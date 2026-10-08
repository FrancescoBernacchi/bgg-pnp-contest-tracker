# Matrice di copertura — TSK-0079

Stato iniziale verificato 2026-10-08. Verifica finale 2026-10-08: test e screenshot in VERIFICHE.json, PYTHON_TESTS.txt, BROWSER_TESTS.txt e outputs/pergioco-qa.

| Superficie | Comportamento attuale | Integrazione concordata | Verifica |
|---|---|---|---|
| Navigazione/fonti | Giochi e Kanare; PerGioco nel selettore generico | Roster fonte distinto, badge e deep link per ID | Verificata: test backend/frontend e QA 1400/780/390 px |
| Catalogo canonico | Fonte candidata compresa nei collegamenti; nessun record autonomo | Confermati e candidati espliciti; niente attribuzione implicita | Verificata: test backend/frontend e QA 1400/780/390 px |
| Roster fonte | Tre source-only non raggiungibili | Tutti i record, titoli qualificati e alias | Verificata: test backend/frontend e QA 1400/780/390 px |
| Ricerca/filtri/ordine/pagine | Giochi per titolo/alias | Record per titoli, classificazioni e crediti/ruolo; filtri combinabili; paginazione | Verificata: test backend/frontend e QA 1400/780/390 px |
| Schede fonte | Assenti | Osservazioni, esiti, date, provenienza, storia e matching | Verificata: test backend/frontend e QA 1400/780/390 px |
| Classificazioni | Assenti | Tipi, path ordinati/assenti, segmenti indice, appartenenze multiple e mapping | Verificata: test backend/frontend e QA 1400/780/390 px |
| Risorse/accessi/condizioni | Solo risorse legacy attribuite | Menzioni anche senza URL, ambiti costo/completa/accesso separati | Verificata: test backend/frontend e QA 1400/780/390 px |
| URL/storia | Solo URL canonico | Storici/richiesti/finali/login e predecessori espliciti | Verificata: test backend/frontend e QA 1400/780/390 px |
| Varianti/istanze | Assenti | Relazioni fonte navigabili, requisiti separati, istanze distinte e sole associazioni provate | Verificata: test backend/frontend e QA 1400/780/390 px |
| Crediti/lacune/diritti | Asserzioni canoniche e notice | Crediti fonte irrisolti e contesto; candidato non promosso | Verificata: test backend/frontend e QA 1400/780/390 px |
| Libreria/lettori | File per gioco e fonte; ID confinati | Nessuna acquisizione pilota, nessun file inventato; lettori preservati | Verificata: test backend/frontend e QA 1400/780/390 px |
| Avanzamento | Layout non configurato | Pilota CAT/importazione/ammissione/identità distinti; MAT/ACQ/IMG — | Verificata: test backend/frontend e QA 1400/780/390 px |
| Statistiche/cruscotti | BGG separato e giochi canonici | Roster, giochi e istanze con denominatori indipendenti | Verificata: test backend/frontend e QA 1400/780/390 px |
| Refresh/API/deep link | Snapshot RO; reload vista attiva | Snapshot corrente di record/evidenze/metriche; errori e fonti/schema mancanti | Verificata: test backend/frontend e QA 1400/780/390 px |
| HTTP/CSP/link/escaping | Protezioni esistenti | Stessi confini, metadata non fidati e nessuna rete esterna | Verificata: test backend/frontend e QA 1400/780/390 px |
| Tastiera/focus/mobile | Layout e tabs esistenti | Etichette, focus, tabelle scorrevoli e percorsi accessibili | Verificata: test backend/frontend e QA 1400/780/390 px |
| Contest/entry/classifiche/scadenze/monitoraggio BGG | Viste specializzate | Non applicabile a PerGioco; nessun equivalente inventato | Verificate: test Python/JavaScript e linguette BGG/Kanare |
| IMG/AI | Non implementato; TSK-0067 autonomo | Nessuna nuova funzionalità o acquisizione | Verificata: ispezione del codice e scope TSK-0067 preservato |


## Esiti e limiti

66 test Python distinti (suite iniziale 65 e suite finale PerGioco 7) riusciti; dopo gli ultimi affinamenti ripetuti i sette test PerGioco. 47 test JavaScript riusciti (frontend comune, attribuzioni e PerGioco). Browser su tutti i dodici record a 1400/780/390 px: titoli omonimi/source-only/candidato, ricerca e filtri combinati, crediti, istanze, navigazione/URL per ID, refresh, focus/tastiera, overflow, Libreria, avanzamento BGG/Kanare/PerGioco; nessuna richiesta esterna o errore pagina. Fixture backend: fonte assente, tabella 013 mancante, manifest assente, eventi indipendenti; rettifica testata senza scegliere l’ultimo ID. Il pilota ha solo un evento per record: evoluzioni reali richiederanno verifica delle nuove evidenze, senza risoluzione automatica dei conflitti.

Hash operativo, conteggi di ogni tabella e hash sidecar coincidono prima/dopo. Nessuna APP immagini, acquisizione, modifica schema/dati, matching, credito canonico o lettura esterna avviata. BGG contest/entry/risultati/scadenze/monitoraggio non applicabili a PerGioco. MAT/ACQ/IMG non hanno un perimetro attestato. I limiti CAT (PDF senza URL, accesso autenticato non collaudato, Abande candidato e tre requisiti non dimostrati) restano limiti informativi dei dati, esplicitamente visibili.

Preflight CUA: inizializzazione node_repl/@oai/sky riuscita; Edge non disponibile nel connettore CUA, browser integrato inizializzato su about:blank. Prima app sandbox: timeout; diagnosi Python WinError 10013 sul socket. Runner QA fuori sandbox approvato per localhost con richieste esterne bloccate; browser integrato poi ha mostrato roster/filtri con il server attivo. Nessun setup refresh had errors, modifica ACL/cache/runtime o blocco node_repl riprodotto. Screenshot desktop/mobile ispezionati; test dello skip link via tastiera, essendo visibile soltanto quando riceve focus.

Skill computer-use applicata alla sola QA; istruzioni e conferme lette. Efficacia: inizializzazione e osservazione app riuscite, diagnosi concreta dei limiti loopback/CUA; test Playwright autorizzati dall’utente completano regressioni e viewport. Nessuna nuova strategia universale promossa; nessuna manutenzione skill necessaria. Skill BGG/FON/MAT/IMG non attivate per sola consultazione dati locali APP. Standard read-only.

Verifica finale supplementare: roster sintetico di 27 record, pagine 25+2 e totali stabili; avanzamento pilota invariato dai filtri/pagine; fonte assente esplicita. Rettifica su copia con supersedes/evento/motivazione conforme ai trigger 013 e conflitto di ammissione non risolto automaticamente: sette test PerGioco riusciti. Hash/inventario operativo ricontrollati invariati.
