# PnP Collection

## Criterio trasversale APP — uniformità, 2026-10-10

Decisione esplicita utente nel passaggio APP di TSK-0081: gestire i giochi quanto più possibile in maniera uniforme, evitando logiche ad hoc per singolo titolo. Componenti riutilizzabili guidati da dati/capacità; eventuali comportamenti diversi per categorie/tipologie di giochi, senza riclassificazioni implicite. Istanze, varianti, raccolte e crediti contestuali sono funzionalità generiche: i giochi citati nei task sono casi di accettazione, non chiavi di selezione del comportamento. Conservare provenienze e semantiche delle fonti senza duplicare il trattamento delle informazioni comuni. Criterio per sviluppi successivi, nessun refactoring generale o migrazione retroattiva autorizzati; PWS 1.5.0 invariato.


## Scopo

Costruire un archivio locale consultabile di giochi Print and Play, iniziando dai contest di design pubblicati su BoardGameGeek. Il sistema deve aiutare a scoprire tempestivamente i giochi, conservarne le informazioni e preservare i materiali più rilevanti prima che diventino indisponibili.

## Scope

Requisito PerGioco 2026-10-06, TSK-0073: database e app conservano la classificazione originale della fonte, etichette/gerarchia e appartenenze multiple con provenienza. Mapping trasversale eventualmente separato, senza sostituire le categorie native. Raccolta CAT, persistenza DAT ed esposizione APP successive, non ancora implementate; dettagli in `sources/PERGIOCO-SCOPE.md`.

Decisione 2026-10-06, TSK-0073: **PerGioco** adottata per un pilota come fonte editoriale di giochi astratti/tradizionali, carta e matita e giochi logici, inclusi problemi solitari. Regole complete gratuite verificate titolo per titolo; sistema di regole distinto da singoli schemi e soluzioni, che non aumentano il conteggio giochi. Perimetro autorevole in `sources/PERGIOCO-SCOPE.md`. CAT pilota distinto da successive importazioni DAT, app e acquisizioni; nessun dato operativo PerGioco ancora importato, nessuna modifica retroattiva alle fonti esistenti.

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

Dal 2026-10-04 tutti i task seguono `TASK_GOVERNANCE.md`: categorie EPR, GPR, APP, INF, FON, CAT, DAT, VER, BGG-G, BGG-A, BGG-M, MAT, ACQ, IMG e ALT; registro centrale `tasks/REGISTRY.json`; modalità, ciclo di lavoro e versionamento separati. Nuovi titoli/cartelle inseriscono il codice dopo la data. I percorsi storici e il bootstrap sono preservati; la classificazione retroattiva è datata e distinta dalla storia originale. La categoria non modifica il contratto operativo BGG né autorizza acquisizioni. IMG è un workflow autonomo deliberato il 2026-10-05 in TSK-0065, governato da `sources/IMAGE_WORKFLOW.md`; non estende i cinque workflow seguenti.

Le attività BGG di censimento, materiali e monitoraggio appartengono a uno solo dei cinque tipi seguenti; IMG segue il contratto autonomo in `sources/IMAGE_WORKFLOW.md`. L'unità di lavoro è parte del contratto del task e non può essere ampliata silenziosamente.

| Tipo standard | Unità di lavoro | Contenuto | Esclusioni obbligatorie | Titolo del task |
|---|---|---|---|---|
| **Censimento globale contest** | Tutti gli anni | Identità del contest, serie, anno, stato originale e normalizzato, fonte BGG e data | Entry, WIP, risorse, materiali e download | `Txxxx-AA.MM.GG - BGG-G - Contest PnP BGG` |
| **Censimento annuale entry** | Un solo anno | Contest dell'anno e roster completo delle entry: titolo, autore, stato, posizione, URL e appartenenza | Lettura dei WIP, censimento di risorse o requisiti materiali, verifica degli host e download | `Txxxx-AA.MM.GG - BGG-A - Contest BGG AAAA` |
| **Analisi materiali del contest** | Un solo contest | WIP delle entry, collegamenti dichiarati, risorse e requisiti materiali osservabili nel perimetro stabilito | Apertura o verifica degli host esterni, download e lavoro su altri contest | `Txxxx-AA.MM.GG - MAT - NOME CONTEST AAAA` |
| **Acquisizione materiali del contest** | Un solo contest | Selezione delle entry, verifica di liceità e condizioni, controllo degli host, download, manifest, hash e versioni | Acquisizioni trasversali a più contest o a un'intera annualità | `Txxxx-AA.MM.GG - ACQ - NOME CONTEST AAAA` |
| **Monitoraggio del contest** | Un solo contest | Snapshot periodico di stato, fasi, roster e metriche secondo il calendario | Nuovo censimento storico, analisi dei materiali e download | `Txxxx-AA.MM.GG - BGG-M - NOME CONTEST AAAA` |

