"""Browser locale PnP Collection. Solo lettura SQLite, nessun accesso esterno."""
from __future__ import annotations

import argparse
from contextlib import contextmanager
from datetime import datetime
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
import json
from pathlib import Path
import re
import sqlite3
import secrets
import hmac
import webbrowser
from library_catalog import library_catalog
from pdf_files import open_pdf, PDFError
from material_files import open_material, docx_blocks, DOCX
from urllib.parse import parse_qs, urlsplit

ROOT = Path(__file__).resolve().parents[1]
DEFAULT_DATABASE = ROOT / "database" / "pnp_collection.sqlite3"
STATIC = Path(__file__).resolve().parent / "static"
try:
    PDFJS_ASSETS = {name for name in json.loads((STATIC / 'vendor/pdfjs/MANIFEST.json').read_text(encoding='utf-8'))['files']
                   if re.fullmatch(r'build/pdf(?:\.worker)?\.mjs|(?:cmaps|standard_fonts|iccs|wasm)/[A-Za-z0-9_.-]+', name)
                   and '..' not in name.split('/')}
except (OSError, ValueError, KeyError):
    PDFJS_ASSETS = set()


@contextmanager
def connect(database: Path):
    # mode=ro impedisce anche la creazione accidentale di un database mancante.
    connection = sqlite3.connect(database.resolve().as_uri() + "?mode=ro", uri=True, timeout=3)
    connection.row_factory = sqlite3.Row
    try:
        connection.execute("PRAGMA query_only=ON")
        connection.execute("BEGIN")  # snapshot coerente per tutta la richiesta
        yield connection
    finally:
        connection.close()


def rows(db, query, params=()):
    return [dict(row) for row in db.execute(query, params)]


def one(db, query, params=()):
    result = rows(db, query, params)
    if not result:
        raise LookupError("Elemento non trovato nel catalogo.")
    return result[0]


def periodic(check):
    kind = check["check_kind"].lower()
    return (any(token in kind for token in ("monitor", "scheduled", "deadline", "follow_up"))
            and not any(token in kind for token in ("baseline", "census", "consistency")))


def catalog(db):
    contests = rows(db, "SELECT * FROM v_contests_monitoring_all ORDER BY year DESC, julianday(starts_at) DESC, contest_id DESC")
    sources = rows(db, "SELECT * FROM catalog_sources ORDER BY display_name COLLATE NOCASE,id")
    if any(contest for contest in contests) and not any(source["source_key"] == "boardgamegeek" for source in sources):
        sources.insert(0, {"id": None, "source_key": "boardgamegeek", "display_name": "BoardGameGeek",
                           "source_kind": "legacy_contest_catalog", "base_url": "https://boardgamegeek.com",
                           "first_seen_at": None, "last_verified_at": None,
                           "notes": "Fonte legacy rappresentata da contest ed entry; record multifonte non ancora materializzati."})
    return {
        "generated_at": datetime.now().astimezone().isoformat(timespec="seconds"),
        "contests": contests,
        "progress": progress_rows(db),
        "rankings": ranking_rows(db),
        "sources": sources,
        "games": game_rows(db),
        "entries": rows(db, """SELECT e.id,e.contest_id,e.position,e.entry_kind,e.base_game_dependency,
            e.status_raw,e.status_normalized,e.materials_status_normalized,e.last_verified_at,
            g.canonical_title,c.name AS contest_name,c.scope_type,c.year,
            EXISTS(SELECT 1 FROM entry_material_scans ems WHERE ems.entry_id=e.id) AS materials_read,
            EXISTS(SELECT 1 FROM acquisitions a JOIN acquired_files af ON af.acquisition_id=a.id
                   WHERE a.game_id=e.game_id) AS materials_downloaded,
            (SELECT group_concat(p.display_name, ', ') FROM game_credits gc
             JOIN people p ON p.id=gc.person_id WHERE gc.game_id=e.game_id) AS credits
            FROM entries e JOIN games g ON g.id=e.game_id JOIN contests c ON c.id=e.contest_id
            ORDER BY g.canonical_title COLLATE NOCASE,e.id"""),
    }


