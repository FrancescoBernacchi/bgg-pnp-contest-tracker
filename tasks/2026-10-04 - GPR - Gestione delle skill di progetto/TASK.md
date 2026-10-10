# Gestione delle skill di progetto

## Contratto e apertura — 2026-10-04

- ID: TSK-0048; categoria GPR; modalità continuativo; cadenza su_richiesta; nessuna automazione.
- Chat: 01a1071a-deb4-7e41-95b6-a65ad1c0654e; titolo conforme `2026-10-04 - GPR - Gestione delle skill di progetto`.
- Contenitore in corso: organizzare, mantenere e verificare le skill locali; proporre procedure nuove soltanto per bisogni ricorrenti documentati.
- Primo incremento: audit offline e riorganizzazione della skill BGG in base condivisa e sei skill specialistiche richieste. Procedura annuale entry identificabile senza accorpamento al censimento globale.
- Input: richiesta allegata dell'utente, AGENTS.md, TASK_GOVERNANCE.md, PROJECT.md, skill-creator, skill/playbook BGG, task e script storici pertinenti.
- Deliverable: skill, inventario, audit con provenienza e grado di evidenza, esempi di applicabilità, riferimenti autorevoli aggiornati.
- Successo: confini coerenti con contratti vigenti; nessuna conoscenza verificata persa; riferimenti risolti; frontmatter validi; casi locali distinguono assenza, mancata osservazione e parzialità.
- Esclusioni: nessun workflow esterno, importazione, download, modifica app/schema/database, automazione o operazione Git di scrittura. Cambiamenti ai contratti restano proposte EPR da deliberare separatamente.

PWS consumer e canonico 1.5.0; nessuna migrazione richiesta. Registro esaminato (47 task): nessun equivalente aperto. TSK-0044 coordina tutti i task, TSK-0048 gestisce le skill; incremento autonomo autorizzato. Main presenta modifiche pregresse, preservate; il riferimento locale origin/main non certifica lo stato del server. Preflight sandbox riuscito. Radice .agents esistente, proprietario NOTEBOOK-OMEN\Francesco1; nessuna sostituzione della radice o modifica ACL.

## Manutenzione continuativa

A ogni ripresa aggiornare inventario e verifiche; riconciliare sovrapposizioni, contraddizioni e lacune. Promuovere esperienze con evidenza, data e limiti; proporre nuove skill con casi reali, beneficio e confini. Registrare incrementi conclusi mantenendo aperto il contenitore.

### Raccordo deliberato in TSK-0069 — 2026-10-05

Per i nuovi incrementi vale il protocollo «Verifica dell’efficacia» in TASK_GOVERNANCE.md: attestazione nel task sorgente, riferimenti alle migliorie pertinenti in questo contenitore senza duplicare evidenze; inventario aggiornato quando cambia stato/copertura/manutenzione delle competenze, non a ogni uso. Nessun riesame retroattivo obbligatorio dei due incrementi conclusi. Manutenzione tecnica autonoma entro il contratto con skill-creator e salvaguardie .agents; scope, contratti e architettura richiedono decisione EPR esplicita. Questo raccordo documentale non esegue manutenzione di skill né chiude il contenitore.

Evidenze collegate, già trattate nell’audit e senza nuove voci duplicate: caricamento progressivo BGG verificato nel playbook; limite PyYAML del primo incremento; errore enum corretto in TSK-0030; generalizzazione preanalisi ancora da collaudare. TSK-0069 ne controlla soltanto la coerenza con il nuovo protocollo. Prossimo passo: applicarlo al prossimo incremento reale, collegando qui eventuali migliorie nuove.

## Primo incremento concluso — 2026-10-04

Create sei skill specialistiche e riorganizzata la base BGG condivisa; playbook conservato con correzione di un'intestazione duplicata. Le procedure MAT duplicate nella base sono rinviate alla specializzazione; copia antecedente in BASE_SKILL_BEFORE.md. Inventario operativo in sources/SKILL_INVENTORY.md; AUDIT.md distingue prove, inferenze, esperimenti e lacune; APPLICABILITY.md registra 13 casi locali. Il censimento annuale entry mantiene un riferimento dedicato nella base: nessuna settima specializzazione necessaria ora.

Aggiornati AGENTS.md, PROJECT.md, TASK_GOVERNANCE.md, PROJECT_STATE.md, sources/README.md, PROJECT_PROGRESS.md e registro. Percorsi storici e riferimenti alla base restano validi. Nessun contratto operativo o architettura modificati; nessuna proposta EPR adottata. Sezioni annuali A/B non rigenerate: dati operativi invariati.

Verifica riproducibile: verify_local.py, sette entrypoint e 24 collegamenti validi, ID registro univoci, modalità/cadenza/stato del contenitore corretti; esito in LOCAL_VERIFICATION.json. Il validatore quick_validate.py di skill-creator è stato tentato ma manca PyYAML nel runtime; verifica equivalente limitata agli scalari semplici realmente usati, non validazione YAML generale. Revisione manuale di 13 casi, senza subagenti o nuove operazioni esterne. Nessun collaudo runtime dei workflow, dichiarato nell'audit.

