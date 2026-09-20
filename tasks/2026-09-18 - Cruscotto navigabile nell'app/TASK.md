# Cruscotto navigabile nell'app

## Scope

Integrare nell'app locale una vista di avanzamento derivata dal database che riprenda gli indicatori annuali del cruscotto di progetto e offra collegamenti rapidi verso anni, contest, entry e stato dei materiali.

## Input

- `PROJECT_PROGRESS.md`, in particolare le sezioni annuali A e B.
- `app/generate_project_progress.py`, come riferimento per la semantica degli indicatori.
- database SQLite operativo e API/UI dell'app esistente.

## Deliverable

- API di sola lettura con indicatori annuali e per contest.
- nuova vista **Avanzamento** nell'app, navigabile e responsive.
- collegamenti contestuali alle viste contest, entry, risultati e materiali.
- test backend e frontend e documentazione d'uso aggiornati.

## Criteri di successo

- Gli indicatori non duplicano dati manuali del Markdown, ma sono calcolati dal database con la stessa semantica essenziale.
- Un anno permette di restringere rapidamente i contest e le entry; un contest apre la sua scheda e le sue entry.
- Lettura materiali e download restano distinti e non fanno inferenze in assenza di dati.
- Nessun accesso esterno, download o modifica del database.
- Test automatici Python e JavaScript superati sul database sintetico e, se disponibile, su quello operativo.

## Stato

Concluso il 2026-09-18.

## Risultati

- Aggiunta la sezione di navigazione **Avanzamento**, con selettore 2008–2026 e tabella per contest.
- Calcolati da SQLite conteggi di entry, stati noti, categorie di classifica, letture materiali e giochi con file acquisiti.
- Collegati gli indicatori alle schede contest, alle classifiche e agli elenchi entry filtrati.
- Estesa la vista entry con filtri per anno e materiali e con indicatori separati `L`/`D`.
- Nessun dato del catalogo, materiale o fonte esterna è stato modificato o consultato.

## Verifiche

- `python -m unittest discover -s app -p test_server.py -v`: 16 test superati usando il runtime Python integrato di Codex.
- `node --test app/test_frontend.cjs`: 17 test superati.
- Database operativo incluso nelle verifiche di copertura e integrità previste dalla suite.
- Rotte HTTP, sola lettura, isolamento dei file locali e rifiuto dei metodi di scrittura restano coperti.

## Decisioni riutilizzabili

La vista nell'app non legge né interpreta `PROJECT_PROGRESS.md`: condivide la semantica essenziale degli indicatori, ma li ricalcola dal database autorevole. In questo modo il Markdown resta il quadro operativo versionabile e l'app una modalità di esplorazione interattiva coerente ma indipendente dalla formattazione del documento.

## Prossimo approfondimento utile

Quando il censimento globale sarà consolidato nel database, la stessa vista mostrerà automaticamente le nuove annualità e i nuovi contest. Prima di allora, gli anni non importati restano esplicitamente vuoti e non producono entry inferite.

## Incremento grafico Pipeline

Su scelta dell'utente è stata adottata la terza proposta grafica. Le annualità importate mostrano quattro barre confrontabili sul totale delle entry: stato noto, presenza in almeno una classifica, lettura materiali e presenza di file acquisiti. Gli anni non ancora importati sono raccolti in una sezione espandibile compatta. La suite aggiornata ha superato 16 test backend e 18 test frontend.

### Correzione delle barre

La prima realizzazione impostava la larghezza tramite attributi `style`, correttamente bloccati dalla Content Security Policy dell'app. Le barre sono state sostituite con elementi HTML nativi `progress`, alimentati da `value` e `max`: la proporzione non dipende più da stili inline e rimane compatibile con la policy di sicurezza.

### Densità della griglia

Su richiesta dell'utente, la griglia desktop mostra cinque schede annuali per riga. Spaziatura, testate e barre sono state rese più compatte mantenendo visibili etichette e valori. La disposizione passa a tre colonne sotto 1100 px, due sotto 820 px e una sotto 520 px.

## Incremento 2026-09-19 — perimetri separati

Le 127 challenge da 24 ore sono state riclassificate nel database come `adjacent` con profilo `format_adjacent`, preservando contest, fonti e stato. La migrazione ripetibile è `database/migrations/008_24h_challenges_adjacent.sql`; anche il generatore del censimento globale produce ora direttamente questa classificazione.

Le schede annuali dell'app espongono due blocchi indipendenti, **PnP principali** e **Adiacenti**. Ciascun blocco possiede conteggi propri per contest, entry, classifiche, lettura materiali e file acquisiti. Le challenge brevi non entrano quindi più nel denominatore dei PnP principali.

Verifiche: 127/127 challenge classificate adiacenti, numero di entry invariato, `integrity_check=ok`, nessuna violazione delle chiavi esterne, 16 test backend e 19 test frontend superati.
