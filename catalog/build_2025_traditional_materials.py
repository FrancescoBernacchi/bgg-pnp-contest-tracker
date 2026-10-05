"""TSK-0055: normalizzazione delle dichiarazioni BGG osservate con CUA."""
import json, sqlite3
from pathlib import Path
from urllib.parse import urlsplit
import build_2025_54_card_materials as shared

ROOT=Path(__file__).resolve().parents[1]
TASK=ROOT/'tasks/2026-10-05 - MAT - Traditional Deck Game Design Contest 2025'
DATE='2026-10-05'
EVIDENCE=TASK.relative_to(ROOT).as_posix()+'/EVIDENCE.json'
POSTS=[46550628,46550651,46550763,46551084,46552264,46552897,46554090,46556052,46564024,46557041,46582927,46595526,46602615,46606327,46608335,46612051,46612031,46622325,46630011,46633218,46637677,46652569,46653063,46664510,46664572,46664576,46692202,46761450,46802831,46583159,46884172,46896468,46907368,46923265,46925258,46925658,46931100,46931979,46941170,46945118,46961483,46961933]
AUTHORS=['quantumpotato','quantumpotato','woffpack','vbugica','LetsGameMore','XendoBreckett','davidmcdougal','mfmw','BGWBarry','Season6028','thecheckdeck','mfmw','KintsugiGames','davidmcdougal','alexserpa','rimadeta','Rexigent','goodkinghenry','weekendworrier','Kikwik','goodkinghenry','rimadeta','woffpack','unlessgames','unlessgames','LetsGameMore','akimakesthings','burismiga','XendoBreckett','Tottojer','Mystael','elastic_kevin','CardGameAcolyte','elmagnifico','jbleveque','davrooom','BGWBarry','jbleveque','dgrgich','wordbandar','Kyl_','Mandrel']
TIMES=['1 set 2025 (edited)']*4+['2 set 2025 (edited)']*4+['4 set 2025 (edited)','3 set 2025 (edited)','8 set 2025','11 set 2025 (edited)','13 set 2025 (edited)','14 set 2025 (edited)','14 set 2025 (edited)','15 set 2025 (edited)','15 set 2025 (edited)','17 set 2025 (edited)','19 set 2025 (edited)','20 set 2025 (edited)','21 set 2025 (edited)','24 set 2025 (edited)','24 set 2025 (edited)','27 set 2025 (edited)','27 set 2025','27 set 2025 (edited)','3 ott 2025','20 ott 2025 (edited)','28 ott 2025 (edited)','8 set 2025 (edited)','13 nov 2025 (edited)','16 nov 2025 (edited)','18 nov 2025','21 nov 2025 (edited)','22 nov 2025','22 nov 2025 (edited)','23 nov 2025 (edited)','23 nov 2025','25 nov 2025','26 nov 2025 (edited)','30 nov 2025 (edited)','30 nov 2025 (edited)']
LINKS={}
def link(i,url,label,role='rules',context=None,version=None):
    LINKS.setdefault(i,[]).append(dict(url=url,label_raw=label,content_role=role,context_raw=context or label,version_raw=version))
def doc(i,ident,label,tail='/edit?usp=sharing',context=None,version=None):
    link(i,'https://docs.google.com/document/d/'+ident+tail,label,context=context,version=version)
def file(i,ident,label,tail='/view?usp=sharing',context=None,version=None,role='rules'):
    link(i,'https://drive.google.com/file/d/'+ident+tail,label,role,context,version)
