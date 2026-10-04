# Pre-analisi della classificazione e del monitoraggio dei task

Data della verifica: 2026-10-04, Europe/Rome. Proposta preliminare: non modifica le convenzioni vigenti.

## Perimetro ed evidenze

Inventariati 42 TASK.md della checkout principale e un registro aggiuntivo nella worktree 52fb: 43 registri preesistenti. Il task corrente porta il totale osservato a 44, con 43 registri nella checkout principale. Consultati contratti, sezioni di stato e chiusura, documentazione autorevole, elenco delle chat recenti e due chat pertinenti di verifica Git e acquisizione Wargame. Non è una lettura integrale di tutte le conversazioni storiche: l'elenco dell'app è limitato alle 50 chat recenti non fissate, oltre alle fissate; chat archiviate e storie remote non censite integralmente. L'inventario completo qui riguarda i registri locali osservati, non tutte le chat mai esistite.

PWS allineato a 1.5.0. Prima delle scritture, main pulito a `2987d51`, coincidente con il riferimento locale origin/main. Sei checkout ispezionate: cinque pulite; 52fb contiene il TASK.md Wargame non tracciato. Tutti i branch locali risultano già contenuti in main. Nessun fetch: la situazione attuale del server GitHub non è verificata. Nessun accesso esterno BGG o Kanare.

Fonti locali: AGENTS.md; PROJECT.md, sezione Tipi standard di attività BGG; PROJECT_PROGRESS.md; .workspace/PROJECT_STATE.md; tutti i TASK.md inventariati; git status, log, branch e worktree list. Chat supplementare: `2026-10-02 - Quadro Kanare e verifica task Git`; chat Wargame restituita dall'app come `2026-10-02 - Acquisizione materiali - 2026 Print and Play W…`, ID 01a0fea0-9fd8-7b11-b96d-f67b02e096e0.

## Coerenza con le regole attuali

1. Evoluzione e gestione del progetto sono categorie utili, ma la ricorrenza deve essere un campo separato. Creare un cruscotto è un intervento circoscritto; mantenerlo è attività continuativa. Un singolo censimento può essere circoscritto pur appartenendo a un processo ricorrente.
2. Evolutive App diventa **Sviluppo e manutenzione dell'app**: comprende funzionalità, correzioni, refactoring e verifiche necessarie. Schema e importazioni hanno esempi sufficienti per una categoria distinta.
3. Esplorazione nuova fonte diventa **Ricerca e valutazione delle fonti** per la selezione dei candidati e la prima esplorazione. Il successivo censimento non è più prima conoscenza.
4. Analisi Anno BGG diventa **Censimento annuale BGG**, coerente con l'unità di un solo anno e le esclusioni dei WIP/materiali. La richiesta di includere sistematicamente le classifiche va deliberata: il contratto corrente elenca posizione delle entry, ma non censimento integrale di categorie, voti e risultati. I task storici hanno raccolto risultati: è un'evidenza storica, non un'estensione implicita del workflow attuale. Proposta: includere risultati e categorie ufficiali del contest, senza WIP né host esterni, precisando deliverable e copertura; in alternativa separare una categoria Risultati BGG se si preferisce un ciclo indipendente. Non introdurla ora senza questa decisione.
5. Analisi materiali resta per singolo contest BGG: comprende risorse dichiarate e componenti fisici, separando analisi dai controlli degli host e dai download. Per Kanare il perimetro va espresso secondo il contratto della fonte, senza imporre un contest inesistente.
6. Acquisizione materiali resta **selettiva e autorizzata**, con manifest, hash e versioni. «Tutti i materiali» non può significare ogni lingua, variante o destinazione senza delimitazione: proposta «tutti i materiali nel perimetro approvato», con completezza distinta da esiti bloccati o non osservabili.
7. **Acquisizione immagini** è una categoria futura, non ancora un workflow BGG approvato. Distinguere fotografie/illustrazioni rappresentative del gioco dalle immagini PNG che sono componenti PnP e appartengono già ai materiali. Definire immagini pertinenti, varianti, diritti, originali/derivati, manifest e supporto app. Per Kanare esiste già una decisione specifica su immagine rappresentativa e selezione delle secondarie: armonizzarla, senza cancellarla.
8. Mancano censimento globale e monitoraggio per contest, due dei cinque tipi BGG vigenti. Non assorbirli genericamente nella gestione progetto.
9. Altro può restare residuale, con motivazione e revisione. Nessuno dei 43 registri osservati richiede questa categoria se si adottano le integrazioni seguenti.

