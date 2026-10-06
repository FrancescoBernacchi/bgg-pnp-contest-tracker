# MAT - Kanare Abstract

ID: TSK-0070. Apertura: 2026-10-06. Categoria MAT; modalità circoscritto, su richiesta. Stato: completato nel perimetro autorizzato, con blocchi informativi residui.

## Contratto autorizzato

Censimento approfondito di tutti i giochi Kanare già catalogati (baseline attesa 64), distinto dai cinque workflow BGG. Risorse, requisiti effettivi, confezioni, componenti comuni/specifici/stampabili, varianti e condivisioni con provenienza puntuale. Non si applica il limite BGG del primo post.

Consultare pagine ufficiali e regolamenti ufficiali IT/EN; altre lingue solo URL/metadati, JA senza lettura/acquisizione. Riutilizzare tre PDF locali. Nessuna nuova acquisizione persistente nella library, lotto IMG, estrazione immagini, AI, piattaforma online, BGG, archivio web, modifica app o operazione Git mutativa. Documenti e prove integrali restano fuori Git; deliverable contengono riepiloghi originali e metadati secondo PUBLICATION_POLICY.md.

Sequenza obbligatoria: skill v1 → pilota 1 (1–2 giochi) → verifica/revisione/riesame → pilota 2 (5 ulteriori giochi) → verifica/revisione/riesame → tutti i rimanenti. Piloti riutilizzati senza duplicazioni. Revisioni successive soltanto per novità procedurali dimostrate.

Distinguere dichiarazioni, normalizzazioni, inferenze e limiti: ricerca conclusa, parziale, non osservabile, assenza verificata, non dichiarato. Nessuna attribuzione tramite matching candidati/implementazioni incerte. Quattro varianti aggregate da riesaminare solo con prova ufficiale puntuale.

## Input e continuità

TSK-0019/0020 censimenti, TSK-0021 import, TSK-0022 modello generale, TSK-0024 verifica destinazioni, TSK-0023 prima acquisizione. Risultati precedenti preservati; nessun MAT Kanare preesistente identificato. Manutenzione skill collegata a TSK-0048 senza trasferirvi i risultati MAT.

PROJECT.md, TASK_GOVERNANCE.md, PUBLICATION_POLICY.md, database operativo in sola lettura per baseline, 141 risorse dichiarate e manifest dei tre PDF. Skill applicate: skill-creator, pdf, nuova kanare-material-census.

## Deliverable e successo

Skill collaudata e storia revisioni; inventario per tutti i giochi; sintesi componenti; blocchi/quesiti; conteggi distinti di analisi e letture effettive. Fonti, crediti/ruoli, data e posizione evidenza per ogni asserzione. Verifiche copertura, unicità e preservazione baseline. Prima di eventuali scritture DB: compatibilità, prova su copia, backup, idempotenza/integrità; nessuna migrazione architetturale implicita. È ammesso conservare il censimento nel manifest se lo schema non rappresenta adeguatamente i requisiti.

## Preflight

2026-10-06: sandbox operativo, PWS progetto/canonico 1.5.0; main riferito a origin/main con numerose modifiche pregresse conservate, remoto non rilevato. Proprietario .agents: NOTEBOOK-OMEN\\Francesco1. Titolo visibile impostato secondo convenzione. Nessuna modifica Git autorizzata.

## Incrementi

All’apertura: preparazione in corso e piloti non ancora eseguiti. Gli incrementi seguenti documentano il completamento.

### Incremento 1 — primo pilota, 2026-10-06

Skill v1 creata prima dell’analisi. Pentwall/ViceVeresi scelti per PnP e componenti comuni; PDF locali e pagine ufficiali verificati. Revisione v2 e riesame conclusi, dettagli in PILOTS.md. Escluso dal denominatore l’omonimo BGG Ripples con legame rejected preesistente: baseline corretta 64 giochi e 141 risorse. Nessuna decisione storica riscritta.

### Incremento 2 — secondo pilota, 2026-10-06

Cinque ulteriori giochi: Chess Territorial, Abande, LAG, Bloody Queen, Tori Shogi. Letture PDF remote in memoria riuscite; revisione v3 limitata a raccolte, confezioni, varianti e URL multipli. Riesame delle osservazioni interessate concluso. Piloti conservati nel censimento senza duplicazioni. Dettagli, anomalie ed efficacia in PILOTS.md.

### Incremento 3 — restante perimetro e chiusura, 2026-10-06

