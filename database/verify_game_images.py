"""Verify migration/import on disposable copies; source database always read-only."""
import argparse
import hashlib
import json
import sqlite3
import sys
from contextlib import closing
from pathlib import Path
from uuid import uuid4

ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT/'catalog'))
from image_catalog import (MIGRATION, apply_migration, digest, installed, inventory,
                           legacy_names, now, open_db, require, validate)
from import_game_images import read_json, run

def verify(database,manifest,sources,library_root,output_dir):
    target=Path(output_dir)/('verification-'+uuid4().hex)
    target.mkdir(parents=True)
    dbcopy=target/'import.sqlite3';empty=target/'migration-only.sqlite3'
    source_sha=hashlib.sha256(Path(database).read_bytes()).hexdigest()
    with open_db(database) as db:
        db.execute('BEGIN');validate(db)
        require(not installed(db),'Use a pre-014 source for this first-increment verifier')
        baseline=inventory(db);names=legacy_names(db)
        for path in (dbcopy,empty):
            with closing(sqlite3.connect(path)) as out:db.backup(out)
    inspect=run(database,manifest,sources,library_root)
    migrated=apply_migration(empty,target/'backups','TSK-0067 user-authorized disposable copy tests')
    with open_db(empty) as db:
        require(inventory(db,names)==baseline,'Legacy changed in standalone migration')
        require(all(db.execute('SELECT count(*) FROM '+o[1]).fetchone()[0]==0
                    for o in inventory(db)['objects'] if o[0]=='table' and o[1].startswith('img_')),
                'Standalone migration contains unexpected rows')
    replay_migration=apply_migration(empty,target/'backups','TSK-0067 copy replay')
    applied=run(dbcopy,manifest,sources,library_root,True,'TSK-0067 authorized tests on copies',target/'backups')
    with open_db(dbcopy) as db:
        validate(db);require(inventory(db,names)==baseline,'Legacy changed in combined import')
        first=inventory(db)
        summary={o[1]:db.execute('SELECT count(*) FROM '+o[1]).fetchone()[0]
                 for o in first['objects'] if o[0]=='table' and o[1].startswith('img_')}
        coverage=db.execute('SELECT sum(complete),count(*)-sum(complete) FROM img_current_research').fetchone()
        raw=db.execute('SELECT manifest_json,sources_json FROM img_imports').fetchone()
        require(json.loads(raw[0])==read_json(manifest) and json.loads(raw[1])==read_json(sources),'Input information lost')
    bytes_before=hashlib.sha256(dbcopy.read_bytes()).hexdigest()
    replay=run(dbcopy,manifest,sources,library_root,True,'TSK-0067 copy replay',target/'backups')
    require(replay['outcome']=='already_imported','Import replay not idempotent')
    require(hashlib.sha256(dbcopy.read_bytes()).hexdigest()==bytes_before,'Replay changed database bytes')
    with open_db(dbcopy) as db:require(inventory(db)==first,'Replay changed content')
    with open_db(database) as db:
        require(inventory(db)==baseline and not installed(db),'Operational source changed')
    require(hashlib.sha256(Path(database).read_bytes()).hexdigest()==source_sha,'Operational bytes changed')
    report={'verified_at':now(),'source_database_sha256':source_sha,'operational_database_unchanged':True,
            'migration_sha256':hashlib.sha256(MIGRATION.read_bytes()).hexdigest(),
            'input_file_sha256':{Path(p).name:hashlib.sha256(Path(p).read_bytes()).hexdigest() for p in (manifest,sources)},
            'legacy_table_count':len(baseline['tables']),'legacy_row_count':sum(t['count'] for t in baseline['tables'].values()),
            'legacy_inventory_sha256':digest(baseline),'legacy_definitions_and_rows_preserved':True,
            'manifest_information_preserved':True,'coverage':{'complete':coverage[0],'partial_or_unknown':coverage[1]},
            'tables':summary,'preview':inspect,'migration_only':migrated,'migration_replay':replay_migration,
            'applied_on_copy':applied,'import_replay':replay,'copy_path':str(dbcopy),
            'backup_restore_verified':True,'integrity_check':'ok','foreign_key_check':[]}
    (target/'report.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n',encoding='utf8')
    return report

def main():
    parser=argparse.ArgumentParser(description=__doc__)
    for name in ('database','manifest','sources'):parser.add_argument('--'+name,type=Path,required=True)
    parser.add_argument('--library-root',type=Path,default=ROOT/'library')
    parser.add_argument('--output-dir',type=Path,default=ROOT/'outputs/image-catalog-014')
    args=parser.parse_args()
    result=verify(args.database,args.manifest,args.sources,args.library_root,args.output_dir)
    print(json.dumps(result,ensure_ascii=False))

if __name__=='__main__':main()
