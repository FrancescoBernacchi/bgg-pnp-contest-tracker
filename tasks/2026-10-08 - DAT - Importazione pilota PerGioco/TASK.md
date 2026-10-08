# TSK-0078 — Importazione pilota PerGioco

Apertura 2026-10-08; DAT, circoscritto, su_richiesta; stato in_corso. Predecessore TSK-0077 completato; riferimenti TSK-0073/74/75/76.

## Contratto e autorizzazione

Preparare importer offline e collaudare su copie lo schema B-v1/013 delle dodici candidate CAT. Prima di qualsiasi scrittura operativa presentare prove, contenuto preciso, ambiguità e backup/ripristino e ottenere nuova autorizzazione esplicita. Nessun commit/push autorizzato in questo incremento.

Input: PERGIOCO-SCOPE, manifest CAT e sue verifiche, preparazione TSK-0075, DECISIONE/MODELLO_LOGICO/COMPATIBILITA_E_VALIDAZIONE TSK-0076, MAPPING_FISICO/migrazione 013 e runner TSK-0077, documenti autorevoli correnti.

Deliverable: importer, anteprima, rapporto collaudo con preservazione completa legacy, replay senza duplicazioni, transazioni/rollback, NULL/collisioni, hash canonici e percorsi completi; piano backup/restore e richiesta finale. Successo operativo futuro: 12 record fonte, esiti CAT 9/3, otto games, Abande candidato 993, tre source-only, Itinera uno/due e soluzioni separate, Libre senza arco canonico verso 993.

Esclusi rete/censimenti, backfill BGG/Kanare, APP/schema/migrazioni, acquisizioni/immagini, conferma Abande. Crediti irrisolti restano osservazioni senza persone fittizie o matching per solo nome.

## Preflight e ripresa

2026-10-08: dopo blocco setup refresh e chiusura completa runtime, comandi sandbox ordinario riusciti; posizione/Git/letture e scrittura-lettura-rimozione temporanea verificate. Avviso PowerShell InitializeDefaultDrives e avvii lenti ancora presenti, ma accesso workspace funzionante; nessuna ACL/cache modificata. PWS allineato 1.5.0. Registro max TSK-0077, nessun task importazione pertinente né fonte PerGioco nell'operativo; tabelle osservazioni 013 vuote. Modifiche pregresse su main preservate, origin/main solo riferimento locale, nessun controllo rete. Inventario consultato: lavoro DAT offline non attiva skill BGG/FON. CUA non richiesto, non inizializzato per evitare interferenza runtime.

## Incremento preparatorio verificato — 2026-10-08

Stato in_verifica, in attesa dell'autorizzazione operativa richiesta dall'utente. Importer e collaudo completi; 26 controlli in COPY_VERIFICHE.json passati su copie, anteprima e piano in ANTEPRIMA.json/PIANO_IMPORTAZIONE.md. Nessun inserimento operativo. Hash operativo prima/dopo `1915090b20fec26f3063f840a7356c4427b12993ca167b3cad1cc195cbf19295`, anche inventario completo invariato. Manifest CAT originale preservato, hash verificato contro TSK-0074; prove WAL, restore, replay, collisioni/NULL, path incompleto e rollback riuscite. Schema/app e ogni riga legacy preservati. Operativo schema 013 installato esatto, fonte PerGioco assente verificata direttamente.

Correzione in collaudo: prima copia rifiutata per record_observation_id mancante nelle relazioni; mapping corretto, rollback automatico, successive prove complete riuscite. Riferimenti raw_value/pointer affinati per URL/gap/istanze e controllati rispetto al CAT. Nessun tentativo di aggirare vincoli o escalation; processo shell alternativo iniziale con sintassi errata non ha scritto dati, corretto alla shell PowerShell.

