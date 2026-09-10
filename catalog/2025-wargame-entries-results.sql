-- Censimento del 2025 Wargame Print and Play Game Design Contest.
-- Verifica: 2026-09-10. Solo metadati BGG; nessun file di gioco aperto/scaricato.

BEGIN IMMEDIATE;

UPDATE contests SET
 status_raw='Results published',status_normalized='complete',last_verified_at='2026-09-10'
WHERE id=21;

UPDATE contest_sources SET last_verified_at='2026-09-10' WHERE contest_id=21;

INSERT INTO contest_phases
 (contest_id,phase_type,label_raw,sequence_number,status_raw,status_normalized,starts_at,ends_at,timezone,date_precision,source_url,first_seen_at,last_verified_at,notes)
VALUES
 (21,'results','Results',3,'Results published','complete',NULL,'2025-12-15','BGG time','day','https://boardgamegeek.com/thread/3441044/results-in-2025-wargame-print-and-play-design-cont','2026-09-10','2026-09-10','Il thread indicava l’annuncio entro il 15 dicembre 2025; le classifiche sono pubblicate nei post ufficiali del thread.');

INSERT INTO contest_checks
 (id,contest_id,checked_at,source_url,check_kind,outcome,notes)
VALUES
 (42,21,'2026-09-10','https://boardgamegeek.com/thread/3441044/results-in-2025-wargame-print-and-play-design-cont','manual_web_census','complete','Censite le 19 entry rimaste nella GeekList ufficiale aggiornata dopo il contest e 93 piazzamenti in otto categorie. Le regole richiedevano la rimozione dalla GeekList delle entry ritirate. Nessun materiale aperto.');

INSERT INTO contest_status_history
 (contest_id,check_id,status_raw,status_normalized,effective_at,observed_at,source_url,confidence,notes)
VALUES
 (21,42,'Results published','complete','2025-12-15','2026-09-10','https://boardgamegeek.com/thread/3441044/results-in-2025-wargame-print-and-play-design-cont','high',NULL);

CREATE TEMP TABLE wargame_2025_import (
 position INTEGER PRIMARY KEY,item_id INTEGER NOT NULL,title TEXT NOT NULL,designer TEXT,username TEXT,wip_url TEXT NOT NULL,entry_text_raw TEXT NOT NULL
);

