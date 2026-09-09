-- Censimento completo del 2025 Solomode Contest, contest adiacente di varianti dipendenti.
-- Verifica: 2026-09-09. Solo metadati BGG; nessun regolamento o componente aperto/scaricato.

BEGIN IMMEDIATE;

UPDATE contests
SET entries_url='https://boardgamegeek.com/geeklist/353866/2025-solomode-design-contest-submissions/',
    results_url='https://boardgamegeek.com/thread/3470244/article/46281057#46281057',
    status_raw='The results are in!', status_normalized='complete', last_verified_at='2026-09-09'
WHERE id=16;

UPDATE contest_sources SET last_verified_at='2026-09-09' WHERE contest_id=16;

INSERT INTO contest_sources
 (id,contest_id,kind,url,label,bgg_object_type,bgg_object_id,is_official,first_seen_at,last_verified_at)
VALUES
 (41,16,'results_post','https://boardgamegeek.com/thread/3470244/article/46281057#46281057','Official results','article',46281057,1,'2026-09-09','2026-09-09');

INSERT INTO contest_phases
 (contest_id,phase_type,label_raw,sequence_number,status_raw,status_normalized,starts_at,ends_at,timezone,date_precision,source_url,first_seen_at,last_verified_at,notes)
VALUES
 (16,'results','Results',5,'Results published July 1, 2025','complete','2025-07-01','2025-07-01','PST','day','https://boardgamegeek.com/thread/3470244/article/46281057#46281057','2026-09-09','2026-09-09',NULL);

INSERT INTO contest_checks
 (id,contest_id,checked_at,source_url,check_kind,outcome,notes)
VALUES
 (37,16,'2026-09-09','https://boardgamegeek.com/geeklist/353866/2025-solomode-design-contest-submissions/','manual_web_census','complete','Snapshot completo delle 38 proposte presenti nella GeekList ufficiale e dei 55 piazzamenti pubblicati. Tutte sono varianti dipendenti da un gioco base; nessun materiale di gioco aperto.');

INSERT INTO contest_status_history
 (contest_id,check_id,status_raw,status_normalized,effective_at,observed_at,source_url,confidence,notes)
VALUES
 (16,37,'The results are in!','complete','2025-07-01','2026-09-09','https://boardgamegeek.com/thread/3470244/article/46281057#46281057','high','Risultati ufficiali pubblicati dall’organizzatore.');

CREATE TEMP TABLE solomode_2025_import (
 position INTEGER PRIMARY KEY,
 title TEXT NOT NULL,
 raw_title TEXT NOT NULL,
 designer TEXT,
 bgg_username TEXT,
 geeklist_item_id INTEGER NOT NULL,
 wip_thread_url TEXT,
 base_game TEXT NOT NULL
);

