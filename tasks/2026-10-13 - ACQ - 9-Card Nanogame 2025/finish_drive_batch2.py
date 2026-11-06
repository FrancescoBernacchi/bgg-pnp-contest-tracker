import importlib.util,zipfile,io
from pathlib import Path
s=importlib.util.spec_from_file_location('s',Path(__file__).with_name('supplement_batch2.py'));supp=importlib.util.module_from_spec(s);s.loader.exec_module(supp);a=supp.a
jobs=[(509,'1H14SkqLO8kqM5voN_wmt8nquFhk4doDW','Rules for Royal Courier update 3-28-2026.docx','application/vnd.openxmlformats-officedocument.wordprocessingml.document'),(510,'18V6fPAutdJQg_MsuwyYL5hLR06rhHXMf','SagaSaurus Rules','application/pdf'),(510,'17eIJ0JuQxPfMniEAJMFcO6q8g5Ms-kkp','Dino cards','application/pdf'),(510,'17AV-tONRb5wp0Po25WwaO-pqYb73-iP1','Dino Cards Low ink','application/pdf')]
for rid,fid,name,mime in jobs:
 row=next(r for r in a.SEL['resources'] if r['id']==rid);url='https://drive.usercontent.google.com/download?id='+fid+'&export=download'
 try:
  data,final,headers=a.fetch(url)
  if mime=='application/pdf':assert data.startswith(b'%PDF-')
  else:assert 'word/document.xml' in zipfile.ZipFile(io.BytesIO(data)).namelist()
  x=supp.store(data,name,row,final,mime,'folder_member_observed_browser');obs=next(o for o in a.M['resource_observations'] if o['remote_resource_id']==rid);obs['status']='available';obs.setdefault('files',[]).append(dict(name=name,status='acquired_pending_language_review',sha256=x['sha256']));a.persist();print(rid,name,flush=True)
 except Exception as ex:print(rid,str(ex),flush=True)