doc(1,'1b_qAVxnY8amahzmgwYy4db-67nL7yt8G_GtZALYzYto','https://docs.google.com/document/d/1b_qAVxnY8amahzmgwYy4db-6...',context='Rules Document (1 page)',version='Last Updated: September 5, 2025')
doc(2,'1inq5w0K2rDOsTYtN_L6u-1MjRpcCb8Xn5G_jidC_018','https://docs.google.com/document/d/1inq5w0K2rDOsTYtN_L6u-1Mj...',tail='/edit',context='Rules Link')
doc(3,'1JkQv-oq5yGgNYRvKQZoJmJ17TIGDITsCSXfW3BZoTPE','https://docs.google.com/document/d/1JkQv-oq5yGgNYRvKQZoJmJ17...',context='RULES Google doc')
link(3,'https://youtu.be/tjpJp0p6jYI','https://youtu.be/tjpJp0p6jYI','video','Overview Video link')
link(3,'https://youtu.be/2Y8OH0p7u7Q','https://youtu.be/2Y8OH0p7u7Q','video','Full Playthrough Video link')
doc(4,'1Ss6fmEGr3566Ig5WrOy571bzkhc2VyMxoKcSj79BeD8','Read here',tail='',context='Full Rules & Tutorial')
link(4,'https://drive.google.com/drive/u/3/folders/1u2WtJOxwPM56a9J4ncpwR4E7NJj_ZErb','Print here',context='Quick Rules')
link(4,'https://www.dropbox.com/scl/fo/2bsea4oa1x383qaz91kwg/ALyieMeywF0ju1mTH4bZ1rw?rlkey=lrd81lcttrokm8h1gh9berxlx&st=3fzgwzqi&e=1&dl=0','여기를 클릭하세요',context='한국어 규칙: 여기를 클릭하세요')
doc(5,'1-KyOTzrXpZehx7R_eMAmh-9VCyEDxTIPjDN0CUmS-bs','River Black Rules')
file(6,'1L-Uwv9pBr5sKNronJ7KY0kO1ULrUi2uG','[Hocken rules]')
doc(7,'1thmkgpLcRmNKOgr-R14ECtB1a9d8duXG3PhhnVWdhVE','V1 Living Rulebook',version='V1')
doc(7,'1Y9mkFuSlDWGUcqKJ8UbJbOM80r-Z4i6A7Xd7Xh3qyGM','V2 Living Rulebook',version='V2')
doc(8,'1D1ukrpzy71AAWczZF-CA4BzcPc6hmuZUo1VucMg64Lo','Beanstalks',tail='/edit?tab=t.0',context='Rules V4',version='V4')
doc(9,'1uf-xCAnACizWIgD800YhlI-T4OfFnjS1HgiuYCeXhDQ','V1.0 Complete',context='RULES',version='V1.0')
doc(12,'1DwzXzS4jFXFktjBk8ocC5XJJDcBGvTU7loRHOnMXUuY','Alchemy',tail='/edit?tab=t.0',context='Rules (V4)',version='V4')
link(13,'https://buymeacoffee.com/kintsugigames/e/532280','Rules available here')
doc(14,'1Qdv-TOTUEjOVO_nJFp9d_wHr0kA_P3njClCsTVcTUaM','2 Player',context='Google Docs Living Rulebooks: v1.3 2 Player',version='v1.3')
doc(14,'1scvGCsb-X1u9ewv2lmbW57WuiUucXN9wGoiBcfahFCw','4 Player',context='Google Docs Living Rulebooks: v0.6 4 Player',version='v0.6')
link(15,'https://drive.google.com/drive/folders/1ShbRBx87YpaahkeyVeKB4sjjFfJkviBA?usp=sharing','here',context='Rules Available here v1.4 (A4 and Letter sizes); 2-Player rule book is in a separate file within the PnP folder',version='v1.4')
link(15,'https://playingcards.io/7gr9rz','https://playingcards.io/7gr9rz','online_play','Online implementation - COMPLETED')
file(16,'1vNnrbKwBIWja1njaWq2R_unjeelLzt6q','Rulebook',tail='/view?usp=drive_link',version='V1.0 - updated 09-15-25')
doc(17,'19BrxfnzU8p5EcFX9C-llE3LPIq1-PEHyoAkAHC7Py-o','Court & Crown Rules',tail='/edit?usp=drivesdk',context='view and download the rulebook in English')
link(17,'https://screentop.gg/@DustinGrayGames/courtandcrown','Play Court & Crown Online','online_play')
doc(18,'1jnTGF_hzJd0QLqRE0iq_ztBtCY02C1gA6AD_N2f5Cmw','Undergrowth Rules')
doc(19,'11WxAB63oGKIjbXcjNqLZaC18W_kdjVzOq9fDYLAAVHE','Downloadable Rules (Google Drive)')
file(20,'16S-VJCYXt2Fzrg0mv8EsRJECJwiabtgb','Rules 1.14',version='v1.14 - 2026/09/08')
doc(21,'1iN80s1JVcop7_vi9sfXxv05Z5O9SdVUIHLm-6wS2RzM','Hedgerow Rules')
file(22,'1ueoO4fiWK0VTLIfC7DxrUI_5Fp-6bp1_','Rulebook',tail='/view?usp=drive_link',version='V3.0 - updated 10-11-2025')
doc(23,'1JitgJTgVYDcvJvM1niSdaSM642Re_xnUDcQ6uesKD-8','https://docs.google.com/document/d/1JitgJTgVYDcvJvM1niSdaSM6...',tail='/edit?tab=t',context='RULES Google doc')
link(23,'https://youtu.be/6cGIrlBZBQ4','https://youtu.be/6cGIrlBZBQ4','video','Overview Video link')
link(23,'https://youtu.be/fOje3R-jAdA','https://youtu.be/fOje3R-jAdA','video','Full Playthrough Video link')
link(24,'https://deck.unlessgames.com/olm','Read the rulebook on our site')
link(25,'https://deck.unlessgames.com/jacks-dream/','Read the rulebook on our site')
doc(26,'1WMM_222yQQPz7RfGvYyfZVKFCSXXUYFcpz1aNl_uwig','Council of Dragons rules v0.1',tail='/edit?usp=drivesdk',version='v0.1')
doc(27,'1i9tsLjJrw_bwrknysslihYJxUcd13od0zPR4GPJhl20','FIRE WIP Rulesheet v1.2',version='v1.2')
link(28,'https://boardgamegeek.com/image/9261429/burismiga','Rule Book',context='The Four Winds Rules: Rule Book')
link(28,'https://boardgamegeek.com/image/9261429','',context='Immagine del Rule Book 9261429 ripetuta nel primo post')
doc(31,'1ww-AEXKouZ-IkQTLxyVjD4kVc2hJspgukwO1k31Y8hw','https://docs.google.com/document/d/1ww-AEXKouZ-IkQTLxyVjD4kV...',context='Visit the living Google Document here')
link(31,'https://drive.google.com/drive/folders/1DjkIijRKQ2HpWyjeFxt_k0CCZ2oZ6LMB?usp=drive_link','https://drive.google.com/drive/folders/1DjkIijRKQ2HpWyjeFxt_...',context='Download the PDF directly')
link(31,'https://pocketmod.jocho.sk/','https://pocketmod.jocho.sk','other','Use a pocketmod PDF converter to print the game')
file(32,'1dw6XuKekmgxBnus5gWzcU0HTsPvtkMwT','https://drive.google.com/file/d/1dw6XuKekmgxBnus5gWzcU0HTsPv...',context='Rules (.pdf)')
doc(33,'1l07oUkL_YlABTuZMHuDsoaU_14a-0wfq3yaRYOiwOtA','https://docs.google.com/document/d/1l07oUkL_YlABTuZMHuDsoaU_...',context='The current rules are available here')
doc(34,'1IldS4fl-w9TE51sKnNiMr0hOG_Y6dlD15hBgIz-fiY0','Necromancer v1.0 game rules (google doc)',version='v1.0')
doc(35,'1ObbBUY16D7QLOFszxDibxyUg1GkfAK8pCTCa6-4vE1Y','Rules in english are available here.',tail='/edit?tab=t.0#heading=h.avtj39clj6ps')
file(35,'1EJUXiez43nnpL9c151kfUVjuIaygAZ6_','here',context='french version of this zine; A4 zine, with rules and game board on either side',role='game_files')
link(36,'https://youtu.be/GHq87F2fS-s?si=8CmTC9JtL0FfHRsc','https://youtu.be/GHq87F2fS-s?si=8CmTC9JtL0FfHRsc','audio','Soundtrack for this game[/url]')
doc(37,'1B3QWQxj5LqxcqboXT6KFFsZY-y5r7n9tHh21qQ0szHM','V1.1 Complete',context='RULES',version='V1.1')
file(38,'1--hsiuMiRXz_5ldTNj1eM-KUF0j7sutl','Rules available here',context='can be printed and folded as a trifold brochure')
file(39,'1jR9xLSN-S65eLNyUruicUuaIHRj6JcvY','Shadow Market',context='Rules')
doc(40,'1BPSwDvHFhRHDd-Q4Jeasj-3463rNEdGa8HsOfUldhl4','Sniper',context='Rules')
file(41,'1wTVNQV5DeMUOOdIO9G_PrRIolWXcLNQ_','Rulebook',tail='/view?usp=drive_link')
link(41,'https://www.youtube.com/watch?v=EiJVJbzIT1Y','Tutorial','video','YouTube: Tutorial')
link(42,'https://repiqued-interests.co.uk/games/pippins-aplenty','at this page',context='The full rules, along with example hands, are available at this page')

