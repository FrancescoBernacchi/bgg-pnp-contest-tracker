# TSK-0075 — Proposta verificabile di persistenza PerGioco

Preparata il 2026-10-06 da evidenze locali CAT TSK-0074, fonte editoriale PerGioco, curatore/proprietario Marino Carpignano secondo FAQ. Crediti dei singoli giochi, ruoli, URL diretti e date sono conservati per record in ANTEPRIMA.json. Nessun accesso esterno. La proposta non adotta architetture né autorizza importazioni.

## Risultato proposto e conteggi

Conservare tutte le 12 candidate come record di fonte: nove con ammissione CAT attestata, tre con requisito non dimostrato. Proposta prudente: otto nuove identità canoniche; Abande senza nuova identità, con solo matching candidate verso game_id 993; Azul e i due Blockade senza games e senza matching automatico. Quindi nove ammissibili CAT non significa nove identità canoniche confermate nella fonte. Le otto identità nuove richiedono decisione sul criterio conservativo, non equivalenza dimostrata con ogni catalogo esterno.

| Candidata locale | Titolo qualificato | Operazione futura proposta |
|---|---|---|
| PGP-001 | Achi | Nuovo game, link confermato alla nuova identità locale |
| PGP-002 | Krypte | Nuovo game, link confermato alla nuova identità locale |
| PGP-003 | Abande | Record fonte e link candidate a 993; nessuna fusione/arricchimento canonico |
| PGP-004 | Abande Libre | Nuovo game; variante del record Abande, relazione canonica rinviata |
| PGP-005 | Chomp | Nuovo game |
| PGP-006 | Itinera | Un nuovo game, due istanze e risorsa soluzioni |
| PGP-007 | Azul | Solo record fonte, requisito non dimostrato |
| PGP-008 | Reversi | Nuovo game; attribuzioni concorrenti e ruoli preservati |
| PGP-009 | Blockade (1975) | Solo record fonte distinto |
| PGP-010 | Blockade (2001) | Solo record fonte distinto |
| PGP-011 | Beeline (1968) | Nuovo game distinto |
| PGP-012 | Beeline (1984) | Nuovo game distinto |

Verificare gli identificativi e i titoli contro ANTEPRIMA.json, autorevole per le operazioni simboliche. Non sono assegnati ID numerici futuri. PGP-xxx è un ID locale del pilota, non un native_id attestato dal sito: native_id resta NULL. Nessun nuovo prodotto o implementazione; materiali acquisiti zero.

I tre record non ammessi restano ricercabili in un futuro inventario della fonte con esito CAT, non nella lista dei giochi ammessi. Non usare `rejected` per completezza non dimostrata: è uno stato di matching/verifica con altra semantica. Nuove prove in un task autorizzato aggiungeranno un esito datato senza sovrascrivere il CAT. Non sono dichiarati definitivamente esclusi né a pagamento.

## Mapping campo–entità e lacune del modello corrente

Verifica reale in MODELLO_CORRENTE.json: sqlite_master, conteggi e query di titoli/alias con mode=ro e query_only. Schema iniziale e migrazioni 009–012 letti; documentazione PROJECT.md, database/README.md e app/README.md confrontata. Il JSON originale di ogni candidata è preservato esattamente nell'anteprima. Nessuna nuova categoria comune proposta.

