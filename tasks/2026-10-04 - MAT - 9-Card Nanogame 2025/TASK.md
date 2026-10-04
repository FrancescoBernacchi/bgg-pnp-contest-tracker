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
