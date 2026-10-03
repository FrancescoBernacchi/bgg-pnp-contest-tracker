# Applicazione locale

## Libreria dei materiali acquisiti

La voce **Libreria** consulta `acquisitions` e `acquired_files`: riepiloga giochi, acquisizioni, file, byte registrati, distribuzioni per contest/fonte/lingua/MIME e presenza locale. Offre filtri combinabili per testo, gioco, contest, fonte, anno del contest, lingua, MIME, stato e presenza; ordinamenti per titolo, data recente, dimensione decrescente e nome, con 50 file per pagina. Le schede **Giochi** includono **Materiali locali**, raggruppati per ID di acquisizione e data, mantenendo versioni e fonti separate. Le acquisizioni senza file hanno una sezione distinta.

Il server controlla soltanto l'esistenza dei percorsi relativi registrati sotto la radice `library/` del progetto. Rifiuta assoluti Windows/POSIX, UNC, drive relativi, traversal, stream NTFS e link risolti all'esterno; restituisce `present`, `missing`, `invalid_path` o `unverifiable`, senza restituire il percorso. La verifica non legge il contenuto, non ricalcola hash e non certifica integrità o completezza: SHA-256 e dimensione sono i metadati registrati. Rientrare nella vista o usare **Rileggi database** ripete la verifica. Un file mancante non cambia lo stato remoto registrato.

L'endpoint `GET /api/library` e `local_materials` in `GET /api/games/<id>` sono offline e in sola lettura. Database assente/incompatibile: errore 503 senza creazione; libreria assente: record consultabili e file segnalati mancanti; percorso non valido: stato separato. I binari, le anteprime e l'apertura locale sono esclusi. Un URL HTTPS senza credenziali si apre soltanto su click esplicito.

La completezza dell'acquisizione resta **non determinabile**: lo schema non certifica il perimetro necessario o selezionato. Il lotto è **parziale** soltanto con successi e fallimenti espliciti fra i file registrati. Indisponibilità, non osservabilità e restrizioni remote restano distinte dalla presenza locale. Nessuna acquisizione non equivale a nessuna risorsa dichiarata; esclusioni e assenza dichiarata restano nei metadati di scansione/risorsa delle viste esistenti e nei manifest, senza convertirli in acquisizioni fittizie. La provenienza contest viene attribuita attraverso le menzioni della risorsa BGG, non attraverso qualsiasi contest dello stesso gioco. Un'attribuzione non ricostruibile appare come fonte non determinabile.

La paginazione limita le righe nel DOM; i metadati vengono ancora caricati integralmente, come nelle viste esistenti. Per raccolte molto grandi potrà servire una futura paginazione lato server.

Interfaccia locale: Python 3.12+ e sola libreria standard, HTML/CSS/JavaScript senza compilazione o pacchetti da installare. Il server è vincolato a `127.0.0.1`; il database è aperto con URI `mode=ro`, `PRAGMA query_only=ON` e una transazione di lettura per richiesta.

## Avvio dell'applicazione

### Avvio rapido dal Desktop

Fare doppio clic sul collegamento **PnP Collection** presente sul Desktop. Il launcher trova automaticamente Python, avvia il server e apre l'app nel browser predefinito. La finestra nera che appare deve restare aperta durante l'uso; per arrestare l'app, selezionarla e premere `Ctrl+C`, quindi confermare se Windows lo richiede.

Il collegamento richiama `app/launch.cmd`, che non è soggetto alla Execution Policy di PowerShell, e usa l'icona PnP conservata in `app/assets/pnp-collection.ico`. Se il progetto viene spostato o rinominato, occorre ricreare il collegamento. Il launcher resta disponibile anche direttamente con un doppio clic nella cartella `app`.

### Avvio dal terminale

Da PowerShell nella radice del progetto:

```powershell
.\app\start.ps1
```

