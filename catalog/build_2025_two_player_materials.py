"""TSK-0056: dichiarazioni dei primi post BGG, osservate con CUA."""
import json, sqlite3, hashlib
from pathlib import Path
from urllib.parse import urlsplit
import build_2025_54_card_materials as shared

ROOT=Path(__file__).resolve().parents[1]
TASK=ROOT/'tasks/2026-10-05 - MAT - Two-Player Print and Play Game Design Contest 2025'
DATE='2026-10-05'
EVIDENCE=TASK.relative_to(ROOT).as_posix()+'/EVIDENCE.json'
POSTS=[46242911,46249238,46251145,46254695,46262161,46266487,46273001,46276524,46285534,46295449,46302725,46305655,46331373,46341267,46349021,46352391,46354822,46380478,46384475,46404052,45445403,46374918,46414031,46419943,46426517,46450656,46456076,46481663,46507405,46523984,46529260,46533535,46538761,46540728,46541392,46541817,46542431,46543109,46536425,46508547]
AUTHORS=['PaganPasta','MGribbins','Witchway_Games','Oceans4Ransom','Lschricke','RIchardSDD','dcluley','JewellGames','Lukifer10','isjustdrew','jeffluenza','watch01','Cnote58','hleveillegauvin','nexttwoyougames','Herald Selenay','OfficeTurtle','Slopesofvesuvius','marksball','joe_plays_games','themisplay','RPMgamer','Wildcard Six','Knosh0','Pistols_at_Dawn','StrangeAcre','KevMakesGames','OnurTosun','Leodip','m_frederic','Animalcolm','m_frederic','BeaRes','nascif','flivni','comodinski','r3_a7','bertez','RPMgamer','DuelofFates']
TIMES=['22 giu 2025 (edited)','24 giu 2025 (edited)','24 giu 2025 (edited)','25 giu 2025 (edited)','27 giu 2025 (edited)','28 giu 2025 (edited)','30 giu 2025 (edited)','30 giu 2025 (edited)','3 lug 2025 (edited)','5 lug 2025 (edited)','7 lug 2025 (edited)','8 lug 2025','14 lug 2025 (edited)','16 lug 2025','18 lug 2025','19 lug 2025 (edited)','20 lug 2025 (edited)','26 lug 2025 (edited)','27 lug 2025 (edited)','31 lug 2025 (edited)','8 gen 2025 (edited)','24 lug 2025 (edited)','2 ago 2025 (edited)','3 ago 2025 (edited)','5 ago 2025 (edited)','10 ago 2025 (edited)','11 ago 2025 (edited)','16 ago 2025 (edited)','22 ago 2025 (edited)','26 ago 2025 (edited)','27 ago 2025 (edited)','28 ago 2025 (edited)','29 ago 2025','30 ago 2025 (edited)','30 ago 2025 (edited)','30 ago 2025 (edited)','30 ago 2025 (edited)','30 ago 2025 (edited)','29 ago 2025 (edited)','22 ago 2025 (edited)']
LINKS={}
def link(i,url,label,role='game_files',context=None,version=None):
    LINKS.setdefault(i,[]).append(dict(url=url,label_raw=label,content_role=role,context_raw=context or label,version_raw=version))
def folder(i,ident,label,tail='?usp=sharing',context=None,version=None):
    link(i,'https://drive.google.com/drive/folders/'+ident+tail,label,context=context,version=version)
def file(i,ident,label,role='component',tail='/view?usp=sharing',context=None,version=None):
    link(i,'https://drive.google.com/file/d/'+ident+tail,label,role,context,version)
def doc(i,ident,label,tail='/edit?usp=sharing',context=None):
    link(i,'https://docs.google.com/document/d/'+ident+tail,label,'rules',context)
folder(1,'1v0hVFk9oeCHWVSnMu8X8O0oiiSVepHnX','https://drive.google.com/drive/folders/1v0hVFk9oeCHWVSnMu8X8...',context='PnP & rulebook[v3.0]',version='v3.0')
link(1,'https://playingcards.io/w2xsk6','https://playingcards.io/w2xsk6','online_play','PCIO')
folder(2,'1ruromRGGBtBrTKhdZXmHpilgMRdu0wqD','Constellate PnP and Rule')
link(2,'https://playingcards.io/fy2n8n','PCIO Link','online_play')
link(3,'https://drive.google.com/drive/u/0/folders/11yhMYYgTVK5GMvTaBClejVVMkiyPO3qE','https://drive.google.com/drive/u/0/folders/11yhMYYgTVK5GMvTa...','game_files','files for the 18 cards and a tuck box that includes the game rules')
doc(4,'14yCN9Ng-p42k5Lz1mWzpcEkWqwr8G9EiSYnGaGkTwMk','RULES v1.1','/edit?usp=drive_link')
file(4,'1mUJkgzE-L9z_z0FrCszcvczfawkP8Kd0','PNP v1.1','game_files',version='v1.1')
file(4,'1z1raIISMuTI0I3PfFYhHc0jC37dvqrMA','PCIO','online_play')
doc(5,'1bpTyVhOfDS1zfW29Ms9l5SvxCb3zd7iGZDcz13z4h_g','Lemonade Stand Rules')
link(6,'https://icedrive.net/s/ZwXFCQu9G714tCYuwj4xSygF9aQF','https://icedrive.net/s/ZwXFCQu9G714tCYuwj4xSygF9aQF',context='For PnP files of the gameboard and game rules visit')
folder(7,'1oQrW9v54j3jbb0yoFFhoi9ccNU4W9eXn','Senjin PDF PNP Files')
link(7,'https://boardgamegeek.com/image/9069432','','component','PNP 11x17 File with Board and Pieces')
link(7,'https://boardgamegeek.com/image/9210387','','rules','Rules')
for repeat in range(2):
    for label,ident,role in [('Game Rules','13j3atSXTm5M1jnWPk_NpYZlCU5_pXqzy','rules'),('6 PnP Cards','1Pfr9ShYFUJRsjquCiJ4O3w_zspZPFyJf','component'),('1 PnP Mana Sheet','1H3_58pqD32-wthlg0-BFiRVMWsut3X6w','component')]:
        file(8,ident,label,role,tail='/view')