def game_rows(db):
    """Identità canoniche leggere; fonti e matching restano attributi separati."""
    games = rows(db, """SELECT g.id,g.canonical_title,g.summary,g.min_players,g.max_players,
        g.min_play_minutes,g.max_play_minutes,g.minimum_age,g.language,g.status_raw,
        g.status_normalized,g.source_url,g.first_seen_at,g.last_verified_at,
        EXISTS(SELECT 1 FROM entries e WHERE e.game_id=g.id) AS has_bgg_entry,
        (SELECT group_concat(gn.name, char(31)) FROM game_names gn
         WHERE gn.game_id=g.id AND gn.name<>g.canonical_title) AS aliases,
        (SELECT COUNT(*) FROM game_source_records gsr
         WHERE gsr.game_id=g.id AND gsr.match_status='candidate') AS candidate_count,
        (SELECT COUNT(*) FROM products p JOIN product_games pg ON pg.product_id=p.id
         WHERE pg.game_id=g.id) AS product_count,
        (SELECT COUNT(*) FROM game_implementations gi WHERE gi.game_id=g.id) AS implementation_count
        FROM games g ORDER BY g.canonical_title COLLATE NOCASE,g.id""")
    for game in games:
        game["aliases"] = game["aliases"].split(chr(31)) if game["aliases"] else []
        game["source_links"] = rows(db, """SELECT cs.source_key,cs.display_name,gsr.match_status,
            sr.id AS source_record_id,sr.record_type,sr.title_raw,sr.canonical_url,
            sr.verification_status,sr.last_verified_at
            FROM game_source_records gsr JOIN source_records sr ON sr.id=gsr.source_record_id
            JOIN catalog_sources cs ON cs.id=sr.source_id WHERE gsr.game_id=?
            ORDER BY cs.display_name COLLATE NOCASE,sr.id""", (game["id"],))
        keys = {link["source_key"] for link in game["source_links"] if link["match_status"] != "rejected"}
        if game["has_bgg_entry"]:
            keys.add("boardgamegeek")
        game["source_keys"] = sorted(keys)
    return games


