-- Censimento e risultati del 2026 9-Card Nanogame Print and Play Design Contest.
-- Verifica: 2026-09-04. Solo metadati BGG; nessun materiale aperto o scaricato.

BEGIN IMMEDIATE;

CREATE TEMP TABLE nano9_import (
  position INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  designer TEXT NOT NULL,
  status_raw TEXT NOT NULL,
  status_normalized TEXT NOT NULL
);

INSERT INTO nano9_import VALUES
 (1,'1st Hero','Pengyu Chen','Contest Ready','contest_ready'),
 (2,'A.D.A.','Michael','Contest Ready','contest_ready'),
 (3,'Accursed''s Village','Rodrigo Kalil','Contest Ready','contest_ready'),
 (4,'Aim the Orcs!','Artie Tofrito','Contest Ready','contest_ready'),
 (5,'Animons Card Battle 9','Túlio Lima','Contest Ready','contest_ready'),
 (6,'Assault on the Citadel','Julio Rodriguez','Contest Ready','contest_ready'),
 (7,'Asturquest','Chendo BVB','Contest Ready','contest_ready'),
 (8,'Backpack Struggle','UncannyFeeling','Contest Ready','contest_ready'),
 (9,'Calaverita','Rafael Arias','Contest Ready','contest_ready'),
 (10,'CAPTCHA all robots!','Nick Huster','Contest Ready','contest_ready'),
 (11,'Cheese Chase','Nicholas Hjelmberg','Contest Ready','contest_ready'),
 (12,'City Ghost','Qu1rr3l','Contest Ready','contest_ready'),
 (13,'COLORI','faz_community','Contest Ready','contest_ready'),
 (14,'Crafting Crawler','Agustín Gallo','Contest Ready','contest_ready'),
 (15,'Diefectors','Arthur Wohlwill','Contest Ready','contest_ready'),
 (16,'DOKUSU','UberDante','Contest Ready','contest_ready'),
 (17,'Dreamstone','Ge Qin','Contest Ready','contest_ready'),
 (18,'FLAMES OF DOOM','Richard Lenherr','Contest Ready','contest_ready'),
 (19,'Flipping Little Dinos','Martin Segobia','Contest Ready','contest_ready'),
 (20,'Foolish Wizards','Alessandro Danovaro','Contest Ready','contest_ready'),
 (21,'HOPPE','tatta_chotdog','Contest Ready','contest_ready'),
 (22,'HOT CARS','Oladotun','Contest Ready','contest_ready'),
 (23,'Mata''s Inhabitants','Rodrigo Kalil','Contest Ready','contest_ready'),
 (24,'Mountaineer''s Challenge','Christian David','Contest Ready','contest_ready'),
 (25,'Ninefold Murder','David Llort','Contest Ready','contest_ready'),
 (26,'Ninefold Surgeon','David Llort','Contest Ready','contest_ready'),
 (27,'OBOLUS','Rosaria Battiato','Contest Ready','contest_ready'),
 (28,'ParallOn','Túlio Lima','Contest Ready','contest_ready'),
 (29,'PLAGA','Joel Carlos','Contest Ready','contest_ready'),
 (30,'PREDATORIA','Lazarus Liew','Contest Ready','contest_ready'),
 (31,'Saci''s Orchard','Christian David','Contest Ready','contest_ready'),
 (32,'Scout''s Dishonor: A Game of Snack-tical Warfare','Scott','Contest Ready','contest_ready'),
 (33,'Sector 9: The Void Anomaly','Rayith KHY','Contest Ready','contest_ready'),
 (34,'Seeds of Wars','Diego Beltrand','Contest Ready','contest_ready'),
 (35,'SEPTEM','Steve Smith','Contest Ready','contest_ready'),
 (36,'Shaolin Soccer','Junjie Wan','Contest Ready','contest_ready'),
 (37,'Shifting Islands','Qu1rr3l','Contest Ready','contest_ready'),
 (38,'SKY SPY','liegom','Contest Ready','contest_ready'),
 (39,'Three Henrys','hazard1994','Contest Ready','contest_ready'),
 (40,'Time Theft','Scott','Contest Ready','contest_ready'),
 (41,'Tribulations in Serpabale','Alexandre Serpa','Contest Ready','contest_ready'),
 (42,'Two Gods','Ge Qin','Contest Ready','contest_ready'),
 (43,'World Search','Frank Swannack','Contest Ready','contest_ready'),
 (44,'Your Easter Bunny needs YOU!','G. Bartjes','Contest Ready','contest_ready'),
 (45,'Bunny Bomb Blaster','Camilo Leiva Cardenas','Component Ready','components_available'),
 (46,'Dingers','Chris P','Component Ready','components_available'),
 (47,'Heretic','Vova Semeniv','Component Ready','components_available'),
 (48,'Penny-cle Accelerator','Chris Workman','Component Ready','components_available'),
 (49,'RAVIVAR','Gustavo Santos','Component Ready','components_available'),
 (50,'Ritual 12','Hernán Cortés','Component Ready','components_available'),
 (51,'Supercolony','Brad N','Component Ready','components_available'),
 (52,'Test of Time','Barny Skinner','Component Ready','components_available'),
 (53,'The Buttering Cat Paradox','David','Component Ready','components_available'),
 (54,'THE WORST PART OF BEING CAUGHT IN A TIME LOOP','Andy Wagers','Component Ready','components_available'),
 (55,'TILXi','Jun Hu','Component Ready','components_available'),
 (56,'Altar of the New Witch','Adesmara','Idea Phase','idea'),
 (57,'BALBÚRDIA','faz_community','Idea Phase','idea'),
 (58,'Der Kommandant','Double B Studio','Idea Phase','idea'),
 (59,'Dice of War','Kyle Nelstead','Idea Phase','idea'),
 (60,'Habitat','Agustín Atencio Andrioli','Idea Phase','idea'),
 (61,'Morpho Dungeon','Is. Ra.','Idea Phase','idea'),
 (62,'The Legend of Demon Island','Lofty Jungle','Idea Phase','idea'),
 (63,'The Wanted Doodle-Doo','Grzegorz Książek','Idea Phase','idea'),
 (64,'Arlo & Bliss','Iffix Y Santaph','Withdrawn','withdrawn'),
 (65,'CHARM','Tracey','Withdrawn','withdrawn'),
 (66,'Cloudbound Colossus Dice Game','Iffix Y Santaph','Withdrawn','withdrawn'),
 (67,'Feldspar','unlessgames','Withdrawn','withdrawn'),
 (68,'My Hat Definitely Doesn''t Have an Explosive Under It','DatMathBoi','Withdrawn','withdrawn'),
 (69,'Stack Dungeon','drawanyth','Withdrawn','withdrawn');

