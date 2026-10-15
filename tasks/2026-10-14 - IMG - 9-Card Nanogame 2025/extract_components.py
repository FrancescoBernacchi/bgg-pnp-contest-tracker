"""Prepare faithful component candidates for visual QA; no library/DB writes."""
import json,hashlib,sqlite3
from pathlib import Path
from PIL import Image,ImageDraw
from pypdf import PdfReader
import pypdfium2 as pdfium
R=Path(__file__).resolve().parents[2];O=R/'outputs/tsk0088';DEST=O/'component-candidates';DEST.mkdir(exist_ok=True)
source=json.loads((O/'materials-private.json').read_text(encoding='utf-8'));D=source['documents']
layouts=json.loads((O/'layouts-private.json').read_text(encoding='utf-8'))
db=sqlite3.connect((R/'database/pnp_collection.sqlite3').as_uri()+'?mode=ro',uri=True)
for d in D:
 row=db.execute('select id from acquired_files where relative_path=? and sha256=?',(d['relative_path'],d['sha256'])).fetchall();assert len(row)==1;d['acquired_file_id']=row[0][0]
db.close()
# Coordinates are per-document plans inspected against the rendered sheets.
plans=[
 (4,[1,2],[23.76,209.28,394.8],[41.76,295.68,549.6],180,249.45,0),
 (5,[1,2],[23.76,209.28,394.8],[41.76,295.68,549.6],180,249.45,0),
 (7,[1,2],[36,216,396],[18,270,522],180,252,0),
 (9,[1,2],[36,216,396],[18,270,522],180,252,0),
 (13,[1,2],[29.764,208.347,386.93],[46.772,296.221,545.67],178.583,249.449,0),
 (15,[1,2,3,4,5],[99.2126,297.638],[73.702,413.859],198.425,340.157,90),
 (16,[1,2],[23.76,209.28,394.8],[41.76,295.68,549.6],180,249.45,90),
 (19,[1,2],[36,216,396],[18,270,522],180,252,0),
 (21,[1,2],[18,216,414],[0,262.44,523.98],180,254.469,0),
 (35,[1,2],[18,270,522],[36,216,396],252,180,0),
 (38,[1,2],[27,225,423],[18,279,540],180,252,0),
 (39,[1,2,3],[46.7718,296.2206,545.6694],[27.65197,207.65197,387.65197],249.4488,180,0),
 (46,[1,2],[36,216,396],[10.08,262.08,514.08],180,252,0),
 (49,[3,4],[27.6375,207.6375,387.6375],[42.945,294.945,546.945],180,252,0),
]
records=[]
def save(im,n,page,cell,box,method,rotation=0,pdf_object=None,native_rectangle=None):
 d=D[n];name=f'{n:02d}-p{page}-c{cell:02d}.png';path=DEST/name
 if rotation:im=im.rotate(rotation,expand=True)
 if im.mode not in ('RGB','RGBA','L','LA','P'):im=im.convert('RGB')
 im.save(path)
 records.append(dict(key=name,game_id=d['game_id'],doc_index=n,acquired_file_id=d['acquired_file_id'],document_sha256=d['sha256'],page=page,cell=cell,rectangle=box,coordinate_system='punti PDF, origine alto-sinistra',method=method,rotation_ccw=rotation,pdf_object=pdf_object,native_pixel_rectangle=native_rectangle,path=path.relative_to(R).as_posix(),width=im.width,height=im.height,sha256=hashlib.sha256(path.read_bytes()).hexdigest(),bytes=path.stat().st_size,qa='pending'))
for n,pages,xs,ys,w,h,rot in plans:
 d=D[n];path=R/'library'/d['relative_path'];assert hashlib.sha256(path.read_bytes()).hexdigest()==d['sha256'];pdf=pdfium.PdfDocument(str(path))
 for page in pages:
  pg=pdf[page-1];scale=300/72;im=pg.render(scale=scale).to_pil().convert('RGB')
  for row,y in enumerate(ys):
   for col,x in enumerate(xs):
    box=[x,y,min(x+w,pg.get_width()),min(y+h,pg.get_height())];pixel=[round(v*scale) for v in box]
    save(im.crop(pixel),n,page,row*len(xs)+col,box,'render 300 DPI + ritaglio rettangolare fedele',rot)
  pg.close()
 pdf.close()
for n in [25,30,32,50]:
 d=D[n];reader=PdfReader(R/'library'/d['relative_path'])
 for pnum,pg in enumerate(reader.pages,1):
  objects={Path(i.name).stem:i for i in pg.images};geometry=next(x for x in layouts if x['doc']==n and x['page']==pnum)
  assert len(objects)==len(geometry['images'])==9
  for geo in sorted(geometry['images'],key=lambda x:(round(x['top'],1),round(x['x0'],1))):
   cell=round((geo['top']-min(x['top'] for x in geometry['images']))/max(1,geo['bottom']-geo['top']))*3+round((geo['x0']-min(x['x0'] for x in geometry['images']))/(geo['x1']-geo['x0']))
   im=objects[geo['name']].image.copy();box=[max(0,geo['x0']),max(0,geo['top']),geo['x1'],geo['bottom']]
   save(im,n,pnum,cell,box,'oggetto raster nativo intero, da confrontare con render',pdf_object=geo['name'])
for gid in sorted({x['game_id'] for x in records}):
 selected=[r for r in records if r['game_id']==gid]
 for start in range(0,len(selected),20):
  chunk=selected[start:start+20];grid=Image.new('RGB',(1600,360*((len(chunk)+4)//5)),'#ddd');draw=ImageDraw.Draw(grid)
  for j,r in enumerate(chunk):
   im=Image.open(R/r['path']).convert('RGB');im.thumbnail((300,325));x=(j%5)*320;y=(j//5)*360;grid.paste(im,(x+(320-im.width)//2,y+25));draw.text((x+4,y+3),r['key'],fill='black')
  grid.save(O/f'components-{gid}-{start//20}.jpg')
(O/'component-candidates.json').write_text(json.dumps(dict(documents=D,candidates=records),ensure_ascii=False,indent=2),encoding='utf-8')
print(json.dumps(dict(component_faces=len(records),games=len({x['game_id'] for x in records}),qa='pending')))
