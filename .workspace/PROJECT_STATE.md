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
