# PnP Collection

## Scopo

Costruire un archivio locale consultabile di giochi Print and Play, iniziando dai contest di design pubblicati su BoardGameGeek. Il sistema deve aiutare a scoprire tempestivamente i giochi, conservarne le informazioni e preservare i materiali più rilevanti prima che diventino indisponibili.

## Scope

Nella prima fase la fonte è esclusivamente BoardGameGeek. Il progetto cataloga tutte le entries individuate nei contest inclusi nel perimetro e scarica i materiali soltanto per i giochi selezionati. La ricerca di ulteriori fonti richiederà un task dedicato.

Dal 20 settembre 2026 è deliberata l'evoluzione verso un catalogo personale multifonte di giochi. Lo stato implementato resta inizialmente quello centrato sui contest BGG; l'estensione sarà introdotta tramite task separati e migrazioni verificabili. Nel modello obiettivo il gioco è l'entità canonica trasversale, BGG e Kanare_Abstract sono fonti specializzate e il Print and Play è una forma di accesso o realizzazione, non il perimetro esclusivo dell'app.

La direzione funzionale comprende gradualmente scoperta, catalogazione, interesse personale, desiderio di acquisto o realizzazione, possesso o accesso, organizzazione di materiali e regolamenti, partite, valutazioni e note. Completezza informativa e rapporto personale con il gioco restano dimensioni distinte.

I contest affini che non producono necessariamente giochi PnP autonomi possono essere inclusi come `adiacenti`, mantenendo esplicita la loro tipologia e le dipendenze esterne. Le varianti Solomode, in particolare, dipendono normalmente da un gioco base e devono restare distinguibili dai giochi PnP autonomi, così da poter ricevere filtri e trattamenti differenti in futuro.

Nel database questa distinzione usa `contests.scope_type` e `contests.treatment_profile`; la natura delle singole entry usa `entries.entry_kind` e `entries.base_game_dependency`. Le note originali restano conservate e questi campi rappresentano soltanto la classificazione operativa normalizzata.

Le viste `v_contests_monitoring_all`, `v_contests_pnp_core`, `v_contests_adjacent`, `v_entries_standalone` e `v_entries_dependent_variants` costituiscono l'interfaccia di lettura stabile per report e applicazione. La vista generale calcola i conteggi correnti e la prossima fase non trascorsa al momento della consultazione.

La baseline globale corrente comprende 305 contest dal 2008 al 2026. Il censimento delle entry è stato completato per 22 contest del 2025–2026 e comprende 829 entry: 365 del 2026 e 464 del 2025, relative a In-Hand, 9-Card Nanogame, Children & Family, 1-Card, Solomode, Solitaire, Two-Player, 54-Card, Traditional Deck, Wargame e Roll & Write. Nel complesso risultano 770 giochi autonomi e 59 varianti dipendenti: 21 varianti Solomode del 2026 e 38 del 2025. Traditional Deck usa `format_adjacent`, Bad Comet `selective_entries` e Solomode `dependent_variants`. Le challenge da 24 ore ospitate su BGG sono incluse nel censimento globale ma classificate `adjacent` con profilo `format_adjacent`, così da non alterare le metriche dei PnP principali; challenge di gioco e concorsi esterni soltanto annunciati nel forum restano esclusi e documentati separatamente.

## Attività previste

- individuazione dei contest PnP attivi, dando precedenza ai più recenti;
- ricostruzione delle relazioni tra forum, thread del contest, GeekList, entry, WIP e file;
- estrazione e normalizzazione dei metadati;
- conservazione dello stato specifico dichiarato dal creatore e dello stato normalizzato;
- acquisizione selettiva e versionata dei materiali;
- registrazione di classifiche, categorie, votazioni e piazzamenti;
- consultazione tramite interfaccia locale con ricerca e filtri;
- produzione di esportazioni e report riproducibili.
- pianificazione dei controlli mediante un taccuino versionabile delle scadenze e delle finestre di riesame.
- sviluppo incrementale di strategie verificabili per navigare le diverse strutture storiche di contest, roster, entry, WIP e risorse BGG.

## Tipi standard di attività BGG

Ogni attività BGG deve appartenere a uno solo dei cinque tipi seguenti. L'unità di lavoro è parte del contratto del task e non può essere ampliata silenziosamente.

