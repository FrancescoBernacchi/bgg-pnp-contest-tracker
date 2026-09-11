# Esplorazione contest BGG 2025

## Stato
Riaperto il 10 settembre 2026 per estendere l'esplorazione annuale a WIP BGG e collegamenti alle risorse dichiarati nei primi post. Baseline, undici censimenti e ricognizione dei contest sono completati.

## Scopo e confini
Esplorare i contest di game design PnP dell'edizione 2025 su BoardGameGeek, quindi censire entry, fasi e risultati per incrementi verificati. L'anno è quello dichiarato dall'edizione, anche quando il calendario attraversa due anni. Nessuna apertura o acquisizione di materiali di gioco. I nuovi casi adiacenti dubbi restano da valutare.

## Input
Thread ufficiali BGG, GeekList e post risultati; serie già censite nel progetto come punti di partenza, senza presumere l'esistenza dell'edizione precedente.

## Deliverable e criteri di successo
- Registro delle fonti 2025 con URL, data, evidenza, copertura e lacune.
- Baseline riproducibile nel catalogo e nel database per i contest verificati.
- Censimenti e risultati successivi separati dalla prima ricognizione.
- Nessun dato ignoto trattato come zero, nessuna conclusione dedotta dal solo anno.
- Verifica dell'integrità SQLite e della conservazione dei dati 2026 prima della chiusura dell'incremento.

## Decisioni del 2026-09-07
- L'utente dedica questo task al 2025 e conserva i controlli 2026 nel task «2026-09-04 - Monitoraggio contest BGG».
- Un task per ciascun anno esplorato a ritroso; nessun branch permanente per anno.
- Lavoro autorizzato su main; commit e push da proporre al termine di incrementi verificati.
- Stato iniziale: main, working tree pulita, allineata al riferimento locale origin/main; remoto non interrogato.

## Verifiche e risultati
### Prima ricognizione del 2026-09-07

Individuate e verificate undici edizioni 2025: In-Hand, 9-Card Nanogame, Children & Family, 1-Card, Solomode, Solitaire, Two-Player, 54-Card, Traditional Deck, Wargame e Roll & Write. Le prime nove corrispondono a serie già note dal 2026; 1-Card e Roll & Write introducono due serie aggiuntive.

Roll & Write è attribuito al 2025 secondo l'etichetta ufficiale, benché sviluppo, freeze e voto terminino nel 2026. Traditional Deck conclude il voto il 2 gennaio 2026. Wargame conserva la proroga ufficiale della chiusura del voto dal 1º all'8 dicembre 2025.

La sfida “2025 Print and Play Challenge” non è un contest di design ed è esclusa. Le sfide bimestrali di 24 ore e i concorsi esterni soltanto annunciati nel forum non sono stati inclusi in questa baseline annuale; potranno essere valutati separatamente se emerge un perimetro stabile. Non è stata trovata evidenza sufficiente di un'edizione 2025 del Turkish PnP o del Bad Comet Cozy analogo a quello 2026.

Creato `catalog/2025-contest-baseline.sql`, destinato ad aggiungere 11 contest, 2 serie, fonti, fasi, osservazioni iniziali e alcuni conteggi ufficiali senza aprire file di gioco.

Lo script è stato prima applicato a una copia del database e poi al database operativo. Risultato: 22 contest complessivi, equamente distribuiti fra 2025 e 2026; 13 serie; 32 fasi 2025; le 365 entry 2026 preesistenti sono rimaste invariate. `PRAGMA foreign_key_check` non segnala violazioni e `PRAGMA integrity_check` restituisce `ok`. Gli otto test dell'applicazione sono superati.

Aggiornati `README.md`, `PROJECT.md` e `catalog/README.md` per rendere visibile la nuova baseline senza presentare le entry 2025 come già censite.

### Censimento In-Hand 2025