REQ={}
def req(i,name,qty,raw,kind='standard_deck',level='required',supply='common'):
    REQ.setdefault(i,[]).append(dict(material_kind=kind,name_normalized=name,name_raw=raw,quantity_raw=qty,requirement_level=level,supply_mode=supply,context_raw=raw))
req(1,'mazzo standard senza joker','52','Shuffle the deck with all 52 cards, excluding 2 Jokers.')
req(2,'carte Shore (quadri e picche)',None,'Shuffle Candles (Diamonds ) & Cannons (Spades ) to form the Shore deck.','playing_cards')
req(2,'carte Ocean (cuori e fiori)',None,'Shuffle Treasure Ships (Hearts ) and Pirates (Clubs ) to form the Ocean deck.','playing_cards')
req(3,'mazzo standard',None,'Required Components: Standard deck of playing cards')
req(4,'mazzo standard','52','Components: 52 card deck and enough table space for a 4x4 grid.')
req(4,'spazio sul tavolo','griglia 4x4','Components: 52 card deck and enough table space for a 4x4 grid.','play_space',supply='household')
req(6,'strumento per tenere il punteggio',None,'You will likely need a way to keep score between rounds in a smaller player count game, but I found I was able to play it all in a single round in my 6-player simulated game.','score_tracker','unclear','unspecified')
req(7,'mazzo standard senza joker','52','Use a standard 52-card deck (no Jokers)')
req(7,'cut marker per giocatore','1 per giocatore','Give each player a cut marker card (token, chit, or placeholder to mark a pile)','marker',supply='household')
req(8,'mazzo standard',None,'Components: Traditional deck of playing cards')
req(9,'mazzo standard con joker',None,'Required Components: Traditional deck of playing cards with jokers')
req(10,'mazzo standard','52','One standard deck of 52 cards')
req(11,'mazzo separato in carte rosse e nere',None,'Separate the deck into red cards and black cards.\nFrom the red deck, remove one 2 and one King.\nFrom the black deck, remove one 2 and one Queen.','playing_cards')
req(12,'mazzo standard',None,'Components: Traditional deck of playing cards, pen and paper/device to track progress')
req(12,'penna e carta',None,'Components: Traditional deck of playing cards, pen and paper/device to track progress','writing_tool','alternative','household')
req(12,'dispositivo per tracciare progressi',None,'Components: Traditional deck of playing cards, pen and paper/device to track progress','digital_device','alternative','digital_device')
req(13,'mazzo standard',None,'Components: Traditional deck of regular playing cards')
req(14,'mazzo standard senza joker','1 / 52 carte','1 standard 52-card deck (no Jokers)')
req(14,'segnalini doppia faccia','9','9 double-sided tokens (Heads/Tails)','marker')
req(14,'griglia numerata','9 spazi','Optional: 9-space grid (numbered 1–9)','play_space','optional','unspecified')
req(14,'regole e aiuto giocatore stampati',None,'Optional: printed rules and player aid','player_aid','optional','printable')
req(15,'mazzo standard con joker',None,'Required Components: Traditional deck of playing cards with jokers.')
req(17,'mazzo standard','1','1 Traditional Deck of Cards')
req(18,'mazzo standard','52','Plays in 10-15 minutes for a single player using only a traditional deck of 52 cards, and a handful of generic tokens.')
req(18,'segnalini generici','una manciata','Plays in 10-15 minutes for a single player using only a traditional deck of 52 cards, and a handful of generic tokens.','marker')
req(19,'mazzo standard senza joker','52 (4-5p); un seme rimosso (3p)','4-5 players: Use a full 52-card deck (no Jokers)\n3 players: Remove one entire suit (e.g., Clubs) and Jokers')
req(20,'joker / contatori danno',None,'. 2026/09/08 - v1.14 : Added a precision about the Jokers/damage counters being carry over through all stages, not being reseted. Thanks Seong Hun Jeong !','marker','unclear','unspecified')
req(21,'mazzo standard',None,'Hedgerow is a game for 1-2 players, where players create lush hedges teeming with life in a head to head drafting and tableau building contest using only a standard deck of cards. Plays in 20 minutes.')
req(23,'mazzo standard',None,'Required Components: Standard deck of playing cards')
req(24,'mazzo standard',None,'This is a TCG-like combat game for a standard deck of playing cards and two players.')
req(27,'mazzo standard',None,'The single-player and two-player co-op modes use only the traditional deck of playing cards. For 3+ players, the addition of two D4 dice is required.')
req(27,'dadi d4','2, per 3+ giocatori','For 3+ players, the addition of two D4 dice is required.','randomizer')
req(28,'segnalino (moneta, meeple o altro)','1','Requires a small token to play (can by anything, a coin, meeple, ect)','marker',supply='household')
req(28,'mazzo standard',None,'The entire game can be played with a standard deck of cards, where the Aces, 2s, and 3s of every suit create a map.')
req(29,'mazzo standard con joker','54','Preparation: From a 54 card deck (Jokers in), separate out Ace (1), 2-7 of  and shuffle these. Form a row from the top 7 cards.')
req(30,'mazzo standard',None,'Required Components: Traditional deck of playing cards.')
req(31,'mazzo di carte','1','All that with just single deck of cards.')
req(32,'carte standard',None,'Feuda Rivalia uses standard playing cards to represent the influence of aspiring Lords on rival fiefs operating a feudal economy.')
req(33,'mazzo standard',None,'Components required: Just a standard deck of cards!')
nec='Required Component: Standard deck of cards with two jokers, 1 flippable token (e.g. a coin), pad of paper for scoring'
req(34,'mazzo standard con joker','2 joker',nec)
req(34,'segnalino reversibile (es. moneta)','1',nec,'marker',supply='household')
req(34,'blocco carta per punteggio',None,nec,'score_tracker',supply='household')
req(35,'carte da mazzo standard','valori 1–6','Soluna is a single player divination game, using cards 1 to 6 from a traditional deck.')
req(35,'zine regole e plancia','A4, due lati','It was designed to be distributed as an A4 zine, with rules and game board on either side.','game_sheet','unclear','printable')
req(36,'mazzo ordinario senza joker e figure',None,'1. Grab an ordinary deck of cards\n2. Burn all jokers and face cards')
req(36,'annotazione del punteggio',None,'After you have filled all four hands, you will score and only the hand with the LOWEST score will count. Write that down.','score_tracker',supply='unspecified')
req(37,'mazzo standard',None,'Required Components: Traditional deck of playing cards.')
req(38,'mazzo standard',None,'GRAZER is a solo arcade-inspired card game, fast-paced and playable with a standard deck of cards.')
req(39,'mazzo standard senza joker','52','Components: Standard 52-Card Deck (No Jokers)')
req(40,'mazzo standard senza joker','52','Components: Standard 52 card deck(no jokers).')
req(41,'mazzo standard',None,'Arsenal: Duel of Kings is a fast, tactical 1v1 card-battle game played with a standard deck of cards, where two rival kings face off using weapons, shields, potions, and clever strategy to bring the enemy’s HP from 20 to zero.')
req(41,'dadi d20',None,'Additional Requirement (Optional): D20 Dice or Pencil & Paper for tracking player HP.','randomizer','optional','common')
req(41,'matita e carta',None,'Additional Requirement (Optional): D20 Dice or Pencil & Paper for tracking player HP.','writing_tool','optional','household')
req(42,'mazzo standard',None,'Pippins Aplenty is a 2v2 game playable with a standard pack of cards.')
NOTES={2:'Due mazzi Shore/Ocean costituiti dai semi dichiarati; nessuna quantità standard dedotta.',5:'Solo link alle regole: nessun requisito esplicito.',6:'Metodo di conteggio richiesto condizionalmente per piccoli player count; mezzo non specificato.',10:'Regole nel primo post; nessun URL pertinente.',11:'Regole nel primo post; deck e rimozioni descritte ma nessuna distinta standard esplicita.',14:'Etichetta contest 54 Card punta al Traditional Deck: URL originale preservato. Grid e player aid opzionali.',15:'Manuali solo/2p nella stessa cartella; differenze PCIO dichiarate. Video annunciato senza URL non trattato come disponibile.',16:'Nessun requisito materiale esplicito nel primo post.',20:'v1.14 aggiornata nel 2026; requisito contatori dal changelog, alternativa e quantità non chiarite. Nessun mazzo quantitativo inferito.',22:'Nessun requisito esplicito; data versione 10-11-2025 preservata senza conversione ambigua.',25:'Nessun inventario esplicito: carte e cuscini della descrizione non trasformati in distinta.',26:'Nessun requisito materiale esplicito.',28:'Regole dichiarate in immagine BGG; due forme URL dello stesso ID immagine, non due manuali.',29:'Regole integrate nel post; nessun URL di materiali.',30:'Regole integrate nel post; immagini di esempi escluse.',31:'Pocketmod è strumento di stampa dichiarato, distinto dal PDF del gioco.',35:'Nome Soluna dichiarato da cambiare ma nuovo nome non fornito. Zine francese con regole/plancia, inglese separato.',36:'Regole integrate; unico URL è soundtrack, non manuale. Annotazione del punteggio esplicita senza dedurre penna specifica.',41:'D20 oppure carta/matita sono alternative opzionali, quantità non specificate.',42:'Implementazione online annunciata senza destinazione; riferimenti a giochi ispiratori esclusi.'}

