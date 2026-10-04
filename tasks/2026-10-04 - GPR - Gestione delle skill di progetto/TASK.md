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
