"""Metriche condivise di lavoro concluso; nessuna verifica negativa implicita."""
import json


def enrich_work_progress(db, contests):
    tables = {r[0] for r in db.execute("SELECT name FROM sqlite_master WHERE type='table'")}
    observations = {}
    if 'entry_work_observations' in tables:
        for row in db.execute('SELECT * FROM entry_work_observations ORDER BY julianday(observed_at),id'):
            observations[(row['entry_id'], row['phase'])] = dict(row)
    census = {}
    if 'contest_census_observations' in tables:
        for row in db.execute('SELECT * FROM contest_census_observations ORDER BY julianday(observed_at),id'):
            census[row['contest_id']] = dict(row)
    for contest in contests:
        cid = contest['contest_id']
        entries = list(db.execute('SELECT id,game_id FROM entries WHERE contest_id=?', (cid,)))
        ids = {e['id'] for e in entries}
        if 'ranked_entry_count' not in contest:
            ranked_games = {r[0] for r in db.execute('SELECT game_id FROM rankings WHERE contest_id=?', (cid,))}
            contest['ranked_entry_count'] = sum(e['game_id'] in ranked_games for e in entries)
        roster = census.get(cid)
        contest['census_complete_count'] = int(bool(roster and roster['outcome'] == 'complete'
            and set(json.loads(roster['entry_ids_json'])) == ids))
        for phase in ('ranking', 'materials', 'acquisition'):
            complete = excluded = blocked = partial = 0
            for entry in entries:
                explicit = observations.get((entry['id'], phase))
                outcome = explicit['outcome'] if explicit else 'unknown'
                # Il contratto MAT termina al primo post; le regole sono integrazione successiva.
                scan = db.execute('SELECT * FROM entry_material_scans WHERE entry_id=? '
                    'ORDER BY julianday(checked_at) DESC,id DESC LIMIT 1', (entry['id'],)).fetchone()
                if not explicit and phase == 'materials' and scan:
                    if scan['material_listing_status'] in ('observed', 'none_declared'):
                        outcome = 'complete'
                    elif scan['material_listing_status'] == 'not_observable':
                        outcome = 'blocked'
                if not explicit and phase == 'acquisition' and scan:
                    if scan['material_listing_status'] == 'none_declared':
                        outcome = 'not_applicable'
                    elif scan['material_listing_status'] == 'observed':
                        resources = {r[0] for r in db.execute('SELECT remote_resource_id FROM entry_resource_mentions WHERE entry_id=?', (entry['id'],))}
                        acquired = {r[0] for r in db.execute("SELECT af.remote_resource_id FROM acquired_files af JOIN acquisitions a ON a.id=af.acquisition_id WHERE a.game_id=? AND af.acquisition_status='acquired'", (entry['game_id'],))}
                        if resources and resources <= acquired:
                            outcome = 'complete'
                    elif scan['material_listing_status'] == 'not_observable':
                        outcome = 'blocked'
                excluded += outcome == 'not_applicable'
                complete += outcome in ('complete', 'absent')
                blocked += outcome == 'blocked'
                partial += outcome == 'partial'
            contest[phase + '_complete_count'] = complete
            contest[phase + '_not_applicable_count'] = excluded
            contest[phase + '_blocked_count'] = blocked
            contest[phase + '_partial_count'] = partial
            contest[phase + '_total'] = len(entries) - excluded
        contest['image_complete_count'] = 0
    return contests


def summarize_work(contests):
    result = {'census_complete_count': sum(c['census_complete_count'] for c in contests),
              'census_incomplete_count': sum(not c['census_complete_count'] for c in contests),
              'contests_without_entries_count': sum(c['entry_count'] == 0 for c in contests)}
    for phase in ('ranking', 'materials', 'acquisition'):
        for suffix in ('complete_count', 'not_applicable_count', 'blocked_count', 'partial_count', 'total'):
            key = phase + '_' + suffix
            result[key] = sum(c[key] for c in contests)
    result['image_complete_count'] = 0
    return result
