"""One-time offline reconciliation of historical census and approved ACQ evidence."""
import hashlib
import json
import sqlite3
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]


def main():
    db = sqlite3.connect((ROOT / 'database/pnp_collection.sqlite3').as_uri() + '?mode=ro', uri=True)
    db.row_factory = sqlite3.Row
    source_id = db.execute("SELECT id FROM catalog_sources WHERE source_key='kanare_abstract'").fetchone()[0]
    records = [dict(r) for r in db.execute('SELECT * FROM source_records WHERE source_id=? ORDER BY id', (source_id,))]
    # All 76 native records belong to the completed 2026-09-20 census; later
    # destination checks changed verification, not the census perimeter.
    assert len(records) == 76
    assert all(r['observed_at'].startswith('2026-09-20') for r in records)
    batch_path = ROOT / 'catalog/kanare_abstract_acquisition_batch_2026-09-21.json'
    batch = json.loads(batch_path.read_text(encoding='utf-8'))
    selections, verified_files = [], []
    for item in batch['items']:
        rows = db.execute('''SELECT af.*,a.game_id FROM acquired_files af
            JOIN acquisitions a ON a.id=af.acquisition_id JOIN catalog_resources cr ON cr.id=af.catalog_resource_id
            WHERE a.source_snapshot=? AND cr.url=?''', (batch['batch_key'], item['resource_url'])).fetchall()
        assert len(rows) == 1
        row = rows[0]
        assert row['sha256'] == item['sha256'] and row['byte_size'] == item['byte_size']
        path = ROOT / 'library' / row['relative_path']
        digest = hashlib.sha256(path.read_bytes()).hexdigest()
        assert digest == row['sha256'] and path.stat().st_size == row['byte_size']
        verified_files.append({'file_id': row['id'], 'game_id': row['game_id'], 'sha256': digest})
        selections.append({'game_id': row['game_id'], 'batch_key': batch['batch_key'],
            'approved_at': batch['approved_at'], 'verified_at': batch['acquired_at'],
            'scope': 'Un PDF EN per gioco; per Pentwall include plancia stampabile',
            'reason': item['selection_reason'],
            'required_files': [{k: item[k] for k in ('resource_url', 'language_code', 'sha256', 'byte_size')}]})
    document = {'schema_version': 1, 'source_key': 'kanare_abstract',
        'formalized_at': '2026-10-06', 'task_id': 'TSK-0071',
        'census': {'verified_at': '2026-09-20', 'evidence': 'TSK-0020',
            'source_urls': ['https://kanare-abstract.com/en/pages/games_by_kanare',
                            'https://kanare-abstract.com/en/collections/all',
                            'https://kanare-abstract.com/en/pages/online_play'],
            'records': [{'id': r['id'], 'url': r['canonical_url'], 'record_type': r['record_type']} for r in records]},
        'materials_manifest': 'kanare_material_census_2026-10-06.json',
        'acquisition': {'verified_at': '2026-09-21', 'evidence': 'TSK-0023',
            'scope': 'Lotto approvato 2026-09-21: tre PDF EN, esclusi JA, immagini e implementazioni online',
            'games': selections}}
    (ROOT / 'catalog/kanare_progress_scope_2026-10-06.json').write_text(
        json.dumps(document, ensure_ascii=False, indent=2) + '\n', encoding='utf-8')
    print(json.dumps({'census_records': len(records), 'acquisition_games': len(selections),
                      'files_rehashed': verified_files}, ensure_ascii=False))


if __name__ == '__main__':
    main()
