-- Storicizza le fasi e le scadenze per consentire confronti fra rilevamenti.

PRAGMA foreign_keys = ON;
BEGIN IMMEDIATE;

CREATE TABLE contest_phase_history (
    id INTEGER PRIMARY KEY,
    phase_id INTEGER NOT NULL REFERENCES contest_phases(id),
    check_id INTEGER REFERENCES contest_checks(id),
    status_raw TEXT,
    status_normalized TEXT NOT NULL DEFAULT 'unknown',
    starts_at TEXT,
    ends_at TEXT,
    observed_at TEXT NOT NULL,
    source_url TEXT NOT NULL,
    confidence TEXT,
    notes TEXT
);

CREATE INDEX idx_contest_phase_history_recent
    ON contest_phase_history(phase_id, observed_at DESC);

INSERT INTO contest_phase_history (
    phase_id, check_id, status_raw, status_normalized, starts_at, ends_at,
    observed_at, source_url, confidence, notes
)
SELECT
    p.id, NULL, p.status_raw, p.status_normalized, p.starts_at, p.ends_at,
    c.last_verified_at, p.source_url, 'baseline',
    'Snapshot iniziale creato dalla migrazione 005.'
FROM contest_phases p
JOIN contests c ON c.id = p.contest_id;

COMMIT;
