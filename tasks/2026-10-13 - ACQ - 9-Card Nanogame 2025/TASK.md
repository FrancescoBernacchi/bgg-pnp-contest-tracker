# TSK-0087 — ACQ - 9-Card Nanogame 2025

Apertura: 2026-10-13. Stato: completato con limiti documentati. Chiusura: 2026-10-14. Modalità: circoscritto, su_richiesta.

## Richiesta e continuità

L'utente richiede di avviare il task di acquisizione materiali del 2025 9-Card Nanogame Print and Play Design Contest, identificato nello screenshot allegato. Il precedente MAT TSK-0051 è completato; questo task costituisce il successivo workflow autonomo ACQ per il solo contest 13. Nessun ACQ dello stesso contest individuato nel registro. Non riapre il censimento MAT né corregge il roster.

## Contratto preparato

Obiettivo: verificare gli host dichiarati e acquisire gli originali dei giochi selezionati, con condizioni, provenienza, data, dimensioni, SHA-256 e versioni. Selezione, lingue e tipi di risorse devono essere confermati prima dell'accesso agli host e dei download. Nessun titolo è ancora selezionato e nessuna acquisizione è autorizzata per implicazione dall'intero roster.

Proposta iniziale da deliberare: i giochi con risultati ufficiali registrati, materiali gratuiti di regole e componenti stampabili in italiano o inglese; esclusi acquisti, video, implementazioni online e immagini IMG autonome. Alternativa: tutte le entry oppure elenco esplicito dell'utente. La proposta non costituisce selezione approvata.

Esclusi: altri contest, nuovi censimenti, riconciliazione ElementaBrawl, estensione MAT all'intero thread, IMG, modifiche schema/app, commit e push. Applicazione dei metadati al database soltanto entro autorizzazione esplicita e dopo collaudo su copia, backup/ripristino e verifiche.

## Input e baseline

- TSK-0051: `tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/TASK.md` e relativo dataset operativo.
- `sources/2025-NINE-CARD-MATERIALS.md`, roster e risorse operative del contest 13.
- Fonte contest: https://boardgamegeek.com/thread/3436343/2025-9-card-nanogame-print-and-play-design-contest.
- Baseline MAT storica del 2026-10-04: 94 record locali, 89 letture complete, cinque blocchi; 80 entry con risorse dichiarate, 208 URL distinti per gioco. Roster ufficiale 93 righe; Elementa/Brawl restano distinti con ambiguità preservata. Lo screenshot mostra 19 entry classificate: dato da verificare sul database prima di definire l'elenco selezionato.

## Deliverable e successo

Elenco approvato con ID e confini; inventario dei file osservabili per risorsa; manifest versionabile con esiti ed esclusioni; originali immutati in library/bgg con hash e versioni; rapporto di verifica e residui. Ogni risorsa inclusa deve avere esito esplicito, senza equiparare blocchi o enumerazione parziale a completezza. Aggiornare attestazioni e sezioni A/B soltanto se cambiano i dati operativi.

## Verifiche di apertura

PWS consumer e canonico 1.5.0. Lettura workspace e git status riusciti; PowerShell ha emesso un avviso InitializeDefaultDrives, senza impedire le letture. Branch main allineato al riferimento locale origin/main; remoto server non verificato. Numerose modifiche preesistenti preservate, nessuna operazione Git di scrittura.

Skill lette e applicate: bgg-contest-navigation e bgg-material-acquisition. Efficacia nell'apertura: distinzione MAT/ACQ e necessità della selezione correttamente applicate; navigazione host, enumerazione e trasferimenti non ancora collaudati in questo task. Nessuna manutenzione skill necessaria.

## Prossimo passo

Ricevere selezione, lingue e risorse; preparare l'elenco identificato sul database e procedere alle verifiche degli host nel perimetro deliberato. Nessun host esterno aperto, nessun file scaricato e nessun dato operativo modificato nell'apertura.

## Lotto approvato — 2026-10-13

L’utente autorizza «Cominciamo con il lotto dei classificati». Selezione verificata sul database RO: 19 entry con piazzamento ufficiale non NULL, deduplicate per gioco; elenco e 58 menzioni di risorsa in SELECTION.json. Si adotta la proposta IT/EN, regole e componenti gratuiti, senza acquisti/IMG/implementazioni online. Prima acquisizione pilota Bullet Run: tre PDF scaricati; controllo lingua e hash in corso. Il trasferimento browser è arrivato in Downloads nonostante timeout del ritorno evento; nessun originale utente eliminato. DNS dei processi sandbox non disponibile; trasferimento diretto fuori sandbox autorizzato e verificato, senza modifiche ACL o configurazione.

## Checkpoint verificato — 2026-10-14

Acquisiti 56 originali distinti: 55 PDF e un JPEG, per 18/19 giochi. Esiti: 17 completi nel perimetro, Dragons Horde parziale (demo con una configurazione contro 256 del completo), Three Buccaneers bloccato dalla baseline MAT. Dettagli in REPORT.md e catalog/2025_nine_card_ranked_acquisition_2026-10-13.json. Otto cartelle confrontate nel browser, tutte senza sottocartelle; versioni/varianti di stampa conservate. Collegamenti duplicati conservati in source_remote_resource_ids senza doppio conteggio del file. Nessun host a pagamento o implementazione online acquisito.

