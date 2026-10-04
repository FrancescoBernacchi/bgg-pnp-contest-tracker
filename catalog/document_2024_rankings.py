"""Aggiorna evidenze e registro di TSK-0046 senza sostituire le altre attività."""
import json
import sqlite3
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
TASK=ROOT/'tasks/2026-10-04 - BGG-A - Classifiche BGG 2024'
rows=json.loads((ROOT/'catalog/2024-rankings-observed-2026-10-04.json').read_text(encoding='utf-8'))
checks=[]
with sqlite3.connect(ROOT/'database/pnp_collection.sqlite3') as db:
    for cid in sorted({r['contest_id'] for r in rows}):
        subset=[r for r in rows if r['contest_id']==cid]
        name,scope=db.execute('SELECT name,scope_type FROM contests WHERE id=?',(cid,)).fetchone()
        checks.append(dict(contest_id=cid,name=name,scope=scope,verified_at='2026-10-04',
            observations=len(subset),categories=len({r['category'] for r in subset}),
            ranked_entries=len({r['game_id'] for r in subset}),
            entries=db.execute('SELECT COUNT(*) FROM entries WHERE contest_id=?',(cid,)).fetchone()[0],
            sources=sorted({r['evidence_url'] for r in subset}),outcome='complete_published_lists',
            limitations='Liste pubblicate per categoria; nessun voto individuale dedotto dai premi. Assenza dalle liste non equivale ad assenza di voti. Nessuna verifica di WIP o materiali.'))
