"""Riconciliazione offline APP-008; nessun accesso esterno, originali preservati."""
from collections import Counter
from contextlib import closing
from pathlib import Path
import hashlib
import json
import sqlite3
import sys

ROOT=Path(__file__).resolve().parents[2]
TASK=Path(__file__).resolve().parent
sys.path.insert(0,str(ROOT/'app'))
from server import progress_rows

DB=ROOT/'database/pnp_collection.sqlite3'
SQL_PATH=ROOT/'catalog/2026-10-04-work-history-reconciliation.sql'
REPORT=TASK/'HISTORY_RECONCILIATION.json'
OUT=ROOT/'outputs/app008'
OUT.mkdir(parents=True,exist_ok=True)
MONITOR='tasks/2026-09-04 - Monitoraggio contest BGG/TASK.md'
ROSTER24='sources/2024-CORE-ROSTER-COMPLETION.md'
ROSTER26='tasks/2026-09-19 - Esplorazione contest BGG 2026/TASK.md'
sql=['-- APP-008: riconciliazione successiva 2026-10-04; date delle fonti locali preservate.',
     'PRAGMA foreign_keys=ON;', 'BEGIN IMMEDIATE;']
decisions=[]
def quote(value):
    return "'"+str(value).replace("'","''")+"'"
def work(entry,phase,outcome,date,source,path,notes):
    assert (ROOT/path).exists(),path
    values=(entry,phase,outcome,date,source,path,notes)
    sql.append('INSERT OR IGNORE INTO entry_work_observations(entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('+','.join(map(quote,values))+');')
def census(db,cid,count,date,path,notes):
    ids=[r[0] for r in db.execute('SELECT id FROM entries WHERE contest_id=? ORDER BY id',(cid,))]
    assert len(ids)==count,(cid,len(ids),count)
    source=db.execute('SELECT COALESCE(entries_url,source_url) FROM contests WHERE id=?',(cid,)).fetchone()[0]
    values=(cid,'complete',json.dumps(ids),date,source,path,notes)
    columns='contest_id,outcome,entry_ids_json,observed_at,source_url,evidence_path,notes'
    # Rerun idempotente; le attestazioni originali non vengono sovrascritte.
    condition=' AND '.join(f'{k}={quote(v)}' for k,v in zip(columns.split(','),values))
    sql.append('INSERT INTO contest_census_observations('+columns+') SELECT '+','.join(map(quote,values))+' WHERE NOT EXISTS (SELECT 1 FROM contest_census_observations WHERE '+condition+');')
    decisions.append(dict(phase='census',contest_id=cid,count=count,date=date,evidence=path,notes=notes))
def contents(db):
    return {r[0]: hashlib.sha256(repr([tuple(row) for row in db.execute('SELECT * FROM "'+r[0]+'" ORDER BY rowid')]).encode()).hexdigest()
            for r in db.execute("SELECT name FROM sqlite_master WHERE type='table' AND name NOT IN ('entry_work_observations','contest_census_observations')").fetchall()}

