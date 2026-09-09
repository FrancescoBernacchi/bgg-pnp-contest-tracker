-- Censimento completo del 2025 54-Card Game Design Contest.
-- Verifica: 2026-09-09. Solo metadati BGG; nessun regolamento o componente aperto/scaricato.

BEGIN IMMEDIATE;

UPDATE contests SET
 entries_url='https://boardgamegeek.com/geeklist/360114/2025-54-card-game-design-contest-entries',
 results_url='https://boardgamegeek.com/thread/3536713/article/46288818#46288818',
 status_raw='Results and jury prize winners published',status_normalized='complete',last_verified_at='2026-09-09'
WHERE id=19;

UPDATE contest_sources SET last_verified_at='2026-09-09' WHERE contest_id=19;

INSERT INTO contest_sources
 (id,contest_id,kind,url,label,bgg_object_type,bgg_object_id,is_official,first_seen_at,last_verified_at)
VALUES
 (44,19,'results_post','https://boardgamegeek.com/thread/3536713/article/46288818#46288818','Official results and jury prize winners','article',46288818,1,'2026-09-09','2026-09-09');

INSERT INTO contest_phases
 (contest_id,phase_type,label_raw,sequence_number,status_raw,status_normalized,starts_at,ends_at,timezone,date_precision,source_url,first_seen_at,last_verified_at,notes)
VALUES
 (19,'results','Results and Jury Prize Winners',5,'Results published','complete',NULL,NULL,'BGG time','unknown','https://boardgamegeek.com/thread/3536713/article/46288818#46288818','2026-09-09','2026-09-09','Nove categorie di voto e un premio della giuria con due classificati e quattro menzioni d’onore.');

INSERT INTO contest_checks
 (id,contest_id,checked_at,source_url,check_kind,outcome,notes)
VALUES
 (40,19,'2026-09-09','https://boardgamegeek.com/geeklist/360114/2025-54-card-game-design-contest-entries','manual_web_census','complete','Censite 28 entry finali dalla GeekList e dalla lista ufficiale aggiornata il 1 novembre 2025; il thread conserva separatamente 9 giochi ritirati. Registrati i risultati del voto e del premio della giuria. Nessun materiale aperto.');

INSERT INTO contest_status_history
 (contest_id,check_id,status_raw,status_normalized,effective_at,observed_at,source_url,confidence,notes)
VALUES
 (19,40,'Results and jury prize winners published','complete',NULL,'2026-09-09','https://boardgamegeek.com/thread/3536713/article/46288818#46288818','high',NULL);

CREATE TEMP TABLE card_54_2025_import (
 position INTEGER PRIMARY KEY,title TEXT NOT NULL,designer TEXT,bgg_username TEXT,wip_thread_url TEXT
);

