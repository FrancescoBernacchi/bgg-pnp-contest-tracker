"""Generate additive B-v1 DDL. Never connects to any database."""
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
MIGRATION = ROOT / 'database/migrations/013_source_evidence.sql'
TABLES = {}
OWNERS = []
RULES = []

def enum(column, values, default='unknown', nullable=False):
    sql = f"{column} TEXT {'NULL' if nullable else 'NOT NULL'}"
    if default is not None:
        sql += f" DEFAULT '{default}'"
    return sql + f" CHECK ({column} IN ({','.join(repr(v) for v in values.split())}))"

def fk(column, table, nullable=False):
    return f"{column} INTEGER {'NULL' if nullable else 'NOT NULL'} REFERENCES {table}(id) ON DELETE RESTRICT"

def text(column, nullable=False):
    return f"{column} TEXT {'NULL' if nullable else 'NOT NULL'} CHECK ({column} IS NULL OR length(trim({column})) > 0)"

def table(name, columns, unique=(), evidence=False, supersede=None):
    cols=['id INTEGER PRIMARY KEY', text('stable_key')+' UNIQUE']+columns
    if evidence:
        cols += [text('source_url'), 'observed_at TEXT',
                 enum('observed_precision','day timestamp unknown'), 'unknown_reason TEXT',
                 text('formalized_at'), text('evidence_path'), text('evidence_pointer'),
                 enum('provenance_kind','observed reused later_formalization',default=None),
                 'raw_value TEXT', 'assessment_note TEXT', text('mapping_version'),
                 "CHECK ((observed_at IS NULL AND observed_precision='unknown' AND length(trim(coalesce(unknown_reason,'')))>0) OR (observed_at IS NOT NULL AND observed_precision<>'unknown' AND julianday(observed_at) IS NOT NULL))",
                 "CHECK (observed_precision<>'day' OR (length(observed_at)=10 AND date(observed_at,'+0 days')=observed_at))",
                 "CHECK (observed_precision<>'timestamp' OR (instr(observed_at,'T')>0 AND (substr(observed_at,-1)='Z' OR substr(observed_at,-6,1) IN ('+','-'))))",
                 "CHECK (julianday(formalized_at) IS NOT NULL AND instr(formalized_at,'T')>0 AND (substr(formalized_at,-1)='Z' OR substr(formalized_at,-6,1) IN ('+','-')))" ]
    if supersede:
        cols += [fk('supersedes_id',name,True), 'CHECK (supersedes_id IS NULL OR supersedes_id<>id)']
        OWNERS.append((name,'supersedes_id',name,supersede,supersede))
    for keys in unique: cols.append('UNIQUE ('+', '.join(keys)+')')
    constraints=[c for c in cols if c.startswith(('CHECK (','CHECK(','UNIQUE (','FOREIGN KEY'))]
    cols=[c for c in cols if c not in constraints]+constraints
    TABLES[name]=(cols,[('stable_key',),('id',)]+list(unique))

def owned(name, column, target, own='record_observation_id', target_own='record_observation_id'):
    OWNERS.append((name,column,target,own,target_own))

def rule(name, invalid, message): RULES.append((name,invalid,message))

