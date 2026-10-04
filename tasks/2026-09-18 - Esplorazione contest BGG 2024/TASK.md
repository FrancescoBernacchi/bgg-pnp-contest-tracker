# Esplorazione contest BGG 2024

## Ripresa autorizzata — 2026-10-04

ID stabile: TSK-0015. La nuova chat `01a1069c-78b1-7042-bfad-2bd049fb50bd`, titolo `2026-10-04 - BGG-A - Contest BGG 2024`, prosegue questo registro aperto senza duplicarlo. L'utente chiede di portare al 100% la barra verde del 2024: obiettivo dell'incremento sono i roster dei 10 contest `pnp_core` attualmente nel database. I 7 contest adiacenti restano separati; la precedente esclusione delle challenge descrive il perimetro storico e non cambia la loro classificazione attuale.

Categoria BGG-A, modalità circoscritto, cadenza su richiesta, stato in corso. Deliverable: roster verificati e import riproducibile per i 9 contest PnP ancora privi di entry, provenienza e anomalie datate, verifica su copia prima dell'importazione, integrità e chiavi esterne, rigenerazione delle sezioni annuali A/B e controllo della copertura 10/10. Il 100% della barra misura contest con entry censite; la completezza dei roster sarà verificata separatamente, senza trattare una singola entry come censimento completo. WIP, materiali, classifiche autonome, host esterni e download sono esclusi.

Preflight riuscito; PWS locale e canonico 1.5.0. Working tree su main con modifiche pregresse di governance e Classifiche 2025, preservate; nessuna operazione Git autorizzata. Baseline: PnP 1/10, 29 entry; adiacenti 1/7, 28 entry. Fonte tecnica: database operativo `database/pnp_collection.sqlite3`.

## Tipo di attività

Censimento annuale delle entry — anno 2024.

## Scope

Identificare i contest BGG 2024 compresi nel perimetro del progetto e censire il roster completo delle entry di ciascun contest: titolo, autore, stato, posizione quando pubblicata, URL BGG e appartenenza al contest.

Sono escluse da questo task la lettura dei WIP, il censimento delle risorse e dei requisiti materiali, la verifica degli host esterni e qualsiasi download. Queste attività potranno essere aperte successivamente in task di analisi o acquisizione dedicati a un singolo contest.

## Input e fonti previste

- BoardGameGeek come fonte iniziale autorevole.
- `PROJECT.md`, `AGENTS.md` e skill locale `.agents/skills/bgg-contest-navigation/`.
- Schema/database e pattern dei censimenti annuali già completati, se necessari per mantenere coerenza.

## Deliverable

- Elenco dei contest 2024 inclusi, con fonte e data di verifica.
- Roster completo delle entry per ogni contest incluso.
- Registrazione delle anomalie, degli scarti e del grado di completezza.
- Aggiornamento delle fonti/catalogo/database e di `PROJECT_PROGRESS.md` soltanto se l'incremento modifica effettivamente la copertura o i conteggi.
- Nota finale con i successivi task conformi per l'analisi dei materiali dei singoli contest.

## Criteri di successo

- Ogni entry è associata a un contest 2024 e a una fonte BGG verificabile.
- I conteggi estratti sono confrontati con quelli pubblicati o ricostruiti dalla fonte autorevole.
- Titoli, autori, stati, posizioni e URL sono conservati senza sostituire i valori originali con sole normalizzazioni.
- Nessun WIP, risorsa, host esterno o materiale viene analizzato o acquisito in questo task.

## Stato

In corso.

## Primo rilevamento — 2026-09-18

La GeekList globale BGG ha identificato 11 contest annuali 2024, item 155–165. L'item 166, relativo alle challenge bimestrali da 24 ore, è stato escluso perché episodico e non omogeneo con le edizioni annuali. Le fonti primarie dei thread sono state registrate in `sources/2024-CONTEST-COVERAGE.md`.

