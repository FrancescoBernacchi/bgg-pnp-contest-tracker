"""TSK-0058: offline serialization of declarations observed through CUA."""
import json, sqlite3, hashlib
from pathlib import Path
from urllib.parse import urlsplit
import build_2025_54_card_materials as shared
from verify_2025_traditional_materials import snapshot

ROOT=Path(__file__).resolve().parents[1]
TITLE='2026-10-05 - MAT - 24 Hour Design Challenge GUARD 2025'
TASK=ROOT/'tasks'/TITLE
DATE='2026-10-05'
EVIDENCE=(TASK.relative_to(ROOT)/'EVIDENCE.json').as_posix()
POSTS=[45662252,45675946,45705323,45706137,45706137,45707562]
AUTHORS=['Julian Anstey','Iffix Y Santaph','Iffix Y Santaph','@This_Punking','@This_Punking','Mus Rattus']
TIMES=['15 feb 2025 (edited)','18 feb 2025 (edited)','23 feb 2025','23 feb 2025 (edited)','23 feb 2025 (edited)','24 feb 2025 (edited)']
LINKS={1:[('https://drive.google.com/drive/folders/1KYTl-iUzJ5kwbnUeat_XRkcQYkbI6Z_2?usp=sharing','Guarded Words - Cards & Rules','game_files')],3:[('https://drive.google.com/file/d/1TvHX3NCWuPH62QCOUD0RiaLOiw9TPvh2/view?usp=sharing','[Rules]','rules'),('https://drive.google.com/file/d/1-aa9Tv537-QkyYSUXuW3rBjoAyw08Ugq/view?usp=sharing','[Components]','component')]}
for i in (4,5):LINKS[i]=[('https://drive.google.com/drive/folders/1UUnxhN2iiW7PPUCBfgJcwXRoVg-RJTJM','Components and rulebook for both games','game_files')]
REQ={}
def req(i,name,q,raw,kind='printable_component',level='required',supply='printable'):
    REQ.setdefault(i,[]).append(dict(material_kind=kind,name_normalized=name,name_raw=raw,quantity_raw=q,requirement_level=level,supply_mode=supply,context_raw=raw))
req(1,'carte',None,'Guarded Words - Cards & Rules')
req(1,'regolamento',None,'Guarded Words - Cards & Rules',kind='rules')
req(2,'carte tradizionali A–6 dei quattro semi','A–6 di 4 semi','From a deck of traditional cards gather the A-6 of 4 suits.',kind='standard_deck',supply='common')
req(2,'dobloni o sostituti','17','You will also need 17 doubloons. You may choose a suitable substitute.',kind='counter',supply='common')
req(3,'componenti',None,'[Components]')
req(3,'regolamento',None,'[Rules]',kind='rules')
for i in (4,5):
    req(i,'componenti',None,'Components and rulebook for both games')
    req(i,'regolamento',None,'Components and rulebook for both games',kind='rules')
req(6,'mazzo tradizionale selezionato con joker','29','29 Cards: 2 x 1,2,3,4,5 in a red suit and a black suit. 1 x 6,7,8,9 in a red suit and a black suit. + 1 Joker',kind='standard_deck',supply='common')
req(6,'segnalini per contare prese',None,'Some way of counting trick winners (counters, pen and paper).',kind='counter',level='alternative',supply='common')
req(6,'penna e carta per contare prese',None,'Some way of counting trick winners (counters, pen and paper).',kind='writing_tool',level='alternative',supply='common')
NOTES={1:'Carte e regole dichiarate nella stessa cartella; quantità non specificate.',2:'Regole integralmente nel post originale autore; nessun URL materiali. A–6 di quattro semi, 17 dobloni sostituibili.',3:'Due file dichiarati, regole e componenti; nessun numero di carte dedotto dalla meccanica.',4:'Post originale e cartella condivisi con Oh My Pies!; due giochi distinti, nessuna fusione.',5:'Post originale e cartella condivisi con Guard the Bard; due giochi distinti, nessuna fusione.',6:'Regole integralmente nel post originale. 29 carte incluso joker; contatori oppure penna/carta alternativi. La frase No components è conservata come assenza di componenti dedicati pubblicati, senza negare i requisiti precedenti. Riferimento ispirazione non risorsa.'}

