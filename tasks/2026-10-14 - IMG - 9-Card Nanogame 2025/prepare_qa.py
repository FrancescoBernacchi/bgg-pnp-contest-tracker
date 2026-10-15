import json,re,hashlib
from pathlib import Path
from PIL import Image,ImageDraw
import pypdfium2 as pdfium
R=Path(__file__).resolve().parents[2];O=R/'outputs/tsk0088'
data=json.loads((O/'component-candidates.json').read_text(encoding='utf-8'))
for r in data['candidates']:
 p=R/r['path'];im=Image.open(p).convert('RGB');rot=0
 if r['doc_index']==30:
  d=data['documents'][30];pdf=pdfium.PdfDocument(str(R/'library'/d['relative_path']));pg=pdf[r['page']-1];scale=300/72
  im=pg.render(scale=scale).to_pil().convert('RGB').crop([round(v*scale) for v in r['rectangle']]);pg.close();pdf.close();r['method']='render 300 DPI: preservazione gestione colore PDF CMYK'
  if r['page']==2:rot=180
 if r['doc_index']==16 and ((r['page']==1 and r['cell']>=3) or (r['page']==2 and r['cell']!=7)):rot=180
 if r['doc_index']==35 and r['page']==2:rot=180
 if r['doc_index']==39 and r['page'] in (2,3) and r['cell']==4:rot=180
 if r['doc_index']==7 and r['page']==2 and r['cell'] in (6,7):rot=90
 if r['doc_index']==13 and ((r['page']==1 and r['cell'] in (6,7)) or (r['page']==2 and r['cell'] in (7,8))):rot=90
 if rot:im=im.rotate(rot,expand=True);r['rotation_ccw']=(r['rotation_ccw']+rot)%360
 im.save(p);r.update(width=im.width,height=im.height,bytes=p.stat().st_size,sha256=hashlib.sha256(p.read_bytes()).hexdigest(),qa='visually reviewed; orientation normalized')
(O/'component-candidates.json').write_text(json.dumps(data,ensure_ascii=False,indent=2),encoding='utf-8')
def sheet(rows,prefix,size=(240,220),batch=25):
 for start in range(0,len(rows),batch):
  part=rows[start:start+batch];w,h=size;grid=Image.new('RGB',(w*5,h*((len(part)+4)//5)),'#ddd');draw=ImageDraw.Draw(grid)
  for i,(label,path) in enumerate(part):
   im=Image.open(path).convert('RGB');im.thumbnail((w-10,h-28));x=i%5*w;y=i//5*h;grid.paste(im,(x+(w-im.width)//2,y+25));draw.text((x+3,y+3),label,fill='black')
  grid.save(O/f'{prefix}-{start//batch}.jpg')
e=json.loads((O/'browser-evidence.json').read_text(encoding='utf-8'))
for i,b in enumerate(e.get('galleryBundles',[])):
 manifest=b.get('manifestPath') or b.get('bundle',{}).get('manifestPath')
 if not manifest:continue
 m=json.loads(Path(manifest).read_text(encoding='utf-8'));sheet([(a['name'],a['path']) for a in m['assets'] if a.get('path')],f'gallery-qa-{i}')
v=json.loads((O/'remote/browser-evidence-verified.json').read_text(encoding='utf-8'))
for gid in sorted({r['game_id'] for r in v}):sheet([(str(r['id']),r['path']) for r in v if r['game_id']==gid],f'remote-qa-{gid}')
sheet([(r['key'],R/r['path']) for r in data['candidates'] if r['doc_index'] in (16,30,35)],'corrected-components')
print('QA sheets prepared')
