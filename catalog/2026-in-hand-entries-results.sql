-- Censimento finale e risultati del 2026 In-Hand Game Design Contest.
-- Verifica: 2026-09-04. Solo metadati BGG; nessun materiale aperto o scaricato.

BEGIN IMMEDIATE;

CREATE TEMP TABLE inhand_import (
 position INTEGER PRIMARY KEY, title TEXT NOT NULL, status_raw TEXT NOT NULL, status_normalized TEXT NOT NULL
);

INSERT INTO inhand_import VALUES
 (1,'Shining Spirits','Games List; contest concluded','contest_ready'),
 (2,'Robot Wipeout','Games List; contest concluded','contest_ready'),
 (3,'Veles vs Perun','Games List; contest concluded','contest_ready'),
 (4,'Puzzlin'' Pawns','Games List; contest concluded','contest_ready'),
 (5,'Summoner of Winding Wood','Games List; contest concluded','contest_ready'),
 (6,'The Cult','Games List; contest concluded','contest_ready'),
 (7,'Aetherwood','Games List; contest concluded','contest_ready'),
 (8,'Glyph Knight','Games List; contest concluded','contest_ready'),
 (9,'Train Conductor','Games List; contest concluded','contest_ready'),
 (10,'BIGFOOT AND YETI','Games List; contest concluded','contest_ready'),
 (11,'Handcraft','Games List; contest concluded','contest_ready'),
 (12,'Turbo Tactics','Games List; contest concluded','contest_ready'),
 (13,'Pocket Forge','Games List; contest concluded','contest_ready'),
 (14,'Paddle Pals','Games List; contest concluded','contest_ready'),
 (15,'HeroHold','Games List; contest concluded','contest_ready'),
 (16,'Show of Hands','Games List; contest concluded','contest_ready'),
 (17,'LOCKSTEP','Games List; contest concluded','contest_ready'),
 (18,'Wild Photo','Games List; contest concluded','contest_ready'),
 (19,'Super Shot: Tennis SX','Games List; contest concluded','contest_ready'),
 (20,'Fool''s Journey: from Zero to Twenty One','Games List; contest concluded','contest_ready'),
 (21,'SkyHold','Games List; contest concluded','contest_ready'),
 (22,'Monk''s Cat: The Book of [Pawprints]','Games List; contest concluded','contest_ready'),
 (23,'Memories','Withdrawn','withdrawn'),
 (24,'Hellhand','Withdrawn','withdrawn'),
 (25,'Strut','Withdrawn','withdrawn');

UPDATE contests SET
 status_raw='Official results published; contest complete', status_normalized='complete',
 entries_url='https://boardgamegeek.com/thread/3591416/2026-in-hand-game-design-contest',
 results_url='https://boardgamegeek.com/thread/3591416/2026-in-hand-game-design-contest',
 last_verified_at='2026-09-04'
WHERE id=6;

INSERT INTO contest_phases
 (contest_id,phase_type,label_raw,sequence_number,status_raw,status_normalized,starts_at,ends_at,timezone,date_precision,source_url,first_seen_at,last_verified_at,notes)
VALUES
 (6,'feedback','Designer Feedback Deadline',2,'February 12, 2026','complete',NULL,'2026-02-12T23:59:59-07:00','BGG time (MT)','second','https://boardgamegeek.com/thread/3591416/2026-in-hand-game-design-contest','2026-09-04','2026-09-04','Tre feedback significativi richiesti per ogni entry presentata.'),
 (6,'corrections','Typo Corrections Deadline',4,'March 7, 2026','complete','2026-02-27','2026-03-07T23:59:59-07:00','BGG time (MT)','second','https://boardgamegeek.com/thread/3591416/2026-in-hand-game-design-contest','2026-09-04','2026-09-04',NULL),
 (6,'results','Contest Results',6,'Official results published','complete',NULL,NULL,'BGG time (MT)','unknown','https://boardgamegeek.com/thread/3591416/2026-in-hand-game-design-contest','2026-09-04','2026-09-04',NULL);

INSERT INTO contest_checks
 (id,contest_id,checked_at,source_url,check_kind,outcome,notes)
VALUES
 (17,6,'2026-09-05T00:12:00+02:00','https://boardgamegeek.com/thread/3591416/2026-in-hand-game-design-contest','manual_entry_and_results_census','complete','22 entry finali e 3 ritirate nella lista ufficiale corrente; 69 piazzamenti di gioco trascritti. Nessun materiale aperto.');

INSERT INTO contest_status_history
 (contest_id,check_id,status_raw,status_normalized,observed_at,source_url,confidence,notes)
