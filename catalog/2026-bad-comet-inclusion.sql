-- Inclusione selettiva del 2026 Bad Comet Cozy Game Design Contest.
-- Verifica: 2026-09-04. Le entry sono incluse solo quando una fonte BGG
-- dichiara una versione PnP o un formato affine concretamente utilizzabile.

BEGIN IMMEDIATE;

INSERT INTO contest_series (id, canonical_name, description, scope_notes, first_seen_at, last_verified_at) VALUES
  (9, 'Bad Comet Cozy Game Design Contest', 'Contest di design promosso da Bad Comet Games e discusso su BGG.', 'Inclusione adiacente selettiva: il contest è monitorato integralmente, le entry soltanto se PnP o similari.', '2026-09-04', '2026-09-04');

INSERT INTO contests (id, series_id, bgg_thread_id, name, year, edition_label, language, geographic_scope, status_raw, status_normalized, organizer, results_url, source_url, first_seen_at, last_verified_at) VALUES
  (9, 9, 3683796, '2026 Bad Comet Cozy Game Design Contest', 2026, '2026', 'English', 'international', '[WINNER ANNOUNCED]', 'complete', 'Bad Comet Games / Mark Kim (@mark34)', 'https://boardgamegeek.com/thread/3683796/finalists-announced-2026-bad-comet-cozy-game-desig/page/2', 'https://boardgamegeek.com/thread/3683796/submissions-closed-2026-bad-comet-cozy-game-design', '2026-09-04', '2026-09-04');

UPDATE contests SET scope_type='adjacent', treatment_profile='selective_entries' WHERE id=9;

INSERT INTO contest_sources (contest_id, kind, url, label, bgg_object_type, bgg_object_id, is_official, first_seen_at, last_verified_at) VALUES
  (9, 'main_thread', 'https://boardgamegeek.com/thread/3683796/submissions-closed-2026-bad-comet-cozy-game-design', 'Contest announcement and submissions thread', 'thread', 3683796, 1, '2026-09-04', '2026-09-04'),
  (9, 'results_thread', 'https://boardgamegeek.com/thread/3683796/finalists-announced-2026-bad-comet-cozy-game-desig/page/2', 'Winner announced state', 'thread', 3683796, 1, '2026-09-04', '2026-09-04');

INSERT INTO contest_phases (contest_id, phase_type, label_raw, sequence_number, status_raw, status_normalized, ends_at, timezone, date_precision, source_url, first_seen_at, last_verified_at, notes) VALUES
  (9, 'results', 'Winner announcement', 1, 'Winner: August 31st', 'complete', '2026-08-31', NULL, 'day', 'https://boardgamegeek.com/thread/3683796/finalists-announced-2026-bad-comet-cozy-game-desig/page/2', '2026-09-04', '2026-09-04', 'Le altre date del calendario richiedono un controllo successivo.');

INSERT INTO contest_checks (id, contest_id, checked_at, source_url, check_kind, outcome, notes) VALUES
  (9, 9, '2026-09-04', 'https://boardgamegeek.com/thread/3683796/finalists-announced-2026-bad-comet-cozy-game-desig/page/2', 'manual_web_baseline', 'partial', 'Contest incluso su decisione dell''utente; entry filtrate per carattere PnP o affine.');

INSERT INTO contest_status_history (contest_id, check_id, status_raw, status_normalized, observed_at, source_url, confidence, notes) VALUES
  (9, 9, '[WINNER ANNOUNCED]', 'complete', '2026-09-04', 'https://boardgamegeek.com/thread/3683796/finalists-announced-2026-bad-comet-cozy-game-desig/page/2', 'high', 'Stato esplicito nel titolo corrente del thread.');

