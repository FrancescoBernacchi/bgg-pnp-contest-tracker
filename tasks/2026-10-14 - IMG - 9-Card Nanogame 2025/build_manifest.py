"""Offline, reviewed IMG batch; preserves original ACQ and remote bytes."""
import json,hashlib,re,unicodedata,shutil
from pathlib import Path
from collections import Counter,defaultdict
from PIL import Image
import pypdfium2 as pdfium
R=Path(__file__).resolve().parents[2];O=R/'outputs/tsk0088';DATE='2026-10-14'
M=R/'catalog/2025_nine_card_images_2026-10-14.json';S=R/'catalog/2025_nine_card_image_sources_2026-10-14.json'
data=json.loads((O/'component-candidates.json').read_text(encoding='utf-8'));D=data['documents'];G=json.loads((O/'materials-private.json').read_text(encoding='utf-8'))['games'];E=json.loads((O/'browser-evidence.json').read_text(encoding='utf-8'));V=json.loads((O/'remote/browser-evidence-verified.json').read_text(encoding='utf-8'));F=json.loads((O/'figure-candidates.json').read_text(encoding='utf-8'))
games={g['game_id']:g for g in G};images=[];components=[];bykey={};remote={};counts=Counter();dedup={};references=[]
def slug(s):return re.sub(r'[^A-Za-z0-9-]+','-',unicodedata.normalize('NFKD',s).encode('ascii','ignore').decode()).strip('-')
def occurrence(r):return {k:r[k] for k in ('acquired_file_id','document_sha256','page','rectangle','coordinate_system')}
def credits(gid):
 g=games[gid];return [dict(name=g.get('wip_post_author','non dichiarato'),role='Autore del post WIP; altri ruoli non inferiti',source_url=g['wip_thread_url'],verified_at=DATE)]
def add(gid,path,category,label,provenance,occurrences=None,subtype=None,side=None,adopt=True,extra=None,folder='estratti',semantic=None):
 path=Path(path);sha=hashlib.sha256(path.read_bytes()).hexdigest();key=(gid,semantic or sha)
 if key in dedup:
  i=dedup[key];i['provenance'].extend(p for p in provenance if p not in i['provenance']);i['occurrences'].extend(p for p in (occurrences or []) if p not in i['occurrences']);return i
 counts[gid]+=1;num=counts[gid];g=games[gid];fmt=Image.open(path).format;ext={'JPEG':'jpg','PNG':'png','WEBP':'webp'}[fmt];size=Image.open(path).size
 catname=category+('-'+subtype if subtype else '')+('-'+side if side else '');prov=provenance[0]['label'];name=f'{slug(g["title"])}__9C-2025__{slug(catname)}__{slug(prov)}__{num:03d}__v01.{ext}'
 dest=R/'library/immagini'/f'{gid}__{slug(g["title"])}'/folder/name;dest.parent.mkdir(parents=True,exist_ok=True)
 if dest.exists():assert hashlib.sha256(dest.read_bytes()).hexdigest()==sha
 else:shutil.copy2(path,dest)
 i=dict(image_id=f'IMG-{gid}-{num:04d}',game_id=gid,entry_id=gid,contest_id=13,series_id=8,title=g['title'],asset_title=label,category=category,additional_categories=[],subtype=subtype,side=side,component_ids=[],version='v01',material_version='Revisione dichiarata nella provenienza; nessuna equivalenza inferita dal download',current_use='adottata' if adopt else 'non adottata',validation_state='not_required',principal=False,relative_path=dest.relative_to(R).as_posix(),original_filename=path.name,format=fmt,width=size[0],height=size[1],bytes=path.stat().st_size,sha256=sha,acquired_at=DATE,provenance=provenance,occurrences=occurrences or [],relationships=[],credits=credits(gid),credits_status='Crediti dell’illustrazione/fotografia non dedotti dal designer; lacune conservate',conditions=dict(status='copia locale personale; nessuna redistribuzione o uso AI attestato',license='Diritti riservati salvo dichiarazione specifica nella provenienza',source_url=provenance[0].get('source_url'),checked_at=DATE,publication_allowed=False),visual_verification='Contact sheet + confronto con pagina/materiale, TSK-0088')
 if occurrences:i['extraction']={**occurrences[0],'method':(extra or {}).get('method','ritaglio fedele della regione visibile')}
 if extra:i.update(extra)
 images.append(i);dedup[key]=i;return i
