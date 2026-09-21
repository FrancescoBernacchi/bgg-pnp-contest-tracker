"""Reproducible offline checks for the Kanare_Abstract census import."""

from __future__ import annotations

import argparse
import json
import sqlite3
from pathlib import Path


LEGACY_COUNTS = {
    "contests": 305,
    "entries": 946,
    "game_credits": 407,
    "rankings": 1054,
    "remote_resources": 327,
}


def scalar(con: sqlite3.Connection, sql: str, params=()):
    return con.execute(sql, params).fetchone()[0]


def verify(path: Path) -> dict:
    con = sqlite3.connect(f"file:{path.resolve().as_posix()}?mode=ro", uri=True)
    con.row_factory = sqlite3.Row
    source_id = scalar(con, "SELECT id FROM catalog_sources WHERE source_key='kanare_abstract'")

    checks = {}
    checks["source_records"] = scalar(con, "SELECT count(*) FROM source_records WHERE source_id=?", (source_id,))
    checks["work_index_titles"] = scalar(
        con, "SELECT json_extract(raw_metadata,'$.documented_title_count') FROM source_records WHERE source_id=? AND record_type='work_index'",
        (source_id,),)
    checks["catalog_products_documented"] = scalar(
        con, "SELECT json_extract(raw_metadata,'$.documented_product_count') FROM source_records WHERE source_id=? AND record_type='product_catalog'",
        (source_id,),)
    checks["canonical_games"] = scalar(
        con, """SELECT count(DISTINCT gsr.game_id) FROM game_source_records gsr
                JOIN source_records sr ON sr.id=gsr.source_record_id
                WHERE sr.source_id=? AND gsr.match_status='confirmed'""", (source_id,))
    checks["index_candidates"] = scalar(
        con, """SELECT count(DISTINCT gsr.game_id) FROM game_source_records gsr
                JOIN source_records sr ON sr.id=gsr.source_record_id
                WHERE sr.source_id=? AND gsr.match_status='confirmed'
                  AND (sr.record_type='game_page' OR sr.record_type='work_index')""", (source_id,))
    checks["product_candidates"] = scalar(
        con, """SELECT count(DISTINCT gsr.game_id) FROM game_source_records gsr
                JOIN source_records sr ON sr.id=gsr.source_record_id
                WHERE sr.source_id=? AND gsr.match_status='confirmed' AND sr.record_type='product_page'""",
        (source_id,))
    checks["online_only_candidates"] = scalar(
        con, """SELECT count(DISTINCT gsr.game_id) FROM game_source_records gsr
                JOIN source_records sr ON sr.id=gsr.source_record_id
                WHERE sr.source_id=? AND gsr.match_status='confirmed' AND sr.record_type='online_play_index'""",
        (source_id,))
    checks["products"] = scalar(con, "SELECT count(*) FROM products")
    checks["ludic_products"] = scalar(con, "SELECT count(*) FROM products WHERE product_kind='physical_game_product'")
    checks["generic_accessories"] = scalar(con, "SELECT count(*) FROM products WHERE product_kind='generic_accessory'")
    checks["product_game_relations"] = scalar(con, "SELECT count(*) FROM product_games")
    checks["included_game_relations"] = scalar(con, "SELECT count(*) FROM product_games WHERE relationship_type='included_game'")
    checks["supported_game_relations"] = scalar(con, "SELECT count(*) FROM product_games WHERE relationship_type='supported_game'")
    checks["game_relationships"] = scalar(con, "SELECT count(*) FROM game_relationships")
    checks["aliases"] = scalar(
        con, """SELECT count(*) FROM game_names gn JOIN source_records sr ON sr.id=gn.source_record_id
                WHERE sr.source_id=?""", (source_id,))
    checks["candidate_matches"] = scalar(
        con, """SELECT count(*) FROM game_source_records gsr JOIN source_records sr ON sr.id=gsr.source_record_id
                WHERE sr.source_id=? AND gsr.match_status='candidate'""", (source_id,))
    checks["implementations"] = scalar(con, "SELECT count(*) FROM game_implementations")
    checks["implementations_declared"] = scalar(
        con, "SELECT count(*) FROM game_implementations WHERE verification_status='declared'")
    checks["catalog_resources"] = scalar(con, "SELECT count(*) FROM catalog_resources")
    checks["resource_links"] = scalar(con, "SELECT count(*) FROM resource_links")
    checks["online_platforms_named"] = scalar(con, "SELECT count(*) FROM online_platforms WHERE canonical_name <> 'Unspecified platform (Kanare declaration)'")
    checks["people_inserted"] = scalar(con, "SELECT count(*) FROM people") - 322
    checks["credit_assertions"] = scalar(con, "SELECT count(*) FROM credit_assertions")

    raw_rows = [json.loads(r[0]) for r in con.execute(
        "SELECT raw_metadata FROM source_records WHERE source_id=? AND raw_metadata IS NOT NULL", (source_id,))]
    checks["declared_image_presences"] = sum(bool(x.get("representative_image_present")) for x in raw_rows)
    checks["declared_rule_presences"] = (
        sum(bool(x.get("rules_languages_declared")) for x in raw_rows)
        + sum(len(x.get("direct_rule_pdf_titles", [])) for x in raw_rows)
    )

    expected = {
        "source_records": 76, "work_index_titles": 38, "catalog_products_documented": 39,
        "canonical_games": 64, "index_candidates": 38, "product_candidates": 25,
        "online_only_candidates": 11, "products": 39, "ludic_products": 31,
        "generic_accessories": 8, "product_game_relations": 56,
        "included_game_relations": 35, "supported_game_relations": 21,
        "game_relationships": 2, "aliases": 2, "candidate_matches": 15,
        "implementations": 54, "implementations_declared": 0,
        "catalog_resources": 141, "resource_links": 162, "online_platforms_named": 9,
        "people_inserted": 13, "credit_assertions": 62,
        "declared_image_presences": 73, "declared_rule_presences": 73,
    }
    assert checks == expected, {k: (checks.get(k), v) for k, v in expected.items() if checks.get(k) != v}

    implementation_statuses = dict(con.execute(
        "SELECT verification_status,count(*) FROM game_implementations GROUP BY verification_status"))
    assert implementation_statuses == {"uncertain": 40, "verified": 14}, implementation_statuses
    ripples = con.execute(
        """SELECT g.source_url,gsr.match_status FROM game_source_records gsr
           JOIN source_records sr ON sr.id=gsr.source_record_id JOIN games g ON g.id=gsr.game_id
           WHERE sr.source_id=? AND sr.record_type='game_page' AND lower(sr.title_raw)='ripples'""",
        (source_id,),).fetchall()
    assert sorted(r["match_status"] for r in ripples) == ["confirmed", "rejected"]

    imported_duplicate_titles = con.execute(
        """SELECT g.canonical_title,count(DISTINCT g.id) n FROM games g
           JOIN game_source_records gsr ON gsr.game_id=g.id JOIN source_records sr ON sr.id=gsr.source_record_id
           WHERE sr.source_id=? AND gsr.match_status='confirmed'
           GROUP BY lower(g.canonical_title) HAVING count(DISTINCT g.id)>1""", (source_id,)).fetchall()
    assert not imported_duplicate_titles, imported_duplicate_titles

    legacy_actual = {table: scalar(con, f"SELECT count(*) FROM {table}") for table in LEGACY_COUNTS}
    assert legacy_actual == LEGACY_COUNTS, (legacy_actual, LEGACY_COUNTS)
    # The 13 legacy name rows received only migration defaults; Kanare rows have provenance.
    assert scalar(con, "SELECT count(*) FROM game_names WHERE source_record_id IS NULL") == 13
    assert scalar(con, "SELECT count(*) FROM games") == 946 + 64
    assert scalar(con, "SELECT count(*) FROM people") == 322 + 13
    assert scalar(con, "SELECT count(*) FROM game_names") == 13 + 2

    fk = [tuple(r) for r in con.execute("PRAGMA foreign_key_check")]
    integrity = scalar(con, "PRAGMA integrity_check")
    assert not fk, fk
    assert integrity == "ok", integrity
    con.close()
    return {"counts": checks, "legacy_counts": legacy_actual,
            "foreign_key_check": fk, "integrity_check": integrity}


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("database", type=Path)
    args = parser.parse_args()
    print(json.dumps(verify(args.database), ensure_ascii=False, indent=2, sort_keys=True))


if __name__ == "__main__":
    main()
