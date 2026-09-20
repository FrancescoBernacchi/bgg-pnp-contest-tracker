# BGG PnP Contest Tracker

Archivio locale per monitorare contest di game design Print and Play pubblicati su BoardGameGeek: stato, fasi, scadenze, statistiche ed evoluzione delle entry.

Lo stato operativo complessivo è raccolto in [`PROJECT_PROGRESS.md`](PROJECT_PROGRESS.md); calendario e finestre dei controlli BGG restano in [`sources/MONITORING_CALENDAR.md`](sources/MONITORING_CALENDAR.md).

## Stato attuale

- 305 contest censiti dal 2008 al 2026; 22 contest del 2025–2026 dispongono già del roster delle entry;
- 19 annualità rappresentate nel database;
- 829 entry censite: le 365 del 2026 e 464 del 2025 (In-Hand, 9-Card Nanogame, Children & Family, 1-Card, Solomode, Solitaire, Two-Player, 54-Card, Traditional Deck, Wargame e Roll & Write);
- cronologia di stati, metriche, entry, fasi e scadenze;
- cruscotto Markdown rigenerabile con confronto fra rilevamenti periodici;
- applicazione locale di consultazione in sola lettura, con ricerca, filtri, dettagli e confronto conservativo degli snapshot;
- prossimo controllo mirato del task 2026: 8 settembre 2026, contest Turkish PnP;
- censimento delle entry 2025 completato per gli undici contest annuali già esplorati; le challenge da 24 ore restano nel censimento globale come contest adiacenti e hanno metriche separate dai PnP principali.

I contest adiacenti hanno trattamenti distinti: Traditional Deck (`format_adjacent`), Bad Comet (`selective_entries`) e Solomode (`dependent_variants`).

## Confini

Il monitoraggio usa inizialmente solo fonti BGG. Il task ricorrente dei contest non apre, analizza o scarica file di gioco: conserva esclusivamente metadati pubblici utili a descrivere contest ed entry. L’app rende consultabili anche i requisiti materiali descritti nel primo post o nelle regole già censite, mantenendoli separati dai collegamenti alle risorse. L'eventuale acquisizione futura di materiali selezionati appartiene a un flusso separato.

Le attività BGG sono organizzate in cinque workflow non sovrapponibili: censimento globale dei contest, censimento annuale delle entry, analisi materiali di un singolo contest, acquisizione/download di un singolo contest e monitoraggio di un singolo contest. Nomi, unità di lavoro ed esclusioni sono definiti in `PROJECT.md`; in particolare analisi e download non vengono eseguiti trasversalmente su più contest.

## Struttura

- `PROJECT.md`: scopo e architettura autorevole;
- `PROJECT_PROGRESS.md`: cruscotto operativo dell'avanzamento complessivo;
- `GIT_GUIDE.md`: guida pratica per commit, branch, push e sincronizzazione;
- `sources/MONITORING_CALENDAR.md`: taccuino dei controlli;
- `database/`: schema, migrazioni e database SQLite locale escluso da Git;
- `catalog/`: importazioni e snapshot testuali versionabili;
- `app/generate_monitoring_report.py`: generatore del cruscotto;
- `app/server.py`, `app/static/`, `app/start.ps1`: applicazione locale e avvio PowerShell;
- `tasks/`: decisioni ed evidenze auditabili;
- `outputs/`: report rigenerabili esclusi da Git;
- `library/`: eventuali materiali acquisiti in flussi separati, esclusi da Git.

## Consultazione nell'app locale

Il modo più semplice è fare doppio clic sul collegamento **PnP Collection** creato sul Desktop. L'app si apre automaticamente nel browser; la finestra del server deve restare aperta durante l'uso.

Da PowerShell, nella cartella del progetto:

```powershell
.\app\start.ps1
```

Aprire [PnP Collection](http://127.0.0.1:8765). Il launcher usa Python disponibile nel PATH o il runtime integrato di Codex; non occorre installare pacchetti. `Ctrl+C` arresta il server. Guida completa, alternative di avvio e test in `app/README.md`.

Sono disponibili contest principali/adiacenti, ricerca delle entry, fasi, statistiche e cronologia. La vista **Risultati** permette di filtrare tutte le classifiche, aprire le entry e consultare vincitori e distribuzione dei piazzamenti per categoria nella sintesi del contest; posizione, punteggio, voti e ufficialità restano distinti. Dalla scheda contest si raggiungono la pagina BGG, le singole entry, i WIP e le risorse dichiarate; le destinazioni esterne si aprono soltanto su click e l’app non effettua verifiche o download automatici. Il confronto richiede due rilevamenti periodici: la baseline attuale non li contiene ancora; assenze da snapshot non certificati non vengono interpretate come rimozioni.

## Rigenerazione del cruscotto

Da PowerShell, nella cartella del progetto e con Python 3 disponibile nel `PATH`:

```powershell
python app/generate_monitoring_report.py
```

Il risultato locale è `outputs/contest-monitoring-dashboard.md`. Il generatore legge SQLite in sola lettura e non effettua accessi di rete.

## Versionamento

Il repository remoto privato è `FrancescoBernacchi/bgg-pnp-contest-tracker`; il branch principale è `main`. Schema, migrazioni, cataloghi e documentazione sono versionati. Database operativo, output rigenerabili e materiali di terzi restano locali.

Codex deve accompagnare le operazioni Git spiegando quando sono utili e perché. La procedura condivisa è descritta in `GIT_GUIDE.md`.