def game_detail(db, game_id, library_root=ROOT / "library"):
    game = one(db, "SELECT * FROM games WHERE id=?", (game_id,))
    return {
        "local_materials": library_catalog(db, library_root, game_id),
        "game": game,
        "names": rows(db, """SELECT gn.*,sr.title_raw AS source_title,cs.source_key,cs.display_name AS source_name
            FROM game_names gn LEFT JOIN source_records sr ON sr.id=gn.source_record_id
            LEFT JOIN catalog_sources cs ON cs.id=sr.source_id WHERE gn.game_id=?
            ORDER BY gn.is_current DESC,gn.is_official DESC,gn.name COLLATE NOCASE,gn.id""", (game_id,)),
        "source_records": rows(db, """SELECT sr.*,cs.source_key,cs.display_name AS source_name,
            gsr.match_status,gsr.match_method,gsr.evidence,gsr.decided_at
            FROM game_source_records gsr JOIN source_records sr ON sr.id=gsr.source_record_id
            JOIN catalog_sources cs ON cs.id=sr.source_id WHERE gsr.game_id=?
            ORDER BY cs.display_name COLLATE NOCASE,sr.id""", (game_id,)),
        "products": rows(db, """SELECT p.*,pg.relationship_type,pg.sequence_number,pg.is_primary,
            pg.verification_status,
            (SELECT group_concat(cs.display_name, ', ') FROM product_source_records psr
             JOIN source_records sr ON sr.id=psr.source_record_id
             JOIN catalog_sources cs ON cs.id=sr.source_id WHERE psr.product_id=p.id) AS source_names
            FROM product_games pg JOIN products p ON p.id=pg.product_id
            WHERE pg.game_id=? ORDER BY pg.is_primary DESC,p.canonical_name COLLATE NOCASE,p.id""", (game_id,)),
        "resources": rows(db, """SELECT cr.*,rl.link_role,rl.is_primary,'game' AS attributed_via
            FROM resource_links rl JOIN catalog_resources cr ON cr.id=rl.resource_id WHERE rl.game_id=?
            UNION ALL
            SELECT cr.*,rl.link_role,rl.is_primary,'source_record' AS attributed_via
            FROM resource_links rl JOIN catalog_resources cr ON cr.id=rl.resource_id
            JOIN game_source_records gsr ON gsr.source_record_id=rl.source_record_id
            WHERE gsr.game_id=? AND gsr.match_status!='rejected'
            UNION ALL
            SELECT cr.*,rl.link_role,rl.is_primary,'product' AS attributed_via
            FROM resource_links rl JOIN catalog_resources cr ON cr.id=rl.resource_id
            JOIN product_games pg ON pg.product_id=rl.product_id WHERE pg.game_id=?
            ORDER BY is_primary DESC,resource_kind,id""", (game_id, game_id, game_id)),
        "implementations": rows(db, """SELECT gi.*,op.canonical_name AS platform_name,
            sr.title_raw AS declared_by_title,cs.display_name AS declared_by_source
            FROM game_implementations gi JOIN online_platforms op ON op.id=gi.platform_id
            LEFT JOIN source_records sr ON sr.id=gi.declared_by_record_id
            LEFT JOIN catalog_sources cs ON cs.id=sr.source_id WHERE gi.game_id=?
            ORDER BY op.canonical_name COLLATE NOCASE,gi.id""", (game_id,)),
        "relationships": rows(db, """SELECT gr.*,gf.canonical_title AS from_title,gt.canonical_title AS to_title
            FROM game_relationships gr JOIN games gf ON gf.id=gr.from_game_id
            JOIN games gt ON gt.id=gr.to_game_id
            WHERE gr.from_game_id=? OR gr.to_game_id=? ORDER BY gr.relationship_type,gr.from_game_id,gr.to_game_id""",
            (game_id, game_id)),
        "entries": rows(db, """SELECT e.id,e.contest_id,e.position,e.status_raw,e.status_normalized,
            c.name AS contest_name,c.year FROM entries e JOIN contests c ON c.id=e.contest_id
            WHERE e.game_id=? ORDER BY c.year DESC,c.name COLLATE NOCASE,e.id""", (game_id,)),
    }


def progress_rows(db):
    """Indicatori del cruscotto calcolati dal catalogo, senza leggere il Markdown."""
    contests = rows(db, """SELECT c.id AS contest_id,c.year,c.name AS contest_name,c.scope_type,
        c.status_normalized,c.source_url,COUNT(DISTINCT e.id) AS entry_count,
        COUNT(DISTINCT CASE WHEN e.status_normalized!='unknown' THEN e.id END) AS known_status_count,
        COUNT(DISTINCT r.category) AS ranking_category_count,
        (SELECT COUNT(DISTINCT ranked_entry.id) FROM entries ranked_entry
         WHERE ranked_entry.contest_id=c.id AND EXISTS(
             SELECT 1 FROM rankings ranked
             WHERE ranked.contest_id=c.id AND ranked.game_id=ranked_entry.game_id
         )) AS ranked_entry_count,
        COUNT(DISTINCT ems.entry_id) AS materials_read_count,
        COUNT(DISTINCT CASE WHEN af.id IS NOT NULL THEN e.id END) AS downloaded_entry_count
        FROM contests c
        LEFT JOIN entries e ON e.contest_id=c.id
        LEFT JOIN rankings r ON r.contest_id=c.id
        LEFT JOIN entry_material_scans ems ON ems.entry_id=e.id
        LEFT JOIN acquisitions a ON a.game_id=e.game_id
        LEFT JOIN acquired_files af ON af.acquisition_id=a.id
        GROUP BY c.id ORDER BY c.year DESC,c.name COLLATE NOCASE,c.id""")
    years = []
    for year in range(2026, 2007, -1):
        current = [contest for contest in contests if contest["year"] == year]
        def scope_summary(scope_type):
            scoped = [contest for contest in current if contest["scope_type"] == scope_type]
            return {
                "contest_count": len(scoped),
                "contests_with_entries_count": sum(1 for row in scoped if row["entry_count"] > 0),
                "entry_count": sum(row["entry_count"] for row in scoped),
                "ranked_entry_count": sum(row["ranked_entry_count"] for row in scoped),
                "materials_read_count": sum(row["materials_read_count"] for row in scoped),
                "downloaded_entry_count": sum(row["downloaded_entry_count"] for row in scoped),
            }
        years.append({
            "year": year,
            "contest_count": len(current),
            "contests_with_entries_count": sum(1 for row in current if row["entry_count"] > 0),
            "entry_count": sum(row["entry_count"] for row in current),
            "known_status_count": sum(row["known_status_count"] for row in current),
            "ranking_category_count": sum(row["ranking_category_count"] for row in current),
            "ranked_entry_count": sum(row["ranked_entry_count"] for row in current),
            "materials_read_count": sum(row["materials_read_count"] for row in current),
            "downloaded_entry_count": sum(row["downloaded_entry_count"] for row in current),
            "pnp_core": scope_summary("pnp_core"),
            "adjacent": scope_summary("adjacent"),
        })
    return {"years": years, "contests": contests}


