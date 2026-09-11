PRAGMA foreign_keys = ON;

CREATE TABLE contest_series (
    id INTEGER PRIMARY KEY,
    canonical_name TEXT NOT NULL UNIQUE,
    description TEXT,
    scope_notes TEXT,
    first_seen_at TEXT NOT NULL,
    last_verified_at TEXT NOT NULL
);

CREATE TABLE contests (
    id INTEGER PRIMARY KEY,
    series_id INTEGER REFERENCES contest_series(id),
    bgg_thread_id INTEGER UNIQUE,
    name TEXT NOT NULL,
    year INTEGER,
    edition_label TEXT,
    language TEXT,
    geographic_scope TEXT,
    scope_type TEXT NOT NULL DEFAULT 'pnp_core' CHECK (scope_type IN ('pnp_core', 'adjacent')),
    treatment_profile TEXT NOT NULL DEFAULT 'standard' CHECK (treatment_profile IN ('standard', 'format_adjacent', 'selective_entries', 'dependent_variants')),
    status_raw TEXT,
    status_normalized TEXT NOT NULL DEFAULT 'unknown',
    organizer TEXT,
    entries_url TEXT,
    results_url TEXT,
    starts_at TEXT,
    submissions_close_at TEXT,
    voting_opens_at TEXT,
    voting_closes_at TEXT,
    source_url TEXT NOT NULL,
    first_seen_at TEXT NOT NULL,
    last_verified_at TEXT NOT NULL
);

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

CREATE TABLE games (
    id INTEGER PRIMARY KEY,
    canonical_title TEXT NOT NULL,
    summary TEXT,
    min_players INTEGER,
    max_players INTEGER,
    min_play_minutes INTEGER,
    max_play_minutes INTEGER,
    minimum_age INTEGER,
    language TEXT,
    status_raw TEXT,
    status_normalized TEXT NOT NULL DEFAULT 'unknown',
    status_evidence TEXT,
    source_url TEXT NOT NULL,
    first_seen_at TEXT NOT NULL,
    last_verified_at TEXT NOT NULL
);

CREATE TABLE game_names (
    id INTEGER PRIMARY KEY,
    game_id INTEGER NOT NULL REFERENCES games(id),
    name TEXT NOT NULL,
    observed_from TEXT,
    observed_at TEXT NOT NULL,
    is_current INTEGER NOT NULL DEFAULT 0 CHECK (is_current IN (0, 1))
);

CREATE TABLE people (
    id INTEGER PRIMARY KEY,
    display_name TEXT NOT NULL,
    bgg_username TEXT,
    profile_url TEXT
);

CREATE TABLE game_credits (
    game_id INTEGER NOT NULL REFERENCES games(id),
    person_id INTEGER NOT NULL REFERENCES people(id),
    role TEXT NOT NULL,
    credit_raw TEXT,
    PRIMARY KEY (game_id, person_id, role)
);

CREATE TABLE entries (
    id INTEGER PRIMARY KEY,
    contest_id INTEGER NOT NULL REFERENCES contests(id),
    game_id INTEGER NOT NULL REFERENCES games(id),
    geeklist_id INTEGER,
    geeklist_item_id INTEGER,
    position INTEGER,
    wip_thread_url TEXT,
    entry_url TEXT NOT NULL,
    entry_text_raw TEXT,
    status_raw TEXT,
    status_normalized TEXT NOT NULL DEFAULT 'unknown',
    materials_status_raw TEXT,
    materials_status_normalized TEXT NOT NULL DEFAULT 'unknown',
    entry_kind TEXT NOT NULL DEFAULT 'standalone_game' CHECK (entry_kind IN ('standalone_game', 'dependent_variant', 'unknown')),
    base_game_dependency TEXT NOT NULL DEFAULT 'none' CHECK (base_game_dependency IN ('none', 'required', 'unknown')),
    entered_at TEXT,
    first_seen_at TEXT NOT NULL,
    last_verified_at TEXT NOT NULL,
    last_edited_at TEXT,
    withdrawn_at TEXT,
    UNIQUE (contest_id, game_id)
);

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

