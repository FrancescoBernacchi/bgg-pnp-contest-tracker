# BGG PnP Contest Tracker

Archivio locale per monitorare contest di game design Print and Play pubblicati su BoardGameGeek: stato, fasi, scadenze, statistiche ed evoluzione delle entry.

## Stato attuale

- 11 contest 2026 monitorati: 8 PnP principali e 3 adiacenti autorizzati;
- 365 entry censite: 344 giochi autonomi e 21 varianti dipendenti da un gioco base;
- cronologia di stati, metriche, entry, fasi e scadenze;
- cruscotto Markdown rigenerabile con confronto fra rilevamenti periodici;
- prossimo controllo mirato: 8 settembre 2026, contest Turkish PnP.

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
- `tasks/`: decisioni ed evidenze auditabili;
- `outputs/`: report rigenerabili esclusi da Git;
- `library/`: eventuali materiali acquisiti in flussi separati, esclusi da Git.

## Rigenerazione del cruscotto

Da PowerShell, nella cartella del progetto e con Python 3 disponibile nel `PATH`:

```powershell
python app/generate_monitoring_report.py
```

Il risultato locale è `outputs/contest-monitoring-dashboard.md`. Il generatore legge SQLite in sola lettura e non effettua accessi di rete.

## Versionamento

Il repository remoto privato è `FrancescoBernacchi/bgg-pnp-contest-tracker`; il branch principale è `main`. Schema, migrazioni, cataloghi e documentazione sono versionati. Database operativo, output rigenerabili e materiali di terzi restano locali.

Codex deve accompagnare le operazioni Git spiegando quando sono utili e perché. La procedura condivisa è descritta in `GIT_GUIDE.md`.
