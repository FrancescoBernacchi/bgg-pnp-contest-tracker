import importlib.util,re,hashlib,json,io
from pathlib import Path
from urllib.parse import urlencode
from PIL import Image
spec=importlib.util.spec_from_file_location('acq',Path(__file__).with_name('acquire.py'));a=importlib.util.module_from_spec(spec);spec.loader.exec_module(a)
# Explicitly preserve host originals and the standard Google form; no access restriction bypass.
row=next(r for r in a.SEL['resources'] if r['id']==552)
u='https://drive.usercontent.google.com/download?id=12yHp9Cl8dAL7Y4NEC84p-7blWYJc2YUE&export=download'
data,final,heads=a.fetch(u)
assert data.startswith(b'\xff\xd8\xff')
im=Image.open(io.BytesIO(data));im.verify()
digest=hashlib.sha256(data).hexdigest();rel='bgg/2025-nine-card/455__word-flower/originals/2026-10-14/Word Flower Rules v0414.pdf'
p=a.ROOT/'library'/rel;p.parent.mkdir(parents=True,exist_ok=True)
if p.exists(): assert hashlib.sha256(p.read_bytes()).hexdigest()==digest
else:p.write_bytes(data)
a.M['items'].append(dict(game_title='Word Flower',game_id=455,entry_id=455,remote_resource_id=552,resource_url=row['url'],source_url=row['source_url'],final_url=final,original_filename='Word Flower Rules v0414.pdf',relative_path=rel,media_type='image/jpeg',byte_size=len(data),sha256=digest,version_raw='v0414',language_code='und',language_status='pending_review',status='acquired_pending_language_review',acquired_at='2026-10-14',usage_conditions='Originale JPEG offerto pubblicamente nella cartella dichiarata; estensione PDF originale preservata. Copia personale, nessuna redistribuzione.',scope='folder_member'))
obs=next(r for r in a.M['resource_observations'] if r['remote_resource_id']==552)
f=next(f for f in obs['files'] if f['name']=='Word Flower Rules v0414.pdf');f.update(status='acquired_pending_language_review',sha256=digest,media_type='image/jpeg',reason='Estensione originale PDF, formato reale JPEG verificato')
a.persist();print('WORD_FLOWER_JPEG',len(data),flush=True)
row=next(r for r in a.SEL['resources'] if r['id']==427)
a.transfer('https://docs.google.com/document/d/1JsP__-QwJd119vnE_64PsV8tmAEr52_KBN41gffGDAk/export?format=pdf','Demo Edition Notes',row,'folder_host_pdf_export')
a.M['items'][-1]['acquired_at']='2026-10-14';a.persist()
row=next(r for r in a.SEL['resources'] if r['id']==400)
obs=next(r for r in a.M['resource_observations'] if r['remote_resource_id']==400)
for f in obs['files']:
 if f['status']!='not_acquired':continue
 try:
  body,final,headers=a.fetch(f['url']);text=body.decode('utf-8','replace')
  form=re.search(r'<form id="download-form" action="([^"]+)".*?</form>',text,re.S)
  if not form:raise ValueError('Nessun modulo standard di conferma')
  fields=dict(re.findall(r'<input type="hidden" name="([^"]+)" value="([^"]+)"',form.group(0)))
  if fields.get('id') not in obs['folder_files']:raise ValueError('ID estraneo alla cartella')
  url=form.group(1)+'?'+urlencode(fields)
  updated=a.transfer(url,f['name'],row,'folder_member_standard_large_file_confirmation')
  f.update(updated);a.M['items'][-1]['acquired_at']='2026-10-14';a.persist();print('LARGE',json.dumps(updated),flush=True)
 except Exception as ex:f.update(status='blocked',reason=str(ex));a.persist();print('BLOCKED',str(ex),flush=True)
