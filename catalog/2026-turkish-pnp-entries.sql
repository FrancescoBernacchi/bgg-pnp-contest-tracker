-- Stato ed entry del 2026 Turkish PnP Contest ricavati dal thread ufficiale.
-- Verifica: 2026-09-04. Nessun materiale di gioco e' stato aperto o scaricato.

BEGIN IMMEDIATE;

CREATE TEMP TABLE turkish_entry_import (
  position INTEGER PRIMARY KEY,
  title_raw TEXT NOT NULL,
  author_display TEXT NOT NULL,
  bgg_username TEXT,
  participation_status TEXT NOT NULL,
  wip_thread_url TEXT
);

INSERT INTO turkish_entry_import VALUES
  (1, 'Fast & Tasty', 'Okan Akdoğan', '@LeonidasPHX', 'active_files_completed', 'https://boardgamegeek.com/thread/3701873/fast-and-tasty-2026-turkce-yazdir-ve-oyna-pnp-tasa'),
  (2, 'Tarihi Komutanlar & Savaşçılar', 'Eren Orhan', '@haeshin', 'active_files_completed', NULL),
  (3, 'Kovan', 'Berkay Akpınar', '@berkayakpinar', 'active_files_completed', NULL),
  (4, 'Prestij Galerisi', 'Kayra Turan', '@Kayratrn', 'active_files_completed', NULL),
  (5, 'Zombiler, Kız Grubu, Aşçı, Oxford Virgülü, ve Taşınabilir Tek Delikli Delgeç', 'Semih Çağatay', '@MarsGameColony', 'active_files_completed', NULL),
  (6, 'Evdeyiz', 'Fatih Gençkal', '@fatiguita', 'active_files_completed', NULL),
  (7, 'Shrouded Skyline (Örtülü Ufuk)', 'Berkay Alp', '@BerkayAlp', 'active_files_completed', 'https://boardgamegeek.com/thread/3723715/contest-ready-shrouded-skyline-ortulu-ufuk-2026-tu'),
  (8, 'Sevkiyat Ustası', 'Okan Akdoğan', '@LeonidasPHX', 'active_files_completed', NULL),
  (9, 'DESIRE FOR CHAOS', 'Umutcan Erkmen', '@Umutcan_Erkmen', 'active_files_completed', NULL),
  (10, 'Akasha: Elementlerin Döngüsü', 'Göksel Köse', '@goxel', 'active_files_completed', NULL),
  (11, 'Arkaso Kartlar', 'Berk Mutlu', '@merkmurk', 'active_files_completed', 'https://boardgamegeek.com/thread/3730642/contest-ready-arkaso-kartlar-2026-turkce-yazdir-ve'),
  (12, 'Kozmik Kaos', 'İbrahim Dinçer', '@Dincerdes', 'active_files_completed', NULL),
  (13, 'What A Match! / Ne Maç Ama!', 'Sezgin Rızaoğlu', '@SevTheGame', 'active_files_completed', NULL),
  (14, 'Plaza Savaşları', 'Burakcan ORHAN / İrem Sancak ORHAN', '@Vantaburak', 'active_files_completed', NULL),
  (15, 'Zhud', 'Gökhan Özdemir', NULL, 'withdrawn', NULL),
  (16, 'David''s vs Goliath', 'Enes Kaan Gül', NULL, 'withdrawn', NULL),
  (17, 'Pervasız Sergüzeşt', 'Ozancan Altun', NULL, 'withdrawn', NULL),
  (18, 'Cadı Çemberi', 'Yusuf Afacan', NULL, 'withdrawn', NULL),
  (19, '666', 'Kerem Y.', NULL, 'withdrawn', NULL),
  (20, 'Büyük Loncalar', 'Arda Güner', NULL, 'withdrawn', NULL);

UPDATE contests
SET status_raw = 'Playtest period extended to 7 September 2026 23:59 TRT; voting form not yet ready',
    status_normalized = 'playtest',
    last_verified_at = '2026-09-04'
