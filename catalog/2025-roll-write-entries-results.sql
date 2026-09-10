-- Censimento del The 2025 Roll & Write Game Design Contest.
-- Verifica: 2026-09-10. Solo metadati BGG; nessun file di gioco aperto/scaricato.

BEGIN IMMEDIATE;

UPDATE contests SET status_raw='Results published',status_normalized='complete',last_verified_at='2026-09-10' WHERE id=22;
UPDATE contest_sources SET last_verified_at='2026-09-10' WHERE contest_id=22;

INSERT INTO contest_phases
 (contest_id,phase_type,label_raw,sequence_number,status_raw,status_normalized,starts_at,ends_at,timezone,date_precision,source_url,first_seen_at,last_verified_at,notes)
VALUES
 (22,'feedback','Mandatory Feedback Deadline',4,'Deadline January 25, 2026','complete',NULL,'2026-01-25','unspecified','day','https://boardgamegeek.com/thread/3585125/the-2025-roll-and-write-game-design-contest','2026-09-10','2026-09-10','Tre feedback obbligatori; il testo mostra una volta per errore 2025 e subito dopo specifica 2026.'),
 (22,'results','Contest Results',6,'Results published','complete',NULL,NULL,'unspecified','unknown','https://boardgamegeek.com/thread/3585125/the-2025-roll-and-write-game-design-contest','2026-09-10','2026-09-10','Risultati pubblicati negli spoiler dei post ufficiali di categoria; data esatta non inferita.');

INSERT INTO contest_checks (id,contest_id,checked_at,source_url,check_kind,outcome,notes)
VALUES (43,22,'2026-09-10','https://boardgamegeek.com/thread/3585125/the-2025-roll-and-write-game-design-contest','manual_web_census','complete','Censite 21 entry finali, 16 ritirate e 107 piazzamenti in undici categorie di gioco. Best Playtester esclusa dalle classifiche di giochi. Nessun materiale aperto.');

INSERT INTO contest_status_history
 (contest_id,check_id,status_raw,status_normalized,effective_at,observed_at,source_url,confidence,notes)
VALUES (22,43,'Results published','complete',NULL,'2026-09-10','https://boardgamegeek.com/thread/3585125/the-2025-roll-and-write-game-design-contest','high','La data esatta di pubblicazione non è dedotta dalla data originaria dei post successivamente modificati.');

