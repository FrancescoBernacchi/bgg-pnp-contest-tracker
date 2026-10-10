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

CREATE TABLE catalog_sources (
    id INTEGER PRIMARY KEY,
    source_key TEXT NOT NULL UNIQUE,
    display_name TEXT NOT NULL,
    source_kind TEXT NOT NULL,
    base_url TEXT,
    first_seen_at TEXT NOT NULL,
    last_verified_at TEXT,
    notes TEXT
);

CREATE TABLE source_records (
    id INTEGER PRIMARY KEY,
    source_id INTEGER NOT NULL REFERENCES catalog_sources(id),
    record_type TEXT NOT NULL,
    native_id TEXT,
    canonical_url TEXT NOT NULL,
    title_raw TEXT,
    status_raw TEXT,
    status_normalized TEXT NOT NULL DEFAULT 'unknown',
    observed_at TEXT NOT NULL,
    verification_status TEXT NOT NULL DEFAULT 'verified'
        CHECK (verification_status IN ('not_checked', 'declared', 'verified', 'rejected', 'uncertain')),
    last_verified_at TEXT,
    raw_metadata TEXT,
    notes TEXT,
    UNIQUE (source_id, canonical_url),
    UNIQUE (source_id, record_type, native_id)
);

CREATE TABLE game_source_records (
    game_id INTEGER NOT NULL REFERENCES games(id),
    source_record_id INTEGER NOT NULL REFERENCES source_records(id),
    match_status TEXT NOT NULL DEFAULT 'candidate'
        CHECK (match_status IN ('candidate', 'confirmed', 'rejected')),
    match_method TEXT NOT NULL DEFAULT 'manual',
    evidence TEXT,
    decided_at TEXT,
    PRIMARY KEY (game_id, source_record_id)
);

