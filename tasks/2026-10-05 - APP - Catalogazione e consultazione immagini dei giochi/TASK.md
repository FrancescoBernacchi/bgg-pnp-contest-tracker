# TSK-0067 — Catalogazione e consultazione immagini dei giochi

Apertura: 2026-10-05. Categoria APP; secondaria DAT. Modalità circoscritto, cadenza su richiesta. Stato in_corso, fase progettazione; implementazione non autorizzata in questa fase.

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
