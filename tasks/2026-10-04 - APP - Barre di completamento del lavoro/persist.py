"""Formalizzazione successiva di verifiche locali; nessuna lettura esterna."""
from pathlib import Path
import json
import sqlite3
import sys
sys.path.insert(0, str(Path(__file__).resolve().parents[2]/'app'))
from server import progress_rows

ROOT = Path(__file__).resolve().parents[2]
TASK = Path(__file__).resolve().parent
DB = ROOT/'database/pnp_collection.sqlite3'
evidence = 'tasks/2026-10-04 - BGG-A - Classifiche BGG 2025/CHECKS_2026-10-04.json'
checks = json.loads((ROOT/evidence).read_text(encoding='utf-8'))
sql = ["-- APP-008: formalizzazione 2026-10-04 delle verifiche TSK-0045, data esterna preservata.", 'BEGIN IMMEDIATE;']
def quote(value):
    return "'"+str(value).replace("'", "''")+"'"

with sqlite3.connect(DB) as db:
    db.row_factory = sqlite3.Row
    original = {r[0]: db.execute('SELECT COUNT(*) FROM '+r[0]).fetchone()[0] for r in db.execute("SELECT name FROM sqlite_master WHERE type='table'").fetchall()}
    for check in checks['checks']:
        entries = list(db.execute('SELECT * FROM entries WHERE contest_id=?', (check['contest_id'],)))
        assert len(entries) == check['entries'], 'Roster variato: riconciliare prima della formalizzazione'
        ranked = {r[0] for r in db.execute('SELECT game_id FROM rankings WHERE contest_id=?', (check['contest_id'],))}
        assert sum(e['game_id'] in ranked for e in entries) == check['ranked_after']
        for entry in entries:
            outcome = 'complete' if entry['game_id'] in ranked else 'absent'
            notes = ('Formalizzazione successiva della lettura integrale delle liste ufficiali documentata da TSK-0045. '
                     'Assente significa assente dalle classifiche pubblicate verificate, non assenza di voti privati. '
                     + check.get('notes', ''))
            values = (entry['id'], 'ranking', outcome, check['verified_at'], check['source_url'], evidence, notes)
            sql.append('INSERT OR IGNORE INTO entry_work_observations(entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('+','.join(map(quote,values))+');')
    sql.append('COMMIT;')
    import_sql = '\n'.join(sql)+'\n'
    migration = (ROOT/'database/migrations/012_work_completion.sql').read_text(encoding='utf-8')
    out = ROOT/'outputs/app008'
    out.mkdir(parents=True,exist_ok=True)
    backup = out/'before.sqlite3'
    assert not backup.exists(), 'Backup esistente: non sovrascrivere'
    with sqlite3.connect(backup) as target:
        db.backup(target)
    trial = out/'trial.sqlite3'
    with sqlite3.connect(trial) as copy:
        db.backup(copy)
        copy.executescript(migration)
        copy.executescript(import_sql)
        assert copy.execute('PRAGMA integrity_check').fetchone()[0] == 'ok'
        assert not copy.execute('PRAGMA foreign_key_check').fetchall()
        for table, count in original.items():
            assert copy.execute('SELECT COUNT(*) FROM '+table).fetchone()[0] == count
        copy.row_factory=sqlite3.Row
        result=progress_rows(copy)
        year=next(y for y in result['years'] if y['year']==2025)
        assert year['pnp_core']['ranking_complete_count']==384
        assert year['pnp_core']['ranking_total']==384
        assert year['adjacent']['ranking_complete_count']==80
    (ROOT/'catalog/2026-10-04-ranking-work-observations.sql').write_text(import_sql,encoding='utf-8')
    db.executescript(migration)
    db.executescript(import_sql)
    assert db.execute('PRAGMA integrity_check').fetchone()[0]=='ok'
    assert not db.execute('PRAGMA foreign_key_check').fetchall()
    for table,count in original.items():
        assert db.execute('SELECT COUNT(*) FROM '+table).fetchone()[0]==count
    result=progress_rows(db)
    (TASK/'VERIFICATION.json').write_text(json.dumps({'date':'2026-10-04','original_table_counts_unchanged':original,'work_observations':db.execute('SELECT COUNT(*) FROM entry_work_observations').fetchone()[0], 'year_2025':next(y for y in result['years'] if y['year']==2025),'integrity':'ok','foreign_key_errors':0,'backup':str(backup.relative_to(ROOT))},ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
    print(json.dumps(next(y for y in result['years'] if y['year']==2025),ensure_ascii=False))
