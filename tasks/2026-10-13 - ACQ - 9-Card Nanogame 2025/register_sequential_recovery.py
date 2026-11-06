"""Sequential, separately verified roster/MAT/ACQ increments. Offline only."""
import sqlite3,json,hashlib,pathlib,sys
ROOT=pathlib.Path(__file__).resolve().parents[2];TASK=pathlib.Path(__file__).parent
MAN=ROOT/'catalog/2025_nine_card_sequential_recovery_2026-11-06.json';OUT=ROOT/'outputs/nine-card-sequential-recovery-2026-11-06';DB=ROOT/'database/pnp_collection.sqlite3'
m=json.loads(MAN.read_text(encoding='utf-8'));stamp=m['verified_at'];ep=MAN.relative_to(ROOT).as_posix()
def con(path,ro=False):
 c=sqlite3.connect(path.resolve().as_uri()+'?mode=ro',uri=True) if ro else sqlite3.connect(path)
 c.execute('PRAGMA foreign_keys=ON');return c
def snap(c):
 return {t:sorted(c.execute('SELECT * FROM "'+t+'"').fetchall(),key=repr) for (t,) in c.execute("SELECT name FROM sqlite_master WHERE type='table' ORDER BY name")}
def integrity(c):
 assert c.execute('PRAGMA integrity_check').fetchone()==('ok',);assert not c.execute('PRAGMA foreign_key_check').fetchall()
def obs(c,typ,eid,field,raw,norm,url):
 c.execute('INSERT INTO observations(entity_type,entity_id,field_name,raw_value,normalized_value,source_url,observed_at,confidence) VALUES(?,?,?,?,?,?,?,?)',(typ,eid,field,raw,norm,url,stamp,'verified'))
def verify_files():
 from PIL import Image
 for x in m['items']:
  p=ROOT/'library'/x['relative_path'];b=p.read_bytes();assert len(b)==x['byte_size'] and hashlib.sha256(b).hexdigest()==x['sha256'];im=Image.open(p);assert im.format=='PNG' and im.size==(2480,3508);im.verify()
def apply(c,stage):
 key='nine_card_seq_2026_11_06_'+stage
 if c.execute('SELECT 1 FROM observations WHERE entity_type=? AND entity_id=13 AND field_name=?',('contest',key)).fetchone():
  if stage=='identity':assert c.execute('SELECT canonical_title FROM games WHERE id=473').fetchone()==('ElementaBrawl',)
  if stage=='mat':assert all(c.execute('SELECT id FROM remote_resources WHERE game_id=445 AND url=?',(x['resource_url'],)).fetchone() for x in m['items'])
  if stage=='acq':
   verify_files();assert c.execute('SELECT count(*) FROM acquired_files f JOIN acquisitions a ON a.id=f.acquisition_id WHERE a.source_snapshot=?',(m['batch_key'],)).fetchone()==(6,)
  return False
 if stage=='identity':
  assert c.execute('SELECT canonical_title FROM games WHERE id=473').fetchone()==('Elementa',)
  assert not c.execute('SELECT 1 FROM games WHERE canonical_title=? AND id<>473',('ElementaBrawl',)).fetchall()
  for name,current,kind in [('Elementa',0,'alias'),('ElementaBrawl',1,'source_title')]:
   c.execute('INSERT INTO game_names(game_id,name,observed_from,observed_at,is_current,name_type,is_official,verification_status,evidence_url,last_verified_at) VALUES(?,?,?,?,?,?,?,?,?,?)',(473,name,'Historical split correction; single author WIP/roster',stamp,current,kind,current,'verified',m['identity']['roster_url'],stamp))
  c.execute('UPDATE games SET canonical_title=?,last_verified_at=? WHERE id=473',('ElementaBrawl',stamp))
  for eid in [473,474]:obs(c,'game',eid,'published_identity_reconciliation',json.dumps(m['identity'],ensure_ascii=False),'one_published_game_local_split_artifact',m['identity']['roster_url'])
 elif stage=='mat':
  for e in m['entries']:obs(c,'entry',e['entry_id'],'targeted_full_wip_supplement_2026_11_06',json.dumps(e,ensure_ascii=False),e['outcome'],e['source_url'])
  for x in m['items']:
   assert not c.execute('SELECT id FROM remote_resources WHERE game_id=445 AND url=?',(x['resource_url'],)).fetchone()
   kind='component' if x['label']=='card' else 'rules'
   rid=c.execute('INSERT INTO remote_resources(game_id,kind,url,host,label,version_raw,first_seen_at,last_verified_at,access_type) VALUES(?,?,?,?,?,?,?,?,?)',(445,kind,x['resource_url'],'boardgamegeek.com',x['label'],x['version_raw'],stamp,stamp,'image')).lastrowid
   c.execute('INSERT INTO entry_resource_mentions(entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES(?,?,?,?,?,?,?,?)',(445,rid,x['source_url'],x['label'],kind,1,stamp,stamp))
   c.execute('INSERT INTO remote_resource_observations(remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) VALUES(?,?,?,?,?,?,?)',(rid,stamp,x['source_url'],'declared_in_wip','not_checked',x['version_raw'],'Integrated rule pages and print-ready card sheet verified; earlier exclusion preserved historically.'))
  c.execute('INSERT INTO entry_resource_scans(entry_id,checked_at,source_url,wip_status,resource_listing_status,notes) VALUES(?,?,?,?,?,?)',(445,stamp,m['items'][0]['source_url'],'found','observed','Corrective first-post image inspection: rule01-05 and nine-card sheet; PnP ready stated within rules. Older none_declared and exclusions preserved. Supplement of later posts stored independently.'))
 elif stage=='acq':
  verify_files()
  aid=c.execute('INSERT INTO acquisitions(game_id,acquired_at,selection_reason,game_status_at_acquisition,source_snapshot,notes) VALUES(?,?,?,?,?,?)',(445,stamp,'User approved sequential recovery of residual games',c.execute('SELECT status_normalized FROM games WHERE id=445').fetchone()[0],m['batch_key'],m['purpose'])).lastrowid
  for x in m['items']:
   rid=c.execute('SELECT id FROM remote_resources WHERE game_id=445 AND url=?',(x['resource_url'],)).fetchone()[0]
   c.execute('INSERT INTO acquired_files(acquisition_id,remote_resource_id,relative_path,original_filename,media_type,byte_size,sha256,version_raw,final_url,language_code,acquisition_status,usage_conditions,notes) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?)',(aid,rid,x['relative_path'],x['original_filename'],x['media_type'],x['byte_size'],x['sha256'],x['version_raw'],x['final_url'],'en','acquired',x['usage_conditions'],json.dumps({'scope':x['scope'],'transferred_at':x['transferred_at']},ensure_ascii=False)))
   c.execute('INSERT INTO remote_resource_observations(remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) VALUES(?,?,?,?,?,?,?)',(rid,stamp,x['resource_url'],'availability_check','available',x['version_raw'],'BGG original download physically present; SHA256, PNG dimensions and content verified.'))
  e=m['entry_outcomes'][0];c.execute('INSERT INTO entry_work_observations(entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES(?,?,?,?,?,?,?)',(445,'acquisition','complete',stamp,m['items'][0]['source_url'],ep,e['notes']))
 else:raise ValueError(stage)
 obs(c,'contest',13,key,ep,'verified_increment',m['identity']['roster_url']);return True
