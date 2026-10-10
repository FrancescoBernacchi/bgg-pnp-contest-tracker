"""Prepare faithful IMG files for existing identities; no network, DB or Git writes."""
from pathlib import Path
import json,hashlib,shutil,copy
from PIL import Image,ImageChops,ImageDraw
import pdfplumber
R=Path(__file__).resolve().parents[2];O=R/'outputs/tsk0068/two-2026-10-10';DATE='2026-10-11'
OLD=R/'catalog/2025_children_family_images_2026-10-05.json';DEST=R/'catalog/2025_children_family_images_2026-10-11.json'
assert not DEST.exists(),'Increment already produced; do not overwrite'
m=json.loads(OLD.read_text(encoding='utf8'));oldimages=copy.deepcopy(m['images']);oldcomponents=copy.deepcopy(m['components'])
docs=json.loads((R/m['source_manifest']).read_text(encoding='utf8'))['documents'];D={d['acquired_file_id']:d for d in docs}
for d in docs:
 p=R/'library'/d['relative_path'];assert p.stat().st_size==d['byte_size'] and hashlib.sha256(p.read_bytes()).hexdigest()==d['sha256']
titles={500:('Poker Face','Poker-Face'),498:("Sorry! That's My Dungeon",'Sorry-Thats-My-Dungeon')}
wips={500:'https://boardgamegeek.com/thread/3465191',498:'https://boardgamegeek.com/thread/3442526'}
authorpage='https://alexandrecamargo.itch.io/sorry-thats-my-dungeon';downloads=json.loads((O/'remote/downloads.json').read_text(encoding='utf8'));remote={Path(x['path']).name:x for x in downloads}
new=[];hist=[]
def add(g,n,src,cat,label,asset,doc=None,page=None,box=None,cmp=None,subtype=None,history=False):
 slug=titles[g][1];ext=Path(src).suffix.lower();ext='.jpg' if ext=='.jpeg' else ext
 folder=R/f'library/immagini/{g}__{slug}';sub='originali' if label in ('BGG-WIP','Autore') else 'estratti'
 naming=cat+('-'+subtype+'-Fronte' if subtype=='Carta' else '-'+subtype if subtype else '')
 target=folder/sub/f'{slug}__CF-2025__{naming}__{label}__{n:03d}__v01{ext}'
 target.parent.mkdir(parents=True,exist_ok=True);assert not target.exists();shutil.copyfile(src,target)
 with Image.open(target) as im:fmt=im.format;width,height=im.size;im.verify()
 prov=[];occ=[];ex=None
 if doc:
  d=D[doc];prov=[{'label':label,'source_url':d['resource_url'],'acquired_file_id':doc,'document_sha256':d['sha256'],'page':page,'rectangle':box,'coordinate_system':'pixel nativi oggetto PDF, origine alto-sinistra' if box else 'oggetto raster intero; geometrie pagina nelle occorrenze','observed_at':DATE}]
  ex={'method':'oggetto raster nativo intero verificato' if not box else 'ritaglio fedele oggetto raster nativo verificato','source_document_id':doc,'source_document_sha256':d['sha256'],'native_pixel_rectangle':box,'dpi':None}
  occ=[{'document_id':doc,'document_sha256':d['sha256'],'page':page,'rectangle':box,'coordinate_system':prov[0]['coordinate_system']}]
 else:
  row=remote[Path(src).name];bgg=Path(src).stem.startswith('pic');id=Path(src).stem[3:] if bgg else None
  prov=[{'label':label,'source_url':'https://boardgamegeek.com/image/'+id if bgg else authorpage,'asset_url':row['url'],'observed_at':DATE}]
 credits=[{'name':'Istivano' if g==500 else 'Alexandre Camargo','role':'Designer','source_url':wips[g],'verified_at':DATE}]
 if g==498:credits.append({'name':'Alexandre Camargo','role':'Artist','source_url':wips[g],'verified_at':DATE,'basis':'Designer/Artist dichiarato nel WIP e nella entry; ruoli distinti'})
 item={'image_id':f'IMG-{g}-{n:04d}','game_id':g,'entry_id':g,'contest_id':14,'series_id':10,'title':titles[g][0],'asset_title':asset,'category':cat,'additional_categories':[],'subtype':subtype,'side':'Fronte' if subtype else None,'component_ids':[cmp] if cmp else [],'version':'v01','material_version':D[doc]['version_raw'] if doc else None,'current_use':'superata' if history else 'adottata','validation':'Originale verificata visivamente '+DATE,'principal':False,'relative_path':target.relative_to(R).as_posix(),'original_filename':D[doc]['original_filename'] if doc else Path(src).name,'format':fmt,'width':width,'height':height,'bytes':target.stat().st_size,'sha256':hashlib.sha256(target.read_bytes()).hexdigest(),'acquired_at':DATE,'provenance':prov,'credits':credits,'credits_status':'Designer verificato; illustratore non dichiarato' if g==500 else 'Designer/Artist dichiarato; fotografo non dichiarato, uploader separato','conditions':{'status':'Uso locale privato IMG autorizzato dall’utente','source_url':D[doc]['resource_url'] if doc else prov[0]['source_url'],'checked_at':DATE,'license':'All rights reserved osservato su BGG; nessuna licenza aperta estesa' if label=='BGG-WIP' else 'Nessuna licenza aperta osservata; non prova di divieto alla sola copia privata','rights_scope':'Consultazione privata/estrazione fedele; nessuna redistribuzione o input AI','publication_allowed':False},'occurrences':occ,'relationships':[],'extraction':ex}
 (hist if history else new).append(item);return item