Prima chiusura dell'incremento controllati whitespace e stato Git. Main conserva modifiche di altre attività; nessun commit, branch, push o modifica ACL. Set-Content nella directory speciale .agents è stato negato: gli aggiornamenti dei file sono riusciti con apply_patch senza cambiare proprietario/ACL o radice. Sandbox ordinario rimasto operativo.

Stato contenitore: **in_corso**, continuativo, su richiesta, nessuna automazione. Primo incremento **concluso**. Prossime manutenzioni: promuovere nuovi pattern dopo esperienza verificata, collaudare preanalisi su una fonte scelta diversa da Kanare, riesaminare autonomia della procedura roster soltanto se cresce. Tassonomia materiali e contratto IMG restano attività separate.

È opportuno un commit dedicato alle skill e alla governance dopo revisione, isolando modifiche di altre chat. Messaggio proposto: `Organizza le skill locali e avvia la gestione continuativa`. Nessuna azione Git eseguita senza autorizzazione.

## Secondo incremento — 2026-10-04

Richiesta dell'utente: rendere sistematica l'applicazione delle skill pertinenti e poi eseguire commit/push. Autorizzazione Git esplicita per le modifiche di TSK-0048, comprese creazione e riorganizzazione del primo incremento. Nessun nuovo task duplicato; PWS ancora 1.5.0. Uso di skill-creator già acquisito nel primo incremento.

Aggiornati punti di ingresso AGENTS.md, PROJECT.md, TASK_GOVERNANCE.md, README.md, sources/README.md, catalog/README.md e inventario: lettura/applicazione prima di ogni attività coperta, anche nelle riprese senza invocazione esplicita; selezione per obiettivo, confini APP/DAT locali, registrazione nel task. I task storici conservano storia e contratti; la nuova regola si applica alle riprese senza riscritture massive. Il catalogo skill della sessione ora espone tutti i sette entrypoint.

Commit/push autorizzati dall'utente. Si escludono modifiche autonome del monitoraggio e classificazione task; nel registro si salva solo TSK-0048, preservando nella working tree gli aggiornamenti preesistenti degli altri record/chat. Nessun materiale, database o output rigenerabile incluso.

Verifiche del secondo incremento: verify_local.py senza errori (7 skill, 24 riferimenti), git diff --cached --check valido; indice selettivo di 25 file, senza dati/materiali di terzi. Remoto main verificato prima del commit e coincidente con HEAD 50e2e1f. L'accesso ordinario al Git index e alla rete è limitato dal sandbox; operazioni Git autorizzate eseguite fuori sandbox senza interventi ACL. Contenitore GPR ancora aperto; secondo incremento documentale concluso, pubblicazione in corso.

## Esito Git — 2026-10-04

Commit principale `d8ad1c7990383261aa2e135fe46e689929251655` su main: 25 file, skill e integrazione documentale. Push origin/main riuscito; refs/heads/main verificato sul server e coincidente con HEAD. Modifiche pregresse di classificazione/naming chat preservate e non incluse. Nessun file operativo, materiale di terzi o output incluso. Il presente esito viene salvato nel commit documentale finale; TSK-0048 resta in corso, su richiesta senza automazione.

## Manutenzione IMG dal pilota TSK-0068 — 2026-10-05

Richiesta esplicita utente nella chat IMG: aggiornare le skill prima dei prossimi lotti. Ripresa di questo contenitore continuativo, nessun task duplicato o nuovo scope. PWS locale/canonico 1.5.0; preflight sandbox riuscito. Proprietario .agents NOTEBOOK-OMEN\Francesco1 verificato; modificati soltanto tre file interni esistenti con apply_patch, radice/ACL preservate. Skill-creator applicata.

Promossi dai risultati verificati di TSK-0068 incremento 4: setup prima della delimitazione delle sagome, celle vuote/testo raster, identità per oggetto+scala+bordi limitata al caso, dorso comune distinto dall'abbinamento fisico; rettifica versionata con file storico; riproduzioni inferiori come occorrenze; Downloads Original realmente esposto da BGG, provenienze multiple con unico file, galleria login distinta dalla sequenza pubblica osservata; limiti live Docs/ACQ, draft/Contest Ready e ruoli crediti distinti. Precisata la valutazione per uso locale concreto: assenza di licenza aperta non prova un divieto, autorizzazione utente/cache non diventano licenze dei titolari. Nessun nuovo permesso, contratto o modifica PUBLICATION_POLICY/IMAGE_WORKFLOW.

Aggiornati game-image-acquisition/SKILL.md e references/{sources,extraction}.md; inventario allineato alla maturità del pilota. Base bgg-contest-navigation già instrada correttamente IMG: nessun cambiamento necessario, pattern specialistici nel riferimento IMG senza duplicazione. Geometrie/DPI/esiti del pilota non diventano algoritmi universali. Nessun helper monogioco trasferito alla skill.

