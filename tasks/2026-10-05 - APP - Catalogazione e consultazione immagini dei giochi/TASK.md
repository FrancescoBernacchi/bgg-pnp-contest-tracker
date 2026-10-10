# TSK-0067 — Catalogazione e consultazione immagini dei giochi

Apertura: 2026-10-05. Categoria APP; secondaria DAT. Modalità circoscritto, cadenza su richiesta. Stato in_corso, fase progettazione; implementazione non autorizzata in questa fase.

**Stato corrente 2026-10-10: completato.** Incrementi 1/2/3 e completamenti nei tre blocchi implementati e collaudati; conclusione richiesta dall’utente dopo riesame visuale e uniformazione della barra IMG a 6 pixel. IMG operativo 014, nessuna ulteriore modifica dati/schema. Prerequisito soddisfatto dai due piloti TSK-0068, che resta autonomo e aperto. Le sezioni precedenti sono storia; verifiche in VERIFICHE_COMPLETAMENTI.json e nota finale di chiusura. Deliverable locali da committare su richiesta.

## Contratto

Supportare nell'app il workflow già deliberato in TSK-0065. Brainstorming progressivo: una proposta e una domanda per punto, registrando separatamente proposte e decisioni. Riepilogare modifiche concordate e piano prima di procedere all'implementazione. Non acquisire, estrarre o generare immagini; non introdurre scrittura nell'app. Validazione AI esplicita dell'utente, registrata tramite Codex. Generazione dalla UI resta evoluzione futura separata.

Input: sources/IMAGE_WORKFLOW.md, sources/IMAGE_CONTEST_CODES.md, TASK.md TSK-0065, app/README.md, database/schema.sql e migrazioni pertinenti, governance e inventario skill.

Deliverable di progettazione: decisioni su persistenza e relazioni, importazione/reconciliation manifest, copertura/filtri, miniature/gallerie/zoom/componenti, principale/fallback, ciclo AI e storico, file/formati/prestazioni, metriche/migrazione e incrementi verificabili. Successo: decisioni esplicite e lacune documentate, compatibilità con Libreria e modello multifonte, piano verificabile riepilogato prima del codice.

## Verifiche di apertura — 2026-10-05

PWS locale/canonico 1.5.0. Preflight sandbox riuscito. Registro: 66 task, nessun APP immagini aperto; TSK-0065 completato e rimanda a APP autonomo. Task Libreria TSK-0034/0035/0040/0041 e metriche TSK-0047 conclusi, riutilizzabili senza duplicarli. Titolo visibile applicato, chat 01a10c8a-b153-7fb3-8242-cebea9edb44a. Main ahead 1 rispetto al riferimento origin/main locale; numerose modifiche pregresse preservate, remoto non verificato. Nessuna operazione Git autorizzata/eseguita.

Inventario skill consultato: brainstorming APP/DAT su documenti locali, nessuna attività coperta dalle skill IMG/BGG/FON; nessuna skill operativa attivata. Schema e migrazioni letti come riferimento, database operativo non modificato.

## Situazione attuale

- games è l'identità canonica; entries collega gioco e contest. Il nucleo 009 conserva record nativi, matching, prodotti, risorse e crediti distinti.
- acquisitions/acquired_files descrivono materiali acquisiti; 011 registra derivati ZIP. Non rappresentano categorie immagini, componenti/lati, catene di ritaglio/AI o validazioni utente.
- Libreria e lettori PDF/PNG/DOCX consultano file registrati via ID, token e percorsi confinati; server in sola lettura. Il supporto PNG dei materiali non equivale alla catalogazione IMG.
- work_progress.py mantiene image_complete_count a zero; 012 attesta altre fasi, senza modello di copertura IMG.
- Workflow IMG e requisiti UI deliberati; nessun lotto operativo collaudato né sigla contest assegnata. Prima importazione dovrà verificare il contratto concreto dei manifest.

## Punto 1 — proposta non deliberata

Separare immagine logica, versioni/file e collegamenti di contesto. Collegamento fondamentale a games.id; associazioni esplicite a entry/contest, prodotto e revisione quando pertinenti, senza estendere un'immagine a tutte le edizioni del gioco. Provenienze multiple conservate. Catene di estrazione/rielaborazione collegate agli originali, anche acquired_files.id per documenti PnP. Copertura della ricerca separata dalla presenza dei file. Nessuna acquisizione ACQ fittizia per registrare IMG.

Esempio: stessa foto in WIP e galleria, un'immagine e due provenienze; nuova versione migliore conserva la precedente; foto di prototipo 2025 non attribuita automaticamente a edizione commerciale. Struttura fisica e SQL da definire dopo discussione.

## Prossimo passo

Discutere il modello a livello gioco con contesti specifici; poi approfondire categorie, versioni e componenti. Nessuna decisione sul punto 1 ancora acquisita.

## Presentazione della revisione approvata — 2026-10-05

L'utente conferma la proposta: ogni immagine estratta mostra nei dettagli materiale di origine e sua versione, segnalando quando proviene da una revisione precedente. Versione materiale distinta dalla versione dell'immagine estratta; ordine revisioni basato su evidenza, non data di download. Nessun requisito aggiuntivo di badge su tutte le miniature deliberato. Prossimo punto proposto: componente distinto dalle sue immagini/lati, dorso condiviso collegato a più componenti, senza duplicare file; proposta da discutere.

## Componenti e lati approvati — 2026-10-05

L'utente approva il componente come entità distinta dalle immagini: identità, sottotipo e collegamenti ai lati, distinguendo revisioni. Nove carte diverse con dorso comune: nove fronti, un'immagine dorso collegata a tutte, consultazione fronte/dorso insieme per carta. Plancia bifacciale: due immagini dello stesso componente. Foto d'insieme classificata Componenti, non componente singolo. Nessuna implementazione. Prossimo punto: importazione offline e riconciliazione dei manifest IMG; proposta ancora da discutere.

## Importazione manifest approvata — 2026-10-05