# Poker: remote title; smaller isolated art stays immutable historical.
logo=add(500,1,O/'remote/pic8730519.png','Titolo-Grafico','BGG-WIP','Titolo grafico Poker Face')
native_logo=Image.open(O/'native21-1-0.png').convert('RGBA');net_logo=Image.open(O/'remote/pic8730519.png').convert('RGBA')
assert native_logo.size==net_logo.size
logo['comparison_to_material']='Stesso contenuto grafico e dimensioni nel manuale locale; encodifica/hash diversi, confronto visivo verificato'
logo['provenance'].append({'label':'Manuale','source_url':D[21]['resource_url'],'acquired_file_id':21,'document_sha256':D[21]['sha256'],'page':1,'rectangle':[73.5,30.75,541.49997,225.75],'coordinate_system':'punti PDF, origine alto-sinistra','observed_at':DATE})
loweye=add(500,2,O/'remote/pic8730527.png','Artwork','BGG-WIP','Espressione occhi al cielo, sorgente BGG',history=True)
names=['bacio','lingua','rabbia','occhi-al-cielo','sorriso','pianto','occhiolino','ok']
with pdfplumber.open(R/'library'/D[20]['relative_path']) as pdf:
 for j,name in enumerate(names):
  cmp=f'CMP-500-{name}';i=add(500,j+3,O/f'native20-1-{j}.png','Componente','PnP',name,20,1,cmp=cmp,subtype='Carta')
  rect=pdf.pages[0].images[j];i['provenance'][0]['rectangle']=[rect[k] for k in ['x0','top','x1','bottom']];i['provenance'][0]['coordinate_system']='punti PDF, origine alto-sinistra, rotazione zero';i['occurrences'][0].update(rectangle=i['provenance'][0]['rectangle'],coordinate_system=i['provenance'][0]['coordinate_system'])
  m['components'].append({'component_id':cmp,'game_id':500,'type':'Carta','label':name,'material_revision':D[20]['version_raw'],'front_image_id':i['image_id'],'back_image_id':None,'physical_occurrence_count':1,'identity_basis':'una carta distinta sul foglio; otto copie del foglio prescritte separatamente, quantità per modalità nel manuale','print_multiplier':8,'required_counts_by_mode':{'Poker Face':6,'Face Match':4,'This Is My Face':4}})
  bounds=(318,611,1096,1389) if j!=7 else (284,611,1124,1389)
  art=add(500,j+11,O/f'poker-art{j}.png','Artwork','PnP','Espressione '+name,20,1,list(bounds));art['relationships'].append({'type':'estratta_da_immagine','target_image_id':i['image_id']});art['provenance'][0]['pdf_object']=rect['name']
  if j==3:loweye['relationships'].append({'type':'variante_superata','target_image_id':art['image_id']});loweye['supercession_reason']='stesso artwork verificato visivamente, estrazione 778x778 migliore del remoto 512x512; originale remoto preservato'
