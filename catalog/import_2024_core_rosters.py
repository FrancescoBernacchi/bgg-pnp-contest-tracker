"""Offline, repeatable import of browser-observed 2024 core contest rosters."""
import argparse
import json
import re
import sqlite3
from pathlib import Path
from urllib.parse import urljoin, unquote

ROOT = Path(__file__).resolve().parents[1]
DATE = '2026-10-04'
CONTESTS = {'54-card': (277,3327975,30), 'in-hand': (279,3162927,35),
 'nine-card': (284,3218618,50), 'one-card': (286,3276117,50),
 'roll-write': (287,3353041,37), 'solitaire': (289,3310131,57),
 'traditional-deck': (291,3360317,50), 'two-player': (292,3217600,29),
 'wargame': (293,3205140,14)}

def normalized_title(raw, author, position):
    if raw == '[link to deleted destination]':
        return f'Titolo non osservabile — {author} — riga {position}'
    title = re.sub(r'^\d+\.\s*', '', raw)
    title = re.sub(r'^\s*[\[{][^\]}]+[\]}]\s*', '', title)
    title = re.split(r'\[|\s*\((?:2024|1p|1 |1\+|2 |working|formerly)|\s+-\s+(?:2024|Contest|contest|[Cc]omponent)|\s+2024\s', title)[0]
    return title.strip(' -') or raw

def status(row):
    raw = row.get('status') or 'Listed in official roster; heading: ' + row['raw']
    s = raw.lower()
    if 'withdrawn' in s: return raw, 'withdrawn'
    if 'disqualified' in s: return raw, 'disqualified'
    if 'contest complete' in s: return raw, 'contest_complete'
    if 'contest ready' in s: return raw, 'contest_ready'
    if 'component' in s and ('ready' in s or 'available' in s): return raw, 'components_available'
    if 'idea phase' in s: return raw, 'idea'
    return raw, 'unknown'

def load():
    batches = []
    for key, (cid, thread, expected) in CONTESTS.items():
        path = ROOT/'catalog'/f'2024-{key}-roster-{DATE}.json'
        data = json.loads(path.read_text(encoding='utf-8'))
        assert len(data['rows']) == expected, (key, len(data['rows']))
        positions, urls = set(), set()
        for i, r in enumerate(data['rows'], 1):
            r['position'] = r.get('position') or int(re.match(r'^(\d+)\.',r['raw'])[1])
            assert r['position'] not in positions
            positions.add(r['position'])
            u = r.get('url')
            if u:
                u = urljoin('https://boardgamegeek.com',u)
                assert re.match(r'https://boardgamegeek.com/(thread|boardgame)/\d+',u), (key,r)
                assert u not in urls, (key,u)
                urls.add(u)
            else:
                assert r['raw']=='[link to deleted destination]',r
            r['url'] = u
        assert positions == set(range(1,expected+1)),key
        batches.append((key,cid,thread,data))
    return batches

