# Registro segnalazioni app

- Apertura: 2026-10-03.
- Stato: attivo; registro di segnalazioni non implementative.
- Titolo Codex: `2026-10-03 - Registro segnalazioni app`.
- PWS: `aligned_version` 1.5.0, uguale alla versione canonica 1.5.0.

## Scopo

Conservare, classificare e seguire le correzioni da realizzare nell'app in task evolutivi dedicati. Questo task è un blocco appunti auditabile: non implementa le correzioni e non modifica codice, database o output dell'app.

## Regole operative

- Ogni segnalazione riceve un identificativo stabile e uno stato.
- Gli stati previsti sono: `segnalata`, `triage`, `pianificata`, `in lavorazione`, `verificata`, `chiusa`, `rifiutata`.
- L'implementazione, quando autorizzata, appartiene a un task evolutivo separato che deve citare l'identificativo della segnalazione.
- Ogni segnalazione deve includere un prompt pronto da copiare per aprire il task evolutivo dedicato.
- La chiusura della segnalazione richiede il riferimento al task evolutivo e una verifica del comportamento corretto.
- Le osservazioni originali, le fonti e le date non vengono sovrascritte da successive interpretazioni.

## Segnalazioni

### APP-001 — Categorie delle classifiche limitate al contest selezionato

- **Stato:** `chiusa`.
- **Data segnalazione:** 2026-10-03.
- **Area:** Risultati BGG → Classifiche dei contest.
- **Fonte:** immagine allegata `C:\Users\39348\AppData\Local\Temp\codex-clipboard-0c547f97-b5e9-47ae-8403-84d5bbc6f2a6.png`; osservazione dell'utente.
- **Contesto osservato:** nella pagina delle classifiche è selezionato il contest `2025 1-Card Print and Play Design Contest`, ma il filtro `Categoria` mostra categorie provenienti dall'insieme complessivo del database, comprese categorie non utilizzate dal contest selezionato.
- **Comportamento atteso:** quando è selezionato un contest nel filtro `contest`, il filtro `Categoria` deve contenere soltanto le categorie effettivamente utilizzate nelle classifiche di quel contest.
- **Comportamento atteso aggiuntivo:** quando non è selezionata alcuna categoria, la scelta/preselezione e l'ordinamento devono privilegiare `overall`; le altre categorie devono seguire in ordine alfabetico. Il confronto deve essere coerente con la normalizzazione già adottata per i nomi delle categorie, senza eliminare il valore originale mostrato nei dati.
- **Fuori scope del registro:** correzione del backend, query, API, frontend, test o dati del database.
- **Criteri per la chiusura:** task evolutivo collegato; verifica con un contest che usa più categorie e con un contest che ne usa una sola; verifica che categorie di altri contest non compaiano; verifica dell'ordinamento/preselezione `overall` e poi alfabetico; nessuna modifica ai dati storici.
- **Task evolutivo:** `tasks/2026-10-03 - Categorie classifiche per contest/TASK.md`.
- **Verifica chiusura (2026-10-03):** menu circoscritto, precedenza overall e transizioni verificati con fixture multi/singola categoria; 37 test frontend superati. Etichette reali overall controllate sul database in sola lettura.
- **Note:** la segnalazione riguarda il comportamento del filtro e della scelta predefinita, non la classificazione o la validità delle categorie registrate nel database.
- **Prompt task evolutivo:**

  > Implementa la correzione `APP-001` nella vista Risultati BGG → Classifiche dei contest. Quando è selezionato un contest, il filtro Categoria deve mostrare soltanto le categorie effettivamente utilizzate nelle classifiche di quel contest, senza elencare tutte le categorie presenti nel database. Quando non è selezionata una categoria, privilegia `overall` e ordina poi le altre categorie alfabeticamente. Mantieni distinti valori originali e normalizzati, non modificare i dati storici e non ampliare il perimetro ad altre viste. Analizza l'implementazione esistente, aggiungi o aggiorna i test necessari e verifica almeno un contest con più categorie e uno con una sola categoria. Riporta file modificati, verifiche eseguite e limiti residui.

### APP-002 — Layout del visualizzatore PDF in base all'orientamento prevalente