# Sorry: lower-res copies and old-board setup retained as history, not current coverage.
lo=[]
for n,file,cat in [(1,'pic8652577.jpg','Copertina'),(2,'pic8652589.jpg','Componenti'),(3,'pic8652590.jpg','Setup')]:lo.append(add(498,n,O/'remote'/file,cat,'BGG-WIP','Foto '+cat+' BGG',history=True))
lo[1]['provenance'].append({'label':'BGG-Galleria','source_url':'https://boardgamegeek.com/image/8682626/deslexo','asset_url':remote['pic8682626.jpg']['url'],'observed_at':DATE});lo[1]['deduplication_basis']='SHA-256 identico per ID 8652589 e 8682626; una sola copia'
title=add(498,4,O/'remote/gXpJRQ.jpg','Titolo-Grafico','Autore','Titolo grafico Sorry! That’s my dungeon')
oldsetup=add(498,5,O/'remote/grG6SC.jpeg','Setup','Autore','Foto setup con tabellone precedente',history=True)
cover=add(498,6,O/'remote/uv%2Fg6I.jpeg','Copertina','Autore','Foto confezione')
overview=add(498,7,O/'remote/EJvkIX.jpeg','Componenti','Autore','Tabellone e componenti in confezione')
for low,hi in zip(lo,[cover,overview,oldsetup]):
 low['relationships'].append({'type':'variante_superata','target_image_id':hi['image_id']});low['supercession_reason']='stessa foto verificata, preferita copia autore 1536x2048 rispetto BGG 347x462'
oldsetup['supercession_reason']='foto del tabellone precedente con corridoi verso il centro e diversa sala centrale; confronto PDF corrente, foto corrente e changelog autore 2024-11-08/21; data esatta foto non inferita'
boardcmp='CMP-498-board';board=add(498,8,O/'native18-1-0.png','Componente','PnP','Tabellone completo',18,1,cmp=boardcmp,subtype='Tabellone');board['additional_categories']=['Diagramma'];board['occurrences']=[]
with pdfplumber.open(R/'library'/D[18]['relative_path']) as pdf:
 for n,pg in enumerate(pdf.pages):
  rect=pg.images[0];board['occurrences'].append({'document_id':18,'document_sha256':D[18]['sha256'],'page':n+1,'pdf_object':rect['name'],'rectangle':[rect[k] for k in ['x0','top','x1','bottom']],'page_bbox':list(pg.bbox),'coordinate_system':'punti PDF pdfplumber, origine alto-sinistra MediaBox; offset non nullo conservato; regione oggetto oltre pagina'})
board['deduplication_basis']='oggetto X4, stessi bytes/hash e 2000x2000 su tutte le quattro pagine; render delle quattro porzioni confrontati con oggetto intero';board['relationships'].append({'type':'versione_corrente_rispetto_storico','target_image_id':oldsetup['image_id']})
m['components'].append({'component_id':boardcmp,'game_id':498,'type':'Tabellone','label':'Tabellone','material_revision':D[18]['version_raw'],'front_image_id':board['image_id'],'back_image_id':None,'physical_occurrence_count':1,'identity_basis':'un solo tabellone completo distribuito su quattro pagine, non quattro componenti'})
# Native crops: details of the four colored rooms, six distinct hero illustrations, skull and chest.
boxes=[('Stanza verde','Dettaglio',(478,217,800,544)),('Stanza blu','Dettaglio',(1463,472,1785,798)),('Stanza gialla','Dettaglio',(217,1198,542,1519)),('Stanza rossa','Dettaglio',(1198,1461,1524,1781))]
boxes += [('Eroe '+str(j+1),'Artwork',b) for j,b in enumerate([(797,1290,860,1375),(817,1384,848,1462),(813,1478,858,1542),(802,1552,850,1621),(819,1628,850,1699),(806,1702,855,1780)])]
boxes += [('Teschio','Artwork',(47,58,163,174)),('Forziere','Artwork',(400,55,514,174))]
bim=Image.open(O/'native18-1-0.png')
for n,(name,cat,b) in enumerate(boxes,9):
 src=O/f'dungeon-crop{n}.png';bim.crop(b).save(src);i=add(498,n,src,cat,'PnP',name,18,1,list(b));i['relationships'].append({'type':'estratta_da_immagine','target_image_id':board['image_id']})
 if cat=='Dettaglio':i['additional_categories']=['Artwork']