def docprov(r,label='PnP'):
 d=D[r['doc_index']];return dict(label=label,source_url=d['source_url'],asset_url=d['resource_url'],observed_at=DATE,original_document_filename=d['original_filename'],**occurrence(r))
cover={401:[8683378],412:[8750647,8750630],416:[8644581,8918507],420:[8848484],422:[8804626],428:[8755049],429:[8728763,8728741,8728740,8728768],449:[8751180],455:[8826940]}
logos={398:[8751533,8828886,8828885,8828884,8828883],404:[8684420],406:[8717130],408:[8712304,8830710],421:[8715703],437:[8685106],452:[8692832],455:[8748110]}
details={396:[8706488],408:[8737139,8737140],416:[8838738],420:[8833450],421:[8855504],422:[8833458],428:[8835278]}
diagrams={398:[8760246,8760273,8760293],404:[8830945,8830946,8703795,8830943,8830941,8830947],420:[8741296,8754144],429:[8735581,8735602]}
components_views={396:[8706489,8799401],401:[8793066,8793065],404:[8830942,8830944,8703796,8703879,8710938,8693682],406:[8806877],416:[8811591],420:[8818424,8736697,8753855,8763922],421:[8715634,8716047],422:[8804627,8810366,8846538,8830285],428:[8794298,8817248,8776072],437:[8821706],452:[8885211],455:[8748145,8817499]}
prep={396:[8706042,8705004,8689136],401:[8703221,8703222],420:[8754085],421:[8740876],452:[8715422,8734354,8755113]}
notadopted={396:{8758221,8689136},406:{8856895,8859488},421:{8807938},428:{8801378},455:{8910385}}
special={396:{8692309:'Grafica della confezione',8758221:'Annotazione proposta sulla carta: riferimento storico'},406:{8717123:'Presentazione del gioco',8829277:'Presentazione contest-ready',8856895:'Proposta grafica del partecipante; adozione non dimostrata',8859488:'Proposta grafica completa; adozione non dimostrata'},404:{8703794:'Illustrazione della roccia'},421:{8807938:'Fotografia di simboli: pertinenza al gioco non confermata'},428:{8801378:'Proposta di mappa: AI e pennellate dichiarate, adozione non dimostrata'},455:{8910385:'Proposta manoscritta di disposizione, non componente ufficiale'}}
same_cover={8728741:'pigeon-cover',8728740:'pigeon-cover',8728768:'pigeon-cover',8728763:'pigeon-cover',8735581:'pigeon-solo-diagram',8735602:'pigeon-solo-diagram'}
# Superior equivalent first; all other occurrences retain their source URLs.
for v in sorted(V,key=lambda v:(v['game_id'],-v['size'][0]*v['size'][1])):
 gid=v['game_id'];ident=v['id'];cat='Partita'
 for mapping,category in [(cover,'Copertina'),(logos,'Titolo-Grafico'),(details,'Dettaglio'),(diagrams,'Diagramma'),(components_views,'Componenti'),(prep,'Preparazione')]:
  if ident in mapping.get(gid,[]):cat=category
 if ident in (8862902,8862903,8862904):cat='Componente'
 if ident in (8692309,8717123,8829277):cat='Copertina'
 if ident in (8703794,8801378,8910385,8856895,8859488):cat='Artwork'
 p=dict(label='BGG-WIP' if any(x['game_id']==gid and any(str(ident) in str(y) for y in x.get('images',[])) for x in E['scans']) else 'Autore',source_url=v['page'],asset_url=v['url'],observed_at=DATE,license_observed=v.get('license'),image_id_bgg=ident,access_basis='Collegamento Original esposto dalla pagina pubblica, senza autenticazione',chain=[games[gid]['wip_thread_url']])
 raw=v.get('title') or '';lines=[x.strip() for x in raw.splitlines() if x.strip()];uploader=next((x for x in lines if x.startswith('@')),None)
 label=special.get(gid,{}).get(ident,f'{cat} del gioco — immagine BGG {ident}')
 extra={'bgg_image_id':ident,'material_revision_status':'unknown','material_revision_evidence':'Versione della fotografia non equiparata alla revisione dei file PnP'}
 if ident in notadopted.get(gid,set()):extra['non_adoption_reason']=label
 if gid==421:extra['source_ai_declared']='L’autore dichiara artwork base Midjourney nel WIP; acquisizione da fonte, nessuna generazione AI in questo task'
 if ident==8801378:extra['source_ai_declared']='Proposta con AI e pennellate dichiarate dall’autore del contributo; nessuna generazione in questo task'
 im=add(gid,v['path'],cat,label,[p],subtype='Carta' if cat=='Componente' else None,side='Fronte' if cat=='Componente' else None,adopt=ident not in notadopted.get(gid,set()),extra=extra,folder='originali',semantic=same_cover.get(ident))
 if uploader:
  cr=dict(name=uploader,role='Uploader immagine BGG; non equivale a illustratore',source_url=v['page'],verified_at=DATE)
  if cr not in im['credits']:im['credits'].append(cr)
 remote[ident]=im
 if v.get('license'):im['conditions']['license']=v['license']
 if ident==8755049:im['credits'].append(dict(name='wirestock / Freepik',role='Fotografia orangutan dichiarata nella didascalia',source_url=v['page'],verified_at=DATE))
 if gid==429:im['conditions']['material_license_note']='PnP dichiara CC BY-NC-ND 4.0; non estesa automaticamente alle foto dei partecipanti'