with closing(sqlite3.connect(DB)) as db:
    db.row_factory=sqlite3.Row
    before=progress_rows(db)
    original=contents(db)
    # Roster 2024: cardinalità e conclusione esplicite nel rapporto, non semplice presenza.
    expected24={'54-Card':30,'Children':29,'In-Hand':35,'9-Card':50,'1-Card':50,
                'Roll':37,'Solitaire':57,'Traditional':50,'Two':29,'Wargame':14,'Solomode':28}
    keys24={277:'54-Card',278:'Children',279:'In-Hand',284:'9-Card',286:'1-Card',287:'Roll',
            289:'Solitaire',290:'Solomode',291:'Traditional',292:'Two',293:'Wargame'}
    for c in before['contests']:
        if c['year']!=2024 or not c['entry_count']:continue
        key=keys24[c['contest_id']]
        assert c['entry_count']==expected24[key]
        path=ROSTER24
        date='2026-09-19' if key in ('Children','Solomode') else '2026-10-04'
        if key=='Solomode':path='tasks/2026-09-18 - Esplorazione contest BGG 2024/TASK.md'
        census(db,c['contest_id'],expected24[key],date,path,'Roster completo esplicitamente documentato e importato; formalizzazione successiva APP-008 il 2026-10-04.')
    # Roster 2026: snapshot completi con check specifico e conteggio riconciliato.
    expected26={1:89,2:17,3:18,4:23,5:20,6:25,7:45,8:69,10:38,11:21,
                300:30,301:9,302:9,303:6,304:3,305:3}
    for cid,count in expected26.items():
        if cid>=300:path=ROSTER26
        elif cid==4:path='tasks/2026-10-02 - Monitoraggio - 2026 Print and Play Wargame Design Contest/TASK.md'
        else:path=MONITOR
        check=db.execute("SELECT * FROM contest_checks WHERE contest_id=? AND (check_kind IN ('manual_entry_census','manual_entry_and_results_census','discovery_and_entry_census','adjacent_inclusion_full_baseline') OR check_kind='scheduled_deadline_monitor') ORDER BY julianday(checked_at) DESC,id DESC LIMIT 1",(cid,)).fetchone()
        assert check and check['outcome'] in ('complete','changed')
        census(db,cid,count,check['checked_at'],path,
               'Snapshot completo nel perimetro del censimento, non garanzia sul roster futuro. '+(check['notes'] or '')+' Formalizzazione successiva 2026-10-04.')
    # Bad Comet resta selettivo/parziale (check originale partial); Roll & Write senza roster.
    # Classifiche: solo cinque baseline esplicitamente completate, mai da stato contest complete.
    ranking_files={6:'catalog/2026-in-hand-entries-results.sql',7:'catalog/2026-two-player-entries-results.sql',
        8:'catalog/2026-9-card-nanogame-entries-results.sql',10:'catalog/2026-children-family-results.sql',
        11:'catalog/2026-solomode-adjacent-entries-results.sql'}
    expected_results={6:(69,22),7:(24,12),8:(58,17),10:(43,20),11:(63,20)}
    for cid,path in ranking_files.items():
        rows=db.execute('SELECT * FROM rankings WHERE contest_id=?',(cid,)).fetchall()
        positive={r['game_id'] for r in rows}
        assert (len(rows),len(positive))==expected_results[cid]
        check=db.execute("SELECT * FROM contest_checks WHERE contest_id=? AND check_kind IN ('manual_entry_and_results_census','results_baseline_completion','adjacent_inclusion_full_baseline') AND outcome='complete' ORDER BY julianday(checked_at) DESC,id DESC LIMIT 1",(cid,)).fetchone()
        assert check
        for e in db.execute('SELECT * FROM entries WHERE contest_id=?',(cid,)).fetchall():
            # Two-Player documenta top-3: riutilizzo positivo, niente negativo oltre tale copertura.
            if cid==7 and e['game_id'] not in positive:continue
            outcome='partial' if cid==7 else ('complete' if e['game_id'] in positive else 'absent')
            evidence='tasks/2026-10-04 - APP - Barre di completamento del lavoro/TASK.md' if cid==7 else path
            work(e['id'],'ranking',outcome,check['checked_at'],rows[0]['evidence_url'],evidence,
                 'Formalizzazione successiva di baseline risultati già verificata: '+check['notes']+
                 (' Copertura Two-Player limitata ai podi documentati in '+path+'; riuso parziale, non attestazione di tutte le categorie/liste. Nessuna assenza inferita per le altre entry.' if cid==7 else ' Assenza riferita alle liste pubblicate già censite, non a voti privati.'))
        decisions.append(dict(phase='ranking',contest_id=cid,date=check['checked_at'],evidence=path,
                              positive=len(positive),negative_policy='none_top3' if cid==7 else 'documented_complete_baseline'))
    # Acquisizione: rispettare gli esiti e le esclusioni già deliberate nei manifest.
    manifest_names=['2025_roll_write_acquisition_batch_2026-10-03.json',
                    '2025_children_family_remaining_acquisition_batch_2026-10-03.json',
                    '2025_children_family_acquisition_batch_2026-10-03.json']
    outcome_map={'acquired':'complete','no_declared_resource':'not_applicable','no_resource_declared':'not_applicable',
                 'restricted':'blocked','access_restricted':'blocked','not_observable':'blocked',
                 'unavailable':'blocked','unavailable_downloads':'blocked','host_limit':'blocked',
                 'acquired_with_limits':'partial','acquired_partial_view_only_rulebook':'partial','acquired_partial_host_limit':'blocked'}
    for name in manifest_names:
        path='catalog/'+name
        manifest=json.loads((ROOT/path).read_text(encoding='utf-8'))
        cid=22 if 'roll_write' in name else 14
        outcomes=manifest.get('entry_outcomes',[])
        if name=='2025_children_family_acquisition_batch_2026-10-03.json':
            outcomes=[dict(game_title=t,outcome='acquired') for t in sorted({i['game_title'] for i in manifest['items']})]
            outcomes += [dict(game_title=i['game_title'],outcome='not_observable') for i in manifest['unresolved_games']]
        mapped=Counter()
        for o in outcomes:
            if 'entry_id' in o:
                e=db.execute('SELECT * FROM entries WHERE id=? AND contest_id=?',(o['entry_id'],cid)).fetchone()
            else:
                matches=db.execute('SELECT e.* FROM entries e JOIN games g ON g.id=e.game_id WHERE e.contest_id=? AND g.canonical_title=?',(cid,o['game_title'])).fetchall()
                assert len(matches)==1,(cid,o['game_title'])
                e=matches[0]
            assert e
            outcome=outcome_map[o['outcome']]
            if outcome=='complete':
                assert not o.get('unresolved_resource_ids')
                assert db.execute("SELECT count(*) FROM acquired_files af JOIN acquisitions a ON a.id=af.acquisition_id WHERE a.game_id=? AND af.acquisition_status='acquired'",(e['game_id'],)).fetchone()[0]>0
            source=o.get('wip_url') or e['wip_thread_url'] or e['entry_url']
            work(e['id'],'acquisition',outcome,manifest['acquired_at'],source,path,
                 'Esito originale '+o['outcome']+'. Perimetro e collegamenti esclusi secondo manifest e task ACQ, non tutte le menzioni indiscriminatamente. '+o.get('notes','')+' Formalizzazione successiva 2026-10-04.')
            mapped[outcome]+=1
        decisions.append(dict(phase='acquisition',contest_id=cid,evidence=path,outcomes=dict(mapped)))
    sql.append('COMMIT;')
    statement='\n'.join(sql)+'\n'
    SQL_PATH.write_text(statement,encoding='utf-8')
    with closing(sqlite3.connect(':memory:')) as trial:
        db.backup(trial)
        trial.row_factory=sqlite3.Row
        trial.executescript(statement)
        assert contents(trial)==original
        assert trial.execute('PRAGMA integrity_check').fetchone()[0]=='ok'
        assert not trial.execute('PRAGMA foreign_key_check').fetchall()
        after_trial=progress_rows(trial)
        counts=[trial.execute('SELECT count(*) FROM '+t).fetchone()[0] for t in ('entry_work_observations','contest_census_observations')]
        trial.executescript(statement)
        assert counts==[trial.execute('SELECT count(*) FROM '+t).fetchone()[0] for t in ('entry_work_observations','contest_census_observations')]
    backup=OUT/'before_history_reconciliation.sqlite3'
    if not backup.exists():
        with closing(sqlite3.connect(backup)) as destination:db.backup(destination)
    db.executescript(statement)
    assert contents(db)==original
    assert db.execute('PRAGMA integrity_check').fetchone()[0]=='ok'
    assert not db.execute('PRAGMA foreign_key_check').fetchall()
    after=progress_rows(db)
    assert after==after_trial
    initial=json.loads((OUT/'audit-before.json').read_text(encoding='utf-8'))['progress'] if (OUT/'audit-before.json').exists() else before
    def snapshot(progress):
        older=[c for c in progress['contests'] if c['year'] is not None and c['year']<2024]
        assert all(c['entry_count']==0 for c in older), 'Riesaminare annualità precedenti con entry operative'
        return dict(years=progress['years'],contests=[c for c in progress['contests'] if c['year'] in (2024,2025,2026)],
                    older_contests_without_entries_count=len(older),total_contests_count=len(progress['contests']))
    REPORT.write_text(json.dumps(dict(date='2026-10-04',decisions=decisions,before=snapshot(initial),after=snapshot(after),
        original_tables_unchanged_sha256=original,integrity='ok',foreign_key_errors=0,idempotent=True,
        backup=str(backup.relative_to(ROOT))),ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
    for y in after['years']:
        if y['year'] in (2024,2025,2026):print(json.dumps(y))
