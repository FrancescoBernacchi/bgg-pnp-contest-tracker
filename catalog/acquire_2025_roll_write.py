"""Acquisizione conservativa delle risorse pubbliche già censite, con journal incrementale."""
import hashlib, html, json, re, sqlite3, urllib.request, urllib.error
from pathlib import Path
from html.parser import HTMLParser
from urllib.parse import urljoin, urlparse

ROOT = Path(__file__).resolve().parents[1]
MANIFEST = ROOT / 'catalog/2025_roll_write_acquisition_batch_2026-10-03.json'
class Page(HTMLParser):
    def __init__(self, text):
        super().__init__(); self.files={}; self.folders={}; self.links=[]; self.pending=None; self.pending_folder=None; self.feed(text)
        for name,fid in re.findall(r'aria-label="([^"]+? PDF[^\"]*)"[^>]*data-id="([^"]+)"',text):
            self.files[fid]=html.unescape(name.split(' PDF')[0])
    def handle_starttag(self, tag, attrs):
        a=dict(attrs)
        label=a.get('aria-label','')
        if re.search(r'\bfolder\b',label,re.I): self.pending_folder=re.split(r'\s+(?:Shared )?folder\b',label,flags=re.I)[0]
        if a.get('data-id') and self.pending_folder:
            self.folders[a['data-id']]=self.pending_folder; self.pending_folder=None
        match=re.search(r'^(.+?\.(?:pdf|png|jpe?g|zip|txt|docx?))\b',label,re.I)
        if match: self.pending=match.group(1)
        if a.get('data-id') and self.pending:
            self.files[a['data-id']]=self.pending; self.pending=None
        if a.get('data-id') and a.get('aria-label'):
            name=a['aria-label']
            if ' PDF' in name: self.files[a['data-id']]=name.split(' PDF')[0]
        if tag=='a' and a.get('href'): self.links.append(a['href'])
def fetch(url):
    req=urllib.request.Request(url,headers={'User-Agent':'Mozilla/5.0'})
    with urllib.request.urlopen(req,timeout=35) as r: return r.read(),r.url,r.headers.get('Content-Type',''),r.headers.get('Content-Disposition','')