| Tipo standard | Unità di lavoro | Contenuto | Esclusioni obbligatorie | Titolo del task |
|---|---|---|---|---|
| **Censimento globale contest** | Tutti gli anni | Identità del contest, serie, anno, stato originale e normalizzato, fonte BGG e data | Entry, WIP, risorse, materiali e download | `YYYY-MM-DD - Censimento globale contest PnP BGG` |
| **Censimento annuale entry** | Un solo anno | Contest dell'anno e roster completo delle entry: titolo, autore, stato, posizione, URL e appartenenza | Lettura dei WIP, censimento di risorse o requisiti materiali, verifica degli host e download | `YYYY-MM-DD - Esplorazione contest BGG AAAA` |
| **Analisi materiali del contest** | Un solo contest | WIP delle entry, collegamenti dichiarati, risorse e requisiti materiali osservabili nel perimetro stabilito | Apertura o verifica degli host esterni, download e lavoro su altri contest | `YYYY-MM-DD - Analisi materiali - NOME CONTEST AAAA` |
| **Acquisizione materiali del contest** | Un solo contest | Selezione delle entry, verifica di liceità e condizioni, controllo degli host, download, manifest, hash e versioni | Acquisizioni trasversali a più contest o a un'intera annualità | `YYYY-MM-DD - Acquisizione materiali - NOME CONTEST AAAA` |
| **Monitoraggio del contest** | Un solo contest | Snapshot periodico di stato, fasi, roster e metriche secondo il calendario | Nuovo censimento storico, analisi dei materiali e download | `YYYY-MM-DD - Monitoraggio - NOME CONTEST AAAA` |

Il passaggio normale è: censimento globale → censimento annuale delle entry → analisi materiali per singolo contest → acquisizione per lo stesso singolo contest. Il monitoraggio è un flusso ricorrente parallelo, attivato dal calendario per i contest che lo richiedono. L'acquisizione non è automatica dopo l'analisi: richiede selezione esplicita e verifica delle condizioni applicabili.

Quando una richiesta propone un perimetro diverso — per esempio materiali per un intero anno, entry di più anni nello stesso task o download trasversali a più contest — l'agente deve evidenziare la deviazione e indicare la scomposizione corretta prima di procedere. Anche nelle risposte di orientamento generale sulle prossime attività, le proposte devono essere formulate usando questi nomi e queste unità di lavoro.

Il cruscotto Markdown corrente è rigenerabile dal database locale con `app/generate_monitoring_report.py`; legge le viste operative e non accede a BGG né ai materiali delle entry.

`PROJECT_PROGRESS.md` è invece il cruscotto trasversale versionabile: integra copertura informativa, pipeline, acquisizioni, attività aperte e salute degli strumenti. Le viste annuali per tipologia e per entry sono rigenerate dal database con `app/generate_project_progress.py`; le parti qualitative sono aggiornate dall'agente nello stesso incremento che modifica dati o stato. Il documento non sostituisce il report tecnico rigenerabile né il calendario dei controlli.

Dal 7 settembre 2026 l'interfaccia di consultazione è realizzata con Python 3.12+ e sola libreria standard (`app/server.py`), asset HTML/CSS/JavaScript locali (`app/static/`) e launcher PowerShell (`app/start.ps1`). Non richiede build o dipendenze aggiuntive. Il server è limitato a `127.0.0.1`; ogni richiesta usa una transazione SQLite in sola lettura (`mode=ro`, `query_only`). Ricerca, filtri, navigazione e aggiornamento sono operazioni locali sui metadati; la libreria dei materiali non è esposta né consultata. La guida operativa è `app/README.md`.

Dal 2 ottobre 2026 l'ingresso principale dell'app è la vista comune **Giochi**: ricerca titoli e alias, filtra per fonte e rende espliciti i matching candidati senza confondere identità canonica, prodotto, record nativo e risorsa. La scheda gioco mantiene separate provenienza, riconciliazioni, prodotti, implementazioni, risorse e presenze BGG. Contest, entry, risultati, scadenze e monitoraggio restano viste specializzate BoardGameGeek; Kanare_Abstract dispone di una prima vista specializzata derivata esclusivamente dai dati locali. Fonti future entrano nel catalogo comune tramite il nucleo relazionale e ricevono viste proprie soltanto per semantiche specifiche. Stack, sola lettura e assenza di rete automatica restano invariati.

