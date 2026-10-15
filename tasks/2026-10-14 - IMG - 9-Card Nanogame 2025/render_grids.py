import json
from pathlib import Path
from PIL import ImageDraw
import pypdfium2 as pdfium
R=Path(__file__).resolve().parents[2];O=R/'outputs/tsk0088';m=json.loads((O/'materials-private.json').read_text(encoding='utf-8'))
for n,page in [(4,1),(9,1),(13,1),(16,1),(35,1),(38,1),(39,1),(49,3),(46,1)]:
 d=m['documents'][n];pdf=pdfium.PdfDocument(str(R/'library'/d['relative_path']));im=pdf[page-1].render(scale=1.5).to_pil().convert('RGB');draw=ImageDraw.Draw(im)
 for x in range(0,int(pdf[page-1].get_width()),25):
  draw.line((x*1.5,0,x*1.5,im.height),fill='#ff00ff',width=1);draw.text((x*1.5+1,2),str(x),fill='red')
 for y in range(0,int(pdf[page-1].get_height()),25):
  draw.line((0,y*1.5,im.width,y*1.5),fill='#ff00ff',width=1);draw.text((2,y*1.5+2),str(y),fill='red')
 im.save(O/f'grid-{n}-{page}.jpg')
print('9 coordinate grids rendered')