UPDATE contests SET
 organizer = 'Michael Murphy (@TaserGoat)',
 status_raw = 'Results published; contest complete', status_normalized = 'complete',
 entries_url = 'https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest',
 results_url = 'https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest',
 starts_at = '2026-01-01', submissions_close_at = '2026-03-16T23:59:00-06:00',
 voting_opens_at = '2026-05-01', voting_closes_at = '2026-05-31T23:59:00-06:00',
 last_verified_at = '2026-09-04'
WHERE id = 8;

INSERT OR IGNORE INTO contest_sources
 (contest_id,kind,url,label,bgg_object_type,bgg_object_id,is_official,first_seen_at,last_verified_at)
VALUES
 (8,'entries_and_results','https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest','Official contest post, entry tables and results','thread',3648226,1,'2026-09-04','2026-09-04');

INSERT INTO contest_phases
 (contest_id,phase_type,label_raw,sequence_number,status_raw,status_normalized,starts_at,ends_at,timezone,date_precision,source_url,first_seen_at,last_verified_at,notes)
VALUES
 (8,'design','Public design period',1,'Earliest public availability January 1, 2026','complete','2026-01-01','2026-03-16T23:59:00-06:00','BGG Time (CST)','minute','https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest','2026-09-04','2026-09-04',NULL),
 (8,'submissions','Entry deadline',2,'March 16, 2026 11:59 PM BGG Time (CST)','complete',NULL,'2026-03-16T23:59:00-06:00','BGG Time (CST)','minute','https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest','2026-09-04','2026-09-04',NULL),
 (8,'component_ready','Component Ready deadline',3,'April 1, 2026 11:59 PM BGG Time (CST)','complete',NULL,'2026-04-01T23:59:00-06:00','BGG Time (CST)','minute','https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest','2026-09-04','2026-09-04','Le entry ancora in Idea Phase erano soggette a ritiro.'),
 (8,'corrections','Contest Ready / corrections deadline',4,'April 15, 2026 11:59 PM BGG Time (CST)','complete','2026-04-02','2026-04-15T23:59:00-06:00','BGG Time (CST)','minute','https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest','2026-09-04','2026-09-04',NULL),
 (8,'playtest','Official Play Testing',5,'April 16 through April 30, 2026','complete','2026-04-16','2026-04-30T23:59:00-06:00','BGG Time (CST)','minute','https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest','2026-09-04','2026-09-04','Feedback obbligatorio ad almeno un altro gioco per i designer.'),
 (8,'voting','Voting',6,'May 1 through May 31, 2026','complete','2026-05-01','2026-05-31T23:59:00-06:00','BGG Time (CST)','minute','https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest','2026-09-04','2026-09-04',NULL),
 (8,'results','Results',7,'Official winners published','complete',NULL,NULL,'BGG Time','unknown','https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest','2026-09-04','2026-09-04',NULL);

