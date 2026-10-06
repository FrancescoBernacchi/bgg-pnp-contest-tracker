# Modello logico B-v1 e dizionario — proposta

Stato corrente: contratto logico B-v1 adottato il 2026-10-06 mediante [DECISIONE.md](DECISIONE.md). Il riferimento alla proposta nel testo sottostante documenta la fase di preparazione. Nessuna migrazione o modifica dello schema operativo effettuata.

TSK-0076, 2026-10-06. Nomi logici non eseguibili; nessuna migrazione creata. Riferimento vigente: schema e migrazioni 001–012, in particolare 009. Il DDL operativo rilevato in MODELLO_CORRENTE di TSK-0075 distingue la base iniziale dalle evoluzioni: non applicare schema.sql sopra un database esistente.

## Responsabilità e cardinalità

```text
catalog_sources 1 ─ N source_records 1 ─ N source_record_observations
source_records N ─ M games                [game_source_records; decisioni storiche separate]
source_record_observations 1 ─ N esiti / classificazioni / URL / menzioni / crediti / relazioni
source_resource_mentions N ─ 0..1 catalog_resources [destinazione URL esatta condivisibile]
source_resource_mentions 1 ─ N access_observations N ─ M condition_observations
source_records 1 ─ N problem_instances N ─ M source_resource_mentions [prove di occorrenza]
source_relation_assertions N ─ 0..1 source_records [destinazione risolta oppure testo/URL]
source_classification_observations 1 ─ N segmenti ordinati
source_classification_observations N ─ M mapping comuni esplicitamente deliberati
```

Il record è l'identità locale della scheda fonte, il gioco è il sistema di regole canonico, l'osservazione è un evento informativo, la menzione è una dichiarazione nel contesto, la destinazione è un URL. Nessuno di questi identifica automaticamente gli altri. Una scheda può descrivere più giochi/confezioni: mantenere l'M:N corrente, senza imporre globalmente un solo game confermato per record. Nel pilota i soli otto record approvati hanno ciascuno un game nuovo; Abande un candidato.

## Convenzioni comuni a tutte le nuove osservazioni

| Campo | Tipo e vincolo | Responsabilità |
|---|---|---|
| id | Intero PK locale immutabile | Join; non identità esterna |
| stable_key | Testo non vuoto UNIQUE | Chiave logica durevole della riga/evento, indipendente da titolo e ID numerico |
| record_observation_id | FK obbligatoria per fatti contestuali | Ancora allo snapshot, fonte derivata dal record; impedire figli di un altro record |
| source_url | Testo URL obbligatorio per osservazioni di fonte | Pagina della prova, distinta da URL della risorsa; nessuna rete implicita |
| observed_at | Data ISO o timestamp con offset, nullable solo con unknown_reason | Momento originario della raccolta, non importazione |
| formalized_at | Timestamp obbligatorio | Trasformazione/registrazione, distinto dalla visita |
| evidence_path, evidence_pointer | Testi obbligatori | Artefatto locale e JSON Pointer/locatore; nessun dump integrale versionato |
| provenance_kind | observed / reused / later_formalization | Provenienza esplicita, non livello di correttezza |
| raw_value, assessment_note | JSON/testo a seconda della tabella | Valore dichiarato e sintesi originale; non ricostruire regolamenti |
| supersedes_id | FK stessa entità nullable | Rettifica esplicita; niente UPDATE/DELETE di evidenza |
| payload_sha256, mapping_version | Hash e versione obbligatori per snapshot/proiezione | Riproducibilità, non prova di identità del gioco |

I figli possono ereditare URL/data/provenienza dallo snapshot soltanto quando coincidono davvero; un credito FAQ o categoria indice ha propri URL/data, non quelli della scheda. Ogni riga espone questi valori nella vista di lettura. Unknown_reason è obbligatorio quando manca un dato materialmente necessario. Date originali/testi raw preservati; precisione day/timestamp/year/unknown esplicita, nessuna mezzanotte inventata come osservazione precisa. Data di aggiornamento pagina e anno del gioco non sono observed_at.

Append-only: il futuro DAT deve impedire UPDATE/DELETE sulle tabelle di osservazione e sulle loro righe figlie (trigger di protezione e percorso di scrittura verificato); FK RESTRICT, niente cascade distruttivo. Correzioni come nuove righe, stesso evento originario se formalizzazione, con supersedes e motivo. Non fare dipendere la storia da un JSON mutabile in source_records.

## Entità e dizionario dei campi specifici

Oltre ai campi comuni, ogni tabella ha i campi qui elencati. NOT NULL per chiavi/FK di proprietario, tipi tecnici e valori di esito; gli attributi dichiarati restano nullable con motivo. I suffissi raw/normalized separano testo e interpretazione.

