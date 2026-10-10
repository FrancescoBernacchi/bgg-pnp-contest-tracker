"""Acceptance on uniquely named copies only; no operational writes."""
import json
import sqlite3
import sys
from datetime import datetime, timezone
from pathlib import Path
from uuid import uuid4
import import_pergioco_carta_matita as imp


def clone(source, target):
    with imp.open_db(source) as db:
        db.execute('BEGIN')
        with sqlite3.connect(target) as dest: db.backup(dest)


def app_reads(path, pilot_ids):
    sys.path.insert(0, str(imp.ROOT / 'app'))
    import server
    import source_evidence
    import pergioco_progress
    with server.connect(path) as db:
        details = {rid:source_evidence.source_record_detail(db,rid) for rid in pilot_ids}
        roster = source_evidence.record_summaries(db,'pergioco')
        progress = pergioco_progress.pergioco_progress(db)
        games = server.game_rows(db)
        old = server.game_detail(db,993)
        # Core catalog and contest/entry readers remain executable on extended data.
        catalog = server.catalog(db)
        cid = db.execute('SELECT min(id) FROM contests').fetchone()[0]
        server.contest_detail(db,cid)
        eid = db.execute('SELECT min(id) FROM entries').fetchone()[0]
        server.entry_detail(db,eid)
    return details, roster, progress, games, old, catalog


