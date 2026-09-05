-- Baseline delle entry del 2026 54-Card Game Design Contest dal thread ufficiale BGG.
-- Verifica: 2026-09-04. Nessun collegamento ai materiali e' stato aperto.

BEGIN IMMEDIATE;

CREATE TEMP TABLE card54_entry_import (
  position INTEGER PRIMARY KEY,
  title_raw TEXT NOT NULL,
  author_raw TEXT NOT NULL,
  players_raw TEXT,
  status_raw TEXT,
  status_normalized TEXT NOT NULL,
  wip_thread_url TEXT
);

INSERT INTO card54_entry_import VALUES
  (1, 'Desire FOR Colors', 'Umutcan_Erkmen', '2-4p', 'Registered in official Best Game list', 'unknown', 'https://boardgamegeek.com/thread/3744281/desire-for-colors-2026-54-card-game-design-contest'),
  (2, 'Wild Chorus', 'Wanshun Wong', '2-8p', 'WIP', 'wip', 'https://boardgamegeek.com/thread/3746665/wip-wild-chorus-2-8-player-party-game-2026-54-card'),
  (3, 'Exclamation!', 'Simon Neech', '2p', 'COMPONENT READY', 'components_available', NULL),
  (4, 'Line O'' Dinos', 'Matthew Bishop', '2-4p', 'Registered in official Best Game list', 'unknown', 'https://boardgamegeek.com/thread/3746991/line-o-dinos-co-op-set-building-2026-54-card-conte'),
  (5, 'Samarra', 'Mark Goadrich', '2p', 'Registered in official Best Game list', 'unknown', NULL),
  (6, 'All You Can Draft', 'Georg Fischer', '2-5p', 'Components available', 'components_available', 'https://boardgamegeek.com/thread/3747598/all-you-can-draft-54-card-contest-2026-components'),
  (7, 'Tailor Made', 'zardon', '2-3p', 'IDEA PHASE', 'idea', 'https://boardgamegeek.com/thread/3752852/wip-tailor-made-2026-54-card-contest-idea-phase'),
  (8, 'Shelter', 'Bryan Hajtovik', '2-4p', 'WIP', 'wip', NULL),
  (9, 'Signum', 'René Uittenbogaard', '2-5p', 'IDEA PHASE', 'idea', 'https://boardgamegeek.com/thread/3754094/wip-signum-2026-54-card-game-design-contest-idea-p'),
  (10, 'The Window Seat', 'Scott Kaplowitz', '1p', 'Registered in official Best Game list', 'unknown', 'https://boardgamegeek.com/thread/3753549/'),
  (11, 'A Tale of Two Cities – Rising Rivals', 'Dirk Röttgers', '1-2p', 'WIP', 'wip', 'https://boardgamegeek.com/thread/3755558/wip-a-tale-of-two-cities-rising-rivals-a-complex-t'),
  (12, 'Flirt', 'Uncle Mac', '1-2p', 'Registered in official Best Game list', 'unknown', NULL),
  (13, 'The Acrobat of Transluciania', 'J.C. Pereira', '2-4p', 'WIP', 'wip', 'https://boardgamegeek.com/thread/3756058/wip-the-acrobats-of-transluciania-54-cards-contest'),
  (14, 'Maremmas', 'Iffix Y Santaph', '2-4p', 'Registered in official Best Game list', 'unknown', NULL),
  (15, 'Karda', 'Sebastian Sparfvinge', '2p', 'Registered in official Best Game list', 'unknown', NULL),
  (16, 'The Nine Lives of the Bureaucat', 'Tobias W', '1p', 'Registered in official Best Game list', 'unknown', NULL),
  (17, 'Runic', 'Graham', '2-4p', 'CONTEST READY', 'contest_ready', 'https://boardgamegeek.com/thread/3760327/contest-ready-runic-a-trick-taking-press-your-luck');

UPDATE contests
SET status_raw = 'Contest active; entry deadline October 16, 2026',
    status_normalized = 'entries_open',
    organizer = 'Edin Mujadzevic (@edvinus)',
    entries_url = 'https://designcontests.eu/enter/54cards',
    last_verified_at = '2026-09-04'
WHERE id = 2;

INSERT OR IGNORE INTO contest_sources (contest_id, kind, url, label, bgg_object_type, bgg_object_id, is_official, first_seen_at, last_verified_at) VALUES
  (2, 'entry_form', 'https://designcontests.eu/enter/54cards', 'Official Design Contest Hub entry form', 'external', NULL, 1, '2026-09-04', '2026-09-04');

INSERT INTO contest_phases (contest_id, phase_type, label_raw, sequence_number, status_raw, status_normalized, starts_at, ends_at, timezone, date_precision, source_url, first_seen_at, last_verified_at, notes) VALUES
  (2, 'earliest_public', 'Earliest Date for Games to be Publicly Available', 0, 'July 1st, 2026', 'complete', '2026-07-01', NULL, 'BGG time', 'day', 'https://boardgamegeek.com/thread/3746297/2026-54-card-game-design-contest', '2026-09-04', '2026-09-04', NULL),
  (2, 'playtest', 'Official Play Testing', 4, 'November 16th thru November 30th, 2026 11:59 PM BGG Time (CST)', 'planned', '2026-11-16', '2026-11-30T23:59:00-05:00', 'BGG time (labelled CST)', 'minute', 'https://boardgamegeek.com/thread/3746297/2026-54-card-game-design-contest', '2026-09-04', '2026-09-04', 'Il thread ufficiale corrente indica il 30 novembre; la precedente bozza riportava erroneamente November 31.');

