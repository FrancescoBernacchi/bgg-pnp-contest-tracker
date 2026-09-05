-- Secondo passaggio selettivo sulle entry Bad Comet Cozy 2026.
-- Verifica: 2026-09-04. Nessun link a materiali esterni è stato aperto.

BEGIN IMMEDIATE;

INSERT INTO games (id, canonical_title, status_raw, status_normalized, status_evidence, source_url, first_seen_at, last_verified_at) VALUES
  (5, 'Lanternwood', 'Playable Prototype (CURRENT): V1.1', 'playtest_ready', 'Il thread WIP dichiara un prototipo Tabletop Simulator corrente.', 'https://boardgamegeek.com/thread/3685657/wip-lanternwood-bad-comet-cozy-contest', '2026-09-04', '2026-09-04');

INSERT INTO entries (id, contest_id, game_id, wip_thread_url, entry_url, status_raw, status_normalized, materials_status_raw, materials_status_normalized, first_seen_at, last_verified_at, last_edited_at) VALUES
  (5, 9, 5, 'https://boardgamegeek.com/thread/3685657/wip-lanternwood-bad-comet-cozy-contest', 'https://boardgamegeek.com/thread/3685657/wip-lanternwood-bad-comet-cozy-contest', 'Playable Prototype (CURRENT): V1.1', 'playtest_ready', 'Tabletop Simulator prototype declared', 'digital_available_declared', '2026-09-04', '2026-09-04', '2026-06-29');

INSERT INTO entry_status_history (entry_id, check_id, status_raw, status_normalized, materials_status_raw, materials_status_normalized, observed_at, source_url, confidence, notes) VALUES
  (5, 9, 'Playable Prototype (CURRENT): V1.1', 'playtest_ready', 'Tabletop Simulator prototype declared', 'digital_available_declared', '2026-09-04', 'https://boardgamegeek.com/thread/3685657/wip-lanternwood-bad-comet-cozy-contest', 'high', 'Inclusa come entry similare digitale; nessun materiale aperto.');

INSERT INTO contest_metric_observations (contest_id, check_id, metric_key, metric_label_raw, numeric_value, unit, method, is_official, source_url, observed_at, notes) VALUES
  (9, 9, 'entries_monitored_pnp', 'PnP or similar entries identified after second pass', 5, 'entries', 'counted_from_verified_threads', 0, 'https://boardgamegeek.com/thread/3683796/submissions-closed-2026-bad-comet-cozy-game-design', '2026-09-04', 'Quattro entry con PnP dichiarato e una con prototipo digitale dichiarato.');

COMMIT;
