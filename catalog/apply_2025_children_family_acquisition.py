"""Registra idempotentemente il primo lotto BGG Children & Family 2025."""

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
        for observation in manifest["resource_observations"]:
            resource_id = observation["remote_resource_id"]
            resource = con.execute(
                "SELECT id FROM remote_resources WHERE id=?", (resource_id,)
            ).fetchone()
            if resource is None:
                raise ValueError(f"Remote resource missing: {resource_id}")
            existing = con.execute(
                """SELECT id FROM remote_resource_observations
                   WHERE remote_resource_id=? AND observed_at=? AND observation_kind='availability_check'""",
                (resource_id, manifest["acquired_at"]),
            ).fetchone()
            values = (
                observation["evidence_url"], observation["availability_status"],
                observation["version_raw"], observation["notes"]
            )
            if existing is None:
                con.execute(
                    """INSERT INTO remote_resource_observations
                       (remote_resource_id,observed_at,evidence_url,observation_kind,
                        availability_status,version_raw,notes)
                       VALUES (?,?,?,'availability_check',?,?,?)""",
                    (resource_id, manifest["acquired_at"], *values),
                )
            else:
                con.execute(
                    """UPDATE remote_resource_observations SET evidence_url=?,availability_status=?,
                       version_raw=?,notes=? WHERE id=?""",
                    (*values, existing[0]),
                )
            con.execute(
                "UPDATE remote_resources SET availability_status=?,last_verified_at=? WHERE id=?",
                (observation["availability_status"], manifest["acquired_at"], resource_id),
            )

        acquisitions: dict[str, int] = {}
        for item in manifest["items"]:
            local = library / Path(item["relative_path"])
            data = local.read_bytes()
            digest = hashlib.sha256(data).hexdigest()
            if len(data) != item["byte_size"] or digest != item["sha256"]:
                raise ValueError(f"File mismatch: {local}")
            if not data.startswith(b"%PDF-"):
                raise ValueError(f"Not a PDF: {local}")
            game = con.execute(
                "SELECT id,status_normalized FROM games WHERE canonical_title=?", (item["game_title"],)
            ).fetchone()
            if game is None:
                raise ValueError(f"Game missing: {item['game_title']}")
            resource = con.execute(
                "SELECT url FROM remote_resources WHERE id=?", (item["remote_resource_id"],)
            ).fetchone()
            if resource is None or resource[0] != item["resource_url"]:
                raise ValueError(f"Resource mismatch: {item['remote_resource_id']}")
            game_id, game_status = game
            acquisition_id = acquisitions.get(item["game_title"])
            if acquisition_id is None:
                row = con.execute(
                    "SELECT id FROM acquisitions WHERE game_id=? AND acquired_at=? AND source_snapshot=?",
                    (game_id, manifest["acquired_at"], manifest["batch_key"]),
                ).fetchone()
                if row is None:
                    acquisition_id = con.execute(
                        """INSERT INTO acquisitions
                           (game_id,acquired_at,selection_reason,game_status_at_acquisition,source_snapshot,notes)
                           VALUES (?,?,?,?,?,?)""",
                        (game_id, manifest["acquired_at"], item["selection_reason"], game_status,
                         manifest["batch_key"], manifest["purpose"]),
                    ).lastrowid
                else:
                    acquisition_id = row[0]
                    con.execute(
                        """UPDATE acquisitions SET selection_reason=?,game_status_at_acquisition=?,notes=?
                           WHERE id=?""",
                        (item["selection_reason"], game_status, manifest["purpose"], acquisition_id),
                    )
                acquisitions[item["game_title"]] = acquisition_id
            existing = con.execute(
                "SELECT id FROM acquired_files WHERE acquisition_id=? AND relative_path=?",
                (acquisition_id, item["relative_path"]),
            ).fetchone()
            values = (
                item["remote_resource_id"], item["original_filename"], item["media_type"],
                item["byte_size"], item["sha256"], item["version_raw"], item["final_url"],
                item["language_code"], item["status"], item["usage_conditions"],
                "Originale acquisito senza modifiche"
            )
            if existing is None:
                con.execute(
                    """INSERT INTO acquired_files
                       (acquisition_id,remote_resource_id,relative_path,original_filename,media_type,
                        byte_size,sha256,version_raw,final_url,language_code,acquisition_status,
                        usage_conditions,notes)
                       VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)""",
                    (acquisition_id, item["remote_resource_id"], item["relative_path"], *values[1:]),
                )
            else:
                con.execute(
                    """UPDATE acquired_files SET remote_resource_id=?,original_filename=?,media_type=?,
                       byte_size=?,sha256=?,version_raw=?,final_url=?,language_code=?,acquisition_status=?,
                       usage_conditions=?,notes=? WHERE id=?""",
                    (*values, existing[0]),
                )
        con.commit()
    except Exception:
        con.rollback()
        raise
    result = {
        "batch_acquisitions": con.execute(
            "SELECT count(*) FROM acquisitions WHERE source_snapshot=?", (manifest["batch_key"],)
        ).fetchone()[0],
        "batch_files": con.execute(
            """SELECT count(*) FROM acquired_files af JOIN acquisitions a ON a.id=af.acquisition_id
               WHERE a.source_snapshot=?""", (manifest["batch_key"],)
        ).fetchone()[0],
        "availability_checks": con.execute(
            """SELECT count(*) FROM remote_resource_observations
               WHERE observed_at=? AND observation_kind='availability_check'
               AND remote_resource_id IN (146,177,178,181,182)""",
            (manifest["acquired_at"],),
        ).fetchone()[0],
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
