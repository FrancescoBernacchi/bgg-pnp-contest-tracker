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
from urllib.parse import parse_qs, urlsplit

ROOT = Path(__file__).resolve().parents[1]
DEFAULT_DATABASE = ROOT / "database" / "pnp_collection.sqlite3"
STATIC = Path(__file__).resolve().parent / "static"


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
    return {
        "generated_at": datetime.now().astimezone().isoformat(timespec="seconds"),
        "contests": contests,
        "entries": rows(db, """SELECT e.id,e.contest_id,e.position,e.entry_kind,e.base_game_dependency,
            e.status_raw,e.status_normalized,e.materials_status_normalized,e.last_verified_at,
            g.canonical_title,c.name AS contest_name,c.scope_type,c.year,
            (SELECT group_concat(p.display_name, ', ') FROM game_credits gc
             JOIN people p ON p.id=gc.person_id WHERE gc.game_id=e.game_id) AS credits
            FROM entries e JOIN games g ON g.id=e.game_id JOIN contests c ON c.id=e.contest_id
            ORDER BY g.canonical_title COLLATE NOCASE,e.id"""),
    }


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
        "rankings": rows(db, """SELECT r.*,g.canonical_title,e.id AS entry_id FROM rankings r
            JOIN games g ON g.id=r.game_id LEFT JOIN entries e ON e.game_id=r.game_id AND e.contest_id=r.contest_id
            WHERE r.contest_id=? ORDER BY r.category,r.rank IS NULL,r.rank,r.id""", (contest_id,)),
    }


def entry_detail(db, entry_id):
    entry = one(db, """SELECT e.*,g.canonical_title,g.summary,c.name AS contest_name,c.scope_type
        FROM entries e JOIN games g ON g.id=e.game_id JOIN contests c ON c.id=e.contest_id WHERE e.id=?""", (entry_id,))
    return {
        "entry": entry,
        "names": rows(db, "SELECT * FROM game_names WHERE game_id=? ORDER BY observed_at DESC,id DESC", (entry["game_id"],)),
        "credits": rows(db, """SELECT p.display_name,p.bgg_username,gc.role,gc.credit_raw FROM game_credits gc
            JOIN people p ON p.id=gc.person_id WHERE gc.game_id=?""", (entry["game_id"],)),
        "history": rows(db, """SELECT h.*,cc.check_kind FROM entry_status_history h
            LEFT JOIN contest_checks cc ON cc.id=h.check_id WHERE h.entry_id=?
            ORDER BY julianday(h.observed_at) DESC,h.id DESC""", (entry_id,)),
        "rankings": rows(db, "SELECT * FROM rankings WHERE contest_id=? AND game_id=? ORDER BY category,rank", (entry["contest_id"], entry["game_id"])),
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
    def respond(self, status, payload, content_type="application/json; charset=utf-8", head=False):
        body = json.dumps(payload, ensure_ascii=False).encode("utf-8") if isinstance(payload, (dict, list)) else payload
        self.send_response(status)
        self.send_header("Content-Type", content_type)
        self.send_header("Content-Length", str(len(body)))
        self.send_header("Cache-Control", "no-store")
        self.send_header("X-Content-Type-Options", "nosniff")
        self.send_header("Referrer-Policy", "no-referrer")
        self.send_header("Content-Security-Policy", "default-src 'self'; connect-src 'self'; img-src 'self'; style-src 'self'; script-src 'self'; frame-ancestors 'none'; base-uri 'none'; form-action 'none'")
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
                  "/app.js": ("app.js", "text/javascript; charset=utf-8"),
                  "/style.css": ("style.css", "text/css; charset=utf-8"),
                  "/favicon.svg": ("favicon.svg", "image/svg+xml")}
        try:
            if path.path in assets:
                filename, mime = assets[path.path]
                self.respond(200, (STATIC / filename).read_bytes(), mime, head)
                return
            # Nessun file server generico: database e library non sono esposti.
            if path.path == "/api/catalog":
                with connect(self.server.database) as db:
                    data = catalog(db)
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


def make_server(database, port=8765):
    server = ThreadingHTTPServer(("127.0.0.1", port), Handler)
    server.database = Path(database)
    return server


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--database", type=Path, default=DEFAULT_DATABASE)
    parser.add_argument("--port", type=int, default=8765)
    args = parser.parse_args()
    if not 1 <= args.port <= 65535:
        parser.error("La porta deve essere compresa fra 1 e 65535.")
    try:
        with connect(args.database) as db:
            catalog(db)
            # Verifica anche le tabelle di dettaglio prima di dichiarare l'avvio riuscito.
            for table in ("contest_checks", "contest_phases", "contest_phase_history", "contest_status_history",
                          "contest_metric_observations", "entry_status_history", "game_names", "rankings"):
                db.execute(f"SELECT * FROM {table} LIMIT 0")
        server = make_server(args.database, args.port)
    except (sqlite3.Error, OSError) as error:
        parser.exit(1, f"Avvio non riuscito: {error}\nVerificare database, schema e porta (vedere app/README.md).\n")
    print(f"PnP Collection: http://127.0.0.1:{args.port} — SQLite in sola lettura. Ctrl+C per terminare.", flush=True)
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        pass
    finally:
        server.server_close()


if __name__ == "__main__":
    main()
