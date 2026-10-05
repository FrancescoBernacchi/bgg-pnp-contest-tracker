# 2026-10-05 - MAT - 24 Hour Design Challenge GREEN 2025

ID: TSK-0061. Apertura 2026-10-05. Stato: completato.

## Contratto

Un solo contest: 297, 8 entry. Censimento first_post_only dei post introduttivi originali degli autori, WIP o presentazioni nel thread quando ammesso. URL dichiarati e requisiti con fonte/data/esito; esclusi host esterni, file/download, risposte successive, roster e classifiche. Skill base BGG e bgg-material-census obbligatorie. Evidenze e importazione riproducibile provata su copia; database operativo e file condivisi gestiti dal coordinamento TSK-0059. Nessun commit autonomo. Successo: tutte le entry con esito esplicito, storia preservata, isolamento e idempotenza verificati.

## Apertura e riferimenti — 2026-10-05

Ripreso l'ID già predisposto dal coordinatore TSK-0059, senza nuovo task né modifica del registro centrale. Input: `catalog/2025-24h-challenge-rosters-2026-10-04.json`, contest 297, otto entry; database operativo aperto esclusivamente `mode=ro` e `query_only`. Letti AGENTS.md, PROJECT.md, TASK_GOVERNANCE.md, stato PWS, README e principi dello Standard canonico, inventario skill, base bgg-contest-navigation, specializzazione bgg-material-census e playbook. Modello tecnico GUARD TSK-0058 e serializzatore TSK-0053 ispezionati: non riusata la parte GUARD che scrive automaticamente nell'operativo.

Preflight ordinario riuscito: percorso del workspace, lettura locale e `git status --short --branch`; PWS locale/canonico entrambi 1.5.0. Working tree con modifiche preesistenti e concorrenti; main ahead 1 rispetto al riferimento locale origin/main. Non effettuati fetch, commit, push o staging. Titolo visibile impostato alla convenzione di questo TASK. CUA inizializzato su about:blank; transizione automatica della verifica Cloudflare, senza interventi o aggiramenti, poi accesso pubblico BGG riuscito. Tab temporaneo chiuso.

## Metodo e risultati

