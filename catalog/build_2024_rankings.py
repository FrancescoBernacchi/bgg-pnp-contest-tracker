"""Offline extraction and conservative reconciliation of browser-observed results."""
import json
import re
import unicodedata
from pathlib import Path
from difflib import SequenceMatcher

ROOT = Path(__file__).resolve().parents[1]
TASK = ROOT / 'tasks/2026-10-04 - BGG-A - Classifiche BGG 2024'

def norm(s):
    s = s.lower().replace('&', 'and').replace('◆', 'diamond')
    return ''.join(x for x in unicodedata.normalize('NFKD', s) if x.isalnum() and not unicodedata.combining(x))

def load(name):
    return json.loads((TASK / name).read_text(encoding='utf-8'))

def records():
    out = []
    def add(cid, cat, rank, raw, url):
        raw = raw.strip().replace('\xa0', ' ')
        if not raw: return
        has_by = bool(re.search(r'\s+by\s+', raw, re.I))
        title = re.split(r'\s+by\s+', raw, flags=re.I)[0].strip()
        if not has_by and ' for ' in title: title = title.split(' for ', 1)[1].strip()
        title = re.sub(r'\s*\(formerly.*?\)', '', title).strip()
        out.append(dict(contest_id=cid, category=cat, rank=rank, title=title, original=raw, evidence_url=url, verified_at='2026-10-04', is_official=1, score=None, vote_count=None))
    for filename,cid in [('nine-card-rich.json',284),('54-card-rich.json',277)]:
        for p in load(filename):
            cat = None
            for line in p['tokens'].splitlines():
                line=line.strip()
                if line.startswith(('Best ', 'Most ', 'Jury Prize!')): cat=line
                m=re.match(r'(?:tie\s*)?\[IMG:d10-(\d+)\]\s*(.*)',line)
                if m and cat and cat!='Best Playtester':
                    raw=m[2]
                    if cat=='Best New Designer' and cid==284: raw=re.search(r'\((.*)\)',raw)[1]
                    add(cid,cat,int(m[1]),raw,p['url'])
            if 'Jury Prize Winners:' in p['text']:
                for rank,raw in re.findall(r'^(\d+)(?:st|nd) Place:\s*(.+)',p['text'],re.M): add(cid,'Jury Prize',int(rank),raw,p['url'])
                block=p['text'].split('Honorable Mentions (in no particular order):')[1].split('Congratulations!')[0]
                for line in block.splitlines():
                    if line.strip(): add(cid,'Jury Prize — Honorable Mention',None,line,p['url'])
    for filename,cid in [('wargame.json',293),('in-hand-page1.json',279),('one-card-results.json',286),('one-card-page2.json',286),('solitaire-results-page2.json',289)]:
        for p in load(filename):
            text=p['text'] if cid!=286 or filename!='one-card-page2.json' else p['tokens']
            text=re.sub(r'\b(for|by)\s*\n+',r'\1 ',text)
            text=re.sub(r'(#\d+:)\s*\n+',r'\1 ',text)
            cm=re.search(r'(?:category|CATEGORY):\s*(.*)',text)
            if not cm: continue
            cat=cm[1].strip()
            if 'PLAYTESTER' in cat: continue
            for line in text.splitlines():
                m=re.match(r'^\s*#?(\d+)(?:(?:st|nd|rd|th))?\s*(?:TIE\s*)?[-:]\s*(.+)',line)
                if cid==293 and not m: m=re.match(r'^\s*(\d+)(?:st|nd|rd|th)\s+(.+)',line)
                if not m: continue
                raw=m[2].strip()
                if raw.startswith('['): continue
                if cid==293:
                    for title in raw.split(' + '): add(cid,cat,int(m[1]),title,p['url'])
                else: add(cid,cat,int(m[1]),raw,p['url'])
    for filename,cid in [('traditional-results.json',291),('children-family-results.json',278),('solomode-results.json',290),('two-player-rich.json',292)]:
        for p in load(filename):
            text=p['text'] if cid==292 else p['tokens']
            # Join the creator/game portions separated by markup elements.
            text=re.sub(r'\b(for|by)\s*\n+',r'\1 ',text)
            text=re.sub(r'(#\d+:)\s*\n+',r'\1 ',text)
            cat=None;rank=None
            for line in text.splitlines():
                line=line.strip()
                if line.startswith(('Best ', 'Most Innovative Mechanic', 'Most Valuable Playtester')): cat=line.rstrip(':');continue
                if not cat or 'Playtester' in cat: continue
                m=re.match(r'^#?(\d+)(?:(?:st|nd|rd|th)\s+(?:place|equal))?:\s*(.*)',line)
                if m:
                    rank=int(m[1]);add(cid,cat,rank,m[2],p['url'])
                elif cid==292 and line.startswith('. . . and '): add(cid,cat,rank,line[10:],p['url'])
    for p in load('roll-write-results.json'):
        cat=p['text'].splitlines()[0].split(': ',1)[1].strip()
        if 'PLAYTESTER' in cat: continue
        for line in p['text'].splitlines():
            m=re.match(r'\s*(First|Second|Third|\d+(?:th|st|nd|rd)) Place:\s*(.*)',line)
            if not m: continue
            rank={'First':1,'Second':2,'Third':3}.get(m[1]) or int(re.match(r'\d+',m[1])[0])
            raw=re.split(r'\s*\(1x',m[2])[0].strip().rstrip(',')
            for title in raw.split(', '): add(287,cat,rank,title,p['url'])
    return out

def main():
    entries=load('ENTRIES.json'); rows=records()
    overrides=load('MATCHES.json') if (TASK/'MATCHES.json').exists() else {}
    unresolved=[]
    for row in rows:
        cid=row['contest_id']; title=row['title'];key=f'{cid}:{title}'
        candidates=[e for e in entries if e['contest_id']==cid]
        exact=[e for e in candidates if norm(e['canonical_title'])==norm(title)]
        if key in overrides: gid=overrides[key]
        elif len(exact)==1: gid=exact[0]['game_id']
        else:
            best=sorted(candidates,key=lambda e:SequenceMatcher(None,norm(title),norm(e['canonical_title'])).ratio(),reverse=True)[:3]
            unresolved.append(dict(key=key,candidates=[dict(game_id=e['game_id'],title=e['canonical_title'],url=e['wip_thread_url']) for e in best]));continue
        assert any(e['game_id']==gid for e in candidates),(key,gid)
        row['game_id']=gid
    (TASK/'UNRESOLVED.json').write_text(json.dumps(list({x['key']:x for x in unresolved}.values()),ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
    (ROOT/'catalog/2024-rankings-observed-2026-10-04.json').write_text(json.dumps(rows,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
    print(json.dumps({'observations':len(rows),'unresolved_titles':len({x['key'] for x in unresolved}),'by_contest':{cid:sum(x['contest_id']==cid for x in rows) for cid in sorted({x['contest_id'] for x in rows})}}))

if __name__=='__main__': main()