L'utente approva il percorso manifest IMG → comando offline → database → app in sola lettura, con Rileggi database. Manifest conserva immagini/file/categorie/provenienze/versioni/componenti/validazioni. Importatore con anteprima di aggiunte/aggiornamenti/problemi, backup prima dell'applicazione e storico preservato. Reimportazione idempotente, provenienze aggiunte senza sostituire le precedenti, decisione AI esplicita registrata tramite Codex e importata. Identità incerta, collegamento inesistente e hash discordante segnalati come conflitti senza risoluzione automatica. Assenza da manifest successivo non equivale a eliminazione/scarto. Schema del manifest e transazioni da precisare nel piano tecnico dopo brainstorming e da collaudare; nessun importatore o scrittura app realizzati. Prossimo punto: copertura per categoria e filtri, ricerca distinta dalla disponibilità.

## Copertura e filtri approvati — 2026-10-05

L'utente approva nella scheda gioco una tabella per categoria con ricerca originali, numero originali adottate, AI approvate e AI da valutare distinti. Ricerca parziale/da esplorare/impedita, assenza verificata e non applicabilità esplicite, con perimetro/data consultabili. Presenza di immagini non conclude la ricerca; AI approvata non cancella la lacuna originale; proposte AI, scartate e superate escluse dalla copertura corrente. Filtri trasversali combinabili: categoria, senza originali, senza immagini adottate, ricerca incompleta, AI da valutare. Nessuna metrica aggregata deliberata in questo punto. Prossimo punto: disposizione della scheda immagini e consultazione galleria/zoom; proposta da discutere.

## Sezione immagini approvata — 2026-10-05

L'utente approva nella scheda gioco: galleria adottata con miniature filtrabili per categoria, didascalia e origine AI riconoscibile; vista Componenti per sottotipo con lati affiancati; area separata Proposte AI Da valutare; area Storico inizialmente chiusa per Superate/Scartate. Click miniatura apre ingrandimento con zoom, fit finestra e precedente/successiva. Dettagli con provenienze/crediti/versioni/materiale originale, pagina e ritaglio per estrazioni. Click categoria nella tabella copertura filtra la galleria. Nessuna scrittura UI. Prossimo punto: criteri precisi principale esplicita/fallback provvisorio e miniature nelle liste.

## Principale e miniature approvate — 2026-10-05

Scelta esplicita tramite Codex/catalogo prioritaria. In assenza: Copertina adottata/corrente, poi Setup adottata/corrente, poi segnaposto. Entro categoria originali prima di AI approvate; a parità ordine stabile registrato, non casuale. Proposte/scartate/superate escluse. Dettagli distinguono Principale scelta e Principale provvisoria. File della principale esplicita mancante: conservare scelta, segnalare problema e usare temporaneamente fallback disponibile. Liste con comando Mostra immagini per nascondere miniature senza cambiare principale. L'utente approva tutta la proposta, nessuna categoria aggiunta al fallback. Prossimo punto: cronologia decisioni AI e distinzione validazione/stato corrente.

## Validazione AI e dipendenza prima dell'implementazione — 2026-10-05

L'utente approva due dimensioni distinte: valutazione Da valutare/Approvata/Scartata e uso corrente adottata/Superata. Immagine approvata sostituita resta approvata ma superata; nessuna assimilazione a scarto. Decisioni registrate tramite Codex con data, ID interessati, riferimento alla conferma e motivo quando fornito. Cambi successivi aggiungono storia senza cancellare decisioni precedenti. Proposte pendenti nella sezione dedicata; approvate/adottate in galleria; scartate/superate nello storico con motivi e legami alle sostituzioni.

Vincolo esplicito dell'utente: prima di qualsiasi implementazione APP deve completarsi un altro task dedicato all'acquisizione immagini di un contest del 2025. Contest e ID del task non ancora comunicati; non inventare la dipendenza né aprire un lotto IMG qui. Brainstorming documentale può continuare. Dopo completamento del lotto, leggere manifest e risultati reali, riconciliare il piano e riepilogarlo prima di procedere al codice/migrazioni. La dipendenza non sospende il brainstorming e non dichiara un blocco attuale. Prossimo punto: accesso locale, formati e compatibilità Libreria.

## Accesso locale e formati approvati — 2026-10-05

L'utente approva file sotto library/immagini secondo struttura deliberata, accesso tramite ID registrati con protezioni della Libreria, supporto iniziale PNG/JPEG/WebP per galleria e zoom. Altri formati conservati nel catalogo con assenza di anteprima esplicita. Miniature derivate rigenerabili, originali immutati; caricamento progressivo miniature e immagine grande quando si apre lo zoom. Estrazioni PDF collegate al documento della Libreria. Dettagli tecnici di decoder/limiti/confinamento/cache da verificare nel piano e nei test, non dichiarati già implementati. Prerequisito IMG 2025 invariato. Prossimo punto: metriche avanzamento distinte da disponibilità immagini.

## Metriche: indicazione utente e chiarimento pendente — 2026-10-05

L'utente accetta la distinzione fra completamento del lavoro IMG e disponibilità/copertura immagini, indicando a denominatore il numero delle entry controllate, incluse quelle senza immagini per alcune o tutte le categorie. Non assumere che presenza file sia requisito di inclusione. Il numeratore e l'estensione del termine controllate (avviate oppure esplorazione conclusa) richiedono chiarimento: la proposta precedente usava tutte le entry del perimetro come denominatore per avanzamento annuale, quindi il cambiamento può lasciare fuori entry non ancora controllate. Nessuna formula adottata definitivamente o implementata. Prossimo passo: esempio numerico per distinguere completamento sui controlli avviati da avanzamento sul roster totale. Prerequisito IMG 2025 invariato.

## Metriche chiarite e visualizzazione da provare — 2026-10-05

