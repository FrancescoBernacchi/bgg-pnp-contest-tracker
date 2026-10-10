Avviamo un task APP autonomo per integrare nella consultazione e nell'Avanzamento PerGioco il lotto Carta e matita importato e verificato in TSK-0081.

Criterio trasversale confermato dall'utente il 2026-10-10: gestire i giochi quanto più possibile in maniera uniforme, evitando gestioni ad hoc per singolo gioco. Implementa componenti e adattatori generici guidati dai dati e dalle capacità (istanze, varianti, raccolte, crediti contestuali, accessi); eventuali differenze funzionali possono riguardare categorie/tipologie di giochi, senza inferire o alterare classificazioni non deliberate. Labirinto, Piattola e gli altri titoli sotto elencati sono casi di accettazione, non motivi per introdurre pagine/componenti o condizioni basate sul loro nome, URL o ID. Le funzioni devono operare anche per altri giochi con le stesse informazioni; verifica questo con almeno un altro record o una fixture sintetica. Mantieni distinta la provenienza delle fonti senza moltiplicare i comportamenti comuni per fonte o titolo. Non autorizza un refactoring generale fuori dal perimetro di questo APP.

Titolo: YYYY-MM-DD - APP - Consultazione e avanzamento Carta e matita PerGioco
Usa la data effettiva di apertura. Non creare un'altra chat automaticamente: questa è la richiesta iniziale della chat APP in cui viene incollata.

Applica AGENTS.md corrente, confronta PWS e consulta tasks/REGISTRY.json prima di aprire il task per evitare duplicazioni. TSK-0079 (consultazione pilota) e TSK-0081 (importazione lotto) sono conclusi: questo è un incremento APP distinto per metriche e informazioni del nuovo lotto, non una riapertura DAT. Collega anche TSK-0080, TSK-0073 e B-v1/013 TSK-0076/0077. TSK-0067 immagini è autonomo e fuori perimetro. Assegna il prossimo ID stabile libero, registra contratto, deliverable e criteri di successo secondo TASK_GOVERNANCE.md e adegua il titolo visibile. Preserva le modifiche preesistenti nel workspace.

Input autorevoli da leggere:
- catalog/pergioco_pilot_2026-10-06.json e catalog/pergioco_extension_carta_matita_2026-10-08.json;
- tasks/2026-10-08 - DAT - Importazione lotto Carta e matita PerGioco/: TASK.md, DECISIONE.md, PIANO_IDENTITA.md, RAPPORTO_COLLAUDI.md, APPLICAZIONE_OPERATIVA.json e OPERATIONAL_VERIFICHE.json;
- TASK.md/RELAZIONE.md/VERIFICHE.json di TSK-0080 e contratto/matrice/verifiche APP di tasks/2026-10-08 - APP - Integrazione completa PerGioco/;
- sources/PERGIOCO-SCOPE.md, PUBLICATION_POLICY.md, modello B-v1 e mapping fisico 013;
- schema e SQLite operativo esclusivamente in sola lettura, app/README.md, app/source_evidence.py, app/pergioco_progress.py, app/source_progress.py, app/server.py, app/static/source-records.js, asset e test pertinenti.

Baseline da riconciliare con le evidenze correnti, senza usare ID numerici come perimetro permanente:
- pilota: 12 record, CAT 12/12, esiti 9 admitted e 3 requirement_not_demonstrated, 8 identità locali confermate, 1 matching candidato Abande e 3 source-only; 2 istanze Itinera;
- Carta e matita: PGCM-001…009, 9 record importati, CAT 9/9, esiti 7/2, 7 nuove identità locali confermate, 0 matching candidato e 2 source-only; 3 istanze Labirinto e 7 varianti Piattola come asserzioni;
- complessivo dei due lotti: 21 record, CAT/importazione 21/21, esiti 16/5, 15 identità locali confermate, 1 candidato e 5 source-only, 5 istanze. Non copertura dell'intero sito. Non convertire 16 admitted in 16 giochi confermati né contare varianti/istanze come ulteriori giochi.

Obiettivo 1 — Avanzamento e denominatori:
Rimuovi la situazione in cui il roster/sintesi includono 21 record ma le barre sembrano descrivere soltanto il pilota senza rendere esplicita la distinzione. Mostra chiaramente totale dei lotti autorizzati e dettaglio pilota/Carta e matita, con denominatori propri e riferimenti/data delle evidenze. Conserva le metriche storiche del pilota come dettaglio, non riscriverne i manifest. Determina il perimetro dai manifest e dalle chiavi stabili, e la persistenza dalle osservazioni coerenti: nessuna completezza inferita dai soli URL o match. Riconcilia coverage_kind pilot_CAT e CAT_carta_matita_batch mantenendoli distinti; osservazioni concorrenti/parziali restano esplicite. Se un record manca o la prova non coincide, mostra incompletezza e limite anziché una percentuale completa. Separa lavoro CAT, ammissione, importazione e identità. MAT/ACQ/IMG restano senza perimetro/attestazione; nessun completamento dedotto da menzioni/file o dal CAT.