[Roster ufficiale](https://boardgamegeek.com/thread/3510376/article/46069059#46069059), autore @UberDante, 11 mag 2025 (edited). Otto destinazioni già risolte: nessun gg-item-link non risolto e nessun fallback necessario. Le regole ufficiali del primo post consentono un WIP separato ma non lo richiedono. Le presentazioni originali degli autori collegate direttamente dal roster costituiscono quindi il primo post del gioco nel perimetro di queste challenge; non usati annunci iniziali, progressi precedenti o successive risposte, anche quando presenti nella stessa pagina renderizzata.

Otto post originali letti integralmente sulle due pagine del thread, con autore, username e timestamp. Body, anchor e iframe/video/source controllati; nessun media incorporato né link dinamico nei post selezionati. Roster, corpo integrale, URL/etichette e header riconciliati con impronte FNV rilevate in CUA. Le date originali sono preservate come testo BGG e la verifica è datata 2026-10-05.

| Dimensione | Esito |
|---|---:|
| Entry riconciliate / esiti completi | 8 / 8 |
| Post originali distinti | 8 |
| Entry con risorse dichiarate | 8 |
| URL distinti / menzioni | 16 / 16 |
| Requisiti dichiarativi | 14 |
| Requisiti observed / none_declared | 7 / 1 |
| WIP non trovato / not_observable | 0 / 0 |

Fruit Tumbler dichiara un file ma nessun requisito sufficientemente esplicito: risorse observed, materiali none_declared; non significa assenza di materiali nel gioco. Il ruolo game_files resta provvisorio. Shipmates include un sell sheet reference e un adattamento digitale ancora da finire senza URL; Cash Crop include un video tutorial/gameplay. Nessuno di questi elementi genera requisiti fisici. I due `[link]` di Flag Finish restano distinti per URL e contesto. Nessun mazzo, quantità, formato pagina o montaggio dedotto da meccaniche, nomi, estensioni o post precedenti. Tutte le quantità restano null; nessun host esterno/file aperto o download, disponibilità e condizioni non verificate.

## Verifiche

`catalog/build_2025_green_materials.py` genera EVIDENCE, baseline, SQL e relazione; apre il sorgente in sola lettura e applica SQL soltanto a `outputs/2025-green-materials/verification.sqlite3`. Nessuna opzione di importazione automatica sull'operativo. Due esecuzioni complete riuscite; ciascuna include applicazione doppia su copia e uguaglianza dello snapshot dopo la seconda applicazione.

- Corpo integrale, identità/header e URL/etichette: 8/8 impronte DOM corrispondenti; roster 8/8 con titoli/autori/ordine e fonte locale.
- Integrità SQLite `ok`, nessuna violazione delle chiavi esterne.
- Copia privata: aggiunti 16 remote_resources, 8 entry_resource_scans, 16 entry_resource_mentions, 16 remote_resource_observations, 8 entry_material_scans, 14 entry_material_requirements e 8 entry_work_observations; compilati 8 wip_thread_url prima null.
- Righe preesistenti preservate, inclusi tutti i campi delle entry salvo compilazione dei WIP null del solo GREEN; altre entry, contest, roster, classifiche, acquisizioni e tutte le tabelle non pertinenti identici.
- Seconda applicazione idempotente; vincoli, unicità, URL, ruoli, contesti e quantità riconciliati con il dataset.
- SQL SHA-256: `dbafa5d4326f9696bf58989f731230c960fff45afa1e97fec9798f574237d1f7`.
- Script concluso senza scritture al database operativo. `VERIFICATION.json` riporta modalità ro/query_only e operational_import false. Riferimenti Git controllati sui soli file dedicati; tutti nuovi, nessuno aggiunto allo staging.

## File consegnati

- `catalog/build_2025_green_materials.py`
- `catalog/2025-green-materials.sql`
- `sources/2025-GREEN-MATERIALS.md`
- Questo `TASK.md`
- `DOM_WITNESS.json`
- `ROSTER_BASELINE.json`
- `EVIDENCE.json`
- `VERIFICATION.json`

La copia privata in outputs è rigenerabile ed esclusa da Git. Non modificati REGISTRY.json, PROJECT_PROGRESS.md, catalog/README.md, AGENTS.md, database operativo o file di altri task.

## Comandi esatti per il coordinatore

Da PowerShell nella radice del progetto, rigenerazione SQL ed evidenze con prova privata (nessuna scrittura all'operativo):

```powershell
$pyGreen = 'C:\Users\39348\.cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe'
& $pyGreen catalog/build_2025_green_materials.py
```

Integrazione seriale riservata a TSK-0059 dopo la propria verifica: backup non sovrascrivibile, SQL verificato con hash, importazione e verifiche di isolamento/idempotenza anche sull'operativo. Questo comando è documentato, NON eseguito da TSK-0061:

```powershell
@'
import hashlib, json, sqlite3, sys
from pathlib import Path
sys.path.insert(0, str(Path('catalog').resolve()))
import build_2025_green_materials as green
sqlpath = Path('catalog/2025-green-materials.sql')
proof = json.loads((green.TASK/'VERIFICATION.json').read_text(encoding='utf8'))
assert hashlib.sha256(sqlpath.read_bytes()).hexdigest() == proof['sql_sha256']
rows = json.loads((green.TASK/'EVIDENCE.json').read_text(encoding='utf8'))['entries']
dbpath = Path('database/pnp_collection.sqlite3')
backup = Path('outputs/2025-green-materials/before-integration.sqlite3')
assert not backup.exists(), 'Non sovrascrivere un backup precedente'
with sqlite3.connect(dbpath.resolve().as_uri()+'?mode=ro', uri=True) as src, sqlite3.connect(backup) as dst:
    src.backup(dst)
with sqlite3.connect(backup.resolve().as_uri()+'?mode=ro', uri=True) as db:
    assert db.execute('pragma integrity_check').fetchall() == [('ok',)]
with sqlite3.connect(dbpath) as db:
    before = green.snapshot(db)
    db.executescript(sqlpath.read_text(encoding='utf8'))
    after = green.snapshot(db)
    green.isolation(before, after, db, rows)
    green.check_import(db, rows)
    db.executescript(sqlpath.read_text(encoding='utf8'))
    assert green.snapshot(db) == after
print('GREEN: integrazione, integrita, isolamento e idempotenza verificati')
print('Backup SHA-256:', hashlib.sha256(backup.read_bytes()).hexdigest())
'@ | & $pyGreen -
```

Coordinatore: registrare backup/importazione, aggiornare registro centrale e catalog/README, rigenerare A/B del cruscotto con `app/generate_project_progress.py` e chiudere formalmente questo task dopo integrazione. Commit finale solo dal coordinamento autorizzato. Nessuna chiusura operativa anticipata.

## Prossimo passo utile e limiti

Integrare serialmente il SQL in TSK-0059. Eventuale ACQ del solo GREEN dopo selezione esplicita dei giochi, verifica delle condizioni e degli host. Nessun monitoraggio ordinario del contest concluso. La copertura first_post_only è completa per il contratto MAT, non attesta contenuto o disponibilità dei materiali. Nessun nuovo pattern da promuovere nei file skill condivisi.

## Chiusura dopo integrazione — 2026-10-05

Stato: completato. TSK-0059 ha integrato il SQL dopo prova su copia e backup con SHA-256; integrità/FK, conservazione della storia, isolamento e idempotenza verificate. Funzioni API verificate per 8/8 entry. Registro e A/B del cruscotto aggiornati prima della chiusura. Evidenza: TSK-0059/GREEN_INTEGRATION.json. Commit finale autorizzato e in preparazione; nessun push.
