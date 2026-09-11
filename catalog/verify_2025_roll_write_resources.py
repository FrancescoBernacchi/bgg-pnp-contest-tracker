import shutil, sqlite3, tempfile
from pathlib import Path
root=Path(__file__).resolve().parents[1]
with tempfile.TemporaryDirectory() as d:
    db=Path(d)/'test.sqlite3'
    shutil.copy2(root/'database/pnp_collection.sqlite3',db)
    c=sqlite3.connect(db)
    c.executescript((root/'catalog/2025-roll-write-wips-resources.sql').read_text(encoding='utf-8'))
    checks={
      'integrity':c.execute('pragma integrity_check').fetchone()[0],
      'fk':len(c.execute('pragma foreign_key_check').fetchall()),
      'wips':c.execute('select count(*) from entries where contest_id=22 and wip_thread_url is not null').fetchone()[0],
      'scans':c.execute("select count(*) from entry_resource_scans s join entries e on e.id=s.entry_id where e.contest_id=22 and s.checked_at='2026-09-10'").fetchone()[0],
      'mentions':c.execute('select count(*) from entry_resource_mentions m join entries e on e.id=m.entry_id where e.contest_id=22').fetchone()[0],
      'resources':c.execute('select count(distinct m.remote_resource_id) from entry_resource_mentions m join entries e on e.id=m.entry_id where e.contest_id=22').fetchone()[0],
      'none':c.execute("select count(*) from entry_resource_scans s join entries e on e.id=s.entry_id where e.contest_id=22 and s.resource_listing_status='none_declared'").fetchone()[0],
      'vanguard':c.execute("select wip_thread_url from entries e join games g on g.id=e.game_id where e.contest_id=22 and g.canonical_title='Vanguard Multi Asset Global Command'").fetchone()[0],
    }
    print(checks)
    c.close()
    assert checks=={'integrity':'ok','fk':0,'wips':37,'scans':37,'mentions':82,'resources':82,'none':7,'vanguard':'https://boardgamegeek.com/thread/3619638'}

