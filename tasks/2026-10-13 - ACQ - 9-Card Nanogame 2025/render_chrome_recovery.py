import json,hashlib,io,zipfile
from pathlib import Path
from PIL import Image,ImageDraw
from pypdf import PdfReader
import pypdfium2 as pdfium
ROOT=Path(__file__).resolve().parents[2];OUT=ROOT/'outputs/nine-card-chrome-recovery-2026-11-06';m=json.loads((ROOT/'catalog/2025_nine_card_chrome_recovery_2026-11-06.json').read_text(encoding='utf-8'));tiles=[];index=[]
for x in m['items']:
 print('VERIFY',x['entry_id'],x['original_filename'],flush=True)
 p=ROOT/'library'/x['relative_path'];data=p.read_bytes();assert len(data)==x['byte_size'] and hashlib.sha256(data).hexdigest()==x['sha256']
 docs=[(x['original_filename'],data)]
 if x['media_type']=='application/zip':
  z=zipfile.ZipFile(io.BytesIO(data));assert not z.testzip();docs=[(i.filename,z.read(i)) for i in z.infolist() if i.filename.lower().endswith('.pdf')]
 for name,body in docs:
  if not body.startswith(b'%PDF-'):continue
  d=pdfium.PdfDocument(body);assert len(d)>0;im=d[0].render(scale=.65).to_pil().convert('RGB');im.thumbnail((350,440));i=len(index);tile=Image.new('RGB',(370,480),'white');tile.paste(im,((370-im.width)//2,30));ImageDraw.Draw(tile).text((5,5),str(i)+' '+str(x['entry_id'])+' '+name[:38],fill='black');tiles.append(tile)
  text='\n'.join(d[p].get_textpage().get_text_range() for p in range(min(2,len(d))));(OUT/f"qa-text-{i}.txt").write_text(text,encoding='utf-8');index.append(dict(index=i,entry_id=x['entry_id'],resource_id=x['remote_resource_id'],name=name,relative_path=x['relative_path'],member_sha256=hashlib.sha256(body).hexdigest(),pages=len(d)))
for start in range(0,len(tiles),12):
 grid=Image.new('RGB',(1480,1440),'#ddd')
 for j,t in enumerate(tiles[start:start+12]):grid.paste(t,((j%4)*370,(j//4)*480))
 grid.save(OUT/f"qa-{start//12}.jpg")
(OUT/'qa-index.json').write_text(json.dumps(index,ensure_ascii=False,indent=2),encoding='utf-8');print(json.dumps({'items':len(m['items']),'rendered':len(index)}))