def import_rosters(db, batches):
    for key,cid,thread,data in batches:
        source=data['source']
        existing=db.execute('SELECT id FROM contest_checks WHERE contest_id=? AND checked_at=? AND source_url=?',(cid,DATE,source)).fetchone()
        if existing: continue
        assert db.execute('SELECT count(*) FROM entries WHERE contest_id=?',(cid,)).fetchone()[0]==0, cid
        check=db.execute('INSERT INTO contest_checks(contest_id,checked_at,source_url,check_kind,outcome,notes) VALUES (?,?,?,?,?,?)',(cid,DATE,source,'manual_web_census','complete_with_limits' if key in ('nine-card','one-card','in-hand','54-card') else 'complete','Complete enumeration of observed authoritative roster, including withdrawn entries. Titles/statuses preserved; no WIP or material analysis. Missing metadata explicitly retained in JSON.')).lastrowid
        db.execute('UPDATE contests SET bgg_thread_id=?,entries_url=?,last_verified_at=? WHERE id=?',(thread,source,DATE,cid))
        db.execute('INSERT OR IGNORE INTO contest_sources(contest_id,kind,url,label,is_official,first_seen_at,last_verified_at) VALUES (?,?,?,?,1,?,?)',(cid,'entries',source,'Official roster observed in browser',DATE,DATE))
        for row in data['rows']:
            raw=row['raw']; pos=row['position']; url=row['url']
            profiles=row.get('profiles',[])
            submitter=next((p for p in profiles if p['text'].startswith('@')),None)
            author=row.get('author') or (submitter['text'] if submitter else None)
            title=normalized_title(raw,author,pos)
            sr,sn=status(row)
            match=db.execute('SELECT id FROM games WHERE source_url=?',(url,)).fetchone() if url else None
            gid=match[0] if match else db.execute('INSERT INTO games(canonical_title,status_raw,status_normalized,status_evidence,source_url,first_seen_at,last_verified_at) VALUES (?,?,?,?,?,?,?)',(title,sr,sn,'Official roster; title normalization is derived, raw heading retained',url or source,DATE,DATE)).lastrowid
            item=row.get('item'); geeklist=int(re.search(r'/geeklist/(\d+)',item)[1]) if item else None
            itemid=int(re.search(r'itemid=(\d+)',item)[1]) if item else None
            evidence=item or (data.get('supplement_source') if key=='54-card' and pos>29 else source)
            eid=db.execute('INSERT INTO entries(contest_id,game_id,geeklist_id,geeklist_item_id,position,wip_thread_url,entry_url,entry_text_raw,status_raw,status_normalized,materials_status_normalized,first_seen_at,last_verified_at) VALUES (?,?,?,?,?,?,?,?,?,?,\'unknown\',?,?)',(cid,gid,geeklist,itemid,pos,url if url and '/thread/' in url else None,evidence,json.dumps(row,ensure_ascii=False),sr,sn,DATE,DATE)).lastrowid
            db.execute('INSERT INTO entry_status_history(entry_id,check_id,status_raw,status_normalized,materials_status_normalized,position,observed_at,source_url,confidence,notes) VALUES (?,?,?,?,\'unknown\',?,?,?,\'high\',?)',(eid,check,sr,sn,pos,DATE,evidence,'Roster metadata only. Submitter is not assumed to be designer.'))
            if author:
                profile=row.get('profile') or (submitter['url'] if submitter else None)
                username=unquote(profile.split('/profile/')[1]) if profile else None
                person=db.execute('SELECT id FROM people WHERE profile_url=?',(profile,)).fetchone() if profile else None
                name=next((p['text'] for p in profiles if p['text'] and not p['text'].startswith('@') and len(p['text'])>1),author)
                pid=person[0] if person else db.execute('INSERT INTO people(display_name,bgg_username,profile_url) VALUES (?,?,?)',(name,username,profile)).lastrowid
                db.execute('INSERT OR IGNORE INTO game_credits(game_id,person_id,role,credit_raw) VALUES (?,?,?,?)',(gid,pid,'submitter' if profiles else 'designer',author))

def verify(db):
    assert db.execute('PRAGMA integrity_check').fetchone()[0]=='ok'
    assert not db.execute('PRAGMA foreign_key_check').fetchall()
    counts=dict(db.execute("SELECT c.id,count(e.id) FROM contests c LEFT JOIN entries e ON e.contest_id=c.id WHERE c.year=2024 AND c.scope_type='pnp_core' GROUP BY c.id"))
    assert len(counts)==10 and all(counts.values()),counts
    for _,(cid,_,expected) in CONTESTS.items(): assert counts[cid]==expected,(cid,counts[cid])
    assert counts[278]==29
    return {'verified_at':DATE,'core_contests':len(counts),'core_entries':sum(counts.values()),'counts':counts,'integrity':'ok','foreign_key_violations':0}

def main():
    p=argparse.ArgumentParser();p.add_argument('--database',type=Path,default=ROOT/'database/pnp_collection.sqlite3');p.add_argument('--apply',action='store_true');args=p.parse_args()
    batches=load()
    with sqlite3.connect(args.database) as live:
        scratch=sqlite3.connect(':memory:');live.backup(scratch);scratch.execute('PRAGMA foreign_keys=ON')
        with scratch: import_rosters(scratch,batches)
        result=verify(scratch)
        before=scratch.total_changes
        with scratch: import_rosters(scratch,batches)
        assert scratch.total_changes==before,'Import must be idempotent'
        if args.apply:
            backup=args.database.with_name(f'pnp_collection.pre-core-rosters-{DATE}.sqlite3')
            if not backup.exists():
                with sqlite3.connect(backup) as b: live.backup(b)
            live.execute('PRAGMA foreign_keys=ON')
            with live: import_rosters(live,batches)
            result=verify(live)
            (ROOT/'catalog'/f'2024-core-rosters-verification-{DATE}.json').write_text(json.dumps(result,indent=2)+'\n',encoding='utf-8')
        print(json.dumps(result,indent=2))

if __name__=='__main__': main()
