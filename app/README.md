# Applicazione locale

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

- **Contest**: schede separate per PnP principali e adiacenti; ricerca per nome, filtri di anno e stato, conteggi comprensivi dei ritiri.
- **Risultati**: tutte le classifiche registrate, ricerca per titolo e crediti, filtri combinabili e pagine da 30 osservazioni; sintesi per contest con vincitori e distribuzione dei piazzamenti per categoria.
- **Tutte le entry**: ricerca per titolo o autore, filtri per contest, perimetro, stato e tipologia; ordinamento e pagine da 30 risultati.
- **Dettaglio contest**: stati originali/normalizzati, dipendenze, distribuzione degli stati, fasi/scadenze con precisione e fuso registrati, metriche correnti e storiche, classifiche ufficiali o segnali sostitutivi.
- **Dettaglio entry**: crediti, stato dei materiali come semplice metadato, dipendenza da gioco base, cronologia degli stati, nomi storici e testo originale visualizzato senza interpretare HTML.
- **Scadenze**: prima fase non trascorsa di ogni contest, calcolata dalle viste SQLite al momento della lettura. Non sostituisce il calendario dei controlli `sources/MONITORING_CALENDAR.md`.
- **Rileggi database**: aggiorna i dati senza effettuare nuovi controlli BGG. La data di lettura dell'app è distinta dalle date di verifica delle fonti.

La ricerca e i filtri restano in memoria durante la consultazione, senza preferenze scritte su disco. Gli URL con frammento, per esempio `#contest/11` e `#entry/362`, permettono di ritrovare una scheda. La prima versione carica in memoria tutti i metadati leggeri del catalogo; è stata verificata sulle 829 entry e 1.054 osservazioni di classifica presenti il 10 settembre 2026, senza introdurre un motore di ricerca separato.

## Confronti e limiti dei dati

La UI confronta **due controlli periodici dello stesso contest**, selezionabili in ordine cronologico. Sono periodici i `check_kind` contenenti `monitor`, `scheduled`, `deadline` o `follow_up`, purché non contengano `baseline`, `census` o `consistency`. Tutti gli altri controlli restano visibili nello storico. A parità di timestamp l'ordine è determinato dall'id.

Stato del contest, entry, metriche e fasi sono confrontati separatamente, usando esclusivamente osservazioni collegate tramite `check_id`. Vengono mostrate transizioni di valori originali/normalizzati, posizione, date, unità, metodo e ufficialità. Le osservazioni duplicate della stessa entità e controllo sono risolte per data e id; gli originali restano nel database.

Lo schema non certifica la completezza dello snapshot per entità: `outcome=complete` da solo non basta. Le entità presenti soltanto da un lato sono quindi indicate come **osservate solo nel precedente/successivo**, mai automaticamente aggiunte o rimosse. Uno snapshot vuoto significa dati insufficienti, non zero entry. “Nessuna variazione” si riferisce soltanto ai campi delle entità comuni. I titoli nei confronti sono quelli correnti; la cronologia dei nomi è consultabile nella scheda entry.

Nel database verificato il 7 settembre 2026 esistono soltanto baseline, censimenti e controlli tecnici: il confronto periodico reale sarà disponibile dopo due rilevamenti idonei. Questa app adotta una semantica conservativa propria; non riutilizza né modifica il motore differenziale del precedente report Markdown.

## Confini tecnici e verifica

Nessuna dipendenza esterna, CDN, telemetria, richiesta di rete esterna, consultazione di `library/`, `remote_resources`, `acquisitions` o `acquired_files`. Non sono disponibili comandi di modifica o acquisizione. Il server espone esclusivamente asset elencati e API di lettura; non espone file del progetto e rifiuta metodi di scrittura e Host non locali. I dati vengono escapati; i soli link attivi verso l'esterno sono pagine BGG di metadati (thread, GeekList, giochi, forum e guild), aperte soltanto su clic dell'utente. I link a file/download e host esterni restano testo. Il server è destinato all'uso personale locale, non alla pubblicazione o all'esposizione in LAN.

Verifiche riproducibili dalla radice (Python e Node disponibili nel PATH, oppure usare i rispettivi percorsi):

```powershell
python -m unittest discover -s app -p test_server.py -v
node --test app/test_frontend.cjs
```

Python è sufficiente per usare l'app; Node serve soltanto ai test del frontend. I 10 test Python verificano letture, blocco scritture, isolamento HTTP, confronti e classifiche su un database temporaneo, più la copertura del database reale quando disponibile. Il test reale viene saltato se il database operativo è assente. I 10 test JavaScript verificano formatter, protezioni, filtri e ordinamenti, null/zero, ex aequo e sintesi. Nessun test modifica il database operativo.

## Classifiche e sintesi dei risultati