def ranking_rows(db, contest_id=None, game_id=None):
    """Una riga per osservazione: niente deduplicazione o graduatorie inferite."""
    return rows(db, """SELECT r.*,g.canonical_title,c.name AS contest_name,c.year,c.scope_type,
        (SELECT group_concat(p.display_name, ', ') FROM game_credits gc
         JOIN people p ON p.id=gc.person_id WHERE gc.game_id=r.game_id) AS credits,
        (SELECT min(e.id) FROM entries e
         WHERE e.game_id=r.game_id AND e.contest_id=r.contest_id) AS entry_id
        FROM rankings r JOIN games g ON g.id=r.game_id JOIN contests c ON c.id=r.contest_id
        WHERE (? IS NULL OR r.contest_id=?) AND (? IS NULL OR r.game_id=?)
        ORDER BY c.year DESC,r.contest_id,r.category,r.rank IS NULL,r.rank,r.id""",
        (contest_id, contest_id, game_id, game_id))


def contest_detail(db, contest_id):
    contest = one(db, "SELECT * FROM v_contests_monitoring_all WHERE contest_id=?", (contest_id,))
    contest["schedule"] = one(db, """SELECT submissions_close_at,voting_opens_at,voting_closes_at
        FROM contests WHERE id=?""", (contest_id,))
    checks = rows(db, "SELECT * FROM contest_checks WHERE contest_id=? ORDER BY julianday(checked_at) DESC,id DESC", (contest_id,))
    for check in checks:
        check["periodic"] = periodic(check)
    metrics = rows(db, """SELECT * FROM contest_metric_observations WHERE contest_id=?
        ORDER BY julianday(observed_at) DESC,id DESC""", (contest_id,))
    seen = set()
    for metric in metrics:
        metric["latest"] = metric["metric_key"] not in seen
        seen.add(metric["metric_key"])
    return {
        "contest": contest, "checks": checks, "metrics": metrics,
        "phases": rows(db, "SELECT * FROM contest_phases WHERE contest_id=? ORDER BY sequence_number,id", (contest_id,)),
        "status_history": rows(db, "SELECT * FROM contest_status_history WHERE contest_id=? ORDER BY julianday(observed_at) DESC,id DESC", (contest_id,)),
        "rankings": ranking_rows(db, contest_id),
    }


