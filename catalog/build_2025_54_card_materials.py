"""MAT TSK-0053: evidenze dichiarative BGG, nessun accesso remoto."""
import argparse
import hashlib
import json
import sqlite3
from pathlib import Path
from urllib.parse import urlsplit

ROOT = Path(__file__).resolve().parents[1]
TASK = ROOT / 'tasks/2026-10-05 - MAT - 54-Card Game Design Contest 2025'
DATE = '2026-10-05'
EVIDENCE = TASK.relative_to(ROOT).as_posix() + '/EVIDENCE.json'
THREADS = [3537032,3538538,3541265,3539855,3543426,3543743,3546692,3548061,3539135,3548538,3549419,3552498,3555689,3558118,3560045,3560716,3561466,3566750,3569340,3572929,3573515,3574791,3576051,3576183,3576425,3576989,3577095,3577099]
POSTS = [46291237,46301955,46324376,46313270,46341270,46344366,46367010,46378729,46307150,46382221,46388295,46415425,46442687,46463006,46479286,46483984,46489667,46532631,46550829,46579299,46584390,46595935,46606498,46607412,46609129,46613703,46614574,46614587]
POST_DATES = ['4 lug 2025','7 lug 2025','12 lug 2025','10 lug 2025','16 lug 2025','17 lug 2025','23 lug 2025','25 lug 2025','8 lug 2025','26 lug 2025','28 lug 2025','2 ago 2025','8 ago 2025','12 ago 2025','16 ago 2025','17 ago 2025','18 ago 2025','28 ago 2025','1 set 2025','8 set 2025','9 set 2025','11 set 2025','14 set 2025','14 set 2025','14 set 2025','15 set 2025','16 set 2025','16 set 2025']
AUTHORS = ['Ghost_Dancer','CrossedSignals','janciorules','Ninjabunny13','Herald Selenay','tucky60','Supah_Jawa','robcsi90','PressStartUA','milovegas','Cnote58','Table_for_two_games','asdir','MrKuricat','Herr_Goldberg','Smulchy_','tosx','chendobvb','ajvw4','alexserpa','PugWarlord','turncoatgames','kensiebensie','Haymire','rimadeta','Zhan_Shi','Hunter_P','ProfStemkoski']

# Ogni menzione conserva URL esatto, etichetta originale e funzione dichiarata.
LINKS = {}
def add(i, role, label, url, context=None, version=None):
    LINKS.setdefault(i, []).append(dict(url=url,label_raw=label,content_role=role,context_raw=context or label,version_raw=version))
def folder(i, ident, label='Google Drive', suffix='?usp=sharing', role='game_files', context=None):
    add(i,role,label,'https://drive.google.com/drive/folders/'+ident+suffix,context)
def file(i, ident, label, role, suffix='?usp=sharing', context=None, version=None):
    add(i,role,label,'https://drive.google.com/file/d/'+ident+'/view'+suffix,context,version)
def tts(i, ident, label='TTS Mod'):
    add(i,'online_play',label,'https://steamcommunity.com/sharedfiles/filedetails/?id='+str(ident),'Tabletop Simulator')