Il passaggio normale è: censimento globale → censimento annuale delle entry → analisi materiali per singolo contest → acquisizione per lo stesso singolo contest. Il monitoraggio è un flusso ricorrente parallelo, attivato dal calendario per i contest che lo richiedono. L'acquisizione non è automatica dopo l'analisi: richiede selezione esplicita e verifica delle condizioni applicabili.

Quando una richiesta propone un perimetro diverso — per esempio materiali per un intero anno, entry di più anni nello stesso task o download trasversali a più contest — l'agente deve evidenziare la deviazione e indicare la scomposizione corretta prima di procedere. Anche nelle risposte di orientamento generale sulle prossime attività, le proposte devono essere formulate usando questi nomi e queste unità di lavoro.

Il cruscotto Markdown corrente è rigenerabile dal database locale con `app/generate_monitoring_report.py`; legge le viste operative e non accede a BGG né ai materiali delle entry.

`PROJECT_PROGRESS.md` è invece il cruscotto trasversale versionabile: integra copertura informativa, pipeline, acquisizioni, attività aperte e salute degli strumenti. Le viste annuali per tipologia e per entry sono rigenerate dal database con `app/generate_project_progress.py`; le parti qualitative sono aggiornate dall'agente nello stesso incremento che modifica dati o stato. Il documento non sostituisce il report tecnico rigenerabile né il calendario dei controlli.

Dal 7 settembre 2026 l'interfaccia di consultazione è realizzata con Python 3.12+ e sola libreria standard (`app/server.py`), asset HTML/CSS/JavaScript locali (`app/static/`) e launcher PowerShell (`app/start.ps1`). Non richiede build o dipendenze aggiuntive. Il server è limitato a `127.0.0.1`; ogni richiesta usa una transazione SQLite in sola lettura (`mode=ro`, `query_only`). Ricerca, filtri, navigazione e aggiornamento sono operazioni locali sui metadati; nella prima versione la libreria dei materiali non era esposta né consultata; le evoluzioni autorizzate del 3 ottobre 2026 sono descritte di seguito. La guida operativa è `app/README.md`.

Dal 3 ottobre 2026 la Libreria consulta acquisizioni e file con provenienza, versioni, filtri e presenza effettiva. Un successivo incremento autonomo, autorizzato esplicitamente nella stessa data, introduce il primo visualizzatore PDF locale: backend sempre con sola libreria standard, PDF.js 6.3.289 e asset/worker locali nel frontend. Solo PDF registrati e validati vengono trasferiti su loopback tramite ID, richieste same-origin e token effimero in header, senza percorsi pubblici o server generico. La radice library, link/reparse point e destinazione dell'handle aperto sono verificati prima del trasferimento. Database e originali restano in sola lettura; nessuna rete esterna, macro, scripting PDF, azione, allegato o link del documento è attivato. La CSP consente worker locali e font blob, mantenendo esclusi frame, object ed eval. Limiti: 128 MiB, trasferimento integrale senza Range, PDF cifrati non supportati. Contratto e test sono in app/README.md e nel task Visualizzatore PDF locale nell'app. APP-005 estende successivamente il contratto a PNG e DOCX come descritto di seguito.

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

Le attività coperte applicano sempre le skill locali pertinenti, selezionate tramite `sources/SKILL_INVENTORY.md` e il routing di AGENTS.md, anche alla ripresa dei task storici. La navigazione BGG usa la base `.agents/skills/bgg-contest-navigation/SKILL.md`, il playbook condiviso e la specializzazione del workflow. Il censimento annuale delle entry legge la procedura dedicata nella base; la ricerca di fonti e la preanalisi di una fonte usano le rispettive skill FON. Ogni roster viene estratto anzitutto dalla fonte BGG autorevole e verificato quantitativamente; ricerche interne o web intervengono solo sugli scarti residui. I nuovi pattern vengono documentati con contesto, metodo, verifica e limiti prima della promozione. Le skill supportano i contratti vigenti senza estenderne perimetro o autorizzazioni.

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
- decisione storica Kanare del 2026-09-20: principale durante il censimento e secondarie inizialmente per URL. Dal 2026-10-05 il task IMG autonomo raccoglie tutte le immagini utili dei giochi Kanare esplicitamente selezionati, secondo `sources/IMAGE_WORKFLOW.md`; nessuna riapertura automatica di CAT o acquisizione retroattiva. Originali e derivati restano separati, versionati e fuori da Git;
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

### EPR-001 — Fasi e calendario dei contest BGG

Proposta registrata il 2026-10-04, **da valutare, non adottata**. Responsabile documentale: [TSK-0052](tasks/2026-10-04%20-%20EPR%20-%20Fasi%20dei%20contest%20e%20approfondimento%20WIP/TASK.md). Collegata a EPR-002 per la distinzione fra ricognizione storica, copertura verificata e aggiornamento futuro; le due proposte non si autorizzano reciprocamente.

