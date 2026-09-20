# Esplorazione contest BGG 2026

## Stato

Completato il 20 settembre 2026.

## Tipo standard

`censimento annuale delle entry`

## Obiettivo

Completare i roster 2026 dei contest già presenti nel database ma ancora privi di entry: 1-Card Print and Play Contest e le cinque 24 Hour Design Challenge CULTURE, CLASSIC, STICK, DRAW e NINE.

## Scope

Un solo anno, 2026. Per ogni contest: fonte BGG autorevole, roster completo, titolo, autore o username se pubblicato, stato originale e normalizzato, posizione o ordine e URL BGG dell'entry quando disponibile.

## Fuori scope

- lettura o analisi dei WIP oltre ai metadati necessari a identificare il roster;
- censimento di risorse e requisiti materiali;
- apertura o verifica di host esterni;
- download o acquisizione di materiali;
- monitoraggio periodico dello stato corrente dei contest.

## Input

- database SQLite locale;
- censimento globale 2026 e registri delle challenge da 24 ore;
- fonti BGG ufficiali dei sei contest;
- skill locale `bgg-contest-navigation` e relativo playbook.

## Deliverable

- registro documentale delle fonti e delle anomalie;
- script SQL versionabile e riproducibile per i sei roster;
- verificatore su copia temporanea del database;
- database operativo aggiornato;
- `PROJECT_PROGRESS.md` rigenerato nelle sezioni annuali A e B;
- documentazione del catalogo e stato del task aggiornati.

## Criteri di successo

- tutti i contest 2026 inclusi hanno almeno un roster completo oppure un'assenza di entry provata e documentata;
- conteggi riconciliati con le fonti BGG;
- nessun WIP, risorsa o file di gioco analizzato;
- `PRAGMA integrity_check` restituisce `ok` e `PRAGMA foreign_key_check` non segnala violazioni;
- il cruscotto mostra copertura entry 100% per PnP principali e adiacenti 2026.

## Nota Git

Il task è stato aperto con una working tree già contenente numerose modifiche non committate di incrementi precedenti. Tali modifiche sono preservate; il censimento aggiunge file dedicati e interviene sui documenti condivisi solo in modo compatibile e verificabile.

## Risultati

- censite 30 entry del 1-Card dalla GeekList ufficiale 376073, incluse posizione, item ID, autore e WIP;
- censite 30 entry dei cinque 24 Hour Challenge: CULTURE 9, CLASSIC 6, STICK 3, DRAW 9 e NINE 3;
- conservati i due ritiri espliciti di CULTURE e la grafia sorgente `Cloudbound Kingdon`;
- corrette le fonti dei contest STICK e NINE dai riferimenti generici ai thread individuali;
- registrato NINE come snapshot corrente, perché il challenge è ancora aperto;
- nessun file di gioco, risorsa esterna o requisito materiale consultato.

## Verifiche

- `catalog/verify_2026_entry_census_completion.py`: 60 entry e sei roster riconciliati su copia temporanea;
- database operativo: `PRAGMA integrity_check = ok` e nessuna violazione da `PRAGMA foreign_key_check`;
- `PROJECT_PROGRESS.md` rigenerato con `app/generate_project_progress.py`;
- test applicativi Python e frontend eseguiti con esito positivo.

## Decisioni riutilizzabili

La GeekList 1-Card ha richiesto scorrimento progressivo su entrambe le pagine: il DOM iniziale materializzava soltanto i primi elementi. Per i 24 Hour Challenge il secondo post del thread individuale è la fonte autorevole, perché l'organizzatore dichiara nel primo post che lì manterrà l'elenco delle entry.

## Prossimo passo

Il prossimo task suggerito è il monitoraggio del 24 Hour Challenge NINE subito dopo la fine di ottobre, per consolidare il roster finale, eventuali ritiri e l'apertura del voto. La finestra è annotata in `sources/MONITORING_CALENDAR.md` per il 1 novembre 2026.
