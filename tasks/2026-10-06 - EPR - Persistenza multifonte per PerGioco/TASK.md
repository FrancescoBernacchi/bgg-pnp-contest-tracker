# TSK-0076 — Persistenza multifonte per PerGioco

Apertura: 2026-10-06. Categoria EPR, secondaria DAT; circoscritto, su_richiesta. Stato iniziale: in_corso, preparazione deliberativa autorizzata; adozione non autorizzata. Chat: 01a112f5-19f1-74c0-873d-c32a9b043631.

## Contratto

Rendere concreta e verificabile l'opzione B di TSK-0075, con modello logico generico, dizionario, mapping e prova offline sulle sole dodici candidate CAT. Produrre PROPOSTA.md, MODELLO_LOGICO.md, COMPATIBILITA_E_VALIDAZIONE.md, CASI_PILOTA.json e VERIFICHE.json. Successo: separazioni semantiche e vincoli definiti, 9/3 CAT preservati, piano otto nuove identità/un candidato 993/tre source-only, Itinera uno/due, compatibilità legacy e autorizzazioni distinte. La prova è documentale e sui dati offline, non un collaudo SQL.

Predecessore TSK-0075 completato; perimetro deliberato TSK-0073; evidenze TSK-0074 completato. Nessun task EPR pertinente aperto nel registro: incremento autonomo necessario perché decide l'architettura, mentre TSK-0075 ne preparava le alternative. Non riaprire i predecessori.

Input: PERGIOCO-SCOPE, manifest CAT, RELAZIONE/VERIFICHE CAT; PROPOSTA/ANTEPRIMA/MODELLO_CORRENTE/VERIFICHE/TASK DAT; schema e migrazioni 001–012, PROJECT, database/README, documentazione app/catalogo multifonte, PUBLICATION_POLICY e TASK_GOVERNANCE. Riferimenti originali nei documenti e hash in VERIFICHE.json.

Esclusi: scritture SQLite, migrazioni eseguibili, schema/app, nuovi campioni, navigazione esterna, piattaforme, iscrizioni, acquisizioni/immagini, manutenzione PWS, operazioni Git mutative. Documenti autorevoli architetturali da aggiornare soltanto dopo conferma esplicita.

## Preflight

Sandbox ordinario: Get-Location, git status e letture riusciti. PWS identificato tramite PROJECT_STATE: aligned_version e VERSION canonico 1.5.0, nessuna migrazione richiesta. Titolo visibile conforme, rinominato il 2026-10-06; non disponibile un titolo precedente attendibile. Main allineato al riferimento locale origin/main; remoto non interrogato. Numerose modifiche pregresse, anche registro/cruscotto/app, preservate; nessun commit/push autorizzato.

Inventario skill consultato: nessuna skill applicabile alla sola deliberazione EPR offline; non attivati workflow FON/BGG/MAT/IMG. Verifica efficacia skill non applicabile. Nessuna delega o CUA necessaria.

## Incremento preparatorio — 2026-10-06

Proposta B-v1 pronta per decisione, modello generico e piano delle identità distinti. Registro e cruscotto aggiornati per attività, senza modificare sezioni annuali generate: dati e metriche invariati. Stato finale di questo incremento: in_verifica, in attesa di deliberazione dell'utente; task EPR non chiuso. Verifiche e limiti in VERIFICHE.json; prove SQL/backup/restore rinviate al DAT esecutivo autorizzato.

Contenuti nuovi: documentazione originale, metadati necessari, link e ruoli attribuiti dal CAT; nessun regolamento integrale, media o dump esterno. Gratuità non trattata come licenza. Non certificata la pubblicabilità di modifiche pregresse; audit completo prima di eventuale commit/push. Suggerimento futuro: `docs: propone persistenza multifonte PerGioco per deliberazione EPR`.

