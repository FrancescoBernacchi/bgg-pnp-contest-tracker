"""Verifiche offline dei deliverable CAT; nessuna scrittura al database."""
import hashlib
import importlib.util
import json
from collections import Counter
from pathlib import Path

ROOT=Path(__file__).resolve().parents[2]
TASK=Path(__file__).resolve().parent
MP=ROOT/'catalog/pergioco_extension_carta_matita_2026-10-08.json'
m=json.loads(MP.read_text(encoding='utf-8'))
pilot=json.loads((ROOT/'catalog/pergioco_pilot_2026-10-06.json').read_text(encoding='utf-8'))
baseline=json.loads((TASK/'BASELINE.json').read_text(encoding='utf-8'))
checks=[]
def check(name,condition):
    checks.append(dict(name=name,passed=bool(condition)))
    if not condition: raise AssertionError(name)

rs=m['records']
check('nove_candidate_confermate',len(rs)==m['candidate_denominator']==m['censused_count']==9)
check('id_stabili_unici',len({r['candidate_id'] for r in rs})==9 and len({r['local_record_key'] for r in rs})==9 and len({r['event_key'] for r in rs})==9)
check('URL_finali_unici',len({r['source_url'] for r in rs})==9)
check('nessun_ricensimento_pilota',not ({r['source_url'] for r in rs}&{r['source_url'] for r in pilot['records']}))
check('indice_riconciliato_10_1_9',m['index_observation']['entries']==len(rs)+len(m['index_observation']['previously_censused']) and m['index_observation']['previously_censused'][0]['pilot_id']=='PGP-005')
counts=Counter(r['outcome'] for r in rs)
check('esiti_7_2_0',counts=={'admitted':7,'requirement_not_demonstrated':2} and m['not_observable_count']==0)
check('titoli_originali_alias_qualificazioni',all(r['title_original'] and isinstance(r['aliases_declared'],list) and r['requested_url'] and r['final_url'] for r in rs))
check('classificazioni_native_multiple_con_provenienza',all(len(r['native_classification'])==2 and all(c['path'] and c['source_url'] and c['observed_at']=='2026-10-08' for c in r['native_classification']) for r in rs))
check('crediti_ruoli_lacune_contesti',all(all(c['role_raw'] and c['source_url'] and c['observed_at'] and ('name_raw' in c) for c in r['credits']) and any(c['name_raw'] is None for c in r['credits']) for r in rs))
check('NULL_regole_incomplete_non_pagamento',all(r['rules']['complete_rules_free'] is None and r['access_assessments'][1]['cost_status']=='unknown' for r in rs if r['outcome']!='admitted'))
check('regole_complete_gratuite_solo_ammissibili',all(r['rules']['complete_rules_free'] is True for r in rs if r['outcome']=='admitted'))
check('ambiti_accesso_distinti',all({a['subject_scope'] for a in r['access_assessments']}=={'public_content','complete_rules','components_product','online_implementation'} for r in rs))
check('matching_solo_candidato_o_assenza_esatta',all(r['local_matching']['status'] in ('candidate','no_exact_match') and r['local_matching']['checked_at']=='2026-10-08' for r in rs))
check('Punti_e_linee_raccolta_non_fusa_Quadratini',rs[5]['entity_kind_observed']=='editorial_collection' and rs[5]['outcome']=='requirement_not_demonstrated' and 'Punti e Linee' in rs[6]['aliases_declared'])
check('Piattola_varianti_distinte_fuori_denominatore',len(rs[4]['embedded_variants'])==7 and all(not v['cataloged_as_separate_candidate'] and not v['admission_separately_assessed'] for v in rs[4]['embedded_variants']))
check('Labirinto_un_sistema_tre_istanze',len(rs[2]['instances'])==3 and len({i['instance_key'] for i in rs[2]['instances']})==3 and all(i['usable_scheme_observed'] is None for i in rs[2]['instances']))
check('licenza_non_inferita_da_gratuita',m['conditions']['permission_state']=='not_attested_for_public_redistribution')
check('nessuna_importazione_o_acquisizione',m['imported_count']==m['downloaded_count']==0 and not m['method']['systematic_material_census'] and not m['method']['external_hosts_checked'])
check('nessuna_esaustivita_sito',m['full_site_census'] is False and m['method']['classification_mapping']==[])
changed=[p for p,h in baseline['files'].items() if not (ROOT/p).is_file() or hashlib.sha256((ROOT/p).read_bytes()).hexdigest()!=h]
check('baseline_database_app_schema_pilota_preservata',not changed)
registry=json.loads((ROOT/'tasks/REGISTRY.json').read_text(encoding='utf-8'))
check('id_task_unico_e_predecessori_conclusi',sum(t['id']=='TSK-0080' for t in registry['tasks'])==1 and all(next(t for t in registry['tasks'] if t['id']==key)['status']=='completato' for key in ['TSK-0073','TSK-0074','TSK-0078','TSK-0079']))

# Audit euristico anche dei nuovi file non tracciati; revisione manuale separata.
spec=importlib.util.spec_from_file_location('publication_audit',ROOT/'catalog/audit_publication.py')
audit=importlib.util.module_from_spec(spec);spec.loader.exec_module(audit)
targets=[MP]+[p for p in TASK.iterdir() if p.is_file() and p.suffix in ('.md','.py','.json')]
findings=[]
for p in targets:
    findings+=audit.inspect(p.relative_to(ROOT).as_posix(),p.read_bytes(),'TSK-0080_new_local',False)
check('audit_euristico_nuovi_deliverable',not findings)
report=dict(task_id='TSK-0080',checked_at='2026-10-08',checks=checks,passed=len(checks),failed=0,manifest_sha256=hashlib.sha256(MP.read_bytes()).hexdigest(),baseline_files_checked=len(baseline['files']),baseline_changed_files=changed,matching_records_with_exact_candidates=sum(bool(r['local_matching']['matches'] or r['local_matching']['source_url_matches']) for r in rs),publication_findings=findings,publication_review_original_summaries_only=True,limits=['Verifiche dei dati raccolti, non playtest né verifica storica indipendente.','Matching esatto: nessun equivalente semantico garantito.','Baseline file raccolta prima della formalizzazione del manifest; non misura processi esterni concorrenti prima di quel momento.','Audit euristico non certifica diritti o liceità; nessun commit/push eseguito.'])
(TASK/'VERIFICHE.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
print(json.dumps(dict(passed=len(checks),baseline_files=len(baseline['files']),changed_files=changed,publication_findings=len(findings)),ensure_ascii=False))
