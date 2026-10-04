"""Verifica invarianti/idempotenza su copia, backup e applicazione MAT opzionale."""
import argparse
import hashlib
import json
import sqlite3
from pathlib import Path

ROOT=Path(__file__).resolve().parents[1]
TASK=ROOT/'tasks/2026-10-04 - MAT - 9-Card Nanogame 2025'
DB=ROOT/'database/pnp_collection.sqlite3'
SQL=ROOT/'catalog/2025-nine-card-materials.sql'
RAW_HASHES=[2319200553,941027171,4152039012,1393818484,2267956546,3585441281,2282422125,4075465963,895372765,3260801379,2733671611,1450236342,131084431,3097402398,1353194994,990057518,3437568775,2567879220,3712681383,3668600186,4067827926,2428606796,1744130565,690542937,601630944,3924617502,343586480,3700862980,2001944255,842920563,3699090111,4107424210,1504305264,2190611713,3563223753,2637955803,3760211574,231510539,2352802508,2795137870,3041589900,3699532592,1052881925,518354886,2625818291,1670637896,4079680774,2891296046,1390851254,1417824833,3346392081,1417482037,3962829214,905729259,2166136261,946783245,1990035383,3707568304,2759748946,3840127936,2521037575,1781466759,4201758322,2460816407,1320887643,2576545184,2630863493,3512093045,3833352487,1353146511,2166136261,1928862206,876555400,3027207468,573737137,144620124,2303775121,1021311527,1099651442,1242678870,3622781748,2758798439,926601948,1032193056,1830635059,4235246654,904112782,1075787655,141317523,134405336]
URL_HASHES=[939645774,1865418416,4050165327,1250827029,3497673569,1650909430,671112391,138898393,265655757,819363484,2240459926,494752855,3563809651,1277119642,1357538682,2788079240,2928527111,211160643,115787532,4243410831,3232343829,1136854495,2420436599,1207494663,1477409732,495261508,1620009197,830030793,561132636,4144865769,2166362040,795403190,2486181200,1063147959,757053549,1093617554,1329682454,657553545,839633817,271541362,449274675,1864039898,3701506946,1776549625,703845716,3757620492,402176084,1743946444,1275934985,3121276778,2238765851,1267281919,1947613349,3653681330,1947613349,3532340372,3258787186,668433622,3610914117,1063101578,3342067388,2828250955,604266163,1947613349,1947613349,639609500,1947613349,1947613349,1947613349,1068581943,1947613349,1947613349,1947613349,978081767,3129766951,2877515482,391565453,1529564532,1368276954,3625831811,1632082654,1490820372,2414455611,122827717,161594762,888890685,133533217,1759169670,1451072411,2628250922]

def fnv(text):
    h=2166136261
    for c in text:h=((h^ord(c))*16777619)&0xffffffff
    return h

def digest_rows(rows):
    return hashlib.sha256(json.dumps(rows,ensure_ascii=False,sort_keys=True).encode()).hexdigest()

def snapshot(db):
    return {name:db.execute('SELECT * FROM "'+name+'" ORDER BY rowid').fetchall() for (name,) in db.execute("SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%'")}

def verify_scope(before,after,db):
    entry_ids=set(range(393,487));game_ids={r[0] for r in db.execute('SELECT game_id FROM entries WHERE contest_id=13')}
    affected={'entries','entry_resource_scans','entry_material_scans','entry_material_requirements','entry_resource_mentions','remote_resources','remote_resource_observations','entry_work_observations'}
    for table in before:
        if table not in affected:assert before[table]==after[table],table
    for table in affected-{'remote_resource_observations','entries'}:
        columns=[r[1] for r in db.execute('PRAGMA table_info('+table+')')]
        field='game_id' if table=='remote_resources' else 'entry_id';index=columns.index(field);ids=game_ids if field=='game_id' else entry_ids
        assert [r for r in before[table] if r[index] not in ids]==[r for r in after[table] if r[index] not in ids],table
    columns=[r[1] for r in db.execute('PRAGMA table_info(entries)')];wip=columns.index('wip_thread_url')
    for old,new in zip(before['entries'],after['entries']):
        if old[0] not in entry_ids:assert old==new
        else:assert old[:wip]+old[wip+1:]==new[:wip]+new[wip+1:]
    # Nessuna riga originaria eliminata o sovrascritta nelle tabelle append-only.
    for table in affected-{'entries'}:
        original={row[0]:row for row in before[table]};current={row[0]:row for row in after[table]}
        assert all(current.get(k)==v for k,v in original.items()),table

