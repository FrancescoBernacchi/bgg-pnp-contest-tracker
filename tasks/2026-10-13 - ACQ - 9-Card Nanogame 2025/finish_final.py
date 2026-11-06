import importlib.util,json
from pathlib import Path
s=importlib.util.spec_from_file_location('supp',Path(__file__).with_name('supplement_final.py'));b=importlib.util.module_from_spec(s);s.loader.exec_module(b);a=b.a
row=next(x for x in a.SEL['resources'] if x['id']==387);p=Path('C:/Users/39348/Downloads/20 Dice v2.1.pdf');data=p.read_bytes();assert data.startswith(b'%PDF-');b.store(data,p.name,row,row['url'],'application/pdf','official_word_pdf_export')
row=next(x for x in a.SEL['resources'] if x['id']==591);data,final,h=a.fetch('https://drive.usercontent.google.com/download?id=1GolkHdqPRwGclRkFY3jbzOIDTrxtOWsi&export=download');assert data.decode('utf8').strip();b.store(data,'yattactics.txt',row,final,'text/plain','declared_rules_text')
row=next(x for x in a.SEL['resources'] if x['id']==581)
for fid in ['1k3M2_caM9yQ6HzbATp-qoG5b0t-hn8d6','1B-EhcTSt8OLz0c5HVy_P-8Sd6kEB_Dx-','1psbKl8QTHS4-Ec7YedcMd5eOTvnb_qDF','1yUcqSCJzLGd7vPOmqsV-u65gZkpZw1kN']:
 url='https://drive.google.com/drive/folders/'+fid;data,final,h=a.fetch(url);page=a.Page(data.decode('utf8','replace'));obs=dict(remote_resource_id=581,url=url,folder_files=page.files,subfolders=page.folders,files=[])
 for fid,name in page.files.items():
  if a.excluded(name) or not name.lower().endswith('.pdf'):obs['files'].append(dict(name=name,status='excluded',reason='Lingua/tipo fuori perimetro'));continue
  obs['files'].append(a.transfer('https://drive.usercontent.google.com/download?id='+fid+'&export=download',name,row,'offered_previous_version'))
 a.M['page_audits'].append(obs);a.persist();print(json.dumps(obs),flush=True)
