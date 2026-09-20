from __future__ import annotations

import shutil
import sqlite3
import tempfile
from contextlib import closing
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
DATABASE = ROOT / "database" / "pnp_collection.sqlite3"
SQL = ROOT / "catalog" / "2026-entry-census-completion.sql"
EXPECTED = {300: 30, 301: 9, 302: 9, 303: 6, 304: 3, 305: 3}


def main() -> None:
    with tempfile.TemporaryDirectory() as directory:
        copy = Path(directory) / "verification.sqlite3"
        shutil.copy2(DATABASE, copy)
        with closing(sqlite3.connect(copy)) as db:
            already_applied = db.execute(
                "SELECT count(*) FROM entries WHERE contest_id BETWEEN 300 AND 305"
            ).fetchone()[0]
            if already_applied == 0:
                db.executescript(SQL.read_text(encoding="utf-8"))
            counts = dict(
                db.execute(
                    "SELECT contest_id, count(*) FROM entries "
                    "WHERE contest_id BETWEEN 300 AND 305 GROUP BY contest_id"
                )
            )
            assert counts == EXPECTED, (counts, EXPECTED)
            assert db.execute("PRAGMA integrity_check").fetchone()[0] == "ok"
            assert db.execute("PRAGMA foreign_key_check").fetchall() == []
            assert db.execute(
                "SELECT count(*) FROM entries WHERE contest_id=301 AND status_normalized='withdrawn'"
            ).fetchone()[0] == 2
            assert db.execute(
                "SELECT count(*) FROM contests WHERE id BETWEEN 300 AND 305 AND entries_url IS NOT NULL"
            ).fetchone()[0] == 6
    print("OK: 60 entry, sei roster completi, integrità e chiavi esterne verificate")


if __name__ == "__main__":
    main()
