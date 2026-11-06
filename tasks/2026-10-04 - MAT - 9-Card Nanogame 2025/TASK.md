# TSK-0051 — MAT - 9-Card Nanogame 2025

Apertura: 2026-10-04. Chiusura: 2026-10-04. Stato: completato. Modalità: circoscritto, su_richiesta.

## Risultato e limiti

Registrati 94 esiti: 89 letture originali complete (94,68%) e 5 bloccati. Risorse dichiarate in 80 entry, 9 `none_declared`, 1 `not_observable` e 4 `not_checked`; 208 URL distinti per gioco, con menzioni multiple conservate. Materiali: 88 `observed`, 1 `none_declared`, 1 `not_observable`, 4 `not_checked`; 414 requisiti dichiarativi. Nessun host esterno aperto, nessun file acquisito.

Roster ufficiale: 63 finali e 30 ritirate, 93 righe. Baseline locale: 94 record, perché ElementaBrawl è stato scisso in Elementa (473) e Brawl (474). Evidenza WIP 3476068 assegnata provvisoriamente soltanto a 473; 474 bloccato. Nessuna fusione, cancellazione o correzione del censimento roster in MAT. Gli altri blocchi sono N/A @zardon (458), HMS Ulven @cabal_se (459), N/A @ryanshaffer (467), senza WIP individuato, e Three Buccaneers (447), primo post originale non osservabile: il primo articolo rimasto del 3 marzo è un aggiornamento.

Lette le 90 destinazioni WIP collegate nel roster. Per i tre collegamenti assenti: ricerca sostitutiva mirata senza candidato e controllo completo delle pagine ufficiali 2–24, senza riferimento pertinente recuperato. I ritirati restano nel perimetro. Stati idea/TBD e conteggi discordanti sono preservati: completezza della lettura non significa completezza del progetto o disponibilità dei file. Nine Tails dichiara rimozione dei file gratuiti; Tiny, Dicey, and Starry mantiene come primo post Dicey Railways, a cui si riferisce l'evidenza.

## Evidenze e verifica

- `EVIDENCE_01.json`–`EVIDENCE_04.json`: trascrizione compatta DOM; alcuni campi `m`/etichette dei gruppi successivi sono sintesi di lavoro.
- `MATERIAL_RAW.json` e `LABEL_RAW.json`: restituiscono i testi/anchor originali dove la trascrizione compatta era sintetica. `EVIDENCE.json` è il dataset operativo, con originali, normalizzazione, note e ruoli separati.
- `catalog/build_2025_nine_card_materials.py`: generazione offline e SQL additivo; nessuna tassonomia annuale consolidata.
- `catalog/2025-nine-card-materials.sql`; `sources/2025-NINE-CARD-MATERIALS.md`: importazione e riepilogo autorevole.
- `catalog/verify_2025_nine_card_materials.py`; `VERIFICATION.json`: confronto delle impronte dei 90 estratti e gruppi URL con le evidenze browser, integrità SQLite, chiavi esterne, idempotenza anche con quantità NULL, preservazione di tutte le righe originarie e dati estranei al contest.

Importazione provata su copia e applicata dopo backup SQLite in `outputs/2025-nine-card-materials/before-import.sqlite3`, hash in VERIFICATION.json. Ripetizione identica verificata anche sull'operativo. API locale: 89 complete/94, 5 blocked; dettaglio entry ordinaria, WIP non osservabile e frammento Brawl controllati. Scheda contest renderizzata nel browser con dati aggiornati; le icone L indicano presenza di scansione, non completezza. Sezioni annuali A/B rigenerate con il generatore; sezioni qualitative e registro aggiornati nello stesso incremento.

## Chiusura e prossimo passo

Deliverable verificati e tutti gli esiti espliciti: task MAT concluso con cinque blocchi documentati, senza dichiarare 100% dei primi post osservabili. PWS invariato 1.5.0; nessun controllo periodico ripetuto, calendario non modificato. Nessun nuovo pattern da consolidare nella skill: applicate le distinzioni esistenti fra primo post, placeholder e risorse esterne.

