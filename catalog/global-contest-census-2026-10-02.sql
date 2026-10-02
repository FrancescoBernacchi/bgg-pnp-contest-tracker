-- Nuova edizione osservata nel forum BGG il 2026-10-02.
-- Il thread ufficiale annuncia le iscrizioni dal 2026-10-15.
PRAGMA foreign_keys = ON;
BEGIN IMMEDIATE;

INSERT INTO contests
  (series_id, bgg_thread_id, name, year, edition_label, language, geographic_scope,
   scope_type, treatment_profile, status_raw, status_normalized, organizer,
   starts_at, submissions_close_at, voting_opens_at, voting_closes_at,
   source_url, first_seen_at, last_verified_at)
SELECT 13, 3776341, 'The 2026 Roll & Write Game Design Contest', 2026, '2026',
       'English', 'international', 'pnp_core', 'standard',
       'We are finally set to begin; submissions October 15 to December 1, 2026',
       'announced', 'Martin Melbardis and Igor Zuber',
       '2026-10-15', '2026-12-01T23:59:00-05:00', '2027-02-01', '2027-02-15',
       'https://boardgamegeek.com/thread/3776341/the-2026-roll-and-write-game-design-contest',
       '2026-10-02', '2026-10-02'
WHERE NOT EXISTS (SELECT 1 FROM contests WHERE bgg_thread_id = 3776341);

INSERT INTO contest_sources
  (contest_id, kind, url, label, bgg_object_type, bgg_object_id, is_official,
   first_seen_at, last_verified_at)
SELECT id, 'main_thread', source_url, 'Official contest announcement', 'thread',
       3776341, 1, '2026-10-02', '2026-10-02'
FROM contests
WHERE bgg_thread_id = 3776341
  AND NOT EXISTS (SELECT 1 FROM contest_sources WHERE contest_id = contests.id AND url = contests.source_url);

INSERT INTO contest_checks (contest_id, checked_at, source_url, check_kind, outcome, notes)
SELECT id, '2026-10-02', source_url, 'global_census_update', 'new_contest',
       'Nuovo thread ufficiale osservato nel forum Design Contests ordinato per data di creazione.'
FROM contests
WHERE bgg_thread_id = 3776341
  AND NOT EXISTS (SELECT 1 FROM contest_checks WHERE contest_id = contests.id AND checked_at = '2026-10-02' AND source_url = contests.source_url);

INSERT INTO contest_status_history
  (contest_id, check_id, status_raw, status_normalized, observed_at, source_url, confidence, notes)
SELECT c.id, cc.id, c.status_raw, c.status_normalized, '2026-10-02', c.source_url,
       'high', 'Il primo post annuncia il contest; la finestra di iscrizione inizia il 15 ottobre.'
FROM contests c
JOIN contest_checks cc ON cc.contest_id = c.id AND cc.checked_at = '2026-10-02' AND cc.source_url = c.source_url
WHERE c.bgg_thread_id = 3776341
  AND NOT EXISTS (SELECT 1 FROM contest_status_history WHERE contest_id = c.id AND check_id = cc.id);

COMMIT;