La scheda entry espone separatamente i collegamenti alle risorse e i requisiti materiali descritti testualmente. Per questi ultimi conserva testo e contesto originali accanto a normalizzazione, quantità, obbligatorietà e modalità di approvvigionamento; fonte, data e copertura precisano se la rilevazione riguarda soltanto il primo post o include anche le regole. Stati negativi e dati mancanti non vengono trasformati in assenze certe.

Dal 10 settembre 2026 la vista **Risultati** rende navigabili tutte le osservazioni di `rankings`, con ricerca, filtri, ordinamenti, provenienza e collegamenti alle schede. La sintesi per contest separa categoria originale, ufficialità, fonte e data: vincitori soltanto da posizione esplicita 1 e distribuzioni delle osservazioni per posizione, senza normalizzare o sommare sistemi di voto diversi. Posizione, punteggio e voti restano distinti; valori mancanti ed ex aequo sono preservati. Non essendoci nello schema una versione operativa della classifica o un metodo/unità del voto, l'app non deduplica né seleziona automaticamente osservazioni sostitutive. Stack, architettura e contratto di sola lettura restano invariati. Semantica e limiti sono documentati in `app/README.md`; verifiche in `tasks/2026-09-10 - Navigazione classifiche app/TASK.md`.

Dal 11 settembre 2026 la navigazione prosegue dalla scheda contest alla singola entry e alle risorse dichiarate nel relativo WIP. L’app legge in sola lettura risorse, scansioni, menzioni e osservazioni di disponibilità, preservando etichette originali, funzione, forma tecnica, provenienza e date. Le destinazioni HTTPS diventano collegamenti esterni solo su click; la consultazione non provoca richieste, verifiche o download automatici. Gli stati di mancata osservazione restano distinti e non vengono interpretati come assenza. Decisioni e verifiche sono in `tasks/2026-09-11 - Navigazione risorse entry/TASK.md`.

La UI confronta due controlli periodici del medesimo contest, escludendo da entrambi baseline, census e consistency. Le transizioni riguardano soltanto entità comuni ai rispettivi snapshot collegati tramite `check_id`. Poiché lo schema non certifica la completezza per entità, le presenze esclusive sono mostrate senza inferire aggiunte o rimozioni; gli insiemi vuoti sono dati insufficienti. Il motore del report Markdown preesistente resta separato e invariato.

I confronti del cruscotto considerano soltanto rilevamenti periodici o legati a una scadenza. Baseline, completamenti di censimento e verifiche tecniche restano nello storico ma non sono presentati come evoluzioni successive. Nuove entry, rimozioni e transizioni sono attendibili soltanto fra snapshot completi collegati ai rispettivi controlli.

## Input e fonti

Fonte iniziale autorevole esterna: BoardGameGeek. Punti di ingresso noti:

- forum Design Contests;
- Guild 4326, “Tabletop Game Designers”;
- thread principali dei contest;
- GeekList delle entries e dei risultati;
- thread WIP dei singoli giochi;
- pagine file BGG e collegamenti pubblici a servizi esterni.

Ogni dato volatile deve riportare URL di provenienza e data dell'ultima verifica.

La navigazione BGG segue la skill locale `.agents/skills/bgg-contest-navigation/SKILL.md` e il relativo playbook evolutivo. Ogni roster viene estratto anzitutto dalla fonte BGG autorevole e verificato quantitativamente; ricerche interne o web intervengono solo sugli scarti residui. I nuovi pattern di pagina vengono documentati con contesto, metodo, verifica e limiti, così che le esplorazioni successive possano adattarsi anche a organizzazioni storiche differenti.

L'analisi materiali del singolo contest raccoglie il thread WIP BGG dedicato di ciascuna entry, i collegamenti alle risorse e i requisiti materiali dichiarati nel primo post, senza aprire le destinazioni esterne. `entry_resource_scans` conserva anche gli esiti negativi o non osservabili; `entry_resource_mentions` collega la risorsa alla specifica entry e alla fonte BGG; `remote_resource_observations` distingue la dichiarazione nel WIP dalla successiva verifica di disponibilità. `entry_material_scans` dichiara la copertura della rilevazione (`first_post_only` o successivamente `rules_integrated`), mentre `entry_material_requirements` conserva nome originale e normalizzato, quantità, categoria provvisoria, obbligatorietà, modalità di approvvigionamento, contesto e fonte. L'inventario tratto dal primo post resta esplicitamente integrabile quando le regole saranno acquisite nel successivo task di acquisizione dello stesso contest.

