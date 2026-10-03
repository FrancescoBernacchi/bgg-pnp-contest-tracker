# Libreria locale dei materiali nell'app

- Apertura: 2026-10-03.
- Stato: concluso il 2026-10-03; modifiche verificate sul branch, nessun commit effettuato.
- Tipo: evoluzione autonoma non BGG, successiva ai task conclusi di acquisizione Children & Family e interfaccia multifonte.
- Branch autorizzato: `codex/libreria-locale-materiali`; partenza da main pulito, 0/0 rispetto a origin/main; PWS 1.5.0 allineato.

## Contratto prima dell'implementazione

- Scopo: consultare acquisizioni e file registrati, provenienza e presenza locale controllata, in sola lettura.
- Input: schema operativo, API e frontend esistenti, acquisitions/acquired_files e radice library.
- Deliverable: vista Libreria, filtri combinabili e ordinamenti, riepiloghi, materiali locali nelle schede gioco, test e documentazione.
- Esclusioni: download, anteprime, servizio dei binari, apertura file/cartelle, richieste remote, modifica del database, migrazioni, commit/push/merge.
- Criteri di successo: relazioni e versioni preservate; nessun percorso assoluto esposto; percorsi non confinati rifiutati; stati locali distinti da disponibilità remota e completezza.
- Verifiche previste: suite backend/frontend completa, fixture di sicurezza e acquisizioni multiple, conteggi operativi (41 file), hash database invariato, integrity_check e foreign_key_check, diff e gitignore finali.

## Decisioni

La presenza è verificata dal server esclusivamente sulla radice autorizzata. Il frontend riceve metadati e stato normalizzato. Le acquisizioni senza file restano consultabili. Nessuna completezza dedotta dal numero di file.

## Apertura futura separata

Un futuro launcher potrebbe accettare soltanto ID registrati, risolvere nuovamente il percorso confinato e richiedere un'azione esplicita. Occorre valutare autenticazione locale, CSRF/Origin, reparse point e race fra verifica/apertura, associazioni del sistema e limiti del contratto HTTP. Nessun endpoint di apertura viene introdotto in questo incremento.


## Implementazione e verifiche finali

- Nuovo modulo `app/library_catalog.py`, endpoint GET `/api/library` e `local_materials` nella scheda canonica. Nessuna migrazione: tutte le query usano lo schema corrente e la connessione SQLite in sola lettura esistente.
- Vista Libreria dalla navigazione comune: dieci filtri/controlli, quattro ordinamenti, distribuzioni, metadati espandibili e 50 righe per pagina. Schede gioco con acquisizioni separate anche senza file. Versioni, condizioni d'uso, SHA-256 e URL HTTPS sicuri preservati.
- Il filtro anno usa l'anno del contest, esplicitamente etichettato. Per Kanare senza contest usare fonte e ordinamento per data di acquisizione.
- Attribuzione contest mediante entry_resource_mentions della risorsa e gioco acquisito; fonte Kanare attraverso catalog_resources/source_records. Nessuna attribuzione arbitraria ai contest in cui lo stesso gioco compare.
- `present`/`missing`/`invalid_path`/`unverifiable` sono distinti. Percorso relativo eliminato dalla risposta dopo controllo confinato; assoluti, UNC, drive relativi, traversal, stream NTFS e destinazioni risolte esterne rifiutati. Nessun binario letto o endpoint generico introdotto.
- Completezza non determinabile dal modello corrente: nessun lotto automaticamente completo. Un lotto con file sia `acquired` sia `failed` è parziale rispetto ai record registrati. Stati remoti conservati indipendentemente dalla presenza. Nessuna acquisizione non significa nessuna risorsa dichiarata; esclusioni e scansioni prive di risorse restano nei metadati esistenti e nei manifest, senza creare record locali fittizi.
- Tutti i test preesistenti e nuovi: **22 backend e 28 frontend superati**, senza skip. Comandi: runtime Python integrato `-m unittest discover -s app -p 'test*.py'`; Node `--test app/test_frontend.cjs`.
- Test dedicati: conteggi e byte; determinismo; acquisizioni multiple/versioni e integrazione scheda; fixture presente/mancante; libreria/database assenti; confinamento e symlink esterno (con fallback mock se Windows non concede privilegio symlink); fonti BGG/Kanare; lotto parziale; nessun percorso/binario HTTP; protezioni esistenti; escaping; filtri e ordinamenti; rendering e paginazione tramite DOM simulato. Non eseguita verifica visuale in un browser reale.
- Verifica operativa del 2026-10-03 tramite query aggregate indipendenti: **17 giochi, 17 acquisizioni, 41 file, 173.596.698 byte**, tutti presenti; 38 PDF Children & Family 2025 e 3 PDF Kanare_Abstract; lingua registrata `en` per 41/41. Zero mancanti o percorsi rifiutati sull'operativo.
- `PRAGMA foreign_key_check`: nessuna riga; `PRAGMA integrity_check`: `ok`. SHA-256 del database identico prima e dopo la consultazione: `ca9e0ee2c6c6001fe65a7b5ce86ba460c14a004ae3b298c43dd503d9c9bafdc0`.
- Documentazione aggiornata in app e library; aggiornato solo lo stato degli strumenti nel cruscotto. Conteggi operativi e pipeline invariati: sezioni annuali generate non modificate né rigenerate.
- Limiti: presenza non certifica integrità del contenuto; hash e dimensioni sono valori registrati; completezza totale non certificata; paginazione del DOM ma caricamento integrale dei metadati. Nessuna apertura locale, proposta separata sopra.
- Verifica Git: branch `codex/libreria-locale-materiali`; `git diff --check` pulito; solo codice, test, README, cruscotto e TASK versionabili. Database, backup e materiali restano ignorati. Nessun commit, push, merge o PR.

## Prossimo passo

Precisazione successiva dell'utente, 2026-10-03: la futura visualizzazione deve essere estensibile oltre i PDF a JPG/PNG, TXT, DOC/DOCX e altri formati. Requisito promosso in `PROJECT.md`, sezione Visualizzazione multiformato della libreria. Nei futuri task che introducono un formato verificare e integrare il relativo supporto sicuro, oppure documentare esplicitamente il blocco; nessuna implementazione del visualizzatore in questa precisazione.

Richiedere autorizzazioni distinte per commit, eventuale push del branch, revisione, unione in main e push finale di main. Messaggio proposto: `Aggiunge la libreria locale dei materiali in sola lettura`. La futura apertura locale resta un incremento separato da deliberare.


## Autorizzazione Git successiva — 2026-10-03

L'utente ha autorizzato esclusivamente commit e push del branch Libreria, compresa la decisione multiformato promossa in PROJECT.md. Revisione, merge in main e push di main non sono autorizzati. Prima del commit ricontrollati branch, diff, file versionabili e gitignore: solo codice, test e documentazione; nessun database, backup o materiale di terzi. L'esito e il riferimento del commit sono comunicati nella chat e verificabili nel registro Git. Il prossimo incremento sarà il primo visualizzatore PDF, da avviare con un prompt separato sul contenuto del branch Libreria.
