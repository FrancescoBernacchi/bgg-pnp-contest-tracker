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

- **Stato:** `chiusa` il 2026-10-04.
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
- **Task evolutivo:** `tasks/2026-10-04 - Contenuti e varianti Libreria APP-006/TASK.md`.
- **Verifica:** 45 test frontend, 36 backend, Edge 1400/390 px (legenda, misti, tastiera, filtri, paginazione e lettori), 198/198 hash verificati. Classificazioni dal nome esplicitamente inferite; attributi ignoti omessi. Evidenza corpus in `CORPUS.json` del task.
- **Prompt task evolutivo:**

  > Implementa l'evoluzione `APP-006` del registro `tasks/2026-10-03 - Registro segnalazioni app/TASK.md`, come incremento della Libreria per gioco introdotta da `APP-005`. Differenzia le icone in base al contenuto, indipendentemente dal formato del file: categorie iniziali rule/regolamento, cards/carte, board/tabellone, player board/plancia giocatore e altro. Esamina i materiali e i metadati locali per verificare se esistono altre categorie standard ricorrenti; documenta la tassonomia adottata e gestisci contenuti misti o non determinabili. Accanto a ciascuna icona mostra dimensione e breve descrizione, mantenendo il layout compatto e l'apertura del visualizzatore. Definisci e implementa una convenzione sintetica e comprensibile per i nomi visualizzati, con sigle per lingua, risoluzione/definizione/qualità e colore o bianco e nero, corredate da legenda. Valuta una forma come “Carte [EN · 300dpi · COL]”, senza trattare questo esempio come tassonomia definitiva. Usa attributi documentati, separa inferenze e valori verificati, non dedurre qualità dalla dimensione e distingui DPI, dimensioni in pixel e qualità dichiarata. Preserva nomi e file originali, hash, provenienza e versioni; applica la convenzione alla presentazione nell'app. Verifica categorie rappresentative, varianti dello stesso materiale, attributi ignoti, accessibilità da tastiera, visualizzatori e schermi stretti. Documenta scelte, verifiche e limiti, aggiorna la documentazione e il cruscotto secondo i protocolli del progetto e collega il task a `APP-006` aggiornandone lo stato con evidenze.

### APP-007 — Formattazione fedele nel visualizzatore DOCX

- **Stato:** `risolta` il 2026-10-04; resa HTML adattata con limiti documentati.
- **Data segnalazione:** 2026-10-04.
- **Area:** Libreria → visualizzatore DOCX.
- **Fonte:** immagine allegata `C:\Users\39348\AppData\Local\Temp\codex-clipboard-f8a6301a-c6f5-441d-861a-de2cabf638a2.png`; segnalazione dell'utente.
- **Caso di riferimento:** `Peste Negra Regras em Português.docx`, gioco `1899 - 1907 Black Death Brazil`, acquisizione #39.
- **Contesto osservato:** il documento appare come testo quasi uniforme, con gerarchia visiva e spaziatura insufficienti; nell'immagine alcuni elementi risultano accostati. Il lettore dichiara di riprodurre testo e tabelle senza impaginazione, immagini, note, intestazioni e revisioni Word. Il confronto puntuale con l'originale deve essere effettuato nel task evolutivo; la schermata da sola non dimostra quali formattazioni siano presenti nel file sorgente.
- **Comportamento atteso:** migliorare la fedeltà al DOCX originale, preservando formattazione del testo, stili e gerarchia dei titoli, paragrafi, spaziature, allineamenti, elenchi e tabelle. Verificare e trattare immagini e impaginazione quando presenti; documentare eventuali elementi non riproducibili, evitando di presentare la sola estrazione del testo come resa fedele.
- **Relazioni:** evoluzione del lettore semantico introdotto con `APP-005`, i cui limiti erano stati documentati alla chiusura. Nessuna riapertura o riscrittura della verifica storica di APP-005.
- **Criteri per la chiusura:** task evolutivo collegato; confronto visivo del caso segnalato con una resa autorevole dell'originale; verifica di DOCX rappresentativi con titoli, testo formattato, elenchi, tabelle e immagini; controllo che contenuti e ordine di lettura siano preservati; verifica tastiera e finestra stretta; originali e hash invariati; limiti residui espliciti.
- **Task evolutivo:** `tasks/2026-10-04 - Formattazione DOCX APP-007/TASK.md`.
- **Verifica:** 40 test backend e 45 frontend; quattro DOCX reali a 1400/390 px, confronto visivo con PDF esportati da Word, 43 immagini nei due regolamenti, completezza/ordine del testo e quattro hash invariati; fixture titoli, elenchi, tabelle e contenuto inerte. Limiti Word e numerazioni/tabelle avanzate in app/README.md.
- **Prompt task evolutivo:**

  > Implementa la correzione `APP-007` descritta nel registro `tasks/2026-10-03 - Registro segnalazioni app/TASK.md`: il visualizzatore DOCX della Libreria non riproduce correttamente la formattazione dei documenti. Usa come caso iniziale `Peste Negra Regras em Português.docx` del gioco `1899 - 1907 Black Death Brazil`, acquisizione #39. Confronta il file originale con la resa attuale e individua le perdite effettive di formattazione. Migliora il lettore affinché conservi stili del testo, gerarchia dei titoli, paragrafi, spaziatura, allineamenti, elenchi e tabelle; verifica anche immagini e impaginazione presenti nei documenti. Scegli una soluzione locale coerente con l'architettura del progetto e documenta il livello di fedeltà ottenibile e gli elementi non supportati. Mantieni originali, hash e provenienza, accesso confinato ai file registrati e gestione sicura dei contenuti del documento. Verifica visivamente il caso segnalato e documenti rappresentativi, confrontandoli con una resa autorevole dell'originale; controlla completezza del contenuto, ordine di lettura, accessibilità e finestra stretta. Registra verifiche e limiti, aggiorna la documentazione e il cruscotto secondo i protocolli del progetto e collega il task a `APP-007`, aggiornandone lo stato con evidenze.

