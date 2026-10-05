# 2026-10-05 - MAT - 24 Hour Design Challenge PATCH 2025

ID: TSK-0063. Apertura 2026-10-05. Stato: completato.

## Contratto

Un solo contest: 299, 12 entry. Censimento first_post_only dei post introduttivi originali degli autori, WIP o presentazioni nel thread quando ammesso. URL dichiarati e requisiti con fonte/data/esito; esclusi host esterni, file/download, risposte successive, roster e classifiche. Skill base BGG e bgg-material-census obbligatorie. Evidenze e importazione riproducibile provata su copia; database operativo e file condivisi gestiti dal coordinamento TSK-0059. Nessun commit autonomo. Successo: tutte le entry con esito esplicito, storia preservata, isolamento e idempotenza verificati.

## Incremento 2026-10-05

Ripresa del task già assegnato nel registro, senza nuovo ID. Preflight ordinario riuscito: posizione workspace, Git e lettura locale; browser inizializzato su about:blank. PWS canonico e aligned_version entrambi 1.5.0; letti README e principi dello Standard in sola lettura. AGENTS.md, PROJECT.md, governance, inventario, skill bgg-contest-navigation e bgg-material-census e playbook applicati; modello GUARD e serializer 54-Card ispezionati senza eseguirne le importazioni operative. Titolo visibile conforme verificato e impostato. Git main ahead 1 rispetto al riferimento origin/main, working tree con modifiche di altre attività: preservate; nessuno staging/commit/push.

Roster ufficiale articolo 46608341 riconciliato con roster locale e 12 entry SQLite del contest 299. Post iniziale dell'organizzatore conferma WIP facoltativo e presentazioni originali valide. Lettura completa dei post introduttivi su tre pagine; nessuna risposta successiva usata. Zero-Day Triage ha un gg-item-link inizialmente #, risolto dopo navigazione al post nel viewport: WIP 3577423, primo articolo originale 46617446 di David McDougal letto integralmente. Riferimento inverso al contest risolto dopo scorrimento e nuovo snapshot. Le altre 11 presentazioni sono gli originali degli autori direttamente collegati dal roster.

Risultato: **12/12 esiti completi first_post_only**, 10 entry con risorse dichiarate, 12 associazioni entry–URL e 12 URL unici globali, 26 requisiti espliciti. Patch-22 e Picking Pumpkins hanno none_declared per collegamenti materiali; solo Picking Pumpkins none_declared per requisiti testuali. Zero WIP non trovati e zero not_observable. Nessuna disponibilità attestata, tutti gli host/file esterni non aperti. Nessun download o modifica di materiali originali.

Limiti: Picking Pumpkins include immagine BGG con alt Gamesheet r4, ma nessuna istruzione operativa esplicita di stampa nel testo; immagine esclusa secondo skill, non aperta. Regole dichiarate non finite in tempo: stato preservato. Mishi's Bedtime: token per giocatore, dado solo solitario; non inferita lingua dal nome PDF. Patch Monsters: working title e cronologia Hour 1/9/23 preservati, intenzioni provvisorie non trattate come inventario finale. Zero-Day: v0.5/v1.0 e refuso 2025-90-16 preservati. Quantità/fornitura non esplicite restano null/unspecified; tassonomia provvisoria.

La revisione automatica del browser ha restituito errori transitori «Selected model is at capacity». Le azioni fallite non furono eseguite; riprese attraverso lo stesso controllo, senza cambio impostazioni o aggiramento. Navigazione e tutte le letture richieste successivamente riuscite, nessun blocco residuo. Primo test offline ha intercettato supply_mode unknown non ammesso dallo schema: corretto a unspecified e ripetuta intera prova su nuova copia dal database in mode=ro.

## Verifiche

- DOM_WITNESS.json: trascrizione delle identità, timestamp, link esatti e label degli output DOM CUA; estratti minimi dei requisiti, assenza media incorporati ed esclusioni. Non è copia dell'intero testo delle regole.
- ROSTER_BASELINE.json: 12 record dal database aperto mode=ro; titoli e posizioni riconciliati con roster e witness ufficiale.
- Copia privata outputs/2025-patch-materials/verification.sqlite3 mediante SQLite backup dalla connessione mode=ro. Nessuna connessione di scrittura al database operativo nello script.
- integrity_check ok, foreign_key_check vuoto. Confronto di tutte le tabelle: righe storiche conservate, altri contest/classifiche/acquisizioni invariati; solo wip_thread_url NULL delle entry bersaglio aggiornabile.
- Due applicazioni del SQL sulla copia: snapshot identici dopo la seconda, idempotenza verificata. URL, requisiti e stati per ciascuna entry verificati contro dataset/witness.
- Aggiunte sulla copia: 12 remote_resources, 12 scansioni risorse, 12 menzioni, 12 osservazioni remote, 12 scansioni materiali, 26 requisiti, 12 attestazioni complete.

VERIFICATION.json conserva conteggi, hash SQL e controlli. Lo script rigenera solo i file dedicati e la copia; non offre --apply operativo.

## File del lotto

- catalog/build_2025_patch_materials.py
- catalog/2025-patch-materials.sql
- sources/2025-PATCH-MATERIALS.md
- Questo TASK.md, DOM_WITNESS.json, EVIDENCE.json, ROSTER_BASELINE.json, VERIFICATION.json nella cartella TSK-0063.
- outputs/2025-patch-materials/verification.sqlite3 è rigenerabile ed escluso da Git.

## Comandi per il coordinatore TSK-0059

Dalla radice del progetto, riprodurre preparazione e prova privata:

```powershell
& 'C:/Users/39348/.cache/codex-runtimes/codex-primary-runtime/dependencies/python/python.exe' catalog/build_2025_patch_materials.py
```

Solo al momento dell'integrazione seriale, dopo backup coordinato del database operativo (comando seguente **non eseguito da questa chat**):

```powershell
@'
import sqlite3
from pathlib import Path
with sqlite3.connect("database/pnp_collection.sqlite3") as db:
    db.executescript(Path("catalog/2025-patch-materials.sql").read_text(encoding="utf8"))
    assert db.execute("pragma integrity_check").fetchall() == [("ok",)]
    assert not db.execute("pragma foreign_key_check").fetchall()
'@ | & 'C:/Users/39348/.cache/codex-runtimes/codex-primary-runtime/dependencies/python/python.exe' -
```

La prova privata può essere ripetuta dopo integrazione per riconfermare idempotenza e conteggi. Il coordinatore aggiorna serialmente REGISTRY.json, PROJECT_PROGRESS.md e catalog/README.md, rigenera sezioni A/B, registra l'integrazione e gestisce il commit finale autorizzato. Nessun file condiviso modificato da questa chat.

Prossimo passo utile: integrare il lotto da TSK-0059. Un eventuale ACQ resta task del solo PATCH con selezione esplicita e verifica condizioni/host; nessun monitoraggio ordinario del contest concluso. Lavoro MAT pronto; integrazione operativa e chiusura centrale ancora da registrare dal coordinatore.

## Chiusura dopo integrazione — 2026-10-05

Stato: completato. TSK-0059 ha integrato il SQL dopo prova su copia e backup con SHA-256; integrità/FK, conservazione della storia, isolamento e idempotenza verificate. Funzioni API verificate per 12/12 entry. Registro e A/B del cruscotto aggiornati prima della chiusura. Evidenza: TSK-0059/PATCH_INTEGRATION.json. Commit finale autorizzato e in preparazione; nessun push.
