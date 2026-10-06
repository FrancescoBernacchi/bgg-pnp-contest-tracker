"""Integration acceptance on copies only; reads the operational DB through mode=ro."""
import hashlib
import argparse
import json
import sqlite3
import subprocess
import sys
from pathlib import Path
from uuid import uuid4

from apply_source_evidence_migration import ROOT, MIGRATION, apply, installed, inventory, open_db, validate

TASK=ROOT/'tasks/2026-10-06 - DAT - Schema multifonte per PerGioco'
SOURCE=ROOT/'database/pnp_collection.sqlite3'

def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()

def backup(source,target):
    with open_db(source) as src:
        src.execute('BEGIN')
        with sqlite3.connect(target) as dest:src.backup(dest)

def app_read(path):
    sys.path.insert(0,str(ROOT/'app'))
    import server
    with server.connect(path) as db:
        result={'catalog':server.catalog(db),'game_993':server.game_detail(db,993)}
        entry=db.execute('SELECT id FROM entries ORDER BY id LIMIT 1').fetchone()[0]
        contest=db.execute('SELECT id FROM contests ORDER BY id LIMIT 1').fetchone()[0]
        result['entry']=server.entry_detail(db,entry);result['contest']=server.contest_detail(db,contest)
    result['catalog'].pop('generated_at',None)
    return hashlib.sha256(json.dumps(result,sort_keys=True,ensure_ascii=False,default=str).encode()).hexdigest()

def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--baseline',type=Path,help='Existing pre-013 backup; required for acceptance replay after operational migration')
    args=parser.parse_args()
    baseline_source=args.baseline.resolve() if args.baseline else SOURCE
    with open_db(baseline_source) as baseline_db:
        if installed(baseline_db):
            raise RuntimeError('Acceptance requires a pre-013 baseline: pass --baseline PATH_TO_VERIFIED_BACKUP. Operational DB is never downgraded.')
    area=ROOT/'outputs/source-evidence-013'/('acceptance-'+uuid4().hex)
    area.mkdir(parents=True)
    source_hash=sha(SOURCE)
    app_hashes={p.relative_to(ROOT).as_posix():sha(p) for p in (ROOT/'app').rglob('*') if p.is_file() and '__pycache__' not in p.parts}
    copy=area/'migration-copy.sqlite3';backup(baseline_source,copy)
    with open_db(copy) as db:before=inventory(db);validate(db)
    old_names={o[2] for o in before['objects']}
    before_app=app_read(copy)
    report=apply(copy,area,'TSK-0077 authorized copy-only acceptance')
    with open_db(copy) as db:after=inventory(db,old_names);validate(db)
    checks={'legacy_rows_IDs_objects_exactly_preserved':before==after,
            'new_tables_empty':report['new_tables_empty'],
            'backup_and_restore_exact':report['restore_matches_backup'],
            'current_app_catalog_game_entry_contest_unchanged':before_app==app_read(copy)}
    copy_hash=sha(copy)
    second=apply(copy,area,'TSK-0077 authorized copy-only replay')
    checks['migration_replay_zero_changes']=second['outcome']=='already_applied' and sha(copy)==copy_hash
    # Error mid-DDL must roll back every table/index/trigger.
    failing=area/'rollback-copy.sqlite3';backup(baseline_source,failing)
    with open_db(failing) as db:baseline=inventory(db)
    try:apply(failing,area,'Synthetic copy-only failure',fail_after=5)
    except RuntimeError as exc:assert 'Synthetic migration failure' in str(exc)
    else:raise AssertionError('Failure injection did not fire')
    with open_db(failing) as db:
        checks['mid_migration_failure_rolls_back_all_DDL']=inventory(db)==baseline and not installed(db)
        validate(db)
    # Partial/conflicting schema must be refused, never repaired silently.
    partial=area/'conflicting-copy.sqlite3';backup(baseline_source,partial)
    with sqlite3.connect(partial) as db:db.execute('CREATE TABLE source_record_keys(id INTEGER PRIMARY KEY, wrong TEXT)')
    partial_hash=sha(partial)
    try:apply(partial,area,'Synthetic copy-only collision')
    except RuntimeError as exc:assert 'Partial/conflicting' in str(exc)
    else:raise AssertionError('Partial schema accepted')
    checks['partial_schema_refused_without_changes']=sha(partial)==partial_hash
    # Keep a WAL connection open: committed content must appear in API backup.
    wal=area/'wal-copy.sqlite3';backup(baseline_source,wal)
    with sqlite3.connect(wal) as writer:
        writer.execute('PRAGMA journal_mode=WAL');writer.execute('PRAGMA wal_autocheckpoint=0')
        writer.execute("INSERT INTO people(display_name) VALUES('Synthetic WAL backup fixture')");writer.commit()
        wal_report=apply(wal,area,'Synthetic copy-only WAL backup test')
        checks['WAL_backup_restore_legacy_preserved']=wal_report['legacy_preserved'] and wal_report['restore_matches_backup']
    # A clean installation must expose the exact same physical B-v1 objects.
    with sqlite3.connect(':memory:') as fresh:
        fresh.executescript((ROOT/'database/schema.sql').read_text(encoding='utf-8-sig'))
        checks['fresh_schema_includes_exact_013']=installed(fresh);validate(fresh)
    tests=subprocess.run([sys.executable,'-B',str(ROOT/'database/test_source_evidence_migration.py')],capture_output=True,text=True)
    checks['15_behavioral_tests_pass']=tests.returncode==0
    (TASK/'TEST_RESULTS.txt').write_text(tests.stdout+tests.stderr,encoding='utf8')
    checks['operational_DB_unchanged_during_acceptance']=source_hash==sha(SOURCE)
    checks['app_files_unchanged']=app_hashes=={p.relative_to(ROOT).as_posix():sha(p) for p in (ROOT/'app').rglob('*') if p.is_file() and '__pycache__' not in p.parts}
    result={'task_id':'TSK-0077','date':'2026-10-06','migration':'013','checks':checks,
            'copy_report':report,'WAL_backup_report':wal_report,'copy_replay':second,
            'operational_sha256_before':source_hash,'operational_sha256_after':sha(SOURCE),
            'migration_sha256':sha(MIGRATION),'app_sha256':app_hashes,
            'acceptance_baseline':str(baseline_source),'app_digest_before':before_app,'app_digest_after':app_read(copy),
            'outputs_local_only':str(area),'external_requests':0,'PerGioco_rows_imported':0,
            'limits':'Migration schema tests and synthetic evidence only; no production catalog import replay tested.'}
    (TASK/'COPY_VERIFICHE.json').write_text(json.dumps(result,ensure_ascii=False,indent=2)+'\n',encoding='utf8')
    assert all(checks.values()),checks
    print(json.dumps({'passed':len(checks),'behavioral_tests':15,'new_tables':report['new_table_count'],'operational_unchanged':True,'copy':str(copy)},ensure_ascii=False))

if __name__=='__main__':main()