folder(1,'10mtLExpoUn6vj4CEJPAyJLH_gQNaFMKg','https://drive.google.com/drive/folders/10mtLExpoUn6vj4CEJPAy...',context='PNP Files*')
tts(1,3549264552,'https://steamcommunity.com/sharedfiles/filedetails/?id=35492...')
add(1,'video','https://youtu.be/Cue21v0XjWo','https://youtu.be/Cue21v0XjWo','Tutorial & Playthrough Video')
add(1,'video','Hack The Planet - Tutorial & Playthrough','https://youtube.com/watch?v=Cue21v0XjWo','Embedded tutorial; same video as textual short URL')
folder(2,'1LJDPOr3J51l0jC8yQvK-zwDGYTPIfYjB','Oh Ship! WIP',context='Game components PnP Files')
tts(2,3542368043,'https://steamcommunity.com/sharedfiles/filedetails/?id=35423...')
add(3,'game_files','HQ ENGLISH VERSION (Fullcolor)','https://janciorules.itch.io/rekta','Print And Play files (ITCH.io): HQ ENGLISH VERSION (Fullcolor) (8 MB zip)','2025.12.16')
add(3,'online_play','PLAYINGCARDS.IO','https://playingcards.io/','Play Online: PLAYINGCARDS.IO (digital game file available in PnP game package)')
file(4,'1ExjyNXtudC2tNSvFgUyoD-qfbXj-IIDX','Card game link','component',context='7/30/25 Update: Card game link')
file(4,'1N-nJIOLgOoTcvoO10i11vK1RzyB59r7K','Link to Rules','rules',context="7/30/25 Update: The link to the video on how to play doesn't work yet- in progress. Link to Rules")
folder(5,'1UfIZINPy7lZoHKYxwCLZrUAbhC4U9FQ6','here!','?usp=drive_link',context='Files available via GoogleDrive; rulebook v4 2025.9.17, PnP v1 and optional tuckbox')
tts(5,3527339355,'here!')
add(5,'video',"Surfboard Stealin' Sea Otters: Assembling the Ocean!",'https://youtube.com/watch?v=IUW7bPzqAMA','Assembling the Ocean Video')
folder(6,'1Ue1klMeUM-HnGJ0qFg59xiYbgGPoE0MB','Rules and Cards',context='Game files: Rules and Cards')
folder(7,'1g5uVw8m4llpoLCg0e1dG5BjuEUte3NWj','Google Drive with Rules and Cards','?usp=drive_link')
folder(8,'1DCSuLeWhgTfzYAfu_2cZndgQxfAj8KKm','Google Drive link','?usp=drive_link',context='Files; low and high ink cards, expansion outside contest limit')
tts(8,3558845840,'Steam link')
folder(10,'16NGp-Q6M3FchjIVLt4JkaF0EdrYTZ62U','https://drive.google.com/drive/folders/16NGp-Q6M3FchjIVLt4Jk...','?usp=share_link',context='Card and Rules Files')
folder(11,'1ER4eLu2eH9AvOhZ_rQEcNATz76N4gz_5','Game Rules and Custom PNP Deck','')
add(11,'online_play','PCIO Available','https://playingcards.io/4bmc9v')
add(11,'video','The Sixth Crypt Playthrough - Traditional Deck Game','https://youtube.com/watch?v=0CV1VPaIbDU','Playthrough Video; titolo video differente dal roster Ranicide')
folder(11,'1ER4eLu2eH9AvOhZ_rQEcNATz76N4gz_5','Google Drive with Rules and Custom PNP Deck')
add(11,'online_play','PCIO Available','https://playingcards.io/4bmc9v')
add(12,'video','here','https://www.youtube.com/watch?v=NrJ_fxfl3_8','Overview video')
add(12,'online_play','here','https://screentop.gg/@SammyB/WildlifeGarden','Digital link (Screentop.gg), rules link inside the game')
add(12,'game_files','here','https://www.dropbox.com/scl/fo/unut6opamrbq1wmtmgv3h/AA5qmaxjQlnJPEvReAcPRlc?rlkey=4pqnpq9hyi85m34160jel1c9f&st=4k4ybhh9&dl=0','Print and play files')
file(13,'1tDPcxxZHSgT5WriudbIperFbL2w9DyRR','Rules','rules',context='Rules (pdf, 2 pages)')
file(13,'1oFmSghW6aaaueQQ0r0vTJ59e5nckX4h-','Cards coloured','component',context='Cards coloured; low-ink version (for both backsides are necessary to print)')
file(13,'1f-Hs3ibPM2ySlQvXeDMnUfKaQbkMgFX5','low-ink version','component',context='Cards coloured; low-ink version (for both backsides are necessary to print)')
add(13,'online_play','Online playtest (playingcards.io)','https://playingcards.io/scpfmm','Online playtest (playingcards.io) (3-players only)')
add(13,'video','Rules video (3-player example)','https://youtu.be/5J1V-DIROcc')
add(14,'rules','Proto 3a.2 Rulebook','https://wannabeboardgamedesigner.com/hack-a-pad_rules-3a.2',version='Proto 3a.2')
add(14,'component','Components download page (v 3a.1)','https://wannabeboardgamedesigner.com/hack-a-pad_3a.1#pnp',version='3a.1')
add(14,'video','YouTube','https://youtu.be/IWFgIb4sW5w','How-to-play video')
tts(14,3573534913,'Tabletop Simulator Mod')
add(14,'online_play','Screentop.gg version','https://screentop.gg/@MrKuriCat/Hack-a-Pad')
folder(15,'1i2h5V1PLnxk5mStTIdR-OtBCRxRRhrN0','August 28th',context='latest rules and PnP files from August 28th')
folder(15,'1i2h5V1PLnxk5mStTIdR-OtBCRxRRhrN0','Get components and rules here','?usp=drive_link')
file(16,'1Cdh7HjozADJEl7xHB3zFyuQ-aju8mx9g','Tower Guard Rules','rules')
file(16,'1m08oBuhY3KGk4SwOWvcyQRMAAkjJI-VX','Tower Guard PNP Files','component')
tts(16,3592617426,'Steam Workshop Link')
file(16,'1eTScFLafteHnLa4MKnRIhS_X47x16b8W','this JSON file','online_play',context='Alternatively, download this JSON file into your TTS documents folder and spawn it in-game via the Saved Objects menu')
add(16,'video','Tower Guard Guide & Playthrough','https://youtube.com/watch?v=h2cJUc79N8k')
folder(17,'1FLD_9XpnyZx5cRcmBd5Uh9_2Rwm8W-0n','Link','?usp=drive_link',context='Rules/Files: Link (rules are cards in the deck; a lower-ink version is available)')
tts(17,3551657730,'TTS')
add(17,'online_play','Screentop','https://screentop.gg/@tosx/Intercept')
for ident,role,ctx in [('1Q8r3-dYhFaSEEqBX8gr1vZZxPhK6jicB','player_aid','Example game'),('1ArKPdGx1-IUHLu8ryN0jgKVGm00QRumv','component','ENGLISH CARDS'),('1lUU5Q1Zz9212fqKLpwuZ4ZAvTVzx4HpO','rules','ENGLISH RULES'),('1bZ2PlsAthVeZUMJcEKtAPtrPEqKmvQo6','game_files','Cards and rules'),('1geLRBcaz444bscIP_MgDWVgZZB9U2P4G','rules','Spanish Rules')]:
    file(18,ident,'https://drive.google.com/file/d/'+ident[:-5]+'...',role,'?usp=drive_link' if ctx=='Spanish Rules' else '?usp=drivesdk',ctx)
