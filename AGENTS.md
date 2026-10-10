# AGENTS.md

## Missione del progetto

PerGioco: decisione TSK-0073 del 2026-10-06, perimetro in `sources/PERGIOCO-SCOPE.md`. Include subito giochi logici oltre ad astratti/tradizionali e carta e matita. Catalogare il sistema di regole; schemi e soluzioni sono istanze/risorse, senza moltiplicare i giochi. CAT pilota separato da DAT/APP/ACQ/IMG, regole complete gratuite e accessi attestati per titolo. Adozione non equivale a importazione né a download.

Costruire e mantenere una collezione locale, ricercabile e tracciabile di giochi Print and Play scoperti inizialmente nei contest di BoardGameGeek.

## Modello operativo

Catalogare tutte le entries comprese nel perimetro del task e acquisire i materiali soltanto per i giochi selezionati. Partire dai contest attivi più recenti. Basare la priorità principalmente su classifiche e votazioni BGG, distinguendo sempre risultati ufficiali da segnali sostitutivi.

Il lavoro BGG di censimento, materiali e monitoraggio segue i cinque tipi standard definiti in `PROJECT.md`: censimento globale dei contest, censimento annuale delle entry, analisi dei materiali di un singolo contest, acquisizione dei materiali di un singolo contest e monitoraggio di un singolo contest. Non combinarli nello stesso task salvo una migrazione esplicitamente deliberata.

Nel censimento annuale registrare le entry di tutti i contest dell'anno senza analizzarne WIP, risorse o requisiti materiali. Cercare WIP, collegamenti dichiarati e requisiti materiali soltanto nel task dedicato a un singolo contest. Distinguere sempre WIP non individuato, risorse non osservabili, nessuna risorsa dichiarata e risorse dichiarate ma non verificate. Verifica degli host esterni, selezione e download appartengono a un successivo task di acquisizione dedicato allo stesso singolo contest, mai a un'annualità intera o a più contest.

Conservare separatamente i contest PnP autonomi e i contest adiacenti autorizzati. Per le varianti dipendenti da un gioco base, registrare tale dipendenza e non presumere che esistano componenti PnP aggiuntivi.

L'agente deve applicare le skill locali pertinenti prima di svolgere le attività coperte, anche nelle riprese di task storici e senza attendere che l'utente le nomini. Per BGG leggere `.agents/skills/bgg-contest-navigation/SKILL.md` e la specializzazione indicata nella sezione Gestione delle skill locali; per FON applicare la skill di scoperta o di preanalisi secondo l'obiettivo. Quando emerge una struttura nuova o una strategia migliore, registrare nel task l'evidenza specifica e promuovere il pattern riutilizzabile nel riferimento condiviso dopo verifica. Preferire l'estrazione completa dalla fonte BGG autorevole; usare ricerche sostitutive soltanto per anomalie residue.

## Mappa del progetto

