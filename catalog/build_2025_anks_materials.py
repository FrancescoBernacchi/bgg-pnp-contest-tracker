"""TSK-0064: serialize BGG declarations; only private-copy verification, never operational import."""
import argparse, hashlib, json, sqlite3
from pathlib import Path
from urllib.parse import urlsplit
import build_2025_54_card_materials as shared
from verify_2025_traditional_materials import snapshot

ROOT=Path(__file__).resolve().parents[1]
TASK=ROOT/'tasks/2026-10-05 - MAT - 24 Hour Design Challenge ANKS 2025'
DATE='2026-10-05'
EVIDENCE=(TASK.relative_to(ROOT)/'EVIDENCE.json').as_posix()
POSTS=[46860893,46916910,46915525,46940111,46944051,46956895,46993380,47044720]
AUTHORS=['Iffix Y Santaph','Noah Charles','Marek Chodan','Iffix Y Santaph','Coblin King','David McDougal','Is. Ra.','David McDougal']
TIMES=['9 nov 2025 (edited)','20 nov 2025 (edited)','20 nov 2025 (edited)','25 nov 2025 (edited)','26 nov 2025 (edited)','29 nov 2025','7 dic 2025','19 dic 2025 (edited)']
LINKS={
2:[('https://1drv.ms/f/c/5e3ac0b8ce9fcff6/EgPGFsB-DlxEv84th0mElvMBHKGYpa0ImnZExbSnbe16Iw?e=nhxUMq','here','game_files','Find the files here.')],
3:[('https://markcho.itch.io/shanks','SHANKS','game_files','Full game (rules and prints) can be found here: SHANKS')],
4:[('https://drive.google.com/file/d/1GeTjZ6dQuTYO4a7QgxNsvFZCSTNwQb9v/view?usp=sharing','[Rules]','rules','[Rules]'),('https://drive.google.com/file/d/1KNLEaQklSY6YRsgaTbwJfeUTPLU_abnK/view?usp=sharing','[Components]','component','[Components]')],
5:[('https://drive.google.com/drive/folders/1QKaR_dW2YxcapCahDE8-yjsybFsUUVHK?usp=sharing','Planks & Piers','game_files','EDIT: Done. Not the deepest game, but I think it works. Planks & Piers')],
6:[('https://docs.google.com/document/d/13Aa6mkpRetPsK84RnOr5nEIUl9XvKkI3U1fumUv6V-M/edit?usp=sharing','PIP BLANKS RULEBOOK','game_files','PNP Grid for gameplay added to rulebook')],
7:[('https://www.dropbox.com/scl/fi/9a4q2jhl3gqqn9hjckgdp/CrankCC-GE.pdf?rlkey=yfauxc8gai18uzv3bnaqteph6&st=frgvfc2n&dl=0','Here','game_files','Here'),('https://www.dropbox.com/scl/fi/zspntabc0jofcuk83uysj/CrankCC-GS.pdf?rlkey=f53rhtf67pv4itau882lzsm8c&st=x8nibapf&dl=0','Aquí','game_files','Aquí')],
8:[('https://docs.google.com/document/d/1tN0R6ftlilxOUThG5AcbWzMa0qpnnja7GaOnGhhwSD8/edit?usp=sharing','Living Rulebook','rules','Living Rulebook (will lock at 2pm EST -5GMT on 12/20/25)')]}
REQ={i:[] for i in range(1,9)}
def req(i,name,q,raw,kind='printable_component',level='required',supply='unspecified'):
    REQ[i].append(dict(material_kind=kind,name_normalized=name,name_raw=raw,quantity_raw=q,requirement_level=level,supply_mode=supply,context_raw=raw))