file(19,'1orvQr2xsKJb6twb1zx6c8eMfSAdWFtgK','Rules Including Components','game_files')
tts(19,3560266779)
file(19,'1YBC_XEz1U-zPIs_nigQaRPhh9dan2CAc','How to Play Video','video')
folder(20,'1daz2DxI1TL0YKhwi9kZ7GsPfzHL8FDf7','here',context='PnP Files can be found here')
add(20,'online_play','https://screentop.gg/@ComplianceBG/WagerInTheFog','https://screentop.gg/@ComplianceBG/WagerInTheFog','Digital Implementation')
file(20,'1qG2tO0Yp74RffG_6rhw_nQWQ5gxq8Kuh','without captions','video',context='How to play Video: without captions')
file(20,'1BdiZQSi9gw0uGAiH8T9wExV-Hp1jYEHt','with captions','video',context='How to play Video: with captions')
file(21,'162O7QYMc194tZcQf6o28sbkc_rRqrOJ3','https://drive.google.com/file/d/162O7QYMc194tZcQf6o28sbkc_rR...','rules',context='Rules')
file(21,'1Wt7rkhV2nAHIDHobUe7dK5yzkvbS5eri','https://drive.google.com/file/d/1Wt7rkhV2nAHIDHobUe7dK5yzkvb...','component',context='Print Files')
file(21,'1B6tiEWmdaXwWJGmPan8ngDehCD6oY1E_','https://drive.google.com/file/d/1B6tiEWmdaXwWJGmPan8ngDehCD6...','component',context='Low Ink Print Files')
tts(21,3565029609,'https://steamcommunity.com/sharedfiles/filedetails/?id=35650...')
folder(22,'1P6pcReFvGRMPoFjPTZpoX5c9h9AUcOWf','Here','?usp=drive_link',context='Update 1: Print and Play Components Available Here')
add(22,'online_play','Here','https://screentop.gg/@turncoatgames/Braggarts','Update 2: Digital Implementation Available Here')
file(22,'1PxR4EEEPeAFFDvKWAqzxrWkVxKIS8K06','Here','rules','?usp=drive_link','Update 3: Illustrated Rules Available Here')
add(22,'video','Here','https://youtu.be/Pvdvpf4_6yQ','Update 4: Playthrough Video Available Here')
folder(22,'1P6pcReFvGRMPoFjPTZpoX5c9h9AUcOWf','here','?usp=drive_link',context='Full colour and low-ink PnP components are available for A4, US Legal and US Letter paper here.')
add(22,'online_play','Screentop.gg','https://screentop.gg/@turncoatgames/Braggarts','You can also play Braggarts online at Screentop.gg without an account.')
add(22,'video','Braggarts Playthrough','https://youtube.com/watch?v=Pvdvpf4_6yQ')
file(23,'1O_s-Qt8MtOvl5fdfTo_YdNTajr-PKLsF','here','rules',context='Rules: here')
file(23,'1nDIn56NdhLHi0p4xVHJZsJp-6eT0oPTX','here','component',context='PNP Files: here')
file(23,'1CCXnFHCRMBgVMLj3YYbNBGvw6-jA2vBo','here','component',context='Low Ink PNP Files: here')
tts(23,3593490172,'here')
add(23,'video','here','https://youtu.be/dZUZ6xhkK_0','How to Play Video')
folder(24,'1RjJfHMBKziOl9OSdqApAl49TgwgECt-I','Google Drive (PnP Components, Rules)','?usp=drive_link')
tts(24,3582649214,'TTS mod')
file(25,'1b_VzBBjdccFVKCALSMVhaatsqcdoFAee','Rulebook Low Ink','rules','?usp=drive_link','Rulebook Low Ink / V3.0 updated 10-14-2025','V3.0')
file(25,'1v51q8qc36x3qa_WufiJUytCPFwuBF3PD','PnP-Cards','component','?usp=drive_link','PnP-Cards / V1.0 updated 09-14-2025','V1.0')
add(26,'game_files','Ready to download','https://boardgamegeek.com/boardgame/454829/potemkin-villages/files','PDF Rulebook and all PnP Files; Last update September 27, 2025 (rulebook v0.0.5, pnp files v0.0.3/4)')
tts(26,3572730165,'Available here')
file(27,'11chOKQQw0F4HWywWh8n7NzKjuq8O3auq','Component Ready','component',context='Status: Component Ready')
folder(27,'1iAaRvcot1-GmYAH2fBMXsDbFn8_hx0su','Rules & Components Link:')
add(27,'rules','The Rules:','https://docs.google.com/document/d/1zksbiZzfIqh7vUIgoq_Ow6W9ekHlGipGJhzAez4ytfM/edit?usp=sharing')
folder(27,'1iAaRvcot1-GmYAH2fBMXsDbFn8_hx0su','Playtest Cards:','',role='component')
file(27,'1IrSMQ6ElmXcacXZpej252Cd1zdEUC1DH','Low-Ink Cards:','component')
file(28,'1sWRe3YIj2MeksEtnfrHlBinxNpBhapKl','Rulebook','rules','?usp=drive_link',version='3.0')
file(28,'1U2RluGzgaEXT19I2nuUwXgRObvidbgcH','Custom Deck','component','?usp=drive_link',version='3.0')
add(28,'project_page','Website','http://stemkoski.net/g20/','Website (now includes digital versions of the game!)')
add(28,'video','The Gauntlet: Twenty Trials of Darkness - Tutorial and Playthrough (standard mode)','https://youtube.com/watch?v=9KIioEz1cac','Video (tutorial and playthrough); solitaire Adventurer standard mode')