- `README.md`: introduzione operativa e stato sintetico per il repository GitHub.
- `GIT_GUIDE.md`: guida semplice e protocollo di supporto Git/GitHub per l'utente.
- `PROJECT.md`: scopo, vincoli e architettura autorevole.
- `TASK_GOVERNANCE.md`: protocollo autorevole per categorie, naming, modalità, stati e monitoraggio trasversale; `tasks/REGISTRY.json` è il registro centrale con ID stabili e verifiche datate.
- `.workspace/PROJECT_STATE.md`: stato di inizializzazione e allineamento PWS.
- `app/`: interfaccia locale Python/HTML/CSS/JavaScript in sola lettura; `server.py`, asset in `static/`, launcher `start.ps1`, test e guida `README.md`; include navigazione di contest, entry, risorse e classifiche, Libreria per gioco e lettori PDF/PNG/DOCX per ID registrati (`pdf_files.py`, `material_files.py`, `static/pdf-viewer.js`, `static/material-viewer.js`, PDF.js locale in `static/vendor/pdfjs/`); estrazione ZIP offline in `catalog/extract_registered_archives.py` con migrazione 011, sintesi per contest e il generatore Markdown preesistente.
- `database/schema.sql`: modello relazionale autorevole iniziale.
- `app/source_progress.py`: adattatori in sola lettura dell'Avanzamento multifonte; linguette BGG/Kanare, attestazioni catalogo/ACQ in `catalog/kanare_progress_scope_2026-10-06.json` e inventario MAT Kanare nel manifest dedicato. Nessuna percentuale inferita dai soli URL; nuove fonti richiedono layout e metriche propri.
- `database/migrations/`: evoluzioni ordinate dello schema.
- `catalog/`: manifest ed esportazioni testuali versionabili.
- `library/`: materiali PnP acquisiti; contenuto escluso da Git.
- `sources/`: registri e note di provenienza riutilizzabili.
- `.agents/skills/bgg-contest-navigation/`: skill locale e playbook evolutivo per esplorare contest, roster, entry, WIP, risultati e risorse BGG.
- `sources/MONITORING_CALENDAR.md`: taccuino autorevole delle prossime finestre di controllo BGG e degli ultimi rilevamenti.
- `PROJECT_PROGRESS.md`: cruscotto autorevole e versionabile dell'avanzamento trasversale su copertura, pipeline, attività, acquisizioni e strumenti.
- `tasks/`: workspace auditabili delle attività non banali.
- `outputs/`: risultati rigenerabili, esclusi da Git salvo documentazione.

## Workflow dei task

All'inizio di ogni richiesta, anche in un nuovo task Codex, verificare i task locali esistenti e il loro stato. Se il lavoro appartiene a un task ancora aperto, indicare all'utente quale riprendere prima di duplicare l'attività. Se il precedente è concluso, spiegare se il nuovo lavoro costituisce un incremento autonomo e perché il task corrente è appropriato. Applicare il controllo anche alle richieste non BGG: l'utente potrebbe non ricordare attività svolte giorni o settimane prima.

Per ogni attività autonoma o multi-step creare `tasks/YYYY-MM-DD - CODICE - descrizione/TASK.md` secondo `TASK_GOVERNANCE.md`. Assegnare ID stabile e aggiornare `tasks/REGISTRY.json` all'apertura e a ogni incremento che cambia stato, categoria, modalità, dipendenze o versionamento. Il task di bootstrap usa eccezionalmente `2026-09-04 - SETUP INIZIALE PROGETTO`; i percorsi storici restano invariati. Definire scope, input, deliverable e criteri di successo prima di operare; lavorare per incrementi verificabili; chiudere registrando verifiche, decisioni e risultati riutilizzabili.

Prima di aprire o proseguire un'attività BGG di censimento, materiali o monitoraggio, classificarla in uno dei cinque tipi standard di `PROJECT.md` e applicarne unità di lavoro ed esclusioni. Se la richiesta dell'utente adotta un perimetro diverso, avvisarlo della divergenza, indicare il tipo e il task corretti e non estendere silenziosamente il perimetro. Applicare lo stesso controllo quando l'utente chiede «che facciamo ora?», «quali sono le prossime attività?» o formule equivalenti: proporre i passi successivi come task separati e conformi, indicando chiaramente anno o singolo contest richiesto da ciascun tipo.

Quando un incremento modifica copertura, conteggi, fase della pipeline, priorità, blocchi, acquisizioni o stato degli strumenti, aggiornare nello stesso incremento `PROJECT_PROGRESS.md` secondo il suo protocollo di manutenzione, prima di chiudere `TASK.md`. Non aggiornare il cruscotto per una mera rigenerazione di output priva di cambiamenti ai dati o allo stato.

Se cambiano contest, entry, classifiche, scansioni dei materiali, acquisizioni o file acquisiti, rigenerare prima le sezioni annuali A e B con `app/generate_project_progress.py`; non modificare manualmente il contenuto compreso tra i marcatori HTML generati.