folder(9,'1MSw6VWTvfPkeZY3Y18Z0JjdMBcFd2mYn','Rezbol trick taking PnP rules and files',tail='?usp=share_link')
link(9,'https://youtu.be/Zx2zrsjQdPM?si=XFpQk34_fDyU0dDF','Video showing how use Print and Play Materials','video')
link(9,'https://youtu.be/PjEJns6Yizc','Video of Rules','video')
link(10,'https://korxsol.com/','korxsol.com',context='Find everything you need to start playing the game at')
link(10,'https://korxsol.base44.app/','Get PRINT AND PLAY FILES HERE')
link(10,'https://korxsol.base44.app/','KORxSOL Game Counter','other','Use the KORxSOL Web App and Game Counter')
folder(11,'1J7Jon2WBxGnKlMvyWWbBYh_LeTwOwpsS','https://drive.google.com/drive/folders/1J7Jon2WBxGnKlMvyWWbB...',context='PnP files (v1.0) and Rulebook (v1.2)',version='PnP v1.0; Rulebook v1.2')
link(11,'https://screentop.gg/@Jeffluenza/CubeWars','Screentop.gg - Cube Wars','online_play','Screentop (v1.0)')
folder(12,'1yohlcOLtvmQSfyyroBWTT7_dDH0gQV_g','https://drive.google.com/drive/folders/1yohlcOLtvmQSfyyroBWT...',tail='',context='Rule and PnP')
folder(13,'1ET8foCJAKjhR9G1dTdhNoF4AIO0YH5-Y','Game Rules and PNP File',tail='?usp=drive_link')
folder(13,'1ET8foCJAKjhR9G1dTdhNoF4AIO0YH5-Y','- Game Board',tail='?usp=drive_link')
link(13,'https://playingcards.io/z44u2x','Playingcards.io','online_play')
folder(15,'1x5sj6iCpEFdXoYimDoqZSeB98U3kkpjq','https://drive.google.com/drive/folders/1x5sj6iCpEFdXoYimDoqZ...',context='Link to PnP Files')
folder(16,'1ZBEinaYX0zZZ9tCOg-ucPlfJI4U_qZli','here!',context='Files available via GoogleDrive; rulebook v1 2025.8.25, low ink PnP v3 2025.8.24',version='rules v1; PnP v3')
link(16,'https://steamcommunity.com/sharedfiles/filedetails/?id=3543471912','here!','online_play','Digital playtesting available via Tabletop Simulator')
file(17,'1iSNz62_37tA95y6A92pnDNQBlJlHZFox','Diskochet v1.04 Cards',tail='/view?usp=drive_link',version='v1.04')
file(17,'1LxRR7DmrFmWMtj4diDMJv0ZFrPYJxZyU','Diskochet v1.04 Rules','rules',tail='/view?usp=drive_link',version='v1.04')
folder(18,'15GA3ACuYANxXveYT8ia0CGq81BSXcudZ','Automon Game Rules',tail='',context='PnP File Location')
doc(19,'1MV1vvV1Aq7ikRU7lF8Y7QQD-akH3ybHmk2fKs6p61lE','https://docs.google.com/document/d/1MV1vvV1Aq7ikRU7lF8Y7QQD-...',context='Here is the rules doc on Google')
link(19,'https://youtube.com/watch?v=FgHkYEFGCXI','How to Play Updated Collapsi: The Shrinking Grid Card Game!','video')
folder(20,'1FBTOp1QdcvDof3Az0LUUWYzBCbw-3xSx','Access the files here',tail='?usp=share_link')
link(21,'https://playingcards.io/@themisplay/under-one-sky','Play in our PlayingCards.io room!','online_play')
link(21,'https://playingcards.io/@themisplay/under-one-sky','https://playingcards.io/@themisplay/under-one-sky','online_play')
link(21,'https://youtube.com/watch?v=N8KSAlr7kAY','Under One Sky - Cardboard Edison (2026)','video')
file(22,'1KSUyDQI35-RciTqh9mWfC2JpggNYl8SA','PAWND PnP Version 0.1','game_files',tail='/view?usp=drive_link',version='0.1; 7/31/25')
file(22,'1VF0prVR1pQKPpMME3nO0ToA4OcrnrmdN','PAWND Rulebook Version 1.0','rules',tail='/view?usp=drive_link',version='1.0; 9/19/25')
link(23,'https://boardgamegeek.com/boardgame/457261/orbits','Orbits','game_files','Game Page: Orbits. Files located in the file section of the Game Page.')
for ident,label,role in [('1RoOxb-bsTSIfCDD9tsgrHMwSQf2SaWqu','cards','component'),('13DG0sL_ycue2vV91WPI8CGlaMdSf7mr6','low ink cards','component'),('1goG9kd1EqpAJnJwuMVtq6N8vx0391iaA','rules ','rules'),('1MbP3Jx2J4-oiWaFRndlhfz9OzgEUE5G8','low ink rules','rules'),('1PflQxaPOhBx3UhmAX8HDnLrvNE479xCh','rules sheet','rules')]:file(24,ident,label,role,version='v1.2')
link(24,'https://playingcards.io/e9r342','playingcards.io','online_play','v1.2 draft cards')
link(24,'https://discord.gg/3bnpgbN3MB','Discord','online_play','Play Virtually ... on my Discord where you can also make your own teams!')
folder(25,'14jgSwxgzVPqIAiEKVTaRh_9l6f5Y4Byk','Download',tail='?usp=drive_link')
link(25,'https://playingcards.io/f4fpq2','https://playingcards.io/f4fpq2','online_play')
link(25,'https://youtube.com/watch?v=HR2JV_AlF5c','5 Spells Playthrough','video')
link(26,'https://airboardgame.net/playgame/V22SMrPneH','Play the Victorian Gothic variant Online','online_play')
link(26,'https://www.strangeacre.games/','Click here to download for free.')
link(27,'https://kevmakesgames.itch.io/submerge','Rules and PnP files are available on itch.io. With an older version as a PCIO version')
for ident,label,role in [('1bzMnMqtXw0AYBZksIl2s0Zy3te_DJE8I','WordStorm_English_PnP_WithRules_600dpi','game_files'),('191kcih76PiiEy2K4WjJl96WLgSJWRqmc','WordStorm_English_Rules_Letter','rules'),('16x-A8Swy2aFNXNyJhsX-U25FslLQyYRJ','WordStorm Turkish Version PnP Pdf','game_files'),('1HmsOOftxj0OtUQJCAqqWT86H_KvQb7El','WordStorm Turkish Rule Book','rules')]:file(28,ident,label,role)
link(28,'https://youtu.be/T-Wxs_wgAVg','Designing a Board Game from Scratch - Part 1 - Creating the Basic Design','video')
link(28,'https://www.youtube.com/playlist?list=PLczPXwIb-s42skQA3WvGhF8ZspiPe4wcM','Designing a Board Game from Scratch - Playlist','video')
folder(29,'1ugTUoDWCoxrdv6ze2hKMLpurKEqTzLNW','Rules & Components available here',tail='?usp=drive_link')
link(29,'https://playingcards.io/qzhfh4','playingcards.io/qzhfh4','online_play')
link(30,'https://playingcards.io/t2tkyz','here!','online_play','Try the game here! (Rules included)')
file(30,'1hwdwiISWDkQxQ78sDgP1oW25kXzBfLpC','OiSH!i Files','game_files')
file(30,'1hBmdGnW5kA8p9D0fo8OPKEoGVY9ogRPz','OiSH!i Rules','rules')
link(30,'https://playingcards.io/t2tkyz','here!','online_play','Digital version: here!')
link(31,'https://www.studiotortu.com/hexbarons','https://www.studiotortu.com/hexbarons','video','QUICKSTART VIDEO')
folder(31,'1M4wnJM0jMsI7PM5ZE_9oLduIKClLPw92','Google Drive direct link',tail='',version='0.7 (August 2025)')
link(31,'https://www.studiotortu.com/hexbarons','https://www.studiotortu.com/hexbarons','other','playtest form available here')
file(32,'1i9btCIhErTPKJ4PatHpFd39pXVwdvC_c','Momentum Files','game_files')
file(32,'1HUncC6J8igKO1nUzkwinsiZxC0kU4LVN','Momentum Rules','rules')
link(32,'https://steamcommunity.com/sharedfiles/filedetails/?id=3562416983','Momentum Workshop','online_play')
file(33,'1CCcHBr-T4gwV_oha6nEx6rX_r7dkbxSt','https://drive.google.com/file/d/1CCcHBr-T4gwV_oha6nEx6rX_r7d...','rules',tail='/view?usp=drive_link',context='Download the Rules here')
file(33,'1Wlx_4NuvcZqWclDPzuupjlAcKduTobTs','https://drive.google.com/file/d/1Wlx_4NuvcZqWclDPzuupjlAcKdu...',tail='/view?usp=drive_link',context='Download the Prints here')
file(33,'1WuSvwBDoKOdStgxipqq_Z1JdLYbvJIWE','https://drive.google.com/file/d/1WuSvwBDoKOdStgxipqq_Z1JdLYb...',tail='/view?usp=drive_link',context='Download Optional Prints here')
link(34,'https://www.dropbox.com/scl/fo/9azudq0zl95cfjzgnlmzi/AOFb-LJOOuUNHKC1EOM7a18?rlkey=ur9ttqx06j7mbdndtkr956353&st=1hdwc8nq&dl=0','here',context='PnP files - board, pieces, rulebook, and summary sheet')
link(35,'https://flivni.github.io/narrow-seas/','Living Rules','rules')
link(35,'https://narrowseas.short.gy/pnp','narrow-seas.zip')
folder(36,'1PA2JLM7nQ_w07oCbb0GYkZLgD37-OC-9','Rules v.2.1, Components v.2.0',tail='',version='Rules v.2.1; Components v.2.0')
folder(37,'15eZO0eAUFkdJTqznByIYJPm7KD-Ocv28','Rule sheet + all components (playtest-ready)',tail='?usp=drive_link')
link(37,'https://airboardgame.net/playgame/npB2BbeTQR','Airboardgame link - to play online','online_play')
file(37,'1uGyhv7I_amU2QZJK6dW-5uVALZ0wcNv5','2.1 Components - 72 Flower Tiles - 1.9 cm.pdf',tail='/view?usp=drive_link',version='2.1; 11.09.2025')
doc(38,'1BQ3PjpWP0aXcCJLwHNGwTU7QpfUHw9ZIsjs4FpSqWMs','Rules','/edit?tab=t.0')
file(38,'1wkvDK04YXbbUUdBPoilLXpHbFWOS59ra','PNP','game_files')
link(38,'https://screentop.gg/@Bertez/Clouds-EdgeV4','Online Implementation (Screentop)','online_play','This version is more experimental and as a result might not match the PNP')
for ident,label,role in [('13ihp6ds8jr4ZrrqReoGXBk9ZpQ76SBYB','GRDNN Board, Tokens, Pawns PnP v0.0 (last updated 8/30/25)','game_files'),('1V9SK_I_8tjBbEfhm8eLwAhvLL9BBuYvf','GRDNN Scoring Cards v0.0 (last updated 8/30/25)','component'),('10fLtSDisLmi_w2G8k6mnEVL_aBrruUt8','GRDNN Rulebook v0.0 (last updated 8/30/25)','rules')]:file(39,ident,label,role,tail='/view?usp=drive_link',version='v0.0; 8/30/25')
link(40,'https://docs.google.com/document/d/1H3BZQUV29SPdSESLYoKHWa3d8nJlMVNd/edit?usp=sharing&ouid=110647625382493989607&rtpof=true&sd=true','Score Card','component')
doc(40,'1ZuBPO_5uwGq5UopzTe-8_5eJQevkfa3x0Blo4rH3J84','Rule Book',context='Two rulebooks in this file; original with updates and faster New Rulebook')

