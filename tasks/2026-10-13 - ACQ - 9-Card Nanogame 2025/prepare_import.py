"""Prepare and verify registration only on copies. No operational apply path."""
import hashlib,json,sqlite3
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2];TASK=Path(__file__).parent;OUT=ROOT/'outputs/nine-card-acq-2026-10-13'
MAN=ROOT/'catalog/2025_nine_card_ranked_acquisition_2026-10-13.json'
def fingerprint(c):
 result={}
 for (name,) in c.execute("SELECT name FROM sqlite_master WHERE type='table' ORDER BY name"):
  rows=c.execute('SELECT * FROM "'+name+'"').fetchall()
  result[name]=hashlib.sha256(repr(sorted(rows,key=repr)).encode()).hexdigest()
 return result

def register_copy(db,m):
 if db.resolve()==(ROOT/'database/pnp_collection.sqlite3').resolve():raise ValueError('Operational database forbidden by this preparation tool')
 c=sqlite3.connect(db);c.execute('PRAGMA foreign_keys=ON');before=c.total_changes
 try:
  c.execute('BEGIN IMMEDIATE')
  acqs={}
  for x in m['items']:
   p=ROOT/'library'/x['relative_path'];data=p.read_bytes();assert len(data)==x['byte_size'] and hashlib.sha256(data).hexdigest()==x['sha256']
   assert c.execute('SELECT url FROM remote_resources WHERE id=? AND game_id=?',(x['remote_resource_id'],x['game_id'])).fetchone()==(x['resource_url'],)
   gid=x['game_id']
   if gid not in acqs:
    row=c.execute('SELECT id FROM acquisitions WHERE game_id=? AND source_snapshot=?',(gid,m['batch_key'])).fetchone()
    if row:aid=row[0]
    else:
     status=c.execute('SELECT status_normalized FROM games WHERE id=?',(gid,)).fetchone()[0]
     aid=c.execute('INSERT INTO acquisitions(game_id,acquired_at,selection_reason,game_status_at_acquisition,source_snapshot,notes) VALUES(?,?,?,?,?,?)',(gid,m['acquired_at'],x['selection_reason'],status,m['batch_key'],m['purpose'])).lastrowid
    acqs[gid]=aid
   aid=acqs[gid]
   old=c.execute('SELECT sha256,byte_size FROM acquired_files WHERE acquisition_id=? AND relative_path=?',(aid,x['relative_path'])).fetchone()
   if old:assert old==(x['sha256'],x['byte_size']);continue
   c.execute('INSERT INTO acquired_files(acquisition_id,remote_resource_id,relative_path,original_filename,media_type,byte_size,sha256,version_raw,final_url,language_code,acquisition_status,usage_conditions,notes) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?)',(aid,x['remote_resource_id'],x['relative_path'],x['original_filename'],x['media_type'],x['byte_size'],x['sha256'],x['version_raw'],x['final_url'],x['language_code'],'acquired',x['usage_conditions'],json.dumps({'scope':x['scope'],'transferred_at':x['transferred_at'],'source_remote_resource_ids':x['source_remote_resource_ids']},ensure_ascii=False)))
  for x in m['entry_outcomes']:
   source=next(e['wip_thread_url'] for e in m['selection'] if e['entry_id']==x['entry_id']);ep=MAN.relative_to(ROOT).as_posix()
   existing=c.execute('SELECT outcome,notes FROM entry_work_observations WHERE entry_id=? AND phase=? AND observed_at=? AND source_url=? AND evidence_path=?',(x['entry_id'],'acquisition',m['verified_at'],source,ep)).fetchone()
   if existing:assert existing==(x['outcome'],x['notes']);continue
   c.execute('INSERT INTO entry_work_observations(entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES(?,?,?,?,?,?,?)',(x['entry_id'],'acquisition',x['outcome'],m['verified_at'],source,ep,x['notes']))
  assert c.execute('PRAGMA integrity_check').fetchone()==('ok',)
  assert not c.execute('PRAGMA foreign_key_check').fetchall()
  c.commit()
 except Exception:c.rollback();raise
 changes=c.total_changes-before;c.close();return changes
if __name__=='__main__':
 m=json.loads(MAN.read_text(encoding='utf-8'));source=sqlite3.connect((ROOT/'database/pnp_collection.sqlite3').resolve().as_uri()+'?mode=ro',uri=True)
 before=fingerprint(source);baseline=OUT/'baseline-before-registration.sqlite3';copy=OUT/'registration-test.sqlite3';restore=OUT/'restore-test.sqlite3'
 for path in (baseline,copy,restore):
  dest=sqlite3.connect(path);source.backup(dest);dest.close()
 assert fingerprint(sqlite3.connect(restore))==before
 first=register_copy(copy,m);second=register_copy(copy,m);assert second==0
 c=sqlite3.connect(copy);after=fingerprint(c)
 changed=[name for name in before if before[name]!=after[name]];assert set(changed)=={'acquisitions','acquired_files','entry_work_observations'}
 # All original rows preserved, including the existing rows in modified tables.
 base=sqlite3.connect(baseline)
 for name in before:
  old=base.execute('SELECT * FROM "'+name+'"').fetchall();new=c.execute('SELECT * FROM "'+name+'"').fetchall();assert set(old)<=set(new)
 assert fingerprint(source)==before
 report=dict(verified_at='2026-10-14',operational_database='unchanged',files=len(m['items']),games_with_files=len({x['game_id'] for x in m['items']}),entry_outcomes=len(m['entry_outcomes']),first_pass_changes=first,replay_changes=second,changed_tables=changed,legacy_rows='all_preserved',backup_restore='full_fingerprint_equal',integrity_check=c.execute('PRAGMA integrity_check').fetchone()[0],foreign_key_check=c.execute('PRAGMA foreign_key_check').fetchall(),manifest_sha256=hashlib.sha256(MAN.read_bytes()).hexdigest())
 (TASK/'IMPORT_PREPARATION_VERIFICATION.json').write_text(json.dumps(report,indent=2)+'\n',encoding='utf-8');print(json.dumps(report))