Il titolo visibile del task Codex usa la convenzione `Txxxx-AA.MM.GG - CODICE - descrizione`, con le quattro cifre dell ID stabile TSK-NNNN, la data di apertura del task in formato breve e una descrizione breve che ne rappresenti lo scopo effettivo. Appena il compito è sufficientemente compreso, verificare autonomamente il titolo e rinominare il task se non rispetta la convenzione o non riflette più correttamente il perimetro concordato; non attendere una richiesta specifica dell’utente. Il titolo aggiornato deve sintetizzare l'intero contenuto della conversazione e preservare i temi precedenti ancora rilevanti, non soltanto l'ultimo focus. Per i cinque tipi BGG usare le convenzioni definite in `PROJECT.md`, mantenendo distinta la data di apertura dall'anno del censimento o dal nome del contest. Alla ripresa di una chat storica registrare il titolo precedente; nessuna rinomina massiva dei percorsi. Separare categoria, modalità/cadenza, ciclo di lavoro, copertura, versionamento e stato runtime della chat; non dedurre completamento da idle o notLoaded. La categoria ALT richiede motivazione e riesame.

## Regole della conoscenza

La tassonomia dei collegamenti resta provvisoria durante l'analisi materiali del singolo contest. Conservare separatamente funzione dichiarata, forma tecnica ed evidenza; accorpare URL identici senza perdere le diverse menzioni. Consolidare categorie ed enumerazioni soltanto dopo il confronto dei task di analisi di tutti i contest dell'anno, senza riunire per questo le analisi in un unico task annuale.

Conservare separatamente dati originali, valori normalizzati e inferenze. Ogni informazione volatile deve includere fonte e data di verifica. Una nota di task diventa conoscenza condivisa solo dopo verifica e promozione deliberata. Non perdere nomi o stati storici quando un gioco viene rinominato, ritirato o aggiornato.

## Regole degli output

Il database SQLite è operativo e locale. Schema, migrazioni, manifest ed esportazioni testuali sono versionabili. Materiali scaricati e output rigenerabili non entrano in Git. Non modificare i file originali acquisiti; eventuali derivati devono essere chiaramente separati e riconducibili alla fonte.

## Protocollo di monitoraggio

- Prima di un controllo periodico consultare `sources/MONITORING_CALENDAR.md` e privilegiare la prima finestra scaduta o l'evento più vicino.
- Non ripetere un rilevamento esterno nello stesso giorno, salvo correzione di un errore, nuovo annuncio BGG o richiesta esplicita dell'utente.
- Distinguere una verifica tecnica di importazione o consistenza da un rilevamento dello stato esterno; soltanto il secondo alimenta la cadenza periodica.
- Per contest con entry o sviluppo aperti usare normalmente una cadenza settimanale, intensificata nei sette giorni prima delle scadenze e il giorno successivo agli eventi di fase.
- Non ricontrollare ordinariamente i contest conclusi, salvo risultati incompleti, rettifiche o nuovi riferimenti autorevoli.
- Registrare anche gli esiti `no_change`, ma soltanto quando il controllo era dovuto; aggiornare sempre il taccuino con esito e prossima finestra.
- Usare per i rilevamenti effettivi un `contest_checks.check_kind` contenente `monitor`, `scheduled`, `deadline` o `follow_up`; riservare `baseline`, `census` e `consistency` alle attività che non devono alimentare il confronto periodico.
- Ogni rilevamento confrontabile deve rappresentare uno snapshot completo dell'entità osservata e collegare tramite `check_id` stato del contest, entry, metriche e fasi disponibili. Non interpretare l'assenza da uno snapshot parziale come rimozione.
- Nei task di solo monitoraggio non aprire né scaricare file di gioco: usare thread, GeekList, Hub, titoli, tabelle e metadati pubblici.
- Al termine di ogni incremento indicare autonomamente il prossimo controllo o approfondimento utile, senza attendere che venga richiesto.

