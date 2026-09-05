-- Baseline completa della GeekList del 2026 Print and Play Wargame Design Contest.
-- Verifica: 2026-09-04. Nessun materiale di gioco e' stato aperto o scaricato.

BEGIN IMMEDIATE;

CREATE TEMP TABLE wargame_entry_import (
  position INTEGER PRIMARY KEY,
  title_raw TEXT NOT NULL,
  author_display TEXT NOT NULL,
  bgg_username TEXT,
  wip_thread_url TEXT NOT NULL,
  status_normalized TEXT NOT NULL,
  materials_status_normalized TEXT NOT NULL
);

INSERT INTO wargame_entry_import VALUES
  (1, '[Playtest ready] Hybrid War - 2026 Print and Play Wargame Design Contest', 'Greg Love', '@zombiewarrior07', 'https://boardgamegeek.com/thread/3628081/playtest-ready-hybrid-war-2026-print-and-play-warg', 'playtest_ready', 'available_declared'),
  (2, '[Playtest ready] OSSA- bones that decide fate - 2026 Print and Play Wargame Design Contest', 'Mauricio Cabaleiro Becker', '@mcbvix', 'https://boardgamegeek.com/thread/3631421/playtest-ready-ossa-bones-that-decide-fate-2026-pr', 'playtest_ready', 'available_declared'),
  (3, '[WIP] Warring States: West Africa (2026 Wargames PNP competition submission) PLAYTEST READY', 'Pete Holmes', '@Prh657', 'https://boardgamegeek.com/thread/3638470/wip-warring-states-west-africa-2026-wargames-pnp-c', 'playtest_ready', 'available_declared'),
  (4, '[WIP] A silent war at the end of the world (2026 Wargames PNP competition submission) [IDEA PHASE]', 'Florin Moldoveanu', '@Catlamp', 'https://boardgamegeek.com/thread/3640690/wip-a-silent-war-at-the-end-of-the-world-2026-warg', 'idea', 'unknown'),
  (5, '[WIP][Playtest ready] Cocci Wars (emergence simulator) - 2026 Print and Play Wargame Design Contest', '@Imposing_hotdog', NULL, 'https://boardgamegeek.com/thread/3634677/wipplaytest-ready-cocci-wars-emergence-simulator-2', 'playtest_ready', 'available_declared'),
  (6, '[WIP] Valour (2026 Wargames PNP competition submission) PLAYTEST READY', 'Florin Moldoveanu', '@Catlamp', 'https://boardgamegeek.com/thread/3649727/wip-valour-2026-wargames-pnp-competition-submissio', 'playtest_ready', 'available_declared'),
  (7, '[WIP] Operation BARDSEA (2026 Wargames pnp submission) [TTS Available]', 'RK Hall', '@rkmaymay', 'https://boardgamegeek.com/thread/3649842/wip-operation-bardsea-2026-wargames-pnp-submission', 'wip', 'digital_available_declared'),
  (8, '[WIP] The Ground Fortified - 2026 Print and Play Wargame Design Contest [Playtest Ready]', 'Felix Sonne', '@felixdsonne', 'https://boardgamegeek.com/thread/3655068/wip-the-ground-fortified-2026-print-and-play-warga', 'playtest_ready', 'available_declared'),
  (9, '(WIP) Slipstream Raiders - Robbing at Redline – 2026 PnP Wargame Contest', 'Robin Metz', '@Beaverlicious', 'https://boardgamegeek.com/thread/3668290/wip-slipstream-raiders-robbing-at-redline-2026-pnp', 'wip', 'unknown'),
  (10, '[WIP] The Battle of Stepney (2026 Wargames PNP contest submission), solo 20-40 mins.', 'Pete Holmes', '@Prh657', 'https://boardgamegeek.com/thread/3669635/wip-the-battle-of-stepney-2026-wargames-pnp-contes', 'wip', 'unknown'),
  (11, '[WIP] [Playtest Ready] Warhammer 40,000: Battle line', 'Patrick', '@xiaolo', 'https://boardgamegeek.com/thread/3669693/wip-playtest-ready-warhammer-40000-battle-line', 'playtest_ready', 'available_declared'),
  (12, 'WIP: Out of the Limelights, entry to 2026 PnP Wargame Design Contest', 'Pablo Martin', '@AgaPablo', 'https://boardgamegeek.com/thread/3692245/wip-out-of-the-limelights-entry-to-2026-pnp-wargam', 'wip', 'unknown'),
  (13, '[WIP] Gilgamesh vs. Enkidu', 'Brandon Chan', '@brandonloveskone', 'https://boardgamegeek.com/thread/3708703/wip-gilgamesh-vs-enkidu', 'wip', 'unknown'),
  (14, '[WIP] WARRING KINGDOMS [2026 Wargame Design Contestt] [PLAYTEST READY]', 'Guilherme Vieira', '@dsfsdfsdfwa', 'https://boardgamegeek.com/thread/3737758/wip-warring-kingdoms-2026-wargame-design-contestt', 'playtest_ready', 'available_declared'),
  (15, '[WIP] Gladiator (2026 Wargames PNP competition submission) MANUAL READY', 'Italo DeSantis', '@desantii', 'https://boardgamegeek.com/thread/3745494/wip-gladiator-2026-wargames-pnp-competition-submis', 'components_available', 'available_declared'),
  (16, '[WIP] CYBERAIDER (2026 Wargames PNP Competition Submission)', 'Patrick Wheeler', '@CousinPaddy', 'https://boardgamegeek.com/thread/3756688/wip-cyberaider-2026-wargames-pnp-competition-submi', 'wip', 'unknown'),
  (17, '[WIP] Mekamui. - 2026 Print and Play Wargame Design Contest', '@Bergenvd', NULL, 'https://boardgamegeek.com/thread/3762455/wip-mekamui-2026-print-and-play-wargame-design-con', 'wip', 'unknown'),
  (18, 'Balled Moves - A Snowball Fight in kindergarden for 2 players, Tiny ARCS with SCOUT mechanic! [IDEA PHASE]', 'Georg Fischer', '@Herr_Goldberg', 'https://boardgamegeek.com/thread/3763647/balled-moves-a-snowball-fight-in-kindergarden-for', 'idea', 'unknown');