Preparato `catalog/2025-in-hand-entries-results.sql` con tutte le 27 entry elencate dal thread: 15 finaliste e 12 ritirate. Registrati 55 piazzamenti di gioco in otto categorie; la categoria Traditional Card/Tarot/Decktet non aveva entry e il premio Best Playtester resta una classifica di persone, non di giochi. Gli ancoraggi interni del thread espongono i titoli ma non gli URL individuali dei WIP, quindi le entry conservano per ora il thread ufficiale come evidenza comune senza inventare collegamenti.

Lo script In-Hand è stato verificato su una copia e applicato al database operativo: 392 entry complessive, di cui 27 nel 2025, e 55 classifiche In-Hand. Integrità e chiavi esterne sono valide; il cruscotto è stato rigenerato e gli otto test dell'applicazione sono superati.

### Censimento 9-Card Nanogame 2025

Preparato `catalog/2025-9-card-nanogame-entries-results.sql` dalla lista conclusiva e dai risultati pubblicati nel thread ufficiale. Il censimento comprende 94 entry: 63 indicate come `Contest Ready` e 31 ritirate. Due righe ritirate riportano `N/A` come titolo: il valore originale è conservato in `entry_text_raw`, mentre i titoli canonici tecnici le distinguono senza inventare nomi di gioco.

Registrati 56 piazzamenti di gioco in undici categorie. La classifica generale conserva il primo posto di Math Knight, il pari merito al secondo posto di Bullet Run e Fall of the Republic e le posizioni successive fino al settimo posto. In `Best New Designer`, il primo posto personale di Scott è associato a entrambe le sue entry, Into the Arcanum e Tower of Babel. Il premio Best Playtester è escluso dalle classifiche di gioco. Non sono stati aperti materiali delle entry; gli autori non univocamente associabili dalla tabella impaginata non sono stati trasformati in crediti certi.

Lo script è stato verificato su una copia e applicato al database operativo. Il database contiene ora 486 entry complessive, 121 delle quali appartengono al 2025. Per 9-Card risultano 94 entry e 56 piazzamenti; `PRAGMA foreign_key_check` non segnala violazioni, `PRAGMA integrity_check` restituisce `ok` e gli otto test dell'applicazione sono superati. Il cruscotto locale è stato rigenerato.

### Censimento Children & Family 2025

Preparato `catalog/2025-children-family-entries-results.sql` dalla GeekList ufficiale, dalla rosa conclusiva e dal post dei risultati. Il censimento comprende tutte le 27 entry ufficiali: 4 nella categoria Children’s Game e 23 nella categoria Family Game. Sono registrati identificativi degli item GeekList, collegamenti ai WIP disponibili, categoria e designer pubblicati; non sono stati aperti o scaricati materiali di gioco.

Registrati 36 piazzamenti ufficiali in cinque categorie: Best Children’s Game, Best Family Game, Best Rulebook, Best Theme e Best Art. Il titolo `Squirelly`, usato nella rosa finale e nei risultati, è canonico; `Squirrelly`, presente nell’intestazione WIP della GeekList, è conservato come alias storico. Le differenze di età o numero di giocatori tra alcune schede WIP e la rosa finale non sono state riconciliate per inferenza: i campi strutturati seguono la rosa finale e il testo della fonte resta tracciato.

Lo script è stato verificato su una copia e applicato al database operativo. Il database contiene ora 513 entry complessive, 148 delle quali appartengono al 2025. Per Children & Family risultano 27 entry e 36 piazzamenti; `PRAGMA foreign_key_check` non segnala violazioni e `PRAGMA integrity_check` restituisce `ok`. Il cruscotto locale è stato rigenerato; gli otto test Python dell’applicazione e i quattro test JavaScript del frontend sono superati.

### Censimento 1-Card 2025

Preparato `catalog/2025-1-card-entries-results.sql` dalla GeekList ufficiale chiusa e dalla sezione dei risultati nel thread principale. Il censimento comprende tutte le 38 entry ancora elencate; il thread dichiara che tutte le entry della GeekList sono rimaste nel contest, quindi non è stata inferita una sezione di ritiri. Sono registrati posizione, identificativo GeekList, collegamento WIP e credito del designer pubblicato. Non sono stati aperti o scaricati materiali di gioco.

