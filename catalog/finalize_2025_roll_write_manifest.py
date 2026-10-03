"""Riconcilia metadati, ZIP, duplicati e le 37 entry senza accessi esterni."""
import copy,hashlib,json,re,sqlite3,zipfile
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
path=ROOT/'catalog/2025_roll_write_acquisition_batch_2026-10-03.json'
m=json.loads(path.read_text(encoding='utf-8'))
def register(data,name,base,relative,**extra):
    dest=ROOT/'library'/relative; dest.parent.mkdir(parents=True,exist_ok=True)
    digest=hashlib.sha256(data).hexdigest()
    if dest.exists(): assert hashlib.sha256(dest.read_bytes()).hexdigest()==digest
    else: dest.write_bytes(data)
    item=copy.deepcopy(base); item.update(original_filename=name,relative_path=relative,byte_size=len(data),sha256=digest,**extra)
    if not any(x['relative_path']==relative for x in m['items']): m['items'].append(item)
for item in list(m['items']):
    if item['media_type']!='application/zip': continue
    original=ROOT/'library'/item['relative_path']
    with zipfile.ZipFile(original) as z:
        if 'word/document.xml' in z.namelist():
            item['media_type']='application/vnd.openxmlformats-officedocument.wordprocessingml.document'
            if item['original_filename'].endswith('.docx.zip'):
                new=item['relative_path'][:-4]; target=ROOT/'library'/new
                if not target.exists(): target.write_bytes(original.read_bytes())
                item['preserved_download_path']=item['relative_path']; item['relative_path']=new
                item['original_filename']=item['original_filename'][:-4]
            item['format_evidence']='ZIP OOXML con word/document.xml, senza esecuzione o conversione'
            continue
        item['archive_members']=[]
        for info in z.infolist():
            if info.is_dir(): continue
            name=Path(info.filename).name
            item['archive_members'].append(dict(name=info.filename,byte_size=info.file_size))
            if not re.search(r'\.(pdf|png|jpe?g)$',name,re.I): continue
            if re.search(r'sell.?sheet|promo|pitch',name,re.I): continue
            data=z.read(info); mime='application/pdf' if data.startswith(b'%PDF-') else 'image/png' if data.startswith(b'\x89PNG') else 'image/jpeg' if data.startswith(b'\xff\xd8\xff') else None
            if not mime: raise ValueError('Formato membro archivio non verificato: '+name)
            relative=str(Path(item['relative_path']).parent/'extracted'/name).replace('\\','/')
            register(data,name,item,relative,media_type=mime,archive_parent_sha256=item['sha256'],archive_member=info.filename,archive_members=None)
proton_url='https://drive.proton.me/urls/8YHBB1NZ88#E3aEkB65vNxw'
template=copy.deepcopy(m['items'][0]); template.update(game_title='Yadoya',remote_resource_id=82,resource_url=proton_url,final_url=proton_url,version_raw='Draft',language_code='und')
for name in ['Yadoya-Rules-Draft.pdf','Yadoya-Sheet-Draft.pdf']:
    src=Path('C:/Users/39348/Downloads')/name
    if src.exists():
        data=src.read_bytes(); assert data.startswith(b'%PDF-')
        register(data,name,template,'bgg/2025-roll-write/yadoya/originals/2026-10-03/'+name,media_type='application/pdf',transfer_method='Download UI pubblico Proton Drive; nessuna autenticazione')
for item in m['items']:
    name=item['original_filename']
    if re.search(r'pt-br|portugu|regras|resumo',name,re.I): item['language_code']='pt'
    elif re.search(r'english',name,re.I): item['language_code']='en'
    version=re.search(r'\b(?:v(?:ersion)?\s*)?\d+(?:\.\d+)+(?:[-_a-z0-9]*)',name,re.I)
    if version: item['version_raw']=version.group(0)
    item['download_url']=item['final_url']
    item['final_url_note']='URL di trasferimento riproducibile; redirect temporanei non conservati nei download HTTP.'