INSERT INTO contest_checks (id, contest_id, checked_at, source_url, check_kind, outcome, notes)
VALUES (13, 2, '2026-09-04T23:00:00+02:00', 'https://boardgamegeek.com/thread/3746297/2026-54-card-game-design-contest', 'manual_entry_census', 'complete', 'Censite 17 entry dalla lista Best Game e verificato il calendario corrente; nessun materiale aperto.');

INSERT INTO contest_status_history (contest_id, check_id, status_raw, status_normalized, effective_at, observed_at, source_url, confidence, notes)
VALUES (2, 13, 'Contest active; entry deadline October 16, 2026', 'entries_open', '2026-08-01', '2026-09-04T23:00:00+02:00', 'https://boardgamegeek.com/thread/3746297/2026-54-card-game-design-contest', 'high', 'Nona edizione; entry gestite tramite Design Contest Hub senza GeekList.');

INSERT INTO games (id, canonical_title, status_raw, status_normalized, status_evidence, source_url, first_seen_at, last_verified_at)
SELECT 132 + position, title_raw, status_raw, status_normalized,
       CASE WHEN status_normalized = 'unknown' THEN 'Presenza confermata nella lista Best Game; stato WIP non verificato.' ELSE 'Stato dichiarato nel titolo del thread WIP indicizzato su BGG.' END,
       COALESCE(wip_thread_url, 'https://boardgamegeek.com/thread/3746297/2026-54-card-game-design-contest'),
       '2026-09-04', '2026-09-04'
FROM card54_entry_import;

INSERT INTO people (id, display_name, bgg_username, profile_url)
SELECT 4000 + row_number() OVER (ORDER BY lower(author_raw)), author_raw,
       CASE WHEN instr(author_raw, ' ') = 0 THEN author_raw END,
       CASE WHEN instr(author_raw, ' ') = 0 THEN 'https://boardgamegeek.com/profile/' || author_raw END
FROM card54_entry_import
GROUP BY lower(author_raw);

INSERT INTO game_credits (game_id, person_id, role, credit_raw)
SELECT 132 + s.position, p.id, 'designer', s.author_raw
FROM card54_entry_import s JOIN people p ON lower(p.display_name) = lower(s.author_raw);

INSERT INTO entries (id, contest_id, game_id, position, wip_thread_url, entry_url, entry_text_raw, status_raw, status_normalized, materials_status_raw, materials_status_normalized, first_seen_at, last_verified_at)
SELECT 132 + position, 2, 132 + position, position, wip_thread_url,
       'https://boardgamegeek.com/thread/3746297/2026-54-card-game-design-contest',
       title_raw || ' by ' || author_raw || ' (' || players_raw || ')', status_raw, status_normalized,
       CASE WHEN status_normalized IN ('components_available', 'contest_ready') THEN status_raw END,
       CASE WHEN status_normalized IN ('components_available', 'contest_ready') THEN 'available_declared' ELSE 'unknown' END,
       '2026-09-04', '2026-09-04'
FROM card54_entry_import;

INSERT INTO entry_status_history (entry_id, check_id, status_raw, status_normalized, materials_status_raw, materials_status_normalized, position, observed_at, source_url, confidence, notes)
SELECT e.id, 13, e.status_raw, e.status_normalized, e.materials_status_raw, e.materials_status_normalized, e.position, '2026-09-04T23:00:00+02:00', e.entry_url,
       CASE WHEN e.wip_thread_url IS NULL OR e.status_normalized = 'unknown' THEN 'medium' ELSE 'high' END,
       'Prima osservazione; nessun collegamento ai materiali aperto.'
FROM entries e WHERE e.contest_id = 2;

INSERT INTO contest_metric_observations (contest_id, check_id, metric_key, metric_label_raw, numeric_value, unit, method, is_official, source_url, observed_at, notes) VALUES
  (2, 13, 'entries_total', 'Best Game entries', 17, 'entries', 'reported_by_organizer', 1, 'https://boardgamegeek.com/thread/3746297/2026-54-card-game-design-contest', '2026-09-04T23:00:00+02:00', NULL),
  (2, 13, 'entries_solo', 'Best Solo Game entries', 4, 'entries', 'reported_by_organizer', 1, 'https://boardgamegeek.com/thread/3746297/2026-54-card-game-design-contest', '2026-09-04T23:00:00+02:00', NULL),
  (2, 13, 'entries_cooperative', 'Best Cooperative Game entries', 3, 'entries', 'reported_by_organizer', 1, 'https://boardgamegeek.com/thread/3746297/2026-54-card-game-design-contest', '2026-09-04T23:00:00+02:00', NULL),
  (2, 13, 'entries_two_player', 'Best 2-Player Game entries', 15, 'entries', 'reported_by_organizer', 1, 'https://boardgamegeek.com/thread/3746297/2026-54-card-game-design-contest', '2026-09-04T23:00:00+02:00', NULL),
  (2, 13, 'entries_family', 'Best Family Game entries', 9, 'entries', 'reported_by_organizer', 1, 'https://boardgamegeek.com/thread/3746297/2026-54-card-game-design-contest', '2026-09-04T23:00:00+02:00', NULL);

DROP TABLE card54_entry_import;

COMMIT;