Registrati 84 piazzamenti ufficiali in nove categorie di gioco: Best Overall Game, Best Solitaire Game, Best Multiplayer Game, Best Game Name, Most Innovative Mechanic Involving the 1 Card, Best Rule Book, Best Artist, Best New Designer e la sfida tematica Switching of Roles: Dystopia. Best Playtester è una classifica di persone ed è esclusa da `rankings`. `Finger Twister` e `Matching Socks`, usati nei risultati, sono i titoli canonici; le precedenti grafie `Operation D-2` e `Shapelink` restano come alias storici.

Lo script è stato verificato su una copia e applicato al database operativo. Il database contiene ora 551 entry complessive, 186 delle quali appartengono al 2025. Per 1-Card risultano 38 entry e 84 piazzamenti; `PRAGMA foreign_key_check` non segnala violazioni e `PRAGMA integrity_check` restituisce `ok`. Il cruscotto locale è stato rigenerato; gli otto test Python dell’applicazione e i quattro test JavaScript del frontend sono superati.

### Censimento Solomode 2025

Preparato `catalog/2025-solomode-adjacent-entries-results.sql` dalle due pagine della GeekList ufficiale e dall’annuncio finale dell’organizzatore. Il censimento comprende tutte le 38 proposte pubblicate. Ogni record è classificato come `dependent_variant` con dipendenza obbligatoria dal gioco base; il nome della variante, il titolo originale della GeekList, il gioco base, l’autore o username disponibile, l’identificativo dell’item e il collegamento WIP sono conservati separatamente. Due item puntano per errore alle pagine generali del contest e restano quindi senza un WIP individuale inventato. Non sono stati aperti o scaricati materiali di gioco.

Registrati 55 piazzamenti ufficiali in nove categorie di gioco. `Best Name` conserva il pari merito al secondo posto fra `b-AI-rista` e `Florek & Florka`. Most Valuable Playtester è registrato come metrica testuale di persone, non come classifica di giochi.

Lo script è stato verificato su una copia e applicato al database operativo. Il database contiene ora 589 entry complessive, 224 delle quali appartengono al 2025. Per Solomode risultano 38 varianti dipendenti e 55 piazzamenti; `PRAGMA foreign_key_check` non segnala violazioni e `PRAGMA integrity_check` restituisce `ok`. Il cruscotto locale è stato rigenerato; gli otto test Python dell’applicazione e i quattro test JavaScript del frontend sono superati. Il prossimo censimento annuale è Solitaire 2025.

### Censimento Solitaire 2025

Preparato `catalog/2025-solitaire-entries-results.sql` dalle tre pagine della GeekList ufficiale chiusa e dai post dei risultati nel thread principale. Il censimento comprende tutte le 74 entry ancora elencate. Il thread dichiara che tutte le entry sono rimaste nella GeekList e che ogni gioco non ritirato entro la scadenza di sviluppo è considerato `Contest Ready`; per questo lo stato finale prevale sulle poche righe descrittive obsolete che riportano ancora `Idea phase` o `Prototype phase`, conservate comunque nel testo originale. Non sono stati aperti o scaricati materiali di gioco.

Registrati 167 piazzamenti ufficiali in 16 categorie associate ai giochi, comprese le categorie personali Best New Solo Designer, Best Artist e Best New Artist, che indicano esplicitamente anche il gioco premiato. Best Playtester è invece una classifica esclusivamente di persone ed è conservata come metrica testuale, con i pari merito pubblicati, senza inserirla in `rankings`.

Lo script è stato verificato su una copia e applicato al database operativo. Il database contiene ora 663 entry complessive, 298 delle quali appartengono al 2025. Per Solitaire risultano 74 entry e 167 piazzamenti; `PRAGMA foreign_key_check` non segnala violazioni e `PRAGMA integrity_check` restituisce `ok`. Il cruscotto locale è stato rigenerato; gli otto test Python dell’applicazione e i quattro test JavaScript del frontend sono superati. Il prossimo censimento annuale è Two-Player 2025.

### Censimento Two-Player 2025

