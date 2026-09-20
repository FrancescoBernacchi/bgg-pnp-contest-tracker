# Censimento Kanare Abstract

## Stato

Primo incremento concluso: censimento delle superfici principali e roster preliminare completo. Importazione nel database e acquisizione delle immagini restano incrementi successivi.

## Tipo di attività

Censimento di una singola fonte non-BGG. È un incremento autonomo dell'evoluzione multifonte e non appartiene ai cinque workflow BGG.

## Scopo

Ricostruire e verificare il roster completo dei giochi attualmente osservabili su Kanare_Abstract, raccogliendo un primo nucleo di informazioni direttamente attribuite alla fonte.

## Input

- pagina indice `https://kanare-abstract.com/en/pages/games_by_kanare`;
- pagine Kanare collegate dall'indice;
- pagine editoriali Kanare pertinenti, in particolare designer e gioco online;
- decisioni multifonte già consolidate in `PROJECT.md`.

## Perimetro

Per ogni titolo:

- titolo ufficiale e URL Kanare;
- gruppo e ordine nell'indice;
- natura del record: gioco autonomo, gioco con componenti comuni o variante;
- forma di accesso dichiarata;
- autore, se indicato;
- stato di osservabilità della pagina;
- immagine rappresentativa e relativi metadati disponibili;
- collegamenti dichiarati a regolamenti, BGG o piattaforme online, senza verificarne le destinazioni;
- fonte, data del rilevamento e anomalie.

## Esclusioni

- verifica esterna su BGG o piattaforme online;
- analisi integrale dei regolamenti;
- inventario completo dei materiali;
- riconciliazione automatica con giochi già presenti;
- download di immagini secondarie;
- cancellazione di record non più osservati.

## Deliverable

- roster Kanare completo e quantitativamente riconciliato con la pagina indice;
- dati strutturati versionabili con provenienza e data;
- eventuale migrazione minima e riutilizzabile necessaria a rappresentare la fonte senza duplicare concetti specifici;
- nota sulle anomalie e sulla copertura;
- aggiornamento di `PROJECT_PROGRESS.md` se cambiano copertura o stato della pipeline.

## Criteri di successo

- ogni titolo dell'indice compare una sola volta nel roster oppure ha una duplicazione motivata;
- il conteggio è riconciliato per sezione e complessivamente;
- gioco, variante, prodotto e risorsa non sono confusi;
- collegamenti non verificati restano esplicitamente tali;
- ogni osservazione volatile conserva URL e data;
- verifiche e limiti sono registrati prima della chiusura.

## Registro operativo

- 2026-09-20: task aperto; pagina indice preliminarmente osservata con 38 collegamenti/titoli distribuiti in nove gruppi.
- 2026-09-20: riconciliati 38 titoli dell'indice, 39 prodotti del catalogo e la pagina Online Play. Separati 64 candidati gioco/variante, prodotti, raccolte e accessori. Risultati, anomalie e limiti registrati in `sources/KANARE-ABSTRACT-TITLE-CENSUS.md`.
- 2026-09-20: nessuna destinazione BGG o piattaforma esterna aperta; PDF soltanto censiti; nessuna immagine o regola scaricata.

## Verifiche

- conteggio dell'indice: 10 + 2 + 1 + 21 + 4 = 38;
- catalogo prodotti: 16 + 16 + 7 = 39 prodotti su tre pagine;
- pagine HTML di tutti i 34 titoli non-PDF dell'indice osservate con titolo, immagine e collegamenti ai regolamenti;
- 21 schede prodotto aggiuntive lette per distinguere gioco, raccolta e giochi inclusi;
- pagina designer usata per i crediti dichiarati; attribuzioni storiche non trasformate in autori moderni;
- anomalie di grafia e collegamento preservate senza fusione automatica.

## Risultato e prossimo incremento

Il censimento preliminare conta 64 candidati gioco/variante. Il prossimo incremento utile è progettare e applicare la migrazione minima del modello multifonte, quindi importare questi record con fonti, alias, prodotti, relazioni e stati di verifica. L'acquisizione delle immagini rappresentative avverrà soltanto dopo che il modello potrà registrare correttamente originali, metadati e hash.
