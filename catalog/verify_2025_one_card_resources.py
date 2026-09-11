import shutil, sqlite3, tempfile
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
with tempfile.TemporaryDirectory() as d:
    db=Path(d)/'test.sqlite3'; shutil.copy2(ROOT/'database'/'pnp_collection.sqlite3',db)
    c=sqlite3.connect(db); c.executescript((ROOT/'catalog'/'2025-one-card-wips-resources.sql').read_text(encoding='utf-8'))
    checks={
      'integrity':c.execute('PRAGMA integrity_check').fetchone()[0],
      'foreign_keys':len(c.execute('PRAGMA foreign_key_check').fetchall()),
      'entries':c.execute('SELECT count(*) FROM entries WHERE contest_id=15').fetchone()[0],
      'wips':c.execute('SELECT count(*) FROM entries WHERE contest_id=15 AND wip_thread_url IS NOT NULL').fetchone()[0],
      'scans':c.execute("SELECT count(*) FROM entry_resource_scans s JOIN entries e ON e.id=s.entry_id WHERE e.contest_id=15 AND s.checked_at='2026-09-11'").fetchone()[0],
      'observed':c.execute("SELECT count(*) FROM entry_resource_scans s JOIN entries e ON e.id=s.entry_id WHERE e.contest_id=15 AND s.resource_listing_status='observed'").fetchone()[0],
      'none_declared':c.execute("SELECT count(*) FROM entry_resource_scans s JOIN entries e ON e.id=s.entry_id WHERE e.contest_id=15 AND s.resource_listing_status='none_declared'").fetchone()[0],
      'not_observable':c.execute("SELECT count(*) FROM entry_resource_scans s JOIN entries e ON e.id=s.entry_id WHERE e.contest_id=15 AND s.resource_listing_status='not_observable'").fetchone()[0],
      'mentions':c.execute('SELECT count(*) FROM entry_resource_mentions m JOIN entries e ON e.id=m.entry_id WHERE e.contest_id=15').fetchone()[0],
      'resources':c.execute('SELECT count(DISTINCT remote_resource_id) FROM entry_resource_mentions m JOIN entries e ON e.id=m.entry_id WHERE e.contest_id=15').fetchone()[0],
    }; c.close()
expected={'integrity':'ok','foreign_keys':0,'entries':38,'wips':38,'scans':38,'observed':35,'none_declared':2,'not_observable':1,'mentions':72,'resources':72}
print(checks); assert checks==expected
