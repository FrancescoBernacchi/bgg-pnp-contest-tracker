# Estrazione da materiali acquisiti

## Ulteriori prove TSK-0068 — 2026-10-12

Peng Wins e Submarine Adventure: oggetti raster delle carte complete confrontati con tutti i fogli; un dorso comune collega più carte e conserva ogni occorrenza, senza una copia per fronte. Nel manuale Submarine, la conversione iniziale RGBA→RGB perdeva alpha e rendeva nero lo sfondo di dado/pesce/granchio. Il render ricompone correttamente il contesto, ma il successivo controllo ha verificato raster nativi RGBA completi 300×300, preferiti preservando la trasparenza originale. Confrontare oggetto nativo e render; usare il render come fallback se maschere, testo o vettori non sono già composti. Non attribuire all'originale un difetto introdotto dalla conversione.

Panic Picasso: le carte sono testo/vettori, senza oggetti raster; render a 300 DPI e ritaglio entro i confini verificati conservano parole, numeri e bordo. I tre gettoni hanno due facce adiacenti da incollare: un'immagine intera per gettone, regioni Fronte/Retro collegate e quantità fisica uno. I simboli cibo Peng sono crop completi sopra il valore numerico, non frammenti di carta. Geometrie specifiche dei PDF locali, nessuna griglia o DPI universali.

QA nel visualizzatore dei gettoni: un crop leggermente interno alle guide può tranciare lo stroke del cerchio. Confrontare anche bounding box delle curve e spessore del tratto; il confine geometrico della curva non include necessariamente tutto lo stroke. Rettificati i tre gettoni in v02, v01 preservate Superate. Quando una guida coincide con il contorno, privilegiare l'integrità del componente e dichiarare la guida residua anziché asportare il bordo; nessuna pulizia grafica implicita. Verifica nel contesto e ingrandita, non soltanto in miniatura.

Leggi i materiali pertinenti con skill PDF/documenti quando applicabili; gli originali restano immutabili. Non acquisire nuovi pacchetti come scorciatoia per IMG. Mantieni pagine/render di lavoro nei percorsi locali esclusi da Git.

## Selezione

Prima di ritagliare, enumera file/versioni equivalenti per componente. Preferisci qualità finale, colore, alta risoluzione e integrità; conserva contenuti unici anche da draft/bn. Vecchie revisioni con grafica/testi diversi sono varianti distinte. Se criteri confliggono, segnala una scelta concreta senza scartare arbitrariamente. Un fronte stampato nove volte non è nove contenuti; nove carte con testi diversi sì.

Leggi le istruzioni di setup pertinenti prima di assegnare funzione e confini alle sagome: uno spazio per carte può sembrare una pedina. Verifica celle occupate e vuote; il testo può essere raster anche se la pagina sembra testuale. Un elemento richiesto dalle regole non prova che esista un componente stampabile nei file acquisiti.

## Ritaglio e verifica

Seleziona un metodo adatto alla pagina: griglia solo se confini regolari verificati; estrazione oggetti solo se restituisce il componente intero (può omettere testo/vettori); render+ritaglio se necessario. Non presumere che un'immagine incorporata nel PDF equivalga a una carta completa. Sono opzioni da collaudare, non algoritmi garantiti.

Conserva documento ID/hash, pagina, regione e sistema coordinate, orientamento, metodo e risoluzione rendering se usato. Preserva bordo di gioco, testo/grafica; escludi crocini/margini/istruzioni di stampa. Fronte/dorso separati e collegati; per sagome prima ritaglio rettangolare fedele, scontorno derivato. Componenti multi-pagina e confini dubbi richiedono controllo specifico prima della catalogazione operativa.

Confronta contenuti: hash file prova identità byte; similarità visiva propone candidati, da controllare su testi, numeri, simboli e revisione. Per duplicati conserva tutte le occorrenze/associazioni con unico contenuto. Verifica ritagli tramite vista d'insieme e ispezione sufficiente a coprire ogni componente; incongruenze restano pendenti, non complete.

Il primo lotto deve fornire esempi reali e confronti fonte/ritagli. Nessuna soglia di similarità, DPI universale o estrazione automatica è già validata.

## PDF suddivisi in fogli e quantità di stampa — TSK-0068, 2026-10-11

Prima di ricomporre un componente su più pagine, verifica se ogni pagina mostra una finestra diversa dello stesso oggetto raster completo. Nel PDF locale 18 di Sorry! That’s My Dungeon, X4 contiene il tabellone intero 2000×2000: quattro estrazioni hanno lo stesso SHA-256; i quattro render mostrano porzioni traslate concordanti. L’oggetto intero conserva grafica e testo del componente senza cucire i render. Registra tutte le pagine e le trasformazioni/regioni, anche fuori MediaBox, e gli offset non nulli della pagina. La prova è specifica del documento: se gli oggetti sono frammenti, maschere o mancano elementi vettoriali, questo metodo non è sufficiente.

Poker Face, PDF 20: gli otto raster nativi includono ciascuno l’intera carta e il bordo, verificati contro il render del foglio; estrazione nativa preferita al render meno risoluto. Il moltiplicatore «otto copie del foglio» è distinto dalle otto occorrenze presenti e dalle quantità richieste dalle tre modalità nel manuale. Non trasformare istruzioni di stampa in coordinate aggiuntive né inventare un dorso quando non è fornito.

