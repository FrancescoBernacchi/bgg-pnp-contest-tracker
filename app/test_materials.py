"""Regressioni multiformato, ZIP e sicurezza su database/materiali sintetici."""
import hashlib
import http.client
import io
import json
from pathlib import Path
import sqlite3
import struct
import sys
import threading
import unittest
from unittest.mock import patch
import zipfile
import zlib

import test_server
from server import make_server, connect, ROOT
from material_files import DOCX, open_material, material_status, docx_blocks
from pdf_files import PDFError
sys.path.insert(0, str(ROOT/'catalog'))
from extract_registered_archives import extract_one, validate_entries
from library_catalog import library_catalog


def png(width=1, height=1):
    def chunk(kind, data):
        return struct.pack('>I', len(data))+kind+data+struct.pack('>I', zlib.crc32(kind+data)&0xffffffff)
    return b'\x89PNG\r\n\x1a\n'+chunk(b'IHDR', struct.pack('>IIBBBBB',width,height,8,2,0,0,0))+chunk(b'IDAT',zlib.compress(b'\x00\xff\x00\x00'))+chunk(b'IEND',b'')


def docx(xml=None):
    output=io.BytesIO()
    with zipfile.ZipFile(output,'w') as archive:
        archive.writestr('word/document.xml', xml or '''<w:document xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main"><w:body><w:p><w:r><w:t>&lt;script&gt;test&lt;/script&gt;</w:t></w:r></w:p><w:tbl><w:tr><w:tc><w:p><w:r><w:t>Cella</w:t></w:r></w:p></w:tc></w:tr></w:tbl></w:body></w:document>''')
        archive.writestr('word/_rels/document.xml.rels','<external href="https://example.org/evil"/>')
    return output.getvalue()