Verifica formato: JPEG Word Flower con estensione originale .pdf preservata, esportazioni Google Docs marcate come export host. Verifica di tutti gli hash/dimensioni superata; PDF riaperti e prima pagina renderizzata, controllo testo/lingua e identità. Un PDF slovacco trasferito prima della verifica lingua è escluso da lotto/importazione, originale preservato e segnalato in excluded_files. Il nome cartella del lotto resta 2026-10-13; timestamp dei trasferimenti e data conclusiva 2026-10-14 distinti dalla data di apertura/autorizzazione.

prepare_import.py vieta l’operativo e registra solo su copie. IMPORT_PREPARATION_VERIFICATION.json: 18 acquisizioni, 56 file e 19 attestazioni; 93 inserimenti al primo passaggio, zero al replay; tutte le righe pregresse preservate, solo tre tabelle additive cambiate, integrità ok, FK vuote. Backup SQLite e ripristino su copia confrontati con impronta completa. Operativo invariato, nessuna registrazione o variazione delle barre app. Prima della futura applicazione ripetere backup/ripristino e verifiche sullo stato operativo corrente.

Skill: bgg-material-acquisition efficace per enumerazione, esiti, originali/versioni/hash; parser storico usato solo come helper isolato, senza importare script con effetti. bgg-contest-navigation e PDF applicate nei rispettivi confini. Limiti risolti con confronti browser/formato reale, coerenti con prescrizioni esistenti; nessuna nuova regola contrattuale o manutenzione skill necessaria. Efficacia tecnica circoscritta a questo lotto, non prova universale sugli host.

Prossimo passo: autorizzazione finale alla registrazione dei 56 file e dei 19 esiti nell’operativo; successivo aggiornamento app/cruscotto. Nessun commit/push. Recupero Three Buccaneers e altre entry richiedono incrementi espliciti; nessun monitoraggio ordinario del contest concluso.

## Applicazione autorizzata e chiusura — 2026-10-14

L’utente risponde «OK» alla richiesta esplicita di registrazione Libreria/avanzamento. Ripetuti collaudo sul database corrente, backup e ripristino con impronte complete; applicati 18 record acquisitions, 56 acquired_files e 19 entry_work_observations, in transazione esclusiva. Integrità ok, FK vuote; operativo identico alla copia collaudata, righe pregresse preservate. OPERATIONAL_VERIFICATION.json registra backup, hash e autorizzazione. Replay operativo in sola lettura verifica i 56 record senza scritture. Il primo tentativo con ordine tabelle alfabetico ha provocato errore FK e rollback completo; corretto l’ordine acquisizioni→file→attestazioni, quindi riapplicato con nuovo backup verificato. Nessun dato parziale lasciato dall’errore.

App locale verificata nel browser: filtro contest Libreria 18 giochi/56 file, tutti presenti; riepilogo generale 254 file presenti/zero mancanti. Avanzamento 9-Card 2025 ACQ 17/93: denominatore dell’intero contest, non del lotto. Demo Dragons Horde parziale e Three Buccaneers bloccato mantengono esiti distinti. Server RO avviato per il controllo su 127.0.0.1:8765; rete socket sandbox limitata, nessuna configurazione modificata. Sezioni A/B rigenerate automaticamente; cruscotto qualitativo e registro aggiornati.

Ciclo classificati concluso: 19 esiti documentati, 18 giochi con file, 17 completi nel perimetro, una demo e un blocco. Nessuna promessa di completezza del contest o dell’intero WIP. Skill efficace per verifiche/hash/provenienza e applicazione collaudata; ordine dipendenze relazionali esplicito nel runner. Nessuna evoluzione contrattuale o schema/app.

Prossimo incremento utile, su richiesta: recupero mirato Three Buccaneers entro un perimetro esplicito, oppure selezione delle entry non classificate in incremento ACQ dello stesso contest. Nessuna acquisizione ulteriore o monitoraggio automatico. Incremento pronto per commit selettivo; messaggio proposto: Acquisisci materiali dei classificati 9-Card Nanogame 2025. Commit/push non eseguiti.

## Commit e push autorizzati — 2026-10-14

L’utente richiede «commit e push». Fetch origin eseguito: main e origin/main senza divergenze e nessun commit preesistente in uscita. Preparazione selettiva: solo TSK-0087, manifest, runner/verifiche e 19 celle del cruscotto ottenute dal confronto generato prima/dopo registrazione; altre modifiche locali preservate. Audit completo eseguito: 299 segnalazioni euristiche su 30 percorsi preesistenti, tutti identici a origin/main; non fanno parte del nuovo incremento. Audit dei 15 file selezionati: zero rilievi. Materiali, database, copie/backup, testo integrale e screenshot esclusi. Report dettagliati locali in outputs/nine-card-git-2026-10-14/. Questo controllo non certifica la liceità della storia pregressa, che resta nel riesame TSK-0066.

## Salvataggio e pubblicazione verificati — 2026-10-14

Commit dati 7de8de814c23f6fb893aa204cc681a2f27beec89 su main: 16 file, solo incremento TSK-0087. Push origin/main riuscito; ls-remote conferma lo stesso SHA su GitHub. Audit di tutti i commit in uscita: un commit, zero rilievi nuovi; 299 candidati storici su 30 percorsi già nel remoto, contenuti invariati dopo normalizzazione LF/CRLF. Indice senza errori whitespace; materiali/database/output esclusi. Modifiche degli altri task preservate nella working tree. La registrazione di questo esito costituisce un successivo commit documentale, senza attribuirgli anticipatamente un hash.
