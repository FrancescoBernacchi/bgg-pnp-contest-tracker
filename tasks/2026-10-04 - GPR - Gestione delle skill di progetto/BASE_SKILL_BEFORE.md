---
name: bgg-contest-navigation
description: Esplora e censisce pagine BoardGameGeek relative a contest, roster, entry, WIP, risultati e risorse, scegliendo la strategia di navigazione adatta alla struttura osservata e registrando i pattern riutilizzabili nel progetto.
---

# Navigazione dei contest BGG

Usa questa skill per ogni esplorazione o verifica di contest, entry, WIP, risultati e collegamenti ai materiali su BoardGameGeek.

## Obiettivo operativo

Costruisci una catena verificabile fra contest, fonte del roster, singola entry, WIP BGG e risorse dichiarate. Distingui sempre:

- pagina o elemento che prova l'iscrizione;
- thread WIP della singola entry;
- collegamenti ai materiali dichiarati nel WIP;
- verifica successiva della disponibilità o acquisizione dei materiali.

Non interpretare un collegamento non ancora risolto come assente.

## Instradamento del task

Prima della navigazione classifica il lavoro secondo uno dei cinque tipi definiti in `PROJECT.md`: censimento globale dei contest, censimento annuale delle entry, analisi materiali di un singolo contest, acquisizione materiali di un singolo contest o monitoraggio di un singolo contest. Applica soltanto le fasi pertinenti al tipo scelto. In particolare, il censimento annuale si ferma al roster delle entry; WIP, risorse e requisiti appartengono all'analisi del singolo contest; verifica degli host e download appartengono all'acquisizione dello stesso singolo contest.

Se la richiesta combina unità diverse o propone analisi o download trasversali a più contest, segnala la deviazione e indica la scomposizione conforme prima di procedere. Usa lo stesso instradamento quando viene chiesto genericamente quale sia il prossimo passo.

## Procedura

1. Identifica la fonte BGG autorevole per il perimetro: post del thread principale, GeekList, Hub, risultati o altra lista mantenuta dall'organizzatore.
2. Comprendi la struttura renderizzata prima di estrarre: sezioni, paginazione, spoiler, entry finali, ritiri e collegamenti dinamici.
3. Usa la fonte autorevole come elenco di controllo e conserva l'ordine e i conteggi pubblicati.
4. Estrai in blocco titolo, autore, stato e URL dai collegamenti renderizzati. Filtra immagini, profili, navigazione e sponsor.
5. Se BGG usa `gg-item-link` con `href="#"`, porta ogni componente nell'area visibile, attendi che BGG ne risolva la destinazione e leggi l'`href` solo dopo il caricamento. Esegui questa operazione sistematicamente sull'intero roster.
6. Confronta il numero di URL risolti con il numero di entry. Verifica identificativi univoci, dominio BGG, tipo di pagina e associazione titolo-autore.
7. Applica fallback soltanto agli scarti residui, nell'ordine più economico indicato nel playbook.
8. Registra fonte, data, metodo, conteggi, anomalie e grado di completezza. Aggiorna database e manifest senza perdere osservazioni storiche valide.

Per strutture già incontrate o fallback, leggi [references/navigation-playbook.md](references/navigation-playbook.md).

## Accumulo della conoscenza

Dopo una struttura nuova o un fallimento istruttivo:

1. documenta nel task l'evidenza specifica e la correzione;
2. aggiungi al playbook soltanto il pattern riutilizzabile;
3. indica contesto, sintomo, strategia riuscita, verifica e limiti;
4. promuovi in questa skill una regola solo quando cambia stabilmente il comportamento dell'agente;
5. correggi o sostituisci strategie superate invece di accumulare istruzioni contraddittorie.

Il compito continuativo dell'agente è migliorare la competenza nella navigazione BGG durante le esplorazioni, mantenendo le procedure rapide, verificabili e adattabili ai formati storici del sito.

## Collegamenti dichiarati nel WIP

1. Limita l'osservazione al primo `article.post` e al relativo `.post-body` renderizzato.
2. Attiva gli eventuali `gg-item-link` nel corpo del post.
3. Estrai `a[href]`, `iframe[src]`, `video[src]` e `source[src]`.
4. Escludi navigazione, profili, immagini decorative, canali aggiunti dai player e duplicati tecnici.
5. Conserva URL, dominio, testo e contesto senza aprire la destinazione.
6. Assegna separatamente funzione e forma tecnica provvisorie.
7. Accorpa URL identici conservando tutte le descrizioni sorgente.
8. Registra l'assenza soltanto dopo questi controlli.

Non chiudere la tassonomia prima del confronto di tutti i contest dell'anno.

## Materiali di gioco dichiarati nel WIP

Durante la lettura integrale del primo post, censisci separatamente anche i requisiti materiali che non dipendono da un URL: dadi, mazzi standard, strumenti di scrittura, pedine, segnalini, oggetti domestici, dispositivi e materiali di montaggio. Conserva testo originale, quantità, contesto, obbligatorietà e modalità di approvvigionamento; assegna categorie soltanto provvisorie. Per una variante dipendente da un gioco base, registra come requisiti della variante soltanto i componenti aggiuntivi o sostitutivi esplicitamente dichiarati e conserva separatamente la dipendenza, senza duplicare l'intera dotazione del gioco base. Distingui esplicitamente la copertura `first_post_only` da un futuro inventario integrato dalle regole. Non dedurre un componente dalla sola descrizione della meccanica e non interpretare il silenzio del primo post come prova che il gioco non richieda materiali.