- **Stato:** `segnalata`.
- **Data segnalazione:** 2026-10-03.
- **Area:** Libreria → Visualizzatore PDF.
- **Fonte:** immagine allegata `C:\Users\39348\AppData\Local\Temp\codex-clipboard-5afea572-191b-41e5-9b07-e04b2609aa8c.png`; osservazione dell'utente.
- **Contesto osservato:** il visualizzatore presenta un'area superiore molto alta e un canvas con impostazione fissa orizzontale (landscape), rendendo spesso necessario scorrere la pagina per vedere il documento.
- **Comportamento atteso generale:** ridurre al minimo ragionevole l'altezza della parte sopra il canvas, così da rendere visibile la pagina PDF intera o la maggior porzione possibile senza scorrimento verticale iniziale.
- **Comportamento atteso per PDF portrait:** se il documento è prevalentemente portrait, il canvas deve adottare un layout verticale, collocarsi a destra e occupare lo spazio superiore disponibile; comandi, metadati e scritte devono disporsi alla sua sinistra.
- **Comportamento atteso per PDF landscape:** mantenere un layout orizzontale adeguato alle proporzioni prevalenti del documento, evitando spazio superiore inutilizzato e riducendo lo scorrimento non necessario.
- **Comportamento atteso per PDF misti:** determinare automaticamente l'orientamento prevalente contando le pagine portrait e landscape e applicare il layout corrispondente all'intero visualizzatore, senza cambiare disposizione a ogni pagina. La regola per i pareggi deve essere definita nel task evolutivo e documentata.
- **Fuori scope del registro:** modifica di HTML, CSS, JavaScript, PDF.js o comportamento di rendering.
- **Criteri per la chiusura:** task evolutivo collegato; verifica su PDF prevalentemente portrait, prevalentemente landscape e misto; verifica della riduzione dell'area superiore; verifica della disposizione portrait con canvas a destra e comandi a sinistra; verifica responsive su finestra stretta; nessuna modifica agli originali acquisiti.
- **Task evolutivo:** da assegnare.
- **Note:** l'orientamento riguarda il layout del visualizzatore, non la modifica o rotazione dei file PDF originali.
- **Prompt task evolutivo:**

  > Implementa la correzione `APP-002` nel visualizzatore PDF locale. Riduci al minimo ragionevole l'altezza dell'area sopra il canvas per limitare lo scorrimento verticale iniziale. Determina automaticamente l'orientamento prevalente del PDF contando le pagine portrait e landscape e applica un layout coerente all'intero visualizzatore: per documenti prevalentemente portrait colloca il canvas a destra, occupa lo spazio superiore disponibile e sposta comandi e metadati alla sua sinistra; per documenti prevalentemente landscape mantieni un layout orizzontale compatto. Definisci e documenta la regola per i pareggi. Non ruotare né modificare i PDF originali. Mantieni accessibilità, controlli esistenti e responsive design. Aggiungi test o verifiche per PDF portrait, landscape, misti e finestra stretta; riporta file modificati, risultati e limiti residui.

### APP-003 — Contatore dei giochi censiti accanto a Kanare

- **Stato:** `segnalata`.
- **Data segnalazione:** 2026-10-03.
- **Area:** navigazione laterale → sezione fonti multifonte.
- **Fonte:** immagine allegata `C:\Users\39348\AppData\Local\Temp\codex-clipboard-58e7ad76-0761-442c-a94e-ce9cfef4322d.png`; osservazione dell'utente.
- **Contesto osservato:** la voce `Kanare_Abstract` è presente nella navigazione laterale ma non mostra un contatore numerico, mentre altre voci dell'app espongono il numero di elementi disponibili.
- **Comportamento atteso:** visualizzare accanto a `Kanare_Abstract` un contatore numerico dei giochi censiti per la fonte Kanare, calcolato sui giochi effettivamente censiti e disponibili nella vista corrispondente.
- **Presentazione attesa:** usare lo stesso stile visivo, allineamento e significato dei contatori già presenti nella navigazione; il numero deve aggiornarsi quando cambia il conteggio sottostante e non deve essere un valore statico scritto nell'interfaccia.
- **Fuori scope del registro:** modifica delle query, API, conteggi del database, frontend o navigazione.
- **Criteri per la chiusura:** task evolutivo collegato; conteggio verificato contro la fonte dati autorevole della vista Kanare; visualizzazione corretta su desktop e schermi stretti; nessuna confusione con il numero di prodotti, record nativi o giochi canonici complessivi.
- **Task evolutivo:** da assegnare.
- **Note:** il contatore richiesto riguarda i giochi censiti della fonte Kanare, non il totale generale mostrato accanto a `Giochi`.
- **Prompt task evolutivo:**

  > Implementa la correzione `APP-003` nella navigazione laterale dell'app. Accanto alla voce `Kanare_Abstract` aggiungi un contatore numerico dinamico dei giochi censiti della fonte Kanare, usando la stessa presentazione visiva e lo stesso allineamento dei contatori già presenti. Il valore deve derivare dalla fonte dati autorevole della vista Kanare e aggiornarsi con il conteggio sottostante; non usare un numero statico e non confondere giochi censiti con prodotti, record nativi o totale dei giochi canonici. Mantieni la navigazione e il layout responsive. Verifica il conteggio contro i dati locali e controlla desktop e schermi stretti. Riporta file modificati, test eseguiti e limiti residui.

