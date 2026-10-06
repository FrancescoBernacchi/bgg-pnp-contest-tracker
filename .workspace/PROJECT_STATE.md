---
standard_id: project-workspace-standard
status: initialized
initialized_with: 1.3.0
aligned_version: 1.5.0
initialized_at: 2026-09-04
last_alignment_at: 2026-09-20
---

# Stato del Project Workspace

## Sintesi dell'architettura

Archivio locale di giochi nato dalla raccolta Print and Play individuata su BoardGameGeek e in evoluzione deliberata verso un catalogo personale multifonte. Il PnP resta una forma di fruizione, mentre la direzione futura comprende scoperta, catalogazione, interesse personale, collezione, risorse ed esperienze di gioco. Il progetto separa applicazione (`app/`), persistenza operativa (`database/`), metadati versionabili (`catalog/`), materiali binari locali (`library/`), provenienza e calendario di monitoraggio (`sources/`), task auditabili (`tasks/`) e risultati rigenerabili (`outputs/`).

## Deviazioni locali dallo Standard

Nessuna deviazione iniziale. I materiali PnP e il database SQLite operativo sono intenzionalmente esclusi da Git; schema, migrazioni, manifest ed esportazioni testuali restano versionabili.

Il repository GitHub privato `FrancescoBernacchi/bgg-pnp-contest-tracker` conserva i contenuti versionabili sul branch `main`. Il remoto locale è `origin`; database operativo, output rigenerabili e materiali di terzi restano esclusi.

## Storico migrazioni

- 2026-10-06: TSK-0073 adotta PerGioco per un pilota dopo preanalisi TSK-0072 e richiesta di percorso passo passo. Scelta esplicita utente: includere subito giochi logici, insieme ad astratti/tradizionali e carta e matita. Sistema di regole distinto da schemi/soluzioni, ammissione individuale con regole complete gratuite; perimetro in sources/PERGIOCO-SCOPE.md. CAT distinto da importazioni, app e acquisizioni; database/schema/app invariati. Evoluzione consumer deliberata, PWS resta 1.5.0.

- 2026-10-05: TSK-0069 adotta localmente la verifica breve dell’efficacia delle skill al termine degli incrementi significativi, comprese nuove riprese storiche; nessun riesame retroattivo obbligatorio delle attività concluse. Protocollo in TASK_GOVERNANCE.md, manutenzione collegata a TSK-0048 e decisione esplicita per scope/contratti/architettura. Evoluzione di governance consumer, non migrazione PWS: aligned_version resta 1.5.0 e Standard invariato.

- 2026-10-04: adottato il protocollo locale `TASK_GOVERNANCE.md` con categorie, naming `YYYY-MM-DD - CODICE - descrizione`, ID stabili e registro centrale `tasks/REGISTRY.json`. Classificazione retroattiva datata dei 43 registri preesistenti e del task corrente; percorsi e storia originari preservati. Copiato senza modifiche in main il registro Wargame sospeso dalla worktree 52fb per conservarne la decisione, senza riattivare acquisizioni. PWS resta 1.5.0; nessuna modifica allo Standard o al contratto annuale BGG. Workflow immagini allora ancora da definire, successivamente deliberato in TSK-0065 il 2026-10-05.

- 2026-09-04: inizializzazione diretta con PWS 1.3.0; nessuna migrazione pregressa.
- 2026-09-04: formalizzato il protocollo di monitoraggio ricorrente e aggiunto `sources/MONITORING_CALENDAR.md`; modifica procedurale applicata al progetto corrente su richiesta esplicita dell'utente.
- 2026-09-05: introdotta la distinzione durevole fra contest PnP autonomi e contest adiacenti; Solomode è incluso come variante dipendente dal gioco base e resta predisposto a filtri o trattamenti futuri differenti.
- 2026-09-05: aggiunto un generatore di cruscotto Markdown basato sulle viste SQLite; l'output è rigenerabile e il processo non accede alle fonti esterne né ai materiali di gioco.
- 2026-09-05: esteso il modello con la cronologia delle fasi e predisposto il cruscotto al confronto automatico fra rilevamenti periodici, mantenendo escluse baseline e verifiche tecniche giornaliere.
- 2026-09-07: consolidata retroattivamente, su richiesta dell'utente, la conoscenza emersa nel task ricorrente: perimetro, profili adiacenti, contratto degli snapshot, calendario, dashboard differenziale e configurazione del repository privato. Nessun nuovo rilevamento BGG e nessuna modifica ai dati operativi.
- 2026-09-07: formalizzato il supporto proattivo dell'agente a un utente non esperto di Git, con spiegazioni contestuali e suggerimenti motivati su commit, branch, push, sincronizzazione e verifiche; aggiunto `GIT_GUIDE.md`.
- 2026-09-07: realizzata la prima interfaccia locale di consultazione con Python 3.12+ senza dipendenze, frontend statico e launcher PowerShell. Server su loopback e SQLite in sola lettura; ricerca/filtri, schede, calendario, statistiche e confronti conservativi fra osservazioni periodiche. Nessuna migrazione, modifica dei dati o acquisizione. Motore Markdown preesistente mantenuto separato. Decisioni e verifiche in `tasks/2026-09-07 - Applicazione locale contest BGG/TASK.md`.

