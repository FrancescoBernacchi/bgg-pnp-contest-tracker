from collections import Counter
from pathlib import Path
from urllib.parse import urlparse

ROOT = Path(__file__).resolve().parents[1]
DATE = "2026-09-11"
CONTEST_ID = 15

ENTRIES = [
    (514,"Archipelago Rebels","3505950","observed"),(515,"BEEP","3508169","observed"),
    (516,"Boom!","3501760","observed"),(517,"Breathless Tango","3495445","observed"),
    (518,"Cuéntame (Tell me)","3505085","observed"),(519,"Deceive to Succeed","3491405","observed"),
    (520,"Delivery Dash","3494616","observed"),(521,"Disturbance at Darkholm Manor","3520521","not_observable"),
    (522,"Don’t Get Snaked!","3487751","observed"),(523,"Finger Twister","3516506","observed"),
    (524,"Flip Fart","3515359","observed"),(525,"Going the Difference!","3509254","observed"),
    (526,"Honeybee and Dragonfly","3491504","observed"),(527,"Hovercraft in a Minefield: Alligator Rescue","3510163","observed"),
    (528,"In the Trench","3495777","observed"),(529,"Know B4 U Go","3520264","observed"),
    (530,"Laced Up","3509555","observed"),(531,"Locky Dice","3495217","observed"),
    (532,"Lucky Words","3491766","observed"),(533,"Matching Socks","3494402","observed"),
    (534,"The Moving Fortress","3489442","none_declared"),(535,"Nap & Roll","3440820","observed"),
    (536,"One Card Battle","3512843","observed"),(537,"One Card Guard","3489141","observed"),
    (538,"One Intersection","3511086","observed"),(539,"Pass the Dice","3493787","observed"),
    (540,"The Peak","3512510","observed"),(541,"Piece of Cake","3512039","observed"),
    (542,"Rabbit Race","3505789","observed"),(543,"Saltatorial","3517033","observed"),
    (544,"Self Service","3516181","observed"),(545,"Shadow Heist","3513986","observed"),
    (546,"Ship Under Sabotage","3488497","observed"),(547,"Sliminal Pursuit","3513981","observed"),
    (548,"Some Strings Attached","3512037","observed"),(549,"Way of the Goose","3510065","observed"),
    (550,"Wobbly Bridge","3503056","observed"),(551,"Zombie Apocalypse","3514360","none_declared"),
]

RESOURCES=[]
def add(entry,role,form,context,*pairs):
    for url,label in pairs: RESOURCES.append((entry,url,role,form,label,context))