def entry_detail(db, entry_id):
    entry = one(db, """SELECT e.*,g.canonical_title,g.summary,c.name AS contest_name,c.scope_type
        FROM entries e JOIN games g ON g.id=e.game_id JOIN contests c ON c.id=e.contest_id WHERE e.id=?""", (entry_id,))
    resources = rows(db, """SELECT r.*,m.label_raw,m.content_role,m.is_primary,
        m.source_url AS mention_source_url,m.first_seen_at AS mention_first_seen_at,
        m.last_seen_at AS mention_last_seen_at
        FROM entry_resource_mentions m
        JOIN remote_resources r ON r.id=m.remote_resource_id
        WHERE m.entry_id=?
        ORDER BY m.is_primary DESC,m.content_role COLLATE NOCASE,
                 COALESCE(m.label_raw,r.label,r.url) COLLATE NOCASE,r.id""", (entry_id,))
    for resource in resources:
        resource["observations"] = rows(db, """SELECT observed_at,evidence_url,
            observation_kind,availability_status,version_raw,notes
            FROM remote_resource_observations WHERE remote_resource_id=?
            ORDER BY julianday(observed_at) DESC,id DESC""", (resource["id"],))
    return {
        "entry": entry,
        "names": rows(db, "SELECT * FROM game_names WHERE game_id=? ORDER BY observed_at DESC,id DESC", (entry["game_id"],)),
        "credits": rows(db, """SELECT p.display_name,p.bgg_username,gc.role,gc.credit_raw FROM game_credits gc
            JOIN people p ON p.id=gc.person_id WHERE gc.game_id=?""", (entry["game_id"],)),
        "history": rows(db, """SELECT h.*,cc.check_kind FROM entry_status_history h
            LEFT JOIN contest_checks cc ON cc.id=h.check_id WHERE h.entry_id=?
            ORDER BY julianday(h.observed_at) DESC,h.id DESC""", (entry_id,)),
        "rankings": ranking_rows(db, entry["contest_id"], entry["game_id"]),
        "resource_scans": rows(db, """SELECT * FROM entry_resource_scans WHERE entry_id=?
            ORDER BY julianday(checked_at) DESC,id DESC""", (entry_id,)),
        "resources": resources,
        "material_scans": rows(db, """SELECT * FROM entry_material_scans WHERE entry_id=?
            ORDER BY julianday(checked_at) DESC,
                     CASE coverage_scope WHEN 'rules_integrated' THEN 0 ELSE 1 END,id DESC""", (entry_id,)),
        "materials": rows(db, """SELECT * FROM entry_material_requirements WHERE entry_id=?
            ORDER BY CASE requirement_level WHEN 'required' THEN 0 WHEN 'alternative' THEN 1
                          WHEN 'optional' THEN 2 ELSE 3 END,
                     material_kind COLLATE NOCASE,name_normalized COLLATE NOCASE,id""", (entry_id,)),
    }


# Le sole tabelle interrogabili per un confronto sono esplicitamente elencate.
SNAPSHOTS = {
    "contest": ("""SELECT h.*,c.name AS label,c.id AS entity_id FROM contest_status_history h
        JOIN contests c ON c.id=h.contest_id WHERE h.check_id=? AND c.id=? ORDER BY julianday(h.observed_at),h.id""",
        ("status_raw", "status_normalized")),
    "entries": ("""SELECT h.*,g.canonical_title AS label,e.id AS entity_id FROM entry_status_history h
        JOIN entries e ON e.id=h.entry_id JOIN games g ON g.id=e.game_id
        WHERE h.check_id=? AND e.contest_id=? ORDER BY julianday(h.observed_at),h.id""",
        ("status_raw", "status_normalized", "materials_status_raw", "materials_status_normalized", "position")),
    "metrics": ("""SELECT *,COALESCE(metric_label_raw,metric_key) AS label,metric_key AS entity_id
        FROM contest_metric_observations WHERE check_id=? AND contest_id=? ORDER BY julianday(observed_at),id""",
        ("numeric_value", "text_value", "unit", "method", "is_official")),
    "phases": ("""SELECT h.*,p.label_raw AS label,p.id AS entity_id FROM contest_phase_history h
        JOIN contest_phases p ON p.id=h.phase_id WHERE h.check_id=? AND p.contest_id=?
        ORDER BY julianday(h.observed_at),h.id""",
        ("status_raw", "status_normalized", "starts_at", "ends_at")),
}


