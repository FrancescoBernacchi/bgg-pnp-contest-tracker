"""TSK-0056: verifica trascrizione DOM, isolamento, integrità e idempotenza."""
import argparse,hashlib,json,sqlite3
from build_2025_two_player_materials import ROOT,TASK,DATE,EVIDENCE
from verify_2025_traditional_materials import snapshot,fnv,compact

def scope(before,after,db,ids,gids):
    affected={'entry_resource_scans','entry_material_scans','entry_material_requirements','entry_resource_mentions','remote_resources','remote_resource_observations','entry_work_observations'}
    for table in before:
        if table not in affected:assert before[table]==after[table],table
    for table in affected:
        current={r[0]:r for r in after[table]};assert all(current.get(r[0])==r for r in before[table]),table
        cols=[r[1] for r in db.execute('pragma table_info('+table+')')];oldids={r[0] for r in before[table]}
        for row in after[table]:
            if row[0] in oldids:continue
            if table=='remote_resource_observations':assert db.execute('select game_id from remote_resources where id=?',(row[cols.index('remote_resource_id')],)).fetchone()[0] in gids
            else:
                key='game_id' if table=='remote_resources' else 'entry_id'
                assert row[cols.index(key)] in (gids if key=='game_id' else ids)

def checks(db,payload):
    assert db.execute('pragma integrity_check').fetchall()==[('ok',)]
    assert not db.execute('pragma foreign_key_check').fetchall()
    assert db.execute("select count(*) from entry_work_observations where evidence_path=? and outcome='complete'",(EVIDENCE,)).fetchone()[0]==39
    assert db.execute("select count(*) from entry_work_observations where evidence_path=? and outcome='blocked'",(EVIDENCE,)).fetchone()[0]==1
    for r in payload['entries']:
        got={x[0] for x in db.execute('select rr.url from entry_resource_mentions m join remote_resources rr on rr.id=m.remote_resource_id where m.entry_id=? and m.source_url=?',(r['entry_id'],r['source_url']))}
        assert got=={x['url'] for x in r['resources']},r['entry_id']
        assert db.execute('select count(*) from entry_material_requirements where entry_id=? and source_url=?',(r['entry_id'],r['source_url'])).fetchone()[0]==len(r['requirements'])
        for table,col in [('entry_resource_scans','resource_listing_status'),('entry_material_scans','material_listing_status')]:
            assert db.execute('select '+col+' from '+table+' where entry_id=? and source_url=? and checked_at=?',(r['entry_id'],r['source_url'],DATE)).fetchone()[0]==r[col]

def main():
    ap=argparse.ArgumentParser();ap.add_argument('--apply',action='store_true');a=ap.parse_args()
    p=json.loads((TASK/'EVIDENCE.json').read_text(encoding='utf8'));w=json.loads((TASK/'DOM_WITNESS.json').read_text(encoding='utf8'))
    assert len(p['entries'])==40
    ids={r['entry_id'] for r in p['entries']};gids={r['game_id'] for r in p['entries']}
    assert [r['wip_url'].split('/thread/')[1].split('/')[0] for r in p['entries']]==w['roster_threads'][1:]
    for i,r in enumerate(p['entries']):
        assert r['entry_id']==w['entry_ids'][i]
        assert r['all_first_post_read']==(r['outcome']=='complete')
        assert fnv(compact([[x['url'],x['label_raw']] for x in r['resources']]))==w['selected_url_label_fnv'][i],('DOM links',i+1)
        assert fnv(compact([r['source_url'],r['author_raw'],r['post_timestamp_raw']]))==w['identity_fnv'][i],('DOM identity',i+1)
        assert len(r['resources'])==w['selected_links_count'][i]
    sqlpath=ROOT/'catalog/2025-two-player-materials.sql';sql=sqlpath.read_text(encoding='utf8');dbpath=ROOT/'database/pnp_collection.sqlite3'
    out=ROOT/'outputs/2025-two-player-materials';out.mkdir(parents=True,exist_ok=True)
    copy=out/'verification.sqlite3'
    with sqlite3.connect(dbpath) as src,sqlite3.connect(copy) as target:src.backup(target)
    with sqlite3.connect(copy) as target:
        before=snapshot(target);target.executescript(sql);after=snapshot(target);scope(before,after,target,ids,gids);checks(target,p)
        target.executescript(sql);assert snapshot(target)==after
    result=dict(task_id='TSK-0056',checked_at=DATE,counts=p['counts'],dom_url_label_identity_checks=40,roster_reconciled=40,copy_integrity='ok',foreign_keys='ok',idempotent=True,original_rows_preserved=True,other_contests_rankings_acquisitions_and_entries_unchanged=True,sql_sha256=hashlib.sha256(sqlpath.read_bytes()).hexdigest())
    if a.apply:
        backup=out/'before-import.sqlite3'
        assert not backup.exists(),'Backup originale esistente: non sovrascrivere'
        with sqlite3.connect(dbpath) as src,sqlite3.connect(backup) as target:src.backup(target)
        result['backup_sha256']=hashlib.sha256(backup.read_bytes()).hexdigest()
        with sqlite3.connect(dbpath) as target:
            before=snapshot(target);target.executescript(sql);after=snapshot(target);scope(before,after,target,ids,gids);checks(target,p)
        result['operational_integrity']='ok'
    (TASK/'VERIFICATION.json').write_text(json.dumps(result,ensure_ascii=False,indent=2)+'\n',encoding='utf8')
    print(json.dumps(result))
if __name__=='__main__':main()
