"""Apply the 2026-09-20 Kanare-only follow-up observation, offline and idempotently."""

from __future__ import annotations

import argparse
import json
import re
import sqlite3
from pathlib import Path
from html import unescape
from urllib.parse import urlparse
from urllib.request import Request, urlopen

OBSERVED_AT = "2026-09-20"
ALLOWED_HTML_HOSTS = {"kanare-abstract.com", "kanareabstract.myshopify.com"}
PRODUCT_SLUGS = {
    "LAG":"lag", "Iago":"iago", "Estate":"estate", "Onager":"onager", "Carpniches":"carpniches",
    "Queen's Guard":"queens_guard", "Quantum Control":"quantum-control", "Comune":"comune", "Saiju":"saiju",
    "Circular Chess":"circular_chess", "Stacking Trilogy":"stacking-trilogy", "Stairs":"stairs", "Slyde":"slyde",
    "Trike":"trike", "Dryad":"dryad", "Flower Shop":"flower-shop", "heXentafl":"hexentafl",
    "Paintscape":"paintscape", "Borderland":"borderland", "Make Muster":"make-muster", "Meridians":"meridians",
    "Morris":"morris", "Lines of Fixation":"lines_of_fixation", "Ripples":"ripples", "Residuel":"residuel",
    "Whirpool":"whirlpool", "RosenKreuz":"rosenkreuz", "Volo":"volo", "Enso":"enso", "Shape Chess":"shape-chess",
    'Generic Game Discs "Color Pack" (includes 4 game rules)':"colorpack", "Generic Game Discs":"gamediscs",
    'Generic Board "Alquerq" Set':"generic-board-alquerq-set", 'Generic Board "Square" Set':"generic_board_square",
    'Generic Board "Checkered" Set':"generic_board_checkered", 'Generic Board "Parallelo" Set':"generic_board_parallelo",
    'Generic Board "Hexagonal" Set':"generic_board_hexagonal", "Special Wood Base":"woodbase", "Tori Shogi":"tori_shogi",
}

PRODUCT_NAME_MAP = {
    'Generic Game Discs "Color Pack" (includes 4 game rules)': 'Generic Game Discs “Color Pack”',
    'Generic Game Discs': 'Generic Game Discs (single discs)',
    'Generic Board "Alquerq" Set': 'Generic Board Set: Alquerq',
    'Generic Board "Square" Set': 'Generic Board Set: Square',
    'Generic Board "Checkered" Set': 'Generic Board Set: Checkered',
    'Generic Board "Parallelo" Set': 'Generic Board Set: Parallelo',
    'Generic Board "Hexagonal" Set': 'Generic Board Set: Hexagonal',
}

ONLINE = {
    "Abstract Play": ["Trike", "Slyde", "heXentafl", "Meridians", "Stairs", "Enso", "Volo", "Abande", "Attangle", "Accasta (original)", "Onager", "Shape Chess", "Estate", "Swarm (unpublished)"],
    "Ai Ai": ["Trike", "Slyde", "Make Muster", "Meridians", "Saiju", "RosenKreuz (7×7)", "Stairs", "Comune", "Estate", "Apart", "Shape Chess", "LAG", "Vault"],
    "BoardGameArena": ["Trike", "Meridians", "Carpniches"],
    "BoardSpace.net": ["Trike", "Meridians", "Volo"],
    "Ludii": ["Trike", "Slyde", "heXentafl", "Make Muster", "Saiju", "Meridians", "Flower Shop", "Paintscape", "Residuel (old rules)", "Abande"],
    "Mindsports": ["Slyde", "Meridians", "Flower Shop"],
    "Spielstein": ["Enso", "Abande", "Attangle"],
    "Tabletopia": ["Tori Shogi (no extra pieces)"],
    "The Garden Gate": ["heXentafl"],
}

PLATFORM_URLS = {
    "Abstract Play": "https://play.abstractplay.com/", "Ai Ai": "http://mrraow.com/index.php/aiai-home/",
    "BoardGameArena": "https://boardgamearena.com/", "BoardSpace.net": "https://boardspace.net/english/index.shtml",
    "Ludii": "https://ludii.games/", "Mindsports": "https://mindsports.nl/", "Spielstein": "https://spielstein.com/",
    "Tabletopia": "https://tabletopia.com/", "The Garden Gate": "https://skudpaisho.com/",
}

TITLE_TO_GAME = {
    "Accasta (original)": "Accasta Pari", "RosenKreuz (7×7)": "RosenKreuz",
    "Residuel (old rules)": "Residuel", "Tori Shogi (no extra pieces)": "Tori Shogi",
    "Swarm (unpublished)": "Swarm",
}