CREATE TABLE game_names (
    id INTEGER PRIMARY KEY,
    game_id INTEGER NOT NULL REFERENCES games(id),
    name TEXT NOT NULL,
    observed_from TEXT,
    observed_at TEXT NOT NULL,
    is_current INTEGER NOT NULL DEFAULT 0 CHECK (is_current IN (0, 1)),
    name_type TEXT NOT NULL DEFAULT 'alias',
    language_code TEXT,
    script_code TEXT,
    is_official INTEGER NOT NULL DEFAULT 0 CHECK (is_official IN (0, 1)),
    source_record_id INTEGER REFERENCES source_records(id),
    verification_status TEXT NOT NULL DEFAULT 'not_checked'
        CHECK (verification_status IN ('not_checked', 'declared', 'verified', 'rejected', 'uncertain')),
    evidence_url TEXT,
    last_verified_at TEXT
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
    catalog_resource_id INTEGER REFERENCES catalog_resources(id),
    final_url TEXT,
    language_code TEXT,
    acquisition_status TEXT NOT NULL DEFAULT 'acquired'
        CHECK (acquisition_status IN ('acquired', 'failed')),
    usage_conditions TEXT,
    notes TEXT,
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

CREATE TABLE products (
    id INTEGER PRIMARY KEY,
    canonical_name TEXT NOT NULL,
    product_kind TEXT NOT NULL DEFAULT 'physical_product',
    status_raw TEXT,
    status_normalized TEXT NOT NULL DEFAULT 'unknown',
    first_seen_at TEXT NOT NULL,
    last_verified_at TEXT,
    notes TEXT
);

CREATE TABLE product_source_records (
    product_id INTEGER NOT NULL REFERENCES products(id),
    source_record_id INTEGER NOT NULL REFERENCES source_records(id),
    match_status TEXT NOT NULL DEFAULT 'confirmed'
        CHECK (match_status IN ('candidate', 'confirmed', 'rejected')),
    evidence TEXT,
    decided_at TEXT,
    PRIMARY KEY (product_id, source_record_id)
);

CREATE TABLE product_games (
    product_id INTEGER NOT NULL REFERENCES products(id),
    game_id INTEGER NOT NULL REFERENCES games(id),
    relationship_type TEXT NOT NULL DEFAULT 'included_game',
    sequence_number INTEGER,
    is_primary INTEGER NOT NULL DEFAULT 0 CHECK (is_primary IN (0, 1)),
    evidence_record_id INTEGER REFERENCES source_records(id),
    verification_status TEXT NOT NULL DEFAULT 'not_checked'
        CHECK (verification_status IN ('not_checked', 'declared', 'verified', 'rejected', 'uncertain')),
    notes TEXT,
    PRIMARY KEY (product_id, game_id, relationship_type)
);

CREATE TABLE game_relationships (
    from_game_id INTEGER NOT NULL REFERENCES games(id),
    to_game_id INTEGER NOT NULL REFERENCES games(id),
    relationship_type TEXT NOT NULL,
    dependency_requirement TEXT NOT NULL DEFAULT 'unknown'
        CHECK (dependency_requirement IN ('none', 'optional', 'required', 'unknown')),
    evidence_record_id INTEGER REFERENCES source_records(id),
    verification_status TEXT NOT NULL DEFAULT 'not_checked'
        CHECK (verification_status IN ('not_checked', 'declared', 'verified', 'rejected', 'uncertain')),
    notes TEXT,
    PRIMARY KEY (from_game_id, to_game_id, relationship_type),
    CHECK (from_game_id <> to_game_id)
);

CREATE TABLE catalog_resources (
    id INTEGER PRIMARY KEY,
    source_record_id INTEGER REFERENCES source_records(id),
    resource_kind TEXT NOT NULL,
    url TEXT NOT NULL,
    label_raw TEXT,
    language_code TEXT,
    media_type TEXT,
    version_raw TEXT,
    access_type TEXT NOT NULL DEFAULT 'unknown',
    availability_status TEXT NOT NULL DEFAULT 'unknown',
    verification_status TEXT NOT NULL DEFAULT 'not_checked'
        CHECK (verification_status IN ('not_checked', 'declared', 'verified', 'rejected', 'uncertain')),
    first_seen_at TEXT NOT NULL,
    last_verified_at TEXT,
    notes TEXT,
    UNIQUE (url)
);

CREATE TABLE resource_links (
    id INTEGER PRIMARY KEY,
    resource_id INTEGER NOT NULL REFERENCES catalog_resources(id),
    game_id INTEGER REFERENCES games(id),
    product_id INTEGER REFERENCES products(id),
    source_record_id INTEGER REFERENCES source_records(id),
    link_role TEXT NOT NULL,
    is_primary INTEGER NOT NULL DEFAULT 0 CHECK (is_primary IN (0, 1)),
    evidence_record_id INTEGER REFERENCES source_records(id),
    notes TEXT,
    CHECK ((game_id IS NOT NULL) + (product_id IS NOT NULL) + (source_record_id IS NOT NULL) = 1),
    UNIQUE (resource_id, game_id, product_id, source_record_id, link_role)
);

CREATE TABLE online_platforms (
    id INTEGER PRIMARY KEY,
    canonical_name TEXT NOT NULL UNIQUE,
    base_url TEXT,
    notes TEXT
);

CREATE TABLE game_implementations (
    id INTEGER PRIMARY KEY,
    game_id INTEGER NOT NULL REFERENCES games(id),
    platform_id INTEGER NOT NULL REFERENCES online_platforms(id),
    implementation_url TEXT,
    title_raw TEXT,
    version_raw TEXT,
    availability_status TEXT NOT NULL DEFAULT 'unknown',
    declared_by_record_id INTEGER REFERENCES source_records(id),
    verification_status TEXT NOT NULL DEFAULT 'not_checked'
        CHECK (verification_status IN ('not_checked', 'declared', 'verified', 'rejected', 'uncertain')),
    first_seen_at TEXT NOT NULL,
    last_verified_at TEXT,
    notes TEXT,
    UNIQUE (game_id, platform_id, implementation_url)
);

CREATE TABLE person_names (
    id INTEGER PRIMARY KEY,
    person_id INTEGER NOT NULL REFERENCES people(id),
    name TEXT NOT NULL,
    name_type TEXT NOT NULL DEFAULT 'alias',
    language_code TEXT,
    script_code TEXT,
    source_record_id INTEGER REFERENCES source_records(id),
    verification_status TEXT NOT NULL DEFAULT 'not_checked'
        CHECK (verification_status IN ('not_checked', 'declared', 'verified', 'rejected', 'uncertain')),
    first_seen_at TEXT NOT NULL,
    last_verified_at TEXT,
    UNIQUE (person_id, name, name_type, source_record_id)
);

CREATE TABLE credit_assertions (
    id INTEGER PRIMARY KEY,
    person_id INTEGER NOT NULL REFERENCES people(id),
    game_id INTEGER REFERENCES games(id),
    product_id INTEGER REFERENCES products(id),
    source_record_id INTEGER REFERENCES source_records(id),
    role TEXT NOT NULL,
    credit_raw TEXT,
    evidence_record_id INTEGER REFERENCES source_records(id),
    verification_status TEXT NOT NULL DEFAULT 'not_checked'
        CHECK (verification_status IN ('not_checked', 'declared', 'verified', 'rejected', 'uncertain')),
    observed_at TEXT NOT NULL,
    notes TEXT,
    CHECK ((game_id IS NOT NULL) + (product_id IS NOT NULL) + (source_record_id IS NOT NULL) = 1)
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
CREATE INDEX idx_acquired_files_catalog_resource ON acquired_files(catalog_resource_id, acquisition_status);
CREATE INDEX idx_source_records_source ON source_records(source_id, record_type, observed_at DESC);
CREATE INDEX idx_game_source_records_record ON game_source_records(source_record_id, match_status);
CREATE INDEX idx_product_source_records_record ON product_source_records(source_record_id, match_status);
CREATE INDEX idx_product_games_game ON product_games(game_id, relationship_type);
CREATE INDEX idx_game_relationships_target ON game_relationships(to_game_id, relationship_type);
CREATE INDEX idx_game_names_search ON game_names(name, language_code, name_type);
CREATE INDEX idx_catalog_resources_source ON catalog_resources(source_record_id, resource_kind);
CREATE INDEX idx_resource_links_game ON resource_links(game_id, link_role);
CREATE INDEX idx_resource_links_product ON resource_links(product_id, link_role);
CREATE INDEX idx_game_implementations_game ON game_implementations(game_id, platform_id);
CREATE INDEX idx_person_names_search ON person_names(name, language_code);
CREATE INDEX idx_credit_assertions_person ON credit_assertions(person_id, role);
CREATE INDEX idx_credit_assertions_game ON credit_assertions(game_id, role);

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
CREATE TABLE archive_contents (
    file_id INTEGER PRIMARY KEY REFERENCES acquired_files(id),
    archive_file_id INTEGER NOT NULL REFERENCES acquired_files(id),
    archive_sha256 TEXT NOT NULL,
    member_path TEXT NOT NULL,
    extracted_at TEXT NOT NULL,
    UNIQUE(archive_file_id, archive_sha256, member_path)
);
CREATE TABLE archive_extractions (
    archive_file_id INTEGER NOT NULL REFERENCES acquired_files(id),
    archive_sha256 TEXT NOT NULL,
    checked_at TEXT NOT NULL,
    status TEXT NOT NULL,
    message TEXT NOT NULL,
    PRIMARY KEY(archive_file_id, archive_sha256)
);

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

-- BEGIN MIGRATION 013_SOURCE_EVIDENCE
-- B-v1 adopted in TSK-0076; additive schema only, no catalog backfill.

-- Generated by database/build_source_evidence_migration.py (TSK-0077).

PRAGMA foreign_keys = ON;

BEGIN IMMEDIATE;

CREATE TABLE source_record_keys (
    id INTEGER PRIMARY KEY,
    stable_key TEXT NOT NULL CHECK (stable_key IS NULL OR length(trim(stable_key)) > 0) UNIQUE,
    source_id INTEGER NOT NULL REFERENCES catalog_sources(id) ON DELETE RESTRICT,
    record_id INTEGER NOT NULL REFERENCES source_records(id) ON DELETE RESTRICT,
    local_key TEXT NOT NULL CHECK (local_key IS NULL OR length(trim(local_key)) > 0),
    key_kind TEXT NOT NULL CHECK (key_kind IS NULL OR length(trim(key_kind)) > 0),
    assigned_at TEXT NOT NULL CHECK (assigned_at IS NULL OR length(trim(assigned_at)) > 0),
    task_id TEXT NOT NULL CHECK (task_id IS NULL OR length(trim(task_id)) > 0),
    UNIQUE (source_id, local_key)
);

CREATE TABLE source_record_observations (
    id INTEGER PRIMARY KEY,
    stable_key TEXT NOT NULL CHECK (stable_key IS NULL OR length(trim(stable_key)) > 0) UNIQUE,
    record_id INTEGER NOT NULL REFERENCES source_records(id) ON DELETE RESTRICT,
    event_key TEXT NOT NULL CHECK (event_key IS NULL OR length(trim(event_key)) > 0),
    payload_json TEXT NOT NULL CHECK(json_valid(payload_json) AND json_type(payload_json)='object'),
    payload_sha256 TEXT NOT NULL CHECK(length(payload_sha256)=64 AND payload_sha256 NOT GLOB '*[^0-9a-f]*'),
    schema_version TEXT NOT NULL CHECK (schema_version IS NULL OR length(trim(schema_version)) > 0),
    title_raw TEXT,
    display_title_qualified TEXT,
    year_raw TEXT,
    year_value INTEGER,
    year_precision TEXT NOT NULL DEFAULT 'unknown' CHECK (year_precision IN ('year','unknown')),
    page_updated_raw TEXT,
    development_status_raw TEXT,
    development_status_normalized TEXT NOT NULL DEFAULT 'unknown' CHECK(development_status_normalized NOT IN ('admitted','requirement_not_demonstrated')),
    coverage_kind TEXT NOT NULL CHECK (coverage_kind IS NULL OR length(trim(coverage_kind)) > 0),
    coverage_state TEXT NOT NULL DEFAULT 'unknown' CHECK (coverage_state IN ('complete','partial','blocked','unknown')),
    parent_observation_id INTEGER NULL REFERENCES source_record_observations(id) ON DELETE RESTRICT,
    source_url TEXT NOT NULL CHECK (source_url IS NULL OR length(trim(source_url)) > 0),
    observed_at TEXT,
    observed_precision TEXT NOT NULL DEFAULT 'unknown' CHECK (observed_precision IN ('day','timestamp','unknown')),
    unknown_reason TEXT,
    formalized_at TEXT NOT NULL CHECK (formalized_at IS NULL OR length(trim(formalized_at)) > 0),
    evidence_path TEXT NOT NULL CHECK (evidence_path IS NULL OR length(trim(evidence_path)) > 0),
    evidence_pointer TEXT NOT NULL CHECK (evidence_pointer IS NULL OR length(trim(evidence_pointer)) > 0),
    provenance_kind TEXT NOT NULL CHECK (provenance_kind IN ('observed','reused','later_formalization')),
    raw_value TEXT,
    assessment_note TEXT,
    mapping_version TEXT NOT NULL CHECK (mapping_version IS NULL OR length(trim(mapping_version)) > 0),
    supersedes_id INTEGER NULL REFERENCES source_record_observations(id) ON DELETE RESTRICT,
    CHECK ((observed_at IS NULL AND observed_precision='unknown' AND length(trim(coalesce(unknown_reason,'')))>0) OR (observed_at IS NOT NULL AND observed_precision<>'unknown' AND julianday(observed_at) IS NOT NULL)),
    CHECK (observed_precision<>'day' OR (length(observed_at)=10 AND date(observed_at,'+0 days')=observed_at)),
    CHECK (observed_precision<>'timestamp' OR (instr(observed_at,'T')>0 AND (substr(observed_at,-1)='Z' OR substr(observed_at,-6,1) IN ('+','-')))),
    CHECK (julianday(formalized_at) IS NOT NULL AND instr(formalized_at,'T')>0 AND (substr(formalized_at,-1)='Z' OR substr(formalized_at,-6,1) IN ('+','-'))),
    CHECK (supersedes_id IS NULL OR supersedes_id<>id),
    UNIQUE (record_id, event_key, payload_sha256, mapping_version)
);

CREATE TABLE source_admission_observations (
    id INTEGER PRIMARY KEY,
    stable_key TEXT NOT NULL CHECK (stable_key IS NULL OR length(trim(stable_key)) > 0) UNIQUE,
    record_observation_id INTEGER NOT NULL REFERENCES source_record_observations(id) ON DELETE RESTRICT,
    policy_ref TEXT NOT NULL CHECK (policy_ref IS NULL OR length(trim(policy_ref)) > 0),
    policy_version TEXT NOT NULL CHECK (policy_version IS NULL OR length(trim(policy_version)) > 0),
    requirement_key TEXT NOT NULL CHECK (requirement_key IS NULL OR length(trim(requirement_key)) > 0),
    outcome_raw TEXT NOT NULL CHECK (outcome_raw IS NULL OR length(trim(outcome_raw)) > 0),
    outcome_normalized TEXT NOT NULL DEFAULT 'unknown' CHECK (outcome_normalized IN ('admitted','requirement_not_demonstrated','not_observable','unknown')),
    completeness_raw TEXT,
    assessment_kind TEXT NOT NULL CHECK (assessment_kind IS NULL OR length(trim(assessment_kind)) > 0),
    source_url TEXT NOT NULL CHECK (source_url IS NULL OR length(trim(source_url)) > 0),
    observed_at TEXT,
    observed_precision TEXT NOT NULL DEFAULT 'unknown' CHECK (observed_precision IN ('day','timestamp','unknown')),
    unknown_reason TEXT,
    formalized_at TEXT NOT NULL CHECK (formalized_at IS NULL OR length(trim(formalized_at)) > 0),
    evidence_path TEXT NOT NULL CHECK (evidence_path IS NULL OR length(trim(evidence_path)) > 0),
    evidence_pointer TEXT NOT NULL CHECK (evidence_pointer IS NULL OR length(trim(evidence_pointer)) > 0),
    provenance_kind TEXT NOT NULL CHECK (provenance_kind IN ('observed','reused','later_formalization')),
    raw_value TEXT,
    assessment_note TEXT,
    mapping_version TEXT NOT NULL CHECK (mapping_version IS NULL OR length(trim(mapping_version)) > 0),
    supersedes_id INTEGER NULL REFERENCES source_admission_observations(id) ON DELETE RESTRICT,
    CHECK ((observed_at IS NULL AND observed_precision='unknown' AND length(trim(coalesce(unknown_reason,'')))>0) OR (observed_at IS NOT NULL AND observed_precision<>'unknown' AND julianday(observed_at) IS NOT NULL)),
    CHECK (observed_precision<>'day' OR (length(observed_at)=10 AND date(observed_at,'+0 days')=observed_at)),
    CHECK (observed_precision<>'timestamp' OR (instr(observed_at,'T')>0 AND (substr(observed_at,-1)='Z' OR substr(observed_at,-6,1) IN ('+','-')))),
    CHECK (julianday(formalized_at) IS NOT NULL AND instr(formalized_at,'T')>0 AND (substr(formalized_at,-1)='Z' OR substr(formalized_at,-6,1) IN ('+','-'))),
    CHECK (supersedes_id IS NULL OR supersedes_id<>id)
);

CREATE TABLE source_classification_observations (
    id INTEGER PRIMARY KEY,
    stable_key TEXT NOT NULL CHECK (stable_key IS NULL OR length(trim(stable_key)) > 0) UNIQUE,
    record_observation_id INTEGER NOT NULL REFERENCES source_record_observations(id) ON DELETE RESTRICT,
    label_raw TEXT NOT NULL CHECK (label_raw IS NULL OR length(trim(label_raw)) > 0),
    kind_raw TEXT NOT NULL CHECK (kind_raw IS NULL OR length(trim(kind_raw)) > 0),
    path_state TEXT NOT NULL CHECK (path_state IN ('observed','not_declared','not_observable')),
    segment_count INTEGER NOT NULL CHECK(segment_count>=0),
    segment_raw TEXT,
    index_title_raw TEXT,
    exhaustiveness_raw TEXT,
    source_url TEXT NOT NULL CHECK (source_url IS NULL OR length(trim(source_url)) > 0),
    observed_at TEXT,
    observed_precision TEXT NOT NULL DEFAULT 'unknown' CHECK (observed_precision IN ('day','timestamp','unknown')),
    unknown_reason TEXT,
    formalized_at TEXT NOT NULL CHECK (formalized_at IS NULL OR length(trim(formalized_at)) > 0),
    evidence_path TEXT NOT NULL CHECK (evidence_path IS NULL OR length(trim(evidence_path)) > 0),
    evidence_pointer TEXT NOT NULL CHECK (evidence_pointer IS NULL OR length(trim(evidence_pointer)) > 0),
    provenance_kind TEXT NOT NULL CHECK (provenance_kind IN ('observed','reused','later_formalization')),
    raw_value TEXT,
    assessment_note TEXT,
    mapping_version TEXT NOT NULL CHECK (mapping_version IS NULL OR length(trim(mapping_version)) > 0),
    supersedes_id INTEGER NULL REFERENCES source_classification_observations(id) ON DELETE RESTRICT,
    CHECK(path_state='observed' OR segment_count=0),
    CHECK ((observed_at IS NULL AND observed_precision='unknown' AND length(trim(coalesce(unknown_reason,'')))>0) OR (observed_at IS NOT NULL AND observed_precision<>'unknown' AND julianday(observed_at) IS NOT NULL)),
    CHECK (observed_precision<>'day' OR (length(observed_at)=10 AND date(observed_at,'+0 days')=observed_at)),
    CHECK (observed_precision<>'timestamp' OR (instr(observed_at,'T')>0 AND (substr(observed_at,-1)='Z' OR substr(observed_at,-6,1) IN ('+','-')))),
    CHECK (julianday(formalized_at) IS NOT NULL AND instr(formalized_at,'T')>0 AND (substr(formalized_at,-1)='Z' OR substr(formalized_at,-6,1) IN ('+','-'))),
    CHECK (supersedes_id IS NULL OR supersedes_id<>id)
);

CREATE TABLE source_classification_segments (
    id INTEGER PRIMARY KEY,
    stable_key TEXT NOT NULL CHECK (stable_key IS NULL OR length(trim(stable_key)) > 0) UNIQUE,
    classification_id INTEGER NOT NULL REFERENCES source_classification_observations(id) ON DELETE RESTRICT,
    position INTEGER NOT NULL CHECK(position>=0),
    label_raw TEXT NOT NULL CHECK (label_raw IS NULL OR length(trim(label_raw)) > 0),
    UNIQUE (classification_id, position)
);

CREATE TABLE common_classification_mappings (
    id INTEGER PRIMARY KEY,
    stable_key TEXT NOT NULL CHECK (stable_key IS NULL OR length(trim(stable_key)) > 0) UNIQUE,
    classification_id INTEGER NOT NULL REFERENCES source_classification_observations(id) ON DELETE RESTRICT,
    common_concept_key TEXT NOT NULL CHECK (common_concept_key IS NULL OR length(trim(common_concept_key)) > 0),
    decision_ref TEXT NOT NULL CHECK (decision_ref IS NULL OR length(trim(decision_ref)) > 0),
    decision_status TEXT NOT NULL CHECK (decision_status IN ('proposed','confirmed','rejected')),
    decided_at TEXT NOT NULL CHECK (decided_at IS NULL OR length(trim(decided_at)) > 0),
    rationale TEXT NOT NULL CHECK (rationale IS NULL OR length(trim(rationale)) > 0),
    source_url TEXT NOT NULL CHECK (source_url IS NULL OR length(trim(source_url)) > 0),
    observed_at TEXT,
    observed_precision TEXT NOT NULL DEFAULT 'unknown' CHECK (observed_precision IN ('day','timestamp','unknown')),
    unknown_reason TEXT,
    formalized_at TEXT NOT NULL CHECK (formalized_at IS NULL OR length(trim(formalized_at)) > 0),
    evidence_path TEXT NOT NULL CHECK (evidence_path IS NULL OR length(trim(evidence_path)) > 0),
    evidence_pointer TEXT NOT NULL CHECK (evidence_pointer IS NULL OR length(trim(evidence_pointer)) > 0),
    provenance_kind TEXT NOT NULL CHECK (provenance_kind IN ('observed','reused','later_formalization')),
    raw_value TEXT,
    assessment_note TEXT,
    mapping_version TEXT NOT NULL CHECK (mapping_version IS NULL OR length(trim(mapping_version)) > 0),
    supersedes_id INTEGER NULL REFERENCES common_classification_mappings(id) ON DELETE RESTRICT,
    CHECK ((observed_at IS NULL AND observed_precision='unknown' AND length(trim(coalesce(unknown_reason,'')))>0) OR (observed_at IS NOT NULL AND observed_precision<>'unknown' AND julianday(observed_at) IS NOT NULL)),
    CHECK (observed_precision<>'day' OR (length(observed_at)=10 AND date(observed_at,'+0 days')=observed_at)),
    CHECK (observed_precision<>'timestamp' OR (instr(observed_at,'T')>0 AND (substr(observed_at,-1)='Z' OR substr(observed_at,-6,1) IN ('+','-')))),
    CHECK (julianday(formalized_at) IS NOT NULL AND instr(formalized_at,'T')>0 AND (substr(formalized_at,-1)='Z' OR substr(formalized_at,-6,1) IN ('+','-'))),
    CHECK (supersedes_id IS NULL OR supersedes_id<>id)
);

CREATE TABLE source_record_url_observations (
    id INTEGER PRIMARY KEY,
    stable_key TEXT NOT NULL CHECK (stable_key IS NULL OR length(trim(stable_key)) > 0) UNIQUE,
    record_observation_id INTEGER NOT NULL REFERENCES source_record_observations(id) ON DELETE RESTRICT,
    record_id INTEGER NOT NULL REFERENCES source_records(id) ON DELETE RESTRICT,
    url_raw TEXT NOT NULL CHECK (url_raw IS NULL OR length(trim(url_raw)) > 0),
    url_role TEXT NOT NULL CHECK (url_role IN ('historical','requested','final','declared')),
    request_event_key TEXT,
    predecessor_url_observation_id INTEGER NULL REFERENCES source_record_url_observations(id) ON DELETE RESTRICT,
    redirect_position INTEGER CHECK(redirect_position>=0),
    destination_kind TEXT NOT NULL DEFAULT 'unknown' CHECK (destination_kind IN ('content','login','unknown')),
    technical_status_raw TEXT,
    source_url TEXT NOT NULL CHECK (source_url IS NULL OR length(trim(source_url)) > 0),
    observed_at TEXT,
    observed_precision TEXT NOT NULL DEFAULT 'unknown' CHECK (observed_precision IN ('day','timestamp','unknown')),
    unknown_reason TEXT,
    formalized_at TEXT NOT NULL CHECK (formalized_at IS NULL OR length(trim(formalized_at)) > 0),
    evidence_path TEXT NOT NULL CHECK (evidence_path IS NULL OR length(trim(evidence_path)) > 0),
    evidence_pointer TEXT NOT NULL CHECK (evidence_pointer IS NULL OR length(trim(evidence_pointer)) > 0),
    provenance_kind TEXT NOT NULL CHECK (provenance_kind IN ('observed','reused','later_formalization')),
    raw_value TEXT,
    assessment_note TEXT,
    mapping_version TEXT NOT NULL CHECK (mapping_version IS NULL OR length(trim(mapping_version)) > 0),
    supersedes_id INTEGER NULL REFERENCES source_record_url_observations(id) ON DELETE RESTRICT,
    CHECK ((observed_at IS NULL AND observed_precision='unknown' AND length(trim(coalesce(unknown_reason,'')))>0) OR (observed_at IS NOT NULL AND observed_precision<>'unknown' AND julianday(observed_at) IS NOT NULL)),
    CHECK (observed_precision<>'day' OR (length(observed_at)=10 AND date(observed_at,'+0 days')=observed_at)),
    CHECK (observed_precision<>'timestamp' OR (instr(observed_at,'T')>0 AND (substr(observed_at,-1)='Z' OR substr(observed_at,-6,1) IN ('+','-')))),
    CHECK (julianday(formalized_at) IS NOT NULL AND instr(formalized_at,'T')>0 AND (substr(formalized_at,-1)='Z' OR substr(formalized_at,-6,1) IN ('+','-'))),
    CHECK (supersedes_id IS NULL OR supersedes_id<>id)
);

CREATE TABLE source_resource_mentions (
    id INTEGER PRIMARY KEY,
    stable_key TEXT NOT NULL CHECK (stable_key IS NULL OR length(trim(stable_key)) > 0) UNIQUE,
    record_id INTEGER NOT NULL REFERENCES source_records(id) ON DELETE RESTRICT,
    mention_key TEXT NOT NULL CHECK (mention_key IS NULL OR length(trim(mention_key)) > 0),
    first_observation_id INTEGER NOT NULL REFERENCES source_record_observations(id) ON DELETE RESTRICT,
    function_raw TEXT NOT NULL CHECK (function_raw IS NULL OR length(trim(function_raw)) > 0),
    label_raw TEXT,
    UNIQUE (record_id, mention_key)
);

CREATE TABLE source_resource_mention_observations (
    id INTEGER PRIMARY KEY,
    stable_key TEXT NOT NULL CHECK (stable_key IS NULL OR length(trim(stable_key)) > 0) UNIQUE,
    mention_id INTEGER NOT NULL REFERENCES source_resource_mentions(id) ON DELETE RESTRICT,
    record_observation_id INTEGER NOT NULL REFERENCES source_record_observations(id) ON DELETE RESTRICT,
    declared_url TEXT NULL CHECK (declared_url IS NULL OR length(trim(declared_url)) > 0),
    resource_id INTEGER NULL REFERENCES catalog_resources(id) ON DELETE RESTRICT,
    function_raw TEXT NOT NULL CHECK (function_raw IS NULL OR length(trim(function_raw)) > 0),
    technical_form_raw TEXT,
    language_raw TEXT,
    declaration_state TEXT NOT NULL CHECK (declaration_state IS NULL OR length(trim(declaration_state)) > 0),
    context_summary TEXT,
    destination_status_raw TEXT,
    source_url TEXT NOT NULL CHECK (source_url IS NULL OR length(trim(source_url)) > 0),
    observed_at TEXT,
    observed_precision TEXT NOT NULL DEFAULT 'unknown' CHECK (observed_precision IN ('day','timestamp','unknown')),
    unknown_reason TEXT,
    formalized_at TEXT NOT NULL CHECK (formalized_at IS NULL OR length(trim(formalized_at)) > 0),
    evidence_path TEXT NOT NULL CHECK (evidence_path IS NULL OR length(trim(evidence_path)) > 0),
    evidence_pointer TEXT NOT NULL CHECK (evidence_pointer IS NULL OR length(trim(evidence_pointer)) > 0),
    provenance_kind TEXT NOT NULL CHECK (provenance_kind IN ('observed','reused','later_formalization')),
    raw_value TEXT,
    assessment_note TEXT,
    mapping_version TEXT NOT NULL CHECK (mapping_version IS NULL OR length(trim(mapping_version)) > 0),
    supersedes_id INTEGER NULL REFERENCES source_resource_mention_observations(id) ON DELETE RESTRICT,
    CHECK ((declared_url IS NULL AND resource_id IS NULL) OR declared_url IS NOT NULL),
    CHECK ((observed_at IS NULL AND observed_precision='unknown' AND length(trim(coalesce(unknown_reason,'')))>0) OR (observed_at IS NOT NULL AND observed_precision<>'unknown' AND julianday(observed_at) IS NOT NULL)),
    CHECK (observed_precision<>'day' OR (length(observed_at)=10 AND date(observed_at,'+0 days')=observed_at)),
    CHECK (observed_precision<>'timestamp' OR (instr(observed_at,'T')>0 AND (substr(observed_at,-1)='Z' OR substr(observed_at,-6,1) IN ('+','-')))),
    CHECK (julianday(formalized_at) IS NOT NULL AND instr(formalized_at,'T')>0 AND (substr(formalized_at,-1)='Z' OR substr(formalized_at,-6,1) IN ('+','-'))),
    CHECK (supersedes_id IS NULL OR supersedes_id<>id)
);

CREATE TABLE admission_evidence_mentions (
    id INTEGER PRIMARY KEY,
    stable_key TEXT NOT NULL CHECK (stable_key IS NULL OR length(trim(stable_key)) > 0) UNIQUE,
    admission_id INTEGER NOT NULL REFERENCES source_admission_observations(id) ON DELETE RESTRICT,
    mention_id INTEGER NOT NULL REFERENCES source_resource_mentions(id) ON DELETE RESTRICT,
    mention_observation_id INTEGER NOT NULL REFERENCES source_resource_mention_observations(id) ON DELETE RESTRICT,
    evidence_role TEXT NOT NULL CHECK (evidence_role IS NULL OR length(trim(evidence_role)) > 0),
    evidence_pointer TEXT NOT NULL CHECK (evidence_pointer IS NULL OR length(trim(evidence_pointer)) > 0),
    UNIQUE (admission_id, mention_observation_id, evidence_role)
);

CREATE TABLE resource_url_observations (
    id INTEGER PRIMARY KEY,
    stable_key TEXT NOT NULL CHECK (stable_key IS NULL OR length(trim(stable_key)) > 0) UNIQUE,
    mention_observation_id INTEGER NOT NULL REFERENCES source_resource_mention_observations(id) ON DELETE RESTRICT,
    requested_url TEXT NOT NULL CHECK (requested_url IS NULL OR length(trim(requested_url)) > 0),
    final_url TEXT NULL CHECK (final_url IS NULL OR length(trim(final_url)) > 0),
    destination_kind TEXT NOT NULL DEFAULT 'unknown' CHECK (destination_kind IN ('content','login','unknown')),
    redirect_chain_json TEXT CHECK(redirect_chain_json IS NULL OR (json_valid(redirect_chain_json) AND json_type(redirect_chain_json)='array')),
    technical_status_raw TEXT,
    scope_checked TEXT NOT NULL CHECK (scope_checked IS NULL OR length(trim(scope_checked)) > 0),
    source_url TEXT NOT NULL CHECK (source_url IS NULL OR length(trim(source_url)) > 0),
    observed_at TEXT,
    observed_precision TEXT NOT NULL DEFAULT 'unknown' CHECK (observed_precision IN ('day','timestamp','unknown')),
    unknown_reason TEXT,
    formalized_at TEXT NOT NULL CHECK (formalized_at IS NULL OR length(trim(formalized_at)) > 0),
    evidence_path TEXT NOT NULL CHECK (evidence_path IS NULL OR length(trim(evidence_path)) > 0),
    evidence_pointer TEXT NOT NULL CHECK (evidence_pointer IS NULL OR length(trim(evidence_pointer)) > 0),
    provenance_kind TEXT NOT NULL CHECK (provenance_kind IN ('observed','reused','later_formalization')),
    raw_value TEXT,
    assessment_note TEXT,
    mapping_version TEXT NOT NULL CHECK (mapping_version IS NULL OR length(trim(mapping_version)) > 0),
    supersedes_id INTEGER NULL REFERENCES resource_url_observations(id) ON DELETE RESTRICT,
    CHECK ((observed_at IS NULL AND observed_precision='unknown' AND length(trim(coalesce(unknown_reason,'')))>0) OR (observed_at IS NOT NULL AND observed_precision<>'unknown' AND julianday(observed_at) IS NOT NULL)),
    CHECK (observed_precision<>'day' OR (length(observed_at)=10 AND date(observed_at,'+0 days')=observed_at)),
    CHECK (observed_precision<>'timestamp' OR (instr(observed_at,'T')>0 AND (substr(observed_at,-1)='Z' OR substr(observed_at,-6,1) IN ('+','-')))),
    CHECK (julianday(formalized_at) IS NOT NULL AND instr(formalized_at,'T')>0 AND (substr(formalized_at,-1)='Z' OR substr(formalized_at,-6,1) IN ('+','-'))),
    CHECK (supersedes_id IS NULL OR supersedes_id<>id)
);

CREATE TABLE condition_observations (
    id INTEGER PRIMARY KEY,
    stable_key TEXT NOT NULL CHECK (stable_key IS NULL OR length(trim(stable_key)) > 0) UNIQUE,
    source_id INTEGER NOT NULL REFERENCES catalog_sources(id) ON DELETE RESTRICT,
    condition_key TEXT NOT NULL CHECK (condition_key IS NULL OR length(trim(condition_key)) > 0),
    scope_raw TEXT NOT NULL CHECK (scope_raw IS NULL OR length(trim(scope_raw)) > 0),
    scope_kind TEXT NOT NULL CHECK (scope_kind IS NULL OR length(trim(scope_kind)) > 0),
    condition_url TEXT NOT NULL CHECK (condition_url IS NULL OR length(trim(condition_url)) > 0),
    summary_original TEXT NOT NULL CHECK (summary_original IS NULL OR length(trim(summary_original)) > 0),
    page_updated_raw TEXT,
    license_identifier TEXT,
    permission_state TEXT NOT NULL DEFAULT 'unknown' CHECK (permission_state IN ('unknown','declared','attested')),
    registration_declared_free INTEGER CHECK(registration_declared_free IN (0,1)),
    newsletter_declared_free INTEGER CHECK(newsletter_declared_free IN (0,1)),
    source_url TEXT NOT NULL CHECK (source_url IS NULL OR length(trim(source_url)) > 0),
    observed_at TEXT,
    observed_precision TEXT NOT NULL DEFAULT 'unknown' CHECK (observed_precision IN ('day','timestamp','unknown')),
    unknown_reason TEXT,
    formalized_at TEXT NOT NULL CHECK (formalized_at IS NULL OR length(trim(formalized_at)) > 0),
    evidence_path TEXT NOT NULL CHECK (evidence_path IS NULL OR length(trim(evidence_path)) > 0),
    evidence_pointer TEXT NOT NULL CHECK (evidence_pointer IS NULL OR length(trim(evidence_pointer)) > 0),
    provenance_kind TEXT NOT NULL CHECK (provenance_kind IN ('observed','reused','later_formalization')),
    raw_value TEXT,
    assessment_note TEXT,
    mapping_version TEXT NOT NULL CHECK (mapping_version IS NULL OR length(trim(mapping_version)) > 0),
    supersedes_id INTEGER NULL REFERENCES condition_observations(id) ON DELETE RESTRICT,
    CHECK ((observed_at IS NULL AND observed_precision='unknown' AND length(trim(coalesce(unknown_reason,'')))>0) OR (observed_at IS NOT NULL AND observed_precision<>'unknown' AND julianday(observed_at) IS NOT NULL)),
    CHECK (observed_precision<>'day' OR (length(observed_at)=10 AND date(observed_at,'+0 days')=observed_at)),
    CHECK (observed_precision<>'timestamp' OR (instr(observed_at,'T')>0 AND (substr(observed_at,-1)='Z' OR substr(observed_at,-6,1) IN ('+','-')))),
    CHECK (julianday(formalized_at) IS NOT NULL AND instr(formalized_at,'T')>0 AND (substr(formalized_at,-1)='Z' OR substr(formalized_at,-6,1) IN ('+','-'))),
    CHECK (supersedes_id IS NULL OR supersedes_id<>id)
);

CREATE TABLE resource_access_observations (
    id INTEGER PRIMARY KEY,
    stable_key TEXT NOT NULL CHECK (stable_key IS NULL OR length(trim(stable_key)) > 0) UNIQUE,
    mention_observation_id INTEGER NOT NULL REFERENCES source_resource_mention_observations(id) ON DELETE RESTRICT,
    subject_scope TEXT NOT NULL CHECK (subject_scope IN ('public_content','complete_rules','components_product','online_implementation')),
    access_raw TEXT NOT NULL CHECK (access_raw IS NULL OR length(trim(access_raw)) > 0),
    access_normalized TEXT NOT NULL CHECK (access_normalized IS NULL OR length(trim(access_normalized)) > 0),
    content_observed INTEGER CHECK(content_observed IN (0,1)),
    completeness_raw TEXT,
    completeness_normalized TEXT NOT NULL CHECK (completeness_normalized IS NULL OR length(trim(completeness_normalized)) > 0),
    cost_raw TEXT,
    cost_status TEXT NOT NULL DEFAULT 'unknown' CHECK (cost_status IN ('unknown','free_declared','free_observed','paid_declared','paid_observed')),
    amount REAL CHECK(amount>=0),
    currency TEXT,
    access_condition_raw TEXT,
    playtested INTEGER CHECK(playtested IN (0,1)),
    source_url TEXT NOT NULL CHECK (source_url IS NULL OR length(trim(source_url)) > 0),
    observed_at TEXT,
    observed_precision TEXT NOT NULL DEFAULT 'unknown' CHECK (observed_precision IN ('day','timestamp','unknown')),
    unknown_reason TEXT,
    formalized_at TEXT NOT NULL CHECK (formalized_at IS NULL OR length(trim(formalized_at)) > 0),
    evidence_path TEXT NOT NULL CHECK (evidence_path IS NULL OR length(trim(evidence_path)) > 0),
    evidence_pointer TEXT NOT NULL CHECK (evidence_pointer IS NULL OR length(trim(evidence_pointer)) > 0),
    provenance_kind TEXT NOT NULL CHECK (provenance_kind IN ('observed','reused','later_formalization')),
    raw_value TEXT,
    assessment_note TEXT,
    mapping_version TEXT NOT NULL CHECK (mapping_version IS NULL OR length(trim(mapping_version)) > 0),
    supersedes_id INTEGER NULL REFERENCES resource_access_observations(id) ON DELETE RESTRICT,
    CHECK(amount IS NULL OR length(trim(coalesce(currency,'')))>0),
    CHECK(cost_status NOT IN ('free_observed','free_declared') OR amount IS NULL OR amount=0),
    CHECK(cost_status<>'free_observed' OR content_observed IS 1),
    CHECK ((observed_at IS NULL AND observed_precision='unknown' AND length(trim(coalesce(unknown_reason,'')))>0) OR (observed_at IS NOT NULL AND observed_precision<>'unknown' AND julianday(observed_at) IS NOT NULL)),
    CHECK (observed_precision<>'day' OR (length(observed_at)=10 AND date(observed_at,'+0 days')=observed_at)),
    CHECK (observed_precision<>'timestamp' OR (instr(observed_at,'T')>0 AND (substr(observed_at,-1)='Z' OR substr(observed_at,-6,1) IN ('+','-')))),
    CHECK (julianday(formalized_at) IS NOT NULL AND instr(formalized_at,'T')>0 AND (substr(formalized_at,-1)='Z' OR substr(formalized_at,-6,1) IN ('+','-'))),
    CHECK (supersedes_id IS NULL OR supersedes_id<>id)
);

CREATE TABLE access_condition_links (
    id INTEGER PRIMARY KEY,
    stable_key TEXT NOT NULL CHECK (stable_key IS NULL OR length(trim(stable_key)) > 0) UNIQUE,
    access_observation_id INTEGER NOT NULL REFERENCES resource_access_observations(id) ON DELETE RESTRICT,
    condition_observation_id INTEGER NOT NULL REFERENCES condition_observations(id) ON DELETE RESTRICT,
    applicability_status TEXT NOT NULL CHECK (applicability_status IN ('declared','attested','uncertain')),
    evidence_pointer TEXT NOT NULL CHECK (evidence_pointer IS NULL OR length(trim(evidence_pointer)) > 0),
    UNIQUE (access_observation_id, condition_observation_id)
);

CREATE TABLE problem_instances (
    id INTEGER PRIMARY KEY,
    stable_key TEXT NOT NULL CHECK (stable_key IS NULL OR length(trim(stable_key)) > 0) UNIQUE,
    record_id INTEGER NOT NULL REFERENCES source_records(id) ON DELETE RESTRICT,
    instance_key TEXT NOT NULL CHECK (instance_key IS NULL OR length(trim(instance_key)) > 0),
    instance_kind TEXT NOT NULL CHECK (instance_kind IS NULL OR length(trim(instance_kind)) > 0),
    native_instance_id TEXT NULL CHECK (native_instance_id IS NULL OR length(trim(native_instance_id)) > 0),
    created_at TEXT NOT NULL CHECK (created_at IS NULL OR length(trim(created_at)) > 0),
    UNIQUE (record_id, instance_key)
);

CREATE TABLE problem_instance_observations (
    id INTEGER PRIMARY KEY,
    stable_key TEXT NOT NULL CHECK (stable_key IS NULL OR length(trim(stable_key)) > 0) UNIQUE,
    instance_id INTEGER NOT NULL REFERENCES problem_instances(id) ON DELETE RESTRICT,
    record_observation_id INTEGER NOT NULL REFERENCES source_record_observations(id) ON DELETE RESTRICT,
    date_raw TEXT,
    published_at TEXT,
    date_precision TEXT NOT NULL DEFAULT 'unknown' CHECK (date_precision IN ('day','timestamp','year','unknown')),
    label_raw TEXT,
    context_locator TEXT NOT NULL CHECK (context_locator IS NULL OR length(trim(context_locator)) > 0),
    source_url TEXT NOT NULL CHECK (source_url IS NULL OR length(trim(source_url)) > 0),
    observed_at TEXT,
    observed_precision TEXT NOT NULL DEFAULT 'unknown' CHECK (observed_precision IN ('day','timestamp','unknown')),
    unknown_reason TEXT,
    formalized_at TEXT NOT NULL CHECK (formalized_at IS NULL OR length(trim(formalized_at)) > 0),
    evidence_path TEXT NOT NULL CHECK (evidence_path IS NULL OR length(trim(evidence_path)) > 0),
    evidence_pointer TEXT NOT NULL CHECK (evidence_pointer IS NULL OR length(trim(evidence_pointer)) > 0),
    provenance_kind TEXT NOT NULL CHECK (provenance_kind IN ('observed','reused','later_formalization')),
    raw_value TEXT,
    assessment_note TEXT,
    mapping_version TEXT NOT NULL CHECK (mapping_version IS NULL OR length(trim(mapping_version)) > 0),
    supersedes_id INTEGER NULL REFERENCES problem_instance_observations(id) ON DELETE RESTRICT,
    CHECK(published_at IS NULL OR (date_precision='year' AND length(published_at)=4) OR (date_precision IN ('day','timestamp') AND julianday(published_at) IS NOT NULL)),
    CHECK ((observed_at IS NULL AND observed_precision='unknown' AND length(trim(coalesce(unknown_reason,'')))>0) OR (observed_at IS NOT NULL AND observed_precision<>'unknown' AND julianday(observed_at) IS NOT NULL)),
    CHECK (observed_precision<>'day' OR (length(observed_at)=10 AND date(observed_at,'+0 days')=observed_at)),
    CHECK (observed_precision<>'timestamp' OR (instr(observed_at,'T')>0 AND (substr(observed_at,-1)='Z' OR substr(observed_at,-6,1) IN ('+','-')))),
    CHECK (julianday(formalized_at) IS NOT NULL AND instr(formalized_at,'T')>0 AND (substr(formalized_at,-1)='Z' OR substr(formalized_at,-6,1) IN ('+','-'))),
    CHECK (supersedes_id IS NULL OR supersedes_id<>id)
);

CREATE TABLE instance_mention_assertions (
    id INTEGER PRIMARY KEY,
    stable_key TEXT NOT NULL CHECK (stable_key IS NULL OR length(trim(stable_key)) > 0) UNIQUE,
    instance_observation_id INTEGER NOT NULL REFERENCES problem_instance_observations(id) ON DELETE RESTRICT,
    mention_observation_id INTEGER NOT NULL REFERENCES source_resource_mention_observations(id) ON DELETE RESTRICT,
    role TEXT NOT NULL CHECK (role IN ('appears_in','solution_for')),
    assertion_status TEXT NOT NULL CHECK (assertion_status IS NULL OR length(trim(assertion_status)) > 0),
    cross_system_decision_ref TEXT NULL CHECK (cross_system_decision_ref IS NULL OR length(trim(cross_system_decision_ref)) > 0),
    source_url TEXT NOT NULL CHECK (source_url IS NULL OR length(trim(source_url)) > 0),
    observed_at TEXT,
    observed_precision TEXT NOT NULL DEFAULT 'unknown' CHECK (observed_precision IN ('day','timestamp','unknown')),
    unknown_reason TEXT,
    formalized_at TEXT NOT NULL CHECK (formalized_at IS NULL OR length(trim(formalized_at)) > 0),
    evidence_path TEXT NOT NULL CHECK (evidence_path IS NULL OR length(trim(evidence_path)) > 0),
    evidence_pointer TEXT NOT NULL CHECK (evidence_pointer IS NULL OR length(trim(evidence_pointer)) > 0),
    provenance_kind TEXT NOT NULL CHECK (provenance_kind IN ('observed','reused','later_formalization')),
    raw_value TEXT,
    assessment_note TEXT,
    mapping_version TEXT NOT NULL CHECK (mapping_version IS NULL OR length(trim(mapping_version)) > 0),
    supersedes_id INTEGER NULL REFERENCES instance_mention_assertions(id) ON DELETE RESTRICT,
    CHECK ((observed_at IS NULL AND observed_precision='unknown' AND length(trim(coalesce(unknown_reason,'')))>0) OR (observed_at IS NOT NULL AND observed_precision<>'unknown' AND julianday(observed_at) IS NOT NULL)),
    CHECK (observed_precision<>'day' OR (length(observed_at)=10 AND date(observed_at,'+0 days')=observed_at)),
    CHECK (observed_precision<>'timestamp' OR (instr(observed_at,'T')>0 AND (substr(observed_at,-1)='Z' OR substr(observed_at,-6,1) IN ('+','-')))),
    CHECK (julianday(formalized_at) IS NOT NULL AND instr(formalized_at,'T')>0 AND (substr(formalized_at,-1)='Z' OR substr(formalized_at,-6,1) IN ('+','-'))),
    CHECK (supersedes_id IS NULL OR supersedes_id<>id),
    UNIQUE (instance_observation_id, mention_observation_id, role)
);

CREATE TABLE source_credit_observations (
    id INTEGER PRIMARY KEY,
    stable_key TEXT NOT NULL CHECK (stable_key IS NULL OR length(trim(stable_key)) > 0) UNIQUE,
    record_observation_id INTEGER NOT NULL REFERENCES source_record_observations(id) ON DELETE RESTRICT,
    name_raw TEXT NULL CHECK (name_raw IS NULL OR length(trim(name_raw)) > 0),
    role_raw TEXT NOT NULL CHECK (role_raw IS NULL OR length(trim(role_raw)) > 0),
    status_raw TEXT NOT NULL CHECK (status_raw IS NULL OR length(trim(status_raw)) > 0),
    subject_context_raw TEXT,
    subject_record_id INTEGER NULL REFERENCES source_records(id) ON DELETE RESTRICT,
    subject_label_raw TEXT,
    party_kind TEXT NOT NULL DEFAULT 'unknown' CHECK (party_kind IN ('person','organization','unknown')),
    resolved_person_id INTEGER NULL REFERENCES people(id) ON DELETE RESTRICT,
    resolution_decision_ref TEXT NULL CHECK (resolution_decision_ref IS NULL OR length(trim(resolution_decision_ref)) > 0),
    source_url TEXT NOT NULL CHECK (source_url IS NULL OR length(trim(source_url)) > 0),
    observed_at TEXT,
    observed_precision TEXT NOT NULL DEFAULT 'unknown' CHECK (observed_precision IN ('day','timestamp','unknown')),
    unknown_reason TEXT,
    formalized_at TEXT NOT NULL CHECK (formalized_at IS NULL OR length(trim(formalized_at)) > 0),
    evidence_path TEXT NOT NULL CHECK (evidence_path IS NULL OR length(trim(evidence_path)) > 0),
    evidence_pointer TEXT NOT NULL CHECK (evidence_pointer IS NULL OR length(trim(evidence_pointer)) > 0),
    provenance_kind TEXT NOT NULL CHECK (provenance_kind IN ('observed','reused','later_formalization')),
    raw_value TEXT,
    assessment_note TEXT,
    mapping_version TEXT NOT NULL CHECK (mapping_version IS NULL OR length(trim(mapping_version)) > 0),
    supersedes_id INTEGER NULL REFERENCES source_credit_observations(id) ON DELETE RESTRICT,
    CHECK(name_raw IS NOT NULL OR status_raw IN ('not_declared','not_registered','unnamed')),
    CHECK(resolved_person_id IS NULL OR (name_raw IS NOT NULL AND party_kind='person' AND resolution_decision_ref IS NOT NULL)),
    CHECK ((observed_at IS NULL AND observed_precision='unknown' AND length(trim(coalesce(unknown_reason,'')))>0) OR (observed_at IS NOT NULL AND observed_precision<>'unknown' AND julianday(observed_at) IS NOT NULL)),
    CHECK (observed_precision<>'day' OR (length(observed_at)=10 AND date(observed_at,'+0 days')=observed_at)),
    CHECK (observed_precision<>'timestamp' OR (instr(observed_at,'T')>0 AND (substr(observed_at,-1)='Z' OR substr(observed_at,-6,1) IN ('+','-')))),
    CHECK (julianday(formalized_at) IS NOT NULL AND instr(formalized_at,'T')>0 AND (substr(formalized_at,-1)='Z' OR substr(formalized_at,-6,1) IN ('+','-'))),
    CHECK (supersedes_id IS NULL OR supersedes_id<>id)
);

CREATE TABLE source_relation_assertions (
    id INTEGER PRIMARY KEY,
    stable_key TEXT NOT NULL CHECK (stable_key IS NULL OR length(trim(stable_key)) > 0) UNIQUE,
    record_observation_id INTEGER NOT NULL REFERENCES source_record_observations(id) ON DELETE RESTRICT,
    from_record_id INTEGER NOT NULL REFERENCES source_records(id) ON DELETE RESTRICT,
    to_record_id INTEGER NULL REFERENCES source_records(id) ON DELETE RESTRICT,
    target_label_raw TEXT NULL CHECK (target_label_raw IS NULL OR length(trim(target_label_raw)) > 0),
    target_url TEXT NULL CHECK (target_url IS NULL OR length(trim(target_url)) > 0),
    relation_type_raw TEXT NOT NULL CHECK (relation_type_raw IS NULL OR length(trim(relation_type_raw)) > 0),
    relation_type_normalized TEXT NOT NULL CHECK (relation_type_normalized IS NULL OR length(trim(relation_type_normalized)) > 0),
    assertion_status TEXT NOT NULL CHECK (assertion_status IS NULL OR length(trim(assertion_status)) > 0),
    information_requirement TEXT NOT NULL DEFAULT 'unknown' CHECK (information_requirement IN ('unknown','none','optional','required')),
    ownership_requirement TEXT NOT NULL DEFAULT 'unknown' CHECK (ownership_requirement IN ('unknown','none','optional','required')),
    purchase_requirement TEXT NOT NULL DEFAULT 'unknown' CHECK (purchase_requirement IN ('unknown','none','optional','required')),
    source_url TEXT NOT NULL CHECK (source_url IS NULL OR length(trim(source_url)) > 0),
    observed_at TEXT,
    observed_precision TEXT NOT NULL DEFAULT 'unknown' CHECK (observed_precision IN ('day','timestamp','unknown')),
    unknown_reason TEXT,
    formalized_at TEXT NOT NULL CHECK (formalized_at IS NULL OR length(trim(formalized_at)) > 0),
    evidence_path TEXT NOT NULL CHECK (evidence_path IS NULL OR length(trim(evidence_path)) > 0),
    evidence_pointer TEXT NOT NULL CHECK (evidence_pointer IS NULL OR length(trim(evidence_pointer)) > 0),
    provenance_kind TEXT NOT NULL CHECK (provenance_kind IN ('observed','reused','later_formalization')),
    raw_value TEXT,
    assessment_note TEXT,
    mapping_version TEXT NOT NULL CHECK (mapping_version IS NULL OR length(trim(mapping_version)) > 0),
    supersedes_id INTEGER NULL REFERENCES source_relation_assertions(id) ON DELETE RESTRICT,
    CHECK(to_record_id IS NOT NULL OR target_label_raw IS NOT NULL OR target_url IS NOT NULL),
    CHECK(to_record_id IS NULL OR to_record_id<>from_record_id),
    CHECK ((observed_at IS NULL AND observed_precision='unknown' AND length(trim(coalesce(unknown_reason,'')))>0) OR (observed_at IS NOT NULL AND observed_precision<>'unknown' AND julianday(observed_at) IS NOT NULL)),
    CHECK (observed_precision<>'day' OR (length(observed_at)=10 AND date(observed_at,'+0 days')=observed_at)),
    CHECK (observed_precision<>'timestamp' OR (instr(observed_at,'T')>0 AND (substr(observed_at,-1)='Z' OR substr(observed_at,-6,1) IN ('+','-')))),
    CHECK (julianday(formalized_at) IS NOT NULL AND instr(formalized_at,'T')>0 AND (substr(formalized_at,-1)='Z' OR substr(formalized_at,-6,1) IN ('+','-'))),
    CHECK (supersedes_id IS NULL OR supersedes_id<>id)
);

CREATE TABLE source_identity_decisions (
    id INTEGER PRIMARY KEY,
    stable_key TEXT NOT NULL CHECK (stable_key IS NULL OR length(trim(stable_key)) > 0) UNIQUE,
    record_id INTEGER NOT NULL REFERENCES source_records(id) ON DELETE RESTRICT,
    game_id INTEGER NULL REFERENCES games(id) ON DELETE RESTRICT,
    decision_kind TEXT NOT NULL CHECK (decision_kind IN ('create_new','match')),
    status TEXT NOT NULL CHECK (status IN ('proposed','candidate','confirmed','rejected')),
    decided_at TEXT,
    decision_ref TEXT NOT NULL CHECK (decision_ref IS NULL OR length(trim(decision_ref)) > 0),
    rationale TEXT NOT NULL CHECK (rationale IS NULL OR length(trim(rationale)) > 0),
    previous_decision_id INTEGER NULL REFERENCES source_identity_decisions(id) ON DELETE RESTRICT,
    CHECK(status='proposed' OR (game_id IS NOT NULL AND decided_at IS NOT NULL))
);

CREATE TABLE canonical_projection_events (
    id INTEGER PRIMARY KEY,
    stable_key TEXT NOT NULL CHECK (stable_key IS NULL OR length(trim(stable_key)) > 0) UNIQUE,
    identity_decision_id INTEGER NOT NULL REFERENCES source_identity_decisions(id) ON DELETE RESTRICT,
    target_game_id INTEGER NOT NULL REFERENCES games(id) ON DELETE RESTRICT,
    target_kind TEXT NOT NULL CHECK (target_kind IN ('identity','name','credit','relationship')),
    name_observation_id INTEGER NULL REFERENCES source_record_observations(id) ON DELETE RESTRICT,
    name_evidence_pointer TEXT,
    credit_assertion_id INTEGER NULL REFERENCES source_credit_observations(id) ON DELETE RESTRICT,
    relation_assertion_id INTEGER NULL REFERENCES source_relation_assertions(id) ON DELETE RESTRICT,
    target_identity_decision_id INTEGER NULL REFERENCES source_identity_decisions(id) ON DELETE RESTRICT,
    target_name_id INTEGER NULL REFERENCES game_names(id) ON DELETE RESTRICT,
    target_credit_id INTEGER NULL REFERENCES credit_assertions(id) ON DELETE RESTRICT,
    relationship_to_game_id INTEGER NULL REFERENCES games(id) ON DELETE RESTRICT,
    relationship_type TEXT,
    projected_at TEXT NOT NULL CHECK (projected_at IS NULL OR length(trim(projected_at)) > 0),
    decision_ref TEXT NOT NULL CHECK (decision_ref IS NULL OR length(trim(decision_ref)) > 0),
    mapping_version TEXT NOT NULL CHECK (mapping_version IS NULL OR length(trim(mapping_version)) > 0),
    CHECK((target_kind='identity' AND name_observation_id IS NULL AND credit_assertion_id IS NULL AND relation_assertion_id IS NULL AND target_name_id IS NULL AND target_credit_id IS NULL AND relationship_to_game_id IS NULL AND relationship_type IS NULL AND target_identity_decision_id IS NULL) OR (target_kind='name' AND name_observation_id IS NOT NULL AND name_evidence_pointer IS NOT NULL AND target_name_id IS NOT NULL AND credit_assertion_id IS NULL AND relation_assertion_id IS NULL AND target_credit_id IS NULL AND relationship_to_game_id IS NULL AND relationship_type IS NULL AND target_identity_decision_id IS NULL) OR (target_kind='credit' AND credit_assertion_id IS NOT NULL AND target_credit_id IS NOT NULL AND name_observation_id IS NULL AND relation_assertion_id IS NULL AND target_name_id IS NULL AND relationship_to_game_id IS NULL AND relationship_type IS NULL AND target_identity_decision_id IS NULL) OR (target_kind='relationship' AND relation_assertion_id IS NOT NULL AND target_identity_decision_id IS NOT NULL AND relationship_to_game_id IS NOT NULL AND relationship_type IS NOT NULL AND name_observation_id IS NULL AND credit_assertion_id IS NULL AND target_name_id IS NULL AND target_credit_id IS NULL)),
    FOREIGN KEY(target_game_id,relationship_to_game_id,relationship_type) REFERENCES game_relationships(from_game_id,to_game_id,relationship_type) ON DELETE RESTRICT
);

CREATE TRIGGER source_record_keys_no_replace BEFORE INSERT ON source_record_keys WHEN EXISTS(SELECT 1 FROM source_record_keys p WHERE p.stable_key IS NEW.stable_key) OR EXISTS(SELECT 1 FROM source_record_keys p WHERE p.id IS NEW.id) OR EXISTS(SELECT 1 FROM source_record_keys p WHERE p.source_id IS NEW.source_id AND p.local_key IS NEW.local_key) BEGIN SELECT RAISE(ABORT,'immutable key collision: source_record_keys'); END;

CREATE TRIGGER source_record_keys_no_update BEFORE UPDATE ON source_record_keys BEGIN SELECT RAISE(ABORT,'append-only: source_record_keys'); END;

CREATE TRIGGER source_record_keys_no_delete BEFORE DELETE ON source_record_keys BEGIN SELECT RAISE(ABORT,'append-only: source_record_keys'); END;

CREATE TRIGGER source_record_observations_no_replace BEFORE INSERT ON source_record_observations WHEN EXISTS(SELECT 1 FROM source_record_observations p WHERE p.stable_key IS NEW.stable_key) OR EXISTS(SELECT 1 FROM source_record_observations p WHERE p.id IS NEW.id) OR EXISTS(SELECT 1 FROM source_record_observations p WHERE p.record_id IS NEW.record_id AND p.event_key IS NEW.event_key AND p.payload_sha256 IS NEW.payload_sha256 AND p.mapping_version IS NEW.mapping_version) BEGIN SELECT RAISE(ABORT,'immutable key collision: source_record_observations'); END;

CREATE TRIGGER source_record_observations_no_update BEFORE UPDATE ON source_record_observations BEGIN SELECT RAISE(ABORT,'append-only: source_record_observations'); END;

CREATE TRIGGER source_record_observations_no_delete BEFORE DELETE ON source_record_observations BEGIN SELECT RAISE(ABORT,'append-only: source_record_observations'); END;

CREATE TRIGGER source_admission_observations_no_replace BEFORE INSERT ON source_admission_observations WHEN EXISTS(SELECT 1 FROM source_admission_observations p WHERE p.stable_key IS NEW.stable_key) OR EXISTS(SELECT 1 FROM source_admission_observations p WHERE p.id IS NEW.id) BEGIN SELECT RAISE(ABORT,'immutable key collision: source_admission_observations'); END;

CREATE TRIGGER source_admission_observations_no_update BEFORE UPDATE ON source_admission_observations BEGIN SELECT RAISE(ABORT,'append-only: source_admission_observations'); END;

CREATE TRIGGER source_admission_observations_no_delete BEFORE DELETE ON source_admission_observations BEGIN SELECT RAISE(ABORT,'append-only: source_admission_observations'); END;

CREATE TRIGGER source_classification_observations_no_replace BEFORE INSERT ON source_classification_observations WHEN EXISTS(SELECT 1 FROM source_classification_observations p WHERE p.stable_key IS NEW.stable_key) OR EXISTS(SELECT 1 FROM source_classification_observations p WHERE p.id IS NEW.id) BEGIN SELECT RAISE(ABORT,'immutable key collision: source_classification_observations'); END;

CREATE TRIGGER source_classification_observations_no_update BEFORE UPDATE ON source_classification_observations BEGIN SELECT RAISE(ABORT,'append-only: source_classification_observations'); END;

CREATE TRIGGER source_classification_observations_no_delete BEFORE DELETE ON source_classification_observations BEGIN SELECT RAISE(ABORT,'append-only: source_classification_observations'); END;

CREATE TRIGGER source_classification_segments_no_replace BEFORE INSERT ON source_classification_segments WHEN EXISTS(SELECT 1 FROM source_classification_segments p WHERE p.stable_key IS NEW.stable_key) OR EXISTS(SELECT 1 FROM source_classification_segments p WHERE p.id IS NEW.id) OR EXISTS(SELECT 1 FROM source_classification_segments p WHERE p.classification_id IS NEW.classification_id AND p.position IS NEW.position) BEGIN SELECT RAISE(ABORT,'immutable key collision: source_classification_segments'); END;

CREATE TRIGGER source_classification_segments_no_update BEFORE UPDATE ON source_classification_segments BEGIN SELECT RAISE(ABORT,'append-only: source_classification_segments'); END;

CREATE TRIGGER source_classification_segments_no_delete BEFORE DELETE ON source_classification_segments BEGIN SELECT RAISE(ABORT,'append-only: source_classification_segments'); END;

CREATE TRIGGER common_classification_mappings_no_replace BEFORE INSERT ON common_classification_mappings WHEN EXISTS(SELECT 1 FROM common_classification_mappings p WHERE p.stable_key IS NEW.stable_key) OR EXISTS(SELECT 1 FROM common_classification_mappings p WHERE p.id IS NEW.id) BEGIN SELECT RAISE(ABORT,'immutable key collision: common_classification_mappings'); END;

CREATE TRIGGER common_classification_mappings_no_update BEFORE UPDATE ON common_classification_mappings BEGIN SELECT RAISE(ABORT,'append-only: common_classification_mappings'); END;

CREATE TRIGGER common_classification_mappings_no_delete BEFORE DELETE ON common_classification_mappings BEGIN SELECT RAISE(ABORT,'append-only: common_classification_mappings'); END;

CREATE TRIGGER source_record_url_observations_no_replace BEFORE INSERT ON source_record_url_observations WHEN EXISTS(SELECT 1 FROM source_record_url_observations p WHERE p.stable_key IS NEW.stable_key) OR EXISTS(SELECT 1 FROM source_record_url_observations p WHERE p.id IS NEW.id) BEGIN SELECT RAISE(ABORT,'immutable key collision: source_record_url_observations'); END;

CREATE TRIGGER source_record_url_observations_no_update BEFORE UPDATE ON source_record_url_observations BEGIN SELECT RAISE(ABORT,'append-only: source_record_url_observations'); END;

CREATE TRIGGER source_record_url_observations_no_delete BEFORE DELETE ON source_record_url_observations BEGIN SELECT RAISE(ABORT,'append-only: source_record_url_observations'); END;

CREATE TRIGGER source_resource_mentions_no_replace BEFORE INSERT ON source_resource_mentions WHEN EXISTS(SELECT 1 FROM source_resource_mentions p WHERE p.stable_key IS NEW.stable_key) OR EXISTS(SELECT 1 FROM source_resource_mentions p WHERE p.id IS NEW.id) OR EXISTS(SELECT 1 FROM source_resource_mentions p WHERE p.record_id IS NEW.record_id AND p.mention_key IS NEW.mention_key) BEGIN SELECT RAISE(ABORT,'immutable key collision: source_resource_mentions'); END;

CREATE TRIGGER source_resource_mentions_no_update BEFORE UPDATE ON source_resource_mentions BEGIN SELECT RAISE(ABORT,'append-only: source_resource_mentions'); END;

CREATE TRIGGER source_resource_mentions_no_delete BEFORE DELETE ON source_resource_mentions BEGIN SELECT RAISE(ABORT,'append-only: source_resource_mentions'); END;

CREATE TRIGGER source_resource_mention_observations_no_replace BEFORE INSERT ON source_resource_mention_observations WHEN EXISTS(SELECT 1 FROM source_resource_mention_observations p WHERE p.stable_key IS NEW.stable_key) OR EXISTS(SELECT 1 FROM source_resource_mention_observations p WHERE p.id IS NEW.id) BEGIN SELECT RAISE(ABORT,'immutable key collision: source_resource_mention_observations'); END;

CREATE TRIGGER source_resource_mention_observations_no_update BEFORE UPDATE ON source_resource_mention_observations BEGIN SELECT RAISE(ABORT,'append-only: source_resource_mention_observations'); END;

CREATE TRIGGER source_resource_mention_observations_no_delete BEFORE DELETE ON source_resource_mention_observations BEGIN SELECT RAISE(ABORT,'append-only: source_resource_mention_observations'); END;

CREATE TRIGGER admission_evidence_mentions_no_replace BEFORE INSERT ON admission_evidence_mentions WHEN EXISTS(SELECT 1 FROM admission_evidence_mentions p WHERE p.stable_key IS NEW.stable_key) OR EXISTS(SELECT 1 FROM admission_evidence_mentions p WHERE p.id IS NEW.id) OR EXISTS(SELECT 1 FROM admission_evidence_mentions p WHERE p.admission_id IS NEW.admission_id AND p.mention_observation_id IS NEW.mention_observation_id AND p.evidence_role IS NEW.evidence_role) BEGIN SELECT RAISE(ABORT,'immutable key collision: admission_evidence_mentions'); END;

CREATE TRIGGER admission_evidence_mentions_no_update BEFORE UPDATE ON admission_evidence_mentions BEGIN SELECT RAISE(ABORT,'append-only: admission_evidence_mentions'); END;

CREATE TRIGGER admission_evidence_mentions_no_delete BEFORE DELETE ON admission_evidence_mentions BEGIN SELECT RAISE(ABORT,'append-only: admission_evidence_mentions'); END;

CREATE TRIGGER resource_url_observations_no_replace BEFORE INSERT ON resource_url_observations WHEN EXISTS(SELECT 1 FROM resource_url_observations p WHERE p.stable_key IS NEW.stable_key) OR EXISTS(SELECT 1 FROM resource_url_observations p WHERE p.id IS NEW.id) BEGIN SELECT RAISE(ABORT,'immutable key collision: resource_url_observations'); END;

CREATE TRIGGER resource_url_observations_no_update BEFORE UPDATE ON resource_url_observations BEGIN SELECT RAISE(ABORT,'append-only: resource_url_observations'); END;

CREATE TRIGGER resource_url_observations_no_delete BEFORE DELETE ON resource_url_observations BEGIN SELECT RAISE(ABORT,'append-only: resource_url_observations'); END;

CREATE TRIGGER condition_observations_no_replace BEFORE INSERT ON condition_observations WHEN EXISTS(SELECT 1 FROM condition_observations p WHERE p.stable_key IS NEW.stable_key) OR EXISTS(SELECT 1 FROM condition_observations p WHERE p.id IS NEW.id) BEGIN SELECT RAISE(ABORT,'immutable key collision: condition_observations'); END;

CREATE TRIGGER condition_observations_no_update BEFORE UPDATE ON condition_observations BEGIN SELECT RAISE(ABORT,'append-only: condition_observations'); END;

CREATE TRIGGER condition_observations_no_delete BEFORE DELETE ON condition_observations BEGIN SELECT RAISE(ABORT,'append-only: condition_observations'); END;

CREATE TRIGGER resource_access_observations_no_replace BEFORE INSERT ON resource_access_observations WHEN EXISTS(SELECT 1 FROM resource_access_observations p WHERE p.stable_key IS NEW.stable_key) OR EXISTS(SELECT 1 FROM resource_access_observations p WHERE p.id IS NEW.id) BEGIN SELECT RAISE(ABORT,'immutable key collision: resource_access_observations'); END;

CREATE TRIGGER resource_access_observations_no_update BEFORE UPDATE ON resource_access_observations BEGIN SELECT RAISE(ABORT,'append-only: resource_access_observations'); END;

CREATE TRIGGER resource_access_observations_no_delete BEFORE DELETE ON resource_access_observations BEGIN SELECT RAISE(ABORT,'append-only: resource_access_observations'); END;

CREATE TRIGGER access_condition_links_no_replace BEFORE INSERT ON access_condition_links WHEN EXISTS(SELECT 1 FROM access_condition_links p WHERE p.stable_key IS NEW.stable_key) OR EXISTS(SELECT 1 FROM access_condition_links p WHERE p.id IS NEW.id) OR EXISTS(SELECT 1 FROM access_condition_links p WHERE p.access_observation_id IS NEW.access_observation_id AND p.condition_observation_id IS NEW.condition_observation_id) BEGIN SELECT RAISE(ABORT,'immutable key collision: access_condition_links'); END;

CREATE TRIGGER access_condition_links_no_update BEFORE UPDATE ON access_condition_links BEGIN SELECT RAISE(ABORT,'append-only: access_condition_links'); END;

CREATE TRIGGER access_condition_links_no_delete BEFORE DELETE ON access_condition_links BEGIN SELECT RAISE(ABORT,'append-only: access_condition_links'); END;

CREATE TRIGGER problem_instances_no_replace BEFORE INSERT ON problem_instances WHEN EXISTS(SELECT 1 FROM problem_instances p WHERE p.stable_key IS NEW.stable_key) OR EXISTS(SELECT 1 FROM problem_instances p WHERE p.id IS NEW.id) OR EXISTS(SELECT 1 FROM problem_instances p WHERE p.record_id IS NEW.record_id AND p.instance_key IS NEW.instance_key) BEGIN SELECT RAISE(ABORT,'immutable key collision: problem_instances'); END;

CREATE TRIGGER problem_instances_no_update BEFORE UPDATE ON problem_instances BEGIN SELECT RAISE(ABORT,'append-only: problem_instances'); END;

CREATE TRIGGER problem_instances_no_delete BEFORE DELETE ON problem_instances BEGIN SELECT RAISE(ABORT,'append-only: problem_instances'); END;

CREATE TRIGGER problem_instance_observations_no_replace BEFORE INSERT ON problem_instance_observations WHEN EXISTS(SELECT 1 FROM problem_instance_observations p WHERE p.stable_key IS NEW.stable_key) OR EXISTS(SELECT 1 FROM problem_instance_observations p WHERE p.id IS NEW.id) BEGIN SELECT RAISE(ABORT,'immutable key collision: problem_instance_observations'); END;

CREATE TRIGGER problem_instance_observations_no_update BEFORE UPDATE ON problem_instance_observations BEGIN SELECT RAISE(ABORT,'append-only: problem_instance_observations'); END;

CREATE TRIGGER problem_instance_observations_no_delete BEFORE DELETE ON problem_instance_observations BEGIN SELECT RAISE(ABORT,'append-only: problem_instance_observations'); END;

CREATE TRIGGER instance_mention_assertions_no_replace BEFORE INSERT ON instance_mention_assertions WHEN EXISTS(SELECT 1 FROM instance_mention_assertions p WHERE p.stable_key IS NEW.stable_key) OR EXISTS(SELECT 1 FROM instance_mention_assertions p WHERE p.id IS NEW.id) OR EXISTS(SELECT 1 FROM instance_mention_assertions p WHERE p.instance_observation_id IS NEW.instance_observation_id AND p.mention_observation_id IS NEW.mention_observation_id AND p.role IS NEW.role) BEGIN SELECT RAISE(ABORT,'immutable key collision: instance_mention_assertions'); END;

CREATE TRIGGER instance_mention_assertions_no_update BEFORE UPDATE ON instance_mention_assertions BEGIN SELECT RAISE(ABORT,'append-only: instance_mention_assertions'); END;

CREATE TRIGGER instance_mention_assertions_no_delete BEFORE DELETE ON instance_mention_assertions BEGIN SELECT RAISE(ABORT,'append-only: instance_mention_assertions'); END;

CREATE TRIGGER source_credit_observations_no_replace BEFORE INSERT ON source_credit_observations WHEN EXISTS(SELECT 1 FROM source_credit_observations p WHERE p.stable_key IS NEW.stable_key) OR EXISTS(SELECT 1 FROM source_credit_observations p WHERE p.id IS NEW.id) BEGIN SELECT RAISE(ABORT,'immutable key collision: source_credit_observations'); END;

CREATE TRIGGER source_credit_observations_no_update BEFORE UPDATE ON source_credit_observations BEGIN SELECT RAISE(ABORT,'append-only: source_credit_observations'); END;

CREATE TRIGGER source_credit_observations_no_delete BEFORE DELETE ON source_credit_observations BEGIN SELECT RAISE(ABORT,'append-only: source_credit_observations'); END;

CREATE TRIGGER source_relation_assertions_no_replace BEFORE INSERT ON source_relation_assertions WHEN EXISTS(SELECT 1 FROM source_relation_assertions p WHERE p.stable_key IS NEW.stable_key) OR EXISTS(SELECT 1 FROM source_relation_assertions p WHERE p.id IS NEW.id) BEGIN SELECT RAISE(ABORT,'immutable key collision: source_relation_assertions'); END;

CREATE TRIGGER source_relation_assertions_no_update BEFORE UPDATE ON source_relation_assertions BEGIN SELECT RAISE(ABORT,'append-only: source_relation_assertions'); END;

CREATE TRIGGER source_relation_assertions_no_delete BEFORE DELETE ON source_relation_assertions BEGIN SELECT RAISE(ABORT,'append-only: source_relation_assertions'); END;

CREATE TRIGGER source_identity_decisions_no_replace BEFORE INSERT ON source_identity_decisions WHEN EXISTS(SELECT 1 FROM source_identity_decisions p WHERE p.stable_key IS NEW.stable_key) OR EXISTS(SELECT 1 FROM source_identity_decisions p WHERE p.id IS NEW.id) BEGIN SELECT RAISE(ABORT,'immutable key collision: source_identity_decisions'); END;

CREATE TRIGGER source_identity_decisions_no_update BEFORE UPDATE ON source_identity_decisions BEGIN SELECT RAISE(ABORT,'append-only: source_identity_decisions'); END;

CREATE TRIGGER source_identity_decisions_no_delete BEFORE DELETE ON source_identity_decisions BEGIN SELECT RAISE(ABORT,'append-only: source_identity_decisions'); END;

CREATE TRIGGER canonical_projection_events_no_replace BEFORE INSERT ON canonical_projection_events WHEN EXISTS(SELECT 1 FROM canonical_projection_events p WHERE p.stable_key IS NEW.stable_key) OR EXISTS(SELECT 1 FROM canonical_projection_events p WHERE p.id IS NEW.id) BEGIN SELECT RAISE(ABORT,'immutable key collision: canonical_projection_events'); END;

CREATE TRIGGER canonical_projection_events_no_update BEFORE UPDATE ON canonical_projection_events BEGIN SELECT RAISE(ABORT,'append-only: canonical_projection_events'); END;

CREATE TRIGGER canonical_projection_events_no_delete BEFORE DELETE ON canonical_projection_events BEGIN SELECT RAISE(ABORT,'append-only: canonical_projection_events'); END;

CREATE TRIGGER source_record_observations_check_0 BEFORE INSERT ON source_record_observations WHEN EXISTS(SELECT 1 FROM source_record_observations p WHERE p.record_id=NEW.record_id AND p.event_key=NEW.event_key AND p.stable_key<>NEW.stable_key) AND (NEW.supersedes_id IS NULL OR NOT EXISTS(SELECT 1 FROM source_record_observations p WHERE p.id=NEW.supersedes_id AND p.record_id=NEW.record_id AND p.event_key=NEW.event_key) OR length(trim(coalesce(NEW.assessment_note,'')))=0) BEGIN SELECT RAISE(ABORT,'changed event requires explicit correction'); END;

CREATE TRIGGER source_classification_segments_check_1 BEFORE INSERT ON source_classification_segments WHEN NOT EXISTS(SELECT 1 FROM source_classification_observations p WHERE p.id=NEW.classification_id AND p.path_state='observed' AND NEW.position<p.segment_count) OR NEW.position<>(SELECT count(*) FROM source_classification_segments WHERE classification_id=NEW.classification_id) BEGIN SELECT RAISE(ABORT,'path segments must be observed and contiguous'); END;

CREATE TRIGGER source_record_url_observations_check_2 BEFORE INSERT ON source_record_url_observations WHEN NEW.predecessor_url_observation_id IS NOT NULL AND NOT EXISTS(SELECT 1 FROM source_record_url_observations p WHERE p.id=NEW.predecessor_url_observation_id AND p.request_event_key IS NEW.request_event_key AND NEW.request_event_key IS NOT NULL AND NEW.redirect_position=p.redirect_position+1) BEGIN SELECT RAISE(ABORT,'redirect chain requires same event and contiguous steps'); END;

CREATE TRIGGER source_resource_mention_observations_check_3 BEFORE INSERT ON source_resource_mention_observations WHEN NOT EXISTS(SELECT 1 FROM source_resource_mentions m JOIN source_record_observations o ON o.record_id=m.record_id WHERE m.id=NEW.mention_id AND o.id=NEW.record_observation_id) BEGIN SELECT RAISE(ABORT,'mention and observation owners differ'); END;

CREATE TRIGGER source_resource_mention_observations_check_4 BEFORE INSERT ON source_resource_mention_observations WHEN NEW.resource_id IS NOT NULL AND NOT EXISTS(SELECT 1 FROM catalog_resources r WHERE r.id=NEW.resource_id AND r.url=NEW.declared_url) BEGIN SELECT RAISE(ABORT,'resource URL must equal declared URL'); END;

CREATE TRIGGER admission_evidence_mentions_check_5 BEFORE INSERT ON admission_evidence_mentions WHEN NOT EXISTS(SELECT 1 FROM source_admission_observations a JOIN source_record_observations o ON o.id=a.record_observation_id JOIN source_resource_mentions m ON m.record_id=o.record_id WHERE a.id=NEW.admission_id AND m.id=NEW.mention_id) BEGIN SELECT RAISE(ABORT,'admission evidence requires its record context'); END;

CREATE TRIGGER resource_url_observations_check_6 BEFORE INSERT ON resource_url_observations WHEN NOT EXISTS(SELECT 1 FROM source_resource_mention_observations m WHERE m.id=NEW.mention_observation_id AND m.declared_url=NEW.requested_url) BEGIN SELECT RAISE(ABORT,'requested URL must identify the contextual mention'); END;

CREATE TRIGGER resource_access_observations_check_7 BEFORE INSERT ON resource_access_observations WHEN NEW.supersedes_id IS NOT NULL AND NOT EXISTS(SELECT 1 FROM resource_access_observations p WHERE p.id=NEW.supersedes_id AND p.subject_scope=NEW.subject_scope) BEGIN SELECT RAISE(ABORT,'access correction must preserve subject scope'); END;

CREATE TRIGGER access_condition_links_check_8 BEFORE INSERT ON access_condition_links WHEN NOT EXISTS(SELECT 1 FROM resource_access_observations a JOIN source_resource_mention_observations m ON m.id=a.mention_observation_id JOIN source_record_observations o ON o.id=m.record_observation_id JOIN source_records r ON r.id=o.record_id JOIN condition_observations c ON c.source_id=r.source_id WHERE a.id=NEW.access_observation_id AND c.id=NEW.condition_observation_id) BEGIN SELECT RAISE(ABORT,'conditions must belong to contextual source'); END;

CREATE TRIGGER problem_instance_observations_check_9 BEFORE INSERT ON problem_instance_observations WHEN NOT EXISTS(SELECT 1 FROM problem_instances i JOIN source_record_observations o ON o.record_id=i.record_id WHERE i.id=NEW.instance_id AND o.id=NEW.record_observation_id) BEGIN SELECT RAISE(ABORT,'instance observation owner differs'); END;

CREATE TRIGGER instance_mention_assertions_check_10 BEFORE INSERT ON instance_mention_assertions WHEN NEW.role='solution_for' AND NOT EXISTS(SELECT 1 FROM source_resource_mention_observations m WHERE m.id=NEW.mention_observation_id AND m.function_raw='solutions') BEGIN SELECT RAISE(ABORT,'solution relation requires a solutions mention'); END;

CREATE TRIGGER instance_mention_assertions_check_11 BEFORE INSERT ON instance_mention_assertions WHEN NEW.cross_system_decision_ref IS NULL AND NOT EXISTS(SELECT 1 FROM problem_instance_observations i JOIN source_record_observations oi ON oi.id=i.record_observation_id JOIN source_resource_mention_observations m JOIN source_record_observations om ON om.id=m.record_observation_id WHERE i.id=NEW.instance_observation_id AND m.id=NEW.mention_observation_id AND oi.record_id=om.record_id) BEGIN SELECT RAISE(ABORT,'cross-system instance relation needs explicit decision'); END;

CREATE TRIGGER canonical_projection_events_check_12 BEFORE INSERT ON canonical_projection_events WHEN NOT EXISTS(SELECT 1 FROM source_identity_decisions d WHERE d.id=NEW.identity_decision_id AND d.status='confirmed' AND d.game_id=NEW.target_game_id) BEGIN SELECT RAISE(ABORT,'canonical projection needs confirmed identity'); END;

CREATE TRIGGER canonical_projection_events_check_13 BEFORE INSERT ON canonical_projection_events WHEN NEW.target_kind='identity' AND NOT EXISTS(SELECT 1 FROM game_source_records g JOIN source_identity_decisions d ON d.record_id=g.source_record_id WHERE d.id=NEW.identity_decision_id AND g.game_id=NEW.target_game_id AND g.match_status='confirmed') BEGIN SELECT RAISE(ABORT,'identity projection must match canonical link'); END;

CREATE TRIGGER canonical_projection_events_check_14 BEFORE INSERT ON canonical_projection_events WHEN NEW.target_kind='name' AND NOT EXISTS(SELECT 1 FROM source_identity_decisions d JOIN source_record_observations o ON o.record_id=d.record_id JOIN game_names n ON n.source_record_id=d.record_id WHERE d.id=NEW.identity_decision_id AND o.id=NEW.name_observation_id AND n.id=NEW.target_name_id AND n.game_id=NEW.target_game_id) BEGIN SELECT RAISE(ABORT,'name projection context differs'); END;

CREATE TRIGGER canonical_projection_events_check_15 BEFORE INSERT ON canonical_projection_events WHEN NEW.target_kind='credit' AND NOT EXISTS(SELECT 1 FROM source_identity_decisions d JOIN source_credit_observations c JOIN source_record_observations o ON o.id=c.record_observation_id JOIN credit_assertions t ON t.person_id=c.resolved_person_id AND t.role=c.role_raw WHERE d.id=NEW.identity_decision_id AND c.id=NEW.credit_assertion_id AND o.record_id=d.record_id AND (c.subject_record_id IS NULL OR c.subject_record_id=d.record_id) AND c.subject_label_raw IS NULL AND t.id=NEW.target_credit_id AND t.game_id=NEW.target_game_id) BEGIN SELECT RAISE(ABORT,'credit projection needs resolved role and correct subject'); END;

CREATE TRIGGER canonical_projection_events_check_16 BEFORE INSERT ON canonical_projection_events WHEN NEW.target_kind='relationship' AND NOT EXISTS(SELECT 1 FROM source_identity_decisions d JOIN source_relation_assertions a ON a.from_record_id=d.record_id JOIN source_identity_decisions td ON td.record_id=a.to_record_id WHERE d.id=NEW.identity_decision_id AND a.id=NEW.relation_assertion_id AND a.relation_type_normalized=NEW.relationship_type AND td.id=NEW.target_identity_decision_id AND td.status='confirmed' AND td.game_id=NEW.relationship_to_game_id) BEGIN SELECT RAISE(ABORT,'relationship projection requires both confirmed identities'); END;

CREATE TRIGGER source_record_keys_check_17 BEFORE INSERT ON source_record_keys WHEN NEW.record_id IS NOT NULL AND NOT EXISTS(SELECT 1 FROM source_records p WHERE p.id=NEW.record_id AND p.source_id IS NEW.source_id) BEGIN SELECT RAISE(ABORT,'referenced owner differs or is absent'); END;

CREATE TRIGGER source_record_observations_check_18 BEFORE INSERT ON source_record_observations WHEN NEW.supersedes_id IS NOT NULL AND NOT EXISTS(SELECT 1 FROM source_record_observations p WHERE p.id=NEW.supersedes_id AND p.record_id IS NEW.record_id) BEGIN SELECT RAISE(ABORT,'referenced owner differs or is absent'); END;

CREATE TRIGGER source_record_observations_check_19 BEFORE INSERT ON source_record_observations WHEN NEW.parent_observation_id IS NOT NULL AND NOT EXISTS(SELECT 1 FROM source_record_observations p WHERE p.id=NEW.parent_observation_id AND p.record_id IS NEW.record_id) BEGIN SELECT RAISE(ABORT,'referenced owner differs or is absent'); END;

CREATE TRIGGER source_admission_observations_check_20 BEFORE INSERT ON source_admission_observations WHEN NEW.supersedes_id IS NOT NULL AND NOT EXISTS(SELECT 1 FROM source_admission_observations p WHERE p.id=NEW.supersedes_id AND p.record_observation_id IS NEW.record_observation_id) BEGIN SELECT RAISE(ABORT,'referenced owner differs or is absent'); END;

CREATE TRIGGER source_classification_observations_check_21 BEFORE INSERT ON source_classification_observations WHEN NEW.supersedes_id IS NOT NULL AND NOT EXISTS(SELECT 1 FROM source_classification_observations p WHERE p.id=NEW.supersedes_id AND p.record_observation_id IS NEW.record_observation_id) BEGIN SELECT RAISE(ABORT,'referenced owner differs or is absent'); END;

CREATE TRIGGER common_classification_mappings_check_22 BEFORE INSERT ON common_classification_mappings WHEN NEW.supersedes_id IS NOT NULL AND NOT EXISTS(SELECT 1 FROM common_classification_mappings p WHERE p.id=NEW.supersedes_id AND p.classification_id IS NEW.classification_id) BEGIN SELECT RAISE(ABORT,'referenced owner differs or is absent'); END;

CREATE TRIGGER source_record_url_observations_check_23 BEFORE INSERT ON source_record_url_observations WHEN NEW.supersedes_id IS NOT NULL AND NOT EXISTS(SELECT 1 FROM source_record_url_observations p WHERE p.id=NEW.supersedes_id AND p.record_id IS NEW.record_id) BEGIN SELECT RAISE(ABORT,'referenced owner differs or is absent'); END;

CREATE TRIGGER source_record_url_observations_check_24 BEFORE INSERT ON source_record_url_observations WHEN NEW.record_observation_id IS NOT NULL AND NOT EXISTS(SELECT 1 FROM source_record_observations p WHERE p.id=NEW.record_observation_id AND p.record_id IS NEW.record_id) BEGIN SELECT RAISE(ABORT,'referenced owner differs or is absent'); END;

CREATE TRIGGER source_record_url_observations_check_25 BEFORE INSERT ON source_record_url_observations WHEN NEW.predecessor_url_observation_id IS NOT NULL AND NOT EXISTS(SELECT 1 FROM source_record_url_observations p WHERE p.id=NEW.predecessor_url_observation_id AND p.record_id IS NEW.record_id) BEGIN SELECT RAISE(ABORT,'referenced owner differs or is absent'); END;

CREATE TRIGGER source_resource_mentions_check_26 BEFORE INSERT ON source_resource_mentions WHEN NEW.first_observation_id IS NOT NULL AND NOT EXISTS(SELECT 1 FROM source_record_observations p WHERE p.id=NEW.first_observation_id AND p.record_id IS NEW.record_id) BEGIN SELECT RAISE(ABORT,'referenced owner differs or is absent'); END;

CREATE TRIGGER source_resource_mention_observations_check_27 BEFORE INSERT ON source_resource_mention_observations WHEN NEW.supersedes_id IS NOT NULL AND NOT EXISTS(SELECT 1 FROM source_resource_mention_observations p WHERE p.id=NEW.supersedes_id AND p.mention_id IS NEW.mention_id) BEGIN SELECT RAISE(ABORT,'referenced owner differs or is absent'); END;

CREATE TRIGGER admission_evidence_mentions_check_28 BEFORE INSERT ON admission_evidence_mentions WHEN NEW.mention_observation_id IS NOT NULL AND NOT EXISTS(SELECT 1 FROM source_resource_mention_observations p WHERE p.id=NEW.mention_observation_id AND p.mention_id IS NEW.mention_id) BEGIN SELECT RAISE(ABORT,'referenced owner differs or is absent'); END;

CREATE TRIGGER resource_url_observations_check_29 BEFORE INSERT ON resource_url_observations WHEN NEW.supersedes_id IS NOT NULL AND NOT EXISTS(SELECT 1 FROM resource_url_observations p WHERE p.id=NEW.supersedes_id AND p.mention_observation_id IS NEW.mention_observation_id) BEGIN SELECT RAISE(ABORT,'referenced owner differs or is absent'); END;

CREATE TRIGGER condition_observations_check_30 BEFORE INSERT ON condition_observations WHEN NEW.supersedes_id IS NOT NULL AND NOT EXISTS(SELECT 1 FROM condition_observations p WHERE p.id=NEW.supersedes_id AND p.source_id IS NEW.source_id) BEGIN SELECT RAISE(ABORT,'referenced owner differs or is absent'); END;

CREATE TRIGGER resource_access_observations_check_31 BEFORE INSERT ON resource_access_observations WHEN NEW.supersedes_id IS NOT NULL AND NOT EXISTS(SELECT 1 FROM resource_access_observations p WHERE p.id=NEW.supersedes_id AND p.mention_observation_id IS NEW.mention_observation_id) BEGIN SELECT RAISE(ABORT,'referenced owner differs or is absent'); END;

CREATE TRIGGER problem_instance_observations_check_32 BEFORE INSERT ON problem_instance_observations WHEN NEW.supersedes_id IS NOT NULL AND NOT EXISTS(SELECT 1 FROM problem_instance_observations p WHERE p.id=NEW.supersedes_id AND p.instance_id IS NEW.instance_id) BEGIN SELECT RAISE(ABORT,'referenced owner differs or is absent'); END;

CREATE TRIGGER instance_mention_assertions_check_33 BEFORE INSERT ON instance_mention_assertions WHEN NEW.supersedes_id IS NOT NULL AND NOT EXISTS(SELECT 1 FROM instance_mention_assertions p WHERE p.id=NEW.supersedes_id AND p.instance_observation_id IS NEW.instance_observation_id) BEGIN SELECT RAISE(ABORT,'referenced owner differs or is absent'); END;

CREATE TRIGGER source_credit_observations_check_34 BEFORE INSERT ON source_credit_observations WHEN NEW.supersedes_id IS NOT NULL AND NOT EXISTS(SELECT 1 FROM source_credit_observations p WHERE p.id=NEW.supersedes_id AND p.record_observation_id IS NEW.record_observation_id) BEGIN SELECT RAISE(ABORT,'referenced owner differs or is absent'); END;

CREATE TRIGGER source_relation_assertions_check_35 BEFORE INSERT ON source_relation_assertions WHEN NEW.supersedes_id IS NOT NULL AND NOT EXISTS(SELECT 1 FROM source_relation_assertions p WHERE p.id=NEW.supersedes_id AND p.from_record_id IS NEW.from_record_id) BEGIN SELECT RAISE(ABORT,'referenced owner differs or is absent'); END;

CREATE TRIGGER source_relation_assertions_check_36 BEFORE INSERT ON source_relation_assertions WHEN NEW.record_observation_id IS NOT NULL AND NOT EXISTS(SELECT 1 FROM source_record_observations p WHERE p.id=NEW.record_observation_id AND p.record_id IS NEW.from_record_id) BEGIN SELECT RAISE(ABORT,'referenced owner differs or is absent'); END;

CREATE TRIGGER source_identity_decisions_check_37 BEFORE INSERT ON source_identity_decisions WHEN NEW.previous_decision_id IS NOT NULL AND NOT EXISTS(SELECT 1 FROM source_identity_decisions p WHERE p.id=NEW.previous_decision_id AND p.record_id IS NEW.record_id) BEGIN SELECT RAISE(ABORT,'referenced owner differs or is absent'); END;

CREATE INDEX idx_source_record_keys_record_id ON source_record_keys(record_id);

CREATE INDEX idx_source_record_keys_source_id ON source_record_keys(source_id);

CREATE INDEX idx_source_record_observations_record_id ON source_record_observations(record_id);

CREATE INDEX idx_source_admission_observations_record_observation_id ON source_admission_observations(record_observation_id);

CREATE INDEX idx_source_classification_observations_record_observation_id ON source_classification_observations(record_observation_id);

CREATE INDEX idx_source_record_url_observations_record_id ON source_record_url_observations(record_id);

CREATE INDEX idx_source_record_url_observations_record_observation_id ON source_record_url_observations(record_observation_id);

CREATE INDEX idx_source_resource_mentions_record_id ON source_resource_mentions(record_id);

CREATE INDEX idx_source_resource_mention_observations_record_observation_id ON source_resource_mention_observations(record_observation_id);

CREATE INDEX idx_source_resource_mention_observations_mention_id ON source_resource_mention_observations(mention_id);

CREATE INDEX idx_admission_evidence_mentions_mention_id ON admission_evidence_mentions(mention_id);

CREATE INDEX idx_admission_evidence_mentions_mention_observation_id ON admission_evidence_mentions(mention_observation_id);

CREATE INDEX idx_resource_url_observations_mention_observation_id ON resource_url_observations(mention_observation_id);

CREATE INDEX idx_condition_observations_source_id ON condition_observations(source_id);

CREATE INDEX idx_resource_access_observations_mention_observation_id ON resource_access_observations(mention_observation_id);

CREATE INDEX idx_problem_instances_record_id ON problem_instances(record_id);

CREATE INDEX idx_problem_instance_observations_record_observation_id ON problem_instance_observations(record_observation_id);

CREATE INDEX idx_problem_instance_observations_instance_id ON problem_instance_observations(instance_id);

CREATE INDEX idx_instance_mention_assertions_mention_observation_id ON instance_mention_assertions(mention_observation_id);

CREATE INDEX idx_source_credit_observations_record_observation_id ON source_credit_observations(record_observation_id);

CREATE INDEX idx_source_relation_assertions_record_observation_id ON source_relation_assertions(record_observation_id);

CREATE INDEX idx_source_identity_decisions_record_id ON source_identity_decisions(record_id);

CREATE INDEX idx_canonical_projection_events_identity_decision_id ON canonical_projection_events(identity_decision_id);

COMMIT;
-- END MIGRATION 013_SOURCE_EVIDENCE


-- IMG 014: nuove installazioni; operativo migrato dal runner, non rieseguire schema.sql.
-- TSK-0067: additive image catalog. No legacy backfill; observations are append-only.
PRAGMA foreign_keys=ON;
CREATE TABLE img_imports (
 id INTEGER PRIMARY KEY, manifest_sha256 TEXT NOT NULL UNIQUE CHECK(length(manifest_sha256)=64),
 source_sha256 TEXT NOT NULL CHECK(length(source_sha256)=64), task_id TEXT NOT NULL,
 observed_at TEXT NOT NULL CHECK(julianday(observed_at) IS NOT NULL), imported_at TEXT NOT NULL,
 manifest_json TEXT NOT NULL CHECK(json_valid(manifest_json)),
 sources_json TEXT NOT NULL CHECK(json_valid(sources_json)), mapping_version TEXT NOT NULL
);
CREATE TABLE img_assets (
 image_id TEXT PRIMARY KEY CHECK(length(trim(image_id))>0),
 game_id INTEGER NOT NULL REFERENCES games(id) ON DELETE RESTRICT
);
CREATE TABLE img_files (
 id INTEGER PRIMARY KEY, image_id TEXT NOT NULL REFERENCES img_assets(image_id) ON DELETE RESTRICT,
 version_raw TEXT NOT NULL, relative_path TEXT NOT NULL UNIQUE,
 sha256 TEXT NOT NULL CHECK(length(sha256)=64 AND sha256 NOT GLOB '*[^0-9a-f]*'),
 byte_size INTEGER NOT NULL CHECK(byte_size>0), format TEXT NOT NULL,
 width INTEGER NOT NULL CHECK(width>0), height INTEGER NOT NULL CHECK(height>0),
 original_filename TEXT, acquired_at TEXT NOT NULL, UNIQUE(image_id,version_raw)
);
CREATE TABLE img_asset_observations (
 id INTEGER PRIMARY KEY, file_id INTEGER NOT NULL REFERENCES img_files(id) ON DELETE RESTRICT,
 import_id INTEGER NOT NULL REFERENCES img_imports(id), observed_at TEXT NOT NULL,
 payload_sha256 TEXT NOT NULL, payload_json TEXT NOT NULL CHECK(json_valid(payload_json)),
 label TEXT, subtype TEXT, side TEXT, origin_kind TEXT NOT NULL CHECK(origin_kind IN ('original','ai_generated','ai_reworked','derived')),
 material_version_raw TEXT, current_use TEXT NOT NULL CHECK(current_use IN ('adopted','superseded','not_adopted')),
 validation_state TEXT NOT NULL CHECK(validation_state IN ('not_required','pending','approved','rejected')),
 is_historical INTEGER NOT NULL CHECK(is_historical IN (0,1)),
 UNIQUE(file_id,observed_at,payload_sha256,is_historical),
 CHECK(origin_kind NOT IN ('ai_generated','ai_reworked') OR current_use<>'adopted' OR validation_state='approved')
);
CREATE TABLE img_categories (
 observation_id INTEGER NOT NULL REFERENCES img_asset_observations(id), category TEXT NOT NULL,
 is_primary INTEGER NOT NULL CHECK(is_primary IN (0,1)), PRIMARY KEY(observation_id,category)
);
CREATE UNIQUE INDEX img_one_category ON img_categories(observation_id) WHERE is_primary=1;
CREATE TABLE img_contexts (
 id INTEGER PRIMARY KEY, observation_id INTEGER NOT NULL REFERENCES img_asset_observations(id),
 entry_id INTEGER REFERENCES entries(id), contest_id INTEGER REFERENCES contests(id),
 product_id INTEGER REFERENCES products(id), source_record_id INTEGER REFERENCES source_records(id),
 revision_raw TEXT, payload_json TEXT NOT NULL CHECK(json_valid(payload_json))
);
CREATE TABLE img_provenances (
 id INTEGER PRIMARY KEY, observation_id INTEGER NOT NULL REFERENCES img_asset_observations(id),
 label TEXT NOT NULL, source_url TEXT, acquired_file_id INTEGER REFERENCES acquired_files(id),
 observed_at TEXT, payload_json TEXT NOT NULL CHECK(json_valid(payload_json)),
 UNIQUE(observation_id,payload_json)
);
CREATE TABLE img_occurrences (
 id INTEGER PRIMARY KEY, observation_id INTEGER NOT NULL REFERENCES img_asset_observations(id),
 acquired_file_id INTEGER REFERENCES acquired_files(id), page INTEGER CHECK(page>0),
 coordinates_json TEXT, coordinate_system TEXT, payload_json TEXT NOT NULL CHECK(json_valid(payload_json)),
 UNIQUE(observation_id,payload_json)
);
CREATE TABLE img_regions (
 id INTEGER PRIMARY KEY, observation_id INTEGER NOT NULL REFERENCES img_asset_observations(id),
 region_key TEXT NOT NULL, side TEXT NOT NULL, acquired_file_id INTEGER REFERENCES acquired_files(id),
 page INTEGER CHECK(page>0), coordinates_json TEXT NOT NULL CHECK(json_valid(coordinates_json)),
 coordinate_system TEXT NOT NULL, payload_json TEXT NOT NULL CHECK(json_valid(payload_json)),
 UNIQUE(observation_id,region_key)
);
CREATE TABLE img_region_links (
 region_id INTEGER NOT NULL REFERENCES img_regions(id), target_region_id INTEGER NOT NULL REFERENCES img_regions(id),
 PRIMARY KEY(region_id,target_region_id), CHECK(region_id<>target_region_id)
);
CREATE TABLE img_components (
 component_id TEXT PRIMARY KEY, game_id INTEGER NOT NULL REFERENCES games(id)
);
CREATE TABLE img_component_observations (
 id INTEGER PRIMARY KEY, component_id TEXT NOT NULL REFERENCES img_components(component_id),
 import_id INTEGER NOT NULL REFERENCES img_imports(id), observed_at TEXT NOT NULL,
 subtype TEXT NOT NULL, label TEXT, material_revision_raw TEXT,
 physical_count INTEGER CHECK(physical_count>=0), payload_sha256 TEXT NOT NULL,
 payload_json TEXT NOT NULL CHECK(json_valid(payload_json)), UNIQUE(component_id,observed_at,payload_sha256)
);
CREATE TABLE img_component_links (
 component_observation_id INTEGER NOT NULL REFERENCES img_component_observations(id),
 image_id TEXT NOT NULL REFERENCES img_assets(image_id), side TEXT NOT NULL DEFAULT 'whole',
 PRIMARY KEY(component_observation_id,image_id,side)
);
CREATE TABLE img_relations (
 id INTEGER PRIMARY KEY, observation_id INTEGER NOT NULL REFERENCES img_asset_observations(id), relation_type TEXT NOT NULL,
 target_image_id TEXT REFERENCES img_assets(image_id), target_file_id INTEGER REFERENCES img_files(id),
 target_component_id TEXT REFERENCES img_components(component_id),
 payload_json TEXT NOT NULL CHECK(json_valid(payload_json)),
 CHECK((target_image_id IS NOT NULL)+(target_file_id IS NOT NULL)+(target_component_id IS NOT NULL)=1)
);
CREATE TABLE img_research_observations (
 id INTEGER PRIMARY KEY, import_id INTEGER NOT NULL REFERENCES img_imports(id), game_id INTEGER NOT NULL REFERENCES games(id),
 entry_id INTEGER REFERENCES entries(id), contest_id INTEGER REFERENCES contests(id),
 observed_at TEXT NOT NULL, complete INTEGER NOT NULL CHECK(complete IN (0,1)),
 status_raw TEXT NOT NULL, payload_sha256 TEXT NOT NULL, payload_json TEXT NOT NULL CHECK(json_valid(payload_json)),
 UNIQUE(game_id,entry_id,contest_id,observed_at,payload_sha256)
);
CREATE TABLE img_category_research (
 research_id INTEGER NOT NULL REFERENCES img_research_observations(id), category TEXT NOT NULL,
 research_raw TEXT NOT NULL, applicability TEXT NOT NULL CHECK(applicability IN ('applicable','desired','not_applicable','unknown')),
 verified_absence INTEGER NOT NULL CHECK(verified_absence IN (0,1)),
 original_count INTEGER NOT NULL CHECK(original_count>=0), ai_count INTEGER NOT NULL CHECK(ai_count>=0),
 pending_count INTEGER NOT NULL CHECK(pending_count>=0),
 payload_json TEXT NOT NULL CHECK(json_valid(payload_json)), PRIMARY KEY(research_id,category)
);
CREATE TABLE img_decisions (
 id INTEGER PRIMARY KEY, file_id INTEGER NOT NULL REFERENCES img_files(id), import_id INTEGER NOT NULL REFERENCES img_imports(id),
 decision_key TEXT NOT NULL UNIQUE, outcome TEXT NOT NULL CHECK(outcome IN ('pending','approved','rejected')),
 decided_at TEXT NOT NULL CHECK(julianday(decided_at) IS NOT NULL), confirmation_ref TEXT, reason TEXT,
 payload_json TEXT NOT NULL CHECK(json_valid(payload_json)),
 CHECK(outcome='pending' OR length(trim(coalesce(confirmation_ref,'')))>0)
);
CREATE TABLE img_primary_selections (
 id INTEGER PRIMARY KEY, import_id INTEGER NOT NULL REFERENCES img_imports(id), game_id INTEGER NOT NULL REFERENCES games(id),
 image_id TEXT REFERENCES img_assets(image_id), selected_at TEXT NOT NULL CHECK(julianday(selected_at) IS NOT NULL),
 evidence_ref TEXT NOT NULL, payload_sha256 TEXT NOT NULL, UNIQUE(game_id,selected_at,payload_sha256)
);
CREATE INDEX img_asset_game ON img_assets(game_id);
CREATE INDEX img_observation_file ON img_asset_observations(file_id,observed_at);
CREATE INDEX img_research_game ON img_research_observations(game_id,entry_id,contest_id,observed_at);
CREATE VIEW img_current_assets AS
 SELECT * FROM (
 SELECT o.*, f.image_id, a.game_id, f.relative_path, f.version_raw,
 row_number() OVER(PARTITION BY f.image_id ORDER BY julianday(o.observed_at) DESC,o.id DESC) AS position
 FROM img_asset_observations o JOIN img_files f ON f.id=o.file_id JOIN img_assets a ON a.image_id=f.image_id
 WHERE o.is_historical=0) WHERE position=1;
CREATE VIEW img_current_research AS
 SELECT * FROM (SELECT r.*,row_number() OVER(PARTITION BY game_id,entry_id,contest_id ORDER BY julianday(observed_at) DESC,id DESC) AS position
 FROM img_research_observations r) WHERE position=1;
CREATE VIEW img_current_components AS
 SELECT * FROM (SELECT c.*,row_number() OVER(PARTITION BY component_id ORDER BY julianday(observed_at) DESC,id DESC) AS position
 FROM img_component_observations c) WHERE position=1;
CREATE VIEW img_current_decisions AS
 SELECT * FROM (SELECT d.*,row_number() OVER(PARTITION BY file_id ORDER BY julianday(decided_at) DESC,id DESC) AS position
 FROM img_decisions d) WHERE position=1;
CREATE VIEW img_current_primary AS
 SELECT * FROM (SELECT s.*,row_number() OVER(PARTITION BY game_id ORDER BY julianday(selected_at) DESC,id DESC) AS position
 FROM img_primary_selections s) WHERE position=1;

CREATE VIEW img_all_provenances AS
 SELECT DISTINCT f.image_id,p.label,p.source_url,p.acquired_file_id,p.observed_at,p.payload_json
 FROM img_provenances p JOIN img_asset_observations o ON o.id=p.observation_id JOIN img_files f ON f.id=o.file_id;
CREATE TRIGGER img_context_owner BEFORE INSERT ON img_contexts
 WHEN NEW.entry_id IS NOT NULL AND NOT EXISTS(
 SELECT 1 FROM entries e JOIN img_asset_observations o ON o.id=NEW.observation_id
 JOIN img_files f ON f.id=o.file_id JOIN img_assets a ON a.image_id=f.image_id
 WHERE e.id=NEW.entry_id AND e.game_id=a.game_id AND (NEW.contest_id IS NULL OR NEW.contest_id=e.contest_id))
 BEGIN SELECT RAISE(ABORT,'image context owner mismatch'); END;
CREATE TRIGGER img_component_owner BEFORE INSERT ON img_component_links
 WHEN NOT EXISTS(SELECT 1 FROM img_component_observations o JOIN img_components c ON c.component_id=o.component_id
 JOIN img_assets a ON a.image_id=NEW.image_id WHERE o.id=NEW.component_observation_id AND c.game_id=a.game_id)
 BEGIN SELECT RAISE(ABORT,'component image owner mismatch'); END;
CREATE TRIGGER img_region_owner BEFORE INSERT ON img_region_links
 WHEN NOT EXISTS(SELECT 1 FROM img_regions r JOIN img_regions t ON t.id=NEW.target_region_id
 WHERE r.id=NEW.region_id AND r.observation_id=t.observation_id)
 BEGIN SELECT RAISE(ABORT,'region owner mismatch'); END;
CREATE TRIGGER img_primary_owner BEFORE INSERT ON img_primary_selections
 WHEN NEW.image_id IS NOT NULL AND NOT EXISTS(SELECT 1 FROM img_assets a WHERE a.image_id=NEW.image_id AND a.game_id=NEW.game_id)
 BEGIN SELECT RAISE(ABORT,'primary owner mismatch'); END;
CREATE TRIGGER img_research_owner BEFORE INSERT ON img_research_observations
 WHEN NEW.entry_id IS NOT NULL AND NOT EXISTS(SELECT 1 FROM entries e WHERE e.id=NEW.entry_id AND e.game_id=NEW.game_id
 AND (NEW.contest_id IS NULL OR NEW.contest_id=e.contest_id))
 BEGIN SELECT RAISE(ABORT,'research owner mismatch'); END;

-- Immutable catalog guards: changes are new observations, never in-place edits.
CREATE TRIGGER img_imports_no_update BEFORE UPDATE ON img_imports BEGIN SELECT RAISE(ABORT,'image catalog is append-only'); END;
CREATE TRIGGER img_imports_no_delete BEFORE DELETE ON img_imports BEGIN SELECT RAISE(ABORT,'image catalog is append-only'); END;
CREATE TRIGGER img_assets_no_update BEFORE UPDATE ON img_assets BEGIN SELECT RAISE(ABORT,'image catalog is append-only'); END;
CREATE TRIGGER img_assets_no_delete BEFORE DELETE ON img_assets BEGIN SELECT RAISE(ABORT,'image catalog is append-only'); END;
CREATE TRIGGER img_files_no_update BEFORE UPDATE ON img_files BEGIN SELECT RAISE(ABORT,'image catalog is append-only'); END;
CREATE TRIGGER img_files_no_delete BEFORE DELETE ON img_files BEGIN SELECT RAISE(ABORT,'image catalog is append-only'); END;
CREATE TRIGGER img_asset_observations_no_update BEFORE UPDATE ON img_asset_observations BEGIN SELECT RAISE(ABORT,'image catalog is append-only'); END;
CREATE TRIGGER img_asset_observations_no_delete BEFORE DELETE ON img_asset_observations BEGIN SELECT RAISE(ABORT,'image catalog is append-only'); END;
CREATE TRIGGER img_categories_no_update BEFORE UPDATE ON img_categories BEGIN SELECT RAISE(ABORT,'image catalog is append-only'); END;
CREATE TRIGGER img_categories_no_delete BEFORE DELETE ON img_categories BEGIN SELECT RAISE(ABORT,'image catalog is append-only'); END;
CREATE TRIGGER img_contexts_no_update BEFORE UPDATE ON img_contexts BEGIN SELECT RAISE(ABORT,'image catalog is append-only'); END;
CREATE TRIGGER img_contexts_no_delete BEFORE DELETE ON img_contexts BEGIN SELECT RAISE(ABORT,'image catalog is append-only'); END;
CREATE TRIGGER img_provenances_no_update BEFORE UPDATE ON img_provenances BEGIN SELECT RAISE(ABORT,'image catalog is append-only'); END;
CREATE TRIGGER img_provenances_no_delete BEFORE DELETE ON img_provenances BEGIN SELECT RAISE(ABORT,'image catalog is append-only'); END;
CREATE TRIGGER img_occurrences_no_update BEFORE UPDATE ON img_occurrences BEGIN SELECT RAISE(ABORT,'image catalog is append-only'); END;
CREATE TRIGGER img_occurrences_no_delete BEFORE DELETE ON img_occurrences BEGIN SELECT RAISE(ABORT,'image catalog is append-only'); END;
CREATE TRIGGER img_regions_no_update BEFORE UPDATE ON img_regions BEGIN SELECT RAISE(ABORT,'image catalog is append-only'); END;
CREATE TRIGGER img_regions_no_delete BEFORE DELETE ON img_regions BEGIN SELECT RAISE(ABORT,'image catalog is append-only'); END;
CREATE TRIGGER img_region_links_no_update BEFORE UPDATE ON img_region_links BEGIN SELECT RAISE(ABORT,'image catalog is append-only'); END;
CREATE TRIGGER img_region_links_no_delete BEFORE DELETE ON img_region_links BEGIN SELECT RAISE(ABORT,'image catalog is append-only'); END;
CREATE TRIGGER img_components_no_update BEFORE UPDATE ON img_components BEGIN SELECT RAISE(ABORT,'image catalog is append-only'); END;
CREATE TRIGGER img_components_no_delete BEFORE DELETE ON img_components BEGIN SELECT RAISE(ABORT,'image catalog is append-only'); END;
CREATE TRIGGER img_component_observations_no_update BEFORE UPDATE ON img_component_observations BEGIN SELECT RAISE(ABORT,'image catalog is append-only'); END;
CREATE TRIGGER img_component_observations_no_delete BEFORE DELETE ON img_component_observations BEGIN SELECT RAISE(ABORT,'image catalog is append-only'); END;
CREATE TRIGGER img_component_links_no_update BEFORE UPDATE ON img_component_links BEGIN SELECT RAISE(ABORT,'image catalog is append-only'); END;
CREATE TRIGGER img_component_links_no_delete BEFORE DELETE ON img_component_links BEGIN SELECT RAISE(ABORT,'image catalog is append-only'); END;
CREATE TRIGGER img_relations_no_update BEFORE UPDATE ON img_relations BEGIN SELECT RAISE(ABORT,'image catalog is append-only'); END;
CREATE TRIGGER img_relations_no_delete BEFORE DELETE ON img_relations BEGIN SELECT RAISE(ABORT,'image catalog is append-only'); END;
CREATE TRIGGER img_research_observations_no_update BEFORE UPDATE ON img_research_observations BEGIN SELECT RAISE(ABORT,'image catalog is append-only'); END;
CREATE TRIGGER img_research_observations_no_delete BEFORE DELETE ON img_research_observations BEGIN SELECT RAISE(ABORT,'image catalog is append-only'); END;
CREATE TRIGGER img_category_research_no_update BEFORE UPDATE ON img_category_research BEGIN SELECT RAISE(ABORT,'image catalog is append-only'); END;
CREATE TRIGGER img_category_research_no_delete BEFORE DELETE ON img_category_research BEGIN SELECT RAISE(ABORT,'image catalog is append-only'); END;
CREATE TRIGGER img_decisions_no_update BEFORE UPDATE ON img_decisions BEGIN SELECT RAISE(ABORT,'image catalog is append-only'); END;
CREATE TRIGGER img_decisions_no_delete BEFORE DELETE ON img_decisions BEGIN SELECT RAISE(ABORT,'image catalog is append-only'); END;
CREATE TRIGGER img_primary_selections_no_update BEFORE UPDATE ON img_primary_selections BEGIN SELECT RAISE(ABORT,'image catalog is append-only'); END;
CREATE TRIGGER img_primary_selections_no_delete BEFORE DELETE ON img_primary_selections BEGIN SELECT RAISE(ABORT,'image catalog is append-only'); END;