CREATE TABLE rankings (
    id INTEGER PRIMARY KEY,
    contest_id INTEGER NOT NULL REFERENCES contests(id),
    game_id INTEGER NOT NULL REFERENCES games(id),
    category TEXT NOT NULL,
    rank INTEGER,
    score REAL,
    vote_count INTEGER,
    is_official INTEGER NOT NULL DEFAULT 1 CHECK (is_official IN (0, 1)),
    evidence_url TEXT NOT NULL,
    verified_at TEXT NOT NULL
);

CREATE TABLE remote_resources (
    id INTEGER PRIMARY KEY,
    game_id INTEGER NOT NULL REFERENCES games(id),
    kind TEXT NOT NULL,
    access_type TEXT NOT NULL DEFAULT 'unknown',
    url TEXT NOT NULL,
    host TEXT,
    label TEXT,
    version_raw TEXT,
    availability_status TEXT NOT NULL DEFAULT 'unknown',
    first_seen_at TEXT NOT NULL,
    last_verified_at TEXT NOT NULL,
    UNIQUE (game_id, url)
);

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

CREATE TABLE acquisitions (
    id INTEGER PRIMARY KEY,
    game_id INTEGER NOT NULL REFERENCES games(id),
    acquired_at TEXT NOT NULL,
    selection_reason TEXT NOT NULL,
    game_status_at_acquisition TEXT NOT NULL,
    source_snapshot TEXT,
    notes TEXT
);

CREATE TABLE acquired_files (
    id INTEGER PRIMARY KEY,
    acquisition_id INTEGER NOT NULL REFERENCES acquisitions(id),
    remote_resource_id INTEGER REFERENCES remote_resources(id),
    relative_path TEXT NOT NULL,
    original_filename TEXT NOT NULL,
    media_type TEXT,
    byte_size INTEGER NOT NULL,
    sha256 TEXT NOT NULL,
    version_raw TEXT,
    UNIQUE (acquisition_id, relative_path)
);

CREATE TABLE observations (
    id INTEGER PRIMARY KEY,
    entity_type TEXT NOT NULL,
    entity_id INTEGER NOT NULL,
    field_name TEXT NOT NULL,
    raw_value TEXT,
    normalized_value TEXT,
    source_url TEXT NOT NULL,
    observed_at TEXT NOT NULL,
    confidence TEXT
);

CREATE INDEX idx_contests_priority ON contests(year DESC, status_normalized);
CREATE INDEX idx_contests_series ON contests(series_id, year DESC);
CREATE INDEX idx_contest_sources_contest ON contest_sources(contest_id, kind);
CREATE INDEX idx_contest_phases_schedule ON contest_phases(contest_id, starts_at, ends_at);
CREATE INDEX idx_contest_checks_recent ON contest_checks(contest_id, checked_at DESC);
CREATE INDEX idx_contest_phase_history_recent ON contest_phase_history(phase_id, observed_at DESC);
CREATE INDEX idx_contest_status_history_recent ON contest_status_history(contest_id, observed_at DESC);
CREATE INDEX idx_contest_metrics_recent ON contest_metric_observations(contest_id, metric_key, observed_at DESC);
CREATE INDEX idx_games_status ON games(status_normalized);
CREATE INDEX idx_entries_contest ON entries(contest_id, position);
CREATE INDEX idx_entries_status ON entries(contest_id, status_normalized);
CREATE INDEX idx_contests_scope ON contests(scope_type, treatment_profile, year DESC);
CREATE INDEX idx_entries_kind ON entries(contest_id, entry_kind, base_game_dependency);
CREATE INDEX idx_entry_status_history_recent ON entry_status_history(entry_id, observed_at DESC);
CREATE INDEX idx_rankings_priority ON rankings(contest_id, category, rank);
CREATE INDEX idx_resources_availability ON remote_resources(game_id, availability_status);
CREATE INDEX idx_entry_resource_scans ON entry_resource_scans(entry_id, checked_at DESC);
CREATE INDEX idx_entry_resource_mentions ON entry_resource_mentions(entry_id, content_role);
CREATE INDEX idx_resource_observations ON remote_resource_observations(remote_resource_id, observed_at DESC);
CREATE INDEX idx_entry_material_scans ON entry_material_scans(entry_id, checked_at DESC);
CREATE INDEX idx_entry_material_requirements ON entry_material_requirements(entry_id, material_kind, name_normalized);

