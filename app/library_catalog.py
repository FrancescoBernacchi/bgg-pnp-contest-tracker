"""Metadati locali e idoneità PDF: lettura confinata di header/coda, nessuna rete."""
from collections import Counter
from pathlib import Path, PureWindowsPath
from urllib.parse import urlsplit
from material_files import material_status, KINDS


def local_presence(root, relative):
    if not isinstance(relative, str) or not relative or '\x00' in relative:
        return 'invalid_path'
    normalized = relative.replace('\\', '/')
    win = PureWindowsPath(relative)
    if win.drive or win.root or normalized.startswith('/') or ':' in normalized or '..' in normalized.split('/'):
        return 'invalid_path'
    try:
        # Resolving links/reparse points must still yield a descendant of the authorized root.
        root = Path(root).resolve()
        target = (root / normalized).resolve()
        if not target.is_relative_to(root) or target == root:
            return 'invalid_path'
        return 'present' if target.is_file() else 'missing'
    except (OSError, ValueError, RuntimeError):
        return 'unverifiable'


def safe_url(value):
    try:
        parsed = urlsplit(value or '')
        if parsed.scheme == 'https' and parsed.hostname and not parsed.username and not parsed.password:
            return value
    except ValueError:
        pass
    return None


def library_catalog(db, root, game_id=None):
    has_archives = db.execute("SELECT 1 FROM sqlite_master WHERE name='archive_contents'").fetchone() is not None
    acquisitions = [dict(r) for r in db.execute('''SELECT a.id,a.game_id,a.acquired_at,
        a.game_status_at_acquisition,g.canonical_title FROM acquisitions a
        JOIN games g ON g.id=a.game_id ORDER BY g.canonical_title COLLATE NOCASE,a.acquired_at,a.id''')
        if game_id is None or r['game_id'] == game_id]
    files = []
    for acquisition in acquisitions:
        acquisition['completeness'] = 'unknown'
        acquisition['files'] = []
        for row in db.execute('''SELECT af.id,af.relative_path,af.original_filename,af.media_type,
            af.byte_size,af.sha256,af.version_raw,af.language_code,af.acquisition_status,
            af.usage_conditions,af.remote_resource_id,af.catalog_resource_id,
            COALESCE(af.final_url,rr.url,cr.url) AS source_url,
            COALESCE(rr.availability_status,cr.availability_status,'unknown') AS remote_status,
            cs.source_key,cs.display_name AS source_name
            FROM acquired_files af LEFT JOIN remote_resources rr ON rr.id=af.remote_resource_id
            LEFT JOIN catalog_resources cr ON cr.id=af.catalog_resource_id
            LEFT JOIN source_records sr ON sr.id=cr.source_record_id
            LEFT JOIN catalog_sources cs ON cs.id=sr.source_id
            WHERE af.acquisition_id=? ORDER BY af.id''', (acquisition['id'],)):
            file = dict(row)
            relative = file.pop('relative_path')
            file['local_status'] = local_presence(root, relative)
            file['viewer_status'] = material_status(root, relative, file['media_type'], file['acquisition_status'])
            file['viewer_kind'] = KINDS.get(file['media_type']) if file['viewer_status'] == 'ready' else None
            file['archive_origin'] = None
            file['extraction'] = None
            if has_archives:
                origin = db.execute('SELECT archive_file_id,archive_sha256,member_path,extracted_at FROM archive_contents WHERE file_id=?', (file['id'],)).fetchone()
                file['archive_origin'] = dict(origin) if origin else None
                extraction = db.execute('SELECT status,message,checked_at FROM archive_extractions WHERE archive_file_id=? AND archive_sha256=?', (file['id'], file['sha256'])).fetchone()
                file['extraction'] = dict(extraction) if extraction else None
            file['local_present'] = file['local_status'] == 'present'
            file['source_url'] = safe_url(file['source_url'])
            file['contests'] = []
            # Attribute BGG contest provenance only through the registered remote resource mention.
            if file['remote_resource_id'] is not None:
                file['source_key'], file['source_name'] = 'boardgamegeek', 'BoardGameGeek'
                file['contests'] = [dict(c) for c in db.execute('''SELECT DISTINCT c.id,c.name,c.year
                    FROM entry_resource_mentions m JOIN entries e ON e.id=m.entry_id
                    JOIN contests c ON c.id=e.contest_id WHERE m.remote_resource_id=? AND e.game_id=?
                    ORDER BY c.year,c.id''', (file['remote_resource_id'], acquisition['game_id']))]
            file['source_key'] = file['source_key'] or 'unknown'
            file['source_name'] = file['source_name'] or 'Fonte non determinabile'
            file.update({k: acquisition[k] for k in ('game_id', 'canonical_title', 'acquired_at')})
            file['acquisition_id'] = acquisition['id']
            acquisition['files'].append(file)
            files.append(file)
        statuses = {file['acquisition_status'] for file in acquisition['files']}
        # Mixed explicit successes/failures establish a partial registered batch,
        # never completeness relative to all materials a game might need.
        acquisition['status'] = 'partial' if statuses == {'acquired', 'failed'} else 'unknown'
        for file in acquisition['files']:
            file['batch_status'] = acquisition['status']
    def distribution(key):
        return [{'value': k, 'files': v} for k, v in sorted(Counter(f[key] or 'Non registrato' for f in files).items())]
    contests = Counter((c['id'], c['name'], c['year']) for f in files for c in f['contests'])
    return {'acquisitions': acquisitions, 'files': files,
            'library_available': Path(root).is_dir(),
            'summary': {'games': len({f['game_id'] for f in files}), 'acquisitions': len(acquisitions),
                        'files': len(files), 'bytes': sum(f['byte_size'] for f in files),
                        'present': sum(f['local_present'] for f in files),
                        'missing': sum(f['local_status'] == 'missing' for f in files),
                        'unverifiable': sum(f['local_status'] in ('invalid_path', 'unverifiable') for f in files),
                        'sources': distribution('source_name'), 'languages': distribution('language_code'),
                        'types': distribution('media_type'),
                        'contests': [{'id': k[0], 'value': k[1], 'year': k[2], 'files': v} for k,v in sorted(contests.items())]}}
