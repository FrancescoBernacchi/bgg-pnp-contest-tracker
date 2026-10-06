# Componenti condivisi, limiti e possibili acquisizioni

TSK-0070, verifica 2026-10-06. Inventario per gioco in INVENTORY.md, dettagli/crediti/URL nel manifest `catalog/kanare_material_census_2026-10-06.json`. Sono riepiloghi di materiali, non regolamenti ricostruiti. Ogni associazione resta legata al gioco e alla sezione ufficiale.

## Sintesi trasversale

- **Set classici**: ViceVersi ammette Othello/Reversi (64 dischi bifacciali, 8×8); Chess Territorial dichiara sufficiente un normale set scacchi. Circular Chess usa 32 pezzi scacchi ma richiede plancia circolare, quindi non è attestata la sufficienza del solo set normale completo di plancia quadrata.
- **Carta e penne**: Pentwall include il foglio stampabile 10×10 (p.1) e preparazione p.2; penne a due colori, oppure un colore con riempimenti distinguibili. Le sagome non sono pezzi da acquisire separatamente.
- **Esagoni e pezzi comuni**: indice e Generic Board Hexagonal supportano Stoic, Stride, Squish, Unlace, Skirt, Node, Orochi, Sibling. Il set offre lati 4/5 davanti e 5/6 dietro; quantità di confezione Full 92, Lite 62, Pieceless zero. Le quantità di ogni gioco dipendono dal setup: Stride 13 per colore, gli altri non vanno uniformati a 46 per colore. Squish e Unlace hanno diagrammi verificati senza inventare un minimo universale.
- **Plance quadrate/scacchiere**: Mabi, Tiptoe, Apart nel set Square; Zong-Heng, Binary, Incorrect Checkers nel Checkered. Tiptoe ammette anche plancia esagonale; Binary adegua esplicitamente il numero di pezzi alla dimensione; Zong-Heng richiede metà dei pezzi per colore. Distinguere gioco sulle celle e sulle intersezioni (Shape Chess 13×13 intersezioni).
- **Alquerque/Fanorona**: Alquad e Sight usano 5×5 intersezioni; Collapse 9×5. Il set Alquerq contiene 26 dischi per colore, non attribuiti come requisito a ogni gioco. Alquad prepara un pezzo per colore e poi 11 in mano; Collapse ha 11 per colore nel diagramma; Sight richiede impilabilità senza quantità numerica universale dichiarata.
- **Più colori**: Color Pack contiene 10 pezzi rossi/blu/gialli/grigi, da combinare con altri componenti; non è da solo sufficiente a tutti i quattro giochi. Nuts Sorting usa 10 per ciascuno di sei colori; Fruits Platter 6 per colore sulla plancia più un indicatore per colore fuori plancia; Candy Chain 8 per colore; Snaketrail tre colori effettivi, quantità di setup scelta dai giocatori.
- **Raccolte**: Stacking Trilogy condivide 40 dischi e plancia bifacciale; Abande/Attangle usano 18 per colore, Accasta Pari 20 con aree Castle. Il documento ha sezioni distinte (pp.1–2, 3–4, 5–6). Onager/Vault condividono confezione ma richiedono rispettivamente esagono lato 6 con 13 pezzi per colore e tre Lake, oppure quadrata 10×10 con 10 per colore. Quantum Control/Leap condividono fascicolo ma usano 49 pezzi contro 61 e diversa suddivisione della plancia.
- **Pezzi e segni specifici**: Saiju richiede combinazioni colore/simbolo e Shadow; Iago due tipi di dischi con faccia rossa; RosenKreuz simbolo e colore distinti; Tori Shogi promozioni e quaglie orientate; Queen’s Guard una regina distinta per colore. Non presumere sostituzioni basate su sola somiglianza.
- **Sostituzioni esplicite**: Borderland permette sostituti quando i pezzi finiscono; Dryad dichiara quantità illimitate e permette componenti di altri giochi o sostituzione di dischi sotto la cima. Non estendere queste concessioni agli altri giochi.

Le misure commerciali sono riepilogate per ogni confezione nell’inventario. Non sono automaticamente misure minime per una realizzazione domestica. Plance con aree, trono, castelli, simboli o contatori non sono equivalenti a una plancia generica priva di tali segni senza ulteriore prova.