CREATE VIEW v_contests_monitoring_all AS
SELECT
    c.id AS contest_id, c.name AS contest_name, c.year, c.starts_at,
    c.status_raw, c.status_normalized, c.scope_type, c.treatment_profile,
    c.organizer, c.source_url, c.last_verified_at,
    COUNT(e.id) AS entry_count,
    COALESCE(SUM(CASE WHEN e.status_normalized = 'withdrawn' THEN 1 ELSE 0 END), 0) AS withdrawn_entry_count,
    COALESCE(SUM(CASE WHEN e.entry_kind = 'dependent_variant' THEN 1 ELSE 0 END), 0) AS dependent_variant_count,
    (SELECT p.phase_type FROM contest_phases p WHERE p.contest_id=c.id AND julianday(COALESCE(p.ends_at,p.starts_at))>=julianday('now') ORDER BY julianday(COALESCE(p.ends_at,p.starts_at)),p.sequence_number LIMIT 1) AS next_phase_type,
    (SELECT p.label_raw FROM contest_phases p WHERE p.contest_id=c.id AND julianday(COALESCE(p.ends_at,p.starts_at))>=julianday('now') ORDER BY julianday(COALESCE(p.ends_at,p.starts_at)),p.sequence_number LIMIT 1) AS next_phase_label,
    (SELECT COALESCE(p.ends_at,p.starts_at) FROM contest_phases p WHERE p.contest_id=c.id AND julianday(COALESCE(p.ends_at,p.starts_at))>=julianday('now') ORDER BY julianday(COALESCE(p.ends_at,p.starts_at)),p.sequence_number LIMIT 1) AS next_deadline
FROM contests c LEFT JOIN entries e ON e.contest_id=c.id
GROUP BY c.id;

CREATE VIEW v_contests_pnp_core AS
SELECT * FROM v_contests_monitoring_all WHERE scope_type='pnp_core';

CREATE VIEW v_contests_adjacent AS
SELECT * FROM v_contests_monitoring_all WHERE scope_type='adjacent';

CREATE VIEW v_entries_standalone AS
SELECT e.id AS entry_id,e.contest_id,c.name AS contest_name,c.scope_type,c.treatment_profile,
       e.position,e.game_id,g.canonical_title,e.status_raw,e.status_normalized,
       e.materials_status_raw,e.materials_status_normalized,e.entry_kind,e.base_game_dependency,
       e.entry_url,e.last_verified_at
FROM entries e JOIN games g ON g.id=e.game_id JOIN contests c ON c.id=e.contest_id
WHERE e.entry_kind='standalone_game';

CREATE VIEW v_entries_dependent_variants AS
SELECT e.id AS entry_id,e.contest_id,c.name AS contest_name,c.scope_type,c.treatment_profile,
       e.position,e.game_id,g.canonical_title,e.status_raw,e.status_normalized,
       e.materials_status_raw,e.materials_status_normalized,e.entry_kind,e.base_game_dependency,
       e.entry_url,e.last_verified_at
FROM entries e JOIN games g ON g.id=e.game_id JOIN contests c ON c.id=e.contest_id
WHERE e.entry_kind='dependent_variant';