Non sono stati aperti WIP individuali, risorse, host esterni o materiali. Resta da estrarre e verificare il roster completo di ciascuno degli 11 contest.

### Incremento 1 — In-Hand 2024

Dal post iniziale del thread BGG sono state estratte 24 entry operative, 5 ritirate e 7 squalificate. Il roster completo e i collegamenti di provenienza sono in `sources/2024-IN-HAND-ROSTER.md`. Gli URL non sono stati aperti: sono stati conservati soltanto come evidenza di appartenenza al roster.

### Incremento 2 — Contest 156–160

Sono state verificate le cinque fonti primarie successive e i conteggi pubblicati: Two Player (29), 9-Card (32), Children & Family (29), Solomode (28) e 1-Card (54). L'estrazione dei titoli dai post dei thread è stata bloccata da una verifica anti-bot Cloudflare, non aggirata. Fonti e stato sono registrati in `sources/2024-ROSTER-STATUS-PART-2.md`; i cinque roster nominali restano da completare.

## Stato di chiusura

Il task non è chiudibile come censimento annuale completo: risultano completati il perimetro dei 11 contest e il roster nominale In-Hand, mentre per gli altri 10 contest sono disponibili fonti e conteggi ma non l'elenco completo delle entry. Non sono stati effettuati WIP, verifiche host o download.

Il punto 1 è parzialmente sbloccato: la navigazione normale ha reso nuovamente accessibili alcuni thread e ha permesso di individuare tre GeekList ufficiali. Restano da completare l'accumulo delle pagine progressive e i roster privi di GeekList direttamente collegata. I punti 2–5 restano sospesi fino alla disponibilità dei roster completi, come richiesto dal workflow del progetto.

Aggiornamento: l'accumulo progressivo ha ora coperto tutti i titoli delle GeekList Children & Family (29), Solomode (28) e 1-Card (54). Prima di considerarli roster operativi occorre ancora associare a ogni titolo autore e URL BGG; Two Player e 9-Card richiedono ancora una fonte roster completa analoga.

Ripresa sessione: per Children & Family sono state verificate le prime 25 triplette titolo–autore/username–URL BGG direttamente dai contenitori DOM degli item. Restano i quattro item finali e la stessa verifica per Solomode e 1-Card.

Passo successivo completato: la pagina 2 ha fornito e verificato le entry 26–29. Children & Family 2024 è ora completo a livello di titolo, autore/username, stato testuale e URL BGG. Restano da normalizzare Solomode e 1-Card, oltre a reperire i roster completi di Two Player e 9-Card.

Solomode 2024 è ora completo: 28 entry verificate sulle due pagine della GeekList ufficiale, con titolo, autore/username, stato testuale e URL BGG. Il prossimo contest è 1-Card 2024.

## Audit della ripresa — 2026-09-19

La ripresa ha distinto le osservazioni di navigazione dai dati realmente persistiti. Il database operativo era presente e integro (`PRAGMA integrity_check = ok`, nessuna violazione delle chiavi esterne), ma tutti i contest 2024 avevano ancora zero entry: le precedenti note di completezza per Children & Family e Solomode descrivevano soltanto osservazioni nel browser e non un censimento importato. La dichiarazione relativa a Solomode resta quindi da ricostruire in un artefatto verificabile prima dell'importazione.

### Incremento verificato — Children & Family

Le due pagine della GeekList ufficiale 329968 sono state riesaminate integralmente. Sono state confermate 29 posizioni distinte, con titolo, thread BGG, item GeekList e submitter ricavato dal profilo BGG. L'import ripetibile è in `catalog/2024-children-family-entries.sql`.

La procedura è stata prima applicata a una copia del database e poi al database operativo. Esito: 29 entry, posizioni 1–29 senza lacune, 29 osservazioni storiche, integrità SQLite valida e zero violazioni delle chiavi esterne. In conformità al perimetro annuale, non sono stati aperti i thread WIP né censiti risorse, host o requisiti materiali.