## Evoluzione strutturale

Cambiare la struttura solo quando emerge un ciclo di vita distinto o un pattern stabile. Aggiornare insieme `PROJECT.md`, questa mappa e lo stato del progetto quando una modifica architetturale diventa permanente.

### Uniformità della gestione dei giochi — decisione utente 2026-10-10

L'app deve gestire i giochi quanto più possibile in maniera uniforme, evitando gestioni ad hoc per singolo gioco. Preferire componenti e comportamenti generici guidati dai dati e dalle capacità effettive (istanze, varianti, raccolte, crediti contestuali, accessi). Eventuali differenziazioni funzionali sono per categorie/tipologie di giochi; non inferire classificazioni nuove per attivarle. I titoli nominati nei requisiti sono casi di verifica, non condizioni applicative basate su nome, URL o ID. Verificare la riusabilità su un altro record o fixture. Adattatori di provenienza preservano le differenze informative senza duplicare i comportamenti comuni. Decisione registrata nel passaggio APP di TSK-0081; non autorizza refactoring, riclassificazioni, schema o dati fuori dal task attivo.

## Salvaguardia del sandbox Windows Codex

- Trattare `.agents`, `.git`, `.codex` e le altre directory di controllo riconosciute dal runtime come percorsi speciali. Non eliminare, rinominare o ricreare queste directory come rimedio a problemi di accesso.
- Se `.agents` non esiste e occorre introdurre una skill locale, non crearne la directory radice tramite `apply_patch` o un altro processo eseguito nel sandbox. Verificare prima esistenza, proprietario e ACL; predisporre la directory sotto l'identità dell'utente Windows mediante un'operazione fuori sandbox esplicitamente autorizzata, quindi verificare il proprietario prima di aggiungere `.agents/skills/...`.
- Se `.agents` esiste, modificarne soltanto i file interni richiesti e non sostituire la directory radice. Prima di una manutenzione strutturale della skill verificare che il proprietario della radice sia l'utente Windows interattivo, non `CodexSandboxOffline`.
- Dopo un ripristino da usage limit, un riavvio o aggiornamento di Codex oppure la ripresa di un task interrotto, eseguire nel sandbox ordinario un preflight leggero: `Get-Location`, `git status --short --branch` e una breve lettura di un file del workspace. Per i task che richiedono CUA verificare anche l'inizializzazione del browser con una pagina neutra prima del lavoro esterno esteso.
- Se un comando banale fallisce con `setup refresh had errors`, interrompere il lavoro sostanziale: non reiterare indiscriminatamente i comandi e non usare `require_escalated` per proseguire il workflow come soluzione permanente.
- In caso di tale errore, verificare prima `~/.codex/.sandbox/setup_error.json`, la coda del log sandbox giornaliero, il percorso indicato da `SetNamedSecurityInfoW` e proprietario/ACL di quel percorso rispetto alla directory padre. Distinguere il wrapper generico dall'errore Windows concreto.
- Usare `require_escalated` soltanto per diagnosi in sola lettura o per una correzione minima esplicitamente autorizzata. Non modificare ACL e non cancellare cache, configurazioni, plugin, sessioni o cronologia senza evidenza specifica e autorizzazione dell'utente.
- Dopo una correzione verificare separatamente: comando sandbox banale, lettura locale, scrittura temporanea e sua rimozione, inizializzazione CUA, pagina neutra e pagina di lavoro. Un comando riuscito fuori sandbox non dimostra che il sandbox sia ripristinato.

## Supporto Git e GitHub