INSERT INTO card_54_2025_import VALUES
 (1,'Hack the Planet','Simon Beal','Ghost_Dancer','https://boardgamegeek.com/thread/3537032/wip-hack-the-planet-2025-54-card-game-design-conte'),
 (2,'Oh Ship!','Keith Henkell','CrossedSignals',NULL),
 (3,'Rekta','Janusz Kuśnierek','janciorules',NULL),
 (4,'Pip''s Quest','Ariel Cristi','Ninjabunny13','https://boardgamegeek.com/thread/3539855/pips-quest-2025-54-card-contest-contest-ready'),
 (5,'Surfboard Stealin'' Sea Otters','Rachel Carpenter','Herald Selenay',NULL),
 (6,'Harlequin','Mark Tuck','tucky60',NULL),
 (7,'Yaminabe','John Megow','Supah_Jawa',NULL),
 (8,'Dreadful Deductions','Robert Szalai','robcsi90',NULL),
 (9,'Villains Incorporated','Roman Zadorozhnyy','PressStartUA',NULL),
 (10,'Kill The Queen','Milo Vegas','milovegas',NULL),
 (11,'Ranicide','Clark Anderson','Cnote58',NULL),
 (12,'Wildlife Garden','Sam Barton','Table_for_two_games',NULL),
 (13,'Racket','Dirk R. Thesing','asdir',NULL),
 (14,'Hack-a-Pad','J-P Kurikka','MrKuricat',NULL),
 (15,'Scavengers','Georg Fischer','Herr_Goldberg',NULL),
 (16,'Tower Guard','Stephen Mulcahy','Smulchy_',NULL),
 (17,'Intercept','Matthew Bishop','tosx',NULL),
 (18,'Perilous Quest','Chendo BVB','chendobvb',NULL),
 (19,'Bet and Bridle','Aaron VanderWoude','ajvw4','https://boardgamegeek.com/thread/3569340/bet-and-bridle-2025-54-card-game-design-contest'),
 (20,'Wager in the Fog','Alex Serpa','alexserpa','https://boardgamegeek.com/thread/3572929/wager-in-the-fog-the-keeper-s-last-hand-54-card-ga'),
 (21,'Victorian Villainy','Alwyn Wong','PugWarlord','https://boardgamegeek.com/thread/3573515/wip-victorian-villainy'),
 (22,'Braggarts','Corin Elliott','turncoatgames','https://boardgamegeek.com/thread/3574791/wip-braggarts-a-double-ended-trick-taker-winner-of'),
 (23,'Tinker Turtle','Kenny Katayama','kensiebensie',NULL),
 (24,'Trick Trick Boom','Haymire','Haymire',NULL),
 (25,'One More?','Richard Lenherr','rimadeta',NULL),
 (26,'Potemkin Villages','Petr Čáslava','Zhan_Shi','https://boardgamegeek.com/thread/3576989/potemkin-villages-54-card-game-design-contest-2025'),
 (27,'Card Champs','Hunter Paustian','Hunter_P','https://boardgamegeek.com/thread/3577095/wip-card-champs-a-1v1-tag-team-wrestling-character-card-game'),
 (28,'The Gauntlet: Twenty Trials of Darkness','Lee Stemkoski','ProfStemkoski','https://boardgamegeek.com/thread/3577099/wip-the-gauntlet-twenty-trials-of-darkness-2025-54');

INSERT INTO games
 (id,canonical_title,status_raw,status_normalized,status_evidence,source_url,first_seen_at,last_verified_at)
SELECT 703+position,title,'Listed among the official contest entries updated November 1, 2025','contest_ready',
 'The contest required Contest Ready files by October 15; withdrawn games are listed separately.',COALESCE(wip_thread_url,'https://boardgamegeek.com/geeklist/360114/2025-54-card-game-design-contest-entries'),'2026-09-09','2026-09-09'
FROM card_54_2025_import;

INSERT INTO entries
 (id,contest_id,game_id,geeklist_id,position,wip_thread_url,entry_url,entry_text_raw,status_raw,status_normalized,materials_status_raw,materials_status_normalized,first_seen_at,last_verified_at)
SELECT 703+position,19,703+position,360114,position,wip_thread_url,
 'https://boardgamegeek.com/geeklist/360114/2025-54-card-game-design-contest-entries',
 title||CASE WHEN designer IS NOT NULL THEN ' by '||designer ELSE '' END||CASE WHEN bgg_username IS NOT NULL THEN ' (@'||bgg_username||')' ELSE '' END,
 'Listed among the official contest entries updated November 1, 2025','contest_ready','Contest Ready files required; files not individually opened','available_declared','2026-09-09','2026-09-09'
FROM card_54_2025_import;

INSERT INTO entry_status_history
 (entry_id,check_id,status_raw,status_normalized,materials_status_raw,materials_status_normalized,position,observed_at,source_url,confidence,notes)
SELECT 703+position,40,'Listed among the official contest entries updated November 1, 2025','contest_ready','Contest Ready files required; files not individually opened','available_declared',position,'2026-09-09',
 'https://boardgamegeek.com/geeklist/360114/2025-54-card-game-design-contest-entries','high','Prima osservazione completa; nessun materiale aperto.'
FROM card_54_2025_import;