REQ={}
def req(i,name,qty,raw,kind='component',level='required',supply='unspecified'):
    REQ.setdefault(i,[]).append(dict(material_kind=kind,name_normalized=name,name_raw=raw,quantity_raw=qty,requirement_level=level,supply_mode=supply,context_raw=raw))
req(2,'tessere 2x2 pollici','280 / 24 pagine','280 tiles (laid out over 24 pages)','tile',supply='printable')
req(2,'segnalini giocatore','8','8 playertokens','marker',supply='printable')
req(2,'regole fronte retro','1 pagina','Complete rules (on a single double-sided page)','rulebook',supply='printable')
req(3,'carte','18','files for the 18 cards and a tuck box that includes the game rules','playing_cards',supply='printable')
req(3,'tuck box con regole',None,'files for the 18 cards and a tuck box that includes the game rules','storage',level='unclear',supply='printable')
req(4,'carte','18','Mush Puppies {2 players | 8+ ages | 15 minutes | 18 cards}','playing_cards',supply='printable')
for name,qty,raw,kind in [('cubi gialli','12','12 yellow cubes (lemonade)','cube'),('tessere piccole','4','4 small tiles (lemonade slush)','tile'),('gemme blu','3','3 blue gems (ice cubes)','marker'),('monete','12','12 coins','coin')]:req(5,name,qty,raw,kind,supply='common')
req(5,'d6 variante solo','1','1 standard D6 for the solo variant','dice','optional','common')
for name,qty,raw,kind in [('d6','1','1 D6 Dice','dice'),('segnalino palla','1','1 small token for the ball','marker'),('segnalino tempo','1','1 small token for the time token','marker'),('segnalini punteggio','2','2 small tokens for the team score track tokens','marker')]:req(6,name,qty,raw,kind,supply='common')
req(6,'tabellone',None,'For PnP files of the gameboard and game rules visit','board',supply='printable')
req(7,'tabellone e pezzi 11x17',None,'PNP 11x17 File with Board and Pieces','board',supply='printable')
req(8,'carte','6','6 PnP Cards','playing_cards',supply='printable')
req(8,'foglio mana','1','1 PnP Mana Sheet','sheet',supply='printable')
for name,raw,kind in [('d20 o contatore colpi','D20 or Hit Counter','score_tracker'),('d3 o d6','D3 or D6 Dice','dice'),('flip token o moneta','Flip Token or Quarter','marker'),('segnalino giocatore','Player Token','marker')]:req(10,name,None,raw,kind,'alternative','common')
req(10,'app contatore',None,'Use the KORxSOL Web App and Game Counter : KORxSOL Game Counter','digital_device','alternative','digital_device')
req(11,'carte','18','18 cards','playing_cards',supply='printable')
req(11,'d6','24','24 D6 dice - can be any color, but helpful to have 2 green, 2 orange, 2 blue of the 24','dice',supply='common')
req(11,'cubi 8mm in dieci colori','100 dichiarati; somma elenco 100','100 8mm cubes of 10 colors:\n> 26 of a player color (Red)\n> 26 of a player color (Blue)\n> 18 White\n> 6 Gray\n> 4 Black\n> 4 Pink\n> 4 Purple\n> 4 Orange\n> 4 Green\n> 4 Yellow','cube',supply='common')
req(12,'mazzi standard','2','1V1 with two standard card deck.','standard_deck',supply='common')
req(13,'dadi di quattro colori','4','4 dice: 1 each in 4 different colors','dice',supply='common')
req(13,'pedine o segnalini','3','3 pawns or markers (I use marshmallows, winner gets to eat \'em).','marker',supply='household')
req(13,'tabellone',None,'- Game Board','board',supply='printable')
req(15,'documenti Letter','2','Two Letter Size Documents','sheet',supply='printable')
req(15,'segnalini stampabili',None,'Printable and Cuttable Tokens','marker',supply='printable')
req(15,'dischi piccoli','6 / 3 per colore','6 Discs (2 colors of 3)','marker','optional','common')
req(15,'dischi più grandi','2 / 1 per colore','2 Slightly larger discs (2 colors of 1 that match the same colors of the smaller discs)','marker','optional','common')
for name,qty,raw,kind in [('Household Omens','9','9 Household Omens (double-sided 2-inch square cards):','playing_cards'),('Omen Effect Cards','9','9 Household Omen Effect Cards (double-sided poker-sized cards):','playing_cards'),('Tarot Cards','36','36 Tarot Cards: (double-sided tarot-sized cards; * indicates a Player’s Starting Tarot Cards)','playing_cards'),('Good Luck Charms','3','3 Good Luck Charms (double-sided 2-inch square cards)','playing_cards'),('Hex Breakers','3','3 Hex Breakers (double-sided 2-inch square cards)','playing_cards'),('Hold Tokens','3','3 Hold Tokens (custom cardstock/cardboard components)','marker'),('Household Omens board','1','1 Household Omens board (custom game board)','board'),('Tarot Tableau playerboards','3','3 Tarot Tableau playerboards (custom playerboards- there are separate Right and Left boards, for now, simply print a duplicate of EITHER to include a third player)','board'),('Talking Spirit Board','1','1 Talking Spirit Board (custom game board)','board'),('Name Title and Instruction Tile','1','1 Name Title and Instruction Tile (custom tile/board)','tile'),('Planchette','1','1 Planchette (custom cardstock/cardboard component)','component'),('Lock Tokens','9','9 Lock Tokens (custom cardstock/cardboard components)','marker')]:req(16,name,qty,raw,kind,supply='printable')
req(16,'moneta','1','1 Coin (Players can supply a coin of their choice, I use a U.S. Quarter.)','coin',supply='common')
req(16,'d6 personalizzati 0-0-1-1-2-2','2','2 Custom dice (both d6s with sides labelled 0-0-1-1-2-2)','dice','alternative','specialized')
req(16,'d6 standard sostitutivi','2','Players can substitute regular d6s and agree to count 1-2 as a 0, 3-4 as a 1, and 5-6 as a 2.','dice','alternative','common')
req(16,'segnalini fortuna bianchi','50','50 White/Good Luck Tokens (Not Included in the PNP! Bingo chips are recommended, but players can substitute with\ncubes, coins, tokens, candy, etc.)','marker',supply='household')
req(16,'segnalini sfortuna neri','50','50 Black/Bad Luck Tokens (Not Included in the PNP! Bingo chips are recommended, but players can substitute with\ncubes, coins, tokens, candy, etc.)','marker',supply='household')
req(16,'sacchetto','1','1 Draw Bag (Not Included in the PNP!)','bag',supply='household')
req(16,'bicchieri o ciotola divisa','2 / una ciotola divisa','2 Supply/Discard Cups (Not Included in the PNP! Players can use separate cups or they can use a divided bowl. Note that the cups/divided bowl only need(s) to be large enough to fit whatever White and Black Tokens the players are using.)','container',supply='household')
for name,qty,raw in [('bustine poker','9','9 Standard/Poker Card Sleeves (for the Household Omen Effect Cards)'),('bustine quadrate','15','15 Square Card Sleeves (for the 9 Household Omens, 3 Good Luck Charms, and 3 Hex'),('bustine tarot','24-36','24-36 Tarot-Size Sleeves (24 Tarot Cards for a 2-Player Game; 36 Tarot Cards for a 3-Player Game)')]:req(16,name,qty,raw,'sleeve','optional','common')
req(17,'carte paddle fronte retro','9','Components: 9 paddle cards (back to back), five disks (or coins)','playing_cards',supply='printable')
req(17,'dischi o monete','5','Components: 9 paddle cards (back to back), five disks (or coins)','marker',supply='household')
for name,qty,raw,kind in [('d6 neri','6','6 Black D6 Automon robot dice','dice'),('d6 rossi','3','3 Red D6 Command dice, 1 red Command gem, 1 red Meeple','dice'),('gemma rossa','1','3 Red D6 Command dice, 1 red Command gem, 1 red Meeple','marker'),('meeple rosso','1','3 Red D6 Command dice, 1 red Command gem, 1 red Meeple','pawn'),('d6 bianchi','3','3 White D6 Command dice, 1 transparent Command gem, 1 white Meeple.','dice'),('gemma trasparente','1','3 White D6 Command dice, 1 transparent Command gem, 1 white Meeple.','marker'),('meeple bianco','1','3 White D6 Command dice, 1 transparent Command gem, 1 white Meeple.','pawn'),('gemme gialle','2','2 Yellow Initiative Gems','marker'),('segnalino primo giocatore','1','A First Player Marker','marker'),('scacchiera','1','A chess board','board')]:req(18,name,qty,raw,kind,supply='common')
req(19,'mazzo standard',None,'Collapsi is an abstract game that uses a regular deck of cards and anything available for pawns.','standard_deck',supply='common')
req(19,'pedine sostitutive',None,'Collapsi is an abstract game that uses a regular deck of cards and anything available for pawns.','pawn',supply='household')
req(20,'tabellone A4','1','1 A4 game board','board',supply='printable')
req(20,'penna o matita',None,'Pencil or pen, recommended different colour per player.','writing_tool',supply='household')
req(22,'griglia sostitutiva 9x9','1','I strongly recommend using your own substitute grid, pawns, and checkers/tokens for best result. You can use a checker board if you place pieces on the intersections instead of inside the square spaces, to create the required 9x9 grid','board','alternative','common')
req(22,'pedine e segnalini sostitutivi',None,'I strongly recommend using your own substitute grid, pawns, and checkers/tokens for best result.','marker','alternative','common')
req(23,'astronavi giocatore','4 per giocatore','Orbits is a two player race game where players will move their four racers across a grid to other side while collecting eight objectives.','pawn')
for name,qty,raw in [('carte Law','8','8 Law unit cards'),('carte Bandit','8','8 Bandit unit cards'),('carte riferimento giocatore','2','2 player reference cards (pending)')]:req(24,name,qty,raw,'playing_cards',supply='printable')
req(25,'carte stampate','2 pagine','The cards requrie two pages to print and the rule book is 2 pages.','playing_cards',supply='printable')
for name,qty,kind in [('tessere','58','tile'),('segnalini rossi','20','marker'),('segnalini blu','20','marker'),('segnalino primo giocatore',None,'marker'),('tabellone',None,'board'),('aiuti giocatore',None,'player_aid')]:req(26,name,qty,'Components: 58 tiles, 20 red & 20 blue tokens, 1st Player marker, Game Board, Player Aids + Rule book',kind)
req(26,'scacchiera sostitutiva','5x5; 6x6 espansione 3-4 giocatori','You can use any checkerboard with a 5 x 5 or 6x6 for the 3-4 player expansion if you want to & feel free to use your own tokens if you have some.','board','alternative','common')
req(26,'adesivi colorati per retro',None,'You could also use coloured stickers for the tile backs in the appropriate colours which would save on coloured ink.','assembly_tool','optional','household')
req(27,'carte','18','18 Cards','playing_cards',supply='printable')
req(27,'segnalini','12 / 6 per giocatore','12 tokens, 6 per player','marker')
req(28,'carte vuote personalizzabili','4',"I've also added four blank cards to spice up the game. You can create any letter and rule you like!",'playing_cards','optional','printable')
req(29,'carte','16',"Frogs Feud is an abstract game with a randomized setup that only requires 16 cards and 4 pawns in 2 different colors (8 total pawns), and the cards themselves don't need to be heavily shuffled or kept secret, so it could even be printed on normal printing paper.",'playing_cards',supply='printable')
req(29,'pedine due colori','8 / 4 per colore',"Frogs Feud is an abstract game with a randomized setup that only requires 16 cards and 4 pawns in 2 different colors (8 total pawns), and the cards themselves don't need to be heavily shuffled or kept secret, so it could even be printed on normal printing paper.",'pawn',supply='common')
req(30,'carte','25','Only 25 tasty cards to play!','playing_cards',supply='printable')
for name,qty,kind in [('set di dadi','2','dice'),('mazzo di carte','1','standard_deck'),('matita','1','writing_tool'),('pagine bianco nero','4','sheet')]:req(31,name,qty,'To get started with the quickstart rules, all you need are 2 sets of dice, a deck of cards, a pencil, and only 4 b&w printed pages - no cutting or assembly required!',kind,supply='printable' if kind=='sheet' else 'common')
req(32,'d6','6','Six 6-sided dice','dice',supply='common')
req(32,'piccoli oggetti holds','10','10 small objects used as "holds" to place on the cards','marker',supply='household')
req(34,'pezzi','16 per giocatore','Each side plays with 16 pieces of different types, including Berserkers, Chieftains, and Shieldmaidens.','pawn',supply='printable')
for name,qty,raw,kind,level in [('carte azione','21','card_fronts.pdf - 21 action cards + 4 ship cards, wind direction token, ship & crew tokens (4 pages)','playing_cards','required'),('carte nave','4','card_fronts.pdf - 21 action cards + 4 ship cards, wind direction token, ship & crew tokens (4 pages)','playing_cards','required'),('segnalino vento e segnalini nave/equipaggio',None,'card_fronts.pdf - 21 action cards + 4 ship cards, wind direction token, ship & crew tokens (4 pages)','marker','required'),('tabellone','1 pagina','board.pdf (1 page)','board','required'),('segnalino primo giocatore',None,'first_player_marker.pdf','marker','optional'),('retro carte',None,'card_backs.pdf','playing_cards','optional')]:req(35,name,qty,raw,kind,level,'printable')
for name,qty,raw in [('carte Artwork','18','18 Artwork cards (Poker size)'),('carte Artist','36','36 Artist cards (Half poker size)'),('carte Stuff','70','70 Stuff cards (small squares)')]:req(36,name,qty,raw,'playing_cards',supply='printable')
req(37,'tessere Flower','72 / 1.9 cm','2.1 Components - 72 Flower Tiles - 1.9 cm.pdf','tile',supply='printable')
req(39,'griglia Garden','7x7','The game is played on a 7 x 7 Garden grid, and uses 7 Flower tokens in 7 different colors as well as 16 mini Scoring cards.','board',supply='printable')
req(39,'Flower tokens','7 in 7 colori (formulazione originale)','The game is played on a 7 x 7 Garden grid, and uses 7 Flower tokens in 7 different colors as well as 16 mini Scoring cards.','marker',supply='printable')
req(39,'carte Scoring','16','The game is played on a 7 x 7 Garden grid, and uses 7 Flower tokens in 7 different colors as well as 16 mini Scoring cards.','playing_cards',supply='printable')
req(39,'pedine giocatori e Groundskeeper','2 giocatori + 1 neutra','Each player has a single pawn which they move on their turn to collect flowers. The Groundskeeper is represented by a neutral pawn that is moved by each player on their turn.','pawn',supply='printable')
req(40,'moneta','1','You will need the following documents 1 coin and 6 dice in total.','coin',supply='common')
req(40,'dadi','6','You will need the following documents 1 coin and 6 dice in total.','dice',supply='common')