| Entità logica | Campi specifici e vincoli | Uso e cardinalità |
|---|---|---|
| source_record_keys | source_id FK, record_id FK, local_key UNIQUE per fonte, key_kind, assigned_at, task_id | 1 record : N chiavi locali/legacy; PGP è chiave locale, native_id resta NULL. Una chiave non cambia proprietario |
| source_record_observations | record_id FK, event_key, payload_json valido, schema_version, title_raw, display_title_qualified, year_raw/year_value/precision, page_updated_raw, development_status_raw/normalized opzionali, coverage_kind, coverage_state, parent_observation_id opzionale | Record 1:N snapshot anche parziali; esatto evento+hash+mapper unico. baseline contiene il record CAT completo |
| source_admission_observations | record_observation_id, policy_ref/version, requirement_key, outcome_raw, outcome_normalized, completeness_raw, assessment_kind, evidence_mentions[] tramite join | Valutazione 1:N requisiti/prove; admitted / requirement_not_demonstrated / not_observable / unknown. Completeness di regole non significa esaustività catalogo |
| admission_evidence_mentions | admission_id FK, mention_id FK, evidence_role, stable_key | N:M; Abande Libre usa due menzioni per percorso base+variante; stesso record valutato, eventuale prova base referenziata esplicitamente |
| source_classification_observations | label_raw obbligatoria, kind_raw, path_state, segment_raw nullable, index_title_raw nullable, exhaustiveness_raw | Snapshot 1:N appartenenze. path_state observed / not_declared / not_observable; path NULL non diventa array vuoto |
| source_classification_segments | classification_id FK, position intero >=0, label_raw non vuota, UNIQUE(classification_id,position) | 0:N segmenti contigui, ricostruzione esatta del path. segment_raw di indice non inserito nel path senza prova |
| common_classification_mappings | classification_id FK, common_concept_key, decision_ref, decision_status, decided_at, rationale, supersedes_id | N:M, vuota nel pilota. Nessuna categoria inferita; vocabolario comune e decisioni richiedono evoluzione separata |
| source_record_url_observations | record_id coerente con snapshot, url_raw, url_role historical/requested/final/declared, request_event_key nullable, predecessor_url_observation_id nullable, redirect_position nullable, destination_kind content/login/unknown, technical_status_raw nullable | 1:N storico; URL non UNIQUE globalmente qui. Raggruppa solo passaggi effettivamente attestati, non inventa catene da URL storici |
| source_resource_mentions | record_id FK, mention_key UNIQUE per record, first_observation_id, function_raw, label_raw nullable | Identità della menzione contestuale 1 record:N. Non è una risorsa fisica e non richiede URL |
| source_resource_mention_observations | mention_id FK, record_observation_id, declared_url nullable, resource_id FK nullable, function_raw, technical_form_raw, language_raw nullable, declaration_state, context_summary, destination_status_raw | Storia append-only 1 menzione:N; resource_id NULL obbligatorio se URL assente, niente placeholder. URL attestato risolve catalog_resources per uguaglianza esatta |
| resource_url_observations | mention_observation_id FK, requested_url obbligatoria, final_url nullable, destination_kind, redirect_chain_json nullable, technical_status_raw, scope_checked | Accesso tecnico osservato, distinto da identità URL e condizioni. Catena nullable se solo endpoint attestati; niente redirect intermedi inventati |
| condition_observations | source_id FK, condition_key, scope_raw, scope_kind, condition_url, summary_original, page_updated_raw, license_identifier nullable, permission_state, registration_declared_free nullable, newsletter_declared_free nullable | Fonte 1:N versioni condizioni; URL/data propri. permission_state unknown / declared / attested; dichiarazione non permesso verificato |
| resource_access_observations | mention_observation_id FK, subject_scope public_content/complete_rules/components_product/online_implementation, access_raw, access_normalized, content_observed bool nullable, completeness_raw/normalized, cost_raw, cost_status unknown/free_declared/free_observed/paid_declared/paid_observed, amount nullable, currency nullable, access_condition_raw nullable, playtested bool nullable | 1 menzione:N osservazioni per ambito. Non trasferire gratuità dalla pagina al PDF o prodotto; assenza di osservazione è ignota |
| access_condition_links | access_observation_id FK, condition_observation_id FK, applicability_status declared/attested/uncertain, evidence_pointer | N:M; condizioni generali riusate non diventano verifica puntuale del file |
| problem_instances | record_id FK, instance_key UNIQUE per record, instance_kind, native_instance_id nullable, created_at | Identità locale del problema, non game. Chiave assegnata documentata; data non UNIQUE globalmente |
| problem_instance_observations | instance_id FK, record_observation_id, date_raw, published_at nullable, date_precision, label_raw nullable, context_locator | 1 istanza:N versioni; Itinera date dichiarate e titoli non inventati |
| instance_mention_assertions | instance_observation_id FK, mention_observation_id FK, role appears_in/solution_for, assertion_status, evidence_pointer | N:M; appears_in due volte per pagina diagrammi, solution_for zero senza prova. Stessa pagina non implica relazione soluzione |
| source_credit_observations | name_raw nullable, role_raw, status_raw, subject_context_raw, subject_record_id FK nullable, subject_label_raw nullable, party_kind person/organization/unknown, resolved_person_id FK nullable, resolution_decision_ref nullable | 1 snapshot:N crediti e lacune. name_raw NULL richiede stato not_declared/not_registered/unnamed, role obbligatorio. Editori non diventano people; nomi ambigui non fusi |
| source_relation_assertions | from_record_id FK, to_record_id FK nullable, target_label_raw/target_url nullable, relation_type_raw/normalized, assertion_status, information_requirement unknown/none/optional/required, ownership_requirement stesso enum, purchase_requirement stesso enum | Snapshot 1:N relazioni; almeno destinazione record/testo/URL. from != to quando entrambi risolti; variante distinta dalla necessità di leggere/possedere/acquistare |
| source_identity_decisions | record_id FK, game_id FK nullable, decision_kind create_new/match, status proposed/candidate/confirmed/rejected, decided_at nullable, decision_ref obbligatoria, rationale, previous_decision_id nullable | Storia decisionale indipendente dalle osservazioni; proposed non è confirmed. game_source_records resta proiezione corrente N:M |
| canonical_projection_events | identity_decision_id FK, assertion_id opzionale FK tipizzata per relazione/credito/nome, target_kind, target_key, projected_at, decision_ref, mapping_version | Provenienza delle promozioni canoniche, 0:N; vietata promozione da matching candidato. Non duplica la verità corrente |