Prossimo approfondimento utile: riconciliazione roster ElementaBrawl in incremento distinto; eventuale ACQ dedicato al singolo contest 9-Card 2025 dopo selezione dei giochi, con host e condizioni da verificare. Nessun monitoraggio ordinario del contest concluso. Incremento coerente pronto per commit dedicato, su richiesta; messaggio proposto `Censisci materiali dichiarati del 9-Card Nanogame 2025`. Database, backup e materiali esclusi da Git; modifiche preesistenti preservate.

## Contratto

## Salvataggio Git autorizzato — 2026-10-04

L'utente richiede «commit e push». PWS resta allineato a 1.5.0. Verificati `.gitignore`, remoto origin e assenza di divergenze dopo fetch; database e backup esclusi. Preparato commit dedicato: 15 file, registro ricostruito da HEAD con sola TSK-0051 e cruscotto con soli sei gruppi di differenze MAT più riepilogo; tutte le altre modifiche locali preservate. Verifica dell'indice `git diff --cached --check` superata. Esito e identificativo del commit sono verificati nella chat; nessun ampliamento agli altri task.

## Contratto del censimento
Censimento dichiarativo dei materiali delle 94 entry già registrate del contest 13, incluse ritirate. Risoluzione WIP dal roster BGG ufficiale e lettura completa dei primi post originali. Risorse URL con menzioni, funzione e forma tecnica provvisorie; requisiti espliciti con evidenza, fonte e data. Copertura first_post_only. Esclusi altri contest, classifiche, host esterni e download.

## Input e deliverable
Roster operativo esistente e https://boardgamegeek.com/thread/3436343/2025-9-card-nanogame-print-and-play-design-contest. Deliverable: evidenze per entry, dataset riproducibile, importazione verificata su copia e database operativo, riepilogo fonti, aggiornamento cruscotto e registro.
Successo: 94 esiti espliciti, distinguendo lettura completa, WIP non individuato e post non osservabile; integrità SQLite e foreign key verificate. Nessuna assenza inferita da letture parziali.

## Apertura e continuità
PWS aligned_version e VERSION canonica: 1.5.0. Preflight sandbox riuscito. main allineato al riferimento locale origin/main, con modifiche non committate preesistenti preservate; nessuna verifica del remoto server. TSK-0009 storico riguarda cinque altri contest e non viene ampliato. Skill applicate: bgg-contest-navigation e bgg-material-census, playbook e inventario letti. Titolo chat aggiornato secondo convenzione.

## Riesame mirato autorizzato — 2026-11-06

L’utente approva il prossimo passo proposto nella chat ACQ TSK-0087: approfondimento MAT dei dodici casi dipendenti, stesso contest 13. Si riprende TSK-0051, precedente ciclo concluso preservato; incremento autonomo mirato senza duplicare task né ampliare ACQ. Entry 445/447/456/457/458/459/461/462/463/466/467/468: otto primi post senza risorse URL dichiarate, Three Buccaneers introduzione non osservabile, tre WIP non individuati. Obiettivo: rivedere integralmente primi post originali e fonte ufficiale per WIP mancanti, risolvere anchor/componenti dinamici, registrare riferimenti/requisiti dichiarativi, assenze e limiti con date. Esclusi host esterni, download, ulteriori post come fonte materiale primaria, modifiche identità/roster/IMG/schema/APP/Git. Brawl resta fuori dal lotto. Deliverable: manifest comparativo dei 12 esiti e riferimenti, prove locali, eventuale importazione dichiarativa dopo copia/idempotenza/backup/ripristino e cruscotto; nessuna attestazione ACQ completa per implicazione. Client autore Codex desktop; titolo primario chat ACQ pertinente all’intera storia, collegamento MAT da registrare senza rinominare percorsi. PWS 1.5.0 mantenuto come deliberato rispetto al canonico 1.8.0; nessuna migrazione. Stato/handoff locale letto, nessun lock condiviso; main con modifiche pregresse preservate, lettura/git tramite runtime riusciti. Skill base BGG e bgg-material-census rilette con playbook; computer-use per navigazione autorizzata.

### Riesame mirato concluso — 2026-11-06

