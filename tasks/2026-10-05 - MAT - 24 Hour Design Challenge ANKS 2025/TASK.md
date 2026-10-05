# 2026-10-05 - MAT - 24 Hour Design Challenge ANKS 2025

ID: TSK-0064. Apertura 2026-10-05. Stato: completato.

## Contratto

Un solo contest: 298, 8 entry. Censimento first_post_only dei post introduttivi originali degli autori, WIP o presentazioni nel thread quando ammesso. URL dichiarati e requisiti con fonte/data/esito; esclusi host esterni, file/download, risposte successive, roster e classifiche. Skill base BGG e bgg-material-census obbligatorie. Evidenze e importazione riproducibile provata su copia; database operativo e file condivisi gestiti dal coordinamento TSK-0059. Nessun commit autonomo. Successo: tutte le entry con esito esplicito, storia preservata, isolamento e idempotenza verificati.

## Incremento 2026-10-05

Preflight ordinario riuscito: posizione, git status e lettura locale; browser IAB inizializzato su about:blank. PWS consumer e canonico entrambi 1.5.0. Main avanti di un commit e numerose modifiche condivise preesistenti: nessuna operazione Git svolta. Titolo visibile reso conforme. Letti PROJECT.md, inventario, skill base/materiali e playbook; modello GUARD ispezionato, senza riutilizzare la sua importazione automatica all'operativo.

Roster ufficiale articolo 46858357: otto associazioni originali risolte (46860893, 46916976, 46915525, 46940111, 46944051, 46956895, 46993380, 47044720). Regole del contest articolo 46858356 dichiarano WIP facoltativo e presentazione nel thread. Per Ankhs, la presentazione 46916976 dell'autore collega il WIP 3614854: primo post originale 46916910, autore Noah Charles, 20 nov 2025 (edited). Gli altri sette post originali sono le presentazioni del roster. Testo completo letto in CUA, anchor e media estratti dal DOM renderizzato; nessun iframe/video/source nei post selezionati. Autori e timestamp conservati in EVIDENCE.json. Nessuna risposta successiva usata e nessuna destinazione esterna/file aperta.

### Risultati e limiti

- 8/8 esiti completi; 8 post originali, 7 entry con risorse, 9 URL distinti, 21 requisiti espliciti.
- Gee, Thanks!: nessun URL materiali dichiarato, regole nel testo e mazzo tradizionale senza joker esplicito.
- Planks & Piers: cartella dichiarata, ma 18 carte e possibile pedina appartengono al progetto iniziale; proposta conservata senza attestarla come requisito finale. Materiali `none_declared` riguarda requisiti finali espliciti, non l'assenza di componenti.
- Pip Blanks: anchor WIP ordinario con href #, rimasto tale dopo messa a fuoco e click; click conduce alla home BGG. Ispezione outerHTML conferma anchor ordinario e nessuna destinazione risolta. Fallback web mirato sul solo titolo senza risultato pertinente. `dedicated_wip_status=not_found`, distinto da fonte introduttiva `found`: presentazione originale completa con regolamento/griglia e quattro requisiti.
- Crank: sette quantità separate; Here/Aquí e nomi dei PDF non utilizzati per dedurre contenuti o lingue. Lost Ranks: regolamento esplicito, nessun mazzo inferito dal trick-taking.
- Nessun `not_observable`: fonti originali leggibili. Disponibilità esterna non verificata, categorie provvisorie, copertura first_post_only.

### Verifiche

Script offline con database sorgente aperto `mode=ro`, SQLite backup su outputs/2025-anks-materials/verification.sqlite3. SQL applicato e riapplicato sulla copia: integrità ok, foreign key ok, idempotenza, conservazione righe pregresse, isolamento degli altri contest e delle tabelle non pertinenti verificati. Coerenza 8 titoli/posizioni col roster e 8 attestazioni materiali, requisiti per fonte verificati. Primo test ha individuato supply_mode non ammesso `digital`, corretto in `unspecified`; prova finale superata. SQL SHA256 in VERIFICATION.json. Nessuna scrittura sul database operativo, registro/cruscotto o file condivisi.

### File e comandi di integrazione

File dedicati: catalog/build_2025_anks_materials.py; catalog/2025-anks-materials.sql; sources/2025-ANKS-MATERIALS.md; questo TASK.md; DOM_WITNESS.json; EVIDENCE.json; ROSTER_BASELINE.json; VERIFICATION.json. DOM_WITNESS trascrive l'estrazione CUA compatta: post, autore, data, lunghezza testo, URL/etichette pertinenti e media; confronto automatico 8/8 con evidenze serializzate. Copia di verifica rigenerabile sotto outputs/2025-anks-materials, esclusa da Git.

Riproduzione (PowerShell dalla radice):

```powershell
& 'C:\Users\39348\.cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe' catalog/build_2025_anks_materials.py
```

Il comando produce SQL ed esegue soltanto prove su copia. Integrazione seriale riservata al coordinatore, dopo suo backup operativo:

```powershell
& 'C:\Users\39348\.cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe' -c "import sqlite3,pathlib; db=sqlite3.connect('database/pnp_collection.sqlite3'); db.executescript(pathlib.Path('catalog/2025-anks-materials.sql').read_text(encoding='utf8')); assert db.execute('pragma integrity_check').fetchall()==[('ok',)]; assert not db.execute('pragma foreign_key_check').fetchall(); db.close()"
```

Successivo aggiornamento seriale REGISTRY/PROJECT_PROGRESS/catalog README e commit affidati a TSK-0059. Eventuale prossimo approfondimento: ACQ del solo ANKS previa selezione esplicita e verifica condizioni/host; i componenti finali di Planks & Piers possono essere chiariti dalle regole in tale scope. Nessun monitoraggio ordinario del contest concluso. Nessuna nuova regola promossa alla skill condivisa, vietata la modifica dei file condivisi in questa delega.

## Chiusura dopo integrazione — 2026-10-05

Stato: completato. TSK-0059 ha integrato il SQL dopo prova su copia e backup con SHA-256; integrità/FK, conservazione della storia, isolamento e idempotenza verificate. Funzioni API verificate per 8/8 entry. Registro e A/B del cruscotto aggiornati prima della chiusura. Evidenza: TSK-0059/ANKS_INTEGRATION.json. Commit finale autorizzato e in preparazione; nessun push.
