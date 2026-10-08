"""Offline B-v1 pilot importer. Default inspection; writes require --apply and authorization.

No network, schema changes, person matching or platform verification.
"""
import argparse
import hashlib
import json
import sqlite3
import sys
from datetime import datetime, timezone
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / 'database'))
from apply_source_evidence_migration import open_db, inventory, installed, validate

MANIFEST = ROOT / 'catalog/pergioco_pilot_2026-10-06.json'
DB = ROOT / 'database/pnp_collection.sqlite3'
VERSION = 'pergioco-pilot-B-v1.1'
EPR = 'tasks/2026-10-06 - EPR - Persistenza multifonte per PerGioco/DECISIONE.md'
NEW = {'PGP-001','PGP-002','PGP-004','PGP-005','PGP-006','PGP-008','PGP-011','PGP-012'}

def canon(value):
    return json.dumps(value, ensure_ascii=False, sort_keys=True, separators=(',', ':'), allow_nan=False)

def digest(value):
    return hashlib.sha256(canon(value).encode('utf-8')).hexdigest()

def filehash(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()

def require(test, message):
    if not test: raise ValueError(message)

def load(path=MANIFEST):
    p=json.loads(Path(path).read_text(encoding='utf-8'))
    checks=json.loads((ROOT/'tasks/2026-10-06 - CAT - Pilota PerGioco/VERIFICHE.json').read_text(encoding='utf-8'))
    require(filehash(path)==checks['manifest_sha256'], 'CAT manifest changed: new review required')
    require(len(p['records'])==12 and len({r['candidate_id'] for r in p['records']})==12, 'Sample collision')
    require({r['candidate_id'] for r in p['records']}=={f'PGP-{i:03}' for i in range(1,13)}, 'Sample expanded')
    require(sum(r['outcome']=='admitted' for r in p['records'])==9, 'Admission denominator changed')
    require(len({r['source_url'] for r in p['records']})==12, 'URL collision')
    for r in p['records']:
        require(r['observed_at']=='2026-10-06', 'Original date changed')
        for c in r['native_classification']:
            require(c['source_url'] and c['observed_at'], 'Missing classification evidence')
            require(c['path'] is None or isinstance(c['path'],list), 'Invalid path')
            require(all(isinstance(s,str) and s.strip() for s in (c['path'] or [])), 'Invalid segment')
    return p

def put(db, table, **data):
    return db.execute('INSERT INTO '+table+' ('+','.join(data)+') VALUES ('+','.join('?' for _ in data)+')',tuple(data.values())).lastrowid

def evidence(item, pointer, fallback_url, formalized):
    return dict(source_url=item.get('source_url', fallback_url), observed_at=item.get('observed_at','2026-10-06'),
                observed_precision='day', formalized_at=formalized, evidence_path=MANIFEST.relative_to(ROOT).as_posix(),
                evidence_pointer=pointer, provenance_kind='reused', raw_value=canon(item), mapping_version=VERSION)

def bput(db, table, key, item, pointer, url, formalized, **data):
    return put(db, table, stable_key=key, **{**evidence(item,pointer,url,formalized),**data})

def verify(db, p):
    validate(db)
    # Every evidence pointer resolves into the frozen CAT; raw values must agree.
    for name, in db.execute("SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%'"):
        columns={x[1] for x in db.execute('PRAGMA table_info('+name+')')}
        if {'raw_value','evidence_path','evidence_pointer','mapping_version'}.issubset(columns):
            for raw,pointer,path in db.execute('SELECT raw_value,evidence_pointer,evidence_path FROM '+name+' WHERE mapping_version=?',(VERSION,)):
                expected=p
                for segment in pointer.lstrip('/').split('/'):
                    expected=expected[int(segment)] if isinstance(expected,list) else expected[segment.replace('~1','/').replace('~0','~')]
                require(path==MANIFEST.relative_to(ROOT).as_posix() and json.loads(raw)==expected,'Evidence pointer/raw mismatch '+name+':'+pointer)
    sid=db.execute("SELECT id FROM catalog_sources WHERE source_key='pergioco'").fetchone()
    require(sid is not None,'Missing source')
    counts={}
    for i,r in enumerate(p['records']):
        key='pergioco:pilot:'+r['candidate_id']
        row=db.execute('SELECT k.record_id,o.id,o.payload_json,o.payload_sha256 FROM source_record_keys k JOIN source_record_observations o ON o.record_id=k.record_id WHERE k.stable_key=? AND o.mapping_version=?',(key,VERSION)).fetchall()
        require(len(row)==1,'Missing/duplicate observation '+key)
        rid,oid,payload,ph=row[0]
        require(json.loads(payload)==r and digest(json.loads(payload))==ph==digest(r),'Payload mismatch '+key)
        require(db.execute('SELECT canonical_url,title_raw,native_id FROM source_records WHERE id=?',(rid,)).fetchone()==(r['source_url'],r['title_original'],None),'Source record mismatch')
        require(db.execute('SELECT outcome_raw FROM source_admission_observations WHERE record_observation_id=?',(oid,)).fetchall()==[(r['outcome'],)],'Admission mismatch')
        classes=db.execute('SELECT id,label_raw,kind_raw,path_state,segment_raw,index_title_raw,source_url,observed_at FROM source_classification_observations WHERE record_observation_id=? ORDER BY id',(oid,)).fetchall()
        require(len(classes)==len(r['native_classification']),'Classification count')
        for actual, expected in zip(classes,r['native_classification']):
            labels=[x[0] for x in db.execute('SELECT label_raw FROM source_classification_segments WHERE classification_id=? ORDER BY position',(actual[0],))]
            require(actual[1:]==(expected['label'],expected['kind'],'observed' if expected['path'] is not None else 'not_declared',expected.get('segment'),expected.get('index_title'),expected['source_url'],expected['observed_at']),'Classification evidence mismatch')
            require(labels==(expected['path'] or []),'Classification path loss')
        links=db.execute('SELECT game_id,match_status FROM game_source_records WHERE source_record_id=?',(rid,)).fetchall()
        if r['candidate_id'] in NEW: require(len(links)==1 and links[0][1]=='confirmed','New identity link mismatch')
        elif r['candidate_id']=='PGP-003': require(links==[(993,'candidate')],'Abande candidate changed')
        else: require(not links,'Non-admitted canonical link')
        resources=db.execute('SELECT m.id,m.declared_url,m.resource_id,m.function_raw,m.raw_value FROM source_resource_mention_observations m WHERE m.record_observation_id=? ORDER BY id',(oid,)).fetchall()
        require(len(resources)==len(r['resources']),'Mention count mismatch')
        for actual,expected in zip(resources,r['resources']):
            require(actual[1]==expected.get('url') and actual[3]==expected['kind'] and json.loads(actual[4])==expected,'Resource mapping mismatch')
            if actual[1]: require(db.execute('SELECT url FROM catalog_resources WHERE id=?',(actual[2],)).fetchone()==(actual[1],),'Resource URL collision')
            else: require(actual[2] is None,'NULL resource invented')
        require(db.execute('SELECT count(*) FROM source_credit_observations WHERE record_observation_id=?',(oid,)).fetchone()[0]==len(r['credits'])+len(r['missing_credits']),'Credit/gap count')
    require(db.execute('SELECT count(*) FROM common_classification_mappings').fetchone()[0]==0,'Common categories inferred')
    require(db.execute("SELECT count(*) FROM instance_mention_assertions WHERE role='solution_for'").fetchone()[0]==0,'Solution association invented')
    require(db.execute('SELECT count(*) FROM problem_instances').fetchone()[0]==2,'Instance count')
    require(db.execute("SELECT published_at FROM problem_instance_observations ORDER BY published_at").fetchall()==[('2021-06-18',),('2021-07-23',)],'Instance dates')
    require(db.execute("SELECT count(*) FROM canonical_projection_events WHERE target_kind='relationship'").fetchone()[0]==0,'Canonical relationship invented')
    for name, in db.execute("SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%'"):
        counts[name]=db.execute('SELECT count(*) FROM "'+name+'"').fetchone()[0]
    return counts

def populate(db, p, formalized, authorization, fail_after=None):
    require(installed(db),'013 missing or divergent')
    validate(db)
    source=db.execute("SELECT id FROM catalog_sources WHERE source_key='pergioco'").fetchone()
    if source:
        verify(db,p)
        return 'already_imported'
    require(db.execute('SELECT canonical_title FROM games WHERE id=993').fetchone()==('Abande',),'Abande baseline changed')
    sid=put(db,'catalog_sources',source_key='pergioco',display_name='PerGioco',source_kind='editorial_catalog',base_url='https://www.pergioco.net/',first_seen_at=p['observed_at'],last_verified_at=p['observed_at'],notes='CAT TSK-0074; B-v1 TSK-0076; import '+authorization)
    cond=p['conditions']
    conditions=[]
    for j,url in enumerate(cond['references']):
        # Aggregate assessment reused verbatim as project-authored summary, not attributed to one page alone.
        conditions.append(bput(db,'condition_observations',f'pergioco:conditions:{j}',cond,'/conditions',url,formalized,source_id=sid,condition_key=cond['id']+':'+str(j),scope_raw='CAT conditions aggregate',scope_kind='source_consultation',condition_url=url,summary_original=cond['summary'],page_updated_raw=cond.get('page_updated_raw') if j==0 else None,permission_state='unknown',registration_declared_free=1 if 'registrazione' in url else None,newsletter_declared_free=1 if 'newsletter' in url else None,assessment_note='Aggregate evidence; no redistribution permission attested'))
    ids={}
    for i,r in enumerate(p['records']):
        require(not db.execute('SELECT id FROM source_records WHERE source_id=? AND canonical_url=?',(sid,r['source_url'])).fetchone(),'URL collision')
        ids[r['candidate_id']]=put(db,'source_records',source_id=sid,record_type='game_page',native_id=None,canonical_url=r['source_url'],title_raw=r['title_original'],status_normalized='unknown',observed_at=r['observed_at'],verification_status='verified',last_verified_at=r['observed_at'],raw_metadata=canon(r),notes='CAT outcome preserved in admission observations')
    for i,r in enumerate(p['records']):
        cid=r['candidate_id']; key='pergioco:pilot:'+cid; rid=ids[cid]; ptr='/records/'+str(i); url=r['source_url']
        put(db,'source_record_keys',stable_key=key,source_id=sid,record_id=rid,local_key=cid,key_kind='local_pilot_id',assigned_at=formalized,task_id='TSK-0078')
        oid=bput(db,'source_record_observations',key+':CAT',r,ptr,url,formalized,record_id=rid,event_key='TSK-0074:2026-10-06',payload_json=canon(r),payload_sha256=digest(r),schema_version=str(p['schema_version']),title_raw=r['title_original'],display_title_qualified=r['title_normalized'],year_raw=str(r['year_declared']) if r['year_declared'] else None,year_value=r['year_declared'],year_precision='year' if r['year_declared'] else 'unknown',page_updated_raw=r.get('page_updated_raw'),coverage_kind='pilot_CAT',coverage_state='complete')
        aid=bput(db,'source_admission_observations',key+':admission',r['rules'],ptr+'/rules',url,formalized,record_observation_id=oid,policy_ref='sources/PERGIOCO-SCOPE.md',policy_version='TSK-0073:2026-10-06',requirement_key='complete_free_rules',outcome_raw=r['outcome'],outcome_normalized=r['outcome'],completeness_raw=r['rules']['completeness'],assessment_kind='CAT_pilot',assessment_note=r['rules']['assessment'])
        for j,c in enumerate(r['native_classification']):
            ck=key+':classification:'+str(j)
            co=bput(db,'source_classification_observations',ck,c,ptr+'/native_classification/'+str(j),url,formalized,record_observation_id=oid,label_raw=c['label'],kind_raw=c['kind'],path_state='observed' if c['path'] is not None else 'not_declared',segment_count=len(c['path'] or []),segment_raw=c.get('segment'),index_title_raw=c.get('index_title'),exhaustiveness_raw=r['classification_exhaustiveness'])
            for n,label in enumerate(c['path'] or []): put(db,'source_classification_segments',stable_key=ck+':'+str(n),classification_id=co,position=n,label_raw=label)
        for j,u in enumerate(r['historical_urls']+[url]):
            bput(db,'source_record_url_observations',key+':url:'+str(j),r,ptr+'/historical_urls/'+str(j) if u!=url else ptr+'/source_url',url,formalized,record_observation_id=oid,record_id=rid,url_raw=u,url_role='historical' if u!=url else 'final',destination_kind='content',technical_status_raw=r['final_url_status'],raw_value=canon(u))
        for j,c in enumerate(r['credits']+[{'name':None,'role':gap,'status':'not_registered','note':gap} for gap in r['missing_credits']]):
            bput(db,'source_credit_observations',key+':credit:'+str(j),c,ptr+'/credits/'+str(j) if j<len(r['credits']) else ptr+'/missing_credits/'+str(j-len(r['credits'])),url,formalized,record_observation_id=oid,name_raw=c.get('name'),role_raw=c['role'],status_raw=c['status'],subject_context_raw=c.get('note'),party_kind='unknown',assessment_note='No person resolution or canonical credit projection; role and subject preserved',raw_value=canon(c) if j<len(r['credits']) else canon(r['missing_credits'][j-len(r['credits'])]))
        for j,res in enumerate(r['resources']):
            mk=key+':mention:'+str(j); rp=ptr+'/resources/'+str(j); ru=res.get('url'); resource_id=None
            if ru:
                existing=db.execute('SELECT id FROM catalog_resources WHERE url=?',(ru,)).fetchone()
                resource_id=existing[0] if existing else put(db,'catalog_resources',source_record_id=rid,resource_kind=res['kind'],url=ru,language_code=res.get('language'),access_type='unknown',availability_status='unknown',verification_status='declared',first_seen_at=res['observed_at'],notes='Contextual access in B-v1 observations; no destination verification inferred')
                put(db,'resource_links',resource_id=resource_id,source_record_id=rid,link_role=res['kind'],evidence_record_id=rid)
            mid=put(db,'source_resource_mentions',stable_key=mk,record_id=rid,mention_key='CAT-resource-'+str(j),first_observation_id=oid,function_raw=res['kind'])
            mo=bput(db,'source_resource_mention_observations',mk+':CAT',res,rp,url,formalized,mention_id=mid,record_observation_id=oid,declared_url=ru,resource_id=resource_id,function_raw=res['kind'],technical_form_raw='HTML' if ru and 'html' in res['kind'] else None,language_raw=res.get('language'),declaration_state='declared',destination_status_raw=res['access'])
            if res['kind'] in ('rules_html','base_rules_html'):
                put(db,'admission_evidence_mentions',stable_key=mk+':admission',admission_id=aid,mention_id=mid,mention_observation_id=mo,evidence_role=res['kind'],evidence_pointer=rp)
            if ru:
                bput(db,'resource_url_observations',mk+':url',res,rp,url,formalized,mention_observation_id=mo,requested_url=ru,final_url=res.get('final_url'),destination_kind='login' if res.get('final_url') and 'login' in res['final_url'] else 'unknown',scope_checked='CAT_reused_only',technical_status_raw=res['access'])
            scopes=['public_content','components_product','online_implementation']
            if res['kind'] in ('rules_html','base_rules_html'): scopes.append('complete_rules')
            for scope in scopes:
                iscontent=scope=='public_content'; isrules=scope=='complete_rules'
                free=res.get('free_observed') if iscontent else (r['rules'].get('complete_rules_free') if isrules else None)
                observed=1 if (iscontent and res['access']=='public_no_login_observed') or (isrules and free is True) else (0 if iscontent and res['access']=='reserved_login_observed' else None)
                access=bput(db,'resource_access_observations',mk+':access:'+scope,res,rp,url,formalized,mention_observation_id=mo,subject_scope=scope,access_raw=res['access'] if iscontent or isrules else 'unknown',access_normalized=res['access'] if iscontent or (isrules and free) else 'unknown',content_observed=observed,completeness_raw=res['completeness'] if iscontent or isrules else None,completeness_normalized=res['completeness'] if iscontent or isrules else 'unknown',cost_status='free_observed' if free is True and observed==1 else 'unknown',playtested=int(r['rules']['playtested']) if isrules else None)
                for condid in conditions: put(db,'access_condition_links',stable_key=mk+':conditions:'+scope+':'+str(condid),access_observation_id=access,condition_observation_id=condid,applicability_status='uncertain',evidence_pointer=ptr+'/conditions_ref')
            for n,date in enumerate(res.get('instance_dates',[])):
                ik=key+':instance:'+str(n)
                ins=put(db,'problem_instances',stable_key=ik,record_id=rid,instance_key='CAT-scheme-'+str(n),instance_kind='logic_scheme',native_instance_id=None,created_at=formalized)
                io=bput(db,'problem_instance_observations',ik+':CAT',res,rp+'/instance_dates/'+str(n),ru,formalized,instance_id=ins,record_observation_id=oid,date_raw=date,published_at=date,date_precision='day',context_locator='CAT dated scheme '+date,raw_value=canon(date))
                bput(db,'instance_mention_assertions',ik+':appears',res,rp,ru,formalized,instance_observation_id=io,mention_observation_id=mo,role='appears_in',assertion_status='CAT_observed')
        for j,relation in enumerate(r['relations_and_dependencies']):
            bput(db,'source_relation_assertions',key+':relation-note:'+str(j),r,ptr+'/relations_and_dependencies/'+str(j),url,formalized,record_observation_id=oid,from_record_id=rid,target_label_raw=relation,relation_type_raw=relation,relation_type_normalized='source_statement',assertion_status='declared',raw_value=canon(relation))
        if cid=='PGP-004':
            for typ in ['variant_of','base_rules_information_required']:
                bput(db,'source_relation_assertions',key+':'+typ,r,ptr+'/relations_and_dependencies',url,formalized,record_observation_id=oid,from_record_id=rid,to_record_id=ids['PGP-003'],relation_type_raw=typ,relation_type_normalized=typ,assertion_status='declared',information_requirement='required' if typ=='base_rules_information_required' else 'unknown',raw_value=canon(r['relations_and_dependencies']))
        if cid in NEW or cid=='PGP-003':
            gid=993 if cid=='PGP-003' else put(db,'games',canonical_title=r['title_normalized'],source_url=url,first_seen_at=r['observed_at'],last_verified_at=r['observed_at'],status_normalized='unknown')
            status='candidate' if cid=='PGP-003' else 'confirmed'
            put(db,'game_source_records',game_id=gid,source_record_id=rid,match_status=status,match_method='TSK-0076_identity_plan',evidence=EPR,decided_at='2026-10-06')
            decision=put(db,'source_identity_decisions',stable_key=key+':identity',record_id=rid,game_id=gid,decision_kind='match' if cid=='PGP-003' else 'create_new',status=status,decided_at='2026-10-06',decision_ref=EPR,rationale='Adopted conservative identity plan; Abande equivalence remains unconfirmed')
            if cid in NEW:
                put(db,'canonical_projection_events',stable_key=key+':projection',identity_decision_id=decision,target_game_id=gid,target_kind='identity',projected_at=formalized,decision_ref=authorization,mapping_version=VERSION)
                names=[(r['title_original'],ptr+'/title_original','source_title')]+[(name,ptr+'/aliases_declared/'+str(n),'alias') for n,name in enumerate(r['aliases_declared'])]
                for n,(name,np,nt) in enumerate(names):
                    nid=put(db,'game_names',game_id=gid,name=name,observed_from=url,observed_at=r['observed_at'],name_type=nt,language_code='it' if nt=='source_title' else None,source_record_id=rid,verification_status='declared',evidence_url=url,last_verified_at=r['observed_at'])
                    put(db,'canonical_projection_events',stable_key=key+':name:'+str(n),identity_decision_id=decision,target_game_id=gid,target_kind='name',name_observation_id=oid,name_evidence_pointer=np,target_name_id=nid,projected_at=formalized,decision_ref=authorization,mapping_version=VERSION)
        if fail_after is not None and i+1>=fail_after: raise RuntimeError('Injected rollback failure')
    verify(db,p)
    return 'imported'

def apply(path, authorization, backup_dir, fail_after=None):
    require(__debug__, 'Python -O unsupported')
    require(authorization.strip(),'Explicit authorization reference required')
    p=load(); path=Path(path).resolve(); stamp=datetime.now(timezone.utc).isoformat()
    with open_db(path) as ro:
        require(installed(ro),'013 missing/divergent'); validate(ro)
        if ro.execute("SELECT 1 FROM catalog_sources WHERE source_key='pergioco'").fetchone():
            verify(ro,p); return {'outcome':'already_imported','writes':0}
        baseline=inventory(ro)
        backup_dir=Path(backup_dir); backup_dir.mkdir(parents=True,exist_ok=True)
        backup=backup_dir/('pergioco-before-'+datetime.now(timezone.utc).strftime('%Y%m%dT%H%M%S%f')+'.sqlite3')
        with sqlite3.connect(backup) as dest: ro.backup(dest)
    restore=backup.with_name(backup.stem+'-restore.sqlite3')
    with open_db(backup) as ro:
        require(inventory(ro)==baseline,'Backup mismatch'); validate(ro)
        with sqlite3.connect(restore) as dest: ro.backup(dest)
    with open_db(restore) as ro: require(inventory(ro)==baseline,'Restore mismatch'); validate(ro)
    with open_db(path,write=True) as db:
        try:
            db.execute('BEGIN EXCLUSIVE')
            require(inventory(db)==baseline,'Target changed since backup')
            result=populate(db,p,stamp,authorization,fail_after)
            # No pre-existing row may change or disappear, including shared catalog tables.
            with open_db(backup) as old:
                for table in baseline['tables']:
                    previous=old.execute('SELECT * FROM "'+table+'"').fetchall()
                    current=set(db.execute('SELECT * FROM "'+table+'"').fetchall())
                    require(all(row in current for row in previous),'Legacy row lost '+table)
                    allowed={'catalog_sources','source_records','games','game_names','game_source_records','catalog_resources','resource_links'}
                    if table not in allowed and not any(o[0]=='table' and o[1]==table for o in __import__('apply_source_evidence_migration').expected_objects()):
                        require(len(current)==len(previous),'Unapproved legacy insert '+table)
            require(inventory(db)['objects']==baseline['objects'],'Schema changed')
            counts=verify(db,p); db.commit()
        except BaseException: db.rollback(); raise
    return {'outcome':result,'backup':str(backup),'backup_sha256':filehash(backup),'restore_proof':str(restore),'counts_after':counts,'manifest_sha256':filehash(MANIFEST),'formalized_at':stamp}

def main():
    ap=argparse.ArgumentParser();ap.add_argument('--database',type=Path,default=DB);ap.add_argument('--apply',action='store_true');ap.add_argument('--authorization',default='');ap.add_argument('--backup-dir',type=Path,default=ROOT/'outputs/pergioco-import-backups');args=ap.parse_args()
    if args.apply: result=apply(args.database,args.authorization,args.backup_dir)
    else:
        p=load()
        with open_db(args.database) as db: require(installed(db),'013 missing/divergent');validate(db); result={'mode':'read_only','source_present':bool(db.execute("SELECT 1 FROM catalog_sources WHERE source_key='pergioco'").fetchone()),'records':12,'new_games':8,'candidate':993,'source_only':3,'manifest_sha256':filehash(MANIFEST)}
    print(json.dumps(result,ensure_ascii=False,indent=2))

if __name__=='__main__':main()
