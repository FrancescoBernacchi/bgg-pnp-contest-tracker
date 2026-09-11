import shutil
import sqlite3
import tempfile
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]

with tempfile.TemporaryDirectory() as directory:
    database = Path(directory) / "test.sqlite3"
    shutil.copy2(ROOT / "database" / "pnp_collection.sqlite3", database)
    connection = sqlite3.connect(database)
    if not connection.execute("SELECT 1 FROM sqlite_master WHERE type='table' AND name='entry_material_scans'").fetchone():
        connection.executescript((ROOT / "database" / "migrations" / "007_entry_declared_materials.sql").read_text(encoding="utf-8"))
    connection.executescript((ROOT / "catalog" / "2025-declared-materials.sql").read_text(encoding="utf-8"))
    checks = {
        "integrity": connection.execute("PRAGMA integrity_check").fetchone()[0],
        "foreign_keys": len(connection.execute("PRAGMA foreign_key_check").fetchall()),
        "entries": connection.execute("SELECT count(1) FROM entries WHERE contest_id IN (12,14,22)").fetchone()[0],
        "wips": connection.execute("SELECT count(1) FROM entries WHERE contest_id IN (12,14,22) AND wip_thread_url IS NOT NULL").fetchone()[0],
        "scans": connection.execute("SELECT count(1) FROM entry_material_scans s JOIN entries e ON e.id=s.entry_id WHERE e.contest_id IN (12,14,22) AND s.checked_at='2026-09-11' AND s.coverage_scope='first_post_only'").fetchone()[0],
        "observed": connection.execute("SELECT count(1) FROM entry_material_scans s JOIN entries e ON e.id=s.entry_id WHERE e.contest_id IN (12,14,22) AND s.material_listing_status='observed'").fetchone()[0],
        "none_declared": connection.execute("SELECT count(1) FROM entry_material_scans s JOIN entries e ON e.id=s.entry_id WHERE e.contest_id IN (12,14,22) AND s.material_listing_status='none_declared'").fetchone()[0],
        "not_observable": connection.execute("SELECT count(1) FROM entry_material_scans s JOIN entries e ON e.id=s.entry_id WHERE e.contest_id IN (12,14,22) AND s.material_listing_status='not_observable'").fetchone()[0],
        "not_checked": connection.execute("SELECT count(1) FROM entry_material_scans s JOIN entries e ON e.id=s.entry_id WHERE e.contest_id IN (12,14,22) AND s.material_listing_status='not_checked'").fetchone()[0],
        "requirements": connection.execute("SELECT count(1) FROM entry_material_requirements r JOIN entries e ON e.id=r.entry_id WHERE e.contest_id IN (12,14,22)").fetchone()[0],
        "entries_with_requirements": connection.execute("SELECT count(DISTINCT r.entry_id) FROM entry_material_requirements r JOIN entries e ON e.id=r.entry_id WHERE e.contest_id IN (12,14,22)").fetchone()[0],
        "non_wip_requirements": connection.execute("SELECT count(1) FROM entry_material_requirements r JOIN entries e ON e.id=r.entry_id WHERE e.wip_thread_url IS NULL").fetchone()[0],
    }
    connection.close()

expected = {"integrity":"ok","foreign_keys":0,"entries":91,"wips":89,"scans":91,
            "observed":69,"none_declared":19,"not_observable":1,"not_checked":2,
            "requirements":201,"entries_with_requirements":69,"non_wip_requirements":0}
print(checks)
assert checks == expected
