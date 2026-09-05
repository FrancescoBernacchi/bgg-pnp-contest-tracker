-- Viste operative per monitoraggio, perimetro e dipendenze delle entry.

PRAGMA foreign_keys = ON;
BEGIN IMMEDIATE;

CREATE VIEW v_contests_monitoring_all AS
SELECT
    c.id AS contest_id,
    c.name AS contest_name,
    c.year,
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

CREATE VIEW v_entries_standalone AS
SELECT
    e.id AS entry_id,
    e.contest_id,
    c.name AS contest_name,
    c.scope_type,
    c.treatment_profile,
    e.position,
    e.game_id,
    g.canonical_title,
    e.status_raw,
    e.status_normalized,
    e.materials_status_raw,
    e.materials_status_normalized,
    e.entry_kind,
    e.base_game_dependency,
    e.entry_url,
    e.last_verified_at
FROM entries e
JOIN games g ON g.id = e.game_id
JOIN contests c ON c.id = e.contest_id
WHERE e.entry_kind = 'standalone_game';

CREATE VIEW v_entries_dependent_variants AS
SELECT
    e.id AS entry_id,
    e.contest_id,
    c.name AS contest_name,
    c.scope_type,
    c.treatment_profile,
    e.position,
    e.game_id,
    g.canonical_title,
    e.status_raw,
    e.status_normalized,
    e.materials_status_raw,
    e.materials_status_normalized,
    e.entry_kind,
    e.base_game_dependency,
    e.entry_url,
    e.last_verified_at
FROM entries e
JOIN games g ON g.id = e.game_id
JOIN contests c ON c.id = e.contest_id
WHERE e.entry_kind = 'dependent_variant';

COMMIT;