INSERT INTO wargame_2025_import VALUES
 (1,11505886,'Ukrainian F-16: Peace has a price','Vova Semeniv','ftd86','https://boardgamegeek.com/boardgame/424102/ukrainian-f-16-peace-has-a-price','Ukrainian F-16: Peace has a price — Vova Semeniv (@ftd86)'),
 (2,11538501,'S.P.A.T.','Ryszard Tokarczuk','RyTo','https://boardgamegeek.com/thread/3461799/wip-spat-2025-wargame-print-and-play-game-design-c','[WIP] S.P.A.T. (2025 Wargame Print and Play Game Design Contest) PLAYTEST READY — Ryszard Tokarczuk (@RyTo)'),
 (3,11645525,'Tank Board Game II: Hex','Ivan J','TankBoard','https://boardgamegeek.com/boardgame/440996/tank-board-game-ii-hex','Tank Board Game II: Hex — Ivan J (@TankBoard)'),
 (4,11684014,'The Ground Between','Felix Sonne','felixdsonne','https://boardgamegeek.com/thread/3491589/released-the-ground-between-2025-wargame-pnp-desig','[RELEASED] The Ground Between (2025 Wargame PNP Design Contest) — Felix Sonne (@felixdsonne)'),
 (5,11704243,'1453: Siege of Constantinople','Pete Holmes','Prh657','https://boardgamegeek.com/thread/3495795/wip-1453-siege-of-constantinople-2025-wargames-pnp','[WIP] 1453: Siege of Constantinople (2025 Wargames PNP Competition Submission) — Pete Holmes (@Prh657)'),
 (6,11715264,'Shootout in the Bardo',NULL,'Thunfar','https://boardgamegeek.com/boardgame/417655/shootout-in-the-bardo','Shootout in the Bardo — @Thunfar'),
 (7,11798426,'Deadlock!','Cassian','EsotericGames','https://boardgamegeek.com/boardgame/446550/deadlock','Deadlock! — Cassian (@EsotericGames)'),
 (8,11852086,'Battle Stations!','Diego Sartorato','Sartorato_ato','https://boardgamegeek.com/thread/3522597/wip-battle-stations-a-space-dogfight-cardgame-2025','[WIP] Battle Stations!* a space dogfight cardgame [2025 PnP Wargame Design Contest] — Diego Sartorato (@Sartorato_ato)'),
 (9,11890485,'In the Trench','Is. Ra.','Ke_mono','https://boardgamegeek.com/thread/3530510/in-the-trench-war-game','In The Trench - War game — Is. Ra. (@Ke_mono)'),
 (10,11933630,'Armored Fury','Lionel Triay','Lionel_Triay','https://boardgamegeek.com/thread/3539132/playtest-ready-armored-fury-2025-wargame-print-and','[Playtest ready] Armored Fury (2025 Wargame Print and Play Design Contest) — Lionel Triay (@Lionel_Triay)'),
 (11,11975391,'Armées de Papier: Combined Arms Battles in the Napoleonic Era','Kyle McNayr','kylemcnayr','https://boardgamegeek.com/thread/3548198/complete-armees-de-papier-combined-arms-battles-in','[COMPLETE] Armées de Papier: Combined Arms Battles in the Napoleonic Era — Kyle McNayr (@kylemcnayr)'),
 (12,12011404,'Finger Guns: A Wargame Played Using Only Fingers',NULL,'TheCheshireHuman','https://boardgamegeek.com/thread/3555005/playtest-ready-finger-guns-a-wargame-played-using','[PLAYTEST READY] Finger Guns: A Wargame Played Using Only Fingers (2025 Wargame Print and Play Design Contest) — @TheCheshireHuman'),
 (13,12051288,'Star Carrier Assault','Sean Young','Sean3Dguy','https://boardgamegeek.com/thread/3542290/wip-star-carrier-assault-2025-wargame-print-and-pl','(WIP) Star Carrier Assault (2025 Wargame Print and Play Contest) (Components ready) — Sean Young (@Sean3Dguy)'),
 (14,12058948,'Fortuna & Virtu','Eren Orhan','haeshin','https://boardgamegeek.com/thread/3564942/playtest-ready-fortuna-and-virtu-medieval-themed-w','[PLAYTEST READY] Fortuna & Virtu: Medieval-themed Wargame — Eren Orhan (@haeshin)'),
 (15,12090840,'Night Strike: 418 Squadron RCAF','Patrick Millin','malawicob','https://boardgamegeek.com/thread/3441750/night-strike-2025-cmc-war-game-pnp-contest-play-te','Night Strike - [2025 CMC War Game PnP Contest] [Play Test Ready] — Patrick Millin (@malawicob)'),
 (16,12124359,'Rough & Tumble Multilateral','Janus','Janusansoucis','https://boardgamegeek.com/thread/3576203/playtest-ready-rough-and-tumble-multilateral-2025','[PLAYTEST READY] Rough & Tumble Multilateral (2025 Wargames PNP Competition Submission) — Janus (@Janusansoucis)'),
 (17,12155300,'Project 01: Ferrum Front','Tri Ho Tram','ConsiliumForge','https://boardgamegeek.com/thread/3582082/playtest-ready-project-01-ferrum-front-2025-wargam','[Playtest Ready] Project 01: Ferrum Front (2025 Wargame Print and Play Game Design Contest) — Tri Ho Tram (@ConsiliumForge)'),
 (18,12163276,'Monster Cross',NULL,'garlicbits','https://boardgamegeek.com/thread/3582983/playtest-ready-monster-cross-2025-wargame-print-an','[PLAYTEST READY] Monster Cross - 2025 Wargame Print and Play Design Contest — @garlicbits'),
 (19,12168246,'StrikeFirstNow','Clement Galluccio','cg_hexstorical','https://boardgamegeek.com/thread/3585042/wip-strikefirstnow-from-hexstorical-playtest-ready','[WIP] StrikeFirstNow from Hexstorical [Playtest Ready Announcement] [2025 Wargame PNP Design Contest] — Clement Galluccio (@cg_hexstorical)');

