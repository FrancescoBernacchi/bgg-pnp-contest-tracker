from pathlib import Path
from urllib.request import Request,urlopen
from PIL import Image
import hashlib,json
O=Path(__file__).resolve().parents[2]/'outputs/tsk0068/two-2026-10-10/remote';O.mkdir(parents=True,exist_ok=True)
urls=['https://cf.geekdo-images.com/SBZf3XXRCfPcpWb87XNKVw__original/img/OuLt2ypGG32Vtd4GPqFGp5Zz9hA=/0x0/filters:format(png)/pic8730519.png','https://cf.geekdo-images.com/0kddtMy3PhJMapOGCWDlpA__original/img/6c66W3FzBd5mTFReRBGHBmzD7TI=/0x0/filters:format(png)/pic8730527.png']
urls += ['https://cf.geekdo-images.com/4bl8y5H4sYvtaL_XeCk2TA__original/img/gHDjERXgLWajCPbUrWzvMLewRAs=/0x0/filters:format(jpeg)/pic8652577.jpg','https://cf.geekdo-images.com/xvJltnXOekvfq6IwzKxv6Q__original/img/QYKHwNPCyBNOlAWOm5lzst4wx7g=/0x0/filters:format(jpeg)/pic8652589.jpg','https://cf.geekdo-images.com/jYOq4U2kX2rkEO9uA2h6Zw__original/img/BC9wwV_1nHbK92MvF4RDruUdKj0=/0x0/filters:format(jpeg)/pic8652590.jpg','https://cf.geekdo-images.com/NzKZJh1fGmvGAPGZarBA5A__original/img/JfhG1dH8H98RmrYJncJ1PFIz-Wc=/0x0/filters:format(jpeg)/pic8682626.jpg','https://img.itch.zone/aW1nLzE4NDYyNzk4LmpwZw==/original/gXpJRQ.jpg','https://img.itch.zone/aW1hZ2UvMzA3OTM2My8xODQ2Mjc1MC5qcGVn/original/grG6SC.jpeg','https://img.itch.zone/aW1hZ2UvMzA3OTM2My8xODUwNTY4NC5qcGVn/original/uv%2Fg6I.jpeg','https://img.itch.zone/aW1hZ2UvMzA3OTM2My8xODUwNTY4Ni5qcGVn/original/EJvkIX.jpeg']
rows=[]
for u in urls:
 p=O/u.rsplit('/',1)[1]
 if not p.exists():
  with urlopen(Request(u,headers={'User-Agent':'Mozilla/5.0'}),timeout=35) as r:p.write_bytes(r.read())
 with Image.open(p) as im:im.verify()
 rows.append({'path':str(p),'url':u,'sha256':hashlib.sha256(p.read_bytes()).hexdigest()})
(O/'downloads.json').write_text(json.dumps(rows,indent=2)+'\n',encoding='utf8')
print(json.dumps(rows))