Applicata v3 ai 57 giochi rimanenti. Nessuna ulteriore revisione: le divergenze nuove erano già gestite dalla procedura e sono dati/limiti dell’inventario. HTML consultato su 75 pagine ufficiali (inclusi set/accessori e pagina dichiarativa Swarm, senza destinazioni online). 62 URL PDF EN consultati: 61 contenuti binari distinti, 163 pagine contando URL; LAG EN doppio URL byte-identico. Tre originali locali riusati; nessun PDF nuovo salvato in library, nessuna immagine acquisita/catalogata. 37 JA, 2 ES, 1 ZH solo URL/metadati; IT non osservati nelle superfici esaminate, senza attestare assenza universale.

Copertura: **64/64 giochi trattati; 62 complete, 1 partial (Candy Chain), 1 blocked (Swarm)**. Completezza è conclusione della ricerca nel perimetro e ricostruzione dalle fonti, non garanzia di ogni informazione dichiarata. Candy Chain: testo 5×5 contro diagramma 8×8 con 48 pezzi, mantenuto il conflitto. Swarm: solo titolo nella matrice ufficiale, nessun materiale puntuale autorizzato osservato. Confezioni e regolamenti divergenti preservati (Dryad, Residuel e surplus), quantità variabili/non dichiarate esplicite. Nessuna acquisizione mascherata da verifica.

Le quattro varianti aggregate hanno fonte ufficiale puntuale nel manifest: link nominativo nell’indice e sezione nominata nel PDF. Collegamenti storici DB conservati. ID generali riusati per giochi/prodotti/risorse/crediti; requisiti nel manifest perché lo schema operativo richiede entry BGG. Nessuna modifica architetturale o importazione SQLite: copia/backup/idempotenza DB non applicabili. Nessuna modifica app, piattaforme, BGG, dati o metriche annuali; A/B del cruscotto non rigenerate.

Deliverable: skill `.agents/skills/kanare-material-census/SKILL.md`; PILOTS.md; INVENTORY.md; COMPONENTS_AND_LIMITS.md; manifest `catalog/kanare_material_census_2026-10-06.json`; VERIFICATION.json e PUBLICATION_REVIEW.json. Helper di baseline/consultazione/rigenerazione/verifica nel catalog. Testi integrali, dump di baseline e rendering locali in outputs escluso da Git, non nei deliverable pubblicabili.

Verifiche: copertura/unicità 64 giochi e 141 risorse, 39 prodotti; zero duplicazioni osservazioni URL; attribuzioni varianti, esclusioni lingue e fonti; tre hash originali ACQ corrispondenti; tabelle baseline identiche al DB attuale, integrity_check=ok e zero FK; rigenerazione offline byte-identica. Audit statico 9 skill / 31 riferimenti / zero errori; validatore standard non eseguibile per PyYAML assente (nessuna installazione). Nuovi deliverable: zero candidati euristici di pubblicazione, riesame manuale di riepiloghi originali, metadati e attribuzioni; nessuna licenza inventata. git diff --check superato; main 0/0 rispetto al riferimento locale origin/main, senza verifica del server o operazioni Git mutative. Modifiche pregresse preservate.

Efficacia skill-creator/pdf/kanare-material-census: risultato atteso di copertura del perimetro raggiunto; piloti e limiti documentati. Rete sandbox indisponibile (WinError 10051) risolta con consultazione in sola lettura autorizzata fuori sandbox, senza setup refresh error; bs4 assente risolto con HTMLParser standard; UTF-8 esplicito per output Windows. Una prima rigenerazione ha richiesto l’esportazione del legame generale product_source_records e l’inserimento del riepilogo Tori Shogi, senza cambiare la procedura della skill o il perimetro. Quantità/diagrammi critici riesaminati; Candy Chain e Swarm sono limiti delle fonti, non difetti procedurali. Migliorie e collaudo collegati a TSK-0048. Nessuna generalizzazione a lingue o fonti escluse.

Prossimo passo: eventuale ACQ Kanare selettivo separato per giochi con componenti già disponibili all’utente, oppure chiarimento ufficiale Candy Chain/Swarm senza contattare terzi automaticamente. Proposte concrete in COMPONENTS_AND_LIMITS.md. Commit suggerito, non eseguito: `Censisce i materiali Kanare e collauda la skill dedicata`. Nuovo task MAT chiuso; blocchi informativi restano tracciati e non risolti per deduzione.

## Salvataggio Git — 2026-10-06

Commit selettivo `f5b3ee0ef99a6360504f5582f09bafdb002a3991` su main, autorizzato dall’utente con «commit e push»: 22 file MAT/skill e sole integrazioni pertinenti nei documenti condivisi. Modifiche degli altri task preservate. Audit dei blob selezionati: zero candidati; audit generale: 299 candidati preesistenti esterni all’incremento, non pubblicati come nuove modifiche. Riferimento remoto uguale alla baseline prima del commit; nessun altro commit locale in uscita. Push autorizzato, da verificare dopo l’esecuzione.