CREATE TEMP TABLE roll_write_2025_import (
 position INTEGER PRIMARY KEY,title TEXT NOT NULL,designer TEXT,status_raw TEXT NOT NULL,status_normalized TEXT NOT NULL,source_article INTEGER NOT NULL
);
INSERT INTO roll_write_2025_import VALUES
 (1,'Ancient World','Martin van Rossum','Listed among 21 games entered in the contest','contest_ready',46680292),
 (2,'Compass & Ink','Jeff Grisenthwaite','Listed among 21 games entered in the contest','contest_ready',46680292),
 (3,'Dawn Chorus','Philip Crump','Listed among 21 games entered in the contest','contest_ready',46680292),
 (4,'Dicease Control: The 4.D-10 Pathogen','Alexandre Serpa','Listed among 21 games entered in the contest','contest_ready',46680292),
 (5,'Doodle Bash!','Daniel Young','Listed among 21 games entered in the contest','contest_ready',46680292),
 (6,'Fortify!','G. Bartjes','Listed among 21 games entered in the contest','contest_ready',46680292),
 (7,'Labyrinth of Shadows','Kendall Woffinden','Listed among 21 games entered in the contest','contest_ready',46680292),
 (8,'Lithomacy','Lazaros Reppas','Listed among 21 games entered in the contest','contest_ready',46680292),
 (9,'Mainframe: System Shutdown','Daniel Howard','Listed among 21 games entered in the contest','contest_ready',46680292),
 (10,'Master of Thievery','MrKuricat','Listed among 21 games entered in the contest','contest_ready',46680292),
 (11,'Natura','Edin Mujadzevic','Listed among 21 games entered in the contest','contest_ready',46680292),
 (12,'On-LINE Kasino','Tomoto Hayashi','Listed among 21 games entered in the contest','contest_ready',46680292),
 (13,'Rolling Fiefdoms','Greg Heitz','Listed among 21 games entered in the contest','contest_ready',46680292),
 (14,'Rolling Parks','drawanyth','Listed among 21 games entered in the contest','contest_ready',46680292),
 (15,'Spellwrights Codex','Saint Ama','Listed among 21 games entered in the contest','contest_ready',46680292),
 (16,'Skyfall','Clark Anderson','Listed among 21 games entered in the contest','contest_ready',46680292),
 (17,'The Leaning Tower of Pisa','Frank','Listed among 21 games entered in the contest','contest_ready',46680292),
 (18,'The Legend of Whispervale','Mabon Foo','Listed among 21 games entered in the contest','contest_ready',46680292),
 (19,'Thieves of Bandervon','Andrew Conniff','Listed among 21 games entered in the contest','contest_ready',46680292),
 (20,'Vanguard Multi Asset Global Command','Thomas Honsa','Listed among 21 games entered in the contest','contest_ready',46680292),
 (21,'Word Builders','sam sam','Listed among 21 games entered in the contest','contest_ready',46680292),
 (22,'1899 - 1907 Black Death Brazil','Wagner Gerlach','Listed among 16 games withdrawn from the contest','withdrawn',46680293),
 (23,'A Dragon''s Die','Peter Bonte','Listed among 16 games withdrawn from the contest','withdrawn',46680293),
 (24,'City Lights','Clint Ghosn','Listed among 16 games withdrawn from the contest','withdrawn',46680293),
 (25,'Fortune Script','toksn','Listed among 16 games withdrawn from the contest','withdrawn',46680293),
 (26,'INFRARED','Robin Metz','Listed among 16 games withdrawn from the contest','withdrawn',46680293),
 (27,'Necromancy: Roll Them Bones!','Jack Chapman','Listed among 16 games withdrawn from the contest','withdrawn',46680293),
 (28,'On the Trail of Bigfoot','Joaquin Rajadel','Listed among 16 games withdrawn from the contest','withdrawn',46680293),
 (29,'PIXIX','Henry Orsagh','Listed among 16 games withdrawn from the contest','withdrawn',46680293),
 (30,'Ringleader','Jared Barry','Listed among 16 games withdrawn from the contest','withdrawn',46680293),
 (31,'Roll & Pose','Ixlndr','Listed among 16 games withdrawn from the contest','withdrawn',46680293),
 (32,'The Thirteenth Dimension','Henry Henri','Listed among 16 games withdrawn from the contest','withdrawn',46680293),
 (33,'Scribe','Nathan Everett','Listed among 16 games withdrawn from the contest','withdrawn',46680293),
 (34,'STRATOS','Fernando Marecos','Listed among 16 games withdrawn from the contest','withdrawn',46680293),
 (35,'Wizard''s Tutelage','Pat G','Listed among 16 games withdrawn from the contest','withdrawn',46680293),
 (36,'U2: Flights of the Dragon Lady','Mike Heim','Listed among 16 games withdrawn from the contest','withdrawn',46680293),
 (37,'Yadoya','KaQu Kal','Listed among 16 games withdrawn from the contest','withdrawn',46680293);

INSERT INTO games
 (id,canonical_title,status_raw,status_normalized,status_evidence,source_url,first_seen_at,last_verified_at)
SELECT 792+position,title,status_raw,status_normalized,'Official final and withdrawn lists in the contest thread',
 'https://boardgamegeek.com/thread/3585125/article/'||source_article||'#'||source_article,'2026-09-10','2026-09-10'
FROM roll_write_2025_import;

INSERT INTO entries
 (id,contest_id,game_id,position,entry_url,entry_text_raw,status_raw,status_normalized,materials_status_raw,materials_status_normalized,first_seen_at,last_verified_at)
SELECT 792+position,22,792+position,position,'https://boardgamegeek.com/thread/3585125/article/'||source_article||'#'||source_article,
 title||CASE WHEN designer IS NULL THEN '' ELSE ' by '||designer END,status_raw,status_normalized,
 'Materials availability not individually verified','unknown','2026-09-10','2026-09-10'
FROM roll_write_2025_import;