### APP-008 — Barre di completamento del lavoro e acquisizione immagini

- **Stato:** `chiusa`.
- **Data:** 2026-10-04.
- **Area:** Avanzamento → schede annuali, PnP principali e adiacenti.
- **Fonte:** richiesta dell'utente e immagine `C:\Users\39348\AppData\Local\Temp\codex-clipboard-56173ee2-8582-41dd-8d18-ad2da28816b9.png`.
- **Requisito:** tutte le barre devono misurare il lavoro completato e raggiungere il 100% quando la fase è conclusa. Per le classifiche contare tutte le entry controllate, comprese quelle verificate come assenti da ogni classifica, per esempio ritirate. Separare copertura delle verifiche e numero di entry con piazzamenti. L'assenza di dati nel database non dimostra una verifica conclusa.
- **Etichette richieste, con ortografia normalizzata:** `Censimento entry`, `Censimento classifica`, `Censimento materiali`, `Acquisizione materiali`.
- **Nuova barra:** `Acquisizione immagini`, inizialmente 0%, con funzione non ancora implementata indicata esplicitamente. Riguarda immagini rappresentative, distinte dai PNG dei materiali PnP; nessun download è autorizzato da questa segnalazione.
- **Da definire nel task evolutivo:** denominatori e condizioni di completamento di ogni fase; casi senza entry/non applicabili, materiali assenti e acquisizioni bloccate; perimetro approvato. Non assegnare completezza artificiale e non inventare verifiche storiche.
- **Relazioni:** coordinare la metrica delle classifiche con il contratto annuale deliberato per TSK-0045; nessun rilevamento BGG nel task APP.
- **Criteri per la chiusura:** classifiche al 100% se tutte le entry sono verificate, anche con alcune prive di piazzamenti; incompletezza distinta dalla verifica negativa; cinque barre con le nuove etichette in entrambi i perimetri; immagini a 0% iniziale; denominatori documentati e coerenza fra app e cruscotto; provenienza e storia preservate.
- **Task evolutivo:** TSK-0047, `tasks/2026-10-04 - APP - Barre di completamento del lavoro/TASK.md`.
- **Incremento correttivo (2026-10-04):** riaperta sulla regressione segnalata dall'utente e richiusa: recuperati roster 2024/2026, classifiche 2026 e manifest ACQ, verifiche parziali visibili; box allineati in alto. 47 test Python, 46 frontend/PDF, Edge 1560/1400/390 px con offset dei titoli 15 px per tutti i primi cinque anni. Evidenza TSK-0047/HISTORY_AUDIT.md.
- **Verifica chiusura (2026-10-04):** 45 test Python distinti, 46 frontend/PDF e browser Edge 1400/390 px; metriche condivise e cruscotto rigenerato. Classifiche 2025 384/384 e 80/80 verificate; 207 e 40 giochi classificati distinti. Undici roster storici attestati; challenge senza roster visibili. Immagini 0% non implementate. Migrazione 012 e importazioni locali provate su copia e backup; righe originarie preservate; aggiunte concorrenti TSK-0046 registrate separatamente. Nessun accesso BGG o download.
- **Prompt task evolutivo:**

  > Implementa `APP-008` del registro `tasks/2026-10-03 - Registro segnalazioni app/TASK.md`. Le barre annuali di Avanzamento devono misurare il completamento del lavoro e raggiungere il 100% quando la fase è conclusa. Rinominale “Censimento entry”, “Censimento classifica”, “Censimento materiali” e “Acquisizione materiali”. Nel censimento classifica conta le entry con verifica conclusa, incluse quelle documentate come assenti da tutte le classifiche; mantieni distinto il numero di entry effettivamente classificate. Non dedurre verifica negativa dalla sola assenza di rankings. Consulta il contratto annuale classifiche TSK-0045 e predisponi eventuale persistenza degli esiti con provenienza, senza inventare verifiche storiche né accedere a BGG. Definisci denominatori e condizioni di completamento coerenti per tutte le fasi, distinguendo dati ignoti, casi non applicabili e blocchi. Aggiungi “Acquisizione immagini”, inizialmente allo 0%, dichiarando la funzione non ancora implementata e distinguendo immagini rappresentative dai materiali PNG. Non implementare acquisizioni di immagini in questo incremento. Mantieni coerenti app e cruscotto autorevole, aggiornando generatori e documentazione pertinenti. Verifica copertura classifiche completa con entry senza piazzamenti, copertura incompleta, casi senza entry, entrambi i perimetri e nuova barra immagini. Documenta verifiche e limiti, collega il task alla segnalazione e usa il naming di categoria APP previsto da TASK_GOVERNANCE.md, conservando APP-008 nel corpo.

