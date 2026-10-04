# Censimento dei contest PnP principali 2024

Verifica BGG e importazione offline: 2026-10-04. Task TSK-0015, incremento richiesto nella chat `01a1069c-78b1-7042-bfad-2bd049fb50bd`. Obiettivo: barra verde dei contest con entry censite, senza estendere il lavoro ai sei contest challenge adiacenti ancora privi di roster.

| Contest | Entry persistite | Fonte autorevole | Osservazione |
|---|---:|---|---|
| 54-Card | 30 | [GeekList 338815](https://boardgamegeek.com/geeklist/338815/2024-54-card-game-design-contest-entries) e [post ritiri](https://boardgamegeek.com/thread/3327975/2024-54-card-game-design-contest) | 29 item, più un ritiro presente soltanto nel thread; 26 operative, 4 ritirate |
| Children & Family | 29 | [GeekList 329968](https://boardgamegeek.com/geeklist/329968/2024-children-and-family-game-design-contest) | Import verificato il 2026-09-19, preservato senza nuovo rilevamento |
| In-Hand | 35 | [Thread ufficiale](https://boardgamegeek.com/thread/3162927/2024-in-hand-game-design-contest) | 24 operative, 5 ritirate, 6 squalificate; autore non dichiarato nell'elenco |
| 9-Card | 50 | [Thread ufficiale, post roster e ritiri](https://boardgamegeek.com/thread/3218618/2024-9-card-nanogame-print-and-play-design-contest) | 32 contest ready, 18 ritirate; due destinazioni cancellate |
| 1-Card | 50 | [GeekList 334560](https://boardgamegeek.com/geeklist/334560/2024-1-card-print-and-play-design-contest-entrants) | Due pagine, posizioni 1–50 |
| Roll & Write | 37 | [Thread ufficiale, post roster e ritiri](https://boardgamegeek.com/thread/3353041/2024-roll-and-write-game-design-contest) | 29 operative e 8 ritirate; autori dichiarati accanto ai titoli |
| Solitaire | 57 | [GeekList 337391](https://boardgamegeek.com/geeklist/337391/2024-solitaire-print-and-play-design-contest-entra) | Tre pagine, posizioni 1–57 |
| Traditional Deck | 50 | [Thread ufficiale, post Entries](https://boardgamegeek.com/thread/3360317/2024-traditional-deck-game-design-contest) | 42 operative e 8 ritirate; autori dichiarati |
| Two Player | 29 | [GeekList 328627](https://boardgamegeek.com/geeklist/328627/2024-two-player-pnp-game-design-contest-entries) | Due pagine, posizioni 1–29 |
| Wargame | 14 | [GeekList 326943](https://boardgamegeek.com/geeklist/326943/2024-wargame-print-and-play-game-design-contest-en) | Incluse due voci che puntano a pagine gioco; non convertite in WIP |

Totale PnP principali: **381 entry, 10/10 contest, 100%**. Aggiunte 352 entry. Adiacenti preservati: 28 entry Solomode, 1/7 contest con roster. Totale annuale operativo: 409 entry in 17 contest; il 100% della barra verde non dichiara completati gli adiacenti né le fasi successive.

## Provenienza, storia e limiti

- I nove JSON `catalog/2024-*-roster-2026-10-04.json` conservano i record estratti dal DOM renderizzato. Per le GeekList, tutte le pagine sono state enumerate e confrontate con il totale dichiarato; per i thread, i componenti lazy sono stati attivati e gli URL risolti prima dell'estrazione. Roster e ritiri sono stati conservati separatamente e poi accorpati per URL, senza duplicare le menzioni.
- Le posizioni di GeekList sono originali. Per elenchi non numerati e ritiri supplementari la posizione persistita è l'ordine di estrazione, non una classifica. Titoli normalizzati sono derivati; intestazioni originali restano in `entry_text_raw` e JSON.
- 9-Card: riga 13 (Jun Li) e riga ritirata 33 (Robert Lausevic) mostrano `[link to deleted destination]`. Nessun URL o titolo è stato ricostruito. Le etichette `Titolo non osservabile` sono identificatori di consultazione espliciti, non titoli dichiarati. Ricerca web residua mirata a BGG/Jun Li senza risultati. L'enumerazione delle 50 righe è completa; l'identificazione nominale è 48/50.
- In-Hand: l'osservazione del 2026-09-18 dichiara 7 squalificate ma ne nomina 6. La verifica attuale conferma 6. Il dato storico resta invariato; la nuova osservazione è operativa. Gli autori assenti nell'elenco restano non dichiarati, senza aprire WIP per colmare la lacuna.
- 1-Card: la nota storica del 2026-09-18 indica 54; la GeekList osservata oggi dichiara 50 e contiene esattamente 50 item. Si registra la discrepanza senza attribuirla a rimozioni non dimostrate. Il thread principale dichiara che tutte le entry sono ancora nella GeekList.
- 54-Card: quattro ritiri nel thread, tre presenti nei 29 item della GeekList; l'unione per URL produce 30 record. La voce supplementare Twineheart non dichiara autore in questa fonte.
- Submitter di GeekList conservato con ruolo `submitter`, senza presumere che sia l'autore. I crediti `designer` derivano soltanto dalle righe che dichiarano `by` nel roster ufficiale. Stati normalizzati derivano da dichiarazioni del roster o dalle intestazioni osservate; una semplice iscrizione non certifica lo stato contest ready.

## Verifica e riproducibilità

`catalog/import_2024_core_rosters.py` importa soltanto i JSON locali, senza accesso di rete. Prova preliminare su copia in memoria, controllo cardinalità e sequenze, URL BGG e unicità, integrità e chiavi esterne. Seconda esecuzione senza nuove righe. Backup SQLite con API backup prima dell'applicazione al database operativo. Esito persistito in `catalog/2024-core-rosters-verification-2026-10-04.json`.

Il backend `app.server.progress_rows` restituisce PnP 10/10 e 381 entry; adiacenti 1/7 e 28 entry; classifiche, materiali letti e acquisizioni annuali restano a zero. Sezioni annuali A/B rigenerate tramite `app/generate_project_progress.py`. Nessun file di gioco, WIP, host esterno o materiale analizzato/acquisito.

Prossimo approfondimento utile: task MAT dedicato a **un singolo contest 2024**, per esempio 9-Card, preservando le due entry non osservabili. Il completamento delle sei challenge adiacenti è un successivo incremento BGG-A 2024, separato dall'obiettivo verde soddisfatto qui; non è stato avviato.
