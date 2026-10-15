"""Transfer only explicit observed image URLs; no HTML discovery or credentials."""
import json,hashlib,urllib.request,sys
from pathlib import Path
from urllib.parse import urlsplit
from PIL import Image
R=Path(__file__).resolve().parents[2];O=R/'outputs/tsk0088/remote';O.mkdir(parents=True,exist_ok=True)
rows=json.loads(Path(sys.argv[1]).read_text(encoding='utf-8-sig'));results=[]
if isinstance(rows,dict):
 rows=[dict(game_id=x['game_id'],id=x['bgg_image_id'],title=x.get('caption'),license=x.get('license'),page=x['page'],url=x['original'][0]['url']) for x in rows['remoteCandidates']]
for row in rows:
 u=row['url'];assert urlsplit(u).scheme=='https' and urlsplit(u).hostname=='cf.geekdo-images.com'
 assert '__original/' in u and ('pic'+str(row['id'])+'.') in u
 dest=O/Path(urlsplit(u).path).name
 if not dest.exists():
  with urllib.request.urlopen(u,timeout=25) as response:data=response.read(128*1024*1024+1)
  assert len(data)<=128*1024*1024
  with Image.open(__import__('io').BytesIO(data)) as im:im.verify()
  with dest.open('xb') as f:f.write(data)
 with Image.open(dest) as im:fmt=im.format;size=list(im.size);im.verify()
 results.append(dict(**row,path=str(dest),format=fmt,size=size,bytes=dest.stat().st_size,sha256=hashlib.sha256(dest.read_bytes()).hexdigest()))
out=O/(Path(sys.argv[1]).stem+'-verified.json');out.write_text(json.dumps(results,ensure_ascii=False,indent=2),encoding='utf-8')
print(json.dumps(dict(downloaded_or_reused=len(results),report=str(out))))
