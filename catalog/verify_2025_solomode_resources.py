import shutil,sqlite3,tempfile
from pathlib import Path
R=Path(__file__).resolve().parents[1]
with tempfile.TemporaryDirectory() as d:
 p=Path(d)/'x.sqlite3';shutil.copy2(R/'database'/'pnp_collection.sqlite3',p);c=sqlite3.connect(p);c.executescript((R/'catalog'/'2025-solomode-wips-resources.sql').read_text(encoding='utf-8'))
 q=lambda s:c.execute(s).fetchone()[0]
 x={'integrity':q('PRAGMA integrity_check'),'fk':len(c.execute('PRAGMA foreign_key_check').fetchall()),'entries':q('SELECT count(*) FROM entries WHERE contest_id=16'),'wips':q('SELECT count(*) FROM entries WHERE contest_id=16 AND wip_thread_url IS NOT NULL'),'scans':q("SELECT count(*) FROM entry_resource_scans s JOIN entries e ON e.id=s.entry_id WHERE e.contest_id=16 AND s.checked_at='2026-09-15'"),'links':q('SELECT count(*) FROM entry_resource_mentions m JOIN entries e ON e.id=m.entry_id WHERE e.contest_id=16'),'observations':q("SELECT count(*) FROM remote_resource_observations o JOIN remote_resources r ON r.id=o.remote_resource_id JOIN entries e ON e.game_id=r.game_id WHERE e.contest_id=16 AND o.observed_at='2026-09-15'")};c.close()
 print(x);assert x=={'integrity':'ok','fk':0,'entries':38,'wips':36,'scans':38,'links':67,'observations':67}