m['images']+=new;m['historical_files']+=hist
assert m['images'][:len(oldimages)]==oldimages and m['components'][:len(oldcomponents)]==oldcomponents
m['checked_at']=DATE;m['previous_manifest']=OLD.relative_to(R).as_posix();m['state']='in corso: quattro giochi esplorati nel perimetro osservabile con limiti; dieci giochi restanti'
for g in m['games']:
 if g['game_id'] not in (498,500):continue
 gid=g['game_id'];g.update(checked_at=DATE,research_status='conclusa nel perimetro osservabile con limiti',research_complete=True,credits_checked_locally_at=DATE,credits_status='Designer verificato WIP/manuale; ruoli non dichiarati espliciti')
 g['sources_reviewed']=['manifest ACQ e hash 38 PDF','PDF locali e render completi','WIP completo: 9/9 post' if gid==500 else 'WIP completo: 4/4 post','entry GeekList e assenza commenti osservata','thread contest 75/75 post su tre pagine','profilo/galleria autore con limite login','pagina autore itch.io, tre foto e titolo' if gid==498 else 'profilo Istivano e due immagini pertinenti pubbliche']
 g['external_research']={'wip':'verificato completo','updates':'verificati tutti i post','gallery':'galleria profilo richiede login; pagine immagine pubbliche osservate; nessuna pagina gioco BGG direttamente collegata individuata','contest':'75 post /3 pagine + entry','author_publisher':'itch.io direttamente collegato verificato' if gid==498 else 'profilo BGG verificato, nessun sito autore/editore esterno pertinente collegato osservato'}
 g['residuals']=['Galleria autore richiede login; sequenza profilo 27 immagini non enumerata integralmente' if gid==498 else 'Galleria autore richiede login; sequenza profilo 21 immagini non enumerata integralmente','Nessuna licenza di redistribuzione/AI; crediti fotografo/illustratore mancanti ove non dichiarati','Carte/regole/box PDF non presenti nel lotto ACQ: eventuale acquisizione separata, non estratti da foto' if gid==498 else 'WIP/entry dichiarano 64 carte, manuale locale 48/32 per modalità; non correggere dati ACQ/identità; dorso stampabile assente nei file osservati','Nessuna importazione operativa 014 di questo incremento']
 for c in g['categories']:
  count=sum(i['game_id']==gid and (i['category']==c['category'] or c['category'] in i['additional_categories']) for i in m['images']);c.update(research='conclusa nel perimetro osservabile',adopted_original_count=count,verified_absence=count==0,impediment='galleria autore richiede login; assenza limitata alle fonti osservate' if not count else None,residual='Eventuali nuovi PDF solo tramite ACQ' if gid==498 else 'Quantità dichiarate per modalità distinte dalle occorrenze stampate');c['applicability']='applicabile' if count else ('desiderata' if c['category'] in ('Icona','Artwork','Titolo-Grafico') else 'non determinata / nessun asset pertinente osservato')
m['verification']={'checked_at':DATE,'pdf_hashes_verified':38,'current_image_files_verified':len(m['images']),'historical_image_files_verified':len(m['historical_files']),'component_relationships_verified':len(m['components']),'game_research_completed':4,'authorized_games':14,'originals_unchanged':True,'operational_import':'non eseguita; operativo ancora i due piloti'}
m['app_handoff']['review_required'] += ['Manifest cumulativo 2026-10-11 distinto dall’input già importato 2026-10-05; riesame/importazione autorizzata separatamente','Tabellone multi-pagina: singolo oggetto completo e quattro occorrenze oltre MediaBox, non quattro plance','Poker Face: moltiplicatore stampa distinto dalle quantità per modalità, nessun dorso inventato','Foto hi-res/storiche, provenienze BGG/itch e crediti per ruolo; nessun asset da associare dal solo nome']
m.setdefault('pilot_increments',[]).append({'checked_at':DATE,'game_ids':[498,500],'current_images_added':len(new),'historical_files_added':len(hist),'physical_files_added':len(new)+len(hist),'download_urls':10,'distinct_downloaded_originals':9,'extractions_added':29,'research_completed':2,'source_manifest':m['source_manifest']})
DEST.write_text(json.dumps(m,ensure_ascii=False,indent=2)+'\n',encoding='utf8')
contact=Image.new('RGB',(1600,1500),'#ddd');draw=ImageDraw.Draw(contact)
for ix,i in enumerate([i for i in new if i['game_id']==498 and i['extraction']]):
 im=Image.open(R/i['relative_path']).convert('RGB');im.thumbnail((380,420));x=(ix%4)*400;y=(ix//4)*375;contact.paste(im,(x,y+20));draw.text((x,y),i['asset_title'],fill='black')
contact.save(O/'dungeon-extractions-contact.png');print(json.dumps(m['verification']));print('added',len(new),len(hist))