def compare(db, contest_id, before, after):
    checks = rows(db, """SELECT * FROM contest_checks WHERE contest_id=?
        ORDER BY julianday(checked_at),id""", (contest_id,))
    available = {check["id"]: (index, check) for index, check in enumerate(checks)}
    if before not in available or after not in available:
        raise ValueError("Selezionare due rilevamenti di questo contest.")
    old_index, old = available[before]
    new_index, new = available[after]
    if old_index >= new_index or not periodic(old) or not periodic(new):
        raise ValueError("Servono due rilevamenti periodici distinti, dal precedente al successivo.")
    sections = {}
    for name, (query, fields) in SNAPSHOTS.items():
        left = {r["entity_id"]: r for r in rows(db, query, (before, contest_id))}
        right = {r["entity_id"]: r for r in rows(db, query, (after, contest_id))}
        changes = []
        for key in left.keys() & right.keys():
            delta = [{"field": field, "before": left[key][field], "after": right[key][field]}
                     for field in fields if left[key][field] != right[key][field]]
            if delta:
                changes.append({"entity_id": key, "label": right[key]["label"], "fields": delta,
                                "before_source": left[key]["source_url"], "after_source": right[key]["source_url"]})
        sections[name] = {
            "before_count": len(left), "after_count": len(right),
            "shared_count": len(left.keys() & right.keys()),
            "changes": sorted(changes, key=lambda item: str(item["label"]).casefold()),
            "only_before": [{"entity_id": key, "label": left[key]["label"]} for key in sorted(left.keys() - right.keys(), key=str)],
            "only_after": [{"entity_id": key, "label": right[key]["label"]} for key in sorted(right.keys() - left.keys(), key=str)],
        }
    return {"before": old, "after": new, "sections": sections,
            "notice": "Confronto delle sole osservazioni collegate ai controlli. La completezza non è certificata nello schema: presenza o assenza non dimostrano aggiunte o rimozioni. I titoli sono quelli correnti; i nomi storici sono nel dettaglio entry."}


