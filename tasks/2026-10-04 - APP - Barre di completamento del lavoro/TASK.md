# Barre di completamento del lavoro

- ID: TSK-0047. Apertura: 2026-10-04. Categoria: APP.
- Modalità: circoscritto; cadenza su_richiesta; stato completato (riaperto e corretto il 2026-10-04).
- Segnalazione: APP-008 nel registro del 2026-10-03.
- Chat: 01a106e7-0978-7b20-a795-ab8654dbea44.
- PWS locale/canonico: 1.5.0. Preflight riuscito; modifiche documentali preesistenti preservate, main allineato al riferimento locale origin/main.

## Contratto

Implementare cinque barre annuali separate per PnP principali e adiacenti. Misurare lavoro concluso con esiti espliciti e provenienza; distinguere piazzamenti, scansioni parziali, file parziali, ignoti, non applicabili e blocchi. Predisporre persistenza additiva senza nuove verifiche BGG, immagini o download. Riutilizzare soltanto verifiche locali già documentate, senza attribuire verifiche storiche implicite.

Input: APP-008, TSK-0045 con CHECKS_2026-10-04.json, database e codice app/generatori. Deliverable: persistenza, metriche condivise, frontend, cruscotto rigenerato, documentazione e test. Successo: verifica completa con entry prive di piazzamenti al 100%, incompleta distinta, denominatore zero esplicito, entrambi i perimetri e immagini 0% non implementate; originali e dati storici preservati.


## Esito — 2026-10-04

Cinque barre annuali per entrambi i perimetri, etichette richieste e immagini 0% non implementate. API e generatore condividono `app/work_progress.py`. Migrazione 012 applicata offline dopo backup e prova su copia; aggiunte soltanto osservazioni, nessuna riga originaria modificata o eliminata (confronto dei contenuti con il backup in VERIFICATION.json). Durante il lavoro TSK-0046 ha aggiunto 869 rankings, 11 contest_sources e 409 attestazioni classifiche 2024: aggiunte concorrenti preservate e distinte dalle 464 attestazioni APP-008.

Formalizzate 464 verifiche classifiche dalle liste ufficiali già esaminate integralmente da TSK-0045: 247 complete con risultati, 217 assenze dalle liste pubblicate. Fonti e data 2026-10-04 conservate, senza rilevamento esterno o deduzioni dalla sola assenza di rankings. Formalizzati 11 roster esplicitamente conclusi in TSK-0005 il 2026-09-10: snapshot con ID, data storica e nota della formalizzazione successiva. Non attribuita completezza ai roster di altre annualità senza attestazione importata.

Metriche 2025: census PnP 9/9 e adiacenti 2/8; classifica PnP 384/384 e adiacenti 80/80, rispettivamente 207 e 40 entry classificate. Sei challenge senza roster restano dipendenza. Materiali secondo MAT: primi post con esito osservabile, regole integrabili successivamente; acquisizioni complete soltanto se tutti i collegamenti dichiarati hanno file acquisiti oppure attestazione esplicita. Denominatori/esclusioni in app/README.md. Nessuna conclusione artificiale da file parziali, blocchi o denominator zero.

Verifiche: suite Python iniziale 43/43, suite finale focalizzata 5/5 (45 test Python distinti); frontend/PDF 46/46. Fixture complete/negative/incomplete/bloccate/non applicabili, roster vuoto e variato, vecchio schema, acquisizioni parziali e fallite, entrambi i perimetri, generatore condiviso e immagini. Edge headless a 1400/390 px: dieci barre 2025, classifica 100%, immagini 0%, nessun errore JavaScript o overflow della pagina; screenshot esaminati visivamente. Cruscotto A/B rigenerato, fonte/dati storici preservati, integrity ok e zero violazioni FK. Backup e screenshot in outputs/app008 (esclusi da Git). Nessun originale/materiale scaricato o modificato.

Segnalazione APP-008 chiusa. Decisioni promosse in app/README.md, PROJECT.md, AGENTS.md e stato workspace. PWS invariato. Limiti: attestazioni di altre annualità non importate automaticamente; risorse ignote/bloccate restano incomplete; acquisizione immagini non implementata. Nessun frontend di editing: gli esiti si registrano offline nei successivi task pertinenti.

Prossimo passo: revisione dell'utente nell'app e commit dedicato `Corregge metriche di completamento e aggiunge indicatore immagini`. Commit/push da autorizzare; modifiche preesistenti e concorrenti restano distinte. Nuove attestazioni appartengono ai task BGG/MAT/ACQ relativi, senza nuova ricerca in questo task APP.