UPDATE contests
SET status_raw = '[CONTEST OPEN]; submissions close October 1, 2026',
    status_normalized = 'entries_open',
    organizer = 'quantum potato (@quantumpotato)',
    voting_opens_at = '2026-11-11',
    voting_closes_at = '2026-12-21',
    last_verified_at = '2026-09-04'
WHERE id = 4;

INSERT INTO contest_phases (contest_id, phase_type, label_raw, sequence_number, status_raw, status_normalized, starts_at, ends_at, timezone, date_precision, source_url, first_seen_at, last_verified_at, notes) VALUES
  (4, 'earliest_public', 'Earliest date for game components to be available', 0, 'October 2, 2025', 'complete', '2025-10-02', NULL, 'BGG time', 'day', 'https://boardgamegeek.com/thread/3627732/contest-open-2026-print-and-play-wargame-design-co', '2026-09-04', '2026-09-04', NULL),
  (4, 'submissions', 'Submissions Close', 1, 'October 1, 2026', 'active', NULL, '2026-10-01', 'BGG time', 'day', 'https://boardgamegeek.com/thread/3627732/contest-open-2026-print-and-play-wargame-design-co', '2026-09-04', '2026-09-04', 'Entro questa data ogni entry deve essere giocabile, con regole e componenti disponibili.'),
  (4, 'development', 'Further development of existing entries', 2, 'Existing entries may be further developed after submissions close', 'planned', '2026-10-02', '2026-11-10', 'BGG time', 'day', 'https://boardgamegeek.com/thread/3627732/contest-open-2026-print-and-play-wargame-design-co', '2026-09-04', '2026-09-04', 'Intervallo inferito fra chiusura entry e apertura del voto; la fonte non assegna un nome formale alla fase.'),
  (4, 'voting', 'Voting', 3, 'November 11 to December 21, 2026', 'planned', '2026-11-11', '2026-12-21', 'BGG time', 'day', 'https://boardgamegeek.com/thread/3627732/contest-open-2026-print-and-play-wargame-design-co', '2026-09-04', '2026-09-04', 'Durante il voto i file PnP non possono essere modificati.'),
  (4, 'results', 'Results announcement', 4, 'Results will be announced shortly afterward', 'planned', NULL, NULL, 'BGG time', 'unknown', 'https://boardgamegeek.com/thread/3627732/contest-open-2026-print-and-play-wargame-design-co', '2026-09-04', '2026-09-04', NULL);

INSERT INTO contest_checks (id, contest_id, checked_at, source_url, check_kind, outcome, notes)
VALUES (14, 4, '2026-09-04T23:30:00+02:00', 'https://boardgamegeek.com/geeklist/369157/2026-wargame-design-contest-entries', 'manual_entry_census', 'complete', 'Censite integralmente le 18 entry della GeekList e verificato il calendario; nessun materiale aperto.');