- Assumere che l'utente non sia esperto di Git. Quando un'azione Git diventa opportuna, segnalarla autonomamente e spiegarne in linguaggio semplice scopo, vantaggio e possibile effetto.
- Prima di iniziare un incremento, controllare quando utile branch, stato della working tree e relazione con `origin`; avvisare se esistono modifiche non committate o divergenze remote.
- Suggerire un commit quando è concluso un incremento coerente e verificato. Riassumere cosa includerà e proporre un messaggio di commit chiaro.
- Suggerire un branch prima di modifiche sperimentali, rischiose, di lunga durata o con alternative da confrontare. Evitare branch inutili per cambiamenti piccoli e lineari.
- Suggerire il push dopo un commit significativo o alla fine di una sessione, spiegando che trasferisce su GitHub commit già locali. Verificare poi l'allineamento fra branch locale e remoto.
- Spiegare `fetch`, `pull`, `merge`, conflitti e pull request nel momento in cui diventano rilevanti; non presumere che i termini siano noti.
- Non eseguire automaticamente commit, creazione/rinomina di branch, push, pull, merge o altre modifiche Git solo perché sarebbero consigliabili: proporre l'azione e procedere quando l'utente la richiede o la autorizza chiaramente.
- Prima di commit e push verificare `.gitignore` e segnalare file inattesi, sensibili, generati o di terzi. Dopo ogni operazione verificare e comunicare risultato, commit, branch e stato residuo.
- Quando si mostrano comandi da eseguire nella PowerShell ordinaria, tenere conto che Git potrebbe non essere nel `PATH`; usare la convenzione `$git` descritta in `GIT_GUIDE.md` o offrire di eseguire l'azione tramite Codex.

## Relazione con lo Standard

Questo progetto segue Project Workspace Standard versione 1.5.0. All'inizio di ogni nuovo task confrontare `aligned_version` in `.workspace/PROJECT_STATE.md` con `C:\PROGETTI CODEX\PROJECT_WORKSPACE_STANDARD\VERSION`; se la versione canonica è più recente, informare l'utente, leggere le migrazioni intermedie e non modificare il progetto finché l'adozione non viene deliberata. Consultare lo Standard per metodologia, governance, evoluzione e migrazioni. Non modificare lo Standard da questo progetto.

## Vincoli specifici

- BoardGameGeek è l'unica fonte iniziale; aggiungerne altre solo tramite task esplicito.
- Non aggirare autenticazione, limitazioni tecniche o condizioni di accesso.
- Verificare liceità e condizioni applicabili prima di acquisire o utilizzare materiali.
- Non redistribuire opere di terzi.
- Calcolare un hash per ogni file acquisito e preservare tutte le versioni.
- Mantenere lo stato specifico dichiarato oltre allo stato normalizzato.
- Preservare i conteggi precedenti quando una rilevazione successiva li corregge; marcare chiaramente quale osservazione è operativa.
- Il repository GitHub privato versiona soltanto contenuti ammessi da `.gitignore`; il branch principale è `main` e il remoto convenzionale è `origin`.

## Definition of Done

Un task è concluso quando i deliverable sono verificati, fonti e date sono registrate, i materiali acquisiti hanno manifest e hash, le decisioni durevoli sono promosse nei file autorevoli e `TASK.md` documenta la chiusura.

## Estensione annuale classifiche BGG — 2026-10-04

Il 2026-10-04 l’utente delibera per TSK-0045 il task continuativo `BGG-A - Classifiche BGG 2025`: estensione annuale limitata a risultati e votazioni, con incrementi per contest, provenienza, confronto con baseline e distinzione fra completezza delle verifiche e percentuale di entry in classifica. Il censimento roster resta distinto; WIP, materiali, host esterni e download restano esclusi. Riprese su richiesta nella stessa chat, senza automazione. Le challenge prive di roster restano dipendenza esplicita. PWS resta 1.5.0. Contratto in `tasks/2026-10-04 - BGG-A - Classifiche BGG 2025/TASK.md`.

## Estensione annuale classifiche 2024 — 2026-10-04

