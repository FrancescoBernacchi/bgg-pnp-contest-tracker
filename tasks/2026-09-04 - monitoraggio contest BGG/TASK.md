# Monitoraggio contest BGG

## Stato

Attivo e ricorrente.

## Scopo

Costruire e mantenere il registro storico dei contest di game design Print and Play ospitati su BoardGameGeek, ordinabile dai più recenti ai più vecchi. Il registro deve consentire aggiornamenti periodici senza perdere gli stati e i valori osservati in precedenza.

Questo task opera al livello dei contest e del monitoraggio leggero delle relative entry. Per ogni entry conserva soltanto i metadati necessari a misurare partecipazione e avanzamento del contest. Non acquisisce, scarica o archivia giochi, regolamenti, componenti o altri materiali.

## Fuori scope

- download o acquisizione dei materiali Print and Play;
- catalogazione editoriale o ludica dettagliata dei singoli giochi oltre ai metadati necessari al monitoraggio dell'entry;
- valutazione o selezione dei giochi da acquisire;
- apertura, download, analisi o validazione dei file delle singole entry; è ammessa soltanto la registrazione della disponibilità dichiarata dalla fonte;
- creazione o aggiornamento della libreria locale dei giochi.

Le entry possono essere considerate soltanto come elementi conteggiabili, collegamenti di provenienza o evidenze utili a descrivere avanzamento, partecipazione, votazioni e risultati del contest.

## Perimetro confermato

- Fonte iniziale unica: BoardGameGeek.
- Contest inclusi: tutti i contest di game design inerenti il Print and Play e quelli similari con una pagina, un thread o una GeekList identificabile su BGG.
- Edizioni annuali trattate come contest distinti e collegate a una stessa serie.
- Inclusi contest attivi, annunciati, conclusi e storici rintracciabili.
- Esclusi giveaway, concorsi non legati al game design e iniziative esterne soltanto menzionate su BGG.

I casi affini ma non chiaramente PnP vengono registrati prima in una coda `da_valutare` e sottoposti all'utente prima dell'inclusione stabile. Opportunità interessanti esterne al perimetro possono essere segnalate senza inserirle automaticamente nel catalogo principale.

## Input

- Thread principale ufficiale del contest.
- GeekList ufficiale delle entry, quando presente.
- Thread o post ufficiale dei risultati.
- Eventuali pagine BGG collegate indicate dagli organizzatori.

## Deliverable

1. Registro delle serie di contest e delle singole edizioni.
2. Stato corrente normalizzato e stato specifico dichiarato dalla fonte.
3. Cronologia delle osservazioni e dei cambi di stato.
4. Calendario completo delle fasi: annuncio, apertura entry, chiusura submission, sviluppo, freeze, playtest, voting, chiusura voting, pubblicazione risultati e altre scadenze dichiarate.
5. Statistiche per contest, con valore, definizione, fonte e data di verifica.
6. Registro leggero delle entry con titolo dichiarato, autore o username, URL, stato dichiarato e normalizzato, date di prima e ultima osservazione, ultima modifica osservata, presenza dichiarata dei materiali e stato di partecipazione.
7. Vista ordinata dal contest più recente al più vecchio e coda dei contest da ricontrollare.

## Modello informativo richiesto

### Identità del contest

- serie e numero/anno dell'edizione;
- titolo originale e titolo normalizzato;
- lingua e ambito geografico, se dichiarati;
- organizzatori e sponsor;
- URL canonici BGG e identificativi BGG;
- relazione con edizioni precedenti e successive.

### Stato e avanzamento

- stato specifico dichiarato dalla fonte;
- stato normalizzato: `annunciato`, `entry_aperte`, `sviluppo`, `freeze`, `voting`, `in_attesa_risultati`, `concluso`, `sospeso`, `annullato`, `sconosciuto`;
- avanzamento calcolato dalle fasi, mantenuto separato dai dati originali;
- data e ora dell'ultima verifica;
- prossima scadenza e indicatore di ritardo o incongruenza.