Aprire **Risultati** nella navigazione principale (`#rankings`). I filtri combinano contest, anno, perimetro principale/adiacente, categoria originale, ufficialità, posizione e ricerca per titolo o nomi nei crediti. Sono disponibili posizione esatta, intervallo 1–3 e posizione non registrata; ordinamento per contest/categoria, titolo oppure posizione crescente/decrescente. I valori di posizione mancanti restano in fondo negli ordinamenti numerici; gli ex aequo non vengono rinumerati. **Azzera filtri** ripristina tutte le osservazioni.

Le colonne separano posizione, punteggio e voti. `Non registrato` non significa zero; nessun punteggio è ricavato dalla posizione e nessun voto dalle metriche aggregate del contest. La ricerca per autore usa esclusivamente i crediti presenti: dove mancano, viene mostrato `Autore non registrato`. Le categorie mantengono la grafia originale, senza equiparare etichette simili.

Ogni riga contiene natura, fonte e data di verifica, oltre all'identificativo dell'osservazione. Titolo e contest aprono le rispettive schede. Il dettaglio entry mostra tutte le sue categorie e i suoi piazzamenti nel contest di appartenenza. `#rankings/ID` apre tutti i risultati di un contest e azzera gli altri filtri; `#results/ID` apre la sua sintesi. La sintesi è raggiungibile anche da **Statistiche e risultati** nella scheda contest. I normali filtri della vista generale restano in memoria fino al ricaricamento della pagina; non sono salvati su disco né serializzati nell'URL.

La sintesi separa categoria, ufficialità, URL della fonte e data di verifica. Mostra come vincitori soltanto i risultati ufficiali con posizione esplicita 1; per i segnali sostitutivi usa `Primi posti non ufficiali`. Se manca il primo posto, non sceglie il minimo disponibile né il punteggio più alto. La distribuzione conta osservazioni per posizione all'interno del gruppo, incluse quelle senza posizione, e non certifica la completezza della graduatoria. I dettagli espandibili contengono tutte le righe del gruppo.

Lo schema `rankings` non registra metodo/unità del voto, identificativo di edizione della classifica o stato di sostituzione di una precedente osservazione. L'app pertanto non somma né confronta punteggi tra categorie, non sceglie una versione operativa e non elimina osservazioni storiche. Un ex aequo è segnalato quando giochi distinti condividono posizione, contest, categoria, natura, fonte e data; viene riconosciuto anche se il filtro, la pagina o la scheda mostrano uno solo dei giochi. Fonti o date diverse restano separate: non si presume un ex aequo fra osservazioni non confrontabili.

Il 10 settembre 2026 la verifica tecnica locale ha rilevato 1.054 righe in `rankings`, relative a 140 coppie contest/categoria e 16 contest. Tutte sono ufficiali e collegate a una entry; quattro menzioni non hanno posizione. Punteggi e voti non sono registrati per nessuna riga. La gestione dei risultati non ufficiali e dei punteggi/voti è verificata con dati sintetici. Questa è una verifica del catalogo, non un nuovo rilevamento BGG.

L'API `/api/catalog` include `rankings`; le API dei dettagli usano la medesima query con filtri parametrici. Filtri, ordinamento e paginazione sono locali nel frontend. Sulla baseline corrente il catalogo JSON pesa circa 864 KB e la lettura misurata è circa 22 ms su questo computer: non serve cambiare stack. Nessuna migrazione o dipendenza aggiunta. Le tabelle sono scorrevoli anche da tastiera, i filtri hanno etichette e i risultati un'area di annuncio; il layout è stato verificato a 320, 390, 768 pixel e desktop. Le tabelle estese scorrono orizzontalmente nel proprio contenitore su schermi piccoli.


## Cruscotto Markdown preesistente

`generate_monitoring_report.py` legge in sola lettura il database operativo e genera `outputs/contest-monitoring-dashboard.md` usando le viste di monitoraggio. Non effettua accessi di rete e non legge la libreria dei materiali.

La sezione `Cambiamenti dall'ultimo rilevamento` considera come confronto soltanto controlli periodici o legati a scadenze, escludendo baseline, completamenti del censimento e verifiche tecniche. Per alimentarla, un nuovo controllo deve registrare un `contest_checks.check_kind` contenente `monitor`, `scheduled`, `deadline` o `follow_up` e collegare tramite `check_id` gli snapshot di stato, entry, metriche e fasi.

Il report corrente riepiloga contest PnP principali e adiacenti, prossime scadenze, distribuzione degli stati delle entry, metriche più recenti e delta dall'ultimo controllo confrontabile. In assenza di una coppia di rilevamenti periodici mostra esplicitamente che i dati costituiscono ancora la baseline.

Esecuzione prevista dalla radice del progetto, con Python 3 disponibile nel `PATH`:

```powershell
python app/generate_monitoring_report.py
```

Sono disponibili `--database` e `--output` per usare percorsi differenti. L'output predefinito è locale e ignorato da Git.
