# TSK-0054 — Solitaire Print and Play Contest 2025

## Contratto e stato

Completato il 2026-10-05, MAT circoscritto su richiesta. Successore per singolo contest di TSK-0009; nessuna prosecuzione del perimetro multi-contest storico. Autorizzazione: «Censiamo i materiali» del contest locale 17.

Scope: tutte le 74 entry del roster già censito; individuazione dei WIP, lettura integrale del primo post originale, risorse dichiarate e requisiti espliciti senza URL. Copertura `first_post_only`. Esclusi host esterni, file, download, nuove entry e classifiche.

Input: database operativo, baseline esportata in ROSTER_BASELINE.json, GeekList ufficiale 358652; skill bgg-contest-navigation e bgg-material-census. PWS locale/canonico 1.5.0 verificato. Preflight sandbox e browser neutro riusciti; main allineato al riferimento origin locale, con modifiche preesistenti preservate.

Deliverable: evidenze DOM con fonte/data/autore/post; manifest risorse e menzioni, requisiti e scansioni; importazione riproducibile verificata su copia, backup prima del database operativo; sintesi e cruscotto aggiornati.

Criteri: esito esplicito per 74/74 entry, nessuna lettura parziale attestata completa, URL identici accorpati per entry preservando menzioni, integrità e foreign key valide, dati estranei preservati e importazione idempotente. Nessuna operazione Git automatica.

## Risultati e chiusura — 2026-10-05

Roster ufficiale: 74 righe su tre pagine; tutti i WIP già presenti corrispondono alle intestazioni autorevoli. Tutti i 74 primi post originali osservabili e letti integralmente, con autore, timestamp originale e permalink articolo. Le modifiche correnti del primo post sono incluse; nessuna risposta successiva utilizzata. Quattro collegamenti BGG dinamici alle pagine file dei giochi risolti mediante scorrimento del primo post.

74/74 attestazioni MAT complete, zero blocchi. 71 entry con collegamenti pertinenti, 236 URL esatti distinti per gioco e 244 menzioni. 239 requisiti in 64 entry; 10 primi post senza inventario sufficientemente esplicito. Nan’s Heroes, Vicinity e Fairway Fantasy non dichiarano URL pertinente nel primo post: soltanto Nan’s Heroes è anche senza requisiti espliciti. Fairway contiene regole integrate. Le assenze non significano che i giochi siano privi di file.

Menzioni identiche accorpate nel database, preservate nel dataset. Funzione e forma tecnica separate; audio, modulo feedback e supporti digitali conservati come funzioni provvisorie. Tre immagini BGG incluse soltanto per il manuale JPG esplicitamente dichiarato di Pilzgrim. Esclusi profili, crediti, immagini decorative, navigazione, feedback su altri giochi e strumenti di sviluppo; null_pr0xy collega un quickstart Protograf, non i propri componenti. Lost in Xmas Town è dichiarato gioco diverso e resta escluso.

Alternative, espansioni, requisiti raccomandati e stime future distinti; nessun componente inferito dalla meccanica. Underdice conserva la contraddizione tra sintesi e dettagli dei dadi. Eighteen Eggs dichiara file della seconda edizione 2026; Pilzgrim una nuova versione 2026 nella stessa cartella. Quantità e sottogruppi non vanno sommati automaticamente. Abydos dichiara gratuità limitata al contest; Delve gamesheet per iscritti Substack; Jelly URL firmato. Condizioni e disponibilità non verificate in MAT.

## Deliverable e verifiche

- `ROSTER_BASELINE.json`: baseline locale, preservata.
- `CENSUS_INPUT.json`: estratti pertinenti e anchor selezionati dal DOM; autore, data, permalink e hash della lettura integrale. Le copie integrali dei primi post e del roster sono solo in outputs escluso da Git.
- `EVIDENCE.json`: manifest normalizzato con menzioni, requisiti, esiti e dichiarazioni originali.
- `catalog/build_2025_solitaire_materials.py` e `catalog/2025-solitaire-materials.sql`: generazione offline riproducibile dagli estratti versionati; riuso esplicito delle funzioni SQL del lotto 54-Card, con ID/data/evidence del presente lotto.
- `catalog/verify_2025_solitaire_materials.py` e `VERIFICATION.json`: confronto puntuale delle 74 selezioni URL/etichetta con il DOM catturato; contesti requisiti presenti nel testo; hash cattura coincidente.
- Importazione su copia e operativo con backup: integrity check ok, zero violazioni FK, seconda applicazione invariata; tutte le righe pregresse preservate, nessuna modifica a roster, classifiche, acquisizioni, file o altri contest.
- Browser locale: tutte le tre pagine, 30+30+14 righe, mostrano lettura registrata. Scheda Nan’s Heroes distingue l’assenza dichiarativa dalla baseline del roster; fonte e data 05/10/2026 visibili.
- Sezioni A/B rigenerate; cruscotto qualitativo aggiornato a 363/509 entry 2025 con scansione registrata, distinta dalla completezza.

Nessun host esterno o file aperto e nessun download. Calendario periodico invariato: censimento di contest concluso, nessun monitoraggio. Nessun nuovo pattern da promuovere; caricamento dinamico e immagini operative seguono il playbook già verificato.

Titolo visibile verificato: `2026-10-05 - MAT - Solitaire Print and Play Contest 2025`. PWS 1.5.0 invariato. Registro TSK-0054 completato; TSK-0009 conserva stato e perimetro storico.

Prossimo passo utile: eventuale ACQ del solo Solitaire 2025, dopo selezione esplicita dei giochi e verifica di condizioni/host. Incremento locale pronto per commit su richiesta: `Censisci materiali dichiarati del Solitaire Contest 2025`. Nessun commit o push eseguito; modifiche preesistenti preservate. Database, backup e copie integrali esclusi da Git.

## Versionamento verificato — 2026-10-05

Su richiesta «commit e push»: commit 7464101 su main, 11 file del censimento e soli delta pertinenti di registro/cruscotto. Push origin/main riuscito; HEAD uguale al riferimento server. Database, backup e copie integrali esclusi. Altri incrementi non committati preservati. Esito registrato nel successivo commit documentale.