# Inventari espliciti di documenti e componenti, oltre ai requisiti aggiuntivi.
req(16,'regolamento',None,'Rulebook','rulebook',supply='printable')
req(20,'regole',None,'- Rules','rulebook',supply='printable')
req(25,'regolamento','2 pagine','The cards requrie two pages to print and the rule book is 2 pages.','rulebook',supply='printable')
req(26,'regolamento',None,'Components: 58 tiles, 20 red & 20 blue tokens, 1st Player marker, Game Board, Player Aids + Rule book','rulebook')
for name,kind in [('Rulebook','rulebook'),('Squad Sheets','sheet'),('Scenario Maps','board'),('Sigil Cards','playing_cards')]:req(31,name,None,name,kind,supply='printable')
req(31,'fogli squadra e mappe vuoti',None,'Blank squad sheets and scenario maps to create your own','sheet','optional','printable')
for name,kind in [('board','board'),('rulebook','rulebook'),('summary sheet','player_aid')]:req(34,name,None,'Status: PnP files - board, pieces, rulebook, and summary sheet are available here.',kind,supply='printable')
req(36,'fogli A4 low ink','6','6 single sided A4 sheets (Low Ink version)','sheet',supply='printable')
req(11,'colori cubi sostituibili',None,'Note: You can use any colors you want realistically - just as long as there are enough distinct colors.','cube','alternative','common')