def language(url: str, label: str) -> str | None:
    text = f"{url} {label}".upper()
    for token, code in [("_EN", "en"), ("ENGLISH", "en"), ("_JP", "ja"), ("JAPANESE", "ja"),
                        ("_ES", "es"), ("_CN", "zh"), ("SPANISH", "es")]:
        if token in text:
            return code
    return "en" if label.strip().lower().startswith("rules") else None


def media_type(url: str) -> str:
    path = urlparse(url).path.lower()
    return "application/pdf" if path.endswith(".pdf") else "image/" + path.rsplit(".", 1)[-1].replace("jpg", "jpeg")


def fetch_html(url: str) -> tuple[str, str]:
    if urlparse(url).hostname not in ALLOWED_HTML_HOSTS:
        raise RuntimeError(f"HTML host outside allowlist: {url}")
    req = Request(url, headers={"User-Agent": "Mozilla/5.0 (compatible; PnPCollection/1.0)"})
    with urlopen(req, timeout=30) as response:
        final = response.geturl()
        if urlparse(final).hostname not in ALLOWED_HTML_HOSTS:
            raise RuntimeError(f"redirect outside allowlist: {final}")
        return final, response.read().decode("utf-8", "replace")


def attrs(html: str, tag: str, attr: str) -> list[str]:
    return [unescape(x) for x in re.findall(fr'<{tag}\b[^>]*\b{attr}=["\']([^"\']+)', html, re.I)]


def page_data(url: str, fallback_title: str) -> dict:
    final, html = fetch_html(url)
    h1 = re.search(r"<h1\b[^>]*>(.*?)</h1>", html, re.I | re.S)
    title = unescape(re.sub(r"<[^>]+>", " ", h1.group(1))).strip() if h1 else fallback_title
    links = []
    for match in re.finditer(r'<a\b[^>]*href=["\']([^"\']+)["\'][^>]*>(.*?)</a>', html, re.I | re.S):
        href = unescape(match.group(1)); label = unescape(re.sub(r"<[^>]+>", " ", match.group(2))).strip()
        if href.startswith("//"): href = "https:" + href
        if href.startswith("/"): href = "https://kanare-abstract.com" + href
        if ".pdf" in href.lower(): links.append({"url": href, "label": re.sub(r"\s+", " ", label)})
    images = []
    image_values = attrs(html, "img", "src") + attrs(html, "img", "data-src")
    image_values += [part.strip().split()[0] for value in attrs(html, "img", "srcset") for part in value.split(",") if part.strip()]
    for src in image_values:
        if src.startswith("//"): src = "https:" + src
        if src.startswith("/"): src = "https://kanare-abstract.com" + src
        if "/cdn/shop/" in src and not re.search(r"logo|SNS_|BGG_|Bodogeema|/1_2\.png|/2\.png", src, re.I):
            images.append({"url": src, "alt": None})
    return {"url": final, "title": title, "links": links, "images": images[:1], "rules": links, "image": images[0] if images else None}


def collect(cur, source_id: int) -> dict:
    products = [page_data(f"https://kanare-abstract.com/en/products/{slug}", title) for title, slug in PRODUCT_SLUGS.items()]
    pages = []
    for url, title in cur.execute("SELECT canonical_url,title_raw FROM source_records WHERE source_id=? AND record_type='game_page' ORDER BY id", (source_id,)):
        pages.append(page_data(url, title))
    fetch_html("https://kanare-abstract.com/en/pages/games_by_kanare")
    variants = [
        {"title":"Bloody Queen","url":"https://cdn.shopify.com/s/files/1/0578/3502/8664/files/QueensGuard_EN.pdf?v=1679584517"},
        {"title":"Stacking Morris","url":"https://cdn.shopify.com/s/files/1/0578/3502/8664/files/Morris_EN.pdf?v=1679584516"},
        {"title":"Custodial Pah-Tum","url":"https://cdn.shopify.com/s/files/1/0578/3502/8664/files/PahTum_EN_fixed.pdf?v=1737704333"},
        {"title":"Tori Shogi＋","url":"https://cdn.shopify.com/s/files/1/0578/3502/8664/files/ToriShogi_EN.pdf?v=1680018285"},
    ]
    return {"products": products, "game_pages": pages, "index_variants": variants}


