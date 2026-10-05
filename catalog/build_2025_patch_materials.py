"""TSK-0063: serialize observed PATCH declarations; test only on private copy.

No remote access, staging, or operational database writes. --database is read-only.
Integration is deliberately left to TSK-0059 via the generated SQL.
"""
import argparse
import hashlib
import json
import sqlite3
from pathlib import Path
from urllib.parse import urlsplit
import build_2025_54_card_materials as shared

ROOT = Path(__file__).resolve().parents[1]
TASK = ROOT/'tasks/2026-10-05 - MAT - 24 Hour Design Challenge PATCH 2025'
DATE = '2026-10-05'
EVIDENCE = (TASK.relative_to(ROOT)/'EVIDENCE.json').as_posix()
POSTS = [46617473,46640833,46691324,46698988,46700123,46740245,46740519,46754814,46776766,46790355,46794941,46807640]
AUTHORS = ['David McDougal','Isaac Haller','Thomas Gutshall','JP Perkins','Is. Ra.','Iffix Y Santaph','Iffix Y Santaph','Corin Elliott','David Stewart','Mitchell Martin-Moran','Jeremiah Brammer','Coblin King']
TIMES = ['16 set 2025 (edited)','22 set 2025 (edited)','3 ott 2025','5 ott 2025 (edited)','6 ott 2025','15 ott 2025 (edited)','15 ott 2025','18 ott 2025 (edited)','23 ott 2025 (edited)','25 ott 2025 (edited)','27 ott 2025','29 ott 2025 (edited)']
LINKS = {
 1:[('https://docs.google.com/document/d/17szR-qbv7s3pf0bYg6JAak3I9hOEQTaYXpd2C45f1sU/edit?usp=sharing','Rules via Google Drive','rules','Rules via Google Drive')],
 2:[('https://drive.google.com/drive/folders/1FvZsjDIxN-EbZPskXAkxz3GayP8QEwqK?usp=sharing','https://drive.google.com/drive/folders/1FvZsjDIxN-EbZPskXAkx...','game_files','Below is the link to the Google drive folder containing the rules and card files.')],
 3:[('https://drive.google.com/drive/folders/1XmJlajClDIim3R4BJzNwFkdEQ5kStg-T?usp=sharing',"Google Drive Files - Autumn's Ghost",'game_files',"Google Drive Files - Autumn's Ghost")],
 4:[('https://drive.google.com/drive/folders/18oENz-56ENBENr0auf52WH5mQ4YYgUKE','https://drive.google.com/drive/folders/18oENz-56ENBENr0auf52...','game_files','Google drive with rules and printable components')],
 5:[('https://www.dropbox.com/scl/fi/jk19ofkfbib5q2siteki1/Mishi-CGE.pdf?rlkey=1wfku9epd01nyn1hl9e9itl9v&st=h5bt7ehr&dl=0','Here','game_files','Ready components; Game Here'),('https://www.dropbox.com/scl/fi/d55h4gi4vp48m1nyi50kx/Mishi-CGS.pdf?rlkey=3o3luqfl0minypfiwpemkmsxy&st=taro883m&dl=0',' Aquí','game_files','Ready components; Juego Aquí')],
 6:[('https://drive.google.com/file/d/135GVEDyiVaykJz4cmJDdQYlvo8tLaw4Q/view?usp=sharing','\n[Components & Rules]','game_files','[Components & Rules]')],
 8:[('https://drive.google.com/drive/folders/1I_K04Wz1NonH2DUEPRfkvQIDS7gy2llD?usp=drive_link','here','game_files','You can find the PnP files for the cards and the rules here.')],
 9:[('https://davidfstewart.ca/wp-content/uploads/2025/10/Berry-Patch-Rules.pdf','Berry Patch - Rules','rules','Berry Patch - Rules'),('https://davidfstewart.ca/wp-content/uploads/2025/10/Berry-Patch-Cards.pdf','Berry Patch - Cards & Chips','component','Berry Patch - Cards & Chips')],
 10:[('https://drive.google.com/drive/folders/1CLsyy0hvneZTdf_DI1Rm6Mtc0IFRyc-p?usp=drive_link','Google Drive Folder Link','game_files','Google Drive Folder Link')],
 12:[('https://drive.google.com/drive/folders/1NgZSSrKNf_fldZk-rUsRyNeSigaC6vTQ?usp=sharing','Patch Monsters - Rulebook and Cards','game_files','EDIT 2: Hour 23; Patch Monsters - Rulebook and Cards')]
}
REQ = {i:[] for i in range(1,13)}
def req(i,name,q,raw,kind='printable_component',level='required',supply='printable'):
    if supply=='unknown':supply='unspecified'
    REQ[i].append(dict(material_kind=kind,name_normalized=name,name_raw=raw,quantity_raw=q,requirement_level=level,supply_mode=supply,context_raw=raw))