NOTES={7:'Immagini esplicitamente etichettate PNP 11x17 e Rules; mockup escluso. Vecchio WIP citato come provenienza, non letto.',9:'Cartella ancora etichettata Rezbol; video dichiarati un poco obsoleti.',11:'Colori sostituibili; conteggio cubi dichiarato 100 ma somma delle dieci righe 100? Verificare: 26+26+18+6+6*4=100.',14:'Primo post originale di GiantLeapGames non osservabile. Primo articolo residuo di hleveillegauvin: I love the artwork! Nessuna assenza di risorse inferita.',16:'Original Edition dal 1-1-2026; gratuità dichiarata per durata contest, condizioni attuali non verificate. Regole v1/PnP v3, low ink, materiali domestici e alternative separati.',17:'Primo post corrente: cinque dischi o monete. Roster storico: un disco e due dadi; dichiarazioni non fuse.',21:'Primo post aggiornato con PCIO/video 2026 e Kickstarter; nessun link PnP dichiarato attualmente, promozioni escluse.',23:'Pagina BGG esplicitamente indicata come luogo dei file; link dinamico risolto. Video promozionale del marchio escluso.',24:'Carte riferimento indicate pending ma To Do le segna completate: entrambe dichiarazioni preservate.',29:'Primo post ora Frogs Feud; roster e titolo canonico storico Pond Pals preservati.',32:'Primo post ora Messenger Momentum; nome storico Momentum preservato.',38:'Screentop sperimentale può differire dal PnP.',39:'Quantità Flower tokens conservata letteralmente, senza dedurre 49.'}

