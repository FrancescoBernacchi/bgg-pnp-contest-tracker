"""Read-only progress adapters for sources other than the legacy BGG pipeline.

Completion comes from dated evidence, never from the mere presence of a URL.
No external requests, database writes, or original-file modifications.
"""
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SCOPE_FILE = 'kanare_progress_scope_2026-10-06.json'


def read_manifest(directory, name):
    if not isinstance(name, str) or Path(name).name != name or '/' in name or '\\' in name:
        raise ValueError('Nome manifest non valido')
    value = json.loads((directory / name).read_text(encoding='utf-8-sig'))
    if not isinstance(value, dict):
        raise ValueError('Manifest non strutturato')
    return value


def validate_scope(scope):
    if scope.get('source_key') != 'kanare_abstract' or scope.get('schema_version') != 1:
        raise ValueError('Fonte o versione manifest non valida')
    census = scope.get('census', {})
    if not isinstance(census, dict) or not isinstance(census.get('records', []), list):
        raise ValueError('Perimetro censimento non valido')
    if census.get('records') and not (census.get('verified_at') and census.get('evidence')):
        raise ValueError('Fonte/data censimento mancanti')
    for record in census.get('records', []):
        if not isinstance(record, dict) or not isinstance(record.get('id'), int) or not isinstance(record.get('url'), str):
            raise ValueError('Identità scheda non valida')
    acquisition = scope.get('acquisition', {})
    if not isinstance(acquisition, dict) or not isinstance(acquisition.get('games', []), list):
        raise ValueError('Selezione ACQ non valida')
    ids = set()
    for game in acquisition.get('games', []):
        if (not isinstance(game, dict) or not isinstance(game.get('game_id'), int)
                or game['game_id'] in ids or not game.get('batch_key') or not game.get('verified_at')
                or not isinstance(game.get('required_files', []), list)):
            raise ValueError('Gioco selezionato non valido o duplicato')
        ids.add(game['game_id'])
        for required in game.get('required_files', []):
            if (not isinstance(required, dict) or not isinstance(required.get('resource_url'), str)
                    or not isinstance(required.get('sha256'), str)
                    or not isinstance(required.get('byte_size'), int)):
                raise ValueError('File concordato non valido')


def metric(phase, name, outcomes, *, date=None, scope='', reason='', evidence=None):
    counts = {status: outcomes.count(status) for status in
              ('complete', 'partial', 'blocked', 'unknown', 'not_applicable')}
    total = len(outcomes) - counts['not_applicable']
    return {'phase': phase, 'name': name, 'value': counts['complete'], 'total': total,
            'percent': round(counts['complete'] * 100 / total) if total else None,
            'counts': counts, 'verified_at': date, 'scope': scope, 'reason': reason,
            'evidence': evidence}


def file_matches(row, requirement, library_root):
    """Check registered verification metadata and existence; do not rehash on HTTP."""
    if (row['acquisition_status'] != 'acquired' or row['sha256'] != requirement['sha256']
            or row['byte_size'] != requirement['byte_size']
            or row['language_code'] != requirement.get('language_code')):
        return False
    base = library_root.resolve()
    path = (base / row['relative_path']).resolve()
    try:
        path.relative_to(base)
        return path.is_file() and path.stat().st_size == row['byte_size']
    except (ValueError, OSError):
        return False