def main():
    TASK.mkdir(parents=True,exist_ok=True)
    dbpath=ROOT/'database/pnp_collection.sqlite3'
    with sqlite3.connect(dbpath) as db:
        db.row_factory=sqlite3.Row
        baseline=[dict(x) for x in db.execute('select e.*,g.canonical_title from entries e join games g on g.id=e.game_id where contest_id=294 order by position')]
    assert len(baseline)==6
    (TASK/'ROSTER_BASELINE.json').write_text(json.dumps(baseline,ensure_ascii=False,indent=2)+'\n',encoding='utf8')
    rows=[]
    for b in baseline:
        i=b['position'];src=f'https://boardgamegeek.com/thread/3452558/article/{POSTS[i-1]}#{POSTS[i-1]}'
        res=[dict(url=u,label_raw=l,content_role=r,context_raw=l,version_raw=None,host=urlsplit(u).netloc,access_type=shared.access(u)) for u,l,r in LINKS.get(i,[])]
        rows.append(dict(entry_id=b['id'],game_id=b['game_id'],position=i,title=b['canonical_title'],source_url=src,wip_url=src,author_raw=AUTHORS[i-1],post_timestamp_raw=TIMES[i-1],checked_at=DATE,wip_status='found',resource_listing_status='observed' if res else 'none_declared',material_listing_status='observed',coverage_scope='first_post_only',outcome='complete',all_first_post_read=True,resources=res,requirements=REQ[i],notes=NOTES[i],source_structure='original_game_submission_in_contest_thread'))
    counts=dict(entries=6,complete=6,unique_original_posts=5,resource_entries=4,resources_per_entry=5,unique_resource_urls=4,requirements=sum(len(x['requirements']) for x in rows))
    payload=dict(task_id='TSK-0058',contest_id=294,checked_at=DATE,counts=counts,coverage_scope='first_post_only',method='CUA rendered original game submissions, linked directly by official roster; dedicated WIP optional under official challenge rules; all original post text read, no external hosts/files opened.',entries=rows)
    (TASK/'EVIDENCE.json').write_text(json.dumps(payload,ensure_ascii=False,indent=2)+'\n',encoding='utf8')
    shared.DATE=DATE;shared.EVIDENCE=EVIDENCE
    sql=shared.sql_for(rows).replace('TSK-0053','TSK-0058')
    sqlpath=ROOT/'catalog/2025-guard-materials.sql';sqlpath.write_text(sql,encoding='utf8')
    out=ROOT/'outputs/2025-guard-materials';out.mkdir(parents=True,exist_ok=True)
    witness=json.loads((TASK/'DOM_WITNESS.json').read_text(encoding='utf8'))
    for r in rows:
        w=next(z for z in witness if z['source']==r['source_url'])
        assert w['author']==r['author_raw'] and w['time'] in r['post_timestamp_raw']
        assert [(z['url'],z['label']) for z in w['links'] if z['url'].startswith('https://drive.google.com/')]==[(z['url'],z['label_raw']) for z in r['resources']]
        assert not w['media']
    roster=next(w for w in witness if '/article/45584159#' in w['source'])
    assert [z['url'] for z in roster['links'] if '/thread/3452558/article/' in z['url']][1:]==[r['source_url'] for r in rows]
    def check(db):
        assert db.execute('pragma integrity_check').fetchall()==[('ok',)]
        assert not db.execute('pragma foreign_key_check').fetchall()
        assert db.execute('select count(*) from entry_work_observations where evidence_path=?',(EVIDENCE,)).fetchone()[0]==6
        for r in rows:
            assert db.execute('select count(*) from entry_material_requirements where entry_id=? and source_url=?',(r['entry_id'],r['source_url'])).fetchone()[0]==len(r['requirements'])
    def isolated(before,after,db):
        ids={r['entry_id'] for r in rows};gids={r['game_id'] for r in rows}
        for table,old in before.items():
            new=after[table]
            if table=='entries':
                cols=[x[1] for x in db.execute('pragma table_info(entries)')];ix=cols.index('wip_thread_url')
                for a,b in zip(old,new):
                    assert a[:ix]+a[ix+1:]==b[:ix]+b[ix+1:]
                    if a[0] not in ids:assert a==b
            else:
                assert set(old).issubset(set(new)),table
                additions=set(new)-set(old)
                if additions:
                    cols=[x[1] for x in db.execute('pragma table_info('+table+')')]
                    if 'entry_id' in cols:assert all(x[cols.index('entry_id')] in ids for x in additions)
                    elif 'game_id' in cols:assert table=='remote_resources' and all(x[cols.index('game_id')] in gids for x in additions)
                    else:assert table=='remote_resource_observations',table
    copy=out/'verification.sqlite3'
    with sqlite3.connect(dbpath) as src,sqlite3.connect(copy) as dst:src.backup(dst)
    with sqlite3.connect(copy) as db:
        before=snapshot(db);db.executescript(sql);after=snapshot(db);isolated(before,after,db);check(db)
        db.executescript(sql);assert snapshot(db)==after
    backup=out/'before-import.sqlite3';assert not backup.exists()
    with sqlite3.connect(dbpath) as src,sqlite3.connect(backup) as dst:src.backup(dst)
    with sqlite3.connect(dbpath) as db:
        before=snapshot(db);db.executescript(sql);after=snapshot(db);isolated(before,after,db);check(db)
    verification=dict(task_id='TSK-0058',counts=counts,dom_identity_and_links=6,roster_reconciled=6,integrity='ok',foreign_keys='ok',idempotent=True,prior_rows_preserved=True,other_contests_unchanged=True,backup_sha256=hashlib.sha256(backup.read_bytes()).hexdigest(),sql_sha256=hashlib.sha256(sqlpath.read_bytes()).hexdigest())
    (TASK/'VERIFICATION.json').write_text(json.dumps(verification,indent=2)+'\n',encoding='utf8')
    report=['# 24 Hour Design Challenge GUARD 2025 — materiali','',f'Verifica {DATE}, TSK-0058. Sei entry riconciliate con il roster ufficiale BGG articolo 45584159. Cinque post originali completi per sei giochi: Guard the Bard e Oh My Pies! condividono post e cartella. WIP dedicato facoltativo secondo le regole ufficiali; dichiarazioni del post introduttivo originale di ciascun gioco, first_post_only.','',json.dumps(counts),'','| Gioco | URL | Requisiti | Note |','|---|---:|---:|---|']
    for r in rows:report.append(f"| [{r['title']}]({r['source_url']}) | {len(r['resources'])} | {len(r['requirements'])} | {r['notes']} |")
    report+=['','Quattro URL unici globali, cinque associazioni gioco–URL. Dichiarazioni e forme tecniche provvisorie; disponibilità non verificata. Nessun host esterno/file aperto o download. Maroons and Doubloons e Handguards non hanno URL materiali, ma regole nel post e requisiti espliciti.','', 'Prossimo passo utile: eventuale ACQ del solo GUARD dopo selezione dei giochi e verifica condizioni/host. Nessun monitoraggio ordinario del contest concluso.','']
    (ROOT/'sources/2025-GUARD-MATERIALS.md').write_text('\n'.join(report),encoding='utf8')
    print(json.dumps(verification))
if __name__=='__main__':main()