| Campi CAT | Destinazione corrente possibile | Lacuna / trattamento |
|---|---|---|
| source_key, URL base, date | catalog_sources | Creare una fonte, previa autorizzazione; condizioni con provenienza separata |
| candidate_id, title_original, source_url | source_records | Chiave locale nel raw_metadata; canonical_url finale; native_id NULL |
| title_normalized, aliases_declared | games, game_names | Titoli qualificati distinti; alias con record/evidenza/data, solo per identità deliberate; mantenere anche originali nel record |
| outcome, rules, assessment, playtested | raw_metadata | Mancano osservazioni di ammissione/completezza multifonte; non usare stati di sviluppo games o entry_work_observations BGG |
| native_classification, kind, path, segment, index_title, exhaustiveness | raw_metadata | Nessuna entità classificazione nativa; array ordinati, NULL e appartenenze multiple preservabili come JSON, non interrogabili con contratto relazionale proprio |
| year_declared, page_updated_raw, observed_at, formalized_at, evidence | raw_metadata e date source_records | Anno dichiarato e aggiornamento pagina non sono data di osservazione; cronologia generalizzata assente |
| historical_urls, final_url_status, resource.final_url | raw_metadata | canonical_url non conserva da solo alias/redirect storici; mai sostituire URL richiesta con login come identità della risorsa |
| local_matching | game_source_records | candidate/confirmed/rejected adeguati; evidence e decided_at, senza promozione implicita |
| credits con nome/ruolo | people, person_names, credit_assertions | Asserzione attribuita al record fonte, declared; prova URL/data preservata nelle note o entità proposta; curatore non designer implicito |
| credits.name=NULL, missing_credits | raw_metadata | person_id NOT NULL impedisce asserzioni senza persona: nessuna persona fittizia “ignoto” |
| resources con URL | catalog_resources, resource_links | URL globale unico, ruolo per menzione; stati/costi specifici del contesto non vanno schiacciati nel record globale |
| resources con URL NULL | raw_metadata | catalog_resources.url NOT NULL: quattro menzioni PDF non diventano URL inventati |
| access, free_observed, completeness, conditions_ref | raw_metadata; campi generali risorsa | Mancano osservazioni accesso/costo/completezza distinte per menzione, storia e condizioni contestuali |
| instance_dates | raw_metadata | Nessuna identità di istanza; URL comune a due schemi non può rappresentare due risorse URL distinte |
| relations_and_dependencies | raw_metadata, game_relationships | Quest'ultima richiede due game_id; Abande candidate non può ricevere una relazione canonica confermata |
| componenti dichiarati | raw_metadata | Non forzare nelle entry_material_requirements BGG; non sono inventario acquisito né costo attestato |

La migrazione 010 riguarda condizioni di file acquisiti, non le condizioni di consultazione di una risorsa non acquisita. 011 riguarda derivati ZIP, non istanze di problemi. 012 è specifica di entry/contest BGG: non riutilizzarla per ammissione PerGioco.

## Identità e semantica dei casi

Abande 993: concordanza titolo/designer è evidenza candidata, non decisione sulle versioni. Crediti e categorie PerGioco restano sul record e non contaminano il gioco Kanare. Alternativa: creare un Abande provvisorio separato comporterebbe una nona nuova identità e successiva riconciliazione; sconsigliata per duplicazione evitabile. La proposta attuale rinvia l'associazione confermata e conserva CAT admitted indipendentemente.

Abande Libre: `variant_of` e `base_rules_information_required` sono due asserzioni distinte verso il record Abande; accesso alle regole base attestato, obbligo di acquistare possedere il prodotto base non attestato. Non impostare dependency_requirement=required come dipendenza fisica. Dopo la decisione su Abande, una relazione canonica variante può essere derivata con evidenza esplicita; la dipendenza informativa resta distinta. Le alternative di tavoliere interne non generano giochi.

Beeline: heading originale identico, titoli qualificati 1968/1984 da indici/breadcrumb; due URL finali distinti e URL storici preservati, incluso beeline-1984.html → 1/beeline.html. I due Blockade restano record distinti. Non deduplicare per titolo, autore, anno o etichette immagini errate. Gli alias restano asserzioni qualificate dalla fonte; un rimando Othello non basta per creare alias equivalente se il CAT non lo attesta in aliases_declared.

Itinera: un sistema canonico; due istanze locali identificate dalla pagina diagrammi e dalle date dichiarate 2021-06-18/2021-07-23. Nessun frammento URL, numero o titolo inventato. Soluzioni: risorsa separata con URL richiesto e destinazione login osservata, costo dopo autenticazione NULL. Non associare una specifica soluzione a uno dei due schemi senza prova. Esempio nella scheda resta descrizione, senza terza istanza numerata inventata.