req(1,'mazzo tradizionale','52 (4 semi, 13 carte per seme)','Deck of Playing Cards (52 card deck, 4 suit 13 card per suit)',kind='standard_deck',supply='common')
req(1,'regolamento',None,'Rules via Google Drive',kind='rules')
req(2,'regolamento',None,'rules and card files',kind='rules')
req(2,'carte',None,'rules and card files')
req(3,'carte','16','Each round, 12 of 16 cards are dealt out, 6 to each player.',supply='unknown')
req(3,'pedine',None,'Then they take turns moving their pieces or making attacks.',kind='token',supply='unknown')
req(4,'dadi',None,'Each day, roll the dice, face the grind, and try to survive long enough to see sunrise.',kind='dice',supply='unknown')
req(4,'regolamento',None,'Google drive with rules and printable components',kind='rules')
req(4,'componenti stampabili',None,'Google drive with rules and printable components')
req(5,'plancia','1','1 Game Board',supply='unknown')
req(5,'tessere','48','48 Tiles',supply='unknown')
req(5,'carte Chain','26','26 Chain Cards',supply='unknown')
req(5,'token','48 per giocatore','48 Tokens (per player)',kind='token',supply='unknown')
req(5,'dado d6 per modalità solitaria','1','1 d6 Die  (For single-player mode)',kind='dice',level='optional',supply='common')
req(6,'componenti',None,'[Components & Rules]')
req(6,'regolamento',None,'[Components & Rules]',kind='rules')
req(7,'mazzo tradizionale senza joker',None,'Deck: Traditional, no jokers',kind='standard_deck',supply='common')
req(8,'carte formato poker','18','Veg Patch requires 18 poker-sized cards and therefore two double-sided printed pages.')
req(8,'regolamento',None,'You can find the PnP files for the cards and the rules here.',kind='rules')
req(9,'regolamento',None,'Berry Patch - Rules',kind='rules')
req(9,'carte',None,'Berry Patch - Cards & Chips')
req(9,'fiches',None,'Berry Patch - Cards & Chips')
req(10,'carte',None,'the Kraken who uses Cards with images of Dice Placements to Attack the Ship',supply='unknown')
req(10,'dadi',None,'The Captain uses Dice to roll and try to meet the requirements of the cards to patch the damage before the ship is destroyed!',kind='dice',supply='unknown')
req(12,'regolamento',None,'Patch Monsters - Rulebook and Cards',kind='rules')
req(12,'carte',None,'Patch Monsters - Rulebook and Cards')
NOTES = {
1:'Presentazione ufficiale articolo 46617473: gg-item-link risolto entrando nel viewport; WIP originale 3577423/46617446 letto integralmente. Versioni dichiarate v0.5 e v1.0; refuso data Final Edit 2025-90-16 conservato, non corretto. Logo e backlink contest esclusi.',
2:'Cartella dichiarata per regole e carte; quantità e approvvigionamento di altri componenti non dedotti dal tile-laying.',
3:'16 carte esplicite nella descrizione, non soltanto le 12 distribuite. Pedine senza quantità o approvvigionamento dichiarato; nessuna distinta inferita.',
4:'Regole e componenti stampabili dichiarati; dadi nel testo, senza numero o tipo. Immagine di presentazione esclusa.',
5:'Due PDF dichiarati Game/Juego, senza aprirli; lingue non inferite dal nome file. 48 token per giocatore, non totale universale. D6 limitato al solo solitario.',
6:'Un unico file per componenti e regole; quantità non specificate.',
7:'Regole integralmente nel post originale, senza link risorse. Mazzo tradizionale senza joker; incongruenze eventuali del setup non corrette e quantità non ricostruite.',
8:'18 carte formato poker su due pagine stampate fronte/retro; le pagine sono supporto di stampa, non due componenti ulteriori. Anteprima carta esclusa.',
9:'Regole e Cards & Chips in due PDF dichiarati; quantità non specificate.',
10:'Carte e dadi espliciti nella descrizione; nessuna quantità o numero di facce dedotto. Funzione dei file della cartella non dettagliata.',
11:'Autore dichiara regole non finite in tempo. Immagine BGG 9184032 con alt Picking Pumpkins Gamesheet r4, senza istruzione esplicita di stampa: esclusa secondo skill MAT, non aperta. Nessun URL materiali o requisito esplicito nel testo.',
12:'Primo post editato contiene cronologia Hour 1/9/23 e working title My Father’s Patchwork; intenzioni iniziali e Bonus Objectives may exist non adottati come distinta finale. Regolamento e carte dichiarati; nessuna quantità dedotta dal mostro.'
}

