# Esplorazione contest BGG 2025

## Stato
Attivo. Primo incremento: ricognizione delle fonti e baseline delle edizioni 2025.

## Scopo e confini
Esplorare i contest di game design PnP dell'edizione 2025 su BoardGameGeek, quindi censire entry, fasi e risultati per incrementi verificati. L'anno è quello dichiarato dall'edizione, anche quando il calendario attraversa due anni. Nessuna apertura o acquisizione di materiali di gioco. I nuovi casi adiacenti dubbi restano da valutare.

## Input
Thread ufficiali BGG, GeekList e post risultati; serie già censite nel progetto come punti di partenza, senza presumere l'esistenza dell'edizione precedente.

## Deliverable e criteri di successo
- Registro delle fonti 2025 con URL, data, evidenza, copertura e lacune.
- Baseline riproducibile nel catalogo e nel database per i contest verificati.
- Censimenti e risultati successivi separati dalla prima ricognizione.
- Nessun dato ignoto trattato come zero, nessuna conclusione dedotta dal solo anno.
- Verifica dell'integrità SQLite e della conservazione dei dati 2026 prima della chiusura dell'incremento.

## Decisioni del 2026-09-07
- L'utente dedica questo task al 2025 e conserva i controlli 2026 nel task «2026-09-04 - Monitoraggio contest BGG».
- Un task per ciascun anno esplorato a ritroso; nessun branch permanente per anno.
- Lavoro autorizzato su main; commit e push da proporre al termine di incrementi verificati.
- Stato iniziale: main, working tree pulita, allineata al riferimento locale origin/main; remoto non interrogato.

## Verifiche e risultati
### Prima ricognizione del 2026-09-07

Individuate e verificate undici edizioni 2025: In-Hand, 9-Card Nanogame, Children & Family, 1-Card, Solomode, Solitaire, Two-Player, 54-Card, Traditional Deck, Wargame e Roll & Write. Le prime nove corrispondono a serie già note dal 2026; 1-Card e Roll & Write introducono due serie aggiuntive.

Roll & Write è attribuito al 2025 secondo l'etichetta ufficiale, benché sviluppo, freeze e voto terminino nel 2026. Traditional Deck conclude il voto il 2 gennaio 2026. Wargame conserva la proroga ufficiale della chiusura del voto dal 1º all'8 dicembre 2025.

La sfida “2025 Print and Play Challenge” non è un contest di design ed è esclusa. Le sfide bimestrali di 24 ore e i concorsi esterni soltanto annunciati nel forum non sono stati inclusi in questa baseline annuale; potranno essere valutati separatamente se emerge un perimetro stabile. Non è stata trovata evidenza sufficiente di un'edizione 2025 del Turkish PnP o del Bad Comet Cozy analogo a quello 2026.

Creato `catalog/2025-contest-baseline.sql`, destinato ad aggiungere 11 contest, 2 serie, fonti, fasi, osservazioni iniziali e alcuni conteggi ufficiali senza aprire file di gioco.

Lo script è stato prima applicato a una copia del database e poi al database operativo. Risultato: 22 contest complessivi, equamente distribuiti fra 2025 e 2026; 13 serie; 32 fasi 2025; le 365 entry 2026 preesistenti sono rimaste invariate. `PRAGMA foreign_key_check` non segnala violazioni e `PRAGMA integrity_check` restituisce `ok`. Gli otto test dell'applicazione sono superati.

Aggiornati `README.md`, `PROJECT.md` e `catalog/README.md` per rendere visibile la nuova baseline senza presentare le entry 2025 come già censite.

## Prossimi incrementi

1. Proseguire con 9-Card Nanogame e Children & Family, già conclusi e corredati di risultati ufficiali.
2. Completare a seguire 1-Card, Solomode, Solitaire, Two-Player, 54-Card, Traditional Deck, Wargame e Roll & Write.
3. Riesaminare a fine censimento eventuali contest PnP 2025 non appartenenti alle serie individuate, mantenendo separati i candidati adiacenti.

### Censimento In-Hand 2025

Preparato `catalog/2025-in-hand-entries-results.sql` con tutte le 27 entry elencate dal thread: 15 finaliste e 12 ritirate. Registrati 55 piazzamenti di gioco in otto categorie; la categoria Traditional Card/Tarot/Decktet non aveva entry e il premio Best Playtester resta una classifica di persone, non di giochi. Gli ancoraggi interni del thread espongono i titoli ma non gli URL individuali dei WIP, quindi le entry conservano per ora il thread ufficiale come evidenza comune senza inventare collegamenti.

Lo script In-Hand è stato verificato su una copia e applicato al database operativo: 392 entry complessive, di cui 27 nel 2025, e 55 classifiche In-Hand. Integrità e chiavi esterne sono valide; il cruscotto è stato rigenerato e gli otto test dell'applicazione sono superati.