Dodici esiti in catalog/2025_nine_card_mat_revisit_2026-11-06.json e REVISIT_REPORT_2026-11-06.md: otto letture originali complete confermano nessun URL materiale; quattro blocchi (Three Buccaneers originale esplicitamente eliminato, tre WIP non individuati). Requisiti delle otto entry confrontati e invariati, nessuna integrazione da regolamenti. Immagini The King of Arcades denominate rule/card senza istruzione esplicita di stampa restano escluse nel contratto MAT. Componenti BGG dinamici di Dice Production/Main Line Mayhem/Psychodynamic Fronts risolti verso il solo contest e non trasformati in risorse. Nessun host esterno aperto o materiale scaricato.

Nuova evidenza specifica: roster ufficiale articolo 45443446 associa la seconda N/A a J Mayer @agentdynamo; baseline locale attribuiva Ryan Shaffer, autore che precede la riga con Three-Legged Race. Annuncio del ritiro di Triplicity del 2 aprile 2025 nell’articolo 45896192 verificato direttamente nel thread del contest. Titolo candidato conservato per entry 467, non WIP recuperato e non correzione del censimento/identità. Causa della discrepanza non dimostrata, possibile errore precedente di associazione; storia preservata, niente rinomina/merge/crediti operativi modificati. Ricerche BGG WIP per HMS Ulven/Triplicity senza risultati; zardon 13 risultati senza candidato 2025, uno 2026 e resto 2016–2024. Fallback web BGG mirati restituiscono soltanto annuncio Triplicity pertinente. La scansione integrale pagine 2–24 è quella storica, non ripetuta o retrodatata nel presente incremento.

Importazione dichiarativa inclusa nella prosecuzione del workflow autorizzato: 12 nuove entry_resource_scans, 12 entry_material_scans e 12 entry_work_observations materials, tutte append-only. REVISIT_PREPARATION_VERIFICATION_2026-11-06.json: copia, 36 inserimenti, zero al replay, impronte complete backup/ripristino e tutte le righe pregresse preservate. REVISIT_OPERATIONAL_VERIFICATION_2026-11-06.json: backup/hash, transazione esclusiva, operativo identico alla copia, integrità ok/FK vuote; replay RO dodici esiti e zero scritture. Entry/identità/crediti/risorse/requisiti/ACQ/IMG e ogni tabella estranea invariati. Nessuno schema/APP nuovo. A/B rigenerate prima del riepilogo; app browser conferma MAT 89/94, ACQ 68/93 e IMG 17/94 invariati.

Client autore Codex desktop. Titolo precedente chat: T0087-26.10.13 - ACQ - 9-Card Nanogame 2025. Titolo proposto e applicato/verificato tramite set_thread_title: T0087-26.10.13 - ACQ - 9-Card Nanogame 2025 e recupero MAT. Primary TSK-0087 preservato, TSK-0051 collegato nel registro; il titolo del registro MAT conserva T0051 e la propria apertura. PWS 1.5.0 mantenuto, nessuna migrazione rispetto al canonico 1.8.0. Nessuna scrittura Standard, Git o calendario monitoraggio.

Verifica efficacia skill: bgg-material-census/base navigazione efficaci per distinguere lettura completa, post eliminato, WIP non trovato e immagini non autorizzate come stampabili. Il componente lazy richiede visibilità: click su testo del post ha risolto il solo riferimento al contest; nessun nuovo pattern rispetto al playbook. Un locator di titolo composto non corrispondente per Main Line Mayhem sostituito con nuova lettura DOM, che mostrava link già risolto. Computer-use efficace per lettura e controlli, nessun download/evento bloccante. Il fallback iniziato con credito storico errato per N/A è stato corretto dopo evidenza ufficiale, producendo il candidato Triplicity: causa a monte nella baseline da riconciliare, non prova di difetto skill. Nessuna manutenzione tecnica necessaria; evidenza candidata TSK-0048 soltanto se il futuro riesame identità dimostra un pattern di disallineamento tra colonne roster.