L'utente precisa che controllate significa ricerca conclusa, anche senza immagini. Dopo chiarimento preferisce una sola barra e una sola torta per immagini, con avanzamento ricerca = entry con ricerca conclusa / totale entry, non due indicatori distinti. L'utente approva di provare un unico elemento a tre segmenti: ricerca conclusa con immagini adottate; ricerca conclusa senza immagini adottate; ricerca non conclusa. Percentuale principale somma dei primi due segmenti sul totale entry. Esempio 100 entry: 12 concluse con immagini, 8 concluse senza, 80 non concluse → 20% completamento. Tooltip con conteggi e distinzione originali/AI approvate; AI pendenti non adottate. Entry con immagini ma ricerca parziale resta nel terzo segmento e il dettaglio rimane consultabile. Copertura per categoria separata nella tabella già approvata.

Soluzione autorizzata come prova visuale da valutare nel futuro incremento APP, non approvazione definitiva di colori/layout né richiesta di anticipare implementazione. Vincolo IMG 2025 preservato; nessuna modifica a codice, database o metriche correnti. Prossimo punto: migrazione e compatibilità dei dati esistenti, poi suddivisione incrementi/piano riepilogativo. Formule tecniche di applicabilità, attestazioni e roll-up per anno/contest da verificare sui manifest reali prima del codice.

## Migrazione additiva approvata — 2026-10-05

L'utente approva nuove tabelle immagini/versioni/provenienze/componenti/decisioni/ricerca, collegate a giochi e materiali esistenti. Nessuna conversione automatica dei PNG Libreria in immagini IMG; potrebbero essere fogli stampabili. Primo lotto importato dal manifest IMG 2025 dopo verifica su copia del database. Compatibilità app mantenuta anche senza nuovi dati; immagini non ancora censite distinte da assenza verificata. Migrazione progettata come additiva, non eseguita. Prerequisito completamento IMG 2025 invariato. Prossimo punto: proposta incrementi verificabili da confermare, poi riepilogo piano concordato.

## Proposta incrementi — non ancora deliberata

Prerequisito: task IMG contest 2025 completato, ID/contest da collegare; riesame manifest reale e piano prima del codice.

1. Persistenza e importatore offline: schema additivo/contratto manifest, anteprima, backup, transazioni, idempotenza, conflitti, cronologia e prova su copia. Verificare che reimportazione non duplichi e assenza da manifest non cancelli record.
2. Accesso file/API consultive e scheda immagini: formati/limiti, miniature, galleria/zoom, dettagli/provenienze, componenti/lati, proposte/storico; test confinamento e originali invariati, browser desktop/stretto.
3. Liste/copertura/avanzamento: principale/fallback, miniature nascondibili, tabella e filtri, metriche condivise app/cruscotto e prova barra/torta tre segmenti. Verificare conteggi con casi senza immagini, AI pendenti e ricerca parziale; valutare leggibilità visuale con utente.

Ogni incremento con verifiche e documentazione; schema operativo solo dopo prova/backup. Generazione/scrittura UI escluse. Ordine e suddivisione da confermare, nessun codice avviato.

## Piano incrementi approvato e chiusura fase brainstorming — 2026-10-05

L'utente approva ordine e contenuto dei tre incrementi proposti sopra: dati/importazione; consultazione scheda/file; liste/filtri/avanzamento. La proposta precedente diventa piano concordato senza riscriverne la storia. Brainstorming concluso; task APP resta in_corso, fase progettazione conclusa e implementazione in attesa del prerequisito IMG 2025. Nessuna sospensione esplicita richiesta e nessun codice/schema operativo modificato.

### Riepilogo concordato

- Raccolta per gioco con contesti pertinenti distinti; versioni/file/provenienze tracciabili. Preferenza per revisione materiale più recente, originali preservati, contenuti unici recuperabili; materiale/versione nei dettagli.
- Componenti con identità/sottotipo/revisione, lati collegati e dorso condiviso senza duplicare file.
- Manifest IMG importati offline con anteprima/backup/idempotenza/conflitti e storico; decisioni utente registrate tramite Codex, app consultiva.
- Copertura per categoria con ricerca, originali, AI approvate/proposte separati; filtri lacune/ricerca incompleta/AI pendenti.
- Galleria adottata, vista componenti, proposte AI separate, storico chiuso; zoom/fit/navigazione e dettagli fonte/crediti/versioni.
- Principale esplicita o fallback Copertina → Setup → segnaposto; originali prioritari entro categoria, ordine stabile, scelta preservata se file mancante; miniature liste nascondibili.
- Valutazione AI distinta da uso corrente; decisioni storicizzate, scartate/superate fuori galleria/copertura corrente.
- PNG/JPEG/WebP locali per ID con protezioni Libreria, miniature derivate progressive, originali immutati, formati ulteriori catalogati con limite anteprima esplicito.
- Una barra/torta a tre segmenti da provare; percentuale ricerca conclusa/totale entry, esiti senza immagini contano come conclusi, disponibilità resa dai segmenti/tooltip; categorie in tabella separata.
- Migrazione additiva senza conversione automatica PNG ACQ; prova/backup su copia, compatibilità senza dati IMG e primo import dal lotto reale.

### Condizione di ripresa implementazione

Completare il task IMG del contest 2025; identificare contest e ID (ancora non comunicati). Leggere manifest/evidenze reali, riconciliare contratto/schema e casi dubbi, presentare eventuali scostamenti dal piano prima dell'implementazione. Solo allora iniziare incremento 1. Nessuna nuova acquisizione/generazione autorizzata da APP; generazione AI nella UI resta evoluzione futura distinta.

### Verifiche fase documentale

Decisioni registrate per punto, registro/cruscotto aggiornati. JSON registro verificato leggibile e ID unici; TASK.md presente. Nessun test app necessario: nessun codice modificato. Documenti da committare, working tree preesistente preservata; nessun commit/push eseguito. Prossimo passo utile: completamento IMG 2025 e riesame del manifest nella ripresa di TSK-0067.

## Commit richiesto ed eseguito — 2026-10-05