### APP-009 — Schede annuali compatte e righe espandibili

- **Stato:** `risolta` — implementata e verificata in TSK-0049 il 2026-10-04.
- **Data:** 2026-10-04.
- **Area:** Avanzamento per anno.
- **Fonte:** richiesta dell'utente e immagine `C:\Users\39348\AppData\Local\Temp\codex-clipboard-12ce2299-1372-4925-ab20-036efc944aa5.png`.
- **Layout:** passare da cinque a quattro anni per riga nella vista desktop; eliminare “Avanzamento separato per perimetro”; abbreviare “entry complessive” in “entry”.
- **Interazione:** le righe di schede annuali devono essere collassabili e tutte inizialmente collassate. Può essere espansa una sola riga alla volta: espandendone un'altra, quella precedentemente aperta si richiude. Interpretazione registrata: riga = gruppo di quattro anni, non singola metrica o singola scheda.
- **Vista collassata:** altezza minima compatibile con leggibilità e accessibilità; anno, conteggio entry e cinque piccoli indicatori a torta in linea, uno per censimento entry, censimento classifica, censimento materiali, acquisizione materiali e acquisizione immagini.
- **Aggregazione:** nella sintesi di ciascun anno combinare PnP principali e adiacenti (indicati come “laterali” nella richiesta). Sommare numeratori e denominatori omogenei, senza fare la media semplice delle percentuali. Preservare gli stati ignoti/non applicabili e i denominatori specifici delle fasi. Il dettaglio espanso mantiene i due perimetri distinti.
- **Relazioni:** usare le metriche di completamento introdotte da APP-008; l'aggregazione compatta è una presentazione aggiuntiva e non cambia i dati o i confini dei workflow.
- **Criteri per la chiusura:** quattro schede per riga desktop; testi richiesti rimossi/abbreviati; tutte le righe collassate all'apertura; espansione esclusiva verificata; cinque indicatori aggregati corretti anche con denominatori differenti o ignoti; dettaglio distinto per perimetro; uso da tastiera, etichette accessibili delle metriche e layout su schermi stretti verificati.
- **Task evolutivo:** TSK-0049, `tasks/2026-10-04 - APP - Schede annuali compatte e righe espandibili/TASK.md`.
- **Prompt task evolutivo:**

  > Implementa APP-009 del registro `tasks/2026-10-03 - Registro segnalazioni app/TASK.md` nella vista Avanzamento per anno. Mostra quattro anni per riga desktop, elimina “Avanzamento separato per perimetro” e abbrevia “entry complessive” in “entry”. Rendi collassabili le righe intese come gruppi di quattro schede annuali: tutte devono essere collassate inizialmente e una sola può essere espansa; aprendo una nuova riga richiudi quella precedente. Nella modalità collassata riduci al minimo l'altezza e mostra per ogni anno conteggio entry e cinque piccoli indicatori a torta in linea: censimento entry, censimento classifica, censimento materiali, acquisizione materiali e acquisizione immagini. Gli indicatori devono sintetizzare insieme PnP principali e adiacenti, usando le metriche di completamento APP-008: somma numeratori e denominatori omogenei, non fare medie semplici delle percentuali e rappresenta esplicitamente dati ignoti/non applicabili. Mantieni nel dettaglio espanso i due perimetri separati. Prevedi etichette e valori accessibili, attivazione da tastiera e adattamento a schermi stretti, con comportamento coerente quando cambia il raggruppamento responsive. Verifica stato iniziale, espansione esclusiva, aggregazioni, casi senza dati e navigazione esistente. Documenta risultati e limiti e aggiorna lo stato della segnalazione; usa il naming di categoria APP senza identificativi di segnalazione nel titolo.

