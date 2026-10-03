import hashlib
import http.client
import json
from pathlib import Path
import sqlite3
import threading
import unittest
from unittest.mock import patch

import test_server
from server import make_server, connect, STATIC, PDFJS_ASSETS
from pdf_files import open_pdf, PDFError, preview_status, MAX_PDF_BYTES
from pdf_test_fixtures import sample_pdf
from library_catalog import library_catalog


class PdfViewerTests(unittest.TestCase):
    insert=staticmethod(test_server.ApplicationTests.insert)
    tearDown=test_server.ApplicationTests.tearDown

    def setUp(self):
        test_server.ApplicationTests.setUp(self)
        self.root=Path(self.temp.name)/'library';self.root.mkdir()
        self.content=sample_pdf(active=True)
        db=sqlite3.connect(self.database)
        for version in (1,2):
            self.insert(db,'acquisitions',id=version,game_id=1,acquired_at=f'2026-10-0{version}',selection_reason='test',game_status_at_acquisition='unknown')
        values=[('one.pdf','application/pdf',self.content),('two.pdf','application/pdf',sample_pdf()),
                ('bad.pdf','application/pdf',b'not pdf'),('broken.pdf','application/pdf',b'%PDF-1.4\ntruncated'),
                ('wrong.txt','text/plain',self.content),('../external.pdf','application/pdf',None),
                ('C:/private.pdf','application/pdf',None),('missing.pdf','application/pdf',None)]
        for i,(name,mime,data) in enumerate(values,1):
            if data is not None:(self.root/name).write_bytes(data)
            self.insert(db,'acquired_files',id=i,acquisition_id=1 if i==1 else 2,relative_path=name,
                        original_filename=f'File <unsafe> {i}',media_type=mime,byte_size=len(data or b''),
                        sha256=hashlib.sha256(data or b'').hexdigest(),version_raw=str(i))
        db.commit();db.close()
        self.server=make_server(self.database,0,self.root)
        self.thread=threading.Thread(target=self.server.serve_forever,daemon=True);self.thread.start()

    def tearDown(self):
        self.server.shutdown();self.server.server_close();self.thread.join()
        test_server.ApplicationTests.tearDown(self)

    def request(self,path,headers=None,method='GET'):
        c=http.client.HTTPConnection('127.0.0.1',self.server.server_port)
        c.request(method,path,headers=headers or {})
        r=c.getresponse();body=r.read();result=(r.status,dict(r.getheaders()),body);c.close();return result

    def headers(self,**extra):
        return {'Sec-Fetch-Site':'same-origin','X-PnP-Viewer':self.server.viewer_token,**extra}

    def test_session_and_cross_origin_protection(self):
        self.assertEqual(self.request('/api/viewer-session')[0],403)
        status,_,body=self.request('/api/viewer-session',{'Sec-Fetch-Site':'same-origin'})
        self.assertEqual(status,200);self.assertEqual(json.loads(body)['token'],self.server.viewer_token)
        for headers in [{},{'Sec-Fetch-Site':'cross-site'},self.headers(**{'Sec-Fetch-Site':'same-site'}),
                        self.headers(Origin='https://evil.example'),self.headers(**{'X-PnP-Viewer':'wrong'}),
                        self.headers(**{'X-PnP-Viewer':'é'}),self.headers(**{'Host':'evil.example'})]:
            self.assertEqual(self.request('/api/files/1/pdf',headers)[0],403,headers)
        self.assertEqual(self.request('/api/files/1/pdf',self.headers(),method='POST')[0],405)

    def test_id_metadata_version_and_exact_original(self):
        before=hashlib.sha256(self.database.read_bytes()).hexdigest()
        originals={p.name:hashlib.sha256(p.read_bytes()).hexdigest() for p in self.root.iterdir()}
        for i in (1,2):
            status,headers,body=self.request(f'/api/files/{i}',self.headers())
            data=json.loads(body);self.assertEqual(status,200)
            self.assertEqual(data['version_raw'],str(i));self.assertEqual(data['viewer_kind'],'pdf')
            self.assertNotIn('relative_path',data);self.assertNotIn(str(self.root),body.decode())
        status,headers,body=self.request('/api/files/1/pdf',self.headers())
        self.assertEqual(status,200);self.assertEqual(body,self.content)
        self.assertEqual(headers['Accept-Ranges'],'none');self.assertEqual(headers['Cache-Control'],'no-store')
        self.assertIn("default-src 'none'",headers['Content-Security-Policy'])
        self.assertNotIn('Access-Control-Allow-Origin',headers)
        self.assertEqual(self.request('/api/files/1/pdf',self.headers(),method='HEAD')[2],b'')
        self.assertEqual(before,hashlib.sha256(self.database.read_bytes()).hexdigest())
        self.assertEqual(originals,{p.name:hashlib.sha256(p.read_bytes()).hexdigest() for p in self.root.iterdir()})

    def test_errors_and_no_generic_file_server(self):
        for i,status in [(3,415),(4,422),(5,415),(6,403),(7,403),(8,404),(999,404)]:
            actual,_,body=self.request(f'/api/files/{i}/pdf',self.headers())
            self.assertEqual(actual,status,(i,body));self.assertNotIn(str(self.root).encode(),body)
        for path in ['/api/files/0/pdf','/api/files/-1/pdf','/api/files/1%20OR%201=1/pdf','/library/one.pdf',
                     '/vendor/pdfjs/../../server.py','/vendor/pdfjs/build/pdf.sandbox.mjs','/vendor/pdfjs/wasm/quickjs-eval.wasm',
                     '/database/pnp_collection.sqlite3','/%2e%2e/library/one.pdf']:
            self.assertEqual(self.request(path,self.headers())[0],404,path)
        self.assertEqual(self.request('/api/files/1/pdf?path=one.pdf',self.headers())[0],400)
        self.assertEqual(self.request('/api/files/1/pdf',self.headers(Range='bytes=0-10'))[0],416)
        self.assertEqual(self.request('/api/viewer-session?token=x',self.headers())[0],400)
        (self.root/'one.pdf').unlink()
        self.assertEqual(self.request('/api/files/1/pdf',self.headers())[0],404)

    def test_missing_database_and_library(self):
        self.server.library_root=self.root/'absent'
        self.assertEqual(self.request('/api/files/1/pdf',self.headers())[0],404)
        self.server.database=Path(self.temp.name)/'absent.sqlite3'
        self.assertEqual(self.request('/api/files/1',self.headers())[0],503)
        self.assertFalse(self.server.database.exists())

    def test_pdf_eligibility_and_size_limit(self):
        with connect(self.database) as db:
            files=library_catalog(db,self.root)['files']
        self.assertEqual([f['viewer_status'] for f in files],['ready','ready','not_pdf','corrupt','unsupported','invalid_path','invalid_path','missing'])
        with open_pdf(self.root,'one.pdf','application/pdf') as (handle,size):
            self.assertEqual(handle.read(),self.content);self.assertEqual(size,len(self.content))
        (self.root/'large.pdf').write_bytes(b'%PDF-1.4\n')
        with (self.root/'large.pdf').open('r+b') as f:f.truncate(MAX_PDF_BYTES+1)
        self.assertEqual(preview_status(self.root,'large.pdf','application/pdf','acquired'),'too_large')

    def test_path_guards_and_reparse_points(self):
        for name in ['../one.pdf','nested/../one.pdf','nested/.. /one.pdf','one.pdf.','C:one.pdf',r'\\server\share\file','/etc/passwd','file.pdf:stream','\x00']:
            with self.assertRaises(PDFError):
                with open_pdf(self.root,name,'application/pdf'):pass
        self.assertEqual(preview_status(self.root,'.','application/pdf','acquired'),'invalid_path')
        original=Path.lstat
        def linked(path,*args,**kwargs):
            if path.name=='one.pdf':
                from types import SimpleNamespace
                return SimpleNamespace(st_mode=0o100644,st_file_attributes=0x400)
            return original(path,*args,**kwargs)
        with patch.object(Path,'lstat',linked):
            self.assertEqual(preview_status(self.root,'one.pdf','application/pdf','acquired'),'invalid_path')

    def test_vendor_integrity_and_security_policy(self):
        manifest=json.loads((STATIC/'vendor/pdfjs/MANIFEST.json').read_text())
        for name,info in manifest['files'].items():
            content=(STATIC/'vendor/pdfjs'/name).read_bytes()
            self.assertEqual(hashlib.sha256(content).hexdigest(),info['sha256'])
        self.assertNotIn('wasm/quickjs-eval.wasm',PDFJS_ASSETS)
        self.assertNotIn('build/pdf.sandbox.mjs',PDFJS_ASSETS)
        status,headers,_=self.request('/vendor/pdfjs/build/pdf.mjs')
        self.assertEqual(status,200)
        self.assertIn("worker-src 'self'",headers['Content-Security-Policy'])
        self.assertIn("object-src 'none'",headers['Content-Security-Policy'])
        self.assertNotIn('unsafe-eval',headers['Content-Security-Policy'])
