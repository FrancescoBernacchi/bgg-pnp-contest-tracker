# B-v1 — mapping fisico 013

TSK-0077, 2026-10-06. Attua la decisione TSK-0076 senza estendere il campione o importare dati. Migrazione `database/migrations/013_source_evidence.sql`, generatore deterministico `database/build_source_evidence_migration.py`. Le 21 entita seguenti sono generiche, non tabelle PerGioco.

| Contratto logico B-v1 | Tabella fisica | Vincoli/responsabilita |
|---|---|---|
| Chiavi locali record | source_record_keys | Source/record coerenti, UNIQUE fonte+chiave, native_id legacy invariato |
| Snapshot record | source_record_observations | JSON oggetto, fingerprint, evento+hash+mapper unici; rettifica esplicita con motivo; stato sviluppo separato |
| Esiti ammissione | source_admission_observations | Policy/versione/requisito ed esito originale/normalizzato, riferiti allo snapshot |
| Classificazioni | source_classification_observations | Etichette/tipo/path_state/segmento indice, molte appartenenze |
| Segmenti percorso | source_classification_segments | Ordine contiguo, limite segment_count; validazione finale della cardinalita dichiarata |
| Mapping comune | common_classification_mappings | Decisione e concetto separati; vuota nell'operativo |
| URL record | source_record_url_observations | Ruolo storico/richiesto/finale/dichiarato, eventi/redirect attestati; nessuna unicita globale URL |
| Identita menzione | source_resource_mentions | Chiave locale per record e prima osservazione; non URL come chiave |
| Versioni menzione | source_resource_mention_observations | Owner coerente; URL NULL implica resource_id NULL, URL dichiarato uguale alla destinazione risolta |
| Prove ammissione | admission_evidence_mentions | Menzione e versione tipizzate con FK, contesto del record, deduplicazione join |
| Accesso tecnico URL | resource_url_observations | Requested URL della menzione e final URL separati, login non sostituisce identita |
| Condizioni | condition_observations | Fonte/ambito/URL/date propri, permesso e registrazione/newsletter dichiarati separati |
| Accessi/costi | resource_access_observations | Quattro ambiti separati; booleane nullable, costo unknown conservato; gratuito osservato richiede contenuto osservato |
| Applicabilita condizioni | access_condition_links | FK/prova ed ambiguita esplicita, fonte coerente |
| Identita istanza | problem_instances | Chiave locale record+istanza, data non usata come unicita globale |
| Versioni istanza | problem_instance_observations | Owner coerente, data originale/precisione/locatore; non game |
| Occorrenze/soluzioni | instance_mention_assertions | Ruolo tipizzato, solutions per solution_for; decisione esplicita per eventuale relazione trasversale |
| Crediti/lacune | source_credit_observations | Ruoli e soggetti separati, NULL con stato esplicito, organizzazione non risolta a persona; no persone fittizie |
| Relazioni fonte | source_relation_assertions | Due record o destinazione testo/URL, dipendenza informativa/possesso/acquisto separati |
| Decisioni identita | source_identity_decisions | Storia proposed/candidate/confirmed/rejected, FK record/game e predecessore coerente |
| Ledger proiezioni | canonical_projection_events | FK tipizzate XOR per identita/nome/credito/relazione e destinazioni; identita confermate obbligatorie |

`PHYSICAL_MODEL.json` enumera colonne, FK, indici e trigger dalle definizioni SQLite effettive della migrazione. Schema.sql contiene lo stesso blocco 013 per installazioni nuove; prefisso preesistente preservato. Nessun ALTER alle tabelle legacy o trigger aggiunto sulle loro scritture.

## Traduzioni tecniche che preservano B-v1

Il generico target_key di proiezione diventa FK concreta a game/name/credit e FK composita a game_relationships, con name_observation_id e JSON Pointer per alias provenienti dallo snapshot. Non usa entity_id polimorfici senza integrita. Le relazioni canoniche richiedono anche target_identity_decision_id confermato: Abande candidato non puo produrre un arco confermato Libre verso 993. Il ledger non aggiorna automaticamente le tabelle canoniche: un futuro importer autorizzato esegue proiezione e ledger nella stessa transazione.

Le prove ammissione riferiscono sia identita sia versione di menzione, non l'ultima versione implicita. Per regole base+variante una menzione contestuale del base nel record variante puo condividere la destinazione URL del record base; il proprietario resta la variante. Le osservazioni hanno propri URL/date/provenienza/evidence_path/pointer; la lettura non deve ereditare indebitamente la data della scheda per crediti FAQ o appartenenze indice.

