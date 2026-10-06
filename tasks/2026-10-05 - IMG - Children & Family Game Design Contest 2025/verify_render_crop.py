"""Prova circoscritta: ritaglio fedele dell'artwork CC0 dal PDF pilota.

Non acquisisce file, non altera originali né adotta il ritaglio inferiore.
"""
import hashlib
import json
import math
import shutil
import subprocess
from pathlib import Path
from PIL import Image
from pypdf import PdfReader

ROOT = Path(__file__).resolve().parents[2]
OUT = ROOT / 'outputs/tsk0068/render-crop'
DPI = 300
RECT = [58.5, 193.0, 154.0, 392.0]

def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()

def main():
    manifest = json.loads((ROOT/'catalog/2025_children_family_image_sources_2026-10-05.json').read_text(encoding='utf-8'))
    source = next(d for d in manifest['documents'] if d['acquired_file_id']==33)
    pdf = ROOT/'library'/source['relative_path']
    assert sha(pdf)==source['sha256']
    page = PdfReader(pdf).pages[0]
    assert page.get('/Rotate',0)==0 and page.cropbox==page.mediabox
    width,height = float(page.mediabox.width),float(page.mediabox.height)
    assert 0<=RECT[0]<RECT[2]<=width and 0<=RECT[1]<RECT[3]<=height
    renderer = shutil.which('pdftoppm')
    if not renderer:
        raise RuntimeError('Poppler pdftoppm non disponibile')
    OUT.mkdir(parents=True,exist_ok=True)
    subprocess.run([renderer,'-f','1','-singlefile','-r',str(DPI),'-png',str(pdf),str(OUT/'page')],check=True,capture_output=True)
    with Image.open(OUT/'page.png') as image:
        expected=(math.ceil(width*DPI/72),math.ceil(height*DPI/72))
        assert all(abs(a-b)<=1 for a,b in zip(image.size,expected))
        # Coordinate PDF normalizzate: origine in alto a sinistra, punti 1/72 inch.
        sx,sy=image.width/width,image.height/height
        bounds=(math.floor(RECT[0]*sx),math.floor(RECT[1]*sy),math.ceil(RECT[2]*sx),math.ceil(RECT[3]*sy))
        crop=image.crop(bounds)
        crop.save(OUT/'mermaid-crop.png')
        assert crop.getextrema()!=((255,255),(255,255),(255,255))
        crop_size=crop.size
        render_size=image.size
    with Image.open(OUT/'mermaid-crop.png') as check:
        assert check.size==crop_size and check.format=='PNG'
        check.verify()
    assert sha(pdf)==source['sha256']
    result=dict(task_id='TSK-0068',checked_at='2026-10-05',acquired_file_id=33,document_sha256=source['sha256'],page=1,
        rectangle=RECT,coordinate_system='punti PDF, origine alto-sinistra, asse y verso basso; cropbox=mediabox, rotazione 0',
        method='pdftoppm pagina completa + PIL ritaglio rettangolare fedele',dpi=DPI,render_size=render_size,pixel_bounds=bounds,
        category='Artwork',asset='Sirena CC0 Arousaland citata dal manuale file 34 pagina 3',
        conditions_source='https://openclipart.org/detail/308228/cute-mermaid',
        scope='Solo artwork isolato e fondo uniforme: non licenza sul tabellone completo',
        output_path='outputs/tsk0068/render-crop/mermaid-crop.png',width=crop_size[0],height=crop_size[1],
        bytes=(OUT/'mermaid-crop.png').stat().st_size,sha256=sha(OUT/'mermaid-crop.png'),
        operational_adoption=False,exclusion_reason='Artwork originale sorgente già acquisito con maggior dettaglio e trasparenza',
        original_unchanged=True,visual_review='pending',limitations=['Convalida solo questa regione; altri componenti e confini non attestati','Nessuna prova fronte/dorso o deduplicazione visiva generale'])
    (OUT/'verification.json').write_text(json.dumps(result,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
    print(json.dumps(result,ensure_ascii=True))

if __name__=='__main__':
    main()
