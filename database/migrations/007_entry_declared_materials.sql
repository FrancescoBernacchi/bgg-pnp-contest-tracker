PRAGMA foreign_keys = ON;

CREATE TABLE entry_material_scans (
    id INTEGER PRIMARY KEY,
    entry_id INTEGER NOT NULL REFERENCES entries(id),
    checked_at TEXT NOT NULL,
    source_url TEXT NOT NULL,
    wip_status TEXT NOT NULL CHECK (wip_status IN ('found', 'not_found', 'not_checked')),
    material_listing_status TEXT NOT NULL CHECK (material_listing_status IN ('observed', 'none_declared', 'not_observable', 'not_checked')),
    coverage_scope TEXT NOT NULL DEFAULT 'first_post_only' CHECK (coverage_scope IN ('first_post_only', 'rules_integrated')),
    notes TEXT,
    UNIQUE (entry_id, checked_at, coverage_scope)
);

CREATE TABLE entry_material_requirements (
    id INTEGER PRIMARY KEY,
    entry_id INTEGER NOT NULL REFERENCES entries(id),
    material_kind TEXT NOT NULL,
    name_normalized TEXT NOT NULL,
    name_raw TEXT NOT NULL,
    quantity_raw TEXT,
    requirement_level TEXT NOT NULL DEFAULT 'required' CHECK (requirement_level IN ('required', 'optional', 'alternative', 'unclear')),
    supply_mode TEXT NOT NULL DEFAULT 'unspecified' CHECK (supply_mode IN ('printable', 'common', 'household', 'specialized', 'digital_device', 'supplied_or_printable', 'unspecified')),
    context_raw TEXT NOT NULL,
    source_url TEXT NOT NULL,
    first_seen_at TEXT NOT NULL,
    last_seen_at TEXT NOT NULL,
    UNIQUE (entry_id, material_kind, name_normalized, quantity_raw, requirement_level, source_url)
);

CREATE INDEX idx_entry_material_scans ON entry_material_scans(entry_id, checked_at DESC);
CREATE INDEX idx_entry_material_requirements ON entry_material_requirements(entry_id, material_kind, name_normalized);