INSERT INTO games
 (id,canonical_title,status_raw,status_normalized,status_evidence,source_url,first_seen_at,last_verified_at)
SELECT 773+position,title,'Present in the official post-contest Entry GeekList','contest_ready',
 'The rules required withdrawn games to be removed from the GeekList; the retained list was posted December 14, 2025.','https://boardgamegeek.com/geeklist/351628/2025-wargame-print-and-play-game-design-contest-en','2026-09-10','2026-09-10'
FROM wargame_2025_import;

INSERT INTO entries
 (id,contest_id,game_id,geeklist_id,geeklist_item_id,position,wip_thread_url,entry_url,entry_text_raw,status_raw,status_normalized,materials_status_raw,materials_status_normalized,first_seen_at,last_verified_at)
SELECT 773+position,21,773+position,351628,item_id,position,wip_url,
 'https://boardgamegeek.com/geeklist/351628/2025-wargame-print-and-play-game-design-contest-en?itemid='||item_id||'#'||item_id,
 entry_text_raw,'Retained in the official post-contest Entry GeekList','contest_ready','Materials required by the contest; availability not independently opened','unknown','2026-09-10','2026-09-10'
FROM wargame_2025_import;

INSERT INTO entry_status_history
 (entry_id,check_id,status_raw,status_normalized,materials_status_raw,materials_status_normalized,position,observed_at,source_url,confidence,notes)
SELECT 773+position,42,'Retained in the official post-contest Entry GeekList','contest_ready','Materials required by the contest; availability not independently opened','unknown',position,'2026-09-10',
 'https://boardgamegeek.com/geeklist/351628/2025-wargame-print-and-play-game-design-contest-en?itemid='||item_id||'#'||item_id,'high','Le regole chiedevano di rimuovere dalla GeekList le entry ritirate; nessun file aperto.'
FROM wargame_2025_import;

