"""Read-only PDF geometry inventory; private working evidence only."""
import json
from pathlib import Path
import pdfplumber
R=Path(__file__).resolve().parents[2];O=R/'outputs/tsk0088'
m=json.loads((O/'materials-private.json').read_text(encoding='utf-8'));pages=[]
for n,d in enumerate(m['documents']):
 if d['media_type']!='application/pdf':continue
 with pdfplumber.open(R/'library'/d['relative_path']) as pdf:
  for k,p in enumerate(pdf.pages):
   images=[{key:v for key,v in i.items() if key in ('x0','x1','top','bottom','width','height','name','srcsize','bits','imagemask')} for i in p.images]
   rects=[[v['x0'],v['top'],v['x1'],v['bottom']] for v in p.rects if v['width']>35 and v['height']>35]
   pages.append(dict(doc=n,game=d['game_id'],page=k+1,size=[p.width,p.height],images=images,rects=rects))
(O/'layouts-private.json').write_text(json.dumps(pages,ensure_ascii=False,indent=2),encoding='utf-8')
print(json.dumps([dict(doc=n,game=d['game_id'],name=d['original_filename'],pages=len(d['pages_inventory'])) for n,d in enumerate(m['documents'])],ensure_ascii=True))