INSERT INTO contest_checks
 (id,contest_id,checked_at,source_url,check_kind,outcome,notes)
VALUES
 (16,8,'2026-09-04T23:58:00+02:00','https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest','manual_entry_and_results_census','complete','69 progetti censiti dalle due tabelle ufficiali; risultati trascritti dal post dell''organizzatore. Nessun materiale aperto.');

INSERT INTO contest_status_history
 (contest_id,check_id,status_raw,status_normalized,observed_at,source_url,confidence,notes)
VALUES
 (8,16,'Results published; contest complete','complete','2026-09-04T23:58:00+02:00','https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest','high',NULL);

INSERT INTO games
 (id,canonical_title,status_raw,status_normalized,status_evidence,source_url,first_seen_at,last_verified_at)
SELECT 212+position,title,status_raw,status_normalized,
 'Stato riportato nella tabella ufficiale del contest.',
 'https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest',
 '2026-09-04','2026-09-04'
FROM nano9_import;

INSERT INTO people (id,display_name)
SELECT 7000 + row_number() OVER (ORDER BY lower(designer)),designer
FROM (SELECT DISTINCT designer FROM nano9_import);

INSERT INTO game_credits (game_id,person_id,role,credit_raw)
SELECT 212+n.position,p.id,'designer',n.designer
FROM nano9_import n JOIN people p ON lower(p.display_name)=lower(n.designer)
WHERE p.id >= 7001;

INSERT INTO entries
 (id,contest_id,game_id,position,entry_url,entry_text_raw,status_raw,status_normalized,materials_status_raw,materials_status_normalized,first_seen_at,last_verified_at,withdrawn_at)
SELECT 212+position,8,212+position,position,
 'https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest',
 title,status_raw,status_normalized,
 CASE WHEN status_normalized IN ('contest_ready','components_available') THEN status_raw END,
 CASE WHEN status_normalized IN ('contest_ready','components_available') THEN 'available_declared' ELSE 'unknown' END,
 '2026-09-04','2026-09-04',CASE WHEN status_normalized='withdrawn' THEN '2026-04-15' END
FROM nano9_import;

INSERT INTO entry_status_history
 (entry_id,check_id,status_raw,status_normalized,materials_status_raw,materials_status_normalized,position,observed_at,source_url,confidence,notes)
SELECT id,16,status_raw,status_normalized,materials_status_raw,materials_status_normalized,position,
 '2026-09-04T23:58:00+02:00',entry_url,'high','Prima osservazione completa dalla tabella ufficiale; nessun materiale aperto.'
FROM entries WHERE contest_id=8;