def snapshot(db):
    return {n:db.execute('SELECT * FROM "'+n+'" ORDER BY rowid').fetchall() for (n,) in db.execute("SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%'")}

def isolated(before,after,db,rows):
    ids={r['entry_id'] for r in rows};gids={r['game_id'] for r in rows}
    allowed={'entries','entry_resource_scans','entry_material_scans','entry_material_requirements','entry_resource_mentions','remote_resources','remote_resource_observations','entry_work_observations'}
    for table,old in before.items():
        new=after[table]
        if table not in allowed:
            assert old==new,table
            continue
        cols=[x[1] for x in db.execute('pragma table_info('+table+')')]
        if table=='entries':
            ix=cols.index('wip_thread_url');assert len(old)==len(new)
            for a,b in zip(old,new):
                assert a[:ix]+a[ix+1:]==b[:ix]+b[ix+1:]
                if a[0] not in ids or a[ix] is not None:assert a==b
        else:
            current={r[0]:r for r in new};assert all(current.get(r[0])==r for r in old),table
            oldids={r[0] for r in old}
            for row in new:
                if row[0] in oldids:continue
                if table=='remote_resource_observations':
                    assert db.execute('select game_id from remote_resources where id=?',(row[cols.index('remote_resource_id')],)).fetchone()[0] in gids
                else:
                    key='game_id' if table=='remote_resources' else 'entry_id'
                    assert row[cols.index(key)] in (gids if key=='game_id' else ids)

def check(db,rows):
    assert db.execute('pragma integrity_check').fetchall()==[('ok',)]
    assert not db.execute('pragma foreign_key_check').fetchall()
    assert db.execute('select count(*) from entry_work_observations where evidence_path=?',(EVIDENCE,)).fetchone()[0]==12
    for r in rows:
        for table,col in [('entry_resource_scans','resource_listing_status'),('entry_material_scans','material_listing_status')]:
            assert db.execute('select '+col+' from '+table+' where entry_id=? and source_url=? and checked_at=?',(r['entry_id'],r['source_url'],DATE)).fetchone()[0]==r[col]
        assert db.execute('select count(*) from entry_material_requirements where entry_id=? and source_url=?',(r['entry_id'],r['source_url'])).fetchone()[0]==len(r['requirements'])
        assert {x[0] for x in db.execute('select rr.url from entry_resource_mentions m join remote_resources rr on rr.id=m.remote_resource_id where m.entry_id=? and m.source_url=?',(r['entry_id'],r['source_url']))}=={x['url'] for x in r['resources']}