La GeekList ufficiale contiene 41 elementi: il primo presenta il contest e i successivi 40 sono i giochi ammessi. Poiché le regole richiedevano di rimuovere dalla GeekList i progetti ritirati, i 40 giochi rimasti sono registrati come entry finali. I materiali non sono stati aperti né scaricati.

Il post ufficiale dei risultati pubblica 41 piazzamenti complessivi nelle categorie Best Theme, Best Graphics, Best Rule Book, Best Mechanics e Best Overall. L'organizzatore dichiara che i voti ricevuti non erano sufficienti a determinare i vincitori delle altre categorie annunciate; questa incompletezza resta esplicita nel censimento. `Roll and Pull`, nome usato nel WIP e nei risultati, è il titolo canonico; `Tractor Pull`, presente nella GeekList, è conservato come alias storico.

Lo script è stato verificato su una copia e applicato al database operativo. Il database contiene ora 703 entry complessive, 338 delle quali appartengono al 2025. Per Two-Player risultano 40 entry e 41 piazzamenti in cinque categorie; `PRAGMA foreign_key_check` non segnala violazioni e `PRAGMA integrity_check` restituisce `ok`. Il prossimo censimento annuale è 54-Card 2025.

### Censimento 54-Card 2025

La GeekList ufficiale e la lista nel thread, aggiornata il 1 novembre 2025, identificano 28 entry finali. Il thread conserva inoltre una sezione distinta con 9 giochi ritirati: il conteggio storico è registrato nelle metriche, mentre questi giochi non entrano nel catalogo operativo. La presenza nella lista finale e l'obbligo di raggiungere lo stato Contest Ready entro il 15 ottobre sostengono lo stato normalizzato delle entry; i file non sono stati aperti né scaricati.

I risultati ufficiali comprendono 48 piazzamenti in nove categorie votate, inclusi i pari merito. Il premio della giuria assegna un primo e un secondo posto, oltre a quattro menzioni d'onore pubblicate senza ordine; queste ultime mantengono quindi un rango nullo. `Hack the Planet` vince il premio della giuria e `Braggarts` il Best Overall Game.

Lo script è stato verificato su una copia e applicato al database operativo. Il database contiene ora 731 entry complessive, 366 delle quali appartengono al 2025. Per 54-Card risultano 28 entry e 54 riconoscimenti complessivi; `PRAGMA foreign_key_check` non segnala violazioni e `PRAGMA integrity_check` restituisce `ok`. Il prossimo censimento annuale è Traditional Deck 2025.

### Censimento Traditional Deck 2025

La Entries List ufficiale contiene 42 proposte in ordine d'iscrizione. Il thread documenta ritiri e squalifiche, ma non presenta una rosa finale separata che consenta di attribuire con certezza uno stato conclusivo a ciascuna proposta. Tutte le 42 entry sono quindi conservate con lo stato normalizzato `unknown`, insieme all'evidenza originale; il contest rimane adiacente perché usa mazzi tradizionali e vieta componenti stampabili personalizzati con funzione di gioco.

Il post ufficiale del 3 gennaio 2026 pubblica dieci posizioni per Best Solo Game, Best Rulebook, Best Use of Theme e Most Innovative Mechanic, e nove per Best Multiplayer Game: 49 piazzamenti di gioco complessivi. Most Valuable Playtester riguarda persone ed è esclusa da `rankings`. `Jack's Dream` vince Solo e Rulebook, `Olm` vince Multiplayer, `Against The Clock` vince Theme e `Soluna` vince Innovative Mechanic.

Lo script è stato verificato su una copia e applicato al database operativo. Il database contiene ora 773 entry complessive, 408 delle quali appartengono al 2025. Per Traditional Deck risultano 42 entry e 49 piazzamenti in cinque categorie; `PRAGMA foreign_key_check` non segnala violazioni e `PRAGMA integrity_check` restituisce `ok`. Il prossimo censimento annuale è Wargame 2025.

### Censimento Wargame 2025

