"""PerGioco pilot metrics: dated CAT scope and current read-only evidence."""
import json
from pathlib import Path
from source_evidence import record_summaries, tables

ROOT = Path(__file__).resolve().parents[1]


def pergioco_progress(db, evidence_root=ROOT / 'catalog'):
    source = db.execute("SELECT * FROM catalog_sources WHERE source_key='pergioco'").fetchone()
    if not source:
        return None
    result = {'source_key': source['source_key'], 'display_name': source['display_name'],
              'layout': 'pergioco', 'metrics': [], 'warnings': [], 'summary': {}, 'records': []}
    records = record_summaries(db, source['source_key'])
    result['records'] = records
    try:
        scope = json.loads((evidence_root / 'pergioco_pilot_2026-10-06.json').read_text(encoding='utf-8-sig'))
        if scope.get('source_key') != source['source_key'] or not scope.get('observed_at') or not scope.get('task_id'):
            raise ValueError('Identità, data o evidenza del perimetro mancanti')
        candidates = scope['records']
        keys = [c['candidate_id'] for c in candidates]
        if len(set(keys)) != len(keys) or scope.get('candidate_denominator') != len(keys):
            raise ValueError('Perimetro duplicato o denominatore incoerente')
    except (OSError, ValueError, KeyError, TypeError):
        result['warnings'].append('Perimetro CAT del pilota assente o non valido: percentuali non disponibili.')
        scope = {}; keys = []
    current_tables = tables(db)
    key_map = {r['local_key']: r['record_id'] for r in db.execute('SELECT local_key,record_id FROM source_record_keys WHERE source_id=?', (source['id'],))} if 'source_record_keys' in current_tables else {}
    by_id = {r['id']: r for r in records}
    selected = [by_id.get(key_map.get(k)) for k in keys]
    outcomes = [{a['outcome_normalized'] for a in r['admissions']} if r else set() for r in selected]
    admitted = sum(outcome == {'admitted'} for outcome in outcomes)
    not_demonstrated = sum(outcome == {'requirement_not_demonstrated'} for outcome in outcomes)
    if any(len(outcome)>1 for outcome in outcomes):
        result['warnings'].append('Esiti concorrenti non sostituiti: ammissione ignota per i record interessati; consultare la storia.')
    catalogued = sum(bool(r) and any(o['coverage_state']=='complete' and o['coverage_kind']=='pilot_CAT' for o in r['observations']) for r in selected)
    imported = sum(bool(r) and bool(r['observations']) for r in selected)
    confirmed = {m['game_id'] for r in records for m in r['matches'] if m['match_status']=='confirmed'}
    candidates_links = [m for r in records for m in r['matches'] if m['match_status']=='candidate']
    result['summary'] = {'records': len(records), 'scope_records': len(keys) if keys else None,
                         'confirmed_games': len(confirmed), 'candidate_links': len(candidates_links),
                         'source_only': sum(not any(m['match_status']!='rejected' for m in r['matches']) for r in records),
                         'admitted': admitted, 'requirement_not_demonstrated': not_demonstrated,
                         'instances': sum(r['instance_count'] for r in records)}
    for phase, name, value in [('catalog','Catalogazione del pilota',catalogued),
                               ('admission','Requisito di ammissione attestato',admitted),
                               ('import','Importazione del pilota',imported)]:
        result['metrics'].append({'phase':phase,'name':name,'value':value,'total':len(keys) if keys else None,
                                 'percent':round(value*100/len(keys)) if keys else None,
                                 'scope':'Campione autorizzato, non intero sito',
                                 'verified_at':scope.get('observed_at') if phase!='import' else None,
                                 'evidence':scope.get('task_id') if phase!='import' else 'Operativo: chiavi registrate e osservazioni B-v1',
                                 'reason':'Esito del requisito distinto da identità e completamento del lavoro' if phase=='admission' else ''})
    for phase, name in [('materials','Censimento materiali'),('acquisition','Acquisizione materiali'),('image','Immagini')]:
        result['metrics'].append({'phase':phase,'name':name,'value':None,'total':None,'percent':None,
                                 'scope':'Perimetro dedicato da autorizzare',
                                 'reason':'Nessun perimetro e attestazione dedicati; CAT e URL non completano questa fase'})
    if any(r['warnings'] for r in records):
        result['warnings'].append('Evidenze incomplete: consultare gli avvisi delle schede fonte.')
    return result
