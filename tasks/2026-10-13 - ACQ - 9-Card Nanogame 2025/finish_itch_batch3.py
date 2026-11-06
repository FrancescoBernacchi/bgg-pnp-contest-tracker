import importlib.util,json
from pathlib import Path
s=importlib.util.spec_from_file_location('supp',Path(__file__).with_name('supplement_batch3.py'));b=importlib.util.module_from_spec(s);s.loader.exec_module(b);a=b.a
row=next(x for x in a.SEL['resources'] if x['id']==472)
for job in json.loads((a.OUT/'itch-urls.json').read_text()):
 data,final,h=a.fetch(job['url']);assert data.startswith(b'%PDF-');b.store(data,job['name'],row,row['url'],'application/pdf','official_itch_free_download');print(job['name'],len(data),flush=True)
