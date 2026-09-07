-- Censimento completo del 2025 In-Hand Game Design Contest.
-- Fonte verificata: thread ufficiale BGG, 2026-09-07. Nessun file di gioco aperto.

BEGIN IMMEDIATE;

INSERT INTO contest_checks (id, contest_id, checked_at, source_url, check_kind, outcome, notes) VALUES
  (33, 12, '2026-09-07', 'https://boardgamegeek.com/thread/3378403/article/44950039#44950039',
   'manual_web_census', 'complete', 'Censimento completo della lista finale e delle classifiche pubblicate nel thread ufficiale.');

INSERT INTO games (id, canonical_title, source_url, first_seen_at, last_verified_at, status_raw, status_normalized) VALUES
  (366,'Crop Rotation','https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07','2026-09-07','final entry','contest_complete'),
  (367,'Hand of Cthulhu','https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07','2026-09-07','final entry','contest_complete'),
  (368,'One Banner','https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07','2026-09-07','final entry','contest_complete'),
  (369,'One for sorrow','https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07','2026-09-07','final entry','contest_complete'),
  (370,'Valley of Gems','https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07','2026-09-07','final entry','contest_complete'),
  (371,'Maze Shift','https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07','2026-09-07','final entry','contest_complete'),
  (372,'Hand-At-Arms','https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07','2026-09-07','final entry','contest_complete'),
  (373,'Office Quest: Data Kraken','https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07','2026-09-07','final entry','contest_complete'),
  (374,'Dive Into The Dungeon','https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07','2026-09-07','final entry','contest_complete'),
  (375,'Publish or Perish','https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07','2026-09-07','final entry','contest_complete'),
  (376,'Songs of the Sea and the Sky','https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07','2026-09-07','final entry','contest_complete'),
  (377,'Smuggler''s Sky: Hand of Fate','https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07','2026-09-07','final entry','contest_complete'),
  (378,'Withering Grove','https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07','2026-09-07','final entry','contest_complete'),
  (379,'Spellbooked!','https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07','2026-09-07','final entry','contest_complete'),
  (380,'Librarian’s Cat','https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07','2026-09-07','final entry','contest_complete'),
  (381,'Duel: Clash of Metal','https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07','2026-09-07','Withdrawn','withdrawn'),
  (382,'Handicam','https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07','2026-09-07','Withdrawn','withdrawn'),
  (383,'Downtown Las Palmas','https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07','2026-09-07','Withdrawn','withdrawn'),
  (384,'Hellheim In-Hand Duel','https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07','2026-09-07','Withdrawn','withdrawn'),
  (385,'Prime Minister - The In-Hand Game','https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07','2026-09-07','Withdrawn','withdrawn'),
  (386,'Starcrossed','https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07','2026-09-07','Withdrawn','withdrawn'),
  (387,'HandMaze','https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07','2026-09-07','Withdrawn','withdrawn'),
  (388,'Dreadspire Keep','https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07','2026-09-07','Withdrawn','withdrawn'),
  (389,'Awake until midnight','https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07','2026-09-07','Withdrawn','withdrawn'),
  (390,'On the Trail of the Letter Cutter','https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07','2026-09-07','Withdrawn','withdrawn'),
  (391,'Black Market','https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07','2026-09-07','Withdrawn','withdrawn'),
  (392,'Memory Trick','https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07','2026-09-07','Withdrawn','withdrawn');

INSERT INTO entries
  (id, contest_id, game_id, position, entry_url, entry_text_raw, status_raw, status_normalized,
   materials_status_raw, materials_status_normalized, entered_at, first_seen_at, last_verified_at, withdrawn_at)
SELECT id, 12, id, id-365,
       'https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest',
       CASE WHEN id<=380 THEN 'Listed in GAMES LIST' ELSE 'Listed under Withdrawn' END,
       status_raw, CASE WHEN id<=380 THEN 'contest_ready' ELSE 'withdrawn' END,
       NULL, 'unknown', NULL, '2026-09-07', '2026-09-07', CASE WHEN id>380 THEN 'unknown' ELSE NULL END
FROM games WHERE id BETWEEN 366 AND 392;

INSERT INTO entry_status_history
  (entry_id, check_id, status_raw, status_normalized, materials_status_raw, materials_status_normalized,
   position, observed_at, source_url, confidence, notes)
SELECT id, 33, status_raw, status_normalized, materials_status_raw, materials_status_normalized,
       position, '2026-09-07', entry_url, 'high', 'Lista finale nel thread ufficiale; URL individuale non esposto dai collegamenti interni della pagina.'
FROM entries WHERE contest_id=12;

