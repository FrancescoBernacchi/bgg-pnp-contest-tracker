# Prima applicazione locale contest BGG

- Apertura: 2026-09-07.
- Stato: concluso il 2026-09-07.
- Branch autorizzato: `codex/local-contest-browser`.

## Scope e input

Realizzare un'interfaccia locale per consultare contest, entry, stati originali e normalizzati, scadenze, statistiche e confronti storici. Input: `PROJECT.md`, schema e migrazioni, viste operative, database locale e generatore Markdown esistente. Nessun rilevamento BGG, accesso ai materiali, modifica del database o operazione remota Git.

## Analisi e decisione tecnica

Progetto inizializzato con PWS 1.3.0, utilizzato come riferimento read-only. Working tree inizialmente pulita su main, allineata al riferimento locale origin/main (nessun fetch eseguito). Già presenti un generatore Python e viste stabili per contest e tipologia delle entry. Scelta proposta e adottata nel mandato di realizzazione: Python 3.12+ con sola libreria standard (sqlite3, http.server), HTML/CSS/JavaScript senza build né dipendenze. Server vincolato a 127.0.0.1; connessione SQLite URI mode=ro e query_only. Nessun frontend framework o servizio esterno necessario per la scala attuale.

Il database non dispone di un flag strutturato di completezza degli snapshot. Il confronto sarà conservativo: transizioni solo fra entità presenti in entrambi i controlli; presenze/assenze descritte come tali, senza dedurre inserimenti o rimozioni. Baseline, census e consistency esclusi dalle coppie periodiche. Nessuna migrazione inclusa.

## Deliverable e criteri di successo

1. Server, interfaccia responsive e launcher PowerShell; ricerca e filtri per perimetro, stato, anno ed entry.
2. Dettaglio contest/entry con provenienza, data di verifica, fasi, classifiche e dipendenze.
3. Cronologia e confronto selezionabile con evidenza delle lacune; nessun falso “nessun cambiamento” in assenza di dati.
4. Test su database sintetico per protezione scritture, isolamento HTTP, confronti di osservazioni comuni, parziali e vuote (senza certificazione di completezza), query e input errati; verifica locale del database reale e del browser.
5. Hash del database prima/dopo invariato, aggiornamento documenti autorevoli e guida di avvio.

## Incrementi

- Analisi completata; branch creato. Prossimo incremento: lettura dati e confronto conservativo verificabili.
- Livello dati completato: viste correnti, dettaglio contest/entry, storico, metriche correnti risolte per data/id, classifiche e confronto per entità; protezione SQLite/HTTP. Prossimo incremento: navigazione e verifiche con fixture.
- Interfaccia completata: schede separate, filtri e ricerca per autore/titolo, paginazione, fasi con precisione/fuso, cronologie, originali e dipendenze; test backend/frontend superati. Prossimo incremento: validazione nel browser e promozione documentale.
- Verifiche nel browser completate su database reale e fixture sintetica separata; documentazione promossa in README, PROJECT, AGENTS e PROJECT_STATE, senza modificare PWS.

## Verifiche e chiusura

### Evidenze locali del 2026-09-07

- `python -m unittest discover -s app -p test_server.py -v`: 8 test superati. Fixture costruita in directory temporanea dallo schema versionato; scrittura negata anche disabilitando `query_only` grazie a `mode=ro`; database mancante non creato; parametri e coppie di controlli non validi respinti; percorsi database/library/traversal non esposti, Host esterno rifiutato, metodi di scrittura rifiutati.
- `node --test app/test_frontend.cjs`: 4 test superati su escaping, allowlist dei link, date/offset e messaggi per snapshot senza entità comuni.
- Controlli sintattici Python/JavaScript superati. Tutti gli 11 dettagli contest e tutte le 365 entry del database reale letti e serializzati correttamente.
- Browser reale su loopback: homepage 11 contest / 8 principali / 3 adiacenti / 365 entry / 21 varianti; filtro Adiacenti restituisce 3 contest; Solomode mostra 21 varianti e relativi risultati; Automa SWars mostra autore, dipendenza e storico; ricerca Adrian Gutierrez restituisce 1 entry, ricerca inesistente 0; paginazione da 1/13 a 2/13; calendario e fasi 54-Card conservano date e offset; baseline senza coppie periodiche esplicitata.
- Browser con fixture sintetica su porta 8766: variazione development→voting, wip→playtest_ready, metrica 2→1 e ufficialità 1→0, proroga 20→25 settembre; entry assente nel secondo snapshot indicata solo come osservata nel precedente. Successivo snapshot vuoto/no_change mostra dati insufficienti, senza false rimozioni o certificazione di invarianza.
- Verifica visiva desktop e viewport 390×844: schede e navigazione leggibili, nessun overflow del documento (375 px utili con scrollbar); tabelle contenute in un'area scorrevole. Override del viewport ripristinato. Console finale senza errori o warning.
- SHA-256 del database prima e dopo le letture: `454004b37193be130f866e9976ba3a91a0faeef34b9a40439bb61de42f6b792b`, invariato. Nessun accesso a BGG, nessun materiale aperto/scaricato, nessuna nuova osservazione esterna. Database e schema non modificati.

### Deliverable e decisioni

Codice in `app/server.py`, `app/static/`, launcher `app/start.ps1`, test `app/test_server.py` e `app/test_frontend.cjs`, guida `app/README.md`. App avviata per la revisione su `http://127.0.0.1:8765`; log e PID dell'istanza di revisione sono in `outputs/app-server*.log` e `outputs/app-server.pid` (ignorati da Git). La normale esecuzione tramite launcher resta in primo piano e si arresta con Ctrl+C.

Nessuna dipendenza installata. Conservata la separazione dal report Markdown esistente; nessuna modifica del suo motore. L'app non identifica automaticamente nuove entry o rimozioni definitive in assenza di un contratto strutturato di completezza. Questo limite è documentato e presentato nella UI.

### Prossima azione utile

Salvare l'incremento verificato con un commit proposto: `feat: aggiungi applicazione locale per consultare contest ed entry BGG`. Commit e push non eseguiti: richiedono ulteriore autorizzazione. Il branch dedicato resta `codex/local-contest-browser` con le modifiche da rivedere.

Il prossimo rilevamento esterno resta Turkish PnP l'8 settembre, come da taccuino invariato. Per evoluzioni future del confronto valutare un task dedicato che certifichi la completezza per entità degli snapshot; non alterare retroattivamente le osservazioni per far apparire disponibile un confronto.