add(514,"game_files","folder","Cartella PDF versione 1.2.",( "https://drive.google.com/drive/folders/1T79Nx9oFPAMizHHwE1bYM5cU1AO8LCSn","PDF files: V1.2"))
add(515,"game_files","document","Gioco PnP e regole nello stesso documento.",( "https://docs.google.com/document/d/1M0kV2mZoObEAuRySrhesbO4_-8tvdWUkWLWanleHnPI/edit?usp=sharing","PnP Game & Rules"))
add(516,"game_files","folder","Regole e carta correnti.",( "https://drive.google.com/drive/folders/1ca8RvdogxImjQwrky-Ha93ExMwqk47gL?usp=drive_link","Download the current Rules and Cards here"))
add(517,"video","video","Video di gameplay.",( "https://www.youtube.com/watch?v=orujXqk_PG0","here"))
add(517,"game_files","folder","File PnP.",( "https://drive.google.com/drive/folders/1hDMkEfZBeGyG8GIqj1CoGrOMlN6am6Yg?usp=drive_link","here"))
add(518,"online_tool","web_app","Dadi virtuali e annotazione degli elementi.",( "https://piliapp.com/random/dice/?num=2","Here"))
add(518,"component","file","Carta versione 1.0.",( "https://www.dropbox.com/scl/fi/i9lhhgjs8xs0z0t3h7eww/1C-Cuentame.pdf?rlkey=2iczuv091ycim0yx98pziq18w&st=27hy5m37&dl=0","Here/Aquí V.1.0"))
add(518,"component","file","Carta versione 2.0.",( "https://www.dropbox.com/scl/fi/ske6o4x2mnhfgq668abkv/1C-Cuentame.V2.pdf?rlkey=5h6mzcxbt0h0sr2z99rzm8ix6&st=iiqf9qp4&dl=0","Here/Aquí V.2.0 New!"))
add(518,"rules","file","Regole inglesi.",( "https://www.dropbox.com/scl/fi/2639ivg5yssibl7cye0pv/Cuentame-R-Eng.pdf?rlkey=uiqay8qop565b33b8lsgyd4fe&st=uukbhc76&dl=0","Here New!"))
add(518,"rules","file","Regole spagnole.",( "https://www.dropbox.com/scl/fi/lylzc5g6sx7y9cb8tv731/Cuentame-R-Esp.pdf?rlkey=j6t1k43721rsaujul3zzk4esu&st=e7zupzhn&dl=0","Aquí ¡Nuevo!"))
add(519,"rules","document","Regolamento pubblicato.",( "https://docs.google.com/document/d/e/2PACX-1vSYENqaXdFY6rTrmR2C5DCXVS8lDR-iKXJX5R1TGYh3MVEC8AzJ81h0vXxslewttCl_QCXnIntGxMeH/pub","Rulebook"))
add(519,"component","file","Carta PnP.",( "https://drive.google.com/file/d/1p6_amyTLmyGlst4xUKpZ0KtkjmOY9spn/view?usp=sharing","PnP Card"))
add(520,"rules","document","Regolamento.",( "https://docs.google.com/document/d/1-mDsIbIs8pqr0fIK3tyAlqKT6Fb5lHBpG769izjCEIg/edit?usp=sharing","Rules"))
add(520,"component","file","Carta camion PnP.",( "https://drive.google.com/file/d/1VmMt9kSVe7QDNDgOMqIgv9zir55srpXS/view?usp=share_link","PNP Truck Card"))
add(520,"component","file","Foglio punteggio.",( "https://drive.google.com/file/d/1yF7ZnY3GuGfnw1IjdaDY4NT5XZUlyTyU/view?usp=share_link","Score Sheet"))
add(522,"rules","document","Regole di gioco.",( "https://docs.google.com/document/d/14FtC-Dbi-HaKIJY9soE2COvX71u10-YhK78GBrvs_Xw/edit?usp=sharing","Game Rules"))
add(522,"component","file","Carta di gioco.",( "https://drive.google.com/file/d/17xGz8zyVjywGJJwxGtRdRGhX0DV_V_wg/view?usp=sharing","Game Card"))
add(523,"component","file","File PnP ancora etichettato col titolo storico Operation D-2.",( "https://drive.google.com/open?id=1zcptfvhv41OlFuvqVzYIjSixTEsWE43p&usp=drive_fs","Operation D-2 - Print and Play"))
add(523,"rules","document","Regole inglesi.",( "https://docs.google.com/document/d/1cDvHG50SL38WdDQIWe0BU8CQ6rkeMK0-19P2ZgI0G9Y/edit?usp=sharing","Finger Twister - Rulebook English"))
add(523,"rules","document","Regole spagnole.",( "https://docs.google.com/document/d/163DXgmMSj-N3U1OT2F8QjvFR-S6aKnfdWtv9DZHEk8Q/edit?usp=sharing","Finger Twister - Reglamento Español"))
shared="https://drive.google.com/drive/folders/1bvVcv7bXpdr1QTW9GyVfnuWKQm6tPyon?usp=sharing"
add(524,"game_files","folder","Cartella condivisa dichiarata dall'autore.",(shared,"https://drive.google.com/drive/folders/1bvVcv7bXpdr1QTW9GyVf..."))
add(525,"game_files","document","Regole e carta correnti.",( "https://docs.google.com/document/d/1QQJOl-lOGMWpDmWYyiuWakDvgIH0nKomaqkOcsbicBA/edit?tab=t.0","Download the current Rules and Cards here"))
add(526,"game_files","folder","Cartella Print and Play.",( "https://drive.google.com/drive/folders/1mlnzG6HcG2lektVTie9YzcX7OV3Tx_ui","Honeybee and Dragonfly"))
add(527,"component","file","Carta PnP.",( "https://drive.google.com/file/d/1QigKqUiArest5rQ8ZRhNaEaMT8qF1WIw/view?usp=sharing","PnP Card"))
add(527,"rules","file","Regolamento.",( "https://drive.google.com/file/d/1ztt1ob6LhT4jBfTC0qN8Uhw1n87_1p_M/view?usp=sharing","Rules"))
add(527,"video","video","Video how-to-play; canale automatico escluso.",( "https://youtube.com/watch?v=LfagBSln8gY","How to Play - Hovercraft in a Minefield: Alligator Rescue"))
add(527,"video","video","Playthrough; canale automatico escluso.",( "https://youtube.com/watch?v=rGCPK4YBi_M","Playthrough - Hovercraft in a Minefield: Alligator Rescue"))
add(528,"component","file","Carta bilingue.",( "https://www.dropbox.com/scl/fi/mt6qi2zdqff90kp40kla4/2-C-ITT.pdf?rlkey=d33n5osokp0uw1dvbd8p6vj27&st=jfpkzfhd&dl=0","Here / Aquí"))
add(528,"rules","file","Regole inglesi.",( "https://www.dropbox.com/scl/fi/98qldyt9ivirqyocexryd/1C-In-The-Trench.ENG.pdf?rlkey=0jpjqn68ohgl6kzroz0ae9cif&st=pwe39869&dl=0","Here"))
add(528,"rules","file","Regole spagnole.",( "https://www.dropbox.com/scl/fi/eh10eig2ip9q5s12fqhzy/1C-In-The-Trench.ESP.pdf?rlkey=5v4zke2apqsix5rzsqn6jz61j&st=qq1w2odi&dl=0","Aquí"))
add(529,"rules","document","Regole versione 1.1.",( "https://docs.google.com/document/d/1I3Qw1IiHsEEW-XILAo_zwZocxUGAt6rPUeF0xtDxJ8Y/edit?usp=sharing","Rules - 1.1"))
add(529,"component","file","Carta versione 1.0.",( "https://drive.google.com/file/d/1AnXMCLWejsEKQnEatE-Jypvfi-mpIitW/view?usp=sharing","Card - 1.0"))
add(530,"game_files","folder","Regole e file di stampa.",( "https://drive.google.com/drive/folders/1MQvgghobf6gMYH8kx-SgghkJCf_dBYkq?usp=drive_link","Download the Rules and Print File here"))
add(531,"game_files","file","Regole e carta versione 1.04.",( "https://drive.google.com/file/d/1A2ljkOpSkUwpiHz9QEGJFPMdBUZdbVIk/view?usp=drive_link","Locky Dice v1.04 Rules and Card"))
add(531,"component","file","Carta versione 1.04.",( "https://drive.google.com/file/d/1pnsPqd_2KBrMjJ6-flz1CR9yp7DaJwMx/view?usp=drive_link","Locky Dice Card v1.04"))
add(532,"component","bgg_image","L'immagine BGG è dichiarata esplicitamente come copia da stampare.",( "https://boardgamegeek.com/image/8819610","Tap the image above to print your copy"))
add(533,"game_files","folder","File correnti, PCIO e vecchia versione Shapelink.",( "https://drive.google.com/drive/folders/1fO10BPR8tmE-UgZRvosjCK1iCgC_Y4tQ?usp=sharing","Matching Socks PNP Files (2025.05.31)"))
add(533,"online_play","web_app","Versione digitale.",( "https://playingcards.io/ju78uw","https://playingcards.io/ju78uw"))
add(535,"game_files","file","Versione corrente Nap & Roll.",( "https://drive.google.com/file/d/16eBGFb_rpqJHdv2N-cmdOL9SgaRhbjAj/view?usp=drive_link","DOWNLOAD LINK"))
add(535,"online_play","web_app","Test digitale.",( "https://nap-and-roll-game.netlify.app/","NEW DIGITAL TEST"))
add(535,"game_files","file","Versione originale (6)^3 preservata.",( "https://drive.google.com/file/d/17l6XaitacmJSNp1IPVpfndgNfIc4oaR1/view?usp=sharing","VERSION 1 - Original Version"))
add(536,"game_files","folder","File PnP.",( "https://drive.google.com/drive/folders/15hP8l8gWGIwbvMv0rOOI8qy5wIbiuugU?usp=sharing","PNP files Download link"))
add(537,"rules","file","Regolamento.",( "https://drive.google.com/file/d/1tVC2xIOhCXxmTzIuyoW66MUNQDpJ7HC5/view","Rulebook"))
add(537,"component","file","Carta PnP.",( "https://drive.google.com/file/d/1RBOvEQt8X5I7TZ1Nn8jCRa_8EJKKmIFj/view","PnP Card"))
add(537,"online_tool","web_app","Companion per salute, focus e tiri.",( "https://greggjewell.io/onecardguard","Dice Companion Web App"))
add(537,"audio","video","Musica dichiarata per accompagnare la partita.",( "https://www.youtube.com/watch?v=H8n7K3jABhI","Here"))
add(538,"rules","file","Regole versione 1.0.",( "https://drive.google.com/file/d/1z6rHCGmafGSEb0sY73CAyWVUv5LhveTe/view","One Intersection Rules v1.0"))
add(538,"component","file","Carta versione 1.0.",( "https://drive.google.com/file/d/186SNUClS3iEuFdb7g0QSwcpnga4HO_9n/view","One Intersection Card v1.0"))
add(538,"video","file","Video how-to-play ospitato su Drive.",( "https://drive.google.com/file/d/1W54NUBYRSARsIv5bvrJYeVjh_7qU1e9o/view","How to play video"))
add(539,"rules","file","Regolamento PDF.",( "https://smallpdf.com/file#s=caaf96f9-31ae-49a2-abd5-e24c9651c185","RULEBOOK (pdf)"))
add(539,"online_play","workshop_module","Modulo Tabletop Simulator.",( "https://steamcommunity.com/sharedfiles/filedetails/?id=3461399811","TabletopSimulator mod"))
add(540,"game_files","folder","Cartella Print and Play.",( "https://drive.google.com/drive/folders/1R-G9pMJe7NHasw9SYBqjlOaWFtodHriK?usp=sharing","Print and play"))
add(541,"game_files","folder","Cartella Print and Play.",( "https://drive.google.com/drive/folders/1zpXykoay_xLG0y-3DZTlSWBqZyyne3yq?usp=sharing","Print and Play"))
add(542,"component","file","Carta multilingue.",( "https://drive.google.com/file/d/1mpNn8wa-79whfdH1IgU9zUAD0x30Z_OY/view?usp=drive_open","Rabbit Race - Card - Multilingual"))
add(542,"rules","file","Regole inglesi.",( "https://drive.google.com/file/d/1J3dDaxR1i-7-1mPhcUTz0HnJeTxUEt_V/view?usp=drive_open","Rabbit Race - Rules - EN"))
add(542,"rules","file","Regole spagnole.",( "https://drive.google.com/file/d/1J4Xpx2gqjI6eggB0Dm30nXH7LTIOAMNJ/view?usp=drive_open","Rabbit Race - Reglas - ES"))
add(542,"video","file","Demo inglese ospitata su Drive.",( "https://drive.google.com/file/d/1ydtSBvrfclQRYb23XZvKjvR195hzqb8d/view","Rabbit Race - Demo - EN"))
add(542,"online_play","web_app","Stanza pubblica PlayingCards.io.",( "https://playingcards.io/5dabyx","PUBLIC ROOM"))
add(542,"online_play","file","File per stanza privata.",( "https://drive.google.com/file/d/1g851H-Vvhjuj2fzEEO4xlh9uXuQh58pg/view","File"))
add(542,"online_tool","web_app","Pagina d'importazione esplicitamente indicata per la stanza privata.",( "https://playingcards.io/import","Import here"))
add(543,"component","file","Carta fronte-retro.",( "https://drive.google.com/file/d/11R_ZkUk48-41DcTKgvjyWkzcdWQRt9ST/view?usp=sharing","1 Double-Sided Card"))
add(543,"rules","document","Versione stampabile del regolamento.",( "https://docs.google.com/document/d/1g6c8UCbCEFEaS5beJsC2HcrAfyOBGAXLR5UwOULhpsU/edit?usp=sharing","Printable doc version of this rulebook"))
add(544,"component","file","File PnP.",( "https://drive.google.com/file/d/1HGkadu5_6AQqinLZQppfVrP4QgOUvOBr/view?usp=sharing","Self Service PnP File"))
add(544,"rules","file","Regolamento.",( "https://drive.google.com/file/d/1EW8wJIvWVfoTJfyo7a6o-dSIR_GLXoyu/view?usp=sharing","Self Service Rulebook"))
add(545,"game_files","folder","Cartella condivisa dichiarata dall'autore.",(shared,"https://drive.google.com/drive/folders/1bvVcv7bXpdr1QTW9GyVf..."))
add(546,"rules","document","Regole beta.",( "https://docs.google.com/document/d/13AmFLBgsMWtPQLHeqbM_TkoOwYQaWUaQPDiTtcPkLkk/edit?usp=sharing","Rules Beta"))
add(546,"component","file","Carta di gioco.",( "https://drive.google.com/file/d/1I5s4dzbIDfyEqn6M3FCMs8ceYw1tZJyD/view?usp=sharing","S.U.S Card"))
add(546,"online_play","web_app","Versione PlayingCards.io.",( "https://playingcards.io/ts7z3y","Playingcards.io"))
add(547,"game_files","folder","Cartella condivisa dichiarata dall'autore.",(shared,"https://drive.google.com/drive/folders/1bvVcv7bXpdr1QTW9GyVf..."))
add(548,"game_files","file","Regole e componenti.",( "https://c.gmx.net/@327464636691519389/CYMWDiaF2I8J_Eb4S3bXYA","Download rules and components here"))
add(549,"game_files","file","Regole e carta gutterfold versione 1.02.",( "https://drive.google.com/file/d/1Iidg2RiCAb9-vn4sVyUEh9bmFt92aR03/view?usp=drive_link","Way of the Goose v1.02 Rules and Card Gutterfold"))
add(550,"game_files","folder","Cartella Google Drive.",( "https://drive.google.com/drive/folders/16fFitJ2BsGNSeVxvzalQLN9TavW96MfQ?usp=drive_link","Wobbly Bridge Google drive"))

