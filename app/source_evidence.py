"""Read-only B-v1 record views. No matching, projections, writes or network."""
import json


def rows(db, sql, params=()):
    return [dict(r) for r in db.execute(sql, params)]


def tables(db):
    return {r[0] for r in db.execute("SELECT name FROM sqlite_master WHERE type='table'")}


REQUIRED = {'source_record_observations', 'source_admission_observations',
            'source_classification_observations', 'source_classification_segments',
            'source_credit_observations', 'source_record_url_observations',
            'source_resource_mentions', 'source_resource_mention_observations',
            'resource_url_observations', 'resource_access_observations',
            'condition_observations', 'access_condition_links', 'problem_instances',
            'problem_instance_observations', 'instance_mention_assertions',
            'source_relation_assertions', 'source_identity_decisions',
            'common_classification_mappings'}


def active(items):
    """Only explicit supersession retires evidence; ID/date alone does not."""
    superseded = {r.get('supersedes_id') for r in items if r.get('supersedes_id') is not None}
    return [r for r in items if r['id'] not in superseded]


def safe_payload(value):
    try:
        result = json.loads(value)
        return result if isinstance(result, dict) else {}
    except (ValueError, TypeError):
        return {}


def snapshot(row):
    # Payload/raw_value remain internal. Expose only necessary factual metadata.
    payload = safe_payload(row.pop('payload_json', None))
    row.pop('raw_value', None)
    row['aliases'] = payload.get('aliases_declared', [])
    row['credit_gaps'] = payload.get('missing_credits', [])
    row['components_summary'] = payload.get('components_declared_summary')
    row['coverage_limit'] = payload.get('classification_exhaustiveness')
    row['rules_assessment'] = payload.get('rules', {}).get('assessment')
    return row


def clean(items):
    superseded = {r.get('supersedes_id') for r in items if r.get('supersedes_id') is not None}
    for item in items:
        original = safe_payload(item.pop('raw_value', None))
        item['source_note'] = original.get('note')
        item['is_superseded'] = item['id'] in superseded
    return items


