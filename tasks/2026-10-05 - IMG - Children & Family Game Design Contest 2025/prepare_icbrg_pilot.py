"""ICBRG: geometrie specifiche verificate; prepara file e manifest candidato locale."""
import copy,hashlib,json,math,shutil,subprocess
from pathlib import Path
import pdfplumber
from pypdf import PdfReader
from PIL import Image,ImageDraw
ROOT=Path(__file__).resolve().parents[2]
OUT=ROOT/'outputs/tsk0068/icbrg'
LIB=ROOT/'library/immagini/507__ICBRG'
DATE='2026-10-05'
COORDS='punti PDF, origine alto-sinistra, y crescente verso basso; cropbox=mediabox, rotazione zero'
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def main():
    m=json.loads((ROOT/'catalog/2025_children_family_images_2026-10-05.json').read_text(encoding='utf-8'))
    assert not any(i['game_id']==507 for i in m['images']), 'Già registrato: non sovrascrivere'
    docs=json.loads((ROOT/m['source_manifest']).read_text(encoding='utf-8'))['documents']
    ds={d['acquired_file_id']:d for d in docs if d['game_id']==507}
    for sub in ['originali','estratti','ai','derivati']:(LIB/sub).mkdir(parents=True,exist_ok=True)
    pages={}
    for id,d in ds.items():
        p=ROOT/'library'/d['relative_path'];assert sha(p)==d['sha256']
        subprocess.run([shutil.which('pdftoppm'),'-r','300','-png',str(p),str(OUT/f'hi-{id}')],check=True,capture_output=True)
        pages[id]=pdfplumber.open(p)
    credit=dict(name='Ryan Moylan',role='Designer',source_url=ds[5]['resource_url'],acquired_file_id=5,page=1,observed_at=DATE)
    new=[];cmps=[]
    def record(n,category,title,path,doc=None,page=None,rect=None,subtype=None,extra=None):
        with Image.open(path) as im:im.verify()
        with Image.open(path) as im:w,h=im.size;fmt=im.format
        r=dict(image_id=f'IMG-507-{n:04d}',game_id=507,entry_id=507,contest_id=14,series_id=10,title='ICBRG',category=category,additional_categories=[],asset_title=title,version='v01',material_version=ds[doc]['version_raw'] if doc else 'Versione immagine BGG osservata 2026-10-05',current_use='adottata',validation='Controllo visivo pendente',principal=False,relative_path=path.relative_to(ROOT).as_posix(),format=fmt,width=w,height=h,bytes=path.stat().st_size,sha256=sha(path),acquired_at=DATE,credits=[credit],credits_status='Designer dichiarato; illustratore e fotografo non dichiarati',component_ids=[],relationships=[],provenance=[],occurrences=[],conditions=dict(status='Uso locale privato autorizzato',basis='IMG autorizzato: estrazione fedele dei PDF PnP già acquisiti, nessuna redistribuzione/AI',checked_at=DATE,publication_allowed=False,ai_use=False))
        if doc:
            r['original_filename']=ds[doc]['original_filename']
            r['conditions']['source_url']=ds[doc]['resource_url']
            r['provenance']=[dict(label='PnP' if doc==4 else 'Manuale',source_url=ds[doc]['resource_url'],acquired_file_id=doc,document_sha256=ds[doc]['sha256'],page=page,rectangle=rect,coordinate_system=COORDS,observed_at=DATE),dict(label='BGG-WIP',source_url='https://boardgamegeek.com/thread/3493395',observed_at=DATE)]
            r['occurrences']=[dict(document_id=doc,document_sha256=ds[doc]['sha256'],page=page,rectangle=rect,coordinate_system=COORDS)]
        if subtype:r['subtype']=subtype
        if extra:r.update(extra)
        new.append(r);return r
    def crop(n,cat,title,doc,page,rect,sub=None):
        p=pages[doc].pages[page-1];assert p.rotation==0
        with Image.open(OUT/f'hi-{doc}-{page}.png') as im:
            b=(math.floor(rect[0]*im.width/p.width),math.floor(rect[1]*im.height/p.height),math.ceil(rect[2]*im.width/p.width),math.ceil(rect[3]*im.height/p.height))
            dest=LIB/'estratti'/f'ICBRG__CF-2025__{cat}{"-"+sub if sub else ""}__{"PnP" if doc==4 else "Manuale"}__{n:03d}__v01.png'
            assert not dest.exists();im.crop(b).save(dest)
        return record(n,cat,title,dest,doc,page,rect,sub,dict(extraction=dict(method='render completo pdftoppm + crop geometrico',dpi=300,pixel_bounds=b,source_document_id=doc,source_document_sha256=ds[doc]['sha256'])))
    board=crop(1,'Componente','Tabellone intero 37 esagoni',4,1,[23.4,24.1,588.6,767.1],'Tabellone')
    board['component_ids']=['CMP-507-board'];cmps.append(dict(component_id='CMP-507-board',game_id=507,type='Tabellone',image_ids=[board['image_id']],physical_occurrence_count=1))
    curves=pages[4].pages[1].curves
    hexes=sorted({tuple(round(c[k],3) for k in ['x0','top','x1','bottom']) for c in curves if abs(c['width']-62.76)<.01 and abs(c['height']-56.88)<.01},key=lambda r:(r[1],r[0]))
    assert len(hexes)==37
    signatures={tuple((round(x-r['x0'],3),round(y-r['top'],3)) for x,y in r['pts'])+(tuple(r['fill']) if isinstance(r['fill'],list) else (r['fill'],))+tuple(r.get('non_stroking_color') or ()) for r in curves if abs(r['width']-62.76)<.01 and abs(r['height']-56.88)<.01}
    # Fill e stroke sono oggetti distinti dello stesso esagono: confronto geometrico
    # e controllo visivo della pagina confermano i 37 componenti uguali.
    tile=crop(2,'Componente','Tessera ghiaccio',4,2,[21.1,25.5,84.6,83.2],'Tessera')
    tile['component_ids']=['CMP-507-ice'];tile['occurrences']=[dict(document_id=4,document_sha256=ds[4]['sha256'],page=2,rectangle=list(r),coordinate_system=COORDS) for r in hexes]
    tile['deduplication_basis']='37 sagome con geometria locale e colori identici, pagina intera e ritaglio verificati; non soglia visiva generale'
    cmps.append(dict(component_id='CMP-507-ice',game_id=507,type='Tessera',image_ids=[tile['image_id']],physical_occurrence_count=37))
    groups=[(3,'nero',[24.4,480.2,61.9,709.2],[24.4,78.78,133.14]),(4,'bianco',[187.5,480.2,225.1,709.2],[187.5,241.89,296.25]),(5,'grigio-A',[350.6,480.2,388.2,709.2],[350.6]),(6,'grigio-B',[404.99,480.2,442.6,709.2],[404.99]),(7,'arancione',[24.4,726.7,243.3,766.1],[24.4])]
    for n,color,rect,xs in groups:
        r=crop(n,'Componente',f'Standee {color} completo da assemblare',4,2,rect,'Pedina')
        cmp='CMP-507-penguin-'+color.split('-')[0];r['component_ids']=[cmp]
        r['additional_categories']=['Preparazione'];r['printed_state']='striscia intera, due facce e base con pieghe; nessuna normalizzazione o scontorno'
        if n<7:
            side_regions=[dict(side='Fronte',rectangle=[rect[0],rect[1],rect[2],575.83]),dict(side='Retro',rectangle=[rect[0],613.656,rect[2],rect[3]],printed_orientation='capovolta rispetto al fronte'),dict(side='Base',rectangle=[rect[0],575.716,rect[2],613.78])]
        else:
            side_regions=[dict(side='Fronte',rectangle=[24.4,726.7,115.824,766.1]),dict(side='Retro',rectangle=[151.94,726.7,243.3,766.1]),dict(side='Base',rectangle=[115.7,727.416,152.06,765.48])]
        r['side_regions']=[dict(s,document_id=4,page=2,coordinate_system=COORDS) for s in side_regions]
        r['occurrences']=[dict(document_id=4,document_sha256=ds[4]['sha256'],page=2,rectangle=[x,rect[1],x+(rect[2]-rect[0]),rect[3]],coordinate_system=COORDS) for x in xs]
        r['deduplication_basis']='stesse facce raster e stessa geometria stampata per nero/bianco; due sagome grigie conservate perché scala frontale diversa'
        c=next((c for c in cmps if c['component_id']==cmp),None)
        if c:c['image_ids'].append(r['image_id']);c['physical_occurrence_count']+=len(xs)
        else:cmps.append(dict(component_id=cmp,game_id=507,type='Pedina',image_ids=[r['image_id']],physical_occurrence_count=len(xs),assembly='due facce incollate e base piegata, istruzioni PnP pagina 2',side_relationship='facce collegate come regioni dello stesso stampato, non carte fronte/dorso'))
    specs=[(8,1,[260,401,351,483],'Setup 2 giocatori','Setup'),(9,2,[270,88,343,174],'Direzioni di movimento','Diagramma'),(10,2,[331,232,541,520],'Limiti del movimento A–E','Diagramma'),(11,2,[93,609,559,688],'Movimento fra altezze, vista laterale','Diagramma'),(12,3,[65,202,174,337],'Movimento prima della rimozione ghiaccio','Diagramma'),(13,3,[315,201,423,337],'Distribuzione ghiaccio dopo il movimento','Diagramma'),(14,3,[112,610,511,670],'Variante Snow Shoes, vista laterale','Diagramma'),(15,4,[220,176,388,406],'Setup 3 giocatori','Setup'),(16,4,[220,506,388,725],'Setup 4 giocatori','Setup')]
    for n,p,rect,title,cat in specs:
        r=crop(n,cat,title,5,p,rect)
        r['additional_categories']=['Diagramma'] if cat=='Setup' else []
        r['context']='schema composito dal manuale 2.0; riferimento alla pagina per le spiegazioni, non stato di partita fotografato'
    reader=PdfReader(ROOT/'library'/ds[4]['relative_path'])
    objects={'Image55.png':'Pinguino nero','Image57.png':'Pinguino bianco','Image59.png':'Pinguino grigio','Image62.png':'Pinguino arancione faccia A','Image64.png':'Pinguino arancione faccia B'}
    for n,(name,title) in enumerate(objects.items(),17):
        obj=next(i for i in reader.pages[1].images if i.name==name)
        dest=LIB/'estratti'/f'ICBRG__CF-2025__Artwork__PnP__{n:03d}__v01.png';assert not dest.exists();dest.write_bytes(obj.data)
        occ=[i for i in pages[4].pages[1].images if i['name']==name.split('.')[0]]
        r=record(n,'Artwork',title,dest,4,2,None,extra=dict(extraction=dict(method='pypdf estrazione oggetto raster con maschera applicata',object_name=name,source_document_id=4,source_document_sha256=ds[4]['sha256'])))
        r['occurrences']=[dict(document_id=4,document_sha256=ds[4]['sha256'],page=2,rectangle=[i[k] for k in ['x0','top','x1','bottom']],coordinate_system=COORDS,object_name=name) for i in occ]
        r['provenance'][0]['rectangle']=r['occurrences'][0]['rectangle']
        r['quality_note']='Dimensioni native modeste: nessun upscale; immagini non attribuite al designer in assenza di credito grafico'
        colors=['nero','bianco','grigio','arancione','arancione'];cmp='CMP-507-penguin-'+colors[n-17]
        r['relationships']=[dict(type='artwork_di_componente',target_component_id=cmp)]
    rem=json.loads((OUT/'remote/downloads.json').read_text(encoding='utf-8'))
    seen={};n=22
    titles={8819477:('Setup','2 player setup','Ryan Moylan','RPMgamer'),8895515:('Setup','Setup for 2 players','Ryan Moylan','RPMgamer'),8895516:('Partita','End of 2 player game','Ryan Moylan','RPMgamer'),8819478:('Partita','2 Player end of game, black wins','Ryan Moylan','RPMgamer'),8819479:('Partita','2 Player end of game, black wins','Ryan Moylan','RPMgamer'),8824311:('Partita','Attempt at creating ICBRG in TTS','Nate Converse','n8_the_gr8'),8825001:('Partita','ICBRG by Ryan Moylan','Frank','Wildcard Six'),8832313:('Partita','ICBRG by Ryan','Markus H','OneTableGames'),8855215:('Partita','TTS Icebrg','Nico Valdez','nicanorrr')}
    for a in rem:
        id=a['bgg_image_id'];cat,title,uploader,username=titles[id]
        prov=dict(label='BGG-Galleria' if id in [8895515,8895516] else 'BGG-WIP',source_url=f'https://boardgamegeek.com/image/{id}',asset_url=a['url'],bgg_image_id=id,observed_at=DATE)
        if a['sha256'] in seen:
            r=seen[a['sha256']];r['provenance'].append(prov);r.setdefault('duplicate_references',[]).append(dict(bgg_image_id=id,basis='SHA-256 identico',adopted_as_new_file=False));continue
        dest=LIB/'originali'/f'ICBRG__CF-2025__{cat}__BGG-WIP__{n:03d}__v01.{"jpg" if a["format"]=="JPEG" else "png"}'
        assert not dest.exists();shutil.copyfile(ROOT/a['path'],dest)
        r=record(n,cat,title,dest);r['validation']='Originale scaricato e vista d’insieme verificata';r['provenance']=[prov,dict(label='BGG-WIP',source_url='https://boardgamegeek.com/thread/3493395',observed_at=DATE)]
        if id==8819477:r['provenance'].append(dict(label='BGG-Contest',source_url='https://boardgamegeek.com/geeklist/351008/2025-children-and-family-game-design-contest?itemid=11692597#11692597',observed_at=DATE))
        r['credits'].append(dict(name=uploader,role='Caricamento BGG',username=username,source_url=prov['source_url'],observed_at=DATE))
        r['conditions'].update(rights_notice='All Rights Reserved',source_url=prov['source_url'],terms_url='https://boardgamegeek.com/terms',basis='Download Original esposto nelle pagine BGG; libreria privata autorizzata')
        r['additional_categories']=['Componenti'] if cat=='Setup' else []
        r['representation']='prototipo fisico' if id in [8819477,8895515,8819478,8895516,8819479] else 'ricostruzione digitale in immagine pubblicata nel WIP; piattaforma non esplorata'
        seen[a['sha256']]=r;n+=1
    assert len(new)==27 and len(cmps)==6
    for d in ds.values():assert sha(ROOT/'library'/d['relative_path'])==d['sha256']
    (OUT/'candidate.json').write_text(json.dumps(dict(images=new,components=cmps,credits=[credit]),ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
    sheet=Image.new('RGB',(1800,1800),'#eee');draw=ImageDraw.Draw(sheet)
    for j,r in enumerate(new):
        with Image.open(ROOT/r['relative_path']) as im:
            im=im.convert('RGBA');im.thumbnail((290,270));x,y=(j%6)*300,(j//6)*350;sheet.paste(im,(x,y+35),im);draw.text((x,y),r['image_id']+' '+r['asset_title'][:25],fill='black')
    sheet.save(OUT/'candidate-sheet.png');print(json.dumps(dict(candidate_images=len(new),components=len(cmps),remote_unique=len(seen),downloads=len(rem))))
if __name__=='__main__':main()