Classificazioni: conservare ogni osservazione come intero percorso ordinato e tipo, senza estrarre automaticamente una tassonomia globale. I-K/K e I-J-K non sono errori da correggere; “Giochi su tavolieri 5x5” senza percorso superiore resta tale. Chomp non riceve “Giochi matematici e con i numeri”. Mapping comune inizialmente vuoto e sempre separato.

Crediti: persone da risolvere manualmente, nomi uguali non bastano per fondere persone. Designer, editore, rivendicazione concorrente, site_curator_owner restano ruoli originali. John Cooper/Andrew Looney riferiti a Icehouse non diventano designer di Blockade. Mancanze esplicite e limiti restano nell'esito; non derivare traduttori dal proprietario sito.

## Alternative e decisione EPR proposta, non adottata

**A — Modello vigente + raw_metadata strutturato.** Persistenza senza perdita delle dodici schede e array originali, risorse note collegate ai record, menzioni senza URL/istanze/classificazioni/esiti nel JSON. Minimo impatto, nessuna migrazione necessaria; interrogazioni/validazione più fragili e APP futura deve leggere il contratto JSON. Serve comunque autorizzazione all'importazione; questo task non la esegue.

**B — Estensione additiva generica, raccomandata per persistenza interrogabile.** Conservare anche raw_metadata come baseline CAT, introducendo i seguenti contratti concettuali in un EPR successivo. Nomi indicativi, non schema deliberato né migrazione numerata.

| Entità proposta | Chiavi e semantica |
|---|---|
| source_record_observations | record + fingerprint contenuto + data osservazione + provenienza; append-only, data formalizzazione separata |
| source_admission_observations | osservazione + requisito + esito originale + valutazione; ammesso/non dimostrato senza equivalere a match |
| source_classification_observations | osservazione + kind + label + path_json ordinato + segment + URL/date; molte appartenenze, nessun nodo genitore inferito |
| source_record_url_observations | record + URL richiesta/storico/finale + tipo + data/evidenza; redirect/login distinguibili |
| source_resource_mentions | record/osservazione + ordinal/key locale + funzione originale + resource_id opzionale + URL nullable; menzioni PDF conservate senza risorsa URL |
| resource_access_observations | menzione + data/evidenza + pubblico/account + costo contenuto/regole/componenti/online separati + completezza + condizioni referenziate |
| resource_instances | menzione/risorsa + chiave locale + data originale + tipo; game non incrementato; collegamento soluzione opzionale non dedotto |
| source_relation_assertions | record origine/destinazione + tipo + dipendenza informativa/fisica esplicita + prova; proiezione canonica solo con identità decise |
| credit_gap_observations / condizioni | assenza per ruolo senza persona; condizioni con URL, data e ambito; crediti nominati mantenuti in credit_assertions |

Mapping comune eventuale: tabella distinta con riferimento alla classificazione osservata, concetto comune, stato decisione, motivazione/data; vuota per il pilota. Non adottare enumerazioni universali da dodici casi. Per risorse condivise preservare menzioni e condizioni multiple; catalog_resources resta destinazione URL, non fonte unica di tutte le prove.

**C — Dodici games indiscriminati o schema PerGioco isolato.** Sconsigliati: il primo trasforma le tre lacune in ammissioni, il secondo duplica identità e infrastruttura multifonte. Una nuova voce APP specializzata resta decisione APP, non conseguenza del DAT.

Decisione richiesta prima dell'esecuzione: scegliere A o deliberare B in EPR autonomo; approvare criterio delle otto nuove identità + Abande candidato + tre source-only; decidere se mantenere Abande irrisolto oppure avviare VER separato con confronto autorizzato. In caso B: definire contratti, vincoli e compatibilità con BGG/Kanare, poi task DAT esecutivo separato. PROJECT.md/AGENTS/stato architetturale si aggiorneranno solo dopo adozione. Nessun EPR esecutivo aperto automaticamente.

## Idempotenza e validazione futura

