"""Verifica riproducibile della migrazione multifonte 009 su un DB temporaneo."""

from __future__ import annotations

import sqlite3
import tempfile
from pathlib import Path


ROOT = Path(__file__).resolve().parent.parent
MIGRATION = ROOT / "database" / "migrations" / "009_multisource_catalog.sql"


LEGACY_SCHEMA = """
PRAGMA foreign_keys = ON;
CREATE TABLE games (
    id INTEGER PRIMARY KEY,
    canonical_title TEXT NOT NULL,
    summary TEXT,
    min_players INTEGER,
    max_players INTEGER,
    min_play_minutes INTEGER,
    max_play_minutes INTEGER,
    minimum_age INTEGER,
    language TEXT,
    status_raw TEXT,
    status_normalized TEXT NOT NULL DEFAULT 'unknown',
    status_evidence TEXT,
    source_url TEXT NOT NULL,
    first_seen_at TEXT NOT NULL,
    last_verified_at TEXT NOT NULL
);
CREATE TABLE game_names (
    id INTEGER PRIMARY KEY,
    game_id INTEGER NOT NULL REFERENCES games(id),
    name TEXT NOT NULL,
    observed_from TEXT,
    observed_at TEXT NOT NULL,
    is_current INTEGER NOT NULL DEFAULT 0 CHECK (is_current IN (0, 1))
);
CREATE TABLE people (
    id INTEGER PRIMARY KEY,
    display_name TEXT NOT NULL,
    bgg_username TEXT,
    profile_url TEXT
);
CREATE TABLE game_credits (
    game_id INTEGER NOT NULL REFERENCES games(id),
    person_id INTEGER NOT NULL REFERENCES people(id),
    role TEXT NOT NULL,
    credit_raw TEXT,
    PRIMARY KEY (game_id, person_id, role)
);
"""


def scalar(db: sqlite3.Connection, sql: str) -> object:
    return db.execute(sql).fetchone()[0]