def build():
    baseline=json.loads((TASK/'ROSTER_BASELINE.json').read_text(encoding='utf8'))
    assert len(baseline)==len(POSTS)==len(AUTHORS)==len(TIMES)==42
    with sqlite3.connect(ROOT/'database/pnp_collection.sqlite3') as db:
        titles=dict(db.execute('select id,canonical_title from games'))
    rows=[]
    for i,b in enumerate(baseline,1):
        src=b['resolved_wip_url']+'/article/'+str(POSTS[i-1])+'#'+str(POSTS[i-1])
        resources=[dict(x,host=urlsplit(x['url']).netloc,access_type=('image' if '/image/' in x['url'] else shared.access(x['url']))) for x in LINKS.get(i,[])]
        rows.append(dict(entry_id=b['id'],game_id=b['game_id'],position=i,title=titles[b['game_id']],source_url=src,wip_url=b['resolved_wip_url'],author_raw=AUTHORS[i-1],post_timestamp_raw=TIMES[i-1],checked_at=DATE,wip_status='found',resource_listing_status='observed' if resources else 'none_declared',material_listing_status='observed' if REQ.get(i) else 'none_declared',coverage_scope='first_post_only',outcome='complete',all_first_post_read=True,resources=resources,requirements=REQ.get(i,[]),notes=NOTES.get(i,'Primo post originale letto integralmente; nessun host/file aperto.')))
    return rows