Commit locale 74f2343 su main: docs: definisci supporto immagini giochi e piano APP. Quattro file, 206 righe aggiunte: TASK.md, sola voce TSK-0067 del registro, sole note TSK-0067 nel cruscotto, integrazione ultima revisione nel workflow. Preparazione selettiva dell'indice dai contenuti HEAD, senza alterare working tree o includere incrementi preesistenti nei file condivisi. Diff staged/check verificati, indice vuoto dopo commit. Audit globale eseguito: 299 candidati preesistenti in 30 percorsi, nessun commit in uscita prima dell'operazione; revisione puntuale dei quattro candidati senza rilievi (documentazione originale, nessun asset/testo integrale/credenziali). Report locali in outputs/tsk0067-publication-audit.json e tsk0067-commit-review.json. Nessun push; main ahead 1 sul riferimento locale origin/main, remoto non verificato. Modifiche degli altri task preservate. Questa attestazione successiva al commit e il relativo aggiornamento del registro restano locali da salvare in un successivo incremento documentale.

## Decisione e chiarimento — 2026-10-05

### Integrazione utente: versione più recente dei materiali

L'utente aggiunge ai criteri IMG la preferenza sempre per la versione più recente dello stesso materiale, accanto a finale/draft, colore/bn e hi-res/lo-res. Decisione promossa in sources/IMAGE_WORKFLOW.md il 2026-10-05; originali già acquisiti preservati, componenti unici recuperabili da revisioni precedenti. Revisioni differenti non diventano duplicati; la preferenza riguarda la raccolta corrente. Per il futuro modello APP servono revisione del materiale e successione documentata, distinte dalla versione del file immagine e dalla data di acquisizione. Nessun codice o dato operativo modificato. Skill IMG e riferimento extraction letti per verificare compatibilità; non eseguito workflow IMG. Il riferimento della skill rinvia al workflow autorevole; le vecchie revisioni restano distinte come già prescritto.

L'utente approva la raccolta incentrata sul gioco. Restano da discutere i dettagli del modello. Chiede frequenza e ammissibilità delle partecipazioni multiple: l'esempio inventato precedente non rappresentava una casistica verificata.

Query SQLite in sola lettura: 1.382 entry e 1.382 game_id distinti; nessun game_id associato a più contest nel catalogo operativo. Limite: misura i collegamenti attuali, non prova assenza di identità duplicate/non riconciliate o frequenza generale BGG.

Regole verificate tramite risultati indicizzati BGG il 2026-10-05: Traditional Deck 2026 vieta precedenti partecipazioni con possibile eccezione 24 Hour; 54-Card 2026 vieta altri contest BGG con eccezione 24 Hour. Fonti: https://boardgamegeek.com/thread/3761810/2026-traditional-deck-game-design-contest e https://boardgamegeek.com/thread/3746297/2026-54-card-game-design-contest/page/1. Apertura diretta web 403; evidenza limitata al testo indicizzato, non audit di tutte le edizioni. Applicata skill bgg-contest-navigation per consultazione puntuale, nessun censimento o rilevamento periodico.

La struttura per gioco resta motivata anche da revisioni e provenienze multiple, indipendentemente dalla partecipazione a più contest. Quest'ultima è possibilità da collegare solo con evidenza, non casistica assunta frequente. Prossimo punto: identità dell'immagine, versioni e componenti.

## Prerequisito identificato — 2026-10-05

TSK-0068, IMG Children & Family Game Design Contest 2025: lotto autorizzato di 14 giochi già acquisiti, non intero contest. Attendere completamento e riesaminare manifest catalog/evidenze di integrità, condizioni, componenti/lati, revisioni e ricerca per categoria. Nessuna implementazione anticipata; precedenti riferimenti a identità non comunicata restano storici.

## Primo manifest IMG parziale — 2026-10-05

TSK-0068: catalog/2025_children_family_image_sources_2026-10-05.json verifica 38 PDF e 14 giochi; catalog/2025_children_family_images_2026-10-05.json registra quattro artwork CC0 game_id 505, copertura per categoria parziale e impedimenti. Prerequisito non concluso (ricerca 0/14): non iniziare implementazione. Relazioni componenti/lati/occorrenze e successioni materiali ancora da collaudare; condizioni BGG/composizioni da risolvere. Riesaminare questi manifest come contratto sperimentale, non schema definitivo o attestazione completa.

## Manifest pilota componenti — 2026-10-05

TSK-0068 ripreso con uso privato ribadito; manifest immagini ora contiene 15 PNG (4 sorgenti + 11 estratti), 9 tipi carta, dorso comune e tabellone. Occorrenze fisiche stampate distinte da contenuti e relazioni: 26 fronti, 9 dorsi nel documento, una cella vuota esclusa. Non interpretare numero dorsi stampati come numero carte totali. Condizioni private non diventano licenza pubblica; crediti designer mancanti espliciti. Ricerca del lotto non conclusa, implementazione resta in attesa.

## Evidenze pilota IMG — 2026-10-05

TSK-0068 ha chiuso Mermaids vs Dinosaurs nel perimetro osservabile, con limiti documentati (pagina galleria richiede login; revisione live Docs non confrontata integralmente senza nuova esportazione ACQ). Lotto ancora 1/14: prerequisito complessivo non concluso. Riesaminare catalog/2025_children_family_images_2026-10-05.json e catalog/2025_children_family_image_sources_2026-10-05.json: 17 immagini attuali, 18 file fisici incluso historical_files con tabellone v01 Superata e identità stabile v02; 10 componenti, fronti/dorso comune e occorrenze; foto Setup anche Componenti senza raddoppiare file; logo draft, foto prototipo, crediti Nico designer/uploader distinti da fotografo e autore grafico non dichiarati; occorrenza logo manuale inferiore non duplicata, assenze per categoria circoscritte. Nessun importatore/app/schema/metriche implementato da IMG.

## Evidenze secondo pilota ICBRG — 2026-10-05

