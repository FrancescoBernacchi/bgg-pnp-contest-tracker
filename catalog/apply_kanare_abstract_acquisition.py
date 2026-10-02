"""Registra idempotentemente il primo lotto acquisito Kanare_Abstract."""

from __future__ import annotations

import argparse
import hashlib
import json
import sqlite3
from pathlib import Path


def apply(database: Path, manifest_path: Path, library: Path) -> dict:
    manifest = json.loads(manifest_path.read_text(encoding="utf-8"))
    con = sqlite3.connect(database)
    con.execute("PRAGMA foreign_keys=ON")
    try:
        con.execute("BEGIN IMMEDIATE")
        for item in manifest["items"]:
            local = library / Path(item["relative_path"])
            data = local.read_bytes()
            digest = hashlib.sha256(data).hexdigest()
            if len(data) != item["byte_size"] or digest != item["sha256"]:
                raise ValueError(f"File mismatch: {local}")
            if not data.startswith(b"%PDF-"):
                raise ValueError(f"Not a PDF: {local}")
            game_id = con.execute(
                "SELECT id FROM games WHERE canonical_title=?", (item["game_title"],)
            ).fetchone()[0]
            resource_id = con.execute(
                "SELECT id FROM catalog_resources WHERE url=?", (item["resource_url"],)
            ).fetchone()[0]
            acquisition = con.execute(
                "SELECT id FROM acquisitions WHERE game_id=? AND acquired_at=? AND source_snapshot=?",
                (game_id, manifest["acquired_at"], manifest["batch_key"]),
            ).fetchone()
            if acquisition is None:
                acquisition_id = con.execute(
                    """INSERT INTO acquisitions
                       (game_id,acquired_at,selection_reason,game_status_at_acquisition,source_snapshot,notes)
                       VALUES (?,?,?,?,?,?)""",
                    (game_id, manifest["acquired_at"], item["selection_reason"], "confirmed",
                     manifest["batch_key"], manifest["purpose"]),
                ).lastrowid
            else:
                acquisition_id = acquisition[0]
                con.execute(
                    """UPDATE acquisitions SET selection_reason=?,game_status_at_acquisition='confirmed',notes=?
                       WHERE id=?""",
                    (item["selection_reason"], manifest["purpose"], acquisition_id),
                )
            existing = con.execute(
                "SELECT id FROM acquired_files WHERE acquisition_id=? AND relative_path=?",
                (acquisition_id, item["relative_path"]),
            ).fetchone()
            values = (None, item["original_filename"], item["media_type"], item["byte_size"],
                      item["sha256"], None, resource_id, item["final_url"], item["language_code"],
                      item["status"], item["usage_conditions"], "Originale acquisito senza modifiche")
            if existing is None:
                con.execute(
                    """INSERT INTO acquired_files
                       (acquisition_id,remote_resource_id,relative_path,original_filename,media_type,
                        byte_size,sha256,version_raw,catalog_resource_id,final_url,language_code,
                        acquisition_status,usage_conditions,notes)
                       VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?)""",
                    (acquisition_id, None, item["relative_path"], *values[1:]),
                )
            else:
                con.execute(
                    """UPDATE acquired_files SET remote_resource_id=?,original_filename=?,media_type=?,
                       byte_size=?,sha256=?,version_raw=?,catalog_resource_id=?,final_url=?,language_code=?,
                       acquisition_status=?,usage_conditions=?,notes=? WHERE id=?""",
                    (*values, existing[0]),
                )
        con.commit()
    except Exception:
        con.rollback()
        raise
    result = {
        "acquisitions": con.execute("SELECT count(*) FROM acquisitions").fetchone()[0],
        "acquired_files": con.execute("SELECT count(*) FROM acquired_files").fetchone()[0],
        "foreign_key_check": con.execute("PRAGMA foreign_key_check").fetchall(),
        "integrity_check": con.execute("PRAGMA integrity_check").fetchone()[0],
    }
    con.close()
    return result


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("database", type=Path)
    parser.add_argument("manifest", type=Path)
    parser.add_argument("library", type=Path)
    args = parser.parse_args()
    print(json.dumps(apply(args.database, args.manifest, args.library), indent=2))


if __name__ == "__main__":
    main()
