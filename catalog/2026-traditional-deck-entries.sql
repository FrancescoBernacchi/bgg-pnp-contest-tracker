-- Baseline del 2026 Traditional Deck Game Design Contest dal thread principale BGG.
-- Verifica: 2026-09-04. Nessun materiale o sito esterno e' stato aperto.

BEGIN IMMEDIATE;

CREATE TEMP TABLE traditional_entry_import (
  position INTEGER PRIMARY KEY,
  title_raw TEXT NOT NULL,
  author_raw TEXT NOT NULL,
  players_raw TEXT,
  category_solo INTEGER NOT NULL,
  category_multiplayer INTEGER NOT NULL,
  rules_status TEXT,
  wip_thread_url TEXT
);

INSERT INTO traditional_entry_import VALUES
  (1, 'Poker Tricktaker', 'Gan', '3-4p', 0, 1, 'RULES AVAILABLE', 'https://boardgamegeek.com/thread/3761843/wip-poker-tricktaker-trick-taking-with-poker-melds'),
  (2, 'Jokers & Thieves', 'UberDante', '1p', 1, 0, 'Rules, video and digital version available', 'https://boardgamegeek.com/thread/3761871/wipjokers-and-thieves-2026-traditional-deck-contes'),
  (3, 'Three Tiers for Sweet Revenge', 'BrianK24', '1p', 1, 0, NULL, NULL),
  (4, 'TOWER DEFENDER', 'Victor "Vivaracho" Camacho', '1-4p', 1, 1, 'Rules Available', NULL),
  (5, 'Gob Crawl', 'Simone Guerra', '1p', 1, 0, NULL, NULL),
  (6, 'Virus', 'Mark', '1p', 1, 0, NULL, NULL),
  (7, 'Sweet Shop', 'WJRGamer', '1-4p', 1, 1, NULL, NULL),
  (8, 'Affair', 'Jackson Spanyard', '2p', 0, 1, 'RULES AVAILABLE', 'https://boardgamegeek.com/thread/3761909/affair-wip-rules-av'),
  (9, 'Foolish Faces', 'mrfixsimmons', '4-5p', 0, 1, NULL, NULL),
  (10, 'Bubbles Burst', 'Markus H', '2-6p', 0, 1, NULL, NULL),
  (11, 'Clash of the Magi', 'Mark', '2p', 0, 1, 'RULES AVAILABLE', NULL),
  (12, 'Witan', 'mandrel', '3-4p', 0, 1, 'RULES AVAILABLE', NULL),
  (13, 'Card Invaders', 'Aaron Min', '2p', 0, 1, NULL, NULL),
  (14, 'The Chase on Nine', 'Jenard Cabilao', '2p', 0, 1, NULL, NULL),
  (15, 'Root & Branch', 'Gabriel Munguia-Ramirez', '2p', 0, 1, NULL, NULL),
  (16, 'Red River Duel', 'kimrhyme', '2p', 0, 1, 'RULES AVAILABLE', NULL),
  (17, 'Nobilitea', 'JewellGames', '2p', 0, 1, NULL, NULL),
  (18, 'Earthlings!', 'WJRGamer', '2-4p', 0, 1, NULL, NULL);

UPDATE contests
SET bgg_thread_id = 3761810,
    status_raw = 'Contest started September 1; submissions open',
    status_normalized = 'entries_open',
    organizer = 'Edin Mujadzevic (@edvinus)',
    source_url = 'https://boardgamegeek.com/thread/3761810/2026-traditional-deck-game-design-contest',
    entries_url = 'https://designcontests.eu/enter/traditionaldeck',
    last_verified_at = '2026-09-04'
WHERE id = 3;

INSERT OR IGNORE INTO contest_sources (contest_id, kind, url, label, bgg_object_type, bgg_object_id, is_official, first_seen_at, last_verified_at) VALUES
  (3, 'main_thread', 'https://boardgamegeek.com/thread/3761810/2026-traditional-deck-game-design-contest', 'Main contest thread', 'thread', 3761810, 1, '2026-09-04', '2026-09-04'),
  (3, 'entry_form', 'https://designcontests.eu/enter/traditionaldeck', 'Official Design Contest Hub entry form', 'external', NULL, 1, '2026-09-04', '2026-09-04');

UPDATE contest_phases
SET source_url = 'https://boardgamegeek.com/thread/3761810/2026-traditional-deck-game-design-contest',
    status_raw = 'September 1 to December 1, 2026',
    last_verified_at = '2026-09-04',
    notes = 'Calendario confermato dal thread principale canonico.'
WHERE contest_id = 3 AND phase_type = 'submissions';

UPDATE contest_phases
SET source_url = 'https://boardgamegeek.com/thread/3761810/2026-traditional-deck-game-design-contest',
    status_raw = 'December 15 to December 31, 2026',
    last_verified_at = '2026-09-04',
    notes = 'Calendario confermato dal thread principale canonico.'
WHERE contest_id = 3 AND phase_type = 'voting';

INSERT INTO contest_phases (contest_id, phase_type, label_raw, sequence_number, status_raw, status_normalized, starts_at, ends_at, timezone, date_precision, source_url, first_seen_at, last_verified_at, notes) VALUES
  (3, 'mandatory_feedback', 'Deadline for mandatory feedback', 2, 'December 10th, 2026', 'planned', NULL, '2026-12-10', 'BGG time', 'day', 'https://boardgamegeek.com/thread/3761810/2026-traditional-deck-game-design-contest', '2026-09-04', '2026-09-04', NULL),
  (3, 'development', 'Development', 3, 'Until December 15th, 2026', 'planned', '2026-12-02', '2026-12-15', 'BGG time', 'day', 'https://boardgamegeek.com/thread/3761810/2026-traditional-deck-game-design-contest', '2026-09-04', '2026-09-04', NULL);

