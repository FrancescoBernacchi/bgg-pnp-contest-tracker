import importlib.util,json
from pathlib import Path
p=Path(__file__).with_name('supplement_batch3.py');s=importlib.util.spec_from_file_location('supp',p);b=importlib.util.module_from_spec(s);s.loader.exec_module(b);a=b.a
for rid,url in [(493,'https://drive.google.com/drive/folders/1I1aImwidcZqs5uzdx7DfWoo8cIgNHfG-'),(518,'https://drive.google.com/drive/folders/1cUZiQCvtqMxOyOzvN_cZBtpJ7MN1v744')]:
 row=next(x for x in a.SEL['resources'] if x['id']==rid);data,final,h=a.fetch(url);page=a.Page(data.decode('utf8','replace'));obs=dict(remote_resource_id=rid,entry_id=row['entry_id'],url=url,enumeration='partial_html',folder_files=page.files,subfolders=page.folders,files=[])
 for fid,name in page.files.items():
  if a.excluded(name):obs['files'].append(dict(name=name,status='excluded',reason='Lingua/tipo fuori perimetro'));continue
  obs['files'].append(a.transfer('https://drive.usercontent.google.com/download?id='+fid+'&export=download',name,row,'offered_previous_version'))
 a.M['page_audits'].append(obs);a.persist();print(json.dumps(obs),flush=True)
row=next(x for x in a.SEL['resources'] if x['id']==554);data,final,h=a.fetch('https://drive.usercontent.google.com/download?id=1D19zxpiZPUqo0FXlfPCD0vk1B_-KPpEa&export=download');assert len(data)==374; b.store(data,'Labyrinth Nine printing instruction.txt',row,final,'text/plain','folder_printing_instructions')
row=next(x for x in a.SEL['resources'] if x['id']==558);print(a.transfer('https://docs.google.com/document/d/1Q-TI4YkNPbAK-zcCu9Qbhus97JQpLZ8Stiz_Z-FTE4k/export?format=pdf','Rules - Red is hungry (pcio).pdf',row,'host_pdf_export'),flush=True)