Obiettivo 2 — Consultazione delle informazioni già persistite:
Integra assessment_original del nuovo CAT con assessment del pilota, preservando origine, limiti e attribuzioni. Esponi una selezione esplicita di metadati/sintesi necessari tramite l'adattatore RO; non restituire indiscriminatamente payload_json/raw_value o documenti integrali negli endpoint. Non interpretare testi liberi come HTML eseguibile.

Tratta e verifica esplicitamente:
- Labirinto: un sistema, tre istanze con etichette/date raw e normalizzate, qualificazione pecora/lupo del Diagramma 2; schema utilizzabile non attestato (NULL), non assente. Soluzione comune solo dichiarata/non verificata, zero solution_for: non associare contenuti soluzione alle istanze o attestare fruibilità dal link. Itinera resta distinto e conserva le sue due istanze/accessi.
- Piattola: sette varianti nominate distinguibili come asserzioni, con alias e crediti contestuali; Piattola Solitaria conserva Morpion Solitaire/Join Five nel proprio contesto. Nessun nuovo game/record, equivalenza confermata, ammissione separata o alias della variante trasferito al base. Marino Carpignano designer della Variante Simmetrica non diventa designer del base.
- Punti e linee: raccolta source-only con esito requisito non dimostrato, non fusa con Quadratini che dichiara Punti e Linee come alias. I quattro titoli collegati restano rinvii fuori lotto, non nuove schede di giochi importati o ammessi.
- Battaglia Navale: source-only, requisito regole complete non dimostrato; costo/accesso regole complete ignoto, non pagamento o esclusione definitiva.
- Quadratini: alias Boxes/Squares e riferimenti ai giochi ispirati mantengono contesti distinti; nessuna equivalenza automatica. Numerino: crediti dell'adattamento commerciale distinti dal sistema tradizionale. Libri/traduzioni/editori/curatore del sito non diventano designer del sistema principale.
- Crediti e lacune: ruolo, soggetto, stato, URL/data propri; nomi/iniziali ambigui irrisolti, nessuna persona inventata. Beniamo Sidoti preservato come dichiarato nel CAT. Matching candidato Abande continua a non proiettare prove del record sul canonico.
- Classificazioni native multiple, path ordinati, titoli originali/alias/qualificazioni, menzioni anche senza URL e accessi/completezza/costi/condizioni per ambito restano consultabili. Gratuità non implica licenza. Nessuna verifica o acquisizione automatica durante refresh o lettura; apertura dei collegamenti esterni soltanto su azione esplicita utente.

Questa richiesta autorizza implementazione APP e scelte tecniche reversibili nel perimetro, con prove locali. Procedi fino al risultato verificato senza fermarti per riconfermare scelte già comprese. Non creare decisioni di identità o cambiare dati per adattarli alla UI. Se emerge una reale incompatibilità dello schema, documentala e proponi un task EPR/DAT separato continuando il lavoro indipendente; non modificare schema o operativo.

Verifiche richieste:
- matrice requisito → campo/evidenza → API/UI → verifica; denominatori pilota/lotto/totale e separazione CAT/ammissione/identità;
- test mirati a record mancanti, fonte/manifest assente, osservazioni concorrenti/parziali, NULL, candidate/source-only e contesti omonimi; fixture sintetiche o copie isolate senza testi integrali di terzi;
- regressioni BGG/Kanare/pilota, navigazione/ricerca/filtri, attribuzioni, Libreria e lettori;
- QA locale desktop/mobile, leggibilità, tastiera e collegamenti; usare il preflight CUA richiesto da AGENTS.md quando serve browser;
- hash/inventario operativo e file/schema/materiali preservati, SQLite e server RO, nessun nuovo accesso esterno.

Deliverable: implementazione e test pertinenti, matrice e rapporto QA, app/README.md aggiornato, TASK.md/registro/PROJECT_PROGRESS.md coerenti con le metriche effettivamente implementate. Se cambiano soltanto app/metriche senza dati BGG, non alterare manualmente le sezioni annuali generate. Applicare PUBLICATION_POLICY.md: metadati/sintesi originali/crediti e link, prove integrali/screenshot e output rigenerabili locali fuori Git. Alla chiusura indica risultati, limiti residui e prossimo passo utile come attività distinta.

Esclusioni: nessuna importazione o replay applicativo degli importer, migrazione/schema, scrittura operativa, backfill BGG/Kanare, nuova identità/matching, censimento esterno o VER autonomo, MAT/ACQ/IMG, host esterni/download, generazione immagini, automazione, commit/push o altra modifica Git. Le operazioni Git le richiederò separatamente.