def build():
    NOTES[11]='Colori dei cubi sostituibili; 100 cubi dichiarati e somma delle dieci righe coerente (26+26+18+6+24=100).'
    rows=[]
    for i,b in enumerate(json.loads((TASK/'ROSTER_BASELINE.json').read_text(encoding='utf8')),1):
        thread=b['wip_thread_url'].split('/thread/')[1].split('/')[0]
        resources=[dict(x,host=urlsplit(x['url']).netloc,access_type=shared.access(x['url'])) for x in LINKS.get(i,[])]
        rows.append(dict(entry_id=b['id'],game_id=b['game_id'],position=b['position'],title=b['canonical_title'],source_url=f'https://boardgamegeek.com/thread/{thread}/article/{POSTS[i-1]}#{POSTS[i-1]}',wip_url=b['wip_thread_url'],author_raw=AUTHORS[i-1],post_timestamp_raw=TIMES[i-1],checked_at=DATE,wip_status='found',resource_listing_status='not_observable' if i==14 else 'observed' if resources else 'none_declared',material_listing_status='not_observable' if i==14 else 'observed' if REQ.get(i) else 'none_declared',coverage_scope='first_post_only',outcome='blocked' if i==14 else 'complete',all_first_post_read=i!=14,resources=resources,requirements=REQ.get(i,[]),notes=NOTES.get(i,'Primo post originale letto integralmente; risorse dichiarate non verificate.')))
    return rows

