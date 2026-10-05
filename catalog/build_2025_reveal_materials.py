"""TSK-0060. Serialize BGG declarations and verify only on a private copy."""
import argparse, hashlib, json, sqlite3
from pathlib import Path
from urllib.parse import urlsplit
import build_2025_54_card_materials as shared
from verify_2025_traditional_materials import snapshot

ROOT=Path(__file__).resolve().parents[1]
TASK=ROOT/'tasks/2026-10-05 - MAT - 24 Hour Design Challenge REVEAL 2025'
DATE='2026-10-05'
EVIDENCE=(TASK.relative_to(ROOT)/'EVIDENCE.json').as_posix()
POSTS=[45784115,45826419,45830622,45846664,45882504,45930400]
AUTHORS=['Iffix Y Santaph','Iffix Y Santaph','Coblin King','Isaac Haller','J de K','Tarang Hardikar']
TIMES=['11 mar 2025','19 mar 2025','20 mar 2025 (edited)','23 mar 2025 (edited)','30 mar 2025 (edited)','9 apr 2025 (edited)']
ISO=['2025-03-11T14:18:48+00:00','2025-03-19T14:05:34+00:00','2025-03-20T06:50:26+00:00','2025-03-23T13:04:48+00:00','2025-03-30T11:39:03+00:00','2025-04-09T14:32:18+00:00']
FNV=['0092236d','9a63b232','bad2b53b','6e5d5a21','5f9fc0ab','6b150b11']
LENGTHS=[2076,703,1733,1215,930,1419]
LINKS={
1:[('https://drive.google.com/file/d/1nmXxGNEV7d_0x4Ga72c0Qji1k2YBJHOD/view?usp=sharing','[Components]','component'),('https://drive.google.com/file/d/1naT2pDNf6ZnB0ebZwBJcAlD1Mhx0zliG/view?usp=sharing','[Rules]','rules')],
2:[('https://drive.google.com/file/d/1HcHpdKmLt3YdMlN3RytOH8OJenXBjssQ/view?usp=sharing','[Rules]','rules'),('https://drive.google.com/file/d/1bh1adDo5qfdgkCWlUM9m27Ykq2FAai33/view?usp=sharing','[Components]','component')],
3:[('https://drive.google.com/drive/folders/1wDpA4uiDqq9CDV1I27S92KvQS0GeQrwN?usp=sharing','Rulebook and Cards','game_files')],
4:[('https://drive.google.com/drive/folders/1wraVcEQXfQVaKsMeJru5HoryrZNKLj0R?usp=sharing','https://drive.google.com/drive/folders/1wraVcEQXfQVaKsMeJru5...','game_files')],
5:[('https://drive.google.com/drive/folders/1stG2TduAvP8lATxKXBNfEILVsfcY6IxI?usp=sharing','https://drive.google.com/drive/folders/1stG2TduAvP8lATxKXBNf...','game_files'),('https://playingcards.io/ryh27k','https://playingcards.io/ryh27k','online_play')],
6:[('https://drive.google.com/file/d/1QcXK590bIegi89XAlFrriSB89LM3Vacf/view?usp=sharing','What Happened Rules','rules'),('https://drive.google.com/file/d/1tPCGHxjoSHVg6dj8-N2GZGmZzpBy9wDj/view?usp=sharing','What Happened PNP','component'),('https://docs.google.com/document/d/1kEdQip1WtGYbjI2m03v2VOeP2n-3HNGN2pXeDrY9SFM/edit?tab=t.0','https://docs.google.com/document/d/1kEdQip1WtGYbjI2m03v2VOeP...','player_aid')]}
REQ={i:[] for i in range(1,7)}
def req(i,name,q,raw,kind='printable_component',level='required',supply='printable'):
    REQ[i].append(dict(material_kind=kind,name_normalized=name,name_raw=raw,quantity_raw=q,requirement_level=level,supply_mode=supply,context_raw=raw))
