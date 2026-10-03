"""Fixture isolate APP-005: giochi, acquisizioni, pagine e formati reali."""
import hashlib
from pathlib import Path
import sqlite3
from test_materials import png, docx
from pdf_test_fixtures import sample_pdf
from server import ROOT, make_server
from material_files import DOCX

folder=ROOT/'outputs/app005-browser'
folder.mkdir(exist_ok=True)
library=folder/'library';library.mkdir(exist_ok=True)
database=folder/'fixtures-v2.sqlite3'
if not database.exists():
    db=sqlite3.connect(database)
    db.executescript((ROOT/'database/schema.sql').read_text(encoding='utf-8'))
    for game in range(1,53):
        db.execute("INSERT INTO games (id,canonical_title,source_url,first_seen_at,last_verified_at) VALUES (?,?,'https://example.invalid','2026-10-03','2026-10-03')",(game,f'Gioco {game:02}'))
        db.execute("INSERT INTO acquisitions (id,game_id,acquired_at,selection_reason,game_status_at_acquisition) VALUES (?,?,'2026-10-03','Fixture','unknown')",(game,game))
    fixtures=[('test.png','image/png',png()),('rules.docx',DOCX,docx()),('test.pdf','application/pdf',sample_pdf()),('unsupported.txt','text/plain',b'Unsupported')]
    for i,(name,mime,data) in enumerate(fixtures,1):
        (library/name).write_bytes(data)
        db.execute('INSERT INTO acquired_files (id,acquisition_id,relative_path,original_filename,media_type,byte_size,sha256,version_raw) VALUES (?,1,?,?,?,?,?,?)',(i,name,name,mime,len(data),hashlib.sha256(data).hexdigest(),str(i)))
    for game in range(2,53):
        db.execute("INSERT INTO acquired_files (acquisition_id,relative_path,original_filename,media_type,byte_size,sha256) VALUES (?,'test.png','test.png','image/png',?,?)",(game,len(png()),hashlib.sha256(png()).hexdigest()))
    db.commit();db.close()
print('APP-005 fixture: http://127.0.0.1:8774/#library',flush=True)
server=make_server(database,8774,library)
try:server.serve_forever()
except KeyboardInterrupt:pass
finally:server.server_close()
