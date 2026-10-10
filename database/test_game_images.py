"""IMG migration/import regression tests: temporary synthetic catalogs only."""
import copy
import hashlib
import json
import sqlite3
import sys
import tempfile
import unittest
from contextlib import closing
from pathlib import Path
from PIL import Image

ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT/'database'))
sys.path.insert(0,str(ROOT/'catalog'))
from image_catalog import Conflict, apply_migration, installed, inventory, open_db
from import_game_images import run
from pdf_files import PDFError

class ImageCatalogTests(unittest.TestCase):
    def setUp(self):
        test_root=ROOT/'outputs/image-catalog-tests'
        test_root.mkdir(parents=True,exist_ok=True)
        self.temp=tempfile.TemporaryDirectory(dir=test_root)
        self.root=Path(self.temp.name)
        self.db=self.root/'test.sqlite3'
        self.library=self.root/'library'
        folder=self.library/'immagini'/'game'
        folder.mkdir(parents=True)
        image=folder/'front.png'
        Image.new('RGB',(16,12),(31,117,89)).save(image)
        back=folder/'back.png'
        Image.new('RGB',(16,12),(91,54,137)).save(back)
        with closing(sqlite3.connect(self.db)) as c:
            c.executescript('''
            CREATE TABLE games(id INTEGER PRIMARY KEY,canonical_title TEXT);
            CREATE TABLE contests(id INTEGER PRIMARY KEY,series_id INTEGER,year INTEGER);
            CREATE TABLE entries(id INTEGER PRIMARY KEY,game_id INTEGER,contest_id INTEGER);
            CREATE TABLE products(id INTEGER PRIMARY KEY);
            CREATE TABLE product_games(product_id INTEGER,game_id INTEGER);
            CREATE TABLE source_records(id INTEGER PRIMARY KEY);
            CREATE TABLE game_source_records(game_id INTEGER,source_record_id INTEGER,match_status TEXT);
            CREATE TABLE acquisitions(id INTEGER PRIMARY KEY,game_id INTEGER);
            CREATE TABLE acquired_files(id INTEGER PRIMARY KEY,acquisition_id INTEGER,relative_path TEXT,sha256 TEXT,byte_size INTEGER,acquisition_status TEXT);
            CREATE TABLE legacy_payload(id INTEGER PRIMARY KEY,payload BLOB);
            INSERT INTO games VALUES(1,'Example'),(2,'Other'),(3,'No image');
            INSERT INTO contests VALUES(1,1,2025);
            INSERT INTO entries VALUES(1,1,1),(2,2,1),(3,3,1);
            INSERT INTO source_records VALUES(1);
            INSERT INTO game_source_records VALUES(1,1,'candidate');
            INSERT INTO legacy_payload VALUES(1,x'00ff0102');
            CREATE VIEW legacy_view AS SELECT * FROM legacy_payload;
            ''')
        self.m={'manifest_version':1,'task_id':'TEST-IMG','checked_at':'2026-10-05',
                'scope':{'contest_id':1,'series_id':1,'year':2025,'authorized_game_ids':[1,2,3]},
                'images':[self.image('front',image),self.image('back',back)],'historical_files':[],
                'games':[self.game(1,True),self.game(2,False),self.game(3,True)],
                'components':[{'component_id':'card','game_id':1,'type':'Carta','front_image_id':'front',
                               'back_image_id':'back','physical_occurrence_count':2}],
                'references':[{'status':'synthetic evidence only'}]}
        self.m['images'][0]['side']='Fronte'
        self.m['images'][1]['side']='Dorso'
        for i in self.m['images']:
            i['component_ids']=['card']
        self.s={'task_id':'TEST-IMG','contest_id':1,'series_id':1,'documents':[]}
        self.manifest=self.root/'manifest.json';self.sources=self.root/'sources.json'
        self.write()
        with open_db(self.db) as c:
            self.before=inventory(c)

    def tearDown(self):
        self.temp.cleanup()

    def image(self,identifier,path):
        with Image.open(path) as im:
            fmt=im.format;width,height=im.size
        return {'image_id':identifier,'game_id':1,'entry_id':1,'contest_id':1,
                'category':'Componente','additional_categories':[],'version':'v01','material_version':'2.1',
                'relative_path':'library/'+path.relative_to(self.library).as_posix(),'sha256':hashlib.sha256(path.read_bytes()).hexdigest(),
                'bytes':path.stat().st_size,'format':fmt,'width':width,'height':height,'acquired_at':'2026-10-05',
                'current_use':'adottata','validation':'synthetic original','provenance':[{'label':'Personale','observed_at':'2026-10-05'}],
                'component_ids':[],'principal':False,'conditions':{'publication_allowed':False},'credits':[],
                'occurrences':[],'relationships':[]}

    def game(self,gid,complete):
        return {'game_id':gid,'entry_id':gid,'contest_id':1,'checked_at':'2026-10-05',
                'research_complete':complete,'research_status':'complete' if complete else 'partial',
                'categories':[{'category':'Icona','research':'explicit scope','applicability':'desiderata',
                  'adopted_original_count':0,'validated_ai_count':0,'pending_ai_count':0,'verified_absence':complete}],
                'sources_reviewed':['synthetic']}

    def write(self):
        self.manifest.write_text(json.dumps(self.m),encoding='utf8')
        self.sources.write_text(json.dumps(self.s),encoding='utf8')

    def execute(self,apply=False,**extra):
        self.write()
        return run(self.db,self.manifest,self.sources,self.library,apply=apply,
                   authorization='user-authorized tests on disposable copy',backup_dir=self.root/'backups',**extra)

    def sql(self,statement):
        with open_db(self.db) as c:
            return c.execute(statement).fetchall()

    def assert_unchanged(self):
        with open_db(self.db) as c:
            self.assertEqual(inventory(c),self.before)

    def test_preview_does_not_write_database(self):
        raw=self.db.read_bytes()
        result=self.execute()
        self.assertEqual(result['outcome'],'preview')
        self.assertFalse(result['database_written'])
        self.assertEqual(raw,self.db.read_bytes())
        self.assert_unchanged()

    def test_apply_preserves_all_legacy_and_backup_restore(self):
        result=self.execute(True)
        self.assertTrue(result['legacy_preserved'])
        self.assertTrue(result['restore_matches_backup'])
        for path in ('backup_path','restore_proof_path'):
            with open_db(result[path]) as c:
                self.assertEqual(inventory(c),self.before)
        with open_db(self.db) as c:
            self.assertEqual(inventory(c,{o[2] for o in self.before['objects']}),self.before)
        self.assertEqual(self.sql('SELECT sum(complete),count(*) FROM img_current_research'),[(2,3)])
        self.assertEqual(self.sql('SELECT count(*) FROM img_component_links'),[(2,)])

    def test_reimport_is_noop_including_database_bytes(self):
        self.execute(True)
        raw=self.db.read_bytes()
        result=self.execute(True)
        self.assertEqual(result['outcome'],'already_imported')
        self.assertEqual(raw,self.db.read_bytes())

    def test_absence_from_later_manifest_does_not_delete(self):
        self.execute(True)
        self.m['checked_at']='2026-10-06'
        self.m['images']=[];self.m['components']=[];self.m['games']=[]
        self.execute(True)
        self.assertEqual(self.sql('SELECT count(*) FROM img_assets'),[(2,)])
        self.assertEqual(self.sql('SELECT count(*) FROM img_current_assets'),[(2,)])
        self.assertEqual(self.sql('SELECT count(*) FROM img_current_research'),[(3,)])

    def test_changed_identity_rejected_without_target_mutation(self):
        self.execute(True)
        raw=self.db.read_bytes()
        self.m['images'][0]['game_id']=2;self.m['images'][0]['entry_id']=2
        self.m['images'][0]['component_ids']=[];self.m['components']=[]
        with self.assertRaises(Conflict):self.execute(True)
        self.assertEqual(raw,self.db.read_bytes())

    def test_file_version_bytes_are_immutable_even_if_manifest_updated(self):
        self.execute(True)
        image=self.library/'immagini/game/front.png'
        Image.new('RGB',(16,12),(1,2,3)).save(image)
        replacement=self.image('front',image)
        self.m['images'][0].update({k:replacement[k] for k in ('sha256','bytes')})
        raw=self.db.read_bytes()
        with self.assertRaises(Conflict):self.execute(True)
        self.assertEqual(raw,self.db.read_bytes())

    def test_new_version_keeps_old_file_and_supersession_relation(self):
        self.execute(True)
        old=copy.deepcopy(self.m['images'][0]);old['current_use']='Superata'
        path=self.library/'immagini/game/front-v2.png'
        Image.new('RGB',(20,15),(60,20,70)).save(path)
        current=self.image('front',path);current['version']='v02';current['component_ids']=['card']
        current['relationships']=[{'type':'supersedes_file_version','target_image_id':'front','target_version':'v01'}]
        self.m['checked_at']='2026-10-06';self.m['historical_files']=[old];self.m['images'][0]=current
        self.execute(True)
        self.assertEqual(self.sql("SELECT version_raw FROM img_current_assets WHERE image_id='front'"),[('v02',)])
        self.assertEqual(self.sql("SELECT count(*) FROM img_files WHERE image_id='front'"),[(2,)])

    def test_old_exact_manifest_replay_does_not_reactivate_version(self):
        old=copy.deepcopy(self.m)
        self.test_new_version_keeps_old_file_and_supersession_relation()
        self.m=old
        self.assertEqual(self.execute(True)['outcome'],'already_imported')
        self.assertEqual(self.sql("SELECT version_raw FROM img_current_assets WHERE image_id='front'"),[('v02',)])

    def test_additional_categories_do_not_duplicate_image(self):
        self.m['images'][0]['additional_categories']=['Artwork','Preparazione']
        self.execute(True)
        self.assertEqual(self.sql('SELECT count(*) FROM img_assets'),[(2,)])
        self.assertEqual(self.sql('SELECT count(*) FROM img_categories'),[(4,)])

    def test_multiple_provenances_kept_as_observations(self):
        self.execute(True)
        self.m['checked_at']='2026-10-06'
        self.m['images'][0]['provenance'].append({'label':'Autore','source_url':'https://example.invalid/image'})
        self.execute(True)
        self.assertEqual(self.sql("SELECT count(DISTINCT p.payload_json) FROM img_provenances p JOIN img_asset_observations o ON o.id=p.observation_id JOIN img_files f ON f.id=o.file_id WHERE f.image_id='front'"),[(2,)])

    def test_missing_file_hash_size_format_and_dimension_conflicts(self):
        for field,value in [('relative_path','library/immagini/game/missing.png'),('sha256','0'*64),
                            ('bytes',1),('format','JPEG'),('width',30)]:
            original=self.m['images'][0][field];self.m['images'][0][field]=value
            with self.assertRaises((Conflict,OSError,PDFError)):
                self.execute(True)
            self.m['images'][0][field]=original
            self.assert_unchanged()

    def test_invalid_paths_rejected(self):
        for path in ('library/immagini/../escape.png','C:/escape.png','//server/share.png',
                     'library/immagini/game/front.png:stream','library/immagini/game./front.png'):
            self.m['images'][0]['relative_path']=path
            with self.assertRaises(Conflict):self.execute(True)
            self.assert_unchanged()

    def test_unknown_and_wrong_entry_rejected(self):
        for entry in (999,2):
            self.m['images'][0]['entry_id']=entry
            with self.assertRaises(Conflict):self.execute(True)
            self.assert_unchanged()

    def test_unconfirmed_source_identity_is_not_attributed(self):
        self.m['images'][0]['source_record_id']=1
        with self.assertRaises(Conflict):self.execute(True)
        self.assert_unchanged()

    def test_partial_research_not_completed_by_image_presence(self):
        self.m['games'][0]['research_complete']=False
        self.execute(True)
        self.assertEqual(self.sql('SELECT complete FROM img_current_research WHERE game_id=1'),[(0,)])

    def test_component_and_region_targets_rejected(self):
        self.m['components'][0]['front_image_id']='absent'
        with self.assertRaises(Conflict):self.execute(True)
        self.assert_unchanged()
        self.m['components'][0]['front_image_id']='front'
        self.m['images'][0]['side_regions']=[{'side_region_id':'r','side':'Fronte','rectangle':[0,0,10,10],
            'coordinate_system':'synthetic pixel','page':1,'linked_side_region_ids':['missing']}]
        with self.assertRaises(Conflict):self.execute(True)

    def test_assembly_regions_are_not_separate_files(self):
        self.m['images'][0]['side_regions']=[
            {'side_region_id':'r1','side':'Fronte','rectangle':[0,0,8,12], 'coordinate_system':'synthetic pixel','page':1,'linked_side_region_ids':['r2']},
            {'side_region_id':'r2','side':'Retro','rectangle':[8,0,16,12], 'coordinate_system':'synthetic pixel','page':1,'linked_side_region_ids':['r1']}]
        self.execute(True)
        self.assertEqual(self.sql('SELECT count(*) FROM img_files'),[(2,)])
        self.assertEqual(self.sql('SELECT count(*) FROM img_regions'),[(2,)])
        self.assertEqual(self.sql('SELECT count(*) FROM img_region_links'),[(2,)])

    def test_ai_pending_approved_rejected_and_reapproved_keep_history(self):
        i=self.m['images'][0]
        i['provenance']=[{'label':'AI-Generata'}]
        i['current_use']='Da valutare';i['validation_state']='pending'
        i['generation']={'request':'synthetic, no AI tool invoked','model':None,'input_image_ids':[]}
        self.execute(True)
        for day,status,use in [('06','approved','adottata'),('07','rejected','Scartata'),('08','approved','adottata')]:
            self.m['checked_at']='2026-10-'+day
            i['validation_state']=status;i['current_use']=use
            self.m['decisions']=[{'decision_key':'decision-'+day,'image_id':'front','version':'v01',
               'outcome':status,'decided_at':'2026-10-'+day,'confirmation_ref':'synthetic user confirmation',
               'reason':'test'}]
            self.execute(True)
        self.assertEqual(self.sql('SELECT count(*) FROM img_decisions'),[(3,)])
        self.assertEqual(self.sql('SELECT outcome FROM img_current_decisions'),[('approved',)])
        self.assertEqual(self.sql("SELECT validation_state FROM img_current_assets WHERE image_id='front'"),[('approved',)])

    def test_ai_approval_without_confirmation_rejected(self):
        i=self.m['images'][0];i['provenance']=[{'label':'AI-Rielaborata'}];i['validation_state']='approved'
        with self.assertRaises(Conflict):self.execute(True)
        self.m['decisions']=[{'decision_key':'d','image_id':'front','version':'v01','outcome':'approved','decided_at':'2026-10-05'}]
        with self.assertRaises(Conflict):self.execute(True)
        self.assert_unchanged()

    def test_principal_preserved_when_later_manifest_omits_selection(self):
        self.m['images'][0]['principal']=True;self.execute(True)
        self.m['images'][0]['principal']=False;self.m['checked_at']='2026-10-06';self.execute(True)
        self.assertEqual(self.sql('SELECT image_id FROM img_current_primary'),[('front',)])
        self.m['primary_selections']=[{'game_id':1,'image_id':None,'selected_at':'2026-10-07','evidence_ref':'explicit reset'}]
        self.execute(True)
        self.assertEqual(self.sql('SELECT image_id FROM img_current_primary'),[(None,)])

    def test_rollback_covers_migration_and_import(self):
        with self.assertRaises(Conflict):self.execute(True,fail_after_import=True)
        self.assert_unchanged()

    def test_append_only_guards(self):
        self.execute(True)
        with closing(sqlite3.connect(self.db)) as c:
            for sql in ('DELETE FROM img_files','UPDATE img_assets SET game_id=2','DELETE FROM img_imports'):
                with self.assertRaises(sqlite3.IntegrityError):c.execute(sql)

    def test_migration_replay_and_partial_schema_conflict(self):
        result=apply_migration(self.db,self.root/'backups','synthetic test')
        self.assertTrue(result['new_tables_empty'])
        self.assertEqual(apply_migration(self.db,self.root/'backups','synthetic test')['outcome'],'already_applied')
        other=self.root/'partial.sqlite3'
        with closing(sqlite3.connect(other)) as c:c.execute('CREATE TABLE img_assets(image_id TEXT)')
        raw=other.read_bytes()
        with self.assertRaises(Conflict):apply_migration(other,self.root/'backups','synthetic test')
        self.assertEqual(raw,other.read_bytes())

    def test_migration_failure_rolls_back_ddl(self):
        with self.assertRaises(Conflict):apply_migration(self.db,self.root/'backups','synthetic test',fail_after=4)
        self.assert_unchanged()

    def test_missing_database_is_never_created(self):
        target=self.root/'missing.sqlite3'
        with self.assertRaises(OSError):run(target,self.manifest,self.sources,self.library)
        self.assertFalse(target.exists())

    def test_png_jpeg_webp_verified_by_content(self):
        for suffix in ('jpg','webp'):
            path=self.library/('immagini/game/front.'+suffix)
            Image.new('RGB',(16,12),(23,45,67)).save(path)
            self.m['images'][0]=self.image('front',path)
            self.m['images'][0]['component_ids']=['card']
            self.assertEqual(self.execute()['verified_image_files'],2)

    def test_ai_input_relations_and_unknown_inputs(self):
        i=self.m['images'][0]
        i.update(origin_kind='ai_reworked',current_use='Da valutare',validation_state='pending',
                 generation={'input_image_ids':['missing']})
        with self.assertRaises(Conflict):self.execute(True)
        i['generation']['input_image_ids']=['back']
        self.execute(True)
        self.assertEqual(self.sql("SELECT target_image_id FROM img_relations WHERE relation_type='ai_input'"),[('back',)])

    def test_ai_decision_without_matching_observation_rejected(self):
        i=self.m['images'][0]
        i.update(origin_kind='ai_generated',current_use='Da valutare',validation_state='pending')
        self.m['decisions']=[{'decision_key':'d','image_id':'front','version':'v01','outcome':'approved',
                            'decided_at':'2026-10-05','confirmation_ref':'synthetic user confirmation'}]
        with self.assertRaises(Conflict):self.execute(True)
        self.assert_unchanged()

    def test_shared_back_and_multiple_confirmed_source_contexts(self):
        self.m['components'].append({'component_id':'second-card','game_id':1,'type':'Carta','back_image_id':'back'})
        self.m['images'][1]['component_ids'].append('second-card')
        with closing(sqlite3.connect(self.db)) as c:
            c.execute("UPDATE game_source_records SET match_status='confirmed'")
            c.execute('INSERT INTO contests VALUES(2,2,2024)')
            c.execute('INSERT INTO entries VALUES(4,1,2)')
            c.commit()
        self.m['images'][0]['contexts']=[{'entry_id':1,'contest_id':1},{'entry_id':4,'contest_id':2,'source_record_id':1}]
        self.execute(True)
        self.assertEqual(self.sql("SELECT count(*) FROM img_component_links WHERE image_id='back'"),[(2,)])
        self.assertEqual(self.sql('SELECT count(*) FROM img_contexts'),[(3,)])

    def test_source_file_hash_missing_and_owner_conflicts(self):
        doc=self.library/'document.pdf';doc.write_bytes(b'synthetic registered material')
        sha=hashlib.sha256(doc.read_bytes()).hexdigest()
        with closing(sqlite3.connect(self.db)) as c:
            c.execute('INSERT INTO acquisitions VALUES(1,1)')
            c.execute("INSERT INTO acquired_files VALUES(1,1,'document.pdf',?,?, 'acquired')",(sha,doc.stat().st_size))
            c.commit()
        self.m['images'][0]['provenance'].append({'label':'Estratta','source_document_id':1,'document_sha256':'0'*64})
        with self.assertRaises(Conflict):self.execute(True)
        self.m['images'][0]['provenance'][-1]['document_sha256']=sha
        doc.rename(self.library/'missing.pdf')
        with self.assertRaises((OSError,PDFError)):self.execute(True)
        (self.library/'missing.pdf').rename(doc)
        self.execute(True)
        self.assertEqual(self.sql('SELECT count(*) FROM img_provenances WHERE acquired_file_id=1'),[(1,)])

    def test_primary_wrong_game_and_duplicate_json_rejected(self):
        self.m['primary_selections']=[{'game_id':2,'image_id':'front','selected_at':'2026-10-05','evidence_ref':'synthetic'}]
        with self.assertRaises(Conflict):self.execute(True)
        self.manifest.write_text('{"manifest_version":1,"manifest_version":1}',encoding='utf8')
        with self.assertRaises(Conflict):run(self.db,self.manifest,self.sources,self.library)
        self.assert_unchanged()

    def test_partial_manifest_can_reference_existing_components_and_images(self):
        self.execute(True)
        self.m['checked_at']='2026-10-06'
        self.m['images']=self.m['images'][:1]
        self.m['components']=[]
        self.execute(True)
        self.m['checked_at']='2026-10-07'
        self.m['images']=[]
        self.m['components']=[{'component_id':'new-card','game_id':1,'type':'Carta','back_image_id':'back'}]
        self.execute(True)
        self.assertEqual(self.sql("SELECT count(*) FROM img_component_links WHERE image_id='back'"),[(2,)])

if __name__=='__main__':
    unittest.main(verbosity=2)
