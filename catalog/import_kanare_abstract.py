"""Import the documented 2026-09-20 Kanare_Abstract census.

This importer is deliberately offline.  Its constants are transcribed only from
sources/KANARE-ABSTRACT-TITLE-CENSUS.md; it does not fetch or verify any URL.
Run it only after migration 009 is present.  The import is atomic and refuses
to run when the Kanare source already exists.
"""

from __future__ import annotations

import argparse
import json
import sqlite3
from pathlib import Path


OBSERVED_AT = "2026-09-20"
BASE_URL = "https://kanare-abstract.com"
INDEX_URL = f"{BASE_URL}/en/pages/games_by_kanare"
CATALOG_URL = f"{BASE_URL}/en/collections/all"
ONLINE_URL = f"{BASE_URL}/en/pages/online_play"


INDEX_GAMES = [
    ("Saiju", "saiju", "standalone", "physical_product", ["en", "ja"], True, True),
    ("Iago", "iago", "standalone", "physical_product", ["en", "ja"], True, True),
    ("Borderland", "borderland", "standalone", "physical_product", ["en", "ja"], True, True),
    ("RosenKreuz", "rosenkreuz", "standalone", "physical_product", ["en", "ja"], True, True),
    ("Lines of Fixation", "lines_of_fixation", "standalone", "physical_product", ["en", "ja"], True, True),
    ("Ripples", "ripples", "standalone", "physical_product", ["en", "ja"], True, True),
    ("Meridians", "meridians", "standalone", "physical_product", ["en", "ja"], True, True),
    ("Stairs", "stairs", "standalone", "physical_product", ["en", "ja"], True, True),
    ("Comune", "comune", "standalone", "physical_product", ["en", "ja"], True, True),
    ("Estate", "estate", "standalone", "physical_product", ["en", "ja"], True, True),
    ("ViceVeresi", "viceversi", "classic_components", "rules_only_othello_reversi", ["en"], True, True),
    ("Chess Territorial", "chess-territorial", "classic_components", "rules_only_chess", ["en"], True, True),
    ("Pentwall", "pentwall", "print_and_play", "rules_and_printable_board", ["en"], True, True),
    ("Stoic", "stoic", "common_components", "generic_board_hexagonal", ["en"], True, True),
    ("Stride", "stride", "common_components", "generic_board_hexagonal", ["en"], True, False),
    ("Squish", "squish", "common_components", "generic_board_hexagonal", ["en"], True, True),
    ("Unlace", "unlace", "common_components", "generic_board_hexagonal", ["en"], True, True),
    ("Skirt", "skirt", "common_components", "generic_board_hexagonal", ["en"], True, True),
    ("Node", "node", "common_components", "generic_board_hexagonal", ["en"], True, True),
    ("Orochi", "orochi", "common_components", "generic_board_hexagonal", ["en"], True, True),
    ("Sibling", "sibling", "common_components", "generic_board_hexagonal", ["en"], True, True),
    ("Mabi", "mabi", "common_components", "generic_board_square", ["en"], True, True),
    ("Tiptoe", "tiptoe", "common_components", "generic_board_square", ["en"], True, True),
    ("Apart", "apart", "common_components", "generic_board_square", ["en"], True, True),
    ("Zong-Heng", "zong-heng", "common_components", "generic_board_checkered", ["en"], True, True),
    ("Binary", "binary", "common_components", "generic_board_checkered", ["en"], True, True),
    ("Incorrect Checkers", "incorrect_checkers", "common_components", "generic_board_checkered", ["en"], True, True),
    ("Alquad", "alquad", "common_components", "generic_board_alquerq", ["en"], True, True),
    ("Sight", "sight", "common_components", "generic_board_alquerq", ["en"], True, True),
    ("Collapse", "collapse", "common_components", "generic_board_alquerq", ["en"], True, True),
    ("Snaketrail", "snaketrail", "common_components", "color_pack", ["en"], True, True),
    ("Nuts Sorting", "nuts_sorting", "common_components", "color_pack", ["en"], True, False),
    ("Fruits Platter", "fruits_platter", "common_components", "color_pack", ["en"], True, True),
    ("Candy Chain", "candy_chain", "common_components", "color_pack", ["en"], True, True),
]

PDF_VARIANTS = ["Bloody Queen", "Stacking Morris", "Custodial Pah-Tum", "Tori Shogi＋"]