class Handler(BaseHTTPRequestHandler):
    def viewer_access(self, token=False):
        host = self.headers.get('Host', '')
        if self.headers.get('Sec-Fetch-Site') != 'same-origin':
            raise PDFError(403, 'foreign_request', 'Visualizzazione disponibile solo dall’app locale.')
        origin = self.headers.get('Origin')
        if origin is not None and origin != f'http://{host}':
            raise PDFError(403, 'foreign_request', 'Origine della richiesta non autorizzata.')
        if token and not hmac.compare_digest(self.headers.get('X-PnP-Viewer', '').encode('utf-8'), self.server.viewer_token.encode('ascii')):
            raise PDFError(403, 'viewer_token', 'Sessione del visualizzatore non valida. Riaprire il documento.')

    def pdf_response(self, file_id, head=False, kind='pdf'):
        self.viewer_access(token=True)
        if self.headers.get('Range'):
            raise PDFError(416, 'range_unsupported', 'Richieste Range non supportate dal visualizzatore.')
        with connect(self.server.database) as db:
            record = one(db, 'SELECT relative_path,media_type,acquisition_status FROM acquired_files WHERE id=?', (file_id,))
        expected = {'pdf': 'application/pdf', 'png': 'image/png', 'docx': DOCX}[kind]
        if record['media_type'] != expected:
            raise PDFError(415, 'unsupported', 'Formato non corrispondente al visualizzatore.')
        with open_material(self.server.library_root, **record) as (handle, size):
            if kind == 'docx':
                self.respond(200, {'blocks': docx_blocks(handle)}, head=head)
                return
            self.send_response(200)
            self.send_header('Content-Type', expected)
            self.send_header('Content-Length', str(size))
            self.send_header('Accept-Ranges', 'none')
            self.send_header('Content-Disposition', 'attachment; filename="material.pdf"')
            self.send_header('Cache-Control', 'no-store')
            self.send_header('X-Content-Type-Options', 'nosniff')
            self.send_header('Cross-Origin-Resource-Policy', 'same-origin')
            self.send_header('Referrer-Policy', 'no-referrer')
            self.send_header('Content-Security-Policy', "sandbox; default-src 'none'; frame-ancestors 'none'")
            self.end_headers()
            if not head:
                try:
                    while chunk := handle.read(64 * 1024):
                        self.wfile.write(chunk)
                except (BrokenPipeError, ConnectionResetError, ConnectionAbortedError):
                    pass  # User cancelled loading; no write to originals or database.

    def respond(self, status, payload, content_type="application/json; charset=utf-8", head=False):
        body = json.dumps(payload, ensure_ascii=False).encode("utf-8") if isinstance(payload, (dict, list)) else payload
        self.send_response(status)
        self.send_header("Content-Type", content_type)
        self.send_header("Content-Length", str(len(body)))
        self.send_header("Cache-Control", "no-store")
        self.send_header("X-Content-Type-Options", "nosniff")
        self.send_header("Referrer-Policy", "no-referrer")
        self.send_header("Content-Security-Policy", "default-src 'self'; connect-src 'self'; img-src 'self' blob:; style-src 'self'; script-src 'self'; worker-src 'self'; font-src 'self' blob:; object-src 'none'; frame-src 'none'; frame-ancestors 'none'; base-uri 'none'; form-action 'none'")
        self.send_header('Cross-Origin-Resource-Policy', 'same-origin')
        self.end_headers()
        if not head:
            self.wfile.write(body)

    def do_GET(self):
        self.get()

    def do_HEAD(self):
        self.get(head=True)

    def get(self, head=False):
        host = self.headers.get("Host", "")
        if host not in (f"127.0.0.1:{self.server.server_port}", f"localhost:{self.server.server_port}"):
            self.respond(403, {"error": "Accesso disponibile soltanto dall'indirizzo locale."}, head=head)
            return
        path = urlsplit(self.path)
        assets = {"/": ("index.html", "text/html; charset=utf-8"),
                  "/pdf-viewer.js": ("pdf-viewer.js", "text/javascript; charset=utf-8"),
                  "/material-viewer.js": ("material-viewer.js", "text/javascript; charset=utf-8"),
                  "/app.js": ("app.js", "text/javascript; charset=utf-8"),
                  "/style.css": ("style.css", "text/css; charset=utf-8"),
                  "/favicon.svg": ("favicon.svg", "image/svg+xml")}
        try:
            vendor_name = path.path.removeprefix('/vendor/pdfjs/')
            if path.path.startswith('/vendor/pdfjs/') and vendor_name in PDFJS_ASSETS:
                mime = 'text/javascript' if vendor_name.endswith(('.js', '.mjs')) else 'application/wasm' if vendor_name.endswith('.wasm') else 'application/octet-stream'
                self.respond(200, (STATIC / 'vendor/pdfjs' / vendor_name).read_bytes(), mime, head)
                return
            if path.path in assets:
                filename, mime = assets[path.path]
                self.respond(200, (STATIC / filename).read_bytes(), mime, head)
                return
            # PDF only by registered ID, guarded session and confined handle; no generic file server.
            if path.path == '/api/viewer-session':
                self.viewer_access()
                if path.query:
                    raise PDFError(400, 'parameters', 'Parametri non validi.')
                data = {'token': self.server.viewer_token}
            elif match := re.fullmatch(r'/api/files/([1-9][0-9]*)(/(?:pdf|png|docx))?', path.path):
                self.viewer_access(token=True)
                if path.query:
                    raise PDFError(400, 'parameters', 'Parametri non validi.')
                file_id = int(match.group(1))
                if match.group(2):
                    self.pdf_response(file_id, head, match.group(2)[1:])
                    return
                with connect(self.server.database) as db:
                    game_id = one(db, 'SELECT a.game_id FROM acquired_files f JOIN acquisitions a ON a.id=f.acquisition_id WHERE f.id=?', (file_id,))['game_id']
                    data = next(f for f in library_catalog(db, self.server.library_root, game_id)['files'] if f['id'] == file_id)
            elif path.path == "/api/catalog":
                with connect(self.server.database) as db:
                    data = catalog(db)
            elif path.path == "/api/library":
                with connect(self.server.database) as db:
                    data = library_catalog(db, self.server.library_root)
            elif match := re.fullmatch(r"/api/games/([1-9][0-9]*)", path.path):
                with connect(self.server.database) as db:
                    data = game_detail(db, int(match.group(1)), self.server.library_root)
            elif match := re.fullmatch(r"/api/(contests|entries)/([1-9][0-9]*)(/compare)?", path.path):
                resource, number, comparison = match.groups()
                with connect(self.server.database) as db:
                    if comparison and resource == "contests":
                        params = parse_qs(path.query)
                        data = compare(db, int(number), int(params.get("before", [""])[0]), int(params.get("after", [""])[0]))
                    elif comparison:
                        raise LookupError()
                    else:
                        data = (contest_detail if resource == "contests" else entry_detail)(db, int(number))
            else:
                raise LookupError()
            self.respond(200, data, head=head)
        except PDFError as error:
            self.respond(error.status, {'error': error.message, 'code': error.code}, head=head)
        except (ValueError, OverflowError):
            self.respond(400, {"error": "Parametri non validi: scegliere due controlli periodici in ordine cronologico."}, head=head)
        except LookupError:
            self.respond(404, {"error": "Elemento non trovato."}, head=head)
        except (sqlite3.Error, OSError):
            self.respond(503, {"error": "Database non disponibile o schema incompatibile. Controllare il percorso e le migrazioni indicate nella guida."}, head=head)

    def do_POST(self):
        self.respond(405, {"error": "L'applicazione consente soltanto la lettura."})

    do_PUT = do_POST
    do_PATCH = do_POST
    do_DELETE = do_POST