TSK-0068 incremento 5: manifest complessivo 44 immagini attuali + 1 storico, ricerca 2/14 con limiti. ICBRG aggiunge 27 immagini: 6 file remoti distinti da 9 ID BGG deduplicati per SHA-256, 7 file componenti/6 identità (due sagome grigie con scala diversa), 9 diagrammi/setup renderizzati e 5 artwork raster nativi. Riesaminare side_regions Fronte/Retro/Base nelle strisce standee e i loro legami/occorrenze: sono stampati da assemblare, non fogli fronte/dorso. Categorie aggiuntive non moltiplicano i file. Riferimento BGG 446904 esplicitamente dichiarato nel WIP associato all'ID locale 507, nessuna identità dal nome. Designer/uploader separati da illustratore/fotografo ignoti; limiti galleria autore 117 immagini con login e vecchio WIP non risolto, dipendenze ACQ per altri PDF. Importatore/schema/metriche ancora non implementati e prerequisito lotto ancora aperto.

## Valutazione sufficienza campione — 2026-10-10

Su domanda dell'utente, riesaminati registro, manifest e TASK TSK-0068: due piloti (Mermaids vs Dinosaurs/ICBRG), 44 immagini correnti e un file storico, 16 componenti, provenienze multiple/deduplica, categorie aggiuntive, lati/dorso condiviso/regioni assemblaggio, revisioni e ricerche complete/parziali con limiti. Campione tecnicamente sufficiente per iniziare progettazione fisica/importatore e consultazione senza richiedere ulteriori acquisizioni come requisito tecnico. Casi AI e formati non rappresentati possono essere verificati con fixture sintetiche; nessuna generazione necessaria per sviluppare gli stati. Non certificata nuova integrità byte per byte in questa lettura; verifiche hash documentate nel task IMG da ripetere nell'importazione.

Prerequisito contrattuale invariato: IMG ancora in_corso, 2/14 ricerche concluse. La domanda di sufficienza non revoca da sola il vincolo precedente di completamento del lotto prima del codice. Raccomandazione: consentire avvio APP sui due piloti senza attendere le ulteriori 12 ricerche, se l'utente delibera tale modifica. Nessuna implementazione o nuova acquisizione eseguita. PWS 1.5.0 allineato; titolo conforme T0067-26.10.05. Working tree con modifiche di altri task preservata. Lettura locale APP, nessun workflow IMG/BGG attivato.

## Incremento 1 autorizzato — 2026-10-10

L'utente conferma che i due piloti TSK-0068 sono sufficienti: il completamento degli altri dodici giochi non è più prerequisito APP, TSK-0068 resta aperto. Autorizzati migrazione additiva e importatore offline generici, prove su copie e documentazione; esclusi UI, API file, metriche operative, acquisizioni/AI e applicazione al database operativo senza successiva approvazione. Nessun commit/push autorizzato in questo incremento.

PWS 1.5.0 allineato, preflight lettura e Git riusciti; warning InitializeDefaultDrives PowerShell distinto da setup refresh, superato usando cmd per comandi locali. Main allineato al riferimento origin/main locale, remoto non verificato; modifiche di altri task preservate. Schema 013 e attestazioni multifonte esistenti da mantenere integralmente. Inventario skill consultato: attività APP/DAT offline, nessun workflow acquisizione/estrazione/BGG né skill operativa pertinente attivati. Piano: identità immagini/file immutabili + osservazioni append-only e proiezioni consultive; JSON canonico per evidenze compositive non riducibili a campi, relazioni tipizzate per consultazione. Prove sul lotto reale completo come manifest, senza dichiarare concluse le 12 ricerche parziali.


## Collaudo incremento 1 — 2026-10-10

Migrazione 014 additiva e importatore offline implementati. Modello/contratto/mapping in MODELLO_E_IMPORTAZIONE.md; strumenti database/image_catalog.py, apply_image_catalog_migration.py, verify_game_images.py, test_game_images.py e catalog/import_game_images.py. Schema operativo resta 013; schema.sql non aggiornato prima della decisione operativa. Nessuna modifica UI/API/lettori, nessun download o AI reale, nessun PNG ACQ convertito.

Riconciliazione su identità dichiarate, non nomi/ID dei piloti: 44 immagini, 45 file incluso storico, 16 componenti, 15 regioni e 30 legami; 55 categorie, 96 provenienze, 111 occorrenze, 24 relazioni. Manifest/fonti completi conservati nel SQLite locale, con payload contestuali per crediti/condizioni/limiti. Nessuna proiezione o matching automatico nel modello 013; collegamenti source_record solo confermati, prodotti/entry coerenti con gioco. Revisioni materiali distinte dalle versioni immagini; nessun ordinamento dedotto dalle stringhe.

32 test sintetici riusciti: preservation/backup/restore, no-write anteprima e replay, omissioni, conflitti file/hash/identità/contesto, partial manifest con riferimenti già importati, categorie/provenienze multiple, dorso condiviso, regioni, PNG/JPEG/WebP e ciclo AI pending/approved/rejected/reapproved con conferme datate. AI sintetiche riutilizzano raster di test, nessuno strumento di generazione invocato. Rollback verificato sia durante DDL sia dopo importazione prima del commit. Prime prove corrette per temp sandbox Windows e chiusura esplicita delle connessioni SQLite; nessuna modifica ACL/escalation.

Collaudo sui manifest reali con verifica di 45 immagini e 38 documenti: migrazione isolata e importazione combinata su copie, replay senza scrittura, backup/ripristino equivalenti, integrity/FK validi. Preservate definizioni e tutte le 18.996 righe delle 62 tabelle preesistenti, compresa B-v1/013. Ricerche concluse 2, parziali/non esplorate 12; nessuna inferenza dalla presenza di file. Zero principali esplicite e zero decisioni AI nei manifest reali. Report riproducibile in VERIFICHE_INCREMENTO1.json; copie/backup/rapporti completi solo in outputs, esclusi da Git.

Task resta in_corso, incremento tecnico collaudato; passaggio operativo attende il consenso finale richiesto dall'utente. Prerequisito corrente registrato nel registro; le precedenti condizioni di attesa del lotto completo rimangono storia. TSK-0068 invariato/aperto. Nessuna nuova decisione funzionale indispensabile per questo lotto; limiti futuri (source-only senza identità canonica, successioni materiali comparabili, coordinate nuove) esplicitati nel contratto.

