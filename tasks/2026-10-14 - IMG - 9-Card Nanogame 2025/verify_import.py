"""Verified copy/replay, then explicitly authorized additive operational import."""
import sys,json,sqlite3,hashlib
from pathlib import Path
R=Path(__file__).resolve().parents[2];O=R/'outputs/tsk0088';sys.path[:0]=[str(R/'catalog'),str(R/'database'),str(R/'app')]
from import_game_images import run
from image_catalog import open_db,inventory,legacy_names,validate,canonical
from game_images import image_catalog
DB=R/'database/pnp_collection.sqlite3';M=R/'catalog/2025_nine_card_images_2026-10-14.json';S=R/'catalog/2025_nine_card_image_sources_2026-10-14.json';COPY=O/'import-proof.sqlite3'
mode=sys.argv[1];manifest=json.loads(M.read_text(encoding='utf-8'))
def snapshot(path):
 with open_db(path) as db:
  validate(db);return inventory(db)
def img_rows(db):
 return {name:{canonical(list(row)) for row in db.execute('SELECT * FROM '+name)} for name, in db.execute("SELECT name FROM sqlite_master WHERE type='table' AND name LIKE 'img_%'")}
if mode=='copy':
 assert not COPY.exists(),'Preserve prior copy proof; do not overwrite'
 before=snapshot(DB)
 with open_db(DB) as db:
  with sqlite3.connect(COPY) as target:db.backup(target)
 result=run(COPY,M,S,apply=True,authorization='TSK-0088: prova su copia prima dell’operativo',backup_dir=O/'copy-backups')
 after=snapshot(COPY);replay=run(COPY,M,S,apply=True,authorization='TSK-0088: replay su copia',backup_dir=O/'copy-backups')
 assert replay['outcome']=='already_imported' and not replay['database_written'];assert snapshot(COPY)==after;assert snapshot(DB)==before
 report=dict(copy=result,replay=replay,operational_unchanged=True,replay_inventory_unchanged=True,manifest_sha256=hashlib.sha256(M.read_bytes()).hexdigest(),sources_sha256=hashlib.sha256(S.read_bytes()).hexdigest())
 (O/'copy-proof.json').write_text(json.dumps(report,ensure_ascii=False,indent=2),encoding='utf-8');print(json.dumps(report,ensure_ascii=False))
elif mode=='apply':
 proof=json.loads((O/'copy-proof.json').read_text(encoding='utf-8'));assert proof['operational_unchanged'] and proof['replay_inventory_unchanged'];assert proof['manifest_sha256']==hashlib.sha256(M.read_bytes()).hexdigest();assert proof['sources_sha256']==hashlib.sha256(S.read_bytes()).hexdigest()
 with open_db(DB) as db:legacy=inventory(db,legacy_names(db));old=img_rows(db);objects=inventory(db)['objects']
 result=run(DB,M,S,apply=True,authorization='Richiesta utente: Riprendi e completa il lavoro; TSK-0088 IMG; decisione 2026-10-11 in IMAGE_WORKFLOW.md',backup_dir=O/'operational-backups')
 with open_db(DB) as db:
  validate(db);assert inventory(db,legacy_names(db))==legacy;assert inventory(db)['objects']==objects;new=img_rows(db);assert all(rows<=new[name] for name,rows in old.items())
  galleries={}
  for g in manifest['games']:
   gallery=image_catalog(db,g['game_id'],R/'library');expected=[i for i in manifest['images'] if i['game_id']==g['game_id']];assert len(gallery['files'])==len(expected);assert all(f['local_status']=='ready' for f in gallery['files']);assert gallery['principal'] is not None
   galleries[str(g['game_id'])]=dict(files=len(gallery['files']),components=len(gallery['components']),all_local_ready=True,research_observations=len(gallery['research']))
  after=inventory(db)
 replay=run(DB,M,S,apply=True,authorization='TSK-0088: replay operativo senza scrittura',backup_dir=O/'operational-backups');assert replay['outcome']=='already_imported' and not replay['database_written'];assert snapshot(DB)==after
 report=dict(result=result,replay=replay,legacy_preserved=True,prior_img_rows_preserved=True,schema_unchanged=True,integrity='ok',foreign_keys='ok',galleries=galleries,replay_inventory_unchanged=True)
 (O/'operational-proof.json').write_text(json.dumps(report,ensure_ascii=False,indent=2),encoding='utf-8');print(json.dumps(report,ensure_ascii=False))
else:raise SystemExit('copy or apply')
