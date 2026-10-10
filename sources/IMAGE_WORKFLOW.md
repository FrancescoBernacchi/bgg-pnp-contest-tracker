# Workflow immagini dei giochi

Decisioni deliberate nel brainstorming TSK-0065, 2026-10-05. Riferimento autorevole del workflow IMG; implementazione dati/app e tecniche di estrazione ancora da realizzare e collaudare. PWS 1.5.0 invariato.

## Contratto e perimetro

Raccogliere tutte le immagini disponibili e utili nel perimetro esplorato per riconoscimento visivo, estetica e comprensione pratica del gioco. La selezione per l'app avviene dopo la raccolta; non limitare la raccolta a tre immagini.

- BGG: task `Txxxx-AA.MM.GG - IMG - NOME CONTEST AAAA`, un solo contest e anno, incrementi per uno o più giochi esplicitamente inclusi. Ammesso un singolo gioco senza completare tutto il contest.
- Kanare: task `Txxxx-AA.MM.GG - IMG - Kanare Abstract`, con giochi esplicitamente inclusi.
- Fonti future: definire il contratto e l'unità di lavoro dopo valutazione della specifica fonte; il modello Kanare non è generalizzato.
- IMG è autonomo rispetto ai cinque workflow BGG esistenti: non estende roster annuali, MAT, ACQ o monitoraggi. I PNG stampabili come materiali originali restano ACQ; ritagli/catalogazione visiva dei componenti appartengono a IMG.
- Non scaricare nuovi manuali o pacchetti PnP per aggirare ACQ: estrarre da materiali già acquisiti nel perimetro o collegare un successivo task ACQ autorizzato.
- Generazione AI: incremento distinto e facoltativo, tramite Codex su richiesta con giochi/categorie definiti. Nessuna pianificazione ricorrente implicita.

Per gioco registrare fonti/materiali esplorati, residui e impedimenti. Completamento significa esplorazione conclusa nel perimetro dichiarato alla data indicata, con esiti espliciti; non assenza universale di altre immagini. Riprese incrementali per contenuti nuovi o migliorativi, preservando osservazioni precedenti. La mancata generazione AI non impedisce di completare la ricerca delle originali.

## Fonti e provenienze

Partire dalle pagine direttamente collegate al gioco/contest e dai materiali acquisiti. Ricerca libera su web/social/video non compresa automaticamente; eventuale approfondimento con scope esplicito.

| Etichetta | Provenienza |
|---|---|
| BGG-WIP | Thread del gioco: primo post e aggiornamenti successivi |
| BGG-Galleria | Galleria della pagina gioco BGG |
| BGG-Contest | Thread o GeekList del contest |
| Autore | Pagina ufficiale dell'autore |
| Editore | Pagina ufficiale dell'editore |
| Manuale | Estrazione dal regolamento |
| PnP | Estrazione dai materiali da stampare/ritagliare |
| Kanare | Pagina della fonte Kanare |
| Personale | Foto o immagine realizzata dall'utente |
| AI-Generata | Generazione ex novo |
| AI-Rielaborata | Trasformazione di un'immagine esistente |

Altre fonti adottate avranno etichette brevi riconoscibili, senza implicare adozione automatica. Etichetta e catena completa sono separate: un ritaglio PnP mantiene documento, versione, pagina/regione e fonte remota; una rielaborazione AI mantiene il riferimento all'immagine di partenza. Duplicati incontrati su più pagine mantengono tutte le provenienze.

## Classificazione

| Categoria principale | Contenuto |
|---|---|
| Copertina | Gioco, confezione o regolamento |
| Titolo-Grafico | Nome realizzato graficamente |
| Artwork | Illustrazioni, sfondi, elementi artistici |
| Icona | Simbolo compatto identificativo del gioco |
| Setup | Disposizione iniziale dei componenti |
| Partita | Situazione durante il gioco, anche con giocatori |
| Componenti | Vista d'insieme di più componenti |
| Componente | Singolo elemento |
| Dettaglio | Ingrandimento significativo |
| Diagramma | Schema esplicativo di disposizione/azioni/funzionamento |
| Preparazione | Stampa, ritaglio, montaggio, costruzione |

Componente: sottotipi Carta, Plancia, Tabellone, Pedina, Segnalino, Dado, Tessera, Schermo; lato Fronte/Retro/Dorso quando pertinente. Sottotipi aggiuntivi motivati nel task prima di consolidarli.

Una categoria principale nel nome del file; categorie aggiuntive nei metadati. Estrazioni isolate del titolo/artwork sono immagini collegate all'origine. Ruolo principale nell'app distinto dalla categoria.

