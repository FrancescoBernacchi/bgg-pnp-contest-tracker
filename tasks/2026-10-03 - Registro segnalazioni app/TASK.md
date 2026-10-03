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

- **Stato:** `chiusa`.
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
- **Task evolutivo:** `tasks/2026-10-03 - Layout PDF per orientamento/TASK.md`.
- **Verifica chiusura (2026-10-03):** 39 test frontend e 7 backend PDF superati; Edge headless con PDF.js e PDF sintetici portrait/landscape/misti, navigazione e layout a 1400/390 px; DOM/CSS anche a 1100/800 px. Screenshot desktop/mobile esaminati. Quadrate escluse dalla maggioranza; pareggio sulla prima non quadrata, tutte quadrate portrait.
- **Note:** l'orientamento riguarda il layout del visualizzatore, non la modifica o rotazione dei file PDF originali.
- **Prompt task evolutivo:**

  > Implementa la correzione `APP-002` nel visualizzatore PDF locale. Riduci al minimo ragionevole l'altezza dell'area sopra il canvas per limitare lo scorrimento verticale iniziale. Determina automaticamente l'orientamento prevalente del PDF contando le pagine portrait e landscape e applica un layout coerente all'intero visualizzatore: per documenti prevalentemente portrait colloca il canvas a destra, occupa lo spazio superiore disponibile e sposta comandi e metadati alla sua sinistra; per documenti prevalentemente landscape mantieni un layout orizzontale compatto. Definisci e documenta la regola per i pareggi. Non ruotare né modificare i PDF originali. Mantieni accessibilità, controlli esistenti e responsive design. Aggiungi test o verifiche per PDF portrait, landscape, misti e finestra stretta; riporta file modificati, risultati e limiti residui.

### APP-003 — Contatore dei giochi censiti accanto a Kanare

- **Stato:** `chiusa`.
- **Data segnalazione:** 2026-10-03.
- **Area:** navigazione laterale → sezione fonti multifonte.
- **Fonte:** immagine allegata `C:\Users\39348\AppData\Local\Temp\codex-clipboard-58e7ad76-0761-442c-a94e-ce9cfef4322d.png`; osservazione dell'utente.
- **Contesto osservato:** la voce `Kanare_Abstract` è presente nella navigazione laterale ma non mostra un contatore numerico, mentre altre voci dell'app espongono il numero di elementi disponibili.
- **Comportamento atteso:** visualizzare accanto a `Kanare_Abstract` un contatore numerico dei giochi censiti per la fonte Kanare, calcolato sui giochi effettivamente censiti e disponibili nella vista corrispondente.
- **Presentazione attesa:** usare lo stesso stile visivo, allineamento e significato dei contatori già presenti nella navigazione; il numero deve aggiornarsi quando cambia il conteggio sottostante e non deve essere un valore statico scritto nell'interfaccia.
- **Fuori scope del registro:** modifica delle query, API, conteggi del database, frontend o navigazione.
- **Criteri per la chiusura:** task evolutivo collegato; conteggio verificato contro la fonte dati autorevole della vista Kanare; visualizzazione corretta su desktop e schermi stretti; nessuna confusione con il numero di prodotti, record nativi o giochi canonici complessivi.
- **Task evolutivo:** `tasks/2026-10-03 - Contatore giochi Kanare/TASK.md`.
- **Verifica chiusura (2026-10-03):** conteggio sulla stessa fonte della vista Kanare: 64 giochi canonici distinti. Caricamento e rilettura verificati con 2/0/1 giochi; filtri e prodotti non alterano il totale. 32 test frontend superati. Stile nav-count esistente: allineato a destra su desktop e nascosto sotto 720 px come gli altri contatori; verifica strutturale HTML/CSS, senza prova visiva browser.
- **Note:** il contatore richiesto riguarda i giochi censiti della fonte Kanare, non il totale generale mostrato accanto a `Giochi`.
- **Prompt task evolutivo:**

  > Implementa la correzione `APP-003` nella navigazione laterale dell'app. Accanto alla voce `Kanare_Abstract` aggiungi un contatore numerico dinamico dei giochi censiti della fonte Kanare, usando la stessa presentazione visiva e lo stesso allineamento dei contatori già presenti. Il valore deve derivare dalla fonte dati autorevole della vista Kanare e aggiornarsi con il conteggio sottostante; non usare un numero statico e non confondere giochi censiti con prodotti, record nativi o totale dei giochi canonici. Mantieni la navigazione e il layout responsive. Verifica il conteggio contro i dati locali e controlla desktop e schermi stretti. Riporta file modificati, test eseguiti e limiti residui.