REQUIREMENTS = {}
def req(i, name, quantity, raw, kind='printable_component', level='required', supply='printable'):
    REQUIREMENTS.setdefault(i,[]).append(dict(material_kind=kind,name_normalized=name,name_raw=raw,quantity_raw=quantity,requirement_level=level,supply_mode=supply,context_raw=raw))
for i,q,raw in [(1,'54','Card Count: 54'),(2,'54','Total card count: 54'),(3,'18','With handy components (only 18 cards)'),(6,'54','Total card count: 54'),(7,'53','Card Count: 53'),(8,'54','Components: 54 cards'),(12,'47','Components- 47 Cards'),(14,'54','Card Count: 54'),(15,'54','Components: 54 cards'),(16,'54','Total Card Count: 54'),(17,'54','Card count: 54'),(18,'54','Requierd componentes: deck of 54 poker size cards'),(20,'54','54 Cards (standard poker size)'),(21,'54','Components: 54 Cards'),(23,'54','Card Count: 54'),(25,'54','components: 54 cards'),(26,'49','Total card count: 49'),(27,'54','Total card count: 54')]:
    req(i,'carte del gioco',q,raw)
req(1,'dorsi delle carte',None,"The card backs are optional - if you don't want to print them, just print odd numbered pages.",level='optional')
req(2,'secondo mazzo per 5–8 giocatori','1 aggiuntivo','Number of players: 2-4 (5-8 with 2 decks)',level='optional')
for name,q in [('carte Quest','9'),('carte risorsa','21'),('carte ostacolo','12'),('carte azione','12')]:
    req(4,name,q,'Total card count: 54 cards: 9 Quest cards (double-sided quests?), 21 resource cards, 12 obstacle cards, 12 action cards; 7/26/25 update: double-sided quest cards with side B being more of a challenge')