Governance: PWS locale/canonico 1.5.0; nessuna migrazione PWS necessaria. Titolo T0067-26.10.05 conforme e percorso storico preservato. Registry aggiornato solo nella voce TSK-0067; documentazione/cruscotto aggiornati, sezioni annuali generate non modificate perché dati operativi invariati. APP/DAT locale: nessuna skill di acquisizione applicata, attestazione efficacia non pertinente. Nessun commit/push/branch eseguito. Il commit documentale 74f2343 resta evento storico, questo incremento è da committare solo su richiesta.

Prossimo passo utile: autorizzazione esplicita per applicare schema 014 e importare gli stessi due manifest nel database operativo, in una transazione con backup/ripristino verificati e nuova anteprima; solo dopo eventuale avvio separato dell'incremento consultivo APP.


## Applicazione operativa autorizzata e verificata — 2026-10-10

L'utente risponde «Autorizzo» al riepilogo concreto della migrazione 014 e dell'importazione. Preflight sandbox/lettura e PWS 1.5.0 eseguiti; main allineato al riferimento locale origin/main, altre modifiche preservate. Ricontrollati hash di tutti gli strumenti collaudati, dei due manifest e del database pre-014: coincidenti con VERIFICHE_INCREMENTO1.json. Anteprima nuova senza conflitti, 45 immagini/file e 38 documenti verificati.

Schema 014 e import applicati all'operativo nella stessa transazione esclusiva con backup e prova di restore equivalenti. Conservate definizioni e 18.996 righe delle 62 tabelle precedenti. Risultato operativo: 44 immagini logiche, 45 file, 16 componenti, 15 regioni, 96 provenienze e 111 occorrenze; copertura ancora due ricerche concluse e dodici parziali/non esplorate. Integrità e FK valide; verifica di replay restituisce already_imported senza scrivere. Manifest e originali invariati. Percorsi/hash backup ed esiti in OPERATIVO_VERIFICHE.json; copie in outputs/image-catalog-014/operational escluse da Git.

schema.sql allineato al blocco 014 per nuove installazioni e verificato in SQLite in memoria, senza eseguirlo sull'operativo. Le note precedenti di attesa descrivono lo stato prima del consenso. Incremento 1 concluso; TSK-0067 resta in_corso per incrementi 2/3. UI/API/grafici invariati, nessuna acquisizione/generazione AI, nessun commit/push. Registro/documentazione/cruscotto aggiornati; sezioni annuali non rigenerate perché contest/entry/MAT/ACQ legacy non modificati. Prossimo passo utile: concordare avvio della consultazione immagini; il presente consenso non anticipa modifiche visive.


## Incremento 2 avviato — 2026-10-10

L’utente chiede «continua» dopo completamento operativo incremento 1: avvio consultazione schede/file secondo piano approvato. Perimetro: API IMG in sola lettura, accesso per ID confinato/hash e miniature derivate, galleria filtrabile/zoom, provenienze/crediti/condizioni, componenti/lati/regioni, proposte AI e storico. Liste/principale-fallback/metriche restano incremento 3; nessuna scrittura UI, acquisizione, AI o Git. PWS 1.5.0 allineato, task 0067 ripreso senza duplicati, altre modifiche locali preservate. Preflight completato dopo latenza dei processi, comando/lettura riusciti; nessun errore setup refresh. Nessuna skill acquisitiva pertinente per sviluppo APP locale.


## Incremento 2 completato — 2026-10-10

Implementati app/game_images.py e static/game-images.js, collegati genericamente alle schede giochi: galleria adottata con filtri categoria/provenienza, miniature progressive, zoom Adatta/100%/150%/200%, navigazione frecce/Escape, pannelli fonti/crediti/condizioni/contesti/occorrenze, componenti e lati condivisi, regioni Fronte/Retro/Base documentate, risultati AI non adottati e storico chiusi inizialmente. Principale esplicita solo annotata quando presente; nessun fallback o miniatura nelle liste anticipati. Region metadata conserva coordinate originali: non produce ritagli/inversioni o nuovi file, per standee mostra l'immagine intera e le regioni dichiarate. Ricerca e applicabilità consultabili senza metriche/grafici nuovi.

API /api/games/{id}/images e /api/image-files/{file_id}/{thumbnail|original} consultive; nessun percorso del client accettato. Confinamento anti-link/reparse ereditato dalla Libreria, handle stabile e hash verificati anche prima della cache. PNG/JPEG/WebP controllati con Pillow, immagine animata/multipagina rifiutata; limiti 128 MiB/40M pixel/16000 lato. Miniature PNG massimo 360×240 solo in memoria, cache LRU 24 MiB/128 voci; due decodifiche e due fetch thumbnail simultanei, con riuso client per dorsi condivisi. EXIF applicato ai soli derivati; byte originali serviti invariati. Richieste file richiedono sessione viewer e same-origin, nessun endpoint di scrittura. Schema pre-014 compatibile con messaggio catalogo non disponibile.

Verifiche: 41 test IMG passati (32 persistenza + 9 consultazione), 17 regressioni server passate. Browser Edge headless: due piloti a 1400/780/390 px, galleria/miniature/filtri/componenti/regioni/storico/zoom/tastiera, ricerca parziale, fixture UI AI pending/rejected e XSS, compatibilità Libreria; zero richieste esterne, zero errori pagina e nessun overflow. Schermate locali ispezionate, immagini caricate e layout leggibile. Browser/script sintetici non scrivono SQLite e non generano AI. Report in VERIFICHE_INCREMENTO2.json, screenshot solo outputs/image-qa esclusi da Git.