req(1,'workers condivisi','2','one of 2 workers which are shared by all players',kind='counter',supply='unspecified')
req(1,'dadi','2 per giocatore','each player will roll 2 dice',kind='dice',supply='common')
req(1,'carte robot','1 per giocatore','Each player starts with a robot card in their hand.')
req(1,'carte oggetto','20 / 28 / 36 secondo giocatori','20 item cards in a 2-3 player game, 28 in a 4 player game, or 36 in a 5 player game.')
req(1,'fogli stampati','5 per 2–3 giocatori','print just 5 sheets if you wish to play a 2-3 player game')
req(1,'regolamento',None,'[Rules]',kind='rules')
req(2,'componenti',None,'[Components]')
req(2,'regolamento',None,'[Rules]',kind='rules')
req(3,'carte sospettato','6','6 suspect cards, 6 location cards, 6 weapon cards.')
req(3,'carte luogo','6','6 suspect cards, 6 location cards, 6 weapon cards.')
req(3,'carte arma','6','6 suspect cards, 6 location cards, 6 weapon cards.')
req(3,'regolamento',None,'Rulebook and Cards',kind='rules')
req(3,'carte di Clue',None,'you own a copy of Clue, you can probably play it just as well with the cards from that game.',kind='base_game_component',level='alternative',supply='specialized')
req(4,'tessere eroe oggetto e nemico',None,'a grid of hero, object, and enemy tiles')
req(5,'componenti PnP',None,'PnP can be found here:')
req(5,'regolamento',None,'Hope the rules and components are clear enough.',kind='rules')
req(6,'carte con fronti e dorsi',None,'Page 1 is card fronts, page 2 is card backs for the cards on the first page. Page 3 is fronts, page 4 is backs and so on.')
req(6,'regolamento',None,'What Happened Rules',kind='rules')
NOTES={1:'Quantità alternative di carte per numero giocatori, non sommate. Workers e dadi espliciti; forma dei workers non inferita.',2:'Immagine BGG illustrativa esclusa: nessuna istruzione di stampa. Legame tematico con Robotika non trasformato in dipendenza.',3:'Roster Krasimir Savov; profilo @coblin visualizzato Coblin King. 18 carte proposte e poi carte pubblicate; pawn, carta e tokens nel brainstorming sono ipotesi, non requisiti confermati. Carte Clue alternativa dichiarata con incertezza probably.',4:'House Run è idea scartata nel medesimo post; inventario riferito solo a Dungeon Encounter. Cartella non enumerata; nessun regolamento inferito.',5:'Roster BlueChicken corrisponde a profilo @BlueChicken visualizzato J de K. PnP e implementazione online separati; Dextrous citato come strumento senza URL, escluso.',6:'Documento soluzione della storia: player_aid provvisorio, spoiler da aprire solo dopo il gioco. Fronti/dorsi espliciti, quantità carte non dedotta.'}

