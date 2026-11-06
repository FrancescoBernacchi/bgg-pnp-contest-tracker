"""TSK-0051 targeted MAT recheck: offline copies first, explicit apply after validation."""
import argparse,hashlib,json,sqlite3,sys
from pathlib import Path
from datetime import datetime,timezone
ROOT=Path(__file__).resolve().parents[2];TASK=Path(__file__).parent;OUT=ROOT/'outputs/nine-card-mat-revisit-2026-11-06';MAN=ROOT/'catalog/2025_nine_card_mat_revisit_2026-11-06.json';DB=ROOT/'database/pnp_collection.sqlite3';EVIDENCE=MAN.relative_to(ROOT).as_posix()
def fingerprint(c):
 return {n:hashlib.sha256(repr(sorted(c.execute('SELECT * FROM "'+n+'"').fetchall(),key=repr)).encode()).hexdigest() for (n,) in c.execute("SELECT name FROM sqlite_master WHERE type='table' ORDER BY name")}
def register_copy(path,m):
 if path.resolve()==DB.resolve():raise ValueError('Operational path forbidden')
 c=sqlite3.connect(path);c.execute('PRAGMA foreign_keys=ON');before=c.total_changes
 try:
  c.execute('BEGIN IMMEDIATE')
  for e in m['entries']:
   notes='TSK-0051 riesame mirato 2026-11-06; '+e['notes']
   vals=(e['entry_id'],m['verified_at'],e['source_url'],e['wip_status'],e['resource_listing_status'],notes)
   existing=c.execute('SELECT wip_status,resource_listing_status,notes FROM entry_resource_scans WHERE entry_id=? AND checked_at=? AND source_url=?',vals[:3]).fetchone()
   if existing:assert existing==vals[3:]
   else:c.execute('INSERT INTO entry_resource_scans(entry_id,checked_at,source_url,wip_status,resource_listing_status,notes) VALUES(?,?,?,?,?,?)',vals)
   vals=(e['entry_id'],m['verified_at'],e['source_url'],e['wip_status'],e['material_listing_status'],'first_post_only',notes)
   existing=c.execute('SELECT wip_status,material_listing_status,coverage_scope,notes FROM entry_material_scans WHERE entry_id=? AND checked_at=? AND source_url=?',vals[:3]).fetchone()
   if existing:assert existing==vals[3:]
   else:c.execute('INSERT INTO entry_material_scans(entry_id,checked_at,source_url,wip_status,material_listing_status,coverage_scope,notes) VALUES(?,?,?,?,?,?,?)',vals)
   vals=(e['entry_id'],'materials',e['outcome'],m['verified_at'],e['source_url'],EVIDENCE,notes)
   existing=c.execute('SELECT outcome,notes FROM entry_work_observations WHERE entry_id=? AND phase=? AND observed_at=? AND source_url=? AND evidence_path=?',(e['entry_id'],'materials',m['verified_at'],e['source_url'],EVIDENCE)).fetchone()
   if existing:assert existing==(e['outcome'],notes)
   else:c.execute('INSERT INTO entry_work_observations(entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES(?,?,?,?,?,?,?)',vals)
  assert c.execute('PRAGMA integrity_check').fetchone()==('ok',);assert not c.execute('PRAGMA foreign_key_check').fetchall();c.commit()
 except Exception:c.rollback();raise
 count=c.total_changes-before;c.close();return count
def prepare(m):
 source=sqlite3.connect(DB.resolve().as_uri()+'?mode=ro',uri=True);before=fingerprint(source)
 for name in ('baseline.sqlite3','tested.sqlite3','restored.sqlite3'):
  dest=sqlite3.connect(OUT/name);source.backup(dest);dest.close()
 restore=sqlite3.connect(OUT/'restored.sqlite3');assert fingerprint(restore)==before;restore.close()
 first=register_copy(OUT/'tested.sqlite3',m);second=register_copy(OUT/'tested.sqlite3',m);assert second==0
 tested=sqlite3.connect(OUT/'tested.sqlite3');after=fingerprint(tested);changed=[n for n in before if before[n]!=after[n]];assert set(changed)=={'entry_resource_scans','entry_material_scans','entry_work_observations'}
 base=sqlite3.connect(OUT/'baseline.sqlite3')
 for n in before:assert set(base.execute('SELECT * FROM "'+n+'"').fetchall())<=set(tested.execute('SELECT * FROM "'+n+'"').fetchall())
 assert fingerprint(source)==before
 report=dict(verified_at=m['verified_at'],manifest_sha256=hashlib.sha256(MAN.read_bytes()).hexdigest(),entries=12,first_pass_changes=first,replay_changes=second,changed_tables=changed,legacy_rows='all_preserved',identity_roster_resources_requirements_acquisition_images='unchanged',backup_restore='full_fingerprint_equal',integrity='ok',foreign_keys=[])
 (TASK/'REVISIT_PREPARATION_VERIFICATION_2026-11-06.json').write_text(json.dumps(report,indent=2)+'\n',encoding='utf8');source.close();base.close();tested.close();return report