INSERT INTO solomode_2025_import VALUES
 (1,'Florek & Florka','"FLOREK & FLORKA the Automas" - Artificial Opponents for a 2-4p competitive game - (an alternative solo variants)','Janusz Kuśnierek','janciorules',11576881,'https://boardgamegeek.com/thread/3454362/florek-and-florka-the-automas-artificial-opponents','Floriferous'),
 (2,'Enchanted Forest Solo Variant','[2025 Solomode] Enchanted Forest solo variant','Karen Robinson','KarenSDR',11579668,'https://boardgamegeek.com/thread/3406119/2025-solomode-enchanted-forest-solo-variant','Enchanted Forest'),
 (3,'Sabi','[2025 Solomode] Sabi solo mode for Kintsugi','Michiel de Wit','michieldewit',11580904,'https://boardgamegeek.com/thread/3466096/2025-solomode-sabi-solo-mode-for-kintsugi','Kintsugi'),
 (4,'Humanoid Monsters Have Brains','[2025 Solomode] Quest for the Lost Pixel "Humanoid monsters have brains"','Thierry Gantier','thierry2015',11582552,'https://boardgamegeek.com/thread/3471610/2025-solomode-quest-for-the-lost-pixel-humanoid-mo','Quest for the Lost Pixel'),
 (5,'War Against the Chtorr - Psionic Corps','[2025 Solomode] Warfighter Chtorr "War Against the Chtorr - Psionic Corps"','Thierry Gantier','thierry2015',11582581,'https://boardgamegeek.com/thread/3471614/2025-solomode-warfighter-chtorr-war-against-the-ch','Warfighter: A Chtorr Special Forces Card Game'),
 (6,'Junk Punk','[2025 Solomode] Radlands Solo Automa "Junk Punk"','Evenger X','EvengerX',11585492,'https://boardgamegeek.com/thread/3446309/2025-solomode-radlands-solo-automa-junk-punk','Radlands'),
 (7,'Unfinished Window','[2025 solomode] Sagrada solomode: Unfinished Window','Karen Robinson','KarenSDR',11585994,'https://boardgamegeek.com/thread/3350683/2025-solomode-sagrada-solomode-unfinished-window','Sagrada'),
 (8,'The Wily Widow','[2025 Solomode] The Wily Widow: a Deadly Dowagers solo variant','CabbageKing','cabbagekingaf',11587004,'https://boardgamegeek.com/thread/3455165/2025-solomode-the-wily-widow-a-deadly-dowagers-sol','Deadly Dowagers'),
 (9,'Solo Automa for Avignon','[2025 Solomode] Solo Automa for Avignon: A Clash of Popes',NULL,'scorius',11587107,'https://boardgamegeek.com/thread/3472563/2025-solomode-solo-automa-for-avignon-a-clash-of-p','Avignon: A Clash of Popes'),
 (10,'The Bus Conspiracy','[2025 Solomode] Bus Solo Mode: The Bus Conspiracy','Alex','talkingshelfspace',11587742,'https://boardgamegeek.com/thread/3445556/2025-solomode-bus-solo-mode-the-bus-conspiracy','Bus'),
 (11,'Veteran Solo Mode','[2025 Solomode] Creature Caravan: Veteran Solo Mode','Alex','talkingshelfspace',11587743,'https://boardgamegeek.com/thread/3418473/2025-solomode-creature-caravan-veteran-solo-mode','Creature Caravan'),
 (12,'Midnight Racetrack','[2025 Solomode] MIDNIGHT RACETRACK','P','Pockets97',11590047,'https://boardgamegeek.com/thread/3472592/2025-solomode-midnight-racetrack','Racetrack'),
 (13,'Lone Digger','[2025 Solomode] Super Motherload - Lone Digger','Evenger X','EvengerX',11598123,'https://boardgamegeek.com/thread/3474645/2025-solomode-super-motherload-lone-digger','Super Motherload'),
 (14,'Codenames Rush','[2025 Solomode] Codenames Rush - solo variant','Lukas Beran','Houp',11602209,'https://boardgamegeek.com/thread/3475523/2025-solomode-codenames-rush-solo-variant','Codenames'),
 (15,'boop. Solo Mode','[2025 Solomode] boop. Solo Mode',NULL,'BoardGamer0',11616405,'https://boardgamegeek.com/thread/3478437/2025-solomode-boop-solo-mode','boop.'),
 (16,'Bot Families','[2025 Solomode] bot families for "For a Crown"','Christian','NHack2013',11625106,'https://boardgamegeek.com/thread/3480600/2025-solomode-bot-families-for-for-a-crown','For a Crown'),
 (17,'Full Auto','[2025 Solomode] Joyride: Full Auto (Self-Driving Cars) -- NEW & IMPROVED','John Barklam','barklam',11636929,'https://boardgamegeek.com/thread/3483643/2025-solomode-joyride-full-auto-self-driving-cars','JOYRIDE: Survival of the Fastest'),
 (18,'Solisauron','[2025 Solomode] Solisauron','Adam Prentis','kukn',11650002,'https://boardgamegeek.com/thread/3486373/2025-solomode-solisauron','The Lord of the Rings: Duel for Middle-earth'),
 (19,'b-AI-rista','[2025 Solomode] unofficial solo against 1 or 2 b-AI-rista''s (with automa deck)','Anke L','anke1',11679234,'https://boardgamegeek.com/thread/3490914/2025-solomode-unofficial-solo-against-1-or-2-b-ai','Coffee Rush'),
 (20,'Felipe I / Felipe II','[2025 Solomode] unofficial solo against Felipe I (singlefold) or Felipe II (multifold)','Anke L','anke1',11679236,'https://boardgamegeek.com/thread/3490911/2025-solomode-unofficial-solo-against-felipe-i-sin','Puerto Rico 1897'),
 (21,'Forest Link','[2025 Solomode] - Forest Link',NULL,'SlimGordo',11707726,'https://boardgamegeek.com/thread/3496730/2025-solomode-forest-link','Forest Shuffle'),
 (22,'Cathy','Calico - Unofficial Solo Variant against Cathy',NULL,'Billard4ever',11728123,'https://boardgamegeek.com/thread/3327279/calico-unofficial-solo-variant-against-cathy','Calico'),
 (23,'Malakar','Inferno - Unofficial Solo Mode against Malakar',NULL,'Billard4ever',11728131,'https://boardgamegeek.com/thread/3398741/inferno-unofficial-solo-mode-against-malakar','Inferno'),
 (24,'Shrimpy','[2025 Solomode] MANTIS Automa: "Shrimpy"','John','InspiringChicken',11733113,'https://boardgamegeek.com/thread/3502388/2025-solomode-mantis-automa-shrimpy','MANTIS'),
 (25,'SUPERCAT','SUPERCAT: a procedural non-player system for solo Arcs','akiko','okonomichiyaki',11734935,'https://boardgamegeek.com/thread/3425290/supercat-a-procedural-non-player-system-for-solo-a','Arcs'),
 (26,'Unofficial Automa for Deep Regrets','Unofficial Automa for Deep Regrets','Raphael Garboua','CaptainFrenchie',11740059,'https://boardgamegeek.com/thread/3503201/2025-solomode-unofficial-automa-for-deep-regrets','Deep Regrets'),
 (27,'Nemesis','[2025 Solomode] Nemesis - A solo bot for Elysium',NULL,'Angelcollector',11744788,'https://boardgamegeek.com/thread/3504827/2025-solomode-nemesis-a-solo-bot-for-elysium','Elysium'),
 (28,'Grandma & Grandpa','[2025 Solomode] That Old Wallpaper Solo Mode (Solo vs. Grandma & Grandpa)',NULL,'Alaena',11746558,'https://boardgamegeek.com/thread/3511290/2025-solomode-that-old-wallpaper-solo-mode-solo-vs','That Old Wallpaper'),
 (29,'Unofficial Solo Mode & Campaign Mode','[2025 Solomode] UnOfficial Solo Mode & Campaign Mode','Pedro Correia','AndrePOR',11774783,'https://boardgamegeek.com/thread/3385154/2025-solomode-unofficial-solo-mode-and-campaign-mo','Babylon'),
 (30,'YRO Solo Campaign','[2025 Solomode] Yro Solo Campaign',NULL,'Satarius_Solo',11782560,'https://boardgamegeek.com/thread/3422271/2025-solomode-yro-solo-campaign','YRO'),
 (31,'Throne Alone','[2025 Solomode] [5th Place overall] Throne Alone - A Simple Solo Variant','Christopher Pütz','pautz',11788456,'https://boardgamegeek.com/thread/3383061/2025-solomode-5th-place-overall-throne-alone-a-sim','Castle Combo'),
 (32,'M. KloneUs','[2025 Solomode] M. KloneUs',NULL,'Alaena',11791932,'https://boardgamegeek.com/thread/3511300/2025-solomode-m-kloneus','Mycelia'),
 (33,'Pharaoh Code Solo Mode','2025 Solomode Design Contest Submissions',NULL,'berrystin',11794744,NULL,'Pharaoh Code'),
 (34,'Lord d''Automa','[2025 Solomode] Lord d''Automa: A simple bot for Castles of Burgundy','Edin Mujadzevic','edvinus',11795669,'https://boardgamegeek.com/thread/3512047/2025-solomode-lord-dautoma-a-simple-bot-for-castle','The Castles of Burgundy'),
 (35,'Splendor Solo Mode','2025 Solomode Contest',NULL,'speaker0410',11799886,NULL,'Splendor'),
 (36,'Cavemono','[2025 Solomode] Cavemono: Unofficial Solo Mode For Honga (Contest Ready)','Ryan Moylan','RPMgamer',11799894,'https://boardgamegeek.com/thread/3344024/2025-solomode-cavemono-unofficial-solo-mode-for-ho','Honga'),
 (37,'Up Front Browser Automa','[2025 Solomode] Browser based automa for Up Front','Brian Sturk','telengard',11799896,'https://boardgamegeek.com/thread/3512452/2025-solomode-browser-based-automa-for-up-front','Up Front'),
 (38,'RuneBot','[Solomode Design Contest] RuneBot: Solo Card Bot','Ray Gaer','Raygun1966',11800862,'https://boardgamegeek.com/thread/3510981/solomode-design-contest-runebot-solo-card-bot','Runebound');

