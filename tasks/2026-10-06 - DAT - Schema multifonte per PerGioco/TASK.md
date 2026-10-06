# TSK-0077 — Schema multifonte per PerGioco

Apertura 2026-10-06, DAT circoscritto su_richiesta. Predecessore TSK-0076 completato, B-v1 e piano identita adottati; TSK-0073 perimetro, TSK-0075 preparazione. Stato iniziale in_corso; stato corrente completato il 2026-10-06 dopo applicazione autorizzata e verifiche. Chat 01a112f5-19f1-74c0-873d-c32a9b043631, titolo cumulativo `2026-10-06 - DAT - Deliberazione e schema multifonte PerGioco`; titolo precedente `2026-10-06 - EPR - Persistenza multifonte per PerGioco`. Percorso EPR preservato.

## Contratto esecutivo

Autorizzazione utente «OK, procedi» al DAT schema/migrazione con prove su copia, backup e ripristino. Implementare B-v1 con migrazione additiva 013, mapping logico-fisico documentato, controlli SQL dei vincoli, strumento offline di applicazione idempotente e verifiche di conservazione legacy. Schema.sql riallineato per nuove installazioni. Nessuna modifica app o dati catalogo; zero import PerGioco, backfill o riesame BGG/Kanare, zero rete/acquisizioni/IMG/piattaforme. Standard PWS read-only 1.5.0.

Applicazione al database operativo soggetta alla risposta esplicita alla domanda mirata, richiesta dal contratto B-v1 `COMPATIBILITA_E_VALIDAZIONE.md`, riga DAT schema/migrazione: «applicazione operativa se compresa esplicitamente». Fino alla risposta soltanto copie e backup letti dall'operativo. Backup consistente tramite SQLite API, integrita/FK e restore provato su copia; nessun ripristino distruttivo automatico dell'operativo. Rollback su errori e preservazione copie diagnostiche. Tutti gli scrittori devono essere assenti durante la transazione esclusiva.

Deliverable: migrazione 013, schema aggiornato, mapping fisico, test vincoli/storia/proiezioni/NULL e rollback su copia, report conservazione contenuto e schema legacy, backup/restore, idempotenza e compatibilita di lettura app. Nuove tabelle operative vuote; vecchie righe/ID/viste/triggers invariati. Successo dopo verifica dei deliverable autorizzati, senza avvio di DAT importazione o APP.

## Preflight

Sandbox ordinario posizione/stato Git/letture riusciti. PWS locale/canonico 1.5.0. Nessun DAT aperto pertinente; nuovo ID 0077 libero. Main allineato a origin/main nel riferimento locale, remoto non interrogato; numerose modifiche pregresse preservate. Nessuna operazione Git mutativa autorizzata. Nessuna skill applicabile alla sola implementazione SQLite offline; verifica efficacia non applicabile. Nessuna delega.

## Autorizzazione operativa e collaudo — 2026-10-06

Risposta esplicita utente alla domanda del contratto: «Sì, applica anche all’operativo dopo le verifiche». Applicazione limitata alla migrazione di schema 013, zero import PerGioco. Tre incrementi di collaudo hanno risolto difetti del generatore/comparatore e rafforzato controlli; ultima prova 15 test comportamentali e 12 controlli su copie tutti riusciti. Fonte operativa invariata durante accettazione; backup/restore/WAL, rollback e replay provati. Mapping e PHYSICAL_MODEL completati, revisione pubblicazione del nuovo incremento senza candidati euristici. Registro aggiornato prima dell’applicazione.


## Migrazione 013 operativa — chiusura 2026-10-06

Stato completato dopo consegna e verifiche dei deliverable autorizzati. Migrazione 013/schema/generatore/runner/test/verificatore e mapping fisico pronti. Applicazione operativa dopo esplicito consenso, backup consistente e restore su copia verificati. 21 nuove tabelle vuote, legacy preservato per tutte le righe/ID/oggetti; integrita/FK valide e lettura app catalog/game993/entry/contest identica al backup. Seconda applicazione operativa zero delta. Zero fonte PerGioco, game/matching, backfill, APP, rete o acquisizioni.

Report: BASELINE.json, COPY_PRE_APPLICAZIONE.json (collaudo prima della scrittura), COPY_VERIFICHE.json (replay su copie del backup), TEST_RESULTS.txt, OPERATIVO_VERIFICHE.json (hash/percorso backup e restore), FINAL_VERIFICHE.json; PHYSICAL_MODEL.json e MAPPING_FISICO.md collegano il contratto logico al DDL. 15 test e 12 controlli d'integrazione riusciti; correzioni del collaudo e limiti descritti nel mapping. La prova non certifica replay di un importer PerGioco ancora inesistente. Nessuna skill applicata, verifica efficacia non applicabile.

Aggiornati database README, PROJECT, AGENTS, PROJECT_STATE, PERGIOCO-SCOPE, README/catalog README, registro e cruscotto; EPR predecessore completato conservato con raccordo. A/B annuali non rigenerate per assenza di modifiche a dati BGG/materiali/ACQ. Standard invariato 1.5.0. File binari di copia/backup solo outputs esclusi Git; nessuna pubblicazione o operazione Git mutativa. Incremento coerente da committare su richiesta, messaggio `feat: aggiunge persistenza multifonte B-v1 senza importare PerGioco`. Prossimo passo: DAT importazione separato su autorizzazione, con contratto del lotto 12 e collaudi idempotenza/provenienza/identita. APP successiva autonoma.

## Commit e push verificati — 2026-10-06

Commit selettivo `22479a61b11456035d0fe23dcb1ad9a37602f31b` su main: decisione B-v1, schema/migrazione 013 e verifiche, 36 file; documenti condivisi e registro preparati da HEAD con sole modifiche PerGioco. Push origin/main riuscito; ls-remote hash identico, confronto 0/0. Audit di tutti i contenuti del commit in uscita senza candidati; 299 candidati pregressi su 30 percorsi esterni all’incremento restano da riesaminare. Database/backup/materiali esclusi, modifiche estranee preservate. Il componente HTTPS bundled Git e stato selezionato tramite exec-path per questa operazione, senza modifiche di configurazione; rete e indice hanno richiesto esecuzione fuori sandbox autorizzata. Esito registrato nel successivo commit documentale compreso nella richiesta commit e push; nessuna importazione o APP.