- 2026-09-10: estesa la consultazione locale con vista Risultati, filtri e ordinamenti delle classifiche, schede collegate e sintesi per contest/categoria/fonte/data/ufficialità. Tutte le osservazioni mantenute, senza inferire punteggi o versioni operative. Stack e schema invariati; verifiche su dati sintetici e copertura del database reale in `tasks/2026-09-10 - Navigazione classifiche app/TASK.md`. Nessun rilevamento esterno o acquisizione.
- 2026-09-11: estesa la scheda entry con pagine BGG e risorse dichiarate navigabili, mantenendo funzione, forma di accesso, stato, provenienza e date. Apertura esterna esclusivamente su click; nessun controllo o download automatico. Gli stati di scansione incompleta o non osservabile restano espliciti. Stack e schema invariati; verifiche in `tasks/2026-09-11 - Navigazione risorse entry/TASK.md`.
- 2026-09-15: introdotto `PROJECT_PROGRESS.md` come cruscotto versionabile dell'avanzamento trasversale. Le viste annuali per tipologia e per tutte le entry sono rigenerate dal database con indicatori colorati; copertura, pipeline, attività aperte, acquisizioni e salute degli strumenti sono mantenute nello stesso incremento che cambia dati o stato. Database, calendario e task restano le fonti di dettaglio. Decisioni e verifiche in `tasks/2026-09-15 - Cruscotto avanzamento raccolta/TASK.md`.
- 2026-09-18: standardizzati cinque tipi di attività BGG con unità non sovrapponibili: censimento globale dei contest, censimento annuale delle entry, analisi materiali di un singolo contest, acquisizione materiali di un singolo contest e monitoraggio di un singolo contest. Le richieste e le proposte di prossime attività devono essere ricondotte esplicitamente a questi workflow; download e acquisizioni non possono attraversare più contest.
- 2026-09-20: adottate deliberatamente in ordine le migrazioni PWS 1.4.0 e 1.5.0, entrambe retroattive ove possibile. Integrati il controllo dinamico del titolo visibile, il criterio cumulativo di adeguatezza e la verifica della versione canonica a ogni nuovo task; `initialized_with` resta 1.3.0. Il task corrente era già stato rinominato coerentemente; nessun riesame massivo dei task storici è stato eseguito in questo incremento.
- 2026-09-20: deliberata la direzione evolutiva verso un catalogo personale multifonte di giochi, con Kanare_Abstract come prima nuova fonte e BGG come fonte specializzata. Simulatore interno e prototipazione 3D sono registrati come idee future trasversali da trattare in task separati; nessuna implementazione o migrazione dati è stata ancora eseguita.
- 2026-09-20: implementato il nucleo dati multifonte con migrazione additiva 009: fonti e record nativi distinti dai giochi canonici, matching esplicito, prodotti molti-a-molti, relazioni fra giochi, nomi qualificati, risorse, implementazioni online e crediti con provenienza e verifica. Nessun dato Kanare importato; compatibilità BGG preservata.
- 2026-09-20: applicata la migrazione 009 al database operativo dopo backup verificato e importato offline il censimento Kanare_Abstract: 64 giochi canonici conservativi, 58 record nativi, 39 prodotti e 56 relazioni prodotto–gioco, con matching ambigui mantenuti `candidate`. Nessuna destinazione esterna verificata e nessun materiale acquisito; dati BGG legacy e app preservati.
- 2026-10-02: estesa l'app locale al nucleo multifonte con vista comune Giochi, ricerca su titoli e alias, filtri per fonte e ambiguità, scheda canonica e prima vista Kanare_Abstract. Le viste operative BGG restano specializzate; identità, record nativi, prodotti, risorse e implementazioni non vengono fusi. Nessuna migrazione dati, richiesta esterna o acquisizione; decisioni e verifiche in `tasks/2026-10-02 - Interfaccia multifonte BGG e Kanare/TASK.md`.

