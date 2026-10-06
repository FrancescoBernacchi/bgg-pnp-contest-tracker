"""Offline migration 013: --apply explicitly selects an existing target.

Default is read-only inspection. Creates verified backup/restore copies before DDL.
Never imports catalog records and never restores the operational target automatically.
"""
import argparse
import hashlib
import json
import sqlite3
from contextlib import contextmanager
from datetime import datetime, timezone
from pathlib import Path
from uuid import uuid4

ROOT = Path(__file__).resolve().parents[1]
MIGRATION = ROOT / 'database/migrations/013_source_evidence.sql'

@contextmanager
def open_db(path, write=False):
    db=sqlite3.connect(path.resolve().as_uri()+('?mode=rw' if write else '?mode=ro'), uri=True,timeout=5)
    try:
        db.execute('PRAGMA foreign_keys=ON')
        if not write: db.execute('PRAGMA query_only=ON')
        yield db
    finally:
        db.close()

def value(v):
    return {'blob_hex':v.hex()} if isinstance(v,bytes) else v

def inventory(db, names=None):
    objects=db.execute("SELECT type,name,tbl_name,sql FROM sqlite_master WHERE name NOT LIKE 'sqlite_%' ORDER BY type,name").fetchall()
    if names is not None: objects=[o for o in objects if o[2] in names]
    tables=[o[1] for o in objects if o[0]=='table']
    results={}
    for name in tables:
        records=[json.dumps([value(v) for v in row],ensure_ascii=False,separators=(',',':')) for row in db.execute('SELECT * FROM "'+name.replace('"','""')+'"')]
        records.sort()
        results[name]={'count':len(records),'sha256':hashlib.sha256('\n'.join(records).encode()).hexdigest()}
    return {'objects':objects,'tables':results}

def expected_objects():
    with sqlite3.connect(':memory:') as db:
        db.executescript(MIGRATION.read_text(encoding='utf8'))
        return db.execute("SELECT type,name,tbl_name,sql FROM sqlite_master WHERE name NOT LIKE 'sqlite_%' ORDER BY type,name").fetchall()

def validate(db):
    assert db.execute('PRAGMA integrity_check').fetchall()==[('ok',)]
    assert not db.execute('PRAGMA foreign_key_check').fetchall()
    if db.execute("SELECT 1 FROM sqlite_master WHERE name='source_classification_observations'").fetchone():
        assert not db.execute('SELECT c.id FROM source_classification_observations c WHERE c.segment_count<>(SELECT count(*) FROM source_classification_segments s WHERE s.classification_id=c.id)').fetchall(), 'Incomplete classification path'

def installed(db):
    expected=expected_objects()
    current={o[1]:o for o in db.execute("SELECT type,name,tbl_name,sql FROM sqlite_master WHERE name NOT LIKE 'sqlite_%'")}
    present=[o for o in expected if o[1] in current]
    if not present: return False
    if len(present)!=len(expected) or any(current[o[1]]!=o for o in expected):
        raise RuntimeError('Partial/conflicting migration 013: no changes allowed')
    return True

def statements(sql):
    buf=''
    for line in sql.splitlines(keepends=True):
        buf+=line
        if sqlite3.complete_statement(buf):
            yield buf;buf=''
    if buf.strip(): raise ValueError('Incomplete SQL statement')

def apply(path, backup_dir, authorization, fail_after=None):
    if not __debug__: raise RuntimeError('Run without Python -O: migration verification must be enabled')
    path=Path(path).resolve()
    if not authorization.strip(): raise ValueError('Explicit authorization reference required')
    with open_db(path) as ro:
        ro.execute('BEGIN')
        validate(ro)
        if installed(ro): return {'outcome':'already_applied','target':str(path),'catalog_rows_inserted':0}
        before=inventory(ro)
        old_names={o[2] for o in before['objects']}  # Include legacy views, not only tables.
        mode=ro.execute('PRAGMA journal_mode').fetchone()[0]
        backup_dir=Path(backup_dir).resolve();backup_dir.mkdir(parents=True,exist_ok=True)
        stamp=datetime.now(timezone.utc).strftime('%Y%m%dT%H%M%S%f')+'-'+uuid4().hex[:8]
        backup=backup_dir/f'013-before-{stamp}.sqlite3'
        restored=backup_dir/f'013-restore-proof-{stamp}.sqlite3'
        with sqlite3.connect(backup) as dest: ro.backup(dest)
    with open_db(backup) as snap:
        validate(snap); assert inventory(snap)==before
        with sqlite3.connect(restored) as dest: snap.backup(dest)
    with open_db(restored) as restored_db:
        validate(restored_db); assert inventory(restored_db)==before
    backup_hash=hashlib.sha256(backup.read_bytes()).hexdigest()
    migration_hash=hashlib.sha256(MIGRATION.read_bytes()).hexdigest()
    with open_db(path,write=True) as db:
        try:
            db.execute('BEGIN EXCLUSIVE')
            if inventory(db)!=before: raise RuntimeError('Target changed since backup; refusing migration')
            count=0
            for stmt in statements(MIGRATION.read_text(encoding='utf8')):
                cleaned='\n'.join(line for line in stmt.splitlines() if not line.strip().startswith('--')).strip()
                if cleaned.startswith(('PRAGMA ','BEGIN ','COMMIT')): continue
                db.execute(stmt);count+=1
                if fail_after is not None and count>=fail_after: raise RuntimeError('Synthetic migration failure')
            assert installed(db)
            validate(db)
            assert inventory(db,old_names)==before
            new_tables=[o[1] for o in expected_objects() if o[0]=='table']
            assert all(db.execute('SELECT count(*) FROM '+n).fetchone()[0]==0 for n in new_tables)
            db.commit()
        except BaseException:
            db.rollback(); raise
    with open_db(path) as db:
        validate(db);assert inventory(db,old_names)==before;assert installed(db)
    return {'outcome':'applied','target':str(path),'authorization':authorization,
            'migration_sha256':migration_hash,'journal_mode_before':mode,
            'backup_path':str(backup),'backup_sha256':backup_hash,
            'restore_proof_path':str(restored),'restore_matches_backup':True,
            'legacy_before':before,'legacy_after':before,'legacy_preserved':True,
            'new_table_count':len(new_tables),'new_tables':new_tables,'new_tables_empty':True,
            'catalog_rows_inserted':0,'integrity_check':'ok','foreign_key_check':[]}

def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--database',type=Path,required=True)
    ap.add_argument('--apply',action='store_true')
    ap.add_argument('--authorization',default='')
    ap.add_argument('--backup-dir',type=Path,default=ROOT/'outputs/source-evidence-013')
    ap.add_argument('--report',type=Path)
    args=ap.parse_args()
    if args.apply: report=apply(args.database,args.backup_dir,args.authorization)
    else:
        with open_db(args.database) as db:
            validate(db);report={'outcome':'inspection_only','installed':installed(db),'tables':inventory(db)['tables']}
    if args.report:
        args.report.parent.mkdir(parents=True,exist_ok=True)
        args.report.write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n',encoding='utf8')
    print(json.dumps({k:v for k,v in report.items() if k not in ('legacy_before','legacy_after','tables')},ensure_ascii=False))

if __name__=='__main__': main()