def slug(s): return re.sub(r'[^a-z0-9]+','-',s.lower()).strip('-')
def save(): MANIFEST.write_text(json.dumps(m,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
def download(url, name, row):
    if any(x['final_url']==url and x['remote_resource_id']==row['id'] for x in m['items']): return True
    data,final,mime,disposition=fetch(url)
    verified_type = ('application/pdf' if data.startswith(b'%PDF-') else
                     'image/png' if data.startswith(b'\x89PNG\r\n\x1a\n') else
                     'image/jpeg' if data.startswith(b'\xff\xd8\xff') else
                     'application/zip' if data.startswith(b'PK\x03\x04') else None)
    if not verified_type: return False
    if not name:
        match=re.search(r'filename="?([^";]+)',disposition)
        name=match.group(1) if match else row['label']+{'application/pdf':'.pdf','image/png':'.png','image/jpeg':'.jpg','application/zip':'.zip'}[verified_type]
    name=re.sub(r'[<>:"/\\|?*]','_',html.unescape(name))
    if not re.search(r'\.(pdf|png|jpe?g|zip)$',name,re.I): name+={'application/pdf':'.pdf','image/png':'.png','image/jpeg':'.jpg','application/zip':'.zip'}[verified_type]
    digest=hashlib.sha256(data).hexdigest()
    relative=f"bgg/2025-roll-write/{slug(row['game_title'])}/originals/2026-10-03/{name}"
    path=ROOT/'library'/relative
    if path.exists() and hashlib.sha256(path.read_bytes()).hexdigest()!=digest:
        relative=relative[:-4]+'-'+digest[:10]+'.pdf'; path=ROOT/'library'/relative
    path.parent.mkdir(parents=True,exist_ok=True)
    if not path.exists(): path.write_bytes(data)
    if not any(x['relative_path']==relative and x['remote_resource_id']==row['id'] for x in m['items']):
        m['items'].append(dict(game_title=row['game_title'],remote_resource_id=row['id'],resource_url=row['url'],relative_path=relative,original_filename=name,media_type=verified_type,byte_size=len(data),sha256=digest,version_raw=None,final_url=url,language_code='und',status='acquired',selection_reason='Tutte le entry del contest selezionate esplicitamente dall’utente',usage_conditions='File offerto pubblicamente tramite risorsa dichiarata dall’autore; copia personale, nessuna redistribuzione; licenza aperta non accertata.'))
    save(); return True

if MANIFEST.exists(): m=json.loads(MANIFEST.read_text(encoding='utf-8'))
else: m=dict(batch_key='bgg-2025-roll-write-all-2026-10-03',acquired_at='2026-10-03',purpose='Acquisizione personale di tutti i file di gioco disponibili del singolo contest Roll & Write 2025',items=[],resource_observations=[],entry_outcomes=[],page_audits=[])
c=sqlite3.connect(ROOT/'database/pnp_collection.sqlite3'); c.row_factory=sqlite3.Row
rows=[dict(r) for r in c.execute('SELECT DISTINCT rr.*,g.canonical_title game_title FROM remote_resources rr JOIN entry_resource_mentions erm ON erm.remote_resource_id=rr.id JOIN entries e ON e.id=erm.entry_id JOIN games g ON g.id=e.game_id WHERE e.contest_id=22 ORDER BY e.id,rr.id')]
for row in (rows if __name__=='__main__' else []):
    if any(x['remote_resource_id']==row['id'] for x in m['resource_observations']): continue
    if row['kind'] in ('video','online_play','tool'):
        m['page_audits'].append(dict(resource_id=row['id'],url=row['url'],outcome='excluded',reason='Video, implementazione o strumento online escluso dai file di gioco')); save(); continue
    url=row['url']; status='unknown'; notes=[]; before=len(m['items'])
    try:
        if 'drive.google.com/file/d/' in url:
            fid=url.split('/file/d/')[1].split('/')[0]
            body,final,mime,_=fetch(url)
            title=re.search(r'<title>(.*?)</title>',body.decode('utf-8','replace'),re.S)
            name=html.unescape(title.group(1)).replace(' - Google Drive','') if title else None
            ok=download('https://drive.usercontent.google.com/download?id='+fid+'&export=download',name,row)
            status='available' if ok else 'unknown'; notes.append('PDF acquisito' if ok else 'Risposta di download non PDF; non conservata')
        elif 'drive.google.com/drive/folders/' in url:
            body,final,mime,_=fetch(url); text=body.decode('utf-8','replace'); page=Page(text)
            m['page_audits'].append(dict(resource_id=row['id'],url=url,final_url=final,files=page.files))
            for fid,name in page.files.items():
                if re.search(r'sell.?sheet|pitch|promo',name,re.I): notes.append('Escluso promozionale: '+name); continue
                try: download('https://drive.usercontent.google.com/download?id='+fid+'&export=download',name,row)
                except Exception as ex: notes.append(name+': '+str(ex))
            status='available' if page.files else 'unknown'; notes.append(f'Enumerati {len(page.files)} PDF nella cartella radice; sottocartelle e altri formati richiedono controllo')
        elif 'docs.google.com/document/d/' in url:
            fid=url.split('/document/d/')[1].split('/')[0]
            ok=download('https://docs.google.com/document/d/'+fid+'/export?format=pdf',row['label']+' (Google Docs export).pdf',row)
            status='available' if ok else 'unknown'; notes.append('Esportazione PDF del documento pubblico' if ok else 'Esportazione non PDF')
        else:
            body,final,mime,_=fetch(url)
            if body.startswith(b'%PDF-'): download(url,None,row); status='available'
            else:
                text=body.decode('utf-8','replace'); page=Page(text)
                links=list(dict.fromkeys(urljoin(final,x) for x in page.links if re.search(r'\.pdf(?:\?|$)|sdm_process_download|drive.google.com/(?:file|drive)|dropbox.com',x)))
                m['page_audits'].append(dict(resource_id=row['id'],url=url,final_url=final,links=links,title=re.findall(r'<title>(.*?)</title>',text,re.S)[:1]))
                notes.append('Pagina osservata; controllo dei file e condizioni da completare'); status='unknown'
    except urllib.error.HTTPError as ex:
        status='unavailable' if ex.code in (404,410) else 'unknown'; notes.append(str(ex))
    except Exception as ex: notes.append(str(ex))
    notes.append(f"File acquisiti dalla risorsa: {len(m['items'])-before}")
    m['resource_observations'].append(dict(remote_resource_id=row['id'],evidence_url=url,availability_status=status,version_raw=None,notes='; '.join(notes)))
    save(); print(row['game_title'],row['id'],status,len(m['items'])-before,flush=True)
if __name__=='__main__': save()
