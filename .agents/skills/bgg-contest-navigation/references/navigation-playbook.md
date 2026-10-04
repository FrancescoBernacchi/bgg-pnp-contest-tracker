# Playbook di navigazione BGG

Questo documento raccoglie pattern tecnici verificati durante le esplorazioni. Non presume che contest di anni o serie differenti abbiano la stessa organizzazione.

## Scelta della fonte del roster

| Struttura osservata | Fonte primaria | Verifica di completezza |
|---|---|---|
| Uno o più post nel thread principale | Post mantenuti dall'organizzatore | Totale dichiarato, sezioni finali/ritirate e somma delle righe |
| GeekList ufficiale | Item della GeekList | Numero di item, paginazione e regole su ritiri/rimozioni |
| Hub o indice con thread collegati | Collegamenti dell'Hub | Cardinalità dichiarata e unicità dei thread |
| Risultati separati dal roster | Roster per le entry, post risultati per i piazzamenti | Non ricostruire il roster dai soli vincitori |

## Pattern: `gg-item-link` caricato quando visibile

**Osservato:** Roll & Write Game Design Contest 2025, 10 settembre 2026.

Il thread principale contiene 21 entry finali e 16 ritirate. Prima dell'attivazione, il DOM può mostrare:

```html
<gg-item-link>
  <a href="#">Titolo</a>
</gg-item-link>
```

La destinazione non è assente. BGG la risolve quando il componente entra nell'area visibile. La strategia verificata è:

1. selezionare i `gg-item-link` appartenenti ai post del roster;
2. portarli progressivamente nell'area visibile;
3. attendere il caricamento;
4. estrarre gli `href` risolti;
5. controllare che il totale corrisponda al roster.

Questa procedura ha risolto 37 WIP su 37. Leggere il DOM iniziale senza attivare i componenti aveva prodotto soltanto 18 WIP tramite ricerche sostitutive ed era quindi inadeguato.

## Pattern: nuovi contest prima dell'aggiornamento della GeekList

**Osservato:** forum Design Contests, 2 ottobre 2026. La GeekList comunitaria corrente conteneva ancora 26 elementi e non mostrava il nuovo Roll & Write 2026, pubblicato lo stesso giorno. Nel forum, il filtro `Recent` ordina le discussioni per creazione e permette di confrontare i thread successivi alla data della baseline; `Active` ordina invece per attività recente e mescola thread vecchi con annunci nuovi. Verificare ogni candidato nel primo post del thread ufficiale, controllare data, natura del contest e appartenenza al perimetro; escludere discussioni, side event e contest esterni. Il forum non sostituisce l'indice storico per il censimento retrospettivo.

## Fallback per URL non risolti

Usa i fallback solo dopo l'estrazione sistematica dalla fonte primaria:

1. altri post ufficiali o annunci dell'autore nello stesso thread;
2. GeekList, Hub o indice BGG collegato al contest;
3. ricerca nei forum BGG per titolo e autore o username;
4. ricerca web limitata a `boardgamegeek.com/thread` come ultima risorsa.

Per ogni fallback verifica titolo, autore, appartenenza al contest e identificativo del thread. Una corrispondenza testuale isolata o un risultato che cita il gioco non basta.

## Varianti strutturali da riconoscere

- roster diviso fra più post o pagine;
- entry finali e ritirate in sezioni separate;
- titoli dentro spoiler;
- immagini e titoli che puntano a destinazioni differenti;
- GeekList con item introduttivi da escludere;
- link a pagina gioco invece che a WIP;
- thread rinominati da `WIP` a `COMPONENTS READY`, `CONTEST READY` o `WITHDRAWN`;
- URL dinamici, redirect e riferimenti cancellati;
- risultati che usano titoli o grafie differenti dal roster.

## Registrazione di un nuovo pattern

## Pattern: GeekList paginata con caricamento progressivo

**Osservato:** `Community PnP contests and winners (2008 to 2024)`, 16 settembre 2026.

Una pagina può dichiarare 25 elementi ma materializzarne nel DOM soltanto quelli vicini alla posizione corrente. Scorrere progressivamente l'intera pagina, accumulare i record per indice, deduplicare e verificare esplicitamente l'assenza di lacune da `1` al totale dichiarato. Saltare direttamente in fondo può perdere gli elementi intermedi. Nel caso osservato il DOM iniziale restituiva 21 record complessivi; il controllo progressivo ha prodotto 166 record su 166.

## Registrazione di un nuovo pattern

Per ogni pattern aggiungere:

