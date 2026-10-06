"""Behavioral tests on synthetic, in-memory SQLite; no operational writes."""
import json
import sqlite3
import unittest
from pathlib import Path

from apply_source_evidence_migration import expected_objects, installed, validate

ROOT=Path(__file__).resolve().parents[1]
MIGRATION=ROOT/'database/migrations/013_source_evidence.sql'
EVIDENCE=dict(source_url='https://example.invalid/evidence', observed_at='2026-10-06',
              observed_precision='day',formalized_at='2026-10-06T12:00:00+02:00',
              evidence_path='synthetic.json',evidence_pointer='/fixture',provenance_kind='observed',
              mapping_version='B-v1-test')

class EvidenceTests(unittest.TestCase):
    def put(self,table,key,**data):
        columns={r[1] for r in self.db.execute('PRAGMA table_info('+table+')')}
        if 'evidence_path' in columns: data={**EVIDENCE,**data}
        data={'stable_key':key,**data}
        cursor=self.db.execute('INSERT INTO '+table+' ('+','.join(data)+') VALUES ('+','.join('?' for _ in data)+')',tuple(data.values()))
        return cursor.lastrowid

    def rejected(self,call):
        self.db.execute('SAVEPOINT expected_failure')
        try:
            with self.assertRaises(sqlite3.IntegrityError):call()
        finally:
            self.db.execute('ROLLBACK TO expected_failure');self.db.execute('RELEASE expected_failure')

    def setUp(self):
        self.db=sqlite3.connect(':memory:');self.addCleanup(self.db.close)
        schema=(ROOT/'database/schema.sql').read_text(encoding='utf-8-sig')
        # Fresh schema may already include the separately generated migration.
        schema=schema.split('-- BEGIN MIGRATION 013_SOURCE_EVIDENCE')[0]
        self.db.executescript(schema);self.db.executescript(MIGRATION.read_text(encoding='utf8'))
        self.db.execute("INSERT INTO catalog_sources(id,source_key,display_name,source_kind,first_seen_at) VALUES(1,'synthetic','Synthetic','test','2026-10-06')")
        for i in [1,2,3]:
            self.db.execute('INSERT INTO source_records(id,source_id,record_type,canonical_url,title_raw,observed_at) VALUES(?,1,?,?,?,?)',(i,'game_page',f'https://example.invalid/{i}','Homonym','2026-10-06'))
            self.db.execute('INSERT INTO games(id,canonical_title,source_url,first_seen_at,last_verified_at) VALUES(?,?,?,?,?)',(i,'Homonym',f'https://example.invalid/{i}','2026-10-06','2026-10-06'))
        self.db.execute("INSERT INTO people(id,display_name) VALUES(1,'Synthetic Designer')")
        self.db.execute("INSERT INTO catalog_resources(id,resource_kind,url,first_seen_at) VALUES(1,'rules','https://example.invalid/rules','2026-10-06')")
        self.db.execute("INSERT INTO game_source_records VALUES(1,1,'confirmed','manual','Synthetic decision','2026-10-06')")
        self.db.execute("INSERT INTO game_names(id,game_id,name,observed_at,source_record_id) VALUES(1,1,'Synthetic alias','2026-10-06',1)")
        self.db.execute("INSERT INTO credit_assertions(id,person_id,game_id,role,observed_at) VALUES(1,1,1,'designer','2026-10-06')")
        self.db.execute("INSERT INTO game_relationships(from_game_id,to_game_id,relationship_type) VALUES(1,2,'variant_of')")
        self.put('source_record_keys','key',source_id=1,record_id=1,local_key='local:1',key_kind='local',assigned_at='2026-10-06',task_id='synthetic')
        for i in [1,2]: self.observation(i,i,'event-'+str(i))
        self.put('source_admission_observations','admission',id=1,record_observation_id=1,policy_ref='synthetic',policy_version='1',requirement_key='complete_rules',outcome_raw='admitted',outcome_normalized='admitted',assessment_kind='test')
        self.put('source_classification_observations','classification',id=1,record_observation_id=1,label_raw='Native',kind_raw='breadcrumb',path_state='observed',segment_count=1)
        self.put('source_classification_segments','segment',classification_id=1,position=0,label_raw='Native')
        self.put('common_classification_mappings','mapping',classification_id=1,common_concept_key='synthetic',decision_ref='synthetic',decision_status='confirmed',decided_at='2026-10-06',rationale='synthetic mapping only')
        self.put('source_record_url_observations','url',id=1,record_id=1,record_observation_id=1,url_raw='https://example.invalid/old',url_role='historical')
        for i,obs in [(1,1),(2,1),(3,2)]:
            self.put('source_resource_mentions',f'mention-{i}',id=i,record_id=obs,mention_key=f'm:{i}',first_observation_id=obs,function_raw='solutions' if i==2 else 'rules')
            self.put('source_resource_mention_observations',f'mo-{i}',id=i,mention_id=i,record_observation_id=obs,function_raw='solutions' if i==2 else 'rules',declared_url='https://example.invalid/solutions' if i==2 else 'https://example.invalid/rules',resource_id=None if i==2 else 1,declaration_state='observed')
        self.put('admission_evidence_mentions','am',admission_id=1,mention_id=1,mention_observation_id=1,evidence_role='rules',evidence_pointer='/rules')
        self.put('resource_url_observations','ru',mention_observation_id=2,requested_url='https://example.invalid/solutions',final_url='https://example.invalid/login',destination_kind='login',scope_checked='public request only')
        self.put('condition_observations','condition',id=1,source_id=1,condition_key='terms',scope_raw='public',scope_kind='general',condition_url='https://example.invalid/terms',summary_original='Synthetic conditions, permission unknown')
        self.put('resource_access_observations','access',id=1,mention_observation_id=1,subject_scope='complete_rules',access_raw='public',access_normalized='public',content_observed=1,completeness_normalized='complete',cost_status='free_observed')
        self.put('access_condition_links','condition-link',access_observation_id=1,condition_observation_id=1,applicability_status='uncertain',evidence_pointer='/terms')
        self.put('problem_instances','instance',id=1,record_id=1,instance_key='dated:2021-06-18',instance_kind='problem',created_at='2026-10-06')
        self.put('problem_instance_observations','io',id=1,instance_id=1,record_observation_id=1,date_raw='18/06/2021',published_at='2021-06-18',date_precision='day',context_locator='diagram dated 18/06/2021')
        self.put('instance_mention_assertions','im',instance_observation_id=1,mention_observation_id=1,role='appears_in',assertion_status='observed')
        self.put('source_credit_observations','credit',id=1,record_observation_id=1,name_raw='Synthetic Designer',role_raw='designer',status_raw='declared',party_kind='person',resolved_person_id=1,resolution_decision_ref='synthetic')
        self.put('source_relation_assertions','relation',id=1,record_observation_id=1,from_record_id=1,to_record_id=2,relation_type_raw='variant_of',relation_type_normalized='variant_of',assertion_status='declared',information_requirement='required')
        self.put('source_identity_decisions','decision-1',id=1,record_id=1,game_id=1,decision_kind='match',status='confirmed',decided_at='2026-10-06',decision_ref='synthetic',rationale='confirmed fixture')
        self.put('source_identity_decisions','decision-2',id=2,record_id=2,game_id=2,decision_kind='match',status='candidate',decided_at='2026-10-06',decision_ref='synthetic',rationale='candidate fixture')
        self.put('canonical_projection_events','projection',identity_decision_id=1,target_game_id=1,target_kind='identity',projected_at='2026-10-06',decision_ref='synthetic',mapping_version='B-v1')
        self.db.commit()

    def observation(self,i,record,event,**kwargs):
        data=dict(id=i,record_id=record,event_key=event,payload_json='{}',payload_sha256='a'*64,schema_version='1',coverage_kind='synthetic',coverage_state='complete')
        data.update(kwargs)
        return self.put('source_record_observations','obs-'+str(i),**data)

    def test_append_only_and_replace_all_21_tables(self):
        tables=[o[1] for o in expected_objects() if o[0]=='table']
        self.assertEqual(len(tables),21)
        for table in tables:
            with self.subTest(table=table):
                row=self.db.execute('SELECT id FROM '+table+' LIMIT 1').fetchone();self.assertIsNotNone(row)
                self.rejected(lambda:self.db.execute('UPDATE '+table+' SET stable_key=stable_key WHERE id=?',row))
                self.rejected(lambda:self.db.execute('DELETE FROM '+table+' WHERE id=?',row))
                self.rejected(lambda:self.db.execute('INSERT OR REPLACE INTO '+table+' SELECT * FROM '+table+' WHERE id=?',row))

    def test_same_event_collision_new_visit_and_correction(self):
        self.rejected(lambda:self.observation(3,1,'event-1'))
        self.observation(3,1,'new-visit')
        self.observation(4,1,'event-1',supersedes_id=1,assessment_note='Explicit correction',payload_json='{"corrected":true}',payload_sha256='b'*64)
        self.assertEqual(self.db.execute('SELECT count(*) FROM source_record_observations WHERE record_id=1').fetchone()[0],3)
        self.rejected(lambda:self.observation(5,1,'event-1',supersedes_id=2,assessment_note='Wrong owner'))
        self.rejected(lambda:self.observation(6,1,'event-1',supersedes_id=1))

    def test_cycle_future_and_cross_owner_reference_rejected(self):
        self.rejected(lambda:self.observation(3,1,'event3',parent_observation_id=3))
        self.rejected(lambda:self.observation(3,1,'event3',parent_observation_id=999))
        self.rejected(lambda:self.observation(3,1,'event3',parent_observation_id=2))

    def test_missing_date_requires_reason_and_precise_dates(self):
        self.rejected(lambda:self.observation(3,1,'e3',observed_at=None,observed_precision='unknown'))
        self.observation(3,1,'e3',observed_at=None,observed_precision='unknown',unknown_reason='Original date not available')
        self.rejected(lambda:self.observation(4,1,'e4',observed_at='2026-02-30'))
        self.rejected(lambda:self.observation(4,1,'e4',observed_at='2026-10-06T12:00:00',observed_precision='timestamp'))

    def test_NULL_mentions_and_shared_destination_contexts(self):
        self.put('source_resource_mention_observations','no-url',mention_id=1,record_observation_id=1,function_raw='rules_pdf_mention',declaration_state='declared',declared_url=None,resource_id=None)
        self.rejected(lambda:self.put('source_resource_mention_observations','bad-null',mention_id=1,record_observation_id=1,function_raw='pdf',declaration_state='declared',resource_id=1))
        self.rejected(lambda:self.put('source_resource_mention_observations','bad-url',mention_id=1,record_observation_id=1,function_raw='pdf',declaration_state='declared',resource_id=1,declared_url='https://example.invalid/other'))
        self.assertEqual(self.db.execute('SELECT count(*) FROM source_resource_mention_observations WHERE resource_id=1').fetchone()[0],2)

    def test_contextual_owners_and_duplicate_join(self):
        self.rejected(lambda:self.put('source_resource_mention_observations','wrong-owner',mention_id=1,record_observation_id=2,function_raw='rules',declaration_state='declared'))
        self.rejected(lambda:self.put('admission_evidence_mentions','duplicate',admission_id=1,mention_id=1,mention_observation_id=1,evidence_role='rules',evidence_pointer='/rules'))
        self.rejected(lambda:self.put('admission_evidence_mentions','other-record',admission_id=1,mention_id=3,mention_observation_id=3,evidence_role='rules',evidence_pointer='/rules'))

    def test_classification_paths_and_NULL_differ(self):
        self.put('source_classification_observations','label-only',id=2,record_observation_id=1,label_raw='5x5',kind_raw='page_label',path_state='not_declared',segment_count=0)
        self.rejected(lambda:self.put('source_classification_segments','invented',classification_id=2,position=0,label_raw='Invented parent'))
        self.put('source_classification_observations','multiple',id=3,record_observation_id=1,label_raw='Other native',kind_raw='index_membership',path_state='observed',segment_count=2,segment_raw='I-J-K')
        with self.assertRaises(AssertionError): validate(self.db)
        self.rejected(lambda:self.put('source_classification_segments','gap',classification_id=3,position=1,label_raw='Child'))
        self.put('source_classification_segments','parent',classification_id=3,position=0,label_raw='Parent')
        self.put('source_classification_segments','child',classification_id=3,position=1,label_raw='Child')
        validate(self.db)
        self.rejected(lambda:self.put('source_classification_segments','overflow',classification_id=3,position=2,label_raw='Extra'))

    def test_login_does_not_replace_requested_identity(self):
        self.assertEqual(self.db.execute('SELECT requested_url,final_url FROM resource_url_observations').fetchone(),('https://example.invalid/solutions','https://example.invalid/login'))
        self.rejected(lambda:self.put('resource_url_observations','wrong-request',mention_observation_id=2,requested_url='https://example.invalid/login',scope_checked='unknown'))

    def test_cost_scopes_free_and_unknown_separated(self):
        for scope in ['public_content','components_product','online_implementation']:
            self.put('resource_access_observations',scope,mention_observation_id=1,subject_scope=scope,access_raw='unknown',access_normalized='unknown',completeness_normalized='unknown')
        self.assertEqual(self.db.execute("SELECT cost_status,amount,content_observed FROM resource_access_observations WHERE subject_scope='components_product'").fetchone(),('unknown',None,None))
        self.rejected(lambda:self.put('resource_access_observations','free-unobserved',mention_observation_id=2,subject_scope='complete_rules',access_raw='login',access_normalized='login',completeness_normalized='unknown',cost_status='free_observed'))
        self.rejected(lambda:self.put('resource_access_observations','paid-no-currency',mention_observation_id=1,subject_scope='complete_rules',access_raw='paid',access_normalized='paid',completeness_normalized='unknown',amount=5))

    def test_two_instances_same_date_no_new_games_or_solution_guess(self):
        count=self.db.execute('SELECT count(*) FROM games').fetchone()[0]
        self.put('problem_instances','instance-2',id=2,record_id=1,instance_key='local-second',instance_kind='problem',created_at='2026-10-06')
        self.put('problem_instance_observations','io2',instance_id=2,record_observation_id=1,date_raw='18/06/2021',published_at='2021-06-18',date_precision='day',context_locator='distinct observed locator')
        self.assertEqual(self.db.execute('SELECT count(*) FROM games').fetchone()[0],count)
        self.assertEqual(self.db.execute("SELECT count(*) FROM instance_mention_assertions WHERE role='solution_for'").fetchone()[0],0)
        self.rejected(lambda:self.put('instance_mention_assertions','wrong-function',instance_observation_id=1,mention_observation_id=1,role='solution_for',assertion_status='declared'))

    def test_credit_gaps_organizations_and_ambiguous_names(self):
        self.put('source_credit_observations','gap',record_observation_id=1,role_raw='illustrator',status_raw='not_registered')
        self.put('source_credit_observations','organization',record_observation_id=1,name_raw='Publisher',role_raw='publisher',status_raw='declared',party_kind='organization')
        self.put('source_credit_observations','same-name-other-context',record_observation_id=2,name_raw='Synthetic Designer',role_raw='claimed_designer',status_raw='disputed',party_kind='unknown')
        self.rejected(lambda:self.put('source_credit_observations','fake-person',record_observation_id=1,role_raw='designer',status_raw='not_declared',resolved_person_id=1))
        self.rejected(lambda:self.put('source_credit_observations','organization-person',record_observation_id=1,name_raw='Publisher',role_raw='publisher',status_raw='declared',party_kind='organization',resolved_person_id=1,resolution_decision_ref='bad'))

    def test_relation_information_is_not_purchase(self):
        self.assertEqual(self.db.execute('SELECT information_requirement,ownership_requirement,purchase_requirement FROM source_relation_assertions').fetchone(),('required','unknown','unknown'))
        self.rejected(lambda:self.put('source_relation_assertions','self',record_observation_id=1,from_record_id=1,to_record_id=1,relation_type_raw='variant_of',relation_type_normalized='variant_of',assertion_status='declared'))

    def test_candidate_cannot_project_identity_or_relationship(self):
        self.rejected(lambda:self.put('canonical_projection_events','candidate',identity_decision_id=2,target_game_id=2,target_kind='identity',projected_at='2026-10-06',decision_ref='bad',mapping_version='B-v1'))
        values=dict(identity_decision_id=1,target_game_id=1,target_kind='relationship',relation_assertion_id=1,target_identity_decision_id=2,relationship_to_game_id=2,relationship_type='variant_of',projected_at='2026-10-06',decision_ref='synthetic',mapping_version='B-v1')
        self.rejected(lambda:self.put('canonical_projection_events','candidate-edge',**values))
        self.put('source_identity_decisions','decision-3',id=3,record_id=2,game_id=2,decision_kind='match',status='confirmed',decided_at='2026-10-06',decision_ref='separate decision',rationale='explicit fixture resolution',previous_decision_id=2)
        values['target_identity_decision_id']=3;self.put('canonical_projection_events','confirmed-edge',**values)

    def test_projections_need_typed_proof_and_matching_subject(self):
        common=dict(identity_decision_id=1,target_game_id=1,projected_at='2026-10-06',decision_ref='synthetic',mapping_version='B-v1')
        self.put('canonical_projection_events','name-projection',target_kind='name',name_observation_id=1,name_evidence_pointer='/alias',target_name_id=1,**common)
        self.put('canonical_projection_events','credit-projection',target_kind='credit',credit_assertion_id=1,target_credit_id=1,**common)
        self.rejected(lambda:self.put('canonical_projection_events','two-kinds',target_kind='credit',credit_assertion_id=1,target_credit_id=1,name_observation_id=1,**common))
        self.rejected(lambda:self.put('canonical_projection_events','wrong-name-record',target_kind='name',name_observation_id=2,name_evidence_pointer='/alias',target_name_id=1,**common))

    def test_admission_is_not_development_and_integrity(self):
        self.rejected(lambda:self.observation(3,1,'e3',development_status_normalized='admitted'))
        self.assertEqual(self.db.execute('PRAGMA integrity_check').fetchone()[0],'ok')
        self.assertEqual(self.db.execute('PRAGMA foreign_key_check').fetchall(),[])
        self.assertTrue(installed(self.db))

if __name__=='__main__':unittest.main(verbosity=2)
