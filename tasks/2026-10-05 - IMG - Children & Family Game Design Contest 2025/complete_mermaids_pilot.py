"""Incremento finale pilota; preserva file e manifest precedenti. Non generalizzare."""
import copy
import hashlib
import json
import math
import shutil
from pathlib import Path
import pdfplumber
from PIL import Image

ROOT = Path(__file__).resolve().parents[2]
MP = ROOT/'catalog/2025_children_family_images_2026-10-05.json'
DATE = '2026-10-05'
WIP = 'https://boardgamegeek.com/thread/3484120'
CONTEST = 'https://boardgamegeek.com/thread/3441385/2025-children-and-family-game-design-contest'
COORDS = 'punti PDF 1/72 inch, origine alto-sinistra, y crescente verso basso; cropbox=mediabox, rotazione zero'

def digest(p):
    return hashlib.sha256(p.read_bytes()).hexdigest()

def main():
    m = json.loads(MP.read_text(encoding='utf-8'))
    if m.get('pilot_completion'):
        raise SystemExit('Incremento già registrato: usare verifica, non sovrascrivere.')
    docs = json.loads((ROOT/m['source_manifest']).read_text(encoding='utf-8'))['documents']
    game = next(g for g in m['games'] if g['game_id']==505)
    board = next(d for d in docs if d['acquired_file_id']==33)
    manual = next(d for d in docs if d['acquired_file_id']==34)
    credit = dict(name='Nico Valdez',role='Designer',source_url=manual['resource_url'],acquired_file_id=34,page=1,observed_at=DATE,evidence='By Nico Valdez, © 2025; WIP e profilo autore concordanti')
    game['verified_credits'] = [credit]
    game['credits_status'] = 'Designer verificato nel manuale e nel WIP; illustratore/compositore del logo e fotografo non dichiarati; crediti artwork separati'
    for i in m['images']:
        if i['game_id']==505 and i['category']=='Componente':
            i['credits'] = [credit]
            i['credits_status'] = game['credits_status']
    old = next(i for i in m['images'] if i['image_id']=='IMG-505-0015')
    historical = copy.deepcopy(old)
    historical.update(current_use='Superata',validation='Ritaglio incompleto: escludeva i tre spazi carte inferiori; rettificato dopo lettura setup manuale pagina 2',superseded_by_version='v02')
    m.setdefault('historical_files',[]).append(historical)
    rectangle = [34.8,34.8,807.2,570.0]
    with pdfplumber.open(ROOT/'library'/board['relative_path']) as p, Image.open(ROOT/'outputs/tsk0068/component-pilot/board.png') as im:
        pg=p.pages[0]
        assert pg.rotation==0
        bounds=(math.floor(rectangle[0]*im.width/pg.width),math.floor(rectangle[1]*im.height/pg.height),math.ceil(rectangle[2]*im.width/pg.width),math.ceil(rectangle[3]*im.height/pg.height))
        dest=ROOT/old['relative_path'].replace('__v01.png','__v02.png')
        assert not dest.exists()
        im.crop(bounds).save(dest)
    old.update(version='v02',relative_path=dest.relative_to(ROOT).as_posix(),bytes=dest.stat().st_size,sha256=digest(dest),validation='Ritaglio completo da verificare visivamente',revision_reason='Include i tre spazi carte inferiori, parte del tabellone; non pedine separabili')
    with Image.open(dest) as im: old.update(width=im.width,height=im.height)
    old['extraction']['pixel_bounds']=bounds
    for pr in old['provenance']+old['occurrences']: pr['rectangle']=rectangle
    old['relationships'].append(dict(type='supersedes_file_version',target_image_id=old['image_id'],target_version='v01'))
    assets=[(16,'8788093','Titolo-Grafico','mermaids vs dinosaur draft logo v0.1','https://cf.geekdo-images.com/cLtslv6FbudhuiYuxKxuvA__original/img/Hvl-CXPwt243T0YZJGYi4tQAa-I=/0x0/filters:format(png)/pic8788093.png'),(17,'8787888','Setup','Mermaids vs Dinosaur Setup','https://cf.geekdo-images.com/0zwb28YmXOnA7uVE17ucQg__original/img/P8dD2BWR_Ot-HJVe9Fce2yxstqM=/0x0/filters:format(png)/pic8787888.png')]
    for n,bggid,category,title,url in assets:
        src=ROOT/f'outputs/tsk0068/bgg/{bggid}.png'
        dest=ROOT/f'library/immagini/505__Mermaids-vs-Dinosaurs/originali/Mermaids-vs-Dinosaurs__CF-2025__{category}__BGG-WIP__{n:03d}__v01.png'
        assert not dest.exists(); shutil.copyfile(src,dest)
        with Image.open(dest) as im:
            im.verify()
        with Image.open(dest) as im: width,height=im.size
        page=f'https://boardgamegeek.com/image/{bggid}'
        m['images'].append(dict(image_id=f'IMG-505-{n:04d}',game_id=505,entry_id=505,contest_id=14,series_id=10,title=game['title'],category=category,additional_categories=['Componenti'] if n==17 else [],component_ids=[],asset_title=title,version='v01',material_version='Draft logo v0.1' if n==16 else 'Prototipo fotografato; pubblicato 2025-03-24',current_use='adottata',validation='Originale remoto decodificato e verificato visivamente 2026-10-05',principal=False,relative_path=dest.relative_to(ROOT).as_posix(),original_filename=f'pic{bggid}.png',format='PNG',width=width,height=height,bytes=dest.stat().st_size,sha256=digest(dest),acquired_at=DATE,
            provenance=[dict(label='BGG-WIP',source_url=WIP,post_id=45851943,observed_at=DATE),dict(label='BGG-Galleria',source_url=page,asset_url=url,bgg_image_id=int(bggid),download_option='Original esposto dal pulsante Downloads',observed_at=DATE),dict(label='Contest',source_url=game['entry_url'],observed_at=DATE),dict(label='Contest',source_url=CONTEST+'/page/2',observed_at=DATE)],
            credits=[dict(name='Nico Valdez',role='Caricamento BGG',username='nicanorrr',source_url=page,observed_at=DATE),credit],credits_status='Autore grafico logo non dichiarato' if n==16 else 'Fotografo non dichiarato; uploader non equiparato al fotografo',
            conditions=dict(status='Uso locale privato',rights_notice='All Rights Reserved',source_url=page,terms_url='https://boardgamegeek.com/terms',checked_at=DATE,basis='Download Original esposto dalla funzionalità BGG; acquisizione privata autorizzata dall’utente',publication_allowed=False,ai_use=False),occurrences=[],relationships=[],revision_note='Nessuna versione finale alternativa individuata; conserva designazione draft' if n==16 else 'Foto storica del prototipo; non rappresenta automaticamente la revisione PDF corrente'))
    logo=m['images'][-2]
    logo['related_occurrences']=[dict(acquired_file_id=34,document_sha256=manual['sha256'],page=1,rectangle=[137.25,73.5,474.75,289.5],coordinate_system=COORDS,embedded_dimensions=[450,288],relationship='stessa composizione del titolo osservata visivamente, non equivalenza di bytes',adopted_as_separate_file=False,reason='Riproduzione nel manuale meno dettagliata; originale BGG conservato')]
    game['research_status']='verificata nel perimetro osservabile; limite accesso pagina galleria registrato'
    game['research_complete']=True
    game['sources_reviewed'] += ['Manuale file 34: tutte le 3 pagine renderizzate; logo pagina 1, nessuna immagine pagine 2–3','WIP: tutti gli 11 post, nessuna paginazione','GeekList item 11638759 e 3/3 commenti','Contest thread: 75/75 post, 3/3 pagine, selezione pertinente al pilota','Profilo autore e designer; galleria accessibile come sequenza immagini 4/4','Cartella Drive autore: 2 PDF, nessun file immagine aggiuntivo']
    game['external_research']=dict(wip='11/11 post verificati: 2 immagini',updates='April 29 Contest Ready, nessuna nuova immagine distinta; revisioni materiali non dedotte dal solo annuncio',gallery='Pagina profilo /images richiede login; sequenza pubblica 4/4 in pagine immagine, 2 pilota + 2 estranee escluse',contest='Entry e 3 commenti; thread 3 pagine/75 post: stesse due immagini, nessuna altra pertinente',author_publisher='Profilo e designer 111335, 6 giochi collegati senza pilota; nessun sito ufficiale esterno collegato osservato',linked_folder='Drive: carte PDF modificato 2025-04-29, tabellone PDF 2025-03-24; nessuna immagine separata o sottocartella visibile; nessun PDF scaricato')
    game['scope_exclusions']=['Video/YouTube e thumbnail incorporata: esclusi dal contratto','TTS: implementazione collegata, non esplorazione di piattaforme ulteriori','Altri due giochi della galleria autore esclusi','Nessun nuovo manuale/PnP o ricerca web/social']
    game['residuals']=['Accesso alla pagina galleria autore richiede login; sequenza pubblica delle immagini verificata 4/4','Nessuna licenza di pubblicazione attestata per composizioni BGG/PnP','Foto prototipo e logo draft preservano designazione storica; successione grafica non inventata','Pedine fisiche generiche richieste dalle regole, nessun componente stampabile dedicato nei 3 PDF acquisiti']
    counts={'Artwork':4,'Componente':11,'Titolo-Grafico':1,'Setup':1,'Componenti':1}
    for c in game['categories']:
        count=counts.get(c['category'],0)
        c.update(research='verificata nelle fonti e materiali elencati',applicability='applicabile' if count else 'nessuna immagine pertinente individuata nel perimetro osservato',adopted_original_count=count,verified_absence=not bool(count),absence_scope=None if count else '3 PDF, WIP 11 post, entry/commenti, contest 75 post e fonti autore direttamente collegate osservabili',impediment='Pagina galleria autore richiede login; sequenza pubblica 4/4 verificata',residual='Limiti del perimetro e del login espliciti; nessuna conclusione sull’intero web')
    m['extraction_pilot'].update(status='11 estrazioni: 9 fronti distinti, dorso comune e tabellone completo v02',residual='Nessuna estrazione residua nei 3 PDF; pedine inferiori era classificazione errata, sono spazi carte',method='pdftoppm pagina completa 300 DPI + ritaglio geometrico verificato',manual_images_reviewed=3)
    m['references'][0].update(status='Condizioni verificate per uso locale tramite download esposto; nessuna licenza di pubblicazione',summary='Downloads espone Original nelle due pagine immagine; avviso All Rights Reserved conservato, nessun riuso pubblico/AI attestato')
    m['pilot_completion']=dict(game_id=505,checked_at=DATE,research_complete_with_documented_access_limit=True,current_images=17,downloaded_originals=6,component_extractions=11,historical_files=1,physical_library_files=18,whole_batch_complete=False)
    m['state']='in corso: pilota concluso nel perimetro osservabile con limiti documentati, altri 13 giochi aperti'
    m['app_handoff']['review_required'] += ['Pilota 17 immagini attuali / 18 file fisici incl. tabellone v01 Superata','Assenze per categoria circoscritte e limite login galleria','Provenienze multiple unico file, occorrenza logo manuale inferiore non duplicata','Designer Nico Valdez distinto da uploader, fotografo e autore grafico non dichiarati']
    MP.write_text(json.dumps(m,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
    print(json.dumps(m['pilot_completion']))

if __name__=='__main__': main()