revisions={4:'Carte 4.0',5:'Carte 3.0 HQ, contenuto invariato verificato rispetto a 4.0',7:'Carte / regolamento 1.0',9:'Carte v2',13:'Piè pagina V3.2; nome file V2.2 preservato',15:'Post-contest v1.01, formato tarot e quattro alternative divinità',16:'Carte 1.1',19:'Carte 1.09',21:'Carte 1.2 Full Color',25:'Carte 1.3 colore',30:'Carte V2',32:'Carte contest, aggiornamenti WIP aprile 2025',35:'Carte full color contest',38:'Main Cards 1.1',39:'PnP EN contest; due impaginazioni del dorso',46:'Carte FINAL Full Color',49:'PnP 3.0 colore',50:'Color Cards 0314'}
candidate_index={(r['doc_index'],r['page'],r['cell']):r for r in data['candidates']}
for r in data['candidates']:
 n,p,c=r['doc_index'],r['page'],r['cell'];gid=r['game_id']
 if n==5:continue
 # Latest three 9 RIP cards: original standalone version has higher resolution.
 if n==4 and p==1 and c in (3,4,7):
  i=remote[{3:8862902,4:8862904,7:8862903}[c]];i['provenance'].append(docprov(r));i['occurrences'].append(occurrence(r));bykey[(n,p,c)]=i;continue
 original=r
 if n==4 and p==1 and c not in (3,4,7):r=candidate_index[(5,p,c)]
 if n==4 and p==2:r=candidate_index[(5,p,c)]
 common=None
 if n==4 and p==2:common='9rip-common-back'
 if n==7 and p==2 and c not in (6,7):common='cats-common-back'
 if n==16 and p==2 and c!=7:common='for9e-common-back'
 if n==39 and p>1:common='parcel-title-back' if c==4 else 'parcel-map-back'
 if n==46 and p==2 and c!=2:common='babel-hourglass-back'
 if n==50 and p==1 and c in (6,7,8):common='word-player-front'
 prov=[docprov(r)];occ=[occurrence(r)]
 if original is not r:prov.append(docprov(original));occ.append(occurrence(original))
 i=add(gid,R/r['path'],'Componente',f'Carta — faccia {p}, posizione {c+1}',prov,occ,'Carta','Fronte' if (p==1 or n==49 and p==3) else 'Dorso',extra=dict(method=r['method'],rotation_ccw=r.get('rotation_ccw',0),material_version=revisions[n],material_revision_status='current',material_revision_evidence='Confronto tra materiali acquisiti e successione dichiarata nel WIP; dettagli nel rapporto',source_pdf_object=r.get('pdf_object')),semantic=common)
 if n==15:i['side']='Fronte' if p in (1,2,5) else 'Dorso'
 if n==21 and p==1 and c<3:i['source_limitation']='Bordo superiore già limitato dal MediaBox del PDF: nessuna ricostruzione inventata'
 if gid==421:i['source_ai_declared']='Artwork base Midjourney dichiarato dall’autore nel WIP; copia da fonte, non generazione del task'
 if gid==429:i['conditions']['license']='CC BY-NC-ND 4.0, dichiarata nel piè pagina PnP';i['credits'].append(dict(name='Danny Hughes',role='Credito nel PnP; designer e disegnatore non separati nella dichiarazione',source_url=D[n]['source_url'],verified_at=DATE))
 bykey[(n,p,c)]=i