assert len(ENTRIES)==38 and len({e for e, *_ in ENTRIES})==38
assert len({(e,u) for e,u,*_ in RESOURCES})==len(RESOURCES)
assert Counter(s for *_,s in ENTRIES)==Counter(observed=35,none_declared=2,not_observable=1)

def q(v): return "NULL" if v is None else "'"+str(v).replace("'","''")+"'"
sql=["-- Full first-post resource census for 2025 1-Card. External destinations were not opened.","PRAGMA foreign_keys=ON;","BEGIN IMMEDIATE;","CREATE TEMP TABLE oc_entry(entry_id INTEGER PRIMARY KEY,title TEXT,wip_url TEXT,listing_status TEXT);","CREATE TEMP TABLE oc_resource(entry_id INTEGER,url TEXT,role TEXT,access_type TEXT,label TEXT,context TEXT,PRIMARY KEY(entry_id,url));"]
for eid,title,tid,status in ENTRIES: sql.append(f"INSERT INTO oc_entry VALUES({eid},{q(title)},{q('https://boardgamegeek.com/thread/'+tid)},{q(status)});")
for row in RESOURCES: sql.append("INSERT INTO oc_resource VALUES("+",".join(q(v) for v in row)+");")
sql += [
 f"DELETE FROM entry_resource_scans WHERE checked_at={q(DATE)} AND entry_id IN (SELECT id FROM entries WHERE contest_id={CONTEST_ID});",
 f"INSERT INTO entry_resource_scans(entry_id,checked_at,source_url,wip_status,resource_listing_status,notes) SELECT entry_id,{q(DATE)},wip_url,'found',listing_status,CASE listing_status WHEN 'observed' THEN 'Primo post renderizzato: anchor, link dinamici e media incorporati censiti; destinazioni non aperte.' WHEN 'none_declared' THEN 'Primo post renderizzato integralmente: nessun collegamento pertinente dichiarato osservato.' ELSE 'Post originale non osservabile; il primo articolo residuo appartiene a un altro utente e non è stato usato come fonte del gioco.' END FROM oc_entry;",
 "INSERT OR IGNORE INTO remote_resources(game_id,kind,access_type,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at) SELECT e.game_id,r.role,r.access_type,r.url,CASE WHEN instr(substr(r.url,instr(r.url,'//')+2),'/')>0 THEN substr(substr(r.url,instr(r.url,'//')+2),1,instr(substr(r.url,instr(r.url,'//')+2),'/')-1) ELSE substr(r.url,instr(r.url,'//')+2) END,r.label,NULL,'unknown','2026-09-11','2026-09-11' FROM oc_resource r JOIN entries e ON e.id=r.entry_id;",
 "UPDATE remote_resources SET kind=(SELECT r.role FROM oc_resource r JOIN entries e ON e.id=r.entry_id WHERE e.game_id=remote_resources.game_id AND r.url=remote_resources.url),access_type=(SELECT r.access_type FROM oc_resource r JOIN entries e ON e.id=r.entry_id WHERE e.game_id=remote_resources.game_id AND r.url=remote_resources.url),label=(SELECT r.label FROM oc_resource r JOIN entries e ON e.id=r.entry_id WHERE e.game_id=remote_resources.game_id AND r.url=remote_resources.url),last_verified_at='2026-09-11' WHERE EXISTS(SELECT 1 FROM oc_resource r JOIN entries e ON e.id=r.entry_id WHERE e.game_id=remote_resources.game_id AND r.url=remote_resources.url);",
 f"DELETE FROM entry_resource_mentions WHERE entry_id IN (SELECT id FROM entries WHERE contest_id={CONTEST_ID});",
 "INSERT INTO entry_resource_mentions(entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) SELECT r.entry_id,rr.id,i.wip_url,r.label,r.role,CASE WHEN r.role='game_files' THEN 1 ELSE 0 END,'2026-09-11','2026-09-11' FROM oc_resource r JOIN oc_entry i ON i.entry_id=r.entry_id JOIN entries e ON e.id=r.entry_id JOIN remote_resources rr ON rr.game_id=e.game_id AND rr.url=r.url;",
 "INSERT INTO remote_resource_observations(remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT rr.id,'2026-09-11',i.wip_url,'declared_in_wip','not_checked',NULL,'Dichiarata nel primo post BGG; destinazione non aperta. Contesto: '||r.context||' Classificazione provvisoria.' FROM oc_resource r JOIN oc_entry i ON i.entry_id=r.entry_id JOIN entries e ON e.id=r.entry_id JOIN remote_resources rr ON rr.game_id=e.game_id AND rr.url=r.url WHERE NOT EXISTS(SELECT 1 FROM remote_resource_observations o WHERE o.remote_resource_id=rr.id AND o.observed_at='2026-09-11' AND o.evidence_url=i.wip_url AND o.observation_kind='declared_in_wip');",
 "DROP TABLE oc_resource;","DROP TABLE oc_entry;","COMMIT;"
]
(ROOT/'catalog'/'2025-one-card-wips-resources.sql').write_text('\n'.join(sql)+'\n',encoding='utf-8')