Prossimo approfondimento utile: riconciliazione distinta della voce N/A 467 rispetto a J Mayer/Triplicity, prima di ulteriori MAT/ACQ su quel candidato. Gli altri dodici esiti restano documentati senza promessa di nuovi file. TSK-0087 conserva i 25 residui e lo stato bloccato rispetto al 100%; questo ciclo MAT è concluso. Incremento pronto per commit selettivo su richiesta, nessun commit/push eseguito.

### Handoff rettifica roster TSK-0005 — 2026-11-06

Entry 467 riconciliata operativamente come Triplicity/J Mayer @agentdynamo, designer verificato. Ryan Shaffer è il designer della riga precedente Three-Legged Race; note storiche preservate. Annuncio originale 45813595 mostra destinazione eliminata, nessun URL WIP utilizzabile. Rapporto ENTRY467_REPORT_2026-11-06.md nel task annuale 2025; nessun incremento MAT/ACQ, conteggi invariati. Per questa entry il blocco corrente è riferimento eliminato, non identità irrisolta.

## Approfondimento mirato oltre il primo post — deliberazione 2026-11-06

Conferma esplicita utente «procedi su tutti in sequenza»: integrazione circoscritta dei messaggi successivi dei WIP di Forest Tip409, Ocean Path426, Slayer438, Stand of Supremacy442, Tralim450 e otto entry senza URL 445/456/457/461/462/463/466/468. Fonti BGG, nessun altro contest. Ricerca di riferimenti sostitutivi e materiali dichiarati dall’autore; conservare autore/data/post/URL e distinguere materiali di terzi/commenti. Non riscrivere baseline first_post_only né alterarne completezza sulla sola lettura dei commenti; evidenze supplementari separate. Eventuali host/download solo nel successivo incremento ACQ TSK-0087 già autorizzato per i materiali selezionati gratuiti IT/EN. Nessun sollecito o duplicazione richieste T0098; nessun Git/schema/APP/IMG. Criterio: ogni candidato con esito verificato o residuo esplicito; inventari/hash se file recuperati, copia/replay/backup/integrità prima di registrazione operativa, cruscotto aggiornato.

### Chiusura approfondimento mirato dei tredici WIP — 2026-11-06

Tutti i tredici casi autorizzati esaminati, con conteggi post e pagine nel manifest sequenziale. Stand of Supremacy26post/2pagine, ForestTip8, OceanPath22, Slayer18, Tralim10, King5, DailyDungeon7, DiceProduction1, MainLineMayhem1, Network2, Psychodynamic1, ThreeLegged1, UHBC4. Nessun URL sostitutivo per quattro riferimenti rimossi o Tralim; sette idee senza file. Per King of Arcades verificati originali rule01-05 e card, regole dichiarano PnPready: sei risorse/menzioni/osservazioni e nuova scansione correttiva datata, vecchie esclusioni preservate. Successiva ACQ separata conclusa con sei PNG e attestazione completa. Scansioni dei commenti conservate in observations con coverage supplementare, non alterano completezza first_post_only. MAT89/94 invariato. Tre stadi separati identity/MAT/ACQ con copia/replay/backup/ripristino/integrità/FK verificati; rapporti nel task0087, A/B e PROJECT_PROGRESS aggiornati prima della chiusura. Skill base/MAT/ACQ efficaci, miglioramento candidato sulle risorse operative incorporate; nessuna modifica skill. Client Codex desktop e titolo cumulativo0087 invariato. Nessun Git.

## Salvataggio Git verificato — 2026-11-06

Commit selettivo6264a2b0fb12b5bff8b70642825919481aa0eed2 su main,87file pertinenti; push origin/main riuscito e riferimento server verificato tramite ls-remote. Audit indice e commit in uscita: zero nuovi rilievi,36Python compilati, nessun database/materiale/screenshot/ID privato incluso. Audit generale segnala299candidati in30file storici già remoti e invariati, distinti dal perimetro pubblicato; nessuna riscrittura. Test codice selezionato14passati/3saltati nella copia senza operativo, integrazione RO separata su operativo conferma70/92 e vecchi ID→473. Modifiche estranee preservate; dati in library/database restano locali. Questa attestazione è un commit documentale successivo al commit dati.
