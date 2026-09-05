PRAGMA foreign_keys = ON;

BEGIN IMMEDIATE;

CREATE TABLE contest_series (
    id INTEGER PRIMARY KEY,
    canonical_name TEXT NOT NULL UNIQUE,
    description TEXT,
    scope_notes TEXT,
    first_seen_at TEXT NOT NULL,
    last_verified_at TEXT NOT NULL
);

ALTER TABLE contests ADD COLUMN series_id INTEGER REFERENCES contest_series(id);
ALTER TABLE contests ADD COLUMN edition_label TEXT;
ALTER TABLE contests ADD COLUMN language TEXT;
ALTER TABLE contests ADD COLUMN geographic_scope TEXT;

CREATE TABLE contest_sources (
    id INTEGER PRIMARY KEY,
    contest_id INTEGER NOT NULL REFERENCES contests(id),
    kind TEXT NOT NULL,
    url TEXT NOT NULL,
    label TEXT,
    bgg_object_type TEXT,
    bgg_object_id INTEGER,
    is_official INTEGER NOT NULL DEFAULT 1 CHECK (is_official IN (0, 1)),
    first_seen_at TEXT NOT NULL,
    last_verified_at TEXT NOT NULL,
    UNIQUE (contest_id, url)
);

CREATE TABLE contest_phases (
    id INTEGER PRIMARY KEY,
    contest_id INTEGER NOT NULL REFERENCES contests(id),
    phase_type TEXT NOT NULL,
    label_raw TEXT NOT NULL,
    sequence_number INTEGER,
    status_raw TEXT,
    status_normalized TEXT NOT NULL DEFAULT 'unknown',
    starts_at TEXT,
    ends_at TEXT,
    timezone TEXT,
    date_precision TEXT NOT NULL DEFAULT 'unknown',
    source_url TEXT NOT NULL,
    first_seen_at TEXT NOT NULL,
    last_verified_at TEXT NOT NULL,
    notes TEXT,
    UNIQUE (contest_id, phase_type, label_raw)
);

CREATE TABLE contest_checks (
    id INTEGER PRIMARY KEY,
    contest_id INTEGER NOT NULL REFERENCES contests(id),
    checked_at TEXT NOT NULL,
    source_url TEXT NOT NULL,
    check_kind TEXT NOT NULL DEFAULT 'manual',
    outcome TEXT NOT NULL DEFAULT 'complete',
    notes TEXT,
    UNIQUE (contest_id, checked_at, source_url)
);

CREATE TABLE contest_status_history (
    id INTEGER PRIMARY KEY,
    contest_id INTEGER NOT NULL REFERENCES contests(id),
    check_id INTEGER REFERENCES contest_checks(id),
    status_raw TEXT,
    status_normalized TEXT NOT NULL,
    effective_at TEXT,
    observed_at TEXT NOT NULL,
    source_url TEXT NOT NULL,
    confidence TEXT,
    notes TEXT
);

CREATE TABLE contest_metric_observations (
    id INTEGER PRIMARY KEY,
    contest_id INTEGER NOT NULL REFERENCES contests(id),
    check_id INTEGER REFERENCES contest_checks(id),
    metric_key TEXT NOT NULL,
    metric_label_raw TEXT,
    numeric_value REAL,
    text_value TEXT,
    unit TEXT,
    method TEXT NOT NULL DEFAULT 'reported',
    is_official INTEGER NOT NULL DEFAULT 1 CHECK (is_official IN (0, 1)),
    source_url TEXT NOT NULL,
    observed_at TEXT NOT NULL,
    notes TEXT,
    CHECK (numeric_value IS NOT NULL OR text_value IS NOT NULL)
);

ALTER TABLE entries ADD COLUMN status_raw TEXT;
ALTER TABLE entries ADD COLUMN status_normalized TEXT NOT NULL DEFAULT 'unknown';
ALTER TABLE entries ADD COLUMN materials_status_raw TEXT;
ALTER TABLE entries ADD COLUMN materials_status_normalized TEXT NOT NULL DEFAULT 'unknown';
ALTER TABLE entries ADD COLUMN first_seen_at TEXT;
ALTER TABLE entries ADD COLUMN last_verified_at TEXT;

CREATE TABLE entry_status_history (
    id INTEGER PRIMARY KEY,
    entry_id INTEGER NOT NULL REFERENCES entries(id),
    check_id INTEGER REFERENCES contest_checks(id),
    status_raw TEXT,
    status_normalized TEXT NOT NULL,
    materials_status_raw TEXT,
    materials_status_normalized TEXT NOT NULL DEFAULT 'unknown',
    position INTEGER,
    observed_at TEXT NOT NULL,
    source_url TEXT NOT NULL,
    confidence TEXT,
    notes TEXT
);

CREATE INDEX idx_contests_series ON contests(series_id, year DESC);
CREATE INDEX idx_contest_sources_contest ON contest_sources(contest_id, kind);
CREATE INDEX idx_contest_phases_schedule ON contest_phases(contest_id, starts_at, ends_at);
CREATE INDEX idx_contest_checks_recent ON contest_checks(contest_id, checked_at DESC);
CREATE INDEX idx_contest_status_history_recent ON contest_status_history(contest_id, observed_at DESC);
CREATE INDEX idx_contest_metrics_recent ON contest_metric_observations(contest_id, metric_key, observed_at DESC);
CREATE INDEX idx_entries_status ON entries(contest_id, status_normalized);
CREATE INDEX idx_entry_status_history_recent ON entry_status_history(entry_id, observed_at DESC);

COMMIT;