def main():
    ap=argparse.ArgumentParser();ap.add_argument('--database',type=Path,default=ROOT/'database/pnp_collection.sqlite3');a=ap.parse_args()
    dbpath=a.database.resolve();out=ROOT/'outputs/2025-patch-materials';out.mkdir(parents=True,exist_ok=True)
    roster=next(x for x in json.loads((ROOT/'catalog/2025-24h-challenge-rosters-2026-10-04.json').read_text(encoding='utf8'))['contests'] if x['key']=='patch')
    with sqlite3.connect(dbpath.as_uri()+'?mode=ro',uri=True) as db:
        db.row_factory=sqlite3.Row
        baseline=[dict(x) for x in db.execute('select e.*,g.canonical_title from entries e join games g on g.id=e.game_id where contest_id=299 order by position')]
    assert len(baseline)==12 and [b['position'] for b in baseline]==list(range(1,13))
    assert [b['canonical_title'] for b in baseline]==[b['title'] for b in roster['rows']]
    (TASK/'ROSTER_BASELINE.json').write_text(json.dumps(baseline,ensure_ascii=False,indent=2)+'\n',encoding='utf8')
    witness=json.loads((TASK/'DOM_WITNESS.json').read_text(encoding='utf8'))
    assert witness['roster_source']==roster['source']
    assert witness['roster_links']==[dict(url=f'https://boardgamegeek.com/thread/3576315/article/{p}#{p}',label=r['title']) for p,r in zip(POSTS,roster['rows'])]
    rows=[]
    for b in baseline:
        i=b['position'];p=POSTS[i-1]
        src=f'https://boardgamegeek.com/thread/3576315/article/{p}#{p}' if i!=1 else 'https://boardgamegeek.com/thread/3577423/article/46617446#46617446'
        res=[dict(url=u,label_raw=l,content_role=r,context_raw=c,version_raw=None,host=urlsplit(u).netloc,access_type='file' if u.endswith('.pdf') or '/scl/fi/' in u else shared.access(u)) for u,l,r,c in LINKS.get(i,[])]
        w=witness['posts'][i-1]
        assert w['source']==src and w['author']==AUTHORS[i-1] and w['time']==TIMES[i-1]
        assert w['selected_links']==[dict(url=z['url'],label=z['label_raw']) for z in res]
        assert w['all_first_post_read'] and w['media']==[]
        assert all(item['context_raw'] in w['requirement_excerpts'] for item in REQ[i])
        rows.append(dict(entry_id=b['id'],game_id=b['game_id'],position=i,title=b['canonical_title'],source_url=src,wip_url=src,roster_submission_url=f'https://boardgamegeek.com/thread/3576315/article/{p}#{p}',author_raw=AUTHORS[i-1],post_timestamp_raw=TIMES[i-1],checked_at=DATE,wip_status='found',resource_listing_status='observed' if res else 'none_declared',material_listing_status='observed' if REQ[i] else 'none_declared',coverage_scope='first_post_only',outcome='complete',all_first_post_read=True,resources=res,requirements=REQ[i],notes=NOTES[i],source_structure='dedicated_wip_original_first_post' if i==1 else 'original_game_submission_in_contest_thread'))
    counts=dict(entries=12,complete=12,resource_entries=sum(bool(r['resources']) for r in rows),none_declared_resource_entries=sum(not r['resources'] for r in rows),resources_per_entry=sum(len(r['resources']) for r in rows),unique_resource_urls=len({x['url'] for r in rows for x in r['resources']}),requirements=sum(len(r['requirements']) for r in rows),none_declared_material_entries=1,not_observable=0,wip_not_found=0)
    payload=dict(task_id='TSK-0063',contest_id=299,checked_at=DATE,counts=counts,coverage_scope='first_post_only',method='CUA rendered official roster and original submissions on three pages. WIP optional under challenge rules; Zero-Day dynamic title link resolved via viewport, then original dedicated WIP read. All selected original posts read completely; no replies or external hosts/files opened.',entries=rows)
    (TASK/'EVIDENCE.json').write_text(json.dumps(payload,ensure_ascii=False,indent=2)+'\n',encoding='utf8')
    shared.DATE=DATE;shared.EVIDENCE=EVIDENCE
    sql=shared.sql_for(rows).replace('TSK-0053','TSK-0063');sqlpath=ROOT/'catalog/2025-patch-materials.sql';sqlpath.write_text(sql,encoding='utf8')
    copy=out/'verification.sqlite3'
    assert copy.resolve()!=dbpath
    with sqlite3.connect(dbpath.as_uri()+'?mode=ro',uri=True) as src,sqlite3.connect(copy) as dst:src.backup(dst)
    with sqlite3.connect(copy) as db:
        before=snapshot(db);db.executescript(sql);after=snapshot(db);isolated(before,after,db,rows);check(db,rows)
        db.executescript(sql);assert snapshot(db)==after
        additions={t:len(after[t])-len(before[t]) for t in before if len(after[t])!=len(before[t])}
    result=dict(task_id='TSK-0063',checked_at=DATE,counts=counts,dom_identity_links_excerpts_verified=12,roster_reconciled=12,copy_integrity='ok',foreign_keys='ok',idempotent=True,original_rows_preserved=True,other_contests_rankings_and_acquisitions_unchanged=True,operational_database_opened_read_only=True,operational_applied=False,copy_path=copy.relative_to(ROOT).as_posix(),table_additions=additions,sql_sha256=hashlib.sha256(sqlpath.read_bytes()).hexdigest())
    (TASK/'VERIFICATION.json').write_text(json.dumps(result,ensure_ascii=False,indent=2)+'\n',encoding='utf8')
    report=['# 24 Hour Design Challenge PATCH 2025 — censimento materiali','',f'Verifica BGG {DATE}, TSK-0063. [Roster ufficiale]({roster["source"]}), 12 entry. Primo post introduttivo originale per ciascuna entry; WIP dedicato facoltativo secondo il [regolamento del contest](https://boardgamegeek.com/thread/3576315). Zero-Day Triage rinvia dal post di presentazione a un WIP originale, letto integralmente. Le altre undici entry sono presentazioni originali nel thread. Nessuna risposta successiva utilizzata.','',f"12/12 esiti completi nel perimetro first_post_only; {counts['resource_entries']} entry con risorse dichiarate, {counts['resources_per_entry']} associazioni entry–URL, {counts['unique_resource_urls']} URL distinti, {counts['requirements']} requisiti. Patch-22 e Picking Pumpkins: none_declared per URL materiali. Picking Pumpkins: nessun requisito testuale esplicito. Zero WIP non trovati o post non osservabili.",'','| Entry | Gioco / fonte | URL | Requisiti | Note |','|---:|---|---:|---:|---|']
    for r in rows:report.append(f"| {r['entry_id']} | [{r['title']}]({r['source_url']}) | {len(r['resources'])} | {len(r['requirements'])} | {r['notes']} |")
    report+=['','Dichiarazioni, quantità, alternative, autore, timestamp, versione e note preservati in [EVIDENCE.json](../'+EVIDENCE.replace(' ','%20')+'). Risorse unknown/not_checked: dichiarazione non equivale a disponibilità. Tassonomia provvisoria, requisiti first_post_only e approvvigionamento unspecified quando non dichiarato. Immagini senza istruzione esplicita di stampa escluse. Nessun host esterno o file aperto e nessun download.','', 'Verifica su copia privata: integrità e foreign key valide, importazione idempotente, righe originarie preservate e altri contest, classifiche e acquisizioni invariati. Database operativo aperto esclusivamente mode=ro; SQL pronto per integrazione seriale da TSK-0059.','', 'Prossimo passo: integrazione coordinata del SQL, rigenerazione cruscotto e registro. Eventuale ACQ soltanto del contest PATCH dopo selezione dei giochi e verifica condizioni/host. Nessun controllo ordinario di monitoraggio del contest concluso.','']
    (ROOT/'sources/2025-PATCH-MATERIALS.md').write_text('\n'.join(report),encoding='utf8')
    print(json.dumps(result,ensure_ascii=False))

if __name__=='__main__':main()
