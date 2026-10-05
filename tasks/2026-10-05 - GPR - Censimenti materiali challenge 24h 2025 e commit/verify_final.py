"""Offline final verification: provenance, API metrics, history and excluded work."""
import hashlib
import json
import sqlite3
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
TASK = Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT / 'catalog'))
sys.path.insert(0, str(ROOT / 'app'))
import integrate_2025_24h_materials as integration
import server

def main():
    database = ROOT / 'database/pnp_collection.sqlite3'
    results = []
    all_urls = set()
    associations = requirements = 0
    with server.connect(database) as db:
        payload = server.progress_rows(db)
        progress = {r['contest_id']: r for r in payload['contests']}
        for key, (cid, expected) in integration.SPECS.items():
            title = f'2026-10-05 - MAT - 24 Hour Design Challenge {key.upper()} 2025'
            evidence_path = ROOT / 'tasks' / title / 'EVIDENCE.json'
            evidence = json.loads(evidence_path.read_text(encoding='utf-8-sig'))
            verification = json.loads((TASK / f'{key.upper()}_INTEGRATION.json').read_text(encoding='utf8'))
            assert verification['applied'] and verification['entries'] == expected
            sqlpath = ROOT / f'catalog/2025-{key}-materials.sql'
            assert verification['sql_sha256'] == hashlib.sha256(sqlpath.read_bytes()).hexdigest()
            assert len(evidence['entries']) == expected
            target_ids = {r[0] for r in db.execute('SELECT id FROM entries WHERE contest_id=?', (cid,))}
            assert {r['entry_id'] for r in evidence['entries']} == target_ids
            for row in evidence['entries']:
                eid = row['entry_id']
                source = row['source_url']
                expected_urls = {x['url'] for x in row['resources']}
                actual_urls = {r[0] for r in db.execute('SELECT r.url FROM entry_resource_mentions m JOIN remote_resources r ON r.id=m.remote_resource_id WHERE m.entry_id=? AND m.source_url=?', (eid, source))}
                assert actual_urls == expected_urls
                assert db.execute('SELECT count(*) FROM entry_material_requirements WHERE entry_id=? AND source_url=?', (eid, source)).fetchone()[0] == len(row['requirements'])
                assert db.execute("SELECT count(*) FROM entry_work_observations WHERE entry_id=? AND phase='materials' AND outcome='complete' AND evidence_path=?", (eid, evidence_path.relative_to(ROOT).as_posix())).fetchone()[0] == 1
                all_urls.update(expected_urls)
                associations += len(expected_urls)
                requirements += len(row['requirements'])
            integration.api_checks(database, cid, expected)
            assert progress[cid]['materials_complete_count'] == expected
            assert progress[cid]['materials_total'] == expected
            results.append({'contest_id': cid, 'theme': key.upper(), 'entries': expected, 'complete': expected,
                            'resources': sum(len(r['resources']) for r in evidence['entries']),
                            'requirements': sum(len(r['requirements']) for r in evidence['entries'])})
    before = ROOT / 'outputs/24h-2025-coordination/before-reveal-import.sqlite3'
    with sqlite3.connect(before) as a, sqlite3.connect(database) as b:
        ids = {r[0] for r in b.execute('SELECT id FROM entries WHERE contest_id IN (295,296,297,298,299)')}
        gids = {r[0] for r in b.execute('SELECT game_id FROM entries WHERE contest_id IN (295,296,297,298,299)')}
        changes = integration.check_scope(b, integration.snapshot(a), integration.snapshot(b), ids, gids)
        assert b.execute('PRAGMA integrity_check').fetchall() == [('ok',)]
        assert not b.execute('PRAGMA foreign_key_check').fetchall()
    result = dict(verified_at='2026-10-05', entries=39, complete=39, contests=results,
                  unique_urls=len(all_urls), game_url_associations=associations, requirements=requirements,
                  integrity='ok', foreign_keys='ok', original_history_preserved=True,
                  roster_rankings_acquisitions_files_other_contests_unchanged=True,
                  provenance_and_api_verified=39, final_materials_metrics_verified=39,
                  changed_tables=changes,
                  year_2025=next(r for r in payload['years'] if r['year']==2025))
    (TASK / 'FINAL_VERIFICATION.json').write_text(json.dumps(result, ensure_ascii=False, indent=2) + '\n', encoding='utf8')
    print(json.dumps(result, ensure_ascii=False))

if __name__ == '__main__':
    main()