## Tassonomia proposta

Una categoria primaria per task; eventuali temi secondari come etichette. Le sigle sono suggerimenti, non ancora convenzioni.

| Sigla | Categoria | Confine pratico |
|---|---|---|
| EPR | Evoluzione del progetto | Scopo, regole, architettura organizzativa, strategie e formalizzazione |
| GPR | Gestione del progetto | Coordinamento, registri, priorità, verifica trasversale e supporto Git |
| APP | Sviluppo e manutenzione dell'app | Codice e comportamento dell'app, funzionalità e correzioni |
| INF | Ambiente e strumenti | Diagnosi runtime, sandbox e strumenti di lavoro |
| FON | Ricerca e valutazione delle fonti | Scoperta, confronto e prima esplorazione di fonti candidate |
| CAT | Censimento delle fonti | Catalogazione di una fonte non BGG già individuata |
| DAT | Modello e gestione dei dati | Schema, migrazioni, importazioni e correzioni strutturali |
| VER | Verifica e riconciliazione | Destinazioni e identità già censite, senza acquisizione |
| BGG-G | Censimento globale BGG | Identità dei contest su tutte le annualità; esclusioni vigenti |
| BGG-A | Censimento annuale BGG | Roster dei contest di un solo anno; risultati da deliberare |
| BGG-M | Monitoraggio contest BGG | Snapshot di un solo contest, secondo calendario |
| MAT | Analisi dei materiali | Risorse e requisiti dichiarati; singolo contest per BGG |
| ACQ | Acquisizione dei materiali | Host e file nel perimetro selezionato e autorizzato |
| IMG | Acquisizione delle immagini | Futuro workflow per immagini rappresentative, distinto dai componenti |
| ALT | Altro | Eccezione motivata, da riesaminare |

INF, CAT, DAT e VER derivano da attività già svolte: evitano di riempire Altro o di chiamare tutto Evoluzione progetto. GPR si distingue da EPR per il deliverable, non soltanto per la durata. Non serve una categoria autonoma Documentazione: la documentazione appartiene alla finalità del task. Per il task multifonte del 20 settembre EPR è primaria e FON secondaria, perché contiene una decisione di direzione del progetto. APP resta separata dall'identificativo della segnalazione APP-007.

## Modalità e stati proposti

**Modalità:** circoscritto (one shot), continuativo (rolling). **Cadenza separata:** su richiesta, periodica, per evento. Un continuativo può avere incrementi conclusi; un task circoscritto può richiedere più sessioni. Il monitoraggio Wargame del 2 ottobre è una rilevazione conclusa di un processo ricorrente: non va riaperto automaticamente soltanto per uniformarlo a rolling. Scegliere in seguito se mantenere un contenitore per contest con incrementi datati oppure task circoscritti collegati; nessun task trasversale esegue più contest.

**Ciclo di lavoro:** proposto, pianificato, in corso, in verifica, completato, sospeso, bloccato, annullato. Sospeso indica una decisione; bloccato un impedimento concreto con condizione di sblocco; annullato abbandono esplicito, non una pausa. Riaperto è un evento storico che riporta in corso. Parziale è copertura del deliverable, non uno stato unico del task. Sostituito/accorpato è una relazione con un successore, preservando lo storico.

**Versionamento, su dimensioni distinte:** salvataggio locale (da committare, committato, non applicabile, da verificare); integrazione (da integrare, integrato in main, non applicabile, da verificare); sincronizzazione (da pushare, sincronizzato con riferimento locale, remoto verificato con data, divergente, non applicabile, da verificare). Un task completato può essere da committare. Un task sospeso può avere una nota da salvare. Commit autorizzato non equivale a eseguito; file tracciato non dimostra che ogni deliverable sia integrato.

