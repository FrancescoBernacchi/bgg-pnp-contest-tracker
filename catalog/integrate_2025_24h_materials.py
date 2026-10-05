"""TSK-0059: serial, offline integration of five independently verified MAT SQL files."""
from __future__ import annotations
import argparse
import hashlib
import json
import sqlite3
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
TASK = ROOT / 'tasks/2026-10-05 - GPR - Censimenti materiali challenge 24h 2025 e commit'
OUT = ROOT / 'outputs/24h-2025-coordination'
SPECS = {'reveal': (296, 6), 'green': (297, 8), 'pad': (295, 5), 'patch': (299, 12), 'anks': (298, 8)}
ALLOWED = {'entry_resource_scans', 'entry_material_scans', 'entry_material_requirements',
           'entry_resource_mentions', 'remote_resources', 'remote_resource_observations',
           'entry_work_observations'}

def snapshot(db):
    return {name: db.execute(f'SELECT * FROM "{name}" ORDER BY rowid').fetchall()
            for (name,) in db.execute("SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%'")}

def check_scope(db, before, after, entry_ids, game_ids):
    assert before.keys() == after.keys(), 'Schema changed'
    changed = {}
    for table, old in before.items():
        new = after[table]
        columns = [r[1] for r in db.execute(f'PRAGMA table_info("{table}")')]
        if table == 'entries':
            assert len(old) == len(new)
            ix = columns.index('wip_thread_url')
            changes = 0
            for a, b in zip(old, new):
                assert a[:ix] + a[ix+1:] == b[:ix] + b[ix+1:]
                if a != b:
                    assert a[0] in entry_ids
                    assert a[ix] is None or a[ix] == b[ix], 'Existing WIP changed'
                    changes += 1
            if changes: changed[table] = {'updated_wip_urls': changes}
        elif table not in ALLOWED:
            assert old == new, f'Out-of-scope table changed: {table}'
        else:
            assert set(old).issubset(set(new)), f'History changed: {table}'
            additions = set(new) - set(old)
            for row in additions:
                if 'entry_id' in columns:
                    assert row[columns.index('entry_id')] in entry_ids
                elif 'game_id' in columns:
                    assert table == 'remote_resources' and row[columns.index('game_id')] in game_ids
                else:
                    assert table == 'remote_resource_observations'
                    rid = row[columns.index('remote_resource_id')]
                    assert db.execute('SELECT game_id FROM remote_resources WHERE id=?', (rid,)).fetchone()[0] in game_ids
            if additions: changed[table] = {'added': len(additions)}
    return changed

def checks(db, cid, expected):
    assert db.execute('PRAGMA integrity_check').fetchall() == [('ok',)]
    assert not db.execute('PRAGMA foreign_key_check').fetchall()
    ids = [r[0] for r in db.execute('SELECT id FROM entries WHERE contest_id=?', (cid,))]
    assert len(ids) == expected
    for eid in ids:
        for table in ['entry_resource_scans', 'entry_material_scans']:
            assert db.execute(f'SELECT count(*) FROM {table} WHERE entry_id=? AND checked_at=?', (eid, '2026-10-05')).fetchone()[0] >= 1, (table, eid)
        assert db.execute("SELECT count(*) FROM entry_work_observations WHERE entry_id=? AND phase='materials' AND observed_at=?", (eid, '2026-10-05')).fetchone()[0] >= 1, ('work observation', eid)

def api_checks(database, cid, expected):
    sys.path.insert(0, str(ROOT / 'app'))
    import server
    with server.connect(database) as db:
        ids = [r[0] for r in db.execute('SELECT id FROM entries WHERE contest_id=? ORDER BY id', (cid,))]
        assert len(ids) == expected
        for eid in ids:
            detail = server.entry_detail(db, eid)
            assert detail['entry']['contest_id'] == cid
            assert detail['resource_scans'] and detail['material_scans']
            assert len(detail['materials']) == db.execute('SELECT count(*) FROM entry_material_requirements WHERE entry_id=?', (eid,)).fetchone()[0]
            assert len(detail['resources']) == db.execute('SELECT count(*) FROM entry_resource_mentions WHERE entry_id=?', (eid,)).fetchone()[0]
        return len(ids)

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('contest', choices=SPECS)
    parser.add_argument('--apply', action='store_true')
    args = parser.parse_args()
    cid, expected = SPECS[args.contest]
    sqlpath = ROOT / f'catalog/2025-{args.contest}-materials.sql'
    sql = sqlpath.read_text(encoding='utf-8-sig')
    database = ROOT / 'database/pnp_collection.sqlite3'
    OUT.mkdir(parents=True, exist_ok=True)
    copy = OUT / f'{args.contest}-integration-test.sqlite3'
    with sqlite3.connect(database) as src, sqlite3.connect(copy) as dst:
        src.backup(dst)
    def validate(db):
        entry_ids = {r[0] for r in db.execute('SELECT id FROM entries WHERE contest_id=?', (cid,))}
        game_ids = {r[0] for r in db.execute('SELECT game_id FROM entries WHERE contest_id=?', (cid,))}
        before = snapshot(db)
        db.executescript(sql)
        after = snapshot(db)
        changed = check_scope(db, before, after, entry_ids, game_ids)
        checks(db, cid, expected)
        db.executescript(sql)
        assert snapshot(db) == after, 'Not idempotent'
        return changed
    with sqlite3.connect(copy) as db:
        changed = validate(db)
    api_count = api_checks(copy, cid, expected)
    result = dict(contest_id=cid, entries=expected, sql_sha256=hashlib.sha256(sqlpath.read_bytes()).hexdigest(),
                  integrity='ok', foreign_keys='ok', history_preserved=True, isolated=True, idempotent=True,
                  changed_tables=changed, api_entries_verified=api_count, applied=False)
    if args.apply:
        backup = OUT / f'before-{args.contest}-import.sqlite3'
        assert not backup.exists(), 'Preserve original backup; do not rerun --apply'
        with sqlite3.connect(database) as src, sqlite3.connect(backup) as dst:
            src.backup(dst)
        with sqlite3.connect(database) as db:
            assert validate(db) == changed
        assert api_checks(database, cid, expected) == expected
        result.update(applied=True, backup_path=backup.relative_to(ROOT).as_posix(),
                      backup_sha256=hashlib.sha256(backup.read_bytes()).hexdigest())
    (TASK / f'{args.contest.upper()}_INTEGRATION.json').write_text(json.dumps(result, ensure_ascii=False, indent=2) + '\n', encoding='utf8')
    print(json.dumps(result, ensure_ascii=False))

if __name__ == '__main__':
    main()
