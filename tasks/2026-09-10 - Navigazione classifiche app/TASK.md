# Navigazione classifiche app

- Apertura e chiusura: 2026-09-10.
- Stato: concluso; modifiche locali verificate, in attesa di autorizzazione al commit e all'integrazione.
- Titolo Codex: `2026-09-10 - Navigazione classifiche app`, impostato all'apertura e riconfermato con lettura del task prima della chiusura.

## Scope, input e criteri di successo

Evolvere l'app locale per consultare tutte le classifiche SQLite: ricerca, filtri, ordinamento, schede entry/contest collegate e sintesi dei risultati per categoria. Input: app esistente, schema versionato e database operativo aperto esclusivamente in sola lettura. Deliverable: API di catalogo estesa, UI Risultati, sintesi per contest, test e documentazione.

Criteri: copertura di tutte le righe `rankings`; nessuna confusione tra posizione, punteggio e voti, ufficialità o versioni storiche; casi limite sintetici; navigazione accessibile e responsive; database invariato. Esclusi acquisizione, apertura di materiali, nuovi rilevamenti BGG e operazioni Git non autorizzate. Stack standard Python/HTML/CSS/JavaScript invariato; PWS 1.3.0 già inizializzato, riferimento read-only.

## Preflight Git

Prima di qualsiasi modifica: branch `main`, working tree pulita; `main`, `origin/main` e riferimento corrente GitHub verificato tramite `ls-remote` coincidono in `17b1383e900cc224f84994028e6ea2fc6aae716e`. Il controllo remoto ha richiesto il corretto `GIT_EXEC_PATH` del Git integrato e accesso fuori sandbox; nessuna modifica remota.

Creato e selezionato `codex/app-rankings-navigation` da `main` su autorizzazione esplicita dell'utente. Nessun commit, merge, push, pull o modifica di altri branch. Prima della chiusura controllati `.gitignore`, diff e stato: database, cache e materiali esclusi; solo codice, documentazione e questo task sono modificati/non tracciati.

## Analisi e decisioni

1. Verifica tecnica locale del 10 settembre: 1.054 osservazioni, 16 contest, 140 coppie contest/categoria. Tutte ufficiali e collegate a una entry. Quattro menzioni senza posizione; tutti i punteggi e conteggi voti null. Nessun duplicato per contest/gioco/categoria nella baseline osservata. Non è un nuovo controllo esterno e non alimenta il calendario di monitoraggio.
2. Una query condivisa `ranking_rows` restituisce una riga per osservazione, titolo, crediti, contest/anno/perimetro e link alla entry. Query parametriche per i dettagli; `/api/catalog` include tutte le osservazioni. Nessuna migrazione, scrittura o dipendenza aggiuntiva. Il vincolo unico contest/gioco di `entries` rende univoco il collegamento.
3. Vista `#rankings`: filtri combinabili per contest, anno, perimetro, categoria originale, natura, posizione esatta/1–3/mancante e titolo/crediti; ordinamenti per contest/categoria, titolo e posizione nelle due direzioni; pagine da 30 risultati. Null distinti da zero, posizioni mancanti in fondo negli ordinamenti numerici, nessuna rinumerazione dei pari merito.
4. Tutte le categorie della singola entry restano visibili. Le schede contest collegano filtro e sintesi. I link `#rankings/ID` aprono il contesto del contest azzerando gli altri filtri; `#results/ID` apre la sintesi. La vista generale conserva i filtri solo in memoria.
5. Sintesi adottata: separazione per contest, categoria, ufficialità, URL e data; vincitori ufficiali soltanto con rank=1. Per risultati non ufficiali: primi posti non ufficiali. Distribuzione delle osservazioni per posizione, incluse le mancanti; dettaglio espandibile completo. Nessun vincitore desunto da punteggio o minimo disponibile, nessuna somma o confronto di punteggi fra categorie.
6. Schema privo di metodo/unità di voto e identificativo/versione operativa della graduatoria: tutte le osservazioni restano consultabili, senza deduplicazione o scelta automatica della più recente. Gli ex aequo richiedono giochi distinti con medesima posizione nel medesimo gruppo fonte/data/natura/categoria/contest; il riconoscimento usa l'universo completo anche in pagine o schede parziali.
7. Fonte e verifica restano quelle registrate in ogni riga, distinte dalla data di lettura dell'app. I link BGG di soli metadati mantengono le protezioni preesistenti; nessun link esterno è stato aperto durante i test. Nessuna richiesta esterna automatica, né accesso alla libreria o ai materiali.

## Verifiche e risultati