Latenza iniziale processi risolta senza modifica sandbox. HTTP nel sandbox ordinario falliva WinError 10013; test eseguiti fuori sandbox solo su localhost/database temporanei. Server QA sandbox non raggiungibile dall'esterno: runner ha avviato e chiuso server/Edge nello stesso ambiente. Server QA iniziale 8795 chiuso selettivamente; nessuna app utente coinvolta. Nessuna auto-review rejection, ACL o directory di controllo alterate. Nessuna skill acquisitiva applicata, attestazione efficacia non pertinente.

Database e manifest operativi invariati per SHA-256; ricontrollati byte/hash di 45 immagini e 38 PDF originali. Nessuna acquisizione, generazione, schema o dato cambiato. Registro, guida APP, mappa e cruscotto aggiornati; sezioni annuali generate e metriche condivise invariate. TSK-0067 resta in_corso per incremento 3; TSK-0068 autonomo e aperto. Nessun commit/push. Prossimo passo: miniature nelle liste, principale esplicita/fallback, filtri lacune e avanzamento condiviso con barra/torta a tre segmenti secondo piano; riavviare l'app già aperta per caricare i nuovi moduli server.

## Avvio incremento 3 — 2026-10-10

Autorizzazione utente «OK, procedi»: principale/fallback, miniature liste nascondibili, copertura e filtri, metriche condivise e prova barra/torta tre segmenti. PWS 1.5.0 allineato; Git main con modifiche pregresse preservate. Nessuna modifica dati/schema, acquisizione/AI o Git autorizzata in questo incremento. Baseline DB registrata prima dei collaudi.

## Liste, copertura e avanzamento IMG — TSK-0067 incremento 3, 2026-10-10

Implementati riepiloghi generici in app/image_progress.py, principale esplicita e fallback temporaneo Copertina → Setup → segnaposto, originali prima di AI approvate entro categoria, ordine stabile per identità immagine. Scelta esplicita indisponibile conservata e segnalata; nessuna scrittura UI. Giochi e liste entry hanno comando Mostra immagini (inizialmente disattivato) e filtri combinabili categoria/copertura: ricerca non conclusa, conclusa senza immagini, originali mancanti, AI adottate/pendenti, assenza originali attestata. Preferenze conservate nella sessione di navigazione. Miniature locali progressive tramite sessione protetta, due richieste simultanee, URL blob revocati a uscita/refresh; nessun file derivato scritto. Scheda: principale scelta/provvisoria e tabella categorie con applicabilità, ricerca, originali, AI adottate e pendenti; click categoria filtra la galleria.

Metriche condivise work_progress.py/generatore: denominatore tutte le entry del contest, completamento solo ricerca esplicitamente conclusa per quella entry e quel contest. Segmenti esclusivi: concluse con immagini adottate, concluse senza, non concluse. Presenza per gioco non completa altri contesti; AI pendenti non sono adottate; immagini di ricerche parziali restano nel terzo segmento. Viola/ocra/grigio nella singola barra e singola torta, descrizioni accessibili e conteggi; originali/AI distinti (le due quantità possono sovrapporsi). Zero entry mostra —. Copertura categorie separata dall’indicatore complessivo. Kanare/PerGioco senza lotto IMG mantengono denominatori/perimetri propri: nessuna attestazione implicita o nuova selezione.

Collaudo: 41 test IMG, 8 nuovi metriche/scelta, 17 server, 7 metriche condivise; browser tre larghezze 1400/780/390 con miniature opzionali, filtri giochi/entry, principale, copertura/galleria, grafici e esempio 12/8/80. Nessun overflow/errore pagina/richiesta esterna. Verifiche in VERIFICHE_INCREMENTO3.json; schermate locali outputs/image-qa. Database immutato per SHA-256 e ricontrollati 45 file IMG e 38 PDF originali. Sezioni annuali cruscotto rigenerate con il generatore in sola lettura; nessuna migrazione, acquisizione, generazione o operazione Git.

Implementazione dei tre incrementi conclusa; task in_verifica per la valutazione visuale con l’utente richiesta nel piano della prova barra/torta. Riavviare l’app per caricare server e asset. Prossimo passo: verificare con l’utente leggibilità di liste/copertura/grafici, poi eventuale chiusura e commit solo su richiesta. TSK-0068 resta aperto e indipendente.

Verifica finale incremento 3: ulteriori 10 regressioni Avanzamento multifonte passate (83 test Python complessivi). Percentuali immagini a un decimale, anche nel cruscotto, per evitare 0% su piccoli avanzamenti; conteggi/segmenti restano la misura esatta. Verificata contiguità dei segmenti 12/8/80 nel browser e ispezionate schermate mobile. Report aggiornato agli hash finali del codice; SQLite operativo ancora immutato.

Ispezione visuale: individuato blocco CSP delle larghezze dichiarate negli attributi HTML. Corretto con data-image-percent e assegnazione delle proprietà CSS nel binding BGG, senza modificare la CSP. Il test browser verifica anche larghezza/altezza non nulle e contiguità dei segmenti; schermata sintetica 12/8/80 e grafico operativo mobile ispezionati dopo la correzione.

## Completamenti autorizzati — 2026-10-10

Utente autorizza i tre blocchi: indicatore contest/link entry; condizioni combinabili e ricerca per categoria; revisione materiale precedente e componenti per sottotipo. TSK-0067 ripreso senza duplicati. PWS 1.5.0 allineato, main con modifiche pregresse preservate; nessuna operazione Git. Stato in_corso durante correzioni; baseline DB registrata. Nessuna acquisizione, generazione o modifica operativa dati/schema.

## Completamenti dei tre blocchi — TSK-0067, 2026-10-10

Blocco 1: colonna Acquisizione immagini nella tabella annuale dei contest, conteggio ricerche concluse/totale entry e tre esiti distinti; link dalla scheda entry alla raccolta della scheda gioco. Children & Family: 2/27, 2 con immagini adottate, 0 senza, 25 non concluse; lotto IMG di 14 giochi distinto dal roster completo.