def upsert_resource(cur, record_id: int, kind: str, url: str, label: str | None, lang: str | None, notes: str):
    cur.execute("""INSERT INTO catalog_resources
        (source_record_id,resource_kind,url,label_raw,language_code,media_type,access_type,
         availability_status,verification_status,first_seen_at,last_verified_at,notes)
        VALUES (?,?,?,?,?,?,'web','declared','declared',?,?,?)
        ON CONFLICT(url) DO UPDATE SET last_verified_at=excluded.last_verified_at""",
        (record_id, kind, url, label, lang, media_type(url), OBSERVED_AT, OBSERVED_AT, notes))
    rid = cur.execute("SELECT id FROM catalog_resources WHERE url=?", (url,)).fetchone()[0]
    if not cur.execute("SELECT 1 FROM resource_links WHERE resource_id=? AND source_record_id=? AND link_role='declared_by_record'",
                       (rid, record_id)).fetchone():
        cur.execute("""INSERT INTO resource_links
            (resource_id,source_record_id,link_role,is_primary,evidence_record_id,notes)
            VALUES (?,?,?, ?,?,?)""", (rid, record_id, "declared_by_record", int(kind == "representative_image"), record_id, notes))


def game_id(cur, title: str) -> int:
    return cur.execute("""SELECT g.id FROM games g JOIN game_source_records gsr ON gsr.game_id=g.id
        JOIN source_records sr ON sr.id=gsr.source_record_id JOIN catalog_sources cs ON cs.id=sr.source_id
        WHERE cs.source_key='kanare_abstract' AND gsr.match_status='confirmed' AND g.canonical_title=?
        ORDER BY g.id DESC LIMIT 1""", (title,)).fetchone()[0]


