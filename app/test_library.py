import hashlib
import http.client
import json
from pathlib import Path
import sqlite3
import threading
import unittest

import test_server
from server import connect, game_detail, make_server
from library_catalog import library_catalog, local_presence


class LibraryTests(unittest.TestCase):
    insert = staticmethod(test_server.ApplicationTests.insert)
    setUp = test_server.ApplicationTests.setUp
    tearDown = test_server.ApplicationTests.tearDown

    def seed(self):
        self.root = Path(self.temp.name) / 'library'
        self.root.mkdir()
        (self.root / 'present.pdf').write_bytes(b'fixture only')
        db = sqlite3.connect(self.database)
        for i in (1,2,3):
            self.insert(db,'acquisitions',id=i,game_id=1,acquired_at=f'2026-10-0{i}',
                        selection_reason='test',game_status_at_acquisition='unknown')
        for i, relative in enumerate(['present.pdf','missing.pdf','../outside.pdf','C:\\secret.pdf'],1):
            self.insert(db,'acquired_files',id=i,acquisition_id=1 if i==1 else 2,
                        relative_path=relative,original_filename='<img onerror=evil>.pdf',
                        byte_size=i*10,sha256='a'*64,version_raw=str(i),language_code='en',
                        final_url='file:///C:/private.pdf',usage_conditions='Uso <personale>')
        db.commit();db.close()

    def test_counts_versions_grouping_and_no_write(self):
        self.seed()
        before=hashlib.sha256(self.database.read_bytes()).hexdigest()
        with connect(self.database) as db:
            result=library_catalog(db,self.root)
            self.assertEqual(result,library_catalog(db,self.root))
            self.assertEqual([result['summary'][k] for k in ('games','acquisitions','files','bytes','present','missing','unverifiable')],[1,3,4,100,1,1,2])
            self.assertEqual([len(a['files']) for a in result['acquisitions']],[1,3,0])
            self.assertEqual([f['version_raw'] for f in result['files']],['1','2','3','4'])
            self.assertEqual(game_detail(db,1,self.root)['local_materials'],result)
            self.assertEqual(library_catalog(db,self.root,2)['files'],[])
            self.assertTrue(all(a['completeness']=='unknown' for a in result['acquisitions']))
            self.assertTrue(all(f['source_url'] is None for f in result['files']))
            serialized=json.dumps(result)
            self.assertNotIn(str(self.root),serialized)
            self.assertNotIn('relative_path',serialized)
        self.assertEqual(before,hashlib.sha256(self.database.read_bytes()).hexdigest())

    def test_paths_and_missing_library(self):
        self.seed()
        self.assertEqual(local_presence(self.root,'present.pdf'),'present')
        for value in ['../outside.pdf','sub/../present.pdf','/etc/passwd','C:/secret','C:secret',r'\\server\share\file','file.pdf:stream','\x00']:
            self.assertEqual(local_presence(self.root,value),'invalid_path',value)
        self.assertEqual(local_presence(self.root,'missing.pdf'),'missing')
        with connect(self.database) as db:
            result=library_catalog(db,self.root/'absent')
            self.assertFalse(result['library_available'])
            self.assertEqual(result['summary']['missing'],2)
            self.assertEqual(result['summary']['files'],4)

    def test_link_escape(self):
        self.seed()
        outside=Path(self.temp.name)/'outside.pdf';outside.write_bytes(b'outside')
        try:
            (self.root/'link.pdf').symlink_to(outside)
        except OSError:
            # On Windows ordinary users may lack symlink privilege; a mocked resolved
            # destination exercises the same confinement check without changing ACLs.
            from unittest.mock import patch
            original=Path.resolve
            def resolve(path,*args,**kwargs):
                return outside if path.name=='link.pdf' else original(path,*args,**kwargs)
            with patch.object(Path,'resolve',resolve):
                self.assertEqual(local_presence(self.root,'link.pdf'),'invalid_path')
        else:
            self.assertEqual(local_presence(self.root,'link.pdf'),'invalid_path')

    def test_provenance_and_partial_registered_batch(self):
        self.seed()
        db=sqlite3.connect(self.database)
        self.insert(db,'remote_resources',id=1,game_id=1,kind='rules',url='https://example.org/rules',availability_status='unavailable')
        self.insert(db,'entry_resource_mentions',entry_id=1,remote_resource_id=1,first_seen_at='2026-01-01',last_seen_at='2026-01-01')
        self.insert(db,'catalog_sources',id=1,source_key='kanare_abstract',display_name='Kanare_Abstract',source_kind='publisher')
        self.insert(db,'source_records',id=1,source_id=1,record_type='game_page',canonical_url='https://example.org/game',title_raw='Game')
        self.insert(db,'catalog_resources',id=1,source_record_id=1,resource_kind='rules',url='https://example.org/file')
        db.execute('UPDATE acquired_files SET remote_resource_id=1,final_url=NULL WHERE id=1')
        db.execute("UPDATE acquired_files SET catalog_resource_id=1,final_url=NULL,acquisition_status='failed' WHERE id=2")
        db.commit();db.close()
        with connect(self.database) as db:
            result=library_catalog(db,self.root)
        bgg,kanare=result['files'][:2]
        self.assertEqual(bgg['source_key'],'boardgamegeek')
        self.assertEqual(bgg['contests'][0]['id'],1)
        self.assertEqual(bgg['remote_status'],'unavailable')
        self.assertTrue(bgg['local_present'])
        self.assertEqual(kanare['source_key'],'kanare_abstract')
        self.assertEqual(kanare['contests'],[])
        self.assertEqual(result['acquisitions'][1]['status'],'partial')
        self.assertEqual(result['acquisitions'][0]['status'],'unknown')

    def test_http_metadata_only_and_missing_database(self):
        self.seed()
        before=hashlib.sha256(self.database.read_bytes()).hexdigest()
        server=make_server(self.database,0,self.root)
        thread=threading.Thread(target=server.serve_forever,daemon=True);thread.start()
        try:
            client=http.client.HTTPConnection('127.0.0.1',server.server_port)
            for path,status in [('/api/library',200),('/api/games/1',200),('/library/present.pdf',404),('/api/library/1',404),('/../library/present.pdf',404),('/%2e%2e/library/present.pdf',404)]:
                client.request('GET',path);response=client.getresponse();payload=response.read()
                self.assertEqual(response.status,status)
                self.assertNotIn(str(self.root).encode(),payload)
                self.assertNotIn(b'fixture only',payload)
            client.request('POST','/api/library');response=client.getresponse();response.read();self.assertEqual(response.status,405)
            server.database=Path(self.temp.name)/'absent.sqlite3'
            client.request('GET','/api/library');response=client.getresponse();response.read();self.assertEqual(response.status,503)
            self.assertFalse(server.database.exists())
            client.close()
        finally:
            server.shutdown();server.server_close();thread.join()
        self.assertEqual(before,hashlib.sha256(self.database.read_bytes()).hexdigest())
