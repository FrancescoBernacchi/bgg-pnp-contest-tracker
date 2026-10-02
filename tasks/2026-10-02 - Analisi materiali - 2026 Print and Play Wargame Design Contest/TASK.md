# Analisi materiali - 2026 Print and Play Wargame Design Contest

## Stato

- Apertura: 2026-10-02.
- Stato: concluso il 2026-10-02.
- Titolo Codex verificato: `2026-10-02 - Analisi materiali - 2026 Print and Play Wargame Design Contest`.
- PWS: `aligned_version` 1.5.0, uguale alla versione canonica 1.5.0.
- Git: checkout detached, working tree pulita all'avvio; commit e push autorizzati dall'utente dopo la chiusura sostanziale del task.

## Contratto

- Tipo standard: **Analisi materiali del contest**.
- Unità di lavoro: solo `2026 Print and Play Wargame Design Contest`.
- Input: snapshot concluso del 2 ottobre 2026 con 23 entry; thread ufficiale BGG; GeekList ufficiale 369157; WIP BGG associati alle 23 entry; database operativo primario.
- Fonti iniziali:
  - `https://boardgamegeek.com/thread/3627732/submissions-closed-2026-print-and-play-wargame-des`
  - `https://boardgamegeek.com/geeklist/369157/2026-wargame-design-contest-entries`
- Perimetro di osservazione per ogni WIP: primo `article.post` e relativo `.post-body` renderizzato, inclusi anchor, `gg-item-link`, iframe, video, source e requisiti materiali dichiarati testualmente.
- Esclusioni: apertura o verifica degli host esterni; download o acquisizione di file; lettura dei materiali remoti; lavoro su altri contest; consolidamento definitivo della tassonomia annuale.

## Deliverable

- Una scansione risorse e una scansione requisiti materiali per ciascuna delle 23 entry.
- Collegamenti dichiarati deduplicati per URL, conservando tutte le menzioni, etichette e funzioni osservate.
- Funzione dichiarata, forma tecnica provvisoria, evidenza, provenienza e data di osservazione per ogni risorsa.
- Requisiti materiali osservabili con testo originale, normalizzazione separata, quantità, obbligatorietà, approvvigionamento, contesto e copertura `first_post_only`.
- Stati distinti per WIP non individuato, risorse non osservabili, nessuna risorsa dichiarata e risorse dichiarate ma non verificate.
- Script SQL riproducibile nel catalogo, aggiornamento del database operativo e di `PROJECT_PROGRESS.md` se copertura o stato cambiano.

## Criteri di successo

- Copertura quantitativa: 23/23 entry ricondotte al roster ufficiale e classificate senza trasformare dati ignoti in assenze.
- Nessuna destinazione esterna aperta e nessun materiale scaricato.
- URL identici accorpati senza perdita delle diverse menzioni sorgente.
- Dati originali, normalizzazioni e inferenze conservati in campi distinti; informazioni volatili accompagnate da fonte e data.
- Script provato su copia del database prima dell'applicazione; `PRAGMA foreign_key_check` vuoto e `PRAGMA integrity_check = ok` dopo l'aggiornamento.
- Se la copertura cambia, sezioni generate A e B di `PROJECT_PROGRESS.md` rigenerate con `app/generate_project_progress.py`, parte qualitativa aggiornata e chiusura documentata con il successivo task utile.

## Metodo previsto

1. Usare il roster ufficiale già verificato come checklist completa di 23 entry.
2. Aprire ciascun WIP BGG, identificare il post originale e limitare l'estrazione al suo corpo renderizzato.
3. Risolvere soltanto i componenti dinamici interni alla pagina WIP; non navigare verso le destinazioni dichiarate.
4. Estrarre e classificare provvisoriamente collegamenti e requisiti materiali, conservando testo e contesto originali.
5. Registrare esplicitamente gli esiti negativi o non osservabili e verificare conteggi, associazioni e deduplicazione.
6. Preparare un incremento SQL riproducibile, verificarlo su copia, applicarlo al database operativo, rigenerare il cruscotto e chiudere il task.

## Evidenze e risultati

- Sessione BGG autenticata in Chrome; tutti i 23 URL WIP dello snapshot del 2 ottobre sono stati aperti direttamente dalla checklist ufficiale.
- Per ogni pagina è stato atteso il caricamento di `article.post` e osservato soltanto il primo `.post-body`; link al contest, immagini decorative e riferimenti esterni puramente contestuali sono stati esclusi.
- Copertura WIP: 23 `found`, 0 `not_found`, 0 `not_observable`.
- Risorse: 18 entry `observed`, 5 `none_declared`, 59 URL pertinenti univoci. Tutte le 59 osservazioni hanno `observation_kind=declared_in_wip` e `availability_status=not_checked`.
- Materiali: 12 entry `observed`, 11 `none_declared`, 48 requisiti con copertura `first_post_only`.
- Deduplicazioni conservative:
  - Warring Kingdoms: il documento delle regole è menzionato due volte con lo stesso URL; una risorsa conserva entrambe le descrizioni.
  - CYBERAIDER: pezzi di gioco e schede personaggio condividono lo stesso URL; l'etichetta conserva entrambe le menzioni.
  - Sitka ever lost: il quick rulebook è citato due volte con lo stesso URL; una sola risorsa conserva le due etichette.
- Dichiarazioni senza URL conservate nelle note: `PtP Files: Coming Soon` per Operation BARDSEA, `Denarii sheets — link TBD` per Gladiator e `TTS version Available` per Glières 1944.
- Registro dettagliato: `sources/2026-WARGAME-MATERIALS.md`.
- Incremento riproducibile: `catalog/2026-wargame-materials.sql`.

## Verifiche e chiusura

- Lo script è stato applicato prima a una copia e poi rieseguito due volte su una copia di idempotenza: conteggi invariati a 23 scansioni risorse, 59 menzioni, 23 scansioni materiali, 48 requisiti e 59 osservazioni dichiarative.
- Backup pre-aggiornamento: `C:\PROGETTI CODEX\Progetto PnP Collection\database\pnp_collection.pre-wargame-materials-20261002.sqlite3`.
- Database operativo aggiornato: `C:\PROGETTI CODEX\Progetto PnP Collection\database\pnp_collection.sqlite3`; SHA-256 finale `4AA4901CE8CAC5E9640DFD7B7C3C11A8B3405F56B3AC8504574B76B586DA2985`.
- Verifiche SQLite: `PRAGMA foreign_key_check` senza righe; `PRAGMA integrity_check = ok`.
- `PROJECT_PROGRESS.md` rigenerato nelle sezioni A e B e aggiornato nelle righe qualitative coinvolte; il contest mostra lettura materiali 23/23.
- Test applicazione: 17 test backend superati, 3 test sul database reale saltati perché il database non è presente nel worktree; 23 test frontend superati.
- Nessun host esterno aperto, nessun file di gioco scaricato o acquisito, nessun altro contest analizzato.
- Commit e push autorizzati dall'utente il 2026-10-02; l'esito e l'identificativo finale vengono verificati e comunicati al termine dell'operazione.

Il task è concluso secondo il contratto. Il successivo task utile per questo stesso contest è **Acquisizione materiali - 2026 Print and Play Wargame Design Contest**, ma soltanto dopo una selezione esplicita delle entry e la verifica di liceità, condizioni e disponibilità degli host. In parallelo, il monitoraggio già pianificato resta separato e prevede il prossimo controllo il 12 novembre 2026.