### APP-004 — Righe compatte nell'avanzamento contest BGG senza riquadri a zero

- **Stato:** `chiusa`.
- **Data segnalazione:** 2026-10-03.
- **Area:** Avanzamento → dettaglio annuale dei contest BGG.
- **Fonte:** immagine allegata `C:\Users\39348\AppData\Local\Temp\codex-clipboard-da140ab8-4ca3-40f4-a881-886240afe3e8.png`; osservazione dell'utente.
- **Contesto osservato:** le righe del dettaglio sono eccessivamente alte perché i contatori specifici con valore zero vengono mostrati dentro grandi rettangoli tratteggiati, anche quando non c'è alcun contenuto da rappresentare.
- **Comportamento atteso:** quando un contatore specifico è a zero, non renderizzare il relativo rettangolo/card vuoto. La cella deve restare compatta, mostrando eventualmente soltanto l'informazione testuale minima necessaria secondo la semantica già adottata.
- **Obiettivo visivo:** ridurre l'altezza delle righe e rendere il dettaglio annuale più denso e facilmente scansionabile, senza spazio verticale inutilizzato.
- **Preservazione informativa:** non alterare i conteggi, i denominatori, i link, le etichette delle metriche o la distinzione fra zero, dato mancante e informazione non disponibile; la rimozione riguarda esclusivamente il riquadro visivo sproporzionato associato al valore zero.
- **Fuori scope del registro:** modifica di componenti, CSS, API, query, calcolo dei progressi o dati del database.
- **Criteri per la chiusura:** task evolutivo collegato; verifica su righe con uno o più contatori a zero e su righe con valori positivi; verifica che i dati zero/non disponibile restino distinguibili; verifica desktop e schermi stretti; verifica che i link e le etichette restino accessibili.
- **Task evolutivo:** `tasks/2026-10-03 - Righe compatte avanzamento BGG/TASK.md`.
- **Verifica chiusura (2026-10-03):** eliminata la collisione con la classe generica empty; zero e denominatori compatti, assenti espliciti. 41 test frontend/PDF superati, rendering dettaglio con link e valori positivi preservati; responsive e accessibilità verificati strutturalmente su HTML/CSS, senza prova visiva browser.
- **Note:** la segnalazione riguarda il dettaglio dei contest BGG nell'avanzamento, non i riquadri o contatori di altre viste dell'app.
- **Prompt task evolutivo:**

  > Implementa la correzione `APP-004` nel dettaglio annuale dell'avanzamento dei contest BGG. Quando un contatore specifico vale zero, non renderizzare il grande riquadro/card vuoto che dilata inutilmente la riga; mantieni la cella compatta e mostra soltanto l'informazione testuale minima necessaria secondo la semantica esistente. Non alterare conteggi, denominatori, link, etichette o distinzione tra zero, dato mancante e informazione non disponibile. Applica la correzione solo a questa vista, preserva accessibilità e responsive design, e verifica righe con valori zero e positivi su desktop e schermi stretti. Riporta file modificati, test eseguiti e limiti residui.

### APP-005 — Libreria per gioco, visualizzatori PNG/DOCX e contenuti ZIP