WHERE id = 5;

UPDATE contest_phases
SET status_raw = 'Original voting schedule superseded by playtest extension; voting form not ready on 31 August',
    status_normalized = 'superseded',
    last_verified_at = '2026-09-04',
    notes = COALESCE(notes || ' ', '') || 'Il 31 agosto l''organizzatore ha rinviato l''apertura del voto; nuove date non ancora pubblicate.'
WHERE contest_id = 5 AND phase_type = 'voting';

INSERT INTO contest_phases (contest_id, phase_type, label_raw, sequence_number, status_raw, status_normalized, starts_at, ends_at, timezone, date_precision, source_url, first_seen_at, last_verified_at, notes)
VALUES
  (5, 'playtest_extension', 'PLAYTEST SÜRECİ HATIRLATMA VE UZATMA', 4, 'Playtest deadline extended by one week to 7 September 2026 23:59', 'active', '2026-09-01T00:00:00+03:00', '2026-09-07T23:59:00+03:00', 'TRT', 'minute', 'https://boardgamegeek.com/thread/3701420/2026-turkce-yazdir-ve-oyna-pnp-kutu-oyunu-tasarim/page/3', '2026-09-04', '2026-09-04', 'Proroga dovuta al modulo di voto non pronto e a feedback obbligatori ancora mancanti.'),
  (5, 'voting_revised', 'Revised voting period', 5, 'Voting delayed; revised dates not yet announced', 'planned', NULL, NULL, 'TRT', 'unknown', 'https://boardgamegeek.com/thread/3701420/2026-turkce-yazdir-ve-oyna-pnp-kutu-oyunu-tasarim/page/3', '2026-09-04', '2026-09-04', 'Monitorare la pubblicazione del modulo e delle nuove date.');

INSERT INTO contest_checks (id, contest_id, checked_at, source_url, check_kind, outcome, notes)
VALUES (11, 5, '2026-09-04T21:00:00+02:00', 'https://boardgamegeek.com/thread/3701420/2026-turkce-yazdir-ve-oyna-pnp-kutu-oyunu-tasarim/page/3', 'manual_entry_census', 'complete', 'Verificata la proroga e censite le liste ufficiali di 14 entry attive e 6 ritirate; nessun materiale aperto.');

INSERT INTO contest_status_history (contest_id, check_id, status_raw, status_normalized, effective_at, observed_at, source_url, confidence, notes)
VALUES (5, 11, 'Playtest period extended to 7 September 2026 23:59 TRT; voting form not yet ready', 'playtest', '2026-09-01T00:00:00+03:00', '2026-09-04T21:00:00+02:00', 'https://boardgamegeek.com/thread/3701420/2026-turkce-yazdir-ve-oyna-pnp-kutu-oyunu-tasarim/page/3', 'high', 'Aggiornamento ufficiale dell''organizzatore pubblicato il 31 agosto.');

INSERT INTO games (id, canonical_title, status_raw, status_normalized, status_evidence, source_url, first_seen_at, last_verified_at)
SELECT 94 + position,
       title_raw,
       CASE WHEN participation_status = 'withdrawn' THEN 'Withdrawn: files not completed by deadline' ELSE 'Files completed; active participant' END,
       CASE WHEN participation_status = 'withdrawn' THEN 'withdrawn' ELSE 'components_available' END,
       'Lista ufficiale pubblicata dall''organizzatore nel thread principale il 9 agosto.',
       COALESCE(wip_thread_url, 'https://boardgamegeek.com/thread/3701420/article/48032459#48032459'),
       '2026-09-04',
       '2026-09-04'
FROM turkish_entry_import;

