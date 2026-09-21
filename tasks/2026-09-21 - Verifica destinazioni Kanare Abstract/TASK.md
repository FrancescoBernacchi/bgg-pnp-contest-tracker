# Verifica destinazioni Kanare Abstract

## Stato

Concluso. Destinazioni verificate conservativamente; nessun materiale acquisito.

## Tipo di attività

Verifica delle destinazioni dichiarate da una singola fonte non-BGG. È un incremento autonomo dell'evoluzione multifonte e non appartiene ai cinque workflow BGG. Per le sole destinazioni BGG si applica la procedura di navigazione BGG, senza estendere il perimetro a contest, WIP o materiali.

## Scopo

Verificare le destinazioni esterne già dichiarate e registrate da Kanare_Abstract, con priorità sui 26 matching `candidate` e sulle 54 implementazioni online attribuite a 9 piattaforme, senza acquisire materiali.

## Input

- collegamenti Kanare già registrati nel database operativo;
- `sources/KANARE-ABSTRACT-TITLE-CENSUS.md`;
- task Kanare precedenti del 2026-09-20;
- `catalog/enrich_kanare_abstract.py` e `catalog/verify_kanare_abstract_import.py`;
- schema, migrazione 009, `database/README.md` e `PROJECT_PROGRESS.md`;
- pagine BGG e piattaforme online raggiunte esclusivamente dai collegamenti dichiarati da Kanare.

## Perimetro

- esaminare i 26 matching ancora `candidate`;
- verificare le 54 implementazioni dichiarate sulle 9 piattaforme registrate;
- conservare separatamente valori grezzi, normalizzati, evidenza, metodo e stato;
- aggiornare idempotentemente i record esistenti preservando identificativi e osservazioni precedenti;
- produrre script e verifiche riproducibili, backup verificato e rendiconti prima/dopo;
- aggiornare la documentazione autorevole se cambia lo stato della pipeline.

## Esclusioni vincolanti

- nessun download o acquisizione di immagini, PDF, regolamenti o altri materiali;
- nessuna lettura integrale dei regolamenti;
- nessun archivio web, account, login, installazione o avvio di partite;
- nessuna ricerca estesa oltre i collegamenti dichiarati, salvo fallback sostitutivo strettamente necessario e documentato per anomalie residue;
- nessuna fusione automatica di alias, grafie, versioni qualificate o omonimi;
- nessuna modifica dell'app salvo necessità dimostrata;
- nessuna operazione Git mutativa senza autorizzazione.

## Criteri di successo

- rendiconto completo dei 26 matching fra `confirmed`, `rejected` e `candidate`;
- rendiconto completo delle 54 implementazioni fra `verified`, `rejected`, `uncertain` e non osservabili;
- nessuna ambiguità risolta senza evidenza sufficiente e trattamento conservativo di `Ripples`;
- titoli qualificati preservati e assenza di duplicazioni o fusioni non motivate;
- dati BGG non pertinenti invariati;
- `PRAGMA foreign_key_check` vuoto e `PRAGMA integrity_check = ok`;
- verificatore Kanare aggiornato e test backend/frontend superati;
- fonti, pagine visitate, evidenze, decisioni, limiti e diff finale documentati.

## Registro operativo

- 2026-09-21: preflight completato; branch `main`, working tree pulita, relazione `origin/main...main` pari a 0/0.
- 2026-09-21: PWS del progetto e versione canonica entrambi 1.5.0; nessuna migrazione richiesta.
- 2026-09-21: titolo visibile impostato a `2026-09-21 - Verifica destinazioni Kanare Abstract`.
- 2026-09-21: task classificato come verifica di destinazioni di una singola fonte non-BGG; skill BGG limitata alle pagine BGG dichiarate.
- 2026-09-21: riconfermata nel browser la matrice `https://kanare-abstract.com/en/pages/online_play`, comprese le 54 presenze e i qualificatori originali.
- 2026-09-21: osservate pagine ufficiali nominative su Abstract Play, Board Game Arena, Mindsports, Spielstein e Tabletopia; controllato separatamente il thread BGG dell'omonimo `Ripples`.
- 2026-09-21: Ai Ai ha presentato un certificato TLS non verificabile; l'interstitial non è stato aggirato. BoardSpace.net non è risultato osservabile in sicurezza. Le relative righe sono rimaste incerte.
- 2026-09-21: creato e provato due volte su copia temporanea lo script idempotente `catalog/verify_kanare_abstract_destinations.py`.
- 2026-09-21: creato con l'API SQLite il backup `outputs/backups/pnp_collection-before-kanare-destinations-20260921.sqlite3`, 2.756.608 byte, SHA-256 `373717bef2a2bf91de502e3d519036fd76718694447ec2b80cd18feaff928db7`, integrità `ok` e nessuna violazione FK.
- 2026-09-21: aggiornato il database operativo senza rieseguire migrazioni.