INSERT INTO entry_status_history
 (entry_id,check_id,status_raw,status_normalized,materials_status_raw,materials_status_normalized,position,observed_at,source_url,confidence,notes)
SELECT 792+position,43,status_raw,status_normalized,'Materials availability not individually verified','unknown',position,'2026-09-10',
 'https://boardgamegeek.com/thread/3585125/article/'||source_article||'#'||source_article,'high','Stato tratto dalla separazione ufficiale fra lista attiva e lista ritirata; nessun file aperto.'
FROM roll_write_2025_import;

CREATE TEMP TABLE roll_write_2025_results (category TEXT NOT NULL,rank INTEGER NOT NULL,position INTEGER NOT NULL,article INTEGER NOT NULL);
INSERT INTO roll_write_2025_results VALUES
 ('Best Overall Game',1,13,46680273),('Best Overall Game',2,5,46680273),('Best Overall Game',3,17,46680273),('Best Overall Game',4,3,46680273),('Best Overall Game',4,9,46680273),('Best Overall Game',6,11,46680273),('Best Overall Game',7,1,46680273),('Best Overall Game',8,16,46680273),('Best Overall Game',9,20,46680273),('Best Overall Game',10,7,46680273),
 ('Best Solitaire Game',1,17,46680275),('Best Solitaire Game',2,13,46680275),('Best Solitaire Game',3,5,46680275),('Best Solitaire Game',4,11,46680275),('Best Solitaire Game',5,7,46680275),('Best Solitaire Game',6,20,46680275),('Best Solitaire Game',7,16,46680275),('Best Solitaire Game',8,2,46680275),('Best Solitaire Game',9,21,46680275),('Best Solitaire Game',10,19,46680275),
 ('Best Multi-Player Game',1,9,46680277),('Best Multi-Player Game',2,13,46680277),('Best Multi-Player Game',3,3,46680277),('Best Multi-Player Game',4,1,46680277),('Best Multi-Player Game',5,14,46680277),('Best Multi-Player Game',6,15,46680277),('Best Multi-Player Game',7,2,46680277),('Best Multi-Player Game',8,11,46680277),('Best Multi-Player Game',9,18,46680277),('Best Multi-Player Game',10,10,46680277),
 ('Best Thematic Game',1,13,46680279),('Best Thematic Game',2,5,46680279),('Best Thematic Game',3,17,46680279),('Best Thematic Game',4,11,46680279),('Best Thematic Game',5,2,46680279),('Best Thematic Game',6,9,46680279),('Best Thematic Game',7,7,46680279),('Best Thematic Game',8,3,46680279),('Best Thematic Game',9,18,46680279),('Best Thematic Game',10,15,46680279),
 ('Best Written Rules',1,17,46680280),('Best Written Rules',2,14,46680280),('Best Written Rules',3,16,46680280),('Best Written Rules',4,9,46680280),('Best Written Rules',5,1,46680280),('Best Written Rules',5,18,46680280),('Best Written Rules',7,7,46680280),('Best Written Rules',8,13,46680280),('Best Written Rules',9,11,46680280),('Best Written Rules',10,3,46680280),
 ('Best Original Artwork',1,17,46680281),('Best Original Artwork',2,5,46680281),('Best Original Artwork',3,1,46680281),('Best Original Artwork',4,14,46680281),('Best Original Artwork',5,13,46680281),('Best Original Artwork',6,18,46680281),('Best Original Artwork',7,2,46680281),('Best Original Artwork',8,15,46680281),('Best Original Artwork',8,12,46680281),('Best Original Artwork',8,11,46680281),
 ('Best Graphic Design',1,5,46680282),('Best Graphic Design',2,17,46680282),('Best Graphic Design',3,13,46680282),('Best Graphic Design',4,2,46680282),('Best Graphic Design',5,9,46680282),('Best Graphic Design',6,1,46680282),('Best Graphic Design',7,7,46680282),('Best Graphic Design',8,14,46680282),('Best Graphic Design',8,16,46680282),('Best Graphic Design',10,18,46680282),
 ('Best Innovative Mechanic',1,16,46680283),('Best Innovative Mechanic',2,17,46680283),('Best Innovative Mechanic',3,5,46680283),('Best Innovative Mechanic',4,4,46680283),('Best Innovative Mechanic',5,13,46680283),('Best Innovative Mechanic',6,19,46680283),('Best Innovative Mechanic',7,14,46680283),('Best Innovative Mechanic',8,2,46680283),('Best Innovative Mechanic',9,1,46680283),('Best Innovative Mechanic',10,7,46680283),
 ('Best Light/Minimal Build',1,9,46680285),('Best Light/Minimal Build',2,17,46680285),('Best Light/Minimal Build',3,13,46680285),('Best Light/Minimal Build',4,12,46680285),('Best Light/Minimal Build',5,3,46680285),('Best Light/Minimal Build',6,19,46680285),('Best Light/Minimal Build',7,20,46680285),('Best Light/Minimal Build',8,5,46680285),('Best Light/Minimal Build',9,4,46680285),
 ('Best Family/Children Friendly Game',1,17,46680286),('Best Family/Children Friendly Game',2,11,46680286),('Best Family/Children Friendly Game',3,2,46680286),('Best Family/Children Friendly Game',4,7,46680286),('Best Family/Children Friendly Game',5,3,46680286),('Best Family/Children Friendly Game',6,14,46680286),('Best Family/Children Friendly Game',7,15,46680286),('Best Family/Children Friendly Game',8,5,46680286),('Best Family/Children Friendly Game',8,18,46680286),('Best Family/Children Friendly Game',8,9,46680286),
 ('Best Low-Ink Version',1,19,46680287),('Best Low-Ink Version',2,13,46680287),('Best Low-Ink Version',3,20,46680287),('Best Low-Ink Version',4,3,46680287),('Best Low-Ink Version',5,9,46680287),('Best Low-Ink Version',6,7,46680287),('Best Low-Ink Version',7,11,46680287),('Best Low-Ink Version',8,17,46680287);

