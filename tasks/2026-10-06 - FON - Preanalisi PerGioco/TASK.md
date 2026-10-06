# TSK-0072 — Preanalisi PerGioco

- Apertura: 2026-10-06; categoria FON; modalità circoscritto; cadenza su richiesta.
- Chat: 01a112a8-cda7-79e2-8d36-d8fb6cc59cea.
- Stato: completato il 2026-10-06.
- Autorizzazione: richiesta di esplorare una fonte candidata e relazione dettagliata; selezione esplicita PerGioco.
- Precedenti: TSK-0037 e TSK-0039 completati; approfondimento autonomo di una singola fonte, senza duplicare la ricerca comparativa.
- PWS: aligned_version e VERSION canonica 1.5.0. Preflight sandbox riuscito; main con numerose modifiche pregresse preservate, nessuna operazione Git mutativa.

## Contratto

Esplorare pagine pubbliche PerGioco con un campione motivato di indici, schede, varianti e servizi. Verificare regole gratuite osservabili, struttura, crediti, accessi e condizioni dichiarate. Confrontare con modello multifonte e app; proporre un percorso di integrazione e aggiornamento. Input: PROJECT.md, graduatoria fonti, migrazione 009 e successive, app/README.md, policy pubblicazione e inventario skill.

Deliverable: RELAZIONE.md dettagliata con fonti dirette e data, campione/lacune, mapping dati, rischi, costi stimati e passi successivi separati. Successo: elementi sufficienti per decidere un eventuale pilota. Esclusi censimento integrale, adozione, importazione, download di file, sessioni di gioco, modifiche app/schema e contatti/iscrizioni.

## Skill

source-preanalysis applicata. Browser CUA usato secondo la documentazione runtime per lettura pubblica; skill computer-use consultata, senza attivare automazione Windows nativa. Nessuna generalizzazione tecnica da un solo caso.

## Diario

- 2026-10-06: apertura; home osservata. Alcuni indici/condizioni non restituiti dallo strumento web, distinzione da indisponibilità del sito. Archivio newsletter leggibile: password su alcuni documenti e alternativa tramite richiesta newsletter, senza richiesta effettuata.

## Risultati e chiusura

Consegnata RELAZIONE.md: 25 pagine/destinazioni, sette schede principali e strutture associate; regole pubbliche, presentazione Azul, base/variante, soluzioni Itinera protette, archivi multi-gioco, ruoli e condizioni. Query SQLite read-only: confronto di undici nomi con titoli/alias, Abande game_id 993 già collegato a Kanare e Dieter Stein. Nessun matching scritto. Mapping schema/app, URL storici, manutenzione e costi qualitativi con limiti espliciti.

Riferimento condiviso sources/PERGIOCO-PREANALYSIS.md; inventario aggiornato sul secondo contesto della skill e collegamento a TSK-0048, che resta aperto. Nessuna modifica alla skill, alla graduatoria comparativa, allo Standard, app, schema o dati operativi; nessun download o iscrizione. PROJECT_PROGRESS.md aggiornato per lo stato FON, sezioni annuali A/B non rigenerate perché nessun dato pertinente è cambiato.

Verifiche documentali e del registro in VERIFICHE.json. Nessuna promessa di completezza del sito o di liceità universale dei contributi. Originali e modifiche pregresse preservati. Titolo visibile conforme. Nessun commit/push eseguito; incremento da committare dopo revisione selettiva. Messaggio proposto: `Documenta la preanalisi della fonte PerGioco`.

Prossimo approfondimento utile: decisione EPR sul perimetro (astratti/carta e matita, eventuali problemi logici), quindi CAT pilota autonomo di 10–15 identità proposto nella relazione. Nessun controllo periodico o automazione impostato.

## Verifica dell'efficacia

Skill source-preanalysis applicata: rapporto singola fonte, campione, accessi, mapping e proposta verificati nel perimetro FON. Cache miss web risolti con lettura browser, senza accessi protetti; date cache/live distinte. Rinvii e titoli non uniformi sono caratteristiche della fonte già gestibili dalla procedura. Un errore iniziale di quoting PowerShell nell'apertura registro è stato corretto prima della scrittura, senza effetto sui dati: origine nel comando, non nella skill. Nessun difetto riproducibile della skill o modifica necessaria emersa. Restano non collaudati censimento integrale, PDF, traduzioni, login, implementazioni ed estrazione massiva. Secondo contesto collegato a TSK-0048 senza validità universale.

## Salvataggio Git — 2026-10-06

Su richiesta utente eseguiti commit selettivo e push su main: ef4d2c4bfa4230af71d66e9fc5cf91966fa1eb04. Audit del commit in uscita senza rilievi; 299 candidati preesistenti della working tree esclusi. Push riuscito e HEAD/origin/main coincidenti. Modifiche degli altri task preservate. Il contratto CAT e pubblicato, mentre la sua esecuzione resta nel task dedicato.