def enrich(path: Path) -> dict:
    con = sqlite3.connect(path)
    con.execute("PRAGMA foreign_keys=ON")
    cur = con.cursor()
    source_id = cur.execute("SELECT id FROM catalog_sources WHERE source_key='kanare_abstract'").fetchone()[0]
    data = collect(cur, source_id)
    online_record = cur.execute("SELECT id FROM source_records WHERE source_id=? AND record_type='online_play_index'", (source_id,)).fetchone()[0]
    try:
        cur.execute("BEGIN IMMEDIATE")
        for item in data["products"]:
            slug = item["url"].rstrip("/").split("/")[-1]
            raw = {"title_raw": item["title"], "og_title_raw": item.get("og_title"),
                   "representative_image_present": bool(item.get("images")),
                   "rules_languages_declared": sorted({language(x["url"], x.get("label", "")) for x in item.get("links", []) if ".pdf" in x["url"].lower()} - {None}),
                   "external_destinations_verified": False}
            cur.execute("""INSERT INTO source_records
                (source_id,record_type,native_id,canonical_url,title_raw,status_normalized,observed_at,
                 verification_status,last_verified_at,raw_metadata,notes)
                VALUES (?, 'product_page', ?, ?, ?, 'unknown', ?, 'verified', ?, ?, ?)
                ON CONFLICT(source_id,canonical_url) DO UPDATE SET title_raw=excluded.title_raw,
                  observed_at=excluded.observed_at,last_verified_at=excluded.last_verified_at,raw_metadata=excluded.raw_metadata""",
                (source_id, slug, item["url"], item["title"], OBSERVED_AT, OBSERVED_AT,
                 json.dumps(raw, ensure_ascii=False, sort_keys=True), "Kanare page observed without opening external destinations"))
            record_id = cur.execute("SELECT id FROM source_records WHERE source_id=? AND canonical_url=?", (source_id, item["url"])).fetchone()[0]
            pname = PRODUCT_NAME_MAP.get(item["title"], "Whirlpool" if item["title"] == "Whirpool" else item["title"])
            pid = cur.execute("SELECT id FROM products WHERE canonical_name=?", (pname,)).fetchone()[0]
            cur.execute("INSERT OR IGNORE INTO product_source_records VALUES (?,?,'confirmed',?,?)",
                        (pid, record_id, "Direct product page observed 2026-09-20", OBSERVED_AT))
            cur.execute("UPDATE products SET last_verified_at=? WHERE id=?", (OBSERVED_AT, pid))
            for image in item.get("images", []):
                upsert_resource(cur, record_id, "representative_image", image["url"], image.get("alt") or None, None,
                                "Image URL and dimensions observed in product-page markup; file not downloaded")
            for link in item.get("links", []):
                if ".pdf" in link["url"].lower() and link.get("label", "").strip():
                    upsert_resource(cur, record_id, "rules", link["url"], link.get("label"), language(link["url"], link.get("label", "")),
                                    "Rules link observed on product page; destination not opened")

        for item in data["game_pages"]:
            record_id = cur.execute("SELECT id FROM source_records WHERE source_id=? AND canonical_url=?", (source_id, item["url"])).fetchone()[0]
            raw = json.loads(cur.execute("SELECT raw_metadata FROM source_records WHERE id=?", (record_id,)).fetchone()[0] or "{}")
            raw.update({"page_title_raw": item["title"], "external_destinations_verified": False})
            cur.execute("UPDATE source_records SET title_raw=?,observed_at=?,last_verified_at=?,raw_metadata=? WHERE id=?",
                        (item["title"], OBSERVED_AT, OBSERVED_AT, json.dumps(raw, ensure_ascii=False, sort_keys=True), record_id))
            if item.get("image"):
                upsert_resource(cur, record_id, "representative_image", item["image"]["url"], item["image"].get("alt") or None, None,
                                "Image URL and dimensions observed in game-page markup; file not downloaded")
            for link in item.get("rules", []):
                upsert_resource(cur, record_id, "rules", link["url"], link.get("label"), language(link["url"], link.get("label", "")),
                                "Rules link observed on game page; destination not opened")

        index_record = cur.execute("SELECT id FROM source_records WHERE source_id=? AND record_type='work_index'", (source_id,)).fetchone()[0]
        for item in data["index_variants"]:
            upsert_resource(cur, index_record, "rules", item["url"], item["title"], "en",
                            "Direct rules link observed on work index; destination not opened")

        platform_ids = {}
        for name, base_url in PLATFORM_URLS.items():
            cur.execute("INSERT INTO online_platforms(canonical_name,base_url,notes) VALUES (?,?,?) ON CONFLICT(canonical_name) DO UPDATE SET base_url=excluded.base_url",
                        (name, base_url, "Named by Kanare; destination not opened"))
            platform_ids[name] = cur.execute("SELECT id FROM online_platforms WHERE canonical_name=?", (name,)).fetchone()[0]

        used = {(p, t) for p, t in cur.execute("""SELECT op.canonical_name,gi.title_raw
                    FROM game_implementations gi JOIN online_platforms op ON op.id=gi.platform_id
                    WHERE op.canonical_name <> 'Unspecified platform (Kanare declaration)'""")}
        existing = cur.execute("""SELECT gi.id,gi.title_raw FROM game_implementations gi
                    JOIN online_platforms op ON op.id=gi.platform_id
                    WHERE op.canonical_name='Unspecified platform (Kanare declaration)' ORDER BY gi.id""").fetchall()
        for iid, title_raw in existing:
            candidates = [(p, t) for p, titles in ONLINE.items() for t in titles if t == title_raw and (p, t) not in used]
            if candidates:
                p, t = candidates[0]
                cur.execute("UPDATE game_implementations SET platform_id=?,declared_by_record_id=?,verification_status='declared',last_verified_at=?,notes=? WHERE id=?",
                            (platform_ids[p], online_record, OBSERVED_AT, "Platform explicitly declared by Kanare; destination not opened", iid))
                used.add((p, t))
        for platform, titles in ONLINE.items():
            for raw_title in titles:
                if (platform, raw_title) in used:
                    continue
                canonical = TITLE_TO_GAME.get(raw_title, raw_title)
                gid = game_id(cur, canonical)
                if cur.execute("SELECT 1 FROM game_implementations WHERE game_id=? AND platform_id=? AND title_raw=?",
                               (gid, platform_ids[platform], raw_title)).fetchone():
                    continue
                cur.execute("""INSERT INTO game_implementations
                    (game_id,platform_id,implementation_url,title_raw,version_raw,availability_status,
                     declared_by_record_id,verification_status,first_seen_at,last_verified_at,notes)
                    VALUES (?,?,NULL,?,?, 'unknown',?,'declared',?,?,?)""",
                    (gid, platform_ids[platform], raw_title,
                     raw_title if raw_title != canonical else None, online_record, OBSERVED_AT, OBSERVED_AT,
                     "Platform explicitly declared by Kanare; destination not opened"))
        con.commit()
    except Exception:
        con.rollback()
        raise
    result = {
        "source_records": cur.execute("SELECT count(*) FROM source_records WHERE source_id=?", (source_id,)).fetchone()[0],
        "products": cur.execute("SELECT count(*) FROM products").fetchone()[0],
        "catalog_resources": cur.execute("SELECT count(*) FROM catalog_resources").fetchone()[0],
        "resource_links": cur.execute("SELECT count(*) FROM resource_links").fetchone()[0],
        "implementations": cur.execute("SELECT count(*) FROM game_implementations").fetchone()[0],
        "platforms": cur.execute("SELECT count(*) FROM online_platforms WHERE canonical_name <> 'Unspecified platform (Kanare declaration)'").fetchone()[0],
    }
    con.close()
    return result


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("database", type=Path)
    args = parser.parse_args()
    print(json.dumps(enrich(args.database), ensure_ascii=False, indent=2, sort_keys=True))


if __name__ == "__main__":
    main()
