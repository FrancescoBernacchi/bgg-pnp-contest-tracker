-- Le challenge da 24 ore sono mantenute nel catalogo, ma separate dai contest PnP principali.

PRAGMA foreign_keys = ON;
BEGIN IMMEDIATE;

UPDATE contests
SET scope_type = 'adjacent', treatment_profile = 'format_adjacent'
WHERE series_id IN (
    SELECT id FROM contest_series WHERE canonical_name = '24 Hour Design Challenge'
)
OR name LIKE '%24 Hour%';

-- Mantiene coerenti anche i profili che per definizione non sono giochi PnP autonomi.
UPDATE contests
SET scope_type = 'adjacent'
WHERE treatment_profile IN ('format_adjacent', 'selective_entries', 'dependent_variants');

COMMIT;