## Incremento correttivo — 2026-10-04

Su segnalazione dell'utente riaperto TSK-0047: recuperare attestazioni storiche dei censimenti 2024/2026 e classifiche 2026, audit di tutte le altre barre e rimozione dello spazio superiore nei box annuali. Il primo incremento non aveva formalizzato tutte le evidenze già disponibili: lo zero indicava mancata conversione delle attestazioni, non perdita dei dati. Verificare ogni fonte locale prima di aggiungere osservazioni; nessuna nuova lettura esterna o acquisizione. Conservare i precedenti risultati e le modifiche pregresse. PWS locale e canonico ancora 1.5.0; preflight ordinario riuscito.

Deliverable: audit prima/dopo, importazioni additive riproducibili con provenienza/data originale, tutte le fasi controllate per entrambi i perimetri, cruscotto rigenerato, CSS e prova dell'offset superiore dei box a desktop/mobile. Successo: nessuna verifica già conclusa omessa dal conteggio, negativi soltanto attestati, esclusioni delle acquisizioni rispettate, blocchi/ignoti distinguibili e titoli annuali allineati in alto senza spazio inutile.

### Chiusura dell'incremento correttivo

Ripristinate 11 attestazioni roster 2024 e 16 snapshot completi 2026, con fonte locale e data storica. Il 2024 PnP torna 10/10 (100%); 2026 PnP 9/10 (90%, nuovo Roll & Write senza roster), adiacenti 7/8 (88%, Bad Comet selettivo/parziale). Classifiche 2026: 132/356 verifiche complete PnP, 12 verifiche parziali Two-Player e 21/74 complete adiacenti; 71 e 20 entry con risultati invariati. I podi Two-Player non certificano liste complete o assenze delle altre entry. Nessun completamento attribuito soltanto dallo stato del contest.

Importati gli esiti di tre manifest ACQ 2025: 39/363 acquisizioni PnP complete, 13 bloccate, 3 parziali, 21 non applicabili; 43 entry con file preservate. Esclusioni documentate dei link non scaricabili rispettate. Materiali confermati: 2026 23 scansioni complete; 2025 161 complete su 167 scansioni (due non osservabili, quattro non controllate); 2024 e annualità precedenti non analizzate. Immagini sempre 0% non implementate. Nessuna ricerca esterna, acquisizione o modifica degli originali.

Audit di tutte le annualità/fasi in HISTORY_AUDIT.md e HISTORY_RECONCILIATION.json. SQL di riproduzione in catalog/2026-10-04-work-history-reconciliation.sql; guardie su cardinalità/provenienza, prova su copia, backup, doppia applicazione idempotente, contenuti delle tabelle originarie invariati, integrity ok e zero violazioni FK. Le attestazioni sono additive; una prima formalizzazione tecnica dei podi Two-Player è stata corretta tramite osservazioni successive parziali, preservando la storia.

CSS dei pulsanti annuali a layout flex con contenuto in alto. Browser Edge 1560/1400/390 px: offset dei titoli primi cinque anni 15 px, differenza massima 0; metriche ripristinate confermate, dieci barre per anno, immagini zero, nessun overflow o errore JavaScript. Screenshot controllati visivamente. Test finali: 47/47 Python e 46/46 frontend/PDF. Cruscotto rigenerato tramite generatore condiviso; esiti parziali visibili in entrambe le superfici.

TSK-0047 e APP-008 nuovamente chiusi. Prossimo passo: revisione dell'app aggiornata e commit dedicato `Riconcilia avanzamento storico e allinea i box annuali`. Nessun commit/push eseguito; modifiche pregresse preservate. Se l'app è già in esecuzione, riavviarla per ricaricare il codice Python; anteprima verificata su 127.0.0.1:8789.

### Salvataggio autorizzato — 2026-10-04

L'utente autorizza commit e push di APP-008. Preparazione selettiva dei file del task, codice, migrazione 012, SQL delle attestazioni e sole parti pertinenti dei documenti condivisi. Esclusi database, backup, libreria, screenshot e modifiche del task GPR sulla rinomina delle chat. Verifiche funzionali già concluse: 47 Python e 46 frontend/PDF, browser desktop/mobile. Esito Git e identificativi saranno registrati soltanto dopo il successo delle operazioni.
