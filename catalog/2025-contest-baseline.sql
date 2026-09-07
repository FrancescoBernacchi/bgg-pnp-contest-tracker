-- Baseline esplorativa delle edizioni BGG 2025.
-- Verifica: 2026-09-07. Solo metadati pubblici; nessun materiale di gioco aperto o scaricato.

BEGIN IMMEDIATE;

INSERT INTO contest_series (id, canonical_name, description, scope_notes, first_seen_at, last_verified_at) VALUES
  (12, '1-Card Print and Play Design Contest', 'Contest annuale per giochi Print and Play su una sola carta.', 'Incluso: PnP esplicito.', '2026-09-07', '2026-09-07'),
  (13, 'Roll & Write Game Design Contest', 'Contest annuale per giochi roll-and-write e flip-and-write.', 'Incluso: PnP gratuito obbligatorio durante il contest.', '2026-09-07', '2026-09-07');

INSERT INTO contests
  (id, series_id, bgg_thread_id, name, year, edition_label, language, geographic_scope,
   scope_type, treatment_profile, status_raw, status_normalized, organizer, entries_url,
   results_url, starts_at, submissions_close_at, voting_opens_at, voting_closes_at,
   source_url, first_seen_at, last_verified_at)
VALUES
  (12, 6, 3378403, '2025 In-Hand Game Design Contest', 2025, 'Fourth edition', 'English', 'international',
   'pnp_core', 'standard', 'Contest results published', 'complete', 'Cy (@CyBadger), Igor Zuber', NULL,
   'https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest', '2024-10-01', '2025-01-01T23:59:59-07:00', '2025-03-17', '2025-03-31T23:59:59-06:00',
   'https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest', '2026-09-07', '2026-09-07'),
  (13, 8, 3436343, '2025 9-Card Nanogame Print and Play Design Contest', 2025, 'Ninth annual', 'English', 'international',
   'pnp_core', 'standard', 'Winners published', 'complete', 'Michael Murphy (@TaserGoat)', NULL,
   'https://boardgamegeek.com/thread/3436343/2025-9-card-nanogame-print-and-play-design-contest', '2025-01-01', '2025-03-16T23:59:00-06:00', '2025-05-01', '2025-05-31T23:59:00-05:00',
   'https://boardgamegeek.com/thread/3436343/2025-9-card-nanogame-print-and-play-design-contest', '2026-09-07', '2026-09-07'),
  (14, 10, 3441385, '2025 Children & Family Game Design Contest', 2025, '10th edition', 'English', 'international',
   'pnp_core', 'standard', 'Results published', 'complete', 'Edin Mujadzevic (@edvinus)', 'https://boardgamegeek.com/geeklist/351008/2025-children-and-family-game-design-contest',
   'https://boardgamegeek.com/thread/3441385/article/46099911#46099911', '2025-01-15', '2025-04-15', '2025-05-01', '2025-05-15',
   'https://boardgamegeek.com/thread/3441385/2025-children-and-family-game-design-contest', '2026-09-07', '2026-09-07'),
  (15, 12, 3487579, '2025 1-Card Print and Play Design Contest', 2025, '2025', 'English', 'international',
   'pnp_core', 'standard', 'All results are in', 'complete', 'Ben Morayta (@bmorayta1)', NULL, NULL,
   '2025-03-30', '2025-05-31', '2025-07-01', '2025-07-31T23:59:59-06:00',
   'https://boardgamegeek.com/thread/3487579/2025-1-card-print-and-play-design-contest', '2026-09-07', '2026-09-07'),
  (16, 11, 3470244, '2025 Solomode Contest', 2025, 'Fifth installment', 'English', 'international',
   'adjacent', 'dependent_variants', 'Contest results published', 'complete', 'Edin Mujadzevic (@edvinus)', 'https://boardgamegeek.com/geeklist/353866/2025-solomode-design-contest-submissions/',
   'https://boardgamegeek.com/thread/3470244/article/46281057#46281057', '2025-03-01', '2025-05-15T23:59:00-07:00', '2025-06-10', '2025-06-30T23:59:00-07:00',
   'https://boardgamegeek.com/thread/3470244/2025-solomode-contest', '2026-09-07', '2026-09-07'),
  (17, 1, 3520713, '2025 Solitaire Print and Play Contest', 2025, '2025', 'English', 'international',
   'pnp_core', 'standard', 'All results are in', 'complete', 'Ben Morayta (@bmorayta1)', 'https://boardgamegeek.com/geeklist/358652/2025-solitaire-print-and-play-contest-entrants',
   'https://boardgamegeek.com/thread/3520713/article/46153954#46153954', '2025-06-01', '2025-08-31T23:59:59-06:00', '2025-10-16', '2025-11-15T23:59:59-07:00',
   'https://boardgamegeek.com/thread/3520713/2025-solitaire-print-and-play-contest', '2026-09-07', '2026-09-07'),
  (18, 7, 3530940, '2025 Two-Player Print and Play Game Design Contest', 2025, '2025', 'English', 'international',
   'pnp_core', 'standard', 'Results and winners published', 'complete', 'Charles Ward (@ex1st)', 'https://boardgamegeek.com/geeklist/359588/2025-two-player-pnp-game-design-contest-entries',
   'https://boardgamegeek.com/thread/3530940/article/46241868#46241868', '2025-06-22', '2025-08-30', '2025-09-22', '2025-10-30',
   'https://boardgamegeek.com/thread/3530940/2025-two-player-print-and-play-game-design-contest', '2026-09-07', '2026-09-07'),
  (19, 2, 3536713, '2025 54-Card Game Design Contest', 2025, 'Eighth annual', 'English', 'international',
   'pnp_core', 'standard', 'Results and jury prize winners published', 'complete', 'Dustin Culbertson (@JonasVenture)', 'https://boardgamegeek.com/geeklist/360114/2025-54-card-game-design-contest-entries',
   'https://boardgamegeek.com/thread/3536713/article/46288818#46288818', '2025-07-01', '2025-09-16T23:59:00-05:00', '2025-11-01', '2025-11-30T23:59:00-06:00',
   'https://boardgamegeek.com/thread/3536713/2025-54-card-game-design-contest', '2026-09-07', '2026-09-07'),
  (20, 3, 3569158, '2025 Traditional Deck Game Design Contest', 2025, 'Fifth installment', 'English', 'international',
   'adjacent', 'format_adjacent', 'Contest results published', 'complete', 'Edin Mujadzevic (@edvinus)', NULL,
   'https://boardgamegeek.com/thread/3569158/article/47101633#47101633', '2025-09-01', '2025-12-01', '2025-12-17', '2026-01-02',
   'https://boardgamegeek.com/thread/3569158/2025-traditional-deck-game-design-contest', '2026-09-07', '2026-09-07'),
  (21, 4, 3441044, '2025 Wargame Print and Play Design Contest', 2025, '2025', 'English', 'international',
   'pnp_core', 'standard', 'Results published', 'complete', '@quantumpotato', 'https://boardgamegeek.com/geeklist/351628/2025-wargame-print-and-play-game-design-contest-en',
   'https://boardgamegeek.com/thread/3441044/results-in-2025-wargame-print-and-play-design-cont', '2024-10-02', '2025-10-01', '2025-11-11', '2025-12-08',
   'https://boardgamegeek.com/thread/3441044/results-in-2025-wargame-print-and-play-design-cont', '2026-09-07', '2026-09-07'),
  (22, 13, 3585125, 'The 2025 Roll & Write Game Design Contest', 2025, '2025', 'English', 'international',
   'pnp_core', 'standard', 'Results published', 'complete', 'Martin Melbardis, Alison Scott, Igor Zuber', NULL, NULL,
   '2025-10-01', '2025-12-01T23:59:00-05:00', '2026-02-01', '2026-02-15',
   'https://boardgamegeek.com/thread/3585125/the-2025-roll-and-write-game-design-contest', '2026-09-07', '2026-09-07');

