import importlib.util
from pathlib import Path
s=importlib.util.spec_from_file_location('a',Path(__file__).with_name('acquire_final.py'));a=importlib.util.module_from_spec(s);s.loader.exec_module(a)
for rid,fid,name in [(593,'1sNgYtTZzYT6XLFCssPYF3_-nkOmAe1rp9gKgFjCAAZU','SubMerge.Rules.v0.4.pdf'),(594,'1Vbres6sUcQ4PA8vZsIDh0lMTH_FKfHqtqdS-qwZJuqk','TheCorridor.Rules.v0.6.pdf')]:
 row=next(x for x in a.SEL['resources'] if x['id']==rid);print(a.transfer('https://docs.google.com/document/d/'+fid+'/export?format=pdf',name,row,'host_pdf_export'),flush=True)
