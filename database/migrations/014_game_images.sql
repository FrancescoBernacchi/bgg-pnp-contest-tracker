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
