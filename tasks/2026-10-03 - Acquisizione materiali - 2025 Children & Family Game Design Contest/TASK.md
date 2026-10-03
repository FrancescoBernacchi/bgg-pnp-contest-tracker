# Acquisizione materiali - 2025 Children & Family Game Design Contest

## Stato

- Apertura: 2026-10-03.
- Stato: concluso il 2026-10-03 per il primo lotto dei vincitori ufficiali.
- Titolo Codex verificato: `2026-10-03 - Acquisizione materiali - 2025 Children & Family Game Design Contest`.
- PWS: `aligned_version` 1.5.0, uguale alla versione canonica 1.5.0.
- Git: branch `main`, allineato a `origin/main` e working tree pulita al preflight.

## Contratto

- Tipo standard: **Acquisizione materiali del contest**.
- Unità di lavoro: solo `2025 Children & Family Game Design Contest`.
- Predecessori: censimento globale; censimento annuale 2025 completo; analisi pre-standardizzazione di 27/27 entry, con risorse e requisiti materiali dichiarati registrati. I dati pregressi vengono riutilizzati senza riscriverne retroattivamente la struttura storica.
- Selezione iniziale approvata nel contesto della chat: vincitori delle cinque categorie ufficiali, deduplicati per gioco.
- Giochi selezionati: `Pirate Treasures`, `ICBRG`, `Good Breeding`, `Zoo Rush`.
- Esclusioni: altri contest; entry non vincitrici; video dimostrativi non necessari al gioco; redistribuzione; derivati o alterazioni degli originali.

## Input osservati

- `Pirate Treasures`: vincitore Best Children's Game; nessuna risorsa dichiarata registrata.
- `ICBRG`: vincitore Best Family Game e Best Rulebook; file PnP e regolamento Google Drive dichiarati.
- `Good Breeding`: vincitore Best Theme; cartella componenti Google Drive dichiarata; video escluso dal lotto.
- `Zoo Rush`: vincitore Best Art; versione a colori e versione printer-friendly dichiarate su GMX.

## Deliverable

- Verifica puntuale di disponibilità, destinazione finale, tipo di accesso e condizioni d'uso osservabili per ogni risorsa selezionata.
- Download dei soli originali chiaramente accessibili per uso personale, senza aggirare autenticazione o restrizioni.
- Conservazione immutabile sotto `library/bgg/2025-children-family/<gioco>/originals/`, senza sovrascrivere versioni precedenti.
- Manifest versionabile con gioco, categoria di selezione, URL dichiarato e finale, data, nome originale, MIME, dimensione, SHA-256, versione, lingua, condizioni d'uso ed esito.
- Aggiornamento riproducibile del database operativo, con osservazioni remote, acquisizioni e file locali associati.
- Rigenerazione delle sezioni annuali di `PROJECT_PROGRESS.md`, aggiornamento qualitativo, verifiche di integrità e chiusura documentata.

## Criteri di successo

- Ogni risorsa selezionata riceve un esito esplicito: acquisita, non disponibile, non osservabile, ristretta o esclusa con motivazione.
- Nessuna assenza viene dedotta da una pagina non osservabile e nessuna destinazione viene inventata.
- Ogni file acquisito coincide con il contenuto remoto osservato e possiede dimensione e SHA-256 verificati.
- Gli originali restano fuori da Git; manifest, script e documentazione non includono materiali di terzi.
- `PRAGMA foreign_key_check` senza righe e `PRAGMA integrity_check = ok` dopo l'aggiornamento.

## Metodo

1. Verificare gli URL dichiarati nel browser e registrare redirect, accessibilità e condizioni esposte.
2. Scaricare soltanto file chiaramente offerti dall'autore o dalla fonte dichiarata, senza autenticazione forzata.
3. Identificare formato, lingua e versione senza modificare gli originali.
4. Preparare manifest e incremento database idempotente; provarli su copia prima dell'operativo.
5. Verificare file, hash, database, cruscotto e stato Git; documentare risultati e prossimo approfondimento utile.

## Registro operativo

- 2026-10-03: task aperto; ricostruiti dal database i quattro vincitori unici e sei risorse dichiarate pertinenti, di cui un video escluso. `Pirate Treasures` non dispone di una risorsa dichiarata nel censimento precedente e richiede verifica conservativa del WIP, senza ricerca arbitraria di copie alternative.
- 2026-10-03: BGG ha mostrato la verifica di sicurezza Cloudflare nel browser integrato; non è stata aggirata. Le destinazioni esterne già dichiarate sono state verificate direttamente.
- 2026-10-03: acquisiti due PDF di `ICBRG` (PnP 2.1 e Rulebook 2.0) e tre PDF correnti di `Good Breeding` (carte v2, regole e scoring tiles). Esclusi cartella storica, sell sheet e video.
- 2026-10-03: entrambi i link GMX di `Zoo Rush` mostrano `Link expired` e `Share (0 File)`; nessun materiale è stato conservato. Le risposte HTML prodotte durante la diagnosi sono state rimosse dopo verifica del percorso.
- 2026-10-03: `Pirate Treasures` resta senza risorsa dichiarata verificabile; nessuna copia alternativa è stata cercata o acquisita.
- 2026-10-03: manifest, applicatore e verificatore dedicati preparati. La prova su copia e la seconda applicazione idempotente hanno confermato 2 acquisizioni, 5 file e 5 controlli di disponibilità, con `foreign_key_check` vuoto e `integrity_check = ok`.
- 2026-10-03: backup pre-aggiornamento `database/pnp_collection.pre-children-family-acquisition-20261003.sqlite3`, SHA-256 `4AA4901CE8CAC5E9640DFD7B7C3C11A8B3405F56B3AC8504574B76B586DA2985`. Database operativo aggiornato e verificato, SHA-256 `76C6E8E3827F4727643B3CCDE89D056287D4EA5684C33A707AEEE18A51077528` prima della rigenerazione del cruscotto.

## Verifiche e chiusura

- Manifest: `catalog/2025_children_family_acquisition_batch_2026-10-03.json`.
- Applicatore idempotente: `catalog/apply_2025_children_family_acquisition.py`.
- Verificatore: `catalog/verify_2025_children_family_acquisition.py`.
- Risultato finale: 2 acquisizioni (`ICBRG`, `Good Breeding`), 5 PDF originali, 5 osservazioni di disponibilità; 3 risorse disponibili e 2 non disponibili.
- Tutti i cinque file coincidono con dimensione e SHA-256 del manifest e iniziano con intestazione PDF valida.
- Database: `PRAGMA foreign_key_check` senza righe; `PRAGMA integrity_check = ok`.
- Cruscotto rigenerato: Children & Family 2025 mostra 2/27 entry con download, `ICBRG` completo e `Good Breeding` parziale rispetto alla risorsa-cartella dichiarata.
- Test applicazione: 17 test backend e 23 test frontend superati.
- Gli originali e il database restano esclusi da Git; nessun materiale di terzi è stato aggiunto ai contenuti versionabili.

Il primo lotto è concluso secondo il contratto. Un eventuale secondo lotto Children & Family potrà essere svolto nella stessa chat come nuovo incremento esplicito, mantenendo il perimetro sul singolo contest. Il prossimo approfondimento utile è decidere se tentare il recupero autorizzato di `Zoo Rush`/`Pirate Treasures` oppure selezionare i successivi piazzati ufficiali con risorse ancora disponibili.
