# Recupero sequenziale dei residui — 2026-11-06

Incrementi autorizzati dall’utente nella chat primaria TSK-0087: prima riconciliazione roster TSK-0005, poi approfondimento MAT TSK-0051 e successiva acquisizione TSK-0087. Singolo contest 13, nessun nuovo contest, immagini rappresentative, schema, applicazione, messaggio esterno o Git. PWS 1.5.0 mantenuto rispetto al canonico 1.8.0 per decisione precedente.

## Risultato

**The King of Arcades completato: sei originali PNG, cinque pagine numerate delle regole EN e tavola delle nove carte.** Contenuti pubblicati da 张 怡杰 @hanjiong; la prima pagina dichiara il credito designer Han Jiong. Forme del nome conservate senza crearne equivalenze anagrafiche ulteriori. Fonte WIP [3478326](https://boardgamegeek.com/thread/3478326/article/45803714#45803714), immagini [rule01](https://boardgamegeek.com/image/8813275), [rule02](https://boardgamegeek.com/image/8813276), [rule03](https://boardgamegeek.com/image/8813277), [rule04](https://boardgamegeek.com/image/8813279), [rule05](https://boardgamegeek.com/image/8813280), [card](https://boardgamegeek.com/image/8813281). Immagini datate 6 aprile 2025, verifica/acquisizione 6 novembre 2026. Originali 2480×3508, PNG integri, SHA256/dimensioni e contenuto verificati; regole complete fino alla condizione di vittoria e foglio di nove carte. Nessuna conversione o alterazione.

La baseline precedente escludeva quelle immagini perché non aveva riscontrato istruzioni operative di stampa. Il contenuto degli originali mostra invece regole vere, con nove carte dichiarate PnP ready, e la relativa tavola. Correzione motivata e datata: sei nuove risorse, menzioni e osservazioni; vecchie esclusioni e scansioni none_declared preservate. Non viene introdotta una regola generale che converta foto di giochi in materiali stampabili. Download originali dal menu BGG, copia personale; avviso All rights reserved, nessuna licenza aperta/redistribuzione attestata. Copertina, foto e immagini di omaggi di terzi escluse. Non è acquisizione IMG.

**Metriche operative condivise con l’app: ACQ 70/93, tre parziali e 20 bloccati, quindi 23 residui; MAT89/94 e IMG17/94 invariati.** Libreria contest73 giochi/213 file, globale411 file. Quantità osservate da SQLite e app/work_progress.py dopo le tre transazioni, A/B rigenerate automaticamente. Nessuna falsa acquisizione per il frammento Brawl.

## Riconciliazione ElementaBrawl

Il [roster](https://boardgamegeek.com/thread/3436343/article/45443446#45443446) contiene 30 righe ritirate: riga18 ElementaBrawl, designer Michael. Il [WIP originale](https://boardgamegeek.com/thread/3476068/article/45782275#45782275) di Michael @Duaneski, 11 marzo 2025, descrive un solo gioco ElementaBrawl e un unico pacchetto; tutti e tre i post letti, nessuna seconda identità Brawl. Il record473 è ora intitolato ElementaBrawl, con Elementa conservato come alias storico e nuovo nome fonte verificato. Osservazioni su473 e474 documentano l’errore di split.

Record474 e relative osservazioni storiche preservati; nessuna fusione/cancellazione né seconda acquisizione o completamento inferito dai file già registrati su473. La riconciliazione documentale è conclusa. Rimane un distinto consolidamento tecnico del record spurio per rimuoverlo dai denominatori mantenendo tutti i riferimenti: il presente incremento non cancella righe né inventa un tipo applicativo per escluderle. Il conteggio operativo 70/93 resta quindi conservativo e include ancora il frammento tecnico tra i23 residui; non sono23 giochi distinti mancanti provati.

## Tredici approfondimenti MAT

Autori WIP e fonti dirette, date dei singoli post e conteggi nel manifest; riassunti originali, trascrizioni integrali solo in outputs ignorato. Copertura supplementare mirata dell’intero WIP osservabile, distinta dalla baseline first_post_only. Non scansionati altri giochi citati per playtest, nessuna richiesta ai proprietari o verifica accessi di TSK-0098.

| Entry | Gioco | Post/pagine | Esito |
|---:|---|---|---|
|409|Forest Tip|8/1|Nessun link sostitutivo; stessa cartella rimossa. Omaggio grafico di terzi non adottato.|
|426|Ocean Path|22/1|Aggiornamenti e chiarimenti senza nuovi URL; link ad altri giochi sono playtest.|
|438|Slayer|18/1|Sempre stesso Drive; hub Linktree dell’autore verificato in ACQ, sito ufficiale is-006.framer.ai/page#slayer-pocket senza file. TTS/video esclusi.|
|442|Stand of Supremacy|26/2|Entrambe le pagine lette, nessun riferimento sostitutivo; aggiornamenti e playtest.|
|450|Tralim|10/1|Stessi tre URL regole/carte/low ink. Carte v4 già acquisite; due file ancora mancanti, nessun nuovo riferimento.|
|445|The King of Arcades|5/1|Correzione delle immagini operative: cinque pagine EN e tavola carte acquisite successivamente in ACQ.|
|456|Daily Dungeon|7/1|Idea/progettazione procedurale, nessun materiale pubblicato.|
|457|Dice Production|1/1|Idea ritirata, nessun aggiornamento/file.|
|461|Main Line Mayhem|1/1|Rules/Cards ancora segnaposto, nessun URL.|
|462|Network with an Octopuse|2/1|Descrizione e ispirazione, nessun materiale offerto.|
|463|Psychodynamic Fronts|1/1|Idea, nessun materiale offerto.|
|466|Three-Legged Race|1/1|Idea, regole menzionate ma nessun file offerto.|
|468|UHBC - Containment Breach|4/1|Tre post riservati vuoti, Rules/PnP senza URL.|

Nessun link sostitutivo emerso per i quattro riferimenti rimossi o Tralim. Nessun ulteriore retry 401/404 già confermato nello stesso giorno. Non si afferma assenza universale di materiali al di fuori delle fonti osservate.

## Verifiche e tracciabilità

Manifest catalog/2025_nine_card_sequential_recovery_2026-11-06.json; runner offline register_sequential_recovery.py, tre stadi identity/mat/acq separati, ciascuno con copia, prova di idempotenza, backup/ripristino completo e transazione esclusiva identica alla copia. Rapporti SEQUENTIAL_IDENTITY/MAT/ACQ_VERIFICATION_2026-11-06.json. Integrity ok, zero FK, replay RO verificati. Tutte le righe pregresse preservate salvo titolo e data verifica del solo gioco473; nessun binario o prova integrale destinato a Git. Backup in outputs/nine-card-sequential-recovery-2026-11-06/.

Primo originale PNG trasferito tramite download BGG browser e riscontrato in Downloads; gli altri acquisiti dagli URL originali realmente osservati nel menu, con rete fuori sandbox autorizzata dopo fallimento DNS ordinario. Nessuna autenticazione o protezione aggirata. La copia del primo PNG in Downloads utente è preservata. Browser concluso prima della registrazione offline; app non modificata/riavviata, metriche verificate tramite adattatore condiviso e generatore.

## Efficacia e limiti

Skill base BGG/MAT/ACQ applicate; lettura dei post successivi deliberata esplicitamente per i candidati, nessuna modifica tacita al contratto generale first_post_only. Caricamento BGG iniziale parziale: controllata cardinalità e paginazione, deduplicati26 post Stand of Supremacy. Click al centro di un articolo può aprire un’immagine collegata; non usarlo come scorrimento generico. Didascalie rule/card e ispezione degli originali hanno corretto un falso negativo della precedente analisi. Candidato di miglioramento TSK-0048: controllare materiali incorporati con istruzione PnP contenuta nelle regole stesse, preservando la distinzione dalle immagini decorative. Nessuna modifica tecnica alla skill in questo incremento.

Ciclo concluso, obiettivo ACQ totale ancora impedito. Passi successivi: gestione risposte in TSK-0098; consolidamento tecnico dello split con impatto esplicito sui denominatori; nuovi link offerti dai proprietari per riferimenti rimossi. Nessun nuovo sollecito o messaggio autorizzato da questo rapporto. Incrementi locali da committare selettivamente solo su richiesta.