INSERT INTO rankings (contest_id, game_id, category, rank, is_official, evidence_url, verified_at) VALUES
  (12,369,'Best Overall Solo Game',1,1,'https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07'),
  (12,372,'Best Overall Solo Game',2,1,'https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07'),
  (12,377,'Best Overall Solo Game',3,1,'https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07'),
  (12,367,'Best Overall Solo Game',4,1,'https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07'),
  (12,376,'Best Overall Solo Game',5,1,'https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07'),
  (12,375,'Best Overall Solo Game',6,1,'https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07'),
  (12,366,'Best Overall Multiplayer Game',1,1,'https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07'),
  (12,379,'Best Overall Multiplayer Game',2,1,'https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07'),
  (12,374,'Best Overall Multiplayer Game',3,1,'https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07'),
  (12,376,'Best Overall Multiplayer Game',3,1,'https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07'),
  (12,377,'Best Rulebook',1,1,'https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07'),
  (12,369,'Best Rulebook',2,1,'https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07'),
  (12,372,'Best Rulebook',3,1,'https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07'),
  (12,375,'Best Rulebook',4,1,'https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07'),
  (12,366,'Best Rulebook',5,1,'https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07'),
  (12,376,'Best Rulebook',6,1,'https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07'),
  (12,369,'Most Visually Appealing',1,1,'https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07'),
  (12,372,'Most Visually Appealing',2,1,'https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07'),
  (12,367,'Most Visually Appealing',3,1,'https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07'),
  (12,370,'Most Visually Appealing',4,1,'https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07'),
  (12,376,'Most Visually Appealing',5,1,'https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07'),
  (12,374,'Most Visually Appealing',6,1,'https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07'),
  (12,369,'Clearest Graphic Design and Support for the Visually Impaired',1,1,'https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07'),
  (12,377,'Clearest Graphic Design and Support for the Visually Impaired',2,1,'https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07'),
  (12,367,'Clearest Graphic Design and Support for the Visually Impaired',3,1,'https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07'),
  (12,374,'Clearest Graphic Design and Support for the Visually Impaired',4,1,'https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07'),
  (12,372,'Clearest Graphic Design and Support for the Visually Impaired',5,1,'https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07'),
  (12,371,'Clearest Graphic Design and Support for the Visually Impaired',6,1,'https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07'),
  (12,369,'Best Use of Theme',1,1,'https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07'),
  (12,373,'Best Use of Theme',2,1,'https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07'),
  (12,377,'Best Use of Theme',3,1,'https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07'),
  (12,367,'Best Use of Theme',4,1,'https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07'),
  (12,374,'Best Use of Theme',5,1,'https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07'),
  (12,372,'Best Use of Theme',6,1,'https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07'),
  (12,376,'Most Innovative Mechanic',1,1,'https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07'),
  (12,372,'Most Innovative Mechanic',2,1,'https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07'),
  (12,371,'Most Innovative Mechanic',3,1,'https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07'),
  (12,374,'Most Innovative Mechanic',4,1,'https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07'),
  (12,380,'Most Innovative Mechanic',4,1,'https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07'),
  (12,377,'Most Innovative Mechanic',5,1,'https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07'),
  (12,367,'Most Innovative Mechanic',6,1,'https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07'),
  (12,372,'Ease of Holding',1,1,'https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07'),
  (12,371,'Ease of Holding',2,1,'https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07'),
  (12,369,'Ease of Holding',3,1,'https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07'),
  (12,366,'Ease of Holding',4,1,'https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07'),
  (12,367,'Ease of Holding',5,1,'https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07'),
  (12,368,'Ease of Holding',6,1,'https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07'),
  (12,377,'Best Low-Ink Printing',1,1,'https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07'),
  (12,369,'Best Low-Ink Printing',2,1,'https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07'),
  (12,368,'Best Low-Ink Printing',3,1,'https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07'),
  (12,379,'Best Low-Ink Printing',4,1,'https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07'),
  (12,371,'Best Low-Ink Printing',5,1,'https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07'),
  (12,378,'Best Low-Ink Printing',6,1,'https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07'),
  (12,375,'Best Low-Ink Printing',6,1,'https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07'),
  (12,374,'Best Low-Ink Printing',6,1,'https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07');

INSERT INTO contest_metric_observations
  (contest_id, check_id, metric_key, metric_label_raw, numeric_value, unit, method, is_official, source_url, observed_at, notes)
VALUES
  (12,33,'final_entries','GAMES LIST',15,'entries','counted_from_official_list',1,'https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07',NULL),
  (12,33,'withdrawn_entries','Withdrawn',12,'entries','counted_from_official_list',1,'https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07',NULL),
  (12,33,'game_rankings','Published game placements',55,'placements','counted_from_results_posts',1,'https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest','2026-09-07','Excludes the Best Playtester category and the empty traditional-card category.');

COMMIT;