Valutare la raccolta sistematica delle fasi, delle date e dei passaggi documentati, anche per una vista calendario annuale nell'app: contest impilati su righe, fasi rappresentate graficamente lungo una linea temporale comune. Benefici attesi: confronto fra calendari, individuazione di sovrapposizioni e scadenze, pianificazione dei controlli e consultazione della storia dei contest.

Percorso osservato, non universale: annuncio; iscrizioni/Idea Phase; sviluppo; Component Ready; playtest e feedback, talvolta obbligatori; Contest Ready; correzioni/freeze; votazione e giuria; risultati e conclusione. Fasi sovrapposte, assenti o diversamente denominate sono ammesse. Component Ready e Contest Ready possono essere scadenze delle entry anziché transizioni del contest: preservare nome originale, destinatario e natura dell'evento, senza imporre una sequenza universale o dedurre una transizione dal solo superamento di una data.

Distinguere date previste dal calendario, date effettive documentate da annunci e date delle nostre osservazioni. Conservare proroghe e rettifiche senza sovrascrivere la storia; rendere esplicite precisione, informazioni sconosciute e provenienza. Una data di osservazione non sostituisce una data effettiva sconosciuta. Valutare la gestione di eventi puntuali, intervalli aperti, calendari che attraversano anni solari e più eventi simultanei.

Evidenza datata: nella conversazione del 2026-10-04, riportata dall'utente all'apertura di TSK-0052, risultavano **97 fasi per 22 dei 306 contest**, 11 contest del 2025 e 11 del 2026; **7 fasi prive di date di inizio/fine**, nessuna fase per annualità precedenti. Fotografia storica dichiarata verificata nella conversazione originaria, non ricalcolata in questo task: verificare i conteggi prima di riutilizzarli come stato corrente. Evidenza strutturale locale consultata il 2026-10-04: `database/schema.sql` contiene `contest_phases`; la migrazione `005_contest_phase_history.sql` introduce la storia delle fasi. La presenza di queste strutture non certifica copertura né adeguatezza per tutte le distinzioni proposte.

Alternative da confrontare: mantenere la raccolta opportunistica vigente; ricognizione dedicata di **un solo anno**, con incrementi verificabili per contest sul modello organizzativo delle classifiche; approfondimenti storici selettivi per contest. Per i contest attivi valutare la raccolta degli aggiornamenti nel BGG-M già dedicato al singolo contest. Una ricognizione annuale sistematica richiede estensione contrattuale deliberata: non appartiene automaticamente al censimento roster, MAT o ACQ. TSK-0045/0046 sono precedenti organizzativi per le classifiche, non autorizzazioni trasferibili alle fasi; i censimenti storici TSK-0005/0017 conservano i propri contratti originari.

Tre filoni distinti: **ricognizione storica** (anno, fonti, copertura e criteri da deliberare); **monitoraggio futuro** (singolo contest BGG-M, calendario e snapshot confrontabili); **sviluppo della vista calendario** (successivo task APP autorizzato, con eventuale analisi del modello dati). La vista dipende dalla qualità delle evidenze, ma una copertura storica incompleta può essere mostrata con limiti espliciti: non serve inventare date per riempire la timeline.

Questioni aperte: quale anno e quali contest includere; come distinguere fasi e milestone delle entry; quali fonti attestano i passaggi effettivi; tassonomia e precisione; criterio di completezza della verifica; compatibilità del modello corrente; come visualizzare sovrapposizioni, proroghe e date ignote; costi di raccolta e priorità rispetto ai task aperti. Nessuna ricognizione, migrazione o funzionalità è avviata dalla registrazione.

### EPR-002 — Approfondimento dei thread WIP delle entry

Proposta registrata il 2026-10-04, **da valutare, non adottata**. Responsabile documentale: [TSK-0052](tasks/2026-10-04%20-%20EPR%20-%20Fasi%20dei%20contest%20e%20approfondimento%20WIP/TASK.md); collegata a EPR-001 per provenienza temporale e aggiornamenti, mantenendo contratti e unità di lavoro separati.

Il primo post è spesso il riepilogo principale, ma non garantisce completezza o aggiornamento. Messaggi successivi possono contenere nuovi file, link sostitutivi, requisiti, rettifiche e versioni. Questa possibilità, riportata dall'utente il 2026-10-04, non misura la frequenza del fenomeno. Evidenza locale concreta: [Three Buccaneers](sources/2025-NINE-CARD-MATERIALS.md), entry 447, WIP 3466260, verificato in TSK-0051 il 2026-10-04: il primo articolo rimasto del 3 marzo 2025 era un aggiornamento; il post introduttivo originale non era osservabile. Il caso prova il limite di osservabilità, non la presenza di nuovi materiali recuperabili nel thread.