INSERT INTO games
 (id,canonical_title,status_raw,status_normalized,status_evidence,source_url,first_seen_at,last_verified_at)
SELECT 551+position,title,'Listed in official submissions GeekList after contest close','contest_ready',
 'Fan-made solo variant for the base game: '||base_game||'.',
 'https://boardgamegeek.com/geeklist/353866/2025-solomode-design-contest-submissions/','2026-09-09','2026-09-09'
FROM solomode_2025_import;

INSERT INTO entries
 (id,contest_id,game_id,geeklist_id,geeklist_item_id,position,wip_thread_url,entry_url,entry_text_raw,status_raw,status_normalized,materials_status_raw,materials_status_normalized,entry_kind,base_game_dependency,first_seen_at,last_verified_at)
SELECT 551+position,16,551+position,353866,geeklist_item_id,position,wip_thread_url,
 'https://boardgamegeek.com/geeklist/353866/2025-solomode-design-contest-submissions/?itemid='||geeklist_item_id||'#'||geeklist_item_id,
 raw_title||CASE WHEN designer IS NOT NULL THEN ' by '||designer ELSE '' END||' (@'||bgg_username||'); base_game='||base_game,
 'Listed in official submissions GeekList after contest close','contest_ready',
 'Solo-mode rules required; additional custom components vary and were not checked','unknown',
 'dependent_variant','required','2026-09-09','2026-09-09'
