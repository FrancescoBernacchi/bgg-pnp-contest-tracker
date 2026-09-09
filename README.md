# BGG PnP Contest Tracker

Archivio locale per monitorare contest di game design Print and Play pubblicati su BoardGameGeek: stato, fasi, scadenze, statistiche ed evoluzione delle entry.

## Stato attuale

- 22 edizioni monitorate: 11 del 2026 e una baseline di 11 contest del 2025;
- 13 serie individuate; per il 2025 si aggiungono 1-Card e Roll & Write;
- 589 entry censite: le 365 del 2026 e 224 del 2025 (In-Hand, 9-Card Nanogame, Children & Family, 1-Card e Solomode);
- cronologia di stati, metriche, entry, fasi e scadenze;
- cruscotto Markdown rigenerabile con confronto fra rilevamenti periodici;
- applicazione locale di consultazione in sola lettura, con ricerca, filtri, dettagli e confronto conservativo degli snapshot;
- prossimo controllo mirato del task 2026: 8 settembre 2026, contest Turkish PnP;
- censimento storico in corso nel task dedicato al 2025.

I contest adiacenti hanno trattamenti distinti: Traditional Deck (`format_adjacent`), Bad Comet (`selective_entries`) e Solomode (`dependent_variants`).

## Confini

Il monitoraggio usa inizialmente solo fonti BGG. Il task ricorrente dei contest non apre, analizza o scarica file di gioco: conserva esclusivamente metadati pubblici utili a descrivere contest ed entry. L'eventuale acquisizione futura di materiali selezionati appartiene a un flusso separato.

## Struttura

- `PROJECT.md`: scopo e architettura autorevole;
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

Da PowerShell, nella cartella del progetto:

```powershell
.\app\start.ps1
```

Aprire [PnP Collection](http://127.0.0.1:8765). Il launcher usa Python disponibile nel PATH o il runtime integrato di Codex; non occorre installare pacchetti. `Ctrl+C` arresta il server. Guida completa, alternative di avvio e test in `app/README.md`.

Sono disponibili contest principali/adiacenti, ricerca delle entry, fasi, statistiche, risultati e cronologia. Non vengono aperti o scaricati materiali. Il confronto richiede due rilevamenti periodici: la baseline attuale non li contiene ancora; assenze da snapshot non certificati non vengono interpretate come rimozioni.

## Rigenerazione del cruscotto

Da PowerShell, nella cartella del progetto e con Python 3 disponibile nel `PATH`:

```powershell
python app/generate_monitoring_report.py
```

Il risultato locale è `outputs/contest-monitoring-dashboard.md`. Il generatore legge SQLite in sola lettura e non effettua accessi di rete.

## Versionamento

Il repository remoto privato è `FrancescoBernacchi/bgg-pnp-contest-tracker`; il branch principale è `main`. Schema, migrazioni, cataloghi e documentazione sono versionati. Database operativo, output rigenerabili e materiali di terzi restano locali.

Codex deve accompagnare le operazioni Git spiegando quando sono utili e perché. La procedura condivisa è descritta in `GIT_GUIDE.md`.