INSERT INTO people (id, display_name, bgg_username, profile_url)
SELECT 2000 + row_number() OVER (ORDER BY identity_key),
       MAX(author_display),
       NULLIF(MAX(bgg_username), ''),
       CASE WHEN NULLIF(MAX(bgg_username), '') IS NOT NULL THEN 'https://boardgamegeek.com/profile/' || ltrim(MAX(bgg_username), '@') END
FROM (
  SELECT *, COALESCE(NULLIF(lower(bgg_username), ''), lower(author_display)) AS identity_key
  FROM turkish_entry_import
)
GROUP BY identity_key;

INSERT INTO game_credits (game_id, person_id, role, credit_raw)
SELECT 94 + s.position, p.id, 'designer', s.author_display || CASE WHEN s.bgg_username IS NOT NULL THEN ' ' || s.bgg_username ELSE '' END
FROM turkish_entry_import s
JOIN people p ON COALESCE(NULLIF(lower(p.bgg_username), ''), lower(p.display_name)) = COALESCE(NULLIF(lower(s.bgg_username), ''), lower(s.author_display));

INSERT INTO entries (id, contest_id, game_id, position, wip_thread_url, entry_url, entry_text_raw, status_raw, status_normalized, materials_status_raw, materials_status_normalized, first_seen_at, last_verified_at, withdrawn_at)
SELECT 94 + position,
       5,
       94 + position,
       position,
       wip_thread_url,
       'https://boardgamegeek.com/thread/3701420/article/48032459#48032459',
       title_raw || ' — designer: ' || author_display,
       CASE WHEN participation_status = 'withdrawn' THEN 'Withdrawn: files not completed by deadline' ELSE 'Files completed; active participant' END,
       CASE WHEN participation_status = 'withdrawn' THEN 'withdrawn' ELSE 'components_available' END,
       CASE WHEN participation_status = 'withdrawn' THEN NULL ELSE 'Game files completed by deadline according to organizer' END,
       CASE WHEN participation_status = 'withdrawn' THEN 'unknown' ELSE 'available_declared' END,
       '2026-09-04',
       '2026-09-04',
       CASE WHEN participation_status = 'withdrawn' THEN '2026-08-09' END
FROM turkish_entry_import;

INSERT INTO entry_status_history (entry_id, check_id, status_raw, status_normalized, materials_status_raw, materials_status_normalized, position, observed_at, source_url, confidence, notes)
SELECT e.id, 11, e.status_raw, e.status_normalized, e.materials_status_raw, e.materials_status_normalized, e.position, '2026-09-04T21:00:00+02:00', e.entry_url, 'high', 'Stato tratto dalla lista ufficiale dell''organizzatore; nessun file aperto.'
FROM entries e
WHERE e.contest_id = 5;

INSERT INTO contest_metric_observations (contest_id, check_id, metric_key, metric_label_raw, numeric_value, unit, method, is_official, source_url, observed_at, notes) VALUES
  (5, 11, 'entries_active', 'Yarışmaya katılımı ve oyun dosyalarını tamamlayan oyunlar tam liste', 14, 'entries', 'reported_by_organizer', 1, 'https://boardgamegeek.com/thread/3701420/article/48032459#48032459', '2026-09-04T21:00:00+02:00', 'Giochi che hanno completato i file entro la scadenza.'),
  (5, 11, 'entries_withdrawn', 'Yarışmadan çekilen oyunlar tam liste', 6, 'entries', 'reported_by_organizer', 1, 'https://boardgamegeek.com/thread/3701420/article/48032459#48032459', '2026-09-04T21:00:00+02:00', 'Ritirati perché non hanno completato i file entro la scadenza.'),
  (5, 11, 'entries_total_known', 'Active plus withdrawn entries', 20, 'entries', 'derived_from_official_lists', 0, 'https://boardgamegeek.com/thread/3701420/article/48032459#48032459', '2026-09-04T21:00:00+02:00', 'Somma delle due liste ufficiali; non include progetti arrivati troppo tardi per partecipare.');

DROP TABLE turkish_entry_import;

COMMIT;