req(1,'mazzo tradizionale senza joker',None,'Gee, Thanks is a trick-taking game played with a traditional deck (no Jokers).',kind='standard_deck',supply='common')
req(2,'tabellone',None,'Just a board, a deck of cards, five scraps, and your increasingly fragile grip on cosmic order.',supply='printable')
req(2,'carte evento','24','Each turn, draw one of 24 event cards',supply='printable')
req(2,'stampante','1','2. A Printer — ideally not haunted, but thematically appropriate if it is.',kind='assembly_tool',supply='common')
req(2,'segnalini sostituibili','5','3. Five tokens — coins, beads, buttons, pebbles, lint, dead flies. Anything.',kind='counter',supply='common')
req(3,'regolamento',None,'Full game (rules and prints) can be found here: SHANKS',kind='rules',supply='printable')
req(3,'materiali stampabili',None,'Full game (rules and prints) can be found here: SHANKS',supply='printable')
req(4,'regolamento',None,'[Rules]',kind='rules',supply='printable')
req(4,'componenti',None,'[Components]',supply='printable')
req(6,'mazzo tradizionale','1 mazzo di 52 carte','1 Standard 52-Card Deck',kind='standard_deck',supply='common')
req(6,'dadi','32 (16 per giocatore)','32 Dice (16 per player)',kind='dice',supply='common')
req(6,'griglie giocatore','2 (4x4)','2 Player Grids (4x4) (optional)',level='optional',supply='printable')
req(6,'segnalino primo giocatore','1','1 First Player Marker (optional)',kind='counter',level='optional')
for name,q,raw,kind in [('tabellone','1','1 Game Board','printable_component'),('tessere','48','48 Tiles','printable_component'),('carte','54','54 Cards','printable_component'),('carte contatore mood o HP','4','4 Cards (mood or HP "counter")','printable_component'),('carta contatore','1','1 Card (counter)','printable_component'),('segnalini','5','5 Tokens','counter'),('meeple','4 (1 per giocatore)','4 Meeples (1 per player)','pawn')]:
    req(7,name,q,raw,kind=kind)
req(8,'regolamento',None,'Living Rulebook (will lock at 2pm EST -5GMT on 12/20/25)',kind='rules')
NOTES={1:'Regole nel post originale; nessun URL materiali dichiarato. Numero totale carte non dedotto.',2:'Roster -> presentazione originale 46916976 -> WIP originale 46916910. PnP, tabellone, 24 carte evento, stampante e cinque segnalini espliciti; bravery escluso come battuta. Host OneDrive non verificato.',3:'Regole e stampe dichiarate; contenuti itch.io non aperti.',4:'Regole e componenti separati; nessuna quantità dedotta dalla meccanica. Immagine decorativa esclusa.',5:'18 carte e possibile pedina dichiarate soltanto come idea iniziale (I imagine, There might); conservate come proposta, non requisito finale. Cartella dichiarata dal successivo EDIT nello stesso primo post.',6:'Regolamento contiene griglia PnP secondo dichiarazione. WIP Thread for Game ha href # e click conduce alla home; fallback mirato senza risultato pertinente. Presentazione originale completa valida. Video solo desiderato futuro, nessun URL.',7:'Due PDF dichiarati con etichette Here/Aquí; lingue/contenuti non verificati né dedotti dai nomi. Quantità carte 54, 4 e 1 mantenute separate; nessun totale inferito. Immagini illustrative escluse.',8:'Solo Living Rulebook dichiarato; nessun inventario di componenti esplicito. Non inferire mazzo tradizionale dalla meccanica.'}