def main():
    out = imp.ROOT / 'outputs/pergioco-carta-matita-tests' / (datetime.now(timezone.utc).strftime('%Y%m%dT%H%M%S')+'-'+uuid4().hex[:8])
    out.mkdir(parents=True)
    checks = {}
    def check(name, condition=True):
        imp.require(condition, 'Failed: '+name); checks[name]=True
    def refusal(name, path, action, errors=(ValueError,sqlite3.IntegrityError,AssertionError,RuntimeError)):
        with imp.open_db(path) as db: before=imp.inventory(db)
        try: action()
        except errors: pass
        else: raise ValueError('Expected refusal: '+name)
        with imp.open_db(path) as db: check(name,imp.inventory(db)==before)
    p=imp.load(); before_hash=imp.filehash(imp.DB)
    protected={f.relative_to(imp.ROOT).as_posix():imp.filehash(f) for folder in ('app','database') for f in (imp.ROOT/folder).rglob('*') if f.is_file() and f.suffix in ('.py','.sql','.js','.css','.html')}
    protected['catalog/pergioco_pilot_2026-10-06.json']=imp.filehash(imp.ROOT/'catalog/pergioco_pilot_2026-10-06.json')
    with imp.open_db(imp.DB) as db:
        baseline=imp.inventory(db)
        pilot_ids=[r[0] for r in db.execute("SELECT record_id FROM source_record_keys WHERE key_kind='local_pilot_id' ORDER BY id")]
        check('pilot_12_present',len(pilot_ids)==12)
        check('013_exact_schema',imp.installed(db))
        check('RO_matching_no_candidates_or_URL_collisions',all(not m['exact_candidates'] and not m['normalized_candidates'] and not m['source_url_collisions'] for m in imp.matching(db,p)))
    old_app=app_reads(imp.DB,pilot_ids)
    work=out/'acceptance.sqlite3'; clone(imp.DB,work)
    result=imp.apply(work,'TSK-0081: authorized COPY rehearsal only',out/'backups')
    with imp.open_db(work) as db:
        first=imp.verify(db,p)
        delta=lambda table:first['tables'][table]['count']-baseline['tables'][table]['count']
        check('9_source_records',delta('source_records')==9)
        check('7_proposed_games_copy_only',delta('games')==7)
        check('9_payloads_full_hashes_and_typed_fields')
        check('18_classifications_complete_paths',delta('source_classification_observations')==18)
        check('no_common_mapping_inferred',delta('common_classification_mappings')==0)
        check('3_Labirinto_instances',delta('problem_instances')==3)
        check('no_solution_for_invented',db.execute("SELECT count(*) FROM instance_mention_assertions WHERE role='solution_for'").fetchone()[0]==0)
        check('7_embedded_variants_without_new_candidates',db.execute("SELECT count(*) FROM source_relation_assertions WHERE relation_type_normalized='embedded_variant_declared'").fetchone()[0]==7)
        check('no_person_resolution_or_canonical_credit',delta('people')==0 and delta('credit_assertions')==0)
        check('no_canonical_relationships',delta('game_relationships')==0)
        check('no_new_source_and_pilot_all_rows_preserved',delta('catalog_sources')==0)
        imp.preserve(db,Path(result['backup']),baseline);check('legacy_and_pilot_every_row_preserved')
        check('schema_unchanged',first['objects']==baseline['objects'])
        ad=db.execute('SELECT a.outcome_normalized,count(*) FROM source_admission_observations a JOIN source_record_observations o ON o.id=a.record_observation_id WHERE o.mapping_version=? GROUP BY a.outcome_normalized ORDER BY a.outcome_normalized',(imp.VERSION,)).fetchall()
        check('CAT_7_2_preserved',ad==[('admitted',7),('requirement_not_demonstrated',2)])
        for cid in ('PGCM-001','PGCM-006'):
            rid=db.execute('SELECT record_id FROM source_record_keys WHERE stable_key=?',(imp.PREFIX+cid,)).fetchone()[0]
            check(cid+'_source_only',not db.execute('SELECT 1 FROM game_source_records WHERE source_record_id=?',(rid,)).fetchone())
        # Every evidence pointer resolves to frozen CAT, including date/raw/NULL metadata.
        for table in first['tables']:
            cols={c[1] for c in db.execute('PRAGMA table_info('+table+')')}
            if {'raw_value','evidence_pointer','mapping_version'}.issubset(cols):
                for raw,pointer in db.execute('SELECT raw_value,evidence_pointer FROM '+table+' WHERE mapping_version=?',(imp.VERSION,)):
                    value=p
                    for part in pointer.lstrip('/').split('/'):
                        value=value[int(part)] if isinstance(value,list) else value[part.replace('~1','/').replace('~0','~')]
                    imp.require(json.loads(raw)==value,'Bad pointer '+pointer)
        check('all_evidence_pointers_resolve')
        # Complete rules unknown != paid; raw complete_rules_free remains NULL.
        check('NULL_rules_cost_not_paid',db.execute("SELECT count(*) FROM resource_access_observations WHERE mapping_version=? AND subject_scope='complete_rules' AND cost_status='unknown' AND content_observed IS NULL",(imp.VERSION,)).fetchone()[0]==2)
        check('alias_contexts_distinct',delta('game_names')==22)
    with imp.open_db(Path(result['backup'])) as db: check('backup_inventory_exact',imp.inventory(db)==baseline)
    with imp.open_db(Path(result['restore_proof'])) as db: check('restore_inventory_exact',imp.inventory(db)==baseline)
    replay=imp.apply(work,'TSK-0081: COPY replay',out/'backups')
    with imp.open_db(work) as db: check('replay_zero_delta',replay['writes']==0 and imp.inventory(db)==first)
    new_app=app_reads(work,pilot_ids)
    # Conditions are source scoped: new condition observations legitimately appear in pilot views.
    for rid in pilot_ids:
        a=dict(old_app[0][rid]); b=dict(new_app[0][rid]); a.pop('conditions');b.pop('conditions')
        check('pilot_app_detail_'+str(rid)+'_preserved',a==b)
    check('APP_roster_21_readable',len(new_app[1])==21)
    check('APP_legacy_Abande_unchanged',old_app[4]==new_app[4])
    check('APP_pilot_metric_denominators_unchanged',old_app[2]['metrics']==new_app[2]['metrics'])
    with __import__('server').connect(work) as db:
        import source_evidence
        ids=[r[0] for r in db.execute('SELECT record_id FROM source_record_keys WHERE task_id=?',('TSK-0081',))]
        for rid in ids:
            detail=source_evidence.source_record_detail(db,rid)
            check('APP_new_record_'+str(rid)+'_readable',len(detail['observations'])==1 and len(detail['admissions'])==1 and len(detail['classifications'])==2)
    failed=out/'rollback.sqlite3';clone(imp.DB,failed)
    refusal('rollback_atomic_after_record_6',failed,lambda:imp.apply(failed,'TSK-0081 COPY failure',out/'backups',fail_after=6))
    collision=out/'URL-collision.sqlite3';clone(imp.DB,collision)
    with imp.open_db(collision,write=True) as db:
        sid=db.execute("SELECT id FROM catalog_sources WHERE source_key='pergioco'").fetchone()[0]
        imp.put(db,'source_records',source_id=sid,record_type='synthetic',canonical_url=p['records'][0]['source_url'],title_raw='Conflict',observed_at='2026-10-08');db.commit()
    refusal('URL_collision_refused',collision,lambda:imp.apply(collision,'COPY collision',out/'backups'))
    name=out/'name-collision.sqlite3';clone(imp.DB,name)
    with imp.open_db(name,write=True) as db: imp.put(db,'games',canonical_title='Engel',source_url='https://example.invalid/name-fixture',first_seen_at='2026-10-08',last_verified_at='2026-10-08');db.commit()
    refusal('new_exact_name_candidate_requires_review',name,lambda:imp.apply(name,'COPY name collision',out/'backups'))
    norm=out/'normalized-collision.sqlite3';clone(imp.DB,norm)
    with imp.open_db(norm,write=True) as db: imp.put(db,'games',canonical_title='STRIPES',source_url='https://example.invalid/normalized-fixture',first_seen_at='2026-10-08',last_verified_at='2026-10-08');db.commit()
    refusal('new_normalized_candidate_requires_review',norm,lambda:imp.apply(norm,'COPY normalized collision',out/'backups'))
    key=out/'key-collision.sqlite3';clone(imp.DB,key)
    with imp.open_db(key,write=True) as db:
        sid=db.execute("SELECT id FROM catalog_sources WHERE source_key='pergioco'").fetchone()[0]
        imp.put(db,'source_record_keys',stable_key=imp.PREFIX+'PGCM-001',source_id=sid,record_id=pilot_ids[0],local_key='collision',key_kind='synthetic',assigned_at='2026-10-08',task_id='synthetic');db.commit()
    refusal('partial_or_key_collision_refused',key,lambda:imp.apply(key,'COPY key collision',out/'backups'))
    changed=out/'changed-manifest.json';mut=json.loads(imp.canon(p));mut['records'][0]['year_declared']=1900;changed.write_text(imp.canon(mut),encoding='utf-8')
    refusal('changed_CAT_manifest_refused',work,lambda:imp.load(changed))
    refusal('missing_authorization_refused',work,lambda:imp.apply(work,'',out/'backups'))
    corrupt=out/'replay-corrupt.sqlite3';clone(work,corrupt)
    with imp.open_db(corrupt,write=True) as db:
        db.execute("UPDATE game_names SET name='Changed' WHERE source_record_id=(SELECT record_id FROM source_record_keys WHERE local_key='PGCM-007') AND name_type='alias'");db.commit()
    refusal('typed_alias_replay_tampering_refused',corrupt,lambda:imp.apply(corrupt,'COPY corrupt replay',out/'backups'))
    tamper=out/'record-corrupt.sqlite3';clone(work,tamper)
    with imp.open_db(tamper,write=True) as db:
        db.execute("UPDATE source_records SET canonical_url=canonical_url||'?changed' WHERE id=(SELECT record_id FROM source_record_keys WHERE local_key='PGCM-003')");db.commit()
    refusal('typed_record_replay_tampering_refused',tamper,lambda:imp.apply(tamper,'COPY corrupt replay',out/'backups'))
    with imp.open_db(work,write=True) as db:
        oid=db.execute('SELECT id FROM source_record_observations WHERE mapping_version=? LIMIT 1',(imp.VERSION,)).fetchone()[0]
        db.execute('BEGIN')
        imp.put(db,'source_classification_observations',stable_key='synthetic:incomplete',record_observation_id=oid,label_raw='Synthetic',kind_raw='synthetic',path_state='observed',segment_count=1,
            source_url='https://example.invalid',observed_at='2026-10-08',observed_precision='day',formalized_at=result['formalized_at'],evidence_path='synthetic',evidence_pointer='/synthetic',provenance_kind='later_formalization',mapping_version='synthetic')
        try: imp.validate(db)
        except AssertionError: check('incomplete_path_refused')
        else: raise ValueError('Incomplete path accepted')
        db.rollback()
        # Explicitly exercise nullable URL ownership, append-only key and hash guards.
        row=db.execute('SELECT * FROM source_resource_mention_observations WHERE mapping_version=? LIMIT 1',(imp.VERSION,)).fetchone()
        cols=[x[1] for x in db.execute('PRAGMA table_info(source_resource_mention_observations)')]
        data=dict(zip(cols,row));data.pop('id');data['stable_key']='synthetic:NULL-owner';data['declared_url']=None
        db.execute('BEGIN')
        try: imp.put(db,'source_resource_mention_observations',**data)
        except sqlite3.IntegrityError: check('NULL_resource_owner_constraint')
        else: raise ValueError('NULL owner accepted')
        db.rollback()
        db.execute('BEGIN')
        try: db.execute('UPDATE source_record_observations SET payload_sha256=? WHERE id=?',('0'*64,oid))
        except sqlite3.IntegrityError: check('append_only_payload_protection')
        else: raise ValueError('Evidence mutation accepted')
        db.rollback()
    concurrent=out/'concurrent.sqlite3';clone(imp.DB,concurrent)
    def writer(path):
        with imp.open_db(path,write=True) as db: db.execute("UPDATE people SET display_name=display_name||' concurrent' WHERE id=(SELECT min(id) FROM people)");db.commit()
    try: imp.apply(concurrent,'COPY concurrent writer',out/'backups',before_lock=writer)
    except ValueError as exc: check('concurrent_mutation_refused','Target changed' in str(exc))
    else: raise ValueError('Concurrent baseline change accepted')
    with imp.open_db(concurrent) as db: check('concurrent_no_batch_insert',imp.batch_presence(db,p)==0)
    wal=out/'wal.sqlite3';clone(imp.DB,wal)
    with imp.open_db(wal,write=True) as active:
        active.execute('PRAGMA journal_mode=WAL');active.execute('PRAGMA wal_autocheckpoint=0')
        active.execute("UPDATE people SET display_name=display_name||' WAL' WHERE id=(SELECT min(id) FROM people)");active.commit()
        wr=imp.apply(wal,'COPY WAL',out/'backups')
        with imp.open_db(Path(wr['backup'])) as db: check('backup_includes_uncheckpointed_WAL',db.execute('SELECT display_name FROM people ORDER BY id LIMIT 1').fetchone()[0].endswith(' WAL'))
    # IDs observed in first rehearsal are not reserved: insert unrelated game first.
    allocation=out/'allocation.sqlite3';clone(imp.DB,allocation)
    with imp.open_db(allocation,write=True) as db: extra=imp.put(db,'games',canonical_title='Unrelated allocation fixture',source_url='https://example.invalid/allocation-fixture',first_seen_at='2026-10-08',last_verified_at='2026-10-08');db.commit()
    imp.apply(allocation,'COPY ID allocation',out/'backups')
    with imp.open_db(allocation) as db:
        actual=db.execute('SELECT game_id FROM source_identity_decisions WHERE stable_key=?',(imp.PREFIX+'PGCM-002:identity',)).fetchone()[0]
        check('game_IDs_allocated_at_transaction_time',actual>extra)
    alternative=out/'source-only-alternative.sqlite3';clone(imp.DB,alternative)
    alt={k:'source_only' for k in imp.PLAN}
    ar=imp.apply(alternative,'COPY source-only fallback',out/'backups',plan=alt)
    check('source_only_alternative_no_games',ar['table_deltas'].get('games',0)==0)
    imp.apply(alternative,'COPY source-only replay',out/'backups',plan=alt);check('source_only_alternative_replay')
    check('operational_file_hash_unchanged',imp.filehash(imp.DB)==before_hash)
    with imp.open_db(imp.DB) as db: check('operational_inventory_unchanged',imp.inventory(db)==baseline)
    check('app_schema_pilot_files_unchanged',all(imp.filehash(imp.ROOT/f)==h for f,h in protected.items()))
    report=dict(task_id='TSK-0081',checked_at='2026-10-08',operational_written=False,operational_sha256_before=before_hash,operational_sha256_after=imp.filehash(imp.DB),
        checks=checks,passed=len(checks),failed=0,copy=str(work),result=result,replay=replay,table_deltas=result['table_deltas'],
        protected_files=len(protected),limits=['Local assertions, no external identity/credit verification or playtest.', 'Existing APP reads succeed; new batch progress denominators and missing display fields require a separate APP task.', 'No operational authorization yet.'])
    (imp.TASK/'COPY_VERIFICHE.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
    print(json.dumps(dict(passed=len(checks),failed=0,report=str(imp.TASK/'COPY_VERIFICHE.json'),table_deltas=result['table_deltas']),ensure_ascii=False,indent=2))


if __name__=='__main__': main()