INSERT INTO rankings (contest_id,game_id,category,rank,is_official,evidence_url,verified_at)
SELECT 22,792+position,category,rank,1,'https://boardgamegeek.com/thread/3585125/article/'||article||'#'||article,'2026-09-10'
FROM roll_write_2025_results;

INSERT INTO game_names (game_id,name,observed_from,observed_at,is_current) VALUES
 (796,'DICEASE CONTROL: The 4.D-10 Pathogen','Official results capitalization','2026-09-10',0),
 (797,'Doodlebash','Official results spelling','2026-09-10',0),
 (807,'Spellwright Codex','Official multiplayer results spelling','2026-09-10',0),
 (809,'The Leaning Tower Of Pisa','Official list capitalization','2026-09-10',0);

INSERT INTO contest_metric_observations
 (contest_id,check_id,metric_key,metric_label_raw,numeric_value,text_value,unit,method,is_official,source_url,observed_at,notes)
VALUES
 (22,43,'active_entries','Number of games entered in the contest',21,NULL,'entries','reported_by_organizer',1,'https://boardgamegeek.com/thread/3585125/article/46680292#46680292','2026-09-10',NULL),
 (22,43,'withdrawn_entries','Number of games withdrawn from the contest',16,NULL,'entries','reported_by_organizer',1,'https://boardgamegeek.com/thread/3585125/article/46680293#46680293','2026-09-10',NULL),
 (22,43,'published_game_placements','Published game placements',107,NULL,'placements','counted_from_official_results',1,'https://boardgamegeek.com/thread/3585125/the-2025-roll-and-write-game-design-contest','2026-09-10','Best Playtester esclusa perché classifica di persone.'),
 (22,43,'published_game_categories','Published game categories',11,NULL,'categories','counted_from_official_results',1,'https://boardgamegeek.com/thread/3585125/the-2025-roll-and-write-game-design-contest','2026-09-10',NULL),
 (22,43,'playtester_category','Best Playtester',NULL,'Six people ranked; excluded from game rankings',NULL,'reported_by_organizer',1,'https://boardgamegeek.com/thread/3585125/article/46680284#46680284','2026-09-10',NULL);

DROP TABLE roll_write_2025_results;
DROP TABLE roll_write_2025_import;
COMMIT;
PRAGMA foreign_keys = ON;