- 2026-10-03: Libreria locale seguita da visualizzatore PDF autorizzato in task autonomo. Backend in sola lettura invariato; introdotto PDF.js 6.3.289 vendorizzato nel frontend e un accesso PDF per ID con token effimero, same-origin e handle confinato. L'eccezione al divieto di binari/anteprime HTTP riguarda soltanto PDF registrati; originali, schema e dati operativi non modificati. Requisito di estensione futura multiformato preservato.

- 2026-10-03: APP-005 implementa Libreria per gioco e lettori PNG/DOCX accanto al PDF. Migrazione 011 e comando offline ZIP separato dal server; due archivi esistenti estratti in 11 contenuti tracciati, 187 originali preservati e verificati, 198 file registrati totali e 46 acquisizioni. Nessuna nuova acquisizione remota. Contratto multiformato, limiti DOCX e ZIP documentati nel task dedicato.

Il 2026-10-04 l’utente delibera per TSK-0045 il task continuativo `BGG-A - Classifiche BGG 2025`: estensione annuale limitata a risultati e votazioni, con incrementi per contest, provenienza, confronto con baseline e distinzione fra completezza delle verifiche e percentuale di entry in classifica. Il censimento roster resta distinto; WIP, materiali, host esterni e download restano esclusi. Riprese su richiesta nella stessa chat, senza automazione. Le challenge prive di roster restano dipendenza esplicita. PWS resta 1.5.0. Contratto in `tasks/2026-10-04 - BGG-A - Classifiche BGG 2025/TASK.md`.

TSK-0046: estensione annuale circoscritta classifiche BGG 2024 confermata il 2026-10-04; risultati e confronto con roster esistente, senza WIP/materiali/download. Completezza del lavoro distinta dai piazzamenti; contratto e verifica nel task dedicato. Nessuna variazione della versione PWS 1.5.0.

- 2026-10-04: APP-008 e migrazione additiva 012 introducono attestazioni di lavoro con provenienza e metriche condivise `app/work_progress.py` per app/cruscotto. Formalizzate 464 verifiche classifiche TSK-0045 e 11 roster 2025 TSK-0005 con date originali preservate; nessuna nuova verifica esterna. Indicatore immagini 0% non implementato. PWS resta 1.5.0.

- 2026-10-04: incremento correttivo APP-008 riconcilia anche roster 2024/2026, risultati 2026 e manifest ACQ 2025. Verifiche parziali distinte; tabelle originarie preservate, nessuna nuova lettura esterna. Box annuali allineati in alto; audit e prove desktop/mobile in TSK-0047. Nessun cambiamento architetturale ulteriore o allineamento PWS.

- 2026-10-04: TSK-0048 riorganizza offline le competenze locali in base BGG condivisa e sei skill specialistiche, con procedura annuale entry separata, inventario e audit delle evidenze. Nessuna modifica ai contratti, al modello dati o all'app; PWS resta 1.5.0. Gestione GPR continuativa su richiesta senza automazione.

- 2026-10-05: TSK-0065 delibera workflow IMG autonomo BGG/Kanare, `sources/IMAGE_WORKFLOW.md`, registro sigle e skill `game-image-acquisition`. Libreria immagini per gioco con originali/estratti/ai/derivati, manifest fuori binari; tassonomia, naming, estrazioni, varianti, copertura e validazione AI utente. PWS resta 1.5.0. App/schema/acquisizioni non implementati; tecniche da collaudare, fonti future non generalizzate.

- 2026-10-06: TSK-0071 adotta e implementa Avanzamento multifonte con linguette BGG/Kanare e layout indipendenti. Attestazioni catalogo/ACQ storiche e manifest MAT Kanare alimentano app/source_progress.py in sola lettura; metriche 76/76, 62/64, 3/3 sul lotto e IMG senza perimetro. Nessuna migrazione SQLite, acquisizione o modifica PWS; aligned_version resta 1.5.0.