Validazione standard quick_validate.py tentata: PyYAML assente, stessa limitazione già nota; nessuna installazione. Audit locale esistente rieseguito con data/output dedicati: 8 skill, 30 riferimenti e frontmatter semplici verificati, nessun errore; report IMG_PILOT_SKILL_VERIFICATION_2026-10-05.json. Non validazione YAML generale né nuovo rilevamento dei siti. Whitespace verificato. Revisione rispetto alle prove del pilota e ai confini del workflow; piccoli aggiornamenti documentali, nessuna delegazione o acquisizione ulteriore.

Efficacia: le istruzioni ora distinguono i due errori osservati (assunzione funzione dal solo aspetto e blocco generale per assenza licenza) dalle limitazioni reali di accesso/materiali. Prossima verifica nei giochi successivi: confermare applicabilità render/crop/deduplicazione senza trasferire geometrie. Contenitore in_corso; incremento concluso. Nessun commit/push, app/schema/database o metrica implementata modificati.


Nota collaudo: prima esecuzione dell'audit ha segnalato falsamente il link esistente TASK_GOVERNANCE.md con ancora, perché il verificatore dell'inventario trattava il frammento come parte del nome file. Corretto il verificatore a rimuovere il frammento, come già faceva per i riferimenti delle skill; riesecuzione: 8 skill, 30 riferimenti, zero errori. Report aggiornato, nessuna modifica al link o al contratto.

## Ulteriore evidenza IMG — secondo pilota, 2026-10-05

TSK-0068 incremento 5 ICBRG conferma i pattern promossi: leggere assemblaggio prima del crop, render per diagrammi compositi, deduplicazione per hash con molteplici ID BGG. Caso nuovo: standee intero con regioni facce/base, due varianti grigie di scala non fuse, galleria autore lunga non attestata completa da carousel parziale. Le istruzioni già prevedono controllo geometria/contenuti e limiti di copertura: nessuna modifica skill necessaria. Prove/cause/residui nel TASK.md IMG, non duplicati in un nuovo audit; ulteriori generalizzazioni da verificare su altri documenti.

## Skill MAT Kanare — 2026-10-06

TSK-0070, autorizzazione esplicita: creata kanare-material-census usando skill-creator, radice .agents preesistente e proprietario NOTEBOOK-OMEN\Francesco1 verificati; nessuna modifica di radice/ACL. v1 prima del pilota 2 giochi, v2 dopo riesame, v3 dopo secondo pilota 5 ulteriori; applicata al restante perimetro senza revisioni automatiche. Evidenze, efficacia, revisioni e limiti in TSK-0070/PILOTS.md e TASK.md, risultati soltanto nel MAT. Inventario e routing aggiornati; nessuna estensione BGG, nuova acquisizione o modello architetturale implicito. Audit statico 9 skill/31 riferimenti/zero errori in KANARE_SKILL_VERIFICATION_2026-10-06.json; validatore standard limitato da PyYAML assente. Incremento manutenzione concluso, TSK-0048 resta continuativo in_corso; prossimo riesame solo con una novità procedurale dimostrata o perimetro deliberato diverso.

## Evidenza source-preanalysis — PerGioco, 2026-10-06

TSK-0072 applica la procedura a un secondo contesto editoriale: 25 pagine/destinazioni, sette schede principali, URL storici con rinvii, regole pubbliche/base-variante e soluzioni con login, mapping sul nucleo multifonte. Relazione ed efficacia nel task sorgente. Inventario aggiornato; nessuna manutenzione della skill o promozione universale del comportamento PerGioco. Le condizioni dichiarate e i limiti dello strumento web sono gestibili con le istruzioni esistenti. Contenitore TSK-0048 ancora aperto, nessuna acquisizione o adozione.

## Evidenza CAT PerGioco — 2026-10-06, TSK-0074

Il pilota CAT applica il contratto adottato, senza estendere source-preanalysis: nessuna skill CAT multifonte dedicata nell’inventario. Efficacia CUA browser e limiti di routing registrati nel TASK.md di TSK-0074. Eventuale procedura CAT da valutare dopo altri casi; proposta non adottata né collaudata in generale. Nessuna manutenzione skill/inventario eseguita, contenitore TSK-0048 resta aperto.

### Manutenzione IMG — TSK-0068, 2026-10-11

Due giochi aggiuntivi: prove e rettifiche nel TASK.md sorgente. Promossi nei riferimenti IMG soltanto i pattern verificati PDF multi-foglio/quantità stampa, controllo ID pagina-download BGG e confronto foto autore hi-res con revisione. Owner .agents utente Windows verificato, root invariata, skill-creator applicata. Nessuna geometria universale, nessuna modifica contratti o DB. Verifiche statiche e limiti nel sorgente; TSK-0048 resta continuativo.
