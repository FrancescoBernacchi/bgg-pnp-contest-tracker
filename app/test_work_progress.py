"""Esiti di lavoro: negativi espliciti, blocchi e completezza dei file."""
import json
import unittest
from contextlib import closing
import test_server as fixtures
from server import connect, progress_rows


class WorkProgressTests(unittest.TestCase):
    setUp = fixtures.ApplicationTests.setUp
    tearDown = fixtures.ApplicationTests.tearDown
    insert = staticmethod(fixtures.ApplicationTests.insert)
    def observe(self, db, entry, phase, outcome, date='2026-10-04'):
        self.insert(db, 'entry_work_observations', entry_id=entry, phase=phase, outcome=outcome,
                    observed_at=date, evidence_path='tasks/test/TASK.md', notes='Fonte completa verificata')

    def metric(self, db, cid=1):
        return next(c for c in progress_rows(db)['contests'] if c['contest_id']==cid)

    def test_complete_ranking_includes_explicit_absences_and_latest_block(self):
        with connect(self.database) as db:
            self.assertEqual(self.metric(db)['ranking_complete_count'],0)
        import sqlite3
        with closing(sqlite3.connect(self.database)) as db:
            db.row_factory=sqlite3.Row
            self.insert(db,'rankings',contest_id=1,game_id=1,category='Overall',rank=1,evidence_url='https://boardgamegeek.com/thread/123',verified_at='2026-10-04')
            self.assertEqual(self.metric(db)['ranking_complete_count'],0)
            self.observe(db,1,'ranking','complete')
            self.observe(db,2,'ranking','absent')
            result=self.metric(db)
            self.assertEqual((result['ranking_complete_count'],result['ranking_total'],result['ranked_entry_count']),(2,2,1))
            self.observe(db,2,'ranking','blocked','2026-10-05')
            self.assertEqual(self.metric(db)['ranking_complete_count'],1)
            self.assertEqual(self.metric(db)['ranking_blocked_count'],1)

    def test_no_entry_contest_and_roster_snapshot(self):
        import sqlite3
        with closing(sqlite3.connect(self.database)) as db:
            db.row_factory=sqlite3.Row
            self.insert(db,'contests',id=3,name='Senza entry',scope_type='adjacent',year=2026)
            result=self.metric(db,3)
            self.assertEqual(result['ranking_total'],0)
            self.assertEqual(result['census_complete_count'],0)
            self.insert(db,'contest_census_observations',contest_id=1,outcome='complete',entry_ids_json=json.dumps([1,2]),observed_at='2026-10-04',evidence_path='tasks/test/TASK.md',notes='Roster integrale')
            self.assertEqual(self.metric(db)['census_complete_count'],1)
            db.execute('DELETE FROM entries WHERE id=2')
            self.assertEqual(self.metric(db)['census_complete_count'],0)

    def test_material_contract_and_partial_acquisition(self):
        import sqlite3
        with closing(sqlite3.connect(self.database)) as db:
            db.row_factory=sqlite3.Row
            self.insert(db,'entry_material_scans',entry_id=1,checked_at='2026-10-04',wip_status='found',material_listing_status='observed',coverage_scope='first_post_only')
            self.insert(db,'entry_material_scans',entry_id=2,checked_at='2026-10-04',wip_status='not_found',material_listing_status='none_declared',coverage_scope='first_post_only')
            for i in (1,2):
                self.insert(db,'remote_resources',id=i,game_id=1,url=f'https://example.com/{i}',kind='pdf')
                self.insert(db,'entry_resource_mentions',entry_id=1,remote_resource_id=i,first_seen_at='2026-10-04',last_seen_at='2026-10-04',content_role='other')
            self.insert(db,'acquisitions',id=1,game_id=1,acquired_at='2026-10-04',selection_reason='test',game_status_at_acquisition='unknown')
            for i in (1,2):
                self.insert(db,'acquired_files',id=i,acquisition_id=1,remote_resource_id=i,relative_path=f'{i}.pdf',original_filename=f'{i}.pdf',byte_size=10,sha256='0'*64,acquisition_status='acquired' if i==1 else 'failed')
            result=self.metric(db)
            self.assertEqual(result['materials_complete_count'],2)
            self.assertEqual(result['acquisition_not_applicable_count'],1)
            self.assertEqual(result['acquisition_total'],1)
            self.assertEqual(result['acquisition_complete_count'],0)
            db.execute("UPDATE acquired_files SET acquisition_status='acquired' WHERE id=2")
            self.assertEqual(self.metric(db)['acquisition_complete_count'],1)
            self.observe(db,1,'materials','partial')
            self.assertEqual(self.metric(db)['materials_complete_count'],1)

    def test_not_applicable_and_both_scopes(self):
        import sqlite3
        with closing(sqlite3.connect(self.database)) as db:
            db.row_factory=sqlite3.Row
            db.execute('UPDATE contests SET year=2026')
            self.observe(db,1,'ranking','complete')
            self.observe(db,2,'ranking','not_applicable')
            self.observe(db,3,'ranking','absent')
            year=next(y for y in progress_rows(db)['years'] if y['year']==2026)
            self.assertEqual((year['pnp_core']['ranking_complete_count'],year['pnp_core']['ranking_total']),(1,1))
            self.assertEqual((year['adjacent']['ranking_complete_count'],year['adjacent']['ranking_total']),(1,1))
            self.assertEqual(year['image_complete_count'],0)

    def test_generator_uses_same_metrics_and_legacy_schema(self):
        import sqlite3
        from generate_project_progress import build_generated_section
        with closing(sqlite3.connect(self.database)) as db:
            db.row_factory=sqlite3.Row
            self.insert(db,'contest_series',id=1,canonical_name='Serie prova')
            db.execute('UPDATE contests SET year=2026,series_id=1 WHERE id=1')
            self.observe(db,1,'ranking','complete')
            self.observe(db,2,'ranking','absent')
            generated=build_generated_section(db)
            self.assertIn('Censimento classifica',generated)
            self.assertIn('2/2 · 100%',generated)
            self.assertIn('0% · non implementata',generated)
            db.execute('DROP TABLE entry_work_observations')
            db.execute('DROP TABLE contest_census_observations')
            self.assertEqual(self.metric(db)['ranking_complete_count'],0)

    def test_manifest_scope_overrides_excluded_links_but_partial_is_not_complete(self):
        import sqlite3
        with closing(sqlite3.connect(self.database)) as db:
            db.row_factory=sqlite3.Row
            self.insert(db,'entry_material_scans',entry_id=1,checked_at='2026-10-03',wip_status='found',material_listing_status='observed',coverage_scope='first_post_only')
            for i,kind in [(1,'pdf'),(2,'video')]:
                self.insert(db,'remote_resources',id=i,game_id=1,url=f'https://example.com/{i}',kind=kind)
                self.insert(db,'entry_resource_mentions',entry_id=1,remote_resource_id=i,first_seen_at='2026-10-03',last_seen_at='2026-10-03',content_role='other')
            self.insert(db,'acquisitions',id=1,game_id=1,acquired_at='2026-10-03',selection_reason='Materiali con esclusione video',game_status_at_acquisition='unknown')
            self.insert(db,'acquired_files',acquisition_id=1,remote_resource_id=1,relative_path='rules.pdf',original_filename='rules.pdf',byte_size=10,sha256='0'*64)
            self.assertEqual(self.metric(db)['acquisition_complete_count'],0)
            self.observe(db,1,'acquisition','complete','2026-10-03')
            self.assertEqual(self.metric(db)['acquisition_complete_count'],1)
            self.observe(db,1,'acquisition','partial','2026-10-04')
            self.assertEqual(self.metric(db)['acquisition_complete_count'],0)
            self.assertEqual(self.metric(db)['acquisition_partial_count'],1)

    def test_snapshot_completion_does_not_complete_partial_roster(self):
        import sqlite3
        with closing(sqlite3.connect(self.database)) as db:
            db.row_factory=sqlite3.Row
            db.execute('UPDATE contests SET year=2026')
            self.insert(db,'contest_census_observations',contest_id=1,outcome='complete',entry_ids_json='[1,2]',observed_at='2026-09-04',evidence_path='tasks/test/TASK.md',notes='Snapshot completo')
            self.insert(db,'contest_census_observations',contest_id=2,outcome='partial',entry_ids_json='[3]',observed_at='2026-09-04',evidence_path='tasks/test/TASK.md',notes='Perimetro parziale')
            year=next(y for y in progress_rows(db)['years'] if y['year']==2026)
            self.assertEqual(year['pnp_core']['census_complete_count'],1)
            self.assertEqual(year['adjacent']['census_complete_count'],0)
            self.assertEqual(year['adjacent']['census_incomplete_count'],1)
