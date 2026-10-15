"""Visible manual figures, rendered in page context; private candidates only."""
import json,hashlib
from pathlib import Path
from PIL import Image,ImageDraw
import pypdfium2 as pdfium
R=Path(__file__).resolve().parents[2];O=R/'outputs/tsk0088';dest=O/'figure-candidates';dest.mkdir(exist_ok=True)
D=json.loads((O/'component-candidates.json').read_text(encoding='utf-8'))['documents'];L=json.loads((O/'layouts-private.json').read_text(encoding='utf-8'));rows=[];seen=set()
for n in [8,10,12,14,17,20,26,28,33,34,37,40,45,47]:
 pdf=pdfium.PdfDocument(str(R/'library'/D[n]['relative_path']))
 for p in [p for p in L if p['doc']==n]:
  selected=[i for i in p['images'] if i['x1']-i['x0']>70 and i['bottom']-i['top']>40 and (i['x1']-i['x0'])*(i['bottom']-i['top'])<p['size'][0]*p['size'][1]*.55]
  if not selected:continue
  pg=pdf[p['page']-1];scale=300/72;render=pg.render(scale=scale).to_pil().convert('RGB')
  for j,i in enumerate(selected):
   box=[max(0,i['x0']),max(0,i['top']),min(pg.get_width(),i['x1']),min(pg.get_height(),i['bottom'])];im=render.crop([round(v*scale) for v in box]);sha=hashlib.sha256(im.tobytes()+str(im.size).encode()).hexdigest()
   if sha in seen:continue
   seen.add(sha);key=f'{n:02d}-p{p["page"]}-f{j:02d}';path=dest/(key+'.png');im.save(path)
   rows.append(dict(key=key,game_id=D[n]['game_id'],doc_index=n,acquired_file_id=D[n]['acquired_file_id'],document_sha256=D[n]['sha256'],page=p['page'],rectangle=box,coordinate_system='punti PDF, origine alto-sinistra',method='render contestuale 300 DPI della regione visibile',path=path.relative_to(R).as_posix()))
  pg.close()
 pdf.close()
for start in range(0,len(rows),25):
 part=rows[start:start+25];grid=Image.new('RGB',(1600,255*((len(part)+4)//5)),'#ddd');draw=ImageDraw.Draw(grid)
 for j,r in enumerate(part):
  im=Image.open(R/r['path']);im.thumbnail((310,225));x=j%5*320;y=j//5*255;grid.paste(im,(x+(320-im.width)//2,y+25));draw.text((x+4,y+3),r['key'],fill='black')
 grid.save(O/f'figures-qa-{start//25}.jpg')
(O/'figure-candidates.json').write_text(json.dumps(rows,ensure_ascii=False,indent=2),encoding='utf-8');print('figures',len(rows))
# Remaining gallery thumbnails: private visual review only.
e=json.loads((O/'browser-evidence.json').read_text(encoding='utf-8'));m=json.loads(Path(e['galleryBundles'][-1]['manifestPath']).read_text(encoding='utf-8'))
part=m['assets'][25:];grid=Image.new('RGB',(1400,260*2),'#ddd');draw=ImageDraw.Draw(grid)
for j,a in enumerate(part):
 im=Image.open(a['path']).convert('RGB');im.thumbnail((270,230));x=j%5*280;y=j//5*260;grid.paste(im,(x,y+25));draw.text((x,y+3),a['name'],fill='black')
grid.save(O/'gallery-bullet-rest.jpg')
