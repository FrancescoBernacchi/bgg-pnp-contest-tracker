-- Espone la data iniziale del contest nella vista operativa, utile per
-- l'ordinamento cronologico dei report senza interrogare le tabelle di base.

PRAGMA foreign_keys = ON;
BEGIN IMMEDIATE;

DROP VIEW IF EXISTS v_contests_pnp_core;
DROP VIEW IF EXISTS v_contests_adjacent;
DROP VIEW IF EXISTS v_contests_monitoring_all;

CREATE VIEW v_contests_monitoring_all AS
SELECT
    c.id AS contest_id,
    c.name AS contest_name,
    c.year,
    c.starts_at,
    c.status_raw,
    c.status_normalized,
    c.scope_type,
    c.treatment_profile,
    c.organizer,
    c.source_url,
    c.last_verified_at,
    COUNT(e.id) AS entry_count,
    COALESCE(SUM(CASE WHEN e.status_normalized = 'withdrawn' THEN 1 ELSE 0 END), 0) AS withdrawn_entry_count,
    COALESCE(SUM(CASE WHEN e.entry_kind = 'dependent_variant' THEN 1 ELSE 0 END), 0) AS dependent_variant_count,
    (
        SELECT p.phase_type
        FROM contest_phases p
        WHERE p.contest_id = c.id
          AND julianday(COALESCE(p.ends_at, p.starts_at)) >= julianday('now')
        ORDER BY julianday(COALESCE(p.ends_at, p.starts_at)), p.sequence_number
        LIMIT 1
    ) AS next_phase_type,
    (
        SELECT p.label_raw
        FROM contest_phases p
        WHERE p.contest_id = c.id
          AND julianday(COALESCE(p.ends_at, p.starts_at)) >= julianday('now')
        ORDER BY julianday(COALESCE(p.ends_at, p.starts_at)), p.sequence_number
        LIMIT 1
    ) AS next_phase_label,
    (
        SELECT COALESCE(p.ends_at, p.starts_at)
        FROM contest_phases p
        WHERE p.contest_id = c.id
          AND julianday(COALESCE(p.ends_at, p.starts_at)) >= julianday('now')
        ORDER BY julianday(COALESCE(p.ends_at, p.starts_at)), p.sequence_number
        LIMIT 1
    ) AS next_deadline
FROM contests c
LEFT JOIN entries e ON e.contest_id = c.id
GROUP BY c.id;

CREATE VIEW v_contests_pnp_core AS
SELECT * FROM v_contests_monitoring_all WHERE scope_type = 'pnp_core';

CREATE VIEW v_contests_adjacent AS
SELECT * FROM v_contests_monitoring_all WHERE scope_type = 'adjacent';

COMMIT;