Aprire nel browser [PnP Collection locale](http://127.0.0.1:8765). Lasciare la PowerShell aperta; `Ctrl+C` arresta il server. Il launcher cerca Python nel PATH oppure nel runtime integrato di Codex presente su questo computer. È possibile specificare un interprete con `-PythonPath 'C:\percorso\python.exe'` e una porta alternativa con `-Port 8767`.

Se PowerShell impedisce l'esecuzione dello script, non è necessario cambiare le impostazioni del sistema: usare direttamente Python, quando disponibile nel PATH:

```powershell
python app/server.py
```

Oppure, su questo computer:

```powershell
& "$env:USERPROFILE\.cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe" app/server.py
```

Il percorso del runtime integrato può cambiare dopo aggiornamenti di Codex. Il server accetta `--database`, `--port` e `--open-browser`; il launcher PowerShell accetta `-Database` e `-Port`. Il database predefinito è `database/pnp_collection.sqlite3`, risolto dalla posizione dello script anche quando la directory corrente è diversa. Se manca, l'app segnala l'errore senza crearlo. Per uno schema incompatibile consultare `database/README.md`: l'app non applica migrazioni. Una porta occupata richiede la chiusura dell'istanza precedente o una porta diversa.

## Consultazione

- **Giochi**: ingresso comune al catalogo canonico. Ricerca titolo e alias attraverso tutte le fonti, filtro per fonte e per presenza di matching ancora candidati. Il conteggio riguarda identità di gioco, non prodotti o pagine osservate.
- **Kanare_Abstract**: prima vista specializzata non-BGG, limitata ai giochi collegati a record Kanare non respinti. Espone prodotti, implementazioni e ambiguità già registrati senza interrogare la fonte.
- **Dettaglio gioco**: record nativi e stato della riconciliazione, alias, prodotti/confezioni, risorse, implementazioni online e presenze nei contest BGG restano sezioni distinte. Un record `candidate` o `rejected` è mostrato come tale e non produce una fusione implicita.
- **Avanzamento**: schede annuali in forma di pipeline per gli anni importati, con barre per stati noti, entry presenti nelle classifiche, letture materiali e file acquisiti; le annualità non importate restano raccolte separatamente e il dettaglio per contest collega alle viste filtrate e alle schede esistenti.
- **Contest**: schede separate per PnP principali e adiacenti; ricerca per nome, filtri di anno e stato, conteggi comprensivi dei ritiri.
- **Risultati**: tutte le classifiche registrate, ricerca per titolo e crediti, filtri combinabili e pagine da 30 osservazioni; sintesi per contest con vincitori e distribuzione dei piazzamenti per categoria.
- **Tutte le entry**: ricerca per titolo o autore, filtri per contest, perimetro, stato e tipologia; ordinamento e pagine da 30 risultati.
- **Filtri materiali**: dalla vista entry si possono isolare letture registrate, letture non iniziate e giochi con file acquisiti; le colonne `L` e `D` mantengono separati censimento dei requisiti e acquisizione.
- **Dettaglio entry, risorse e materiali**: collegamenti espliciti alla pagina dell’entry e al WIP BGG; risorse dichiarate con URL apribili soltanto su click; requisiti materiali descritti testualmente con nome originale e normalizzato, quantità, necessità, approvvigionamento, contesto e provenienza.
- **Dettaglio contest**: stati originali/normalizzati, dipendenze, distribuzione degli stati, fasi/scadenze con precisione e fuso registrati, metriche correnti e storiche, classifiche ufficiali o segnali sostitutivi.
- **Dettaglio entry**: crediti, stato dei materiali, risorse collegate, requisiti fisici dichiarati con quantità ed evidenza, dipendenza da gioco base, cronologia degli stati, nomi storici e testo originale visualizzato senza interpretare HTML.
- **Scadenze**: prima fase non trascorsa di ogni contest, calcolata dalle viste SQLite al momento della lettura. Non sostituisce il calendario dei controlli `sources/MONITORING_CALENDAR.md`.
- **Rileggi database**: aggiorna i dati senza effettuare nuovi controlli BGG. La data di lettura dell'app è distinta dalle date di verifica delle fonti.

La ricerca e i filtri restano in memoria durante la consultazione, senza preferenze scritte su disco. Gli URL con frammento, per esempio `#game/1`, `#contest/11` e `#entry/362`, permettono di ritrovare una scheda. La prima versione carica in memoria tutti i metadati leggeri del catalogo; non introduce un motore di ricerca separato.

### Confine fra viste comuni e specializzate

Sono comuni alle fonti l'identità canonica del gioco, titoli e alias, ricerca, parametri di gioco generali, prodotti collegati, risorse, implementazioni, crediti e provenienza. Restano specializzate le strutture che appartengono alla semantica di una fonte: per BGG contest, entry, classifiche, fasi, monitoraggio e materiali dichiarati nei WIP; per Kanare il catalogo dell'editore/designer, le confezioni e le piattaforme dichiarate. Aggiungere una fonte futura richiede un record in `catalog_sources`, record nativi e riconciliazioni; la vista Giochi non richiede colonne dedicate alla nuova fonte. Una nuova voce specializzata è giustificata solo quando esistono funzioni proprie della fonte, non per duplicare la lista comune.

## Confronti e limiti dei dati

La UI confronta **due controlli periodici dello stesso contest**, selezionabili in ordine cronologico. Sono periodici i `check_kind` contenenti `monitor`, `scheduled`, `deadline` o `follow_up`, purché non contengano `baseline`, `census` o `consistency`. Tutti gli altri controlli restano visibili nello storico. A parità di timestamp l'ordine è determinato dall'id.

Stato del contest, entry, metriche e fasi sono confrontati separatamente, usando esclusivamente osservazioni collegate tramite `check_id`. Vengono mostrate transizioni di valori originali/normalizzati, posizione, date, unità, metodo e ufficialità. Le osservazioni duplicate della stessa entità e controllo sono risolte per data e id; gli originali restano nel database.

Lo schema non certifica la completezza dello snapshot per entità: `outcome=complete` da solo non basta. Le entità presenti soltanto da un lato sono quindi indicate come **osservate solo nel precedente/successivo**, mai automaticamente aggiunte o rimosse. Uno snapshot vuoto significa dati insufficienti, non zero entry. “Nessuna variazione” si riferisce soltanto ai campi delle entità comuni. I titoli nei confronti sono quelli correnti; la cronologia dei nomi è consultabile nella scheda entry.

Nel database verificato il 7 settembre 2026 esistono soltanto baseline, censimenti e controlli tecnici: il confronto periodico reale sarà disponibile dopo due rilevamenti idonei. Questa app adotta una semantica conservativa propria; non riutilizza né modifica il motore differenziale del precedente report Markdown.

## Confini tecnici e verifica

Nessuna dipendenza esterna, CDN, telemetria o richiesta di rete automatica. L’app consulta anche il nucleo multifonte (`catalog_sources`, `source_records`, riconciliazioni, prodotti, risorse e implementazioni) oltre alle tabelle BGG, sempre in sola lettura; non consulta `library/`. `acquisitions` e `acquired_files` sono usate soltanto per indicatori aggregati già esistenti, mai per aprire file. Non sono disponibili comandi di modifica o acquisizione. Il server espone esclusivamente asset elencati e API di lettura; non espone file del progetto e rifiuta metodi di scrittura e Host non locali.

L'API `/api/catalog` include l'elenco leggero `games` e le fonti disponibili. `/api/games/ID` restituisce il dettaglio relazionale del gioco. BoardGameGeek è esposto anche come fonte virtuale per le entry legacy: finché tali entry non avranno record nativi nella migrazione multifonte, questa etichetta deriva dalla loro presenza nelle tabelle BGG e non inventa un `source_record`.

I dati vengono escapati. Le pagine BGG di metadati e le destinazioni delle risorse diventano link soltanto se hanno una forma ammessa; le risorse richiedono HTTPS e non possono contenere credenziali nell’URL. Tutti i link esterni si aprono in una nuova scheda con isolamento `noopener noreferrer`, esclusivamente dopo il click dell’utente. L’app non segue redirect, controlla disponibilità, apre o scarica materiali durante la lettura della scheda. Il server è destinato all’uso personale locale, non alla pubblicazione o all’esposizione in LAN.

Verifiche riproducibili dalla radice (Python e Node disponibili nel PATH, oppure usare i rispettivi percorsi):

```powershell
python -m unittest discover -s app -p test_server.py -v
node --test app/test_frontend.cjs
```

Python è sufficiente per usare l'app; Node serve soltanto ai test del frontend. I test Python verificano letture, blocco scritture, isolamento HTTP, confronti, classifiche e associazioni entry-risorsa su un database temporaneo, più la copertura del database reale quando disponibile. I test reali vengono saltati se il database operativo è assente. I test JavaScript verificano formatter, protezioni URL, stati delle scansioni, filtri e ordinamenti, null/zero, ex aequo e sintesi. Nessun test modifica il database operativo.

## Navigazione di pagine e risorse

La scheda contest collega la propria pagina BGG. Dalla lista delle entry si apre la scheda individuale, che distingue la pagina che prova l’iscrizione dal thread WIP. La sezione **Risorse dichiarate** usa le associazioni di `entry_resource_mentions`, evitando di attribuire automaticamente a un’entry tutte le risorse dello stesso gioco. Il testo del collegamento privilegia `label_raw`, quindi l’etichetta normalizzata e infine il ruolo della risorsa.

Per ciascuna risorsa sono mostrati ruolo, eventuale indicazione primaria, `access_type`, host, versione, disponibilità registrata, fonte BGG e date. L’ultima osservazione di disponibilità, quando esiste, prevale sullo stato riepilogativo senza eliminare la cronologia sottostante. `unknown` e `not_checked` sono presentati come **Non verificata** e non come indisponibilità.

Se non esistono link, l’interfaccia distingue `none_declared`, `not_observable`, `not_checked` e assenza di scansione. In particolare, `not_observable` chiarisce che il post originale non era leggibile e che l’assenza di un URL non dimostra l’assenza della risorsa. L’app non ricostruisce destinazioni mancanti.

## Materiali dichiarati senza collegamento

La scheda entry presenta **Materiali richiesti** separatamente dalle risorse dotate di URL. I dati provengono da `entry_material_requirements`: il testo `name_raw` e il contesto originale restano visibili, mentre nome normalizzato, categoria, modalità di approvvigionamento e livello `required`, `optional`, `alternative` o `unclear` sono indicati come classificazioni distinte. Una quantità assente viene mostrata come **Non specificata** e non come zero.

La più recente `entry_material_scans` dichiara fonte, data ed estensione della copertura. `first_post_only` indica che le regole possono ancora integrare l’elenco; `rules_integrated` indica che la rilevazione registrata comprende anche le regole. A parità di data prevale la copertura integrata. Gli esiti `none_declared`, `not_observable`, `not_checked` e l’assenza di scansione producono messaggi diversi e non fanno dedurre che il gioco non richieda materiali.

## Classifiche e sintesi dei risultati

Aprire **Risultati** nella navigazione principale (`#rankings`). I filtri combinano contest, anno, perimetro principale/adiacente, categoria originale, ufficialità, posizione e ricerca per titolo o nomi nei crediti. Sono disponibili posizione esatta, intervallo 1–3 e posizione non registrata; ordinamento per contest/categoria, titolo oppure posizione crescente/decrescente. I valori di posizione mancanti restano in fondo negli ordinamenti numerici; gli ex aequo non vengono rinumerati. **Azzera filtri** ripristina tutte le osservazioni.

Le colonne separano posizione, punteggio e voti. `Non registrato` non significa zero; nessun punteggio è ricavato dalla posizione e nessun voto dalle metriche aggregate del contest. La ricerca per autore usa esclusivamente i crediti presenti: dove mancano, viene mostrato `Autore non registrato`. Le categorie mantengono la grafia originale, senza equiparare etichette simili.

Ogni riga contiene natura, fonte e data di verifica, oltre all'identificativo dell'osservazione. Titolo e contest aprono le rispettive schede. Il dettaglio entry mostra tutte le sue categorie e i suoi piazzamenti nel contest di appartenenza. `#rankings/ID` apre tutti i risultati di un contest e azzera gli altri filtri; `#results/ID` apre la sua sintesi. La sintesi è raggiungibile anche da **Statistiche e risultati** nella scheda contest. I normali filtri della vista generale restano in memoria fino al ricaricamento della pagina; non sono salvati su disco né serializzati nell'URL.

La sintesi separa categoria, ufficialità, URL della fonte e data di verifica. Mostra come vincitori soltanto i risultati ufficiali con posizione esplicita 1; per i segnali sostitutivi usa `Primi posti non ufficiali`. Se manca il primo posto, non sceglie il minimo disponibile né il punteggio più alto. La distribuzione conta osservazioni per posizione all'interno del gruppo, incluse quelle senza posizione, e non certifica la completezza della graduatoria. I dettagli espandibili contengono tutte le righe del gruppo.

Lo schema `rankings` non registra metodo/unità del voto, identificativo di edizione della classifica o stato di sostituzione di una precedente osservazione. L'app pertanto non somma né confronta punteggi tra categorie, non sceglie una versione operativa e non elimina osservazioni storiche. Un ex aequo è segnalato quando giochi distinti condividono posizione, contest, categoria, natura, fonte e data; viene riconosciuto anche se il filtro, la pagina o la scheda mostrano uno solo dei giochi. Fonti o date diverse restano separate: non si presume un ex aequo fra osservazioni non confrontabili.

Il 10 settembre 2026 la verifica tecnica locale ha rilevato 1.054 righe in `rankings`, relative a 140 coppie contest/categoria e 16 contest. Tutte sono ufficiali e collegate a una entry; quattro menzioni non hanno posizione. Punteggi e voti non sono registrati per nessuna riga. La gestione dei risultati non ufficiali e dei punteggi/voti è verificata con dati sintetici. Questa è una verifica del catalogo, non un nuovo rilevamento BGG.

L'API `/api/catalog` include `rankings`; le API dei dettagli usano la medesima query con filtri parametrici. Filtri, ordinamento e paginazione sono locali nel frontend. Sulla baseline corrente il catalogo JSON pesa circa 864 KB e la lettura misurata è circa 22 ms su questo computer: non serve cambiare stack. Nessuna migrazione o dipendenza aggiunta. Le tabelle sono scorrevoli anche da tastiera, i filtri hanno etichette e i risultati un'area di annuncio; il layout è stato verificato a 320, 390, 768 pixel e desktop. Le tabelle estese scorrono orizzontalmente nel proprio contenitore su schermi piccoli.


## Cruscotto Markdown preesistente

La scheda entry separa **Risorse dichiarate** (destinazioni URL) e **Materiali richiesti** (componenti e strumenti dichiarati nel primo post). La seconda sezione mostra quantità, classificazione provvisoria, approvvigionamento ed evidenza originale, dichiarando se la copertura è limitata al primo post o integrata dalle regole.

`generate_monitoring_report.py` legge in sola lettura il database operativo e genera `outputs/contest-monitoring-dashboard.md` usando le viste di monitoraggio. Non effettua accessi di rete e non legge la libreria dei materiali.

`generate_project_progress.py` aggiorna le sezioni annuali generate di `PROJECT_PROGRESS.md`: la sintesi per tipologia copre il 2008–2026 in gruppi di massimo quattro anni; il dettaglio è ordinato dal 2026 al 2008, elenca le entry degli anni già importati e mostra una tabella di stato esplicita per quelli ancora da consolidare. Il resto del documento viene preservato. Anche questo comando legge SQLite in sola lettura e non accede alla rete.

La sezione `Cambiamenti dall'ultimo rilevamento` considera come confronto soltanto controlli periodici o legati a scadenze, escludendo baseline, completamenti del censimento e verifiche tecniche. Per alimentarla, un nuovo controllo deve registrare un `contest_checks.check_kind` contenente `monitor`, `scheduled`, `deadline` o `follow_up` e collegare tramite `check_id` gli snapshot di stato, entry, metriche e fasi.

Il report corrente riepiloga contest PnP principali e adiacenti, prossime scadenze, distribuzione degli stati delle entry, metriche più recenti e delta dall'ultimo controllo confrontabile. In assenza di una coppia di rilevamenti periodici mostra esplicitamente che i dati costituiscono ancora la baseline.

Esecuzione prevista dalla radice del progetto, con Python 3 disponibile nel `PATH`:

```powershell
python app/generate_monitoring_report.py
```

Per aggiornare le viste annuali del cruscotto di progetto:

```powershell
python app/generate_project_progress.py
```

Sono disponibili `--database` e `--output` per usare percorsi differenti. L'output predefinito è locale e ignorato da Git.