- **Stato:** `chiusa` il 2026-10-03.
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
- **Task evolutivo:** `tasks/2026-10-03 - Libreria per gioco e visualizzatori APP-005/TASK.md`.
- **Verifica:** 36 test backend e 43 frontend; Edge a 1400/390 px su fixture e materiali reali, tastiera, filtri e paginazione per gioco. Estratti 11 contenuti da due ZIP, riesecuzione senza duplicati, 187 originali invariati e 198 hash verificati. DOCX semantico senza impaginazione/immagini Word; ZIP annidati non ricorsivi. Evidenze in `VERIFICATION.json` del task.
- **Relazioni:** layout coordinato con `APP-002`, verificata conclusa prima dell’incremento.
- **Prompt task evolutivo:**

  > Implementa l'evoluzione `APP-005` descritta nel registro `tasks/2026-10-03 - Registro segnalazioni app/TASK.md`. Nella Libreria sostituisci l'elenco per file con un elenco per gioco: in una colonna raggruppa tutti i file del gioco, ciascuno rappresentato da un'icona cliccabile e dalla sola dimensione come testo visibile ordinario. Mantieni nomi e dettagli consultabili e accessibili, distinguendo file, acquisizioni e versioni. Il clic deve aprire il visualizzatore del file corrispondente; conserva il lettore PDF e aggiungi visualizzatori interni per PNG e DOCX. Scompatta i file ZIP acquisiti nei loro singoli contenuti, associandoli al gioco e rendendoli consultabili per i formati supportati. Preserva gli archivi originali, registra provenienza, relazione archivio–contenuto e hash dei file estratti, senza sovrascrivere versioni esistenti. Definisci filtri, conteggi e paginazione coerenti con il raggruppamento per gioco e una gestione esplicita dei formati non supportati o archivi non estraibili. L'estrazione deve essere confinata e limitata; i visualizzatori devono operare sui file registrati e non eseguire contenuti attivi. Consulta i vincoli architetturali del progetto e coordina il layout con `APP-002`. Verifica raggruppamento, filtri, apertura PDF/PNG/DOCX, estrazione ZIP, tracciabilità, tastiera e schermi stretti. Documenta scelte, verifiche e limiti, aggiorna il cruscotto quando richiesto dal suo protocollo e collega questo task alla segnalazione con il relativo stato ed evidenza di verifica.

### APP-006 — Icone per contenuto, descrizioni e sigle delle varianti in Libreria