CREATE TEMP TABLE nano9_results (category TEXT,rank INTEGER,title TEXT);
INSERT INTO nano9_results VALUES
 ('Best Solitaire Game',1,'Shifting Islands'),('Best Solitaire Game',2,'DOKUSU'),('Best Solitaire Game',2,'SEPTEM'),('Best Solitaire Game',3,'OBOLUS'),('Best Solitaire Game',4,'Ninefold Surgeon'),
 ('Best 2 Player Game',1,'OBOLUS'),('Best 2 Player Game',2,'Ninefold Murder'),('Best 2 Player Game',3,'Aim the Orcs!'),('Best 2 Player Game',3,'Ninefold Surgeon'),('Best 2 Player Game',4,'Your Easter Bunny needs YOU!'),
 ('Best 3 or More Player Game',1,'1st Hero'),('Best 3 or More Player Game',2,'CAPTCHA all robots!'),('Best 3 or More Player Game',3,'Three Henrys'),('Best 3 or More Player Game',4,'Ninefold Murder'),('Best 3 or More Player Game',5,'Cheese Chase'),
 ('Best Thematic Game',1,'1st Hero'),('Best Thematic Game',2,'OBOLUS'),('Best Thematic Game',3,'Ninefold Surgeon'),('Best Thematic Game',4,'Sector 9: The Void Anomaly'),('Best Thematic Game',5,'Three Henrys'),
 ('Best Written Rules',1,'OBOLUS'),('Best Written Rules',2,'DOKUSU'),('Best Written Rules',3,'1st Hero'),('Best Written Rules',4,'Sector 9: The Void Anomaly'),('Best Written Rules',4,'SEPTEM'),
 ('Best Artwork',1,'1st Hero'),('Best Artwork',2,'Aim the Orcs!'),('Best Artwork',3,'Sector 9: The Void Anomaly'),('Best Artwork',4,'SEPTEM'),('Best Artwork',5,'Shifting Islands'),
 ('Best New Designer',1,'Dreamstone'),('Best New Designer',2,'Aim the Orcs!'),('Best New Designer',3,'HOPPE'),('Best New Designer',4,'Seeds of Wars'),('Best New Designer',4,'Sector 9: The Void Anomaly'),
 ('Most Innovative Mechanic',1,'1st Hero'),('Most Innovative Mechanic',2,'DOKUSU'),('Most Innovative Mechanic',3,'Aim the Orcs!'),('Most Innovative Mechanic',3,'OBOLUS'),('Most Innovative Mechanic',4,'CAPTCHA all robots!'),
 ('Best Language Independent Game',1,'DOKUSU'),('Best Language Independent Game',2,'SEPTEM'),('Best Language Independent Game',3,'Shifting Islands'),('Best Language Independent Game',4,'Aim the Orcs!'),('Best Language Independent Game',5,'HOPPE'),
 ('Best Overall Game',1,'OBOLUS'),('Best Overall Game',2,'SEPTEM'),('Best Overall Game',2,'Shifting Islands'),('Best Overall Game',3,'DOKUSU'),('Best Overall Game',4,'1st Hero'),('Best Overall Game',5,'Sector 9: The Void Anomaly'),('Best Overall Game',6,'Ninefold Surgeon'),('Best Overall Game',7,'CAPTCHA all robots!'),('Best Overall Game',7,'Dreamstone'),('Best Overall Game',7,'Ninefold Murder'),('Best Overall Game',7,'PLAGA'),
 ('Jury Prize',1,'OBOLUS'),('Jury Prize',2,'Seeds of Wars');

INSERT INTO rankings
 (contest_id,game_id,category,rank,is_official,evidence_url,verified_at)
SELECT 8,g.id,r.category,r.rank,1,
 'https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest','2026-09-04'
FROM nano9_results r JOIN games g ON g.id BETWEEN 213 AND 281 AND lower(g.canonical_title)=lower(r.title);

INSERT INTO contest_metric_observations
 (contest_id,check_id,metric_key,metric_label_raw,numeric_value,text_value,unit,method,is_official,source_url,observed_at,notes)
VALUES
 (8,16,'entries_total','All listed projects',69,NULL,'entries','counted_from_official_tables',1,'https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest','2026-09-04T23:58:00+02:00',NULL),
 (8,16,'entries_contest_ready','Contest Ready Entries',44,NULL,'entries','counted_from_official_table',1,'https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest','2026-09-04T23:58:00+02:00',NULL),
 (8,16,'entries_component_ready','Component Ready',11,NULL,'entries','counted_from_official_table',1,'https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest','2026-09-04T23:58:00+02:00',NULL),
 (8,16,'entries_idea_phase','Idea Phase',8,NULL,'entries','counted_from_official_table',1,'https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest','2026-09-04T23:58:00+02:00',NULL),
 (8,16,'entries_withdrawn','Withdrawn',6,NULL,'entries','counted_from_official_table',1,'https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest','2026-09-04T23:58:00+02:00',NULL),
 (8,16,'best_overall_winner','Best Overall Game #1',NULL,'OBOLUS',NULL,'reported_by_organizer',1,'https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest','2026-09-04T23:58:00+02:00',NULL),
 (8,16,'best_playtester_winner','Best Playtester #1',NULL,'G. Bartjes (@geoffrey69)',NULL,'reported_by_organizer',1,'https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest','2026-09-04T23:58:00+02:00','Seconda Rosaria Battiato; terzi ex aequo Frank Swannack e Qu1rr3l.');

DROP TABLE nano9_results;
DROP TABLE nano9_import;
COMMIT;