(TASK/'CHECKS_2026-10-04.json').write_text(json.dumps(checks,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
report=['# Verifica classifiche BGG 2024 — 2026-10-04','','Sono state riconciliate integralmente le liste ufficiali osservate di 11 contest con roster esistente: 869 osservazioni, 239 entry distinte su 409. Baseline: zero risultati nel database.','','| Contest | Entry | In classifica | Categorie | Risultati |','|---|---:|---:|---:|---:|']
report += [f"| {c['name']} | {c['entries']} | {c['ranked_entries']} | {c['categories']} | {c['observations']} |" for c in checks]
report += ['','PnP principali: 225/381 (59,06%). Adiacenti: 14/28 (50%). Lavoro di confronto concluso: 381/381 e 28/28; le entry assenti dalle liste hanno un esito esplicito separato dai piazzamenti. Le sei challenge prive di roster restano fuori dal denominatore.','','## Evidenze e limiti','','Le fonti per categoria sono elencate in CHECKS_2026-10-04.json; i dati originali osservati e i nomi normalizzati rimangono distinti nel manifest. I pari merito conservano i numeri dichiarati, senza rinumerazione. Le menzioni onorevoli della giuria 54-Card hanno posizione nulla. Best Playtester è escluso perché premia persone. Categorie non pubblicate o con partecipazione insufficiente non sono inventate. Premi GeekGold e totali globali di votanti non diventano punteggi dei giochi.','','MATCHES.json documenta le corrispondenze verificate con titoli e collegamenti del roster, inclusi nomi precedenti e varianti. I suggerimenti di similarità del parser non vengono accettati automaticamente: UNRESOLVED.json è vuoto. In Solomode, Forest Shuffle corrisponde a SoloShuffle Fluegelschlaegerin (878), distinto dalla seconda variante Forest Shuffle (879). One Card Pyramid Builder corrisponde al nome successivo Little Awesome Pyramid (1178).','','Le percentuali dei piazzamenti sono il massimo recuperato dalle liste osservate, senza pretendere che siano disponibili tutte le schede di voto. Per un ulteriore aumento servono nuove tabelle ufficiali o rettifiche; nessun ricontrollo periodico dei contest conclusi è necessario.','','Importazione verificata prima su copia in memoria, poi in transazione con backup SQLite; controlli di integrità, chiavi esterne e ripetibilità. IMPORT_VERIFICATION.json registra il risultato. Nessun roster o materiale modificato.','','Pattern verificati: leggere alt delle immagini numeriche per i piazzamenti e contenuto degli spoiler ordinari per i risultati; conservare distintamente testo originale, posizione e fonte. Le posizioni nei token delle immagini non sono dedotte dall’ordine della lista.']
(TASK/'VERIFICA_2026-10-04.md').write_text('\n'.join(report)+'\n',encoding='utf-8')
task=TASK/'TASK.md'; text=task.read_text(encoding='utf-8').replace('stato in_corso.','stato completato.')
if '## Chiusura' not in text:
    text+='\n## Chiusura — 2026-10-04\n\nImportati 869 risultati ufficiali di 11 contest; 225/381 entry principali e 14/28 adiacenti presenti nelle liste. Confronto concluso per tutte le 409 entry con esiti espliciti complete/absent. Fonti e limiti in CHECKS_2026-10-04.json e VERIFICA_2026-10-04.md. Backup e verifiche in IMPORT_VERIFICATION.json; importazione idempotente, integrità e chiavi esterne valide. Sezioni annuali A/B rigenerate. Nessuna acquisizione o modifica Git. Prossimo approfondimento utile: solo nuove tabelle ufficiali/rettifiche; censimento delle challenge in task roster distinto.\n'
task.write_text(text,encoding='utf-8')
registry=ROOT/'tasks/REGISTRY.json'; data=json.loads(registry.read_text(encoding='utf-8'))
for item in data['tasks']:
    if item.get('id',item.get('task_id'))=='TSK-0046':
        item['status']='completato'; item['last_verified_at']='2026-10-04'
        item['status_basis']='Importazione e confronto conclusi; integrità, chiavi esterne e idempotenza verificate; evidenze in VERIFICA_2026-10-04.md.'
        item['coverage']='11 contest; 409 entry verificate; 869 risultati; 225/381 PnP e 14/28 adiacenti in classifica'
        item['next_action']='Solo nuove tabelle ufficiali o rettifiche; challenge senza roster in censimento separato.'
registry.write_text(json.dumps(data,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
for filename in ('AGENTS.md','PROJECT.md','TASK_GOVERNANCE.md'):
    path=ROOT/filename; text=path.read_text(encoding='utf-8')
    marker='## Estensione annuale classifiche 2024 — 2026-10-04'
    if marker not in text:
        text+='\n'+marker+'\n\nL’utente ha confermato TSK-0046, `BGG-A - Classifiche BGG 2024`, incremento annuale circoscritto ai risultati e votazioni dei contest con roster esistente. Provenienza e confronto con baseline per contest; completezza della verifica separata dalla presenza in classifica. Roster aggiuntivi, WIP, materiali, host esterni e download esclusi. Le challenge senza roster restano dipendenza del censimento. Contratto: `tasks/2026-10-04 - BGG-A - Classifiche BGG 2024/TASK.md`. PWS invariato a 1.5.0.\n'
        path.write_text(text,encoding='utf-8')
progress=ROOT/'PROJECT_PROGRESS.md'; text=progress.read_text(encoding='utf-8')
note='- 2026-10-04 — TSK-0046 Classifiche 2024: conclusa riconciliazione delle liste ufficiali di 11 contest; importati 869 risultati. PnP 225/381 (59,06%), adiacenti 14/28 (50%); confronto esplicito completato per tutte le 409 entry. Sei challenge senza roster escluse. Backup, integrità, chiavi esterne e importazione idempotente verificati. Evidenze nel task dedicato; sezioni A/B rigenerate. Prossimo approfondimento solo su nuove tabelle ufficiali/rettifiche.'
if note not in text: progress.write_text(text.rstrip()+'\n\n'+note+'\n',encoding='utf-8')
state=ROOT/'.workspace/PROJECT_STATE.md'; text=state.read_text(encoding='utf-8')
note='TSK-0046: estensione annuale circoscritta classifiche BGG 2024 confermata il 2026-10-04; risultati e confronto con roster esistente, senza WIP/materiali/download. Completezza del lavoro distinta dai piazzamenti; contratto e verifica nel task dedicato. Nessuna variazione della versione PWS 1.5.0.'
if note not in text: state.write_text(text.rstrip()+'\n\n'+note+'\n',encoding='utf-8')
print(json.dumps({'checked_contests':len(checks),'observations':len(rows),'ranked_entries':sum(c['ranked_entries'] for c in checks)}))
