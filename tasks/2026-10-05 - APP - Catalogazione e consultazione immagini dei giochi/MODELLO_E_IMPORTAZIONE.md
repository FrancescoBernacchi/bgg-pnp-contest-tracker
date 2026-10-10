# TSK-0067 — Incremento 1: persistenza e importazione offline

Revisione 2026-10-10. Prerequisito modificato esplicitamente: i due piloti conclusi di TSK-0068 bastano; gli altri dodici giochi proseguono nel task IMG. Migrazione 014 implementata e collaudata su copie; **non applicata al database operativo**. UI e API restano fuori da questo incremento.

## Modello fisico e riconciliazione

La migrazione aggiunge 18 tabelle `img_`, sei viste e protezioni append-only. Non modifica tabelle, righe, viste o trigger esistenti; non importa i PNG ACQ e non altera la riconciliazione multifonte 009/013.

| Concetto | Persistenza | Regola |
|---|---|---|
| Immagine logica | `img_assets` | ID stabile del manifest, gioco canonico esistente; nessun matching per titolo. |
| File/versione | `img_files` | Versione dichiarata, percorso, hash, dimensioni e formato immutabili; file diversi dello stesso asset conservati. |
| Stato e revisione materiale | `img_asset_observations` | Osservazioni datate con uso e valutazione distinti; revisione materiale testuale, separata dalla versione immagine. |
| Categorie | `img_categories` | Categoria primaria e aggiuntive per osservazione; nessuna categoria produce un nuovo file. |
| Contesti | `img_contexts` | Più entry/contest, prodotti o record fonte; associazioni al gioco verificate. Matching candidato non sufficiente. |
| Provenienze | `img_provenances` | Più URL/documenti/etichette; accumulo consultabile in `img_all_provenances`, senza perdita dello storico. |
| Occorrenze | `img_occurrences` | Documento acquisito, pagina, coordinate e sistema; distinguibili dal conteggio fisico dei componenti. |
| Regioni di assemblaggio | `img_regions`, `img_region_links` | Fronte/retro/base e collegamenti entro un'immagine; coordinate riferite al documento o sistema dichiarato. |
| Componenti e lati | `img_components`, `img_component_observations`, `img_component_links` | Identità, revisione materiale, tipo, quantità esplicita e lati; un dorso può servire più componenti. |
| Relazioni | `img_relations` | Target tipizzato: immagine, precisa versione/file o componente; input AI registrati come relazioni. |
| Ricerca/applicabilità | `img_research_observations`, `img_category_research` | Ricerca conclusa esplicita, applicabilità separata, assenza verificata e conteggi attestati. |
| Decisioni AI | `img_decisions` | Esito datato per versione, riferimento alla conferma utente e motivo; chiave stabile non riutilizzabile con altro contenuto. |
| Principale esplicita | `img_primary_selections` | Decisione storicizzata per gioco; reset solo esplicito. Fallback automatico demandato al successivo APP. |
| Importazioni | `img_imports` | Hash canonico del lotto e versione del mapping; manifest e fonti completi nel SQLite locale. |

I campi descrittivi, crediti con ruoli/lacune, condizioni, limiti, tecnica di estrazione, generazione e riferimenti rimangono nei payload JSON datati e negli input completi. Non diventano persone, permessi o prove canoniche 013 senza un distinto atto di riconciliazione. Si tipizzano le relazioni utili; non si crea una tabella per ogni campo sperimentale. Nessun testo o binario terzo viene aggiunto al repository da questo importer.

Nel campione il tabellone v01 è un file storico della stessa immagine di v02. Le regioni Fronte/Retro/Base degli standee non sono tre immagini autonome. Le 96 provenienze e le 111 occorrenze mantengono i riferimenti ai materiali originali; 55 assegnazioni di categoria riguardano 44 immagini. Le revisioni materiali restano dichiarazioni contestuali, non un ordinamento automatico di stringhe: la scelta del materiale più recente viene attestata da IMG e conservata, senza dedurre successioni da nomi o date di download.

Le viste correnti scelgono l'osservazione più recente per data, poi ID in caso di stessa data. `img_current_assets` esclude le segnalazioni `historical_files`: queste documentano il file precedente senza riattivarlo. Un asset da ritirare esplicitamente deve avere un'osservazione corrente `current_use=superseded` o `not_adopted`. L'omissione non ritira un asset. Per correggere una decisione si aggiunge una nuova osservazione/decisione; identità e file non vengono riscritti.

## Contratto dell'importatore

`catalog/import_game_images.py` accetta esplicitamente `--database`, `--manifest`, `--sources`; opera offline e offre anteprima di default. Il manifest v1 è adattato con mapping `img-v1/014-v1`. Non segue URL e non cerca automaticamente altre raccolte. Non contiene condizioni per nomi, giochi o ID dei piloti. Un manifest parziale può riferire immagini/componenti già persistiti; riferimenti sconosciuti o appartenenti a un altro gioco producono conflitto.