### APP-010 — Colori coerenti per tipo di avanzamento

- **Stato:** `segnalata`.
- **Data:** 2026-10-04.
- **Area:** Avanzamento per anno → barre e indicatori a torta.
- **Fonte:** richiesta dell'utente e immagine `C:\Users\39348\AppData\Local\Temp\codex-clipboard-fb387d7b-eddd-4ab8-b366-64047fb3d844.png`.
- **Contesto osservato:** il censimento entry usa colori diversi nei PnP principali e negli adiacenti; gli indicatori a torta usano un colore uniforme anche per fasi differenti.
- **Comportamento atteso:** assegnare un colore riconoscibile a ciascuna delle cinque fasi (censimento entry, censimento classifica, censimento materiali, acquisizione materiali, acquisizione immagini). Usare lo stesso colore della fase nelle barre di entrambi i perimetri e nelle relative torte aggregate, in tutti gli anni e nelle modalità collassata/espansa.
- **Scelta della palette:** definire e documentare una mappatura unica, riutilizzando ove opportuno i colori esistenti. Il colore identifica la fase, non il perimetro; principale e adiacente restano identificati dalle intestazioni. Conservare un trattamento coerente della parte non completata e dei dati non disponibili.
- **Relazioni:** segue le metriche APP-008 e il layout compatto APP-009; non modifica formule, conteggi o aggregazioni.
- **Criteri per la chiusura:** cinque colori di fase documentati e applicati coerentemente a barre/torte e principali/adiacenti; contrasto e leggibilità verificati; nomi e valori rendono le metriche distinguibili anche senza percezione del colore; casi 0%, 100% e non disponibile verificati.
- **Task evolutivo:** da assegnare.
- **Prompt task evolutivo:**

  > Implementa APP-010 del registro `tasks/2026-10-03 - Registro segnalazioni app/TASK.md`. Nella vista Avanzamento per anno definisci una mappatura unica di colori per le cinque fasi: censimento entry, censimento classifica, censimento materiali, acquisizione materiali e acquisizione immagini. Ogni fase deve avere lo stesso colore nelle barre dei PnP principali, nelle barre degli adiacenti e nei corrispondenti indicatori a torta aggregati, in ogni anno e nelle viste collassata ed espansa. Scegli una palette distinguibile e coerente con l'app, riutilizzando i colori esistenti dove opportuno, e centralizza la mappatura per evitare divergenze. Mantieni coerenti sfondo non completato e stati non disponibili; conserva etichette e valori accessibili affinché il colore non sia l'unico mezzo di identificazione. Non modificare metriche, dati o aggregazioni introdotte da APP-008/APP-009. Verifica corrispondenza dei colori fra barre e torte, entrambi i perimetri, casi 0%, 100% e dato non disponibile, contrasto e schermi stretti. Documenta la palette e le verifiche e aggiorna la segnalazione con il riferimento al task. Usa il naming di categoria APP senza identificativi di segnalazione nel titolo.

## Registro cambiamenti

- 2026-10-04: inserita APP-010 con prompt evolutivo; nessuna implementazione eseguita nel registro.

- 2026-10-04: inserita APP-009 con prompt evolutivo; nessuna implementazione eseguita nel registro.

- 2026-10-04: APP-008 riaperta e corretta in TSK-0047 per attestazioni storiche omesse e allineamento verticale; audit di tutte le fasi concluso.

- 2026-10-04: APP-008 implementata e chiusa in TSK-0047; evidenze e limiti nel task evolutivo.

- 2026-10-04: inserita APP-008 con prompt evolutivo; nessuna implementazione eseguita.

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
- 2026-10-04: inserita `APP-007` con caso DOCX di riferimento e prompt evolutivo; nessuna implementazione eseguita in questo registro.

- 2026-10-04: APP-007 risolta con lettore DOCX formattato e confronto Word; evidenze e limiti nel task evolutivo dedicato.