Le join con array nel diagramma sono relazionali, non liste di ID senza FK. I riferimenti tipizzati della proiezione devono essere FK dedicate con XOR del tipo (esattamente una asserzione quando necessaria), non entity_id polimorfo senza integrità. Il DAT può separare fisicamente i ledger per tipo, mantenendo il contratto. Anche la relazione soluzione deve riferirsi a una menzione di funzione solutions e a un'istanza dello stesso sistema o documentare esplicitamente un caso trasversale.

Per record CAT senza osservazione di sviluppo, i campi development restano unknown/NULL; admitted non entra in status_normalized. Gli esiti di lavoro/censimento usano coverage_state complete/partial/blocked/unknown e coverage_kind esplicito; dodici schede complete nel CAT non certificano un intero sito. Ulteriori outcome originali restano raw con normalizzazione unknown fino a mapping deliberato.

## Riutilizzo del nucleo e aggiunte indispensabili

| Già rappresentabile | Limite corrente | B proposta |
|---|---|---|
| catalog_sources, source_records, games, game_source_records | Record URL NOT NULL/unico per fonte; stato corrente del matching | Chiavi stabili sidecar, osservazioni e decisioni append-only; nessuna modifica distruttiva dei record |
| game_names e people/person_names | Alias richiede game; persona richiede risoluzione | Alias/anno originari nel payload snapshot; nomi canonici proiettati dopo decisione. Crediti irrisolti strutturati separatamente |
| credit_assertions | person_id obbligatorio, ruoli organizzazione e lacune non rappresentabili senza forzature | Osservazioni credito primarie per prove; credit_assertions solo proiezione risolta con decisione |
| catalog_resources, resource_links | URL obbligatorio/unico; metadati globali possono mescolare contesti, UNIQUE con NULL debole | Stessa destinazione URL riusata, menzioni/versioni e accessi contestuali; resource_links compatibilità, non prova primaria |
| products/product_games, online_platforms/game_implementations | Richiedono entità risolte; non attestano costo o possesso | Nessuna creazione nel pilota; menzioni e ambiti accesso conservano dichiarazioni senza canonicalizzare |
| game_relationships | Due game_id obbligatori; un solo dependency_requirement | Asserzioni tra record prima di matching, tre necessità distinte. Projection variant_of solo dopo decisione; non forzare dipendenza informativa nel requisito fisico |
| acquired_files + 010, archive_contents + 011 | Condizioni/file e derivati acquisiti; non osservazioni di consultazione o problemi | Nessun riuso improprio; nessun file nuovo |
| 006/007/012 BGG | Proprietari entry/contest e perimetri specifici | Preservare; nessuna entry artificiale PerGioco o Kanare |

catalog_resources.url resta l'ancora tecnica esatta, non una promessa di identità del contenuto. Il login finale non la sostituisce. Se più URL conducono allo stesso contenuto, conservarli distinti finché non esiste una decisione di equivalenza; la semplice uguaglianza di final_url non basta. source_record_id presente sulla destinazione legacy resta provenienza iniziale, non esclusività: le menzioni N:M attribuiscono contesti ulteriori. Non overwriting lingua/funzione/accesso globali da un contesto successivo.

