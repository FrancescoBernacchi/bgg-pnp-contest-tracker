from pathlib import Path
from PIL import Image,ImageDraw
import json,copy,hashlib
R=Path(__file__).resolve().parents[2];O=R/'outputs/tsk0068/two-2026-10-10';P=R/'catalog/2025_children_family_images_2026-10-11.json';m=json.loads(P.read_text(encoding='utf8'));board=Image.open(O/'native18-1-0.png')
boxes={13:[800,1292,868,1370],14:[820,1378,846,1452],15:[811,1470,858,1542],16:[812,1551,853,1624],17:[812,1632,856,1695],18:[810,1701,854,1776]}
for n,b in boxes.items():
 i=next(i for i in m['images'] if i['image_id']==f'IMG-498-{n:04d}');old=copy.deepcopy(i);old.update(current_use='superata',validation='Crop candidato v01 rettificato prima della chiusura: confini incompleti o frammenti adiacenti',supercession_reason='Rettifica confini artwork dopo controllo ingrandito del contesto; v02 integra arma/capo/figura ed esclude bordo stanza')
 old['relationships'].append({'type':'variante_superata','target_image_id':i['image_id'],'target_version':'v02'});m['historical_files'].append(old)
 path=R/i['relative_path'].replace('__v01.png','__v02.png');assert not path.exists();board.crop(b).save(path)
 i.update(version='v02',relative_path=path.relative_to(R).as_posix(),width=b[2]-b[0],height=b[3]-b[1],bytes=path.stat().st_size,sha256=hashlib.sha256(path.read_bytes()).hexdigest())
 i['extraction']['native_pixel_rectangle']=b;i['provenance'][0]['rectangle']=b;i['occurrences'][0]['rectangle']=b
m['verification']['historical_image_files_verified']=len(m['historical_files']);m['pilot_increments'][-1].update(historical_files_added=11,physical_files_added=44,crop_corrections=6)
P.write_text(json.dumps(m,ensure_ascii=False,indent=2)+'\n',encoding='utf8')
c=Image.new('RGB',(1200,700),'#ddd');d=ImageDraw.Draw(c)
for j,n in enumerate(boxes):
 i=next(i for i in m['images'] if i['image_id']==f'IMG-498-{n:04d}');im=Image.open(R/i['relative_path']);im=im.resize((im.width*3,im.height*3));x=(j%3)*400;y=(j//3)*350;c.paste(im,(x,y+25));d.text((x,y),i['asset_title'],fill='black')
c.save(O/'hero-corrected-contact.png')
