"""Offline DAT proposal only: reads operational SQLite, writes task JSON artifacts."""
import copy
import hashlib
import json
import sqlite3
from pathlib import Path

TASK = Path(__file__).resolve().parent
ROOT = TASK.parent.parent
MANIFEST = ROOT / 'catalog/pergioco_pilot_2026-10-06.json'
DB = ROOT / 'database/pnp_collection.sqlite3'

def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()

def dump(path, value):
    path.write_text(json.dumps(value, ensure_ascii=False, indent=2) + '\n', encoding='utf-8')

def build():
    before = sha(DB)
    p = json.loads(MANIFEST.read_text(encoding='utf-8'))
    cat = json.loads((ROOT / 'tasks/2026-10-06 - CAT - Pilota PerGioco/VERIFICHE.json').read_text(encoding='utf-8'))
    with sqlite3.connect(DB.resolve().as_uri() + '?mode=ro', uri=True) as db:
        db.execute('PRAGMA query_only=ON')
        schema = {name: sql for name, sql in db.execute("SELECT name,sql FROM sqlite_master WHERE type='table'")}
        counts = {name: db.execute('SELECT count(*) FROM "' + name.replace('"','""') + '"').fetchone()[0] for name in schema}
        abande = db.execute('SELECT id,canonical_title FROM games WHERE id=993').fetchall()
        source = db.execute("SELECT id,source_key FROM catalog_sources WHERE source_key='pergioco'").fetchall()
        matches = {}
        for r in p['records']:
            found = set()
            for name in r['local_matching']['queried_names']:
                found.update(db.execute('SELECT id,canonical_title FROM games WHERE canonical_title=? COLLATE NOCASE UNION SELECT g.id,g.canonical_title FROM game_names n JOIN games g ON g.id=n.game_id WHERE n.name=? COLLATE NOCASE', (name,name)))
            matches[r['candidate_id']] = sorted(found)
        fk = db.execute('PRAGMA foreign_key_check').fetchall()
        integrity = db.execute('PRAGMA integrity_check').fetchall()
    records = []
    for r in p['records']:
        cid = r['candidate_id']
        admitted = r['outcome'] == 'admitted'
        action = 'candidate_link_only' if r['candidate_title'] == 'Abande' else ('create_canonical_after_authorization' if admitted else 'source_record_only')
        resources = []
        for i, resource in enumerate(r['resources']):
            resources.append({'key': f'{cid}:resource:{i+1}', 'destination': 'catalog_resources+source_record_link' if resource.get('url') else 'resource_mention_proposed_or_raw_metadata', 'payload': copy.deepcopy(resource)})
        instances = [{'key': f'{cid}:instance:{date}', 'published_at': date, 'source_url': res['url'], 'observed_at': res['observed_at'], 'provenance': res.get('provenance'), 'counts_as_game': False, 'solution_instance_match': None} for res in r['resources'] for date in res.get('instance_dates', [])]
        records.append({'candidate_id': cid, 'source_record_key': f'pergioco:pilot:{cid}', 'native_id_policy': 'NULL: PGP identifiers are local, not PerGioco native IDs', 'canonical_url': r['source_url'], 'title_raw': r['title_original'], 'display_title_qualified': r['title_normalized'], 'identity_plan': {'action': action, 'symbolic_game_key': cid if action == 'create_canonical_after_authorization' else None, 'candidate_game_id': 993 if action == 'candidate_link_only' else None, 'match_status': 'candidate' if action == 'candidate_link_only' else ('confirmed_new_local_identity_proposed' if admitted else None), 'canonical_admission': admitted, 'identity_equivalence_decided': False}, 'credit_plan': {'target': 'source_record', 'named': [c for c in r['credits'] if c.get('name')], 'missing_or_unnamed': [c for c in r['credits'] if not c.get('name')], 'missing_roles': r['missing_credits'], 'person_resolution': 'manual role/name review; no same-name person merge'}, 'classification_observations': copy.deepcopy(r['native_classification']), 'common_category_mapping': [], 'resource_plan': resources, 'instance_plan': instances, 'original_CAT_record': copy.deepcopy(r)})
    preview = {'task_id':'TSK-0075', 'date':'2026-10-06', 'executed_import':False, 'architecture_adopted':False, 'input_manifest_sha256':sha(MANIFEST), 'source_plan': {'source_key':'pergioco', 'action':'create_after_authorization' if not source else 'reconcile_existing', 'conditions':p['conditions'], 'method':p['method']}, 'summary': {'source_records':12, 'CAT_admitted':9, 'CAT_requirement_not_demonstrated':3, 'proposed_new_canonical_games':8, 'candidate_links_to_existing_games':1, 'non_admitted_source_only':3, 'Itinera_games':1, 'Itinera_instances':2, 'products_to_create':0, 'implementations_to_create':0}, 'relationship_plan': [{'from':'PGP-004', 'to_source_record':'PGP-003', 'type':'variant_of', 'state':'declared_by_source', 'canonical_edge':'deferred_until_Abande_identity_decision'}, {'from':'PGP-004', 'to_source_record':'PGP-003', 'type':'base_rules_information_required', 'resource_url':'https://www.pergioco.net/1/abande.html', 'requires_purchase':None, 'note':'Informational dependency, not a physical base game requirement'}], 'records':records}
    checks = {'CAT_input_hash_matches':sha(MANIFEST)==cat['manifest_sha256'], 'exact_CAT_records_preserved':all(a['original_CAT_record']==b for a,b in zip(records,p['records'])), '12_unique_records':len(records)==len({r['candidate_id'] for r in records})==12, '12_unique_urls':len({r['canonical_url'] for r in records})==12, '9_admitted':sum(r['outcome']=='admitted' for r in p['records'])==9, '3_source_only':sum(r['identity_plan']['action']=='source_record_only' for r in records)==3, '8_new_games':sum(r['identity_plan']['action']=='create_canonical_after_authorization' for r in records)==8, 'Abande_993_candidate':abande==[(993,'Abande')] and next(r for r in records if r['candidate_id']=='PGP-003')['identity_plan']['candidate_game_id']==993, 'Itinera_2_instances':len(next(r for r in records if r['candidate_id']=='PGP-006')['instance_plan'])==2, 'classification_lossless':all(a['classification_observations']==b['native_classification'] for a,b in zip(records,p['records'])), 'no_inferred_categories':all(not r['common_category_mapping'] for r in records), 'foreign_keys_clean':not fk, 'integrity_ok':integrity==[('ok',)], 'database_unchanged':before==sha(DB)}
    dump(TASK/'ANTEPRIMA.json',preview)
    dump(TASK/'MODELLO_CORRENTE.json',{'date':'2026-10-06','access':'mode=ro + query_only','table_counts':counts,'schema':schema,'existing_pergioco_source':source,'Abande_993':abande,'exact_local_matches':matches,'matching_limit':'Exact title/registered alias lookup only; not identity equivalence'})
    dump(TASK/'VERIFICHE.json',{'task_id':'TSK-0075','date':'2026-10-06','database_sha256_before':before,'database_sha256_after':sha(DB),'manifest_sha256':sha(MANIFEST),'preview_sha256':sha(TASK/'ANTEPRIMA.json'),'checks':checks,'idempotence_test':'Deterministic JSON regeneration; no SQL import replay performed', 'writes_to_operational_database':0})
    assert all(checks.values()), checks
    print(json.dumps({'checks':checks,'summary':preview['summary']},ensure_ascii=False))

if __name__ == '__main__':
    build()
