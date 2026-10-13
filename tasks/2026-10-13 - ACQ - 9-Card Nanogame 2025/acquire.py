"""Offline selection; explicit network execution, no database writes."""
import ast, hashlib, html, io, json, re, urllib.request
from pathlib import Path
from concurrent.futures import ThreadPoolExecutor
from pypdf import PdfReader
ROOT=Path(__file__).resolve().parents[2]
TASK=Path(__file__).parent
OUT=ROOT/'outputs/nine-card-acq-2026-10-13'
OUT.mkdir(parents=True,exist_ok=True)
SEL=json.loads((TASK/'SELECTION.json').read_text(encoding='utf-8'))
MAN=ROOT/'catalog/2025_nine_card_ranked_acquisition_2026-10-13.json'
M=json.loads(MAN.read_text(encoding='utf-8')) if MAN.exists() else dict(batch_key='bgg-2025-nine-card-ranked-2026-10-13',approved_at='2026-10-13',verified_at='2026-10-13',contest_id=13,selection=SEL['entries'],languages=['it','en'],purpose='Copia personale, nessuna redistribuzione',items=[],resource_observations=[],page_audits=[],entry_outcomes=[])
# Reuse only the verified HTML parser; never import the historical acquisition script.
tree=ast.parse((ROOT/'catalog/acquire_2025_roll_write.py').read_text(encoding='utf-8'))
parser=next(x for x in tree.body if isinstance(x,ast.ClassDef) and x.name=='Page')
from html.parser import HTMLParser
exec(compile(ast.Module(body=[parser],type_ignores=[]),'<historical Page parser>','exec'))
def fetch(url):
    req=urllib.request.Request(url,headers={'User-Agent':'Mozilla/5.0'})
    with urllib.request.urlopen(req,timeout=25) as r: return r.read(),r.url,r.headers