class MaterialTests(unittest.TestCase):
    insert=staticmethod(test_server.ApplicationTests.insert)
    setUp=test_server.ApplicationTests.setUp
    tearDown=test_server.ApplicationTests.tearDown

    def seed(self):
        self.root=Path(self.temp.name)/'library';self.root.mkdir()
        db=sqlite3.connect(self.database)
        self.insert(db,'acquisitions',id=1,game_id=1,acquired_at='2026-10-03',selection_reason='test',game_status_at_acquisition='unknown')
        for i,(name,mime,data) in enumerate([('image.png','image/png',png()),('rules.docx',DOCX,docx())],1):
            (self.root/name).write_bytes(data)
            self.insert(db,'acquired_files',id=i,acquisition_id=1,relative_path=name,original_filename=name,media_type=mime,byte_size=len(data),sha256=hashlib.sha256(data).hexdigest())
        db.commit();db.close()

    def test_formats_errors_limits_and_text_only(self):
        self.seed()
        self.assertEqual(material_status(self.root,'image.png','image/png','acquired'),'ready')
        with open_material(self.root,'rules.docx',DOCX) as (handle,size):
            blocks=docx_blocks(handle)
            self.assertEqual(blocks[0]['text'],'<script>test</script>')
            self.assertEqual(blocks[1]['rows'],[['Cella']])
            self.assertNotIn('example.org',json.dumps(blocks))
        (self.root/'bad.png').write_bytes(png()[:-1])
        self.assertEqual(material_status(self.root,'bad.png','image/png','acquired'),'corrupt')
        (self.root/'huge.png').write_bytes(png(16000,16000))
        self.assertEqual(material_status(self.root,'huge.png','image/png','acquired'),'too_large')
        (self.root/'bad.docx').write_bytes(docx('<!DOCTYPE x [<!ENTITY bad "evil">]><x/>'))
        self.assertEqual(material_status(self.root,'bad.docx',DOCX,'acquired'),'corrupt')
        self.assertEqual(material_status(self.root,'missing.png','image/png','acquired'),'missing')
        self.assertEqual(material_status(self.root,'../image.png','image/png','acquired'),'invalid_path')
        with patch('material_files.MAX_BYTES',1):
            self.assertEqual(material_status(self.root,'image.png','image/png','acquired'),'too_large')

    def test_http_token_format_head_no_write(self):
        self.seed()
        before=hashlib.sha256(self.database.read_bytes()).hexdigest()
        server=make_server(self.database,0,self.root)
        thread=threading.Thread(target=server.serve_forever,daemon=True);thread.start()
        try:
            client=http.client.HTTPConnection('127.0.0.1',server.server_port)
            headers={'Sec-Fetch-Site':'same-origin','X-PnP-Viewer':server.viewer_token}
            for path,status in [('/api/files/1/png',200),('/api/files/2/docx',200),('/api/files/1/docx',415),('/api/files/999/png',404)]:
                client.request('GET',path,headers=headers);response=client.getresponse();body=response.read()
                self.assertEqual(response.status,status)
                if path.endswith('/docx') and status==200:self.assertEqual(json.loads(body)['blocks'][1]['rows'],[['Cella']])
            client.request('GET','/api/files/1/png');response=client.getresponse();response.read();self.assertEqual(response.status,403)
            client.request('HEAD','/api/files/2/docx',headers=headers);response=client.getresponse();self.assertEqual(response.read(),b'');self.assertEqual(response.status,200)
            client.close()
        finally:
            server.shutdown();server.server_close();thread.join()
        self.assertEqual(before,hashlib.sha256(self.database.read_bytes()).hexdigest())

    def test_docx_compatibility_branches_are_not_duplicated(self):
        xml='''<w:document xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"><w:body><w:p><mc:AlternateContent><mc:Choice><w:r><w:t>Doppione</w:t></w:r></mc:Choice><mc:Fallback><w:r><w:t>Unico</w:t></w:r></mc:Fallback></mc:AlternateContent></w:p></w:body></w:document>'''
        self.assertEqual(docx_blocks(io.BytesIO(docx(xml))),[{'kind':'paragraph','text':'Unico'}])

    def archive(self, names):
        data=io.BytesIO()
        with zipfile.ZipFile(data,'w') as archive:
            for name,content in names:archive.writestr(name,content)
        content=data.getvalue();path=self.root/'archive.zip';path.write_bytes(content)
        db=sqlite3.connect(self.database);db.row_factory=sqlite3.Row
        self.insert(db,'acquired_files',id=3,acquisition_id=1,relative_path='archive.zip',original_filename='archive.zip',media_type='application/zip',byte_size=len(content),sha256=hashlib.sha256(content).hexdigest())
        db.commit()
        return db,dict(db.execute('SELECT * FROM acquired_files WHERE id=3').fetchone())

    def test_zip_repeatability_provenance_hash_original_nested(self):
        self.seed();db,record=self.archive([('/',b''),('sub/image.png',png()),('rules.docx',docx()),('nested.zip',b'not recursively extracted')])
        original=(self.root/'archive.zip').read_bytes()
        first=extract_one(db,self.root,record);db.commit()
        second=extract_one(db,self.root,record);db.commit()
        self.assertEqual(first,second);self.assertEqual(len(first),3)
        self.assertEqual(db.execute('SELECT count(*) FROM acquired_files').fetchone()[0],6)
        self.assertEqual(db.execute('SELECT count(*) FROM archive_contents').fetchone()[0],3)
        for file in first:self.assertEqual(hashlib.sha256((self.root/file['relative_path']).read_bytes()).hexdigest(),file['sha256'])
        self.assertEqual((self.root/'archive.zip').read_bytes(),original)
        db.close()
        with connect(self.database) as db:
            derived=[f for f in library_catalog(db,self.root)['files'] if f['archive_origin']]
            self.assertEqual({f['archive_origin']['archive_file_id'] for f in derived},{3})
            self.assertEqual({f['viewer_kind'] for f in derived},{'png','docx',None})

    def test_zip_traversal_duplicate_links_bombs_password_and_corruption(self):
        for name in ['../evil','/evil','C:/evil','file:stream','folder/../evil','file.']:
            with self.assertRaises(ValueError):validate_entries([zipfile.ZipInfo(name)])
        with self.assertRaises(ValueError):validate_entries([zipfile.ZipInfo('a'),zipfile.ZipInfo('A')])
        item=zipfile.ZipInfo('link');item.external_attr=(0o120777<<16)
        with self.assertRaises(ValueError):validate_entries([item])
        item=zipfile.ZipInfo('password');item.flag_bits=1
        with self.assertRaises(ValueError):validate_entries([item])
        item=zipfile.ZipInfo('bomb');item.file_size=10000;item.compress_size=1
        with self.assertRaises(ValueError):validate_entries([item])
        with patch('extract_registered_archives.MAX_ENTRIES',1):
            with self.assertRaises(ValueError):validate_entries([zipfile.ZipInfo('a'),zipfile.ZipInfo('b')])
        self.seed();db,record=self.archive([('../evil',b'evil')])
        with self.assertRaises(ValueError):extract_one(db,self.root,record)
        self.assertFalse((self.root/'_extracted').exists());db.close()

    def test_zip_existing_content_is_never_overwritten(self):
        self.seed();db,record=self.archive([('rules.docx',docx())])
        first=extract_one(db,self.root,record);db.commit()
        target=self.root/first[0]['relative_path'];target.write_bytes(b'changed')
        with self.assertRaises(ValueError):extract_one(db,self.root,record)
        self.assertEqual(target.read_bytes(),b'changed');db.close()

    def test_zip_corrupt_hash_and_size_are_explicit(self):
        self.seed();db,record=self.archive([('file.txt',b'hello')])
        with patch('extract_registered_archives.MAX_ARCHIVE',1):
            with self.assertRaises(ValueError):extract_one(db,self.root,record)
        (self.root/'archive.zip').write_bytes(b'bad zip')
        with self.assertRaises(ValueError):extract_one(db,self.root,record)
        record['sha256']=hashlib.sha256(b'bad zip').hexdigest()
        with self.assertRaises(zipfile.BadZipFile):extract_one(db,self.root,record)
        db.close()


if __name__=='__main__':unittest.main()