INSERT INTO contest_checks (id, contest_id, checked_at, source_url, check_kind, outcome, notes)
VALUES (12, 3, '2026-09-04T22:00:00+02:00', 'https://boardgamegeek.com/thread/3761810/2026-traditional-deck-game-design-contest', 'manual_entry_census', 'complete', 'Individuato il thread canonico e censite 18 entry uniche dalle categorie ufficiali; nessun materiale aperto.');

INSERT INTO contest_status_history (contest_id, check_id, status_raw, status_normalized, effective_at, observed_at, source_url, confidence, notes)
VALUES (3, 12, 'Contest started September 1; submissions open', 'entries_open', '2026-09-01', '2026-09-04T22:00:00+02:00', 'https://boardgamegeek.com/thread/3761810/2026-traditional-deck-game-design-contest', 'high', 'Sesta edizione; gestione entry tramite Design Contest Hub, senza GeekList.');

INSERT INTO games (id, canonical_title, status_raw, status_normalized, status_evidence, source_url, first_seen_at, last_verified_at)
SELECT 114 + position,
       title_raw,
       COALESCE(rules_status, 'Registered in official Entry List'),
       CASE WHEN rules_status IS NOT NULL THEN 'components_available' ELSE 'unknown' END,
       CASE WHEN rules_status IS NOT NULL THEN 'Disponibilita delle regole dichiarata nel titolo WIP indicizzato su BGG.' ELSE 'Presenza confermata nelle categorie ufficiali del thread principale.' END,
       COALESCE(wip_thread_url, 'https://boardgamegeek.com/thread/3761810/2026-traditional-deck-game-design-contest'),
       '2026-09-04', '2026-09-04'
FROM traditional_entry_import;

INSERT INTO people (id, display_name, bgg_username, profile_url)
SELECT 3000 + row_number() OVER (ORDER BY lower(author_raw)),
       author_raw,
       CASE WHEN instr(author_raw, ' ') = 0 THEN author_raw END,
       CASE WHEN instr(author_raw, ' ') = 0 THEN 'https://boardgamegeek.com/profile/' || author_raw END
FROM traditional_entry_import
GROUP BY lower(author_raw);

INSERT INTO game_credits (game_id, person_id, role, credit_raw)
SELECT 114 + s.position, p.id, 'designer', s.author_raw
FROM traditional_entry_import s
JOIN people p ON lower(p.display_name) = lower(s.author_raw);

INSERT INTO entries (id, contest_id, game_id, position, wip_thread_url, entry_url, entry_text_raw, status_raw, status_normalized, materials_status_raw, materials_status_normalized, first_seen_at, last_verified_at)
SELECT 114 + position,
       3,
       114 + position,
       position,
       wip_thread_url,
       'https://boardgamegeek.com/thread/3761810/2026-traditional-deck-game-design-contest',
       title_raw || ' by ' || author_raw || ' (' || COALESCE(players_raw, 'players unknown') || ')',
       COALESCE(rules_status, 'Registered in official Entry List'),
       CASE WHEN rules_status IS NOT NULL THEN 'components_available' ELSE 'unknown' END,
       rules_status,
       CASE WHEN rules_status IS NOT NULL THEN 'available_declared' ELSE 'unknown' END,
       '2026-09-04', '2026-09-04'
FROM traditional_entry_import;

INSERT INTO entry_status_history (entry_id, check_id, status_raw, status_normalized, materials_status_raw, materials_status_normalized, position, observed_at, source_url, confidence, notes)
SELECT e.id, 12, e.status_raw, e.status_normalized, e.materials_status_raw, e.materials_status_normalized, e.position, '2026-09-04T22:00:00+02:00', e.entry_url, CASE WHEN e.wip_thread_url IS NULL THEN 'medium' ELSE 'high' END, 'Prima osservazione; nessun materiale aperto.'
FROM entries e WHERE e.contest_id = 3;

INSERT INTO contest_metric_observations (contest_id, check_id, metric_key, metric_label_raw, numeric_value, unit, method, is_official, source_url, observed_at, notes) VALUES
  (3, 12, 'entries_total', 'Unique entries in official category lists', 18, 'entries', 'deduplicated_from_official_lists', 1, 'https://boardgamegeek.com/thread/3761810/2026-traditional-deck-game-design-contest', '2026-09-04T22:00:00+02:00', 'Unione deduplicata delle liste Best Solo Game e Best Multiplayer Game.'),
  (3, 12, 'entries_solo', 'Best Solo Game entries', 6, 'entries', 'reported_by_organizer', 1, 'https://boardgamegeek.com/thread/3761810/article/48124569#48124569', '2026-09-04T22:00:00+02:00', NULL),
  (3, 12, 'entries_multiplayer', 'Best Multiplayer Game entries', 14, 'entries', 'reported_by_organizer', 1, 'https://boardgamegeek.com/thread/3761810/article/48124571#48124571', '2026-09-04T22:00:00+02:00', NULL),
  (3, 12, 'entries_rules_available_identified', 'Entries with rules availability visible in indexed BGG metadata', 7, 'entries', 'counted_from_bgg_metadata', 0, 'https://boardgamegeek.com/thread/3761810/2026-traditional-deck-game-design-contest', '2026-09-04T22:00:00+02:00', 'Conteggio prudenziale; le altre entry non sono classificate come prive di regole, ma come stato non verificato.');

DROP TABLE traditional_entry_import;

COMMIT;