### Fasi e scadenze

Ogni fase conserva tipo, etichetta originale, inizio e fine previsti, date effettive quando note, fuso orario, precisione della data, stato della fase, fonte e note. Le modifiche alle date non sovrascrivono le osservazioni precedenti.

### Statistiche

Le metriche possono includere entry annunciate, valide, ritirate, incomplete e squalificate; giochi con file disponibili; partecipanti; categorie; votanti; voti o valutazioni valide; playtest/feedback; vincitori e piazzamenti; thread post e subscriber quando utili. Ogni osservazione conserva nome originale, valore normalizzato, unità, metodo di conteggio, fonte e data.

### Monitoraggio delle entry

Per i contest attivi, ogni rilevazione può registrare le entry presenti nella lista ufficiale e il loro stato dichiarato, normalizzato in `idea`, `wip`, `components_available`, `playtest_ready`, `contest_ready`, `withdrawn`, `incomplete`, `disqualified` o `unknown`. Il sistema deve poter ricostruire quante entry sono state aggiunte, rimosse o hanno cambiato stato tra due verifiche. La presenza dei materiali viene registrata solo quando dichiarata o visibile come metadato, senza aprire o scaricare i file.

## Politica di aggiornamento

- Aggiornare prima i contest con una fase aperta o una scadenza imminente, poi quelli annunciati, in attesa di risultati e infine lo storico.
- Nei contest aperti o in sviluppo, rilevare anche nuove entry, ritiri e transizioni di stato delle entry.
- Registrare una nuova osservazione quando cambia uno stato, una data o una statistica; non cancellare il valore precedente.
- Marcare separatamente dati ufficiali, dati ricavati e inferenze.
- Segnalare date contraddittorie o dichiarate come soggette a modifica.
- Non aprire attività di acquisizione, non scaricare materiali e non popolare la libreria dei giochi nell'ambito di questo task.

## Criteri di successo

- Ogni contest nel perimetro ha almeno una fonte BGG verificata e una data di verifica.
- Le fasi note sono rappresentate senza ridurle a una sola data di inizio/fine.
- Stato originale e stato normalizzato restano distinti.
- Le statistiche sono storicizzate e riconducibili alla fonte.
- L'aggiornamento periodico produce una lista chiara di cambiamenti, scadenze e anomalie.
- La chiusura del task, se mai richiesta, documenta verifiche, decisioni e risultati promossi nei file autorevoli.

## Decisioni iniziali

- 2026-09-04: task impostato come registro ricorrente, non come rilevazione una tantum.
- 2026-09-04: ordinamento operativo dal più recente al più vecchio.
- 2026-09-04: BGG resta l'unica fonte iniziale, in conformità con il progetto.
- 2026-09-04: l'utente conferma l'inclusione di tutti i contest PnP e similari presenti su BGG.
- 2026-09-04: i casi dubbi e le opportunità adiacenti devono essere sottoposti all'utente prima dell'inclusione stabile.
- 2026-09-04: l'utente ribadisce che il task riguarda esclusivamente monitoraggio e gestione del database dei contest e della loro evoluzione; download e gestione dei giochi sono fuori scope.
- 2026-09-04: l'utente include il Bad Comet Cozy Game Design Contest nel monitoraggio; per questo contest esterno le entry sono registrate selettivamente solo quando caratterizzate come PnP o similari archiviabili.
- 2026-09-04: il perimetro viene esteso al monitoraggio leggero delle entry per misurare numero di giochi caricati e relativo stato nei contest attivi, senza acquisizione o analisi dei materiali.

## Evidenze iniziali

- 2026-09-04: individuate su BGG edizioni recenti di contest PnP con calendari e stati differenti, tra cui 2026 In-Hand, 2026 Two-Player, 2026 9-Card Nanogame, 2026 Solitaire e 2026 54-Card, oltre a edizioni storiche. Questo conferma la necessità di modellare fasi multiple, variazioni delle date, risultati e serie annuali.

## Prossimi incrementi

