-- Contenuti derivati da archivi; originali e acquisizioni restano distinti.
PRAGMA foreign_keys=ON;
BEGIN IMMEDIATE;
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
COMMIT;
