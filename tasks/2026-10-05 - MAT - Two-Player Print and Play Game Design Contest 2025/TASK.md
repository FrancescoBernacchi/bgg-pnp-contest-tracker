# 2026-10-05 - MAT - Two-Player Print and Play Game Design Contest 2025

ID: TSK-0056. MAT circoscritto su richiesta; aperto 2026-10-05. Stato: completato il 2026-10-05, con un esito bloccato esplicito.

## Contratto

Solo contest 18, 40 entry del roster esistente. Lettura integrale del primo post originale WIP; URL, menzioni e requisiti espliciti; copertura first_post_only. Esclusi risposte, host esterni, file, download e classifiche. Input: roster ufficiale GeekList 359588, baseline locale. Deliverable: evidenze per entry, SQL riproducibile, relazione, importazione provata su copia con backup, registro e cruscotto. Successo: 40 esiti espliciti con provenienza/data e preservazione delle osservazioni storiche.

Skill bgg-contest-navigation e bgg-material-census lette, inventario/playbook consultati. PWS locale/canonico 1.5.0; preflight locale e browser neutro riusciti. Nessun MAT dedicato precedente, task autonomo distinto dal roster annuale. main con modifiche precedenti preservate; nessuna operazione Git. Titolo visibile conforme.

## Risultati e verifiche — 2026-10-05

Roster ufficiale riconciliato integralmente su due pagine: 41 item, uno introduttivo escluso, 40 giochi. Tutti i WIP già registrati confermati; nessun nuovo roster importato. Letti integralmente in CUA 39 primi post originali, con autore e timestamp. Parry: primo articolo residuo 46341267 di hleveillegauvin, «I love the artwork!», distinto dall'autore GiantLeapGames della entry; originale non osservabile. WIP trovato, entrambe le scansioni not_observable, attestazione blocked; nessuna risorsa/requisito inventato. Il task è concluso perché tutte le 40 entry hanno un esito esplicito; il recupero di Parry resta un approfondimento distinto.

39 entry con risorse: 87 URL esatti distinti per entry, 95 menzioni, 131 requisiti dichiarati in 34 entry. URL identici accorpati per gioco; menzioni, funzioni, etichette e contesti conservati nel dataset. KORxSOL usa lo stesso URL per materiali e contatore; Hex Barons per video e feedback. Scissor Wizards ripete i tre link. Regole, file, video, implementazioni, strumenti, low ink, lingue e varianti restano distinti; tassonomia provvisoria. Senjin dichiara immagini PNP 11x17/Rules; mockup escluso. Orbits: pagina BGG indicata esplicitamente come luogo dei file; componente dinamico risolto con focus. Video promozionale del marchio escluso, nessun file BGG aperto.

Nomi osservati: Pond Pals → Frogs Feud; Momentum → Messenger Momentum; Unlucky Spirits → Original Edition (aggiornamento 1-1-2026). Nomi canonici e storia pregressa preservati; osservazioni nelle evidenze e note delle scansioni, senza fusione/riscrittura dell'identità. Intramural conserva cartella etichettata Rezbol. Under One Sky ha ora PCIO/video 2026 ma nessun collegamento PnP attualmente nel primo post; promozioni escluse. Diskochet: primo post corrente cinque dischi/monete, distinta dalla descrizione del roster storico. Quickdraw: player aids ancora indicati pending nell'inventario ma completati nella checklist. Cloud's Edge dichiara che Screentop può differire dal PnP. Unlucky Spirits: gratuità dichiarata per la durata del contest, condizioni attuali non verificate. Nessuna acquisizione autorizzata da tali dichiarazioni.

EVIDENCE.json conserva evidenze selezionate, requisiti verbatim, versioni, URL, autore/data e limiti, non l'archivio integrale dei post. DOM_WITNESS.json contiene impronte FNV di URL/etichette/identità, conteggi e lunghezze dei testi letti e thread del roster. Verificati 40 confronti URL/etichetta/identità e la sequenza completa roster. Requisiti riesaminati manualmente contro il testo letto; FNV è controllo di trascrizione, SHA-256 è usato per manifest SQL e backup.

SQL riproducibile con riuso del serializzatore locale, costanti del lotto corrente e attestazione Parry blocked. Prova su copia: integrity_check ok, nessuna violazione FK, idempotenza, preservazione integrale delle righe originarie; modifiche additive soltanto a scansioni, requisiti, risorse, menzioni e attestazioni delle entry target. Entries, giochi, altri contest, risultati, acquisizioni e file invariati. Il primo tentativo su copia ha rilevato supply_mode custom non ammesso: corretto a specialized prima dell'operativo, schema invariato. Importazione operativa effettuata solo dopo verifica, con backup e hash in outputs/2025-two-player-materials. VERIFICATION.json registra esiti e hash.

API_VERIFICATION.json: scansioni, risorse e requisiti esposti per tutte le 40 entry. Browser: contest e filtro Lettura registrata 40, scheda Parry con messaggi not_observable verificati. Lettura registrata include la scansione bloccata e non equivale alla completezza; attestazioni complete 39/40. Cruscotto A/B rigenerato; 445/509 entry 2025 con scansione registrata, distinta dalla completezza.

Deliverable: ROSTER_BASELINE.json, EVIDENCE.json, DOM_WITNESS.json, VERIFICATION.json, API_VERIFICATION.json; catalog/build_2025_two_player_materials.py, catalog/verify_2025_two_player_materials.py, catalog/2025-two-player-materials.sql; sources/2025-TWO-PLAYER-MATERIALS.md; registro e PROJECT_PROGRESS.md aggiornati.

Nessun host esterno/file aperto o download. Nessun nuovo pattern strutturale da promuovere; applicati quelli già verificati. Skill e PWS invariati. Nessun commit/push; modifiche preesistenti preservate. Incremento verificato da committare: messaggio proposto `Censisci materiali Two-Player PnP 2025`.

Prossimo passo utile: selezione dei giochi per un eventuale ACQ del solo Two-Player 2025, con verifica condizioni e host. Per Parry occorre recuperare l'originale o concordare una fonte alternativa; nessun monitoraggio ordinario del contest concluso.

## Versionamento verificato — 2026-10-05

Su richiesta commit e push: commit e63fe64 su main, 13 file, soli delta Two-Player nei file condivisi. Push origin/main riuscito; hash completo HEAD uguale al riferimento letto sul server. Database, backup e temporanei esclusi; altre modifiche locali preservate. Usato componente HTTPS Git integrato con exec-path esplicito, senza modifiche persistenti. Esito salvato nel successivo commit documentale.