VALUES
 (6,17,'Official results published; contest complete','complete','2026-09-05T00:12:00+02:00','https://boardgamegeek.com/thread/3591416/2026-in-hand-game-design-contest','high',NULL);

INSERT INTO games
 (id,canonical_title,status_raw,status_normalized,status_evidence,source_url,first_seen_at,last_verified_at)
SELECT 281+position,title,status_raw,status_normalized,
 'Stato derivato dalla separazione Games List / Withdrawn nel thread ufficiale.',
 'https://boardgamegeek.com/thread/3591416/2026-in-hand-game-design-contest','2026-09-04','2026-09-04'
FROM inhand_import;

INSERT INTO entries
 (id,contest_id,game_id,position,entry_url,entry_text_raw,status_raw,status_normalized,materials_status_raw,materials_status_normalized,first_seen_at,last_verified_at,withdrawn_at)
SELECT 281+position,6,281+position,position,
 'https://boardgamegeek.com/thread/3591416/2026-in-hand-game-design-contest',title,status_raw,status_normalized,
 CASE WHEN status_normalized='contest_ready' THEN 'PnP required by contest rules; entry present in final Games List' END,
 CASE WHEN status_normalized='contest_ready' THEN 'available_declared' ELSE 'unknown' END,
 '2026-09-04','2026-09-04',CASE WHEN status_normalized='withdrawn' THEN '2026-02-26' END
FROM inhand_import;

INSERT INTO entry_status_history
 (entry_id,check_id,status_raw,status_normalized,materials_status_raw,materials_status_normalized,position,observed_at,source_url,confidence,notes)
SELECT id,17,status_raw,status_normalized,materials_status_raw,materials_status_normalized,position,
 '2026-09-05T00:12:00+02:00',entry_url,'high','Prima osservazione completa della lista ufficiale; nessun materiale aperto.'
FROM entries WHERE contest_id=6;

CREATE TEMP TABLE inhand_results (category TEXT,rank INTEGER,title TEXT);
INSERT INTO inhand_results VALUES
 ('Best Overall Solo Game',1,'Glyph Knight'),('Best Overall Solo Game',2,'Turbo Tactics'),('Best Overall Solo Game',3,'The Cult'),('Best Overall Solo Game',4,'Fool''s Journey: from Zero to Twenty One'),('Best Overall Solo Game',5,'Train Conductor'),('Best Overall Solo Game',6,'Robot Wipeout'),('Best Overall Solo Game',7,'Puzzlin'' Pawns'),('Best Overall Solo Game',8,'Summoner of Winding Wood'),
 ('Best Overall Multiplayer Game',1,'Show of Hands'),('Best Overall Multiplayer Game',2,'Super Shot: Tennis SX'),('Best Overall Multiplayer Game',3,'Veles vs Perun'),('Best Overall Multiplayer Game',4,'Paddle Pals'),('Best Overall Multiplayer Game',5,'Wild Photo'),
 ('Best Rulebook',1,'Show of Hands'),('Best Rulebook',2,'Handcraft'),('Best Rulebook',3,'Puzzlin'' Pawns'),('Best Rulebook',4,'Robot Wipeout'),('Best Rulebook',5,'Summoner of Winding Wood'),('Best Rulebook',6,'Train Conductor'),('Best Rulebook',7,'The Cult'),('Best Rulebook',8,'Pocket Forge'),
 ('Most Visually Appealing',1,'SkyHold'),('Most Visually Appealing',2,'Glyph Knight'),('Most Visually Appealing',3,'Shining Spirits'),('Most Visually Appealing',4,'BIGFOOT AND YETI'),('Most Visually Appealing',5,'Summoner of Winding Wood'),('Most Visually Appealing',6,'Puzzlin'' Pawns'),('Most Visually Appealing',7,'Fool''s Journey: from Zero to Twenty One'),('Most Visually Appealing',8,'Handcraft'),
 ('Clearest Graphic Design and Support for the Visually Impaired',1,'Monk''s Cat: The Book of [Pawprints]'),('Clearest Graphic Design and Support for the Visually Impaired',2,'Puzzlin'' Pawns'),('Clearest Graphic Design and Support for the Visually Impaired',3,'Train Conductor'),('Clearest Graphic Design and Support for the Visually Impaired',4,'Handcraft'),('Clearest Graphic Design and Support for the Visually Impaired',5,'Super Shot: Tennis SX'),('Clearest Graphic Design and Support for the Visually Impaired',6,'Summoner of Winding Wood'),('Clearest Graphic Design and Support for the Visually Impaired',7,'Veles vs Perun'),('Clearest Graphic Design and Support for the Visually Impaired',8,'Paddle Pals'),
 ('Best Use of Theme',1,'Super Shot: Tennis SX'),('Best Use of Theme',2,'Turbo Tactics'),('Best Use of Theme',3,'Puzzlin'' Pawns'),('Best Use of Theme',4,'SkyHold'),('Best Use of Theme',5,'Glyph Knight'),('Best Use of Theme',6,'The Cult'),('Best Use of Theme',7,'Shining Spirits'),('Best Use of Theme',8,'Monk''s Cat: The Book of [Pawprints]'),
 ('Most Innovative Mechanic',1,'Super Shot: Tennis SX'),('Most Innovative Mechanic',2,'Glyph Knight'),('Most Innovative Mechanic',3,'Turbo Tactics'),('Most Innovative Mechanic',4,'LOCKSTEP'),('Most Innovative Mechanic',5,'Robot Wipeout'),('Most Innovative Mechanic',6,'Paddle Pals'),('Most Innovative Mechanic',7,'Train Conductor'),('Most Innovative Mechanic',8,'Veles vs Perun'),
 ('Ease of Holding',1,'Aetherwood'),('Ease of Holding',2,'Pocket Forge'),('Ease of Holding',3,'The Cult'),('Ease of Holding',4,'Show of Hands'),('Ease of Holding',5,'Wild Photo'),('Ease of Holding',6,'BIGFOOT AND YETI'),('Ease of Holding',6,'HeroHold'),('Ease of Holding',7,'Turbo Tactics'),
 ('Best Low-Ink Printing',1,'Train Conductor'),('Best Low-Ink Printing',2,'LOCKSTEP'),('Best Low-Ink Printing',3,'Super Shot: Tennis SX'),('Best Low-Ink Printing',4,'Handcraft'),('Best Low-Ink Printing',5,'Paddle Pals'),('Best Low-Ink Printing',6,'Puzzlin'' Pawns'),('Best Low-Ink Printing',7,'Monk''s Cat: The Book of [Pawprints]'),('Best Low-Ink Printing',8,'Summoner of Winding Wood');

