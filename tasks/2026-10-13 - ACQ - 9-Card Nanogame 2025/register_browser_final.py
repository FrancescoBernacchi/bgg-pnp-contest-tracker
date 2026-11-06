import importlib.util
from pathlib import Path
s=importlib.util.spec_from_file_location('supp',Path(__file__).with_name('supplement_final.py'));b=importlib.util.module_from_spec(s);s.loader.exec_module(b);a=b.a
for rid,name in [(439,'v2.4 Fruit Sort Company Gamejam Rules (1).pdf'),(440,'v2.3 Fruit Sort Company Gamejam Rules.pdf'),(441,'v2.3 SAVED Fruit Sort Company Gamejam Rules.pdf')]:
 p=Path('C:/Users/39348/Downloads')/name
 if not p.exists():print('NOT FOUND',name);continue
 row=next(x for x in a.SEL['resources'] if x['id']==rid);data=p.read_bytes();assert data.startswith(b'%PDF-');b.store(data,p.name,row,row['url'],'application/pdf','official_word_pdf_export');print(name,len(data))