def define():
    table('source_record_keys',[fk('source_id','catalog_sources'),fk('record_id','source_records'),text('local_key'),text('key_kind'),text('assigned_at'),text('task_id')],unique=[('source_id','local_key')])
    owned('source_record_keys','record_id','source_records','source_id','source_id')
    table('source_record_observations',[fk('record_id','source_records'),text('event_key'),
        "payload_json TEXT NOT NULL CHECK(json_valid(payload_json) AND json_type(payload_json)='object')",
        "payload_sha256 TEXT NOT NULL CHECK(length(payload_sha256)=64 AND payload_sha256 NOT GLOB '*[^0-9a-f]*')",
        text('schema_version'), 'title_raw TEXT', 'display_title_qualified TEXT', 'year_raw TEXT','year_value INTEGER',
        enum('year_precision','year unknown'), 'page_updated_raw TEXT','development_status_raw TEXT',
        "development_status_normalized TEXT NOT NULL DEFAULT 'unknown' CHECK(development_status_normalized NOT IN ('admitted','requirement_not_demonstrated'))",
        text('coverage_kind'),enum('coverage_state','complete partial blocked unknown'),
        fk('parent_observation_id','source_record_observations',True)],
        unique=[('record_id','event_key','payload_sha256','mapping_version')],evidence=True,supersede='record_id')
    owned('source_record_observations','parent_observation_id','source_record_observations','record_id','record_id')
    rule('source_record_observations',"EXISTS(SELECT 1 FROM source_record_observations p WHERE p.record_id=NEW.record_id AND p.event_key=NEW.event_key AND p.stable_key<>NEW.stable_key) AND (NEW.supersedes_id IS NULL OR NOT EXISTS(SELECT 1 FROM source_record_observations p WHERE p.id=NEW.supersedes_id AND p.record_id=NEW.record_id AND p.event_key=NEW.event_key) OR length(trim(coalesce(NEW.assessment_note,'')))=0)", 'changed event requires explicit correction')
    table('source_admission_observations',[fk('record_observation_id','source_record_observations'),text('policy_ref'),text('policy_version'),text('requirement_key'),text('outcome_raw'),enum('outcome_normalized','admitted requirement_not_demonstrated not_observable unknown'), 'completeness_raw TEXT',text('assessment_kind')],evidence=True,supersede='record_observation_id')
    table('source_classification_observations',[fk('record_observation_id','source_record_observations'),text('label_raw'),text('kind_raw'),enum('path_state','observed not_declared not_observable',default=None),'segment_count INTEGER NOT NULL CHECK(segment_count>=0)','segment_raw TEXT','index_title_raw TEXT','exhaustiveness_raw TEXT',"CHECK(path_state='observed' OR segment_count=0)"],evidence=True,supersede='record_observation_id')
    table('source_classification_segments',[fk('classification_id','source_classification_observations'),'position INTEGER NOT NULL CHECK(position>=0)',text('label_raw')],unique=[('classification_id','position')])
    rule('source_classification_segments',"NOT EXISTS(SELECT 1 FROM source_classification_observations p WHERE p.id=NEW.classification_id AND p.path_state='observed' AND NEW.position<p.segment_count) OR NEW.position<>(SELECT count(*) FROM source_classification_segments WHERE classification_id=NEW.classification_id)",'path segments must be observed and contiguous')
    table('common_classification_mappings',[fk('classification_id','source_classification_observations'),text('common_concept_key'),text('decision_ref'),enum('decision_status','proposed confirmed rejected',default=None),text('decided_at'),text('rationale')],evidence=True,supersede='classification_id')
    table('source_record_url_observations',[fk('record_observation_id','source_record_observations'),fk('record_id','source_records'),text('url_raw'),enum('url_role','historical requested final declared',default=None),'request_event_key TEXT',fk('predecessor_url_observation_id','source_record_url_observations',True),'redirect_position INTEGER CHECK(redirect_position>=0)',enum('destination_kind','content login unknown'),'technical_status_raw TEXT'],evidence=True,supersede='record_id')
    owned('source_record_url_observations','record_observation_id','source_record_observations','record_id','record_id')
    owned('source_record_url_observations','predecessor_url_observation_id','source_record_url_observations','record_id','record_id')
    rule('source_record_url_observations',"NEW.predecessor_url_observation_id IS NOT NULL AND NOT EXISTS(SELECT 1 FROM source_record_url_observations p WHERE p.id=NEW.predecessor_url_observation_id AND p.request_event_key IS NEW.request_event_key AND NEW.request_event_key IS NOT NULL AND NEW.redirect_position=p.redirect_position+1)",'redirect chain requires same event and contiguous steps')
    table('source_resource_mentions',[fk('record_id','source_records'),text('mention_key'),fk('first_observation_id','source_record_observations'),text('function_raw'),'label_raw TEXT'],unique=[('record_id','mention_key')])
    owned('source_resource_mentions','first_observation_id','source_record_observations','record_id','record_id')
    table('source_resource_mention_observations',[fk('mention_id','source_resource_mentions'),fk('record_observation_id','source_record_observations'),text('declared_url',True),fk('resource_id','catalog_resources',True),text('function_raw'),'technical_form_raw TEXT','language_raw TEXT',text('declaration_state'),'context_summary TEXT','destination_status_raw TEXT',"CHECK ((declared_url IS NULL AND resource_id IS NULL) OR declared_url IS NOT NULL)"],evidence=True,supersede='mention_id')
    rule('source_resource_mention_observations',"NOT EXISTS(SELECT 1 FROM source_resource_mentions m JOIN source_record_observations o ON o.record_id=m.record_id WHERE m.id=NEW.mention_id AND o.id=NEW.record_observation_id)",'mention and observation owners differ')
    rule('source_resource_mention_observations',"NEW.resource_id IS NOT NULL AND NOT EXISTS(SELECT 1 FROM catalog_resources r WHERE r.id=NEW.resource_id AND r.url=NEW.declared_url)",'resource URL must equal declared URL')
    table('admission_evidence_mentions',[fk('admission_id','source_admission_observations'),fk('mention_id','source_resource_mentions'),fk('mention_observation_id','source_resource_mention_observations'),text('evidence_role'),text('evidence_pointer')],unique=[('admission_id','mention_observation_id','evidence_role')])
    owned('admission_evidence_mentions','mention_observation_id','source_resource_mention_observations','mention_id','mention_id')
    rule('admission_evidence_mentions',"NOT EXISTS(SELECT 1 FROM source_admission_observations a JOIN source_record_observations o ON o.id=a.record_observation_id JOIN source_resource_mentions m ON m.record_id=o.record_id WHERE a.id=NEW.admission_id AND m.id=NEW.mention_id)",'admission evidence requires its record context')
    table('resource_url_observations',[fk('mention_observation_id','source_resource_mention_observations'),text('requested_url'),text('final_url',True),enum('destination_kind','content login unknown'),"redirect_chain_json TEXT CHECK(redirect_chain_json IS NULL OR (json_valid(redirect_chain_json) AND json_type(redirect_chain_json)='array'))",'technical_status_raw TEXT',text('scope_checked')],evidence=True,supersede='mention_observation_id')
    rule('resource_url_observations',"NOT EXISTS(SELECT 1 FROM source_resource_mention_observations m WHERE m.id=NEW.mention_observation_id AND m.declared_url=NEW.requested_url)",'requested URL must identify the contextual mention')
    table('condition_observations',[fk('source_id','catalog_sources'),text('condition_key'),text('scope_raw'),text('scope_kind'),text('condition_url'),text('summary_original'),'page_updated_raw TEXT','license_identifier TEXT',enum('permission_state','unknown declared attested'), 'registration_declared_free INTEGER CHECK(registration_declared_free IN (0,1))','newsletter_declared_free INTEGER CHECK(newsletter_declared_free IN (0,1))'],evidence=True,supersede='source_id')
    table('resource_access_observations',[fk('mention_observation_id','source_resource_mention_observations'),enum('subject_scope','public_content complete_rules components_product online_implementation',default=None),text('access_raw'),text('access_normalized'),'content_observed INTEGER CHECK(content_observed IN (0,1))','completeness_raw TEXT',text('completeness_normalized'),'cost_raw TEXT',enum('cost_status','unknown free_declared free_observed paid_declared paid_observed'),'amount REAL CHECK(amount>=0)','currency TEXT','access_condition_raw TEXT','playtested INTEGER CHECK(playtested IN (0,1))',"CHECK(amount IS NULL OR length(trim(coalesce(currency,'')))>0)","CHECK(cost_status NOT IN ('free_observed','free_declared') OR amount IS NULL OR amount=0)","CHECK(cost_status<>'free_observed' OR content_observed IS 1)"],evidence=True,supersede='mention_observation_id')
    rule('resource_access_observations',"NEW.supersedes_id IS NOT NULL AND NOT EXISTS(SELECT 1 FROM resource_access_observations p WHERE p.id=NEW.supersedes_id AND p.subject_scope=NEW.subject_scope)",'access correction must preserve subject scope')
    table('access_condition_links',[fk('access_observation_id','resource_access_observations'),fk('condition_observation_id','condition_observations'),enum('applicability_status','declared attested uncertain',default=None),text('evidence_pointer')],unique=[('access_observation_id','condition_observation_id')])
    rule('access_condition_links',"NOT EXISTS(SELECT 1 FROM resource_access_observations a JOIN source_resource_mention_observations m ON m.id=a.mention_observation_id JOIN source_record_observations o ON o.id=m.record_observation_id JOIN source_records r ON r.id=o.record_id JOIN condition_observations c ON c.source_id=r.source_id WHERE a.id=NEW.access_observation_id AND c.id=NEW.condition_observation_id)",'conditions must belong to contextual source')
    table('problem_instances',[fk('record_id','source_records'),text('instance_key'),text('instance_kind'),text('native_instance_id',True),text('created_at')],unique=[('record_id','instance_key')])
    table('problem_instance_observations',[fk('instance_id','problem_instances'),fk('record_observation_id','source_record_observations'),'date_raw TEXT','published_at TEXT',enum('date_precision','day timestamp year unknown'),'label_raw TEXT',text('context_locator'),"CHECK(published_at IS NULL OR (date_precision='year' AND length(published_at)=4) OR (date_precision IN ('day','timestamp') AND julianday(published_at) IS NOT NULL))"],evidence=True,supersede='instance_id')
    rule('problem_instance_observations',"NOT EXISTS(SELECT 1 FROM problem_instances i JOIN source_record_observations o ON o.record_id=i.record_id WHERE i.id=NEW.instance_id AND o.id=NEW.record_observation_id)",'instance observation owner differs')
    table('instance_mention_assertions',[fk('instance_observation_id','problem_instance_observations'),fk('mention_observation_id','source_resource_mention_observations'),enum('role','appears_in solution_for',default=None),text('assertion_status'),text('cross_system_decision_ref',True)],unique=[('instance_observation_id','mention_observation_id','role')],evidence=True,supersede='instance_observation_id')
    rule('instance_mention_assertions',"NEW.role='solution_for' AND NOT EXISTS(SELECT 1 FROM source_resource_mention_observations m WHERE m.id=NEW.mention_observation_id AND m.function_raw='solutions')",'solution relation requires a solutions mention')
    rule('instance_mention_assertions',"NEW.cross_system_decision_ref IS NULL AND NOT EXISTS(SELECT 1 FROM problem_instance_observations i JOIN source_record_observations oi ON oi.id=i.record_observation_id JOIN source_resource_mention_observations m JOIN source_record_observations om ON om.id=m.record_observation_id WHERE i.id=NEW.instance_observation_id AND m.id=NEW.mention_observation_id AND oi.record_id=om.record_id)",'cross-system instance relation needs explicit decision')
    table('source_credit_observations',[fk('record_observation_id','source_record_observations'),text('name_raw',True),text('role_raw'),text('status_raw'),'subject_context_raw TEXT',fk('subject_record_id','source_records',True),'subject_label_raw TEXT',enum('party_kind','person organization unknown'),fk('resolved_person_id','people',True),text('resolution_decision_ref',True),"CHECK(name_raw IS NOT NULL OR status_raw IN ('not_declared','not_registered','unnamed'))","CHECK(resolved_person_id IS NULL OR (name_raw IS NOT NULL AND party_kind='person' AND resolution_decision_ref IS NOT NULL))"],evidence=True,supersede='record_observation_id')
    table('source_relation_assertions',[fk('record_observation_id','source_record_observations'),fk('from_record_id','source_records'),fk('to_record_id','source_records',True),text('target_label_raw',True),text('target_url',True),text('relation_type_raw'),text('relation_type_normalized'),text('assertion_status'),enum('information_requirement','unknown none optional required'),enum('ownership_requirement','unknown none optional required'),enum('purchase_requirement','unknown none optional required'),"CHECK(to_record_id IS NOT NULL OR target_label_raw IS NOT NULL OR target_url IS NOT NULL)","CHECK(to_record_id IS NULL OR to_record_id<>from_record_id)"],evidence=True,supersede='from_record_id')
    owned('source_relation_assertions','record_observation_id','source_record_observations','from_record_id','record_id')
    table('source_identity_decisions',[fk('record_id','source_records'),fk('game_id','games',True),enum('decision_kind','create_new match',default=None),enum('status','proposed candidate confirmed rejected',default=None),'decided_at TEXT',text('decision_ref'),text('rationale'),fk('previous_decision_id','source_identity_decisions',True),"CHECK(status='proposed' OR (game_id IS NOT NULL AND decided_at IS NOT NULL))"],evidence=False)
    owned('source_identity_decisions','previous_decision_id','source_identity_decisions','record_id','record_id')
    table('canonical_projection_events',[fk('identity_decision_id','source_identity_decisions'),fk('target_game_id','games'),enum('target_kind','identity name credit relationship',default=None),fk('name_observation_id','source_record_observations',True),'name_evidence_pointer TEXT',fk('credit_assertion_id','source_credit_observations',True),fk('relation_assertion_id','source_relation_assertions',True),fk('target_identity_decision_id','source_identity_decisions',True),fk('target_name_id','game_names',True),fk('target_credit_id','credit_assertions',True),fk('relationship_to_game_id','games',True),'relationship_type TEXT',text('projected_at'),text('decision_ref'),text('mapping_version'),
        "CHECK((target_kind='identity' AND name_observation_id IS NULL AND credit_assertion_id IS NULL AND relation_assertion_id IS NULL AND target_name_id IS NULL AND target_credit_id IS NULL AND relationship_to_game_id IS NULL AND relationship_type IS NULL AND target_identity_decision_id IS NULL) OR (target_kind='name' AND name_observation_id IS NOT NULL AND name_evidence_pointer IS NOT NULL AND target_name_id IS NOT NULL AND credit_assertion_id IS NULL AND relation_assertion_id IS NULL AND target_credit_id IS NULL AND relationship_to_game_id IS NULL AND relationship_type IS NULL AND target_identity_decision_id IS NULL) OR (target_kind='credit' AND credit_assertion_id IS NOT NULL AND target_credit_id IS NOT NULL AND name_observation_id IS NULL AND relation_assertion_id IS NULL AND target_name_id IS NULL AND relationship_to_game_id IS NULL AND relationship_type IS NULL AND target_identity_decision_id IS NULL) OR (target_kind='relationship' AND relation_assertion_id IS NOT NULL AND target_identity_decision_id IS NOT NULL AND relationship_to_game_id IS NOT NULL AND relationship_type IS NOT NULL AND name_observation_id IS NULL AND credit_assertion_id IS NULL AND target_name_id IS NULL AND target_credit_id IS NULL))",
        'FOREIGN KEY(target_game_id,relationship_to_game_id,relationship_type) REFERENCES game_relationships(from_game_id,to_game_id,relationship_type) ON DELETE RESTRICT'])
    rule('canonical_projection_events',"NOT EXISTS(SELECT 1 FROM source_identity_decisions d WHERE d.id=NEW.identity_decision_id AND d.status='confirmed' AND d.game_id=NEW.target_game_id)",'canonical projection needs confirmed identity')
    rule('canonical_projection_events',"NEW.target_kind='identity' AND NOT EXISTS(SELECT 1 FROM game_source_records g JOIN source_identity_decisions d ON d.record_id=g.source_record_id WHERE d.id=NEW.identity_decision_id AND g.game_id=NEW.target_game_id AND g.match_status='confirmed')",'identity projection must match canonical link')
    rule('canonical_projection_events',"NEW.target_kind='name' AND NOT EXISTS(SELECT 1 FROM source_identity_decisions d JOIN source_record_observations o ON o.record_id=d.record_id JOIN game_names n ON n.source_record_id=d.record_id WHERE d.id=NEW.identity_decision_id AND o.id=NEW.name_observation_id AND n.id=NEW.target_name_id AND n.game_id=NEW.target_game_id)",'name projection context differs')
    rule('canonical_projection_events',"NEW.target_kind='credit' AND NOT EXISTS(SELECT 1 FROM source_identity_decisions d JOIN source_credit_observations c JOIN source_record_observations o ON o.id=c.record_observation_id JOIN credit_assertions t ON t.person_id=c.resolved_person_id AND t.role=c.role_raw WHERE d.id=NEW.identity_decision_id AND c.id=NEW.credit_assertion_id AND o.record_id=d.record_id AND (c.subject_record_id IS NULL OR c.subject_record_id=d.record_id) AND c.subject_label_raw IS NULL AND t.id=NEW.target_credit_id AND t.game_id=NEW.target_game_id)",'credit projection needs resolved role and correct subject')
    rule('canonical_projection_events',"NEW.target_kind='relationship' AND NOT EXISTS(SELECT 1 FROM source_identity_decisions d JOIN source_relation_assertions a ON a.from_record_id=d.record_id JOIN source_identity_decisions td ON td.record_id=a.to_record_id WHERE d.id=NEW.identity_decision_id AND a.id=NEW.relation_assertion_id AND a.relation_type_normalized=NEW.relationship_type AND td.id=NEW.target_identity_decision_id AND td.status='confirmed' AND td.game_id=NEW.relationship_to_game_id)",'relationship projection requires both confirmed identities')

