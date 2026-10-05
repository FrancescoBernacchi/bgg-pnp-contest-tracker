"""TSK-0062: PAD declarations; generates SQL and verifies ONLY a private copy."""
import argparse, hashlib, json, sqlite3
from pathlib import Path
from urllib.parse import urlsplit
import build_2025_54_card_materials as shared
from verify_2025_traditional_materials import snapshot

ROOT=Path(__file__).resolve().parents[1]
TASK=ROOT/'tasks/2026-10-05 - MAT - 24 Hour Design Challenge PAD 2025'
DATE='2026-10-05'
EVIDENCE=(TASK.relative_to(ROOT)/'EVIDENCE.json').as_posix()
POSTS=[46361933,46367208,46430966,46482487,46484191]
AUTHORS=['Cameron','Iffix Y Santaph','David Stewart','Iffix Y Santaph','Isaac Haller']
TIMES=['22 lug 2025 (edited)','23 lug 2025 (edited)','6 ago 2025 (edited)','17 ago 2025 (edited)','17 ago 2025']
LINKS={1:[('https://docs.google.com/document/d/1Z48pyFKnoxPcAGL6Ev7kN-PjDm87J2Hbv-_7UkNGwGQ/edit?tab=t','https://docs.google.com/document/d/1Z48pyFKnoxPcAGL6Ev7kN-Pj...','rules','RULES; files for the actual game are within the rules')],3:[('https://davidfstewart.ca/wp-content/uploads/2025/08/Lunch-Pad-Game-by-David-Stewart.pdf','Lunch-Pad-Game-by-David-Stewart.pdf','game_files','Here is the print-and-play file that contains the rules and cards')],4:[('https://drive.google.com/file/d/1kDIsTPy8Tfp0RZWjmteJjqLRdr0MvhcK/view?usp=sharing','[Components]','component','[Components]'),('https://drive.google.com/file/d/1WjeA3B4QG5dyAz6CgEb0eIOhOw5_9mqC/view?usp=sharing','[Rules]','rules','[Rules]')],5:[('https://drive.google.com/drive/folders/1OWAZYD8xhl0ufOL8TvFMKmAquLJdaQ82?usp=sharing','https://drive.google.com/drive/folders/1OWAZYD8xhl0ufOL8TvFM...','game_files',"A little late, but here's my entry! It's called CareFlight")]}
REQ={i:[] for i in range(1,6)}
def req(i,name,q,raw,kind='printable_component',level='required',supply='printable'):
    REQ[i].append(dict(material_kind=kind,name_normalized=name,name_raw=raw,quantity_raw=q,requirement_level=level,supply_mode=supply,context_raw=raw))
req(1,'mazzo PnP con plance incluse','1 per giocatore; 3 mazzi per 2 giocatori','Print out one PnP deck for each person playing the game (the boards are included in the deck files)')
req(1,'mazzo wild',None,'print out the wild deck and player guide no matter what')
req(1,'guida giocatore',None,'print out the wild deck and player guide no matter what',kind='player_aid')
req(1,'pedine per le plance',None,'Grab some movers for the boards, as I forgot to make any',kind='counter',supply='common')
req(1,'blocco segnapunti o superficie per tacche','1 per giocatore','a scorepad/somewhere to write tally marks for each person',kind='writing_tool',supply='common')
req(2,'mazzo tradizionale con joker per spareggio','30/40/50 carte in gioco per 3/4/5 giocatori',"Preparation: In a 3 player game, remove Jokers, all 2-6's, and red 7's; this leaves 30 cards. In a 4 player game, remove Jokers and 2-4's; this leaves 40 cards. In a 5 player game, remove Jokers and red 2's; this leaves 50 cards.",kind='standard_deck',supply='common')
req(3,'dadi','8','You will need 8 dice to play, along with the cards included in the print-and-play file.',kind='dice',supply='common')
req(3,'carte PnP',None,'You will need 8 dice to play, along with the cards included in the print-and-play file.')
req(3,'segnalino primo giocatore',None,'The rules mention a first player token, which is not needed but helps with the flow.',kind='counter',level='optional',supply='common')
req(3,'regolamento',None,'Here is the print-and-play file that contains the rules and cards',kind='rules')
ALT='The game uses 32 mini-sized playing cards, a game board and 2 player boards, and just a handful of components.'
req(4,'carte mini','32',ALT)
req(4,'plancia gioco','1',ALT)
req(4,'plance giocatore','2',ALT)
req(4,'altri componenti non specificati','a handful',ALT,kind='other',supply='unspecified')
req(4,'regolamento',None,'[Rules]',kind='rules')
NOTES={1:'Plance incluse nel mazzo, non sommate nuovamente. Tre mazzi per due giocatori; mazzo wild e guida sempre richiesti. File Canva Lilypad Boards e Cards dichiarati mera arte non configurata PnP; nessun URL Canva nel post originale corrente. File di gioco dichiarati interni alle regole: destinazioni annidate non osservate.',2:'Regole interamente nel post, nessun URL materiali. Mazzo selezionato per numero giocatori; joker delle carte rimosse usati nello spareggio. Nessuno strumento segnapunti dedotto.',3:'PDF dichiarato regole e carte; 8 dadi e segnalino primo giocatore opzionale. Immagine BGG 9031357 illustrativa esclusa: nessuna istruzione di stampa.',4:'32 carte mini, una plancia gioco, due plance giocatore e ulteriori componenti non specificati. Nessuna distinta dedotta dalla meccanica.',5:'Cartella dichiarata per entry, contenuto non verificato. Nessun requisito esplicito: roll n write non autorizza inferire dadi, matite o schede.'}

