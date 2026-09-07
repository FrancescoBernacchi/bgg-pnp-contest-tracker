# Consolidamento conoscenza del progetto

## Stato

Completato.

## Obiettivo

Promuovere nei documenti autorevoli tutte le indicazioni, decisioni e conoscenze durevoli emerse nel task ricorrente di monitoraggio contest BGG fino al 7 settembre 2026.

## Scope

Revisione e aggiornamento coordinato di documentazione, mappa del progetto, protocolli operativi e stato PWS. Sono esclusi nuovi accessi a BGG, modifiche ai dati del catalogo, download di materiali e cambiamenti allo schema.

## Input

- task ricorrente `2026-09-04 - monitoraggio contest BGG`;
- stato del database e delle migrazioni 001-005;
- calendario dei controlli;
- configurazione Git locale e repository GitHub privato.

## Deliverable

- pagina introduttiva `README.md` per il repository;
- documentazione coerente su perimetro, profili adiacenti e rilevamenti differenziali;
- istruzioni operative per snapshot completi e classificazione dei controlli;
- stato corrente e prossimi passi aggiornati.

## Criteri di successo

- nessuna decisione durevole resta confinata alla conversazione;
- baseline e controlli periodici sono distinguibili senza ambiguità;
- il task di monitoraggio indica prossimi incrementi ancora attuali;
- riferimenti a Git, output locali e dati esclusi dal repository sono coerenti;
- nessun dato BGG viene presentato come verificato il 7 settembre, poiché non è stato eseguito un controllo esterno.

## Verifiche

- documenti Markdown riesaminati dopo le modifiche;
- collegamenti e nomi dei file controllati;
- `git diff --check` senza errori;
- database operativo lasciato invariato.

## Risultato

Conoscenza consolidata nei documenti autorevoli. Il prossimo evento operativo resta il controllo Turkish PnP dell'8 settembre 2026.

## Estensione successiva

- 2026-09-07: su richiesta dell'utente, aggiunta una guida Git/GitHub per principianti e introdotte in `AGENTS.md` regole permanenti affinché l'agente suggerisca le operazioni di versionamento nel momento opportuno, ne spieghi la motivazione e ne verifichi l'esito senza eseguirle implicitamente.