def main():
    p=argparse.ArgumentParser();p.add_argument('--database',type=Path,default=ROOT/'database/pnp_collection.sqlite3');a=p.parse_args()
    uri=a.database.resolve().as_uri()+'?mode=ro'
    with sqlite3.connect(uri,uri=True) as db:
        db.row_factory=sqlite3.Row
        baseline=[dict(x) for x in db.execute('select e.*,g.canonical_title from entries e join games g on g.id=e.game_id where contest_id=298 order by position')]
    roster=next(x for x in json.loads((ROOT/'catalog/2025-24h-challenge-rosters-2026-10-04.json').read_text())['contests'] if x['key']=='anks')
    assert len(baseline)==8 and [x['canonical_title'] for x in baseline]==[x['title'] for x in roster['rows']]
    rows=[]
    for b in baseline:
        i=b['position'];src=f'https://boardgamegeek.com/thread/{3614854 if i==2 else 3607485}/article/{POSTS[i-1]}#{POSTS[i-1]}'
        res=[dict(url=u,label_raw=l,content_role=r,context_raw=c,version_raw=None,host=urlsplit(u).netloc,access_type='folder' if i==2 else shared.access(u)) for u,l,r,c in LINKS.get(i,[])]
        rows.append(dict(entry_id=b['id'],game_id=b['game_id'],position=i,title=b['canonical_title'],source_url=src,wip_url=src,author_raw=AUTHORS[i-1],post_timestamp_raw=TIMES[i-1],checked_at=DATE,wip_status='found',dedicated_wip_status='found' if i==2 else ('not_found' if i==6 else 'not_required'),resource_listing_status='observed' if res else 'none_declared',material_listing_status='observed' if REQ[i] else 'none_declared',coverage_scope='first_post_only',outcome='complete',all_first_post_read=True,resources=res,requirements=REQ[i],notes=NOTES[i],source_structure='dedicated_wip_original_first_post' if i==2 else 'original_game_submission_in_contest_thread'))
    witness=json.loads((TASK/'DOM_WITNESS.json').read_text(encoding='utf8'))
    assert len(witness)==8
    for r,w in zip(rows,witness):
        assert '/article/'+str(w['post'])+'#' in r['source_url']
        assert w['author']==r['author_raw'] and w['time']==r['post_timestamp_raw'] and w['text_length']>0 and not w['media']
        assert [(x['url'],x['label']) for x in w['links']]==[(x['url'],x['label_raw']) for x in r['resources']]
    counts=dict(entries=8,complete=8,unique_original_posts=8,resource_entries=7,resources_per_entry=sum(len(r['resources']) for r in rows),unique_resource_urls=len({z['url'] for r in rows for z in r['resources']}),requirements=sum(len(r['requirements']) for r in rows),none_declared_resource_entries=1,none_declared_material_entries=1)
    payload=dict(task_id='TSK-0064',contest_id=298,checked_at=DATE,counts=counts,roster_source=roster['source'],coverage_scope='first_post_only',method='CUA rendered original author posts, whole text read; BGG rules explicitly permit optional dedicated WIP. No replies, external hosts or files used.',entries=rows,anomalies=[dict(entry_position=6,label='WIP Thread for Game',href='#',click_result='https://boardgamegeek.com/',fallback='site:boardgamegeek.com/thread "Pip Blanks"; no relevant result'),dict(entry_position=5,provisional_components_raw='The way I imagine it is 18 cards; There might also be a player pawn',adopted_as_requirements=False)])
    (TASK/'EVIDENCE.json').write_text(json.dumps(payload,ensure_ascii=False,indent=2)+'\n',encoding='utf8')
    (TASK/'ROSTER_BASELINE.json').write_text(json.dumps(baseline,ensure_ascii=False,indent=2)+'\n',encoding='utf8')
    shared.DATE=DATE;shared.EVIDENCE=EVIDENCE
    sql=shared.sql_for(rows).replace('TSK-0053','TSK-0064')
    sqlpath=ROOT/'catalog/2025-anks-materials.sql';sqlpath.write_text(sql,encoding='utf8')
    out=ROOT/'outputs/2025-anks-materials';out.mkdir(parents=True,exist_ok=True)
    copy=out/'verification.sqlite3'
    if copy.resolve()==a.database.resolve():raise ValueError('Verification must use private copy')
    with sqlite3.connect(uri,uri=True) as src,sqlite3.connect(copy) as dst:src.backup(dst)
    with sqlite3.connect(copy) as db:
        before=snapshot(db);db.executescript(sql);after=snapshot(db)
        ids={r['entry_id'] for r in rows};gids={r['game_id'] for r in rows}
        allowed={'entries','entry_resource_scans','entry_material_scans','entry_work_observations','remote_resources','entry_resource_mentions','remote_resource_observations','entry_material_requirements'}
        for table,old in before.items():
            new=after[table]
            if table not in allowed:assert old==new,table
            elif table=='entries':
                cols=[x[1] for x in db.execute('pragma table_info(entries)')];ix=cols.index('wip_thread_url')
                for x,y in zip(old,new):
                    assert x[:ix]+x[ix+1:]==y[:ix]+y[ix+1:]
                    if x[0] not in ids:assert x==y
            else:
                assert set(old).issubset(set(new)),table
                additions=set(new)-set(old);cols=[x[1] for x in db.execute('pragma table_info('+table+')')]
                if additions and 'entry_id' in cols:assert all(x[cols.index('entry_id')] in ids for x in additions)
                elif additions and 'game_id' in cols:assert all(x[cols.index('game_id')] in gids for x in additions)
                elif additions:
                    assert table=='remote_resource_observations'
                    ridx=cols.index('remote_resource_id')
                    assert all(db.execute('select game_id from remote_resources where id=?',(x[ridx],)).fetchone()[0] in gids for x in additions)
        assert db.execute('pragma integrity_check').fetchall()==[('ok',)]
        assert not db.execute('pragma foreign_key_check').fetchall()
        assert db.execute('select count(*) from entry_work_observations where evidence_path=?',(EVIDENCE,)).fetchone()[0]==8
        for r in rows:
            assert db.execute('select count(*) from entry_material_requirements where entry_id=? and source_url=?',(r['entry_id'],r['source_url'])).fetchone()[0]==len(r['requirements'])
        db.executescript(sql);assert snapshot(db)==after
    verification=dict(task_id='TSK-0064',counts=counts,dom_identity_and_links=8,roster_reconciled=8,integrity='ok',foreign_keys='ok',idempotent=True,prior_rows_preserved=True,other_contests_unchanged=True,operational_database_opened_read_only=True,sql_sha256=hashlib.sha256(sqlpath.read_bytes()).hexdigest(),private_copy=str(copy))
    (TASK/'VERIFICATION.json').write_text(json.dumps(verification,ensure_ascii=False,indent=2)+'\n',encoding='utf8')
    report=['# 24 Hour Design Challenge ANKS 2025 — censimento materiali','',f'Verifica BGG {DATE}, TSK-0064. [Roster ufficiale]({roster["source"]}), otto entry riconciliate. Otto post originali completi, first_post_only. Ankhs Before Isfet rimanda a un WIP dedicato; per le altre entry presentazione originale nel contest, ammessa dalle regole. Nessun host esterno/file aperto, nessun download o risposta successiva utilizzata.','',json.dumps(counts),'','| Gioco | URL | Requisiti | Evidenza e limiti |','|---|---:|---:|---|']
    for r in rows:report.append(f"| [{r['title']}]({r['source_url']}) | {len(r['resources'])} | {len(r['requirements'])} | {r['notes']} |")
    report+=['','URL e requisiti sono dichiarazioni, non disponibilità verificata o distinta delle regole. Funzione e forma tecnica restano provvisorie. Gli originali sono identificati con autore e timestamp in EVIDENCE.json; i frammenti verbatim preservano la base dei requisiti. Nessun not_observable: tutte le fonti originali erano leggibili. Gee, Thanks!: none_declared solo URL; Planks & Piers: none_declared requisiti finali, idee storiche conservate separatamente.','', 'Pronto per integrazione seriale del coordinatore: SQL dedicato provato due volte su copia privata, dati preesistenti preservati e altri contest invariati. Database operativo letto con mode=ro.','', 'Prossimo approfondimento utile: eventuale ACQ del solo ANKS, dopo selezione esplicita dei giochi e verifica condizioni/host; chiarire componenti finali di Planks & Piers dalle regole in quel perimetro. Nessun monitoraggio ordinario del contest concluso.','']
    (ROOT/'sources/2025-ANKS-MATERIALS.md').write_text('\n'.join(report),encoding='utf8')
    print(json.dumps(verification,ensure_ascii=False))
if __name__=='__main__':main()
