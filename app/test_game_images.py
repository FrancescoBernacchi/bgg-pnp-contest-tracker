"""Consultive IMG API/file regressions on synthetic disposable catalogs."""
import hashlib
import http.client
import io
import json
from pathlib import Path
import sys
import threading
import unittest
from PIL import Image

ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT/'database'))
from test_game_images import ImageCatalogTests as Fixtures
from game_images import image_catalog,raster_response,file_record
from pdf_files import PDFError
from server import connect,make_server

class ImageConsultationTests(unittest.TestCase):
    def setUp(self):
        self.fixture=Fixtures('test_preview_does_not_write_database');self.fixture.setUp()
        self.fixture.execute(True);self.db=self.fixture.db;self.library=self.fixture.library
        with connect(self.db) as db:self.file=file_record(db,1)
        self.before=hashlib.sha256(self.db.read_bytes()).hexdigest()
    def tearDown(self):self.fixture.tearDown()
    def test_projection_categories_research_and_shared_back(self):
        with connect(self.db) as db:
            d=image_catalog(db,1,self.library)
            self.assertEqual(len(d['files']),2);self.assertEqual(len(d['components']),1)
            self.assertEqual(len(d['components'][0]['links']),2)
            self.assertTrue(d['research'][0]['complete'])
            self.assertNotIn('relative_path',d['files'][0])
            self.assertEqual(image_catalog(db,2,self.library)['research'][0]['complete'],False)
        self.assertEqual(hashlib.sha256(self.db.read_bytes()).hexdigest(),self.before)
    def test_historical_attestation_does_not_override_current_observation(self):
        import copy
        historical=copy.deepcopy(self.fixture.m['images'][0]);historical['current_use']='Superata'
        self.fixture.m.update(checked_at='2026-10-06',images=[],components=[],historical_files=[historical])
        self.fixture.execute(True)
        with connect(self.db) as db:
            f=next(f for f in image_catalog(db,1,self.library)['files'] if f['image_id']=='front')
        self.assertTrue(f['is_current']);self.assertEqual(f['current_use'],'adopted')
        self.assertEqual(len(f['history']),2)
    def test_verified_png_original_thumbnail_and_no_source_changes(self):
        raw=(self.library/'immagini/game/front.png').read_bytes()
        original,mime=raster_response(self.library,self.file)
        self.assertEqual(original,raw);self.assertEqual(mime,'image/png')
        thumb,mime=raster_response(self.library,self.file,True)
        with Image.open(io.BytesIO(thumb)) as im:self.assertLessEqual(im.width,360);self.assertLessEqual(im.height,240)
        self.assertEqual(raw,(self.library/'immagini/game/front.png').read_bytes())
    def test_hash_checked_even_after_thumbnail_cached(self):
        raster_response(self.library,self.file,True)
        path=self.library/'immagini/game/front.png';raw=bytearray(path.read_bytes());raw[-1]^=1;path.write_bytes(raw)
        with self.assertRaises(PDFError) as e:raster_response(self.library,self.file,True)
        self.assertEqual(e.exception.status,409)
    def test_missing_traversal_dimensions_and_unsupported(self):
        for change,status in [({'relative_path':'immagini/../escape.png'},403),({'relative_path':'bgg/file.png'},403),
                              ({'relative_path':'immagini/game/missing.png'},404),({'format':'SVG'},415),({'width':100},409)]:
            with self.subTest(change=change):
                with self.assertRaises(PDFError) as e:raster_response(self.library,{**self.file,**change})
                self.assertEqual(e.exception.status,status)
    def test_jpeg_and_webp(self):
        for fmt,suffix in [('JPEG','jpg'),('WEBP','webp')]:
            path=self.library/('immagini/game/test.'+suffix);Image.new('RGB',(20,15)).save(path,format=fmt)
            f={**self.file,'format':fmt,'relative_path':path.relative_to(self.library).as_posix(),'width':20,'height':15,
               'byte_size':path.stat().st_size,'sha256':hashlib.sha256(path.read_bytes()).hexdigest()}
            self.assertEqual(raster_response(self.library,f)[1],'image/jpeg' if fmt=='JPEG' else 'image/webp')
    def test_schema_without_img_is_compatible(self):
        import sqlite3
        with sqlite3.connect(':memory:') as db:self.assertFalse(image_catalog(db,1,self.library)['available'])
    def test_jpeg_orientation_applied_only_to_thumbnail(self):
        path=self.library/'immagini/game/oriented.jpg'
        im=Image.new('RGB',(30,10));exif=im.getexif();exif[274]=6;im.save(path,exif=exif)
        f={**self.file,'format':'JPEG','relative_path':path.relative_to(self.library).as_posix(),'width':30,'height':10,
           'byte_size':path.stat().st_size,'sha256':hashlib.sha256(path.read_bytes()).hexdigest()}
        thumb,_=raster_response(self.library,f,True)
        with Image.open(io.BytesIO(thumb)) as oriented:self.assertEqual(oriented.size,(10,30))
        self.assertEqual(raster_response(self.library,f)[0],path.read_bytes())
    def test_http_guard_head_unknown_parameters_and_writes(self):
        server=make_server(self.db,0,self.library);thread=threading.Thread(target=server.serve_forever,daemon=True);thread.start()
        try:
            def request(url,headers=None,method='GET'):
                c=http.client.HTTPConnection('127.0.0.1',server.server_port)
                c.request(method,url,headers=headers or {});r=c.getresponse();result=r.status,dict(r.getheaders()),r.read();c.close();return result
            same={'Sec-Fetch-Site':'same-origin'}
            status,_,body=request('/api/viewer-session',same);self.assertEqual(status,200)
            guarded={**same,'X-PnP-Viewer':json.loads(body)['token']}
            self.assertEqual(request('/api/image-files/1/original')[0],403)
            self.assertEqual(request('/api/image-files/1/original',same)[0],403)
            self.assertEqual(request('/api/image-files/1/original',{**guarded,'Origin':'https://example.invalid'})[0],403)
            self.assertEqual(request('/api/image-files/999/original',guarded)[0],404)
            self.assertEqual(request('/api/image-files/1/original?path=bad',guarded)[0],400)
            self.assertEqual(request('/api/image-files/1/original',{**guarded,'Range':'bytes=0-10'})[0],400)
            status,headers,body=request('/api/image-files/1/thumbnail',guarded);self.assertEqual(status,200)
            self.assertEqual(headers['Content-Type'],'image/png');self.assertEqual(headers['Cache-Control'],'no-store')
            self.assertEqual(request('/api/image-files/1/original',guarded,'HEAD')[2],b'')
            self.assertEqual(request('/api/games/1/images',same)[0],200)
            self.assertEqual(request('/api/games/999/images',same)[0],404)
            self.assertEqual(request('/api/games/1/images?url=bad',same)[0],400)
            self.assertEqual(request('/api/games/1/images',same,'POST')[0],405)
        finally:server.shutdown();server.server_close();thread.join()
        self.assertEqual(hashlib.sha256(self.db.read_bytes()).hexdigest(),self.before)

if __name__=='__main__':unittest.main(verbosity=2)
