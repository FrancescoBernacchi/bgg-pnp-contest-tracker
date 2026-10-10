# TSK-0081 — Importazione lotto Carta e matita PerGioco

Apertura: 2026-10-08. Chiusura: 2026-10-10. Categoria DAT, modalità circoscritto, cadenza su richiesta. Stato: completato dopo conferma esplicita, applicazione e accettazione operativa. Chat: 01a11d66-fdb7-73f1-9b14-85c0183ff430. PWS confrontato alla ripresa: consumer e canonico 1.5.0.

## Contratto

Preparazione autorizzata dalla richiesta allegata: esclusivamente nove candidate PGCM-001…009 del CAT TSK-0080 (7 admitted, 2 requirement_not_demonstrated). Piano identità proposto, importer offline additivo B-v1/013 e collaudi su copie; piano finale e applicazione operativa richiedono conferma esplicita dopo rapporto concreto. Nessuna autorizzazione operativa registrata all'apertura.

Predecessore TSK-0080 concluso; adozione TSK-0073, modello TSK-0076, migrazione TSK-0077, pilota TSK-0078 e APP TSK-0079 collegati senza riapertura. Nessun task duplicato nel registro al controllo iniziale.

Input autorevoli: catalog/pergioco_extension_carta_matita_2026-10-08.json; TASK.md/RELAZIONE.md/VERIFICHE.json TSK-0080; sources/PERGIOCO-SCOPE.md; PUBLICATION_POLICY.md; DECISIONE.md/MODELLO_LOGICO.md/COMPATIBILITA_E_VALIDAZIONE.md TSK-0076; mapping fisico/contratto 013; schema operativo RO e importer/verifiche TSK-0078, riutilizzabili solo dopo verifica.

Esclusioni: schema/app, censimenti o rete esterna, VER autonoma, MAT/ACQ/IMG, download, backfill BGG/Kanare, ricensimento pilota/Chomp, automazioni e operazioni Git. Punti e linee raccolta e Battaglia Navale restano source-only proposti; Piattola sette varianti distinguibili senza ulteriori candidate/games; Labirinto un sistema e tre istanze, nessuna fruibilità o solution_for inventata. Matching locale solo candidati documentati, mai fusioni per nome; crediti contestuali non trasferiti al canonico.

## Deliverable e successo

Piano per ciascuna candidata e mapping, importer con ispezione predefinita RO, prove su copie e rapporto di confronto, backup/restore, eventuale operativo solo dopo conferma, registro e cruscotto aggiornati. Payload CAT completo e hash canonico, provenienza/date, classificazioni/path, NULL, accessi per ambito, crediti/lacune, menzioni, istanze/varianti/relazioni preservati. Chiavi/eventi stabili; proiezioni tipizzate; integrità/FK e schema esatto, conservazione di tutte le righe legacy/pilota, rollback atomico, replay zero delta, backup consistente e restore verificato, letture APP senza regressioni. ID allocati nella transazione, mai riservati sulla copia.

## Preflight e skill

Git main con numerose modifiche precedenti non committate: preservate; nessun fetch/commit/push. Letture e git riusciti nel sandbox ordinario, con avviso InitializeDefaultDrives già osservato nel pilota; nessun setup refresh had errors. Alias WindowsApps python non eseguibile: usare runtime Python bundled individuato dal tool dipendenze. Nessuna skill specialistica pertinente al DAT interamente offline; inventario locale consultato, verifica efficacia non applicabile. CUA non richiesto.

## Diario

- 2026-10-08: contratto registrato prima dell'implementazione. Importer pilota incompatibile direttamente con secondo lotto (guardia fonte già presente e conteggi globali); riuso selettivo di utility/protocollo, mapper dedicato senza modificare pilota.

- 2026-10-08: confronto corrente RO senza candidati esatti/normalizzati o collisioni URL; sette nuove identità locali conservative proposte, due source-only, 0 matching candidato nuovo. PIANO_IDENTITA.md tratta tutti i nove record, alias/crediti/lacune, raccolta, sette varianti e tre istanze senza solution_for. Alternativa nove source-only collaudata.
- 2026-10-08: importer/test dedicati offline, riuso delle utility pilota e del protocollo 013; nessuna modifica agli strumenti pilota/schema/app. COPY_VERIFICHE.json: 70/70 controlli finali, legacy/pilota completi, payload/hash/proiezioni, percorsi/date, backup/restore/WAL, NULL/collisioni/concorrenza/allocazione ID, rollback e replay zero delta. 69 crediti, 18 classificazioni/63 segmenti, 11 menzioni, 38 accessi, 3 istanze/appears_in e 7 varianti come asserzioni. Operativo hash/inventario invariato.
- 2026-10-08: APP_REGRESSION.json 66/66 e SCHEMA_REGRESSION.json 15/15 riusciti. Suite APP su fixture locali; TEMP sandbox non accessibile risolto con temp in outputs, socket localhost WinError 10013 diagnosticato fuori sandbox, senza rete esterna/scrittura operativa. Non attestato ripristino generale sandbox. Un difetto della fixture collisione (URL obbligatorio omesso) corretto prima della suite finale; nessuna perdita DAT.
- 2026-10-08: RAPPORTO_COLLAUDI.md registra verifica e limiti APP futuri (denominatori pilota e campi raw non tutti esposti). Nessuna incompatibilità strutturale B-v1/013 emersa. Nuovi deliverable sottoposti ad audit euristico/revisione originale; PUBLICATION_CHECK.json. Nessuna skill applicata, efficacia non applicabile. Dati annuali invariati, A/B non rigenerate; cruscotto aggiornato per stato task, registro aggiornato senza riaprire predecessori.

