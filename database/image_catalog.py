"""Offline image catalog primitives. No server, network or acquisition operations."""
import hashlib
import json
import sqlite3
from contextlib import closing, contextmanager
from datetime import datetime, timezone
from pathlib import Path
from uuid import uuid4

ROOT = Path(__file__).resolve().parents[1]
MIGRATION = ROOT / 'database/migrations/014_game_images.sql'

class Conflict(ValueError):
    """Input/target conflict: the transaction must not be committed."""

def require(condition, message):
    if not condition:
        raise Conflict(message)

def canonical(value):
    return json.dumps(value, ensure_ascii=False, sort_keys=True, separators=(',', ':'), allow_nan=False)

def digest(value):
    return hashlib.sha256(canonical(value).encode('utf8')).hexdigest()

def now():
    return datetime.now(timezone.utc).isoformat()

@contextmanager
def open_db(path, write=False):
    path = Path(path).resolve(strict=True)
    db = sqlite3.connect(path.as_uri()+('?mode=rw' if write else '?mode=ro'), uri=True, timeout=5)
    try:
        db.execute('PRAGMA foreign_keys=ON')
        if not write:
            db.execute('PRAGMA query_only=ON')
        yield db
    finally:
        db.close()

def objects(db):
    return db.execute("SELECT type,name,tbl_name,sql FROM sqlite_master WHERE name NOT LIKE 'sqlite_%' ORDER BY type,name").fetchall()

def inventory(db, names=None):
    selected = [o for o in objects(db) if names is None or o[2] in names or o[1] in names]
    tables = {}
    for _,name,_,_ in [o for o in selected if o[0]=='table']:
        rows = [canonical([{'blob':v.hex()} if isinstance(v,bytes) else v for v in row])
                for row in db.execute('SELECT * FROM "'+name.replace('"','""')+'"')]
        tables[name] = {'count':len(rows), 'sha256':hashlib.sha256('\n'.join(sorted(rows)).encode()).hexdigest()}
    return {'objects':selected, 'tables':tables}

def statements(sql):
    buffer = ''
    for line in sql.splitlines(keepends=True):
        buffer += line
        if sqlite3.complete_statement(buffer):
            yield buffer
            buffer = ''
    require(not buffer.strip(), 'Incomplete migration SQL')

def expected():
    with closing(sqlite3.connect(':memory:')) as db:
        # Referenced legacy parents need not exist to create definitions.
        db.executescript(MIGRATION.read_text(encoding='utf8'))
        return objects(db)

def installed(db):
    desired = expected()
    current = {o[1]:o for o in objects(db)}
    present = [o for o in desired if o[1] in current]
    if not present:
        return False
    require(len(present)==len(desired) and all(current[o[1]]==o for o in desired), 'Partial/conflicting migration 014')
    return True

def migrate(db):
    if installed(db):
        return False
    for stmt in statements(MIGRATION.read_text(encoding='utf8')):
        db.execute(stmt)
    require(installed(db), 'Migration definition mismatch')
    return True

def validate(db):
    require(db.execute('PRAGMA integrity_check').fetchall()==[('ok',)], 'Database integrity failure')
    require(not db.execute('PRAGMA foreign_key_check').fetchall(), 'Foreign key failure')

def legacy_names(db):
    return {o[2] for o in objects(db) if not o[1].startswith('img_')}

def backup(db, directory):
    directory = Path(directory).resolve()
    directory.mkdir(parents=True,exist_ok=True)
    stamp=datetime.now(timezone.utc).strftime('%Y%m%dT%H%M%S%f')+'-'+uuid4().hex[:8]
    path=directory/f'014-before-{stamp}.sqlite3'
    restored=directory/f'014-restore-proof-{stamp}.sqlite3'
    before=inventory(db)
    with closing(sqlite3.connect(path)) as out:
        db.backup(out)
    with open_db(path) as saved:
        validate(saved)
        require(inventory(saved)==before,'Backup mismatch')
        with closing(sqlite3.connect(restored)) as out:
            saved.backup(out)
    with open_db(restored) as restored_db:
        validate(restored_db)
        require(inventory(restored_db)==before,'Restore proof mismatch')
    return {'backup_path':str(path),'backup_sha256':hashlib.sha256(path.read_bytes()).hexdigest(),
            'restore_proof_path':str(restored),'restore_matches_backup':True}, before

def apply_migration(path, backup_dir, authorization, fail_after=None):
    require(bool(authorization.strip()),'Explicit authorization reference required')
    with open_db(path) as ro:
        ro.execute('BEGIN')
        validate(ro)
        if installed(ro):
            return {'outcome':'already_applied','legacy_preserved':True}
        evidence,before=backup(ro,backup_dir)
        names=legacy_names(ro)
    with open_db(path,True) as db:
        try:
            db.execute('BEGIN EXCLUSIVE')
            require(inventory(db)==before,'Target changed after backup')
            for index,stmt in enumerate(statements(MIGRATION.read_text(encoding='utf8')),1):
                db.execute(stmt)
                if fail_after and index>=fail_after:
                    raise Conflict('Synthetic migration failure')
            validate(db)
            require(installed(db),'Migration mismatch')
            require(inventory(db,names)==before,'Legacy changed')
            db.commit()
        except BaseException:
            db.rollback()
            raise
    return {**evidence,'outcome':'applied','legacy_preserved':True,'new_tables_empty':True,
            'migration_sha256':hashlib.sha256(MIGRATION.read_bytes()).hexdigest(),'authorization':authorization}