for name,q in [('carte Surfboards','30'),('carte Ocean Waves','8'),('carte Department of Fish & Wildlife','2'),('carte Wild Surfboards','3'),('carte Action','11')]:
    req(5,name,q,'Components: 54 Cards - 30 Surfboards - 8 Ocean Waves - 2 Department of Fish & Wildlife Cards - 3 Wild Surfboards - 11 Action Cards')
req(5,'regolamento',None,'Components: Rulebook',kind='rules')
req(5,'tuckbox',None,'Tuckbox (optional)',level='optional')
req(5,'dorsi delle carte',None,'Page 7 is an optional card back (the same for all cards).',level='optional')
req(8,'espansione per 5–6 giocatori e carte avanzate',None,'For the 5 and 6 player count, as well as some advanced cards and even more replayability you need to print an expansion, which is outside of the contests limit',level='optional')
req(9,'carte Treasure','42','Components: 42 Treasure Cards; 12 Decision Cards')
req(9,'carte Decision','12','Components: 42 Treasure Cards; 12 Decision Cards')
req(10,'carte del gioco',None,'Feel free to print and play the cards and let me know what you think!')
req(11,'mazzo tradizionale con joker','52 + 2 joker','Card Count: Uses 54 cards: a traditional deck and 2 Jokers.',kind='standard_deck',supply='common')
req(11,'mazzo PnP personalizzato',None,'Game Rules and Custom PNP Deck',level='alternative')
req(13,'carte con dorsi stampati',None,'Cards coloured; low-ink version (for both backsides are necessary to print)')
req(19,'mazzo standard','52','Card Count: 52; Each suit in a standard deck represents a different horse in the race',kind='standard_deck',supply='common')
req(22,'carte teste','27 (9 per seme)','Braggarts requires a deck of 54 cards, split into 3 suits of 18 cards. Each suit has 9 heads and 9 tails numbered 1, 2, 2, 3, 3, 4, 4, 5, 5.')
req(22,'carte code','27 (9 per seme)','Braggarts requires a deck of 54 cards, split into 3 suits of 18 cards. Each suit has 9 heads and 9 tails numbered 1, 2, 2, 3, 3, 4, 4, 5, 5.')
req(24,'carte PnP','22','Components needed: 1. The PnP file for 22 cards.')
req(24,'carte da mazzo standard','32','2. 32 cards from a standard deck of cards. The Ace and 2-8 of Spades, Hearts, Clubs, Diamonds (Alternatively the 2-9 of Spades, Hearts, Clubs, Diamonds, if you consider Ace to be high only).',kind='standard_deck',supply='common')
req(28,'mazzo standard con joker','52 + 2 joker','Components: A standard deck of cards (52 cards + 2 jokers) or the custom artwork cards below.',kind='standard_deck',level='alternative',supply='common')
req(28,'mazzo personalizzato',None,'Components: A standard deck of cards (52 cards + 2 jokers) or the custom artwork cards below.',level='alternative')

