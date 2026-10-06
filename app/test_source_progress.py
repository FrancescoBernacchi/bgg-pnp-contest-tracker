"""Progress denominators and evidence semantics on an isolated, synthetic source."""
import hashlib
import json
from pathlib import Path
import sqlite3
import tempfile
import unittest

from source_progress import kanare_progress, source_progress, SCOPE_FILE, ROOT


class SourceProgressTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.directory = Path(self.temp.name)
        self.library = self.directory / 'library'
        self.library.mkdir()
        self.db = sqlite3.connect(':memory:')
        self.db.row_factory = sqlite3.Row
        self.db.executescript((ROOT / 'database/schema.sql').read_text(encoding='utf-8'))
        self.insert('catalog_sources', id=1, source_key='kanare_abstract', display_name='Kanare', source_kind='publisher')
        for gid in (1, 2, 3):
            self.insert('games', id=gid, canonical_title=f'Game {gid}')
        for rid in (1, 2):
            self.insert('source_records', id=rid, source_id=1, record_type='game_page', canonical_url=f'https://example.test/game/{rid}', title_raw=f'Game {rid}')
        for gid, rid, status in ((1, 1, 'confirmed'), (2, 2, 'candidate'), (3, 2, 'rejected')):
            self.insert('game_source_records', game_id=gid, source_record_id=rid, match_status=status)
        self.insert('products', id=1, canonical_name='Shared box')
        self.insert('product_source_records', product_id=1, source_record_id=1)
        for gid in (1, 2):
            self.insert('product_games', product_id=1, game_id=gid)
        self.insert('catalog_resources', id=1, resource_kind='rulebook', url='https://example.test/rules.pdf')
        self.insert('acquisitions', id=1, game_id=1, acquired_at='2026-09-21', selection_reason='Test', game_status_at_acquisition='complete', source_snapshot='approved')
        data = b'synthetic bytes'
        self.sha = hashlib.sha256(data).hexdigest()
        (self.library / 'shared.pdf').write_bytes(data)
        self.insert('acquired_files', id=1, acquisition_id=1, catalog_resource_id=1, relative_path='shared.pdf', original_filename='shared.pdf', byte_size=len(data), sha256=self.sha, language_code='en')
        required = {'resource_url': 'https://example.test/rules.pdf', 'sha256': self.sha, 'byte_size': len(data), 'language_code': 'en'}
        self.scope = {'schema_version': 1, 'source_key': 'kanare_abstract',
            'census': {'verified_at': '2026-09-20', 'evidence': 'historical',
                'records': [{'id': rid, 'url': f'https://example.test/game/{rid}'} for rid in (1, 2)]},
            'materials_manifest': 'materials.json',
            'acquisition': {'verified_at': '2026-09-21', 'games': [
                {'game_id': gid, 'batch_key': 'approved', 'verified_at': '2026-09-21', 'required_files': [required]} for gid in (1, 2)]}}
        self.materials = {'task_id': 'MAT-test', 'verified_at': '2026-10-06', 'games': [
            {'game_id': 1, 'analysis_status': 'complete', 'verified_at': '2026-10-06', 'official_pages': ['https://example.test/game/1']},
            {'game_id': 2, 'analysis_status': 'blocked', 'verified_at': '2026-10-06', 'limits': ['Unavailable']}]}
        self.write()

    def insert(self, table, **values):
        columns = {r[1] for r in self.db.execute(f'PRAGMA table_info({table})')}
        defaults = {k: '2026-09-20' for k in ('first_seen_at', 'last_verified_at', 'observed_at') if k in columns}
        if 'source_url' in columns:
            defaults['source_url'] = 'https://example.test/'
        values = {**defaults, **values}
        self.db.execute(f"INSERT INTO {table} ({','.join(values)}) VALUES ({','.join('?' for _ in values)})", tuple(values.values()))

    def write(self):
        (self.directory / SCOPE_FILE).write_text(json.dumps(self.scope), encoding='utf-8')
        (self.directory / 'materials.json').write_text(json.dumps(self.materials), encoding='utf-8')

    def progress(self):
        return kanare_progress(self.db, self.directory, self.library)

    def tearDown(self):
        self.db.close()
        self.temp.cleanup()

    def test_shared_file_and_product_do_not_duplicate_games(self):
        p = self.progress()
        self.assertEqual(p['summary']['games'], 2)
        self.assertEqual(p['summary']['products'], 1)
        self.assertEqual(p['summary']['identity_pending'], 1)
        self.assertEqual(p['products'][0]['game_ids'], [1, 2])
        self.assertEqual(p['metrics'][2]['value'], 2)
        self.assertEqual(p['metrics'][2]['total'], 2)
        self.assertEqual(p['metrics'][1]['value'], 1)
        self.assertEqual(p['metrics'][1]['counts']['blocked'], 1)
        self.assertEqual(p['metrics'][3]['percent'], None)

    def test_new_game_and_record_reduce_completion_without_inventing_evidence(self):
        self.insert('source_records', id=3, source_id=1, record_type='game_page', canonical_url='https://example.test/new')
        self.insert('game_source_records', game_id=3, source_record_id=3, match_status='confirmed')
        p = self.progress()
        self.assertEqual((p['metrics'][0]['value'], p['metrics'][0]['total']), (2, 3))
        self.assertEqual((p['metrics'][1]['value'], p['metrics'][1]['total']), (1, 3))
        self.assertEqual(p['metrics'][1]['counts']['unknown'], 1)
        self.assertEqual(p['metrics'][2]['total'], 2)

    def test_missing_file_blocks_selected_games(self):
        (self.library / 'shared.pdf').unlink()
        p = self.progress()
        self.assertEqual((p['metrics'][2]['value'], p['metrics'][2]['total']), (0, 2))
        self.assertEqual(p['metrics'][2]['counts']['blocked'], 2)

    def test_hash_or_language_mismatch_never_completes(self):
        self.db.execute("UPDATE acquired_files SET language_code='ja'")
        self.assertEqual(self.progress()['metrics'][2]['value'], 0)
        self.db.execute("UPDATE acquired_files SET language_code='en',sha256='wrong'")
        self.assertEqual(self.progress()['metrics'][2]['value'], 0)

    def test_removed_selected_game_stays_in_denominator(self):
        self.db.execute("UPDATE game_source_records SET match_status='rejected' WHERE game_id=2")
        p = self.progress()
        self.assertEqual((p['metrics'][2]['value'], p['metrics'][2]['total']), (1, 2))
        self.assertTrue(p['warnings'])

    def test_missing_or_invalid_manifest_keeps_bgg_and_unknowns(self):
        (self.directory / 'materials.json').write_text('{bad', encoding='utf-8')
        p = self.progress()
        self.assertEqual(p['metrics'][1]['counts']['unknown'], 2)
        self.assertTrue(p['warnings'])
        (self.directory / SCOPE_FILE).unlink()
        profiles = source_progress(self.db, evidence_root=self.directory, library_root=self.library)
        self.assertEqual(profiles[0]['layout'], 'bgg')
        self.assertEqual(profiles[1]['metrics'][0]['counts']['unknown'], 2)

    def test_explicit_non_applicability_and_partial_remain_distinct(self):
        self.materials['games'][0]['analysis_status'] = 'not_applicable'
        self.materials['games'][1]['analysis_status'] = 'partial'
        self.write()
        p = self.progress()
        self.assertEqual(p['metrics'][1]['total'], 1)
        self.assertEqual(p['metrics'][1]['counts']['not_applicable'], 1)
        self.assertEqual(p['metrics'][1]['counts']['partial'], 1)
        self.assertEqual(p['metrics'][1]['value'], 0)

    def test_read_only_and_confinement(self):
        self.db.execute("UPDATE acquired_files SET relative_path='../outside.pdf'")
        (self.directory / 'outside.pdf').write_bytes(b'synthetic bytes')
        self.db.commit()
        self.db.execute('PRAGMA query_only=ON')
        self.assertEqual(self.progress()['metrics'][2]['value'], 0)

    def test_invalid_scope_and_duplicate_material_records_fail_conservatively(self):
        original = json.loads(json.dumps(self.scope))
        self.scope['acquisition']['games'][0]['required_files'] = 'not a list'
        self.write()
        p = self.progress()
        self.assertTrue(p['warnings'])
        self.assertEqual(p['metrics'][0]['value'], 0)
        self.assertEqual(p['metrics'][2]['percent'], None)
        self.scope = original
        self.materials['games'].append(dict(self.materials['games'][0]))
        self.write()
        p = self.progress()
        self.assertTrue(p['warnings'])
        self.assertEqual(p['metrics'][1]['counts']['unknown'], 2)

    def test_explicit_absence_completes_search_but_not_acquisition(self):
        self.materials['games'][0]['analysis_status'] = 'absent'
        self.scope['acquisition']['games'] = []
        self.write()
        p = self.progress()
        self.assertEqual(p['metrics'][1]['value'], 1)
        self.assertEqual(p['metrics'][2]['percent'], None)


if __name__ == '__main__':
    unittest.main()
