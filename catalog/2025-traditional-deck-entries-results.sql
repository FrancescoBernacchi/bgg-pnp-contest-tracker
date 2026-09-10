-- Censimento del 2025 Traditional Deck Game Design Contest.
-- Verifica: 2026-09-09. Solo metadati BGG; nessun file di gioco aperto/scaricato.

BEGIN IMMEDIATE;

UPDATE contests SET
 results_url='https://boardgamegeek.com/thread/3569158/article/47101633#47101633',
 status_raw='Contest results published',status_normalized='complete',last_verified_at='2026-09-09'
WHERE id=20;

UPDATE contest_sources SET last_verified_at='2026-09-09' WHERE contest_id=20;

INSERT INTO contest_sources
 (id,contest_id,kind,url,label,bgg_object_type,bgg_object_id,is_official,first_seen_at,last_verified_at)
VALUES
 (45,20,'results_post','https://boardgamegeek.com/thread/3569158/article/47101633#47101633','Official contest results','article',47101633,1,'2026-09-09','2026-09-09');

INSERT INTO contest_phases
 (contest_id,phase_type,label_raw,sequence_number,status_raw,status_normalized,starts_at,ends_at,timezone,date_precision,source_url,first_seen_at,last_verified_at,notes)
VALUES
 (20,'feedback','Mandatory Feedback',2,'Deadline December 10, 2025','complete',NULL,'2025-12-10','BGG time','day','https://boardgamegeek.com/thread/3569158/2025-traditional-deck-game-design-contest','2026-09-09','2026-09-09','Tre feedback significativi richiesti per ciascuna entry.'),
 (20,'development','Development',3,'Until December 15, 2025','complete',NULL,'2025-12-15','BGG time','day','https://boardgamegeek.com/thread/3569158/2025-traditional-deck-game-design-contest','2026-09-09','2026-09-09',NULL),
 (20,'results','Contest Results',5,'Results published January 3, 2026','complete','2026-01-03','2026-01-03','BGG time','day','https://boardgamegeek.com/thread/3569158/article/47101633#47101633','2026-09-09','2026-09-09',NULL);

INSERT INTO contest_checks
 (id,contest_id,checked_at,source_url,check_kind,outcome,notes)
VALUES
 (41,20,'2026-09-09','https://boardgamegeek.com/thread/3569158/2025-traditional-deck-game-design-contest','manual_web_census','complete','Censite le 42 proposte nella Entries List ufficiale e 49 piazzamenti in cinque categorie di gioco. Ritiri e squalifiche sono attestati nel thread ma non ricomposti in una rosa finale separata completa; stato individuale mantenuto unknown. Nessun materiale aperto.');

INSERT INTO contest_status_history
 (contest_id,check_id,status_raw,status_normalized,effective_at,observed_at,source_url,confidence,notes)
VALUES
 (20,41,'Contest results published','complete','2026-01-03','2026-09-09','https://boardgamegeek.com/thread/3569158/article/47101633#47101633','high',NULL);

CREATE TEMP TABLE traditional_2025_import (
 position INTEGER PRIMARY KEY,title TEXT NOT NULL,designer TEXT,players_raw TEXT
);

INSERT INTO traditional_2025_import VALUES
 (1,'Swamp','quantumpotato','1p'),
 (2,'Candles & Cannons','quantumpotato','1p'),
 (3,'Edgar Shovelhands','Kendall Woffinden','1p'),
 (4,'Polarité','Vincent Bugica','2p'),
 (5,'River Black','Luiz Mendez','1p'),
 (6,'Hocken','Iffix Y Santaph','2-6p'),
 (7,'Divide','David McDougal','3-6p'),
 (8,'Beanstalks','Mark','2p'),
 (9,'Rules of Engagement','Barry Smith','2p'),
 (10,'Safes','@Season6028','2+p'),
 (11,'Winner Take All!','Steve Johnson','2p'),
 (12,'Alchemy','Mark','1p'),
 (13,'The Four Musketeers','David Atkinson','1p'),
 (14,'Trick Tac Foe','David McDougal','2p / 4p'),
 (15,'S.O.L. SIX ORBIT LOCKDOWN','Alexandre Serpa','1-2p'),
 (16,'Flock Rocks: Sheep vs. Wolves','Richard Lenherr','2-4p'),
 (17,'Court & Crown','Dustin Gray','2p'),
 (18,'Undergrowth','Josiah Mather','1p'),
 (19,'Share Tactics','Chris Parker','3-5p'),
 (20,'Against The Clock','Kikwik','1p'),
 (21,'Hedgerow','Josiah Mather','1-2p'),
 (22,'The House Always Wins','Richard Lenherr','1-4p'),
 (23,'Shadow Solitaire: Gambit for the City','Kendall Woffinden','1p'),
 (24,'Olm','Ákos Plesznivy and Petra Hahn','2p'),
 (25,'Jack''s Dream','Ákos Plesznivy and Petra Hahn','1p'),
 (26,'Council of Dragons','Luiz Mendes','1p'),
 (27,'FIRE','Akimakesthings','1-6p'),
 (28,'The Four Winds','@burismiga','3-4p'),
 (29,'Relic Solitaire','Iffix Y Santaph','1p'),
 (30,'Hightower','Jeremy Totton','2p'),
 (31,'Cardello','Marek Kolcun','2-4p'),
 (32,'Feuda Rivalia','Kevin Kotowski','3-6p'),
 (33,'Train Trekker','Zachary Robbins','2-5p'),
 (34,'Necromancer','Kevin Galbraith','4-5p'),
 (35,'Soluna','Jean-Baptiste Lévêque','1p'),
 (36,'This Ol'' Cowboy','Dave LaSalle','1p'),
 (37,'Super Snap Showdown','Barry Smith','2p'),
 (38,'Grazer','Jean-Baptiste Lévêque','1p'),
 (39,'Shadow Market','Drew Grgich','3-5p'),
 (40,'Sniper','Rohinton Daruwala','2-4p'),
 (41,'Arsenal: Duel of Kings','Kyl Tusay','2p'),
 (42,'Pippins Aplenty','Andy Bond','4p');