Prossima unità di lavoro: ricostruire e importare Solomode 2024 dalla GeekList ufficiale, senza assumere come persistita la precedente osservazione del browser.

### Incremento verificato — Solomode

La GeekList ufficiale 332839 è stata riesaminata sulle due pagine. Sono state confermate 28 entry con posizioni 1–28, item GeekList, thread BGG e submitter associato al profilo. Le due voci dal titolo generico `Unofficial Solo Mode Contest Entry` sono state disambiguate mediante il gioco base e il testo della rispettiva scheda come `Forest Shuffle Automa` e `Harmonies: Steve Automa`.

Tutte le entry sono state registrate come `dependent_variant` con dipendenza dal gioco base `required`; il profilo del contest è stato coerentemente aggiornato a `dependent_variants`. L'import ripetibile è generato da `catalog/build_2024_solomode_entries.py` in `catalog/2024-solomode-entries.sql`.

La procedura è stata applicata prima a una copia e poi al database operativo. Esito: 28 entry, posizioni 1–28 senza lacune, 28 osservazioni storiche, integrità SQLite valida e zero violazioni delle chiavi esterne. Nessun thread WIP è stato aperto e nessuna risorsa o requisito materiale è stato censito.

Prossima unità di lavoro: completare e importare 1-Card 2024 dalla GeekList ufficiale 334560.

## Incremento concluso — barra verde 2024 — 2026-10-04

Obiettivo richiesto raggiunto: **10/10 contest PnP principali, 100%, 381 entry**. Importate 352 nuove entry nei nove contest mancanti; Children & Family (29) e Solomode adiacente (28) preservati. Totale annuale 409 entry. Adiacenti ancora 1/7: le sei challenge non sono comprese nell'incremento verde, quindi il contenitore annuale resta parziale/in corso rispetto al perimetro attuale di 17 contest; questo incremento è concluso.

Deliverable: nove JSON datati in catalog, importatore offline idempotente `catalog/import_2024_core_rosters.py`, verifica JSON e [rapporto con fonti, conteggi, anomalie e limiti](../../sources/2024-CORE-ROSTER-COMPLETION.md). Enumerazione verificata per tutti i roster, distinguendo completezza delle righe dai metadati non osservabili: 9-Card include due destinazioni cancellate, In-Hand autori non dichiarati, 54-Card un ritiro supplementare privo di autore. Discrepanze storiche In-Hand 7/6 squalificate e 1-Card 54/50 conservate e descritte, senza riscrivere le vecchie osservazioni o inferire rimozioni.

Verifiche riuscite: prova su copia in memoria prima dell'applicazione, backup SQLite, cardinalità e posizioni senza lacune, unicità URL, seconda esecuzione senza modifiche, `integrity_check=ok`, zero violazioni di chiavi esterne. Backend dell'app verificato: `pnp_core` 10 contest, 10 censiti, 381 entry; `adjacent` 7 contest, 1 censito, 28 entry; zero classifiche, letture materiali e acquisizioni 2024. Sezioni annuali A/B rigenerate con il generatore ufficiale, sintesi manuale e registro aggiornati. Nessuna analisi WIP, risorsa, requisito, host esterno o download.

Prossimo passo utile: MAT di un solo contest 2024 (per esempio 9-Card); eventuale completamento delle sei challenge adiacenti in un successivo incremento BGG-A 2024. Nessun monitoraggio ordinario previsto per questi contest conclusi. Nessuna nuova strategia strutturale: applicati i pattern già verificati del playbook, senza manutenzione della directory `.agents`.

Salvataggio Git: deliverable locali da committare. Commit/push non eseguiti; modifiche pregresse di altri task preservate. Messaggio suggerito per un commit selettivo: `Completa censimento dei contest PnP principali BGG 2024`.
