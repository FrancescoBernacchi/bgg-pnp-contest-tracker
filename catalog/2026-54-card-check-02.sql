-- Secondo controllo del 2026 54-Card Game Design Contest.
-- Verifica: 2026-09-04. Nessuna variazione rilevata; nessun materiale aperto.

BEGIN IMMEDIATE;

UPDATE contests SET
 status_raw='Contest active; entry deadline October 16, 2026',
 status_normalized='entries_open', last_verified_at='2026-09-04'
WHERE id=2;

UPDATE contest_sources SET last_verified_at='2026-09-04'
WHERE contest_id=2 AND url='https://boardgamegeek.com/thread/3746297/2026-54-card-game-design-contest';

UPDATE games SET last_verified_at='2026-09-04'
WHERE id IN (SELECT game_id FROM entries WHERE contest_id=2);

UPDATE entries SET last_verified_at='2026-09-04'
WHERE contest_id=2;

INSERT INTO contest_checks
 (id,contest_id,checked_at,source_url,check_kind,outcome,notes)
VALUES
 (18,2,'2026-09-04T22:32:06+02:00','https://boardgamegeek.com/thread/3746297/2026-54-card-game-design-contest','consistency_verification','verified_no_change','Verifica tecnica nello stesso giorno della baseline: lista Best Game invariata a 17 entry; non costituisce un rilevamento periodico. Nessun materiale aperto.');

INSERT INTO contest_status_history
 (contest_id,check_id,status_raw,status_normalized,effective_at,observed_at,source_url,confidence,notes)
VALUES
 (2,18,'Contest active; entry deadline October 16, 2026','entries_open','2026-08-01','2026-09-04T22:32:06+02:00','https://boardgamegeek.com/thread/3746297/2026-54-card-game-design-contest','high','Nessuna variazione rispetto al controllo precedente.');

INSERT INTO entry_status_history
 (entry_id,check_id,status_raw,status_normalized,materials_status_raw,materials_status_normalized,position,observed_at,source_url,confidence,notes)
SELECT id,18,status_raw,status_normalized,materials_status_raw,materials_status_normalized,position,
 '2026-09-04T22:32:06+02:00','https://boardgamegeek.com/thread/3746297/2026-54-card-game-design-contest','high','Presenza e posizione riconfermate; nessuna variazione rilevata dalla lista ufficiale.'
FROM entries WHERE contest_id=2;

INSERT INTO contest_metric_observations
 (contest_id,check_id,metric_key,metric_label_raw,numeric_value,unit,method,is_official,source_url,observed_at,notes)
VALUES
 (2,18,'entries_total','Best Game entries',17,'entries','reported_by_organizer',1,'https://boardgamegeek.com/thread/3746297/2026-54-card-game-design-contest','2026-09-04T22:32:06+02:00','Invariato dal primo controllo.'),
 (2,18,'entries_solo','Best Solo Game entries',4,'entries','reported_by_organizer',1,'https://boardgamegeek.com/thread/3746297/2026-54-card-game-design-contest','2026-09-04T22:32:06+02:00','Invariato.'),
 (2,18,'entries_cooperative','Best Cooperative Game entries',3,'entries','reported_by_organizer',1,'https://boardgamegeek.com/thread/3746297/2026-54-card-game-design-contest','2026-09-04T22:32:06+02:00','Invariato.'),
 (2,18,'entries_two_player','Best 2-Player Game entries',15,'entries','reported_by_organizer',1,'https://boardgamegeek.com/thread/3746297/2026-54-card-game-design-contest','2026-09-04T22:32:06+02:00','Invariato.'),
 (2,18,'entries_family','Best Family Game entries',9,'entries','reported_by_organizer',1,'https://boardgamegeek.com/thread/3746297/2026-54-card-game-design-contest','2026-09-04T22:32:06+02:00','Invariato.'),
 (2,18,'entries_party','Best Party Game entries',2,'entries','reported_by_organizer',1,'https://boardgamegeek.com/thread/3746297/2026-54-card-game-design-contest','2026-09-04T22:32:06+02:00','Prima osservazione esplicita della categoria.'),
 (2,18,'entries_artwork','Best Artwork entries',7,'entries','reported_by_organizer',1,'https://boardgamegeek.com/thread/3746297/2026-54-card-game-design-contest','2026-09-04T22:32:06+02:00','Prima osservazione esplicita della categoria.'),
 (2,18,'entries_new_designer','Best New Designer entries',4,'entries','reported_by_organizer',1,'https://boardgamegeek.com/thread/3746297/2026-54-card-game-design-contest','2026-09-04T22:32:06+02:00','Prima osservazione esplicita della categoria.');

COMMIT;