INSERT INTO contest_metric_observations (contest_id, check_id, metric_key, metric_label_raw, numeric_value, unit, method, is_official, source_url, observed_at, notes) VALUES
  (9, 9, 'entries_total', 'field of 116 entries', 116, 'entries', 'reported_by_finalist', 0, 'https://boardgamegeek.com/thread/3726647/wip-ayla-bad-comet-cozy-contest-finalist', '2026-09-04', 'Segnale secondario dichiarato da una finalista; da verificare su fonte organizzatore.'),
  (9, 9, 'finalists_total', 'three finalists', 3, 'entries', 'reported_by_finalist', 0, 'https://boardgamegeek.com/thread/3726647/wip-ayla-bad-comet-cozy-contest-finalist', '2026-09-04', 'Segnale secondario coerente con lo stato Finalists Announced.'),
  (9, 9, 'entries_monitored_pnp', 'PnP or similar entries identified in first pass', 4, 'entries', 'counted_from_verified_threads', 0, 'https://boardgamegeek.com/thread/3683796/submissions-closed-2026-bad-comet-cozy-game-design', '2026-09-04', 'Sottoinsieme iniziale, non conteggio esaustivo.');

INSERT INTO games (id, canonical_title, status_raw, status_normalized, status_evidence, source_url, first_seen_at, last_verified_at) VALUES
  (1, 'AYLA', 'Finalist', 'contest_complete', 'WIP thread title and author update', 'https://boardgamegeek.com/thread/3726647/wip-ayla-bad-comet-cozy-contest-finalist', '2026-09-04', '2026-09-04'),
  (2, 'Rare Sight', 'PnP available', 'components_ready', 'Author announcement in contest thread', 'https://boardgamegeek.com/thread/3683796/finalists-announced-2026-bad-comet-cozy-game-desig/page/2', '2026-09-04', '2026-09-04'),
  (3, 'Stone Skipping', 'Closed; PnP listed', 'contest_complete', 'WIP thread title and PnP metadata', 'https://boardgamegeek.com/thread/3685593/wip-stone-skipping-bad-comet-cozy-contest', '2026-09-04', '2026-09-04'),
  (4, 'Firmament: The Valley''s Atlas', 'Playable prototype; PnP listed', 'components_ready', 'WIP thread metadata', 'https://boardgamegeek.com/thread/3691200/wip-firmament-bad-comet-cozy-contest', '2026-09-04', '2026-09-04');

INSERT INTO entries (id, contest_id, game_id, wip_thread_url, entry_url, status_raw, status_normalized, materials_status_raw, materials_status_normalized, first_seen_at, last_verified_at) VALUES
  (1, 9, 1, 'https://boardgamegeek.com/thread/3726647/wip-ayla-bad-comet-cozy-contest-finalist', 'https://boardgamegeek.com/thread/3726647/wip-ayla-bad-comet-cozy-contest-finalist', 'Finalist', 'contest_ready', 'Print and Play listed', 'available_declared', '2026-09-04', '2026-09-04'),
  (2, 9, 2, NULL, 'https://boardgamegeek.com/thread/3683796/finalists-announced-2026-bad-comet-cozy-game-desig/page/2', 'Entry; current placing not verified', 'unknown', 'Rulebook and print and play linked', 'available_declared', '2026-09-04', '2026-09-04'),
  (3, 9, 3, 'https://boardgamegeek.com/thread/3685593/wip-stone-skipping-bad-comet-cozy-contest', 'https://boardgamegeek.com/thread/3685593/wip-stone-skipping-bad-comet-cozy-contest', 'Closed', 'contest_ready', 'Print and Play listed', 'available_declared', '2026-09-04', '2026-09-04'),
  (4, 9, 4, 'https://boardgamegeek.com/thread/3691200/wip-firmament-bad-comet-cozy-contest', 'https://boardgamegeek.com/thread/3691200/wip-firmament-bad-comet-cozy-contest', 'Playable prototype', 'components_available', 'Print and Play listed', 'available_declared', '2026-09-04', '2026-09-04');

INSERT INTO entry_status_history (entry_id, check_id, status_raw, status_normalized, materials_status_raw, materials_status_normalized, observed_at, source_url, confidence, notes)
SELECT id, 9, status_raw, status_normalized, materials_status_raw, materials_status_normalized, '2026-09-04', entry_url, 'medium', 'Prima selezione basata esclusivamente su metadati visibili nelle fonti BGG.' FROM entries WHERE contest_id = 9;

COMMIT;