def component(gid,label,front,back=None,kind='Carta',count=1,extra=None):
 num=1+sum(c['game_id']==gid for c in components);cid=f'CMP-{gid}-{num:03d}';c=dict(component_id=cid,game_id=gid,type=kind,label=label,physical_occurrence_count=count,identity_basis='Confronto visivo delle facce e impaginazione di stampa fronte/retro',front_image_id=front['image_id'],material_revision=front.get('material_version'))
 if back:c['back_image_id']=back['image_id'];front['relationships'].append(dict(type='lato_opposto',target_image_id=back['image_id']))
 for i in [front,back]:
  if i and cid not in i['component_ids']:i['component_ids'].append(cid)
 if extra:c.update(extra)
 components.append(c);return c
def mirrorcols(c):return c//3*3+2-c%3
def mirrorrows(c):return (2-c//3)*3+c%3
for n in [4,7,9,13,16,19,21,25,30,32,35,38,39,46,49,50]:
 gid=D[n]['game_id'];pf,pb=(3,4) if n==49 else (1,2)
 for c in range(9):
  if n==38 and c==0:continue # cut tokens/tracker are catalogued below, whole sheet region remains preparation context
  backcell=mirrorrows(c) if n in (16,35) else mirrorcols(c)
  component(gid,f'Carta {c+1} — {revisions[n]}',bykey[(n,pf,c)],bykey[(n,pb,backcell)],extra=dict(duplex_basis='Specchio righe: stampa lungo il lato lungo di facce ruotate' if n in (16,35) else 'Specchio colonne; riscontro sulle facce riconoscibili e layout duplex'))
for p in [1,2]:
 for c in range(4):component(406,f'Carta base {4*(p-1)+c+1}',bykey[(15,p,c)],bykey[(15,p+2,c)])
for c in range(4):component(406,f'Divinità alternativa {c+1}',bykey[(15,5,c)],extra=dict(selection_group='Una alternativa scelta, non quattro carte simultanee',back_status='Dorso non presente nel materiale acquisito'))
# Manual figures selected visually: reject pages-as-background, clipped captions and redundant card examples.
selected=['08-p1-f00','08-p2-f00','08-p3-f00','08-p3-f01','10-p2-f00','10-p3-f00','10-p3-f01','10-p3-f02','12-p1-f01','12-p1-f02','12-p2-f00','12-p2-f01','12-p2-f03','12-p2-f04','12-p2-f05','12-p3-f00','12-p3-f03','12-p3-f04','12-p3-f05','12-p3-f06','12-p4-f00','12-p4-f01','12-p4-f02','12-p5-f00','12-p5-f01','12-p5-f02','12-p5-f03','12-p5-f04','12-p5-f05','12-p5-f07','12-p6-f00','12-p6-f01','12-p6-f02','12-p6-f03','12-p6-f04','12-p6-f05','14-p2-f00','14-p3-f00','14-p4-f00','14-p5-f00','14-p5-f01','14-p6-f00','17-p1-f00','17-p1-f01','17-p1-f02','17-p2-f00','17-p2-f01','20-p1-f01','20-p7-f02','20-p12-f02','26-p6-f08','28-p1-f01','33-p2-f00','37-p7-f00','40-p1-f00','40-p1-f01','40-p1-f02','40-p1-f03','40-p2-f00','40-p2-f01','40-p2-f03','40-p2-f04','40-p3-f00','40-p3-f01']
for r in F:
 if r['key'] not in selected:continue
 cat='Artwork' if r['key'] in ('20-p1-f01','20-p7-f02','20-p12-f02') else 'Icona' if r['key']=='26-p6-f08' else 'Titolo-Grafico' if r['key']=='28-p1-f01' else 'Diagramma'
 add(r['game_id'],R/r['path'],cat,f'{cat} dal regolamento — pagina {r["page"]}, figura {r["key"].split("f")[-1]}',[docprov(r,'Manuale')],[occurrence(r)],extra=dict(material_version=D[r['doc_index']]['original_filename'],method=r['method']))
def extract(n,page,box,label,category,kind=None,side=None,extra=None):
 d=D[n];pdf=pdfium.PdfDocument(str(R/'library'/d['relative_path']));pg=pdf[page-1];scale=300/72;im=pg.render(scale=scale).to_pil().convert('RGB').crop([round(v*scale) for v in box]);pg.close();pdf.close();path=O/'figure-candidates'/f'extra-{n}-{page}-{slug(label)}.png';im.save(path);r=dict(doc_index=n,acquired_file_id=d['acquired_file_id'],document_sha256=d['sha256'],page=page,rectangle=box,coordinate_system='punti PDF, origine alto-sinistra');return add(d['game_id'],path,category,label,[docprov(r)],[occurrence(r)],kind,side,extra=extra)
# Six distinct chip faces from the older unique chip variant; no invented physical pairings.
chip_positions=[(0,0,'Rosso senza numero'),(1,0,'Rosso 2'),(2,0,'Blu 2'),(3,0,'Blu senza numero'),(0,5,'Nero croce'),(2,5,'Grigio senza numero')]
for col,row,label in chip_positions:
 x=[83,195,308,426][col];y=180+row*99.6;i=extract(6,3,[x,y,x+88,y+85],f'Gettone {label}','Componente','Segnalino','Fronte',dict(material_version='Variante Cards and CHip PnP, precedente a carte 4.0',material_revision_status='previous',material_revision_evidence='Variante con gettoni nel file storico, componenti unici non presenti nei file carte 3.0/4.0',opposite_side_status='Associazione fronte/retro non dimostrata; numero di facce stampate distinto dal numero fisico'))
 component(396,label,i,kind='Segnalino',count=None,extra=dict(printed_face_occurrences=2 if row==5 else 5,identity_basis='Disegno distinto del gettone; non dedotti abbinamenti dai soli colori'))
# Cut regions of Particular Pigeons: two tokens and one action tracker, front/back mirrored.
for label,a,b,kind in [('Gettone Hungry / Comfort Food',[27,18,117,144],[513,18,603,144],'Segnalino'),('Gettone Epicurious / A Plus One',[117,18,207,144],[423,18,513,144],'Segnalino'),('Tracciato azioni',[27,144,207,270],[423,144,603,270],'Plancia')]:
 f=extract(38,1,a,label+' fronte','Componente',kind,'Fronte');b=extract(38,2,b,label+' retro','Componente',kind,'Dorso');component(429,label,f,b,kind)
for n in (2,29):
 pdf=pdfium.PdfDocument(str(R/'library'/D[n]['relative_path']));pg=pdf[0];im=pg.render(scale=1).to_pil().convert('RGB');pg.close();pdf.close();import PIL.ImageChops
 box=PIL.ImageChops.difference(im,Image.new('RGB',im.size,'white')).point(lambda p:255 if p>25 else 0).getbbox();extract(n,1,list(box),'Schema completo della scatola da montare','Preparazione')
# Artwork isolated from whole cards, linked to their source image (no reconstruction).
for n,cells in []: # Rejected QA candidates: partial swords/frames; whole cards retained.
 page=1 if n==19 else 2
 for c in cells:
  r=candidate_index[(n,page,c)];x,y,_,_=r['rectangle'];box=[x+15,y+35,x+165,y+100] if n==19 else [x+45,y+48,x+135,y+128]
  i=extract(n,page,box,f'Illustrazione della carta {c+1}','Artwork');i['relationships'].append(dict(type='estratta_da',target_image_id=bykey[(n,page,c)]['image_id']))
# Source credits: role-scoped, never assign photograph credit to a designer.
for i in images:
 if i['game_id']==408 and i['category'] in ('Componente','Titolo-Grafico','Artwork'):i['credits'].append(dict(name='Vova Semeniv',role='Artwork dichiarato nel WIP FOR9E',source_url=games[408]['wip_thread_url'],verified_at=DATE))
 if i['game_id']==412:i['credits'].append(dict(name='Joem Antonio',role='Design e artwork dichiarati nel WIP',source_url=games[412]['wip_thread_url'],verified_at=DATE))
 if i['game_id']==420 and i['category'] in ('Componente','Icona','Artwork'):
  i['credits'].extend([dict(name='Birgit Röscheisen',role='Disegni carte ancora; adattamento figure Lola',source_url=D[26]['source_url'],verified_at=DATE),dict(name='Christian Mohr',role='Figure Lola originali, adattate dall’autrice',source_url=D[26]['source_url'],verified_at=DATE),dict(name='Noun Project',role='Icone dichiarate con permesso; persone non specificate',source_url=D[26]['source_url'],verified_at=DATE),dict(name='idefix; kidhacks; MinGyu Jung; Pexels; Lothar Dieterich',role='Foto Pixabay rispettivamente razza, tartaruga, medusa, pesci, kraken: ruoli contestuali, non autori di tutte le carte',source_url=D[26]['source_url'],verified_at=DATE)])
# Principal selection favors recognizable cover/title, independent from acquisition count.
for gid in games:
 choice=next((i for cat in ('Copertina','Titolo-Grafico','Componenti','Partita') for i in images if i['game_id']==gid and i['category']==cat and i['current_use']=='adottata'),None)
 if choice:choice['principal']=True
categories=['Copertina','Titolo-Grafico','Artwork','Icona','Setup','Partita','Componenti','Componente','Dettaglio','Diagramma','Preparazione']
observations=[]
for gid,g in games.items():
 scans=[s for s in E['scans'] if s['game_id']==gid];gallery=[s for s in E['galleryScans'] if s.get('game_id')==gid and s.get('url')]
 # Tower of Babel shares the same author's observed gallery with Into the Arcanum.
 if gid==449:gallery=[s for s in E['galleryScans'] if s.get('game_id')==416 and s.get('url')]
 cats=[]
 for cat in categories:
  count=sum(i['game_id']==gid and i['category']==cat and i['current_use']=='adottata' for i in images);cats.append(dict(category=cat,research='conclusa nel perimetro osservato; limiti nel record del gioco',research_complete=True,applicability='applicabile' if count else 'desiderata' if cat in ('Titolo-Grafico','Artwork','Icona') else 'non determinata',adopted_original_count=count,validated_ai_count=0,pending_ai_count=0,verified_absence=False,absence_scope='Nessuna assenza universale attestata; zero non equivale a inesistenza'))
 observations.append(dict(game_id=gid,entry_id=gid,contest_id=13,title=g['title'],wip_url=g['wip_thread_url'],checked_at=DATE,research_complete=True,research_status='conclusa nel perimetro osservabile con limiti espliciti',acquired_file_ids=[d['acquired_file_id'] for d in D if d['game_id']==gid],categories=cats,sources_reviewed=[dict(url=s['url'],kind='WIP',post_count=s.get('post_count'),total=s.get('total')) for s in scans]+[dict(url=s['url'],kind='galleria autore',pagination=s.get('pagination')) for s in gallery],residuals=['Perimetro: WIP completo e aggiornamenti, pagine/gallerie autore effettivamente osservate, materiali ACQ già disponibili; non censimento del web né delle intere gallerie pluricontest.','Pagine gioco BGG non risolte dove il collegamento era dinamico; nessun URL inventato. TGC/Drive/TTS/PlayingCardsIO non trattati come autorizzazione a nuovi pacchetti o software.','Nessuna nuova scansione autonoma del thread generale contest o del roster; contesto e identità dal catalogo preesistente.','Crediti e diritti della fotografia distinti da quelli del gioco; lacune non colmate per inferenza.'],material_revisions={str(n):revisions[n] for n in revisions if D[n]['game_id']==gid},credits=credits(gid)))
for s in E['scans']:
 for ref in s.get('images',[]):
  text=str(ref);match=re.search(r'(?:/image/|pic)(\d+)',text)
  if not match:continue
  ident=int(match.group(1));references.append(dict(game_id=s['game_id'],source_url=s['url'],image_url=f'https://boardgamegeek.com/image/{ident}',checked_at=DATE,outcome='Acquisita' if ident in remote else 'Solo riferimento',reason='Originale e provenienze nel manifest' if ident in remote else 'Revisione/proposta storica, esempio equivalente ai materiali locali o pertinenza non dimostrata; nessuna assenza inferita',image_id=remote[ident]['image_id'] if ident in remote else None))
manifest=dict(manifest_version=1,task_id='TSK-0088',checked_at=DATE,scope=dict(contest_id=13,series_id=8,year=2025,contest_code='9C',authorized_game_ids=sorted(games),whole_contest=False),source_manifest=S.relative_to(R).as_posix(),state='17 giochi ACQ completi: ricerca immagini conclusa nel perimetro dichiarato, con limiti',games=observations,images=images,historical_files=[],components=components,references=references)
sources=dict(task_id='TSK-0088',contest_id=13,series_id=8,checked_at=DATE,documents=[{k:d[k] for k in ('game_id','entry_id','acquired_file_id','relative_path','sha256','byte_size','source_url','resource_url','original_filename')} for d in D])
M.write_text(json.dumps(manifest,ensure_ascii=False,indent=2),encoding='utf-8');S.write_text(json.dumps(sources,ensure_ascii=False,indent=2),encoding='utf-8')
summary=dict(remote_original_files=len(V),catalogued_images=len(images),adopted=sum(i['current_use']=='adottata' for i in images),not_adopted=sum(i['current_use']!='adottata' for i in images),extracted=sum('/estratti/' in i['relative_path'] for i in images),components=len(components),games=len(games),by_game={str(gid):dict(images=sum(i['game_id']==gid for i in images),adopted=sum(i['game_id']==gid and i['current_use']=='adottata' for i in images)) for gid in games})
(O/'batch-summary.json').write_text(json.dumps(summary,ensure_ascii=False,indent=2),encoding='utf-8');print(json.dumps(summary))
