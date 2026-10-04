-- Esiti espliciti, append-only; nessun backfill implicito dai piazzamenti.
CREATE TABLE entry_work_observations (
    id INTEGER PRIMARY KEY,
    entry_id INTEGER NOT NULL REFERENCES entries(id),
    phase TEXT NOT NULL CHECK(phase IN ('ranking','materials','acquisition')),
    outcome TEXT NOT NULL CHECK(outcome IN ('complete','absent','not_applicable','partial','blocked','unknown')),
    observed_at TEXT NOT NULL,
    source_url TEXT NOT NULL,
    evidence_path TEXT NOT NULL,
    notes TEXT NOT NULL,
    UNIQUE(entry_id,phase,observed_at,source_url,evidence_path)
);
CREATE TABLE contest_census_observations (
    id INTEGER PRIMARY KEY,
    contest_id INTEGER NOT NULL REFERENCES contests(id),
    outcome TEXT NOT NULL CHECK(outcome IN ('complete','partial','blocked','unknown')),
    entry_ids_json TEXT NOT NULL,
    observed_at TEXT NOT NULL,
    source_url TEXT NOT NULL,
    evidence_path TEXT NOT NULL,
    notes TEXT NOT NULL
);
