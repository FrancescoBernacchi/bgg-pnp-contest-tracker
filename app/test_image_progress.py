"""Meaningful IMG metric and main-selection cases on disposable synthetic data."""
import copy
import hashlib
from pathlib import Path
import sys
import unittest
ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT/'database'))
import test_game_images as fixtures
from image_progress import image_summaries,image_counts,entry_image_state
from image_progress import category_research_complete
from game_images import material_revision_notice
from server import connect,progress_rows

class ImageProgressTests(unittest.TestCase):
    def setUp(self):
        self.f=fixtures.ImageCatalogTests('test_preview_does_not_write_database');self.f.setUp()
    def tearDown(self):self.f.tearDown()
    def summaries(self):
        self.f.execute(True)
        before=hashlib.sha256(self.f.db.read_bytes()).hexdigest()
        with connect(self.f.db) as db:result=image_summaries(db,self.f.library)
        self.assertEqual(before,hashlib.sha256(self.f.db.read_bytes()).hexdigest())
        return result
    def test_three_segments_include_completed_without_images(self):
        summaries=self.summaries()
        entries=[{'id':i,'game_id':i,'contest_id':1} for i in (1,2,3)]
        counts=image_counts(entries,summaries)
        self.assertEqual([counts[k] for k in ('image_complete_count','image_with_images_count','image_without_images_count','image_incomplete_count')],[2,1,1,1])
        self.assertEqual(sum(counts[k] for k in ('image_with_images_count','image_without_images_count','image_incomplete_count')),len(entries))
    def test_context_does_not_complete_another_entry_or_contest(self):
        g=self.summaries()[1]
        self.assertEqual(entry_image_state(g,999,1),'incomplete')
        self.assertEqual(entry_image_state(g,1,999),'incomplete')
    def test_partial_with_images_remains_incomplete(self):
        self.f.m['games'][0]['research_complete']=False
        g=self.summaries()[1]
        self.assertEqual(g['original_count'],2)
        self.assertEqual(entry_image_state(g,1,1),'incomplete')
    def test_no_component_fallback_and_category_deduplication(self):
        self.f.m['images'][0]['additional_categories']=['Icona']
        g=self.summaries()[1]
        self.assertIsNone(g['main']['file_id'])
        self.assertEqual(g['original_count'],2)
        self.assertEqual(next(c for c in g['coverage'] if c['category']=='Icona')['original_count'],1)
    def test_explicit_missing_preserved_with_temporary_fallback(self):
        self.f.m['images'][0]['principal']=True
        self.f.m['images'][1]['category']='Setup'
        self.summaries()
        (self.f.library/'immagini/game/front.png').unlink()
        with connect(self.f.db) as db:g=image_summaries(db,self.f.library)[1]
        self.assertEqual(g['main']['explicit_image_id'],'front')
        self.assertEqual(g['main']['image_id'],'back')
        self.assertTrue(g['main']['problem']);self.assertTrue(g['main']['provisional'])
    def test_cover_precedes_setup_and_order_is_stable(self):
        self.f.m['images'][0]['category']='Copertina';self.f.m['images'][1]['category']='Setup'
        g=self.summaries()[1]
        self.assertEqual(g['main']['image_id'],'front')
        self.assertTrue(g['main']['provisional'])
    def test_old_schema_and_zero_denominator(self):
        import sqlite3
        with sqlite3.connect(':memory:') as db:self.assertEqual(image_summaries(db),{})
        self.assertTrue(all(n==0 for n in image_counts([],{}).values()))
    def test_category_outcomes_do_not_infer_completion_from_counts(self):
        self.assertFalse(category_research_complete('parziale',{'adopted_original_count':5}))
        self.assertTrue(category_research_complete('verificata nelle fonti e materiali elencati',{}))
        self.assertIsNone(category_research_complete('unrecognized outcome',{'adopted_original_count':5}))
        self.assertIsNone(category_research_complete('verificata nelle fonti solo parzialmente',{}))
        self.assertFalse(category_research_complete('complete',{'research_complete':False}))
    def test_revision_notice_requires_explicit_succession_evidence(self):
        self.assertEqual(material_revision_notice({'material_version':'older date','is_historical':True})['status'],'unknown')
        self.assertEqual(material_revision_notice({'material_revision_status':'previous'})['status'],'unknown')
        payload={'material_revision_status':'previous','material_revision_evidence':{'source_url':'https://example.org/revision','statement':'Explicit succession'}}
        self.assertEqual(material_revision_notice(payload)['status'],'previous')
        self.assertEqual(material_revision_notice({'extraction':payload})['evidence'],payload['material_revision_evidence'])
    def test_category_projection_keeps_context_and_unknowns(self):
        self.f.m['games'][0]['categories'][0].update(research='parziale')
        g=self.summaries()[1];c=next(c for c in g['coverage'] if c['category']=='Icona')
        self.assertEqual(c['research_observations'][0]['complete'],False)
        self.assertEqual((c['research_observations'][0]['entry_id'],c['research_observations'][0]['contest_id']),(1,1))
    def test_ai_pending_excluded_and_original_preferred_within_category(self):
        image=self.f.m['images'][0]
        image.update(category='Copertina',origin_kind='ai_generated',current_use='Da valutare',validation_state='pending')
        self.f.m['images'][1]['category']='Copertina'
        self.f.m['images'][1]['additional_categories']=['Setup']
        g=self.summaries()[1]
        self.assertEqual((g['original_count'],g['ai_count'],g['pending_count']),(1,0,1))
        self.assertEqual(g['main']['image_id'],'back')
        self.f.m['checked_at']='2026-10-06'
        image.update(validation_state='approved',current_use='adottata')
        self.f.m['decisions']=[{'decision_key':'approval','image_id':'front','version':'v01','outcome':'approved',
            'decided_at':'2026-10-06','confirmation_ref':'synthetic explicit approval'}]
        g=self.summaries()[1]
        self.assertEqual((g['original_count'],g['ai_count'],g['pending_count']),(1,1,0))
        self.assertEqual(g['main']['image_id'],'back')

if __name__=='__main__':unittest.main(verbosity=2)