Le prossime finestre operative e gli ultimi controlli sono mantenuti in `sources/MONITORING_CALENDAR.md`. Il monitoraggio evita rilevamenti duplicati nella stessa giornata e distingue i controlli tecnici locali dalle nuove osservazioni dello stato pubblicato su BGG.

## Deliverable

- applicazione locale di consultazione;
- database operativo SQLite;
- schema e migrazioni riproducibili;
- catalogo ed esportazioni testuali versionabili;
- libreria locale dei materiali selezionati;
- manifest con versione, provenienza, data di acquisizione, dimensione e hash dei file;
- report su contest, disponibilità, classifiche e priorità di acquisizione.
- cruscotto Markdown versionabile dell'avanzamento complessivo.

## Stakeholder / destinatari

Uso personale del proprietario del progetto. Nessuna pubblicazione o redistribuzione dei materiali è inclusa nello scope iniziale.

Il codice e la documentazione sono conservati anche nel repository GitHub privato `FrancescoBernacchi/bgg-pnp-contest-tracker`, branch `main`. Database operativo, output rigenerabili e materiali di terzi restano esclusi dal repository.

Poiché l'utente sta acquisendo familiarità con Git e GitHub, l'agente fornisce supporto proattivo sulle azioni di versionamento: indica quando conviene creare commit, branch o push, ne spiega la motivazione e verifica l'esito. Le operazioni non vengono eseguite senza una richiesta o autorizzazione chiara. Il riferimento operativo è `GIT_GUIDE.md`.

## Conoscenza condivisa

Il modello concettuale distingue contest, entry, gioco, persona/credito, stato, classifica, risorsa remota, acquisizione e file locale. I valori normalizzati non sostituiscono mai il testo originale da cui derivano.

Dal 20 settembre 2026 il nucleo multifonte distingue inoltre il gioco canonico dal record nativo osservato in una fonte. La riconciliazione fra i due è una relazione con esito esplicito e non una fusione implicita. Prodotti e confezioni hanno identità propria e relazione molti-a-molti con i giochi; varianti e dipendenze sono relazioni tipizzate fra giochi. Nomi, risorse, implementazioni online e crediti conservano provenienza e stato di verifica. Le tabelle BGG preesistenti restano compatibili e continuano a servire l'app corrente; il nucleo generale sarà il punto di ingresso per le future importazioni multifonte.

## Vincoli

- conservare integri gli originali e non sovrascrivere versioni precedenti;
- non includere materiali PnP o altri binari voluminosi in Git;
- registrare rinomini, ritiri, indisponibilità e variazioni di stato;
- rispettare condizioni d'uso, licenze e diritti dei creatori;
- non interpretare `WIP` isolatamente: lo stato giocabile può essere dichiarato anche come `Playtest Ready`, `Components Ready`, `Contest Ready` o equivalente;
- non automatizzare accessi che richiedono credenziali o aggirano limitazioni del sito.

## Razionale dell'architettura

`database/` contiene la verità operativa interrogabile, mentre `catalog/` conserva manifest ed esportazioni leggibili e adatte a Git. `library/` ha governance separata perché contiene copie locali, potenzialmente grandi, di opere di terzi. `sources/` rende verificabile la provenienza senza confondere evidenza e dato normalizzato. `tasks/` isola il lavoro e le decisioni di ogni iniziativa.

## Strategia di realizzazione incrementale

1. PoC su un contest attivo recente e un piccolo campione di entries.
2. Prima versione del modello dati, importazione e interfaccia di consultazione.
3. Acquisizione selettiva con manifest e controllo di integrità.
4. Estensione graduale ad altri contest BGG e monitoraggio prudente guidato da scadenze.

## Priorità correnti

Per il monitoraggio la priorità è determinata dal taccuino: eventi di fase imminenti o appena trascorsi, poi controllo settimanale dei contest attivi. La priorità dei giochi sarà determinata autonomamente soprattutto da classifiche e votazioni degli utenti; in assenza di risultati ufficiali, eventuali segnali sostitutivi dovranno essere dichiarati come tali.

## Domande aperte

- eventuale evoluzione dello stack solo qualora la scala o nuovi flussi la richiedano;
- soglie operative per l'acquisizione quando un contest non dispone ancora di votazioni;
- eventuali limiti massimi di spazio occupato dalla libreria.

## Evoluzione multifonte deliberata

