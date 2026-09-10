"""Regressioni funzionali su SQLite temporaneo e HTTP locale; nessuna rete esterna."""
import hashlib
import http.client
import json
from pathlib import Path
import sqlite3
import tempfile
import threading
import unittest

from server import ROOT, DEFAULT_DATABASE, catalog, compare, connect, contest_detail, entry_detail, make_server, periodic, ranking_rows


class ApplicationTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.database = Path(self.temp.name) / "catalogo à # test.sqlite3"
        db = sqlite3.connect(self.database)
        db.executescript((ROOT / "database/schema.sql").read_text(encoding="utf-8"))
        self.insert(db, "contests", id=1, name="Contest prova", scope_type="pnp_core")
        self.insert(db, "contests", id=2, name="Contest adiacente", scope_type="adjacent", treatment_profile="dependent_variants")
        for i in (1, 2, 3):
            self.insert(db, "games", id=i, canonical_title=f"Gioco {i}")
            self.insert(db, "entries", id=i, contest_id=1 if i < 3 else 2, game_id=i,
                        entry_url="https://boardgamegeek.com/geeklist/123", entry_kind="standalone_game" if i < 3 else "dependent_variant",
                        base_game_dependency="none" if i < 3 else "required")
        for i, kind, outcome in [(1,"manual_web_baseline","complete"), (2,"scheduled_monitor","complete"),
                                  (3,"follow_up","partial"), (4,"monitor_consistency","complete"),
                                  (5,"monitor_census","complete"), (6,"scheduled","no_change")]:
            self.insert(db, "contest_checks", id=i, contest_id=1, checked_at=f"2026-09-{i:02d}", check_kind=kind, outcome=outcome)
        self.insert(db, "contest_checks", id=7, contest_id=2, checked_at="2026-09-07", check_kind="monitor")
        for check_id, status in [(2,"development"),(3,"voting")]:
            self.insert(db, "contest_status_history", contest_id=1, check_id=check_id, status_raw=status, status_normalized=status)
        for entry_id, check_id, status in [(1,2,"wip"),(2,2,"idea"),(1,3,"playtest_ready")]:
            self.insert(db, "entry_status_history", entry_id=entry_id, check_id=check_id, status_normalized=status, status_raw=status)
        for check_id, value, official in [(2,2,1),(3,1,0)]:
            self.insert(db, "contest_metric_observations", contest_id=1, check_id=check_id, metric_key="entries_total", numeric_value=value, is_official=official)
        self.insert(db, "contest_phases", id=1, contest_id=1, phase_type="voting", label_raw="Voto")
        for check_id, end in [(2,"2026-09-20"),(3,"2026-09-25")]:
            self.insert(db, "contest_phase_history", phase_id=1, check_id=check_id, ends_at=end)
        db.commit()
        db.close()

    @staticmethod
    def insert(db, table, **values):
        defaults = {"source_url":"https://boardgamegeek.com/thread/123", "first_seen_at":"2026-09-01",
                    "last_verified_at":"2026-09-01", "observed_at":"2026-09-01"}
        columns = {row[1] for row in db.execute(f"PRAGMA table_info({table})")}
        values = {**{k:v for k,v in defaults.items() if k in columns}, **values}
        db.execute(f"INSERT INTO {table} ({','.join(values)}) VALUES ({','.join('?' for _ in values)})", tuple(values.values()))

    def tearDown(self):
        self.temp.cleanup()

    def test_read_only_and_no_missing_database_creation(self):
        before = hashlib.sha256(self.database.read_bytes()).hexdigest()
        with connect(self.database) as db:
            self.assertEqual(db.execute("PRAGMA query_only").fetchone()[0], 1)
            with self.assertRaises(sqlite3.OperationalError):
                db.execute("DELETE FROM entries")
            db.execute("PRAGMA query_only=OFF")
            with self.assertRaises(sqlite3.OperationalError):
                db.execute("DELETE FROM entries")
        missing = self.database.parent / "missing.sqlite3"
        with self.assertRaises(sqlite3.OperationalError):
            with connect(missing):
                pass
        self.assertFalse(missing.exists())
        self.assertEqual(before, hashlib.sha256(self.database.read_bytes()).hexdigest())

    def test_catalog_details_dependencies_and_latest_metrics(self):
        with connect(self.database) as db:
            result = catalog(db)
            self.assertEqual(len(result["contests"]), 2)
            self.assertEqual(len(result["entries"]), 3)
            self.assertEqual(entry_detail(db,3)["entry"]["base_game_dependency"], "required")
            self.assertEqual(entry_detail(db,3)["entry"]["scope_type"], "adjacent")
            detail = contest_detail(db,1)
            latest = [m for m in detail["metrics"] if m["latest"]]
            self.assertEqual(len(latest),1)
            self.assertEqual(latest[0]["numeric_value"],1)
            self.assertEqual(len(detail["metrics"]),2)  # precedente preservato
            with self.assertRaises(LookupError):
                entry_detail(db,999)

    def test_periodic_classification(self):
        for kind in ("scheduled","manual_monitor","deadline_follow_up"):
            self.assertTrue(periodic({"check_kind":kind}))
        for kind in ("baseline","monitor_baseline","scheduled_census","monitor_consistency","manual_entry_census"):
            self.assertFalse(periodic({"check_kind":kind}))

    def test_rankings_preserve_observations_nulls_credits_and_entry_links(self):
        db = sqlite3.connect(self.database)
        self.insert(db, "people", id=1, display_name="Autrice à")
        self.insert(db, "people", id=2, display_name="Coautore")
        for person in (1, 2):
            self.insert(db, "game_credits", game_id=1, person_id=person, role="designer")
        samples = [
            (1, 1, 1, "Overall", 1, None, None, 1),
            (2, 1, 2, "Overall", 1, 0, 0, 1),
            (3, 1, 1, "Jury Prize", None, 8.5, None, 1),
            (4, 1, 1, "Overall", 3, None, 12, 0),
            (5, 1, 1, "Overall", 2, None, None, 1),
            (6, 2, 3, "Overall", 2, None, None, 1),
            (7, 2, 1, "No entry", None, None, None, 0),
        ]
        for rid, contest, game, category, rank, score, votes, official in samples:
            self.insert(db, "rankings", id=rid, contest_id=contest, game_id=game,
                        category=category, rank=rank, score=score, vote_count=votes,
                        is_official=official, evidence_url="https://boardgamegeek.com/thread/123",
                        verified_at="2026-09-02" if rid==5 else "2026-09-01")
        db.commit(); db.close()
        before = hashlib.sha256(self.database.read_bytes()).hexdigest()
        with connect(self.database) as db:
            result = catalog(db)["rankings"]
            self.assertEqual(len(result), len(samples))
            by_id = {r["id"]:r for r in result}
            self.assertEqual(by_id[1]["credits"], "Autrice à, Coautore")
            self.assertIsNone(by_id[7]["entry_id"])
            self.assertEqual(by_id[6]["scope_type"], "adjacent")
            self.assertEqual(by_id[2]["score"], 0)
            self.assertEqual(by_id[2]["vote_count"], 0)
            self.assertIsNone(by_id[3]["rank"])
            self.assertEqual(by_id[3]["score"], 8.5)
            self.assertEqual({r["id"] for r in contest_detail(db,1)["rankings"]}, {1,2,3,4,5})
            self.assertEqual({r["id"] for r in entry_detail(db,1)["rankings"]}, {1,3,4,5})
            self.assertEqual(ranking_rows(db,999), [])
        self.assertEqual(before, hashlib.sha256(self.database.read_bytes()).hexdigest())

    @unittest.skipUnless(DEFAULT_DATABASE.exists(), "Database locale non disponibile")
    def test_real_ranking_coverage_and_integrity(self):
        before = hashlib.sha256(DEFAULT_DATABASE.read_bytes()).hexdigest()
        with connect(DEFAULT_DATABASE) as db:
            actual = catalog(db)["rankings"]
            expected = {r["id"]: dict(r) for r in db.execute("SELECT * FROM rankings")}
            self.assertEqual(len(actual), len(expected))
            for r in actual:
                self.assertEqual({k:r[k] for k in expected[r["id"]]}, expected[r["id"]])
                if r["entry_id"] is not None:
                    entry = db.execute("SELECT contest_id,game_id FROM entries WHERE id=?", (r["entry_id"],)).fetchone()
                    self.assertEqual(tuple(entry), (r["contest_id"],r["game_id"]))
            for cid in {r["contest_id"] for r in actual}:
                self.assertEqual({r["id"] for r in contest_detail(db,cid)["rankings"]},
                                 {r["id"] for r in actual if r["contest_id"]==cid})
            for eid in {r["entry_id"] for r in actual if r["entry_id"] is not None}:
                self.assertEqual({r["id"] for r in entry_detail(db,eid)["rankings"]},
                                 {r["id"] for r in actual if r["entry_id"]==eid})
        self.assertEqual(before, hashlib.sha256(DEFAULT_DATABASE.read_bytes()).hexdigest())

    def test_partial_snapshot_has_transitions_but_no_inferred_removals(self):
        with connect(self.database) as db:
            result = compare(db,1,2,3)
        entries = result["sections"]["entries"]
        self.assertEqual(entries["shared_count"],1)
        self.assertEqual(entries["only_before"],[{"entity_id":2,"label":"Gioco 2"}])
        self.assertNotIn("removed_entries",entries)
        self.assertEqual(entries["changes"][0]["fields"][1]["after"],"playtest_ready")
        self.assertEqual(len(result["sections"]["contest"]["changes"]),1)
        metric_fields = {f["field"] for f in result["sections"]["metrics"]["changes"][0]["fields"]}
        self.assertEqual(metric_fields,{"numeric_value","is_official"})
        self.assertEqual(result["sections"]["phases"]["changes"][0]["fields"][0]["after"],"2026-09-25")

    def test_empty_snapshot_does_not_certify_zero_or_no_change(self):
        with connect(self.database) as db:
            result = compare(db,1,3,6)
        entries = result["sections"]["entries"]
        self.assertEqual(entries["after_count"],0)
        self.assertEqual(entries["shared_count"],0)
        self.assertEqual(len(entries["only_before"]),1)
        self.assertIn("completezza non è certificata",result["notice"])

    def test_same_observations_have_no_field_changes(self):
        db = sqlite3.connect(self.database)
        self.insert(db,"entry_status_history",entry_id=1,check_id=6,status_normalized="playtest_ready",status_raw="playtest_ready")
        db.commit(); db.close()
        with connect(self.database) as db:
            section = compare(db,1,3,6)["sections"]["entries"]
        self.assertEqual(section["shared_count"],1)
        self.assertEqual(section["changes"],[])

    def test_reject_wrong_contest_order_or_nonperiodic_checks(self):
        with connect(self.database) as db:
            for before, after in [(1,2),(2,2),(3,2),(2,4),(2,5),(2,7),(2,999)]:
                with self.subTest(before=before,after=after), self.assertRaises(ValueError):
                    compare(db,1,before,after)

    def test_http_routes_and_isolation(self):
        server = make_server(self.database,0)
        thread = threading.Thread(target=server.serve_forever,daemon=True)
        thread.start()
        def request(path, method="GET", host=None):
            connection = http.client.HTTPConnection("127.0.0.1",server.server_port,timeout=5)
            connection.request(method,path,headers={"Host":host} if host else {})
            response = connection.getresponse()
            result = response.status,response.read(),dict(response.getheaders())
            connection.close()
            return result
        try:
            for path in ("/","/app.js","/style.css","/api/catalog","/api/contests/1","/api/entries/1","/api/contests/1/compare?before=2&after=3"):
                with self.subTest(path=path):
                    status,body,headers = request(path)
                    self.assertEqual(status,200)
                    self.assertIn("frame-ancestors 'none'",headers["Content-Security-Policy"])
                    self.assertNotIn("Access-Control-Allow-Origin",headers)
            for path in ("/database/pnp_collection.sqlite3","/library/file.pdf","/../database/schema.sql","/%2e%2e/database/schema.sql","/api/entries/999","/api/entries/1/compare"):
                self.assertEqual(request(path)[0],404)
            self.assertEqual(request("/api/contests/1/compare?before=1&after=2")[0],400)
            self.assertEqual(request("/api/contests/1/compare?before=2%20OR%201=1&after=3")[0],400)
            self.assertEqual(request("/",host="untrusted.example")[0],403)
            for method in ("POST","PUT","PATCH","DELETE"):
                self.assertEqual(request("/api/catalog",method)[0],405)
            self.assertEqual(request("/api/catalog","HEAD")[1],b"")
            self.assertEqual(len(json.loads(request("/api/catalog")[1])["entries"]),3)
            server.database = self.database.parent / "missing.sqlite3"
            self.assertEqual(request("/api/catalog")[0],503)
            self.assertFalse(server.database.exists())
        finally:
            server.shutdown(); server.server_close(); thread.join()


if __name__ == "__main__":
    unittest.main(verbosity=2)