Il contratto MAT vigente riguarda il **primo post originale**. Una lettura storica completa secondo quel contratto resta completa nel suo perimetro anche senza lettura dell'intero WIP. ACQ riguarda le risorse nel perimetro autorizzato, senza garantire assenza di ulteriori materiali nel thread. File rimossi, accessi limitati, progetti incompleti e materiali non selezionati sono cause distinte di blocco o esclusione; ampliare la lettura non garantisce di risolverle. Preservare attestazioni storiche e copertura effettiva senza riclassificazioni retroattive implicite.

| Alternativa | Beneficio atteso | Limite da misurare |
|---|---|---|
| Approfondimento soltanto per anomalie, versioni discordanti o acquisizioni bloccate | Concentrarsi sui casi con un problema documentato | Può non intercettare aggiornamenti senza segnali nel primo post |
| Ricerca mirata in tutti i WIP, privilegiando autore, collegamenti e annunci di aggiornamento | Recuperare evidenze aggiuntive con un filtro ripetibile | Può perdere requisiti in prosa o contributi pertinenti di altri utenti; copertura mirata da dichiarare |
| Lettura integrale di tutti i WIP | Ampliare la copertura dei messaggi osservabili | Paginazione, testo, citazioni ripetute e discussioni possono moltiplicare il lavoro nei thread lunghi; non risolve contenuti rimossi o ristretti |

Non esistono misure affidabili dei costi. Navigazione e paginazione aumentano il tempo; testo e citazioni aumentano i token, senza una stima quantitativa attendibile. Preferenza preliminare da valutare: approccio mirato, confrontato con le altre alternative mediante **eventuale pilota separatamente autorizzato su 5–10 WIP di lunghezze diverse**. Definire campione e contest, copertura delle tre strategie, baseline del primo post, tempo, consumo disponibile e informazioni aggiuntive recuperate (file/link, requisiti, rettifiche, versioni e utilità per i blocchi). Se il consumo non è misurabile, registrare il limite senza inventare valori. Il pilota non è avviato e non autorizza host esterni o download; un campione fra contest richiede un contratto esplicito distinto dal MAT vigente.

Monitoraggio futuro da progettare separatamente: valutare identificativi/timestamp dell'ultimo messaggio osservato e ricerche di nuovi annunci o link per limitare le riletture, tenendo conto di modifiche a messaggi precedenti, cancellazioni e riordino. Un cursore sugli ultimi messaggi non garantisce di rilevare edit del primo post o di risposte già lette. Conservare URL/ID dei messaggi, autore, date di pubblicazione/modifica se osservabili, data di verifica, versioni, intervalli/pagine letti, criterio di selezione e limiti. Un controllo mirato non diventa lettura integrale e l'assenza di risultati non prova assenza di aggiornamenti.

Dipendenze e decisioni aperte: strategia, segnali di attivazione, unità per contest e numero di entry, copertura minima, gestione di messaggi non osservabili, duplicati e versioni discordanti; integrazione delle nuove evidenze senza alterare originali e attestazioni MAT/ACQ; criteri di successo del pilota, priorità e frequenza dei controlli futuri. Prima di un'adozione deliberare l'eventuale estensione del contratto e l'applicazione storica, senza confonderle con la manutenzione delle skill TSK-0048. Benefici attesi: recupero di informazioni utili e diagnosi più precisa dei blocchi; entità del recupero e costi restano sconosciuti.

### Visualizzazione multiformato della libreria

Requisito confermato dall'utente il 2026-10-03, dopo l'incremento Libreria: progettare la futura visualizzazione interna come funzionalità estensibile per formato, iniziando dai PDF presenti. Quando vengono introdotti materiali JPG/JPEG, PNG, TXT, DOC/DOCX o altri formati, verificare nello stesso task il supporto di visualizzazione e integrare il visualizzatore appropriato quando tecnicamente fattibile e sicuro; altrimenti registrare il limite e il successivo intervento necessario. Non considerare automaticamente coperto un formato perché il file è acquisito.

La scelta del visualizzatore deve basarsi su tipo verificato e contenuto, non sulla sola estensione. Immagini e testo richiedono rendering controllato; documenti Office possono richiedere conversione locale con derivati separati e tracciabili. Nessuna esecuzione di macro, script o contenuti attivi, nessun caricamento verso servizi esterni, nessuna alterazione degli originali. I formati non supportati devono essere segnalati esplicitamente nell'interfaccia. Il requisito fu registrato prima dell'implementazione; il primo task PDF del 2026-10-03 ha deliberato l'eccezione limitata ai PDF descritta sopra. Ulteriori formati richiedono task autonomi e revisione del relativo contratto di sicurezza.

### Simulatore di giochi

Valutare un motore interno che permetta al progetto di implementare in modo modulare simulazioni digitali di giochi selezionati. Il motore non è destinato alla programmazione da parte dell'utente finale. I giochi dovranno poter esporre, senza confonderlo con le presenze su piattaforme esterne, uno stato specifico relativo alla disponibilità e maturità della simulazione nell'app. Architettura, formato delle implementazioni, verifica delle regole e interfaccia saranno definiti in un task autonomo.