Limiti: importer del pilota congelato, non engine di monitoraggio/nuove visite; input mutato richiede nuovo contratto. Persone/crediti canonici non risolti; fonte/categorie/accessi e lacune preservati nella nuova evidenza B-v1. APP non modificata né dichiarata capace di mostrarli. Skill specialistiche non applicate, verifica efficacia non pertinente. Versionamento da_committare, nessun commit/push. Predecessori restano completati; A/B annuali non rigenerate perché nessun dato operativo mutato.

Titolo visibile cumulativo aggiornato da `2026-10-06 - DAT - Preparazione integrazione PerGioco` a `2026-10-06 - DAT - Preparazione e importazione pilota PerGioco`: data apertura chat preservata, cartella nuovo incremento 2026-10-08. Prossimo passo: autorizzazione finale al lotto descritto; backup fresco e ricontrollo baseline prima dell'operativo. Nessun restore operativo automatico.

## Chiusura operativa autorizzata — 2026-10-08

Utente conferma «Autorizzo» nella chat corrente. Operativo importato con backup fresco pergioco-before-20261008T194952981278.sqlite3 e restore su copia verificato; nessun restore operativo eseguito. Stato completato. Report OPERATIONAL_VERIFICHE.json registra consenso, mapper/hash, ID, delta tabelle e verifiche post-commit. Record 77–88, nuovi games 1447–1454, Abande candidato 993, tre senza game; 9/3, istanze/soluzioni e relazioni fonte invariati. Ogni riga legacy e schema preservati; letture delle schede via app attuale verificate, nessuna funzione nuova implementata. Replay operativo already_imported con zero scritture e hash file identico.

Registro e cruscotto aggiornati prima della chiusura; sezioni annuali A/B rigenerate dal generatore perché sono cambiati games/risorse, senza modificarle manualmente. Stato operativo corrente promosso in sources/PERGIOCO-SCOPE.md, database/README.md, catalog/README.md e PROJECT_STATE; nessuna nuova architettura o modifica Standard. Manifest CAT/anteprime/copied tests conservati come storia, non riscritti. Tutti i binari/test/backup restano in outputs escluso da Git. Skill non applicate oltre inventario, efficacia non pertinente.

Incremento da_committare; nessun commit/push eseguito. Proposta messaggio futuro: `feat: importa pilota PerGioco nel modello multifonte B-v1`. Modifiche pregresse preservate. Prossimo passo utile APP autonomo per navigare classificazioni/esiti/evidenze PerGioco; eventuale VER Abande distinto, nessuna acquisizione automatica.

Follow-up documentale 2026-10-08: utente richiede prompt per integrare PerGioco in tutti gli aspetti dell'app. Preparato PROMPT_PROSSIMA_CHAT_APP.md con matrice delle superfici, viste canoniche/record fonte, classificazioni e prove B-v1, ricerca, risorse/istanze, crediti/diritti, Libreria/lettori, metriche e QA/regressioni. Nessun task/chat APP creato e nessuna implementazione avviata. Registro verificato: nessun APP PerGioco pertinente; TSK-0067 immagini resta autonomo. TSK-0078 resta completato, scope/stato dati invariati; nessun ulteriore aggiornamento cruscotto necessario per questo solo prompt.

## Versionamento verificato — 2026-10-08

Commit `de36af3c6648dfc048f2922a288c3acf8b782407` su main: 14 file dell incremento DAT PerGioco e prompt APP, documentazione condivisa selezionata, database/backup/materiali esclusi. Push origin/main riuscito, hash server verificato uguale a HEAD. Audit commit in uscita: zero rilievi; 299 segnalazioni su 30 percorsi pregressi esclusi dal commit, revisione selettiva documentata localmente. Il primo comando di commit è stato respinto da auto-review per audit globale non risolto; ripetuto soltanto dopo prova di sovrapposizione nulla e revisione dei file selezionati, poi approvato. Modifiche pregresse preservate. Questa nota e lo stato Git nel registro formano il successivo commit documentale della richiesta commit/push.
