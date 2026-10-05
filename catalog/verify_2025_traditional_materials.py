"""TSK-0055: verifica DOM, isolamento, idempotenza e importazione con backup."""
import argparse, hashlib, json, sqlite3
from build_2025_traditional_materials import ROOT,TASK,DATE,EVIDENCE

def snapshot(db):
    return {n:db.execute('SELECT * FROM "'+n+'" ORDER BY rowid').fetchall() for (n,) in db.execute("SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%'")}

def fnv(s):
    h=2166136261
    for ch in s:h=((h^ord(ch))*16777619)&0xffffffff
    return format(h,'08x')
def compact(value):return json.dumps(value,ensure_ascii=False,separators=(',',':'))

def scope(before,after,db):
    ids=set(range(732,774));gids={r[0] for r in db.execute('select game_id from entries where contest_id=20')}
    affected={'entries','entry_resource_scans','entry_material_scans','entry_material_requirements','entry_resource_mentions','remote_resources','remote_resource_observations','entry_work_observations'}
    for table in before:
        if table not in affected:assert before[table]==after[table],table
    for table in affected-{'entries'}:
        current={r[0]:r for r in after[table]};assert all(current.get(r[0])==r for r in before[table]),table
        cols=[r[1] for r in db.execute('pragma table_info('+table+')')];oldids={r[0] for r in before[table]}
        for row in after[table]:
            if row[0] in oldids:continue
            if table=='remote_resource_observations':assert db.execute('select game_id from remote_resources where id=?',(row[cols.index('remote_resource_id')],)).fetchone()[0] in gids
            else:
                key='game_id' if table=='remote_resources' else 'entry_id'
                assert row[cols.index(key)] in (gids if key=='game_id' else ids)
    cols=[r[1] for r in db.execute('pragma table_info(entries)')];ix=cols.index('wip_thread_url')
    assert len(before['entries'])==len(after['entries'])
    for old,new in zip(before['entries'],after['entries']):
        if old[0] not in ids:assert old==new
        else:
            assert old[:ix]+old[ix+1:]==new[:ix]+new[ix+1:]
            if old[ix] is not None:assert old[ix]==new[ix]

def checks(db,payload):
    assert db.execute('pragma integrity_check').fetchall()==[('ok',)]
    assert not db.execute('pragma foreign_key_check').fetchall()
    for table in ['entry_resource_scans','entry_material_scans']:
        assert db.execute('select count(*) from '+table+' where entry_id between 732 and 773 and checked_at=?',(DATE,)).fetchone()[0]==42
    assert db.execute("select count(*) from entry_work_observations where evidence_path=? and phase='materials' and outcome='complete'",(EVIDENCE,)).fetchone()[0]==42
    for r in payload['entries']:
        got={x[0] for x in db.execute('select rr.url from entry_resource_mentions m join remote_resources rr on rr.id=m.remote_resource_id where m.entry_id=? and m.source_url=?',(r['entry_id'],r['source_url']))}
        assert got=={x['url'] for x in r['resources']},r['entry_id']
        assert db.execute('select count(*) from entry_material_requirements where entry_id=? and source_url=?',(r['entry_id'],r['source_url'])).fetchone()[0]==len(r['requirements'])
        for table,col in [('entry_resource_scans','resource_listing_status'),('entry_material_scans','material_listing_status')]:
            assert db.execute('select '+col+' from '+table+' where entry_id=? and source_url=? and checked_at=?',(r['entry_id'],r['source_url'],DATE)).fetchone()[0]==r[col]

def main():
    ap=argparse.ArgumentParser();ap.add_argument('--apply',action='store_true');a=ap.parse_args()
    payload=json.loads((TASK/'EVIDENCE.json').read_text(encoding='utf8'));w=json.loads((TASK/'DOM_WITNESS.json').read_text(encoding='utf8'))
    assert len(payload['entries'])==42 and w['requirement_contexts_all_present']
    for i,r in enumerate(payload['entries']):
        assert r['all_first_post_read'] and r['entry_id']==w['entry_ids'][i]
        assert fnv(compact([[x['url'],x['label_raw']] for x in r['resources']]))==w['selected_url_label_fnv'][i],('DOM links',i+1)
        assert fnv(compact([r['source_url'],r['author_raw'],r['post_timestamp_raw']]))==w['identity_fnv'][i],('DOM identity',i+1)
        assert len(r['resources'])==w['selected_links_count'][i]
        contexts=list(dict.fromkeys(x['context_raw'] for x in r['requirements']))
        assert [fnv(x) for x in contexts]==w['requirement_context_fnv'].get(str(i+1),[]),('DOM contexts',i+1)
    sqlpath=ROOT/'catalog/2025-traditional-materials.sql';sql=sqlpath.read_text(encoding='utf8');dbpath=ROOT/'database/pnp_collection.sqlite3'
    out=ROOT/'outputs/2025-traditional-materials';out.mkdir(parents=True,exist_ok=True)
    copy=out/'verification.sqlite3'
    with sqlite3.connect(dbpath) as src,sqlite3.connect(copy) as target:src.backup(target)
    with sqlite3.connect(copy) as target:
        before=snapshot(target);target.executescript(sql);after=snapshot(target);scope(before,after,target);checks(target,payload)
        target.executescript(sql);assert snapshot(target)==after
    result=dict(task_id='TSK-0055',checked_at=DATE,counts=payload['counts'],dom_url_label_identity_and_context_checks=42,copy_integrity='ok',foreign_keys='ok',idempotent=True,original_rows_preserved=True,other_contests_rankings_and_acquisitions_unchanged=True,sql_sha256=hashlib.sha256(sqlpath.read_bytes()).hexdigest(),applied=a.apply)
    if a.apply:
        backup=out/'before-import.sqlite3';assert not backup.exists(),'Non sovrascrivere backup'
        with sqlite3.connect(dbpath) as src,sqlite3.connect(backup) as target:src.backup(target)
        result['backup_path']=backup.relative_to(ROOT).as_posix();result['backup_sha256']=hashlib.sha256(backup.read_bytes()).hexdigest()
        with sqlite3.connect(dbpath) as target:
            before=snapshot(target);target.executescript(sql);after=snapshot(target);scope(before,after,target);checks(target,payload)
            target.executescript(sql);assert snapshot(target)==after
        result['operational_integrity']='ok';result['operational_idempotent']=True
    (TASK/'VERIFICATION.json').write_text(json.dumps(result,ensure_ascii=False,indent=2)+'\n',encoding='utf8')
    print(json.dumps(result))
if __name__=='__main__':main()
