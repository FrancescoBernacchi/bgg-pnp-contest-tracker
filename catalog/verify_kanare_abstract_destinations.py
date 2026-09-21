"""Apply the 2026-09-21 verification of Kanare-declared external destinations.

The observation set is deliberately explicit and offline: only URLs and outcomes
recorded during the browser review are applied.  Re-running the script is
idempotent and does not perform network requests.
"""

from __future__ import annotations

import argparse
import json
import sqlite3
from pathlib import Path


VERIFIED_AT = "2026-09-21"

VERIFIED_IMPLEMENTATIONS = {
    2: "https://play.abstractplay.com/games/meridians",
    4: "https://play.abstractplay.com/games/stairs",
    8: "https://play.abstractplay.com/games/trike",
    11: "https://play.abstractplay.com/games/enso",
    13: "https://play.abstractplay.com/games/abande",
    20: "https://en.boardgamearena.com/gamepanel?game=carpniches",
    27: "https://tabletopia.com/games/tori-shogi",
    36: "https://en.boardgamearena.com/gamepanel?game=trike",
    37: "https://en.boardgamearena.com/gamepanel?game=meridians",
    48: "https://mindsports.nl/index.php/dagaz/765-dagaz-project",
    50: "https://mindsports.nl/index.php/dagaz/765-dagaz-project",
    51: "https://spielstein.com/games/enso",
    52: "https://spielstein.com/games/abande",
    53: "https://spielstein.com/games/attangle",
}

NON_OBSERVABLE_PLATFORMS = {
    "Ai Ai": "Browser refused the destination because its TLS certificate could not be verified; no bypass attempted",
    "BoardSpace.net": "Platform page was not safely observable in the browser session",
    "Unspecified platform (Kanare declaration)": "No platform destination was recorded by Kanare",
}

CONFIRMED_MATCHES = {
    "Abande", "Attangle", "Carpniches", "Enso", "Flower Shop", "Meridians",
    "Slyde", "Stairs", "Tori Shogi", "Trike",
}


def scalar(con: sqlite3.Connection, sql: str, params=()):
    return con.execute(sql, params).fetchone()[0]


def apply(path: Path) -> dict:
    con = sqlite3.connect(path)
    con.execute("PRAGMA foreign_keys=ON")
    con.row_factory = sqlite3.Row
    source_id = scalar(con, "SELECT id FROM catalog_sources WHERE source_key='kanare_abstract'")
    online_record = scalar(con, "SELECT id FROM source_records WHERE source_id=? AND record_type='online_play_index'", (source_id,))
    try:
        con.execute("BEGIN IMMEDIATE")
        for row in con.execute("""SELECT gi.id,op.canonical_name FROM game_implementations gi
                                  JOIN online_platforms op ON op.id=gi.platform_id""").fetchall():
            iid, platform = row["id"], row["canonical_name"]
            if iid in VERIFIED_IMPLEMENTATIONS:
                url = VERIFIED_IMPLEMENTATIONS[iid]
                con.execute("""UPDATE game_implementations
                    SET implementation_url=?, availability_status='available', verification_status='verified',
                        last_verified_at=?, notes=? WHERE id=?""",
                    (url, VERIFIED_AT,
                     f"Official platform page or catalogue identifies the implementation; verified {VERIFIED_AT}", iid))
            else:
                reason = NON_OBSERVABLE_PLATFORMS.get(
                    platform,
                    "Platform reachable or indexed, but no sufficiently specific official implementation page was observed",
                )
                con.execute("""UPDATE game_implementations
                    SET availability_status=?, verification_status='uncertain', last_verified_at=?, notes=? WHERE id=?""",
                    ("not_observable" if platform in NON_OBSERVABLE_PLATFORMS else "unconfirmed",
                     VERIFIED_AT, f"{reason}; Kanare declaration preserved", iid))

        for title in CONFIRMED_MATCHES:
            con.execute("""UPDATE game_source_records SET match_status='confirmed', match_method='external_destination',
                evidence=?, decided_at=? WHERE source_record_id=? AND game_id=(SELECT id FROM games WHERE canonical_title=? ORDER BY id DESC LIMIT 1)
                AND match_status='candidate'""",
                (f"Kanare title reconciled with an official platform destination observed {VERIFIED_AT}",
                 VERIFIED_AT, online_record, title))

        # The BGG thread is a 2026 contest WIP, while Kanare's Ripples is the older
        # reversible-piece territory game.  Exact title alone is therefore rejected.
        con.execute("""UPDATE game_source_records SET match_status='rejected', match_method='manual_disambiguation',
            evidence=?, decided_at=? WHERE source_record_id IN
            (SELECT id FROM source_records WHERE source_id=? AND record_type='game_page' AND lower(title_raw)='ripples')
            AND game_id IN (SELECT id FROM games WHERE source_url LIKE 'https://boardgamegeek.com/thread/3713561/%')
            AND match_status='candidate'""",
            ("BGG destination is a distinct 2026 1-Card contest WIP; Kanare Ripples is described as a reversible-piece territory game",
             VERIFIED_AT, source_id))
        con.commit()
    except Exception:
        con.rollback()
        raise

    result = {
        "matches": {r[0]: r[1] for r in con.execute("""SELECT match_status,count(*) FROM game_source_records gsr
            JOIN source_records sr ON sr.id=gsr.source_record_id WHERE sr.source_id=? GROUP BY match_status""", (source_id,))},
        "implementations": {r[0]: r[1] for r in con.execute(
            "SELECT verification_status,count(*) FROM game_implementations GROUP BY verification_status")},
        "availability": {r[0]: r[1] for r in con.execute(
            "SELECT availability_status,count(*) FROM game_implementations GROUP BY availability_status")},
        "foreign_key_check": [tuple(r) for r in con.execute("PRAGMA foreign_key_check")],
        "integrity_check": scalar(con, "PRAGMA integrity_check"),
    }
    con.close()
    return result


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("database", type=Path)
    args = parser.parse_args()
    print(json.dumps(apply(args.database), ensure_ascii=False, indent=2, sort_keys=True))


if __name__ == "__main__":
    main()