FROM solomode_2025_import;

INSERT INTO entry_status_history
 (entry_id,check_id,status_raw,status_normalized,materials_status_raw,materials_status_normalized,position,observed_at,source_url,confidence,notes)
SELECT 551+position,37,'Listed in official submissions GeekList after contest close','contest_ready',
 'Solo-mode rules required; additional custom components vary and were not checked','unknown',position,'2026-09-09',
 'https://boardgamegeek.com/geeklist/353866/2025-solomode-design-contest-submissions/?itemid='||geeklist_item_id||'#'||geeklist_item_id,
 'high','Variante dipendente dal gioco base '||base_game||'; nessun regolamento o componente aperto.'
FROM solomode_2025_import;

CREATE TEMP TABLE solomode_2025_results (category TEXT NOT NULL,rank INTEGER NOT NULL,position INTEGER NOT NULL);
INSERT INTO solomode_2025_results VALUES
 ('Best Solo Mode',1,30),('Best Solo Mode',2,15),('Best Solo Mode',3,18),('Best Solo Mode',4,36),('Best Solo Mode',5,31),('Best Solo Mode',6,14),('Best Solo Mode',7,6),('Best Solo Mode',8,5),('Best Solo Mode',9,3),('Best Solo Mode',10,7),
 ('Best Rulebook',1,30),('Best Rulebook',2,5),('Best Rulebook',3,3),('Best Rulebook',4,31),('Best Rulebook',5,25),('Best Rulebook',6,34),('Best Rulebook',7,18),('Best Rulebook',8,36),('Best Rulebook',9,6),('Best Rulebook',10,13),
 ('Best Official Solo Mode Replacement',1,30),('Best Official Solo Mode Replacement',2,5),('Best Official Solo Mode Replacement',3,7),('Best Official Solo Mode Replacement',4,34),('Best Official Solo Mode Replacement',5,1),
 ('Best AI System',1,31),('Best AI System',2,3),('Best AI System',3,30),('Best AI System',4,15),('Best AI System',5,25),('Best AI System',6,34),('Best AI System',7,18),('Best AI System',8,36),('Best AI System',9,6),('Best AI System',10,27),
 ('Best Light Game Solo Mode',1,15),('Best Light Game Solo Mode',2,31),('Best Light Game Solo Mode',3,14),('Best Light Game Solo Mode',4,6),('Best Light Game Solo Mode',5,3),
 ('Best Medium Complexity Game Solo Mode',1,30),('Best Medium Complexity Game Solo Mode',2,18),('Best Medium Complexity Game Solo Mode',3,36),('Best Medium Complexity Game Solo Mode',4,34),('Best Medium Complexity Game Solo Mode',5,13),
 ('Best Complex Game Solo Mode',1,5),
 ('Best First Time Solo Mode Designer',1,30),('Best First Time Solo Mode Designer',2,15),('Best First Time Solo Mode Designer',3,24),
 ('Best Name',1,31),('Best Name',2,19),('Best Name',2,1),('Best Name',3,17),('Best Name',4,8),('Best Name',5,7);