La prima nuova fonte prevista è **Kanare_Abstract**. Il relativo task dovrà progettare schema, scraping e interfaccia senza introdurre colonne o copie del modello specifiche della fonte quando il concetto è riutilizzabile. Il nucleo comune dovrà supportare ricerca multifonte; i dati realmente specifici resteranno tipizzati, attribuiti ed etichettati con la relativa fonte.

Decisioni già raccolte per il futuro task Kanare_Abstract:

- vista generale **Giochi** come ingresso al catalogo canonico, con ricerca e filtri su tutte le fonti; ogni fonte mantiene una voce di menu e viste specializzate;
- gioco distinto da prodotto, edizione, implementazione digitale e record nativo della fonte; prodotti o confezioni possono includere più giochi;
- catalogo Kanare esteso a giochi attuali, fuori produzione, varianti nominate, classici, giochi con componenti comuni e titoli dichiarati sulle piattaforme online; accessori e set generici non sono elementi di catalogo, ma i singoli giochi supportati sono censiti e collegati al set come riferimento tecnico;
- titoli ufficiali conservati come principali, alias e grafie giapponesi ricercabili, traduzione italiana interna secondaria quando utile e chiaramente distinta da un titolo ufficiale;
- descrizioni brevi e dettagliate in italiano; se manca la breve può essere derivata dalla dettagliata, mentre una descrizione dettagliata assente non viene inventata. Testi giapponesi usati solo transitoriamente per tradurre e non censiti; la provenienza resta registrata;
- un'immagine rappresentativa viene acquisita durante il censimento; le immagini secondarie sono inizialmente censite tramite URL e scaricate soltanto dopo selezione manuale. Originali e derivati restano separati, versionati e fuori da Git;
- tutti i regolamenti sono censiti per lingua, ma dopo selezione manuale si scaricano soltanto quelli italiani o inglesi. I regolamenti giapponesi non vengono acquisiti o analizzati;
- inventario completo dei materiali ricostruito da regolamenti, elenchi ufficiali, descrizioni e immagini, separando contenuto della confezione, requisiti di gioco, sostituzioni, dati dichiarati e inferenze;
- presenze su BGG e piattaforme di gioco distinte fra dichiarate da Kanare, da verificare e verificate; la verifica esterna appartiene a un incremento successivo;
- nessun prezzo o dato promozionale; si registra invece la forma di accesso gratuita o a pagamento, distinguendo prodotto fisico, PnP, digitale, componenti comuni e giochi utilizzabili con il solo regolamento;
- autori gestiti come persone condivise con nome, alias, ruoli, collegamenti essenziali e riconciliazione tra fonti; biografie e ritratti non sono prioritari;
- classificazione interna multidimensionale con categorie gerarchiche dove appropriate e relazioni trasversali. Il primo nucleo comprende natura ludica, obiettivo, meccanismi, componenti, forma di accesso, informazione/casualità e struttura dei giocatori; dichiarazioni, importazioni e inferenze restano distinguibili e revisionabili;
- riconciliazione automatica fra fonti solo con evidenza forte; corrispondenze ambigue richiedono approvazione manuale;
- primo censimento limitato alle informazioni Kanare attualmente accessibili, comprese pagine di giochi fuori commercio ancora online; nessun recupero automatico da archivi web;
- aggiornamenti avviati manualmente, storicizzati e non distruttivi. Un elemento non più osservato non viene cancellato automaticamente;
- conservazione selettiva delle evidenze: dati strutturati e metadati per tutte le pagine, snapshot completi soltanto per anomalie o casi motivati;
- copertura del censimento separata dagli stati personali del gioco.

### Stato implementato del modello

La migrazione `009_multisource_catalog.sql` realizza il nucleo relazionale generale. Le fonti e i loro record nativi sono separati dai giochi canonici; gli stati di matching impediscono fusioni automatiche. Il modello comprende prodotti e contenuti molti-a-molti, relazioni fra giochi, alias multilingue, risorse attribuibili, piattaforme e implementazioni online, alias delle persone e asserzioni di credito con evidenza.

Il censimento Kanare_Abstract osservato il 2026-09-20 è importato nel database operativo mediante `catalog/import_kanare_abstract.py` e verificabile con `catalog/verify_kanare_abstract_import.py`. Comprende 64 identità canoniche conservative, 58 record nativi, 39 prodotti, 56 relazioni prodotto–gioco, 2 alias, 2 relazioni fra giochi, 28 implementazioni dichiarate, 13 persone e 62 asserzioni di credito. Ventisei riconciliazioni ambigue restano `candidate`. Regolamenti e immagini privi di URL puntuale nel documento locale sono conservati come presenze dichiarate nei metadati dei record nativi, senza creare URL o righe risorsa fittizie. Nessuna destinazione esterna è stata verificata e nessun materiale è stato acquisito.