PRODUCT_GAMES = [
    ("LAG", "lag", ["Takuro Kawasaki"], "main_game", ["en", "es", "ja"], True),
    ("Onager", "onager", ["Néstor Romeral Andrés"], "main_game", ["en", "ja"], True),
    ("Vault", "onager", ["Néstor Romeral Andrés"], "reverse_side_derived_from_onager", [], True),
    ("Carpniches", "carpniches", ["Germán Kijel"], "main_game", ["en", "es", "ja"], True),
    ("Queen's Guard", "queens_guard", ["Anthony Peacock"], "also_called_agon_or_royal_guard", ["en", "ja"], True),
    ("Quantum Control", "quantum-control", ["Néstor Romeral Andrés", "Kanare Kato"], "main_collaborative_game", ["en", "ja"], True),
    ("Quantum Leap", "quantum-control", ["Néstor Romeral Andrés"], "original_game_on_reverse", [], True),
    ("Circular Chess", "circular_chess", ["Dave Reynolds"], "traditional_modern_application", ["en", "ja"], True),
    ("Abande", "stacking-trilogy", ["Dieter Stein"], "included_in_stacking_trilogy", ["en", "ja"], True),
    ("Attangle", "stacking-trilogy", ["Dieter Stein"], "included_in_stacking_trilogy", ["en", "ja"], True),
    ("Accasta Pari", "stacking-trilogy", ["Dieter Stein"], "included_in_stacking_trilogy", ["en", "ja"], True),
    ("Slyde", "slyde", ["Mike Zapawa"], "main_game", ["en", "ja"], True),
    ("Trike", "trike", ["Alek Erickson"], "main_game", ["en", "ja"], True),
    ("Dryad", "dryad", ["Kanare Kato"], "main_game", ["en", "ja"], True),
    ("Flower Shop", "flower-shop", ["Mike Zapawa"], "main_game", ["en", "ja"], True),
    ("heXentafl", "hexentafl", ["Kevin Kane"], "main_game", ["en", "ja"], True),
    ("Paintscape", "paintscape", ["Michael Amundsen"], "main_game", ["en", "ja"], True),
    ("Make Muster", "make-muster", ["Dale Walton"], "main_game", ["en", "ja"], True),
    ("Morris", "morris", [], "traditional_family_nine_and_twelve_mens_morris", ["en", "ja"], True),
    ("Residuel", "residuel", ["Michael Amundsen"], "main_game", ["en", "ja"], True),
    ("Whirlpool", "whirlpool", ["Kanare Kato"], "page_also_uses_whirpool", ["en", "ja"], True),
    ("Volo", "volo", ["Dieter Stein"], "main_game", ["en", "ja"], True),
    ("Enso", "enso", ["Dieter Stein"], "main_game", ["en", "ja"], True),
    ("Shape Chess", "shape-chess", ["Richu"], "main_game", ["en", "ja", "zh"], True),
    ("Tori Shogi", "tori_shogi", [], "traditional_edo_game_rules_by_kanare", ["en", "ja"], True),
]

ONLINE_BASE_TITLES = [
    "Saiju", "Meridians", "RosenKreuz", "Stairs", "Comune", "Estate", "Apart",
    "Trike", "Slyde", "heXentafl", "Enso", "Volo", "Abande", "Attangle",
    "Onager", "Shape Chess", "Make Muster", "LAG", "Vault", "Carpniches",
    "Flower Shop", "Paintscape", "Residuel",
]

ONLINE_VERSION_TITLES = [
    ("Accasta Pari", "Accasta (original)", "ambiguous title retained; not treated as an alias"),
    ("RosenKreuz", "RosenKreuz (7×7)", "declared implementation/version, not a new game"),
    ("Residuel", "Residuel (old rules)", "declared implementation/version, not a new game"),
    ("Tori Shogi", "Tori Shogi (no extra pieces)", "declared implementation/version, not a new game"),
]


def page_url(slug: str) -> str:
    return f"{BASE_URL}/en/pages/{slug}"


def product_url(slug: str) -> str:
    return f"{BASE_URL}/en/products/{slug}"


def add_record(cur, source_id, record_type, native_id, url, title, raw, notes=None):
    cur.execute(
        """INSERT INTO source_records
           (source_id,record_type,native_id,canonical_url,title_raw,status_raw,
            status_normalized,observed_at,verification_status,last_verified_at,
            raw_metadata,notes)
           VALUES (?,?,?,?,?,NULL,'unknown',?,'verified',?,?,?)""",
        (source_id, record_type, native_id, url, title, OBSERVED_AT,
         OBSERVED_AT, json.dumps(raw, ensure_ascii=False, sort_keys=True), notes),
    )
    return cur.lastrowid