La verifica comprende identità e chiavi esterne, contesto gioco/entry/contest, documenti acquisiti con hash/bytes, relazioni/lati/regioni, percorsi confinati e file immagini decodificabili con formato/dimensioni/hash concordanti. Limiti offline iniziali: manifest 32 MiB, immagine 128 MiB, 40 milioni di pixel e lato massimo 16.000; immagini animate/multipagina richiedono futura gestione esplicita. PNG/JPEG/WebP collaudati. Il catalogo ammette altri formati decodificabili da Pillow, senza promettere anteprima nell'app. Dipendenza offline Pillow, disponibile nel runtime collaudato (12.3.0); nessuna installazione da rete.

L'anteprima simula migrazione e importazione su una copia in memoria del database in sola lettura. L'applicazione richiede `--apply --authorization RIFERIMENTO`, backup SQLite consistente e ripristino su copia verificato, poi transazione esclusiva. Input/schema/stato del database vengono ricontrollati prima della scrittura. Un errore annulla sia DDL sia inserimenti. Non viene tentato un ripristino automatico dell'operativo: un restore futuro richiede valutazione e autorizzazione distinte.

La reimportazione identica verifica ancora file e riferimenti, ma non scrive. Lotto identificato dall'hash canonico di entrambi i manifest e del mapping, osservazioni deduplicate per identità/data/payload. File/versione, percorso o decision_key in conflitto non vengono sovrascritti. Un nuovo manifest aggiunge storia; l'assenza di record non li elimina. A parità di data, osservazioni nuove sono trattate come una revisione successivamente registrata: per mantenere l'ordine temporale usare date accurate, non il numero di versione testuale.

`research_complete` è un booleano esplicito. La presenza di immagini o PDF non chiude la ricerca. Applicabilità descrittiva non riconosciuta rimane `unknown`, conservando il testo originario; un conteggio zero non diventa `not_applicable`. I conteggi di categoria sono attestazioni del manifest, non metriche live dell'app. Il lotto conserva due ricerche concluse e dodici parziali/non esplorate con i loro limiti.

## Estensioni v1 per decisioni e principale

Gli originali possono conservare la descrizione `validation` senza diventare AI approvata. Per AI usare `origin_kind=ai_generated|ai_reworked`, `validation_state=pending|approved|rejected` e `current_use=adopted|superseded|not_adopted`. AI adottata richiede approvazione. Una AI approvata può essere superata senza essere scartata. Osservazione corrente e ultima decisione devono concordare. Manifest dei due piloti: nessuna AI, nessuna principale esplicita; entrambe le strutture restano vuote.

Esempio sintetico di decisione aggiunta al manifest (nessuna generazione richiesta):

```json
{"decisions":[{"decision_key":"decisione-stabile-1","image_id":"immagine-esempio","version":"v01","outcome":"approved","decided_at":"2026-10-10","confirmation_ref":"riferimento alla conferma utente","reason":"motivo facoltativo"}]}
```

La corrispondente osservazione dell'immagine deve dichiarare lo stesso esito; per approvazione/scarto occorre una decisione datata nella stessa importazione. `generation.input_image_ids` conserva gli input come relazioni, gli altri dati della generazione rimangono nel payload. Nessuna decisione viene inferita da una descrizione testuale.

`principal:true` registra una scelta; `principal:false` o omissione non cancella scelte pregresse. Alternativa esplicita: `primary_selections` con `game_id`, `image_id`, `selected_at`, `evidence_ref`; `image_id:null` registra il reset. Non impostare più scelte per lo stesso gioco nel medesimo lotto.

## Verifiche e passo successivo

Comandi dalla radice del progetto, con il proprio Python dotato di Pillow:

```text
python database/test_game_images.py
python database/verify_game_images.py --database database/pnp_collection.sqlite3 --manifest catalog/2025_children_family_images_2026-10-05.json --sources catalog/2025_children_family_image_sources_2026-10-05.json
python catalog/import_game_images.py --database database/pnp_collection.sqlite3 --manifest catalog/2025_children_family_images_2026-10-05.json --sources catalog/2025_children_family_image_sources_2026-10-05.json
```

Il secondo comando crea esclusivamente copie in `outputs/image-catalog-014`; il terzo è anteprima. `database/apply_image_catalog_migration.py --database ...` ispeziona soltanto, oppure applica il solo schema con autorizzazione/backup. L'importatore può applicare schema e dati nella stessa transazione, modalità proposta per l'operativo dopo consenso.

Esiti e hash in `VERIFICHE_INCREMENTO1.json`. Prima dell'operativo ricontrollare i manifest, la migrazione e lo stato DB: eventuali modifiche richiedono nuova anteprima. `schema.sql` rimane all'installazione 013 fino alla decisione operativa; non eseguirlo sul database esistente. Eventuali nuove fonti source-only senza gioco confermato, ordinamento comparabile delle revisioni materiali e nuovi sistemi di coordinate richiedono esempi e decisioni specifiche future; non bloccano questo lotto. Nessuna nuova decisione funzionale necessaria per importare i due piloti nel perimetro concordato.


## IMG 014 operativa — TSK-0067, 2026-10-10

