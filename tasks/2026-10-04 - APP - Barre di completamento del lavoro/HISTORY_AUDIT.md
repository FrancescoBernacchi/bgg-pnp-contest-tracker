# Audit delle cinque barre — 2026-10-04

Riconciliazione tecnica locale APP-008, non rilevamento BGG. Screenshot dell'utente come evidenza della regressione; fonti autorevoli riutilizzate: task di censimento/monitoraggio, SQL originali, check SQLite e manifest ACQ già presenti. I dati originali non erano scomparsi: mancavano attestazioni storiche nel modello nuovo, e il confronto automatico dei link ignorava alcune esclusioni deliberate.

## Conteggi ripristinati

| Anno/perimetro | Censimento entry prima → dopo | Verifiche classifica prima → dopo | Piazzamenti/entry conservati |
|---|---|---|---|
| 2026 PnP | 0/10 → 9/10 (90%) | 0/356 → 132/356 (37%), 12 parziali | 71 entry con risultati |
| 2026 adiacenti | 0/8 → 7/8 (88%) | 0/74 → 21/74 (28%) | 20 entry con risultati |
| 2025 PnP | 9/9 invariato | 384/384 invariato | 207 entry con risultati |
| 2025 adiacenti | 2/8 invariato | 80/80 invariato | 40 entry con risultati |
| 2024 PnP | 0/10 → 10/10 (100%) | 381/381 invariato | 225 entry con risultati |
| 2024 adiacenti | 0/7 → 1/7 (14%) | 28/28 invariato | 14 entry con risultati |

Il 2026 non viene forzato al 100%: Roll & Write è un contest aggiunto il 2026-10-02 ancora senza roster; Bad Comet conserva la rilevazione selettiva/parziale originaria, non un censimento completo dell'intero contest. Le sei challenge senza roster del 2024 e 2025 rimangono dipendenza. Gli snapshot completi dei contest aperti sono datati: non garantiscono l'assenza di future nuove entry.

Riferimenti roster: TSK-0015 e `sources/2024-CORE-ROSTER-COMPLETION.md` (10 principali; Solomode in TASK.md), TSK-0017 e i check nominali precedenti in TSK-0001; snapshot Wargame post-chiusura TSK-0028. Date originali preservate nelle attestazioni, formalizzazione successiva dichiarata nelle note.

Risultati 2026: In-Hand, 9-Card, Children & Family e Solomode hanno baseline di risultati completate e documentate; esiti completi/assenti riferiti esclusivamente alle liste pubblicate censite. Two-Player conserva i podi: 12 osservazioni di entry parziali, senza negativi per le restanti 33. Una prima formalizzazione tecnica di queste 12 entry come complete è stata corretta nello stesso incremento tramite osservazioni successive append-only, senza modificare i risultati storici. Stato `complete` del contest e semplice assenza di rankings non certificano mai da soli la verifica delle classifiche.

## Controllo delle altre fasi

**Censimento materiali:** verificati tutti i conteggi contro scansioni e task MAT. 2026 PnP 23/356: tutte le 23 entry Wargame hanno scansione del primo post; le altre non sono state analizzate. 2025 PnP 125/384 e adiacenti 36/80: 161 scansioni con esito conclusivo su 167 presenti; le altre sei sono due non osservabili e quattro `not_checked`. Si conserva la presenza di tutte le scansioni, ma non si assegnano completamenti artificiali. 2024 non ha scansioni: zero corretto. Tutte le annualità 2008–2023 sono prive di roster operativi e quindi non hanno completamenti di queste fasi.

**Acquisizione materiali:** 2025 PnP passa da 16/361 a 39/363 (11%), con 13 bloccate, 3 parziali e 21 non applicabili. Le 43 entry con almeno un file restano invariate: 39 complete nel perimetro dei manifest e quattro con file parziali (una bloccata da limite host). Due esiti precedentemente considerati non applicabili sono in realtà non osservabili, quindi tornano nel denominatore e nei blocchi. 2025 adiacenti resta 0/65, 15 non applicabili; 2026 resta senza acquisizioni, con 11 assenze dichiarate nel censimento Wargame; 2024 e annualità precedenti senza acquisizioni. Nessuna copia originale, file, acquisizione o dato remoto modificato.

Fonti acquisizione: `catalog/2025_roll_write_acquisition_batch_2026-10-03.json`, `catalog/2025_children_family_remaining_acquisition_batch_2026-10-03.json` e primo lotto Children & Family. Esclusioni video, implementazioni, materiali promozionali e varianti non approvate rispettate. Nessun limite o blocco è stato trasformato in acquisizione completa.

**Acquisizione immagini:** tutte le barre rimangono allo 0%, funzione non implementata; nessuna acquisizione di immagini rappresentative confusa con i PNG già in libreria.

## Verifiche

- Importazione su copia, backup prima dell'operativo, doppia applicazione idempotente, hash dei contenuti di tutte le tabelle originarie invariati; integrity ok e zero violazioni FK.
- 47/47 test Python e 46/46 frontend/PDF. Nuove regressioni su snapshot completo/parziale e acquisizione conclusa nel perimetro del manifest con video escluso, mantenendo distinti i casi parziali.
- Edge headless a 1560, 1400 e 390 px: dati ripristinati verificati nell'HTML reale, dieci barre per anno, immagini zero e nessun overflow/errore JavaScript. Titoli dei primi cinque box sempre a **15 px dal bordo superiore**, differenza massima 0 px: nessun centraggio verticale residuo.
- Screenshot desktop e mobile esaminati; A/B rigenerate soltanto tramite generatore. Dettagli completi prima/dopo e provenienze in `HISTORY_RECONCILIATION.json`; SQL di riproduzione in `catalog/2026-10-04-work-history-reconciliation.sql`.

Prossimo passo utile: revisione dell'utente nell'app aggiornata e commit dedicato. Roster mancanti, verifiche parziali e nuove acquisizioni restano nei task BGG/MAT/ACQ pertinenti; nessuna ricerca esterna eseguita da questo audit APP.