Blocco 2: categoria/stato e condizioni indipendenti combinabili in AND (Senza originali, Senza immagini adottate, Ricerca incompleta, AI da valutare), con azzeramento filtri. Senza immagini adottate vale anche per ricerca aperta. Ricerca della categoria selezionata usa le proprie attestazioni contestuali; nelle entry filtra esattamente entry/contest, senza trasferire completezza da altri contesti o dal gioco. Esiti non riconosciuti restano non attestati; assenza file non certifica assenza verificata. Il selettore galleria include le categorie della ricerca anche senza file, quindi click su copertura mantiene categoria e galleria vuota.

Blocco 3: componenti raggruppati per sottotipo registrato, filtro sottotipo e lati affiancati, dorso condiviso riusato. Dettagli immagine: avviso revisione precedente solo con dichiarazione esplicita e prova di successione, indipendente dalla versione immagine/data download/stato storico. In assenza di prova l’ordine resta non attestato. Nessuna riclassificazione o nuova inferenza.

Collaudo: 69 test Python mirati passati (41 IMG, 17 server, 11 metriche/revisioni); tre suite browser desktop/tablet/mobile 1400/780/390 per nuovi blocchi e regressioni galleria/liste/grafici. Fixture di soli metadati per filtri simultanei, ricerca categoria parziale con gioco concluso, assenza immagini a ricerca aperta e revisione precedente; nessuna AI generata. Zero errori pagina, richieste esterne e overflow; tabella larga resta scorrevole su mobile. Ispezionate schermate locali. SQLite immutato per SHA-256, 45 immagini e 38 PDF originali ricontrollati; manifest/schema/metriche aggregate invariati. Nessuna rigenerazione annuale necessaria: cambia esposizione/filtraggio UI, non conteggi o dati. Nessuna skill acquisitiva pertinente applicata; nessun commit/push.

Stato in_verifica: completamenti funzionali autorizzati implementati, resta valutazione visuale utente di barra/torta secondo piano. Report VERIFICHE_COMPLETAMENTI.json; precedenti dichiarazioni di chiusura incremento 3 conservate come storia e rettificate da questo riesame. Riavviare app. Prossimo passo: verifica visuale utente ed eventuale chiusura, poi commit solo su richiesta. TSK-0068 autonomo e aperto.

## Uniformità altezza barra immagini — 2026-10-10

Su richiesta esplicita dell’utente, uniformata l’altezza della barra IMG da 12 a 6 pixel, come le altre barre di avanzamento. Segmenti, colori, legenda e conteggi invariati. Superata la regressione browser app/test_image_progress_browser.cjs a 1400/780/390 pixel: segmenti contigui e visibili, nessun overflow, errore pagina o richiesta esterna. Correzione solo CSS; nessuna modifica dati/schema, commit o push. Task ancora in_verifica per valutazione visuale utente.

## Chiusura — 2026-10-10

L’utente richiede la conclusione dopo il riesame visuale e la correzione dell’altezza della barra immagini: completata la verifica utente prevista dal piano. Stato finale **completato**. Consegnati persistenza 014 e importatore offline con anteprima/validazione/idempotenza/backup/transazione, consultazione locale immagini e storico, componenti e provenienze, principale/fallback, miniature e filtri, copertura e avanzamento condiviso. Evidenze: OPERATIVO_VERIFICHE.json, VERIFICHE_INCREMENTO1/2/3.json e VERIFICHE_COMPLETAMENTI.json; regressione finale barra responsive superata. Limiti documentati in app/README.md e MODELLO_E_IMPORTAZIONE.md. Nessuna ulteriore implementazione necessaria nel perimetro concordato.

PWS 1.5.0 allineato. Registro e cruscotto aggiornati; storia precedente preservata. TSK-0068 resta aperto e autonomo: ulteriori immagini non sono prerequisito di questa chiusura. Generazione AI dalla UI rimane evoluzione futura distinta; app in sola lettura. Nessun commit/push eseguito: prossimo passo consigliato, su richiesta, salvataggio Git selettivo dei deliverable, preservando le modifiche degli altri task.

## Salvataggio Git autorizzato — 2026-10-10

L’utente richiede commit e push. Preparazione selettiva dei deliverable TSK-0067 e delle sole parti IMG nei documenti/file condivisi; modifiche indipendenti ad attribuzioni, PerGioco, MAT e classifiche conservate nella working tree. Fetch origin: HEAD e origin/main allineati, nessun commit pregresso in uscita. Verificati .gitignore e policy pubblica: database, materiali e screenshot esclusi; audit euristico dei 39 file candidati senza rilievi. Verifica delle versioni selezionate su checkout isolato prima del commit; nessuna modifica agli originali operativi. Esito e identificativi Git da registrare dopo l’operazione.

Collaudo selezione: 59 test passati sul checkout isolato delle versioni candidate (41 IMG, 11 metriche/revisioni, 7 metriche condivise). Il primo tentativo nel sandbox ha incontrato esclusivamente restrizioni socket/Temp Windows; ripetizione fuori sandbox riuscita, senza dati operativi. Audit generale: 299 rilievi in 30 file preesistenti estranei ai candidati, nessun commit pregresso in uscita; contenuti estranei non inclusi. Audit specifico dei candidati senza rilievi; riepiloghi originali/schema/codice/test sintetici e metadati di verifica, nessun materiale binario o testo integrale acquisito.

## Commit e push verificati — 2026-10-10

Commit funzionale `a944081` su main: 39 file/porzioni IMG, persistenza/importatore e consultazione/metriche/chiusura TSK-0067. Push origin/main riuscito; hash server `a944081b3b260163e24dd75d5f8f3010097a331c` verificato direttamente, confronto HEAD/origin/main 0 avanti e 0 indietro. 59 test delle versioni selezionate passati su checkout isolato; diff --check e audit candidati/commit in uscita senza rilievi. I 299 rilievi generali rimangono in contenuti preesistenti estranei al commit, non pubblicati in questo incremento. Materiali, database e screenshot esclusi. Modifiche degli altri task preservate localmente. Questa attestazione viene salvata in un successivo commit documentale; task completato, raccolta TSK-0068 autonoma.
