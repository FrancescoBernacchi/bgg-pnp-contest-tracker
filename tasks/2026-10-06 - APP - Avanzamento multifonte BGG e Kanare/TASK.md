# Avanzamento multifonte BGG e Kanare

ID: TSK-0071. Apertura: 2026-10-06. Categoria APP, secondaria EPR. Modalità circoscritto, su richiesta. Stato: completato; proposta adottata e implementazione verificata il 2026-10-06.

## Scope e successo — incremento iniziale di proposta

Proporre schede indipendenti per fonte e definire unità, denominatori e criteri di completamento Kanare. Nessuna implementazione, acquisizione o nuova verifica esterna autorizzata da questo incremento. Successo: proposta leggibile con formule, trattamento delle ambiguità e dettagli operativi.

## Input e continuità

TSK-0047/0049/0050 conclusi: nuovo incremento autonomo multifonte. TSK-0070 MAT Kanare in corso, fonte delle future attestazioni; TSK-0067 app immagini aperto, evitare duplicazioni. Consultati registro, TASK_GOVERNANCE, stato PWS, README app e task Kanare. PWS locale/canonico 1.5.0. Sandbox ordinario funzionante; main riferito a origin/main, remoto non verificato e molte modifiche pregresse preservate. Chat 01a112a2-b03e-73e2-9d95-4365caa3e5e1 rinominata secondo convenzione. Nessuna skill specialistica applicata: proposta app offline, senza censimento o acquisizione.

## Proposta — adottata il 2026-10-06

Avanzamento con linguette BGG e Kanare, estensibili per fonte. BGG conserva organizzazione annuale/contest. Kanare: riepilogo catalogo, barre per gioco e tabella filtrabile; confezioni come vista alternativa, senza duplicare giochi nei totali. Nessuna media globale fra fonti o fasi.

Catalogo: schede native censite / schede individuate nello snapshot datato della fonte; varianti aggregate tracciate esplicitamente. Numero giochi canonici distinto da record nativi e prodotti (baseline documentale 64/58/39).

Identità: unità censite con riconciliazione conclusa / unità censite da riconciliare; associazioni candidate escluse dal numeratore.

Materiali: giochi con analisi completa e attestata di risorse/requisiti / giochi catalogati nel perimetro MAT; assenza esplicita può completare la ricerca, blocchi e analisi parziali no. Baseline MAT attesa 64, da riconciliare con risultati TSK-0070.

Acquisizione: giochi selezionati con tutto il pacchetto concordato acquisito, registrato e verificato / giochi selezionati con materiali acquisibili richiesti. Esporre anche copertura sul catalogo; nessun obbligo implicito di acquisire tutti i giochi. File condivisi associati a tutti i giochi coperti, una sola acquisizione fisica. Lingue/versioni secondo contratto.

Immagini: giochi selezionati con copertura IMG obbligatoria completa / giochi nel lotto IMG approvato; disponibilità di una rappresentativa separata dalla completezza per categorie, AI pendente esclusa. Dipendenza TSK-0067.

Implementazioni online come dato accessorio (verificato/incerto/assente), senza obiettivo percentuale iniziale. Mostrare n/d, %, data/perimetro e stati parziale/bloccato/non applicabile/non attestato. Denominatore zero: trattino con motivo. Nuovi giochi possono ridurre la percentuale con storia conservata. Nessuna percentuale attuale inventata dalla presenza dei record.

## Verifica e prossimo passo

Proposta confrontata con semantica multifonte e regole delle attestazioni APP-008; nessun dato operativo modificato, nessuna prova software necessaria. Discutere metriche e layout, poi definire incremento implementativo e riconciliare tutte le evidenze storiche prima del calcolo. Nessun commit/push eseguito.

## Decisione e incremento implementativo — 2026-10-06

Utente accetta la proposta e autorizza la nuova versione app. Implementare linguette per fonte, layout BGG conservato, riepilogo/metriche Kanare, filtri, dettaglio gioco e vista confezioni. API in sola lettura e nessuna richiesta esterna. Riconciliare censimento storico completo (76 record dopo arricchimento, non baseline iniziale 58), lotto ACQ 3 giochi e manifest MAT 62 completi/1 parziale/1 bloccato. IMG resta dipendenza di TSK-0067, senza lotto selezionato. Successo: regressioni backend/frontend e browser desktop/mobile, denominatori e casi mancanti verificati, documenti autorevoli aggiornati. Proposta adottata; implementazione in corso. Nessuna operazione Git mutativa autorizzata.


