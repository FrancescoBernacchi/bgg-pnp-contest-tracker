"""Rettifica roster TSK-0005; copia verificata e backup prima dell'operativo."""
import sqlite3,json,hashlib,pathlib,sys
ROOT=pathlib.Path(__file__).resolve().parents[2]
MAN=ROOT/'catalog/2025_nine_card_entry467_reconciliation_2026-11-06.json'
OUT=ROOT/'outputs/nine-card-entry467-reconciliation-2026-11-06'
DB=ROOT/'database/pnp_collection.sqlite3'
def connect(p):
 c=sqlite3.connect(p);c.row_factory=sqlite3.Row;c.execute('PRAGMA foreign_keys=ON');return c
def snap(c):
 return {t:[dict(r) for r in c.execute('SELECT * FROM "'+t+'" ORDER BY rowid')] for (t,) in c.execute("SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%' ORDER BY name")}
def check(c):
 assert c.execute('PRAGMA integrity_check').fetchone()[0]=='ok'
 assert not c.execute('PRAGMA foreign_key_check').fetchall()
def mutate(c):
 m=json.loads(MAN.read_text(encoding='utf-8'));date=m['verified_at'];url=m['announcement']['url'];roster=m['roster']['url']
 g=dict(c.execute('SELECT * FROM games WHERE id=467').fetchone())
 if g['canonical_title']=='Triplicity':
  assert c.execute("SELECT count(*) FROM game_credits gc JOIN people p ON p.id=gc.person_id WHERE gc.game_id=467 AND gc.role='designer' AND p.profile_url=?",(m['designer']['profile_url'],)).fetchone()[0]==1
  assert c.execute("SELECT count(*) FROM observations WHERE entity_type='game' AND entity_id=467 AND field_name='identity_reconciliation_2026-11-06'").fetchone()[0]==1
  return False
 assert g['canonical_title']=='Titolo non indicato (entry ritirata 12)'
 assert not c.execute("SELECT id FROM games WHERE canonical_title='Triplicity' AND id<>467").fetchall()
 assert not c.execute('SELECT * FROM game_credits WHERE game_id=467').fetchall()
 e=dict(c.execute('SELECT * FROM entries WHERE id=467').fetchone());assert e['position']==75 and e['contest_id']==13 and e['game_id']==467 and e['wip_thread_url'] is None
 p=c.execute("SELECT id FROM people WHERE lower(ltrim(coalesce(bgg_username,''),'@'))='agentdynamo' OR profile_url=?",(m['designer']['profile_url'],)).fetchall();assert len(p)<=1
 if p: pid=p[0][0]
 else: pid=c.execute('INSERT INTO people(display_name,bgg_username,profile_url) VALUES(?,?,?)',tuple(m['designer'].values())).lastrowid
 c.execute("INSERT INTO game_credits VALUES(?,?,'designer',?)",(467,pid,'J Mayer (@agentdynamo)'))
 c.execute('UPDATE games SET canonical_title=?,last_verified_at=? WHERE id=467',('Triplicity',date))
 c.execute('UPDATE entries SET last_verified_at=? WHERE id=467',(date,))
 for name,current,kind,official,when,origin in [(g['canonical_title'],0,'alias',0,g['first_seen_at'],'Historical local technical placeholder; not an author title'),('Triplicity',1,'source_title',1,date,'Author contest submission and withdrawal; roster positional reconciliation')]:
  c.execute("INSERT INTO game_names(game_id,name,observed_from,observed_at,is_current,name_type,is_official,verification_status,evidence_url,last_verified_at) VALUES(467,?,?,?,?,?,?,'verified',?,?)",(name,origin,when,current,kind,official,url,date))
 for field,raw,norm,source in [('identity_reconciliation_2026-11-06',json.dumps(m,ensure_ascii=False),'Triplicity | J Mayer @agentdynamo',url),('historical_designer_correction','Historical MAT attribution Ryan Shaffer; previous roster row Three-Legged Race','J Mayer @agentdynamo',roster),('wip_reference_status','BGG submission announcement shows link to deleted destination','destination_deleted_url_not_observable',url)]:
  c.execute("INSERT INTO observations(entity_type,entity_id,field_name,raw_value,normalized_value,source_url,observed_at,confidence) VALUES('game',467,?,?,?,?,?,'verified')",(field,raw,norm,source,date))
 return True
def validate(before,after):
 allowed={'games','entries','people','game_credits','game_names','observations'}
 assert {t for t in before if before[t]!=after[t]}==allowed
 for t in before:
  if t not in allowed: assert before[t]==after[t],t
 for t,fields in [('games',{'canonical_title','last_verified_at'}),('entries',{'last_verified_at'})]:
  assert len(before[t])==len(after[t])
  for a,b in zip(before[t],after[t]):
   if a['id']!=467: assert a==b
   else: assert {k for k in a if a[k]!=b[k]}<=fields
 for t in allowed-{'games','entries'}: assert after[t][:len(before[t])]==before[t],t
 assert len(after['game_names'])-len(before['game_names'])==2
 assert len(after['observations'])-len(before['observations'])==3
OUT.mkdir(parents=True,exist_ok=True)
if '--verify' in sys.argv:
 c=sqlite3.connect(DB.as_uri()+'?mode=ro',uri=True);c.row_factory=sqlite3.Row
 assert not mutate(c);check(c);print('Read-only replay: verified');c.close();sys.exit(0)
if '--apply' not in sys.argv: sys.exit('Use --apply after reviewing manifest; performs copy tests before operational transaction')
c=connect(DB);before=snap(c);backup=OUT/'pre-reconciliation.sqlite3'
assert not backup.exists(),'Backup already exists: use read-only verification instead of reapplying'
b=connect(backup);c.backup(b);assert snap(b)==before;check(b);b.close()
copy=OUT/'trial.sqlite3';t=connect(copy);c.backup(t);assert mutate(t);t.commit();check(t);after=snap(t);validate(before,after);assert not mutate(t);t.commit();assert snap(t)==after;t.close()
restore=connect(OUT/'restore-check.sqlite3');b=connect(backup);b.backup(restore);assert snap(restore)==before;check(restore);restore.close();b.close()
c.execute('BEGIN EXCLUSIVE');assert snap(c)==before;assert mutate(c);check(c);assert snap(c)==after;c.commit();assert not mutate(c);c.rollback();check(c)
report={'task_id':'TSK-0005','verified_at':'2026-11-06','copy_test':'passed','backup_restore':'passed','idempotence':'passed','unrelated_tables':'unchanged','integrity':'ok','foreign_key_violations':0,'changed_tables':[k for k in before if before[k]!=after[k]],'before_game':next(x for x in before['games'] if x['id']==467),'after_game':next(x for x in after['games'] if x['id']==467),'manifest_sha256':hashlib.sha256(MAN.read_bytes()).hexdigest()}
(OUT/'verification.json').write_text(json.dumps(report,indent=2,ensure_ascii=False)+'\n',encoding='utf-8');print(json.dumps(report,ensure_ascii=False));c.close()