### APP-004 — Righe compatte nell'avanzamento contest BGG senza riquadri a zero

- **Stato:** `segnalata`.
- **Data segnalazione:** 2026-10-03.
- **Area:** Avanzamento → dettaglio annuale dei contest BGG.
- **Fonte:** immagine allegata `C:\Users\39348\AppData\Local\Temp\codex-clipboard-da140ab8-4ca3-40f4-a881-886240afe3e8.png`; osservazione dell'utente.
- **Contesto osservato:** le righe del dettaglio sono eccessivamente alte perché i contatori specifici con valore zero vengono mostrati dentro grandi rettangoli tratteggiati, anche quando non c'è alcun contenuto da rappresentare.
- **Comportamento atteso:** quando un contatore specifico è a zero, non renderizzare il relativo rettangolo/card vuoto. La cella deve restare compatta, mostrando eventualmente soltanto l'informazione testuale minima necessaria secondo la semantica già adottata.
- **Obiettivo visivo:** ridurre l'altezza delle righe e rendere il dettaglio annuale più denso e facilmente scansionabile, senza spazio verticale inutilizzato.
- **Preservazione informativa:** non alterare i conteggi, i denominatori, i link, le etichette delle metriche o la distinzione fra zero, dato mancante e informazione non disponibile; la rimozione riguarda esclusivamente il riquadro visivo sproporzionato associato al valore zero.
- **Fuori scope del registro:** modifica di componenti, CSS, API, query, calcolo dei progressi o dati del database.
- **Criteri per la chiusura:** task evolutivo collegato; verifica su righe con uno o più contatori a zero e su righe con valori positivi; verifica che i dati zero/non disponibile restino distinguibili; verifica desktop e schermi stretti; verifica che i link e le etichette restino accessibili.
- **Task evolutivo:** da assegnare.
- **Note:** la segnalazione riguarda il dettaglio dei contest BGG nell'avanzamento, non i riquadri o contatori di altre viste dell'app.
- **Prompt task evolutivo:**

  > Implementa la correzione `APP-004` nel dettaglio annuale dell'avanzamento dei contest BGG. Quando un contatore specifico vale zero, non renderizzare il grande riquadro/card vuoto che dilata inutilmente la riga; mantieni la cella compatta e mostra soltanto l'informazione testuale minima necessaria secondo la semantica esistente. Non alterare conteggi, denominatori, link, etichette o distinzione tra zero, dato mancante e informazione non disponibile. Applica la correzione solo a questa vista, preserva accessibilità e responsive design, e verifica righe con valori zero e positivi su desktop e schermi stretti. Riporta file modificati, test eseguiti e limiti residui.

### APP-005 — Libreria per gioco, visualizzatori PNG/DOCX e contenuti ZIP

