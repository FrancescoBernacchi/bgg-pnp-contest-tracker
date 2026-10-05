# 2026-10-05 - MAT - 24 Hour Design Challenge REVEAL 2025

ID: TSK-0060. Apertura 2026-10-05. Stato: completato.

## Contratto

Un solo contest: 296, 6 entry. Censimento first_post_only dei post introduttivi originali degli autori, WIP o presentazioni nel thread quando ammesso. URL dichiarati e requisiti con fonte/data/esito; esclusi host esterni, file/download, risposte successive, roster e classifiche. Skill base BGG e bgg-material-census obbligatorie. Evidenze e importazione riproducibile provata su copia; database operativo e file condivisi gestiti dal coordinamento TSK-0059. Nessun commit autonomo. Successo: tutte le entry con esito esplicito, storia preservata, isolamento e idempotenza verificati.

## Incremento 2026-10-05

Preflight sandbox riuscito: posizione, Git, lettura locale, browser neutro e BGG. PWS canonico e allineamento entrambi 1.5.0. Letti AGENTS.md, PROJECT.md, inventario, base BGG, playbook, specializzazione MAT e modello GUARD. Titolo visibile conforme. Ripreso ID predisposto senza allocazioni. Main ahead 1 e modifiche pregresse presenti: nessuna operazione Git eseguita.

Letti integralmente i sei post introduttivi originali degli autori collegati dal roster articolo 45765525. Il post 45765523 dichiara WIP facoltativo. URL risolti e riconciliati: 45784115, 45826419, 45830622, 45846664, 45882504, 45930400. Tutti gli autori/profili e timestamp verificati nel DOM renderizzato. Roster Krasimir Savov corrisponde al profilo @coblin ora Coblin King; BlueChicken al profilo omonimo ora J de K; valori originali preservati separatamente. Nessuna modifica identità canonica.

Risultato: 6/6 complete, 6 post originali, 6 entry con risorse, 11 URL unici e associazioni, 18 requisiti. Tutti found/observed; nessun none_declared o not_observable. Nessun contenuto delle risposte usato. Immagine Intent decorativa esclusa; brainstorming di Shuffle & Sleuth distinto dalle carte pubblicate, alternative Clue conservate con probably. House Run scartato nel primo post, inventario riferito soltanto a Dungeon Encounter. Soluzione What Happened censita come player_aid provvisorio, senza apertura.

## Deliverable dedicati

- `catalog/build_2025_reveal_materials.py`
- `catalog/2025-reveal-materials.sql`
- `sources/2025-REVEAL-MATERIALS.md`
- nel task: `EVIDENCE.json`, `DOM_WITNESS.json`, `ROSTER_BASELINE.json`, `VERIFICATION.json`, questo `TASK.md`.
- output escluso Git: `outputs/2025-reveal-materials/verification.sqlite3`.

Il DOM witness conserva identità, date ISO, URL/etichette, assenza media incorporati e fingerprint FNV del testo completo osservato, senza riprodurre integralmente post di terzi. Le citazioni dichiarative sono nel dataset. Funzioni e forme tecniche provvisorie; disponibilità e contenuti dei file sconosciuti. Nessun host esterno/file aperto né download. Primo post soltanto: non equivale a distinta verificata nelle regole.

## Verifiche e riproduzione

Eseguito dalla radice progetto:

```powershell
& 'C:\Users\39348\.cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe' catalog/build_2025_reveal_materials.py
```

Il comando produce SQL/evidenze/relazione e prova soltanto su copia privata; parametro `--database` facoltativo per baseline alternativa, sempre aperta con mode=ro. Non ha opzione di applicazione automatica all'operativo. Prima prova ha rilevato supply_mode non ammesso per alternativa Clue; corretto a specialized, mantenendo testo originale. Seconda prova superata: integrity_check ok, foreign_key_check vuoto, tutte 6 attestazioni, URL e requisiti esatti, righe originarie preservate, entry non pertinenti e tutte altre tabelle/contest isolate, seconda applicazione identica alla prima. SQL SHA256 in VERIFICATION.json.

Integrazione seriale riservata al coordinatore, dopo suo backup e controlli complessivi:

```powershell
& 'C:\Users\39348\.cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe' -c "import sqlite3,pathlib; db=sqlite3.connect('database/pnp_collection.sqlite3'); db.executescript(pathlib.Path('catalog/2025-reveal-materials.sql').read_text(encoding='utf8')); assert db.execute('pragma integrity_check').fetchall()==[('ok',)]; assert not db.execute('pragma foreign_key_check').fetchall(); db.close()"
```

Database operativo non modificato da questo task. REGISTRY, PROJECT_PROGRESS, catalog/README, AGENTS e file condivisi non modificati. Coordinatore deve aggiornare registri/cruscotto dopo integrazione e gestire commit finale. Nessun messaggio ad altre chat.

## Prossimo passo

TSK-0059 integra il SQL e chiude dopo controllo complessivo. Eventuale ACQ del solo REVEAL richiede selezione esplicita e verifica condizioni/host; nessun monitoraggio ordinario del contest concluso.

## Chiusura dopo integrazione — 2026-10-05

Stato: completato. Il coordinatore TSK-0059 ha integrato il SQL nel database operativo dopo prova su copia e backup con SHA-256. Integrità/FK, conservazione della storia, isolamento e idempotenza verificati; funzioni API dell'app verificate per 6/6 entry. Evidenza: TSK-0059/REVEAL_INTEGRATION.json. Registro e A/B del cruscotto aggiornati prima della chiusura. Commit finale del lotto autorizzato e in preparazione; nessun push.
