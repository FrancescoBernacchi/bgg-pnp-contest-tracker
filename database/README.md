# Database

`schema.sql` definisce il modello relazionale iniziale. Il file operativo previsto è `pnp_collection.sqlite3`, escluso da Git. Ogni modifica successiva allo schema deve essere introdotta tramite una migrazione numerata in `migrations/`.

La migrazione `001_contest_monitoring.sql` introduce serie ed edizioni dei contest, fonti, fasi e scadenze, controlli periodici, cronologia degli stati, metriche osservate e cronologia leggera dello stato delle entry. Le tabelle storiche sono append-only: i nuovi rilevamenti non sostituiscono quelli precedenti.

La migrazione `002_contest_scope_and_entry_dependencies.sql` distingue contest PnP principali e contest adiacenti, assegna un profilo di trattamento e identifica le entry che dipendono da un gioco base. I profili iniziali sono `standard`, `format_adjacent`, `selective_entries` e `dependent_variants`.

La migrazione `003_monitoring_views.sql` aggiunge le viste operative `v_contests_monitoring_all`, `v_contests_pnp_core`, `v_contests_adjacent`, `v_entries_standalone` e `v_entries_dependent_variants`. La vista generale calcola conteggi delle entry e la prossima fase con scadenza non trascorsa al momento della query.

La migrazione `004_monitoring_view_schedule.sql` espone anche `starts_at` nella vista generale, così i report possono ordinare le edizioni recenti senza dipendere direttamente dalla struttura delle tabelle.

La migrazione `005_contest_phase_history.sql` introduce gli snapshot storici delle fasi e delle scadenze. La migrazione registra come baseline i valori correnti; i controlli successivi devono collegare i nuovi snapshot al relativo `contest_checks.id`.

La migrazione `006_entry_resource_provenance.sql` distingue la scansione del WIP, la menzione di una risorsa nella specifica entry e la successiva verifica della risorsa. `remote_resources.kind` conserva la funzione attribuita dal contesto e `remote_resources.access_type` la forma tecnica. I valori usati durante l’esplorazione annuale sono provvisori: categorie ed enumerazioni saranno consolidate soltanto dopo il confronto di tutti i contest 2025. URL identici rappresentano una risorsa unica, mentre descrizioni e contesto della specifica entry restano nelle menzioni.

La migrazione `007_entry_declared_materials.sql` separa le scansioni dei requisiti materiali dai singoli materiali dichiarati. Conserva la copertura (`first_post_only` o `rules_integrated`), gli esiti negativi o non osservabili e, per ogni requisito, testo originale, normalizzazione provvisoria, quantità, obbligatorietà, modalità di approvvigionamento, contesto e fonte. Una scansione limitata al primo post resta integrabile dalle regole e non certifica l'inventario completo del gioco.

La migrazione `008_24h_challenges_adjacent.sql` riallinea le challenge da 24 ore al perimetro `adjacent` senza alterare roster o storico.

La migrazione `009_multisource_catalog.sql` aggiunge il nucleo generale del catalogo multifonte senza modificare le tabelle o le viste BGG esistenti. `catalog_sources` identifica una fonte; `source_records` conserva il record nativo osservato e non coincide con il gioco canonico. `game_source_records` e `product_source_records` rendono esplicita la riconciliazione e accettano `candidate`, `confirmed` o `rejected`, così una corrispondenza ambigua non produce una fusione automatica.

`products` e `product_games` modellano confezioni, raccolte e set con relazione molti-a-molti ai giochi. `game_relationships` rappresenta varianti, derivazioni e dipendenze tipizzate. `catalog_resources` e `resource_links` gestiscono regole, immagini e altre risorse attribuendole a un gioco, prodotto o record nativo; le precedenti `remote_resources` restano il contratto legacy delle entry BGG. `online_platforms` e `game_implementations` separano le implementazioni digitali dai giochi. `person_names` e `credit_assertions` aggiungono alias e crediti provenienti da più fonti senza sostituire i crediti BGG già presenti.

Stato di verifica e provenienza sono registrati sul dato o sulla relazione pertinente. I valori ammessi per la verifica sono `not_checked`, `declared`, `verified`, `rejected` e `uncertain`; una dichiarazione della fonte non equivale a verifica della destinazione esterna. `game_names` mantiene tutte le colonne precedenti e aggiunge tipo, lingua, scrittura, ufficialità, record di origine e verifica.

La prova riproducibile `database/test_multisource_migration.py` applica la migrazione a un database legacy temporaneo, verifica la preservazione delle righe preesistenti, inserisce fixture sintetiche per le cardinalità principali ed esegue `foreign_key_check` e `integrity_check`.

L'importazione offline del censimento Kanare_Abstract del 2026-09-20 è definita in `catalog/import_kanare_abstract.py`. Lo script richiede la migrazione 009, opera in una transazione atomica e rifiuta una seconda esecuzione quando la fonte è già presente. `catalog/verify_kanare_abstract_import.py` riconcilia 38 titoli dell'indice, 39 prodotti e 64 candidati complessivi; controlla cardinalità, matching `candidate`, conteggi BGG legacy, chiavi esterne e integrità. Entrambi gli script sono esclusivamente locali e non effettuano richieste di rete.

Il completamento del censimento è applicato da `catalog/enrich_kanare_abstract.py`: limita le richieste HTML ai due host ufficiali Kanare in allowlist, non apre PDF, immagini o destinazioni esterne e aggiorna idempotentemente i record esistenti. Il rilevamento del 2026-09-20 porta il catalogo Kanare a 76 record nativi, 39 prodotti con scheda puntuale, 141 risorse URL, 162 legami di provenienza e 54 implementazioni attribuite a 9 piattaforme dichiarate.

## Contratto dei rilevamenti differenziali

Un controllo periodico confrontabile deve:

1. creare un record in `contest_checks` con un `check_kind` contenente `monitor`, `scheduled`, `deadline` o `follow_up`;
2. collegare tramite `check_id` lo stato osservato e gli snapshot completi di entry, metriche e fasi disponibili;
3. registrare anche `no_change` quando il controllo era dovuto;
4. non usare l'assenza da un insieme parziale come prova di rimozione;
5. preservare tutti i valori precedenti nelle tabelle storiche.

I controlli con finalità di `baseline`, `census` o `consistency` possono arricchire il database, ma non costituiscono da soli una nuova finestra periodica. Il database SQLite operativo è locale e non viene pubblicato su GitHub.

Gli stati normalizzati iniziali previsti sono `unknown`, `wip`, `playtest_ready`, `components_ready`, `contest_ready`, `contest_complete`, `withdrawn` e `unavailable`. Il valore originale e la relativa evidenza devono sempre essere conservati.

Per i contest si usano inizialmente `announced`, `entries_open`, `development`, `freeze`, `voting`, `awaiting_results`, `complete`, `suspended`, `cancelled` e `unknown`. Per le entry si usano `idea`, `wip`, `components_available`, `playtest_ready`, `contest_ready`, `withdrawn`, `incomplete`, `disqualified` e `unknown`. Il testo originale della fonte resta sempre separato dal valore normalizzato.
