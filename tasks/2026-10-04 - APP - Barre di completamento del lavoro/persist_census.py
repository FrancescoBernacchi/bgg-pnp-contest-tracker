"""Attestazione retrospettiva del solo roster 2025 esplicitamente concluso."""
from pathlib import Path
import json
import sqlite3
from contextlib import closing
root=Path(__file__).resolve().parents[2]
checks=json.loads((root/'tasks/2026-10-04 - BGG-A - Classifiche BGG 2025/CHECKS_2026-10-04.json').read_text(encoding='utf-8'))['checks']
evidence='tasks/2026-09-07 - Esplorazione contest BGG 2025/TASK.md'
sql=['-- Formalizzazione 2026-10-04 del roster concluso il 2026-09-10 in TSK-0005.', 'BEGIN IMMEDIATE;']
def quote(v):return "'"+str(v).replace("'","''")+"'"
with closing(sqlite3.connect(root/'database/pnp_collection.sqlite3')) as db:
    for check in checks:
        ids=[r[0] for r in db.execute('SELECT id FROM entries WHERE contest_id=? ORDER BY id',(check['contest_id'],))]
        assert len(ids)==check['entries']
        source=db.execute('SELECT source_url FROM contests WHERE id=?',(check['contest_id'],)).fetchone()[0]
        values=(check['contest_id'],'complete',json.dumps(ids),'2026-09-10',source,evidence,'Ricognizione conclusiva: tutti gli undici roster 2025 completi. Formalizzazione successiva 2026-10-04; challenge 24h escluse dalla verifica storica.')
        sql.append('INSERT INTO contest_census_observations(contest_id,outcome,entry_ids_json,observed_at,source_url,evidence_path,notes) VALUES ('+','.join(map(quote,values))+');')
    sql.append('COMMIT;')
    text='\n'.join(sql)+'\n'
    backup=root/'outputs/app008/before_census.sqlite3'
    assert not backup.exists()
    with closing(sqlite3.connect(backup)) as target:db.backup(target)
    with closing(sqlite3.connect(':memory:')) as trial:
        db.backup(trial)
        trial.executescript(text)
        assert trial.execute('PRAGMA integrity_check').fetchone()[0]=='ok'
        assert not trial.execute('PRAGMA foreign_key_check').fetchall()
        assert trial.execute('SELECT COUNT(*) FROM contest_census_observations').fetchone()[0]==11
    (root/'catalog/2026-10-04-census-work-observations.sql').write_text(text,encoding='utf-8')
    db.executescript(text)
    assert db.execute('PRAGMA integrity_check').fetchone()[0]=='ok'
    assert not db.execute('PRAGMA foreign_key_check').fetchall()
    print('11 attestazioni roster; provenienza TSK-0005, data storica 2026-09-10 preservata')