CREATE TEMP TABLE wargame_2025_results (category TEXT NOT NULL,rank INTEGER NOT NULL,position INTEGER NOT NULL,evidence_url TEXT NOT NULL);
INSERT INTO wargame_2025_results VALUES
 ('Best Use of Theme',1,10,'https://boardgamegeek.com/thread/3441044/article/45485601#45485601'),('Best Use of Theme',2,11,'https://boardgamegeek.com/thread/3441044/article/45485601#45485601'),('Best Use of Theme',3,16,'https://boardgamegeek.com/thread/3441044/article/45485601#45485601'),('Best Use of Theme',4,19,'https://boardgamegeek.com/thread/3441044/article/45485601#45485601'),('Best Use of Theme',5,5,'https://boardgamegeek.com/thread/3441044/article/45485601#45485601'),('Best Use of Theme',6,18,'https://boardgamegeek.com/thread/3441044/article/45485601#45485601'),('Best Use of Theme',7,3,'https://boardgamegeek.com/thread/3441044/article/45485601#45485601'),('Best Use of Theme',8,14,'https://boardgamegeek.com/thread/3441044/article/45485601#45485601'),('Best Use of Theme',9,4,'https://boardgamegeek.com/thread/3441044/article/45485601#45485601'),('Best Use of Theme',10,17,'https://boardgamegeek.com/thread/3441044/article/45485601#45485601'),('Best Use of Theme',11,2,'https://boardgamegeek.com/thread/3441044/article/45485601#45485601'),('Best Use of Theme',12,12,'https://boardgamegeek.com/thread/3441044/article/45485601#45485601'),('Best Use of Theme',13,13,'https://boardgamegeek.com/thread/3441044/article/45485601#45485601'),
 ('Best Art/Graphic Design',1,11,'https://boardgamegeek.com/thread/3441044/article/45485602#45485602'),('Best Art/Graphic Design',2,10,'https://boardgamegeek.com/thread/3441044/article/45485602#45485602'),('Best Art/Graphic Design',3,19,'https://boardgamegeek.com/thread/3441044/article/45485602#45485602'),('Best Art/Graphic Design',4,18,'https://boardgamegeek.com/thread/3441044/article/45485602#45485602'),('Best Art/Graphic Design',5,14,'https://boardgamegeek.com/thread/3441044/article/45485602#45485602'),('Best Art/Graphic Design',6,6,'https://boardgamegeek.com/thread/3441044/article/45485602#45485602'),('Best Art/Graphic Design',7,1,'https://boardgamegeek.com/thread/3441044/article/45485602#45485602'),('Best Art/Graphic Design',8,8,'https://boardgamegeek.com/thread/3441044/article/45485602#45485602'),('Best Art/Graphic Design',9,4,'https://boardgamegeek.com/thread/3441044/article/45485602#45485602'),('Best Art/Graphic Design',10,7,'https://boardgamegeek.com/thread/3441044/article/45485602#45485602'),('Best Art/Graphic Design',11,16,'https://boardgamegeek.com/thread/3441044/article/45485602#45485602'),('Best Art/Graphic Design',12,2,'https://boardgamegeek.com/thread/3441044/article/45485602#45485602'),('Best Art/Graphic Design',13,12,'https://boardgamegeek.com/thread/3441044/article/45485602#45485602'),
 ('Best Rule Book',1,11,'https://boardgamegeek.com/thread/3441044/article/45485603#45485603'),('Best Rule Book',2,10,'https://boardgamegeek.com/thread/3441044/article/45485603#45485603'),('Best Rule Book',3,16,'https://boardgamegeek.com/thread/3441044/article/45485603#45485603'),('Best Rule Book',4,18,'https://boardgamegeek.com/thread/3441044/article/45485603#45485603'),('Best Rule Book',5,4,'https://boardgamegeek.com/thread/3441044/article/45485603#45485603'),('Best Rule Book',6,12,'https://boardgamegeek.com/thread/3441044/article/45485603#45485603'),('Best Rule Book',7,19,'https://boardgamegeek.com/thread/3441044/article/45485603#45485603'),('Best Rule Book',8,5,'https://boardgamegeek.com/thread/3441044/article/45485603#45485603'),('Best Rule Book',9,7,'https://boardgamegeek.com/thread/3441044/article/45485603#45485603'),('Best Rule Book',10,1,'https://boardgamegeek.com/thread/3441044/article/45485603#45485603'),
 ('Best Mechanics',1,10,'https://boardgamegeek.com/thread/3441044/article/45485604#45485604'),('Best Mechanics',2,11,'https://boardgamegeek.com/thread/3441044/article/45485604#45485604'),('Best Mechanics',3,12,'https://boardgamegeek.com/thread/3441044/article/45485604#45485604'),('Best Mechanics',4,18,'https://boardgamegeek.com/thread/3441044/article/45485604#45485604'),('Best Mechanics',5,16,'https://boardgamegeek.com/thread/3441044/article/45485604#45485604'),('Best Mechanics',6,5,'https://boardgamegeek.com/thread/3441044/article/45485604#45485604'),('Best Mechanics',7,17,'https://boardgamegeek.com/thread/3441044/article/45485604#45485604'),('Best Mechanics',8,19,'https://boardgamegeek.com/thread/3441044/article/45485604#45485604'),('Best Mechanics',9,7,'https://boardgamegeek.com/thread/3441044/article/45485604#45485604'),('Best Mechanics',10,13,'https://boardgamegeek.com/thread/3441044/article/45485604#45485604'),('Best Mechanics',11,14,'https://boardgamegeek.com/thread/3441044/article/45485604#45485604'),('Best Mechanics',12,4,'https://boardgamegeek.com/thread/3441044/article/45485604#45485604'),('Best Mechanics',13,9,'https://boardgamegeek.com/thread/3441044/article/45485604#45485604'),('Best Mechanics',14,1,'https://boardgamegeek.com/thread/3441044/article/45485604#45485604'),('Best Mechanics',15,2,'https://boardgamegeek.com/thread/3441044/article/45485604#45485604'),
 ('Best Solitaire Game',1,10,'https://boardgamegeek.com/thread/3441044/article/45485606#45485606'),('Best Solitaire Game',2,5,'https://boardgamegeek.com/thread/3441044/article/45485606#45485606'),('Best Solitaire Game',3,13,'https://boardgamegeek.com/thread/3441044/article/45485606#45485606'),('Best Solitaire Game',4,15,'https://boardgamegeek.com/thread/3441044/article/45485606#45485606'),('Best Solitaire Game',5,19,'https://boardgamegeek.com/thread/3441044/article/45485606#45485606'),('Best Solitaire Game',6,1,'https://boardgamegeek.com/thread/3441044/article/45485606#45485606'),('Best Solitaire Game',7,3,'https://boardgamegeek.com/thread/3441044/article/45485606#45485606'),
 ('Best Multi-Player Game',1,10,'https://boardgamegeek.com/thread/3441044/article/45485607#45485607'),('Best Multi-Player Game',2,11,'https://boardgamegeek.com/thread/3441044/article/45485607#45485607'),('Best Multi-Player Game',3,18,'https://boardgamegeek.com/thread/3441044/article/45485607#45485607'),('Best Multi-Player Game',4,16,'https://boardgamegeek.com/thread/3441044/article/45485607#45485607'),('Best Multi-Player Game',5,12,'https://boardgamegeek.com/thread/3441044/article/45485607#45485607'),('Best Multi-Player Game',6,19,'https://boardgamegeek.com/thread/3441044/article/45485607#45485607'),('Best Multi-Player Game',7,4,'https://boardgamegeek.com/thread/3441044/article/45485607#45485607'),('Best Multi-Player Game',8,8,'https://boardgamegeek.com/thread/3441044/article/45485607#45485607'),('Best Multi-Player Game',9,14,'https://boardgamegeek.com/thread/3441044/article/45485607#45485607'),('Best Multi-Player Game',10,3,'https://boardgamegeek.com/thread/3441044/article/45485607#45485607'),('Best Multi-Player Game',11,6,'https://boardgamegeek.com/thread/3441044/article/45485607#45485607'),('Best Multi-Player Game',12,17,'https://boardgamegeek.com/thread/3441044/article/45485607#45485607'),
 ('Best Game on This Year''s Theme: Armor',1,10,'https://boardgamegeek.com/thread/3441044/article/45485609#45485609'),('Best Game on This Year''s Theme: Armor',2,3,'https://boardgamegeek.com/thread/3441044/article/45485609#45485609'),('Best Game on This Year''s Theme: Armor',3,11,'https://boardgamegeek.com/thread/3441044/article/45485609#45485609'),('Best Game on This Year''s Theme: Armor',4,18,'https://boardgamegeek.com/thread/3441044/article/45485609#45485609'),('Best Game on This Year''s Theme: Armor',5,7,'https://boardgamegeek.com/thread/3441044/article/45485609#45485609'),('Best Game on This Year''s Theme: Armor',6,4,'https://boardgamegeek.com/thread/3441044/article/45485609#45485609'),('Best Game on This Year''s Theme: Armor',7,2,'https://boardgamegeek.com/thread/3441044/article/45485609#45485609'),('Best Game on This Year''s Theme: Armor',8,16,'https://boardgamegeek.com/thread/3441044/article/45485609#45485609'),('Best Game on This Year''s Theme: Armor',9,5,'https://boardgamegeek.com/thread/3441044/article/45485609#45485609'),('Best Game on This Year''s Theme: Armor',10,19,'https://boardgamegeek.com/thread/3441044/article/45485609#45485609'),('Best Game on This Year''s Theme: Armor',11,8,'https://boardgamegeek.com/thread/3441044/article/45485609#45485609'),
 ('Best Overall Wargame',1,11,'https://boardgamegeek.com/thread/3441044/article/45485610#45485610'),('Best Overall Wargame',1,10,'https://boardgamegeek.com/thread/3441044/article/45485610#45485610'),('Best Overall Wargame',3,18,'https://boardgamegeek.com/thread/3441044/article/45485610#45485610'),('Best Overall Wargame',4,16,'https://boardgamegeek.com/thread/3441044/article/45485610#45485610'),('Best Overall Wargame',5,5,'https://boardgamegeek.com/thread/3441044/article/45485610#45485610'),('Best Overall Wargame',6,19,'https://boardgamegeek.com/thread/3441044/article/45485610#45485610'),('Best Overall Wargame',7,4,'https://boardgamegeek.com/thread/3441044/article/45485610#45485610'),('Best Overall Wargame',8,12,'https://boardgamegeek.com/thread/3441044/article/45485610#45485610'),('Best Overall Wargame',9,14,'https://boardgamegeek.com/thread/3441044/article/45485610#45485610'),('Best Overall Wargame',10,7,'https://boardgamegeek.com/thread/3441044/article/45485610#45485610'),('Best Overall Wargame',11,9,'https://boardgamegeek.com/thread/3441044/article/45485610#45485610'),('Best Overall Wargame',12,15,'https://boardgamegeek.com/thread/3441044/article/45485610#45485610');

