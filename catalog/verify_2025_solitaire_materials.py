"""Confronto DOM, isolamento, integrità e idempotenza; applicazione con backup."""
import argparse
import hashlib
import json
import sqlite3
from pathlib import Path
from build_2025_solitaire_materials import ROOT,TASK,DATE,EVIDENCE,RAW,SELECT

def snapshot(db):
    return {n:db.execute('SELECT * FROM "'+n+'" ORDER BY rowid').fetchall() for (n,) in db.execute("SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%'")}
def verify_scope(before,after,db):
    ids=set(range(590,664));gids={r[0] for r in db.execute('SELECT game_id FROM entries WHERE contest_id=17')}
    affected={'entries','entry_resource_scans','entry_material_scans','entry_material_requirements','entry_resource_mentions','remote_resources','remote_resource_observations','entry_work_observations'}
    for table in before:
        if table not in affected: assert before[table]==after[table],table
    for table in affected-{'entries'}:
        current={r[0]:r for r in after[table]}
        assert all(current.get(r[0])==r for r in before[table]),('originals',table)
        cols=[r[1] for r in db.execute('PRAGMA table_info('+table+')')]
        old_ids={r[0] for r in before[table]}
        for row in after[table]:
            if row[0] in old_ids: continue
            if table=='remote_resource_observations':
                gid=db.execute('SELECT game_id FROM remote_resources WHERE id=?',(row[cols.index('remote_resource_id')],)).fetchone()[0]
                assert gid in gids
            else:
                key='game_id' if table=='remote_resources' else 'entry_id'
                assert row[cols.index(key)] in (gids if key=='game_id' else ids),(table,row)
    cols=[r[1] for r in db.execute('PRAGMA table_info(entries)')];wip=cols.index('wip_thread_url')
    assert len(before['entries'])==len(after['entries'])
    for old,new in zip(before['entries'],after['entries']):
        if old[0] not in ids: assert old==new
        else:
            assert old[:wip]+old[wip+1:]==new[:wip]+new[wip+1:]
            if old[wip] is not None: assert old[wip]==new[wip]
def checks(db,payload):
    assert db.execute('PRAGMA integrity_check').fetchall()==[('ok',)]
    assert not db.execute('PRAGMA foreign_key_check').fetchall()
    for table in ('entry_resource_scans','entry_material_scans'):
        assert db.execute('SELECT count(*) FROM '+table+' WHERE entry_id BETWEEN 590 AND 663 AND checked_at=?',(DATE,)).fetchone()[0]==74
    assert db.execute("SELECT count(*) FROM entry_work_observations WHERE entry_id BETWEEN 590 AND 663 AND phase='materials' AND outcome='complete' AND evidence_path=?",(EVIDENCE,)).fetchone()[0]==74
    for r in payload['entries']:
        urls={x['url'] for x in r['resources']}
        actual={x[0] for x in db.execute('SELECT rr.url FROM entry_resource_mentions m JOIN remote_resources rr ON rr.id=m.remote_resource_id WHERE m.entry_id=? AND m.source_url=?',(r['entry_id'],r['source_url']))}
        assert urls==actual,r['entry_id']
        assert db.execute('SELECT count(*) FROM entry_material_requirements WHERE entry_id=? AND source_url=?',(r['entry_id'],r['source_url'])).fetchone()[0]==len(r['requirements'])
    assert db.execute("SELECT count(*) FROM remote_resource_observations o JOIN remote_resources r ON r.id=o.remote_resource_id WHERE r.game_id BETWEEN 590 AND 663 AND o.observation_kind='availability_check'").fetchone()[0]==0
    assert db.execute("SELECT resource_listing_status FROM entry_resource_scans WHERE entry_id=636 AND checked_at=?",(DATE,)).fetchone()[0]=='none_declared'

def main():
    parser=argparse.ArgumentParser();parser.add_argument('--apply',action='store_true');a=parser.parse_args()
    payload=json.loads((TASK/'EVIDENCE.json').read_text(encoding='utf8'))
    capture=json.loads((TASK/'CENSUS_INPUT.json').read_text(encoding='utf8'))
    raw=json.loads(RAW.read_text(encoding='utf8')) if RAW.exists() else None
    assert len(payload['entries'])==74
    for r,x in zip(payload['entries'],capture['posts']):
        assert r['entry_id']==x['entry_id'] and x['all_first_post_read']
        witness=raw[r['position']-1] if raw else x
        actual=[[witness['links'][j]['url'],witness['links'][j]['label']] for j in SELECT[r['position']]]
        assert actual==[[l['url'],l['label_raw']] for l in r['resources']]
        for req in r['requirements']:assert req['context_raw'] in witness['text']
        assert r['source_url']==witness['postLinks'][0]
    if raw:assert hashlib.sha256(RAW.read_bytes()).hexdigest()==capture['raw_sha256']
    dbpath=ROOT/'database/pnp_collection.sqlite3';sqlpath=ROOT/'catalog/2025-solitaire-materials.sql';sql=sqlpath.read_text(encoding='utf8')
    output=ROOT/'outputs/2025-solitaire-materials';output.mkdir(parents=True,exist_ok=True)
    copy=output/'verification.sqlite3'
    with sqlite3.connect(dbpath) as src,sqlite3.connect(copy) as target: src.backup(target)
    with sqlite3.connect(copy) as target:
        before=snapshot(target);target.executescript(sql);after=snapshot(target)
        verify_scope(before,after,target);checks(target,payload)
        target.executescript(sql);assert snapshot(target)==after,'idempotence'
    result=dict(task_id='TSK-0054',checked_at=DATE,dom_url_and_label_witnesses_matched=74,raw_capture_matched=bool(raw),copy_integrity='ok',foreign_keys='ok',idempotent=True,original_rows_preserved=True,other_contests_rankings_and_acquisitions_unchanged=True,counts=payload['counts'],sql_sha256=hashlib.sha256(sqlpath.read_bytes()).hexdigest(),applied=a.apply)
    if a.apply:
        backup=output/'before-import.sqlite3';assert not backup.exists(),'Backup esistente, non sovrascrivere'
        with sqlite3.connect(dbpath) as src,sqlite3.connect(backup) as target: src.backup(target)
        result['backup_path']=backup.relative_to(ROOT).as_posix();result['backup_sha256']=hashlib.sha256(backup.read_bytes()).hexdigest()
        with sqlite3.connect(dbpath) as target:
            before=snapshot(target);target.executescript(sql);after=snapshot(target)
            verify_scope(before,after,target);checks(target,payload)
            target.executescript(sql);assert snapshot(target)==after
        result['operational_integrity']='ok';result['operational_idempotent']=True
    (TASK/'VERIFICATION.json').write_text(json.dumps(result,ensure_ascii=False,indent=2)+'\n',encoding='utf8')
    print(json.dumps(result))

if __name__=='__main__': main()