L’utente ha confermato TSK-0046, `BGG-A - Classifiche BGG 2024`, incremento annuale circoscritto ai risultati e votazioni dei contest con roster esistente. Provenienza e confronto con baseline per contest; completezza della verifica separata dalla presenza in classifica. Roster aggiuntivi, WIP, materiali, host esterni e download esclusi. Le challenge senza roster restano dipendenza del censimento. Contratto: `tasks/2026-10-04 - BGG-A - Classifiche BGG 2024/TASK.md`. PWS invariato a 1.5.0.
## Metriche di completamento dell'app — 2026-10-04

`app/work_progress.py` condivide le metriche APP-008 fra API e generatore del cruscotto. La migrazione 012 conserva attestazioni con fonte/data/evidenza: `entry_work_observations` e `contest_census_observations`. Nei futuri incrementi registrare completezza o assenza esplicita, non inferirla dalla presenza/assenza di piazzamenti o file; aggiornare le attestazioni di roster quando cambia lo snapshot. Il censimento materiali resta conforme al contratto MAT del primo post. Dettagli e denominatori in `app/README.md`; immagini rappresentative ancora non implementate.

Quando cambia la metrica di una barra, riconciliare tutte le evidenze storiche pertinenti prima di adottarla: una attestazione non ancora convertita non significa lavoro non svolto. Preservare separatamente quantità già raccolte e verifiche parziali, senza dichiararle complete. Per acquisizioni rispettare perimetro ed esclusioni documentati nei manifest; non richiedere file per video, implementazioni o altri link esclusi. Audit correttivo APP-008 in TSK-0047/HISTORY_AUDIT.md.

## Gestione delle skill locali — 2026-10-04

Dal 2026-10-05, decisione TSK-0069: al termine di ogni incremento significativo che applica skill, registrare la breve verifica dell’efficacia prevista in `TASK_GOVERNANCE.md`, sezione «Verifica dell’efficacia». Vale anche per nuovi incrementi di task storici, senza riesame retroattivo obbligatorio. Collegare migliorie a TSK-0048; manutenzione tecnica autonoma nei confini autorizzati con skill-creator e salvaguardie .agents; scope, contratti e architettura richiedono decisione esplicita. Criteri e modalità di attestazione restano nel solo protocollo autorevole.

TSK-0048 mantiene le skill come attività GPR continuativa su richiesta, senza automazione. Inventario autorevole: `sources/SKILL_INVENTORY.md`. Per BGG leggere la base `.agents/skills/bgg-contest-navigation/SKILL.md` e soltanto la specializzazione pertinente: `bgg-contest-census` (BGG-G), `bgg-ranking-census` (risultati nel contratto autorizzato), `bgg-material-census` (MAT), `bgg-material-acquisition` (ACQ). Il roster annuale resta procedura distinta in `.agents/skills/bgg-contest-navigation/references/annual-entry-census.md`; monitoraggio governato da PROJECT.md e calendario. Per FON usare `potential-source-discovery` per candidati/gradatoria e `source-preanalysis` per una sola fonte. Tutti gli entrypoint sono `.agents/skills/NOME/SKILL.md`. Queste skill non adottano nuove fonti né estendono contratti; manutenzione con skill-creator, prove locali e promozione delle sole esperienze verificate. Cambi contrattuali/architetturali restano EPR da deliberare. Salvaguardie Windows .agents invariate.


## Workflow immagini — 2026-10-05

TSK-0065 adotta `sources/IMAGE_WORKFLOW.md`, autorevole per IMG, e il registro `sources/IMAGE_CONTEST_CODES.md`. Applicare `.agents/skills/game-image-acquisition/SKILL.md` per acquisizione/catalogazione immagini, estrazioni e integrazioni AI autorizzate; per navigazione BGG leggere anche la base. IMG è autonomo dai cinque workflow BGG: un contest/anno con incrementi per gioco; Kanare con giochi selezionati; fonti future da valutare singolarmente. Non estende CAT/MAT/ACQ/monitoraggio e non autorizza nuovi pacchetti PnP.

