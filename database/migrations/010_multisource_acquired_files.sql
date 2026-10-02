-- Collega i file acquisiti alle risorse del catalogo multifonte e conserva
-- i metadati tecnici e d'uso osservati al momento dell'acquisizione.

PRAGMA foreign_keys = ON;
BEGIN IMMEDIATE;

ALTER TABLE acquired_files ADD COLUMN catalog_resource_id INTEGER REFERENCES catalog_resources(id);
ALTER TABLE acquired_files ADD COLUMN final_url TEXT;
ALTER TABLE acquired_files ADD COLUMN language_code TEXT;
ALTER TABLE acquired_files ADD COLUMN acquisition_status TEXT NOT NULL DEFAULT 'acquired'
    CHECK (acquisition_status IN ('acquired', 'failed'));
ALTER TABLE acquired_files ADD COLUMN usage_conditions TEXT;
ALTER TABLE acquired_files ADD COLUMN notes TEXT;

CREATE INDEX idx_acquired_files_catalog_resource
    ON acquired_files(catalog_resource_id, acquisition_status);

COMMIT;
