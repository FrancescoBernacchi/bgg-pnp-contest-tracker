# Task

## Identificazione

- Titolo visibile previsto: `2026-09-04 - SETUP INIZIALE PROGETTO`
- Nome cartella auditabile previsto: `2026-09-04 - SETUP INIZIALE PROGETTO`
- Titolo visibile verificato: sì
- Cartella auditabile verificata: sì
- Eccezioni di naming: nessuna

## Obiettivo

Comprendere e inizializzare PnP Collection secondo Project Workspace Standard 1.3.0.

## Richiesta / contesto

Creare le fondamenta di un archivio locale di giochi Print and Play scoperti nei contest BoardGameGeek, separando catalogazione completa e acquisizione selettiva dei materiali.

## Scope

Solo discovery, progettazione architetturale e bootstrap. Sono esclusi crawler, popolamento del catalogo, download dei giochi e implementazione dell'interfaccia.

## Input

- indicazioni dell'utente;
- pagine BGG di esempio: forum Design Contests, Guild 4326, contest 2025 Two-Player PnP e relativa GeekList;
- Project Workspace Standard 1.3.0.

## Vincoli / assunzioni

- fonte iniziale limitata a BGG;
- interfaccia locale;
- materiali voluminosi esclusi da Git;
- catalogazione di tutte le entries e download selettivo;
- priorità basata soprattutto su classifiche e votazioni degli utenti.

## Perimetro temporale

`non applicabile: task non evolutivo`

## Deliverable

- `.workspace/PROJECT_STATE.md`;
- `AGENTS.md` e `PROJECT.md`;
- struttura minima motivata;
- `.gitignore` coerente;
- schema dati iniziale.

## Criteri di successo

- progetto dichiarato `initialized` e allineato a PWS 1.3.0;
- istruzioni locali sufficienti per i task successivi;
- separazione tra database, catalogo versionabile e libreria binaria;
- struttura e schema verificabili.

## Verifiche

- marker `.workspace/PROJECT_STATE.md` presente con `status: initialized`;
- titolo visibile e cartella auditabile conformi al naming speciale del bootstrap;
- schema eseguito con successo in un database SQLite in memoria: 11 tabelle e relativi indici creati;
- `.gitignore` verificato per database operativo, materiali della libreria e output rigenerabili;
- struttura ispezionata dopo la creazione: nessun file preesistente è stato perso.

## Stato

Completato.

## Decisioni

- usare un'interfaccia locale;
- usare SQLite come database operativo;
- conservare schema, migrazioni, manifest ed esportazioni in Git;
- escludere da Git materiali PnP e database operativo;
- iniziare il lavoro futuro dai contest attivi più recenti;
- conservare stato specifico e stato normalizzato;
- basare la priorità di acquisizione principalmente sui risultati degli utenti.

## Questioni aperte

- stack applicativo da scegliere nel PoC;
- frequenza di aggiornamento;
- limiti di spazio e fallback di priorità prima della pubblicazione dei risultati.

## Risultati riutilizzabili

Modello concettuale iniziale e regole di separazione tra evidenze, metadati normalizzati e file acquisiti.

## Chiusura

Bootstrap concluso il 2026-09-04. Il progetto è pronto per un task separato dedicato al PoC sul contest BGG attivo più recente. Nessun gioco è stato catalogato o scaricato durante il setup.