La mappa comprende i due riferimenti immagini, la skill e `library/immagini/<ID-stabile>__<Titolo>/{originali,estratti,ai,derivati}/`; manifest versionabili in catalog, binari fuori Git. Copertura per categoria, provenienze, estrazioni, naming, varianti e ciclo di vita sono definiti nel workflow. AI inizialmente tramite Codex su richiesta, risultati Da valutare fino a validazione esplicita utente. App immagini da implementare in task APP; generazione dalla UI solo evoluzione potenziale. Regole deliberate, tecniche di estrazione/navigazione IMG da collaudare. PWS 1.5.0.

## Censimento materiali Kanare — 2026-10-06

TSK-0070 autorizza MAT di una singola fonte non-BGG per i 64 giochi Kanare preesistenti. Applicare `.agents/skills/kanare-material-census/SKILL.md`; non applicare il vincolo BGG del primo post. Pagine ufficiali e regolamenti IT/EN consultabili, altre lingue solo URL/metadati, nessuna nuova acquisizione/library/IMG o verifica piattaforme. Contratto, due piloti sequenziali e risultati in `tasks/2026-10-06 - MAT - Kanare Abstract/`; manifest `catalog/kanare_material_census_2026-10-06.json`. Requisiti non forzati nelle tabelle entry BGG: database/app invariati; eventuale modello generale richiede decisione distinta. Manutenzione skill collegata a TSK-0048. PWS resta 1.5.0.

## Persistenza multifonte PerGioco — B-v1 adottata

TSK-0076, conferma esplicita 2026-10-06: architettura logica B-v1 e piano identita adottati, nessuna implementazione/importazione. Riferimenti autorevoli in `tasks/2026-10-06 - EPR - Persistenza multifonte per PerGioco/`: `DECISIONE.md`, `MODELLO_LOGICO.md`, `COMPATIBILITA_E_VALIDAZIONE.md`. Estensione generica additiva del nucleo 009, nessun sottocatalogo PerGioco. Osservazioni append-only, esiti CAT separati da sviluppo/matching, categorie native multiple con URL/data e percorsi/segmenti originali, mapping comune vuoto; URL e redirect/login distinti dall'identita, menzioni anche senza URL e prove contestuali. Condizioni/accessi/costi/completezza per ambito separati; gratuita non implica licenza. Crediti per ruolo e lacune senza persone fittizie, istanze distinte da giochi, relazioni fonte prima della proiezione canonica e dipendenza informativa distinta da possesso/acquisto.

Futuro piano limitato a dodici record: otto nuove identita, Abande solo candidato 993, Azul/Blockade 1975/2001 source-only con requisito non dimostrato; esiti CAT 9/3 preservati. Itinera un gioco/due istanze datate e soluzioni separate senza associazioni non provate; Libre variante distinta, nessun arco canonico confermato verso 993 finche Abande resta candidato. Alternative interne non creano giochi. TSK-0074/0075 restano completati; perimetro TSK-0073 invariato. Schema operativo ancora pre-B; nessun backfill/riesame implicito BGG/Kanare. DAT migrazione, DAT importazione, eventuale VER, APP e acquisizioni richiedono autorizzazioni separate; prima dell'operativo prove su copia, idempotenza/collisioni/NULL, backup e ripristino. Anteprime con architecture_adopted=false restano storia della preparazione, decisione corrente in DECISIONE.md. PWS 1.5.0.


## Migrazione 013 operativa — TSK-0077, 2026-10-06

Schema B-v1 implementato e applicato all'operativo con autorizzazione esplicita dopo collaudo: `database/migrations/013_source_evidence.sql`, 21 tabelle generiche nuove e vuote. Legacy completo preservato, nessun dato PerGioco/backfill/matching o APP modificato. Mapping e verifiche in `tasks/2026-10-06 - DAT - Schema multifonte per PerGioco/`; runner offline `database/apply_source_evidence_migration.py`, test e verificatore su copie nella stessa directory database. Ispezione predefinita mode=ro; applicazione richiede --apply/--authorization, backup e restore verificati, transazione esclusiva e confronto completo legacy. Non usare Python -O, INSERT OR REPLACE sulle prove o schema.sql sull'operativo. Replay 013 verifica definizioni esatte e non scrive. Verificatore su copie dopo migrazione richiede --baseline al backup pre-013; nessun downgrade dell'operativo.