## Varianti ed estrazione

Integrazione deliberata in TSK-0067, 2026-10-05: fra versioni differenti dello stesso materiale privilegiare sempre la versione più recente per la raccolta/estrazione corrente. Registrare versione dichiarata ed evidenza della successione; data di download e numero vNN dell'immagine archiviata non provano la revisione del materiale. Se l'ordine non è determinabile, mantenerlo incerto e segnalarlo. Le revisioni precedenti non sono fonti concorrenti della raccolta corrente, anche quando differiscono graficamente; restano distinguibili nello storico, con originali già acquisiti immutati. Recuperare componenti unici presenti soltanto nei materiali precedenti, dichiarandone la revisione di origine. Eventuali esigenze di rappresentazione storica di una specifica entry restano esplicite. Questa preferenza integra la selezione corrente, senza trasformare revisioni diverse in duplicati.

Confrontare prima dell'estrazione equivalenti per componente e revisione. Preferire finale a draft, colore a bn/low ink, maggiore risoluzione e contenuto integro. Escludere dalla raccolta le varianti inferiori equivalenti, senza eliminare materiali originali. Recuperare componenti unici da altri file, anche inferiori. Grafica, testi, numeri o simboli diversi sono contenuti distinti, incluse vecchie revisioni; non deduplicare come semplici differenze di qualità. Conflitti (colore poco nitido vs bn nitido) da segnalare per scelta.

Estrarre ogni componente intero con grafica, testo e bordo di gioco, escludendo margini foglio, crocini e istruzioni di stampa. Fronte/dorso separati e collegati. Nove carte diverse producono nove immagini; nove dorsi identici un contenuto con nove occorrenze e associazioni ai componenti. Confronti di similarità sono candidati, non prova di identità; hash del file identifica duplicati byte per byte, non tutti i duplicati visivi.

Conservare documento, pagina e coordinate del ritaglio con unità/sistema di riferimento. Verificare integrità, leggibilità, orientamento, categoria e associazioni prima della catalogazione operativa. Prima estrazione rettangolare fedele per elementi irregolari; scontorno/trasparenza derivato separato. Automatizzare casi chiari, segnalare confini incerti, sovrapposizioni o componenti multi-pagina. Tecniche specifiche e soglie non ancora collaudate: verificarle nel primo lotto senza promettere estrazione universale.

## Naming e libreria

Formato approvato:

`Gioco__Contest-Anno__Categoria__Provenienza__Numero__Versione.ext`

Titolo leggibile con trattini per spazi; titolo originale e ID stabile nei metadati. Anno a quattro cifre. Categoria con sottotipo/lato quando pertinente. Numero stabile dell'immagine nel gioco; `v01` è versione dell'immagine archiviata, distinta da quella dei materiali. Per giochi senza contest usare fonte al posto di Contest-Anno, ad esempio Kanare.

Esempio inventato, sigla non ancora assegnata: `Forest-Trail__9C-2025__Componente-Carta-Dorso__PnP__003__v01.png`.

Struttura: `library/immagini/<ID-stabile>__<Titolo>/` con `originali/`, `estratti/`, `ai/`, `derivati/`. Usare ID esistenti, senza inventare una nuova identità. Nessuna sottocartella per categoria. Un'immagine condivisa fra contest ha un file e più collegamenti; scegliere e documentare il riferimento nel nome senza duplicare il contenuto. Non rinominare lo storico automaticamente quando cambia il titolo.

Manifest testuali versionabili in catalog/, binari fuori Git. Conservare ID immagine/gioco, entry/versione/prodotto pertinenti, contest, titolo, categoria/tag/sottotipo/lato, provenienze e crediti dichiarati, condizioni con fonte/data, percorso relativo, nome originale, formato verificato, dimensioni, bytes, SHA-256, data, versione e collegamenti a originali/estrazioni/derivati, occorrenze, stato validazione/adozione. Dati ignoti espliciti. Non inventare crediti o confondere foto commerciali con prototipi contest. Applicare PUBLICATION_POLICY.md anche ai manifest (niente testi integrali, screenshot o credenziali).

Sigle contest in [IMAGE_CONTEST_CODES.md](IMAGE_CONTEST_CODES.md): nessuna sigla operativa assegnata nel brainstorming. Assegnare e verificare unicità nel primo task pertinente; esempio 9C non costituisce registrazione.

## Esiti, condizioni e ciclo di vita

