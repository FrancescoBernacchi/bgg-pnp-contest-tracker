#!/usr/bin/env python3
"""Verifica la chiusura del censimento globale su una copia temporanea."""

from __future__ import annotations

import shutil
import sqlite3
import tempfile
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
DATABASE = ROOT / "database" / "pnp_collection.sqlite3"
SQL = ROOT / "catalog" / "global-contest-census-finalization.sql"


def main() -> None:
    with tempfile.TemporaryDirectory() as directory:
        target = Path(directory) / "verify.sqlite3"
        shutil.copy2(DATABASE, target)
        db = sqlite3.connect(target)
        try:
            db.executescript(SQL.read_text(encoding="utf-8"))
            assert db.execute("PRAGMA integrity_check").fetchone()[0] == "ok"
            assert not db.execute("PRAGMA foreign_key_check").fetchall()
            assert db.execute("SELECT COUNT(*) FROM contests").fetchone()[0] == 305
            assert db.execute("SELECT COUNT(DISTINCT year) FROM contests").fetchone()[0] == 19
            completed = db.execute(
                "SELECT COUNT(*) FROM contests WHERE year=2026 AND status_normalized='complete' "
                "AND (name LIKE '%(CULTURE)' OR name LIKE '%(CLASSIC)' "
                "OR name LIKE '%(STICK)' OR name LIKE '%(DRAW)')"
            ).fetchone()[0]
            assert completed == 4
            unresolved = db.execute(
                "SELECT COUNT(*) FROM contests WHERE status_normalized='unknown'"
            ).fetchone()[0]
            assert unresolved == 1
            assert db.execute(
                "SELECT status_normalized FROM contests "
                "WHERE year=2018 AND name='League of Designers Workshop and Contest'"
            ).fetchone()[0] == "unknown"
        finally:
            db.close()
        print("Verified finalization: 305 contests, 19 years, 4 resolved states, 1 documented unknown; integrity ok")


if __name__ == "__main__":
    main()