Per piccoli artwork adiacenti a testo, dadi o altri disegni, verifica anche un ingrandimento del contesto oltre alla contact sheet: nel pannello degli eroi alcuni crop iniziali tagliavano armi/copricapi o includevano frammenti adiacenti. Rettificati mantenendo file/versioni precedenti Superate. L’ingrandimento è una prova locale, non un aumento della risoluzione dei file adottati. Geometrie e soglie del caso non sono riutilizzabili automaticamente.

## Evidenza pilota TSK-0068 — 2026-10-05

Mermaids vs Dinosaurs, file 32–34: render completo a 300 DPI seguito da crop verificato conserva bordi/testo/grafica dove l'estrazione di oggetti restituisce solo maschere o parti. La griglia 3x3 è specifica di quel PDF: pagina 3 ha una cella vuota; carte aiuto con testo raster. Duplicati verificati tramite stesso oggetto raster, stessa scala/bordo e controllo visivo; non trasferire automaticamente questa equivalenza ad altri documenti o revisioni. Un dorso comune collega tipi di carta, senza provare l'abbinamento fisico fronte/retro di ogni foglio.

Il setup chiarisce che i tre elementi inferiori sono spazi carte del tabellone. Il ritaglio incompleto v01 è preservato Superata; v02 mantiene ID immagine/componente e traccia la correzione. In una rettifica conserva file/hash/versione precedente fuori dalla copertura corrente, aggiorna regione e verifica nuovamente l'intero componente. La riproduzione inferiore del logo nel manuale resta occorrenza collegata al sorgente migliore: confronto visivo non equivale a identità byte. Prove e limiti nel TASK.md di TSK-0068 e nel manifest catalog/2025_children_family_images_2026-10-05.json; nessun algoritmo universale collaudato.
### Compatibilità delle coordinate con l'importatore 014 — TSK-0068, 2026-10-11

Il tabellone Sorry è un oggetto integrale collocato oltre i margini su quattro pagine; pdfplumber restituisce bounding box anche negative. Il validatore 014 richiede rettangoli positivi. Per le occorrenze operative registrare l'intersezione visibile con la pagina in punti, traslata rispetto all'angolo superiore sinistro della MediaBox; preservare separatamente bounding box originale dell'oggetto, bounding box pagina e descrizione del sistema di riferimento. Non attribuire alla regione visibile il significato di oggetto completo. Se occorre un adattamento, conservare il manifest di raccolta immutato e collegare il manifest operativo con SHA-256. Caso verificato su copia e operativo; nessuna modifica del file immagine o cucitura dei fogli.

## Verifiche sei giochi TSK-0068 — 2026-10-13

Enumerare i raster restituiti da pypdf non dimostra che siano tutti visibili: risorse condivise possono essere inutilizzate o coperte da un composito opaco. In Isles PDF14, oggetti delle pagine precedenti/successive erano sotto la pagina finale; estrazioni dal composito visibile, confrontate con tutti i render. Conservare oggetto e coordinate della fonte effettivamente dipinta, senza catalogare livelli nascosti come componenti correnti.

Un raster dipinto può ancora essere soltanto una banda: il logo Squirrelly del PDF29 era suddiviso tra immagini contigue. La prima estrazione R22 era incompleta, rettificata da render intero in v02; il logo BGG completo 3664×1657 resta preferito alla copia render inferiore. Le righe di gettoni PDF28 contengono frammenti sovrapposti di righe adiacenti: 50 facce e bounding box verificate sul render completo, non dal numero di XObject. Il raster nativo scelto contiene un cerchio intero, bordo incluso. Nessuna soglia di segmentazione universale.

L’orientamento del foglio non è l’orientamento di ogni faccia. Good Breeding: i fronti e i dorsi nel gutterfold richiedono rotazioni opposte; cinque dorsi v02 correggono il verso, v01 preservate. Isles: carte orizzontali inizialmente capovolte, orientate contro il testo prima dell’adozione. Verificare separatamente fronti, retro, aiutanti e quantità, anche dopo una rotazione apparentemente uniforme.

Confrontare anche varianti inferiori: Allmende printer-friendly contiene due ruoli con punteggi diversi dal colore. Recuperati come varianti con successione incerta, non esclusi per la sola qualità. In Squirrelly 54/108 sono formati paralleli e alcune carte speciali cambiano testo/simboli; le equivalenze visive verificate mantengono quantità per formato, senza sommare mazzi alternativi. Due tessere Isles p11/p12 hanno modifiche e Wanted 3/5VP sono distinti. Somiglianza, colore e date non provano equivalenza.

Per componenti su due fogli, le plance Robots sono quattro coppie sinistra/destra: ricomposizione di raster interi senza ridisegno, entrambe le pagine/regioni tracciate. Tracker energia e salute usano due carte sovrapposte: non trattarle come fronte e dorso. Collegare le facce dei moltiplicatori soltanto con istruzioni/layout/colore concordanti, non con la sola posizione nella lista.

Un originale PNG della griglia Allmende misura 9848×7386 e supera il limite implementato di40MP. Originale immutato, ID sorgente/metadati/hash nel manifest; anteprima intera ridotta in derivati e importata, relazione al sorgente conservata. Non ridurre l’originale né cambiare schema/app per aggirare un limite: attestare distintamente conservazione del binario e consultabilità del derivato.
