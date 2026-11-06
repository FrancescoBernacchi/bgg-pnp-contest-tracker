import sys,pathlib,sqlite3,json,hashlib
ROOT=pathlib.Path(__file__).resolve().parents[2];sys.path.insert(0,str(ROOT/'app'))
from catalog_identity import install_current_projection,canonical_game_id,canonical_entry_id,duplicate_map
from work_progress import enrich_work_progress
DB=ROOT/'database/pnp_collection.sqlite3';OUT=ROOT/'outputs/catalog-duplicate-consolidation-2026-11-06';TASK=pathlib.Path(__file__).parent
URL='https://boardgamegeek.com/thread/3436343/article/45443446#45443446'
def snap(c):return {t:sorted(c.execute('select * from main."'+t+'"').fetchall(),key=repr) for (t,) in c.execute("select name from main.sqlite_master where type='table'")}
def mutate(c):
 row=c.execute("select to_game_id from game_relationships where from_game_id=474 and relationship_type='duplicate_of'").fetchone()
 if row:assert row==(473,);return False
 c.execute("insert into game_relationships(from_game_id,to_game_id,relationship_type,dependency_requirement,verification_status,notes) values(474,473,'duplicate_of','none','verified',?)",('TSK-0099, 2026-11-06: Brawl is an import split artifact of ElementaBrawl; source '+URL+'; WIP3476068. Historical main records and observations retained; exclude duplicate from current catalog only.',))
 c.execute("insert into observations(entity_type,entity_id,field_name,raw_value,normalized_value,source_url,observed_at,confidence) values('game',474,'catalog_consolidation','Historical record retained; duplicate of game473, not a second published game','duplicate_of:473',?,'2026-11-06','verified')",(URL,));return True
def integrity(c):assert c.execute('pragma integrity_check').fetchone()[0]=='ok';assert not c.execute('pragma foreign_key_check').fetchall()
def metrics(c):
 c.row_factory=sqlite3.Row;install_current_projection(c);c.execute('pragma query_only=ON');r=enrich_work_progress(c,[{'contest_id':13}])[0];return dict(r)
def verify_projection(c):
 before=snap(c);install_current_projection(c);install_current_projection(c)
 assert c.execute('select count(*) from games where id=474').fetchone()[0]==0
 assert c.execute('select count(*) from main.games where id=474').fetchone()[0]==1
 assert c.execute('select count(*) from entries where id=474').fetchone()[0]==0
 assert c.execute('select count(*) from main.entries where id=474').fetchone()[0]==1
 assert canonical_game_id(c,474)==473 and canonical_entry_id(c,474)==473
 assert c.execute('select entry_count from v_contests_monitoring_all where contest_id=13').fetchone()[0]==93
 assert snap(c)==before
if '--verify' in sys.argv:
 c=sqlite3.connect(DB.resolve().as_uri()+'?mode=ro',uri=True);assert not mutate(c);verify_projection(c);m=metrics(c);assert m['acquisition_total']==92 and m['acquisition_complete_count']==70 and m['census_complete_count']==1;integrity(c);print(json.dumps(m));sys.exit(0)
assert '--apply' in sys.argv
c=sqlite3.connect(DB);c.execute('pragma foreign_keys=ON');before=snap(c)
base=OUT/'baseline.sqlite3';test=OUT/'trial.sqlite3';restore=OUT/'restore.sqlite3';fixture=OUT/'independent-fixture.sqlite3'
for p in [base,test,restore,fixture]:
 assert not p.exists();d=sqlite3.connect(p);c.backup(d);d.close()
assert snap(sqlite3.connect(restore))==before
t=sqlite3.connect(test);t.execute('pragma foreign_keys=ON');assert mutate(t);t.commit();assert not mutate(t);after=snap(t)
assert {k for k in before if before[k]!=after[k]}=={'game_relationships','observations'}
assert all(set(before[k])<=set(after[k]) for k in before);verify_projection(t);m=metrics(t);assert m['acquisition_total']==92 and m['acquisition_complete_count']==70 and m['materials_total']==93 and m['census_complete_count']==1;integrity(t);t.close()
f=sqlite3.connect(fixture);f.execute("insert into game_relationships(from_game_id,to_game_id,relationship_type,dependency_requirement,verification_status) values(397,393,'duplicate_of','none','verified')");f.commit();install_current_projection(f);assert not f.execute('select id from games where id=397').fetchone();assert canonical_game_id(f,397)==393 and canonical_entry_id(f,397)==393;assert f.execute('select id from games where id=474').fetchone();assert f.execute('select count(*) from main.acquired_files').fetchone()[0]==411
f.execute("insert into game_relationships(from_game_id,to_game_id,relationship_type,dependency_requirement,verification_status) values(393,397,'duplicate_of','none','verified')")
try:duplicate_map(f);raise AssertionError('Cycle not rejected')
except ValueError:pass
f.rollback();f.close()
c.execute('begin exclusive');assert snap(c)==before;assert mutate(c);assert snap(c)==after;integrity(c);c.commit();assert not mutate(c);c.rollback();verify_projection(c);m=metrics(c);integrity(c)
report={'verified_at':'2026-11-06','backup_restore':'full_snapshot_equal','copy':'passed','replay':'zero_changes','operational':'exclusive_matches_copy','all_main_history':'preserved','schema':'unchanged','projection':'temporary_read_only_views','independent_fixture':'397_to_393_passed','cycle_rejection':'passed','integrity':'ok','foreign_keys':[],'metrics':m}
(TASK/'VERIFICATION.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(report))