NOTES = {
 1:'URL breve e incorporato riferiscono lo stesso video; entrambi gli URL dichiarati conservati, non due contenuti distinti.',
 2:'Secondo mazzo solo per 5–8 giocatori; non sommare al mazzo base per 2–4.',
 3:'Versione dichiarata finale 2025.12.16; link PlayingCards.io generico, file digitale dichiarato nel pacchetto PnP. LINK BGG a pagina gioco/WIP non risorse.',
 4:'Aggiornamenti storici del primo post preservati nel contesto: file assenti inizialmente, aggiunti il 30 luglio. Linktr.ee personale escluso.',
 5:'Licenza dichiarata: Game rules and cards available as a free print and play for the duration of the 2025 54-Card Game Design Contest. Disponibilità attuale non verificata; box e dorsi opzionali. Varianti low ink color/greyscale e carta Legal/Letter dichiarate.',
 8:'Espansione fuori dal limite contest distinta dal mazzo 54; annuncio futuro 70–80 carte non adottato come inventario corrente.',
 9:'Primo post originale @PressStartUA 8 luglio: componenti espliciti ma nessun URL pertinente; none_declared riguarda solo i collegamenti, non disponibilità universale.',
11:'Cartella ripetuta con/senza usp: URL originali conservati; stesso identificativo cartella. PCIO identico accorpato. Video intitolato The Sixth Crypt: nome video preservato, nessuna rinomina canonica inferita.',
13:'Dorsi esplicitamente necessari per versione colore e low ink; PCIO dichiarato solo per tre giocatori.',
15:'Due parametri usp per lo stesso ID cartella: forme dichiarate preservate. Instagram personale escluso.',
16:'JSON alternativo per TTS classificato online_play/file, non componente stampabile.',
17:'Regole integrate nelle carte, nessun regolamento aggiuntivo inferito; low ink dichiarato.',
18:'Deck poker size personalizzato esplicito; non inferita compatibilità con mazzo standard dalla categoria del contest. Cards and rules senza lingua esplicita conservato.',
19:'Rules Including Components conservato come game_files; contenuto del file non letto. Video su Drive distinto da regole.',
20:'Video con/senza sottotitoli separati; carte dado non trasformate in requisito dadi fisici.',
21:'Crediti Artstation esclusi; Rules e Print Files correnti diversi da quelli storici del roster.',
22:'Menzioni ripetute preservate; 27 teste e 27 code sono normalizzazione esplicita di 3×9, totale 54 non sommato nuovamente. Due URL video dello stesso contenuto conservati. A4, US Legal, US Letter e low ink dichiarati.',
26:'Destinazione PDF/PnP è pagina file BGG, non aperta; versione regole 0.0.5 e PnP 0.0.3/4 dichiarate.',
27:'Status Component Ready è anchor a un file: funzione componente provvisoria, contenuto non verificato. Stesso ID cartella per Rules & Components e Playtest Cards, URL originali conservati; profili artisti esclusi.',
28:'Mazzo standard e personalizzato sono alternative; Website dichiara versioni digitali. Versione 3.0, file aggiornati 13 ottobre 2025.'}

def access(url):
    if '/folders/' in url or '/scl/fo/' in url: return 'folder'
    if 'steamcommunity.com' in url: return 'workshop_module'
    if 'youtu.be' in url or 'youtube.com' in url: return 'video'
    if 'docs.google.com' in url: return 'document'
    if 'file/d/' in url: return 'file'
    if 'screentop.gg' in url or 'playingcards.io' in url: return 'web_app'
    return 'download_page'