La GeekList ufficiale, pubblicata il 14 dicembre 2025 dopo la conclusione del voto, contiene 19 entry. Le regole richiedevano esplicitamente agli autori di rimuovere dalla GeekList i giochi ritirati; le 19 righe rimaste sono quindi registrate come roster finale. Sono conservati identificativo dell’item, titolo, autore o username disponibile e collegamento alla pagina del gioco o al WIP. I materiali non sono stati aperti né scaricati.

I post ufficiali pubblicano 93 piazzamenti in otto categorie. Best Overall Wargame conserva il pari merito al primo posto tra `Armées de Papier` e `Armored Fury`, seguito direttamente dal terzo posto. Le grafie abbreviate o discordanti dei risultati, tra cui `Ukranian F-16`, `Ferrum Front` e `Night Strike`, sono conservate come alias dei titoli della GeekList.

Lo script è stato verificato su una copia e applicato al database operativo. Il database contiene ora 792 entry complessive, 427 delle quali appartengono al 2025. Per Wargame risultano 19 entry e 93 piazzamenti in otto categorie; `PRAGMA foreign_key_check` non segnala violazioni e `PRAGMA integrity_check` restituisce `ok`. Il prossimo censimento annuale è Roll & Write 2025.

### Censimento Roll & Write 2025

Il thread ufficiale mantiene due elenchi separati: 21 giochi finali e 16 ritirati. Tutte le 37 proposte sono state censite con titolo, autore pubblicato, stato originale e stato normalizzato. I collegamenti dei titoli nel post non espongono destinazioni individuali utilizzabili, quindi ciascuna entry conserva come evidenza il post ufficiale della propria lista senza inventare URL WIP. Nessun materiale è stato aperto o scaricato.

Gli spoiler ufficiali pubblicano 107 piazzamenti di gioco in undici categorie, inclusi tutti i pari merito. Best Playtester classifica sei persone ed è conservata come metrica testuale, non in `rankings`. Le grafie varianti dei risultati, come `Doodlebash`, `Spellwright Codex` e la capitalizzazione di `The Leaning Tower Of Pisa`, sono conservate come alias storici.

Lo script è stato verificato su una copia e applicato al database operativo. Il database contiene ora 829 entry complessive, 464 delle quali appartengono al 2025. Per Roll & Write risultano 21 entry finali, 16 ritirate e 107 piazzamenti in undici categorie; `PRAGMA foreign_key_check` non segnala violazioni e `PRAGMA integrity_check` restituisce `ok`. Tutte le undici edizioni 2025 della baseline hanno ora un censimento dedicato; resta la ricognizione conclusiva di copertura.

### Ricognizione conclusiva di copertura

Il 10 settembre 2026 sono stati riesaminati il forum BGG Design Contests, la ricerca interna per `2025`, i thread e le GeekList indicizzati e i riferimenti incrociati presenti nei contest censiti. Non è emerso un ulteriore contest annuale PnP ospitato su BGG con evidenza sufficiente per ampliare la baseline delle undici edizioni.

La serie `2025 Bi-Monthly 24-Hour Design Challenges` è stata confermata come insieme di challenge brevi ed episodiche con un ciclo distinto e resta fuori dal task annuale. La `2025 Print and Play Challenge` è una challenge di gioco, non un contest di design. I concorsi esterni soltanto annunciati nel forum restano esclusi dal perimetro iniziale BGG. Non è stata trovata evidenza sufficiente per edizioni 2025 di Turkish PnP o Bad Comet Cozy. Metodo, fonti e limiti della conclusione sono registrati in `sources/2025-CONTEST-COVERAGE.md`.

La verifica finale conferma 22 contest complessivi, 11 dei quali attribuiti al 2025, e 829 entry complessive, 464 delle quali del 2025. Tutti gli undici contest 2025 dispongono di baseline e censimento dedicato. Integrità SQLite, chiavi esterne, generazione del cruscotto e test dell'applicazione sono stati rieseguiti con esito positivo.

## Esito e seguito

Il perimetro 2025 è completo secondo le fonti BGG disponibili alla data di chiusura. Un eventuale censimento delle challenge da 24 ore richiederà un task autonomo, perché segue un ciclo episodico diverso. La successiva esplorazione annuale a ritroso può iniziare dal 2024 in un nuovo task dedicato.

