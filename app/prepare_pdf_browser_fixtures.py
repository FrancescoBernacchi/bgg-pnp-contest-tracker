"""Fixture browser isolate in outputs; pypdf è solo una dipendenza di sviluppo."""
import argparse
from pathlib import Path
import sqlite3
import hashlib
import io

from pdf_test_fixtures import sample_pdf
from server import ROOT, make_server


def prepare():
    from pypdf import PdfReader, PdfWriter
    folder=ROOT/'outputs/pdf-viewer-browser-fixtures'
    folder.mkdir(parents=True,exist_ok=True)
    library=folder/'library';library.mkdir(exist_ok=True)
    database=folder/'fixtures.sqlite3'
    if database.exists():
        return database,library
    writer=PdfWriter(clone_from=PdfReader(io.BytesIO(sample_pdf())))
    writer.encrypt('fixture-only-password',algorithm='AES-256')
    encrypted=io.BytesIO();writer.write(encrypted)
    fixtures=[('active.pdf',sample_pdf(active=True)),('encrypted.pdf',encrypted.getvalue()),
              ('malformed.pdf',b'%PDF-1.4\ninvalid structure\n%%EOF\n'),('missing.pdf',None)]
    db=sqlite3.connect(database)
    db.executescript((ROOT/'database/schema.sql').read_text(encoding='utf-8'))
    db.execute("INSERT INTO games (id,canonical_title,source_url,first_seen_at,last_verified_at) VALUES (1,'PDF browser fixture','https://example.invalid/','2026-10-03','2026-10-03')")
    db.execute("INSERT INTO acquisitions (id,game_id,acquired_at,selection_reason,game_status_at_acquisition) VALUES (1,1,'2026-10-03','Fixture autonoma','unknown')")
    for index,(name,data) in enumerate(fixtures,1):
        if data is not None:(library/name).write_bytes(data)
        db.execute('''INSERT INTO acquired_files (id,acquisition_id,relative_path,original_filename,
            media_type,byte_size,sha256,version_raw) VALUES (?,1,?,?,'application/pdf',?,?,?)''',
            (index,name,name,len(data or b''),hashlib.sha256(data or b'').hexdigest(),str(index)))
    db.commit();db.close()
    return database,library


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__);parser.add_argument('--serve',action='store_true');args=parser.parse_args()
    database,library=prepare()
    if args.serve:
        print('Fixture browser: http://127.0.0.1:8772/#library',flush=True)
        server=make_server(database,8772,library)
        try:server.serve_forever()
        except KeyboardInterrupt:pass
        finally:server.server_close()
