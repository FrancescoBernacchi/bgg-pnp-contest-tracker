"""Apply the reviewed copy delta after explicit authorization; exclusive transaction."""
import argparse,hashlib,importlib.util,json,sqlite3,subprocess,sys
from datetime import datetime,timezone
from pathlib import Path
TASK=Path(__file__).parent;ROOT=TASK.parents[1];OUT=ROOT/'outputs/nine-card-acq-2026-10-13';DB=ROOT/'database/pnp_collection.sqlite3'
p=argparse.ArgumentParser();p.add_argument('--authorization',required=True);args=p.parse_args()
if args.authorization!='TSK-0087-user-OK-2026-10-14':raise ValueError('Explicit authorization not recognized')
if (TASK/'OPERATIONAL_VERIFICATION.json').exists():
 m=json.loads((ROOT/'catalog/2025_nine_card_ranked_acquisition_2026-10-13.json').read_text(encoding='utf-8'))
 ro=sqlite3.connect(DB.resolve().as_uri()+'?mode=ro',uri=True)
 for x in m['items']:
  row=ro.execute('SELECT af.sha256,af.byte_size FROM acquired_files af JOIN acquisitions a ON a.id=af.acquisition_id WHERE a.source_snapshot=? AND af.relative_path=?',(m['batch_key'],x['relative_path'])).fetchone()
  assert row==(x['sha256'],x['byte_size'])
 assert ro.execute('PRAGMA integrity_check').fetchone()==('ok',);assert not ro.execute('PRAGMA foreign_key_check').fetchall()
 print(json.dumps(dict(replay='read_only',files_verified=len(m['items']),writes=0)));ro.close();sys.exit(0)
subprocess.run([sys.executable,str(TASK/'prepare_import.py')],check=True)
spec=importlib.util.spec_from_file_location('prep',TASK/'prepare_import.py');prep=importlib.util.module_from_spec(spec);spec.loader.exec_module(prep)
manifest=json.loads(prep.MAN.read_text(encoding='utf-8'));verified=json.loads((TASK/'IMPORT_PREPARATION_VERIFICATION.json').read_text())
assert verified['manifest_sha256']==hashlib.sha256(prep.MAN.read_bytes()).hexdigest()
baseline=sqlite3.connect(OUT/'baseline-before-registration.sqlite3');tested=sqlite3.connect(OUT/'registration-test.sqlite3');expected_before=prep.fingerprint(baseline);expected_after=prep.fingerprint(tested)
stamp=datetime.now(timezone.utc).strftime('%Y%m%dT%H%M%SZ');backup=OUT/('operational-before-'+stamp+'.sqlite3');restore=OUT/('operational-restore-'+stamp+'.sqlite3')
c=sqlite3.connect(DB,timeout=5);c.execute('PRAGMA foreign_keys=ON');assert prep.fingerprint(c)==expected_before
for path in (backup,restore):
 dest=sqlite3.connect(path);c.backup(dest);dest.close()
r=sqlite3.connect(restore);assert prep.fingerprint(r)==expected_before;r.close()
changed=['acquisitions','acquired_files','entry_work_observations'];assert set(changed)==set(verified['changed_tables']);counts={}
try:
 c.execute('BEGIN EXCLUSIVE');assert prep.fingerprint(c)==expected_before
 for name in changed:
  columns=[r[1] for r in c.execute('PRAGMA table_info("'+name+'")')]
  previous=set(baseline.execute('SELECT * FROM "'+name+'"').fetchall());rows=tested.execute('SELECT * FROM "'+name+'"').fetchall();delta=[r for r in rows if r not in previous]
  sql='INSERT INTO "'+name+'" ('+','.join('"'+x+'"' for x in columns)+') VALUES ('+','.join('?' for x in columns)+')'
  c.executemany(sql,delta);counts[name]=len(delta)
 assert prep.fingerprint(c)==expected_after
 assert c.execute('PRAGMA integrity_check').fetchone()==('ok',);assert not c.execute('PRAGMA foreign_key_check').fetchall()
 c.commit()
except Exception:c.rollback();raise
assert prep.fingerprint(c)==expected_after
# Replay reconciliation is read-only: exact fingerprint equality with the collaudated result.
report=dict(applied_at='2026-10-14',authorization=args.authorization,backup=str(backup.relative_to(ROOT)),backup_sha256=hashlib.sha256(backup.read_bytes()).hexdigest(),backup_restore='verified_full_fingerprint',inserted=counts,exclusive_transaction='committed',operational_matches_tested_copy=True,replay='read_only_exact_fingerprint',integrity_check='ok',foreign_key_check=[],manifest_sha256=verified['manifest_sha256'])
(TASK/'OPERATIONAL_VERIFICATION.json').write_text(json.dumps(report,indent=2)+'\n',encoding='utf-8');print(json.dumps(report));c.close();baseline.close();tested.close()