### Prototipazione 3D per la stampa

Valutare un'area trasversale per progettare componenti stampabili in 3D di giochi selezionati: plance, board, pedine, schede o supporti di gioco, scatole e organizer. I progetti dovranno essere collegati al gioco e, quando necessario, alla specifica edizione; sorgenti modificabili, STL derivati, versioni, misure, dipendenze, licenze e profili di stampa dovranno restare tracciabili. La funzionalità sfrutterà l'inventario completo dei materiali, ma sarà progettata e implementata in task dedicati.

## Classificazione evolutiva delle risorse dichiarate

La classificazione dei collegamenti dichiarati nei WIP evolve per osservazione. Funzione, forma tecnica e stato dell'evidenza restano dimensioni separate. I valori usati durante il censimento sono provvisori e saranno consolidati soltanto dopo la scansione trasversale di tutti i contest 2025; testo e contesto originali restano preservati.

## Libreria multiformato e contenuti derivati (APP-005)

Incremento autorizzato il 2026-10-03: Libreria con una riga per gioco, icone e dimensioni, dettagli accessibili, filtri sui file e paginazione di 50 giochi. PDF conservato; PNG validati trasferiti tramite ID/token e letti dal browser; DOCX trasformati in JSON testuale limitato, senza impaginazione Word, immagini, macro o risorse esterne. Il server e gli originali restano in sola lettura; CSP estesa soltanto alle immagini blob locali.

L'estrazione ZIP ha un ciclo di vita offline distinto, in `catalog/extract_registered_archives.py`, separato dall'app HTTP. La migrazione additiva 011 collega ogni file estratto al file archivio, al suo hash e al percorso interno, con data e stato di estrazione; i contenuti ereditano acquisizione e provenienza. Originali, versioni e ZIP annidati preservati, senza ricorsione. Manifest testuali versionati, backup e binari esclusi da Git. Limiti, transazioni e verifiche in `app/README.md` e nel task APP-005. I conteggi di file registrati includono originali e contenuti estratti e non misurano il numero di risorse remote o la completezza di un gioco.

## Estensione annuale classifiche BGG — 2026-10-04

Il 2026-10-04 l’utente delibera per TSK-0045 il task continuativo `BGG-A - Classifiche BGG 2025`: estensione annuale limitata a risultati e votazioni, con incrementi per contest, provenienza, confronto con baseline e distinzione fra completezza delle verifiche e percentuale di entry in classifica. Il censimento roster resta distinto; WIP, materiali, host esterni e download restano esclusi. Riprese su richiesta nella stessa chat, senza automazione. Le challenge prive di roster restano dipendenza esplicita. PWS resta 1.5.0. Contratto in `tasks/2026-10-04 - BGG-A - Classifiche BGG 2025/TASK.md`.

## Estensione annuale classifiche 2024 — 2026-10-04

L’utente ha confermato TSK-0046, `BGG-A - Classifiche BGG 2024`, incremento annuale circoscritto ai risultati e votazioni dei contest con roster esistente. Provenienza e confronto con baseline per contest; completezza della verifica separata dalla presenza in classifica. Roster aggiuntivi, WIP, materiali, host esterni e download esclusi. Le challenge senza roster restano dipendenza del censimento. Contratto: `tasks/2026-10-04 - BGG-A - Classifiche BGG 2024/TASK.md`. PWS invariato a 1.5.0.
### Metriche di completamento del lavoro — 2026-10-04

APP-008 introduce attestazioni additive `entry_work_observations` e `contest_census_observations` (migrazione 012). `app/work_progress.py` è il calcolo condiviso da app e cruscotto: completezza del roster attestata per snapshot, verifica completa delle classifiche distinta dai piazzamenti, censimento dichiarativo del primo post secondo MAT e acquisizione completa dei collegamenti nel perimetro documentato. Ignoti e blocchi restano incompleti; non applicabili espliciti escono dal denominatore. Fonti e date storiche delle attestazioni riutilizzate restano separate dalla formalizzazione successiva. Le immagini rappresentative hanno soltanto un indicatore 0% non implementato. Contratto dettagliato in `app/README.md` e TSK-0047; nessun nuovo workflow BGG o IMG autorizzato.

## Organizzazione delle competenze locali — 2026-10-04