def q(v):
    return 'NULL' if v is None else "'"+str(v).replace("'","''")+"'"
def insert(table,values):
    return 'INSERT OR IGNORE INTO '+table+' ('+','.join(values)+') VALUES ('+','.join(q(v) for v in values.values())+');'

def build(db):
    local=db.execute('SELECT e.id,e.game_id,e.position,g.canonical_title FROM entries e JOIN games g ON g.id=e.game_id WHERE e.contest_id=19 ORDER BY e.position').fetchall()
    assert len(local)==28 and [x[2] for x in local]==list(range(1,29))
    rows=[]
    for eid,gid,i,title in local:
        source=f'https://boardgamegeek.com/thread/{THREADS[i-1]}/article/{POSTS[i-1]}#{POSTS[i-1]}'
        resources=[dict(x,host=urlsplit(x['url']).netloc,access_type=access(x['url'])) for x in LINKS.get(i,[])]
        rows.append(dict(entry_id=eid,game_id=gid,position=i,title=title,source_url=source,wip_url=f'https://boardgamegeek.com/thread/{THREADS[i-1]}',author_raw=AUTHORS[i-1],post_timestamp_raw=POST_DATES[i-1]+' (edited)',checked_at=DATE,wip_status='found',resource_listing_status='observed' if resources else 'none_declared',material_listing_status='observed',coverage_scope='first_post_only',outcome='complete',resources=resources,requirements=REQUIREMENTS[i],notes=NOTES.get(i,'Primo post originale completo; collegamenti e requisiti dichiarati, host non aperti.')))
    return rows

def sql_for(rows):
    sql=['PRAGMA foreign_keys=ON;','BEGIN;']
    for r in rows:
        eid=r['entry_id'];src=r['source_url'];notes='TSK-0053; first_post_only; '+r['notes']
        sql.append('UPDATE entries SET wip_thread_url='+q(r['wip_url'])+' WHERE id='+str(eid)+' AND wip_thread_url IS NULL;')
        common=dict(entry_id=eid,checked_at=DATE,source_url=src,wip_status='found',notes=notes)
        sql.append(insert('entry_resource_scans',dict(common,resource_listing_status=r['resource_listing_status'])))
        sql.append(insert('entry_material_scans',dict(common,material_listing_status=r['material_listing_status'],coverage_scope='first_post_only')))
        sql.append(insert('entry_work_observations',dict(entry_id=eid,phase='materials',outcome='complete',observed_at=DATE,source_url=src,evidence_path=EVIDENCE,notes=notes)))
        for url in sorted({x['url'] for x in r['resources']}):
            group=[x for x in r['resources'] if x['url']==url];x=group[0]
            sql.append(insert('remote_resources',dict(game_id=r['game_id'],kind=x['content_role'],access_type=x['access_type'],url=url,host=x['host'],label=' | '.join(dict.fromkeys(z['label_raw'] for z in group)),version_raw=x['version_raw'],availability_status='unknown',first_seen_at=DATE,last_verified_at=DATE)))
            rid='(SELECT id FROM remote_resources WHERE game_id='+str(r['game_id'])+' AND url='+q(url)+')'
            for role in sorted({z['content_role'] for z in group}):
                labels=[z['label_raw'] for z in group if z['content_role']==role]
                sql.append('INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES ('+','.join([str(eid),rid,q(src),q(' | '.join(labels)),q(role),'1',q(DATE),q(DATE)])+');')
            context=' | '.join(z['context_raw'] for z in group)
            sql.append('INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT '+','.join([rid,q(DATE),q(src),q('declared_in_wip'),q('not_checked'),q(x['version_raw']),q(notes+' Contesto originale: '+context)])+' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id='+rid+' AND observed_at='+q(DATE)+' AND evidence_url='+q(src)+" AND observation_kind='declared_in_wip');")
        for item in r['requirements']:
            vals=dict(entry_id=eid,**item,source_url=src,first_seen_at=DATE,last_seen_at=DATE)
            identity=['entry_id','material_kind','name_normalized','quantity_raw','requirement_level','source_url']
            sql.append('INSERT INTO entry_material_requirements ('+','.join(vals)+') SELECT '+','.join(q(v) for v in vals.values())+' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE '+' AND '.join(k+' IS '+q(vals[k]) for k in identity)+');')
    return '\n'.join(sql+['COMMIT;',''])