def add_game(cur, title, source_url, language="en", status_raw=None):
    cur.execute(
        """INSERT INTO games
           (canonical_title,language,status_raw,status_normalized,status_evidence,
            source_url,first_seen_at,last_verified_at)
           VALUES (?,?,?,'unknown',?,?,?,?)""",
        (title, language, status_raw,
         "Kanare_Abstract census observed 2026-09-20; no external verification",
         source_url, OBSERVED_AT, OBSERVED_AT),
    )
    return cur.lastrowid


def import_census(db_path: Path) -> dict[str, int]:
    con = sqlite3.connect(db_path)
    con.execute("PRAGMA foreign_keys=ON")
    cur = con.cursor()
    required = {"catalog_sources", "source_records", "products", "game_implementations"}
    present = {r[0] for r in cur.execute("SELECT name FROM sqlite_master WHERE type='table'")}
    if not required <= present:
        raise RuntimeError("migration 009 is not present")
    if cur.execute("SELECT 1 FROM catalog_sources WHERE source_key='kanare_abstract'").fetchone():
        raise RuntimeError("Kanare_Abstract has already been imported")

    try:
        cur.execute("BEGIN IMMEDIATE")
        cur.execute(
            """INSERT INTO catalog_sources
               (source_key,display_name,source_kind,base_url,first_seen_at,last_verified_at,notes)
               VALUES ('kanare_abstract','Kanare_Abstract','publisher_designer_catalog',?,?,?,?)""",
            (BASE_URL, OBSERVED_AT, OBSERVED_AT,
             "Offline import from the documented 2026-09-20 census; external destinations not checked"),
        )
        source_id = cur.lastrowid

        index_record = add_record(cur, source_id, "work_index", "games_by_kanare", INDEX_URL,
            "Kanare's Game", {"documented_title_count": 38,
            "groups": {"standalone": 10, "classic_components": 2, "print_and_play": 1,
                       "common_components": 21, "variants": 4},
            "direct_rule_pdf_titles": PDF_VARIANTS,
            "direct_rule_pdf_urls_preserved": False})
        catalog_record = add_record(cur, source_id, "product_catalog", "collections_all", CATALOG_URL,
            "All products", {"documented_product_count": 39, "pages": 3,
            "ludic_products_or_collections": 31, "generic_sets_or_accessories": 8},
            "Some products/accessories are documented only as aggregate categories; no URL was invented")
        online_record = add_record(cur, source_id, "online_play_index", "online_play", ONLINE_URL,
            "Online Play", {"destinations_verified": False, "unpublished_title": "Swarm"})

        game_ids = {}
        detail_records = {}
        for title, slug, group, form, langs, has_image, bgg_declared in INDEX_GAMES:
            url = page_url(slug)
            rec = add_record(cur, source_id, "game_page", slug, url,
                "ViceVersi" if title == "ViceVeresi" else title,
                {"index_title_raw": title, "page_title_raw": "ViceVersi" if title == "ViceVeresi" else title,
                 "group_normalized": group, "access_form_normalized": form,
                 "rules_languages_declared": langs, "representative_image_present": has_image,
                 "bgg_link_declared": bgg_declared, "external_destinations_verified": False})
            detail_records[title] = rec
            gid = add_game(cur, title, url)
            game_ids[title] = gid
            cur.execute("INSERT INTO game_source_records VALUES (?,?, 'confirmed','manual',?,?)",
                        (gid, rec, "Direct title/page relationship documented in the census", OBSERVED_AT))

        for title in PDF_VARIANTS:
            gid = add_game(cur, title, INDEX_URL)
            game_ids[title] = gid
            cur.execute("INSERT INTO game_source_records VALUES (?,?, 'confirmed','manual',?,?)",
                        (gid, index_record,
                         "Named variant in the work index; direct PDF URL not preserved in the census", OBSERVED_AT))

        product_records = {}
        for title, slug, authors, relation, langs, has_image in PRODUCT_GAMES:
            if slug not in product_records:
                represented = [r[0] for r in PRODUCT_GAMES if r[1] == slug]
                product_records[slug] = add_record(cur, source_id, "product_page", slug,
                    product_url(slug), title if len(represented) == 1 else {
                        "onager": "Onager", "quantum-control": "Quantum Control",
                        "stacking-trilogy": "Stacking Trilogy"}[slug],
                    {"games_documented": represented,
                     "rules_languages_declared": sorted({x for r in PRODUCT_GAMES if r[1] == slug for x in r[4]}),
                     "representative_image_present": True, "external_destinations_verified": False})
            rec = product_records[slug]
            gid = add_game(cur, title, product_url(slug))
            game_ids[title] = gid
            cur.execute("INSERT INTO game_source_records VALUES (?,?, 'confirmed','manual',?,?)",
                        (gid, rec, f"Product-page relationship documented as {relation}", OBSERVED_AT))

        swarm_id = add_game(cur, "Swarm", ONLINE_URL, status_raw="unpublished")
        game_ids["Swarm"] = swarm_id
        cur.execute("INSERT INTO game_source_records VALUES (?,?, 'confirmed','manual',?,?)",
                    (swarm_id, online_record,
                     "Only documented occurrence is the Online Play page; status raw is unpublished", OBSERVED_AT))

        # Exact BGG homonym: preserve a candidate relation rather than merging it.
        bgg_ripples = cur.execute(
            "SELECT id FROM games WHERE id < ? AND lower(canonical_title)=lower('Ripples') ORDER BY id",
            (min(game_ids.values()),),
        ).fetchall()
        for (existing_game_id,) in bgg_ripples:
            cur.execute("INSERT INTO game_source_records VALUES (?,?, 'candidate','exact_title',?,NULL)",
                        (existing_game_id, detail_records["Ripples"],
                         "Exact title only; BGG destination was not opened or verified"))

        # Preserve observed alternative spellings without turning them into separate games.
        aliases = [
            ("ViceVeresi", "ViceVersi", "page_title", detail_records["ViceVeresi"], page_url("viceversi")),
            ("Whirlpool", "Whirpool", "source_spelling", product_records["whirlpool"], product_url("whirlpool")),
        ]
        for game, name, kind, rec, evidence_url in aliases:
            cur.execute(
                """INSERT INTO game_names
                   (game_id,name,observed_from,observed_at,is_current,name_type,language_code,
                    script_code,is_official,source_record_id,verification_status,evidence_url,last_verified_at)
                   VALUES (?,?,?,?,0,?,'en','Latn',0,?,'declared',?,?)""",
                (game_ids[game], name, "Kanare_Abstract", OBSERVED_AT, kind, rec, evidence_url, OBSERVED_AT),
            )

        # 31 ludic products/collections: ten products corresponding to index games plus 21 product pages.
        product_ids = {}
        for title, *_ in INDEX_GAMES[:10]:
            cur.execute("INSERT INTO products VALUES (NULL,?,'physical_game_product',NULL,'unknown',?,?,?)",
                        (title, OBSERVED_AT, OBSERVED_AT,
                         "Product counted in the catalog census; individual product URL not preserved"))
            product_ids[title] = cur.lastrowid
            cur.execute("INSERT INTO product_source_records VALUES (?,?, 'confirmed',?,?)",
                        (cur.lastrowid, catalog_record, "Counted in the documented 39-product catalog", OBSERVED_AT))

        slug_product_names = {
            "lag": "LAG", "onager": "Onager", "carpniches": "Carpniches",
            "queens_guard": "Queen's Guard", "quantum-control": "Quantum Control",
            "circular_chess": "Circular Chess", "stacking-trilogy": "Stacking Trilogy",
            "slyde": "Slyde", "trike": "Trike", "dryad": "Dryad", "flower-shop": "Flower Shop",
            "hexentafl": "heXentafl", "paintscape": "Paintscape", "make-muster": "Make Muster",
            "morris": "Morris", "residuel": "Residuel", "whirlpool": "Whirlpool",
            "volo": "Volo", "enso": "Enso", "shape-chess": "Shape Chess", "tori_shogi": "Tori Shogi",
        }
        for slug, pname in slug_product_names.items():
            cur.execute("INSERT INTO products VALUES (NULL,?,'physical_game_product',NULL,'unknown',?,?,NULL)",
                        (pname, OBSERVED_AT, OBSERVED_AT))
            pid = cur.lastrowid
            product_ids[pname] = pid
            cur.execute("INSERT INTO product_source_records VALUES (?,?, 'confirmed',?,?)",
                        (pid, product_records[slug], "Direct product page documented in the census", OBSERVED_AT))

        accessory_names = [
            "Generic Game Discs “Color Pack”", "Generic Game Discs (single discs)",
            "Generic Board Set: Alquerq", "Generic Board Set: Square",
            "Generic Board Set: Checkered", "Generic Board Set: Parallelo",
            "Generic Board Set: Hexagonal", "Special Wood Base",
        ]
        for name in accessory_names:
            cur.execute("INSERT INTO products VALUES (NULL,?,'generic_accessory',NULL,'unknown',?,?,?)",
                        (name, OBSERVED_AT, OBSERVED_AT,
                         "Aggregate product label preserved from the census; individual URL not documented"))
            product_ids[name] = cur.lastrowid
            cur.execute("INSERT INTO product_source_records VALUES (?,?, 'confirmed',?,?)",
                        (cur.lastrowid, catalog_record,
                         "Included in the documented group of eight generic sets/accessories", OBSERVED_AT))

        def link_product(product, game, rel="included_game", seq=None, primary=False, rec=None, notes=None):
            cur.execute(
                "INSERT INTO product_games VALUES (?,?,?,?,?,?,?,?)",
                (product_ids[product], game_ids[game], rel, seq, int(primary), rec,
                 "declared", notes),
            )

        for title, *_ in INDEX_GAMES[:10]:
            link_product(title, title, primary=True, rec=catalog_record,
                         notes="Catalog membership documented; product detail URL unavailable in the census")

        games_by_slug = {}
        for title, slug, *_ in PRODUCT_GAMES:
            games_by_slug.setdefault(slug, []).append(title)
        for slug, titles in games_by_slug.items():
            pname = slug_product_names[slug]
            for seq, title in enumerate(titles, 1):
                link_product(pname, title, seq=seq, primary=(seq == 1), rec=product_records[slug])

        board_support = {
            "Generic Board Set: Hexagonal": ["Stoic", "Stride", "Squish", "Unlace", "Skirt", "Node", "Orochi", "Sibling"],
            "Generic Board Set: Square": ["Mabi", "Tiptoe", "Apart"],
            "Generic Board Set: Checkered": ["Zong-Heng", "Binary", "Incorrect Checkers"],
            "Generic Board Set: Alquerq": ["Alquad", "Sight", "Collapse"],
            "Generic Game Discs “Color Pack”": ["Snaketrail", "Nuts Sorting", "Fruits Platter", "Candy Chain"],
        }
        for product, titles in board_support.items():
            for title in titles:
                link_product(product, title, rel="supported_game", rec=catalog_record,
                             notes="Support relationship stated by the index group/form")

        # Only explicit, document-supported inter-game relations are imported.
        cur.execute("INSERT INTO game_relationships VALUES (?,?, 'derived_from','unknown',?,'declared',?)",
                    (game_ids["Vault"], game_ids["Onager"], product_records["onager"],
                     "Census states that Vault is derived from Onager"))
        cur.execute("INSERT INTO game_relationships VALUES (?,?, 'variant_of','unknown',?,'uncertain',?)",
                    (game_ids["Tori Shogi＋"], game_ids["Tori Shogi"], index_record,
                     "Conservative title-based relation; dependency and extra-piece requirement not verified"))

        # Online destinations are declarations only.  The census gives a platform only for Swarm.
        cur.execute("INSERT INTO online_platforms VALUES (NULL,?,?,?)",
                    ("Unspecified platform (Kanare declaration)", None,
                     "Platform name not preserved in the local census; destination not checked"))
        unspecified_platform = cur.lastrowid
        cur.execute("INSERT INTO online_platforms VALUES (NULL,?,?,?)",
                    ("Abstract Play", None, "Named by Kanare for Swarm; destination not checked"))
        abstract_play = cur.lastrowid
        for title in ONLINE_BASE_TITLES:
            cur.execute(
                """INSERT INTO game_implementations
                   (game_id,platform_id,implementation_url,title_raw,version_raw,
                    availability_status,declared_by_record_id,verification_status,
                    first_seen_at,last_verified_at,notes)
                   VALUES (?,?,?,?,?,'unknown',?,'declared',?,NULL,?)""",
                (game_ids[title], unspecified_platform, None, title, None, online_record,
                 OBSERVED_AT, "Presence declared by Online Play page; destination not verified"))
            cur.execute("INSERT OR IGNORE INTO game_source_records VALUES (?,?, 'candidate','manual',?,NULL)",
                        (game_ids[title], online_record,
                         "Online Play page names the title; platform destination not checked"))
        for game, title_raw, note in ONLINE_VERSION_TITLES:
            cur.execute(
                """INSERT INTO game_implementations
                   (game_id,platform_id,implementation_url,title_raw,version_raw,
                    availability_status,declared_by_record_id,verification_status,
                    first_seen_at,last_verified_at,notes)
                   VALUES (?,?,?,?,?,'unknown',?,'declared',?,NULL,?)""",
                (game_ids[game], unspecified_platform, None, title_raw, title_raw, online_record,
                 OBSERVED_AT, note))
            cur.execute("INSERT OR IGNORE INTO game_source_records VALUES (?,?, 'candidate','manual',?,NULL)",
                        (game_ids[game], online_record, note))
        cur.execute(
            """INSERT INTO game_implementations
               (game_id,platform_id,implementation_url,title_raw,version_raw,
                availability_status,declared_by_record_id,verification_status,
                first_seen_at,last_verified_at,notes)
               VALUES (?,?,?,?,?,'unknown',?,'declared',?,NULL,?)""",
            (swarm_id, abstract_play, None, "Swarm", "unpublished", online_record,
             OBSERVED_AT, "Author not attributed by the page; destination not verified"))

        author_games = {"Kanare Kato": [row[0] for row in INDEX_GAMES] + PDF_VARIANTS}
        for title, _slug, authors, *_ in PRODUCT_GAMES:
            for author in authors:
                author_games.setdefault(author, []).append(title)
        for person_name, titles in author_games.items():
            cur.execute("INSERT INTO people(display_name) VALUES (?)", (person_name,))
            person_id = cur.lastrowid
            cur.execute(
                """INSERT INTO person_names
                   (person_id,name,name_type,language_code,script_code,source_record_id,
                    verification_status,first_seen_at,last_verified_at)
                   VALUES (?,?,'display_name',NULL,'Latn',?,'declared',?,?)""",
                (person_id, person_name, index_record if person_name == "Kanare Kato" else catalog_record,
                 OBSERVED_AT, OBSERVED_AT),
            )
            for title in dict.fromkeys(titles):
                rec = detail_records.get(title) or product_records.get(
                    next((r[1] for r in PRODUCT_GAMES if r[0] == title), ""), catalog_record)
                role = "modern_application" if title == "Circular Chess" and person_name == "Dave Reynolds" else "designer"
                cur.execute(
                    """INSERT INTO credit_assertions
                       (person_id,game_id,role,credit_raw,evidence_record_id,
                        verification_status,observed_at,notes)
                       VALUES (?,?,?,?,?,'declared',?,?)""",
                    (person_id, game_ids[title], role, person_name, rec, OBSERVED_AT,
                     "Source declaration imported without external verification"),
                )

        # Expected scope is an invariant of this importer, not a post-hoc report.
        assert len(game_ids) == 64
        assert len(product_ids) == 39
        con.commit()
    except Exception:
        con.rollback()
        raise

    counts = {
        "catalog_sources": 1,
        "source_records": cur.execute("SELECT count(*) FROM source_records WHERE source_id=?", (source_id,)).fetchone()[0],
        "canonical_games": len(game_ids),
        "game_source_records": cur.execute(
            "SELECT count(*) FROM game_source_records gsr JOIN source_records sr ON sr.id=gsr.source_record_id WHERE sr.source_id=?",
            (source_id,),).fetchone()[0],
        "products": len(product_ids),
        "product_game_relations": cur.execute("SELECT count(*) FROM product_games").fetchone()[0],
        "game_relationships": cur.execute("SELECT count(*) FROM game_relationships").fetchone()[0],
        "aliases": len(aliases),
        "catalog_resources": cur.execute("SELECT count(*) FROM catalog_resources").fetchone()[0],
        "implementations": cur.execute("SELECT count(*) FROM game_implementations").fetchone()[0],
        "people": len(author_games),
        "credit_assertions": cur.execute("SELECT count(*) FROM credit_assertions").fetchone()[0],
    }
    con.close()
    return counts


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("database", type=Path)
    args = parser.parse_args()
    print(json.dumps(import_census(args.database), ensure_ascii=False, indent=2, sort_keys=True))


if __name__ == "__main__":
    main()