## Quattro varianti aggregate

Tutte e quattro hanno adesso attribuzione puntuale **nel manifest**, verificata tramite indice ufficiale nominativo e sezione del documento: Bloody Queen → QueensGuard EN p.2; Stacking Morris → Morris EN p.2; Custodial Pah-Tum → PahTum EN fixed p.2; Tori Shogi＋ → ToriShogi EN p.3. Non sono stati modificati i collegamenti storici del database. Tori Shogi＋ comprende civetta e/o averla facoltative; civetta sostituisce una gru per giocatore, averla aggiunge una riserva per giocatore. La confezione da 39 pezzi non è il requisito simultaneo della base da 32.

## Blocchi e informazioni da chiarire

| Caso | Evidenza e limite | Trattamento |
|---|---|---|
| Swarm | Matrice ufficiale Online play: solo titolo `Swarm (unpublished)`, nessun materiale puntuale osservato | Analisi bloccata informativamente; nessuna piattaforma aperta o matching incerto utilizzato; autore non registrato |
| Candy Chain | SETUP p.1 dice 5×5 con 48 pezzi; figure 1/2 mostrano 8×8 | Analisi parziale; mantenute entrambe le osservazioni, nessuna dimensione operativa imposta |
| Dryad | Regolamento 40 cubi, confezione 35; regolamento ammette quantità illimitate e sostituzioni | Analisi fonti completa; divergenza del contenuto conservata, possibile scelta domestica da valutare |
| Residuel | Regolamento richiede 25 dischi piccoli per colore oltre a 44 tessere; confezione elenca solo le tessere | Analisi completa con contenuto scatola non riconciliato; non attestata presenza dei dischi nella scatola |
| Borderland, Iago, Ripples, Enso | Confezione 70/62/62/36 contro dotazioni regolamento 60/61/61/32 | Quantità mantenute separatamente; surplus non trasformato in requisito |
| LAG | Due URL EN con parametro differente restituiscono lo stesso SHA-256 nel rilevamento | Entrambi URL preservati, una sola identità binaria; nessuna versione inventata |
| Iago | Pagina gioco offre Iago_EN, prodotto Iago_S_EN; hash distinti, requisito materiale concorde | Entrambi letti e conservati come riferimenti; nessuna equivalenza integrale o identità di versione attestata |
| Quantità o misure non dichiarate | Alcuni giochi comuni descrivono dimensioni variabili o diagrammi senza distinta numerica | Campo non dichiarato e posizione del diagramma; nessun minimo inventato |
| Lingue | 37 JA, 2 ES, 1 ZH soltanto URL/metadati; IT non osservato nelle fonti esaminate | Nessuna lettura integrale o acquisizione; non dichiarata assenza globale di traduzioni |

Nessun errore HTTP/login ha bloccato le 62 consultazioni PDF EN. Le 39 immagini censite restano riferimenti, senza acquisizione né lotto IMG. I rendering locali sono consultazioni di pagine di regolamento, non estrazioni catalogate di componenti.

## Compatibilità e conservazione

ID di giochi, prodotti e risorse del nucleo generale riutilizzati. Le tabelle `entry_material_requirements`/`entry_material_scans` richiedono entry BGG; non si creano entry fittizie, colonne Kanare o payload opachi nel database. Nessuna scrittura SQLite: prova importazione su copia, backup e idempotenza DB non applicabili. Il manifest è l’osservazione autorevole di questo MAT; un’eventuale integrazione generalizzata dei requisiti sarà decisione architetturale separata. App e metriche APP-008 restano invariate.

## Prossime acquisizioni proposte, non eseguite

Un task **ACQ - Kanare Abstract** separato può selezionare pochi regolamenti e componenti in base all’interesse dell’utente. Candidati pratici: regolamenti dei giochi con componenti comuni già disponibili all’utente (Stride, Apart, Binary, Alquad) oppure un fascicolo condiviso Stacking Trilogy per tre giochi. Pentwall, ViceVersi e Chess Territorial sono già acquisiti e non vanno duplicati. Prima della scelta verificare disponibilità dei componenti personali, condizioni specifiche dei file e divergenze pertinenti; Candy Chain richiede prima chiarimento della plancia, Swarm una fonte ufficiale puntuale. Nessun lotto automaticamente autorizzato.
