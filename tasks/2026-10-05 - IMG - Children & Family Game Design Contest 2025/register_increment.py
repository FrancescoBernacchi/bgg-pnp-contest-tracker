"""Registra il primo incremento IMG, senza scrivere il database operativo."""
import hashlib
import json
import shutil
import sqlite3
from pathlib import Path
from PIL import Image

ROOT = Path(__file__).resolve().parents[2]
DATE = '2026-10-05'
SOURCE = ROOT / 'catalog/2025_children_family_image_sources_2026-10-05.json'
OUT = ROOT / 'catalog/2025_children_family_images_2026-10-05.json'
CATEGORIES = ['Copertina','Titolo-Grafico','Artwork','Icona','Setup','Partita','Componenti','Componente','Dettaglio','Diagramma','Preparazione']

def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()

def main():
    if OUT.exists() and 'technical_resolution' in json.loads(OUT.read_text(encoding='utf-8')):
        raise RuntimeError('Manifest evoluto nell’incremento 2: non rigenerare dal solo incremento 1; preservare evidenze successive.')
    sources = json.loads(SOURCE.read_text(encoding='utf-8'))
    docs = sources['documents']
    assert len(docs) == 38 and len({d['game_id'] for d in docs}) == 14
    db = sqlite3.connect((ROOT/'database/pnp_collection.sqlite3').as_uri()+'?mode=ro',uri=True)
    db.row_factory = sqlite3.Row
    # Crediti del catalogo: conservare ruolo e fonte senza inferire illustratori.
    tables = {r[0] for r in db.execute("select name from sqlite_master where type='table'")}
    credits = {}
    if 'game_credits' in tables:
        for gid in {d['game_id'] for d in docs}:
            credits[gid] = [dict(r) for r in db.execute('select gc.role,gc.credit_raw,p.display_name,p.bgg_username,p.profile_url from game_credits gc join people p on p.id=gc.person_id where gc.game_id=?',(gid,))]
    games = []
    for gid in sorted({d['game_id'] for d in docs}):
        game_docs = [d for d in docs if d['game_id']==gid]
        first = game_docs[0]
        games.append(dict(game_id=gid,entry_id=first['entry_id'],contest_id=14,title=first['game_title'],
            wip_url=first['wip_thread_url'],entry_url=first['entry_url'],
            acquired_file_ids=[d['acquired_file_id'] for d in game_docs],
            credits_from_catalog=credits.get(gid,[]),credits_source_url=first['wip_thread_url'],credits_checked_locally_at=DATE,credits_status='Crediti preesistenti: verifica locale, non nuova verifica esterna; nessun illustratore dedotto dal designer',
            research_status='parziale',research_complete=False,checked_at=DATE,
            sources_reviewed=['manifest ACQ','PDF locali: ricerca testuale condizioni e crediti'],
            external_research=dict(wip='non svolta: condizioni BGG da chiarire',updates='non svolta',gallery='non svolta',contest='non svolta',author_publisher='non svolta salvo artwork direttamente citati per game_id 505'),
            categories=[dict(category=cat,research='parziale',applicability='desiderata' if cat in ['Artwork','Titolo-Grafico','Icona'] else 'da determinare',
                adopted_original_count=4 if gid==505 and cat=='Artwork' else 0,validated_ai_count=0,pending_ai_count=0,
                verified_absence=False,impediment='Condizioni BGG e permessi di estrazione composizioni da chiarire',residual='Ricerca delle fonti e componenti non conclusa') for cat in CATEGORIES],
            residuals=['WIP/aggiornamenti/gallerie/contest e pagine collegate da esplorare dopo chiarimento condizioni','Confronto revisioni e varianti per contenuto non concluso','Estrazione componenti interi/lati/dorsi non collaudata']))
    specs = [
        (308228,'cute-mermaid','Arousaland','Cute mermaid',Path('C:/Users/39348/Downloads/308228.png')),
        (293199,'tonight-its-fish','cactus cowboy',"tonight it's fish",ROOT/'outputs/tsk0068/openclipart/293199.png'),
        (314119,'dinosaur-3-trex-with-feet','amcolley','Dinosaur 3 T-Rex with Feet',ROOT/'outputs/tsk0068/openclipart/314119.png'),
        (62629,'checkered-flag','J_Alves','Checkered flag',ROOT/'outputs/tsk0068/openclipart/62629.png')]
    base = ROOT/'library/immagini/505__Mermaids-vs-Dinosaurs'
    for folder in ['originali','estratti','ai','derivati']:
        (base/folder).mkdir(parents=True,exist_ok=True)
    images = []
    for n,(art_id,slug,author,title,path) in enumerate(specs,1):
        filename=f'Mermaids-vs-Dinosaurs__CF-2025__Artwork__Autore__{n:03d}__v01.png'
        dest=base/'originali'/filename
        if dest.exists():
            assert digest(dest)==digest(path), 'Non sovrascrivere originali diversi'
        else:
            shutil.copyfile(path,dest)
        with Image.open(dest) as im:
            fmt=im.format; size=im.size;im.verify()
        assert fmt=='PNG'
        source_url=f'https://openclipart.org/detail/{art_id}/{slug}'
        credit=[dict(name=author,role='artwork',source_url=source_url,verified_at=DATE)]
        if art_id==314119:
            credit.append(dict(name='Firkin',role='autore artwork precedente, remix dichiarato',source_url='https://openclipart.org/detail/299976',verified_at=DATE))
        images.append(dict(image_id=f'IMG-505-{n:04d}',game_id=505,entry_id=next(d['entry_id'] for d in docs if d['game_id']==505),contest_id=14,series_id=10,
            title='Mermaids vs Dinosaurs',asset_title=title,category='Artwork',additional_categories=[],subtype=None,side=None,component_ids=[],
            version='v01',material_version=None,current_use='adottata',validation='originale verificata visivamente',principal=False,
            relative_path=dest.relative_to(ROOT).as_posix(),original_filename=f'{art_id}.png',format=fmt,width=size[0],height=size[1],bytes=dest.stat().st_size,sha256=digest(dest),acquired_at=DATE,
            provenance=[dict(label='Autore',source_url=source_url,asset_url=f'https://openclipart.org/image/2000px/{art_id}',observed_at=DATE),
                dict(label='Manuale',acquired_file_id=34,document_sha256=next(d['sha256'] for d in docs if d['acquired_file_id']==34),page=3,role='fonte del collegamento artwork',coordinates=None)],
            credits=credit,conditions=dict(status='verificate per artwork sorgente',license='CC0 1.0, dichiarazione fonte Openclipart',source_url='https://openclipart.org/share',verified_at=DATE,scope='Artwork sorgente: copia/riuso/modifica; non esteso alla composizione del gioco; binario locale fuori Git'),
            occurrences=[],relationships=[],comparison_to_material='Figura riconosciuta nel tabellone locale; nessuna equivalenza byte o revisione dichiarata' if art_id!=293199 else 'PDF usa pesci recolorati/orientati diversamente; equivalenza tecnica non attestata',
            extraction=None))
    # Ogni documento verificato resta immutato. Il vecchio purpose ACQ non è una licenza.
    for d in docs:
        assert digest(ROOT/'library'/d['relative_path'])==d['sha256']
        d['img_conditions']={'status':'da chiarire per estrazione composizioni','basis':'Manifest ACQ ammette copia personale, non registra permesso specifico di estrazione; nessuna licenza generale trovata nella ricerca testuale PDF','verified_at':DATE,'ai_use':'non autorizzato/non eseguito'}
    sources['documents']=docs
    SOURCE.write_text(json.dumps(sources,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
    manifest=dict(manifest_version=1,task_id='TSK-0068',scope=dict(contest_id=14,series_id=10,year=2025,contest_code='CF',authorized_game_ids=[g['game_id'] for g in games],whole_contest=False),
        checked_at=DATE,state='incremento parziale; ricerca non conclusa',source_manifest=SOURCE.relative_to(ROOT).as_posix(),games=games,images=images,components=[],
        references=[dict(source_url='https://boardgamegeek.com/terms',observed_at=DATE,status='Condizioni da chiarire',sections=['5(E)','6','6(B)(iv)','6(E)'],summary='Uso dei contributi legato alle funzionalità del sito; copie ristrette; clausola sui dati per AI/LLM. Nessuna autorizzazione generale a raccolta immagini attestata.')],
        extraction_pilot=dict(game_id=505,status='ispezione e confronto svolti; componenti non adottati',local_evidence='outputs/tsk0068/pilot/',method='pypdf oggetti raster e pdftoppm render pagina 1 file 33',
            finding='Oggetti PDF possono essere maschere o gruppi di artwork, non componenti interi. Necessaria verifica del rendering. Quattro artwork sorgente superiori acquisiti; nessun ritaglio inferiore equivalente adottato.',
            residual='Coordinate/componenti/lati/dorso e selezione revisioni ancora da collaudare dopo verifica condizioni'),
        app_handoff=dict(task_id='TSK-0067',prerequisite_complete=False,review_required=['contratto manifest sperimentale','38 documenti verificati','ricerca per categoria parziale, nessuna assenza attestata','condizioni per composizioni e BGG','componenti/lati/occorrenze e revisioni non implementati','crediti artwork distinti dai designer','nessuna conversione automatica artwork in Icona/Titolo-Grafico']))
    OUT.write_text(json.dumps(manifest,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
    for i in images:
        p=ROOT/i['relative_path'];assert p.stat().st_size==i['bytes'] and digest(p)==i['sha256']
    assert len({i['image_id'] for i in images})==4
    assert len({g['game_id'] for g in games})==14
    print(json.dumps({'pdf_verified':38,'games_reconciled':14,'original_artworks':4,'research_complete':0,'component_extractions_adopted':0,'manifest':OUT.relative_to(ROOT).as_posix()}))

if __name__=='__main__':
    main()