- `python -m unittest discover -s app -p test_server.py -v`: 10/10 passati, incluso il test di copertura reale (non saltato su questo computer). Eseguito con il Python integrato perché `python` non è nel PATH.
- `node --test app/test_frontend.cjs`: 10/10 passati.
- Fixture SQLite sintetica: due perimetri, più crediti senza moltiplicare righe, ex aequo, posizione nulla, score 0 e 8.5, voti 0 e 12, categoria senza posizione, risultato non ufficiale, osservazione successiva preservata e gioco senza entry nel contest.
- Query/API: copertura esatta di ogni campo originale di tutte le 1.054 righe; dettagli di tutti i contest con classifiche e di tutte le entry coinvolte confrontati con il catalogo; link contest/gioco verificati. Regressioni HTTP, protezione Host, metodi di scrittura rifiutati, file non esposti, database mancante non creato e `query_only` passate.
- Frontend sintetico: combinazione dei filtri, ricerca case-insensitive e caratteri accentati, sort numerico e stabile, null sempre in fondo nei sort numerici, fonti/date/nature separate, ex aequo anche su riga isolata, nessun falso ex aequo per osservazioni dello stesso gioco, nessun vincitore dedotto, escaping di titoli/categorie/URL, assenza di entry collegata e stato vuoto.
- Browser locale su `127.0.0.1:8767`: tutte le 36 pagine percorse da tastiera, 1.054 identificativi di osservazione unici, senza omissioni o duplicazioni; focus sul contenitore risultati dopo il cambio pagina e pulsante successivo disabilitato alla fine.
- Browser: filtro posizione mancante restituisce le quattro menzioni del contest 54-Card 2025; contest 9-Card 2026 + categoria Best 2 Player Game + autore David Llort restituisce Ninefold Murder e Ninefold Surgeon, quest'ultimo con ex aequo correttamente riconosciuto anche rispetto a righe escluse dal filtro. Ordinamento decrescente inizia da rank 25. Filtro non ufficiali mostra correttamente stato vuoto sulla baseline reale.
- Navigazione verificata: classifica → Ninefold Surgeon (quattro categorie e piazzamenti) → contest → Statistiche e risultati → sintesi → classifica del contest con reset dei filtri. Titoli, breadcrumb e voce attiva aggiornati. Sintesi con vincitori, distribuzione e dettagli espandibili controllata sul contest 9-Card.
- Accessibilità/layout: controlli nativi etichettati, intestazioni di colonna, focus visibile, regione risultati live, tabelle scorrevoli e focalizzabili. Verifiche desktop e a 320, 390, 768 pixel; larghezza pagina entro il viewport e scorrimento orizzontale confinato alle tabelle. Screenshot desktop/mobile controllati. Nessun errore o warning console. Override del viewport ripristinato; preview lasciata sulla vista generale.
- Prestazioni indicative: lettura catalogo ~22 ms e JSON ~864 KB sul computer corrente; scala adeguata al caricamento locale in memoria.
- Hash SHA-256 database prima e dopo: `6adad244ef121548f5afc767bc1e47706e82dbdad47691b8213f5b7d5e6b02cc`. Nessuna scrittura rilevata.
- `git diff --check`: passato. Restano solo gli avvisi informativi della configurazione Git LF/CRLF, nessun errore di whitespace.

## Conoscenza promossa e limiti residui

Aggiornati `app/README.md`, `PROJECT.md`, `README.md`, mappa `AGENTS.md` e `.workspace/PROJECT_STATE.md`. Non modificati PWS, schema, database, cataloghi, fonti o calendario.

La ricerca autore dipende dai crediti presenti e non inventa attribuzioni mancanti. Metodi/unità di voto, completezza della graduatoria e relazione di sostituzione tra osservazioni non sono certificati nello schema: la UI li tratta conservativamente. Non effettuata una certificazione formale con screen reader; verificati semantica accessibile, tastiera e layout. Punteggi/voti e natura non ufficiale sono coperti da fixture, essendo assenti nella baseline reale. Nessun limite blocca la consultazione richiesta.

## Passo successivo proposto

Salvare l'incremento verificato con commit sul branch dedicato, messaggio `feat(app): add contest rankings navigation and summaries`. Poi riesaminare il diff e autorizzare l'integrazione in `main`; infine autorizzare il push per trasferire i commit su GitHub e verificarne l'allineamento. Nessuna di queste operazioni è stata eseguita automaticamente. Il prossimo approfondimento utile, solo se emergeranno osservazioni sostitutive o metodi di voto registrati, è valutare un modello esplicito delle versioni delle classifiche.
