"""Post-application acceptance, existing database RO and verified no-write replay."""
import json
from pathlib import Path
import import_pergioco_carta_matita as imp
from test_pergioco_carta_matita import app_reads


def main():
    applied=json.loads((imp.TASK/'APPLICAZIONE_OPERATIVA.json').read_text(encoding='utf-8'))
    backup=Path(applied['backup']); restored=Path(applied['restore_proof']); p=imp.load()
    imp.require(imp.filehash(backup)==applied['backup_sha256'],'Backup hash changed')
    imp.require(imp.filehash(restored)==applied['restore_sha256'],'Restore hash changed')
    with imp.open_db(backup) as old:
        baseline=imp.inventory(old);imp.validate(old)
        pilots=[r[0] for r in old.execute("SELECT record_id FROM source_record_keys WHERE key_kind='local_pilot_id' ORDER BY id")]
    with imp.open_db(restored) as db:
        imp.validate(db);imp.require(imp.inventory(db)==baseline,'Restore inventory differs')
    with imp.open_db(imp.DB) as db:
        first=imp.verify(db,p);imp.preserve(db,backup,baseline)
        delta={t:first['tables'][t]['count']-baseline['tables'][t]['count'] for t in first['tables'] if first['tables'][t]['count']!=baseline['tables'][t]['count']}
        imp.require(delta==applied['table_deltas'],'Operational deltas differ from application')
        records=db.execute('SELECT k.local_key,k.record_id,d.game_id,d.status FROM source_record_keys k LEFT JOIN source_identity_decisions d ON d.record_id=k.record_id WHERE k.task_id=? ORDER BY k.local_key',('TSK-0081',)).fetchall()
    old_views=app_reads(backup,pilots);new_views=app_reads(imp.DB,pilots)
    for rid in pilots:
        a=dict(old_views[0][rid]);b=dict(new_views[0][rid]);a.pop('conditions');b.pop('conditions')
        imp.require(a==b,'Pilot app detail changed')
    imp.require(new_views[4]==old_views[4],'Abande app view changed')
    imp.require(new_views[2]['metrics']==old_views[2]['metrics'],'Pilot metrics changed')
    imp.require(len(new_views[1])==21,'PerGioco roster count differs')
    import server,source_evidence
    with server.connect(imp.DB) as db:
        for _,rid,_,_ in records:
            detail=source_evidence.source_record_detail(db,rid)
            imp.require(len(detail['observations'])==1 and len(detail['admissions'])==1,'New app detail missing')
    before_hash=imp.filehash(imp.DB)
    replay=imp.apply(imp.DB,'TSK-0081: authorized final no-write replay',imp.ROOT/'outputs/pergioco-carta-matita-backups')
    with imp.open_db(imp.DB) as db:imp.require(imp.inventory(db)==first,'Replay changed contents')
    imp.require(replay.get('writes')==0 and imp.filehash(imp.DB)==before_hash,'Replay wrote operational database')
    report=dict(task_id='TSK-0081',verified_at='2026-10-10',application_at=applied['formalized_at'],
        backup_hash_verified=True,restore_hash_inventory_verified=True,integrity='ok',foreign_key_check=[],legacy_and_pilot_all_rows_preserved=True,
        schema_unchanged=True,payload_hash_typed_projections_paths_verified=True,operational_records=9,confirmed_new_games=7,candidate_links=0,source_only=2,
        CAT_admitted=7,CAT_requirement_not_demonstrated=2,Labirinto_instances=3,Piattola_variant_assertions=7,solution_for=0,
        record_game_ids=[dict(candidate_id=cid,record_id=rid,game_id=gid,identity_status=status if status else 'source_only') for cid,rid,gid,status in records],
        table_deltas=delta,replay=replay,replay_inventory_hash_unchanged=True,operational_sha256=before_hash,APP_reads_verified=True,
        APP_pilot_metrics_unchanged=True,APP_roster_records=21,limits=['APP batch metrics/raw fields require a separate task; no external semantic equivalence assessment.'])
    (imp.TASK/'OPERATIONAL_VERIFICHE.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
    print(json.dumps(dict(records=report['record_game_ids'],replay=replay,legacy_preserved=True,APP_roster=21),ensure_ascii=False,indent=2))


if __name__=='__main__':main()