CREATE TEMP TABLE card_54_2025_results (category TEXT NOT NULL,rank INTEGER,position INTEGER NOT NULL);
INSERT INTO card_54_2025_results VALUES
 ('Best Solo Game',1,12),('Best Solo Game',2,1),('Best Solo Game',3,16),('Best Solo Game',4,28),('Best Solo Game',5,20),
 ('Best Cooperative Game',1,12),('Best Cooperative Game',2,17),('Best Cooperative Game',3,26),
 ('Best 2-Player Game',1,2),('Best 2-Player Game',2,6),('Best 2-Player Game',3,1),('Best 2-Player Game',4,17),('Best 2-Player Game',5,12),
 ('Best Family Game',1,6),('Best Family Game',2,5),('Best Family Game',3,2),('Best Family Game',4,22),('Best Family Game',5,12),('Best Family Game',5,28),
 ('Best Party Game',1,2),('Best Party Game',2,9),('Best Party Game',3,6),('Best Party Game',4,25),('Best Party Game',5,8),
 ('Best Artwork',1,22),('Best Artwork',2,26),('Best Artwork',3,17),('Best Artwork',4,2),('Best Artwork',5,12),('Best Artwork',5,6),
 ('Best New Designer',1,2),('Best New Designer',2,16),('Best New Designer',3,23),('Best New Designer',3,4),('Best New Designer',5,27),
 ('Best Game Using a Standard Playing Card Deck',1,11),('Best Game Using a Standard Playing Card Deck',1,28),('Best Game Using a Standard Playing Card Deck',3,19),
 ('Best Overall Game',1,22),('Best Overall Game',2,17),('Best Overall Game',3,26),('Best Overall Game',4,1),('Best Overall Game',5,15),('Best Overall Game',5,2),('Best Overall Game',7,12),('Best Overall Game',7,9),('Best Overall Game',8,5),('Best Overall Game',9,28),
 ('Jury Prize',1,1),('Jury Prize',2,28),
 ('Jury Prize Honorable Mention',NULL,20),('Jury Prize Honorable Mention',NULL,12),('Jury Prize Honorable Mention',NULL,11),('Jury Prize Honorable Mention',NULL,6);

INSERT INTO rankings
 (contest_id,game_id,category,rank,is_official,evidence_url,verified_at)
SELECT 19,703+position,category,rank,1,'https://boardgamegeek.com/thread/3536713/article/46288818#46288818','2026-09-09'
FROM card_54_2025_results;

INSERT INTO contest_metric_observations
 (contest_id,check_id,metric_key,metric_label_raw,numeric_value,text_value,unit,method,is_official,source_url,observed_at,notes)
VALUES
 (19,40,'entries_final','Contest Entries updated 1 November 2025',28,NULL,'entries','counted_from_official_list',1,'https://boardgamegeek.com/thread/3536713/2025-54-card-game-design-contest','2026-09-09',NULL),
 (19,40,'entries_withdrawn','Withdrawn Games updated 1 November 2025',9,NULL,'entries','counted_from_official_list',1,'https://boardgamegeek.com/thread/3536713/2025-54-card-game-design-contest','2026-09-09','Conservato come conteggio storico; i giochi ritirati non sono aggiunti alle entry operative.'),
 (19,40,'voted_game_placements','Placements in nine voting categories',48,NULL,'placements','counted_from_official_results',1,'https://boardgamegeek.com/thread/3536713/article/46288818#46288818','2026-09-09','Comprende i pari merito pubblicati.'),
 (19,40,'jury_ranked_placements','Ranked Jury Prize winners',2,NULL,'placements','counted_from_official_results',1,'https://boardgamegeek.com/thread/3536713/article/46288818#46288818','2026-09-09',NULL),
 (19,40,'jury_honorable_mentions','Jury Prize honorable mentions',4,NULL,'mentions','counted_from_official_results',1,'https://boardgamegeek.com/thread/3536713/article/46288818#46288818','2026-09-09','Pubblicate senza ordine.');

DROP TABLE card_54_2025_results;
DROP TABLE card_54_2025_import;
COMMIT;