1. Censire le serie attive e le edizioni 2026, quindi procedere a ritroso.
2. Produrre il primo report di stato e la coda di ricontrollo.
3. Eseguire un secondo rilevamento per verificare la ricostruzione delle variazioni.

## Incrementi completati

- 2026-09-04: verificato il modello dati iniziale.
- 2026-09-04: aggiunta la migrazione `001_contest_monitoring.sql` per serie, fonti, fasi, controlli periodici, cronologia degli stati, metriche ed evoluzione leggera delle entry; aggiornato anche lo schema autorevole per i nuovi database.
- 2026-09-04: creata la baseline esplorativa 2026 con otto contest inclusi, fonti, prime fasi, stati e metriche disponibili; prodotto il primo report operativo e separato un candidato esterno da valutare.
- 2026-09-04: incluso il 2026 Bad Comet Cozy Game Design Contest come contest adiacente selettivo e registrato un primo sottoinsieme di quattro entry con disponibilità PnP dichiarata, senza aprire o scaricare materiali.
- 2026-09-04: secondo passaggio Bad Comet; aggiunta `Lanternwood` come entry affine con prototipo digitale dichiarato. `A Distant Harvest` e gli altri casi senza conferma di disponibilità restano in verifica.
- 2026-09-04: censita integralmente la GeekList ufficiale del 2026 Solitaire Print and Play Contest: 89 entry su quattro pagine, con posizione, titolo, autore/username, thread WIP e stato derivato dai soli metadati pubblici. La precedente osservazione di 56 entry resta nello storico; nessun materiale è stato aperto o scaricato.
- 2026-09-04: aggiornato il 2026 Turkish PnP Contest dopo l'annuncio ufficiale del 31 agosto: playtest prorogato al 7 settembre 23:59 TRT e voto rinviato senza nuove date. Censite dal post ufficiale 14 entry attive con file completati e 6 ritirate; nessun materiale aperto o scaricato.
- 2026-09-04: individuato il thread principale canonico `3761810` del 2026 Traditional Deck Game Design Contest. Confermati calendario e gestione tramite Design Contest Hub, senza GeekList; censite 18 entry uniche dalle categorie ufficiali, di cui 6 solo e 14 multiplayer con due sovrapposizioni.
- 2026-09-04: censite 17 entry del 2026 54-Card Game Design Contest dalla lista ufficiale Best Game nel thread BGG. Aggiunte le fasi earliest-public e playtest; confermato che la versione corrente corregge il refuso `November 31st` in 30 novembre. Gli stati individuali restano prudentemente parziali quando il thread WIP non e' identificato.
- 2026-09-04: censita integralmente la GeekList del 2026 Print and Play Wargame Design Contest: 18 entry, tutte collegate al thread WIP. Confermato lo stato `entries_open` fino al 1 ottobre e registrato il calendario fino alla chiusura del voto del 21 dicembre; nessun materiale aperto.
- 2026-09-04: completato il 2026 Two-Player PnP Contest: 45 giochi effettivi su 46 item della GeekList, un ritirato, calendario completo e risultati ufficiali. Registrati il podio generale e i primi tre posti delle sette ulteriori categorie di gioco; Migoyugo vince Best Game.
- 2026-09-04: completato il 2026 9-Card Nanogame PnP Contest dal thread ufficiale: censiti 69 progetti (44 Contest Ready, 11 Component Ready, 8 Idea Phase, 6 ritirati), sette fasi temporali e 58 piazzamenti ufficiali. OBOLUS vince Best Overall e Jury Prize; nessun materiale di gioco è stato aperto o scaricato.
- 2026-09-04: completato il 2026 In-Hand Game Design Contest: la lista ufficiale corrente conta 22 finalisti e 3 ritirati, correggendo senza cancellarla la rilevazione preliminare di 23 attivi. Registrati calendario completo e 69 piazzamenti in nove categorie; Glyph Knight vince il solo, Show of Hands il multiplayer e Qu1rr3l il premio playtester. Nessun materiale aperto o scaricato.
- 2026-09-04: eseguito il secondo snapshot del 2026 54-Card Contest. Le 17 entry e le categorie già censite sono invariate; aggiunte le metriche Best Party (2), Best Artwork (7) e Best New Designer (4). Il controllo `no_change` e lo stato di tutte le entry sono stati storicizzati senza aprire materiali.
- 2026-09-04: su indicazione dell'utente, il secondo accesso 54-Card dello stesso giorno viene riclassificato concettualmente come verifica di consistenza e non come rilevamento periodico. Creato `sources/MONITORING_CALENDAR.md` e promosso in `PROJECT.md`, `AGENTS.md` e nello stato PWS un protocollo durevole basato su controlli settimanali, scadenze, assenza di duplicati giornalieri e separazione tra monitoraggio e download.
- 2026-09-05: incluso il 2026 Children & Family Game Design Contest, erede esplicito del Children's Game Print & Play Contest. Censite 36 entry finali (5 Children's e 31 Family) e 2 ritirate, con calendario e metadati descrittivi; la discrepanza fra intestazione e lista è preservata. Le classifiche restano il prossimo approfondimento; nessun materiale è stato aperto o scaricato.
- 2026-09-05: completata la baseline risultati Children & Family dal post ufficiale: 43 piazzamenti in cinque categorie. Excuse Me, Bear! vince Children's e Rulebook; Oh My Gods! Family; Juicy Fruit Salad Art; Alien Tongue Theme. Registrata la pubblicazione in due passaggi del 19-20 maggio senza creare un nuovo rilevamento periodico; nessun materiale aperto o scaricato.
- 2026-09-05: valutato il 2026 Solomode Contest come candidato adiacente distinto dal Solitaire PnP. Il contest riguarda varianti solitarie per giochi esistenti, con PDF richiesto solo per eventuali componenti personalizzati; conta 21 entry principali ed è concluso. Inclusione sospesa perché le entry non sono necessariamente esperienze PnP autonome e possono richiedere il gioco base.
- 2026-09-05: su decisione dell'utente, incluso stabilmente il 2026 Solomode come contest adiacente suscettibile di trattamenti futuri differenti. Censite 21 varianti dipendenti dal gioco base, cinque fasi, 63 piazzamenti di gioco in otto categorie, tre Most Valuable Playtester e statistiche del voto (40 voti, 17 votanti, media 2,35). Nessun regolamento o componente aperto o scaricato.
- 2026-09-05: creata la migrazione `002_contest_scope_and_entry_dependencies.sql`. Aggiunti per i contest `scope_type` e `treatment_profile` e per le entry `entry_kind` e `base_game_dependency`; classificati retroattivamente Traditional Deck come `format_adjacent`, Bad Comet come `selective_entries` e Solomode come `dependent_variants`. Verificate sia la ricostruzione pulita sia la migrazione di una copia del database, entrambe senza violazioni referenziali.
- 2026-09-05: creata la migrazione `003_monitoring_views.sql` con cinque viste di consultazione per quadro generale, PnP principali, contest adiacenti, giochi autonomi e varianti dipendenti. La vista generale espone conteggi e prossima fase utile. Verificati 11 contest (8 core, 3 adiacenti), 344 entry autonome e 21 dipendenti sia su ricostruzione pulita sia su copia migrata, senza violazioni referenziali.
- 2026-09-05: aggiunto `app/generate_monitoring_report.py`, che produce un cruscotto Markdown dal solo database locale usando le viste operative. La migrazione `004_monitoring_view_schedule.sql` rende disponibile la data iniziale per l'ordinamento dal più recente al più vecchio; nessun accesso a BGG o ai materiali è coinvolto nella generazione.
- 2026-09-05: aggiunta al cruscotto la sezione differenziale fra rilevamenti periodici. La migrazione `005_contest_phase_history.sql` storicizza fasi e scadenze e crea la baseline corrente; baseline, completamenti di censimento e verifiche tecniche dello stesso giorno non vengono presentati come cambiamenti periodici.