counts=Counter(e for e,*_ in RESOURCES); titles={e:t for e,t,*_ in ENTRIES}; labels={'observed':'risorse osservate','none_declared':'nessuna risorsa dichiarata','not_observable':'post originale non osservabile'}
md=["# WIP e risorse dichiarate — 1-Card 2025","","Verifica dell’11 settembre 2026 sui primi post renderizzati dei 38 WIP. Le destinazioni esterne non sono state aperte e la tassonomia resta provvisoria.","","| # | Entry | Stato WIP/risorse | Risorse distinte |","|---:|---|---|---:|"]
for i,(e,t,_,s) in enumerate(ENTRIES,1): md.append(f"| {i} | {t} | {labels[s]} | {counts[e]} |")
md += ["","## Risorse","","| Entry | Etichetta originale | Contesto osservato | Funzione provvisoria | Forma tecnica | Dominio | URL |","|---|---|---|---|---|---|---|"]
clean=lambda x:str(x).replace('|','/').replace('\n',' ')
for e,u,r,f,l,c in RESOURCES: md.append(f"| {clean(titles[e])} | {clean(l)} | {clean(c)} | `{r}` | `{f}` | `{urlparse(u).netloc}` | {u} |")
md += ["","## Esclusioni e casistiche","","- Esclusi navigazione, profili, immagini decorative, riferimenti al contest, giochi citati come feedback e canali YouTube automatici.","- Conservata l’immagine BGG di `Lucky Words` perché il post la dichiara esplicitamente come copia da stampare.","- `Disturbance at Darkholm Manor`: post originale non osservabile; risposte residue non attribuite al censimento.","- `The Moving Fortress` e `Zombie Apocalypse`: nessun collegamento pertinente osservato nel primo post.","","## Totali","",f"- 38 entry e 38 WIP coperti.",f"- 35 WIP con risorse, 2 senza risorse osservate, 1 post originale non osservabile.",f"- {len(RESOURCES)} collegamenti distinti.","- Nessuna destinazione esterna aperta e nessun file scaricato."]
(ROOT/'sources'/'2025-ONE-CARD-WIPS-RESOURCES.md').write_text('\n'.join(md)+'\n',encoding='utf-8')
print(f"generated {len(RESOURCES)} resources for {len(ENTRIES)} entries")