**Stato della chat:** attiva/inattiva nel runtime, archiviata/non archiviata, letta/non letta. È separato dallo stato del lavoro: notLoaded e idle non significano completato. Una chat può contenere più registri e un registro può proseguire in più chat.

Registro centrale suggerito: ID stabile, titolo e data originari, categoria primaria e secondarie, modalità e cadenza, scope (fonte/anno/contest), stato dichiarato, stato operativo proposto, ultima verifica e evidenza, prossima azione, dipendenze/successori, percorsi dei TASK.md, ID chat, worktree/branch, commit e versionamento. La rinomina non deve essere la chiave dell'identità.

## Inventario preliminare completo dei registri preesistenti

Nomi sotto riportati delle cartelle locali, non necessariamente titoli delle chat. «Concluso» include le formulazioni originali completato/concluso/chiuso, senza riscriverle. C = circoscritto, R = continuativo. Le categorie e modalità sono proposte; le eccezioni sono esplicite. I riferimenti completi di dettaglio sono TASK.md sotto ciascuna cartella in tasks/.

| # | Cartella task | Categoria | Modalità | Stato / attenzione |
|---|---|---|---|---|
| 1 | 2026-09-04 - monitoraggio contest BGG | BGG-M; secondaria GPR | R | Dichiarato attivo; contenitore storico multi-contest da riallineare ai contratti attuali |
| 2 | 2026-09-04 - SETUP INIZIALE PROGETTO | EPR | C | Completato; naming bootstrap eccezionale |
| 3 | 2026-09-07 - Applicazione locale contest BGG | APP | C | Concluso; note Git storiche superate dalla cronologia |
| 4 | 2026-09-07 - consolidamento conoscenza progetto | EPR | C | Completato |
| 5 | 2026-09-07 - Esplorazione contest BGG 2025 | BGG-A; secondaria MAT | C | Dichiarato riaperto; roster completo, analisi successive mischiate; chiusura da riconciliare |
| 6 | 2026-09-10 - Avvio semplificato app | APP | C | Concluso |
| 7 | 2026-09-10 - Navigazione classifiche app | APP | C | Concluso; vecchia attesa Git non prova un pending attuale |
| 8 | 2026-09-11 - Diagnosi sandbox Windows Codex | INF | C | Concluso; raccomandazione di riavvio storica |
| 9 | 2026-09-11 - Esplorazione contest BGG 2025 - Parte 2 | MAT | C | Dichiarato in corso; multi-contest storico, futura prosecuzione per singolo contest |
| 10 | 2026-09-11 - Navigazione risorse entry | APP | C | Concluso |
| 11 | 2026-09-11 - Visibilità materiali dichiarati | APP | C | Concluso |
| 12 | 2026-09-15 - Censimento globale contest PnP BGG | BGG-G | C | Completato; nuovo incremento globale separato il 2 ottobre |
| 13 | 2026-09-15 - Cruscotto avanzamento raccolta | EPR | C | Concluso; creazione distinta dalla manutenzione ricorrente |
| 14 | 2026-09-18 - Cruscotto navigabile nell'app | APP | C | Concluso |
| 15 | 2026-09-18 - Esplorazione contest BGG 2024 | BGG-A | C | In corso, copertura incompleta e impedimenti documentati; stato operativo da riesaminare |
| 16 | 2026-09-18 - Standardizzazione esplorazioni BGG | EPR | C | Completato |
| 17 | 2026-09-19 - Esplorazione contest BGG 2026 | BGG-A | C | Completato |
| 18 | 2026-09-20 - Catalogo giochi multifonte e Kanare Abstract | EPR; secondaria FON | C | Concluso come esplorazione/formalizzazione |
| 19 | 2026-09-20 - Censimento Kanare Abstract | CAT | C | Primo incremento concluso; completamento in registro successivo, chiusura del contenitore da chiarire |
| 20 | 2026-09-20 - Completamento censimento Kanare Abstract | CAT; secondaria DAT | C | Concluso |
| 21 | 2026-09-20 - Importazione censimento Kanare Abstract | DAT | C | Concluso |
| 22 | 2026-09-20 - Modello dati multifonte Kanare Abstract | DAT | C | Concluso |
| 23 | 2026-09-21 - Acquisizione selettiva materiali Kanare Abstract | ACQ | C | Concluso; non richiede contest BGG |
| 24 | 2026-09-21 - Verifica destinazioni Kanare Abstract | VER | C | Concluso con esiti incerti conservati; incertezza non riapre il task |
| 25 | 2026-10-02 - Analisi materiali - 2026 Print and Play Wargame Design Contest | MAT | C | Concluso |
| 26 | 2026-10-02 - Censimento globale contest PnP BGG | BGG-G | C | Completato |
| 27 | 2026-10-02 - Interfaccia multifonte BGG e Kanare | APP | C | Concluso |
| 28 | 2026-10-02 - Monitoraggio - 2026 Print and Play Wargame Design Contest | BGG-M | C | Rilevazione conclusa; processo ricorrente, prossima finestra registrata 12 novembre |
| 29 | 2026-10-03 - Acquisizione materiali - 2025 Children & Family Game Design Contest | ACQ | C | Concluso con copertura ed esiti documentati |
| 30 | 2026-10-03 - Acquisizione materiali - Roll & Write 2025 | ACQ | C | Concluso con blocchi documentati |
| 31 | 2026-10-03 - Categorie classifiche per contest | APP | C | Concluso, APP-001 |
| 32 | 2026-10-03 - Contatore giochi Kanare | APP | C | Concluso, APP-003 |
| 33 | 2026-10-03 - Layout PDF per orientamento | APP | C | Concluso, APP-002 |
| 34 | 2026-10-03 - Libreria locale dei materiali nell'app | APP | C | Concluso; stessa chat proseguita nel visualizzatore PDF |
| 35 | 2026-10-03 - Libreria per gioco e visualizzatori APP-005 | APP | C | Concluso |
| 36 | 2026-10-03 - Registro segnalazioni app | GPR; secondaria APP | R | Attivo; non implementativo |
| 37 | 2026-10-03 - Ricerca fonti multifonte giochi | FON | C | Chiuso; ulteriore valutazione in registro successivo |
| 38 | 2026-10-03 - Righe compatte avanzamento BGG | APP | C | Concluso, APP-004 |
| 39 | 2026-10-03 - Valutazione fonti con regolamenti gratuiti | FON | C | Concluso; prosegue la stessa chat di ricerca fonti |
| 40 | 2026-10-03 - Visualizzatore PDF locale nell'app | APP | C | Concluso; separato dalla Libreria nel registro locale |
| 41 | 2026-10-04 - Contenuti e varianti Libreria APP-006 | APP | C | Concluso; TASK.md incluso nel commit 2987d51 |
| 42 | 2026-10-04 - Formattazione DOCX APP-007 | APP | C | Concluso; TASK.md incluso nel commit 2987d51 |
| 43 | 2026-10-02 - Acquisizione materiali - 2026 Print and Play Wargame Design Contest | ACQ | C | Sospeso dall'utente il 3 ottobre; solo worktree 52fb, TASK.md non tracciato |