Esiti dei riferimenti: Acquisita, Solo riferimento, Accesso impedito, Condizioni da chiarire, Esclusa (motivo e collegamento al contenuto mantenuto per duplicati). Conservare riferimenti anche senza file, con data e limite osservato. Accessibilità non prova diritto di acquisizione, redistribuzione o rielaborazione AI. Verificare separatamente condizioni per uso previsto, con fonte/data; non aggirare autenticazione o limiti tecnici.

Originali già acquisiti immutabili/versionati; migliori versioni rendono precedenti Superate e nascoste dalla galleria ordinaria. Varianti inferiori non ancora acquisite: solo riferimento/esclusione. AI rifiutate: Scartata, file/richiesta/motivo conservati inizialmente, fuori galleria ordinaria e copertura. Derivati rigenerabili sostituibili con origine tracciata. Cancellazione definitiva dei file conservati richiede un'operazione esplicita di pulizia.

## Copertura e AI

Per gioco/categoria conservare indipendentemente ricerca, applicabilità, numero originali adottate, numero AI validate e proposte pendenti; non cancellare una ricerca incompleta quando compare un'immagine.

Etichette UI: Da esplorare, Originali presenti, Assenza verificata, Solo AI, Originali + AI, Non applicabile. Assenza verificata riferita a perimetro/data, distinta da accesso impedito o ricerca parziale. Icona, Titolo-Grafico e Artwork desiderate per tutti i giochi; altre categorie caso per caso. Immagini AI non validate non coprono la categoria per l'uso nell'app; originali mancanti restano rilevabili dopo integrazione AI.

Modalità iniziale: Codex genera su richiesta per giochi/categorie selezionati e registra risultati come Da valutare; l'utente valida esplicitamente, anche per lotto, prima dell'adozione. Originali preservate. Registrare richiesta, strumento/modello quando disponibile, data, riferimenti agli input e decisione utente. Conservare fonti/input utilizzabili; evitare invii di materiali a servizi AI senza verificare l'uso previsto. Artwork, Titolo-Grafico e Icona consentono proposte creative; Setup/Componenti richiedono evidenza sufficiente e verifica di fedeltà. Lo stile e l'uso di riferimenti si scelgono nel lotto, non presunti.

Generazione direttamente nell'app: potenziale evoluzione APP separata, con integrazione AI, credenziali, costi e scrittura da progettare; non adottata nella fase iniziale.

## App: requisiti approvati e integrazione operativa

Miniature principali nascondibili nelle liste; galleria per categoria con zoom/didascalia/provenienza/versione; componenti raggruppati per sottotipo e lati collegati; AI riconoscibile e proposte da validare in sezione separata; riepilogo lacune e filtri trasversali. Principale scelta esplicitamente nel catalogo, altrimenti fallback provvisorio Copertina poi Setup. La consultazione non acquisisce né genera immagini. Implementazione in task APP autonomo con modello dati e metriche da verificare; indicatore immagini attuale resta non implementato.

### Decisione utente 2026-10-11 — acquisizione e visibilità nell'app

Le precedenti indicazioni di mancata implementazione descrivono la fase iniziale; persistenza 014 e consultazione/avanzamento sono state implementate in TSK-0067. Da questa decisione, l'autorizzazione di un nuovo incremento IMG comprende anche l'importazione del manifest verificato nel modello operativo esistente, senza ulteriori passaggi autorizzativi. La chiusura comprende controllo delle immagini nella galleria e riconciliazione dell'avanzamento nell'app, con limiti di ricerca preservati.

Usare l'importatore già implementato: verifica su copia, backup e ripristino verificati, transazione, integrità e replay senza modifiche. Registrare manifest, evidenze ed esito nel task IMG e collegare TSK-0067 come riferimento tecnico. Questo passaggio operativo non introduce un task APP né una nuova conferma per ogni lotto. Nuovi schemi/migrazioni, sviluppo app, nuovi materiali ACQ e validazione AI restano soggetti ai propri contratti. Binari/database restano locali; commit/push richiedono autorizzazione propria. La decisione riguarda i prossimi incrementi; non attesta l'importazione dei due giochi già raccolti nel manifest 2026-10-11.

## Stato e verifica

Skill dedicata: `.agents/skills/game-image-acquisition/SKILL.md`. Regole deliberate e verifiche documentali locali; nessun lotto IMG, download, estrazione o generazione eseguiti in TSK-0065. Primo lotto dovrà collaudare navigazione, ritagli, equivalenza/deduplicazione e manifest. Solo pattern tecnici dimostrati vanno promossi come verificati.