Dopo consenso esplicito utente, migrazione 014 e importazione dei due manifest TSK-0068 applicate con backup/ripristino su copia verificati e transazione esclusiva. Operativo ora 014: 44 immagini/45 file, 16 componenti, 15 regioni; ricerca 2 concluse/12 parziali. Legacy 009/013 completo preservato, integrità/FK valide e replay senza scrittura. `database/schema.sql` include il blocco 014 per nuove installazioni: non rieseguirlo sull'operativo. Evidenza in `tasks/2026-10-05 - APP - Catalogazione e consultazione immagini dei giochi/OPERATIVO_VERIFICHE.json`. Le precedenti note di attesa sono storiche. UI/API/metriche immagini ancora da implementare nei successivi incrementi; nessuna nuova acquisizione o generazione, nessun commit/push.

## Completamenti dei tre blocchi — TSK-0067, 2026-10-10

Blocco 1: colonna Acquisizione immagini nella tabella annuale dei contest, conteggio ricerche concluse/totale entry e tre esiti distinti; link dalla scheda entry alla raccolta della scheda gioco. Children & Family: 2/27, 2 con immagini adottate, 0 senza, 25 non concluse; lotto IMG di 14 giochi distinto dal roster completo.

Blocco 2: categoria/stato e condizioni indipendenti combinabili in AND (Senza originali, Senza immagini adottate, Ricerca incompleta, AI da valutare), con azzeramento filtri. Senza immagini adottate vale anche per ricerca aperta. Ricerca della categoria selezionata usa le proprie attestazioni contestuali; nelle entry filtra esattamente entry/contest, senza trasferire completezza da altri contesti o dal gioco. Esiti non riconosciuti restano non attestati; assenza file non certifica assenza verificata. Il selettore galleria include le categorie della ricerca anche senza file, quindi click su copertura mantiene categoria e galleria vuota.

Blocco 3: componenti raggruppati per sottotipo registrato, filtro sottotipo e lati affiancati, dorso condiviso riusato. Dettagli immagine: avviso revisione precedente solo con dichiarazione esplicita e prova di successione, indipendente dalla versione immagine/data download/stato storico. In assenza di prova l’ordine resta non attestato. Nessuna riclassificazione o nuova inferenza.

Collaudo: 69 test Python mirati passati (41 IMG, 17 server, 11 metriche/revisioni); tre suite browser desktop/tablet/mobile 1400/780/390 per nuovi blocchi e regressioni galleria/liste/grafici. Fixture di soli metadati per filtri simultanei, ricerca categoria parziale con gioco concluso, assenza immagini a ricerca aperta e revisione precedente; nessuna AI generata. Zero errori pagina, richieste esterne e overflow; tabella larga resta scorrevole su mobile. Ispezionate schermate locali. SQLite immutato per SHA-256, 45 immagini e 38 PDF originali ricontrollati; manifest/schema/metriche aggregate invariati. Nessuna rigenerazione annuale necessaria: cambia esposizione/filtraggio UI, non conteggi o dati. Nessuna skill acquisitiva pertinente applicata; nessun commit/push.

Stato in_verifica: completamenti funzionali autorizzati implementati, resta valutazione visuale utente di barra/torta secondo piano. Report VERIFICHE_COMPLETAMENTI.json; precedenti dichiarazioni di chiusura incremento 3 conservate come storia e rettificate da questo riesame. Riavviare app. Prossimo passo: verifica visuale utente ed eventuale chiusura, poi commit solo su richiesta. TSK-0068 autonomo e aperto.

## Metadati consultivi per ricerca e revisioni — completamenti 2026-10-10

I payload originali sono preservati dall'importatore 014. Per categoria un booleano esplicito `research_complete` ha precedenza; altrimenti l'adattatore legge gli esiti dichiarati noti (complete/completed/conclusa/concluso/verificata/verificato e le due attestazioni sperimentali «verificata nelle fonti e materiali elencati», «verificata nelle fonti elencate, limiti espliciti»). Parziale/non esplorata/impedita resta aperta; testo non riconosciuto resta non attestato. Nessuna conclusione dai conteggi immagini. L'API conserva `research_observations` per categoria con entry/contest/data e complete true/false/null; il filtro per entry considera solo quel contesto, il filtro gioco richiede tutte le attestazioni pertinenti concluse. Non si adotta automaticamente come completa una categoria solo perché la ricerca generale è conclusa.

Una successione materiale attestata può essere consultata dal payload immagine, `extraction` o `contexts`: `material_revision_status` (previous/precedente oppure current/corrente) e `material_revision_evidence` non vuota (dichiarazione/fonte/riferimento alla successione). Nei contesti sono supportati anche revision_status/revision_evidence. Stato senza prova non produce avviso precedente; data, etichetta versione e file storico non provano la successione. Questi metadati sono preservati nel payload immutabile e letti genericamente: nessuna nuova tabella o dato operativo creato. Per future registrazioni offline preservare fonte/data/prova esplicita; non inserire un ordine ricostruito dalle date dei file.