INSERT INTO contest_sources (contest_id, kind, url, label, bgg_object_type, bgg_object_id, is_official, first_seen_at, last_verified_at)
SELECT id, 'main_thread', source_url, 'Main contest thread', 'thread', bgg_thread_id, 1, '2026-09-07', '2026-09-07'
FROM contests WHERE year=2025;

INSERT INTO contest_sources (contest_id, kind, url, label, bgg_object_type, bgg_object_id, is_official, first_seen_at, last_verified_at)
SELECT id, 'entries_geeklist', entries_url, 'Official entries GeekList', 'geeklist',
       CAST(substr(entries_url, instr(entries_url, '/geeklist/') + 10,
                   instr(substr(entries_url, instr(entries_url, '/geeklist/') + 10), '/') - 1) AS INTEGER),
       1, '2026-09-07', '2026-09-07'
FROM contests WHERE year=2025 AND entries_url IS NOT NULL;

INSERT INTO contest_phases (contest_id, phase_type, label_raw, sequence_number, status_raw, status_normalized, starts_at, ends_at, timezone, date_precision, source_url, first_seen_at, last_verified_at, notes) VALUES
  (12,'submissions','Submissions and Idea Phase',1,'Deadline January 1, 2025','complete','2024-10-01','2025-01-01T23:59:59-07:00','BGG time (MT)','second','https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07','2026-09-07',NULL),
  (12,'development','Development',2,'Deadline February 26, 2025','complete',NULL,'2025-02-26T23:59:59-07:00','BGG time (MT)','second','https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07','2026-09-07',NULL),
  (12,'voting','Voting',3,'March 17 to March 31, 2025','complete','2025-03-17','2025-03-31T23:59:59-06:00','BGG time (MT)','second','https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07','2026-09-07',NULL),
  (13,'submissions','Entry Deadline',1,'March 16, 2025','complete','2025-01-01','2025-03-16T23:59:00-06:00','BGG time (CST)','minute','https://boardgamegeek.com/thread/3436343/2025-9-card-nanogame-print-and-play-design-contest','2026-09-07','2026-09-07',NULL),
  (13,'component_ready','Component Ready',2,'April 1, 2025','complete',NULL,'2025-04-01T23:59:00-05:00','BGG time (CST label)','minute','https://boardgamegeek.com/thread/3436343/2025-9-card-nanogame-print-and-play-design-contest','2026-09-07','2026-09-07',NULL),
  (13,'contest_ready','Contest Ready',3,'April 15, 2025','complete',NULL,'2025-04-15T23:59:00-05:00','BGG time (CST label)','minute','https://boardgamegeek.com/thread/3436343/2025-9-card-nanogame-print-and-play-design-contest','2026-09-07','2026-09-07',NULL),
  (13,'voting','Voting',4,'May 1 to May 31, 2025','complete','2025-05-01','2025-05-31T23:59:00-05:00','BGG time (CST label)','minute','https://boardgamegeek.com/thread/3436343/2025-9-card-nanogame-print-and-play-design-contest','2026-09-07','2026-09-07',NULL),
  (14,'submissions','Game submissions',1,'January 15 to April 15, 2025','complete','2025-01-15','2025-04-15','BGG time','day','https://boardgamegeek.com/thread/3441385/2025-children-and-family-game-design-contest','2026-09-07','2026-09-07',NULL),
  (14,'voting','Voting',2,'May 1 to May 15, 2025','complete','2025-05-01','2025-05-15','BGG time','day','https://boardgamegeek.com/thread/3441385/2025-children-and-family-game-design-contest','2026-09-07','2026-09-07',NULL),
  (15,'submissions','Submissions',1,'March 30 to May 31, 2025','complete','2025-03-30','2025-05-31','BGG time (MT)','day','https://boardgamegeek.com/thread/3487579/2025-1-card-print-and-play-design-contest','2026-09-07','2026-09-07',NULL),
  (15,'development','Development',2,'Until June 30, 2025','complete',NULL,'2025-06-30','BGG time (MT)','day','https://boardgamegeek.com/thread/3487579/2025-1-card-print-and-play-design-contest','2026-09-07','2026-09-07',NULL),
  (15,'voting','Voting',3,'July 1 to July 31, 2025','complete','2025-07-01','2025-07-31T23:59:59-06:00','BGG time (MT)','second','https://boardgamegeek.com/thread/3487579/2025-1-card-print-and-play-design-contest','2026-09-07','2026-09-07',NULL),
  (16,'submissions','Submissions',1,'March 1 to May 15, 2025','complete','2025-03-01','2025-05-15T23:59:00-07:00','PST label','minute','https://boardgamegeek.com/thread/3470244/2025-solomode-contest','2026-09-07','2026-09-07',NULL),
  (16,'development','Development',2,'Deadline May 31, 2025','complete',NULL,'2025-05-31T23:59:00-07:00','PST label','minute','https://boardgamegeek.com/thread/3470244/2025-solomode-contest','2026-09-07','2026-09-07',NULL),
  (16,'voting','Voting',3,'June 10 to June 30, 2025','complete','2025-06-10','2025-06-30T23:59:00-07:00','PST label','minute','https://boardgamegeek.com/thread/3470244/2025-solomode-contest','2026-09-07','2026-09-07',NULL),
  (17,'submissions','Submissions',1,'June 1 to August 31, 2025','complete','2025-06-01','2025-08-31T23:59:59-06:00','BGG time (MT)','second','https://boardgamegeek.com/thread/3520713/2025-solitaire-print-and-play-contest','2026-09-07','2026-09-07',NULL),
  (17,'development','Development',2,'Until October 15, 2025','complete','2025-09-01','2025-10-15T23:59:59-06:00','BGG time (MT)','second','https://boardgamegeek.com/thread/3520713/2025-solitaire-print-and-play-contest','2026-09-07','2026-09-07',NULL),
  (17,'voting','Voting',3,'October 16 to November 15, 2025','complete','2025-10-16','2025-11-15T23:59:59-07:00','BGG time (MT)','second','https://boardgamegeek.com/thread/3520713/2025-solitaire-print-and-play-contest','2026-09-07','2026-09-07',NULL),
  (18,'submissions','Submissions',1,'June 22 to August 30, 2025','complete','2025-06-22','2025-08-30','CT','day','https://boardgamegeek.com/thread/3530940/2025-two-player-print-and-play-game-design-contest','2026-09-07','2026-09-07',NULL),
  (18,'voting','Voting',2,'September 22 to October 30, 2025','complete','2025-09-22','2025-10-30','CT','day','https://boardgamegeek.com/thread/3530940/2025-two-player-print-and-play-game-design-contest','2026-09-07','2026-09-07',NULL),
  (19,'submissions','Entry Deadline',1,'September 16, 2025','complete','2025-07-01','2025-09-16T23:59:00-05:00','BGG time (CST label)','minute','https://boardgamegeek.com/thread/3536713/2025-54-card-game-design-contest','2026-09-07','2026-09-07',NULL),
  (19,'component_ready','Component Ready',2,'October 1, 2025','complete',NULL,'2025-10-01T23:59:00-05:00','BGG time (CST label)','minute','https://boardgamegeek.com/thread/3536713/2025-54-card-game-design-contest','2026-09-07','2026-09-07',NULL),
  (19,'contest_ready','Contest Ready',3,'October 15, 2025','complete',NULL,'2025-10-15T23:59:00-05:00','BGG time (CST label)','minute','https://boardgamegeek.com/thread/3536713/2025-54-card-game-design-contest','2026-09-07','2026-09-07',NULL),
  (19,'voting','Voting',4,'November 1 to November 30, 2025','complete','2025-11-01','2025-11-30T23:59:00-06:00','BGG time (CST label)','minute','https://boardgamegeek.com/thread/3536713/2025-54-card-game-design-contest','2026-09-07','2026-09-07',NULL),
  (20,'submissions','Submissions',1,'Deadline December 1, 2025','complete','2025-09-01','2025-12-01','BGG time','day','https://boardgamegeek.com/thread/3569158/2025-traditional-deck-game-design-contest','2026-09-07','2026-09-07',NULL),
  (20,'voting','Voting',2,'December 17, 2025 to January 2, 2026','complete','2025-12-17','2026-01-02','BGG time','day','https://boardgamegeek.com/thread/3569158/2025-traditional-deck-game-design-contest','2026-09-07','2026-09-07',NULL),
  (21,'submissions','Submissions',1,'Deadline October 1, 2025','complete','2024-10-02','2025-10-01','BGG time','day','https://boardgamegeek.com/thread/3441044/results-in-2025-wargame-print-and-play-design-cont','2026-09-07','2026-09-07',NULL),
  (21,'voting','Voting',2,'November 11 to December 8, 2025','complete','2025-11-11','2025-12-08','BGG time','day','https://boardgamegeek.com/thread/3441044/results-in-2025-wargame-print-and-play-design-cont','2026-09-07','2026-09-07','Closing extended from December 1 to December 8.'),
  (22,'submissions','Submission Period',1,'October 15 to December 1, 2025','complete','2025-10-15','2025-12-01T23:59:00-05:00','EST label','minute','https://boardgamegeek.com/thread/3585125/the-2025-roll-and-write-game-design-contest','2026-09-07','2026-09-07',NULL),
  (22,'development','Development Phase',2,'December 2, 2025 to January 17, 2026','complete','2025-12-02','2026-01-17','unspecified','day','https://boardgamegeek.com/thread/3585125/the-2025-roll-and-write-game-design-contest','2026-09-07','2026-09-07',NULL),
  (22,'freeze','Freeze Period',3,'January 18 to January 30, 2026','complete','2026-01-18','2026-01-30','unspecified','day','https://boardgamegeek.com/thread/3585125/the-2025-roll-and-write-game-design-contest','2026-09-07','2026-09-07',NULL),
  (22,'voting','Voting Period',4,'February 1 to February 15, 2026','complete','2026-02-01','2026-02-15','unspecified','day','https://boardgamegeek.com/thread/3585125/the-2025-roll-and-write-game-design-contest','2026-09-07','2026-09-07',NULL);

