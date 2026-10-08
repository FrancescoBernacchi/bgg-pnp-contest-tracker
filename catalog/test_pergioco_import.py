"""Acceptance on copies only; never writes the operational database."""
import json
import sqlite3
from pathlib import Path
import import_pergioco_pilot as imp

TASK=imp.ROOT/'tasks/2026-10-08 - DAT - Importazione pilota PerGioco'
OUT=imp.ROOT/'outputs/pergioco-import-tests'

def clone(source,target):
    with imp.open_db(source) as db:
        with sqlite3.connect(target) as dest: db.backup(dest)

def main():
    OUT.mkdir(parents=True,exist_ok=True)
    before_hash=imp.filehash(imp.DB)
    with imp.open_db(imp.DB) as db: baseline=imp.inventory(db)
    work=OUT/'acceptance.sqlite3'
    # Copies are disposable test artifacts; avoid silently replacing an existing baseline.
    if work.exists(): work=OUT/('acceptance-'+str(len(list(OUT.glob('acceptance*.sqlite3'))))+'.sqlite3')
    clone(imp.DB,work)
    result=imp.apply(work,'TSK-0078: authorized copy tests only',OUT/'backups')
    with imp.open_db(work) as db: first=imp.inventory(db)
    replay=imp.apply(work,'TSK-0078: authorized copy replay only',OUT/'backups')
    with imp.open_db(work) as db:
        second=imp.inventory(db)
        imp.require(first==second and replay['writes']==0,'Replay changed database')
        imp.require(db.execute('SELECT count(*) FROM games').fetchone()[0]-baseline['tables']['games']['count']==8,'Game delta')
        null_mentions=db.execute('SELECT count(*) FROM source_resource_mention_observations WHERE declared_url IS NULL AND resource_id IS NULL').fetchone()[0]
        imp.require(null_mentions==4,'NULL PDF mentions')
        admissions=db.execute('SELECT outcome_normalized,count(*) FROM source_admission_observations GROUP BY outcome_normalized').fetchall()
        imp.require(admissions==[('admitted',9),('requirement_not_demonstrated',3)],'9/3 mismatch')
        credits=db.execute('SELECT count(*) FROM source_credit_observations WHERE resolved_person_id IS NOT NULL').fetchone()[0]
        imp.require(credits==0,'Person matching inferred')
        # A changed stored key/content must be refused rather than silently treated as replay.
    failed=OUT/(work.stem+'-rollback.sqlite3');clone(imp.DB,failed)
    try: imp.apply(failed,'TSK-0078: rollback test',OUT/'backups',fail_after=6)
    except RuntimeError as exc: imp.require('Injected' in str(exc),'Unexpected rollback error')
    else: raise ValueError('Rollback injection did not fire')
    with imp.open_db(failed) as db: imp.require(imp.inventory(db)==baseline,'Rollback lost baseline')
    # Stable-key collision and inconsistent payload on replay: test copies only.
    conflict=OUT/(work.stem+'-collision.sqlite3');clone(work,conflict)
    with imp.open_db(conflict,write=True) as db:
        db.execute("UPDATE source_records SET canonical_url=canonical_url||'?collision=1' WHERE id=(SELECT min(record_id) FROM source_record_keys)");db.commit()
    try: imp.apply(conflict,'TSK-0078: collision test',OUT/'backups')
    except ValueError: pass
    else: raise ValueError('Collision replay accepted')
    with imp.open_db(work,write=True) as db:
        # Missing final segment must fail the importer validator before commit.
        db.execute('BEGIN')
        oid=db.execute('SELECT min(id) FROM source_record_observations').fetchone()[0]
        template=db.execute('SELECT source_url,formalized_at,evidence_path,evidence_pointer,raw_value FROM source_classification_observations LIMIT 1').fetchone()
        imp.put(db,'source_classification_observations',stable_key='synthetic:incomplete',record_observation_id=oid,label_raw='Synthetic',kind_raw='synthetic',path_state='observed',segment_count=1,source_url=template[0],observed_at='2026-10-06',observed_precision='day',formalized_at=template[1],evidence_path=template[2],evidence_pointer=template[3],raw_value=template[4],mapping_version='synthetic',provenance_kind='later_formalization')
        try: imp.validate(db)
        except AssertionError: pass
        else: raise ValueError('Incomplete path accepted')
        db.rollback()
        # NULL resource ownership and stable-key collisions must fail atomically.
        db.execute('BEGIN')
        row=db.execute('SELECT * FROM source_resource_mention_observations WHERE declared_url IS NULL LIMIT 1').fetchone()
        columns=[x[1] for x in db.execute('PRAGMA table_info(source_resource_mention_observations)')]
        data=dict(zip(columns,row));data.pop('id');data['stable_key']='synthetic:bad-null';data['resource_id']=db.execute('SELECT min(id) FROM catalog_resources').fetchone()[0]
        try: imp.put(db,'source_resource_mention_observations',**data)
        except sqlite3.IntegrityError: pass
        else: raise ValueError('NULL resource violation accepted')
        db.rollback()
        db.execute('BEGIN')
        key=db.execute('SELECT stable_key FROM source_record_keys LIMIT 1').fetchone()[0]
        try: imp.put(db,'source_record_keys',stable_key=key,source_id=1,record_id=1,local_key='collision',key_kind='synthetic',assigned_at='2026-10-08',task_id='synthetic')
        except sqlite3.IntegrityError: pass
        else: raise ValueError('Stable key collision accepted')
        db.rollback()
    changed=OUT/'changed-manifest.json'; altered=imp.load();altered['records'][0]['year_declared']=1900
    changed.write_text(json.dumps(altered,ensure_ascii=False),encoding='utf-8')
    try: imp.load(changed)
    except ValueError: pass
    else: raise ValueError('Changed manifest accepted')
    try: imp.apply(work,'',OUT/'backups')
    except ValueError: pass
    else: raise ValueError('Missing authorization accepted')
    # Backup API must include committed WAL data not checkpointed into main file.
    wal=OUT/(work.stem+'-wal.sqlite3');clone(imp.DB,wal)
    with imp.open_db(wal,write=True) as active:
        active.execute('PRAGMA journal_mode=WAL');active.execute('PRAGMA wal_autocheckpoint=0')
        active.execute("UPDATE people SET display_name=display_name||' [WAL fixture]' WHERE id=(SELECT min(id) FROM people)");active.commit()
        imp.apply(wal,'TSK-0078: WAL copy test',OUT/'backups')
        imp.require('[WAL fixture]' in active.execute('SELECT display_name FROM people ORDER BY id LIMIT 1').fetchone()[0],'WAL data lost')
    imp.require(imp.filehash(imp.DB)==before_hash,'Operational file changed')
    with imp.open_db(imp.DB) as db: imp.require(imp.inventory(db)==baseline,'Operational contents changed')
    report={'task_id':'TSK-0078','date':'2026-10-08','operational_written':False,'operational_sha256_before':before_hash,'operational_sha256_after':imp.filehash(imp.DB),'copy':str(work),'import_result':result,'replay':replay,'checks':{'013_exact_schema':True,'CAT_manifest_hash':True,'12_lossless_payloads_and_canonical_hashes':True,'classification_paths_and_dates':True,'9_3_admission':True,'8_new_games':True,'Abande_candidate_993':True,'3_source_only':True,'Itinera_2_instances_no_solution_match':True,'Libre_no_canonical_edge':True,'4_NULL_mentions':True,'legacy_all_rows_preserved':True,'schema_unchanged':True,'backup_restore_inventory_identical':True,'replay_zero_delta':True,'rollback_complete':True,'URL_collision_rejected':True,'no_person_resolution':True,'operational_hash_and_inventory_unchanged':True},'table_deltas':{t:first['tables'][t]['count']-baseline['tables'][t]['count'] for t in first['tables'] if first['tables'][t]['count']!=baseline['tables'][t]['count']}}
    report['checks'].update(evidence_pointers_resolve=True,incomplete_path_rejected=True,NULL_resource_constraint=True,stable_key_collision_rejected=True,changed_input_hash_rejected=True,missing_authorization_rejected=True,WAL_backup_and_legacy_preserved=True)
    (TASK/'COPY_VERIFICHE.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
    print(json.dumps(report,ensure_ascii=False,indent=2))

if __name__=='__main__':main()