INSERT INTO rankings
 (contest_id,game_id,category,rank,is_official,evidence_url,verified_at)
SELECT 16,551+position,category,rank,1,'https://boardgamegeek.com/thread/3470244/article/46281057#46281057','2026-09-09'
FROM solomode_2025_results;

INSERT INTO contest_metric_observations
 (contest_id,check_id,metric_key,metric_label_raw,numeric_value,text_value,unit,method,is_official,source_url,observed_at,notes)
VALUES
 (16,37,'submissions_geeklist_items','Official submissions GeekList items',38,NULL,'entries','counted_from_complete_official_geeklist',1,'https://boardgamegeek.com/geeklist/353866/2025-solomode-design-contest-submissions/','2026-09-09','La GeekList è articolata in due pagine e contiene 38 item.'),
 (16,37,'published_game_placements','Published game placements',55,NULL,'placements','counted_from_official_results',1,'https://boardgamegeek.com/thread/3470244/article/46281057#46281057','2026-09-09','Include il pari merito al secondo posto fra due entry nella categoria Best Name.'),
 (16,37,'mvp_rank_1','Most Valuable Playtester #1',NULL,'Karen Robinson (@KarenSDR)',NULL,'reported_by_organizer',1,'https://boardgamegeek.com/thread/3470244/article/46281057#46281057','2026-09-09',NULL),
 (16,37,'mvp_rank_2','Most Valuable Playtester #2',NULL,'Evenger X (@EvengerX)',NULL,'reported_by_organizer',1,'https://boardgamegeek.com/thread/3470244/article/46281057#46281057','2026-09-09',NULL),
 (16,37,'mvp_rank_3','Most Valuable Playtester #3',NULL,'CabbageKing (@cabbagekingaf)',NULL,'reported_by_organizer',1,'https://boardgamegeek.com/thread/3470244/article/46281057#46281057','2026-09-09',NULL);

DROP TABLE solomode_2025_results;
DROP TABLE solomode_2025_import;
COMMIT;