- contest e data di osservazione;
- struttura della pagina;
- sintomo che rende fallace il metodo ordinario;
- procedura riuscita;
- controllo quantitativo o qualitativo eseguito;
- limiti noti e fallback appropriato.

## Pattern: risorse nel primo post

**Osservato:** Roll & Write 2025, 10 settembre 2026.

I WIP combinano anchor ordinari, `gg-item-link`, video incorporati, cartelle, file, pagine di distribuzione, piattaforme giocabili e strumenti. Estrarre dal primo post renderizzato e non dalla sola indicizzazione. Skyfall ripete la stessa cartella; Thieves of Bandervon usa lo stesso URL video con due descrizioni; Leaning Tower contiene Vimeo in `iframe`; i player YouTube aggiungono collegamenti tecnici al canale da escludere. Funzione e forma tecnica restano provvisorie fino alla revisione completa del 2025.

## Pattern: post originale non più osservabile

**Osservato:** Black Market, In-Hand 2025, 11 settembre 2026.

Un thread WIP può restare raggiungibile dopo la rimozione del post originale. Il primo `article.post` renderizzato è allora una risposta successiva e non prova né l'assenza di risorse né il contenuto completo dichiarato dall'autore. Verificare autore, timestamp e testo del primo articolo residuo. Se una risposta attesta una risorsa ma non ne espone l'URL, registrare `not_observable`, conservare l'evidenza testuale e non inventare o ricostruire la destinazione. Questa casistica è distinta sia da `none_declared` sia da WIP non individuato.

## Pattern: requisiti materiali senza collegamento

**Osservato:** Roll & Write, In-Hand e Children & Family 2025, 11 settembre 2026.

Il primo post può dichiarare requisiti necessari o alternativi che non compaiono fra le risorse URL: dadi comuni o personalizzati, mazzi standard, penne, matite, meeple, fiches, monete, fermagli, strumenti di montaggio e dispositivi digitali. Estrarli dall'intero primo post e conservarli separatamente dalle risorse remote. Registrare la frase originale e mantenere distinti quantità, categoria funzionale, obbligatorietà e approvvigionamento. Alternative domestiche come “monete, caramelle o fiches” non vanno fuse con il componente stampabile che sostituiscono. Se le regole non sono state consultate, marcare la copertura `first_post_only`; `none_declared` significa soltanto assenza di una dichiarazione sufficientemente esplicita nel post.

## Pattern: immagine BGG dichiarata come componente stampabile

**Osservato:** `Lucky Words`, 1-Card 2025, 11 settembre 2026.

Un collegamento `/image/...` non è sempre decorativo. Se il primo post associa esplicitamente l'immagine a un'istruzione operativa come “Tap the image above to print your copy”, conservarla come risorsa BGG del gioco con etichetta e contesto. L'eccezione richiede evidenza testuale esplicita: immagini di copertina, anteprime, esempi e illustrazioni prive di tale dichiarazione restano escluse.

## Pattern: materiali aggiuntivi nelle varianti dipendenti

**Osservato:** Solomode 2025, 15 settembre 2026.

Nei contest di varianti il primo post può elencare insieme componenti del gioco base e materiali introdotti dalla modalità. La dipendenza dal gioco base non deve trasformarsi nella duplicazione del suo intero inventario: conservare come requisiti della variante soltanto carte, dadi, fogli, timer, dispositivi o sostituzioni esplicitamente aggiuntivi. Una dichiarazione come “no extra components” è evidenza utile per la scansione ma non genera un requisito materiale. Se il post propone un kit alternativo per provare la variante senza il gioco base, registrarlo come `alternative`, conservando separata la dipendenza principale.

## Pattern: piazzamenti con immagini numeriche e spoiler

**Verificato:** TSK-0046, classifiche 2024, 4 ottobre 2026; Nine Card articolo 43546487, 54 Card articoli 45273141/45273144, Traditional 45411639 e Two Player 43538242.

Le posizioni possono essere immagini con alt `d10-N`: conservare il numero esplicito insieme al testo e alla fonte, senza ricavarlo dall'ordine delle righe. Gli spoiler sono normale contenuto della pagina: aprirli con i controlli della pagina e leggere le categorie complete; gli spoiler annidati richiedono controllare di nuovo i pulsanti ancora chiusi. Preservare pari merito e menzioni senza posizione. Escludere premi ai playtester e non convertire premi GeekGold o totali globali dei votanti in voti dei giochi. Conservare separatamente completezza del confronto delle liste pubblicate e presenza delle entry nelle classifiche.
