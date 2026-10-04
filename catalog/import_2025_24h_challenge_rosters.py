"""Offline, repeatable import of the six browser-observed 2025 24-hour challenge rosters."""
import argparse
import json
import sqlite3
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
DATA = ROOT / 'catalog' / '2025-24h-challenge-rosters-2026-10-04.json'
DATE = '2026-10-04'
EXPECTED = {294: 6, 296: 6, 297: 8, 295: 5, 299: 12, 298: 8}


def load():
    data = json.loads(DATA.read_text(encoding='utf-8'))
    assert data['observed_at'] == DATE
    assert {c['contest_id']: len(c['rows']) for c in data['contests']} == EXPECTED
    for contest in data['contests']:
        assert [r['position'] for r in contest['rows']] == list(range(1, len(contest['rows']) + 1))
        assert len({r['title'] for r in contest['rows']}) == len(contest['rows'])
        assert contest['source'].startswith(f"https://boardgamegeek.com/thread/{contest['thread_id']}/article/")
    return data


def person_id(db, author):
    row = db.execute('SELECT id FROM people WHERE display_name=? ORDER BY id LIMIT 1', (author,)).fetchone()
    if row:
        return row[0]
    username = author[1:] if author.startswith('@') else None
    return db.execute(
        'INSERT INTO people(display_name,bgg_username) VALUES (?,?)', (author, username)
    ).lastrowid


def import_rosters(db, data):
    imported = {}
    for contest in data['contests']:
        cid, source = contest['contest_id'], contest['source']
        existing = db.execute(
            'SELECT id FROM contest_checks WHERE contest_id=? AND checked_at=? AND source_url=?',
            (cid, DATE, source),
        ).fetchone()
        if existing:
            imported[cid] = [r[0] for r in db.execute('SELECT id FROM entries WHERE contest_id=? ORDER BY position,id', (cid,))]
            continue
        assert db.execute('SELECT count(*) FROM entries WHERE contest_id=?', (cid,)).fetchone()[0] == 0, cid
        check_id = db.execute(
            'INSERT INTO contest_checks(contest_id,checked_at,source_url,check_kind,outcome,notes) VALUES (?,?,?,?,?,?)',
            (cid, DATE, source, 'manual_web_census', 'complete',
             'Roster ufficiale completo osservato nel post BGG renderizzato; classifiche, WIP e materiali esclusi.'),
        ).lastrowid
        db.execute(
            'UPDATE contests SET bgg_thread_id=?,entries_url=?,last_verified_at=? WHERE id=?',
            (contest['thread_id'], source, DATE, cid),
        )
        db.execute(
            'INSERT OR IGNORE INTO contest_sources(contest_id,kind,url,label,is_official,first_seen_at,last_verified_at) VALUES (?,?,?,?,1,?,?)',
            (cid, 'entries', source, 'Official challenge roster', DATE, DATE),
        )
        entry_ids = []
        for row in contest['rows']:
            raw = json.dumps(row, ensure_ascii=False)
            game_id = db.execute(
                'INSERT INTO games(canonical_title,status_raw,status_normalized,status_evidence,source_url,first_seen_at,last_verified_at) VALUES (?,?,?,?,?,?,?)',
                (row['title'], 'Official challenge entry', 'contest_ready',
                 'Official roster; no WIP or material analysis', source, DATE, DATE),
            ).lastrowid
            entry_id = db.execute(
                "INSERT INTO entries(contest_id,game_id,position,entry_url,entry_text_raw,status_raw,status_normalized,materials_status_normalized,first_seen_at,last_verified_at) VALUES (?,?,?,?,?,?,?,'unknown',?,?)",
                (cid, game_id, row['position'], source, raw, 'Official challenge entry', 'contest_ready', DATE, DATE),
            ).lastrowid
            entry_ids.append(entry_id)
            db.execute(
                "INSERT INTO entry_status_history(entry_id,check_id,status_raw,status_normalized,materials_status_normalized,position,observed_at,source_url,confidence,notes) VALUES (?,?,?,?,'unknown',?,?,?,'high',?)",
                (entry_id, check_id, 'Official challenge entry', 'contest_ready', row['position'], DATE, source,
                 'Roster metadata only; author preserved as declared. Rankings, WIP and materials excluded.'),
            )
            pid = person_id(db, row['author'])
            db.execute(
                'INSERT OR IGNORE INTO game_credits(game_id,person_id,role,credit_raw) VALUES (?,?,?,?)',
                (game_id, pid, 'designer', row['author']),
            )
        db.execute(
            'INSERT INTO contest_census_observations(contest_id,outcome,entry_ids_json,observed_at,source_url,evidence_path,notes) VALUES (?,?,?,?,?,?,?)',
            (cid, 'complete', json.dumps(entry_ids), DATE, source,
             'tasks/2026-09-07 - Esplorazione contest BGG 2025/TASK.md',
             'Roster ufficiale completo osservato nel browser autenticato; classifiche, WIP e materiali esclusi.'),
        )
        imported[cid] = entry_ids
    return imported


def verify(db):
    assert db.execute('PRAGMA integrity_check').fetchone()[0] == 'ok'
    assert not db.execute('PRAGMA foreign_key_check').fetchall()
    counts = dict(db.execute(
        'SELECT contest_id,count(*) FROM entries WHERE contest_id IN (294,295,296,297,298,299) GROUP BY contest_id'
    ))
    assert counts == EXPECTED, counts
    attestations = db.execute(
        "SELECT count(*) FROM contest_census_observations WHERE contest_id IN (294,295,296,297,298,299) AND outcome='complete'"
    ).fetchone()[0]
    assert attestations == 6, attestations
    assert db.execute('SELECT count(*) FROM rankings WHERE contest_id IN (294,295,296,297,298,299)').fetchone()[0] == 0
    assert db.execute('SELECT count(*) FROM entry_resource_scans WHERE entry_id IN (SELECT id FROM entries WHERE contest_id IN (294,295,296,297,298,299))').fetchone()[0] == 0
    return {
        'verified_at': DATE,
        'contests': 6,
        'entries': sum(counts.values()),
        'counts': counts,
        'complete_attestations': attestations,
        'rankings': 0,
        'resource_scans': 0,
        'integrity': 'ok',
        'foreign_key_violations': 0,
    }


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--database', type=Path, default=ROOT / 'database' / 'pnp_collection.sqlite3')
    parser.add_argument('--apply', action='store_true')
    args = parser.parse_args()
    data = load()
    with sqlite3.connect(args.database) as live:
        scratch = sqlite3.connect(':memory:')
        live.backup(scratch)
        scratch.execute('PRAGMA foreign_keys=ON')
        with scratch:
            import_rosters(scratch, data)
        result = verify(scratch)
        before = scratch.total_changes
        with scratch:
            import_rosters(scratch, data)
        assert scratch.total_changes == before, 'Import must be idempotent'
        if args.apply:
            backup = args.database.with_name(f'pnp_collection.pre-2025-24h-rosters-{DATE}.sqlite3')
            if not backup.exists():
                with sqlite3.connect(backup) as destination:
                    live.backup(destination)
            live.execute('PRAGMA foreign_keys=ON')
            with live:
                import_rosters(live, data)
            result = verify(live)
            (ROOT / 'catalog' / f'2025-24h-challenge-rosters-verification-{DATE}.json').write_text(
                json.dumps(result, indent=2) + '\n', encoding='utf-8'
            )
        print(json.dumps(result, indent=2))


if __name__ == '__main__':
    main()