def persist(): MAN.write_text(json.dumps(M,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
def safe(s): return re.sub(r'[<>:"/\\|?*\x00-\x1f]','_',s).strip(' .')
def excluded(name):
    return bool(re.search(r'playingcards|\.pcio$|\.json$|\.mp4$|\.jpg$|\.jpeg$|\.psd$|\.xcf$|ukrain|укра|russian|рус|german|deutsch|spanish|españ|french|fran[cç]|portugu',name,re.I))

def transfer(url,name,row,scope):
    data,final,headers=fetch(url)
    if not data.startswith(b'%PDF-'):
        return dict(name=name,url=url,status='not_acquired',reason='Risposta non PDF; nessuna conversione o salvataggio implicito')
    reader=PdfReader(io.BytesIO(data)); text='\n'.join(p.extract_text() or '' for p in reader.pages)
    (OUT/f"text-{row['id']}-{hashlib.sha256(data).hexdigest()[:12]}.txt").write_text(text,encoding='utf-8')
    # Language remains pending a human/model review of extracted content.
    digest=hashlib.sha256(data).hexdigest()
    if not name.lower().endswith('.pdf'): name+='.pdf'
    title=next(e['title'] for e in SEL['entries'] if e['entry_id']==row['entry_id'])
    slug=re.sub('[^a-z0-9]+','-',title.lower()).strip('-')
    rel=f"bgg/2025-nine-card/{row['game_id']}__{slug}/originals/2026-10-13/{safe(name)}"
    path=ROOT/'library'/rel
    if path.exists() and hashlib.sha256(path.read_bytes()).hexdigest()!=digest:
        path=path.with_name(path.stem+'__'+digest[:12]+path.suffix); rel=path.relative_to(ROOT/'library').as_posix()
    path.parent.mkdir(parents=True,exist_ok=True)
    if not path.exists(): path.write_bytes(data)
    item=dict(game_title=title,game_id=row['game_id'],entry_id=row['entry_id'],remote_resource_id=row['id'],resource_url=row['url'],source_url=row['source_url'],final_url=final,original_filename=name,relative_path=rel,media_type='application/pdf',byte_size=len(data),sha256=digest,version_raw=row['version_raw'],language_code='und',language_status='pending_review',pages=len(reader.pages),status='acquired_pending_language_review',acquired_at='2026-10-13',usage_conditions='Offerta pubblica tramite destinazione dichiarata nel WIP autore; download pubblico verificato. Copia personale; nessuna licenza aperta o redistribuzione attestata.',scope=scope)
    if not any(x['relative_path']==rel and x['remote_resource_id']==row['id'] for x in M['items']): M['items'].append(item)
    persist()
    return dict(name=name,url=url,status='acquired_pending_language_review',sha256=digest)

def process(row):
    if row['kind'] in ('video','online_play','tool') or 'playingcards.io' in row['label'].lower():
        return dict(remote_resource_id=row['id'],entry_id=row['entry_id'],url=row['url'],status='excluded',reason='Video o implementazione online fuori perimetro')
    if row['host']=='boardgamegeek.com':
        return dict(remote_resource_id=row['id'],entry_id=row['entry_id'],url=row['url'],status='reference_only',reason='Regole nel post BGG; nessun file originale dichiarato. File della cartella verificati separatamente.')
    result=dict(remote_resource_id=row['id'],entry_id=row['entry_id'],url=row['url'],status='partial',files=[],enumeration='not_applicable')
    try:
        body,final,headers=fetch(row['url']); text=body.decode('utf-8','replace')
        (OUT/f"page-{row['id']}.html").write_text(text,encoding='utf-8')
        title=html.unescape((re.search(r'<title>(.*?)</title>',text,re.S) or [None,''])[1]).replace(' - Google Drive','').replace(' - Google Docs','')
        result['page_title']=title;result['final_url']=final
        if 'accounts.google.com' in final or re.search('Request access|Richiedi accesso|You need access',text,re.I):
            result['status']='restricted';return result
        if '/file/d/' in row['url']:
            fid=row['url'].split('/file/d/')[1].split('/')[0]
            if excluded(title): result.update(status='excluded',reason='Nome file fuori perimetro');return result
            result['files'].append(transfer('https://drive.usercontent.google.com/download?id='+fid+'&export=download',title,row,'declared_file'))
        elif '/document/d/' in row['url']:
            fid=row['url'].split('/document/d/')[1].split('/')[0]
            result['files'].append(transfer('https://docs.google.com/document/d/'+fid+'/export?format=pdf',title,row,'host_pdf_export'))
        elif '/folders/' in row['url']:
            page=Page(text)
            result.update(enumeration='partial_html',folder_files=page.files,subfolders=page.folders)
            for fid,name in page.files.items():
                if excluded(name) or not name.lower().endswith('.pdf'):
                    result['files'].append(dict(name=name,status='excluded',reason='Non PDF o lingua/tipo fuori perimetro'));continue
                try: result['files'].append(transfer('https://drive.usercontent.google.com/download?id='+fid+'&export=download',name,row,'folder_member'))
                except Exception as ex: result['files'].append(dict(name=name,status='blocked',reason=str(ex)))
            # Complete enumeration requires a browser comparison, including subfolders.
        else: result['reason']='Destinazione non gestita; verifica browser necessaria'
        result['status']='downloaded_pending_review' if any(x['status'].startswith('acquired') for x in result['files']) else 'partial'
    except Exception as ex: result.update(status='blocked',reason=str(ex))
    return result
if __name__=='__main__':
    import sys
    ids=set(map(int,sys.argv[1:])) if len(sys.argv)>1 else None
    for row in SEL['resources']:
        if ids and row['id'] not in ids: continue
        if any(x['remote_resource_id']==row['id'] for x in M['resource_observations']): continue
        outcome=process(row);M['resource_observations'].append(outcome);persist()
        print(json.dumps({k:v for k,v in outcome.items() if k not in ('folder_files','files')},ensure_ascii=True),flush=True)
    print('FILES',len(M['items']),flush=True)