### Sondaggio WIP e risorse Roll & Write

Su richiesta dell'utente, il 10 settembre 2026 è stato avviato un sondaggio per estendere la profondità dei task annuali. Il modello distingue ora concettualmente l'evidenza di iscrizione, il thread WIP BGG dedicato e le molteplici risorse che il primo post può dichiarare. Il sondaggio non ha aperto né scaricato i materiali esterni.

Il campione Roll & Write mostra casi diversi: `Rolling Fiefdoms` dichiara una pagina gratuita corrente su PnP Stash e collegamenti separati per regolamento, fogli, sfide solitarie e versione online; `Word Builders` dichiara una cartella di file e un video; per `Doodle Bash!` e `The Leaning Tower of Pisa` il WIP è stato individuato ma i collegamenti ai materiali non erano esposti dai risultati indicizzati; per la ritirata `A Dragon's Die` non è stato verificato un WIP dedicato. I risultati e la proposta di modello sono documentati in `sources/2025-ROLL-WRITE-RESOURCE-SURVEY.md`.

Lo schema corrente ha già `entries.wip_thread_url` e la relazione uno-a-molti `remote_resources`, ma non conserva adeguatamente la menzione del collegamento nella specifica entry né la storia delle osservazioni. La migrazione `006_entry_resource_provenance.sql` aggiunge `entry_resource_scans`, `entry_resource_mentions`, `remote_resource_observations` e il tipo tecnico di accesso alla risorsa.

La scansione è stata estesa a tutte le 37 entry mediante `catalog/2025-roll-write-wips-resources.sql`. Una prima ricerca basata sui risultati indicizzati aveva individuato soltanto 18 WIP. La procedura corretta usa il roster originale come elenco di controllo, porta ogni componente dinamico nell'area visibile, attende la risoluzione BGG e legge quindi l'URL effettivo. Sono ora verificati tutti i 37 WIP. In questo incremento correttivo non sono stati esaminati i materiali esterni.

Lo script è stato verificato su una copia e applicato al database operativo. Dopo la correzione sono presenti 37 scansioni e 37 `wip_thread_url`; il censimento delle risorse sarà rieseguito separatamente. Integrità SQLite e chiavi esterne sono valide. Il dettaglio tabellare è conservato in `sources/2025-ROLL-WRITE-WIPS-RESOURCES.md`.

### Esperienza promossa: navigazione BGG adattiva

L'errore iniziale non dipendeva dall'assenza dei collegamenti nel roster: i componenti BGG `gg-item-link` esponevano inizialmente `href="#"` e risolvevano la destinazione soltanto quando entravano nell'area visibile. La ricerca indicizzata usata come sostituto aveva quindi prodotto una copertura incompleta e costosa. Portando sistematicamente nell'area visibile tutti i componenti dei due post autorevoli e verificando il risultato contro le 21 entry finali e le 16 ritirate, sono stati ottenuti 37 URL WIP univoci su 37.

Questa esperienza è stata promossa nella skill locale `.agents/skills/bgg-contest-navigation/SKILL.md` e nel relativo playbook. La regola permanente è partire dalla struttura renderizzata e dalla fonte autorevole, estrarre l'intero roster in blocco e misurare la completezza; i fallback interni o web sono riservati agli scarti residui. Il playbook dovrà evolvere quando contest più vecchi o serie diverse presenteranno post multipli, GeekList, Hub, spoiler, paginazione, link cancellati o altri meccanismi.

### Censimento completo delle risorse dichiarate Roll & Write

Il 10 settembre 2026 sono stati analizzati i primi post renderizzati di tutte le 37 WIP, senza seguire destinazioni esterne. Il censimento registra 82 risorse distinte in 30 entry; 7 WIP non dichiarano collegamenti pertinenti osservabili. Sono stati considerati anchor ordinari, link dinamici e media incorporati, con deduplicazione degli URL e conservazione delle descrizioni. La tassonomia funzionale e tecnica rimane provvisoria fino alla scansione di tutti i contest 2025.