def main():
    rows=build()
    counts=dict(entries=42,complete=42,resource_entries=sum(bool(r['resources']) for r in rows),resources=sum(len({x['url'] for x in r['resources']}) for r in rows),resource_mentions=sum(len(r['resources']) for r in rows),requirement_entries=sum(bool(r['requirements']) for r in rows),requirements=sum(len(r['requirements']) for r in rows))
    payload=dict(task_id='TSK-0055',contest_id=20,checked_at=DATE,coverage_scope='first_post_only',method='42 original first posts rendered in CUA, fully read; authors and timestamps observed. Selected verbatim evidence and exact declared URL forms retained; no external hosts or files opened.',counts=counts,entries=rows)
    (TASK/'EVIDENCE.json').write_text(json.dumps(payload,ensure_ascii=False,indent=2)+'\n',encoding='utf8')
    shared.DATE=DATE;shared.EVIDENCE=EVIDENCE
    sql=shared.sql_for(rows).replace('TSK-0053; first_post_only;','TSK-0055; first_post_only;')
    (ROOT/'catalog/2025-traditional-materials.sql').write_text(sql,encoding='utf8')
    report=['# Traditional Deck Game Design Contest 2025 — materiali','',f'Verifica {DATE}, TSK-0055. [Roster ufficiale](https://boardgamegeek.com/thread/3569158/2025-traditional-deck-game-design-contest): 42 entry, 42 WIP risolti sistematicamente dai componenti dinamici del post Entries. Tutti i primi post originali letti integralmente. Nessun host esterno o file aperto, nessun download.','',f"42/42 letture complete; {counts['resource_entries']} entry con URL pertinenti; {counts['resources']} URL esatti distinti per entry; {counts['resource_mentions']} menzioni; {counts['requirements']} requisiti in {counts['requirement_entries']} entry.",'','Safes, Winner Take All!, Relic Solitaire e Hightower hanno regole nel post senza URL pertinente. This Ol’ Cowboy ha regole nel post e un soundtrack. Assenza di URL o inventario non significa assenza di materiali. Quantità, alternative, versioni e date originali sono dichiarazioni, non disponibilità verificata. The Four Winds usa due URL dello stesso manuale immagine BGG. Pocketmod è uno strumento distinto dai materiali di Cardello.','', '| Entry | Gioco | URL | Requisiti | Note |','|---:|---|---:|---:|---|']
    for r in rows:report.append(f"| {r['entry_id']} | [{r['title']}]({r['source_url']}) | {len({x['url'] for x in r['resources']})} | {len(r['requirements'])} | {r['notes']} |")
    report+=['','Copertura first_post_only e tassonomia provvisoria. Esclusi profili, immagini decorative, feedback su altre entry, fonti di ispirazione e collegamenti al contest. Gli elementi espliciti contenuti nelle regole integrate nel primo post rientrano nella lettura; nessuna integrazione da regole esterne. Evidenze selezionate e metadati originali in [EVIDENCE.json](../'+EVIDENCE.replace(' ','%20')+').','', 'Prossimo passo: eventuale ACQ del solo Traditional Deck 2025 dopo selezione dei giochi e verifica delle condizioni di accesso; nessun controllo periodico ordinario del contest concluso.','']
    (ROOT/'sources/2025-TRADITIONAL-MATERIALS.md').write_text('\n'.join(report),encoding='utf8')
    print(json.dumps(counts))
if __name__=='__main__':main()