INSERT INTO contest_checks (id, contest_id, checked_at, source_url, check_kind, outcome, notes)
SELECT id + 10, id, '2026-09-07', source_url, 'manual_web_baseline', 'complete',
       'Prima ricognizione dell’edizione 2025; nessun materiale di gioco aperto o scaricato.'
FROM contests WHERE year=2025;

INSERT INTO contest_status_history (contest_id, check_id, status_raw, status_normalized, observed_at, source_url, confidence, notes)
SELECT id, id + 10, status_raw, status_normalized, '2026-09-07', source_url, 'high', 'Baseline 2025 da thread ufficiale.'
FROM contests WHERE year=2025;

INSERT INTO contest_metric_observations
  (contest_id, check_id, metric_key, metric_label_raw, numeric_value, unit, method, is_official, source_url, observed_at, notes)
VALUES
  (12,22,'listed_entries','Games list',27,'entries','counted_from_official_list',1,'https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07','15 finali e 12 ritirate nella lista del thread.'),
  (12,22,'final_entries','Games list excluding Withdrawn',15,'entries','counted_from_official_list',1,'https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07',NULL),
  (12,22,'withdrawn_entries','Withdrawn',12,'entries','counted_from_official_list',1,'https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07',NULL),
  (19,29,'geeklist_items','2025 54-Card Game Design Contest Entries',28,'items','geeklist_header',1,'https://boardgamegeek.com/geeklist/360114/2025-54-card-game-design-contest-entries','2026-09-07','Conteggio della GeekList; stati da censire separatamente.'),
  (20,30,'listed_entries','Entries List',42,'entries','reported',1,'https://boardgamegeek.com/thread/3569158/2025-traditional-deck-game-design-contest','2026-09-07',NULL),
  (21,31,'geeklist_items','Entry GeekList items',19,'items','geeklist_header',1,'https://boardgamegeek.com/geeklist/351628/2025-wargame-print-and-play-game-design-contest-en','2026-09-07','Conteggio della GeekList; stati da censire separatamente.'),
  (22,32,'active_entries','Number of games entered in the contest',21,'entries','reported',1,'https://boardgamegeek.com/thread/3585125/the-2025-roll-and-write-game-design-contest','2026-09-07','Lista finale mostrata nel thread.'),
  (22,32,'withdrawn_entries','Number of games withdrawn from the contest',16,'entries','reported',1,'https://boardgamegeek.com/thread/3585125/the-2025-roll-and-write-game-design-contest','2026-09-07',NULL);

INSERT INTO contest_phase_history
  (phase_id, check_id, status_raw, status_normalized, starts_at, ends_at, observed_at, source_url, confidence, notes)
SELECT p.id, p.contest_id + 10, p.status_raw, p.status_normalized, p.starts_at, p.ends_at,
       '2026-09-07', p.source_url, 'high', 'Baseline delle fasi 2025.'
FROM contest_phases p JOIN contests c ON c.id=p.contest_id WHERE c.year=2025;

COMMIT;