def make_server(database, port=8765, library_root=ROOT / "library"):
    server = ThreadingHTTPServer(("127.0.0.1", port), Handler)
    server.database = Path(database)
    server.library_root = Path(library_root)
    server.viewer_token = secrets.token_urlsafe(32)
    return server


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--database", type=Path, default=DEFAULT_DATABASE)
    parser.add_argument("--port", type=int, default=8765)
    parser.add_argument("--open-browser", action="store_true", help="Apre l'app nel browser predefinito dopo l'avvio")
    args = parser.parse_args()
    if not 1 <= args.port <= 65535:
        parser.error("La porta deve essere compresa fra 1 e 65535.")
    try:
        with connect(args.database) as db:
            catalog(db)
            # Verifica anche le tabelle di dettaglio prima di dichiarare l'avvio riuscito.
            for table in ("contest_checks", "contest_phases", "contest_phase_history", "contest_status_history",
                          "contest_metric_observations", "entry_status_history", "game_names", "rankings",
                          "remote_resources", "entry_resource_scans", "entry_resource_mentions",
                          "remote_resource_observations", "entry_material_scans",
                          "entry_material_requirements"):
                db.execute(f"SELECT * FROM {table} LIMIT 0")
        server = make_server(args.database, args.port)
    except (sqlite3.Error, OSError) as error:
        parser.exit(1, f"Avvio non riuscito: {error}\nVerificare database, schema e porta (vedere app/README.md).\n")
    print(f"PnP Collection: http://127.0.0.1:{args.port} — SQLite in sola lettura. Ctrl+C per terminare.", flush=True)
    if args.open_browser:
        webbrowser.open(f"http://127.0.0.1:{args.port}")
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        pass
    finally:
        server.server_close()


if __name__ == "__main__":
    main()
