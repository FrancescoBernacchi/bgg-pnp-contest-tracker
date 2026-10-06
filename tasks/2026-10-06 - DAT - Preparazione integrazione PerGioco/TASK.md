# TSK-0075 — Preparazione integrazione PerGioco

Apertura: 2026-10-06. Categoria DAT; modalità circoscritto, cadenza su_richiesta. Predecessore TSK-0074 completato; dipendenza dal perimetro deliberato TSK-0073. Stato iniziale in_corso.

## Contratto

Progettare, senza eseguire importazioni, la persistenza delle dodici candidate del CAT: nove ammissibili e tre con requisito non dimostrato. Conservare integralmente metadati, esiti, classificazioni native, provenienza e date; distinguere identità, record fonte, matching, ruoli, risorse/istanze e accessi. Verificare il modello operativo esclusivamente con SQLite mode=ro e query_only.

Input: sources/PERGIOCO-SCOPE.md, catalog/pergioco_pilot_2026-10-06.json, RELAZIONE.md e VERIFICHE.json di TSK-0074; schema, migrazioni 001–012, PROJECT.md, database/README.md e app/README.md correnti.

Deliverable: PROPOSTA.md con mapping, lacune, alternative, decisione EPR proposta, idempotenza, backup/ripristino e criteri di accettazione; ANTEPRIMA.json con operazioni simboliche per tutte le candidate; VERIFICHE.json con controlli offline e impronte; build_preview.py riproducibile e privo di scritture SQLite.

Esclusioni: database operativo, migrazioni, schema/app, acquisizioni/immagini, iscrizioni, piattaforme, ampliamento campione e navigazione esterna. Importazione e APP richiedono passi separati. Nessuna architettura adottata implicitamente.

Successo: 12 esiti preservati, 9/3 riconciliati, tre non ammessi senza games automatici, Abande 993 solo candidato, omonimi separati, Itinera un sistema/due istanze, dati originali senza perdita e verifiche DB invariato. Proposta completa prima delle decisioni esecutive.

## Preflight e competenze

Sandbox ordinario: posizione, git status e letture riusciti; PWS locale/canonico 1.5.0. Main allineato al riferimento locale origin/main, remoto non interrogato; numerose modifiche pregresse preservate. Titolo Codex rinominato secondo convenzione. Registro e inventario consultati: nessun DAT PerGioco preesistente, nessuna skill pertinente a questa sola progettazione DAT offline; workflow BGG/FON/MAT non attivati. Python non nel PATH, usato runtime bundled senza installazioni. PWS read-only.

## Chiusura — 2026-10-06

Stato completato per la preparazione, non per importazione o integrazione. PROPOSTA.md, ANTEPRIMA.json, MODELLO_CORRENTE.json e VERIFICHE.json consegnati. Quattordici invarianti offline superate; manifest confrontato con hash CAT, payload e classificazioni originali preservati. Due esecuzioni del generatore concluse positivamente. Schema operativo, conteggi, matching esatto e integrità letti in mode=ro/query_only; impronte DB prima/dopo identiche. Abande unico riscontro locale esatto 993, ancora candidato. Gli altri undici senza match esatto: limite esplicito, non prova di unicità.

Proposta: dodici record fonte, otto games nuovi dopo autorizzazione, un candidato 993, tre source-only; Itinera uno/due, risorsa soluzioni separata. Opzione A senza migrazioni mediante metadati strutturati oppure B additiva, raccomandata e da deliberare in EPR; nessuna adozione implicita. Criteri di accettazione, rischi di unicità con NULL, rollback e ripristino documentati. Non eseguito replay SQL: importer non realizzato.

TSK-0074 resta completato e collegato come predecessore; registro e cruscotto aggiornati. Sezioni annuali A/B non rigenerate, dati invariati. Nessuna skill applicata oltre alla consultazione dell'inventario, quindi verifica di efficacia non applicabile. Nessuna rete/CUA, iscrizione, acquisizione o verifica piattaforme. Schema/app e documenti architetturali autorevoli invariati.

Revisione pubblicazione del nuovo incremento: soltanto metadati, DDL locale, link, codice e sintesi originali provenienti dal CAT; crediti e date inclusi, nessun testo integrale o binario di terzi. Non certifica la pubblicabilità delle numerose modifiche/commit pregressi; audit completo resta necessario prima di un eventuale commit/push. Nessuna operazione Git mutativa eseguita. Incremento da committare, proposta messaggio `docs: prepara integrazione DAT PerGioco senza importazione`.

Prossimo passo: decisione A/B e conferma del piano identità proposto. Solo dopo eventuale EPR, aprire separatamente esecuzione DAT; APP autonoma. Nessun approfondimento esterno è necessario per deliberare questa proposta; confronto Abande ulteriore da autorizzare in VER se richiesto.

Follow-up documentale 2026-10-06: su richiesta utente preparato PROMPT_PROSSIMA_CHAT.md per deliberare l'opzione B in una nuova chat EPR. Nessuna chat/task EPR creati, nessuna adozione o implementazione. TSK-0075 resta completato; prompt verificato rispetto a proposta, confini e piano identità. Nessun cambiamento a copertura, stato o architettura: registro e cruscotto non richiedono un ulteriore aggiornamento.