def main() -> None:
    with tempfile.TemporaryDirectory(prefix="pnp-migration-009-") as tmp:
        db_path = Path(tmp) / "migration.sqlite3"
        db = sqlite3.connect(db_path)
        db.execute("PRAGMA foreign_keys = ON")
        db.executescript(LEGACY_SCHEMA)
        db.execute(
            "INSERT INTO games(id,canonical_title,source_url,first_seen_at,last_verified_at) VALUES(1,'Legacy BGG Game','https://boardgamegeek.com/thread/1','2026-01-01','2026-01-01')"
        )
        db.execute(
            "INSERT INTO game_names(id,game_id,name,observed_from,observed_at,is_current) VALUES(1,1,'Legacy Alias','BGG','2026-01-01',1)"
        )
        db.execute("INSERT INTO people(id,display_name) VALUES(1,'Legacy Designer')")
        db.execute("INSERT INTO game_credits(game_id,person_id,role,credit_raw) VALUES(1,1,'designer','Legacy Designer')")
        db.commit()

        before = tuple(db.execute("SELECT * FROM games WHERE id=1").fetchone())
        db.executescript(MIGRATION.read_text(encoding="utf-8"))
        after = tuple(db.execute("SELECT * FROM games WHERE id=1").fetchone())
        assert before == after
        assert db.execute("SELECT name,is_current FROM game_names WHERE id=1").fetchone() == ("Legacy Alias", 1)
        assert db.execute("SELECT display_name FROM people WHERE id=1").fetchone()[0] == "Legacy Designer"
        assert scalar(db, "SELECT COUNT(*) FROM game_credits") == 1

        db.execute("INSERT INTO catalog_sources VALUES(1,'synthetic','Synthetic Source','publisher','https://example.invalid','2026-09-20','2026-09-20',NULL)")
        db.execute("INSERT INTO source_records(id,source_id,record_type,native_id,canonical_url,title_raw,observed_at) VALUES(1,1,'game_page','game-a','https://example.invalid/games/a','Game A','2026-09-20')")
        db.execute("INSERT INTO source_records(id,source_id,record_type,native_id,canonical_url,title_raw,observed_at) VALUES(2,1,'product_page','box-1','https://example.invalid/products/box-1','Box One','2026-09-20')")
        for game_id, title in ((2, "Game A"), (3, "Game B"), (4, "Game A Variant")):
            db.execute(
                "INSERT INTO games(id,canonical_title,source_url,first_seen_at,last_verified_at) VALUES(?,?,?,?,?)",
                (game_id, title, f"https://example.invalid/games/{game_id}", "2026-09-20", "2026-09-20"),
            )
        db.execute("INSERT INTO game_source_records VALUES(2,1,'confirmed','manual','synthetic fixture','2026-09-20')")
        db.execute("INSERT INTO products VALUES(1,'Box One','collection',NULL,'available','2026-09-20','2026-09-20',NULL)")
        db.execute("INSERT INTO product_source_records VALUES(1,2,'confirmed','synthetic fixture','2026-09-20')")
        db.execute("INSERT INTO product_games VALUES(1,2,'included_game',1,1,2,'declared',NULL)")
        db.execute("INSERT INTO product_games VALUES(1,3,'included_game',2,0,2,'declared',NULL)")
        db.execute("INSERT INTO game_relationships VALUES(4,2,'variant_of','required',1,'declared',NULL)")
        db.execute("INSERT INTO game_names(id,game_id,name,observed_from,observed_at,is_current,name_type,language_code,is_official,source_record_id,verification_status,evidence_url,last_verified_at) VALUES(2,2,'ゲームA','Synthetic Source','2026-09-20',1,'official','ja',1,1,'verified','https://example.invalid/games/a','2026-09-20')")
        db.execute("INSERT INTO catalog_resources VALUES(1,1,'rules','https://example.invalid/rules/a-en.pdf','English rules','en','application/pdf',NULL,'download','available','declared','2026-09-20',NULL,NULL)")
        db.execute("INSERT INTO resource_links(resource_id,game_id,link_role,evidence_record_id) VALUES(1,2,'rules',1)")
        db.execute("INSERT INTO online_platforms VALUES(1,'Synthetic Arena','https://play.example.invalid',NULL)")
        db.execute("INSERT INTO game_implementations(id,game_id,platform_id,title_raw,availability_status,declared_by_record_id,verification_status,first_seen_at) VALUES(1,2,1,'Game A','unknown',1,'declared','2026-09-20')")
        db.execute("INSERT INTO person_names VALUES(1,1,'Designer Alias','alias','en','Latn',1,'declared','2026-09-20',NULL)")
        db.execute("INSERT INTO credit_assertions(id,person_id,game_id,role,credit_raw,evidence_record_id,verification_status,observed_at) VALUES(1,1,2,'designer','Designer Alias',1,'declared','2026-09-20')")
        db.commit()

        assert scalar(db, "SELECT COUNT(*) FROM product_games WHERE product_id=1") == 2
        assert scalar(db, "SELECT COUNT(*) FROM game_relationships WHERE from_game_id=4 AND to_game_id=2") == 1
        assert scalar(db, "SELECT COUNT(*) FROM resource_links WHERE game_id=2") == 1
        assert scalar(db, "SELECT COUNT(*) FROM game_implementations WHERE verification_status='declared'") == 1
        assert scalar(db, "SELECT COUNT(*) FROM credit_assertions WHERE game_id=2") == 1
        assert db.execute("PRAGMA foreign_key_check").fetchall() == []
        assert scalar(db, "PRAGMA integrity_check") == "ok"
        print("migration 009: ok; legacy rows preserved; multifonte relations verified; foreign_key_check: ok; integrity_check: ok")
        db.close()


if __name__ == "__main__":
    main()