def isolation(before,after,db,rows):
    ids={r['entry_id'] for r in rows};gids={r['game_id'] for r in rows}
    allowed={'entries','entry_resource_scans','entry_material_scans','entry_material_requirements','entry_resource_mentions','remote_resources','remote_resource_observations','entry_work_observations'}
    for table,old in before.items():
        new=after[table]
        if table not in allowed: assert old==new,table; continue
        cols=[x[1] for x in db.execute('pragma table_info("'+table+'")')]
        if table=='entries':
            ix=cols.index('wip_thread_url');assert len(old)==len(new)
            for a,b in zip(old,new):
                assert a[:ix]+a[ix+1:]==b[:ix]+b[ix+1:]
                if a[0] not in ids or a[ix] is not None:assert a==b
            continue
        current={r[0]:r for r in new};assert all(current.get(r[0])==r for r in old),table
        for row in set(new)-set(old):
            if table=='remote_resource_observations':assert db.execute('select game_id from remote_resources where id=?',(row[cols.index('remote_resource_id')],)).fetchone()[0] in gids
            else:
                key='game_id' if table=='remote_resources' else 'entry_id'
                assert row[cols.index(key)] in (gids if key=='game_id' else ids),table

def main():
    ap=argparse.ArgumentParser();ap.add_argument('--database',type=Path,default=ROOT/'database/pnp_collection.sqlite3');args=ap.parse_args()
    dbpath=args.database.resolve()
    with sqlite3.connect(dbpath.as_uri()+'?mode=ro',uri=True) as db:
        db.row_factory=sqlite3.Row
        baseline=[dict(x) for x in db.execute('select e.*,g.canonical_title from entries e join games g on g.id=e.game_id where contest_id=295 order by position')]
    assert len(baseline)==5
    roster=json.loads((ROOT/'catalog/2025-24h-challenge-rosters-2026-10-04.json').read_text(encoding='utf8'))
    challenge=next(x for x in roster['contests'] if x['contest_id']==295)
    assert [x['canonical_title'].casefold() for x in baseline]==[x['title'].casefold() for x in challenge['rows']]
    rows=[]
    for b in baseline:
        i=b['position'];src=f'https://boardgamegeek.com/thread/3542704/article/{POSTS[i-1]}#{POSTS[i-1]}'
        res=[dict(url=u,label_raw=l,content_role=r,context_raw=c,version_raw=None,host=urlsplit(u).netloc,access_type=shared.access(u)) for u,l,r,c in LINKS.get(i,[])]
        rows.append(dict(entry_id=b['id'],game_id=b['game_id'],position=i,title=b['canonical_title'],source_url=src,wip_url=src,author_raw=AUTHORS[i-1],post_timestamp_raw=TIMES[i-1],checked_at=DATE,wip_status='found',resource_listing_status='observed' if res else 'none_declared',material_listing_status='observed' if REQ[i] else 'none_declared',coverage_scope='first_post_only',outcome='complete',all_first_post_read=True,resources=res,requirements=REQ[i],notes=NOTES[i],source_structure='original_game_submission_in_contest_thread'))
    witness=json.loads((TASK/'DOM_WITNESS.json').read_text(encoding='utf8'))
    assert witness['original_post_ids']==POSTS==witness['roster_post_ids']
    assert witness['authors']==AUTHORS and witness['times']==TIMES
    assert witness['embedded_media_counts']==[0]*5
    for i,r in enumerate(rows):
        assert witness['external_links'][i]==[[x['url'],x['label_raw']] for x in r['resources']]
    counts=dict(entries=5,complete=5,unique_original_posts=5,resource_entries=4,resources=5,unique_resource_urls=5,requirements=sum(len(r['requirements']) for r in rows),requirement_entries=4)
    payload=dict(task_id='TSK-0062',contest_id=295,checked_at=DATE,counts=counts,coverage_scope='first_post_only',method='CUA rendered original submissions linked by roster. WIP optional per official first post 46335243. Entire original submissions read, no later replies used, no external hosts or files opened.',entries=rows)
    (TASK/'ROSTER_BASELINE.json').write_text(json.dumps(baseline,ensure_ascii=False,indent=2)+'\n',encoding='utf8')
    (TASK/'EVIDENCE.json').write_text(json.dumps(payload,ensure_ascii=False,indent=2)+'\n',encoding='utf8')
    shared.DATE=DATE;shared.EVIDENCE=EVIDENCE
    sql=shared.sql_for(rows).replace('TSK-0053','TSK-0062')
    sqlpath=ROOT/'catalog/2025-pad-materials.sql';sqlpath.write_text(sql,encoding='utf8')
    out=ROOT/'outputs/2025-pad-materials';out.mkdir(parents=True,exist_ok=True)
    copy=out/'verification.sqlite3'
    with sqlite3.connect(dbpath.as_uri()+'?mode=ro',uri=True) as src,sqlite3.connect(copy) as dst:src.backup(dst)
    with sqlite3.connect(copy) as db:
        before=snapshot(db);db.executescript(sql);after=snapshot(db);isolation(before,after,db,rows)
        assert db.execute('pragma integrity_check').fetchall()==[('ok',)]
        assert not db.execute('pragma foreign_key_check').fetchall()
        assert db.execute('select count(*) from entry_work_observations where evidence_path=?',(EVIDENCE,)).fetchone()[0]==5
        for r in rows:
            for table,col in [('entry_resource_scans','resource_listing_status'),('entry_material_scans','material_listing_status')]:
                assert db.execute('select '+col+' from '+table+' where entry_id=? and source_url=? and checked_at=?',(r['entry_id'],r['source_url'],DATE)).fetchone()[0]==r[col]
            assert db.execute('select count(*) from entry_material_requirements where entry_id=? and source_url=?',(r['entry_id'],r['source_url'])).fetchone()[0]==len(r['requirements'])
            got={x[0] for x in db.execute('select rr.url from entry_resource_mentions m join remote_resources rr on rr.id=m.remote_resource_id where m.entry_id=? and m.source_url=?',(r['entry_id'],r['source_url']))}
            assert got=={x['url'] for x in r['resources']}
        db.executescript(sql);assert snapshot(db)==after
    result=dict(task_id='TSK-0062',counts=counts,dom_identity_and_links_checked=5,roster_reconciled=5,integrity='ok',foreign_keys='ok',idempotent=True,prior_rows_preserved=True,other_contests_rankings_acquisitions_unchanged=True,operational_database_opened_read_only=True,applied=False,sql_sha256=hashlib.sha256(sqlpath.read_bytes()).hexdigest())
    (TASK/'VERIFICATION.json').write_text(json.dumps(result,indent=2)+'\n',encoding='utf8')
    report=['# 24 Hour Design Challenge PAD 2025 — materiali','',f'Verifica BGG {DATE}, TSK-0062. Cinque entry riconciliate con [roster ufficiale](https://boardgamegeek.com/thread/3542704/article/46335246#46335246). Cinque presentazioni originali lette integralmente; WIP dedicato facoltativo secondo [regole ufficiali](https://boardgamegeek.com/thread/3542704/article/46335243#46335243). Copertura first_post_only.','',f"5/5 esiti completi; 4 giochi con URL, 5 URL distinti e {counts['requirements']} requisiti espliciti. Disponibilità non verificata; nessun host esterno/file aperto o download. Tassonomia provvisoria.",'','| Gioco | Autore e data post | URL | Requisiti | Note |','|---|---|---:|---:|---|']
    for r in rows:report.append(f"| [{r['title']}]({r['source_url']}) | {r['author_raw']}, {r['post_timestamp_raw']} | {len(r['resources'])} | {len(r['requirements'])} | {r['notes']} |")
    report+=['','Evidenze dichiarative in [EVIDENCE.json](../'+EVIDENCE.replace(' ','%20')+'). Pad Your Stats: none_declared riguarda solo URL, non regole o requisiti. CareFlight: none_declared riguarda i requisiti, non risorse. Tutte le fonti originali osservabili; nessun WIP non trovato o not_observable. URL identici accorpati; nessun duplicato in questo lotto.','', 'SQL pronto per integrazione seriale del coordinatore, provato esclusivamente su copia privata. Nessuna modifica del database operativo, registro o cruscotto. Prossimo approfondimento utile: eventuale ACQ del solo PAD dopo selezione giochi e verifica delle condizioni/host; nessun monitoraggio ordinario del contest concluso.','']
    (ROOT/'sources/2025-PAD-MATERIALS.md').write_text('\n'.join(report),encoding='utf8')
    print(json.dumps(result))
if __name__=='__main__':main()
