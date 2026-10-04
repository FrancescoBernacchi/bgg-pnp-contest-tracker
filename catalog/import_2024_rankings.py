"""Importazione append-only delle liste ufficiali osservate; --apply per l'operativo."""
import argparse
import json
import sqlite3
from datetime import datetime
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
TASK = ROOT / 'tasks/2026-10-04 - BGG-A - Classifiche BGG 2024'
DATA = ROOT / 'catalog/2024-rankings-observed-2026-10-04.json'

def insert(db, rows):
    added = 0
    cols = ('contest_id','game_id','category','rank','score','vote_count','is_official','evidence_url','verified_at')
    for row in rows:
        assert db.execute('SELECT 1 FROM entries WHERE contest_id=? AND game_id=?',
                          (row['contest_id'],row['game_id'])).fetchone(), row
        values = tuple(row[c] for c in cols)
        if not db.execute('SELECT 1 FROM rankings WHERE '+ ' AND '.join(c+' IS ?' for c in cols), values).fetchone():
            db.execute('INSERT INTO rankings ('+','.join(cols)+') VALUES ('+','.join('?' for _ in cols)+')',values)
            added += 1
    tables = {r[0] for r in db.execute("SELECT name FROM sqlite_master WHERE type='table'")}
    for cid,url in sorted({(r['contest_id'],r['evidence_url']) for r in rows}):
        db.execute('INSERT OR IGNORE INTO contest_sources(contest_id,kind,url,label,is_official,first_seen_at,last_verified_at) VALUES (?,?,?,?,?,?,?)',
                   (cid,'results',url,'Risultati ufficiali 2024',1,'2026-10-04','2026-10-04'))
    if 'entry_work_observations' in tables:
        for cid in sorted({r['contest_id'] for r in rows}):
            source = next(r['evidence_url'] for r in rows if r['contest_id']==cid)
            games = {r['game_id'] for r in rows if r['contest_id']==cid}
            for eid,gid in db.execute('SELECT id,game_id FROM entries WHERE contest_id=?',(cid,)).fetchall():
                db.execute('INSERT OR IGNORE INTO entry_work_observations(entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES (?,?,?,?,?,?,?)',
                    (eid,'ranking','complete' if gid in games else 'absent','2026-10-04',source,
                     'tasks/2026-10-04 - BGG-A - Classifiche BGG 2024/CHECKS_2026-10-04.json',
                     'Confronto integrale con le liste ufficiali osservate, incluse categorie e pari merito. Assente indica assenza dalle liste pubblicate, non assenza di voti privati; nessun piazzamento inferito.'))
    assert not db.execute('PRAGMA foreign_key_check').fetchall()
    assert db.execute('PRAGMA integrity_check').fetchone()[0]=='ok'
    return added

def main():
    parser=argparse.ArgumentParser(); parser.add_argument('--apply',action='store_true'); args=parser.parse_args()
    rows=json.loads(DATA.read_text(encoding='utf-8'))
    assert len(rows)==869 and all('game_id' in r for r in rows)
    assert len({(r['contest_id'],r['game_id'],r['category'],r['rank']) for r in rows})==869
    with sqlite3.connect(ROOT/'database/pnp_collection.sqlite3') as db:
        db.execute('PRAGMA foreign_keys=ON')
        scratch=sqlite3.connect(':memory:'); db.backup(scratch)
        scratch.execute('PRAGMA foreign_keys=ON')
        added=insert(scratch,rows); assert insert(scratch,rows)==0
        result={'observations':len(rows),'new_rankings':added,'scratch_integrity':'ok','repeat_additions':0,'applied':args.apply}
        if args.apply:
            backup=ROOT/'outputs'/('rankings-2024-before-'+datetime.now().strftime('%Y%m%d-%H%M%S')+'.sqlite3')
            backup.parent.mkdir(exist_ok=True)
            with sqlite3.connect(backup) as destination:
                db.backup(destination)
                assert destination.execute('PRAGMA integrity_check').fetchone()[0]=='ok'
            with db:
                assert insert(db,rows)==added
            result['backup']=str(backup)
            result['by_contest']=[{'contest_id':cid,'entries':db.execute('SELECT COUNT(*) FROM entries WHERE contest_id=?',(cid,)).fetchone()[0],
                'ranked':db.execute('SELECT COUNT(DISTINCT game_id) FROM rankings WHERE contest_id=?',(cid,)).fetchone()[0]} for cid in sorted({r['contest_id'] for r in rows})]
            (TASK/'IMPORT_VERIFICATION.json').write_text(json.dumps(result,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
        print(json.dumps(result,ensure_ascii=False))

if __name__=='__main__': main()
