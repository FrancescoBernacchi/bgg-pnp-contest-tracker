"""Shared, read-only image coverage: completion is an explicit contextual assertion."""
from game_images import select, supported, local_status
import json

def category_research_complete(raw,payload):
    """Normalize explicit research outcomes, never image presence or download date."""
    if isinstance(payload.get('research_complete'),bool):return payload['research_complete']
    text=str(raw or '').strip().casefold()
    if text in ('complete','completed','conclusa','concluso','verificata','verificato',
        'verificata nelle fonti e materiali elencati','verificata nelle fonti elencate, limiti espliciti'):
        return True
    if text in ('partial','parziale','not_started','non esplorata','da esplorare','blocked','impedita') or payload.get('impediment'):
        return False
    return None


def image_summaries(db, library_root=None):
    result = {}
    if not supported(db):
        return result
    for r in select(db, 'SELECT * FROM img_current_research ORDER BY julianday(observed_at),id'):
        g = result.setdefault(r['game_id'], {'categories': {}, 'research': [], 'files': []})
        g['research'].append({k:r[k] for k in ('entry_id','contest_id','complete','observed_at')})
        for c in select(db, 'SELECT * FROM img_category_research WHERE research_id=?',(r['id'],)):
            category=g['categories'].setdefault(c['category'],{'research_observations':[]})
            observations=category['research_observations']
            category.update(dict(c))
            observations.append({'entry_id':r['entry_id'],'contest_id':r['contest_id'],'observed_at':r['observed_at'],
                'complete':category_research_complete(c['research_raw'],json.loads(c['payload_json']))})
    for r in select(db, '''SELECT o.*,f.relative_path,f.format,f.byte_size,f.id AS file_id
        FROM img_current_assets o JOIN img_files f ON f.id=o.file_id ORDER BY o.image_id'''):
        g = result.setdefault(r['game_id'], {'categories': {}, 'research': [], 'files': []})
        r['categories'] = [c['category'] for c in select(db,
            'SELECT category FROM img_categories WHERE observation_id=?',(r['id'],))]
        r['local_status'] = local_status(library_root,r) if library_root else 'unchecked'
        g['files'].append(r)
    selections = {r['game_id']:r for r in select(db,'SELECT * FROM img_current_primary')}
    for gid in selections:
        result.setdefault(gid,{'categories':{},'research':[],'files':[]})
    for gid,g in result.items():
        adopted = [f for f in g['files'] if f['current_use']=='adopted' and
            (f['validation_state']=='approved' if f['origin_kind'].startswith('ai_') else f['validation_state']!='rejected')]
        g['original_count'] = sum(not f['origin_kind'].startswith('ai_') for f in adopted)
        g['ai_count'] = len(adopted)-g['original_count']
        g['pending_count'] = sum(f['validation_state']=='pending' for f in g['files'])
        categories = set(g['categories']) | {c for f in g['files'] for c in f['categories']}
        g['coverage'] = []
        for name in sorted(categories):
            assertion = g['categories'].get(name,{})
            files = [f for f in adopted if name in f['categories']]
            g['coverage'].append({'category':name,'applicability':assertion.get('applicability','unknown'),
                'research_raw':assertion.get('research_raw','Non esplorata'),
                'verified_absence':bool(assertion.get('verified_absence')),
                'research_observations':assertion.get('research_observations',[]),
                'original_count':sum(not f['origin_kind'].startswith('ai_') for f in files),
                'ai_count':sum(f['origin_kind'].startswith('ai_') for f in files),
                'pending_count':sum(name in f['categories'] and f['validation_state']=='pending' for f in g['files'])})
        explicit = selections.get(gid,{}).get('image_id')
        chosen = next((f for f in adopted if f['image_id']==explicit),None)
        candidates = [f for category in ('Copertina','Setup') for f in
            sorted(adopted,key=lambda f:(f['origin_kind'].startswith('ai_'),f['image_id']))
            if category in f['categories'] and f['local_status'] in ('ready','unchecked')]
        usable = chosen if chosen and chosen['local_status'] in ('ready','unchecked') else None
        displayed = usable or next(iter(candidates),None)
        g['main'] = {'file_id':displayed['file_id'] if displayed else None,
            'image_id':displayed['image_id'] if displayed else None,
            'explicit_image_id':explicit,'provisional':not bool(usable),
            'problem':bool(explicit and not usable)}
        g.pop('files');g.pop('categories')
    return result


def entry_image_state(summary, entry_id, contest_id):
    research = next((r for r in summary.get('research',[]) if
        r['entry_id']==entry_id and r['contest_id']==contest_id),None)
    complete = bool(research and research['complete'])
    available = bool(summary.get('original_count',0)+summary.get('ai_count',0))
    return 'complete_with_images' if complete and available else 'complete_without_images' if complete else 'incomplete'


def image_counts(entries, summaries):
    counts = {'image_complete_count':0,'image_with_images_count':0,'image_without_images_count':0,
        'image_incomplete_count':0,'image_original_entry_count':0,'image_ai_entry_count':0}
    for e in entries:
        summary = summaries.get(e['game_id'],{})
        state = entry_image_state(summary,e['id'],e['contest_id'])
        counts['image_incomplete_count'] += state=='incomplete'
        counts['image_complete_count'] += state!='incomplete'
        counts['image_with_images_count'] += state=='complete_with_images'
        counts['image_without_images_count'] += state=='complete_without_images'
        counts['image_original_entry_count'] += bool(summary.get('original_count'))
        counts['image_ai_entry_count'] += bool(summary.get('ai_count'))
    return counts