INSERT INTO rankings
 (contest_id,game_id,category,rank,is_official,evidence_url,verified_at)
SELECT 6,g.id,r.category,r.rank,1,'https://boardgamegeek.com/thread/3591416/2026-in-hand-game-design-contest','2026-09-04'
FROM inhand_results r JOIN games g ON g.id BETWEEN 282 AND 306 AND lower(g.canonical_title)=lower(r.title);

INSERT INTO contest_metric_observations
 (contest_id,check_id,metric_key,metric_label_raw,numeric_value,text_value,unit,method,is_official,source_url,observed_at,notes)
VALUES
 (6,17,'entries_final_current','Current Games List',22,NULL,'entries','counted_from_current_official_list',1,'https://boardgamegeek.com/thread/3591416/2026-in-hand-game-design-contest','2026-09-05T00:12:00+02:00','Corregge la precedente rilevazione preliminare di 23 senza cancellarla.'),
 (6,17,'entries_withdrawn_current','Withdrawn',3,NULL,'entries','counted_from_current_official_list',1,'https://boardgamegeek.com/thread/3591416/2026-in-hand-game-design-contest','2026-09-05T00:12:00+02:00',NULL),
 (6,17,'ranked_game_results','Published game placements',69,NULL,'placements','counted_from_official_results',1,'https://boardgamegeek.com/thread/3591416/2026-in-hand-game-design-contest','2026-09-05T00:12:00+02:00','La categoria traditional card/tarot/decktet dichiara NO ENTRIES.'),
 (6,17,'best_solo_winner','Best Overall Solo Game #1',NULL,'Glyph Knight',NULL,'reported_by_organizer',1,'https://boardgamegeek.com/thread/3591416/2026-in-hand-game-design-contest','2026-09-05T00:12:00+02:00',NULL),
 (6,17,'best_multiplayer_winner','Best Overall Multiplayer Game #1',NULL,'Show of Hands',NULL,'reported_by_organizer',1,'https://boardgamegeek.com/thread/3591416/2026-in-hand-game-design-contest','2026-09-05T00:12:00+02:00',NULL),
 (6,17,'best_playtester_winner','Best Playtester #1',NULL,'Qu1rr3l',NULL,'reported_by_organizer',1,'https://boardgamegeek.com/thread/3591416/2026-in-hand-game-design-contest','2026-09-05T00:12:00+02:00','Seguono akavel, Eben Lenehan, UberDante, Phil e Matt Shelton ex aequo, Jim Andrew.');

DROP TABLE inhand_results;
DROP TABLE inhand_import;
COMMIT;
