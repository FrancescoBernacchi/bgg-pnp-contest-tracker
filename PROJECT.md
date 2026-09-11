# PnP Collection

## Scopo

Costruire un archivio locale consultabile di giochi Print and Play, iniziando dai contest di design pubblicati su BoardGameGeek. Il sistema deve aiutare a scoprire tempestivamente i giochi, conservarne le informazioni e preservare i materiali più rilevanti prima che diventino indisponibili.

## Scope

Nella prima fase la fonte è esclusivamente BoardGameGeek. Il progetto cataloga tutte le entries individuate nei contest inclusi nel perimetro e scarica i materiali soltanto per i giochi selezionati. La ricerca di ulteriori fonti richiederà un task dedicato.

I contest affini che non producono necessariamente giochi PnP autonomi possono essere inclusi come `adiacenti`, mantenendo esplicita la loro tipologia e le dipendenze esterne. Le varianti Solomode, in particolare, dipendono normalmente da un gioco base e devono restare distinguibili dai giochi PnP autonomi, così da poter ricevere filtri e trattamenti differenti in futuro.

Nel database questa distinzione usa `contests.scope_type` e `contests.treatment_profile`; la natura delle singole entry usa `entries.entry_kind` e `entries.base_game_dependency`. Le note originali restano conservate e questi campi rappresentano soltanto la classificazione operativa normalizzata.

Le viste `v_contests_monitoring_all`, `v_contests_pnp_core`, `v_contests_adjacent`, `v_entries_standalone` e `v_entries_dependent_variants` costituiscono l'interfaccia di lettura stabile per report e applicazione. La vista generale calcola i conteggi correnti e la prossima fase non trascorsa al momento della consultazione.

La baseline corrente comprende 11 contest del 2026 e 11 edizioni del 2025, distribuite su 13 serie. Sono censite 829 entry: 365 del 2026 e 464 del 2025, relative a In-Hand, 9-Card Nanogame, Children & Family, 1-Card, Solomode, Solitaire, Two-Player, 54-Card, Traditional Deck, Wargame e Roll & Write. Nel complesso risultano 770 giochi autonomi e 59 varianti dipendenti: 21 varianti Solomode del 2026 e 38 del 2025. Traditional Deck usa `format_adjacent`, Bad Comet `selective_entries` e Solomode `dependent_variants`. L'esplorazione 2025 è conclusa: le undici edizioni individuate hanno un censimento dedicato e la ricognizione finale non ha trovato altri contest annuali PnP con evidenza BGG sufficiente. Le challenge brevi, le challenge di gioco e i concorsi esterni annunciati nel forum rimangono fuori da questa baseline e sono documentati separatamente.

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

Il cruscotto Markdown corrente è rigenerabile dal database locale con `app/generate_monitoring_report.py`; legge le viste operative e non accede a BGG né ai materiali delle entry.

Dal 7 settembre 2026 l'interfaccia di consultazione è realizzata con Python 3.12+ e sola libreria standard (`app/server.py`), asset HTML/CSS/JavaScript locali (`app/static/`) e launcher PowerShell (`app/start.ps1`). Non richiede build o dipendenze aggiuntive. Il server è limitato a `127.0.0.1`; ogni richiesta usa una transazione SQLite in sola lettura (`mode=ro`, `query_only`). Ricerca, filtri, navigazione e aggiornamento sono operazioni locali sui metadati; la libreria dei materiali non è esposta né consultata. La guida operativa è `app/README.md`.

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

L'esplorazione annuale raccoglie anche il thread WIP BGG dedicato, i collegamenti alle risorse e i requisiti materiali dichiarati nel primo post, senza aprire le destinazioni esterne. `entry_resource_scans` conserva anche gli esiti negativi o non osservabili; `entry_resource_mentions` collega la risorsa alla specifica entry e alla fonte BGG; `remote_resource_observations` distingue la dichiarazione nel WIP dalla successiva verifica di disponibilità. `entry_material_scans` dichiara la copertura della rilevazione (`first_post_only` o successivamente `rules_integrated`), mentre `entry_material_requirements` conserva nome originale e normalizzato, quantità, categoria provvisoria, obbligatorietà, modalità di approvvigionamento, contesto e fonte. L'inventario tratto dal primo post resta esplicitamente integrabile quando le regole saranno acquisite in un task separato.

Le prossime finestre operative e gli ultimi controlli sono mantenuti in `sources/MONITORING_CALENDAR.md`. Il monitoraggio evita rilevamenti duplicati nella stessa giornata e distingue i controlli tecnici locali dalle nuove osservazioni dello stato pubblicato su BGG.

## Deliverable

- applicazione locale di consultazione;
- database operativo SQLite;
- schema e migrazioni riproducibili;
- catalogo ed esportazioni testuali versionabili;
- libreria locale dei materiali selezionati;
- manifest con versione, provenienza, data di acquisizione, dimensione e hash dei file;
- report su contest, disponibilità, classifiche e priorità di acquisizione.

## Stakeholder / destinatari

Uso personale del proprietario del progetto. Nessuna pubblicazione o redistribuzione dei materiali è inclusa nello scope iniziale.

Il codice e la documentazione sono conservati anche nel repository GitHub privato `FrancescoBernacchi/bgg-pnp-contest-tracker`, branch `main`. Database operativo, output rigenerabili e materiali di terzi restano esclusi dal repository.

Poiché l'utente sta acquisendo familiarità con Git e GitHub, l'agente fornisce supporto proattivo sulle azioni di versionamento: indica quando conviene creare commit, branch o push, ne spiega la motivazione e verifica l'esito. Le operazioni non vengono eseguite senza una richiesta o autorizzazione chiara. Il riferimento operativo è `GIT_GUIDE.md`.

## Conoscenza condivisa

Il modello concettuale distingue contest, entry, gioco, persona/credito, stato, classifica, risorsa remota, acquisizione e file locale. I valori normalizzati non sostituiscono mai il testo originale da cui derivano.

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

## Classificazione evolutiva delle risorse dichiarate

La classificazione dei collegamenti dichiarati nei WIP evolve per osservazione. Funzione, forma tecnica e stato dell'evidenza restano dimensioni separate. I valori usati durante il censimento sono provvisori e saranno consolidati soltanto dopo la scansione trasversale di tutti i contest 2025; testo e contesto originali restano preservati.
