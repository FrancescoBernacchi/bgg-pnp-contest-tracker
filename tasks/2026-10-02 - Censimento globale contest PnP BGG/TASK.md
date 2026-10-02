# Censimento globale contest PnP BGG — aggiornamento 2026-10-02

## Stato

Completato il 2 ottobre 2026 dopo che l'utente ha aperto una sessione BGG nel proprio browser. Confermata e importata una nuova edizione: The 2026 Roll & Write Game Design Contest. Totale globale: 306 contest.

## Scopo e confini

Confrontare i contest e le challenge di design PnP pubblicati su BGG dopo la baseline di 305 unità, su tutte le annualità. Registrare solo identità, serie, anno, stato dichiarato e normalizzato, fonte e data. Entry, WIP, risorse e materiali sono esclusi; i cambiamenti dei contest già noti appartengono ai task di monitoraggio dei singoli contest.

## Input e fonti

- Baseline conclusa in `tasks/2026-09-15 - Censimento globale contest PnP BGG/TASK.md`.
- [GeekList corrente](https://boardgamegeek.com/geeklist/355982/community-pnp-contests-and-winners).
- [Forum Design Contests](https://boardgamegeek.com/forum/974620/bgg/design-contests).
- [START HERE](https://boardgamegeek.com/thread/3218432/start-here).
- Registri `sources/BGG-PNP-CONTEST-GLOBAL-COVERAGE.md` e `sources/BGG-PNP-24H-CHALLENGES.md`.

## Deliverable e criteri di successo

Confronto verificabile delle fonti indice attuali con i 305 contest esistenti; ogni nuova unità confermata con URL e data; incremento riproducibile del database e aggiornamento del cruscotto solo se la copertura cambia. Nessuna assenza o assenza di novità va inferita da una ricerca indicizzata incompleta.

## Verifiche del 2 ottobre 2026

- Repository su `main`, allineato al riferimento locale `origin/main`, senza modifiche iniziali. PWS 1.5.0, uguale alla versione di allineamento locale.
- Il task globale del settembre 2026 è concluso: questo è un controllo successivo e autonomo. La richiesta iniziale più ampia è stata suddivisa secondo i cinque workflow di `PROJECT.md`.
- Il primo tentativo nell'in-app browser ha restituito la pagina di verifica di sicurezza BGG; la lettura web delle fonti indice ha restituito HTTP 403. Non sono stati aggirati i controlli del sito. L'utente ha poi effettuato l'accesso nel proprio Chrome; il forum è divenuto leggibile senza condividere credenziali con l'agente.
- Ricerche indicizzate su BGG hanno restituito contest già presenti (Solitaire, 54-Card, Traditional Deck, Wargame, Roll & Write) e thread di entry o side event; nessuna di queste occorrenze prova una nuova unità da importare.
- Il [forum Design Contests](https://boardgamegeek.com/forum/974620/bgg/design-contests), ordinato per data delle nuove discussioni, mostra il 2 ottobre come più recente [The 2026 Roll & Write Game Design Contest](https://boardgamegeek.com/thread/3776341/the-2026-roll-and-write-game-design-contest). I thread seguenti sono anteriori al 18 settembre; BoardSprints del 12 settembre è esterno e già escluso. Il primo post del nuovo contest, dell'organizzatore Martin Melbardis, indica Igor Zuber come co-organizzatore, iscrizioni 15 ottobre–1 dicembre, sviluppo fino al 17 gennaio 2027 e voto 1–15 febbraio 2027. Richiede PnP gratuito durante il contest. Stato alla data: `announced`.
- La GeekList corrente mostra ancora 26 elementi e non comprende il nuovo Roll & Write. Il thread ufficiale è stato quindi usato come fonte autorevole per questa edizione.
- L'incremento SQL idempotente `catalog/global-contest-census-2026-10-02.sql` è stato applicato prima su copia SQLite in memoria: 306 contest, 18 nel 2026, nessuna violazione di chiavi esterne e `integrity_check=ok`; una seconda applicazione di prova ha lasciato 306 contest. Applicato poi al database operativo con gli stessi esiti. Nessuna entry aggiunta.
- Le sezioni generate A e B di `PROJECT_PROGRESS.md` sono state rigenerate con `app/generate_project_progress.py`, quindi aggiornate le parti qualitative del cruscotto e il registro di copertura.
- Il confronto verificato fra forum `Recent` e GeekList non ancora aggiornata è stato promosso nel playbook della skill locale come strategia riutilizzabile per le nuove pubblicazioni.

## Decisione operativa e seguito

Il prossimo controllo specifico per il nuovo contest è fissato al 16 ottobre, dopo l'apertura delle iscrizioni. I controlli di stato e roster già scaduti richiedono task separati di monitoraggio per singolo contest, secondo `sources/MONITORING_CALENDAR.md`.
