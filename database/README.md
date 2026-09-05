# Database

`schema.sql` definisce il modello relazionale iniziale. Il file operativo previsto è `pnp_collection.sqlite3`, escluso da Git. Ogni modifica successiva allo schema deve essere introdotta tramite una migrazione numerata in `migrations/`.

La migrazione `001_contest_monitoring.sql` introduce serie ed edizioni dei contest, fonti, fasi e scadenze, controlli periodici, cronologia degli stati, metriche osservate e cronologia leggera dello stato delle entry. Le tabelle storiche sono append-only: i nuovi rilevamenti non sostituiscono quelli precedenti.

La migrazione `002_contest_scope_and_entry_dependencies.sql` distingue contest PnP principali e contest adiacenti, assegna un profilo di trattamento e identifica le entry che dipendono da un gioco base. I profili iniziali sono `standard`, `format_adjacent`, `selective_entries` e `dependent_variants`.

La migrazione `003_monitoring_views.sql` aggiunge le viste operative `v_contests_monitoring_all`, `v_contests_pnp_core`, `v_contests_adjacent`, `v_entries_standalone` e `v_entries_dependent_variants`. La vista generale calcola conteggi delle entry e la prossima fase con scadenza non trascorsa al momento della query.

La migrazione `004_monitoring_view_schedule.sql` espone anche `starts_at` nella vista generale, così i report possono ordinare le edizioni recenti senza dipendere direttamente dalla struttura delle tabelle.

La migrazione `005_contest_phase_history.sql` introduce gli snapshot storici delle fasi e delle scadenze. La migrazione registra come baseline i valori correnti; i controlli successivi devono collegare i nuovi snapshot al relativo `contest_checks.id`.

Gli stati normalizzati iniziali previsti sono `unknown`, `wip`, `playtest_ready`, `components_ready`, `contest_ready`, `contest_complete`, `withdrawn` e `unavailable`. Il valore originale e la relativa evidenza devono sempre essere conservati.

Per i contest si usano inizialmente `announced`, `entries_open`, `development`, `freeze`, `voting`, `awaiting_results`, `complete`, `suspended`, `cancelled` e `unknown`. Per le entry si usano `idea`, `wip`, `components_available`, `playtest_ready`, `contest_ready`, `withdrawn`, `incomplete`, `disqualified` e `unknown`. Il testo originale della fonte resta sempre separato dal valore normalizzato.
