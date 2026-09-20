-- Nucleo additivo per il catalogo multifonte.
-- Le tabelle BGG esistenti restano invariate e continuano a essere l'interfaccia
-- operativa dell'applicazione corrente.

PRAGMA foreign_keys = ON;
BEGIN IMMEDIATE;

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

ALTER TABLE game_names ADD COLUMN name_type TEXT NOT NULL DEFAULT 'alias';
ALTER TABLE game_names ADD COLUMN language_code TEXT;
ALTER TABLE game_names ADD COLUMN script_code TEXT;
ALTER TABLE game_names ADD COLUMN is_official INTEGER NOT NULL DEFAULT 0 CHECK (is_official IN (0, 1));
ALTER TABLE game_names ADD COLUMN source_record_id INTEGER REFERENCES source_records(id);
ALTER TABLE game_names ADD COLUMN verification_status TEXT NOT NULL DEFAULT 'not_checked'
    CHECK (verification_status IN ('not_checked', 'declared', 'verified', 'rejected', 'uncertain'));
ALTER TABLE game_names ADD COLUMN evidence_url TEXT;
ALTER TABLE game_names ADD COLUMN last_verified_at TEXT;

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
    CHECK (
        (game_id IS NOT NULL) +
        (product_id IS NOT NULL) +
        (source_record_id IS NOT NULL) = 1
    ),
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
    CHECK (
        (game_id IS NOT NULL) +
        (product_id IS NOT NULL) +
        (source_record_id IS NOT NULL) = 1
    )
);

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

COMMIT;