def sql_for(rows):
    # Riutilizzo del serializzatore, con costanti e stati del lotto corrente.
    shared.DATE=DATE;shared.EVIDENCE=EVIDENCE
    sql=shared.sql_for(rows).replace('TSK-0053','TSK-0056')
    # Il serializzatore storico attestava sempre complete: Parry è bloccato.
    sql=sql.replace("'materials','complete','2026-10-05','https://boardgamegeek.com/thread/3542787/", "'materials','blocked','2026-10-05','https://boardgamegeek.com/thread/3542787/")
    return sql

def main():
    rows=build();counts=dict(entries=len(rows),complete=sum(r['outcome']=='complete' for r in rows),blocked=sum(r['outcome']=='blocked' for r in rows),resource_entries=sum(bool(r['resources']) for r in rows),resources=sum(len({x['url'] for x in r['resources']}) for r in rows),resource_mentions=sum(len(r['resources']) for r in rows),requirement_entries=sum(bool(r['requirements']) for r in rows),requirements=sum(len(r['requirements']) for r in rows))
    payload=dict(task_id='TSK-0056',contest_id=18,checked_at=DATE,coverage_scope='first_post_only',method='Rendered first posts in CUA; original author and timestamps checked; selected verbatim declarations, no external hosts or files opened.',counts=counts,entries=rows)
    (TASK/'EVIDENCE.json').write_text(json.dumps(payload,ensure_ascii=False,indent=2)+'\n',encoding='utf8')
    (ROOT/'catalog/2025-two-player-materials.sql').write_text(sql_for(rows),encoding='utf8')
    report=['# Two-Player Print and Play Game Design Contest 2025 — materiali','',f'Verifica {DATE}, TSK-0056. [Roster ufficiale](https://boardgamegeek.com/geeklist/359588/2025-two-player-pnp-game-design-contest-entries): 41 item, intestazione esclusa, 40 giochi su due pagine riconciliati. Copertura first_post_only; 39 primi post originali completi, Parry non osservabile. Nessun host esterno/file aperto o download.','',json.dumps(counts,ensure_ascii=False),'','URL identici accorpati per gioco, menzioni e funzioni preservate. Le quantità sono dichiarative e non costituiscono inventario delle regole esterne. Tassonomia provvisoria. Le versioni del primo post corrente possono essere successive al contest; nomi storici preservati.','', '| Entry | Gioco | Esito | URL | Requisiti | Note |','|---:|---|---|---:|---:|---|']
    for r in rows:report.append(f"| {r['entry_id']} | [{r['title']}]({r['source_url']}) | {r['outcome']} | {len({x['url'] for x in r['resources']})} | {len(r['requirements'])} | {r['notes']} |")
    report+=['','Evidenze selezionate, versioni, etichette e requisiti in [EVIDENCE.json](../'+EVIDENCE.replace(' ','%20')+'). Profili, crediti, promozioni, riferimenti al contest e immagini illustrative esclusi. Senjin: immagini associate esplicitamente a PNP 11x17 e Rules conservate come dichiarazioni, senza verifica del contenuto o download. Orbits: nessun file BGG aperto.','', 'Prossimo passo: eventuale ACQ dedicato al solo Two-Player 2025 dopo selezione dei giochi; condizioni/host restano da verificare. Parry richiede recupero del post originale o fonte alternativa autorizzata. Nessun monitoraggio ordinario del contest concluso.','']
    (ROOT/'sources/2025-TWO-PLAYER-MATERIALS.md').write_text('\n'.join(report),encoding='utf8')
    print(json.dumps(counts))

if __name__=='__main__':main()