- **Stato:** `segnalata`.
- **Data segnalazione:** 2026-10-03.
- **Area:** Libreria → elenco materiali e visualizzatori.
- **Fonte:** immagine allegata `C:\Users\39348\AppData\Local\Temp\codex-clipboard-7eb969c7-de44-4b02-b403-ff0bb0097c9f.png`; richiesta dell'utente.
- **Contesto osservato:** la Libreria presenta una riga per ciascun file, ripetendo il gioco e la provenienza; nell'immagine più file del medesimo gioco occupano righe separate.
- **Comportamento atteso — elenco:** sostituire la lista per singolo file con una lista per gioco. Raggruppare tutti i file del gioco in una colonna; rappresentare ciascun file con un'icona e la sola dimensione come testo visibile ordinario. Rendere nome, formato e altri dettagli consultabili senza appesantire la lista, con etichette accessibili che permettano di distinguere i file.
- **Comportamento atteso — apertura:** cliccando sull'icona aprire il visualizzatore del relativo file. Conservare la lettura PDF e aggiungere visualizzatori interni per PNG e DOCX, indicati dall'utente come formati recentemente aggiunti alla Libreria.
- **Comportamento atteso — ZIP:** scompattare gli archivi nei singoli contenuti interni, associando questi al gioco e rendendoli consultabili secondo il formato supportato. Conservare gli ZIP originali e la provenienza di ogni contenuto estratto; documentare hash e relazione con l'archivio sorgente.
- **Punti da definire nel task evolutivo:** semantica dei filtri e della paginazione per gioco; gestione delle diverse acquisizioni/versioni dello stesso gioco; presentazione dei formati non visualizzabili e degli archivi non estraibili; modalità di lettura DOCX e gestione dei contenuti ZIP annidati.
- **Fuori scope del registro:** raggruppamento effettivo, implementazione dei visualizzatori, estrazione ZIP, registrazione dei contenuti o migrazioni.
- **Criteri per la chiusura:** task evolutivo collegato; una riga per gioco senza perdita dei file/versioni/provenienze; icone con dimensioni corrette e apertura del file corrispondente; lettura PDF, PNG e DOCX verificata; estrazione ZIP verificata con originali preservati, hash e tracciabilità dei contenuti; filtri e paginazione coerenti; verifica tastiera e schermi stretti. L'estrazione deve impedire percorsi esterni alla destinazione, sovrascritture e decompressioni senza limiti.
- **Task evolutivo:** da assegnare.
- **Relazioni:** coordinare il layout dei visualizzatori con `APP-002` senza presumere che sia già implementata.
- **Prompt task evolutivo:**

  > Implementa l'evoluzione `APP-005` descritta nel registro `tasks/2026-10-03 - Registro segnalazioni app/TASK.md`. Nella Libreria sostituisci l'elenco per file con un elenco per gioco: in una colonna raggruppa tutti i file del gioco, ciascuno rappresentato da un'icona cliccabile e dalla sola dimensione come testo visibile ordinario. Mantieni nomi e dettagli consultabili e accessibili, distinguendo file, acquisizioni e versioni. Il clic deve aprire il visualizzatore del file corrispondente; conserva il lettore PDF e aggiungi visualizzatori interni per PNG e DOCX. Scompatta i file ZIP acquisiti nei loro singoli contenuti, associandoli al gioco e rendendoli consultabili per i formati supportati. Preserva gli archivi originali, registra provenienza, relazione archivio–contenuto e hash dei file estratti, senza sovrascrivere versioni esistenti. Definisci filtri, conteggi e paginazione coerenti con il raggruppamento per gioco e una gestione esplicita dei formati non supportati o archivi non estraibili. L'estrazione deve essere confinata e limitata; i visualizzatori devono operare sui file registrati e non eseguire contenuti attivi. Consulta i vincoli architetturali del progetto e coordina il layout con `APP-002`. Verifica raggruppamento, filtri, apertura PDF/PNG/DOCX, estrazione ZIP, tracciabilità, tastiera e schermi stretti. Documenta scelte, verifiche e limiti, aggiorna il cruscotto quando richiesto dal suo protocollo e collega questo task alla segnalazione con il relativo stato ed evidenza di verifica.

## Registro cambiamenti

- 2026-10-03: creato il registro e inserita `APP-001`; nessuna implementazione eseguita.
- 2026-10-03: inserita `APP-002`; nessuna implementazione eseguita.
- 2026-10-03: inserita `APP-003`; nessuna implementazione eseguita.
- 2026-10-03: inserita `APP-004`; nessuna implementazione eseguita.
- 2026-10-03: predisposti i prompt evolutivi per `APP-001`–`APP-004` e resa obbligatoria la loro presenza per le segnalazioni successive.
- 2026-10-03: inserita `APP-005` con prompt evolutivo; nessuna implementazione o estrazione eseguita.

- 2026-10-03: chiusa APP-001 nel task Categorie classifiche per contest; nessuna modifica ai dati storici.