Distribuzione verificata per categoria primaria: APP 16; EPR 5; ACQ 4; BGG-A 3; MAT 2; BGG-G 2; BGG-M 2; CAT 2; DAT 2; FON 2; GPR 1; INF 1; VER 1. Totale 43. IMG e ALT non hanno registri preesistenti assegnati. Il task corrente aggiunge un GPR continuativo.

## Anomalie e priorità del monitoraggio

- **Registro Wargame sospeso fuori da main.** Percorso: `C:/Users/39348/.codex/worktrees/52fb/Progetto PnP Collection/tasks/2026-10-02 - Acquisizione materiali - 2026 Print and Play Wargame Design Contest/TASK.md`. È l'unico pending Git osservato prima di questa pre-analisi. Salvare la decisione di sospensione è utile anche se il task non è completato; non richiede riavviare download. Nessun salvataggio Git eseguito qui.
- **Stati Git storici obsoleti.** Prima app, classifiche e APP-006 dichiarano in punti storici commit non eseguito, mentre cronologia e riferimenti successivi mostrano salvataggi. Conservare il testo originale e aggiungere una verifica successiva, non sostituire l'evidenza storica.
- **2025 Parte 1/Parte 2.** Sono contenitori misti antecedenti alla standardizzazione del 18 settembre. Il titolo annuale non descrive più correttamente la Parte 2. Proporre formalizzazione della copertura conclusa e collegamenti ai futuri task MAT per contest, senza spostare retroattivamente gli originali o fingere che quei task esistessero già.
- **Monitoraggio globale storico.** Dichiarato ricorrente ma contiene baseline, censimenti e codice. Proporre ruolo di coordinamento GPR e successori BGG-M per contest; preservare il ruolo storico. Non continuare rilevamenti multi-contest per la sola rinomina.
- **2024 ancora aperto.** Riprendere il task esistente, non crearne uno equivalente. La classificazione non modifica dati o copertura né risolve gli impedimenti di accesso.
- **Censimento Kanare iniziale.** Primo incremento chiuso e completamento separato: formalizzare relazione di completamento, evitando di considerarlo lavoro pendente duplicato.
- **Chat senza registro.** La verifica Kanare/Git del 2 ottobre non ha TASK.md autonomo nella checkout principale; utile come antecedente di GPR, non conteggiata nei 43 registri. CHAT e TASK.md non hanno relazione uno-a-uno: Libreria/PDF e ricerca/valutazione fonti ne sono esempi.
- **Acquisizione immagini futura.** Proposta evolutiva da registrare ora come idea in questo task, poi formalizzare EPR per il workflow e APP per la consultazione, collegati ma distinti. Nessuna nuova procedura o download autorizzato dalla sola categoria.

