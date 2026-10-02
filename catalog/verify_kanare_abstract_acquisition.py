"""Verifica database, manifest e originali del primo lotto Kanare_Abstract."""

from __future__ import annotations

import argparse
import hashlib
import json
import sqlite3
from pathlib import Path


LEGACY_COUNTS = {"contests": 305, "entries": 946, "rankings": 1054, "remote_resources": 327}


def verify(database: Path, manifest_path: Path, library: Path) -> dict:
    manifest = json.loads(manifest_path.read_text(encoding="utf-8"))
    con = sqlite3.connect(f"file:{database.resolve().as_posix()}?mode=ro", uri=True)
    con.row_factory = sqlite3.Row
    rows = con.execute(
        """SELECT g.canonical_title,a.source_snapshot,af.*,cr.url resource_url
           FROM acquired_files af JOIN acquisitions a ON a.id=af.acquisition_id
           JOIN games g ON g.id=a.game_id
           JOIN catalog_resources cr ON cr.id=af.catalog_resource_id
           WHERE a.source_snapshot=? ORDER BY g.canonical_title""",
        (manifest["batch_key"],),
    ).fetchall()
    assert len(rows) == len(manifest["items"]) == 3
    by_title = {r["canonical_title"]: r for r in rows}
    hashes = set()
    for item in manifest["items"]:
        row = by_title[item["game_title"]]
        local = library / Path(item["relative_path"])
        data = local.read_bytes()
        digest = hashlib.sha256(data).hexdigest()
        assert data.startswith(b"%PDF-")
        assert len(data) == row["byte_size"] == item["byte_size"]
        assert digest == row["sha256"] == item["sha256"]
        assert row["resource_url"] == item["resource_url"]
        assert row["final_url"] == item["final_url"]
        assert row["media_type"] == "application/pdf"
        assert row["language_code"] == "en"
        assert row["acquisition_status"] == "acquired"
        hashes.add(digest)
    assert len(hashes) == 3, "Duplicati byte-identici non motivati"
    assert con.execute("SELECT count(*) FROM acquisitions").fetchone()[0] == 3
    assert con.execute("SELECT count(*) FROM acquired_files").fetchone()[0] == 3
    assert con.execute("SELECT count(*) FROM game_source_records gsr JOIN source_records sr ON sr.id=gsr.source_record_id JOIN catalog_sources cs ON cs.id=sr.source_id WHERE cs.source_key='kanare_abstract' AND gsr.match_status='candidate'").fetchone()[0] == 15
    legacy = {t: con.execute(f"SELECT count(*) FROM {t}").fetchone()[0] for t in LEGACY_COUNTS}
    assert legacy == LEGACY_COUNTS, (legacy, LEGACY_COUNTS)
    fk = con.execute("PRAGMA foreign_key_check").fetchall()
    integrity = con.execute("PRAGMA integrity_check").fetchone()[0]
    assert not fk and integrity == "ok"
    con.close()
    return {"batch": manifest["batch_key"], "files": len(rows), "unique_hashes": len(hashes),
            "legacy_counts": legacy, "candidate_matches": 15,
            "foreign_key_check": [], "integrity_check": integrity}


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("database", type=Path)
    parser.add_argument("manifest", type=Path)
    parser.add_argument("library", type=Path)
    args = parser.parse_args()
    print(json.dumps(verify(args.database, args.manifest, args.library), indent=2, sort_keys=True))


if __name__ == "__main__":
    main()