## Risultato e chiusura — 2026-10-06

Implementata sezione trasversale Avanzamento, spostata fuori dal gruppo BGG della navigazione. Linguette estensibili per fonte con layout indipendenti; BGG conserva annualità/contest, selezione e apertura righe. Kanare: 64 giochi, 76 schede native (arricchimento storico 58→76 riconosciuto), 39 prodotti e 15 identità candidate. Metriche: catalogo 76/76, materiali 62/64 completi (Candy Chain parziale, Swarm bloccato), acquisizione 3/3 nel lotto storico selezionato; copertura 3/64 distinta. Immagini senza lotto selezionato: trattino con motivo, dipendenza futura TSK-0067. Nessuna media fra fasi/fonti.

Viste Giochi/Confezioni/Schede, filtri fase/stato/ricerca/identità; dettagli espandibili con requisiti, confezioni, componenti condivisi, limiti, inferenze, fonti e crediti/ruoli/date. Lettura e download restano azioni distinte; URL esterne aperte solo su click. Linguette navigabili da tastiera e URL diretti per fonte. Cambio fonte e refresh preservano lo stato indipendente dei filtri e delle annualità.

Attestazione versionabile del perimetro censimento e lotto ACQ in catalog/kanare_progress_scope_2026-10-06.json; date originali 2026-09-20/21 distinte dalla formalizzazione. reconcile_scope.py registra gli ID senza matching per titolo e ricontrolla i tre SHA-256 originali. Adattatore app/source_progress.py legge queste attestazioni e il manifest MAT concluso TSK-0070, senza importazione SQLite. Nuovi giochi/record, obblighi ACQ non più nel catalogo, evidenze mancanti, N/A e file condivisi trattati conservativamente. Metadati registrati, lingua, hash dichiarato, dimensione e presenza confinata dei file verificati durante la lettura HTTP; hash contenuti ricontrollati offline, non a ogni richiesta.

Verifiche: 59 test Python, 42 test frontend e browser 1400/780/390 px superati; zero errori browser, richieste esterne o overflow pagina. Verificati stati, filtri, dettagli, confezioni, schede, tastiera, refresh e preservazione BGG. Corretto durante QA il focus delle linguette: il gestore hashchange originario riportava il focus al main. Prove visive desktop/mobile consultate; evidenze in VERIFICATION.json e screenshot locali outputs/multisource-progress. integrity_check=ok e zero FK. Nessuna modifica dati SQLite, materiali originali o sezioni annuali generate; nessuna acquisizione.

PROJECT.md, AGENTS.md, stato PWS, guida app/catalog, README, cruscotto e registro aggiornati. PWS 1.5.0 invariato. Revisione mirata di nuovi codice/fixture/manifest: zero candidati euristici, riepiloghi originali/ID/metadati, nessun manuale/immagine/dump aggiunto; non è audit della storia pregressa. Nessuna skill specialistica applicata: sviluppo app e riconciliazione offline di evidenze già prodotte, senza nuovo CAT/MAT/ACQ/IMG.

Task concluso. Prossimo passo: verifica utente della nuova interfaccia, poi eventuale incremento IMG in TSK-0067 o nuovo lotto ACQ Kanare separato e selezionato. Commit suggerito, non eseguito: `Estende Avanzamento a BGG e Kanare con metriche dedicate`. Molte modifiche pregresse preservate; nessun commit, branch o push eseguito.


## Commit e push autorizzati — 2026-10-06

L’utente richiede commit e push. Ripreso TSK-0071, PWS 1.5.0 e sandbox ordinario verificati. Fetch origin riuscito; main coincide con origin/main prima dell’incremento. Numerose modifiche di altri task restano escluse mediante patch selettiva dell’indice, senza alterare i file di lavoro. Incluse le dipendenze concluse TSK-0049/0050 (schede compatte e palette BGG) e l’avviso diritti comune richiesto dalla policy; altre attribuzioni/API/lettori e altri workflow restano locali. Test browser delle dipendenze aggiornati a conteggi API datati correnti e URL di prova configurabile, evitando aspettative numeriche storiche su un database evoluto. Verifica del contenuto esatto selezionato prima del commit.

Audit integrale pre-commit: 299 candidati preesistenti su 30 percorsi, nessun commit allora in uscita. I percorsi segnalati restano fuori da questo incremento; pubblicazione limitata ai nuovi cambiamenti revisionati, senza attestare la liceità della storia già remota. Originali, SQLite, screenshot, materiali e output restano esclusi. Selezione/audit e risultato Git registrati dopo verifica.