## Chiavi, NULL, collisioni e storia

PGP-001…012 sono ID locali di campione: source_record_keys usa `pergioco:pilot:PGP-xxx`, native_id NULL. Record ID immutabile, canonical_url corrente è solo ancora compatibile; nuovi URL sono osservazioni, non nuovi record automatici. Gli URL storici non sono alias unici: uno stesso URL può essere stato riutilizzato nel tempo. Collisione con ancora corrente di altro record richiede riconciliazione esplicita e arresta quel lotto; nessuna fusione per title/year/designer. Preservare maiuscole/query/frammenti raw; normalizzare soltanto per ricerca conservativa, senza trattare URL normalizzati come identità.

Menzione locale da registro persistente (chiavi resource:1 ecc. ereditate DAT): ordinalità di array non ricalcolata come identità se cambia ordine. Nuova menzione ambigua si ferma per assegnazione; non decide il titolo. Itinera usa due chiavi locali datate del DAT, ma due problemi futuri nella stessa data richiederebbero un nuovo discriminante locale attestato e locatore, senza titoli inventati. Crediti e classificazioni sono keyed come fatti contestuali con fingerprint e occorrenze: due prove identiche in URL diversi non si cancellano.

Unicità osservazione su record/event_key/payload_hash/mapping_version; event_key proviene dal registro di raccolta, per la baseline è il manifest+pointer originario, e non dal momento del replay. Contenuto identico osservato in un'altra visita ha nuovo evento e resta nuova osservazione; importazione identica dello stesso evento ha zero delta. Payload diverso per stesso evento richiede rettifica/motivo e supersedes, non silenziosa sostituzione. Catene supersedes acicliche, stesso proprietario; verificare in transazione. NULL distinto da false/zero/stringa vuota/array vuoto: non attestato non significa gratuito, assente o non richiesto.

La proiezione corrente seleziona l'osservazione operativa per dominio/ambito e decisione di supersessione, mai semplicemente MAX(id). Non usare snapshot parziali per dedurre rimozioni. Conservare osservazioni simultanee contraddittorie e mostrare uncertain finché non riconciliate. raw_metadata corrente può restare una cache della baseline/corrente con riferimento di versione; non modifica le righe storiche e non prevale sulle evidenze strutturate.

## Mapping dall'anteprima DAT

| Input ANTEPRIMA / CAT | Destinazione B | Regola |
|---|---|---|
| source_plan, conditions | catalog_sources + condition_observations | source_key unico; condizioni URL/data originari, registrazione formale separata |
| source_record_key, native_id_policy | source_record_keys + source_records | native_id NULL; URL corrente da canonical_url, nessun ID sito inventato |
| original_CAT_record | source_record_observations.payload_json | Identico payload e hash; summary e normalizzati sono derivati attribuiti |
| title_raw/display_title_qualified/year_declared/aliases_declared | Snapshot; poi games/game_names via decisione | Heading Beeline resta Beeline; qualificatori e alias preservati senza equivalenza universale |
| outcome, rules, classification_exhaustiveness | admission + coverage + access | Policy TSK-0073, esito CAT originale e valutazione distinta dalla completezza del record |
| classification_observations | classifications + segments | Path ordinato identico, segment distinto, multiple appartenenze; mapping comune vuoto |
| historical_urls/source_url/final_url_status | record_url_observations | Stato tecnico e limiti originari; URL storico non prova redirect visitato |
| resource_plan[].key/payload | mention + mention_observation + catalog_resources se URL | URL NULL conservato; shared URL unico e prove distinte |
| access/free_observed/completeness/conditions_ref | access + condition_links | Ambito della menzione; public_content_free e complete_rules_free restano separati |
| final_url della soluzione | resource_url_observations | Requested solutions URL resta destinazione identitaria, login finale solo esito |
| instance_plan, instance_dates | problem_instances + observations + appears_in | Due date originali, zero solution_for, game count invariato |
| credit_plan named/missing, original credits | credit_observations | Nomi/ruoli/gap preservati, persona risolta solo con prova/decisione |
| relationship_plan, relations_and_dependencies | source_relation_assertions | Due archi distinti Libre→Abande; ulteriori riferimenti testo/URL senza nuovi record fuori campione |
| identity_plan, local_matching | identity_decisions + game_source_records dopo autorizzazione | `confirmed_new_local_identity_proposed` è proposta DAT: non importarlo come confirmed prima della decisione |

La matrice CASI_PILOTA.json contiene per tutti e dodici titoli, crediti/ruoli/mancanze, URL/date, classificazioni, menzioni, accessi CAT, istanze e piano simbolico. Mantiene originali e limiti senza aggiornare le fonti. Non è un importer.