def apply(m,auth):
 if auth!='TSK-0051-user-next-MAT-step-2026-11-06':raise ValueError('Authorization not recognized')
 report_path=TASK/'REVISIT_OPERATIONAL_VERIFICATION_2026-11-06.json'
 if report_path.exists():
  report=json.loads(report_path.read_text());assert report['manifest_sha256']==hashlib.sha256(MAN.read_bytes()).hexdigest();c=sqlite3.connect(DB.resolve().as_uri()+'?mode=ro',uri=True)
  for e in m['entries']:assert c.execute('SELECT outcome FROM entry_work_observations WHERE entry_id=? AND phase=? AND observed_at=? AND source_url=? AND evidence_path=?',(e['entry_id'],'materials',m['verified_at'],e['source_url'],EVIDENCE)).fetchone()==(e['outcome'],)
  assert c.execute('PRAGMA integrity_check').fetchone()==('ok',);assert not c.execute('PRAGMA foreign_key_check').fetchall();c.close();return dict(replay='read_only',entries=12,writes=0)
 verify=prepare(m);base=sqlite3.connect(OUT/'baseline.sqlite3');tested=sqlite3.connect(OUT/'tested.sqlite3');before=fingerprint(base);after=fingerprint(tested);c=sqlite3.connect(DB,timeout=5);c.execute('PRAGMA foreign_keys=ON');assert fingerprint(c)==before
 stamp=datetime.now(timezone.utc).strftime('%Y%m%dT%H%M%SZ');backup=OUT/('before-'+stamp+'.sqlite3');restore=OUT/('restore-'+stamp+'.sqlite3')
 for path in (backup,restore):
  dest=sqlite3.connect(path);c.backup(dest);dest.close()
 r=sqlite3.connect(restore);assert fingerprint(r)==before;r.close();counts={}
 try:
  c.execute('BEGIN EXCLUSIVE');assert fingerprint(c)==before
  for n in verify['changed_tables']:
   old=set(base.execute('SELECT * FROM "'+n+'"').fetchall());delta=[row for row in tested.execute('SELECT * FROM "'+n+'"') if row not in old];cols=[row[1] for row in c.execute('PRAGMA table_info("'+n+'")')];sql='INSERT INTO "'+n+'" ('+','.join('"'+x+'"' for x in cols)+') VALUES ('+','.join('?' for _ in cols)+')';c.executemany(sql,delta);counts[n]=len(delta)
  assert fingerprint(c)==after;assert c.execute('PRAGMA integrity_check').fetchone()==('ok',);assert not c.execute('PRAGMA foreign_key_check').fetchall();c.commit()
 except Exception:c.rollback();raise
 report=dict(applied_at=m['verified_at'],authorization=auth,manifest_sha256=verify['manifest_sha256'],inserted=counts,backup=str(backup.relative_to(ROOT)),backup_sha256=hashlib.sha256(backup.read_bytes()).hexdigest(),backup_restore='full_fingerprint_equal',operational_matches_tested_copy=True,integrity='ok',foreign_keys=[],unrelated_tables='all_unchanged',legacy_rows='all_preserved')
 report_path.write_text(json.dumps(report,indent=2)+'\n',encoding='utf8');c.close();base.close();tested.close();return report
if __name__=='__main__':
 p=argparse.ArgumentParser();p.add_argument('--apply',action='store_true');p.add_argument('--authorization');args=p.parse_args();OUT.mkdir(parents=True,exist_ok=True);m=json.loads(MAN.read_text(encoding='utf8'));print(json.dumps(apply(m,args.authorization) if args.apply else prepare(m)))