Tutti i 21 insiemi nuovi hanno chiavi immutabili e trigger no UPDATE/no DELETE/no REPLACE. I controlli BEFORE INSERT bloccano anche INSERT OR REPLACE con recursive_triggers disattivato, compreso conflitto su chiave semantica diversa da PK. Il replay della migrazione verifica definizioni esatte e non scrive; replay di importazioni e registro eventi appartengono al DAT importazione futuro. Nessun INSERT OR IGNORE usato per nascondere conflitti.

Rettifiche e predecessori devono riferire righe gia esistenti dello stesso owner: niente self-link, riferimento futuro o ciclo. Per lo stesso evento record un payload/mapper diverso richiede supersedes_id dell'evento e motivo. Un'altra visita con contenuto identico e evento diverso e una nuova osservazione. Date ignote richiedono unknown_reason; date raw e precisione sono distinte dalla formalizzazione con timezone. Nome/anno/categoria non sono chiavi d'identita.

segment_count e un conteggio tecnico del path osservato, non categoria inferita: controlla l'inserimento ordinato e la validazione di fine transazione. Path assente usa path_state not_declared/not_observable, segment_count=0; percorso osservato vuoto resta distinguibile. L'importer futuro deve validare completezza segmenti prima del commit. Similmente il payload_sha256 e strutturalmente vincolato nel DDL, ma la corrispondenza al JSON canonico deve essere verificata dall'importer: SQLite standard non ha SHA-256 nativo. Non certificare il contenuto solo per la forma dell'hash.

Stati nativi e osservazioni semantiche aperte rimangono raw; i vocabolari tecnici piccoli sono CHECK, versionati con il mapper. JSON di redirect valida la forma, non inventa passaggi mancanti; endpoint soli non provano la catena. I controlli SQL impediscono owner errati e proiezioni candidate, non verificano storicamente le dichiarazioni della fonte: resta responsabilita del censimento e del contratto di importazione.

## Esecuzione, backup e limiti

`database/apply_source_evidence_migration.py --database PERCORSO` ispeziona soltanto, in mode=ro/query_only. L'applicazione richiede `--apply --authorization RIFERIMENTO` e un target esistente mode=rw. Rifiuta schema parziale/divergente, crea backup consistente SQLite API e prova ripristino su copia, poi prende BEGIN EXCLUSIVE, ricontrolla la baseline e applica DDL in una singola transazione. Qualunque errore prima del commit causa rollback. Legacy confrontato per tutte le righe/ID, definizioni tabelle, viste, indici e trigger, non solo conteggi.

La backup API include commit nel WAL, senza copiare isolatamente il file principale. Backup e prova restore sono in outputs/source-evidence-013, esclusi da Git; hash/percorso nel report. Il tool non ripristina mai automaticamente l'operativo: in caso di esito post-commit problematico conservare stato fallito/sidecar e seguire piano B-v1 con scrittori fermi e verifica di incrementi successivi. Non usare down-migration distruttiva.

Runner e controlli richiedono Python con SQLite/JSON1, nessuna dipendenza o rete. Non disattivare assert tramite Python -O. Applicare solo con questo runner, non con executescript non controllato sull'operativo: il file SQL resta una migrazione eseguibile, mentre backup/preflight/idempotenza sono responsabilita del runner. L'app e in sola lettura e non applica migrazioni.

Dopo l'applicazione operativa il verificatore di accettazione richiede `--baseline PERCORSO_BACKUP_PRE013`, che riusa il backup verificato senza declassare o modificare l'operativo. COPY_PRE_APPLICAZIONE.json conserva il collaudo prima della scrittura; COPY_VERIFICHE.json conserva il successivo replay completo su copie del backup. Il runner di applicazione sull'operativo gia migrato restituisce already_applied dopo verifica delle definizioni e dell'integrita, con zero delta.

## Verifiche

15 test comportamentali su fixture sintetiche: append-only/replace in tutte le tabelle, collisioni/NULL e owner, date, rettifica/nuova visita, classificazioni multiple/percorsi, URL login, costi per ambito, due istanze stessa data senza nuovi games, crediti/gap/organizzazioni, dipendenze e proiezioni candidate/tipizzate. 12 controlli di integrazione su copie: conservazione legacy e lettura app, nuovi insiemi vuoti, backup/restore, replay zero delta, errore DDL/rollback, schema parziale rifiutato, WAL, schema fresh, test, hash operativo e app invariati durante accettazione.

Correzioni durante il collaudo: ordine dei vincoli di tabella SQLite nel generatore; fixture di rettifica inizialmente senza cambio hash; confronto legacy esteso alle viste oltre alle tabelle. Difetti risolti prima dell'operativo; nessun cambio del contratto B-v1. Non collaudato un importer PerGioco, non ancora implementato/autorizzato; nessun dato fonte inserito dalle prove nell'operativo.