def validate(before,after,stage):
 allowed={'identity':{'games','game_names','observations'},'mat':{'observations','remote_resources','entry_resource_mentions','remote_resource_observations','entry_resource_scans'},'acq':{'observations','acquisitions','acquired_files','remote_resource_observations','entry_work_observations'}}[stage]
 changed={t for t in before if before[t]!=after[t]};assert changed==allowed,(stage,changed)
 for t in before:
  if t=='games' and stage=='identity':
   a={r[0]:r for r in before[t]};b={r[0]:r for r in after[t]};assert a.keys()==b.keys()
   for k in a:
    if k!=473:assert a[k]==b[k]
    else:assert {i for i in range(len(a[k])) if a[k][i]!=b[k][i]}=={1,len(a[k])-1}
  else:assert set(before[t])<=set(after[t]),t
 return sorted(changed)
if __name__=='__main__':
 stage=sys.argv[1];mode=sys.argv[2];report=TASK/('SEQUENTIAL_'+stage.upper()+'_VERIFICATION_2026-11-06.json')
 if mode=='--verify':
  c=con(DB,True);assert not apply(c,stage);integrity(c);print(stage,'RO replay verified');sys.exit(0)
 assert mode=='--apply';assert not report.exists(),'Already applied: use --verify'
 c=con(DB);before=snap(c);base=OUT/(stage+'-baseline.sqlite3');test=OUT/(stage+'-test.sqlite3');restore=OUT/(stage+'-restore.sqlite3')
 for path in [base,test]:
  assert not path.exists(),path;d=con(path);c.backup(d);d.close()
 b=con(base,True);d=con(restore);b.backup(d);assert snap(d)==before;integrity(d);d.close();b.close()
 t=con(test);assert apply(t,stage);t.commit();after=snap(t);changed=validate(before,after,stage);assert not apply(t,stage);assert snap(t)==after;integrity(t);t.close()
 try:
  c.execute('BEGIN EXCLUSIVE');assert snap(c)==before;assert apply(c,stage);assert snap(c)==after;integrity(c);c.commit()
 except: c.rollback();raise
 assert not apply(c,stage);c.rollback();integrity(c)
 result={'stage':stage,'verified_at':stamp,'copy':'passed','backup_restore':'full_fingerprint_equal','legacy':'all_preserved_except_game473_title_verification_date' if stage=='identity' else 'all_rows_preserved','changed_tables':changed,'idempotent_replay':'zero_writes','operational':'exclusive_transaction_matches_copy','integrity':'ok','foreign_keys':[],'manifest_sha256':hashlib.sha256(MAN.read_bytes()).hexdigest(),'backup':str(base.relative_to(ROOT))}
 report.write_text(json.dumps(result,indent=2)+'\n',encoding='utf-8');print(json.dumps(result));c.close()
