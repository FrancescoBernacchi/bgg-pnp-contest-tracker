import json,hashlib
from pathlib import Path
from PIL import Image,ImageDraw
import pypdfium2 as pdfium
ROOT=Path(__file__).resolve().parents[2]; OUT=ROOT/'outputs/nine-card-acq-2026-10-13'
m=json.loads((ROOT/'catalog/2025_nine_card_ranked_acquisition_2026-10-13.json').read_text(encoding='utf-8'))
items=list({x['relative_path']:x for x in m['items']}.values()); records=[]; tiles=[]
for i,x in enumerate(items):
 p=ROOT/'library'/x['relative_path'];data=p.read_bytes();assert len(data)==x['byte_size'] and hashlib.sha256(data).hexdigest()==x['sha256']
 if x['media_type']=='application/pdf':
  assert data.startswith(b'%PDF-');d=pdfium.PdfDocument(str(p));assert len(d)>0;im=d[0].render(scale=.85).to_pil().convert('RGB')
 else:im=Image.open(p).convert('RGB')
 im.thumbnail((350,440));tile=Image.new('RGB',(370,480),'white');tile.paste(im,((370-im.width)//2,30));ImageDraw.Draw(tile).text((5,5),str(i)+' '+str(x['entry_id'])+' '+x['original_filename'][:35],fill='black');tiles.append(tile)
 records.append(dict(index=i,entry_id=x['entry_id'],path=x['relative_path'],sha256=x['sha256'],verified=True))
for b in range(0,len(tiles),12):
 grid=Image.new('RGB',(1480,1440),'#ddd')
 for j,t in enumerate(tiles[b:b+12]):grid.paste(t,((j%4)*370,(j//4)*480))
 grid.save(OUT/('review-'+str(b//12)+'.jpg'))
(OUT/'render-index.json').write_text(json.dumps(records,indent=2),encoding='utf-8');print(json.dumps({'files':len(items),'references':len(m['items']),'hash_and_size':'passed'}))