Decisione TSK-0069 del 2026-10-05: verifica dell’efficacia obbligatoria alla chiusura degli incrementi significativi che applicano skill, comprese riprese storiche; nessun riesame retroattivo obbligatorio. Protocollo autorevole, criteri e confine manutenzione tecnica/evoluzione in [TASK_GOVERNANCE.md](TASK_GOVERNANCE.md#verifica-dellefficacia--decisione-tsk-0069-2026-10-05). TSK-0048 raccoglie le migliorie pertinenti mediante collegamenti alle evidenze sorgenti; PWS invariato.

Il contenitore GPR TSK-0048 mantiene un inventario in [sources/SKILL_INVENTORY.md](sources/SKILL_INVENTORY.md), una base tecnica BGG e sei skill specialistiche: censimento identità contest, classifiche, materiali dichiarati, acquisizione, scoperta fonti e preanalisi di una fonte. Il censimento annuale entry conserva una procedura autonoma identificabile nella base BGG, distinta dal censimento globale. Playbook e percorsi storici restano validi; routing in AGENTS.md. La riorganizzazione non introduce workflow, migrazioni dati, nuove adozioni di fonti o estensioni annuali ulteriori. PWS resta 1.5.0.


## Workflow immagini — 2026-10-05

TSK-0065 delibera `sources/IMAGE_WORKFLOW.md`: raccolta completa utile per singolo contest/anno BGG o giochi Kanare selezionati, provenienze leggibili, tassonomia, estrazioni per componente, varianti superiori, naming e libreria per gioco. Manifest/versioni/hash e riferimenti senza file; copertura per categoria distinta da originali/AI, AI tramite Codex con validazione utente. Fonti future richiedono contratto proprio. La skill `.agents/skills/game-image-acquisition/SKILL.md` applica il workflow. Tecniche IMG ancora da collaudare su primo lotto; dati e app non implementati.

La mappa include `sources/IMAGE_WORKFLOW.md`, `sources/IMAGE_CONTEST_CODES.md`, la nuova skill e la futura radice `library/immagini/`. Manifest testuali in catalog, binari fuori Git. Requisiti app approvati (miniature, galleria, componenti, lacune, principale, proposte AI separate) in task APP futuro; generazione AI interna all’app resta potenziale evoluzione separata. PWS invariato.

Il 2026-10-06 TSK-0070 realizza il MAT Kanare autorizzato per i 64 giochi esistenti, distinto dai workflow BGG: skill `kanare-material-census` collaudata prima su 2 e poi su 5 ulteriori giochi, quindi sul restante perimetro. Inventario e osservazioni nel manifest `catalog/kanare_material_census_2026-10-06.json`; fonti/crediti/data/posizioni e confezioni separate dai requisiti. 62 analisi complete nel perimetro, Candy Chain parziale per contraddizione plancia, Swarm bloccata per assenza di materiale puntuale osservabile; 62 URL PDF EN consultati in memoria o dai tre originali locali. Altre lingue solo metadati, nessuna acquisizione o modifica app. Il nucleo generale è riusato tramite ID; requisiti nel manifest, perché le tabelle dei requisiti operative sono legate alle entry BGG. Nessuna migrazione implicita, DB e PWS invariati.

## Avanzamento multifonte — TSK-0071, 2026-10-06

L’utente adotta schede indipendenti per fonte nella sezione Avanzamento. BGG conserva annualità/contest; Kanare usa giochi canonici, confezioni e schede native, con metriche separate per catalogo, MAT, ACQ selezionata e IMG selezionata. Nessuna media globale, nessuna acquisizione implicita. Nuove fonti richiedono layout e denominatori propri.

`app/source_progress.py` legge il database e attestazioni versionabili: `catalog/kanare_progress_scope_2026-10-06.json` riconcilia censimento TSK-0020 e lotto ACQ TSK-0023 preservandone le date; il manifest MAT TSK-0070 fornisce requisiti/esiti. Nessuna migrazione SQLite. File condivisi e confezioni non duplicano giochi nei totali; denominatore zero/assenza di attestazione restano espliciti. Metriche, verifiche tecniche e manutenzione dei manifest in `app/README.md`; IMG dipende dal task APP dedicato TSK-0067. Le sezioni annuali generate del cruscotto restano BGG.

## Persistenza multifonte PerGioco — B-v1 adottata

Decisione esplicita TSK-0076 del 2026-10-06: adottati architettura logica B-v1 e piano identita, non implementati. Registro autorevole della decisione: [DECISIONE.md](tasks/2026-10-06%20-%20EPR%20-%20Persistenza%20multifonte%20per%20PerGioco/DECISIONE.md); contratto in MODELLO_LOGICO.md e compatibilita/accettazione in COMPATIBILITA_E_VALIDAZIONE.md della stessa cartella.

Estensione additiva generica del nucleo 009: record fonte e giochi canonici distinti, osservazioni append-only e baseline CAT tracciata; esiti di ammissione/completezza separati da sviluppo e matching; classificazioni native multiple con percorsi ordinati/segmenti e URL/data, mapping comune inizialmente vuoto. URL storici/richiesti/finali, redirect/login, menzioni senza URL e destinazioni condivise conservano prove contestuali separate. Condizioni/accessi/costi/completezza distinti per contenuto pubblico, regole complete, componenti/prodotti e implementazioni; gratuita non equivale a licenza. Istanze di problemi, crediti per ruolo/organizzazioni irrisolte e lacune senza persone fittizie; asserzioni tra record e dipendenza informativa distinte da possesso/acquisto. Proiezioni canoniche richiedono decisioni sulle identita e sulle attribuzioni.

Piano delle sole dodici candidate CAT: otto nuove identita conservative (Achi, Krypte, Abande Libre, Chomp, Itinera, Reversi, Beeline 1968 e 1984); Abande solo candidato a 993; Azul e Blockade 1975/2001 record fonte con requisito non dimostrato senza giochi automatici. Esiti CAT 9/3 invariati. Itinera un gioco e due istanze datate, soluzioni separate senza collegamenti a schemi non provati. Nessun arco canonico confermato Libre verso 993; alternative di tavoliere interne non creano giochi, omonimi non fusi per titolo.

TSK-0073 governa il perimetro; TSK-0074 e TSK-0075 restano completati. Nessun sottocatalogo PerGioco, backfill o riesame implicito BGG/Kanare; dati/evidenze legacy preservati, formalizzazioni future con contratto proprio e date originarie distinte. Schema/database/app restano invariati. Migrazione DAT, importazione PerGioco, eventuale VER Abande, APP e acquisizioni richiedono passi autorizzati separatamente. Il DAT dovra provare su copia vincoli, idempotenza, collisioni/NULL, conservazione legacy, backup e ripristino. PWS 1.5.0, Standard invariato.


## Migrazione 013 operativa — TSK-0077, 2026-10-06

Dopo adozione B-v1 TSK-0076, l'utente autorizza esplicitamente il DAT di schema e l'applicazione operativa dopo collaudo. Migrazione 013 additiva applicata: 21 tabelle generiche, storia append-only, chiavi/owner/FK/proiezioni tipizzate; schema nuovo allineato, tabelle legacy e tutti i loro dati/ID/viste preservati. Mapping fisico in `tasks/2026-10-06 - DAT - Schema multifonte per PerGioco/MAPPING_FISICO.md`; prove 15 test comportamentali e 12 controlli di integrazione su copie, backup consistente/restore/WAL, rollback e replay. Lettura app operativa invariata, nuovi insiemi vuoti.

Il modello logico e ora implementato nello schema, ma PerGioco non e importato: esiti CAT 9/3 e piano otto identita/Abande candidato 993/tre source-only restano nel manifest, nessun game nuovo o matching cambiato. Itinera uno/due e relazioni Libre sono vincoli del futuro import. Zero backfill/riesame BGG/Kanare, nessuna implementazione APP o acquisizione. Importazione PerGioco richiede un nuovo DAT autorizzato e collaudato; APP separata. PWS invariato 1.5.0.

## Consultazione PerGioco — TSK-0079, 2026-10-08

APP autorizzata dopo importazione TSK-0078. `app/source_evidence.py` legge genericamente B-v1/013, `app/pergioco_progress.py` adatta il campione PerGioco e `app/static/source-records.js` espone roster e schede. Nessuna migrazione, scrittura SQLite o richiesta a fonti esterne. TSK-0067 immagini conserva il proprio scope.

Navigazione `#source/pergioco`, schede `#source-record/<ID>` e API `/api/source-records/<ID>`: tutti i record nativi, inclusi source-only e candidati, restano separati dai giochi canonici. Le schede canoniche collegano le dichiarazioni fonte senza promuoverle. Risorse legate a matching candidato non sono attribuite al canonico. Ricerca per titoli/alias, classificazioni e crediti/ruoli; categorie per uguaglianza di etichetta/segmento, filtri combinabili, ordinamento e pagine da 25 record. I contatori di fonte e avanzamento non dipendono dai filtri. La ricerca canonica consulta metadati delle sole fonti con matching confermato.

Classificazioni mantengono tipo, percorso ordinato, percorso non dichiarato, segmento indice e appartenenze multiple; mapping comune separato. Menzioni senza URL restano consultabili, senza collegamenti inventati. Accesso tecnico, contenuto osservato, completezza, costo, playtest e condizioni sono distinti per ambito. NULL resta ignoto. URL storici/richiesti/finali e login non vengono seguiti automaticamente. Istanze e associazioni provate restano separate dai giochi; relazioni tra record non creano archi canonici.

Crediti conservano ruolo, soggetto/contesto, stato, lacune, fonte e data anche senza risoluzione a persone. Le condizioni e gli avvisi non certificano licenze. Libreria di record usa solo file esplicitamente attribuiti tramite catalog_resources e identità confermata; il pilota non ha file. Lettori e protezioni per ID/token/confinamento restano quelli esistenti.

Avanzamento `#progress/pergioco`: catalogazione completa attestata nel CAT / record del campione; ammissione attestata / record del campione; presenza di chiavi e osservazioni importate / record del campione. Identità confermate, candidati, source-only e istanze sono quantità separate. Perimetro e denominatore da manifest CAT congelato, stato importazione da SQLite corrente: imported_count storico del CAT non è operativo. Nessuna completezza dell’intero sito, media tra fonti o MAT/ACQ/IMG inferita; fasi senza perimetro/attestazione mostrano — con motivo. Queste quantità attuano la richiesta autorizzata, senza cambiare le metriche BGG/Kanare.

Storia: solo supersedes esplicito sostituisce una prova. Eventi indipendenti restano consultabili; non si sceglie l’ultimo ID come verità universale. Le righe figlie mostrano osservazione, rettifica e appartenenza a snapshot storico. L’app non risolve conflitti né unifica osservazioni parziali; consultare gli eventi e le decisioni prima di una correzione DAT. Date originali, formalizzazione e aggiornamento pagina restano distinti dalla lettura locale. Schema/prove/perimetro mancanti producono avvisi e quantità ignote senza nascondere BGG/Kanare. Schema legacy principale resta necessario.

Verifiche e copertura nel task TSK-0079; screenshot locali in outputs/pergioco-qa fuori Git. Test `test_pergioco.py`, `test_pergioco_frontend.cjs`, `test_pergioco_browser.cjs` (server locale sulla porta 8793). I test comportamentali usano RO operativo e copie isolate; nessuna fixture con regolamenti integrali. Per browser QA usare soltanto localhost.

## Preparazione persistenza IMG — TSK-0067, 2026-10-10

Incremento APP/DAT autorizzato sui due piloti TSK-0068, senza attendere le altre dodici ricerche; IMG resta autonomo/aperto. Migrazione 014 e importatore offline generici collaudati su copie, dati legacy/009/013 preservati. Identità immagini/file distinta da revisioni materiali, categorie e provenienze multiple, componenti/lati/regioni e decisioni datate, ricerca/applicabilità separata. Contratto fisico in MODELLO_E_IMPORTAZIONE.md di TSK-0067. Database operativo ancora 013; applicazione e importazione richiedono consenso finale dopo riepilogo prove. Nessuna nuova proiezione canonica, acquisizione o UI autorizzata in questo incremento.


## IMG 014 operativa — TSK-0067, 2026-10-10

Dopo consenso esplicito utente, migrazione 014 e importazione dei due manifest TSK-0068 applicate con backup/ripristino su copia verificati e transazione esclusiva. Operativo ora 014: 44 immagini/45 file, 16 componenti, 15 regioni; ricerca 2 concluse/12 parziali. Legacy 009/013 completo preservato, integrità/FK valide e replay senza scrittura. `database/schema.sql` include il blocco 014 per nuove installazioni: non rieseguirlo sull'operativo. Evidenza in `tasks/2026-10-05 - APP - Catalogazione e consultazione immagini dei giochi/OPERATIVO_VERIFICHE.json`. Le precedenti note di attesa sono storiche. UI/API/metriche immagini ancora da implementare nei successivi incrementi; nessuna nuova acquisizione o generazione, nessun commit/push.


## Consultazione IMG nelle schede — 2026-10-10, TSK-0067

Incremento 2 completato: app/game_images.py e static/game-images.js espongono solo lettura per ID, galleria/zoom/miniature progressive, categorie/provenienze, componenti/lati/regioni, proposte AI e storico. Si riusano sessione/confinamento della Libreria, verificando anche hash/bytes e formati; derivati solo in memoria e originali immutati. Nessuna scrittura UI, nuova acquisizione o AI. Dati/schema/metriche invariati; app già aperta da riavviare. Verifiche nel task (41 test IMG, 17 server, browser 1400/780/390), report VERIFICHE_INCREMENTO2.json. TSK-0067 resta aperto per incremento 3 liste/principale/copertura/avanzamento; nessun commit/push.

## Incremento IMG 3 — TSK-0067, 2026-10-10

Principale/fallback, miniature nascondibili nelle liste, tabella copertura e filtri, metriche condivise e barra/torta uniche a tre segmenti implementate e collaudate. App e generatore usano app/image_progress.py tramite work_progress.py: ricerca conclusa per entry/contest / totale entry, immagini adottate e assenza distinte; ricerca parziale non completata dai file. Sezioni annuali rigenerate, dati/schema e 45 immagini/38 PDF immutati. Dettagli e VERIFICHE_INCREMENTO3.json nel task; app/README.md documenta uso/limiti. Task in_verifica per leggibilità visuale con utente; TSK-0068 autonomo. Nessun commit/push.

## Completamenti IMG collaudati — TSK-0067, 2026-10-10

Implementati i tre blocchi del riesame: indicatore per contest/link entry, filtri indipendenti combinabili e ricerca contestuale per categoria/categorie vuote, componenti per sottotipo e avviso revisione precedente con evidenza esplicita. App sola lettura, nessuna nuova classificazione, schema/dati/originali e metriche aggregate invariati. 69 test Python mirati e tre suite browser responsive passati; report VERIFICHE_COMPLETAMENTI.json nel task. Stato in_verifica per valutazione visuale utente; TSK-0068 autonomo, nessun commit/push. Guida/metadati in app/README.md e MODELLO_E_IMPORTAZIONE.md.
