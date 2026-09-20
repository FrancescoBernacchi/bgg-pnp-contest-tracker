#!/usr/bin/env python3
"""Genera l'incremento SQL del censimento globale dei soli contest BGG."""

from __future__ import annotations

import json
import re
import sqlite3
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))

from app.generate_project_progress import challenge_titles

DB = ROOT / "database" / "pnp_collection.sqlite3"
MANIFEST = ROOT / "catalog" / "bgg_contest_census_titles.json"
OUTPUT = ROOT / "catalog" / "global-contest-census.sql"
OBSERVED = "2026-09-16"
HISTORIC_SOURCE = "https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024"
RECENT_SOURCE = "https://boardgamegeek.com/geeklist/355982/community-pnp-contests-and-winners"


def sql(value: object) -> str:
    if value is None:
        return "NULL"
    return "'" + str(value).replace("'", "''") + "'"


def key(value: str) -> str:
    value = re.sub(r"\b20\d{2}\b", "", value.casefold())
    normalized = re.sub(r"[^a-z0-9]+", "", value)
    return {"solomodedesigncontest": "solomodecontest"}.get(normalized, normalized)


def status(year: int, title: str) -> tuple[str, str]:
    lowered = title.casefold()
    if "eff the rules" in lowered or "15th roll & write" in lowered:
        return "abandoned", "abandoned"
    if "video stream" in lowered:
        return "cancelled", "cancelled"
    if "league of designers" in lowered:
        return "cancellation uncertain in historical index", "unknown"
    if year <= 2025:
        return "listed in retired/closed section of community index", "complete"
    if "september–october" in lowered and "nine" in lowered:
        return "active at 2026-09-16", "development"
    if "wargame" in lowered or "54-card" in lowered or "traditional deck" in lowered:
        return "2026 cycle not yet verified complete", "unknown"
    if "1-card print and play contest" in lowered:
        return "voting window elapsed", "complete"
    return "2026 state requires direct-thread verification", "unknown"


def main() -> None:
    raw = json.loads(MANIFEST.read_text(encoding="utf-8"))
    records = [(int(year), title) for year, titles in raw.items() for title in titles]
    for year, titles in challenge_titles().items():
        records.extend((year, title) for title in titles)

    with sqlite3.connect(DB) as db:
        existing_series = db.execute("SELECT canonical_name FROM contest_series").fetchall()
        existing_contests = db.execute(
            "SELECT c.year,c.name,cs.canonical_name FROM contests c JOIN contest_series cs ON cs.id=c.series_id"
        ).fetchall()
        series_by_key = {key(name): name for (name,) in existing_series}
        existing_keys = {(year, key(name)) for year, name, series in existing_contests}
        existing_keys.update((year, key(series)) for year, name, series in existing_contests)

    lines = ["PRAGMA foreign_keys = ON;", "BEGIN IMMEDIATE;", ""]
    seen: set[tuple[int, str]] = set()
    for year, title in sorted(records, key=lambda item: (item[0], item[1].casefold())):
        record_key = (year, key(title))
        if record_key in seen:
            continue
        seen.add(record_key)
        if record_key in existing_keys:
            continue
        is_challenge = "24 Hour" in title
        series = "24 Hour Design Challenge" if is_challenge else series_by_key.get(key(title), title)
        scope_type = "adjacent" if is_challenge else "pnp_core"
        treatment_profile = "format_adjacent" if is_challenge else "standard"
        source = HISTORIC_SOURCE if year <= 2024 else RECENT_SOURCE
        raw_status, normalized = status(year, title)
        lines.extend([
            "INSERT INTO contest_series(canonical_name,description,scope_notes,first_seen_at,last_verified_at)",
            f"SELECT {sql(series)},NULL,'Global BGG contest census', {sql(OBSERVED)}, {sql(OBSERVED)}",
            f"WHERE NOT EXISTS (SELECT 1 FROM contest_series WHERE canonical_name={sql(series)});",
            "INSERT INTO contests(series_id,name,year,edition_label,scope_type,treatment_profile,status_raw,status_normalized,source_url,first_seen_at,last_verified_at)",
            f"SELECT cs.id,{sql(title)},{year},{sql(str(year))},{sql(scope_type)},{sql(treatment_profile)},{sql(raw_status)},{sql(normalized)},{sql(source)},{sql(OBSERVED)},{sql(OBSERVED)}",
            f"FROM contest_series cs WHERE cs.canonical_name={sql(series)}",
            f"AND NOT EXISTS (SELECT 1 FROM contests c WHERE c.year={year} AND lower(c.name)=lower({sql(title)}));",
            "INSERT INTO contest_sources(contest_id,kind,url,label,bgg_object_type,is_official,first_seen_at,last_verified_at)",
            f"SELECT c.id,'community_index',{sql(source)},'Community PnP contests and winners','geeklist',0,{sql(OBSERVED)},{sql(OBSERVED)}",
            f"FROM contests c JOIN contest_series cs ON cs.id=c.series_id WHERE cs.canonical_name={sql(series)} AND c.year={year}",
            f"AND NOT EXISTS (SELECT 1 FROM contest_sources s WHERE s.contest_id=c.id AND s.url={sql(source)});",
            "",
        ])
    lines.extend(["COMMIT;", ""])
    OUTPUT.write_text("\n".join(lines), encoding="utf-8", newline="\n")
    print(f"Generated {OUTPUT.name}: {len(seen)} candidate records")


if __name__ == "__main__":
    main()
