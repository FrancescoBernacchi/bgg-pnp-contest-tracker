import shutil
import sqlite3
import tempfile
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]

with tempfile.TemporaryDirectory() as directory:
    database = Path(directory) / "test.sqlite3"
    shutil.copy2(ROOT / "database" / "pnp_collection.sqlite3", database)
    connection = sqlite3.connect(database)
    connection.executescript((ROOT / "catalog" / "2025-in-hand-wips-resources.sql").read_text(encoding="utf-8"))
    checks = {
        "integrity": connection.execute("PRAGMA integrity_check").fetchone()[0],
        "foreign_keys": len(connection.execute("PRAGMA foreign_key_check").fetchall()),
        "entries": connection.execute("SELECT count(*) FROM entries WHERE contest_id=12").fetchone()[0],
        "wips": connection.execute("SELECT count(*) FROM entries WHERE contest_id=12 AND wip_thread_url IS NOT NULL").fetchone()[0],
        "scans": connection.execute("SELECT count(*) FROM entry_resource_scans s JOIN entries e ON e.id=s.entry_id WHERE e.contest_id=12 AND s.checked_at='2026-09-11'").fetchone()[0],
        "observed": connection.execute("SELECT count(*) FROM entry_resource_scans s JOIN entries e ON e.id=s.entry_id WHERE e.contest_id=12 AND s.resource_listing_status='observed'").fetchone()[0],
        "none_declared": connection.execute("SELECT count(*) FROM entry_resource_scans s JOIN entries e ON e.id=s.entry_id WHERE e.contest_id=12 AND s.resource_listing_status='none_declared'").fetchone()[0],
        "not_observable": connection.execute("SELECT count(*) FROM entry_resource_scans s JOIN entries e ON e.id=s.entry_id WHERE e.contest_id=12 AND s.resource_listing_status='not_observable'").fetchone()[0],
        "not_checked": connection.execute("SELECT count(*) FROM entry_resource_scans s JOIN entries e ON e.id=s.entry_id WHERE e.contest_id=12 AND s.resource_listing_status='not_checked'").fetchone()[0],
        "mentions": connection.execute("SELECT count(*) FROM entry_resource_mentions m JOIN entries e ON e.id=m.entry_id WHERE e.contest_id=12").fetchone()[0],
        "resources": connection.execute("SELECT count(DISTINCT m.remote_resource_id) FROM entry_resource_mentions m JOIN entries e ON e.id=m.entry_id WHERE e.contest_id=12").fetchone()[0],
        "duel_wip": connection.execute("SELECT wip_thread_url FROM entries WHERE id=381").fetchone()[0],
    }
    connection.close()

expected = {
    "integrity": "ok",
    "foreign_keys": 0,
    "entries": 27,
    "wips": 26,
    "scans": 27,
    "observed": 23,
    "none_declared": 2,
    "not_observable": 1,
    "not_checked": 1,
    "mentions": 63,
    "resources": 63,
    "duel_wip": None,
}
print(checks)
assert checks == expected