Preparazione conclusa, task non chiuso: nessun piano identità confermato e nessuna importazione operativa del lotto. Prossimo passo utile: conferma esplicita di PIANO_IDENTITA.md e applicazione dei nove record, quindi backup fresco, rivalidazione collisioni/legacy e verifica operativa/replay prima della chiusura. Eventuale APP separato; nessun commit/push eseguito o richiesto da questo task.

## Chiusura operativa — 2026-10-10

La frase precedente documenta lo stato della preparazione. L'utente ha poi confermato piano e applicazione: decisione in DECISIONE.md. Importazione eseguita il 2026-10-08, timestamp originale 2026-10-08T21:46:04.788098+00:00, APPLICAZIONE_OPERATIVA.json; ripresa richiesta il 2026-10-10 per completare accettazione e chiusura, senza nuova importazione.

OPERATIONAL_VERIFICHE.json: nove source_records 89–97, sette games 1455–1461 confermati come identità locali conservative, zero matching candidato nuovo e due source-only (89 Battaglia Navale, 94 Punti e linee raccolta). CAT 7/2; tre istanze Labirinto con usability ignota e zero solution_for, sette varianti Piattola come asserzioni senza altri games/record. Crediti/alias/relazioni/provenienza/path/payload/hash e campi NULL verificati dal mapper; delte operative identiche alle prove. Fonte PerGioco ora 21 record complessivi, distinti dal pilota storico dodici.

Backup fresco e restore con hash identico bafca09f2f63b7e131f53132dfc60a8e2c8bca73fa8155d016d4585d7e662d64 e inventario identico, percorsi locali in APPLICAZIONE_OPERATIVA.json. Schema e tutte le righe legacy/pilota preservate; integrità/FK valide. Letture APP operative 21 record e nove nuove schede riuscite, vecchie schede preservate salvo condizioni condivise aggiunte; Abande e metriche pilota immutati. Replay already_imported, zero scritture, hash e inventario operativo invariati prima/dopo replay. Nessun ripristino operativo necessario.

Registro e PROJECT_PROGRESS aggiornati; sezioni annuali rigenerate tramite generatore dopo importazione, senza variazioni ai dati BGG. Nessuna modifica schema/app o acquisizione, nessuna skill specialistica applicata; nessuna operazione Git. Preparazione (70 controlli copie, 66 APP, 15 schema) preservata come evidenza storica, non rieseguita sul lotto operativo. Audit nuovi deliverable aggiornato.

Prossimo approfondimento utile: APP autonomo per includere il lotto Carta e matita nei denominatori PerGioco e mostrare assessment_original, qualificazioni/usability delle istanze e alias/crediti contestuali delle varianti. Nessuna APP avviata. Perimetro sito intero non attestato; varianti/relazioni fuori lotto restano rinviate e non identità confermate. Commit/push restano esclusi e richiedono richiesta separata.

## Passaggio al task APP — 2026-10-10

Ulteriore indicazione esplicita utente: gestione quanto più uniforme possibile, senza logiche ad hoc per singolo gioco, al più per categorie. Registrata in PROJECT.md/AGENTS.md e nel prompt APP: titoli del lotto come casi di accettazione di componenti generici, riusabilità verificata su altri dati, nessun ramo applicativo per nome/URL/ID. Nessuna implementazione o refactoring eseguiti; DAT resta completato.

Su richiesta dell'utente predisposto PROMPT_PROSSIMO_APP.md: incrementi su denominatori dei due lotti e consultazione dei campi contestuali già persistiti, con matrice/test/QA e SQLite RO. Registro ricontrollato: TSK-0079 concluso, TSK-0067 aperto soltanto per immagini e fuori perimetro, nessun APP duplicato osservato. Questo è un allegato di passaggio del DAT completato: nessuna riapertura, nuovo ID, chat o implementazione APP avviati. PWS 1.5.0 allineato, modifiche Git preesistenti preservate; nessuna skill specialistica pertinente alla sola preparazione offline del prompt.


## Commit e push — 2026-10-10

Autorizzazione esplicita utente. Commit b773c767aabdf4e8401642c0a4e45f71646a9f0b su main inviato a origin e verificato sul remoto. Revisione dei contenuti di tutti i commit in uscita senza segnalazioni; modifiche locali estranee preservate. Database, backup e materiali esclusi. Evidenza in GIT_VERIFICHE.json.