Prossimo passo: confermare o correggere la formulazione in PROPOSTA.md. Dopo conferma registrare decisione, data e ambito e promuovere solo l'architettura deliberata in PROJECT.md, AGENTS.md, database/README.md e PROJECT_STATE; aggiornare registro/cruscotto e chiudere EPR. Non avviare DAT, importazione, VER Abande o APP automaticamente.

Verifica finale dell'incremento: 17 controlli offline superati e sei controlli documentali aggiuntivi; matrice JSON rigenerata con hash identico, registro con ID unici e predecessori ancora completati. 26 classificazioni, 21 menzioni (quattro URL NULL), due istanze; schema, migrazioni, app, DB e riferimenti architetturali con hash invariati durante il verificatore. PUBLICATION_CHECK.json applica l'euristica della policy ai nuovi file anche non tracciati: zero candidati nel perimetro, revisione manuale di sintesi/metadati/ruoli/link effettuata; non riguarda modifiche o cronologia altrui. I grandi diff di registro/cruscotto rispetto a Git includono incrementi pregressi: in questa chat aggiunti solo TSK-0076, il collegamento successore di TSK-0075, la chat e una riga del cruscotto. Nessun collaudo SQL, backup/restore o revisione esterna eseguiti. Proposta richiesta nel pannello Codex; tool restituisce queued, senza attestazione di apertura visibile.


## Persistenza multifonte PerGioco — B-v1 adottata

Chiusura 2026-10-06, stato completato. Utente: «OK, confermo», dopo richiesta esplicita di confermare B-v1 e piano identita. DECISIONE.md registra l'adozione logica e i confini; PROJECT.md, AGENTS.md, database/README.md, PROJECT_STATE e PERGIOCO-SCOPE aggiornati. Registro e cruscotto coerenti; TSK-0074/0075 restano completati. Proposta/anteprime/verifiche preparatorie preservate come storia, con raccordo allo stato corrente; modello logico e compatibilita adottati, DDL operativo invariato. Nessun DAT/importazione/VER/APP avviato, nessun backfill, navigazione o acquisizione. PWS 1.5.0; verifica della formalizzazione in DECISION_VERIFICHE.json. Nessuna skill applicabile a questa registrazione documentale, verifica efficacia non applicabile.

Prossimo passo utile: su richiesta autorizzare un DAT esecutivo di schema/migrazione secondo il contratto deliberato; importazione PerGioco e APP restano successivi passi autonomi. Incremento documentale coerente da salvare con commit su richiesta, messaggio suggerito `docs: registra decisione B-v1 sulla persistenza multifonte PerGioco`; nessun commit/push eseguito.


## Migrazione 013 operativa — successore 2026-10-06

TSK-0077 DAT schema multifonte autorizzato nella stessa chat dopo chiusura EPR, con consenso esplicito aggiuntivo all'applicazione operativa dopo prove. B-v1 ora implementata come migrazione 013, nuovi insiemi vuoti e legacy preservato; PerGioco non importato/APP invariata. TSK-0076 resta completato, adozione originaria e date preservate; esiti di esecuzione nel successore. Titolo chat cumulativo aggiornato a `2026-10-06 - DAT - Deliberazione e schema multifonte PerGioco` con storia nel registro.

## Commit e push verificati — 2026-10-06

Commit selettivo `22479a61b11456035d0fe23dcb1ad9a37602f31b` su main: decisione B-v1, schema/migrazione 013 e verifiche, 36 file; documenti condivisi e registro preparati da HEAD con sole modifiche PerGioco. Push origin/main riuscito; ls-remote hash identico, confronto 0/0. Audit di tutti i contenuti del commit in uscita senza candidati; 299 candidati pregressi su 30 percorsi esterni all’incremento restano da riesaminare. Database/backup/materiali esclusi, modifiche estranee preservate. Il componente HTTPS bundled Git e stato selezionato tramite exec-path per questa operazione, senza modifiche di configurazione; rete e indice hanno richiesto esecuzione fuori sandbox autorizzata. Esito registrato nel successivo commit documentale compreso nella richiesta commit e push; nessuna importazione o APP.