unique={}
for item in m['items']:
    key=item['relative_path']
    if key in unique:
        assert unique[key]['sha256']==item['sha256']
        unique[key].setdefault('additional_source_mentions',[]).append(dict(remote_resource_id=item['remote_resource_id'],resource_url=item['resource_url'],download_url=item['download_url']))
    else: unique[key]=item
m['items']=list(unique.values())
for obs in m['resource_observations']:
    rid=obs['remote_resource_id']
    if rid==5: obs.update(availability_status='access_restricted',notes='Browser Drive: è necessaria autorizzazione di accesso; nessuna richiesta inviata.')
    if rid==12: obs['notes']='Pagina Substack corrente priva di link puntuale a Labyrinth of Shadows; profilo Itch collegato senza il gioco osservabile. Regole Google Docs acquisite separatamente.'
    if rid==21: obs.update(availability_status='available',notes='Pagina autore osservata; file acquisiti dalle pagine full color e low ink dichiarate separatamente.')
    if rid==1: obs['notes']='Pagina PnP Stash osservabile, nessun trasferimento gratuito acquisito da questa risorsa; materiali pubblici Drive dichiarati acquisiti separatamente.'
    if rid==82:
        count=sum(x['remote_resource_id']==82 for x in m['items'])
        obs.update(availability_status='available',notes=f'Proton Drive pubblico: due PDF enumerati; {count} acquisiti attraverso il pulsante Scarica.')
c=sqlite3.connect(ROOT/'database/pnp_collection.sqlite3'); c.row_factory=sqlite3.Row
m['entry_outcomes']=[]
for e in c.execute('SELECT e.id,e.wip_thread_url,g.canonical_title FROM entries e JOIN games g ON g.id=e.game_id WHERE e.contest_id=22 ORDER BY e.id'):
    files=[x for x in m['items'] if x['game_title']==e['canonical_title']]
    resources=[dict(x) for x in c.execute('SELECT DISTINCT rr.id,rr.kind FROM remote_resources rr JOIN entry_resource_mentions erm ON erm.remote_resource_id=rr.id WHERE erm.entry_id=?',(e['id'],))]
    relevant=[x for x in resources if x['kind'] not in ('video','online_play','tool')]
    unresolved=[x['id'] for x in relevant if next((o['availability_status'] for o in m['resource_observations'] if o['remote_resource_id']==x['id']),'unknown')!='available']
    outcome='acquired_with_limits' if files and unresolved else 'acquired' if files else 'restricted' if e['canonical_title']=='Dawn Chorus' else 'no_declared_resource' if not relevant else 'not_acquired'
    m['entry_outcomes'].append(dict(entry_id=e['id'],game_title=e['canonical_title'],wip_url=e['wip_thread_url'],outcome=outcome,file_count=len(files),unresolved_resource_ids=unresolved,notes='Nessun link di gioco dichiarato nel primo post della precedente analisi; nuova verifica WIP limitata dal challenge BGG.' if not relevant else 'Copertura delle risorse dichiarate, senza inferire completezza delle regole o delle dotazioni.'))
assert len(m['entry_outcomes'])==37
m['format_support']={'application/pdf':'Lettore PDF locale disponibile','image/png':'Originali locali disponibili; anteprima interna non implementata, task autonomo necessario','application/zip':'Archivio originale e membri stampabili estratti con hash; nessuna esecuzione','application/vnd.openxmlformats-officedocument.wordprocessingml.document':'Originale locale; visualizzazione/conversione da progettare in task autonomo'}
path.write_text(json.dumps(m,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
from collections import Counter
print(json.dumps(dict(files=len(m['items']),games=len(set(x['game_title'] for x in m['items'])),formats=dict(Counter(x['media_type'] for x in m['items'])),outcomes=dict(Counter(x['outcome'] for x in m['entry_outcomes'])),bytes=sum(x['byte_size'] for x in m['items'])),indent=2))
