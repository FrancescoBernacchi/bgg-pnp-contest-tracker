"""Incremento pilota IMG locale: carte intere con occorrenze e dorso condiviso.

Griglia verificata nelle quattro pagine. Nessun algoritmo generalizzato ad altri PDF.
"""
import hashlib
import json
import math
import shutil
import subprocess
from pathlib import Path
import pdfplumber
from PIL import Image, ImageDraw

ROOT=Path(__file__).resolve().parents[2]
MANIFEST=ROOT/'catalog/2025_children_family_images_2026-10-05.json'
SOURCE=ROOT/'catalog/2025_children_family_image_sources_2026-10-05.json'
OUT=ROOT/'outputs/tsk0068/component-pilot'
LIB=ROOT/'library/immagini/505__Mermaids-vs-Dinosaurs/estratti'
DPI=300
DATE='2026-10-05'
COORDS='punti PDF 1/72 inch, origine alto-sinistra, y crescente verso basso; cropbox=mediabox, rotazione zero'

def hash_file(p):return hashlib.sha256(p.read_bytes()).hexdigest()

def main():
    m=json.loads(MANIFEST.read_text(encoding='utf-8'))
    if m.get('pilot_completion'):
        raise SystemExit('Pilota successivamente completato: preservare revisioni e metadati; non rigenerare incremento storico.')
    docs=json.loads(SOURCE.read_text(encoding='utf-8'))['documents']
    cards=next(d for d in docs if d['acquired_file_id']==32)
    board=next(d for d in docs if d['acquired_file_id']==33)
    OUT.mkdir(parents=True,exist_ok=True);LIB.mkdir(parents=True,exist_ok=True)
    renderer=shutil.which('pdftoppm');assert renderer
    pdf=ROOT/'library'/cards['relative_path'];assert hash_file(pdf)==cards['sha256']
    subprocess.run([renderer,'-r',str(DPI),'-png',str(pdf),str(OUT/'page')],capture_output=True,check=True)
    conditions=dict(status='Uso locale privato autorizzato dall’utente',basis='PDF già acquisito come PnP dal collegamento autore; chiarimento utente 2026-10-05: libreria privata, nessuna esposizione GitHub',
        source_url=cards['resource_url'],checked_at=DATE,rights_scope='Consultazione locale e ritaglio fedele nel contratto IMG; licenza aperta/redistribuzione non attestata; nessun input/generazione AI',publication_allowed=False)
    groups=[]
    # Ogni posizione è verificata nel render; stessi contenuti conservano occorrenze.
    for p in [1,2]:
        for row in range(3):
            groups.append(dict(name=f'fish-{p}-{row}',page=p,cell=row*3,occurrences=[(p,row*3+i) for i in range(3)],side='Fronte'))
    groups.extend([
        dict(name='fish-wild',page=3,cell=0,occurrences=[(3,i) for i in range(3)],side='Fronte'),
        dict(name='first-player',page=3,cell=3,occurrences=[(3,3)],side='Fronte'),
        dict(name='turn-reference',page=3,cell=4,occurrences=[(3,i) for i in [4,5,6,7]],side='Fronte'),
        dict(name='common-back',page=4,cell=0,occurrences=[(4,i) for i in range(9)],side='Dorso')])
    new=[];components=[];rectangles={}
    with pdfplumber.open(pdf) as pl:
        for p,page in enumerate(pl.pages,1):
            assert page.rotation==0
            rects=sorted(page.rects,key=lambda r:(round(r['top'],2),r['x0']))
            assert len(rects)==9
            assert all(abs(r['width']-178.583)<.01 and abs(r['height']-249.449)<.01 for r in rects)
            rectangles[p]=rects
        # Anche il testo delle carte aiuto è raster: provarne l'identità tramite
        # riuso dello stesso oggetto della pagina, con stessa scala e bordo.
        for group in groups:
            objects=[]
            for p,cell in group['occurrences']:
                r=rectangles[p][cell];cx=(r['x0']+r['x1'])/2;cy=(r['top']+r['bottom'])/2
                matching=[x for x in pl.pages[p-1].images if x['x0']<=cx<=x['x1'] and x['top']<=cy<=x['bottom']]
                assert len(matching)==1
                x=matching[0];objects.append((p,x['name'],x['srcsize'],round(x['width'],2),round(x['height'],2)))
            assert len(set(objects))==1, 'Contenuti o scale diversi: non deduplicare'
            group['object_identity']=objects[0]
        for index,g in enumerate(groups,5):
            r=rectangles[g['page']][g['cell']]
            rect=[r['x0'],r['top'],r['x1'],r['bottom']]
            page=pl.pages[g['page']-1]
            with Image.open(OUT/f"page-{g['page']}.png") as img:
                # 0.2 punti comprendono il tratto esterno del bordo; nessun margine di stampa.
                sx,sy=img.width/page.width,img.height/page.height
                bounds=(math.floor((rect[0]-.2)*sx),math.floor((rect[1]-.2)*sy),math.ceil((rect[2]+.2)*sx),math.ceil((rect[3]+.2)*sy))
                crop=img.crop(bounds)
                candidate=OUT/f'{g["name"]}.png';crop.save(candidate)
                size=crop.size
            filename=f'Mermaids-vs-Dinosaurs__CF-2025__Componente-Carta-{g["side"]}__PnP__{index:03d}__v01.png'
            dest=LIB/filename
            if dest.exists():assert hash_file(dest)==hash_file(candidate)
            else:shutil.copyfile(candidate,dest)
            image_id=f'IMG-505-{index:04d}'
            component_id=f'CMP-505-{g["name"]}'
            occ=[]
            for p,cell in g['occurrences']:
                rr=rectangles[p][cell]
                occ.append(dict(document_id=32,document_sha256=cards['sha256'],page=p,cell=cell+1,rectangle=[rr['x0'],rr['top'],rr['x1'],rr['bottom']],coordinate_system=COORDS))
            rec=dict(image_id=image_id,game_id=505,entry_id=cards['entry_id'],contest_id=14,series_id=10,title='Mermaids vs Dinosaurs',
                category='Componente',subtype='Carta',side=g['side'],additional_categories=[],component_ids=[] if g['side']=='Dorso' else [component_id],
                asset_title=g['name'],version='v01',material_version=cards['version_raw'],current_use='adottata',validation='Controllo visivo pendente',principal=False,
                relative_path=dest.relative_to(ROOT).as_posix(),original_filename=cards['original_filename'],format='PNG',width=size[0],height=size[1],bytes=dest.stat().st_size,sha256=hash_file(dest),acquired_at=DATE,
                provenance=[dict(label='PnP',source_url=cards['resource_url'],acquired_file_id=32,document_sha256=cards['sha256'],page=g['page'],rectangle=rect,coordinate_system=COORDS,observed_at=DATE),dict(label='BGG-WIP',source_url=cards['wip_thread_url'],role='collegamento storico del manifest ACQ, non nuova lettura',observed_at=cards['acquired_at'] if 'acquired_at' in cards else '2026-10-03')],
                credits=next(x['credits_from_catalog'] for x in m['games'] if x['game_id']==505),conditions=conditions,occurrences=occ,
                relationships=[],extraction=dict(method='pdftoppm full page + rettangolo griglia verificato',dpi=DPI,pixel_bounds=bounds,border_padding_points=.2,source_document_id=32,source_document_sha256=cards['sha256']),deduplication_basis=dict(method='stesso oggetto raster della pagina, stessa scala/bordo, confronto visivo',object_identity=g['object_identity']))
            new.append(rec)
            if g['side']=='Fronte':components.append(dict(component_id=component_id,game_id=505,type='Carta',material_revision=cards['version_raw'],front_image_id=image_id,back_image_id='IMG-505-0014',physical_occurrence_count=len(occ),identity_basis='contenuto carta distinto nel PDF locale; nomi tecnici originali del catalogo',label=g['name']))
    back=next(x for x in new if x['side']=='Dorso');back['component_ids']=[x['component_id'] for x in components];back['relationships']=[dict(type='dorso_condiviso',target_component_id=x['component_id']) for x in components]
    for image in new:
        if image['side']=='Fronte':image['relationships'].append(dict(type='lato_collegato',target_image_id=back['image_id']))
    # Tabellone intero, margini esclusi. Pedine separabili inferiori restano residuo.
    bp=ROOT/'library'/board['relative_path'];assert hash_file(bp)==board['sha256']
    subprocess.run([renderer,'-f','1','-singlefile','-r',str(DPI),'-png',str(bp),str(OUT/'board')],capture_output=True,check=True)
    rect=[35.0,35.0,807.0,499.0]
    with pdfplumber.open(bp) as p,Image.open(OUT/'board.png') as img:
        bounds=(math.floor(rect[0]*img.width/p.pages[0].width),math.floor(rect[1]*img.height/p.pages[0].height),math.ceil(rect[2]*img.width/p.pages[0].width),math.ceil(rect[3]*img.height/p.pages[0].height))
        crop=img.crop(bounds);candidate=OUT/'board-crop.png';crop.save(candidate);size=crop.size
    dest=LIB/'Mermaids-vs-Dinosaurs__CF-2025__Componente-Tabellone__PnP__015__v01.png'
    if dest.exists():assert hash_file(dest)==hash_file(candidate)
    else:shutil.copyfile(candidate,dest)
    new.append(dict(image_id='IMG-505-0015',game_id=505,entry_id=board['entry_id'],contest_id=14,series_id=10,title='Mermaids vs Dinosaurs',category='Componente',subtype='Tabellone',side=None,additional_categories=[],component_ids=['CMP-505-board'],asset_title='Tabellone',version='v01',material_version=board['version_raw'],current_use='adottata',validation='Controllo visivo pendente',principal=False,
        relative_path=dest.relative_to(ROOT).as_posix(),original_filename=board['original_filename'],format='PNG',width=size[0],height=size[1],bytes=dest.stat().st_size,sha256=hash_file(dest),acquired_at=DATE,credits=next(x['credits_from_catalog'] for x in m['games'] if x['game_id']==505),
        conditions=dict(conditions,source_url=board['resource_url']),provenance=[dict(label='PnP',source_url=board['resource_url'],acquired_file_id=33,document_sha256=board['sha256'],page=1,rectangle=rect,coordinate_system=COORDS,observed_at=DATE)],occurrences=[dict(document_id=33,document_sha256=board['sha256'],page=1,rectangle=rect,coordinate_system=COORDS)],relationships=[],extraction=dict(method='pdftoppm full page + ritaglio bordo tabellone verificato',dpi=DPI,source_document_id=33,source_document_sha256=board['sha256'],pixel_bounds=bounds)))
    components.append(dict(component_id='CMP-505-board',game_id=505,type='Tabellone',image_ids=['IMG-505-0015'],material_revision=board['version_raw'],physical_occurrence_count=1))
    ids={x['image_id'] for x in new};assert len(ids)==11
    m['images']=[x for x in m['images'] if x['image_id'] not in ids]+new
    cmpids={x['component_id'] for x in components};m['components']=[x for x in m['components'] if x['component_id'] not in cmpids]+components
    m['private_use_clarification']=dict(date=DATE,basis='Chiarimento esplicito utente: immagini nella libreria privata, nessuna esposizione GitHub',scope='14 giochi e fonti direttamente collegate; niente AI/nuovi PnP/app/schema',not_a_third_party_license=True,restrictions='Registrare restrizioni specifiche effettivamente osservate; assenza licenza aperta non blocco automatico')
    m['state']='in corso; pilota componenti in verifica'
    m['extraction_pilot'].update(status='11 estrazioni componenti prodotte: 9 fronti distinti, dorso comune e tabellone; controllo visivo pendente',residual='Pedine inferiori del tabellone e diagrammi manuale da completare; ricerca esterna aperta')
    MANIFEST.write_text(json.dumps(m,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
    sheet=Image.new('RGB',(1500,950),'#eeeeee');draw=ImageDraw.Draw(sheet)
    for n,i in enumerate(new):
        image=Image.open(ROOT/i['relative_path']);image.thumbnail((280,410));x,y=(n%5)*300,(n//5)*460;sheet.paste(image,(x,y+25));draw.text((x+5,y+5),i['image_id']+' '+i['asset_title'],fill='black')
    sheet.save(OUT/'contact-sheet.png')
    assert hash_file(pdf)==cards['sha256'] and hash_file(bp)==board['sha256']
    print(json.dumps({'new_extracted_images':11,'library_images':len(m['images']),'components':len(components),'card_front_occurrences':26,'back_print_occurrences':9,'visual_review':'pending'}))

if __name__=='__main__':main()
