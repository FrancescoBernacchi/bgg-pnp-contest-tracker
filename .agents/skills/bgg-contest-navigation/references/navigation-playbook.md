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
