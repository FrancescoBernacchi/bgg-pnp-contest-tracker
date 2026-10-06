# Estrazione da materiali acquisiti

Leggi i materiali pertinenti con skill PDF/documenti quando applicabili; gli originali restano immutabili. Non acquisire nuovi pacchetti come scorciatoia per IMG. Mantieni pagine/render di lavoro nei percorsi locali esclusi da Git.

## Selezione

Prima di ritagliare, enumera file/versioni equivalenti per componente. Preferisci qualità finale, colore, alta risoluzione e integrità; conserva contenuti unici anche da draft/bn. Vecchie revisioni con grafica/testi diversi sono varianti distinte. Se criteri confliggono, segnala una scelta concreta senza scartare arbitrariamente. Un fronte stampato nove volte non è nove contenuti; nove carte con testi diversi sì.

Leggi le istruzioni di setup pertinenti prima di assegnare funzione e confini alle sagome: uno spazio per carte può sembrare una pedina. Verifica celle occupate e vuote; il testo può essere raster anche se la pagina sembra testuale. Un elemento richiesto dalle regole non prova che esista un componente stampabile nei file acquisiti.

## Ritaglio e verifica

Seleziona un metodo adatto alla pagina: griglia solo se confini regolari verificati; estrazione oggetti solo se restituisce il componente intero (può omettere testo/vettori); render+ritaglio se necessario. Non presumere che un'immagine incorporata nel PDF equivalga a una carta completa. Sono opzioni da collaudare, non algoritmi garantiti.

Conserva documento ID/hash, pagina, regione e sistema coordinate, orientamento, metodo e risoluzione rendering se usato. Preserva bordo di gioco, testo/grafica; escludi crocini/margini/istruzioni di stampa. Fronte/dorso separati e collegati; per sagome prima ritaglio rettangolare fedele, scontorno derivato. Componenti multi-pagina e confini dubbi richiedono controllo specifico prima della catalogazione operativa.

Confronta contenuti: hash file prova identità byte; similarità visiva propone candidati, da controllare su testi, numeri, simboli e revisione. Per duplicati conserva tutte le occorrenze/associazioni con unico contenuto. Verifica ritagli tramite vista d'insieme e ispezione sufficiente a coprire ogni componente; incongruenze restano pendenti, non complete.

Il primo lotto deve fornire esempi reali e confronti fonte/ritagli. Nessuna soglia di similarità, DPI universale o estrazione automatica è già validata.

## Evidenza pilota TSK-0068 — 2026-10-05

Mermaids vs Dinosaurs, file 32–34: render completo a 300 DPI seguito da crop verificato conserva bordi/testo/grafica dove l'estrazione di oggetti restituisce solo maschere o parti. La griglia 3x3 è specifica di quel PDF: pagina 3 ha una cella vuota; carte aiuto con testo raster. Duplicati verificati tramite stesso oggetto raster, stessa scala/bordo e controllo visivo; non trasferire automaticamente questa equivalenza ad altri documenti o revisioni. Un dorso comune collega tipi di carta, senza provare l'abbinamento fisico fronte/retro di ogni foglio.

Il setup chiarisce che i tre elementi inferiori sono spazi carte del tabellone. Il ritaglio incompleto v01 è preservato Superata; v02 mantiene ID immagine/componente e traccia la correzione. In una rettifica conserva file/hash/versione precedente fuori dalla copertura corrente, aggiorna regione e verifica nuovamente l'intero componente. La riproduzione inferiore del logo nel manuale resta occorrenza collegata al sorgente migliore: confronto visivo non equivale a identità byte. Prove e limiti nel TASK.md di TSK-0068 e nel manifest catalog/2025_children_family_images_2026-10-05.json; nessun algoritmo universale collaudato.
