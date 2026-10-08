"""B-v1 UI contracts against read-only operational data and isolated copies."""
import json
from pathlib import Path
import sqlite3
import tempfile
import unittest

from server import connect, DEFAULT_DATABASE, catalog, game_detail
from source_evidence import source_record_detail, record_summaries, active
from pergioco_progress import pergioco_progress


class PerGiocoTests(unittest.TestCase):
    def setUp(self):
        self.context = connect(DEFAULT_DATABASE)
        self.db = self.context.__enter__()
        self.records = record_summaries(self.db, 'pergioco')

    def tearDown(self):
        self.context.__exit__(None, None, None)

    def detail(self, title):
        return source_record_detail(self.db, next(r['id'] for r in self.records if r['title_raw']==title))

    def test_every_record_and_distinct_denominators(self):
        self.assertEqual(len(self.records),12)
        s=pergioco_progress(self.db)
        self.assertEqual(s['summary'], dict(records=12,scope_records=12,confirmed_games=8,candidate_links=1,source_only=3,admitted=9,requirement_not_demonstrated=3,instances=2))
        self.assertEqual([(m['value'],m['total']) for m in s['metrics'][:3]],[(12,12),(9,12),(12,12)])
        self.assertTrue(all(m['percent'] is None for m in s['metrics'][3:]))
        for r in self.records:
            d=source_record_detail(self.db,r['id'])
            self.assertEqual(d['warnings'],[])
            self.assertEqual(d['files'],[])
            self.assertNotIn('payload_json',d['observations'][0])

    def test_candidate_and_source_only_never_promoted(self):
        abande=self.detail('Abande')
        self.assertEqual(abande['matches'][0]['match_status'],'candidate')
        game=game_detail(self.db,abande['matches'][0]['game_id'])
        self.assertFalse(any('pergioco' in (c['source_url'] or '') for c in game['credits']))
        self.assertFalse(any('pergioco' in (r['url'] or '') for r in game['resources']))
        only=[r for r in self.records if not r['matches']]
        self.assertEqual(len(only),3)
        self.assertTrue(all(r['admissions'][0]['outcome_normalized']=='requirement_not_demonstrated' for r in only))

    def test_classifications_credits_and_missing_urls(self):
        details=[source_record_detail(self.db,r['id']) for r in self.records]
        self.assertEqual(sum(len(d['classifications']) for d in details),26)
        self.assertEqual(sum(len(c['segments']) for d in details for c in d['classifications']),96)
        mentions=[m for d in details for m in d['mentions']]
        self.assertEqual(len(mentions),21)
        self.assertEqual(sum(m['declared_url'] is None for m in mentions),4)
        self.assertTrue(any(c['name_raw'] is None for d in details for c in d['credits']))
        krypte=self.detail('Krypte')
        self.assertTrue(any('K' in [s['label_raw'] for s in c['segments']] for c in krypte['classifications']))
        self.assertTrue(any(c['segment_raw']=='I-J-K' for c in krypte['classifications']))
        chomp=self.detail('Chomp')
        self.assertFalse(any('matemat' in c['label_raw'].lower() for c in chomp['classifications']))

    def test_itinera_and_libre(self):
        itinera=self.detail('Itinera')
        self.assertEqual(len(itinera['matches']),1)
        self.assertEqual(len(itinera['instances']),2)
        self.assertEqual({i['published_at'] for i in itinera['instances']},{'2021-06-18','2021-07-23'})
        self.assertFalse(any(a['role']=='solution_for' for i in itinera['instances'] for a in i['assertions']))
        self.assertTrue(any(u['destination_kind']=='login' for m in itinera['mentions'] for u in m['url_observations']))
        libre=self.detail('Abande Libre')
        self.assertTrue(any(r['to_record_id']==self.detail('Abande')['record']['id'] for r in libre['relations']))
        gid=libre['matches'][0]['game_id']
        self.assertFalse(any(r['to_game_id']==993 and r['verification_status']=='confirmed' for r in game_detail(self.db,gid)['relationships']))

    def copy(self):
        copied=sqlite3.connect(':memory:');copied.row_factory=sqlite3.Row
        self.db.backup(copied)
        return copied

    def test_absent_source_schema_and_scope(self):
        db=self.copy()
        # Empty source in a clean schema is an absent source, not a failed legacy app.
        empty=sqlite3.connect(':memory:');empty.row_factory=sqlite3.Row
        empty.executescript(Path('database/schema.sql').read_text(encoding='utf-8'))
        self.assertIsNone(pergioco_progress(empty))
        self.assertEqual(catalog(empty)['source_records'],[])
        db.execute('ALTER TABLE source_credit_observations RENAME TO unavailable_credit_table')
        d=source_record_detail(db,self.records[0]['id'])
        self.assertTrue(d['warnings']);self.assertEqual(d['credits'],[])
        self.assertTrue(catalog(db)['games'])
        with tempfile.TemporaryDirectory(dir=Path('outputs').resolve()) as directory:
            p=pergioco_progress(self.db,Path(directory))
            self.assertTrue(p['warnings']);self.assertTrue(all(m['percent'] is None for m in p['metrics']))
        db.close();empty.close()

    def test_events_do_not_use_last_id_as_replacement(self):
        db=self.copy()
        old=dict(db.execute('SELECT * FROM source_record_observations WHERE record_id=?',(self.records[0]['id'],)).fetchone())
        # On copy only, add an independent event whose content differs from the prior snapshot.
        new={**old,'id':10001,'stable_key':'synthetic:event','event_key':'synthetic:later','payload_json':json.dumps({'aliases_declared':['Synthetic alias']}),'payload_sha256':'0'*64,'title_raw':'Synthetic title','display_title_qualified':'Synthetic title','observed_at':'2026-10-08'}
        db.execute('INSERT INTO source_record_observations ('+','.join(new)+') VALUES ('+','.join('?' for _ in new)+')',tuple(new.values()))
        detail=source_record_detail(db,old['record_id'])
        self.assertEqual(len(detail['current_observation_ids']),2)
        self.assertTrue(any(o['aliases']==['Synthetic alias'] for o in detail['observations']))
        self.assertEqual([x['id'] for x in active([{'id':1},{'id':2,'supersedes_id':1}])],[2])
        correction={**new,'id':10002,'stable_key':'synthetic:correction','event_key':old['event_key'],'assessment_note':'Synthetic explicit correction on copy only','payload_sha256':'1'*64,'supersedes_id':old['id']}
        db.execute('INSERT INTO source_record_observations ('+','.join(correction)+') VALUES ('+','.join('?' for _ in correction)+')',tuple(correction.values()))
        detail=source_record_detail(db,old['record_id'])
        self.assertNotIn(old['id'],detail['current_observation_ids'])
        self.assertTrue(all(c['historical_snapshot'] for c in detail['credits']))
        db.close()

    def test_concurrent_admission_outcomes_remain_unknown(self):
        db=self.copy()
        original=dict(db.execute("SELECT * FROM source_admission_observations WHERE outcome_normalized='admitted' LIMIT 1").fetchone())
        conflicting={**original,'id':10001,'stable_key':'synthetic:conflicting-admission','outcome_normalized':'requirement_not_demonstrated','outcome_raw':'synthetic conflict'}
        db.execute('INSERT INTO source_admission_observations ('+','.join(conflicting)+') VALUES ('+','.join('?' for _ in conflicting)+')',tuple(conflicting.values()))
        result=pergioco_progress(db)
        self.assertEqual(result['summary']['admitted'],8)
        self.assertEqual(result['summary']['requirement_not_demonstrated'],3)
        self.assertTrue(any('concorrenti' in w for w in result['warnings']))
        db.close()


if __name__=='__main__':
    unittest.main()
