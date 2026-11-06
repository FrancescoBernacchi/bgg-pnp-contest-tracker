import importlib.util,io,json,hashlib,re,zipfile
from pathlib import Path
from urllib.parse import urlparse,parse_qsl,urlencode,urlunparse
spec=importlib.util.spec_from_file_location('a',Path(__file__).with_name('acquire_batch3.py'));a=importlib.util.module_from_spec(spec);spec.loader.exec_module(a)
def store(data,name,row,final,mime,scope='declared_file'):
 digest=hashlib.sha256(data).hexdigest();title=next(e['title'] for e in a.SEL['entries'] if e['entry_id']==row['entry_id']);slug=re.sub('[^a-z0-9]+','-',title.lower()).strip('-');rel=f"bgg/2025-nine-card/{row['game_id']}__{slug}/originals/2026-11-06/{a.safe(name)}";path=a.ROOT/'library'/rel
 if path.exists():assert hashlib.sha256(path.read_bytes()).hexdigest()==digest
 else:path.parent.mkdir(parents=True,exist_ok=True);path.write_bytes(data)
 x=dict(game_title=title,game_id=row['game_id'],entry_id=row['entry_id'],remote_resource_id=row['id'],resource_url=row['url'],source_url=row['source_url'],final_url=final,original_filename=name,relative_path=rel,media_type=mime,byte_size=len(data),sha256=digest,version_raw=row['version_raw'],language_code='und',language_status='pending_review',status='acquired_pending_language_review',acquired_at='2026-11-06',usage_conditions='Originale offerto pubblicamente dall’autore tramite host dichiarato nel WIP; copia personale, nessuna redistribuzione attestata.',scope=scope)
 if not any(y['relative_path']==rel for y in a.M['items']):a.M['items'].append(x)
 a.persist();return x

if __name__=='__main__':
 for row in a.SEL['resources']:
  if row['id'] not in (502,503,530):continue
  obs=next(x for x in a.M['resource_observations'] if x['remote_resource_id']==row['id'])
  try:
   url=row['url'].replace('dl=0','dl=1');data,final,headers=a.fetch(url)
   if data.startswith(b'%PDF-'):
    x=store(data,urlparse(row['url']).path.split('/')[-1],row,final,'application/pdf');obs.update(status='available',files=[dict(name=x['original_filename'],sha256=x['sha256'])])
   elif data.startswith(b'PK'):
    z=zipfile.ZipFile(io.BytesIO(data));assert not z.testzip();members=[dict(path=i.filename,byte_size=i.file_size,sha256=hashlib.sha256(z.read(i)).hexdigest()) for i in z.infolist() if not i.is_dir()];x=store(data,'Tiny Dicey and Starry - shared folder.zip',row,final,'application/zip','host_folder_archive');obs.update(status='available_pending_review',enumeration='complete_archive_inventory',archive_members=members)
   else:obs.update(status='blocked',reason='Formato originale non PDF/ZIP, nessuna conversione')
  except Exception as ex:obs.update(status='blocked',reason=str(ex))
  a.persist();print(json.dumps(dict(id=row['id'],status=obs['status'])),flush=True)
