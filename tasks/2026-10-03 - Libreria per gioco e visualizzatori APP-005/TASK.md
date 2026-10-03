# Libreria per gioco e visualizzatori APP-005

- Apertura: 2026-10-03.
- Stato: concluso il 2026-10-03; modifiche locali verificate, nessuna operazione Git mutativa.
- Segnalazione: APP-005; incremento autonomo rispetto ai task Libreria, PDF e APP-002 conclusi.
- PWS: aligned_version e versione canonica 1.5.0 verificati.
- Git iniziale: main pulito, allineato al riferimento locale origin/main; nessuna operazione mutativa autorizzata.

## Scope, input e deliverable

Raggruppamento Libreria per gioco, icone accessibili, lettori PNG/DOCX, estrazione offline degli ZIP acquisiti, relazione archivio/contenuto e manifest con hash. Input: registro APP-005, PROJECT.md, schema e migrazioni, app e manifest correnti. Nessun download o rilevamento esterno. Server e originali in sola lettura; estrazione confinata con limiti e versioni preservate.

## Criteri di successo

Una riga per gioco; paginazione per gioco e soli file corrispondenti ai filtri; dettagli accessibili e versioni distinte. Apertura PDF/PNG/DOCX per ID, senza contenuti attivi o risorse esterne. ZIP registrati estratti in modo ripetibile, originali preservati e hash/provenienza registrati. Errori e limiti espliciti; verifiche backend, frontend, tastiera e schermi stretti. Documentazione, registro e cruscotto aggiornati prima della chiusura.

## Decisioni

- DOCX: lettura semantica di paragrafi e tabelle, senza ricostruzione dell'impaginazione Word; nessuna macro, immagine o relazione esterna caricata.
- ZIP annidati conservati e registrati ma non estratti ricorsivamente; estrazione offline separata dal server.

## Risultati e verifiche

- Frontend: una riga per gioco, filtri applicati ai file e 50 giochi per pagina; icone con ID/nome/versione/acquisizione accessibili, dimensione ordinaria e dettagli completi. Ordine per somma bytes filtrati, data più recente o primo nome alfabetico. Materiali della scheda gioco mantengono acquisizioni separate e mostrano la relazione archivio/contenuto.
- Lettori: PDF e APP-002 preservati; PNG con fit/dimensione originale e DOCX con testo/tabelle sicuri, token per ID e handle confinato. Il DOCX seleziona una sola rappresentazione XML di compatibilità, evitando duplicazioni osservate sul file reale #159.
- Migrazione additiva 011 applicata dopo backup integro: `archive_contents` e `archive_extractions`. Gli 11 contenuti (10 PDF e 1 PNG) dei file ZIP #151 e #152 hanno ID #188–198, hash e provenienza nel manifest `catalog/archive_contents_batch_2026-10-03.json`. Acquisizioni invariate a 46; file totali 198. Nessun download o rilevamento BGG.
- Confronto con backup: tutti i 187 record originali invariati. SHA-256 verificati per tutti i 198 file. Integrità SQLite e chiavi esterne corrette. Seconda applicazione reale dell'estrattore senza nuove righe o sovrascritture.
- Suite complete: 36 test Python backend e 43 test Node frontend superati; log in `outputs/app005-backend-tests.log` e `outputs/app005-frontend-tests.log`. Regressioni: formati, errori/limiti, testo non fidato, accessi HTTP/token/HEAD, versioni, filtri/paginazione per gioco, hash/idempotenza ZIP, traversal, nomi ambigui, link, cifratura, compressione, corruzione e conflitti con contenuti già estratti.
- Edge headless locale: fixture isolate a 1400/390 px, 52 giochi con pagine 50+2, filtro sul singolo file, apertura da tastiera e dettagli del formato non supportato; nessuna richiesta esterna o errore JavaScript. PDF/PNG/DOCX reali (#130/#184/#159) pronti alle due larghezze, senza overflow orizzontale. Screenshot in `outputs/app005-browser/`; ispezionati DOCX desktop/mobile e Libreria. Script ripetibile fixture in `app/test_material_browser.cjs`; verifica reale in `outputs/app005-real-browser.cjs`.

## Limiti e chiusura

DOCX semantico senza immagini o impaginazione Word; formattazione, intestazioni, note, numerazione e revisioni non riprodotte. PNG/PDF possono fallire nel decoder dopo il controllo preliminare: errore esplicito. ZIP annidati registrati senza ricorsione; formati ulteriori esplicitamente non visualizzabili. Un errore durante la scrittura offline può lasciare derivati non registrati recuperabili al rerun; nessun originale viene eliminato.

Aggiornati PROJECT.md, AGENTS.md, stato workspace, guide app/catalog/database, README, registro APP-005 e cruscotto. Sezioni annuali A/B rigenerate prima dell'aggiornamento manuale delle sole sezioni non generate; i file derivati aumentano i conteggi senza indicare nuove risorse remote. APP-005 chiusa con evidenza in VERIFICATION.json. `.gitignore` verificato: originali, estratti, database, backup e screenshot esclusi. Nessun branch, commit o push eseguito.

Prossimo passo utile: prova dell'utente sulla Libreria e commit dell'incremento verificato; messaggio suggerito `Implementa APP-005: Libreria per gioco, lettori PNG/DOCX e contenuti ZIP`. Il commit conserverà codice, migrazione, manifest e documentazione; un successivo push li trasferirà sul repository privato senza includere materiali.

## Finalizzazione Git

- 2026-10-03: utente autorizza commit e push dell'incremento APP-005 su main. Controllati working tree, allineamento PWS 1.5.0, esclusioni Git e diff senza errori. Il commit include soltanto codice, test, migrazione, manifest testuale e documentazione; database, backup, materiali e screenshot restano esclusi. L'esito e l'identificativo del commit sono comunicati nella chat e nella cronologia Git.