def kanare_progress(db, evidence_root=ROOT / 'catalog', library_root=ROOT / 'library'):
    source = db.execute("SELECT * FROM catalog_sources WHERE source_key='kanare_abstract'").fetchone()
    if not source:
        return None
    source_id = source['id']
    records = [dict(r) for r in db.execute(
        "SELECT * FROM source_records WHERE source_id=? AND verification_status!='rejected'", (source_id,))]
    games = [dict(r) for r in db.execute('''SELECT DISTINCT g.id,g.canonical_title FROM games g
        JOIN game_source_records gs ON gs.game_id=g.id JOIN source_records sr ON sr.id=gs.source_record_id
        WHERE sr.source_id=? AND gs.match_status!='rejected' ORDER BY g.canonical_title COLLATE NOCASE,g.id''',
        (source_id,))]
    game_ids = {g['id'] for g in games}
    links = [dict(r) for r in db.execute('''SELECT gs.* FROM game_source_records gs
        JOIN source_records sr ON sr.id=gs.source_record_id WHERE sr.source_id=?''', (source_id,))]
    products = [dict(r) for r in db.execute('''SELECT DISTINCT p.* FROM products p
        JOIN product_source_records ps ON ps.product_id=p.id JOIN source_records sr ON sr.id=ps.source_record_id
        WHERE sr.source_id=? AND ps.match_status!='rejected' ORDER BY p.canonical_name COLLATE NOCASE,p.id''',
        (source_id,))]
    product_links = [dict(r) for r in db.execute('SELECT * FROM product_games WHERE verification_status!=\'rejected\'')]
    warnings = []
    scope = {}
    try:
        scope = read_manifest(evidence_root, SCOPE_FILE)
        validate_scope(scope)
    except (OSError, ValueError, KeyError, TypeError) as error:
        warnings.append('Attestazione del perimetro non disponibile: ' + str(error))
        scope = {}
    census = scope.get('census', {})
    completed_records = {(r['id'], r['url']) for r in census.get('records', [])}
    census_outcomes = ['complete' if (r['id'], r['canonical_url']) in completed_records else 'unknown' for r in records]
    metrics = [metric('census', 'Censimento catalogo', census_outcomes,
        date=census.get('verified_at'), scope='Schede native, inclusi indici e schede prodotto; varianti aggregate comprese negli indici',
        evidence=census.get('evidence'), reason='' if census else 'Completezza del censimento non attestata')]
    material_doc = {}
    material_games = {}
    try:
        if scope.get('materials_manifest'):
            material_doc = read_manifest(evidence_root, scope['materials_manifest'])
            entries = material_doc['games']
            if (not isinstance(entries, list) or not all(isinstance(g, dict) and isinstance(g.get('game_id'), int) for g in entries)
                    or not isinstance(material_doc.get('resources', []), list)
                    or not isinstance(material_doc.get('products', []), list)):
                raise ValueError('Inventario MAT non valido')
            if len({g['game_id'] for g in entries}) != len(entries):
                raise ValueError('Giochi duplicati nel manifest MAT')
            for game in entries:
                for key in ('requirements', 'limits', 'inferences', 'credits', 'official_pages', 'resource_ids', 'historical_resource_ids'):
                    if not isinstance(game.get(key, []), list):
                        raise ValueError('Dettaglio MAT non valido: ' + key)
            if not all(isinstance(r, dict) and isinstance(r.get('id'), int) for r in material_doc.get('resources', [])):
                raise ValueError('Risorse MAT non valide')
            if not all(isinstance(p, dict) and isinstance(p.get('product_id'), int) for p in material_doc.get('products', [])):
                raise ValueError('Confezioni MAT non valide')
            material_games = {g['game_id']: g for g in entries}
    except (OSError, ValueError, KeyError, TypeError) as error:
        warnings.append('Evidenza materiali non disponibile: ' + str(error))
        material_doc, material_games = {}, {}
    resources = {r['id']: r for r in material_doc.get('resources', [])}
    packages = {p['product_id']: p for p in material_doc.get('products', [])}
    selections = scope.get('acquisition', {}).get('games', [])
    selected_by_id = {g['game_id']: g for g in selections}
    stale_selections = set(selected_by_id) - game_ids
    if stale_selections:
        warnings.append('Giochi selezionati fuori dal catalogo corrente: ' + ', '.join(map(str, sorted(stale_selections))))
    registered = [dict(r) for r in db.execute('''SELECT af.*,a.source_snapshot,a.game_id,cr.url
        FROM acquired_files af JOIN acquisitions a ON a.id=af.acquisition_id
        JOIN catalog_resources cr ON cr.id=af.catalog_resource_id''')]
    material_outcomes, acquisition_outcomes = [], []
    for game in games:
        gid = game['id']
        game_links = [link for link in links if link['game_id'] == gid and link['match_status'] != 'rejected']
        game['identity_pending'] = any(link['match_status'] == 'candidate' for link in game_links)
        game['products'] = [dict(p) for p in products if any(
            link['product_id'] == p['id'] and link['game_id'] == gid for link in product_links)]
        mat = material_games.get(gid, {})
        outcome = mat.get('analysis_status', 'unknown')
        if outcome == 'absent' and mat.get('official_pages'):
            outcome = 'complete'
        if outcome not in ('complete', 'partial', 'blocked', 'not_applicable') or not mat.get('verified_at'):
            outcome = 'unknown'
        if outcome == 'complete' and not (mat.get('rule_evidence') or mat.get('official_pages')):
            outcome = 'unknown'
        material_outcomes.append(outcome)
        # Explicitly keep historical/aggregated associations apart from the reviewed rule.
        game['materials'] = {'outcome': outcome, 'verified_at': mat.get('verified_at'),
            'requirements': mat.get('requirements', []), 'limits': mat.get('limits', []),
            'inferences': mat.get('inferences', []), 'credits': mat.get('credits', []),
            'official_pages': mat.get('official_pages', []), 'rule_evidence': mat.get('rule_evidence'),
            'common_components_suffice': mat.get('common_components_suffice'),
            'resources': [{**resources[rid], 'reviewed_rule': rid == mat.get('reviewed_rule_resource_id'),
                           'historical_association': rid in mat.get('historical_resource_ids', [])}
                          for rid in mat.get('resource_ids', []) if rid in resources]}
        for product in game['products']:
            product['material_evidence'] = packages.get(product['id'])
        selection = selected_by_id.get(gid)
        acquisition = {'outcome': 'not_selected', 'files': [], 'required_files': [], 'verified_at': None}
        if selection:
            required = selection.get('required_files', [])
            matched = []
            for requirement in required:
                found = next((row for row in registered if row['url'] == requirement['resource_url']
                    and row['source_snapshot'] == selection['batch_key']
                    and file_matches(row, requirement, library_root)), None)
                if found:
                    matched.append({'id': found['id'], 'original_filename': found['original_filename'],
                                    'language_code': found['language_code'], 'sha256': found['sha256']})
            acq_outcome = 'complete' if required and len(matched) == len(required) else 'partial' if matched else 'blocked'
            if not required:
                acq_outcome = 'not_applicable' if selection.get('outcome') == 'not_applicable' else 'unknown'
            acquisition = {'outcome': acq_outcome, 'files': matched, 'required_files': required,
                'verified_at': selection.get('verified_at'), 'approved_at': selection.get('approved_at'),
                'batch_key': selection['batch_key'], 'scope': selection.get('scope'), 'reason': selection.get('reason')}
            acquisition_outcomes.append(acq_outcome)
        game['acquisition'] = acquisition
        game['images'] = {'outcome': 'not_selected', 'reason': 'Nessun lotto IMG registrato; supporto immagini in task dedicato'}
    # A removed selected game remains an open obligation, not a smaller denominator.
    acquisition_outcomes.extend('blocked' for _ in stale_selections)
    metrics.append(metric('materials', 'Censimento materiali', material_outcomes,
        date=material_doc.get('verified_at'), scope=material_doc.get('scope', 'Tutti i giochi Kanare catalogati'),
        evidence=material_doc.get('task_id'), reason='' if material_doc else 'Nessuna attestazione MAT disponibile'))
    metrics.append(metric('acquisition', 'Acquisizione materiali', acquisition_outcomes,
        date=scope.get('acquisition', {}).get('verified_at'), scope=scope.get('acquisition', {}).get('scope', 'Giochi selezionati'),
        evidence=scope.get('acquisition', {}).get('evidence'), reason='' if selections else 'Nessun lotto ACQ selezionato'))
    metrics.append(metric('image', 'Acquisizione immagini', [], scope='Giochi selezionati nel perimetro IMG',
        reason='Nessun lotto IMG registrato; copertura per categorie e validazione AI dipendono dal supporto immagini'))
    for product in products:
        product['game_ids'] = sorted({link['game_id'] for link in product_links
                                     if link['product_id'] == product['id'] and link['game_id'] in game_ids})
        product['material_evidence'] = packages.get(product['id'])
    return {'source_key': source['source_key'], 'display_name': 'Kanare', 'layout': 'kanare',
        'metrics': metrics, 'games': games, 'products': products, 'warnings': warnings,
        'records': [{'id': r['id'], 'title': r['title_raw'], 'url': r['canonical_url'],
                     'record_type': r['record_type'], 'outcome': outcome,
                     'verified_at': census.get('verified_at') if outcome == 'complete' else None}
                    for r, outcome in zip(records, census_outcomes)],
        'summary': {'games': len(games), 'records': len(records), 'products': len(products),
            'identity_pending': sum(g['identity_pending'] for g in games),
            'candidate_links': sum(link['match_status'] == 'candidate' for link in links),
            'selected_acquisition': len(selections), 'selected_images': 0,
            'games_with_files': sum(bool(g['acquisition']['files']) for g in games)},
        'census_verified_at': census.get('verified_at'), 'materials_verified_at': material_doc.get('verified_at')}


def source_progress(db, **kwargs):
    from pergioco_progress import pergioco_progress
    kanare = kanare_progress(db, **kwargs)
    result = [{'source_key': 'boardgamegeek', 'display_name': 'BGG', 'layout': 'bgg'}] + ([kanare] if kanare else [])
    pergioco = pergioco_progress(db, evidence_root=kwargs.get('evidence_root', ROOT / 'catalog'))
    if pergioco:
        result.append(pergioco)
    supported = {s['source_key'] for s in result}
    result.extend({'source_key': row['source_key'], 'display_name': row['display_name'], 'layout': 'unconfigured'}
                  for row in db.execute('SELECT source_key,display_name FROM catalog_sources ORDER BY display_name')
                  if row['source_key'] not in supported)
    return result