INSERT INTO contest_status_history (contest_id, check_id, status_raw, status_normalized, observed_at, source_url, confidence, notes)
VALUES (4, 14, '[CONTEST OPEN]; submissions close October 1, 2026', 'entries_open', '2026-09-04T23:30:00+02:00', 'https://boardgamegeek.com/thread/3627732/contest-open-2026-print-and-play-wargame-design-co', 'high', 'Lo stato annunciato e la scadenza sono coerenti: nuove entry accettate fino al 1 ottobre.');

INSERT INTO games (id, canonical_title, status_raw, status_normalized, status_evidence, source_url, first_seen_at, last_verified_at)
SELECT 149 + position, title_raw, title_raw, status_normalized, 'Stato derivato esclusivamente dal titolo corrente della GeekList ufficiale.', wip_thread_url, '2026-09-04', '2026-09-04'
FROM wargame_entry_import;

INSERT INTO people (id, display_name, bgg_username, profile_url)
SELECT 5000 + row_number() OVER (ORDER BY identity_key), MAX(author_display), NULLIF(MAX(bgg_username), ''),
       CASE WHEN NULLIF(MAX(bgg_username), '') IS NOT NULL THEN 'https://boardgamegeek.com/profile/' || ltrim(MAX(bgg_username), '@') END
FROM (SELECT *, COALESCE(NULLIF(lower(bgg_username), ''), lower(author_display)) AS identity_key FROM wargame_entry_import)
GROUP BY identity_key;

INSERT INTO game_credits (game_id, person_id, role, credit_raw)
SELECT 149 + s.position, p.id, 'designer', s.author_display || CASE WHEN s.bgg_username IS NOT NULL THEN ' ' || s.bgg_username ELSE '' END
FROM wargame_entry_import s
JOIN people p ON COALESCE(NULLIF(lower(p.bgg_username), ''), lower(p.display_name)) = COALESCE(NULLIF(lower(s.bgg_username), ''), lower(s.author_display));

INSERT INTO entries (id, contest_id, game_id, geeklist_id, position, wip_thread_url, entry_url, entry_text_raw, status_raw, status_normalized, materials_status_raw, materials_status_normalized, first_seen_at, last_verified_at)
SELECT 149 + position, 4, 149 + position, 369157, position, wip_thread_url,
       'https://boardgamegeek.com/geeklist/369157/2026-wargame-design-contest-entries', title_raw, title_raw, status_normalized,
       CASE materials_status_normalized WHEN 'available_declared' THEN 'Playtest/manual availability declared in title' WHEN 'digital_available_declared' THEN 'TTS availability declared in title' END,
       materials_status_normalized, '2026-09-04', '2026-09-04'
FROM wargame_entry_import;

INSERT INTO entry_status_history (entry_id, check_id, status_raw, status_normalized, materials_status_raw, materials_status_normalized, position, observed_at, source_url, confidence, notes)
SELECT e.id, 14, e.status_raw, e.status_normalized, e.materials_status_raw, e.materials_status_normalized, e.position, '2026-09-04T23:30:00+02:00', e.entry_url, 'high', 'Prima osservazione dalla GeekList ufficiale; nessun materiale aperto.'
FROM entries e WHERE e.contest_id = 4;

INSERT INTO contest_metric_observations (contest_id, check_id, metric_key, metric_label_raw, numeric_value, unit, method, is_official, source_url, observed_at, notes) VALUES
  (4, 14, 'entries_total', '18 Items', 18, 'entries', 'reported_by_geeklist', 1, 'https://boardgamegeek.com/geeklist/369157/2026-wargame-design-contest-entries', '2026-09-04T23:30:00+02:00', NULL),
  (4, 14, 'entries_playtest_ready', 'Playtest Ready titles', 8, 'entries', 'derived_from_entry_titles', 0, 'https://boardgamegeek.com/geeklist/369157/2026-wargame-design-contest-entries', '2026-09-04T23:30:00+02:00', NULL),
  (4, 14, 'entries_components_available', 'Manual Ready titles', 1, 'entries', 'derived_from_entry_titles', 0, 'https://boardgamegeek.com/geeklist/369157/2026-wargame-design-contest-entries', '2026-09-04T23:30:00+02:00', NULL),
  (4, 14, 'entries_idea', 'Idea Phase titles', 2, 'entries', 'derived_from_entry_titles', 0, 'https://boardgamegeek.com/geeklist/369157/2026-wargame-design-contest-entries', '2026-09-04T23:30:00+02:00', NULL),
  (4, 14, 'entries_wip', 'WIP without physical readiness declaration', 7, 'entries', 'derived_from_entry_titles', 0, 'https://boardgamegeek.com/geeklist/369157/2026-wargame-design-contest-entries', '2026-09-04T23:30:00+02:00', 'Una delle sette entry dichiara un modulo TTS disponibile.');

DROP TABLE wargame_entry_import;

COMMIT;