INSERT INTO rankings
 (contest_id,game_id,category,rank,is_official,evidence_url,verified_at)
SELECT 21,773+position,category,rank,1,evidence_url,'2026-09-10' FROM wargame_2025_results;

INSERT INTO game_names (game_id,name,observed_from,observed_at,is_current) VALUES
 (774,'Ukranian F-16','Official results spelling','2026-09-10',0),
 (785,'Finger Guns','Official results short title','2026-09-10',0),
 (790,'Ferrum Front','Official results short title','2026-09-10',0),
 (787,'Fortuna & Virtù','GeekList description spelling','2026-09-10',0),
 (788,'Night Strike','Official results short title','2026-09-10',0);

INSERT INTO contest_metric_observations
 (contest_id,check_id,metric_key,metric_label_raw,numeric_value,text_value,unit,method,is_official,source_url,observed_at,notes)
VALUES
 (21,42,'final_entries','Entry GeekList items retained after contest',19,NULL,'entries','counted_from_official_list',1,'https://boardgamegeek.com/geeklist/351628/2025-wargame-print-and-play-game-design-contest-en','2026-09-10','Le regole richiedevano la rimozione delle entry ritirate.'),
 (21,42,'published_game_placements','Published game placements',93,NULL,'placements','counted_from_official_results',1,'https://boardgamegeek.com/thread/3441044/results-in-2025-wargame-print-and-play-design-cont','2026-09-10','Include il pari merito al primo posto della classifica generale.'),
 (21,42,'published_game_categories','Published game categories',8,NULL,'categories','counted_from_official_results',1,'https://boardgamegeek.com/thread/3441044/results-in-2025-wargame-print-and-play-design-cont','2026-09-10',NULL);

DROP TABLE wargame_2025_results;
DROP TABLE wargame_2025_import;
COMMIT;
PRAGMA foreign_keys = ON;