Il secondo rilevamento controllato dello stesso giorno ha completato gli URL puntuali mediante `catalog/enrich_kanare_abstract.py`: 76 record nativi, 39 prodotti con scheda diretta, 141 risorse URL dichiarate e 54 implementazioni attribuite a 9 piattaforme. I 26 matching ambigui restano `candidate`; destinazioni, file e materiali non sono stati aperti né acquisiti.

Il 21 settembre 2026 un incremento separato ha verificato le destinazioni già dichiarate: 14 delle 54 implementazioni dispongono di evidenza ufficiale sufficiente e sono `verified`, mentre 40 restano `uncertain` (18 non osservabili e 22 non confermate puntualmente). Dieci matching della pagina Online Play sono `confirmed`, l'omonimo BGG `Ripples` è `rejected` e 15 matching restano `candidate`. Nessun materiale è stato acquisito e nessun qualificatore è stato trasformato automaticamente in alias.

Il 21 settembre 2026 il primo lotto Kanare_Abstract approvato per uso personale ha acquisito tre PDF inglesi direttamente offerti dalla fonte: Pentwall (regole e plancia stampabile), ViceVeresi/ViceVersi e Chess Territorial. Gli originali sono conservati fuori da Git, immutati e associati alle risorse del catalogo mediante la migrazione 010; manifest, dimensioni, MIME, URL e SHA-256 restano versionabili. Non è stata osservata una licenza aperta: nessuna redistribuzione o produzione di derivati è autorizzata.

## Idee evolutive da trattare in task separati

### Visualizzazione multiformato della libreria

Requisito confermato dall'utente il 2026-10-03, dopo l'incremento Libreria: progettare la futura visualizzazione interna come funzionalità estensibile per formato, iniziando dai PDF presenti. Quando vengono introdotti materiali JPG/JPEG, PNG, TXT, DOC/DOCX o altri formati, verificare nello stesso task il supporto di visualizzazione e integrare il visualizzatore appropriato quando tecnicamente fattibile e sicuro; altrimenti registrare il limite e il successivo intervento necessario. Non considerare automaticamente coperto un formato perché il file è acquisito.

La scelta del visualizzatore deve basarsi su tipo verificato e contenuto, non sulla sola estensione. Immagini e testo richiedono rendering controllato; documenti Office possono richiedere conversione locale con derivati separati e tracciabili. Nessuna esecuzione di macro, script o contenuti attivi, nessun caricamento verso servizi esterni, nessuna alterazione degli originali. I formati non supportati devono essere segnalati esplicitamente nell'interfaccia. L'implementazione richiede un task autonomo e una revisione deliberata dell'attuale esclusione di binari HTTP e anteprime; questa decisione registra il requisito futuro e non modifica il contratto di sicurezza dell'app corrente.

### Simulatore di giochi

Valutare un motore interno che permetta al progetto di implementare in modo modulare simulazioni digitali di giochi selezionati. Il motore non è destinato alla programmazione da parte dell'utente finale. I giochi dovranno poter esporre, senza confonderlo con le presenze su piattaforme esterne, uno stato specifico relativo alla disponibilità e maturità della simulazione nell'app. Architettura, formato delle implementazioni, verifica delle regole e interfaccia saranno definiti in un task autonomo.

### Prototipazione 3D per la stampa

Valutare un'area trasversale per progettare componenti stampabili in 3D di giochi selezionati: plance, board, pedine, schede o supporti di gioco, scatole e organizer. I progetti dovranno essere collegati al gioco e, quando necessario, alla specifica edizione; sorgenti modificabili, STL derivati, versioni, misure, dipendenze, licenze e profili di stampa dovranno restare tracciabili. La funzionalità sfrutterà l'inventario completo dei materiali, ma sarà progettata e implementata in task dedicati.

## Classificazione evolutiva delle risorse dichiarate

La classificazione dei collegamenti dichiarati nei WIP evolve per osservazione. Funzione, forma tecnica e stato dell'evidenza restano dimensioni separate. I valori usati durante il censimento sono provvisori e saranno consolidati soltanto dopo la scansione trasversale di tutti i contest 2025; testo e contesto originali restano preservati.