- **Stato:** `segnalata`.
- **Data segnalazione:** 2026-10-03.
- **Area:** Libreria → materiali raggruppati per gioco.
- **Fonte:** immagine allegata `C:\Users\39348\AppData\Local\Temp\codex-clipboard-38b66a9a-600e-4783-a248-1702fd66dd85.png`; richiesta dell'utente.
- **Contesto osservato:** le icone distinguono insufficientemente il contenuto dei file; la sola dimensione non permette di riconoscere materiali e varianti dello stesso gioco.
- **Comportamento atteso — contenuto:** assegnare icone significative alla funzione ludica/editoriale del materiale, indipendentemente dal formato tecnico. Categorie iniziali richieste: `rule` (regolamento), `cards` (carte), `board` (tabellone), `player board` (plancia giocatore), `altro`. Verificare sul corpus locale se emergono ulteriori categorie standard ricorrenti, prima di consolidarle; gestire file con più tipi di contenuto e casi non determinabili.
- **Comportamento atteso — descrizione:** accanto all'icona e alla dimensione mostrare una breve descrizione utile a identificare il materiale, mantenendo compatta la vista per gioco.
- **Comportamento atteso — varianti:** introdurre una convenzione sintetica ma parlante per il nome visualizzato, con flag/sigle per lingua, risoluzione/definizione/qualità e colore o bianco e nero. Distinguere le varianti dello stesso materiale senza confondere tali attributi con versioni editoriali o formato MIME.
- **Proposta da valutare nel task evolutivo:** nome visualizzato `<descrizione> [<lingua> · <qualità> · <colore>]`, per esempio `Carte [EN · 300dpi · COL]` oppure `Regole [IT · B/N]`. Le sigle sono illustrative: definire una legenda e usare soltanto attributi supportati da evidenza. Non dedurre qualità dalla dimensione del file; mantenere separati DPI, dimensioni in pixel e qualità dichiarata. Omettere attributi ignoti o renderne esplicita l'incertezza.
- **Preservazione:** conservare nomi originali, file, hash, provenienza e versioni; la convenzione riguarda il nome di presentazione nell'app, senza rinominare gli originali acquisiti. Separare classificazioni verificate e inferenze, registrando la base della classificazione.
- **Relazioni:** incremento successivo ad `APP-005`, già registrata come chiusa. La richiesta di breve descrizione estende deliberatamente il precedente requisito di sola dimensione visibile; la specifica storica di `APP-005` resta preservata.
- **Criteri per la chiusura:** task evolutivo collegato; categorie e legenda documentate dopo verifica del corpus; icone semanticamente distinte e accessibili; descrizioni compatte; varianti di lingua/qualità/colore distinguibili; gestione esplicita dei materiali misti e degli attributi ignoti; apertura dei visualizzatori, filtri e layout stretto verificati; originali e hash preservati.
- **Task evolutivo:** da assegnare.
- **Prompt task evolutivo:**

  > Implementa l'evoluzione `APP-006` del registro `tasks/2026-10-03 - Registro segnalazioni app/TASK.md`, come incremento della Libreria per gioco introdotta da `APP-005`. Differenzia le icone in base al contenuto, indipendentemente dal formato del file: categorie iniziali rule/regolamento, cards/carte, board/tabellone, player board/plancia giocatore e altro. Esamina i materiali e i metadati locali per verificare se esistono altre categorie standard ricorrenti; documenta la tassonomia adottata e gestisci contenuti misti o non determinabili. Accanto a ciascuna icona mostra dimensione e breve descrizione, mantenendo il layout compatto e l'apertura del visualizzatore. Definisci e implementa una convenzione sintetica e comprensibile per i nomi visualizzati, con sigle per lingua, risoluzione/definizione/qualità e colore o bianco e nero, corredate da legenda. Valuta una forma come “Carte [EN · 300dpi · COL]”, senza trattare questo esempio come tassonomia definitiva. Usa attributi documentati, separa inferenze e valori verificati, non dedurre qualità dalla dimensione e distingui DPI, dimensioni in pixel e qualità dichiarata. Preserva nomi e file originali, hash, provenienza e versioni; applica la convenzione alla presentazione nell'app. Verifica categorie rappresentative, varianti dello stesso materiale, attributi ignoti, accessibilità da tastiera, visualizzatori e schermi stretti. Documenta scelte, verifiche e limiti, aggiorna la documentazione e il cruscotto secondo i protocolli del progetto e collega il task a `APP-006` aggiornandone lo stato con evidenze.

## Registro cambiamenti

- 2026-10-03: creato il registro e inserita `APP-001`; nessuna implementazione eseguita.
- 2026-10-03: inserita `APP-002`; nessuna implementazione eseguita.
- 2026-10-03: inserita `APP-003`; nessuna implementazione eseguita.
- 2026-10-03: inserita `APP-004`; nessuna implementazione eseguita.
- 2026-10-03: predisposti i prompt evolutivi per `APP-001`–`APP-004` e resa obbligatoria la loro presenza per le segnalazioni successive.
- 2026-10-03: inserita `APP-005` con prompt evolutivo; nessuna implementazione o estrazione eseguita.

- 2026-10-03: chiusa APP-001 nel task Categorie classifiche per contest; nessuna modifica ai dati storici.

- 2026-10-03: chiusa APP-002 nel task Layout PDF per orientamento dopo verifiche automatiche e screenshot; originali e database operativo invariati.

- 2026-10-03: chiusa APP-004 nel task Righe compatte avanzamento BGG; dati invariati.

- 2026-10-03: APP-005 implementata e chiusa nel task dedicato, con limiti DOCX/ZIP documentati e verifiche registrate.
- 2026-10-03: inserita `APP-006` con prompt evolutivo e proposta di convenzione da valutare; nessuna implementazione eseguita in questo registro.
