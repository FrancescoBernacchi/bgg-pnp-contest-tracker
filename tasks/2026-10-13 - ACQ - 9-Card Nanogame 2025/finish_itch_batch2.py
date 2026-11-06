import importlib.util
from pathlib import Path
s=importlib.util.spec_from_file_location('supp',Path(__file__).with_name('supplement_batch2.py'));supp=importlib.util.module_from_spec(s);s.loader.exec_module(supp);a=supp.a;row=next(r for r in a.SEL['resources'] if r['id']==425)
data,final,headers=a.fetch((a.OUT/'itch-rule-url.txt').read_text());assert data.startswith(b'%PDF-');supp.store(data,'CCW-RULES.pdf',row,row['url'],'application/pdf','official_itch_download_signed_url_local_only')
p=Path(r'C:/Users/39348/Downloads/CCW-CARDS.pdf');data=p.read_bytes();assert data.startswith(b'%PDF-');supp.store(data,p.name,row,row['url'],'application/pdf','official_itch_download')
obs=next(r for r in a.M['resource_observations'] if r['remote_resource_id']==425);obs.update(status='available',enumeration='complete_browser_listing',file_names=['CCW-CARDS.pdf','CCW-RULES.pdf'],reason='Due file gratuiti, nessun pagamento o account');a.persist();print('Itch 2/2')