1. Input fissato per hash e versione; manifest CAT immutato. Chiave locale pergioco:pilot:PGP-xxx conservata con registro importazione, non inserita come identificatore nativo del sito.
2. Risolvere fonte per source_key; record per chiave locale documentata e URL storico/finale. Se URL collide con altro record, fermarsi e richiedere riconciliazione. Non usare titolo come chiave; cambi URL non creano nuove identità automaticamente.
3. Osservazioni con fingerprint canonico del payload, URL/provenienza/date; identico replay nessun inserimento. Dato cambiato nuova osservazione, non cancellazione storico. Non usare INSERT OR REPLACE: può eliminare righe e legami.
4. Giochi creati tramite mapping stabile candidato→ID nel registro della transazione; secondo import non ricrea games. Matching candidato a 993 conservato; conferma solo su decisione registrata, con stato precedente preservato.
5. Nomi, crediti, menzioni, classificazioni e istanze risolti per chiave semantica. resource_links UNIQUE contiene NULL: SQLite consente duplicati con NULL, quindi il vincolo attuale non basta; futuro importer usa ricerca IS NULL/NOT EXISTS, oppure indici parziali deliberati. Credit_assertions/game_names non hanno unicità semantica sufficiente: controlli espliciti obbligatori. Accesso concorrente impedito nel processo import.
6. Prova su copia: primo passaggio delta atteso, secondo delta zero, input mutato crea storia senza promozioni implicite; collisione URL, omonimi, NULL e errore intermedio devono produrre rifiuto/rollback. Confronto conteggi BGG/Kanare e integrità prima/dopo. Questa preparazione verifica rigenerazione JSON, non certifica un importer ancora inesistente.

## Backup e ripristino prima di un futuro import

Nessun backup operativo o migrazione eseguiti qui. Nel task esecutivo: fermare processi scrittori e app se necessario; rilevare schema, conteggi, mode journal e hash del manifest. Creare snapshot consistente via SQLite backup API verso file locale escluso da Git, includendo contenuti WAL tramite API; non copiare solo sqlite3 con scrittore attivo. Verificare snapshot con integrity_check, foreign_key_check, conteggi e hash; annotare percorso/data/schema e registro importazione. Provare ripristino su copia prima di lavorare sull'originale.

Una transazione unica per l'import, foreign_keys attivo, nessuna rete; rollback su qualunque errore. Se serve migrazione B, applicarla solo dopo EPR e prove, con backup pre-migrazione. Dopo commit verificare invarianti e dati legacy, registrare ID creati e impronte. Ripristino completo solo con scrittori fermi e autorizzazione nel contratto esecutivo: preservare DB fallito e sidecar per diagnosi, ripristinare snapshot consistente, verificare schema/contatori/integrità e lettura app. Non ripristinare ciecamente se dopo il backup esistono altri incrementi: prima riconciliare, per evitare perdita di lavoro.

## Criteri di accettazione

Preparazione: dodici payload originali identici al CAT; 9/3, titoli/omonimi, classificazioni e date preservati; anteprima riproducibile; DB invariato; proposta EPR non adottata. Soddisfatti in VERIFICHE.json.

Futuro import: dodici record fonte, tre source-only senza canonicalizzazione; otto giochi nuovi se il criterio viene approvato, Abande candidate 993; nove ammissioni distinte dagli otto link confermati. Itinera uno/due, soluzioni separate senza match inventati; URL NULL di PDF conservati senza placeholder. Classificazioni native e mapping comune separati, nessuna inferenza ulteriore; crediti per ruolo e assenze, risorse/accessi/costi e condizioni riconciliati per campo. Date originali uguali al CAT, timestamp import separato; legacy BGG/Kanare invariato; integrità/FK valide; replay zero delta e rollback/restore provati. Solo dopo queste verifiche chiudere il task esecutivo; APP e acquisizioni restano autonomi.

## Evidenze e limiti

ANTEPRIMA.json contiene sintesi originali/metadati/link già formalizzati nel CAT, senza regolamenti, screenshot o media. Condizioni riutilizzate con data originaria 2026-10-06, non riverificate; non attestano licenza di redistribuzione. MODELLO_CORRENTE.json registra DDL e conteggi locali, non contenuti del database. L'assenza di match esatto non dimostra unicità mondiale. Nessuna verifica del remoto Git; nessun commit/push. Successivo passo utile: decisione su A/B e piano identità; importazione soltanto in task separato dopo decisione.