def main():
    p=argparse.ArgumentParser();p.add_argument('--database',type=Path,default=ROOT/'database/pnp_collection.sqlite3');a=p.parse_args()
    with sqlite3.connect(a.database.resolve().as_uri()+'?mode=ro',uri=True) as db: rows=build(db)
    stats=dict(entries=len(rows),complete=28,resource_entries=sum(bool(r['resources']) for r in rows),resources=sum(len({x['url'] for x in r['resources']}) for r in rows),resource_mentions=sum(len(r['resources']) for r in rows),requirements=sum(len(r['requirements']) for r in rows))
    (TASK/'EVIDENCE.json').write_text(json.dumps(dict(task_id='TSK-0053',contest_id=19,checked_at=DATE,coverage_scope='first_post_only',method='Rendered original first posts; exact declared URLs and selected verbatim evidence; all text read; no external hosts/files opened.',counts=stats,entries=rows),ensure_ascii=False,indent=2)+'\n',encoding='utf8')
    sql=sql_for(rows);(ROOT/'catalog/2025-54-card-materials.sql').write_text(sql,encoding='utf8')
    report=['# 54-Card Game Design Contest 2025 — censimento materiali','',f'Verifica BGG: {DATE}, TSK-0053. [Roster ufficiale](https://boardgamegeek.com/geeklist/360114/2025-54-card-game-design-contest-entries), 28 righe su due pagine riconciliate con le 28 entry locali. Tutti i 28 primi post originali letti integralmente; identità autore e data osservate. Nessun host esterno o file aperto e nessun download.','',f"28/28 esiti completi, 27 entry con URL pertinenti, {stats['resources']} URL esatti distinti per entry, {stats['resource_mentions']} menzioni e {stats['requirements']} requisiti dichiarativi. Villains Incorporated: nessun collegamento dichiarato nel primo post, ma 42 Treasure Cards e 12 Decision Cards esplicite.",'','Copertura first_post_only; tassonomia provvisoria. URL diversi dello stesso video o della stessa cartella restano forme dichiarate distinte, segnalate nelle note: il conteggio URL non equivale a file o contenuti diversi. Menzioni di URL identici accorpate nel database, preservate nel dataset. Requisiti e alternative non sono una distinta verificata delle regole.','', '| Entry | Gioco | URL distinti | Requisiti | Note |','|---:|---|---:|---:|---|']
    for r in rows:
        report.append(f"| {r['entry_id']} | [{r['title']}]({r['source_url']}) | {len({x['url'] for x in r['resources']})} | {len(r['requirements'])} | {r['notes']} |")
    report+=['','Evidenze originali, quantità, autore, timestamp, menzioni, versioni e contesti in [EVIDENCE.json](../'+EVIDENCE.replace(' ','%20')+'). Esclusi profili e crediti artisti, immagini decorative, feedback su altre entry, riferimenti contest e canali automatici. Nessun contenuto delle risposte utilizzato.','', 'Prossimo passo: eventuale task ACQ dello stesso singolo contest, dopo selezione esplicita dei giochi, verifica condizioni e host. Per Surfboard Stealin’ Sea Otters la gratuità è dichiarata limitata alla durata del contest; disponibilità e condizioni attuali restano da verificare. Nessun monitoraggio periodico del contest concluso.','']
    (ROOT/'sources/2025-54-CARD-MATERIALS.md').write_text('\n'.join(report),encoding='utf8')
    print(json.dumps(dict(stats,sql_sha256=hashlib.sha256((ROOT/'catalog/2025-54-card-materials.sql').read_bytes()).hexdigest())))

if __name__=='__main__': main()
