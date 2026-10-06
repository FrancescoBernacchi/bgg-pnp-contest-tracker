"""Documentary evidence projection only. No SQLite, network or migrations."""
import hashlib
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
HERE = Path(__file__).resolve().parent
CAT = ROOT / 'catalog/pergioco_pilot_2026-10-06.json'
DAT = ROOT / 'tasks/2026-10-06 - DAT - Preparazione integrazione PerGioco'
CAT_TASK = ROOT / 'tasks/2026-10-06 - CAT - Pilota PerGioco'

def read(path):
    return json.loads(path.read_text(encoding='utf-8-sig'))

def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()

def semantic(value):
    return hashlib.sha256(json.dumps(value, ensure_ascii=False, sort_keys=True,
                                     separators=(',', ':')).encode()).hexdigest()

def write(path, value):
    path.write_text(json.dumps(value, ensure_ascii=False, indent=2) + '\n', encoding='utf-8')

def main():
    protected = [ROOT / 'database/pnp_collection.sqlite3', ROOT / 'database/schema.sql',
                 ROOT / 'PROJECT.md', ROOT / 'AGENTS.md', ROOT / '.workspace/PROJECT_STATE.md']
    protected += sorted((ROOT / 'database/migrations').glob('*.sql'))
    protected += sorted(p for p in (ROOT / 'app').rglob('*') if p.is_file()
                        and '__pycache__' not in p.parts)
    protected += [CAT, *(DAT / name for name in ['ANTEPRIMA.json', 'PROPOSTA.md',
                   'MODELLO_CORRENTE.json', 'VERIFICHE.json', 'TASK.md'])]
    before = {str(p.relative_to(ROOT)).replace('\\', '/'): sha(p) for p in protected}
    pilot, preview = read(CAT), read(DAT / 'ANTEPRIMA.json')
    cat_checks, dat_checks = read(CAT_TASK / 'VERIFICHE.json'), read(DAT / 'VERIFICHE.json')
    # Read every specified document as an input, without external access.
    inputs = [CAT, ROOT / 'sources/PERGIOCO-SCOPE.md', CAT_TASK / 'RELAZIONE.md',
              CAT_TASK / 'VERIFICHE.json', *(DAT / n for n in ['PROPOSTA.md', 'ANTEPRIMA.json',
              'MODELLO_CORRENTE.json', 'VERIFICHE.json', 'TASK.md']), ROOT / 'database/schema.sql',
              ROOT / 'database/README.md', ROOT / 'PROJECT.md', ROOT / 'app/README.md',
              ROOT / 'catalog/README.md', ROOT / 'PUBLICATION_POLICY.md', ROOT / 'TASK_GOVERNANCE.md']
    inputs += sorted((ROOT / 'database/migrations').glob('*.sql'))
    input_hashes = {str(p.relative_to(ROOT)).replace('\\', '/'): sha(p) for p in inputs}
    original = {r['candidate_id']: r for r in pilot['records']}
    matrix = []
    for r in preview['records']:
        cat = original[r['candidate_id']]
        matrix.append({
            'candidate_id': r['candidate_id'], 'source_record_key': r['source_record_key'],
            'title_raw': r['title_raw'], 'display_title_qualified': r['display_title_qualified'],
            'source_url': cat['source_url'], 'historical_urls': cat['historical_urls'],
            'observed_at': cat['observed_at'], 'CAT_formalized_at': cat['formalized_at'],
            'EPR_formalized_at': '2026-10-06', 'year_declared': cat['year_declared'],
            'page_updated_raw': cat['page_updated_raw'], 'aliases_declared': cat['aliases_declared'],
            'CAT_outcome': cat['outcome'], 'identity_plan_proposed': r['identity_plan'],
            'record_payload_semantic_sha256': semantic(cat),
            'credits_and_gaps': r['credit_plan'],
            'classification_observations': r['classification_observations'],
            'common_category_mapping': [], 'rules_assessment': cat['rules'],
            'mentions': r['resource_plan'], 'instances': r['instance_plan'],
            'relations_and_limits': cat['relations_and_dependencies'],
            'evidence': cat['evidence'], 'conditions_ref': cat['conditions_ref'],
            'local_matching_evidence': cat['local_matching'],
            'source_artifact': 'catalog/pergioco_pilot_2026-10-06.json',
            'source_pointer': '/records/' + str(pilot['records'].index(cat)),
        })
    by_id = {r['candidate_id']: r for r in matrix}
    resources = [m for r in matrix for m in r['mentions']]
    classifications = [c for r in matrix for c in r['classification_observations']]
    instances = [i for r in matrix for i in r['instances']]
    expected_new = {'PGP-001','PGP-002','PGP-004','PGP-005','PGP-006','PGP-008','PGP-011','PGP-012'}
    checks = {
        'fixed_CAT_hash_matches_both_predecessors': sha(CAT) == cat_checks['manifest_sha256'] == dat_checks['manifest_sha256'],
        'exact_12_candidate_ids': set(by_id) == {f'PGP-{i:03}' for i in range(1,13)} and len(matrix) == 12,
        'DAT_original_payloads_equal_CAT': all(r['original_CAT_record'] == original[r['candidate_id']] for r in preview['records']),
        'CAT_outcomes_9_3': sum(r['CAT_outcome']=='admitted' for r in matrix)==9 and sum(r['CAT_outcome']=='requirement_not_demonstrated' for r in matrix)==3,
        'eight_new_identities_proposed': {r['candidate_id'] for r in matrix if r['identity_plan_proposed']['action']=='create_canonical_after_authorization'} == expected_new,
        'Abande_993_only_candidate': by_id['PGP-003']['identity_plan_proposed']['candidate_game_id']==993 and by_id['PGP-003']['identity_plan_proposed']['match_status']=='candidate',
        'three_requirement_not_demonstrated_source_only': all(by_id[k]['CAT_outcome']=='requirement_not_demonstrated' and not by_id[k]['identity_plan_proposed']['canonical_admission'] for k in ['PGP-007','PGP-009','PGP-010']),
        'Itinera_two_dated_instances_no_solution_matches': len(instances)==2 and {i['published_at'] for i in instances}=={'2021-06-18','2021-07-23'} and all(i['solution_instance_match'] is None for i in instances),
        'Itinera_requested_solution_and_login_final_separate': any(m['payload'].get('kind')=='solutions' and m['payload']['url']=='https://www.pergioco.net/a/itinera-soluzioni.php' and m['payload'].get('final_url')=='https://www.pergioco.net/a/imlogin.php?loginstatus=-3' for m in resources),
        'four_NULL_URL_mentions_preserved': sum(m['payload'].get('url') is None for m in resources)==4,
        'native_classifications_lossless': all(r['classification_observations']==original[r['candidate_id']]['native_classification'] for r in matrix),
        'classifications_have_URL_and_original_date': all(c.get('source_url') and c.get('observed_at') for c in classifications),
        'common_mapping_empty': all(not r['common_category_mapping'] for r in matrix),
        'Beeline_omonimi_heading_preserved': by_id['PGP-011']['title_raw']==by_id['PGP-012']['title_raw']=='Beeline' and by_id['PGP-011']['source_url']!=by_id['PGP-012']['source_url'],
        'Libre_source_assertions_not_canonical_confirmed': len(preview['relationship_plan'])==2 and preview['relationship_plan'][0]['canonical_edge']=='deferred_until_Abande_identity_decision',
        'credits_roles_and_gaps_preserved': all(r['credits_and_gaps']==preview['records'][n]['credit_plan'] for n,r in enumerate(matrix)),
    }
    cases = {'task_id':'TSK-0076', 'proposal_version':'B-v1', 'architecture_adopted':False,
             'executed_import':False, 'new_external_observations':0, 'source_conditions':preview['source_plan']['conditions'],
             'summary':preview['summary'], 'classification_count':len(classifications),
             'mention_count':len(resources), 'distinct_declared_URLs':len({m['payload']['url'] for m in resources if m['payload'].get('url')}),
             'relationship_plan_proposed':preview['relationship_plan'], 'records':matrix}
    write(HERE / 'CASI_PILOTA.json', cases)
    after = {str(p.relative_to(ROOT)).replace('\\','/'):sha(p) for p in protected}
    checks['protected_database_schema_app_authorities_inputs_unchanged'] = before == after
    assert all(checks.values()), checks
    result = {'task_id':'TSK-0076', 'date':'2026-10-06', 'proposal_version':'B-v1',
              'architecture_adopted':False, 'input_sha256':input_hashes, 'checks':checks,
              'matrix_sha256':sha(HERE/'CASI_PILOTA.json'),
              'protected_sha256_before':before, 'protected_sha256_after':after,
              'scope':'Offline documentary projection; no SQLite connection, SQL replay, network, backup or restore executed',
              'limits':['CAT source accuracy not independently reviewed','Historical evidence reused, not newly observed',
                        'Future schema/importer constraints and idempotence require tests on a copy',
                        'Protected hashes cover this verifier execution, not other concurrent work'],
              'writes_to_operational_database':0}
    write(HERE/'VERIFICHE.json', result)
    print(json.dumps({'checks_passed':len(checks), 'candidates':len(matrix), 'classifications':len(classifications),
                      'mentions':len(resources), 'instances':len(instances), 'adopted':False}, ensure_ascii=False))

if __name__ == '__main__':
    main()