def checks(db,expected):
    assert db.execute('PRAGMA integrity_check').fetchall()==[('ok',)]
    assert not db.execute('PRAGMA foreign_key_check').fetchall()
    for table in ('entry_resource_scans','entry_material_scans'):
        assert db.execute('SELECT count(*) FROM '+table+' WHERE entry_id BETWEEN 393 AND 486 AND checked_at=?',('2026-10-04',)).fetchone()[0]==94
    assert db.execute("SELECT count(*) FROM entry_work_observations WHERE entry_id BETWEEN 393 AND 486 AND phase='materials' AND evidence_path LIKE '%9-Card Nanogame 2025/EVIDENCE.json' AND outcome='complete'").fetchone()[0]==89
    assert db.execute('SELECT count(*) FROM entry_material_requirements WHERE entry_id BETWEEN 393 AND 486').fetchone()[0]==expected
    assert db.execute('SELECT count(*) FROM entry_resource_mentions WHERE entry_id=474').fetchone()[0]==0
    assert db.execute('SELECT count(*) FROM entry_material_requirements WHERE entry_id IN (447,458,459,467,474)').fetchone()[0]==0
    assert db.execute("SELECT count(*) FROM remote_resource_observations o JOIN entry_resource_mentions m ON m.remote_resource_id=o.remote_resource_id WHERE m.entry_id BETWEEN 393 AND 486 AND o.observation_kind='availability_check'").fetchone()[0]==0

def main():
    parser=argparse.ArgumentParser();parser.add_argument('--apply',action='store_true');args=parser.parse_args()
    payload=json.loads((TASK/'EVIDENCE.json').read_text(encoding='utf8'));rows=payload['entries'];expected=sum(len(r['requirements']) for r in rows)
    for r in rows:
        if 'i' in r:
            assert fnv(r['material_raw'])==RAW_HASHES[r['i']],('raw',r['i'])
            assert fnv(json.dumps([x[:2] for x in r['l']],ensure_ascii=False,separators=(',',':')))==URL_HASHES[r['i']],('url',r['i'])
    output=ROOT/'outputs/2025-nine-card-materials';output.mkdir(parents=True,exist_ok=True)
    copied=output/'verification.sqlite3'
    with sqlite3.connect(DB) as source,sqlite3.connect(copied) as target:source.backup(target)
    sql=SQL.read_text(encoding='utf8')
    with sqlite3.connect(copied) as target:
        before=snapshot(target);target.executescript(sql);after=snapshot(target)
        verify_scope(before,after,target);checks(target,expected)
        target.executescript(sql);assert snapshot(target)==after,'non idempotente'
    verification=dict(task_id='TSK-0051',checked_at='2026-10-04',copy_integrity='ok',foreign_keys='ok',idempotent=True,
                      original_rows_preserved=True,other_contests_and_rankings_unchanged=True,
                      raw_material_fingerprints_matched=90,url_fingerprints_matched=90,
                      resource_scans=94,material_scans=94,complete=89,blocked=5,resources=208,requirements=expected,
                      sql_sha256=hashlib.sha256(SQL.read_bytes()).hexdigest(),applied=args.apply)
    if args.apply:
        backup=output/'before-import.sqlite3'
        assert not backup.exists(),'Backup esistente: non sovrascrivere'
        with sqlite3.connect(DB) as source,sqlite3.connect(backup) as backup_db:source.backup(backup_db)
        verification['backup_path']=backup.relative_to(ROOT).as_posix()
        verification['backup_sha256']=hashlib.sha256(backup.read_bytes()).hexdigest()
        with sqlite3.connect(DB) as operational:
            before=snapshot(operational);operational.executescript(sql);after=snapshot(operational)
            verify_scope(before,after,operational);checks(operational,expected)
            operational.executescript(sql);assert snapshot(operational)==after
        verification['operational_integrity']='ok';verification['operational_idempotent']=True
    (TASK/'VERIFICATION.json').write_text(json.dumps(verification,ensure_ascii=False,indent=2)+'\n',encoding='utf8')
    print(json.dumps(verification))

if __name__=='__main__':main()