def render():
    TABLES.clear();OWNERS.clear();RULES.clear()
    define()
    out=['-- B-v1 adopted in TSK-0076; additive schema only, no catalog backfill.',
         '-- Generated by database/build_source_evidence_migration.py (TSK-0077).',
         'PRAGMA foreign_keys = ON;', 'BEGIN IMMEDIATE;']
    for name,(columns,_) in TABLES.items():
        out.append('CREATE TABLE '+name+' (\n    '+',\n    '.join(columns)+'\n);')
    # Guard replacement independently of recursive_triggers: OR REPLACE cannot erase evidence.
    for name,(_,uniques) in TABLES.items():
        conflicts=['EXISTS(SELECT 1 FROM '+name+' p WHERE '+' AND '.join('p.'+c+' IS NEW.'+c for c in key)+')' for key in uniques]
        out.append(f"CREATE TRIGGER {name}_no_replace BEFORE INSERT ON {name} WHEN {' OR '.join(conflicts)} BEGIN SELECT RAISE(ABORT,'immutable key collision: {name}'); END;")
        for verb in ['UPDATE','DELETE']:
            out.append(f"CREATE TRIGGER {name}_no_{verb.lower()} BEFORE {verb} ON {name} BEGIN SELECT RAISE(ABORT,'append-only: {name}'); END;")
    for n,col,target,own,to in OWNERS:
        rule(n,f"NEW.{col} IS NOT NULL AND NOT EXISTS(SELECT 1 FROM {target} p WHERE p.id=NEW.{col} AND p.{to} IS NEW.{own})",'referenced owner differs or is absent')
    for i,(name,invalid,message) in enumerate(RULES):
        out.append(f"CREATE TRIGGER {name}_check_{i} BEFORE INSERT ON {name} WHEN {invalid} BEGIN SELECT RAISE(ABORT,'{message}'); END;")
    # Query indexes for evidence owners; existing objects are not altered.
    for name,(cols,_) in TABLES.items():
        for col in ['record_id','record_observation_id','mention_id','mention_observation_id','source_id','instance_id','identity_decision_id']:
            if any(c.startswith(col+' ') for c in cols): out.append(f'CREATE INDEX idx_{name}_{col} ON {name}({col});')
    out.append('COMMIT;')
    return '\n\n'.join(out)+'\n'

if __name__=='__main__':
    sql=render();MIGRATION.write_text(sql,encoding='utf8')
    print(f'Generated {MIGRATION.name}: {len(TABLES)} additive tables; no database access.')
