PRAGMA foreign_keys = ON;

BEGIN IMMEDIATE;

ALTER TABLE remote_resources ADD COLUMN access_type TEXT NOT NULL DEFAULT 'unknown';

CREATE TABLE entry_resource_scans (
    id INTEGER PRIMARY KEY,
    entry_id INTEGER NOT NULL REFERENCES entries(id),
    checked_at TEXT NOT NULL,
    source_url TEXT NOT NULL,
    wip_status TEXT NOT NULL CHECK (wip_status IN ('found', 'not_found', 'not_checked')),
    resource_listing_status TEXT NOT NULL CHECK (resource_listing_status IN ('observed', 'none_declared', 'not_observable', 'not_checked')),
    notes TEXT,
    UNIQUE (entry_id, checked_at)
);

CREATE TABLE entry_resource_mentions (
    id INTEGER PRIMARY KEY,
    entry_id INTEGER NOT NULL REFERENCES entries(id),
    remote_resource_id INTEGER NOT NULL REFERENCES remote_resources(id),
    source_url TEXT NOT NULL,
    label_raw TEXT,
    content_role TEXT NOT NULL DEFAULT 'other',
    is_primary INTEGER NOT NULL DEFAULT 0 CHECK (is_primary IN (0, 1)),
    first_seen_at TEXT NOT NULL,
    last_seen_at TEXT NOT NULL,
    UNIQUE (entry_id, remote_resource_id, content_role)
);

CREATE TABLE remote_resource_observations (
    id INTEGER PRIMARY KEY,
    remote_resource_id INTEGER NOT NULL REFERENCES remote_resources(id),
    observed_at TEXT NOT NULL,
    evidence_url TEXT NOT NULL,
    observation_kind TEXT NOT NULL CHECK (observation_kind IN ('declared_in_wip', 'availability_check')),
    availability_status TEXT NOT NULL CHECK (availability_status IN ('not_checked', 'available', 'unavailable', 'access_restricted', 'unknown')),
    version_raw TEXT,
    notes TEXT
);

CREATE INDEX idx_entry_resource_scans ON entry_resource_scans(entry_id, checked_at DESC);
CREATE INDEX idx_entry_resource_mentions ON entry_resource_mentions(entry_id, content_role);
CREATE INDEX idx_resource_observations ON remote_resource_observations(remote_resource_id, observed_at DESC);

COMMIT;
