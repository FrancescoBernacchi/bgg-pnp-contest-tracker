-- Classificazione strutturata dei contest adiacenti e delle entry dipendenti.

PRAGMA foreign_keys = ON;
BEGIN IMMEDIATE;

ALTER TABLE contests ADD COLUMN scope_type TEXT NOT NULL DEFAULT 'pnp_core'
    CHECK (scope_type IN ('pnp_core', 'adjacent'));
ALTER TABLE contests ADD COLUMN treatment_profile TEXT NOT NULL DEFAULT 'standard'
    CHECK (treatment_profile IN ('standard', 'format_adjacent', 'selective_entries', 'dependent_variants'));

ALTER TABLE entries ADD COLUMN entry_kind TEXT NOT NULL DEFAULT 'standalone_game'
    CHECK (entry_kind IN ('standalone_game', 'dependent_variant', 'unknown'));
ALTER TABLE entries ADD COLUMN base_game_dependency TEXT NOT NULL DEFAULT 'none'
    CHECK (base_game_dependency IN ('none', 'required', 'unknown'));

UPDATE contests SET scope_type='adjacent', treatment_profile='format_adjacent' WHERE id=3;
UPDATE contests SET scope_type='adjacent', treatment_profile='selective_entries' WHERE id=9;
UPDATE contests SET scope_type='adjacent', treatment_profile='dependent_variants' WHERE id=11;
UPDATE entries SET entry_kind='dependent_variant', base_game_dependency='required' WHERE contest_id=11;

CREATE INDEX idx_contests_scope ON contests(scope_type, treatment_profile, year DESC);
CREATE INDEX idx_entries_kind ON entries(contest_id, entry_kind, base_game_dependency);

COMMIT;
