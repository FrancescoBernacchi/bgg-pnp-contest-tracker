import json
from pathlib import Path
from PIL import Image,ImageDraw
R=Path(__file__).resolve().parents[2];O=R/'outputs/tsk0088'
def sheet(rows,prefix):
 for start in range(0,len(rows),25):
  part=rows[start:start+25];grid=Image.new('RGB',(1400,270*((len(part)+4)//5)),'#ddd');draw=ImageDraw.Draw(grid)
  for i,(label,path) in enumerate(part):
   im=Image.open(path).convert('RGB');im.thumbnail((270,240));x=i%5*280;y=i//5*270;grid.paste(im,(x+(280-im.width)//2,y+25));draw.text((x+3,y+3),label,fill='black')
  grid.save(O/f'{prefix}-{start//25}.jpg')
v=json.loads((O/'remote/browser-evidence-verified.json').read_text(encoding='utf-8'))
for gid in sorted({r['game_id'] for r in v}):sheet([(str(r['id']),r['path']) for r in v if r['game_id']==gid],f'remote-qa-{gid}')
print('remote sheets ready',len(v))