def source_record_detail(db, record_id, library_root=None):
    found = rows(db, '''SELECT sr.id,sr.source_id,sr.record_type,sr.title_raw,sr.canonical_url,
        sr.status_raw,sr.status_normalized,sr.verification_status,sr.observed_at,sr.last_verified_at,
        cs.source_key,cs.display_name AS source_name FROM source_records sr
        JOIN catalog_sources cs ON cs.id=sr.source_id WHERE sr.id=?''', (record_id,))
    if not found:
        raise LookupError('Record fonte non trovato')
    record = found[0]
    result = {'record': record, 'warnings': [], 'observations': [], 'admissions': [],
              'classifications': [], 'credits': [], 'urls': [], 'mentions': [],
              'conditions': [], 'instances': [], 'relations': [], 'identity_history': [],
              'matches': rows(db, '''SELECT gs.*,g.canonical_title FROM game_source_records gs
                  JOIN games g ON g.id=gs.game_id WHERE gs.source_record_id=?''', (record_id,)),
              'files': []}
    missing = REQUIRED - tables(db)
    if missing:
        result['warnings'].append('Schema delle evidenze non disponibile o incompleto; i metadati di base restano consultabili.')
        return result
    observations = rows(db, 'SELECT * FROM source_record_observations WHERE record_id=?', (record_id,))
    result['observations'] = [snapshot(o) for o in observations]
    result['current_observation_ids'] = [o['id'] for o in active(result['observations'])]
    if not observations:
        result['warnings'].append('Nessuna osservazione B-v1 disponibile per questo record.')
    def children(table):
        items = clean(rows(db, f'''SELECT t.* FROM {table} t JOIN source_record_observations o
            ON o.id=t.record_observation_id WHERE o.record_id=? ORDER BY t.id''', (record_id,)))
        for item in items:
            item['historical_snapshot'] = item['record_observation_id'] not in result['current_observation_ids']
        return items
    for key, table in [('admissions','source_admission_observations'),
                       ('classifications','source_classification_observations'),
                       ('credits','source_credit_observations'), ('urls','source_record_url_observations'),
                       ('relations','source_relation_assertions')]:
        result[key] = children(table)
    for classification in result['classifications']:
        classification['segments'] = rows(db, '''SELECT position,label_raw FROM source_classification_segments
            WHERE classification_id=? ORDER BY position''', (classification['id'],))
        classification['common_mappings'] = rows(db, 'SELECT * FROM common_classification_mappings WHERE classification_id=?', (classification['id'],))
    mentions = children('source_resource_mention_observations')
    for mention in mentions:
        declaration = rows(db, 'SELECT label_raw,mention_key FROM source_resource_mentions WHERE id=?', (mention['mention_id'],))[0]
        mention.update(declaration)
        mention['access'] = clean(rows(db, 'SELECT * FROM resource_access_observations WHERE mention_observation_id=? ORDER BY id', (mention['id'],)))
        mention['url_observations'] = clean(rows(db, 'SELECT * FROM resource_url_observations WHERE mention_observation_id=? ORDER BY id', (mention['id'],)))
        for access in mention['access']:
            access['conditions'] = clean(rows(db, '''SELECT c.*,l.applicability_status FROM access_condition_links l
                JOIN condition_observations c ON c.id=l.condition_observation_id WHERE l.access_observation_id=?''', (access['id'],)))
    result['mentions'] = mentions
    result['conditions'] = clean(rows(db, 'SELECT * FROM condition_observations WHERE source_id=? ORDER BY id', (record['source_id'],)))
    result['instances'] = children('problem_instance_observations')
    for instance in result['instances']:
        instance['assertions'] = clean(rows(db, 'SELECT * FROM instance_mention_assertions WHERE instance_observation_id=? ORDER BY id', (instance['id'],)))
    result['identity_history'] = rows(db, 'SELECT * FROM source_identity_decisions WHERE record_id=? ORDER BY id', (record_id,))
    # Only files explicitly attributed to this source record. Candidate canonical files do not qualify.
    if {'acquired_files','acquisitions','catalog_resources'} <= tables(db):
        if library_root is None:
            from pathlib import Path
            library_root = Path(__file__).resolve().parents[1] / 'library'
        from library_catalog import library_catalog
        resource_ids = {r[0] for r in db.execute('SELECT id FROM catalog_resources WHERE source_record_id=?', (record_id,))}
        game_ids = {m['game_id'] for m in result['matches'] if m['match_status']=='confirmed'}
        result['files'] = [f for gid in game_ids for f in library_catalog(db, library_root, gid)['files']
                           if f['catalog_resource_id'] in resource_ids and f['source_key']==record['source_key']]
    return result


def record_summaries(db, source_key=None):
    where = 'WHERE cs.source_key=?' if source_key else ''
    records = rows(db, f'''SELECT sr.id,sr.title_raw,sr.canonical_url,cs.source_key,cs.display_name AS source_name
        FROM source_records sr JOIN catalog_sources cs ON cs.id=sr.source_id {where}
        ORDER BY sr.title_raw COLLATE NOCASE,sr.id''', (source_key,) if source_key else ())
    for record in records:
        detail = source_record_detail(db, record['id'])
        current = set(detail.get('current_observation_ids', []))
        observations = [o for o in detail['observations'] if o['id'] in current]
        record['titles'] = list(dict.fromkeys([record['title_raw']] + [o.get('display_title_qualified') or o.get('title_raw') for o in observations]))
        record['aliases'] = list(dict.fromkeys(a for o in observations for a in o['aliases']))
        record['classifications'] = active([c for c in detail['classifications'] if c['record_observation_id'] in current])
        record['credits'] = active([c for c in detail['credits'] if c['record_observation_id'] in current])
        record['admissions'] = active([a for a in detail['admissions'] if a['record_observation_id'] in current])
        record['matches'] = detail['matches']
        record['observations'] = observations
        record['warnings'] = detail['warnings']
        record['instance_count'] = len({i['instance_id'] for i in detail['instances']})
        record['year_raw'] = next((o['year_raw'] for o in observations if o['year_raw']), None)
    return records