def main():
    ap=argparse.ArgumentParser();ap.add_argument('--database',type=Path,default=ROOT/'database/pnp_collection.sqlite3');a=ap.parse_args()
    dbpath=a.database.resolve()
    with sqlite3.connect(dbpath.as_uri()+'?mode=ro',uri=True) as db:
        db.row_factory=sqlite3.Row
        baseline=[dict(x) for x in db.execute('select e.*,g.canonical_title from entries e join games g on g.id=e.game_id where contest_id=296 order by position')]
    roster=next(x for x in json.loads((ROOT/'catalog/2025-24h-challenge-rosters-2026-10-04.json').read_text())['contests'] if x['contest_id']==296)
    assert len(baseline)==6 and [x['canonical_title'] for x in baseline]==[x['title'] for x in roster['rows']]
    (TASK/'ROSTER_BASELINE.json').write_text(json.dumps(baseline,ensure_ascii=False,indent=2)+'\n',encoding='utf8')
    rows=[];witness=[]
    for b in baseline:
        i=b['position'];src=f'https://boardgamegeek.com/thread/3473961/article/{POSTS[i-1]}#{POSTS[i-1]}'
        res=[dict(url=u,label_raw=l,content_role=r,context_raw=('The Answer To The Puzzle; revealed story, only after solving the game' if i==6 and r=='player_aid' else l),version_raw=None,host=urlsplit(u).netloc,access_type=shared.access(u)) for u,l,r in LINKS[i]]
        rows.append(dict(entry_id=b['id'],game_id=b['game_id'],position=i,title=b['canonical_title'],source_url=src,wip_url=src,author_raw=AUTHORS[i-1],roster_author_raw=roster['rows'][i-1]['author'],post_timestamp_raw=TIMES[i-1],post_timestamp_iso=ISO[i-1],checked_at=DATE,wip_status='found',resource_listing_status='observed',material_listing_status='observed',coverage_scope='first_post_only',outcome='complete',all_first_post_read=True,resources=res,requirements=REQ[i],notes=NOTES[i],source_structure='original_game_submission_in_contest_thread'))
        witness.append(dict(source=src,author=AUTHORS[i-1],time=TIMES[i-1],datetime=ISO[i-1],characters=LENGTHS[i-1],text_fnv=FNV[i-1],links=[dict(url=u,label=l) for u,l,_ in LINKS[i]],media=[]))
    counts=dict(entries=6,complete=6,unique_original_posts=6,resource_entries=6,resources=11,unique_resource_urls=11,requirements=sum(len(r['requirements']) for r in rows))
    (TASK/'DOM_WITNESS.json').write_text(json.dumps(dict(checked_at=DATE,method='CUA rendered DOM; original posts only; full text read, text fingerprint recorded without reproducing whole third-party posts',roster_source=roster['source'],roster_posts=POSTS,optional_wip_evidence='https://boardgamegeek.com/thread/3473961/article/45765523#45765523',entries=witness),ensure_ascii=False,indent=2)+'\n',encoding='utf8')
    payload=dict(task_id='TSK-0060',contest_id=296,checked_at=DATE,counts=counts,coverage_scope='first_post_only',method='CUA original author posts directly linked by official roster; optional dedicated WIP; no external hosts/files or replies used.',entries=rows)
    (TASK/'EVIDENCE.json').write_text(json.dumps(payload,ensure_ascii=False,indent=2)+'\n',encoding='utf8')
    shared.DATE=DATE;shared.EVIDENCE=EVIDENCE
    sql=shared.sql_for(rows).replace('TSK-0053','TSK-0060')
    sqlpath=ROOT/'catalog/2025-reveal-materials.sql';sqlpath.write_text(sql,encoding='utf8')
    out=ROOT/'outputs/2025-reveal-materials';out.mkdir(parents=True,exist_ok=True);copy=out/'verification.sqlite3'
    assert copy.resolve()!=dbpath
    with sqlite3.connect(dbpath.as_uri()+'?mode=ro',uri=True) as src,sqlite3.connect(copy) as dst:src.backup(dst)
    with sqlite3.connect(copy) as db:
        before=snapshot(db);db.executescript(sql);after=snapshot(db)
        ids={r['entry_id'] for r in rows};gids={r['game_id'] for r in rows}
        for table,old in before.items():
            new=after[table];cols=[x[1] for x in db.execute('pragma table_info('+table+')')]
            if table=='entries':
                ix=cols.index('wip_thread_url');assert len(old)==len(new)
                for x,y in zip(old,new):
                    assert x[:ix]+x[ix+1:]==y[:ix]+y[ix+1:]
                    if x[0] not in ids or x[ix] is not None:assert x==y
            else:
                assert set(old).issubset(set(new)),table
                for z in set(new)-set(old):
                    if 'entry_id' in cols:assert z[cols.index('entry_id')] in ids
                    elif table=='remote_resources':assert z[cols.index('game_id')] in gids
                    elif table=='remote_resource_observations':assert db.execute('select game_id from remote_resources where id=?',(z[cols.index('remote_resource_id')],)).fetchone()[0] in gids
                    else:raise AssertionError(table)
        assert db.execute('pragma integrity_check').fetchall()==[('ok',)]
        assert not db.execute('pragma foreign_key_check').fetchall()
        assert db.execute('select count(*) from entry_work_observations where evidence_path=?',(EVIDENCE,)).fetchone()[0]==6
        for r in rows:
            assert db.execute('select count(*) from entry_material_requirements where entry_id=? and source_url=?',(r['entry_id'],r['source_url'])).fetchone()[0]==len(r['requirements'])
            urls={x[0] for x in db.execute('select rr.url from entry_resource_mentions m join remote_resources rr on rr.id=m.remote_resource_id where m.entry_id=? and m.source_url=?',(r['entry_id'],r['source_url']))}
            assert urls=={x['url'] for x in r['resources']}
        db.executescript(sql);assert snapshot(db)==after
    verification=dict(task_id='TSK-0060',counts=counts,integrity='ok',foreign_keys='ok',idempotent=True,prior_rows_preserved=True,other_contests_unchanged=True,operational_database_opened_read_only=True,applied=False,sql_sha256=hashlib.sha256(sqlpath.read_bytes()).hexdigest())
    (TASK/'VERIFICATION.json').write_text(json.dumps(verification,indent=2)+'\n',encoding='utf8')
    report=['# REVEAL 2025 — censimento materiali','',f'Verifica BGG {DATE}, TSK-0060, contest 296. Sei post originali completi riconciliati con il [roster ufficiale]('+roster['source']+'). WIP dedicato facoltativo secondo il post di apertura; presentazioni originali valide. Copertura first_post_only.','',f"6/6 esiti completi; 11 URL dichiarati distinti; {counts['requirements']} requisiti. Nessun host esterno/file aperto, nessun download. Disponibilità non verificata. SQL provato soltanto su copia privata; pronto per integrazione seriale del coordinatore.",'','| Gioco | Autore visualizzato | Data post | URL | Requisiti | Note |','|---|---|---|---:|---:|---|']
    for r in rows:report.append(f"| [{r['title']}]({r['source_url']}) | {r['author_raw']} | {r['post_timestamp_raw']} | {len(r['resources'])} | {len(r['requirements'])} | {r['notes']} |")
    report+=['','Autori originali del roster preservati separatamente dai display name. Nessun esito negativo: tutti i post risultano osservabili e dichiarano risorse. Immagine Intent illustrativa esclusa; risposte successive e relativi link esclusi. Tassonomia funzione/forma provvisoria, soluzioni conservate senza apertura. Quantità alternative non sommate; materiali soltanto ipotetici esclusi.','', 'Dettaglio dichiarazioni, contesti, fonti e date: `tasks/2026-10-05 - MAT - 24 Hour Design Challenge REVEAL 2025/EVIDENCE.json`; attestazioni DOM in DOM_WITNESS.json.','', 'Prossimo passo: integrazione SQL da TSK-0059; eventuale ACQ del solo REVEAL dopo selezione esplicita e verifica condizioni/host. Nessun controllo ordinario del contest concluso.','']
    (ROOT/'sources/2025-REVEAL-MATERIALS.md').write_text('\n'.join(report),encoding='utf8')
    print(json.dumps(verification))
if __name__=='__main__':main()