INSERT INTO games
 (id,canonical_title,status_raw,status_normalized,status_evidence,source_url,first_seen_at,last_verified_at)
SELECT 731+position,title,'Present in the official Entries List (42 entries)','unknown',
 'The thread documents some withdrawals and disqualifications without a complete separate final roster.','https://boardgamegeek.com/thread/3569158/2025-traditional-deck-game-design-contest','2026-09-09','2026-09-09'
FROM traditional_2025_import;

INSERT INTO entries
 (id,contest_id,game_id,position,entry_url,entry_text_raw,status_raw,status_normalized,materials_status_raw,materials_status_normalized,first_seen_at,last_verified_at)
SELECT 731+position,20,731+position,position,'https://boardgamegeek.com/thread/3569158/2025-traditional-deck-game-design-contest',
 title||' by '||designer||' ('||players_raw||')','Present in the official Entries List (42 entries)','unknown','Rules and material availability not individually verified','unknown','2026-09-09','2026-09-09'
FROM traditional_2025_import;

INSERT INTO entry_status_history
 (entry_id,check_id,status_raw,status_normalized,materials_status_raw,materials_status_normalized,position,observed_at,source_url,confidence,notes)
SELECT 731+position,41,'Present in the official Entries List (42 entries)','unknown','Rules and material availability not individually verified','unknown',position,'2026-09-09',
 'https://boardgamegeek.com/thread/3569158/2025-traditional-deck-game-design-contest','medium','Il thread non presenta una rosa finale separata completa; nessun file aperto.'
FROM traditional_2025_import;

CREATE TEMP TABLE traditional_2025_results (category TEXT NOT NULL,rank INTEGER NOT NULL,position INTEGER NOT NULL);
INSERT INTO traditional_2025_results VALUES
 ('Best Solo Game',1,25),('Best Solo Game',2,23),('Best Solo Game',3,20),('Best Solo Game',4,35),('Best Solo Game',5,1),('Best Solo Game',6,5),('Best Solo Game',7,13),('Best Solo Game',8,12),('Best Solo Game',9,15),('Best Solo Game',10,2),
 ('Best Multiplayer Game',1,24),('Best Multiplayer Game',2,39),('Best Multiplayer Game',3,4),('Best Multiplayer Game',4,28),('Best Multiplayer Game',5,15),('Best Multiplayer Game',6,8),('Best Multiplayer Game',7,40),('Best Multiplayer Game',8,27),('Best Multiplayer Game',9,31),
 ('Best Rulebook',1,25),('Best Rulebook',2,13),('Best Rulebook',3,28),('Best Rulebook',4,38),('Best Rulebook',5,24),('Best Rulebook',6,1),('Best Rulebook',7,23),('Best Rulebook',8,26),('Best Rulebook',9,12),('Best Rulebook',10,40),
 ('Best Use of Theme',1,20),('Best Use of Theme',2,2),('Best Use of Theme',3,3),('Best Use of Theme',4,1),('Best Use of Theme',5,13),('Best Use of Theme',6,40),('Best Use of Theme',7,8),('Best Use of Theme',8,25),('Best Use of Theme',9,27),('Best Use of Theme',10,4),
 ('Most Innovative Mechanic',1,35),('Most Innovative Mechanic',2,2),('Most Innovative Mechanic',3,24),('Most Innovative Mechanic',4,12),('Most Innovative Mechanic',5,20),('Most Innovative Mechanic',6,40),('Most Innovative Mechanic',7,1),('Most Innovative Mechanic',8,38),('Most Innovative Mechanic',9,27),('Most Innovative Mechanic',10,4);

INSERT INTO rankings
 (contest_id,game_id,category,rank,is_official,evidence_url,verified_at)
SELECT 20,731+position,category,rank,1,'https://boardgamegeek.com/thread/3569158/article/47101633#47101633','2026-09-09'
FROM traditional_2025_results;

INSERT INTO contest_metric_observations
 (contest_id,check_id,metric_key,metric_label_raw,numeric_value,text_value,unit,method,is_official,source_url,observed_at,notes)
VALUES
 (20,41,'entries_listed','Entries List',42,NULL,'entries','reported_by_organizer',1,'https://boardgamegeek.com/thread/3569158/2025-traditional-deck-game-design-contest','2026-09-09','La lista non separa in modo completo entry finali, ritirate e squalificate.'),
 (20,41,'published_game_placements','Published game placements',49,NULL,'placements','counted_from_official_results',1,'https://boardgamegeek.com/thread/3569158/article/47101633#47101633','2026-09-09','Dieci posizioni in quattro categorie e nove in Best Multiplayer Game.'),
 (20,41,'published_game_categories','Published game categories',5,NULL,'categories','counted_from_official_results',1,'https://boardgamegeek.com/thread/3569158/article/47101633#47101633','2026-09-09',NULL),
 (20,41,'playtester_category','Most Valuable Playtester',NULL,'Published separately; people ranking excluded from game rankings',NULL,'reported_by_organizer',1,'https://boardgamegeek.com/thread/3569158/article/47101633#47101633','2026-09-09',NULL);

DROP TABLE traditional_2025_results;
DROP TABLE traditional_2025_import;
COMMIT;