## Pagine ed evidenze principali

- Kanare Online Play: matrice dichiarativa completa, titoli grezzi e 9 piattaforme nominate.
- Abstract Play: pagine pubbliche di Abande, Enso, Meridians, Stairs e Trike, con titolo e attribuzione del gioco.
- Board Game Arena: pagine gioco di Carpniches, Meridians e Trike, con titolo, designer e disponibilità online.
- Mindsports, pagina Dagaz Project: elenco ufficiale con Flower Shop e Slyde.
- Spielstein: pagine gioco di Abande, Attangle ed Enso con accesso a match/ranking.
- Tabletopia: pagina Tori Shogi con titolo, crediti Kanare_Abstract e opzioni di gioco.
- BGG thread `3713561`: WIP `Ripples` del contest 1-Card 2026, distinto dalla descrizione Kanare del gioco con pezzi reversibili.

## Decisioni

- Matching `confirmed` (10): Abande, Attangle, Carpniches, Enso, Flower Shop, Meridians, Slyde, Stairs, Tori Shogi, Trike.
- Matching `rejected` (1): il candidato BGG Ripples, per omonimia fra giochi differenti.
- Matching ancora `candidate` (15): Accasta Pari, Apart, Comune, Estate, heXentafl, LAG, Make Muster, Onager, Paintscape, Residuel, RosenKreuz, Saiju, Shape Chess, Vault, Volo.
- Implementazioni: 14 `verified`, 0 `rejected`, 40 `uncertain`. Le incerte comprendono 18 `not_observable` e 22 `unconfirmed`.
- Nessun alias o titolo qualificato è stato fuso. `Accasta (original)`, `RosenKreuz (7×7)`, `Residuel (old rules)`, `Tori Shogi (no extra pieces)` e `Swarm (unpublished)` sono rimasti invariati.
- Le due righe storiche su piattaforma non specificata e la doppia rappresentazione di Swarm sono state preservate; nessuna cancellazione o deduplicazione distruttiva.

## Verifiche finali

- confronto prima/dopo: 26→15 matching `candidate`; 10 nuovi `confirmed`; 1 nuovo `rejected`; 54 implementazioni da `declared` a 14 `verified` e 40 `uncertain`;
- strutture invarianti: 76 record nativi, 64 giochi canonici Kanare, 39 prodotti, 56 relazioni prodotto–gioco, 141 risorse e 162 legami di provenienza;
- dati BGG non pertinenti invariati: 305 contest, 946 entry, 407 crediti, 1.054 classifiche e 327 risorse remote;
- esecuzione idempotente su copia: conteggi invariati alla seconda applicazione;
- `PRAGMA foreign_key_check`: nessuna riga; `PRAGMA integrity_check`: `ok`;
- `catalog/verify_kanare_abstract_import.py`: superato sul database operativo;
- migrazione multifonte sintetica: superata;
- backend: 16/16 test superati; frontend: 20/20 test superati;
- `git diff --check`: superato, con soli avvisi informativi LF→CRLF;
- branch finale `main`, ancora allineato 0/0 a `origin/main`; nessuna operazione Git mutativa eseguita.

## Risultato e prossimo incremento

Il rilevamento ha trasformato soltanto gli esiti sostenuti da una pagina ufficiale sufficientemente specifica. I 15 casi residui restano deliberatamente candidati e le 40 implementazioni prive di conferma puntuale restano incerte.

Il prossimo incremento proposto, separato da questo lavoro, è **Acquisizione selettiva dei materiali Kanare_Abstract**, con selezione manuale preventiva, verifica delle condizioni applicabili, manifest e hash. Un eventuale nuovo tentativo sui 15 matching residui dovrà essere un controllo mirato distinto, senza aggirare certificati o richiedere account.

Messaggio di commit proposto, non eseguito: `Verifica le destinazioni dichiarate da Kanare Abstract`.