## Naming proposto e adozione

La data è il prefisso esistente. Il nuovo elemento sarebbe un codice di categoria subito dopo la data:

`YYYY-MM-DD - SIGLA - descrizione`

Esempi proposti: `2026-10-04 - GPR - Monitoraggio e classificazione dei task`; `2026-10-04 - APP - Formattazione DOCX (APP-007)`; `2026-09-18 - BGG-A - Censimento entry BGG 2024`; `2026-10-02 - MAT - Wargame 2026`.

Categoria stabile nel titolo; stato e cadenza nel registro, per evitare rinomini a ogni incremento. Conservare data di apertura anche quando cambia lo stato. Eventuali titoli brevi devono comunque disambiguare il contest; i percorsi originari restano riferimenti stabili finché non viene deliberata una migrazione. Una chat multi-registro mantiene titolo cumulativo e categoria prevalente, mentre i singoli registri conservano le proprie categorie.

L'adozione modifica le convenzioni locali in PROJECT.md/AGENTS.md e richiede una decisione esplicita sul trattamento storico. Proposta prudente: classificazione retroattiva nel registro con data/evidenza; nuovi titoli conformi per il futuro; rinomina delle chat storiche solo dove utile; nessuna rinomina massiva delle cartelle, che romperebbe riferimenti. Il bootstrap conserva l'eccezione documentata. Sono decisioni proposte, non una migrazione già deliberata.

## Passi successivi separati

1. Concordare categorie, sigle, confini delle classifiche annuali e modalità dei monitoraggi.
2. Formalizzare convenzioni e registro centrale, con collegamenti alle chat e ai registri storici e verifiche Git datate.
3. Gestire il pending Git del TASK.md Wargame sospeso, previa autorizzazione all'operazione Git.
4. Riesaminare gli stati ambigui 2025/Kanare e continuare 2024 nel task esistente.
5. Aprire successivamente un task EPR per proceduralizzare le immagini e un task APP per l'impatto applicativo; acquisizioni future sempre in task autonomi per contest e perimetro approvato.

Nessun monitoraggio automatico configurato: il continuativo indica l'utilizzo della chat/registro nel tempo, non un'esecuzione schedulata.