Per futuro DAT importazione autorizzato: rispettare modello B-v1 e MAPPING_FISICO, convalidare completezza path/segment_count e hash canonico payload, chiavi stabili/eventi, NULL/collisioni, provenienza/date e proiezioni tipizzate in transazione. Schema disponibile non autorizza importare dodici candidate, formalizzare evidenze BGG/Kanare, confermare Abande o sviluppare APP. Anteprime/verifiche EPR precedenti restano storiche. PWS 1.5.0; Standard read-only.

## Consultazione PerGioco — TSK-0079, 2026-10-08

Integrazione APP B-v1/013 dopo TSK-0078: roster fonte autonomo e schede per ID, ricerca/filtri su titoli/categorie/crediti, classificazioni native, accessi/condizioni/menzioni anche senza URL, istanze/relazioni, crediti e storia. Lettori e SQLite RO preservati; matching candidato non attribuisce prove al canonico. Avanzamento pilota con CAT/ammissione/importazione e identità separate, MAT/ACQ/IMG — senza perimetro. Moduli app/source_evidence.py, app/pergioco_progress.py e static/source-records.js; contratto/matrice/verifiche in tasks/2026-10-08 - APP - Integrazione completa PerGioco/. Nessuna modifica dati/schema/rete esterna; TSK-0067 autonomo, PWS 1.5.0 invariato. Dettagli e denominatori in app/README.md; stato storico preservato.

Nel naming il codice categoria sostituisce le vecchie etichette operative: usare `ACQ - NOME CONTEST/FONTE`, `MAT - NOME CONTEST` e `BGG-M - NOME CONTEST`, senza ripetere Acquisizione materiali, Analisi materiali o Monitoraggio. Per BGG-G e BGG-A usare le forme compatte definite in PROJECT.md/TASK_GOVERNANCE.md. I contratti conservano i nomi estesi dei workflow e i loro vincoli.

Nei titoli visibili e nei nomi dei nuovi task APP non citare mai identificativi di segnalazione (per esempio APP-007 o APP-006); mantenere soltanto il codice di categoria APP. Conservare i riferimenti alle segnalazioni nel corpo dei documenti. La rinomina storica dei titoli è autorizzata dall'utente il 2026-10-04 e tracciata nel registro centrale; i percorsi storici restano invariati.

## Prefisso titoli Codex - 2026-10-10

Decisione TSK-0044: applicazione retroattiva a tutti i titoli visibili del progetto del prefisso `Txxxx-AA.MM.GG`, preservando la parte successiva alla data. Assegnare prima l ID nel registro. Per chat con più registri applicare il primary_task_id secondo TASK_GOVERNANCE.md; preservare gli altri collegamenti. Cartelle nuove e percorsi storici restano nella convenzione YYYY-MM-DD. PWS 1.5.0 invariato.


## Persistenza immagini collaudata — TSK-0067, 2026-10-10

`database/migrations/014_game_images.sql`, `database/image_catalog.py` e `catalog/import_game_images.py` preparano catalogo IMG generico e importazione offline. Modello/contratto in MODELLO_E_IMPORTAZIONE.md di TSK-0067; test/verify solo copie. Prerequisito deliberato: due piloti TSK-0068 sufficienti; altri dodici giochi restano IMG aperto. Schema operativo ancora 013; non applicare 014 né importare lotti senza autorizzazione finale. Default RO, applicazione con backup/ripristino su copia verificati e transazione; omissioni non cancellano, file/identità immutabili e decisioni append-only. Non proiettare prove nel modello 013, non convertire PNG ACQ né implementare UI per implicazione.
