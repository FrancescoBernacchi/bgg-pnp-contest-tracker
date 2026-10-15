"""Offline inventory/render only: no original changes or database writes."""
import json,hashlib
from pathlib import Path
from PIL import Image,ImageDraw
import pypdfium2 as pdfium
ROOT=Path(__file__).resolve().parents[2]
OUT=ROOT/'outputs/tsk0088';OUT.mkdir(parents=True,exist_ok=True)
m=json.loads((ROOT/'catalog/2025_nine_card_ranked_acquisition_2026-10-13.json').read_text(encoding='utf-8'))
selected=[g for g in m['selection'] if any(o['entry_id']==g['entry_id'] and o['outcome']=='complete' for o in m['entry_outcomes'])]
docs=[]
for g in selected:
 tiles=[]
 for x in {i['relative_path']:i for i in m['items'] if i['entry_id']==g['entry_id']}.values():
  p=ROOT/'library'/x['relative_path'];assert hashlib.sha256(p.read_bytes()).hexdigest()==x['sha256']
  d=dict(x);d['pages_inventory']=[]
  if x['media_type']=='application/pdf':
   pdf=pdfium.PdfDocument(str(p))
   for n in range(len(pdf)):
    pg=pdf[n];text=pg.get_textpage().get_text_range();im=pg.render(scale=.65).to_pil().convert('RGB');im.thumbnail((300,385))
    tile=Image.new('RGB',(320,435),'white');tile.paste(im,((320-im.width)//2,45));draw=ImageDraw.Draw(tile);draw.text((4,4),str(len(docs))+' p'+str(n+1)+' '+x['original_filename'][:37],fill='black');tiles.append(tile)
    d['pages_inventory'].append(dict(page=n+1,size=list(pg.get_size()),text=text))
  else:
   im=Image.open(p).convert('RGB');im.thumbnail((300,385));tile=Image.new('RGB',(320,435),'white');tile.paste(im,(10,40));ImageDraw.Draw(tile).text((4,4),str(len(docs))+' image',fill='black');tiles.append(tile)
  docs.append(d)
 for start in range(0,len(tiles),20):
  chunk=tiles[start:start+20];grid=Image.new('RGB',(1600,435*((len(chunk)+4)//5)),'#ddd')
  for j,t in enumerate(chunk):grid.paste(t,((j%5)*320,(j//5)*435))
  grid.save(OUT/f'{g["game_id"]}-pages-{start//20}.jpg')
(OUT/'materials-private.json').write_text(json.dumps(dict(games=selected,documents=docs),ensure_ascii=False,indent=2),encoding='utf-8')
print(json.dumps(dict(games=len(selected),documents=len(docs),pages=sum(len(d['pages_inventory']) for d in docs))))
