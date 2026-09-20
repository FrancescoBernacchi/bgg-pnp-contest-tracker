#!/usr/bin/env python3
"""Verifica l'incremento globale su una copia temporanea del database."""

from __future__ import annotations

import shutil
import sqlite3
import tempfile
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
DB = ROOT / "database" / "pnp_collection.sqlite3"
SQL = ROOT / "catalog" / "global-contest-census.sql"

if not SQL.exists():
    raise SystemExit("Run build_global_contest_census.py first")

with tempfile.TemporaryDirectory(ignore_cleanup_errors=True) as directory:
    copy = Path(directory) / DB.name
    shutil.copy2(DB, copy)
    with sqlite3.connect(copy) as db:
        before = db.execute("SELECT COUNT(*) FROM contests").fetchone()[0]
        db.executescript(SQL.read_text(encoding="utf-8"))
        after = db.execute("SELECT COUNT(*) FROM contests").fetchone()[0]
        years = db.execute("SELECT MIN(year),MAX(year),COUNT(DISTINCT year) FROM contests").fetchone()
        fk = db.execute("PRAGMA foreign_key_check").fetchall()
        integrity = db.execute("PRAGMA integrity_check").fetchone()[0]
    assert after == 305, (before, after)
    assert years == (2008, 2026, 19), years
    assert not fk, fk
    assert integrity == "ok", integrity
    print(f"Verified: contests {before} -> {after}; years {years[0]}-{years[1]} ({years[2]}); integrity ok")
