# Cruscotto di avanzamento della raccolta

Ultimo aggiornamento: 2026-10-05. Fonte dello stato: repository e database operativo locale; censimenti materiali 54-Card e Solitaire 2025 verificati il 2026-10-05. Ultimo controllo periodico BGG registrato: 2026-10-02.

Questo documento è il quadro operativo autorevole dell'avanzamento complessivo del progetto. Riassume cosa è coperto, cosa è ancora incompleto e quale sia il prossimo passo utile; non sostituisce il database, i registri di provenienza, il calendario dei controlli o i `TASK.md`.

## Censimento globale dei contest BGG

Questa è la vista pertinente al task globale: comprende tutte le annualità osservate. La baseline di 305 unità è stata integrata il 2 ottobre 2026 con il nuovo Roll & Write, per un totale di 306 contest. La verifica puntuale dei thread e degli stati prudenziali storici resta aperta.

| Anno | Contest/challenge candidate | Stato dei titoli | Stato di consolidamento |
|---:|---:|---|---|
| 2026 | 18 | estratti; 5 challenge individualizzate | baseline aggiornata il 2 ottobre con Roll & Write; NINE attiva e un'anomalia storica fuori dall'anno |
| 2025 | 17 | estratti; 6 challenge individualizzate | baseline finalizzata |
| 2024 | 17 | estratti; 6 challenge individualizzate | baseline finalizzata |
| 2023 | 21 | estratti; 9 challenge individualizzate | baseline finalizzata |
| 2022 | 12 | estratti | baseline finalizzata |
| 2021 | 14 | estratti | baseline finalizzata |
| 2020 | 24 | estratti; 11 challenge individualizzate | baseline finalizzata |
| 2019 | 23 | estratti; 12 challenge individualizzate | baseline finalizzata |
| 2018 | 22 | estratti; 12 challenge individualizzate | baseline finalizzata; League of Designers resta unknown |
| 2017 | 20 | estratti; 12 challenge individualizzate | baseline finalizzata |
| 2016 | 21 | estratti; 12 challenge individualizzate | baseline finalizzata |
| 2015 | 24 | estratti; 12 challenge individualizzate | baseline finalizzata |
| 2014 | 22 | estratti; 12 challenge individualizzate | baseline finalizzata |
| 2013 | 18 | estratti; 12 challenge individualizzate | baseline finalizzata |
| 2012 | 12 | estratti; 6 challenge individualizzate | baseline finalizzata |
| 2011 | 9 | estratti | baseline finalizzata |
| 2010 | 5 | estratti | baseline finalizzata |
| 2009 | 6 | estratti | baseline finalizzata |
| 2008 | 1 | estratto | baseline finalizzata |

Fonti operative: `sources/BGG-PNP-CONTEST-GLOBAL-COVERAGE.md`, `sources/BGG-PNP-24H-CHALLENGES.md` e `catalog/global-contest-census.sql`.

## Avanzamento dettagliato dei contest già nel database

Le sezioni A e B sottostanti sono rigenerate dal database con `app/generate_project_progress.py` e coprono il 2008–2026. Il contenuto compreso tra i marcatori HTML non deve essere modificato manualmente.

<!-- BEGIN GENERATED ANNUAL PROGRESS -->
## A. Sintesi immediata per anno

Le metriche di lavoro coincidono con l'app, separate dagli indicatori di presenza. Censimento entry: contest con roster completo attestato / contest registrati. Classifica: entry con tutte le categorie verificate, incluse assenze esplicite / entry applicabili. Materiali: primo post censito con esito osservabile secondo contratto MAT, regole integrabili successivamente / entry applicabili; acquisizione: tutte le risorse dichiarate acquisite / entry applicabili. Gli esiti non applicabili escono dal denominatore; ignoti e blocchi non completano la fase. Zero entry non significa 100%. Immagini rappresentative: 0%, funzione non implementata. Le sezioni di dettaglio L/D mostrano invece la presenza storica di scansioni/file e non il completamento del lavoro.

### Gruppo anni 1 di 5

| N. | Tipologia e indicatore | 2026 | 2025 | 2024 | 2023 |
|---:|:---|:---|:---|:---|:---|
|   |   | **18 contest nel database** | **17 contest nel database** | **17 contest nel database** | **21 contest nel database** |
| 2 | **[1-Card Print and Play Contest](https://boardgamegeek.com/thread/3686290/2026-1-card-print-and-play-contest)** |   |   |   |   |
|   |     Stati entry | 🟢 contest_ready 30 | — | — | — |
|   |     Censimento entry | 1/1 contest attestati · 30 entry | — | — | — |
|   |     Censimento classifica | 0/30 · 0% · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — | — | — |
|   |     Censimento materiali | 0/30 · 0% · 0 N/A · 0 bloccate | — | — | — |
|   |     Acquisizione materiali | 0/30 · 0% · 0 N/A · 0 bloccate | — | — | — |
|   |     Acquisizione immagini | 0% · non implementata | — | — | — |
| 3 | **[1-Card Print and Play Design Contest](https://boardgamegeek.com/thread/3487579/2025-1-card-print-and-play-design-contest)** |   |   |   |   |
|   |     Stati entry | — | 🟢 contest_ready 38 | — | — |
|   |     Censimento entry | — | 1/1 contest attestati · 38 entry | — | — |
|   |     Censimento classifica | — | 38/38 · 100% · 0 N/A · 0 bloccate · 31 entry classificate · 9 categorie | — | — |
|   |     Censimento materiali | — | 37/38 · 97% · 0 N/A · 1 bloccate | — | — |
|   |     Acquisizione materiali | — | 0/34 · 0% · 4 N/A · 1 bloccate | — | — |
|   |     Acquisizione immagini | — | 0% · non implementata | — | — |
| 10 | **[14th ROLL & WRITE GAME DESIGN CONTEST](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | — | — | — | 🔴  |
|   |     Censimento entry | — | — | — | 0/1 contest attestati · 0 entry |
|   |     Censimento classifica | — | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie |
|   |     Censimento materiali | — | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione materiali | — | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione immagini | — | — | — | 0% · non implementata |
| 11 | **[15th ROLL & WRITE GAME DESIGN CONTEST](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | — | — | — | 🔴  |
|   |     Censimento entry | — | — | — | 0/1 contest attestati · 0 entry |
|   |     Censimento classifica | — | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie |
|   |     Censimento materiali | — | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione materiali | — | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione immagini | — | — | — | 0% · non implementata |
| 17 | **[24 Hour Design Challenge](https://boardgamegeek.com/thread/3765638/september-october-2026-bi-monthly-24-hour-design-c)** |   |   |   |   |
|   |     Stati entry | 🟢 contest_ready 3 | 🟢 contest_ready 12 | 🔴  | 🔴  |
|   |     Censimento entry | 1/1 contest attestati · 3 entry | 1/1 contest attestati · 12 entry | 0/1 contest attestati · 0 entry | 0/1 contest attestati · 0 entry |
|   |     Censimento classifica | 0/3 · 0% · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | 0/12 · 0% · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie |
|   |     Censimento materiali | 0/3 · 0% · 0 N/A · 0 bloccate | 0/12 · 0% · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione materiali | 0/3 · 0% · 0 N/A · 0 bloccate | 0/12 · 0% · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione immagini | 0% · non implementata | 0% · non implementata | 0% · non implementata | 0% · non implementata |
| 22 | **[54-Card Game Design Contest](https://boardgamegeek.com/thread/3746297/2026-54-card-game-design-contest)** |   |   |   |   |
|   |     Stati entry | 🟡 unknown 8, wip 4, components_available 2, idea 2, contest_ready 1 | 🟢 contest_ready 28 | 🟡 contest_ready 16, components_available 5, unknown 4, withdrawn 4, contest_complete 1 | 🔴  |
|   |     Censimento entry | 1/1 contest attestati · 17 entry | 1/1 contest attestati · 28 entry | 1/1 contest attestati · 30 entry | 0/1 contest attestati · 0 entry |
|   |     Censimento classifica | 0/17 · 0% · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | 28/28 · 100% · 0 N/A · 0 bloccate · 20 entry classificate · 11 categorie | 30/30 · 100% · 0 N/A · 0 bloccate · 19 entry classificate · 11 categorie | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie |
|   |     Censimento materiali | 0/17 · 0% · 0 N/A · 0 bloccate | 28/28 · 100% · 0 N/A · 0 bloccate | 0/30 · 0% · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione materiali | 0/17 · 0% · 0 N/A · 0 bloccate | 0/28 · 0% · 0 N/A · 0 bloccate | 0/30 · 0% · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione immagini | 0% · non implementata | 0% · non implementata | 0% · non implementata | 0% · non implementata |
| 28 | **[9-Card Nanogame Print and Play Design Contest](https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest)** |   |   |   |   |
|   |     Stati entry | 🟢 contest_ready 44, components_available 11, idea 8, withdrawn 6 | 🟢 contest_ready 63, withdrawn 31 | — | — |
|   |     Censimento entry | 1/1 contest attestati · 69 entry | 1/1 contest attestati · 94 entry | — | — |
|   |     Censimento classifica | 69/69 · 100% · 0 N/A · 0 bloccate · 17 entry classificate · 11 categorie | 94/94 · 100% · 0 N/A · 0 bloccate · 19 entry classificate · 11 categorie | — | — |
|   |     Censimento materiali | 0/69 · 0% · 0 N/A · 0 bloccate | 89/94 · 95% · 0 N/A · 5 bloccate | — | — |
|   |     Acquisizione materiali | 0/69 · 0% · 0 N/A · 0 bloccate | 0/93 · 0% · 1 N/A · 1 bloccate | — | — |
|   |     Acquisizione immagini | 0% · non implementata | 0% · non implementata | — | — |
| 31 | **[Bad Comet Cozy Game Design Contest](https://boardgamegeek.com/thread/3683796/submissions-closed-2026-bad-comet-cozy-game-design)** |   |   |   |   |
|   |     Stati entry | 🟡 contest_ready 2, components_available 1, playtest_ready 1, unknown 1 | — | — | — |
|   |     Censimento entry | 0/1 contest attestati · 5 entry | — | — | — |
|   |     Censimento classifica | 0/5 · 0% · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — | — | — |
|   |     Censimento materiali | 0/5 · 0% · 0 N/A · 0 bloccate | — | — | — |
|   |     Acquisizione materiali | 0/5 · 0% · 0 N/A · 0 bloccate | — | — | — |
|   |     Acquisizione immagini | 0% · non implementata | — | — | — |
| 35 | **[Children & Family Game Design Contest](https://boardgamegeek.com/thread/3645079/2026-children-and-family-game-design-contest)** |   |   |   |   |
|   |     Stati entry | 🟢 contest_ready 36, withdrawn 2 | 🟢 contest_ready 27 | 🟢 contest_complete 29 | 🔴  |
|   |     Censimento entry | 1/1 contest attestati · 38 entry | 1/1 contest attestati · 27 entry | 1/1 contest attestati · 29 entry | 0/1 contest attestati · 0 entry |
|   |     Censimento classifica | 38/38 · 100% · 0 N/A · 0 bloccate · 20 entry classificate · 5 categorie | 27/27 · 100% · 0 N/A · 0 bloccate · 16 entry classificate · 5 categorie | 29/29 · 100% · 0 N/A · 0 bloccate · 15 entry classificate · 2 categorie | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie |
|   |     Censimento materiali | 0/38 · 0% · 0 N/A · 0 bloccate | 26/27 · 96% · 0 N/A · 0 bloccate | 0/29 · 0% · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione materiali | 0/38 · 0% · 0 N/A · 0 bloccate | 12/23 · 52% · 4 N/A · 10 bloccate · 1 verifiche parziali | 0/29 · 0% · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione immagini | 0% · non implementata | 0% · non implementata | 0% · non implementata | 0% · non implementata |
| 55 | **[In-Hand Game Design Contest](https://boardgamegeek.com/thread/3591416/2026-in-hand-game-design-contest)** |   |   |   |   |
|   |     Stati entry | 🟢 contest_ready 22, withdrawn 3 | 🟢 contest_ready 15, withdrawn 12 | 🟡 unknown 24, disqualified 6, withdrawn 5 | 🔴  |
|   |     Censimento entry | 1/1 contest attestati · 25 entry | 1/1 contest attestati · 27 entry | 1/1 contest attestati · 35 entry | 0/1 contest attestati · 0 entry |
|   |     Censimento classifica | 25/25 · 100% · 0 N/A · 0 bloccate · 22 entry classificate · 9 categorie | 27/27 · 100% · 0 N/A · 0 bloccate · 15 entry classificate · 9 categorie | 35/35 · 100% · 0 N/A · 0 bloccate · 20 entry classificate · 10 categorie | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie |
|   |     Censimento materiali | 0/25 · 0% · 0 N/A · 0 bloccate | 25/27 · 93% · 0 N/A · 1 bloccate | 0/35 · 0% · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione materiali | 0/25 · 0% · 0 N/A · 0 bloccate | 0/21 · 0% · 6 N/A · 1 bloccate | 0/35 · 0% · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione immagini | 0% · non implementata | 0% · non implementata | 0% · non implementata | 0% · non implementata |
| 65 | **[Nine Card Nanogame Print and Play Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | — | — | 🟢 contest_ready 32, withdrawn 18 | 🔴  |
|   |     Censimento entry | — | — | 1/1 contest attestati · 50 entry | 0/1 contest attestati · 0 entry |
|   |     Censimento classifica | — | — | 50/50 · 100% · 0 N/A · 0 bloccate · 22 entry classificate · 17 categorie | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie |
|   |     Censimento materiali | — | — | 0/50 · 0% · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione materiali | — | — | 0/50 · 0% · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione immagini | — | — | 0% · non implementata | 0% · non implementata |
| 66 | **[One Card Print and Play Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | — | — | — | 🔴  |
|   |     Censimento entry | — | — | — | 0/1 contest attestati · 0 entry |
|   |     Censimento classifica | — | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie |
|   |     Censimento materiali | — | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione materiali | — | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione immagini | — | — | — | 0% · non implementata |
| 67 | **[One Card Print and Play Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | — | — | 🟡 contest_ready 21, unknown 19, components_available 9, contest_complete 1 | — |
|   |     Censimento entry | — | — | 1/1 contest attestati · 50 entry | — |
|   |     Censimento classifica | — | — | 50/50 · 100% · 0 N/A · 0 bloccate · 33 entry classificate · 12 categorie | — |
|   |     Censimento materiali | — | — | 0/50 · 0% · 0 N/A · 0 bloccate | — |
|   |     Acquisizione materiali | — | — | 0/50 · 0% · 0 N/A · 0 bloccate | — |
|   |     Acquisizione immagini | — | — | 0% · non implementata | — |
| 75 | **[Print and Play Wargame Design Contest](https://boardgamegeek.com/thread/3627732/contest-open-2026-print-and-play-wargame-design-co)** |   |   |   |   |
|   |     Stati entry | 🟡 playtest_ready 13, wip 6, components_available 2, idea 1, unknown 1 | 🟢 contest_ready 19 | — | — |
|   |     Censimento entry | 1/1 contest attestati · 23 entry | 1/1 contest attestati · 19 entry | — | — |
|   |     Censimento classifica | 0/23 · 0% · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | 19/19 · 100% · 0 N/A · 0 bloccate · 19 entry classificate · 8 categorie | — | — |
|   |     Censimento materiali | 23/23 · 100% · 0 N/A · 0 bloccate | 0/19 · 0% · 0 N/A · 0 bloccate | — | — |
|   |     Acquisizione materiali | 0/12 · 0% · 11 N/A · 0 bloccate | 0/19 · 0% · 0 N/A · 0 bloccate | — | — |
|   |     Acquisizione immagini | 0% · non implementata | 0% · non implementata | — | — |
| 78 | **[Roll & Write Game Design Contest](https://boardgamegeek.com/thread/3776341/the-2026-roll-and-write-game-design-contest)** |   |   |   |   |
|   |     Stati entry | 🔴  | 🟢 contest_ready 21, withdrawn 16 | 🟡 unknown 29, withdrawn 8 | — |
|   |     Censimento entry | 0/1 contest attestati · 0 entry | 1/1 contest attestati · 37 entry | 1/1 contest attestati · 37 entry | — |
|   |     Censimento classifica | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | 37/37 · 100% · 0 N/A · 0 bloccate · 19 entry classificate · 11 categorie | 37/37 · 100% · 0 N/A · 0 bloccate · 25 entry classificate · 11 categorie | — |
|   |     Censimento materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | 37/37 · 100% · 0 N/A · 0 bloccate | 0/37 · 0% · 0 N/A · 0 bloccate | — |
|   |     Acquisizione materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | 27/30 · 90% · 7 N/A · 1 bloccate · 2 verifiche parziali | 0/37 · 0% · 0 N/A · 0 bloccate | — |
|   |     Acquisizione immagini | 0% · non implementata | 0% · non implementata | 0% · non implementata | — |
| 81 | **[Solitaire Print and Play Contest](https://boardgamegeek.com/thread/3716853/2026-solitaire-print-and-play-contest)** |   |   |   |   |
|   |     Stati entry | 🟡 components_available 49, wip 23, playtest_ready 10, unknown 5, idea 2 | 🟢 contest_ready 74 | — | — |
|   |     Censimento entry | 1/1 contest attestati · 89 entry | 1/1 contest attestati · 74 entry | — | — |
|   |     Censimento classifica | 0/89 · 0% · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | 74/74 · 100% · 0 N/A · 0 bloccate · 48 entry classificate · 16 categorie | — | — |
|   |     Censimento materiali | 0/89 · 0% · 0 N/A · 0 bloccate | 74/74 · 100% · 0 N/A · 0 bloccate | — | — |
|   |     Acquisizione materiali | 0/89 · 0% · 0 N/A · 0 bloccate | 0/64 · 0% · 10 N/A · 0 bloccate | — | — |
|   |     Acquisizione immagini | 0% · non implementata | 0% · non implementata | — | — |
| 82 | **[Solitaire Print and Play Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | — | — | 🟡 contest_ready 31, components_available 15, unknown 9, contest_complete 2 | 🔴  |
|   |     Censimento entry | — | — | 1/1 contest attestati · 57 entry | 0/1 contest attestati · 0 entry |
|   |     Censimento classifica | — | — | 57/57 · 100% · 0 N/A · 0 bloccate · 40 entry classificate · 16 categorie | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie |
|   |     Censimento materiali | — | — | 0/57 · 0% · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione materiali | — | — | 0/57 · 0% · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione immagini | — | — | 0% · non implementata | 0% · non implementata |
| 83 | **[Solomode Contest](https://boardgamegeek.com/thread/3670686/2026-solomode-contest)** |   |   |   |   |
|   |     Stati entry | 🟢 contest_ready 21 | 🟢 contest_ready 38 | 🟢 contest_complete 28 | 🔴  |
|   |     Censimento entry | 1/1 contest attestati · 21 entry | 1/1 contest attestati · 38 entry | 1/1 contest attestati · 28 entry | 0/1 contest attestati · 0 entry |
|   |     Censimento classifica | 21/21 · 100% · 0 N/A · 0 bloccate · 20 entry classificate · 8 categorie | 38/38 · 100% · 0 N/A · 0 bloccate · 19 entry classificate · 9 categorie | 28/28 · 100% · 0 N/A · 0 bloccate · 14 entry classificate · 7 categorie | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie |
|   |     Censimento materiali | 0/21 · 0% · 0 N/A · 0 bloccate | 36/38 · 95% · 0 N/A · 0 bloccate | 0/28 · 0% · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione materiali | 0/21 · 0% · 0 N/A · 0 bloccate | 0/23 · 0% · 15 N/A · 0 bloccate | 0/28 · 0% · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione immagini | 0% · non implementata | 0% · non implementata | 0% · non implementata | 0% · non implementata |
| 90 | **[Traditional Deck Game Design Contest](https://boardgamegeek.com/thread/3761810/2026-traditional-deck-game-design-contest)** |   |   |   |   |
|   |     Stati entry | 🟡 unknown 11, components_available 7 | 🔴 unknown 42 | 🟡 unknown 42, withdrawn 8 | 🔴  |
|   |     Censimento entry | 1/1 contest attestati · 18 entry | 1/1 contest attestati · 42 entry | 1/1 contest attestati · 50 entry | 0/1 contest attestati · 0 entry |
|   |     Censimento classifica | 0/18 · 0% · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | 42/42 · 100% · 0 N/A · 0 bloccate · 21 entry classificate · 5 categorie | 50/50 · 100% · 0 N/A · 0 bloccate · 23 entry classificate · 6 categorie | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie |
|   |     Censimento materiali | 0/18 · 0% · 0 N/A · 0 bloccate | 0/42 · 0% · 0 N/A · 0 bloccate | 0/50 · 0% · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione materiali | 0/18 · 0% · 0 N/A · 0 bloccate | 0/42 · 0% · 0 N/A · 0 bloccate | 0/50 · 0% · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione immagini | 0% · non implementata | 0% · non implementata | 0% · non implementata | 0% · non implementata |
| 92 | **[Turkish Print and Play Design Contest](https://boardgamegeek.com/thread/3701420/2026-turkce-yazdir-ve-oyna-pnp-kutu-oyunu-tasarim)** |   |   |   |   |
|   |     Stati entry | 🟢 components_available 14, withdrawn 6 | — | — | — |
|   |     Censimento entry | 1/1 contest attestati · 20 entry | — | — | — |
|   |     Censimento classifica | 0/20 · 0% · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — | — | — |
|   |     Censimento materiali | 0/20 · 0% · 0 N/A · 0 bloccate | — | — | — |
|   |     Acquisizione materiali | 0/20 · 0% · 0 N/A · 0 bloccate | — | — | — |
|   |     Acquisizione immagini | 0% · non implementata | — | — | — |
| 96 | **[Two-Player Print and Play Game Design Contest](https://boardgamegeek.com/thread/3620917/2026-two-player-print-and-play-game-design-contest)** |   |   |   |   |
|   |     Stati entry | 🟢 components_available 32, contest_ready 7, playtest_ready 4, wip 1, withdrawn 1 | 🟢 contest_ready 40 | 🟡 contest_ready 14, unknown 7, components_available 5, idea 2, contest_complete 1 | 🔴  |
|   |     Censimento entry | 1/1 contest attestati · 45 entry | 1/1 contest attestati · 40 entry | 1/1 contest attestati · 29 entry | 0/1 contest attestati · 0 entry |
|   |     Censimento classifica | 0/45 · 0% · 0 N/A · 0 bloccate · 12 verifiche parziali · 12 entry classificate · 8 categorie | 40/40 · 100% · 0 N/A · 0 bloccate · 20 entry classificate · 5 categorie | 29/29 · 100% · 0 N/A · 0 bloccate · 17 entry classificate · 10 categorie | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie |
|   |     Censimento materiali | 0/45 · 0% · 0 N/A · 0 bloccate | 39/40 · 98% · 0 N/A · 1 bloccate | 0/29 · 0% · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione materiali | 0/45 · 0% · 0 N/A · 0 bloccate | 0/35 · 0% · 5 N/A · 1 bloccate | 0/29 · 0% · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione immagini | 0% · non implementata | 0% · non implementata | 0% · non implementata | 0% · non implementata |
| 102 | **[Wargame Print and Play Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | — | — | 🟡 unknown 6, components_available 2, contest_ready 2, withdrawn 2, contest_complete 1, idea 1 | 🔴  |
|   |     Censimento entry | — | — | 1/1 contest attestati · 14 entry | 0/1 contest attestati · 0 entry |
|   |     Censimento classifica | — | — | 14/14 · 100% · 0 N/A · 0 bloccate · 11 entry classificate · 8 categorie | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie |
|   |     Censimento materiali | — | — | 0/14 · 0% · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione materiali | — | — | 0/14 · 0% · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione immagini | — | — | 0% · non implementata | 0% · non implementata |

### Gruppo anni 2 di 5

| N. | Tipologia e indicatore | 2022 | 2021 | 2020 | 2019 |
|---:|:---|:---|:---|:---|:---|
|   |   | **12 contest nel database** | **14 contest nel database** | **24 contest nel database** | **23 contest nel database** |
| 5 | **[10th anniversary Christmas Print and Play Game contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | — | — | 🔴  | — |
|   |     Censimento entry | — | — | 0/1 contest attestati · 0 entry | — |
|   |     Censimento classifica | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — |
|   |     Censimento materiali | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — |
|   |     Acquisizione materiali | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — |
|   |     Acquisizione immagini | — | — | 0% · non implementata | — |
| 6 | **[10th ROLL & WRITE GAME DESIGN CONTEST](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | — | 🔴  | — | — |
|   |     Censimento entry | — | 0/1 contest attestati · 0 entry | — | — |
|   |     Censimento classifica | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — | — |
|   |     Censimento materiali | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — |
|   |     Acquisizione materiali | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — |
|   |     Acquisizione immagini | — | 0% · non implementata | — | — |
| 7 | **[11th ROLL & WRITE GAME DESIGN CONTEST](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | 🔴  | — | — | — |
|   |     Censimento entry | 0/1 contest attestati · 0 entry | — | — | — |
|   |     Censimento classifica | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — | — | — |
|   |     Censimento materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — | — |
|   |     Acquisizione materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — | — |
|   |     Acquisizione immagini | 0% · non implementata | — | — | — |
| 8 | **[12th ROLL & WRITE GAME DESIGN CONTEST](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | 🔴  | — | — | — |
|   |     Censimento entry | 0/1 contest attestati · 0 entry | — | — | — |
|   |     Censimento classifica | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — | — | — |
|   |     Censimento materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — | — |
|   |     Acquisizione materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — | — |
|   |     Acquisizione immagini | 0% · non implementata | — | — | — |
| 9 | **[13th ROLL & WRITE GAME DESIGN CONTEST](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | 🔴  | — | — | — |
|   |     Censimento entry | 0/1 contest attestati · 0 entry | — | — | — |
|   |     Censimento classifica | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — | — | — |
|   |     Censimento materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — | — |
|   |     Acquisizione materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — | — |
|   |     Acquisizione immagini | 0% · non implementata | — | — | — |
| 17 | **[24 Hour Design Challenge](https://boardgamegeek.com/thread/3765638/september-october-2026-bi-monthly-24-hour-design-c)** |   |   |   |   |
|   |     Stati entry | — | — | 🔴  | 🔴  |
|   |     Censimento entry | — | — | 0/1 contest attestati · 0 entry | 0/1 contest attestati · 0 entry |
|   |     Censimento classifica | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie |
|   |     Censimento materiali | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione materiali | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione immagini | — | — | 0% · non implementata | 0% · non implementata |
| 18 | **[2nd ROLL & WRITE GAME DESIGN CONTEST](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | — | — | — | 🔴  |
|   |     Censimento entry | — | — | — | 0/1 contest attestati · 0 entry |
|   |     Censimento classifica | — | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie |
|   |     Censimento materiali | — | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione materiali | — | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione immagini | — | — | — | 0% · non implementata |
| 19 | **[3rd ROLL & WRITE GAME DESIGN CONTEST](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | — | — | 🔴  | — |
|   |     Censimento entry | — | — | 0/1 contest attestati · 0 entry | — |
|   |     Censimento classifica | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — |
|   |     Censimento materiali | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — |
|   |     Acquisizione materiali | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — |
|   |     Acquisizione immagini | — | — | 0% · non implementata | — |
| 21 | **[4th ROLL & WRITE GAME DESIGN CONTEST](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | — | — | 🔴  | — |
|   |     Censimento entry | — | — | 0/1 contest attestati · 0 entry | — |
|   |     Censimento classifica | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — |
|   |     Censimento materiali | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — |
|   |     Acquisizione materiali | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — |
|   |     Acquisizione immagini | — | — | 0% · non implementata | — |
| 22 | **[54-Card Game Design Contest](https://boardgamegeek.com/thread/3746297/2026-54-card-game-design-contest)** |   |   |   |   |
|   |     Stati entry | 🔴  | 🔴  | 🔴  | 🔴  |
|   |     Censimento entry | 0/1 contest attestati · 0 entry | 0/1 contest attestati · 0 entry | 0/1 contest attestati · 0 entry | 0/1 contest attestati · 0 entry |
|   |     Censimento classifica | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie |
|   |     Censimento materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione immagini | 0% · non implementata | 0% · non implementata | 0% · non implementata | 0% · non implementata |
| 23 | **[5th ROLL & WRITE GAME DESIGN CONTEST](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | — | — | 🔴  | — |
|   |     Censimento entry | — | — | 0/1 contest attestati · 0 entry | — |
|   |     Censimento classifica | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — |
|   |     Censimento materiali | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — |
|   |     Acquisizione materiali | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — |
|   |     Acquisizione immagini | — | — | 0% · non implementata | — |
| 24 | **[6th ROLL & WRITE GAME DESIGN CONTEST](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | — | 🔴  | — | — |
|   |     Censimento entry | — | 0/1 contest attestati · 0 entry | — | — |
|   |     Censimento classifica | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — | — |
|   |     Censimento materiali | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — |
|   |     Acquisizione materiali | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — |
|   |     Acquisizione immagini | — | 0% · non implementata | — | — |
| 25 | **[7th ROLL & WRITE GAME DESIGN CONTEST](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | — | 🔴  | — | — |
|   |     Censimento entry | — | 0/1 contest attestati · 0 entry | — | — |
|   |     Censimento classifica | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — | — |
|   |     Censimento materiali | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — |
|   |     Acquisizione materiali | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — |
|   |     Acquisizione immagini | — | 0% · non implementata | — | — |
| 26 | **[8th ROLL & WRITE GAME DESIGN CONTEST](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | — | 🔴  | — | — |
|   |     Censimento entry | — | 0/1 contest attestati · 0 entry | — | — |
|   |     Censimento classifica | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — | — |
|   |     Censimento materiali | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — |
|   |     Acquisizione materiali | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — |
|   |     Acquisizione immagini | — | 0% · non implementata | — | — |
| 27 | **[9 Card Game Print and Play Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | — | — | 🔴  | 🔴  |
|   |     Censimento entry | — | — | 0/1 contest attestati · 0 entry | 0/1 contest attestati · 0 entry |
|   |     Censimento classifica | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie |
|   |     Censimento materiali | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione materiali | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione immagini | — | — | 0% · non implementata | 0% · non implementata |
| 28 | **[9-Card Nanogame Print and Play Design Contest](https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest)** |   |   |   |   |
|   |     Stati entry | — | 🔴  | — | — |
|   |     Censimento entry | — | 0/1 contest attestati · 0 entry | — | — |
|   |     Censimento classifica | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — | — |
|   |     Censimento materiali | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — |
|   |     Acquisizione materiali | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — |
|   |     Acquisizione immagini | — | 0% · non implementata | — | — |
| 29 | **[9th ROLL & WRITE GAME DESIGN CONTEST](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | — | 🔴  | — | — |
|   |     Censimento entry | — | 0/1 contest attestati · 0 entry | — | — |
|   |     Censimento classifica | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — | — |
|   |     Censimento materiali | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — |
|   |     Acquisizione materiali | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — |
|   |     Acquisizione immagini | — | 0% · non implementata | — | — |
| 36 | **[Children and Family Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | 🔴  | — | — | — |
|   |     Censimento entry | 0/1 contest attestati · 0 entry | — | — | — |
|   |     Censimento classifica | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — | — | — |
|   |     Censimento materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — | — |
|   |     Acquisizione materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — | — |
|   |     Acquisizione immagini | 0% · non implementata | — | — | — |
| 37 | **[Children's Game Print and Play Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | — | — | — | 🔴  |
|   |     Censimento entry | — | — | — | 0/1 contest attestati · 0 entry |
|   |     Censimento classifica | — | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie |
|   |     Censimento materiali | — | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione materiali | — | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione immagini | — | — | — | 0% · non implementata |
| 38 | **[Children's Print and Play Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | — | — | 🔴  | — |
|   |     Censimento entry | — | — | 0/1 contest attestati · 0 entry | — |
|   |     Censimento classifica | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — |
|   |     Censimento materiali | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — |
|   |     Acquisizione materiali | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — |
|   |     Acquisizione immagini | — | — | 0% · non implementata | — |
| 46 | **[DTR Pewter Heroes Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | — | 🔴  | — | — |
|   |     Censimento entry | — | 0/1 contest attestati · 0 entry | — | — |
|   |     Censimento classifica | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — | — |
|   |     Censimento materiali | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — |
|   |     Acquisizione materiali | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — |
|   |     Acquisizione immagini | — | 0% · non implementata | — | — |
| 55 | **[In-Hand Game Design Contest](https://boardgamegeek.com/thread/3591416/2026-in-hand-game-design-contest)** |   |   |   |   |
|   |     Stati entry | 🔴  | — | — | — |
|   |     Censimento entry | 0/1 contest attestati · 0 entry | — | — | — |
|   |     Censimento classifica | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — | — | — |
|   |     Censimento materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — | — |
|   |     Acquisizione materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — | — |
|   |     Acquisizione immagini | 0% · non implementata | — | — | — |
| 65 | **[Nine Card Nanogame Print and Play Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | 🔴  | — | — | — |
|   |     Censimento entry | 0/1 contest attestati · 0 entry | — | — | — |
|   |     Censimento classifica | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — | — | — |
|   |     Censimento materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — | — |
|   |     Acquisizione materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — | — |
|   |     Acquisizione immagini | 0% · non implementata | — | — | — |
| 66 | **[One Card Print and Play Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | 🔴  | 🔴  | 🔴  | — |
|   |     Censimento entry | 0/1 contest attestati · 0 entry | 0/1 contest attestati · 0 entry | 0/1 contest attestati · 0 entry | — |
|   |     Censimento classifica | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — |
|   |     Censimento materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — |
|   |     Acquisizione materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — |
|   |     Acquisizione immagini | 0% · non implementata | 0% · non implementata | 0% · non implementata | — |
| 68 | **[One Page PnP Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | — | — | — | 🔴  |
|   |     Censimento entry | — | — | — | 0/1 contest attestati · 0 entry |
|   |     Censimento classifica | — | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie |
|   |     Censimento materiali | — | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione materiali | — | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione immagini | — | — | — | 0% · non implementata |
| 74 | **[Postcard Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | — | — | — | 🔴  |
|   |     Censimento entry | — | — | — | 0/1 contest attestati · 0 entry |
|   |     Censimento classifica | — | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie |
|   |     Censimento materiali | — | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione materiali | — | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione immagini | — | — | — | 0% · non implementata |
| 78 | **[Roll & Write Game Design Contest](https://boardgamegeek.com/thread/3776341/the-2026-roll-and-write-game-design-contest)** |   |   |   |   |
|   |     Stati entry | — | — | — | 🔴  |
|   |     Censimento entry | — | — | — | 0/1 contest attestati · 0 entry |
|   |     Censimento classifica | — | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie |
|   |     Censimento materiali | — | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione materiali | — | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione immagini | — | — | — | 0% · non implementata |
| 79 | **[Single Page Solo Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | — | — | — | 🔴  |
|   |     Censimento entry | — | — | — | 0/1 contest attestati · 0 entry |
|   |     Censimento classifica | — | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie |
|   |     Censimento materiali | — | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione materiali | — | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione immagini | — | — | — | 0% · non implementata |
| 81 | **[Solitaire Print and Play Contest](https://boardgamegeek.com/thread/3716853/2026-solitaire-print-and-play-contest)** |   |   |   |   |
|   |     Stati entry | — | 🔴  | 🔴  | 🔴  |
|   |     Censimento entry | — | 0/1 contest attestati · 0 entry | 0/1 contest attestati · 0 entry | 0/1 contest attestati · 0 entry |
|   |     Censimento classifica | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie |
|   |     Censimento materiali | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione materiali | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione immagini | — | 0% · non implementata | 0% · non implementata | 0% · non implementata |
| 82 | **[Solitaire Print and Play Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | 🔴  | — | — | — |
|   |     Censimento entry | 0/1 contest attestati · 0 entry | — | — | — |
|   |     Censimento classifica | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — | — | — |
|   |     Censimento materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — | — |
|   |     Acquisizione materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — | — |
|   |     Acquisizione immagini | 0% · non implementata | — | — | — |
| 83 | **[Solomode Contest](https://boardgamegeek.com/thread/3670686/2026-solomode-contest)** |   |   |   |   |
|   |     Stati entry | — | 🔴  | 🔴  | — |
|   |     Censimento entry | — | 0/1 contest attestati · 0 entry | 0/1 contest attestati · 0 entry | — |
|   |     Censimento classifica | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — |
|   |     Censimento materiali | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — |
|   |     Acquisizione materiali | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — |
|   |     Acquisizione immagini | — | 0% · non implementata | 0% · non implementata | — |
| 90 | **[Traditional Deck Game Design Contest](https://boardgamegeek.com/thread/3761810/2026-traditional-deck-game-design-contest)** |   |   |   |   |
|   |     Stati entry | 🔴  | 🔴  | — | — |
|   |     Censimento entry | 0/1 contest attestati · 0 entry | 0/1 contest attestati · 0 entry | — | — |
|   |     Censimento classifica | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — | — |
|   |     Censimento materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — |
|   |     Acquisizione materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — |
|   |     Acquisizione immagini | 0% · non implementata | 0% · non implementata | — | — |
| 94 | **[Two Player Print and Play Game Design](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | — | 🔴  | 🔴  | 🔴  |
|   |     Censimento entry | — | 0/1 contest attestati · 0 entry | 0/1 contest attestati · 0 entry | 0/1 contest attestati · 0 entry |
|   |     Censimento classifica | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie |
|   |     Censimento materiali | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione materiali | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione immagini | — | 0% · non implementata | 0% · non implementata | 0% · non implementata |
| 96 | **[Two-Player Print and Play Game Design Contest](https://boardgamegeek.com/thread/3620917/2026-two-player-print-and-play-game-design-contest)** |   |   |   |   |
|   |     Stati entry | 🔴  | — | — | — |
|   |     Censimento entry | 0/1 contest attestati · 0 entry | — | — | — |
|   |     Censimento classifica | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — | — | — |
|   |     Censimento materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — | — |
|   |     Acquisizione materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — | — |
|   |     Acquisizione immagini | 0% · non implementata | — | — | — |
| 99 | **[Video Stream Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | — | — | 🔴  | — |
|   |     Censimento entry | — | — | 0/1 contest attestati · 0 entry | — |
|   |     Censimento classifica | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — |
|   |     Censimento materiali | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — |
|   |     Acquisizione materiali | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — |
|   |     Acquisizione immagini | — | — | 0% · non implementata | — |
| 101 | **[Wargame Print and Play Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | — | — | — | 🔴  |
|   |     Censimento entry | — | — | — | 0/1 contest attestati · 0 entry |
|   |     Censimento classifica | — | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie |
|   |     Censimento materiali | — | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione materiali | — | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione immagini | — | — | — | 0% · non implementata |
| 102 | **[Wargame Print and Play Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | 🔴  | 🔴  | 🔴  | — |
|   |     Censimento entry | 0/1 contest attestati · 0 entry | 0/1 contest attestati · 0 entry | 0/1 contest attestati · 0 entry | — |
|   |     Censimento classifica | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — |
|   |     Censimento materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — |
|   |     Acquisizione materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — |
|   |     Acquisizione immagini | 0% · non implementata | 0% · non implementata | 0% · non implementata | — |

### Gruppo anni 3 di 5

| N. | Tipologia e indicatore | 2018 | 2017 | 2016 | 2015 |
|---:|:---|:---|:---|:---|:---|
|   |   | **22 contest nel database** | **20 contest nel database** | **21 contest nel database** | **24 contest nel database** |
| 12 | **[18 Card MicroGame Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | — | 🔴  | 🔴  | 🔴  |
|   |     Censimento entry | — | 0/1 contest attestati · 0 entry | 0/1 contest attestati · 0 entry | 0/1 contest attestati · 0 entry |
|   |     Censimento classifica | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie |
|   |     Censimento materiali | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione materiali | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione immagini | — | 0% · non implementata | 0% · non implementata | 0% · non implementata |
| 13 | **[2 Player PnP Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | — | — | 🔴  | — |
|   |     Censimento entry | — | — | 0/1 contest attestati · 0 entry | — |
|   |     Censimento classifica | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — |
|   |     Censimento materiali | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — |
|   |     Acquisizione materiali | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — |
|   |     Acquisizione immagini | — | — | 0% · non implementata | — |
| 14 | **[2 Player PnP Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | — | 🔴  | — | — |
|   |     Censimento entry | — | 0/1 contest attestati · 0 entry | — | — |
|   |     Censimento classifica | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — | — |
|   |     Censimento materiali | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — |
|   |     Acquisizione materiali | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — |
|   |     Acquisizione immagini | — | 0% · non implementata | — | — |
| 15 | **[2015-16 Wargame Print and Play Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | — | — | — | 🔴  |
|   |     Censimento entry | — | — | — | 0/1 contest attestati · 0 entry |
|   |     Censimento classifica | — | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie |
|   |     Censimento materiali | — | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione materiali | — | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione immagini | — | — | — | 0% · non implementata |
| 16 | **[2016-17 Wargame Print and Play Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | — | — | 🔴  | — |
|   |     Censimento entry | — | — | 0/1 contest attestati · 0 entry | — |
|   |     Censimento classifica | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — |
|   |     Censimento materiali | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — |
|   |     Acquisizione materiali | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — |
|   |     Acquisizione immagini | — | — | 0% · non implementata | — |
| 17 | **[24 Hour Design Challenge](https://boardgamegeek.com/thread/3765638/september-october-2026-bi-monthly-24-hour-design-c)** |   |   |   |   |
|   |     Stati entry | 🔴  | 🔴  | 🔴  | 🔴  |
|   |     Censimento entry | 0/1 contest attestati · 0 entry | 0/1 contest attestati · 0 entry | 0/1 contest attestati · 0 entry | 0/1 contest attestati · 0 entry |
|   |     Censimento classifica | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie |
|   |     Censimento materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione immagini | 0% · non implementata | 0% · non implementata | 0% · non implementata | 0% · non implementata |
| 22 | **[54-Card Game Design Contest](https://boardgamegeek.com/thread/3746297/2026-54-card-game-design-contest)** |   |   |   |   |
|   |     Stati entry | 🔴  | — | — | — |
|   |     Censimento entry | 0/1 contest attestati · 0 entry | — | — | — |
|   |     Censimento classifica | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — | — | — |
|   |     Censimento materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — | — |
|   |     Acquisizione materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — | — |
|   |     Acquisizione immagini | 0% · non implementata | — | — | — |
| 28 | **[9-Card Nanogame Print and Play Design Contest](https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest)** |   |   |   |   |
|   |     Stati entry | 🔴  | 🔴  | 🔴  | — |
|   |     Censimento entry | 0/1 contest attestati · 0 entry | 0/1 contest attestati · 0 entry | 0/1 contest attestati · 0 entry | — |
|   |     Censimento classifica | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — |
|   |     Censimento materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — |
|   |     Acquisizione materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — |
|   |     Acquisizione immagini | 0% · non implementata | 0% · non implementata | 0% · non implementata | — |
| 32 | **[Badger Rainbow Deck Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | — | — | — | 🔴  |
|   |     Censimento entry | — | — | — | 0/1 contest attestati · 0 entry |
|   |     Censimento classifica | — | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie |
|   |     Censimento materiali | — | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione materiali | — | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione immagini | — | — | — | 0% · non implementata |
| 37 | **[Children's Game Print and Play Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | 🔴  | 🔴  | 🔴  | 🔴  |
|   |     Censimento entry | 0/1 contest attestati · 0 entry | 0/1 contest attestati · 0 entry | 0/1 contest attestati · 0 entry | 0/1 contest attestati · 0 entry |
|   |     Censimento classifica | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie |
|   |     Censimento materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione immagini | 0% · non implementata | 0% · non implementata | 0% · non implementata | 0% · non implementata |
| 48 | **[Eff the Rules Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | — | 🔴  | — | — |
|   |     Censimento entry | — | 0/1 contest attestati · 0 entry | — | — |
|   |     Censimento classifica | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — | — |
|   |     Censimento materiali | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — |
|   |     Acquisizione materiali | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — |
|   |     Acquisizione immagini | — | 0% · non implementata | — | — |
| 51 | **[Gamer Deck 1 Mechanics Design Challenge](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | — | 🔴  | — | — |
|   |     Censimento entry | — | 0/1 contest attestati · 0 entry | — | — |
|   |     Censimento classifica | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — | — |
|   |     Censimento materiali | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — |
|   |     Acquisizione materiali | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — |
|   |     Acquisizione immagini | — | 0% · non implementata | — | — |
| 57 | **[League of Designers Workshop and Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | 🔴  | — | — | — |
|   |     Censimento entry | 0/1 contest attestati · 0 entry | — | — | — |
|   |     Censimento classifica | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — | — | — |
|   |     Censimento materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — | — |
|   |     Acquisizione materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — | — |
|   |     Acquisizione immagini | 0% · non implementata | — | — | — |
| 59 | **[M80 World Languages Card Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | — | — | — | 🔴  |
|   |     Censimento entry | — | — | — | 0/1 contest attestati · 0 entry |
|   |     Censimento classifica | — | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie |
|   |     Censimento materiali | — | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione materiali | — | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione immagini | — | — | — | 0% · non implementata |
| 63 | **[MicroGame Print and Play Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | — | — | 🔴  | 🔴  |
|   |     Censimento entry | — | — | 0/1 contest attestati · 0 entry | 0/1 contest attestati · 0 entry |
|   |     Censimento classifica | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie |
|   |     Censimento materiali | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione materiali | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione immagini | — | — | 0% · non implementata | 0% · non implementata |
| 64 | **[Mint Tin Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | 🔴  | 🔴  | 🔴  | 🔴  |
|   |     Censimento entry | 0/1 contest attestati · 0 entry | 0/1 contest attestati · 0 entry | 0/1 contest attestati · 0 entry | 0/1 contest attestati · 0 entry |
|   |     Censimento classifica | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie |
|   |     Censimento materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione immagini | 0% · non implementata | 0% · non implementata | 0% · non implementata | 0% · non implementata |
| 70 | **[One Page PNP Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | — | — | 🔴  | — |
|   |     Censimento entry | — | — | 0/1 contest attestati · 0 entry | — |
|   |     Censimento classifica | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — |
|   |     Censimento materiali | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — |
|   |     Acquisizione materiali | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — |
|   |     Acquisizione immagini | — | — | 0% · non implementata | — |
| 81 | **[Solitaire Print and Play Contest](https://boardgamegeek.com/thread/3716853/2026-solitaire-print-and-play-contest)** |   |   |   |   |
|   |     Stati entry | 🔴  | 🔴  | 🔴  | 🔴  |
|   |     Censimento entry | 0/1 contest attestati · 0 entry | 0/1 contest attestati · 0 entry | 0/1 contest attestati · 0 entry | 0/1 contest attestati · 0 entry |
|   |     Censimento classifica | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie |
|   |     Censimento materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione immagini | 0% · non implementata | 0% · non implementata | 0% · non implementata | 0% · non implementata |
| 84 | **[Starfarm! Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | 🔴  | — | — | — |
|   |     Censimento entry | 0/1 contest attestati · 0 entry | — | — | — |
|   |     Censimento classifica | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — | — | — |
|   |     Censimento materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — | — |
|   |     Acquisizione materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — | — |
|   |     Acquisizione immagini | 0% · non implementata | — | — | — |
| 85 | **[Summer 2018 Green Box of Games Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | 🔴  | — | — | — |
|   |     Censimento entry | 0/1 contest attestati · 0 entry | — | — | — |
|   |     Censimento classifica | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — | — | — |
|   |     Censimento materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — | — |
|   |     Acquisizione materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — | — |
|   |     Acquisizione immagini | 0% · non implementata | — | — | — |
| 87 | **[The Pug Life Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | — | — | — | 🔴  |
|   |     Censimento entry | — | — | — | 0/1 contest attestati · 0 entry |
|   |     Censimento classifica | — | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie |
|   |     Censimento materiali | — | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione materiali | — | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione immagini | — | — | — | 0% · non implementata |
| 91 | **[Travel Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | — | — | — | 🔴  |
|   |     Censimento entry | — | — | — | 0/1 contest attestati · 0 entry |
|   |     Censimento classifica | — | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie |
|   |     Censimento materiali | — | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione materiali | — | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione immagini | — | — | — | 0% · non implementata |
| 94 | **[Two Player Print and Play Game Design](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | 🔴  | — | — | — |
|   |     Censimento entry | 0/1 contest attestati · 0 entry | — | — | — |
|   |     Censimento classifica | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — | — | — |
|   |     Censimento materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — | — |
|   |     Acquisizione materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — | — |
|   |     Acquisizione immagini | 0% · non implementata | — | — | — |
| 95 | **[Two-Player PnP Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | — | — | — | 🔴  |
|   |     Censimento entry | — | — | — | 0/1 contest attestati · 0 entry |
|   |     Censimento classifica | — | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie |
|   |     Censimento materiali | — | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione materiali | — | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione immagini | — | — | — | 0% · non implementata |
| 100 | **[War Game Print and Play Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | 🔴  | — | — | — |
|   |     Censimento entry | 0/1 contest attestati · 0 entry | — | — | — |
|   |     Censimento classifica | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — | — | — |
|   |     Censimento materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — | — |
|   |     Acquisizione materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — | — |
|   |     Acquisizione immagini | 0% · non implementata | — | — | — |
| 103 | **[Wibbell++ Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | — | — | — | 🔴  |
|   |     Censimento entry | — | — | — | 0/1 contest attestati · 0 entry |
|   |     Censimento classifica | — | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie |
|   |     Censimento materiali | — | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione materiali | — | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione immagini | — | — | — | 0% · non implementata |

### Gruppo anni 4 di 5

| N. | Tipologia e indicatore | 2014 | 2013 | 2012 | 2011 |
|---:|:---|:---|:---|:---|:---|
|   |   | **22 contest nel database** | **18 contest nel database** | **12 contest nel database** | **9 contest nel database** |
| 4 | **[10d12 Dice Game contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | — | — | — | 🔴  |
|   |     Censimento entry | — | — | — | 0/1 contest attestati · 0 entry |
|   |     Censimento classifica | — | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie |
|   |     Censimento materiali | — | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione materiali | — | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione immagini | — | — | — | 0% · non implementata |
| 12 | **[18 Card MicroGame Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | 🔴  | — | — | — |
|   |     Censimento entry | 0/1 contest attestati · 0 entry | — | — | — |
|   |     Censimento classifica | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — | — | — |
|   |     Censimento materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — | — |
|   |     Acquisizione materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — | — |
|   |     Acquisizione immagini | 0% · non implementata | — | — | — |
| 17 | **[24 Hour Design Challenge](https://boardgamegeek.com/thread/3765638/september-october-2026-bi-monthly-24-hour-design-c)** |   |   |   |   |
|   |     Stati entry | 🔴  | 🔴  | 🔴  | — |
|   |     Censimento entry | 0/1 contest attestati · 0 entry | 0/1 contest attestati · 0 entry | 0/1 contest attestati · 0 entry | — |
|   |     Censimento classifica | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — |
|   |     Censimento materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — |
|   |     Acquisizione materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — |
|   |     Acquisizione immagini | 0% · non implementata | 0% · non implementata | 0% · non implementata | — |
| 20 | **[4 Year Old D12 Game Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | — | — | 🔴  | — |
|   |     Censimento entry | — | — | 0/1 contest attestati · 0 entry | — |
|   |     Censimento classifica | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — |
|   |     Censimento materiali | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — |
|   |     Acquisizione materiali | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — |
|   |     Acquisizione immagini | — | — | 0% · non implementata | — |
| 30 | **[Art and Game contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | — | — | 🔴  | — |
|   |     Censimento entry | — | — | 0/1 contest attestati · 0 entry | — |
|   |     Censimento classifica | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — |
|   |     Censimento materiali | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — |
|   |     Acquisizione materiali | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — |
|   |     Acquisizione immagini | — | — | 0% · non implementata | — |
| 34 | **[Card Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | 🔴  | — | — | — |
|   |     Censimento entry | 0/1 contest attestati · 0 entry | — | — | — |
|   |     Censimento classifica | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — | — | — |
|   |     Censimento materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — | — |
|   |     Acquisizione materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — | — |
|   |     Acquisizione immagini | 0% · non implementata | — | — | — |
| 40 | **[Classic Novel Microgame Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | 🔴  | — | — | — |
|   |     Censimento entry | 0/1 contest attestati · 0 entry | — | — | — |
|   |     Censimento classifica | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — | — | — |
|   |     Censimento materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — | — |
|   |     Acquisizione materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — | — |
|   |     Acquisizione immagini | 0% · non implementata | — | — | — |
| 43 | **[Dexterity Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | 🔴  | — | — | — |
|   |     Censimento entry | 0/1 contest attestati · 0 entry | — | — | — |
|   |     Censimento classifica | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — | — | — |
|   |     Censimento materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — | — |
|   |     Acquisizione materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — | — |
|   |     Acquisizione immagini | 0% · non implementata | — | — | — |
| 44 | **[Dice Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | 🔴  | — | — | — |
|   |     Censimento entry | 0/1 contest attestati · 0 entry | — | — | — |
|   |     Censimento classifica | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — | — | — |
|   |     Censimento materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — | — |
|   |     Acquisizione materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — | — |
|   |     Acquisizione immagini | 0% · non implementata | — | — | — |
| 47 | **[Easy Builds Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | — | — | — | 🔴  |
|   |     Censimento entry | — | — | — | 0/1 contest attestati · 0 entry |
|   |     Censimento classifica | — | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie |
|   |     Censimento materiali | — | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione materiali | — | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione immagini | — | — | — | 0% · non implementata |
| 50 | **[Four Poppels and Six Dice Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | — | — | — | 🔴  |
|   |     Censimento entry | — | — | — | 0/1 contest attestati · 0 entry |
|   |     Censimento classifica | — | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie |
|   |     Censimento materiali | — | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione materiali | — | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione immagini | — | — | — | 0% · non implementata |
| 52 | **[Gimme a Hand contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | — | — | 🔴  | — |
|   |     Censimento entry | — | — | 0/1 contest attestati · 0 entry | — |
|   |     Censimento classifica | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — |
|   |     Censimento materiali | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — |
|   |     Acquisizione materiali | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — |
|   |     Acquisizione immagini | — | — | 0% · non implementata | — |
| 53 | **[Historical Themed Board Game contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | — | — | 🔴  | — |
|   |     Censimento entry | — | — | 0/1 contest attestati · 0 entry | — |
|   |     Censimento classifica | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — |
|   |     Censimento materiali | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — |
|   |     Acquisizione materiali | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — |
|   |     Acquisizione immagini | — | — | 0% · non implementata | — |
| 54 | **[In-A-Tin / Express Print-and-Play Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | — | 🔴  | — | — |
|   |     Censimento entry | — | 0/1 contest attestati · 0 entry | — | — |
|   |     Censimento classifica | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — | — |
|   |     Censimento materiali | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — |
|   |     Acquisizione materiali | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — |
|   |     Acquisizione immagini | — | 0% · non implementata | — | — |
| 56 | **[Iron Game Designer Challenge](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | — | — | — | 🔴  |
|   |     Censimento entry | — | — | — | 0/1 contest attestati · 0 entry |
|   |     Censimento classifica | — | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie |
|   |     Censimento materiali | — | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione materiali | — | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione immagini | — | — | — | 0% · non implementata |
| 58 | **[Little Box Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | — | — | — | 🔴  |
|   |     Censimento entry | — | — | — | 0/1 contest attestati · 0 entry |
|   |     Censimento classifica | — | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie |
|   |     Censimento materiali | — | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione materiali | — | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione immagini | — | — | — | 0% · non implementata |
| 61 | **[Mashup Game Design and Artwork Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | — | 🔴  | 🔴  | — |
|   |     Censimento entry | — | 0/1 contest attestati · 0 entry | 0/1 contest attestati · 0 entry | — |
|   |     Censimento classifica | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — |
|   |     Censimento materiali | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — |
|   |     Acquisizione materiali | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — |
|   |     Acquisizione immagini | — | 0% · non implementata | 0% · non implementata | — |
| 62 | **[MicroGame Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | 🔴  | — | — | — |
|   |     Censimento entry | 0/1 contest attestati · 0 entry | — | — | — |
|   |     Censimento classifica | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — | — | — |
|   |     Censimento materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — | — |
|   |     Acquisizione materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — | — |
|   |     Acquisizione immagini | 0% · non implementata | — | — | — |
| 69 | **[One Page PnP contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | — | — | — | 🔴  |
|   |     Censimento entry | — | — | — | 0/1 contest attestati · 0 entry |
|   |     Censimento classifica | — | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie |
|   |     Censimento materiali | — | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione materiali | — | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione immagini | — | — | — | 0% · non implementata |
| 72 | **[PNP Hidden Role / Bluffing Card Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | — | 🔴  | — | — |
|   |     Censimento entry | — | 0/1 contest attestati · 0 entry | — | — |
|   |     Censimento classifica | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — | — |
|   |     Censimento materiali | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — |
|   |     Acquisizione materiali | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — |
|   |     Acquisizione immagini | — | 0% · non implementata | — | — |
| 73 | **[PnP Postcard Game Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | — | 🔴  | — | — |
|   |     Censimento entry | — | 0/1 contest attestati · 0 entry | — | — |
|   |     Censimento classifica | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — | — |
|   |     Censimento materiali | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — |
|   |     Acquisizione materiali | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — |
|   |     Acquisizione immagini | — | 0% · non implementata | — | — |
| 76 | **[Quick Print and Play contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | — | — | — | 🔴  |
|   |     Censimento entry | — | — | — | 0/1 contest attestati · 0 entry |
|   |     Censimento classifica | — | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie |
|   |     Censimento materiali | — | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione materiali | — | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione immagini | — | — | — | 0% · non implementata |
| 77 | **[Randall's Dice Or No Dice Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | 🔴  | — | — | — |
|   |     Censimento entry | 0/1 contest attestati · 0 entry | — | — | — |
|   |     Censimento classifica | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — | — | — |
|   |     Censimento materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — | — |
|   |     Acquisizione materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — | — |
|   |     Acquisizione immagini | 0% · non implementata | — | — | — |
| 81 | **[Solitaire Print and Play Contest](https://boardgamegeek.com/thread/3716853/2026-solitaire-print-and-play-contest)** |   |   |   |   |
|   |     Stati entry | 🔴  | 🔴  | 🔴  | 🔴  |
|   |     Censimento entry | 0/1 contest attestati · 0 entry | 0/1 contest attestati · 0 entry | 0/1 contest attestati · 0 entry | 0/1 contest attestati · 0 entry |
|   |     Censimento classifica | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie |
|   |     Censimento materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione immagini | 0% · non implementata | 0% · non implementata | 0% · non implementata | 0% · non implementata |
| 86 | **[Synergy Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | — | — | — | 🔴  |
|   |     Censimento entry | — | — | — | 0/1 contest attestati · 0 entry |
|   |     Censimento classifica | — | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie |
|   |     Censimento materiali | — | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione materiali | — | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione immagini | — | — | — | 0% · non implementata |
| 93 | **[Two Player PnP Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | — | 🔴  | — | — |
|   |     Censimento entry | — | 0/1 contest attestati · 0 entry | — | — |
|   |     Censimento classifica | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — | — |
|   |     Censimento materiali | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — |
|   |     Acquisizione materiali | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — |
|   |     Acquisizione immagini | — | 0% · non implementata | — | — |
| 97 | **[Two-Player Print-and-Play Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | 🔴  | — | — | — |
|   |     Censimento entry | 0/1 contest attestati · 0 entry | — | — | — |
|   |     Censimento classifica | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — | — | — |
|   |     Censimento materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — | — |
|   |     Acquisizione materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — | — |
|   |     Acquisizione immagini | 0% · non implementata | — | — | — |
| 98 | **[Unique Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |   |
|   |     Stati entry | 🔴  | — | — | — |
|   |     Censimento entry | 0/1 contest attestati · 0 entry | — | — | — |
|   |     Censimento classifica | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — | — | — |
|   |     Censimento materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — | — |
|   |     Acquisizione materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — | — |
|   |     Acquisizione immagini | 0% · non implementata | — | — | — |

### Gruppo anni 5 di 5

| N. | Tipologia e indicatore | 2010 | 2009 | 2008 |
|---:|:---|:---|:---|:---|
|   |   | **5 contest nel database** | **6 contest nel database** | **1 contest nel database** |
| 1 | **[$1,000 Budget Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |
|   |     Stati entry | — | 🔴  | — |
|   |     Censimento entry | — | 0/1 contest attestati · 0 entry | — |
|   |     Censimento classifica | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — |
|   |     Censimento materiali | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — |
|   |     Acquisizione materiali | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — |
|   |     Acquisizione immagini | — | 0% · non implementata | — |
| 33 | **[BoardGameCreate Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |
|   |     Stati entry | — | — | 🔴  |
|   |     Censimento entry | — | — | 0/1 contest attestati · 0 entry |
|   |     Censimento classifica | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie |
|   |     Censimento materiali | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione materiali | — | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate |
|   |     Acquisizione immagini | — | — | 0% · non implementata |
| 39 | **[Christmas Print and Play Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |
|   |     Stati entry | 🔴  | — | — |
|   |     Censimento entry | 0/1 contest attestati · 0 entry | — | — |
|   |     Censimento classifica | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — | — |
|   |     Censimento materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — |
|   |     Acquisizione materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — |
|   |     Acquisizione immagini | 0% · non implementata | — | — |
| 41 | **[Co-Operative Game Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |
|   |     Stati entry | — | 🔴  | — |
|   |     Censimento entry | — | 0/1 contest attestati · 0 entry | — |
|   |     Censimento classifica | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — |
|   |     Censimento materiali | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — |
|   |     Acquisizione materiali | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — |
|   |     Acquisizione immagini | — | 0% · non implementata | — |
| 42 | **[Confuse a Gamer Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |
|   |     Stati entry | 🔴  | — | — |
|   |     Censimento entry | 0/1 contest attestati · 0 entry | — | — |
|   |     Censimento classifica | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — | — |
|   |     Censimento materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — |
|   |     Acquisizione materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — |
|   |     Acquisizione immagini | 0% · non implementata | — | — |
| 45 | **[Dicefest Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |
|   |     Stati entry | 🔴  | — | — |
|   |     Censimento entry | 0/1 contest attestati · 0 entry | — | — |
|   |     Censimento classifica | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — | — |
|   |     Censimento materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — |
|   |     Acquisizione materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — |
|   |     Acquisizione immagini | 0% · non implementata | — | — |
| 49 | **[Four Cards or Tiles contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |
|   |     Stati entry | — | 🔴  | — |
|   |     Censimento entry | — | 0/1 contest attestati · 0 entry | — |
|   |     Censimento classifica | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — |
|   |     Censimento materiali | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — |
|   |     Acquisizione materiali | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — |
|   |     Acquisizione immagini | — | 0% · non implementata | — |
| 60 | **[Many Monster Dice Game Competition](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |
|   |     Stati entry | 🔴  | — | — |
|   |     Censimento entry | 0/1 contest attestati · 0 entry | — | — |
|   |     Censimento classifica | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — | — |
|   |     Censimento materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — |
|   |     Acquisizione materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — |
|   |     Acquisizione immagini | 0% · non implementata | — | — |
| 71 | **[PnP Dice contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |
|   |     Stati entry | — | 🔴  | — |
|   |     Censimento entry | — | 0/1 contest attestati · 0 entry | — |
|   |     Censimento classifica | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — |
|   |     Censimento materiali | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — |
|   |     Acquisizione materiali | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — |
|   |     Acquisizione immagini | — | 0% · non implementata | — |
| 80 | **[Sneaky Sci-Fi Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |
|   |     Stati entry | 🔴  | — | — |
|   |     Censimento entry | 0/1 contest attestati · 0 entry | — | — |
|   |     Censimento classifica | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — | — |
|   |     Censimento materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — |
|   |     Acquisizione materiali | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — | — |
|   |     Acquisizione immagini | 0% · non implementata | — | — |
| 88 | **[Themed Rummy Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |
|   |     Stati entry | — | 🔴  | — |
|   |     Censimento entry | — | 0/1 contest attestati · 0 entry | — |
|   |     Censimento classifica | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — |
|   |     Censimento materiali | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — |
|   |     Acquisizione materiali | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — |
|   |     Acquisizione immagini | — | 0% · non implementata | — |
| 89 | **[Traditional Card Game Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024)** |   |   |   |
|   |     Stati entry | — | 🔴  | — |
|   |     Censimento entry | — | 0/1 contest attestati · 0 entry | — |
|   |     Censimento classifica | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate · 0 entry classificate · 0 categorie | — |
|   |     Censimento materiali | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — |
|   |     Acquisizione materiali | — | — denominatore non disponibile / non applicabile · 0 N/A · 0 bloccate | — |
|   |     Acquisizione immagini | — | 0% · non implementata | — |


## B. Dettaglio delle entry per anno

Per ogni entry: **L** = lettura dei materiali dichiarati (`🟢` scansione registrata, `🔴` non iniziata); **D** = download (`🟢` tutte le risorse dichiarate associate a file acquisiti, `🟡` solo una parte, `🔴` nessun file). Le entry sono ordinate per la classifica principale scelta; quelle senza posizione seguono in ordine alfabetico. Se non esiste una classifica adatta, l'intero contest è alfabetico. La classifica usata è indicata sotto la tabella.

### 2026

#### Gruppo 1 di 4

| N. | [1-Card Print and Play Contest](https://boardgamegeek.com/thread/3686290/2026-1-card-print-and-play-contest) | [2026 54-Card Game Design Contest](https://boardgamegeek.com/thread/3746297/2026-54-card-game-design-contest) | [2026 9-Card Nanogame Print and Play Design Contest](https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest) | [2026 Bad Comet Cozy Game Design Contest](https://boardgamegeek.com/thread/3683796/submissions-closed-2026-bad-comet-cozy-game-design) | [2026 Children & Family Game Design Contest](https://boardgamegeek.com/thread/3645079/2026-children-and-family-game-design-contest) | [2026 In-Hand Game Design Contest](https://boardgamegeek.com/thread/3591416/2026-in-hand-game-design-contest) |
|---:|:---|:---|:---|:---|:---|:---|
| **Classifica utilizzata per l'ordinamento delle Entry** | **ordine alfabetico** | **ordine alfabetico** | **Best Overall Game** | **ordine alfabetico** | **Best Family Game** | **Best Overall Solo Game** |
| 1 | [3 Dice on Mount Olympus](https://boardgamegeek.com/thread/3691866/wip-3-dice-on-mount-olympus-2026-1-card-print-and) — Ready | [A Tale of Two Cities](https://boardgamegeek.com/thread/3755558/wip-a-tale-of-two-cities-rising-rivals-a-complex-t) — WIP | #1 [OBOLUS](https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest) — Ready | [AYLA](https://boardgamegeek.com/thread/3726647/wip-ayla-bad-comet-cozy-contest-finalist) — Ready | #1 [Oh My Gods!](https://boardgamegeek.com/thread/3645079/2026-children-and-family-game-design-contest) — Ready | #1 [Glyph Knight](https://boardgamegeek.com/thread/3591416/2026-in-hand-game-design-contest) — Ready |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |
| 2 | [ALT](https://boardgamegeek.com/thread/3715534/wipalt2026-1-card-game-design-contestcomponents-av) — Ready | [All You Can Draft](https://boardgamegeek.com/thread/3747598/all-you-can-draft-54-card-contest-2026-components) — Components | #2 [SEPTEM](https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest) — Ready | [Firmament: The Valley's Atlas](https://boardgamegeek.com/thread/3691200/wip-firmament-bad-comet-cozy-contest) — Components | #2 [Daikoro: Elemental Dice Duel](https://boardgamegeek.com/thread/3645079/2026-children-and-family-game-design-contest) — Ready | #2 [Turbo Tactics](https://boardgamegeek.com/thread/3591416/2026-in-hand-game-design-contest) — Ready |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |
| 3 | [Archeologist vs Temple](https://boardgamegeek.com/thread/3713118/archeologist-vs-temple-2026-1-card-print-and-play) — Ready | [Desire FOR Colors](https://boardgamegeek.com/thread/3744281/desire-for-colors-2026-54-card-game-design-contest) | #2 [Shifting Islands](https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest) — Ready | [Lanternwood](https://boardgamegeek.com/thread/3685657/wip-lanternwood-bad-comet-cozy-contest) — Playtest | #3 [The Cheese Stands Alone](https://boardgamegeek.com/thread/3645079/2026-children-and-family-game-design-contest) — Ready | #3 [The Cult](https://boardgamegeek.com/thread/3591416/2026-in-hand-game-design-contest) — Ready |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |
| 4 | [BeltDashCzar](https://boardgamegeek.com/thread/3716313/wip-beltdashczar-2026-1-card-print-and-play-contes) — Ready | [Exclamation!](https://boardgamegeek.com/thread/3746297/2026-54-card-game-design-contest) — Components | #3 [DOKUSU](https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest) — Ready | [Rare Sight](https://boardgamegeek.com/thread/3683796/finalists-announced-2026-bad-comet-cozy-game-desig/page/2) | #4 [Cookmates](https://boardgamegeek.com/thread/3645079/2026-children-and-family-game-design-contest) — Ready | #4 [Fool's Journey: from Zero to Twenty One](https://boardgamegeek.com/thread/3591416/2026-in-hand-game-design-contest) — Ready |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |
| 5 | [Branch Line](https://boardgamegeek.com/thread/3715617/wip-branch-line-2026-1-card-print-and-play-contest) — Ready | [Flirt](https://boardgamegeek.com/thread/3746297/2026-54-card-game-design-contest) | #4 [1st Hero](https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest) — Ready | [Stone Skipping](https://boardgamegeek.com/thread/3685593/wip-stone-skipping-bad-comet-cozy-contest) — Ready | #5 [The Abyss](https://boardgamegeek.com/thread/3645079/2026-children-and-family-game-design-contest) — Ready | #5 [Train Conductor](https://boardgamegeek.com/thread/3591416/2026-in-hand-game-design-contest) — Ready |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |
| 6 | [Bump it!](https://boardgamegeek.com/thread/3709500/bump-it-2026-1-card-print-and-play-pnp-design-cont) — Ready | [Karda](https://boardgamegeek.com/thread/3746297/2026-54-card-game-design-contest) | #5 [Sector 9: The Void Anomaly](https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest) — Ready |   | #6 [Alien Tongue](https://boardgamegeek.com/thread/3645079/2026-children-and-family-game-design-contest) — Ready | #6 [Robot Wipeout](https://boardgamegeek.com/thread/3591416/2026-in-hand-game-design-contest) — Ready |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 | L 🔴 · D 🔴 |
| 7 | [Cardboat Legend](https://boardgamegeek.com/thread/3700003/wip-cardboat-legend-2026-1-card-pnp-contest-contes) — Ready | [Line O' Dinos](https://boardgamegeek.com/thread/3746991/line-o-dinos-co-op-set-building-2026-54-card-conte) | #6 [Ninefold Surgeon](https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest) — Ready |   | #7 [Graffito](https://boardgamegeek.com/thread/3645079/2026-children-and-family-game-design-contest) — Ready | #7 [Puzzlin' Pawns](https://boardgamegeek.com/thread/3591416/2026-in-hand-game-design-contest) — Ready |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 | L 🔴 · D 🔴 |
| 8 | [Colorfill](https://boardgamegeek.com/thread/3695473/wip-colorfill-2026-1-card-print-and-play-contest-c) — Ready | [Maremmas](https://boardgamegeek.com/thread/3746297/2026-54-card-game-design-contest) | #7 [CAPTCHA all robots!](https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest) — Ready |   | #8 [Animal Roundup](https://boardgamegeek.com/thread/3645079/2026-children-and-family-game-design-contest) — Ready | #8 [Summoner of Winding Wood](https://boardgamegeek.com/thread/3591416/2026-in-hand-game-design-contest) — Ready |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 | L 🔴 · D 🔴 |
| 9 | [CR!S!S](https://boardgamegeek.com/thread/3696427/wip-crss-a-2-player-superhero-game-submission-to-t) — Ready | [Runic](https://boardgamegeek.com/thread/3760327/contest-ready-runic-a-trick-taking-press-your-luck) — Ready | #7 [Dreamstone](https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest) — Ready |   | #9 [IRANIKA](https://boardgamegeek.com/thread/3645079/2026-children-and-family-game-design-contest) — Ready | [Aetherwood](https://boardgamegeek.com/thread/3591416/2026-in-hand-game-design-contest) — Ready |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 | L 🔴 · D 🔴 |
| 10 | [Dauntless Squad](https://boardgamegeek.com/thread/3716261/wip-dauntless-squad-2026-1-card-print-and-play-con) — Ready | [Samarra](https://boardgamegeek.com/thread/3746297/2026-54-card-game-design-contest) | #7 [Ninefold Murder](https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest) — Ready |   | #10 [Juicy Fruit Salad](https://boardgamegeek.com/thread/3645079/2026-children-and-family-game-design-contest) — Ready | [BIGFOOT AND YETI](https://boardgamegeek.com/thread/3591416/2026-in-hand-game-design-contest) — Ready |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 | L 🔴 · D 🔴 |
| 11 | [Dice Volley](https://boardgamegeek.com/thread/3703035/wip-dice-volley-2p-abstract-strategy-game-2026-1-c) — Ready | [Shelter](https://boardgamegeek.com/thread/3746297/2026-54-card-game-design-contest) — WIP | #7 [PLAGA](https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest) — Ready |   | #11 [Cherries](https://boardgamegeek.com/thread/3645079/2026-children-and-family-game-design-contest) — Ready | [Handcraft](https://boardgamegeek.com/thread/3591416/2026-in-hand-game-design-contest) — Ready |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 | L 🔴 · D 🔴 |
| 12 | [Emmet and the Zombie Ant](https://boardgamegeek.com/thread/3687680/emmet-and-the-zombie-ant-entry-into-the-2026-1-car) — Ready | [Signum](https://boardgamegeek.com/thread/3754094/wip-signum-2026-54-card-game-design-contest-idea-p) — Idea | [A.D.A.](https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest) — Ready |   | #12 [Sandwich Stackers](https://boardgamegeek.com/thread/3645079/2026-children-and-family-game-design-contest) — Ready | [Hellhand](https://boardgamegeek.com/thread/3591416/2026-in-hand-game-design-contest) — Withdrawn |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 | L 🔴 · D 🔴 |
| 13 | [Flippin' Bomber](https://boardgamegeek.com/thread/3707964/wip-flippin-bomber-chaotic-1-card-maze-bomber-for) — Ready | [Tailor Made](https://boardgamegeek.com/thread/3752852/wip-tailor-made-2026-54-card-contest-idea-phase) — Idea | [Accursed's Village](https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest) — Ready |   | #13 [RoboRacers](https://boardgamegeek.com/thread/3645079/2026-children-and-family-game-design-contest) — Ready | [HeroHold](https://boardgamegeek.com/thread/3591416/2026-in-hand-game-design-contest) — Ready |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 | L 🔴 · D 🔴 |
| 14 | [Hitman Leaderboard](https://boardgamegeek.com/thread/3716965/wip-hitman-leaderboard-1-card-design-contest-2026) — Ready | [The Acrobat of Transluciania](https://boardgamegeek.com/thread/3756058/wip-the-acrobats-of-transluciania-54-cards-contest) — WIP | [Aim the Orcs!](https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest) — Ready |   | #14 [Storyboard Heroes](https://boardgamegeek.com/thread/3645079/2026-children-and-family-game-design-contest) — Ready | [LOCKSTEP](https://boardgamegeek.com/thread/3591416/2026-in-hand-game-design-contest) — Ready |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 | L 🔴 · D 🔴 |
| 15 | [hoop.exe](https://boardgamegeek.com/thread/3703841/wip-hoopexe-2-player-tactical-programming-game-202) — Ready | [The Nine Lives of the Bureaucat](https://boardgamegeek.com/thread/3746297/2026-54-card-game-design-contest) | [Altar of the New Witch](https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest) — Idea |   | #15 [Size the Cows](https://boardgamegeek.com/thread/3645079/2026-children-and-family-game-design-contest) — Ready | [Memories](https://boardgamegeek.com/thread/3591416/2026-in-hand-game-design-contest) — Withdrawn |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 | L 🔴 · D 🔴 |
| 16 | [Kaos Karts](https://boardgamegeek.com/thread/3706052/wip-kaos-karts-drive-through-portals-and-release-b) — Ready | [The Window Seat](https://boardgamegeek.com/thread/3753549/) | [Animons Card Battle 9](https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest) — Ready |   | [Arctic Rush](https://boardgamegeek.com/thread/3645079/2026-children-and-family-game-design-contest) — Ready | [Monk's Cat: The Book of](https://boardgamegeek.com/thread/3591416/2026-in-hand-game-design-contest) — Ready |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 | L 🔴 · D 🔴 |
| 17 | [LÜMEN: Eternal Night](https://boardgamegeek.com/thread/3708298/wip-lumen-eternal-night-solo-game-2026-1-card-prin) — Ready | [Wild Chorus](https://boardgamegeek.com/thread/3746665/wip-wild-chorus-2-8-player-party-game-2026-54-card) — WIP | [Arlo & Bliss](https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest) — Withdrawn |   | [Bag Drop](https://boardgamegeek.com/thread/3645079/2026-children-and-family-game-design-contest) — Ready | [Paddle Pals](https://boardgamegeek.com/thread/3591416/2026-in-hand-game-design-contest) — Ready |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 | L 🔴 · D 🔴 |
| 18 | [Node Links](https://boardgamegeek.com/thread/3710606/wip-node-links-2026-1-card-print-and-play-contest) — Ready |   | [Assault on the Citadel](https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest) — Ready |   | [Battle of the Mouse King](https://boardgamegeek.com/thread/3645079/2026-children-and-family-game-design-contest) — Ready | [Pocket Forge](https://boardgamegeek.com/thread/3591416/2026-in-hand-game-design-contest) — Ready |
|   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 | L 🔴 · D 🔴 |
| 19 | [One Card Hacker](https://boardgamegeek.com/thread/3706845/wip-one-card-hacker-2026-1-card-print-and-play-con) — Ready |   | [Asturquest](https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest) — Ready |   | [Bee Friendly](https://boardgamegeek.com/thread/3645079/2026-children-and-family-game-design-contest) — Ready | [Shining Spirits](https://boardgamegeek.com/thread/3591416/2026-in-hand-game-design-contest) — Ready |
|   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 | L 🔴 · D 🔴 |
| 20 | [Ripples](https://boardgamegeek.com/thread/3713561/wip-ripples-2026-1-card-print-and-play-contest-con) — Ready |   | [Backpack Struggle](https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest) — Ready |   | [Bit and Bob's SCRAPYARD SHOWCASE](https://boardgamegeek.com/thread/3645079/2026-children-and-family-game-design-contest) — Ready | [Show of Hands](https://boardgamegeek.com/thread/3591416/2026-in-hand-game-design-contest) — Ready |
|   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 | L 🔴 · D 🔴 |
| 21 | [Slapstick](https://boardgamegeek.com/thread/3707495/wipslapstickdual-entry-24-hour-and-1-card-design-c) — Ready |   | [BALBÚRDIA](https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest) — Idea |   | [Cash Grab](https://boardgamegeek.com/thread/3645079/2026-children-and-family-game-design-contest) — Ready | [SkyHold](https://boardgamegeek.com/thread/3591416/2026-in-hand-game-design-contest) — Ready |
|   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 | L 🔴 · D 🔴 |
| 22 | [Snake](https://boardgamegeek.com/thread/3709948/wip-snake-1-card-print-and-play-contest-2026-compo) — Ready |   | [Bunny Bomb Blaster](https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest) — Components |   | [Colour Collab](https://boardgamegeek.com/thread/3645079/2026-children-and-family-game-design-contest) — Ready | [Strut](https://boardgamegeek.com/thread/3591416/2026-in-hand-game-design-contest) — Withdrawn |
|   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 | L 🔴 · D 🔴 |
| 23 | [Space Shooter 1C](https://boardgamegeek.com/thread/3713304/wip-space-shooter-1c-2026-1-card-print-and-play-co) — Ready |   | [Calaverita](https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest) — Ready |   | [Creative City Blocks](https://boardgamegeek.com/thread/3645079/2026-children-and-family-game-design-contest) — Ready | [Super Shot: Tennis SX](https://boardgamegeek.com/thread/3591416/2026-in-hand-game-design-contest) — Ready |
|   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 | L 🔴 · D 🔴 |
| 24 | [Sugar and Splice](https://boardgamegeek.com/thread/3717072/sugar-and-splice-entry-for-the-2026-one-card-conte) — Ready |   | [CHARM](https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest) — Withdrawn |   | [Desire FOR Mods](https://boardgamegeek.com/thread/3645079/2026-children-and-family-game-design-contest) — Ready | [Veles vs Perun](https://boardgamegeek.com/thread/3591416/2026-in-hand-game-design-contest) — Ready |
|   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 | L 🔴 · D 🔴 |
| 25 | [Sword To Table](https://boardgamegeek.com/thread/3717003/wip-sword-to-table-a-monster-cooking-dungeon-crawl) — Ready |   | [Cheese Chase](https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest) — Ready |   | [Excuse Me, Bear!](https://boardgamegeek.com/thread/3645079/2026-children-and-family-game-design-contest) — Ready | [Wild Photo](https://boardgamegeek.com/thread/3591416/2026-in-hand-game-design-contest) — Ready |
|   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 | L 🔴 · D 🔴 |
| 26 | [Teseliatron](https://boardgamegeek.com/thread/3715614/wip-teseliatron-2026-1-card-print-and-play-contest) — Ready |   | [City Ghost](https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest) — Ready |   | [FLOWER FEAST](https://boardgamegeek.com/thread/3645079/2026-children-and-family-game-design-contest) — Ready |   |
|   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 |   |
| 27 | [The Boy in the Cornfield](https://boardgamegeek.com/thread/3663168/wip-the-boy-in-the-cornfield-2p-hidden-movement-ga) — Ready |   | [Cloudbound Colossus Dice Game](https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest) — Withdrawn |   | [Fruit Stacks!](https://boardgamegeek.com/thread/3645079/2026-children-and-family-game-design-contest) — Ready |   |
|   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 |   |
| 28 | [Tic-Tac-Finger](https://boardgamegeek.com/thread/3713002/wip-tic-tac-finger-2026-1-card-print-and-play-cont) — Ready |   | [COLORI](https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest) — Ready |   | [Gold Rush: Unplugged](https://boardgamegeek.com/thread/3645079/2026-children-and-family-game-design-contest) — Ready |   |
|   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 |   |
| 29 | [Time Looper](https://boardgamegeek.com/thread/3702446/wip-time-looper-2026-1-card-print-and-play-contest) — Ready |   | [Crafting Crawler](https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest) — Ready |   | [Invisible words](https://boardgamegeek.com/thread/3645079/2026-children-and-family-game-design-contest) — Ready |   |
|   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 |   |
| 30 | [Trials and Tribulations](https://boardgamegeek.com/thread/3708498/wip-trials-and-tribulations-a-lotr-adventure-on-on) — Ready |   | [Der Kommandant](https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest) — Idea |   | [Math for Ladybugs!](https://boardgamegeek.com/thread/3645079/2026-children-and-family-game-design-contest) — Ready |   |
|   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 |   |
| 31 |   |   | [Dice of War](https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest) — Idea |   | [Patently Absurd](https://boardgamegeek.com/thread/3645079/2026-children-and-family-game-design-contest) — Ready |   |
|   |   |   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 |   |
| 32 |   |   | [Diefectors](https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest) — Ready |   | [Pivot](https://boardgamegeek.com/thread/3645079/2026-children-and-family-game-design-contest) — Ready |   |
|   |   |   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 |   |
| 33 |   |   | [Dingers](https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest) — Components |   | [RoboBots: Kaiju Hunters](https://boardgamegeek.com/thread/3645079/2026-children-and-family-game-design-contest) — Ready |   |
|   |   |   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 |   |
| 34 |   |   | [Feldspar](https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest) — Withdrawn |   | [Seven Stones](https://boardgamegeek.com/thread/3645079/2026-children-and-family-game-design-contest) — Ready |   |
|   |   |   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 |   |
| 35 |   |   | [FLAMES OF DOOM](https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest) — Ready |   | [Survival of the Middlest](https://boardgamegeek.com/thread/3645079/2026-children-and-family-game-design-contest) — Ready |   |
|   |   |   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 |   |
| 36 |   |   | [Flipping Little Dinos](https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest) — Ready |   | [Terra Incognita](https://boardgamegeek.com/thread/3645079/2026-children-and-family-game-design-contest) — Withdrawn |   |
|   |   |   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 |   |
| 37 |   |   | [Foolish Wizards](https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest) — Ready |   | [The Travel Bug Card Game](https://boardgamegeek.com/thread/3645079/2026-children-and-family-game-design-contest) — Withdrawn |   |
|   |   |   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 |   |
| 38 |   |   | [Habitat](https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest) — Idea |   | [Uftro Tomb](https://boardgamegeek.com/thread/3645079/2026-children-and-family-game-design-contest) — Ready |   |
|   |   |   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 |   |
| 39 |   |   | [Heretic](https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest) — Components |   |   |   |
|   |   |   | L 🔴 · D 🔴 |   |   |   |
| 40 |   |   | [HOPPE](https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest) — Ready |   |   |   |
|   |   |   | L 🔴 · D 🔴 |   |   |   |
| 41 |   |   | [HOT CARS](https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest) — Ready |   |   |   |
|   |   |   | L 🔴 · D 🔴 |   |   |   |
| 42 |   |   | [Mata's Inhabitants](https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest) — Ready |   |   |   |
|   |   |   | L 🔴 · D 🔴 |   |   |   |
| 43 |   |   | [Morpho Dungeon](https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest) — Idea |   |   |   |
|   |   |   | L 🔴 · D 🔴 |   |   |   |
| 44 |   |   | [Mountaineer's Challenge](https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest) — Ready |   |   |   |
|   |   |   | L 🔴 · D 🔴 |   |   |   |
| 45 |   |   | [My Hat Definitely Doesn't Have an Explosive Under It](https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest) — Withdrawn |   |   |   |
|   |   |   | L 🔴 · D 🔴 |   |   |   |
| 46 |   |   | [ParallOn](https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest) — Ready |   |   |   |
|   |   |   | L 🔴 · D 🔴 |   |   |   |
| 47 |   |   | [Penny-cle Accelerator](https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest) — Components |   |   |   |
|   |   |   | L 🔴 · D 🔴 |   |   |   |
| 48 |   |   | [PREDATORIA](https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest) — Ready |   |   |   |
|   |   |   | L 🔴 · D 🔴 |   |   |   |
| 49 |   |   | [RAVIVAR](https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest) — Components |   |   |   |
|   |   |   | L 🔴 · D 🔴 |   |   |   |
| 50 |   |   | [Ritual 12](https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest) — Components |   |   |   |
|   |   |   | L 🔴 · D 🔴 |   |   |   |
| 51 |   |   | [Saci's Orchard](https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest) — Ready |   |   |   |
|   |   |   | L 🔴 · D 🔴 |   |   |   |
| 52 |   |   | [Scout's Dishonor: A Game of Snack-tical Warfare](https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest) — Ready |   |   |   |
|   |   |   | L 🔴 · D 🔴 |   |   |   |
| 53 |   |   | [Seeds of Wars](https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest) — Ready |   |   |   |
|   |   |   | L 🔴 · D 🔴 |   |   |   |
| 54 |   |   | [Shaolin Soccer](https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest) — Ready |   |   |   |
|   |   |   | L 🔴 · D 🔴 |   |   |   |
| 55 |   |   | [SKY SPY](https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest) — Ready |   |   |   |
|   |   |   | L 🔴 · D 🔴 |   |   |   |
| 56 |   |   | [Stack Dungeon](https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest) — Withdrawn |   |   |   |
|   |   |   | L 🔴 · D 🔴 |   |   |   |
| 57 |   |   | [Supercolony](https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest) — Components |   |   |   |
|   |   |   | L 🔴 · D 🔴 |   |   |   |
| 58 |   |   | [Test of Time](https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest) — Components |   |   |   |
|   |   |   | L 🔴 · D 🔴 |   |   |   |
| 59 |   |   | [The Buttering Cat Paradox](https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest) — Components |   |   |   |
|   |   |   | L 🔴 · D 🔴 |   |   |   |
| 60 |   |   | [The Legend of Demon Island](https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest) — Idea |   |   |   |
|   |   |   | L 🔴 · D 🔴 |   |   |   |
| 61 |   |   | [The Wanted Doodle-Doo](https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest) — Idea |   |   |   |
|   |   |   | L 🔴 · D 🔴 |   |   |   |
| 62 |   |   | [THE WORST PART OF BEING CAUGHT IN A TIME LOOP](https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest) — Components |   |   |   |
|   |   |   | L 🔴 · D 🔴 |   |   |   |
| 63 |   |   | [Three Henrys](https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest) — Ready |   |   |   |
|   |   |   | L 🔴 · D 🔴 |   |   |   |
| 64 |   |   | [TILXi](https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest) — Components |   |   |   |
|   |   |   | L 🔴 · D 🔴 |   |   |   |
| 65 |   |   | [Time Theft](https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest) — Ready |   |   |   |
|   |   |   | L 🔴 · D 🔴 |   |   |   |
| 66 |   |   | [Tribulations in Serpabale](https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest) — Ready |   |   |   |
|   |   |   | L 🔴 · D 🔴 |   |   |   |
| 67 |   |   | [Two Gods](https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest) — Ready |   |   |   |
|   |   |   | L 🔴 · D 🔴 |   |   |   |
| 68 |   |   | [World Search](https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest) — Ready |   |   |   |
|   |   |   | L 🔴 · D 🔴 |   |   |   |
| 69 |   |   | [Your Easter Bunny needs YOU!](https://boardgamegeek.com/thread/3648226/2026-9-card-nanogame-print-and-play-design-contest) — Ready |   |   |   |
|   |   |   | L 🔴 · D 🔴 |   |   |   |

#### Gruppo 2 di 4

| N. | [2026 Print and Play Wargame Design Contest](https://boardgamegeek.com/thread/3627732/contest-open-2026-print-and-play-wargame-design-co) | [2026 Solitaire Print and Play Contest](https://boardgamegeek.com/thread/3716853/2026-solitaire-print-and-play-contest) | [2026 Solomode Contest](https://boardgamegeek.com/thread/3670686/2026-solomode-contest) | [2026 Traditional Deck Game Design Contest](https://boardgamegeek.com/thread/3761810/2026-traditional-deck-game-design-contest) | [2026 Two-Player Print and Play Game Design Contest](https://boardgamegeek.com/thread/3620917/2026-two-player-print-and-play-game-design-contest) | [2026 Türkçe Yazdır ve Oyna (PNP) Kutu Oyunu Tasarım Yarışması](https://boardgamegeek.com/thread/3701420/2026-turkce-yazdir-ve-oyna-pnp-kutu-oyunu-tasarim) |
|---:|:---|:---|:---|:---|:---|:---|
| **Classifica utilizzata per l'ordinamento delle Entry** | **ordine alfabetico** | **ordine alfabetico** | **Best Light Game Solo Mode** | **ordine alfabetico** | **Best Game** | **ordine alfabetico** |
| 1 | [Slipstream Raiders](https://boardgamegeek.com/thread/3668290/wip-slipstream-raiders-robbing-at-redline-2026-pnp) — WIP | [Take her to daycare!](https://boardgamegeek.com/thread/3735336/pciotts-available-wip-take-her-to-daycare-2026-sol) — Playtest | #1 [Solo mode for Humans!!!](https://boardgamegeek.com/thread/3670686/2026-solomode-contest) — Ready | [Affair](https://boardgamegeek.com/thread/3761909/affair-wip-rules-av) — Components | #1 [Migoyugo](https://boardgamegeek.com/thread/3655964/wip-migoyugo-2026-two-player-print-and-play-design) — WIP | [666](https://boardgamegeek.com/thread/3701420/article/48032459#48032459) — Withdrawn |
|   | L 🟢 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |
| 2 | [2026 Wargame Contest](https://boardgamegeek.com/thread/3766762/playtest-ready-2026-wargame-contest-glieres-1944) — Playtest | [We Regret to Inform](https://boardgamegeek.com/thread/3738710/wip-rules-available-we-regret-to-inform-manage-six) — WIP | #2 [The Blind Watchmaker, a solo mode for Take Time](https://boardgamegeek.com/thread/3670686/2026-solomode-contest) — Ready | [Bubbles Burst](https://boardgamegeek.com/thread/3761810/2026-traditional-deck-game-design-contest) | #2 [Baju](https://boardgamegeek.com/thread/3633058/wip-baju-2026-two-player-print-and-play-design-con) — Components | [Akasha: Elementlerin Döngüsü](https://boardgamegeek.com/thread/3701420/article/48032459#48032459) — Components |
|   | L 🟢 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |
| 3 | [Hybrid War](https://boardgamegeek.com/thread/3628081/playtest-ready-hybrid-war-2026-print-and-play-warg) — Playtest | [How The Tides Turn](https://boardgamegeek.com/thread/3761729/wip-how-the-tides-turn-fantasy-themed-roll-and-wri) — Components | #3 [Onoda Solitude](https://boardgamegeek.com/thread/3670686/2026-solomode-contest) — Ready | [Card Invaders](https://boardgamegeek.com/thread/3761810/2026-traditional-deck-game-design-contest) | #3 [fourmidable](https://boardgamegeek.com/thread/3636227/wip-fourmidable-2026-two-player-print-and-play-des) — Components | [Arkaso Kartlar](https://boardgamegeek.com/thread/3730642/contest-ready-arkaso-kartlar-2026-turkce-yazdir-ve) — Components |
|   | L 🟢 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |
| 4 | [OSSA- bones that decide fate](https://boardgamegeek.com/thread/3631421/playtest-ready-ossa-bones-that-decide-fate-2026-pr) — Playtest | [13 Came Callin'](https://boardgamegeek.com/thread/3721425/wip-13-came-callin-2026-solitaire-pnp-contest-pnpp) — WIP | #4 [R-Eco Solo Variant](https://boardgamegeek.com/thread/3670686/2026-solomode-contest) — Ready | [Clash of the Magi](https://boardgamegeek.com/thread/3761810/2026-traditional-deck-game-design-contest) — Components | ['Mancer: Gems of Power](https://boardgamegeek.com/thread/3642734/wip-mancer-gems-of-power-2026-two-player-print-and) — Components | [Büyük Loncalar](https://boardgamegeek.com/thread/3701420/article/48032459#48032459) — Withdrawn |
|   | L 🟢 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |
| 5 | [The Lost Eagles](https://boardgamegeek.com/thread/3770697/playtest-ready-the-lost-eagles-2026-print-and-play) — Playtest | [638 Squadron](https://boardgamegeek.com/thread/3761120/wip-638-squadron-a-solo-wwii-aerial-bombing-game-2) — WIP | #5 [Skull King solomode](https://boardgamegeek.com/thread/3670686/2026-solomode-contest) — Ready | [Earthlings!](https://boardgamegeek.com/thread/3761810/2026-traditional-deck-game-design-contest) | [Breach](https://boardgamegeek.com/thread/3657193/wip-breach-2026-two-player-print-and-play-design-c) — Components | [Cadı Çemberi](https://boardgamegeek.com/thread/3701420/article/48032459#48032459) — Withdrawn |
|   | L 🟢 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |
| 6 | [Warhammer 40,000: Battle line](https://boardgamegeek.com/thread/3669693/wip-playtest-ready-warhammer-40000-battle-line) — Playtest | [A Better Yesterday](https://boardgamegeek.com/thread/3728191/wip-a-better-yesterday-time-travel-solo-card-game) — WIP | #6 [Pocket Piquet](https://boardgamegeek.com/thread/3670686/2026-solomode-contest) — Ready | [Foolish Faces](https://boardgamegeek.com/thread/3761810/2026-traditional-deck-game-design-contest) | [Cookmates](https://boardgamegeek.com/thread/3644212/wip-cookmates-2026-two-player-print-and-play-desig) — Ready | [David's vs Goliath](https://boardgamegeek.com/thread/3701420/article/48032459#48032459) — Withdrawn |
|   | L 🟢 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |
| 7 | [A silent war at the end of the world](https://boardgamegeek.com/thread/3640690/wip-a-silent-war-at-the-end-of-the-world-2026-warg) — Idea | [Abandon Gamma Sector](https://boardgamegeek.com/thread/3731817/wip-abandon-gamma-sector-18-card-spatial-puzzle-so) — Components | #7 [Solodraftus](https://boardgamegeek.com/thread/3670686/2026-solomode-contest) — Ready | [Gob Crawl](https://boardgamegeek.com/thread/3761810/2026-traditional-deck-game-design-contest) | [DiceStrike](https://boardgamegeek.com/thread/3636028/wip-dicestrike-an-arcade-inspired-dice-fighter-202) — Playtest | [DESIRE FOR CHAOS](https://boardgamegeek.com/thread/3701420/article/48032459#48032459) — Components |
|   | L 🟢 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |
| 8 | [CYBERAIDER >PLAYTEST READY<](https://boardgamegeek.com/thread/3756688/wip-cyberaider-playtest-ready-2026-wargames-pnp-co) — Playtest | [Ankle Breakers](https://boardgamegeek.com/thread/3753581/wip-ankle-breakers) — WIP | #8 [Castle Solo](https://boardgamegeek.com/thread/3670686/2026-solomode-contest) — Ready | [Jokers & Thieves](https://boardgamegeek.com/thread/3761871/wipjokers-and-thieves-2026-traditional-deck-contes) — Components | [DRY CHICAGO](https://boardgamegeek.com/thread/3630771/wip-dry-chicago-a-60-minutes-wargame-like-boardgam) — Components | [Evdeyiz](https://boardgamegeek.com/thread/3701420/article/48032459#48032459) — Components |
|   | L 🟢 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |
| 9 | [Garland 1942](https://boardgamegeek.com/thread/3775769/wip-garland-1942-a-solo-sabotage-game-playtests-re) — Playtest | [Athens Alone](https://boardgamegeek.com/thread/3717393/wip-athens-alone-2026-solitaire-print-and-play-con) — WIP | #9 [Hobbit There and Back Again](https://boardgamegeek.com/thread/3670686/2026-solomode-contest) — Ready | [Nobilitea](https://boardgamegeek.com/thread/3761810/2026-traditional-deck-game-design-contest) | [Everyday Ramen](https://boardgamegeek.com/thread/3658093/wip-everyday-ramen-2026-two-player-print-and-play) — Components | [Fast & Tasty](https://boardgamegeek.com/thread/3701873/fast-and-tasty-2026-turkce-yazdir-ve-oyna-pnp-tasa) — Components |
|   | L 🟢 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |
| 10 | [Gilgamesh vs. Enkidu](https://boardgamegeek.com/thread/3708703/wip-gilgamesh-vs-enkidu) — WIP | [Beating Beneath the Boards](https://boardgamegeek.com/thread/3708801/wip-beating-beneath-the-boards-1p-bag-building-dic) — Components | #10 [SOLO MODE](https://boardgamegeek.com/thread/3670686/2026-solomode-contest) — Ready | [Poker Tricktaker](https://boardgamegeek.com/thread/3761843/wip-poker-tricktaker-trick-taking-with-poker-melds) — Components | [Fishing With Fishes](https://boardgamegeek.com/thread/3662353/wip-fishing-with-fishes-2026-two-player-print-and) — Components | [Kovan](https://boardgamegeek.com/thread/3701420/article/48032459#48032459) — Components |
|   | L 🟢 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |
| 11 | [Gladiator](https://boardgamegeek.com/thread/3745494/wip-gladiator-2026-wargames-pnp-competition-submis) — Components | [Beaver Dam](https://boardgamegeek.com/thread/3751892/wip-beaver-dam-solo-pnp-design-contest-2026-entry) — Playtest | [Automa SWars](https://boardgamegeek.com/thread/3670686/2026-solomode-contest) — Ready | [Red River Duel](https://boardgamegeek.com/thread/3761810/2026-traditional-deck-game-design-contest) — Components | [Flip to Talk](https://boardgamegeek.com/thread/3641834/wip-flip-to-talk-2026-two-player-print-and-play-de) — Components | [Kozmik Kaos](https://boardgamegeek.com/thread/3701420/article/48032459#48032459) — Components |
|   | L 🟢 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |
| 12 | [Mekamui.](https://boardgamegeek.com/thread/3762455/wip-mekamui-2026-print-and-play-wargame-design-con) — WIP | [Behind The Curtain](https://boardgamegeek.com/thread/3730152/wip-behind-the-curtain-worker-placement-tableaueng) — Components | [Betting Bots for Solo Play! (WIN)](https://boardgamegeek.com/thread/3670686/2026-solomode-contest) — Ready | [Root & Branch](https://boardgamegeek.com/thread/3761810/2026-traditional-deck-game-design-contest) | [Frutas](https://boardgamegeek.com/thread/3634290/wip-frutas-abstract-strategy-game-for-2-players-ag) — Components | [Pervasız Sergüzeşt](https://boardgamegeek.com/thread/3701420/article/48032459#48032459) — Withdrawn |
|   | L 🟢 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |
| 13 | [Operation BARDSEA](https://boardgamegeek.com/thread/3649842/wip-operation-bardsea-2026-wargames-pnp-submission) — WIP | [Below Zero](https://boardgamegeek.com/thread/3760334/wip-below-zero-action-point-system-hand-and-resour) — Components | [Cosmotrons](https://boardgamegeek.com/thread/3670686/2026-solomode-contest) — Ready | [Sweet Shop](https://boardgamegeek.com/thread/3761810/2026-traditional-deck-game-design-contest) | [Gourmet Duel](https://boardgamegeek.com/thread/3637879/wip-gourmet-duel-2026-two-player-print-and-play-de) — Components | [Plaza Savaşları](https://boardgamegeek.com/thread/3701420/article/48032459#48032459) — Components |
|   | L 🟢 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |
| 14 | [Sitka ever lost : Alaska from Russia to America 1784-1867](https://boardgamegeek.com/thread/3767955/wip-sitka-ever-lost-alaska-from-russia-to-america) — Playtest | [Blockhead Adventures](https://boardgamegeek.com/thread/3731556/wip-blockhead-adventures-2026-solo-pnp-contest-com) — Components | [Free Ride Fanmade Solo Mode](https://boardgamegeek.com/thread/3670686/2026-solomode-contest) — Ready | [The Chase on Nine](https://boardgamegeek.com/thread/3761810/2026-traditional-deck-game-design-contest) | [Gran Tavola](https://boardgamegeek.com/thread/3627701/wip-gran-tavola-2026-two-player-print-and-play-des) — Components | [Prestij Galerisi](https://boardgamegeek.com/thread/3701420/article/48032459#48032459) — Components |
|   | L 🟢 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |
| 15 | [The Battle of Stepney](https://boardgamegeek.com/thread/3669635/wip-the-battle-of-stepney-2026-wargames-pnp-contes) — WIP | [Cape Cod Visit](https://boardgamegeek.com/thread/3730542/wip-cape-cod-visit-a-solo-tableau-builder-and-opti) — Components | [Infamy: The Syndicate](https://boardgamegeek.com/thread/3670686/2026-solomode-contest) — Ready | [Three Tiers for Sweet Revenge](https://boardgamegeek.com/thread/3761810/2026-traditional-deck-game-design-contest) | [Grimoire War](https://boardgamegeek.com/thread/3651871/wip-grimoire-war-2026-two-player-print-and-play-de) — Playtest | [Sevkiyat Ustası](https://boardgamegeek.com/thread/3701420/article/48032459#48032459) — Components |
|   | L 🟢 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |
| 16 | [The Ground Fortified](https://boardgamegeek.com/thread/3655068/wip-the-ground-fortified-2026-print-and-play-warga) — Playtest | [Captain Crash!](https://boardgamegeek.com/thread/3723756/wip-captain-crash-1p-command-cards-deduction-compo) — Components | [Lord High and Master Lowe](https://boardgamegeek.com/thread/3670686/2026-solomode-contest) — Ready | [TOWER DEFENDER](https://boardgamegeek.com/thread/3761810/2026-traditional-deck-game-design-contest) — Components | [HELLHAND /2 PLAYER/ COOPERATIVE/ 15 MIN/](https://boardgamegeek.com/thread/3657579/wip-hellhand-2-player-cooperative-15-min-component) — Components | [Shrouded Skyline (Örtülü Ufuk)](https://boardgamegeek.com/thread/3723715/contest-ready-shrouded-skyline-ortulu-ufuk-2026-tu) — Components |
|   | L 🟢 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |
| 17 | [Valour](https://boardgamegeek.com/thread/3649727/wip-valour-2026-wargames-pnp-competition-submissio) — Playtest | [Carnage Core](https://boardgamegeek.com/thread/3717549/wip-carnage-core-a-solo-1v1v1-mech-builder-and-fig) — Components | [Mobilis in Mobili](https://boardgamegeek.com/thread/3670686/2026-solomode-contest) — Ready | [Virus](https://boardgamegeek.com/thread/3761810/2026-traditional-deck-game-design-contest) | [Hextract](https://boardgamegeek.com/thread/3641938/wip-hextract-2026-two-player-print-and-play-design) — Components | [Tarihi Komutanlar & Savaşçılar](https://boardgamegeek.com/thread/3701420/article/48032459#48032459) — Components |
|   | L 🟢 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |
| 18 | [WARRING KINGDOMS](https://boardgamegeek.com/thread/3737758/wip-warring-kingdoms-2026-wargame-design-contestt) — Playtest | [Cliff Dwellers](https://boardgamegeek.com/thread/3761593/wip-cliff-dwellers-compact-tile-layer-2026-solitai) — Components | [Play-I, a solo mode for Compile](https://boardgamegeek.com/thread/3670686/2026-solomode-contest) — Ready | [Witan](https://boardgamegeek.com/thread/3761810/2026-traditional-deck-game-design-contest) — Components | [Hidden Village](https://boardgamegeek.com/thread/3616011/wip-hidden-village-2026-two-player-print-and-play) — Components | [What A Match! / Ne Maç Ama!](https://boardgamegeek.com/thread/3701420/article/48032459#48032459) — Components |
|   | L 🟢 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |
| 19 | [Warring States: West Africa](https://boardgamegeek.com/thread/3638470/wip-warring-states-west-africa-2026-wargames-pnp-c) — Playtest | [Corsairs & Krakens](https://boardgamegeek.com/thread/3722475/wip-corsairs-and-krakens-a-micro-solo-game-entry-f) — Components | [SECOND WAVE](https://boardgamegeek.com/thread/3670686/2026-solomode-contest) — Ready |   | [Infirmarium](https://boardgamegeek.com/thread/3661821/wip-infirmarium-2026-two-player-print-and-play-des) — Ready | [Zhud](https://boardgamegeek.com/thread/3701420/article/48032459#48032459) — Withdrawn |
|   | L 🟢 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 | L 🔴 · D 🔴 |
| 20 | [Cocci Wars](https://boardgamegeek.com/thread/3634677/wipplaytest-ready-cocci-wars-emergence-simulator-2) — Playtest | [Croaking by the Pond](https://boardgamegeek.com/thread/3752465/wip-croaking-by-the-pond-18-cards-2026-solitaire-p) — Components | [Torchlit](https://boardgamegeek.com/thread/3670686/2026-solomode-contest) — Ready |   | [Jewel eXchange](https://boardgamegeek.com/thread/3531550/wip-jewel-exchange-2026-two-player-print-and-play) — Ready | [Zombiler, Kız Grubu, Aşçı, Oxford Virgülü, ve Taşınabilir Tek Delikli Delgeç](https://boardgamegeek.com/thread/3701420/article/48032459#48032459) — Components |
|   | L 🟢 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 | L 🔴 · D 🔴 |
| 21 | [Balled Moves](https://boardgamegeek.com/thread/3763647/balled-moves-a-snowball-fight-for-2-players-compon) — Components | [Cursed Bingo](https://boardgamegeek.com/thread/3757640/wip-cursed-bingo-1-page-solo-roll-and-write-2026-s) — Components | [Two Trips to Japan, please!](https://boardgamegeek.com/thread/3670686/2026-solomode-contest) — Ready |   | [Jin](https://boardgamegeek.com/thread/3661741/wip-jin-2026-two-player-print-and-play-design-cont) — Components |   |
|   | L 🟢 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 |   |
| 22 | [Imposed Cost](https://boardgamegeek.com/thread/3776117/imposed-cost-a-card-game-of-grey-zone-warfare) | [Darkness Falls](https://boardgamegeek.com/thread/3725215/wip-darkness-falls-a-solo-sci-fi-survival-board-ga) — WIP |   |   | [Katapultoj](https://boardgamegeek.com/thread/3657835/wip-katapultoj-2026-two-player-print-and-play-desi) — Components |   |
|   | L 🟢 · D 🔴 | L 🔴 · D 🔴 |   |   | L 🔴 · D 🔴 |   |
| 23 | [Out of the Limelights](https://boardgamegeek.com/thread/3692245/wip-out-of-the-limelights-entry-to-2026-pnp-wargam) — WIP | [Defense of Helm's Deep](https://boardgamegeek.com/thread/3721903/wip-defense-of-helms-deep-a-draw-and-draw-tower-de) — Components |   |   | [Khagan](https://boardgamegeek.com/thread/3661791/wip-khagan-2026-two-player-print-and-play-design-c) — Components |   |
|   | L 🟢 · D 🔴 | L 🔴 · D 🔴 |   |   | L 🔴 · D 🔴 |   |
| 24 |   | [Don't Play This Game](https://boardgamegeek.com/thread/3740100/wip-dont-play-this-game-2026-solitaire-pnp-contest) — Components |   |   | [Last Donut in the Breakroom](https://boardgamegeek.com/thread/3648989/wip-last-donut-in-the-breakroom-2026-two-player-pr) — Withdrawn |   |
|   |   | L 🔴 · D 🔴 |   |   | L 🔴 · D 🔴 |   |
| 25 |   | [Dream Stone](https://boardgamegeek.com/thread/3758499/wip-dream-stone-a-9-card-in-hand-game-that-require) — Components |   |   | [Let's Take Over the HOA](https://boardgamegeek.com/thread/3661285/wip-lets-take-over-the-hoa-2026-two-player-print-a) — Ready |   |
|   |   | L 🔴 · D 🔴 |   |   | L 🔴 · D 🔴 |   |
| 26 |   | [Final Shift](https://boardgamegeek.com/thread/3745573/wip-final-shift-a-response-driven-deckbuilder-2026) — Components |   |   | [Mint Souls](https://boardgamegeek.com/thread/3622663/wip-mint-souls-2026-two-player-print-and-play-desi) — Components |   |
|   |   | L 🔴 · D 🔴 |   |   | L 🔴 · D 🔴 |   |
| 27 |   | [Fool Mouse Playable](https://boardgamegeek.com/thread/3718135/wip-fool-mouse-2026-solitaire-print-and-play-conte) — Playtest |   |   | [Patently Absurd](https://boardgamegeek.com/thread/3655760/wip-patently-absurd-set-collection-plus-spatial-pu) — Components |   |
|   |   | L 🔴 · D 🔴 |   |   | L 🔴 · D 🔴 |   |
| 28 |   | [Friend-Ship](https://boardgamegeek.com/thread/3761676/wip-friend-ship-a-7-cards-dice-placement-entry-to) — WIP |   |   | [Pocket Zoo](https://boardgamegeek.com/thread/3609939/wip-pocket-zoo-a-gateway-euro-for-2-5-players-2026) — Components |   |
|   |   | L 🔴 · D 🔴 |   |   | L 🔴 · D 🔴 |   |
| 29 |   | [Hero of Rome: Usurper](https://boardgamegeek.com/thread/3761089/wip-hero-of-rome-usurper-solo-low-ink-pnp-ancient) — Playtest |   |   | [PRISMA](https://boardgamegeek.com/thread/3620996/wip-prisma-components-ready) — Components |   |
|   |   | L 🔴 · D 🔴 |   |   | L 🔴 · D 🔴 |   |
| 30 |   | [JOUST](https://boardgamegeek.com/thread/3733326/wip-joust-a-solo-jousting-tournament-board-game-pe) — WIP |   |   | [Pyramids](https://boardgamegeek.com/thread/3645589/wip-pyramids-2026-two-player-print-and-play-design) — Ready |   |
|   |   | L 🔴 · D 🔴 |   |   | L 🔴 · D 🔴 |   |
| 31 |   | [Knights Aberrant](https://boardgamegeek.com/thread/3720855/wip-knights-aberrant-a-solitaire-game-of-procedura) — Components |   |   | [Ra-Duel](https://boardgamegeek.com/thread/3609272/wip-ra-duel-2026-two-player-print-and-play-design) — Components |   |
|   |   | L 🔴 · D 🔴 |   |   | L 🔴 · D 🔴 |   |
| 32 |   | [Last Prime Minister Playable,](https://boardgamegeek.com/thread/3733831/wip-last-prime-minister-2026-solitaire-print-and-p) — Playtest |   |   | [Room For Dessert](https://boardgamegeek.com/thread/3662608/wip-room-for-dessert-2026-two-player-print-and-pla) — Components |   |
|   |   | L 🔴 · D 🔴 |   |   | L 🔴 · D 🔴 |   |
| 33 |   | [Lawman](https://boardgamegeek.com/thread/3758908/wip-lawman-solo-card-and-dice-game) — WIP |   |   | [Sazon Criollo](https://boardgamegeek.com/thread/3637910/wip-sazon-criollo-2026-two-player-print-and-play-d) — Components |   |
|   |   | L 🔴 · D 🔴 |   |   | L 🔴 · D 🔴 |   |
| 34 |   | [Legends of Dark Lands](https://boardgamegeek.com/thread/3710076/wip-legends-of-dark-lands-2026-solitaire-contest-c) — Playtest |   |   | [Scrapyard Tinkers](https://boardgamegeek.com/thread/3264080/wip-scrapyard-tinkers-2026-two-player-print-and-pl) — Components |   |
|   |   | L 🔴 · D 🔴 |   |   | L 🔴 · D 🔴 |   |
| 35 |   | [Lights Out](https://boardgamegeek.com/thread/3744707/wip-lights-out-2026-solo-pnp-game-design-contest-p) — Playtest |   |   | [Shadow Convoy](https://boardgamegeek.com/thread/3646369/wip-shadow-convoy-2026-two-player-print-and-play-d) — Components |   |
|   |   | L 🔴 · D 🔴 |   |   | L 🔴 · D 🔴 |   |
| 36 |   | [Lock Pick](https://boardgamegeek.com/thread/3719518/wip-lock-pick-2026-solitaire-print-and-play-contes) — Components |   |   | [Superhero Smash](https://boardgamegeek.com/thread/3650079/wip-superhero-smash-2026-two-player-print-and-play) — Components |   |
|   |   | L 🔴 · D 🔴 |   |   | L 🔴 · D 🔴 |   |
| 37 |   | [MOW](https://boardgamegeek.com/thread/3725071/wip-mow-solo-roll-and-write-components-and-online) — Components |   |   | [Taxi 375](https://boardgamegeek.com/thread/3649812/wip-taxi-375-2026-two-player-print-and-play-design) — Components |   |
|   |   | L 🔴 · D 🔴 |   |   | L 🔴 · D 🔴 |   |
| 38 |   | [Mugs of Madness](https://boardgamegeek.com/thread/3756311/wip-mugs-of-madness-1p-15-30-min-ages-14-plus-a-20) — Components |   |   | [TECTONIC](https://boardgamegeek.com/thread/3639481/wip-tectonic-2026-two-player-print-and-play-design) — Components |   |
|   |   | L 🔴 · D 🔴 |   |   | L 🔴 · D 🔴 |   |
| 39 |   | [Nailhead 24](https://boardgamegeek.com/thread/3761042/wip-nailhead-24-2026-solo-pnp-game-design-contest) — Components |   |   | [The Inner Circle](https://boardgamegeek.com/thread/3657264/wip-the-inner-circle-2026-two-player-print-and-pla) — Playtest |   |
|   |   | L 🔴 · D 🔴 |   |   | L 🔴 · D 🔴 |   |
| 40 |   | [One More Card?!](https://boardgamegeek.com/thread/3761527/wip-one-more-card-solo-push-your-luck-with-a-stand) — Playtest |   |   | [Tic TacTics](https://boardgamegeek.com/thread/3662621/wip-tic-tactics-cats-vs-dogs-2026-two-player-print) — Components |   |
|   |   | L 🔴 · D 🔴 |   |   | L 🔴 · D 🔴 |   |
| 41 |   | [One More Gear](https://boardgamegeek.com/thread/3757916/wip-one-more-gear-2026-solitaire-pnp-contest-compo) — Components |   |   | [Uftro Wilds](https://boardgamegeek.com/thread/3638150/wip-uftro-wilds-2026-two-player-print-and-play-des) — Playtest |   |
|   |   | L 🔴 · D 🔴 |   |   | L 🔴 · D 🔴 |   |
| 42 |   | [Pecunia Sanguinus](https://boardgamegeek.com/thread/3753902/wip-pecunia-sanguinus-the-lobbyist-s-game-solo-eur) — Components |   |   | [Unlucky Spirits](https://boardgamegeek.com/thread/3640989/wip-unlucky-spirits-revised-edition-1-4-players-60) — Ready |   |
|   |   | L 🔴 · D 🔴 |   |   | L 🔴 · D 🔴 |   |
| 43 |   | [Perpetual](https://boardgamegeek.com/thread/3722897/wip-perpetual-2026-solitaire-print-and-play-contes) — WIP |   |   | [Vigilante Mansion](https://boardgamegeek.com/thread/3662089/wip-vigilante-mansion-2026-two-player-print-and-pl) — Components |   |
|   |   | L 🔴 · D 🔴 |   |   | L 🔴 · D 🔴 |   |
| 44 |   | [Pivot Pilot](https://boardgamegeek.com/thread/3737333/wip-pivot-pilot-loop-deck-builder-2026-solo-pnp-ga) — Idea |   |   | [Peak Duel](https://boardgamegeek.com/thread/3638844/peak-duel-completed) — Ready |   |
|   |   | L 🔴 · D 🔴 |   |   | L 🔴 · D 🔴 |   |
| 45 |   | [Please Be Patient](https://boardgamegeek.com/thread/3753626/wip-please-be-patient-1p-card-placement-dice-assig) — Components |   |   | [Countess Bathory's Beasts](https://boardgamegeek.com/thread/3635652/wip-countess-bathorys-beasts-2026-two-player-print) — Components |   |
|   |   | L 🔴 · D 🔴 |   |   | L 🔴 · D 🔴 |   |
| 46 |   | [Please Don’t Feed The Bears](https://boardgamegeek.com/thread/3760815/wip-please-don-t-feed-the-bears-2026-pnp-solo) — WIP |   |   |   |   |
|   |   | L 🔴 · D 🔴 |   |   |   |   |
| 47 |   | [Pocket Spire: a shrunk version of StS](https://boardgamegeek.com/thread/3647926/wip-pocket-spire-a-shrunk-version-of-sts-2026-soli) — Components |   |   |   |   |
|   |   | L 🔴 · D 🔴 |   |   |   |   |
| 48 |   | [RE: Retrieve, Repair, Return](https://boardgamegeek.com/thread/3695614/wip-re-retrieve-repair-return-engine-building-poly) — Components |   |   |   |   |
|   |   | L 🔴 · D 🔴 |   |   |   |   |
| 49 |   | [Reef Revival Solo](https://boardgamegeek.com/thread/3760841/wip-reef-revival-solo) — WIP |   |   |   |   |
|   |   | L 🔴 · D 🔴 |   |   |   |   |
| 50 |   | [Ring of Rakshasas](https://boardgamegeek.com/thread/3722961/wip-ring-of-rakshasas-2026-solitaire-contest-spati) — WIP |   |   |   |   |
|   |   | L 🔴 · D 🔴 |   |   |   |   |
| 51 |   | [Route Won](https://boardgamegeek.com/thread/3717278/wip-route-won-2026-solitaire-print-and-play-contes) — Components |   |   |   |   |
|   |   | L 🔴 · D 🔴 |   |   |   |   |
| 52 |   | [Signal & Noise](https://boardgamegeek.com/thread/3722153/wip-signal-and-noise-2026-solitaire-pnp-contest-co) — Components |   |   |   |   |
|   |   | L 🔴 · D 🔴 |   |   |   |   |
| 53 |   | [Snip, Snip, BOOM!](https://boardgamegeek.com/thread/3684827/wip-snip-snip-boom-a-solitaire-defuse-the-bomb-dic) — Components |   |   |   |   |
|   |   | L 🔴 · D 🔴 |   |   |   |   |
| 54 |   | [Story Quilt](https://boardgamegeek.com/thread/3761424/wip-story-quilt-cozy-roll-and-color-game-2026-solo) — Playtest |   |   |   |   |
|   |   | L 🔴 · D 🔴 |   |   |   |   |
| 55 |   | [Strike Twelve](https://boardgamegeek.com/thread/3758945/wip-strike-twelve-an-entry-into-the-2026-solitaire) — Components |   |   |   |   |
|   |   | L 🔴 · D 🔴 |   |   |   |   |
| 56 |   | [Summoning Demons](https://boardgamegeek.com/thread/3740856/wip-summoning-demons-2026-solitaire-pnp-contest-co) — Components |   |   |   |   |
|   |   | L 🔴 · D 🔴 |   |   |   |   |
| 57 |   | [Survive the Mist](https://boardgamegeek.com/thread/3727500/wip-survive-the-mist-a-solitaire-game-of-post-apoc) — Components |   |   |   |   |
|   |   | L 🔴 · D 🔴 |   |   |   |   |
| 58 |   | [Tales of the Windward Sea](https://boardgamegeek.com/thread/3757339/wip-tales-of-the-windward-sea-one-page-pirate-adve) — WIP |   |   |   |   |
|   |   | L 🔴 · D 🔴 |   |   |   |   |
| 59 |   | [The awakaned 3](https://boardgamegeek.com/thread/3646147/wip-the-awakaned-3-a-solo-space-pnp-survival-game) — Components |   |   |   |   |
|   |   | L 🔴 · D 🔴 |   |   |   |   |
| 60 |   | [The Castle In The Clouds](https://boardgamegeek.com/thread/3757894/wip-the-castle-in-the-clouds-solo-stealth-focused) — WIP |   |   |   |   |
|   |   | L 🔴 · D 🔴 |   |   |   |   |
| 61 |   | [The Hidden World](https://boardgamegeek.com/thread/3743402/wip-the-hidden-world-a-solo-dice-adventure-game-20) — Components |   |   |   |   |
|   |   | L 🔴 · D 🔴 |   |   |   |   |
| 62 |   | [Tidepool Teaparty](https://boardgamegeek.com/thread/3709724/wip-tidepool-teaparty-10-min-cozy-card-fishing-sol) — Components |   |   |   |   |
|   |   | L 🔴 · D 🔴 |   |   |   |   |
| 63 |   | [Too Many Vikings](https://boardgamegeek.com/thread/3717939/wip-too-many-vikings-2026-solitaire-print-and-play) — WIP |   |   |   |   |
|   |   | L 🔴 · D 🔴 |   |   |   |   |
| 64 |   | [Troubled Sands](https://boardgamegeek.com/thread/3761539/wip-troubled-sands-a-solo-cozy-temple-crawler-2026) — WIP |   |   |   |   |
|   |   | L 🔴 · D 🔴 |   |   |   |   |
| 65 |   | [Upholder](https://boardgamegeek.com/thread/3719232/wip-upholder-malta-s-ace-2026-solitaire-print-and) — Components |   |   |   |   |
|   |   | L 🔴 · D 🔴 |   |   |   |   |
| 66 |   | [Vertical Overlines Solitaire Snowboarding](https://boardgamegeek.com/thread/3739127/wip-vertical-overlines-solitaire-snowboarding-dice) — Components |   |   |   |   |
|   |   | L 🔴 · D 🔴 |   |   |   |   |
| 67 |   | [Vice and Virtue](https://boardgamegeek.com/thread/3719862/wip-vice-and-virtue-2026-solitaire-print-and-play) — Components |   |   |   |   |
|   |   | L 🔴 · D 🔴 |   |   |   |   |
| 68 |   | [War of the Worlds: The Journey](https://boardgamegeek.com/thread/3727954/wip-war-of-the-worlds-the-journey-2026-solitaire-p) — Components |   |   |   |   |
|   |   | L 🔴 · D 🔴 |   |   |   |   |
| 69 |   | [WARRING KINGDOMS](https://boardgamegeek.com/thread/3737430/wip-warring-kingdoms-2026-solitaire-pnp-contest-pl) — Playtest |   |   |   |   |
|   |   | L 🔴 · D 🔴 |   |   |   |   |
| 70 |   | [Wormhole Report](https://boardgamegeek.com/thread/3725222/wip-wormhole-report-2026-solitaire-print-and-play) — Components |   |   |   |   |
|   |   | L 🔴 · D 🔴 |   |   |   |   |
| 71 |   | [Zerax Clinic](https://boardgamegeek.com/thread/3749243/wip-zerax-clinic-a-small-9-card-dice-placement-sol) — WIP |   |   |   |   |
|   |   | L 🔴 · D 🔴 |   |   |   |   |
| 72 |   | [Not·ro](https://boardgamegeek.com/thread/3694850/wip-notro-54-card-solo-print-and-play-originally-a) — WIP |   |   |   |   |
|   |   | L 🔴 · D 🔴 |   |   |   |   |
| 73 |   | [Code of Caligos](https://boardgamegeek.com/thread/3749828/wipcode-of-caligos2026-solitaire-game-design-conte) — Components |   |   |   |   |
|   |   | L 🔴 · D 🔴 |   |   |   |   |
| 74 |   | [The Most Magnificent, Utterly Important, Highly Official, Absolutely True Chronicle of ... Wilfred the Pink Lion...](https://boardgamegeek.com/thread/3718644/wipthe-most-magnificent-utterly-important-highly-o) — Components |   |   |   |   |
|   |   | L 🔴 · D 🔴 |   |   |   |   |
| 75 |   | [Treasure, in Spades](https://boardgamegeek.com/thread/3717627/wiptreasure-in-spades-2026-solitaire-contest-tradi) — WIP |   |   |   |   |
|   |   | L 🔴 · D 🔴 |   |   |   |   |
| 76 |   | [WIP} Tomb Tin](https://boardgamegeek.com/thread/3744985/wip-tomb-tin-2026-solitaire-print-and-play-design) — WIP |   |   |   |   |
|   |   | L 🔴 · D 🔴 |   |   |   |   |
| 77 |   | [Ant Farm](https://boardgamegeek.com/thread/3747098/ant-farm-an-entry-into-the-2026-solitaire-game-des) |   |   |   |   |
|   |   | L 🔴 · D 🔴 |   |   |   |   |
| 78 |   | [Dice Delve](https://boardgamegeek.com/thread/3727736/dice-delve-a-component-light-dungeon-crawler-using) — Components |   |   |   |   |
|   |   | L 🔴 · D 🔴 |   |   |   |   |
| 79 |   | [Doodle-inks](https://boardgamegeek.com/thread/3742948/doodle-inks-a-rolln-writen-play-golf-game-2026-pnp) |   |   |   |   |
|   |   | L 🔴 · D 🔴 |   |   |   |   |
| 80 |   | [Hanging Gardens](https://boardgamegeek.com/thread/3760494/hanging-gardens-an-entry-for-the-2026-solitaire-pr) |   |   |   |   |
|   |   | L 🔴 · D 🔴 |   |   |   |   |
| 81 |   | [Midnight Confessions](https://boardgamegeek.com/thread/3724336/midnight-confessions-the-case-of-dr-black-web-app) |   |   |   |   |
|   |   | L 🔴 · D 🔴 |   |   |   |   |
| 82 |   | [Monster Inside Me](https://boardgamegeek.com/thread/3723673/monster-inside-me-2026-solitaire-pnp-contest-compo) — Components |   |   |   |   |
|   |   | L 🔴 · D 🔴 |   |   |   |   |
| 83 |   | [Omens & Bones: The Curse of Zaryth](https://boardgamegeek.com/thread/3716966/omens-and-bones-the-curse-of-zaryth-1p-20min-stand) — Components |   |   |   |   |
|   |   | L 🔴 · D 🔴 |   |   |   |   |
| 84 |   | [Seventeen!!!](https://boardgamegeek.com/thread/3757052/seventeen-2026-solitaire-print-and-play-contest) |   |   |   |   |
|   |   | L 🔴 · D 🔴 |   |   |   |   |
| 85 |   | [Unicellular](https://boardgamegeek.com/thread/3757581/unicellular-a-9-cards-roll-n-write-resource-manage) — Components |   |   |   |   |
|   |   | L 🔴 · D 🔴 |   |   |   |   |
| 86 |   | [Utopia Express](https://boardgamegeek.com/thread/3759385/utopia-express-2026-solitaire-print-and-play-conte) — Idea |   |   |   |   |
|   |   | L 🔴 · D 🔴 |   |   |   |   |
| 87 |   | [Component Ready](https://boardgamegeek.com/thread/3759763/wip-component-ready-re-chronicle-an-entry-in-the-2) — Components |   |   |   |   |
|   |   | L 🔴 · D 🔴 |   |   |   |   |
| 88 |   | [Wuul Farm: Frostbreak](https://boardgamegeek.com/thread/3754624/wuul-farm-frostbreak-2026-solitaire-contest-compet) — Components |   |   |   |   |
|   |   | L 🔴 · D 🔴 |   |   |   |   |
| 89 |   | [{WIP\] Restore the Reef!](https://boardgamegeek.com/thread/3760556/wip-restore-the-reef-2026-solo-pnp-contest-entry) — WIP |   |   |   |   |
|   |   | L 🔴 · D 🔴 |   |   |   |   |

#### Gruppo 3 di 4

| N. | [January–February 2026 — 24 Hour Design Challenge (CULTURE)](https://boardgamegeek.com/thread/3642254/january-february-2026-bi-monthly-24-hour-design-ch) | [July–August 2026 — 24 Hour Design Challenge (DRAW)](https://boardgamegeek.com/thread/3734535/july-august-2026-bi-monthly-24-hour-design-challen) | [March–April 2026 — 24 Hour Design Challenge (CLASSIC)](https://boardgamegeek.com/thread/3675743/march-april-2026-bi-monthly-24-hour-design-challen) | [May–June 2026 — 24 Hour Design Challenge (STICK)](https://boardgamegeek.com/thread/3706306/may-june-2026-bi-monthly-24-hour-design-challenge) | [September–October 2026 — 24 Hour Design Challenge (NINE)](https://boardgamegeek.com/thread/3765638/september-october-2026-bi-monthly-24-hour-design-c) | [The 2026 Roll & Write Game Design Contest](https://boardgamegeek.com/thread/3776341/the-2026-roll-and-write-game-design-contest) |
|---:|:---|:---|:---|:---|:---|:---|
| **Classifica utilizzata per l'ordinamento delle Entry** | **ordine alfabetico** | **ordine alfabetico** | **ordine alfabetico** | **ordine alfabetico** | **ordine alfabetico** | **ordine alfabetico** |
| 1 | [Cloudbound Kingdon](https://boardgamegeek.com/thread/3642254/article/47134017#47134017) — Withdrawn | [Communal Comics](https://boardgamegeek.com/thread/3734535/article/47901801#47901801) — Ready | [Boneyard Gin](https://boardgamegeek.com/thread/3675743/article/47408545#47408545) — Ready | [Kindling](https://boardgamegeek.com/thread/3706306/article/47659966#47659966) — Ready | [Dressed to the Nines](https://boardgamegeek.com/thread/3765638/article/48154812#48154812) — Ready |   |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |
| 2 | [Cozy Harvest](https://boardgamegeek.com/thread/3642254/article/47134017#47134017) — Ready | [Connectrons](https://boardgamegeek.com/thread/3734535/article/47901801#47901801) — Ready | [Classic Car Show](https://boardgamegeek.com/thread/3675743/article/47408545#47408545) — Ready | [Slapstick](https://boardgamegeek.com/thread/3707495/wipslapstickdual-entry-24-hour-and-1-card-design-c) — Ready | [Naoi](https://boardgamegeek.com/thread/3765638/article/48154812#48154812) — Ready |   |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |
| 3 | [Get the Play on the Stage!](https://boardgamegeek.com/thread/3642254/article/47134017#47134017) — Ready | [Desperados Duel](https://boardgamegeek.com/thread/3734535/article/47901801#47901801) — Ready | [Clincher](https://boardgamegeek.com/thread/3675743/article/47408545#47408545) — Ready | [Stick'em Up](https://boardgamegeek.com/thread/3706306/article/47659966#47659966) — Ready | [Pittas](https://boardgamegeek.com/thread/3765638/article/48154812#48154812) — Ready |   |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |
| 4 | [Minutes to Majesty](https://boardgamegeek.com/thread/3642254/article/47134017#47134017) — Ready | [Drawing from Memory](https://boardgamegeek.com/thread/3734535/article/47901801#47901801) — Ready | [Closing the Gap](https://boardgamegeek.com/thread/3675743/article/47408545#47408545) — Ready |   |   |   |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |   |   |
| 5 | [MUTT](https://boardgamegeek.com/thread/3642254/article/47134017#47134017) — Withdrawn | [Neon Divide](https://boardgamegeek.com/thread/3734535/article/47901801#47901801) — Ready | [Quirlen](https://boardgamegeek.com/thread/3675743/article/47408545#47408545) — Ready |   |   |   |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |   |   |
| 6 | [Poser](https://boardgamegeek.com/thread/3642254/article/47134017#47134017) — Ready | [Obfuscation](https://boardgamegeek.com/thread/3734535/article/47901801#47901801) — Ready | [Starward Shield](https://boardgamegeek.com/thread/3675743/article/47408545#47408545) — Ready |   |   |   |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |   |   |
| 7 | [Random Traces](https://boardgamegeek.com/thread/3642254/article/47134017#47134017) — Ready | [Pip Draw](https://boardgamegeek.com/thread/3734535/article/47901801#47901801) — Ready |   |   |   |   |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |   |   |   |
| 8 | [SEWN](https://boardgamegeek.com/thread/3642254/article/47134017#47134017) — Ready | [The Fastest Gun in the West](https://boardgamegeek.com/thread/3734535/article/47901801#47901801) — Ready |   |   |   |   |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |   |   |   |
| 9 | [Uncultured Swine](https://boardgamegeek.com/thread/3642254/article/47134017#47134017) — Ready | [Umbrella](https://boardgamegeek.com/thread/3734535/article/47901801#47901801) — Ready |   |   |   |   |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |   |   |   |

#### Gruppo 4 di 4

| N. | Turkish Print and Play Design Contest |
|---:|:---|


### 2025

#### Gruppo 1 di 4

| N. | [2025 1-Card Print and Play Design Contest](https://boardgamegeek.com/thread/3487579/2025-1-card-print-and-play-design-contest) | [2025 54-Card Game Design Contest](https://boardgamegeek.com/thread/3536713/2025-54-card-game-design-contest) | [2025 9-Card Nanogame Print and Play Design Contest](https://boardgamegeek.com/thread/3436343/2025-9-card-nanogame-print-and-play-design-contest) | [2025 Children & Family Game Design Contest](https://boardgamegeek.com/thread/3441385/2025-children-and-family-game-design-contest) | [2025 In-Hand Game Design Contest](https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest) | [2025 Solitaire Print and Play Contest](https://boardgamegeek.com/thread/3520713/2025-solitaire-print-and-play-contest) |
|---:|:---|:---|:---|:---|:---|:---|
| **Classifica utilizzata per l'ordinamento delle Entry** | **Best Overall Game** | **Best Overall Game** | **Best Overall Game** | **Best Family Game** | **Best Overall Solo Game** | **Best Overall Game** |
| 1 | #1 [Locky Dice](https://boardgamegeek.com/thread/3495217/wip-locky-dice-a-solitaire-dice-manipulation-game) — Ready | #1 [Braggarts](https://boardgamegeek.com/thread/3574791/wip-braggarts-a-double-ended-trick-taker-winner-of) — Ready | #1 [Math Knight](https://boardgamegeek.com/thread/3436938) — Ready | #1 [ICBRG](https://boardgamegeek.com/thread/3493395) — Ready | #1 [One for sorrow](https://boardgamegeek.com/thread/3388854) — Ready | #1 [Alea’s Garden](https://boardgamegeek.com/thread/3530593/aleas-garden-cosy-polyomino-deckbuilding-game-winn) — Ready |
|   | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🟢 | L 🟢 · D 🔴 | L 🟢 · D 🔴 |
| 2 | #2 [Nap & Roll](https://boardgamegeek.com/thread/3440820/wip-nap-and-roll-2025-1-card-print-and-play-design) — Ready | #2 [Intercept](https://boardgamegeek.com/thread/3561466) — Ready | #2 [Bullet Run](https://boardgamegeek.com/thread/3450478) — Ready | #2 [The Robots are Multiplying](https://boardgamegeek.com/thread/3442172) — Ready | #2 [Hand-At-Arms](https://boardgamegeek.com/thread/3402467) — Ready | #2 [Server Breach](https://boardgamegeek.com/thread/3545479/wip-server-breach-fast-solo-card-game-of-strategic) — Ready |
|   | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🟡 | L 🟢 · D 🔴 | L 🟢 · D 🔴 |
| 3 | #3 [Sliminal Pursuit](https://boardgamegeek.com/thread/3513981/wip-sliminal-pursuit-2025-1-card-print-and-play-de) — Ready | #3 [Potemkin Villages](https://boardgamegeek.com/thread/3576989/potemkin-villages-54-card-game-design-contest-2025) — Ready | #2 [Fall of the Republic](https://boardgamegeek.com/thread/3463372) — Ready | #3 [Poker Face](https://boardgamegeek.com/thread/3465191) — Ready | #3 [Smuggler's Sky: Hand of Fate](https://boardgamegeek.com/thread/3425444) — Ready | #3 [Super Robo JetKaiser Z](https://boardgamegeek.com/thread/3528637/wip-super-robo-jetkaiser-z-3rd-place-2025-solo-pnp) — Ready |
|   | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🟢 | L 🟢 · D 🔴 | L 🟢 · D 🔴 |
| 4 | #4 [Honeybee and Dragonfly](https://boardgamegeek.com/thread/3491504/wip-honeybee-and-dragonfly-entry-into-the-2025-1-c) — Ready | #4 [Hack the Planet](https://boardgamegeek.com/thread/3537032/wip-hack-the-planet-2025-54-card-game-design-conte) — Ready | #3 [Veggie Patch](https://boardgamegeek.com/thread/3452530) — Ready | #4 [Good Breeding](https://boardgamegeek.com/thread/3431880) — Ready | #4 [Hand of Cthulhu](https://boardgamegeek.com/thread/3379033) — Ready | #4 [Word Dungeon](https://boardgamegeek.com/thread/3527240/wip-word-dungeon-2025-solitaire-p-and-p-design-con) — Ready |
|   | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🟡 | L 🟢 · D 🔴 | L 🟢 · D 🔴 |
| 5 | #5 [Shadow Heist](https://boardgamegeek.com/thread/3513986/wip-shadow-heist-2025-1-card-print-and-play-design) — Ready | #5 [Oh Ship!](https://boardgamegeek.com/thread/3538538) — Ready | #4 [Dung Beetles](https://boardgamegeek.com/thread/3453315) — Ready | #5 [Bon-Bon](https://boardgamegeek.com/thread/3493740) — Ready | #5 [Songs of the Sea and the Sky](https://boardgamegeek.com/thread/3419526) — Ready | #5 [Tightrope Terror](https://boardgamegeek.com/thread/3507873/wip-tightrope-terror-1p-set-collection-balance-mgm) — Ready |
|   | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 |
| 6 | #6 [Matching Socks](https://boardgamegeek.com/thread/3494402/matching-socks-1p-puzzle-5min-1-card-contest) — Ready | #5 [Scavengers](https://boardgamegeek.com/thread/3560045) — Ready | #5 [Mutineer](https://boardgamegeek.com/thread/3477856) — Ready | #6 [Submarine Adventure](https://boardgamegeek.com/thread/3473660) — Ready | #6 [Publish or Perish](https://boardgamegeek.com/thread/3413650) — Ready | #6 [Count Poitiers: Murder at Harmax Hall](https://boardgamegeek.com/thread/3526641/wip-count-poitiers-murder-at-harmax-hall-2025-soli) — Ready |
|   | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🟡 | L 🟢 · D 🔴 | L 🟢 · D 🔴 |
| 7 | #7 [Self Service](https://boardgamegeek.com/thread/3516181/wip-self-service-2-4p-8-10min-worker-placement-dic) — Ready | #7 [Villains Incorporated](https://boardgamegeek.com/thread/3539135) — Ready | #6 [Dragons Horde](https://boardgamegeek.com/thread/3439500) — Ready | #7 [Allmende](https://boardgamegeek.com/thread/3487174) — Ready | [Awake until midnight](https://boardgamegeek.com/thread/3425454) — Withdrawn | #7 [Flipping Fortune](https://boardgamegeek.com/thread/3552470/wip-flipping-fortune-push-your-luck-deckbuilding-2) — Ready |
|   | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🟡 | L 🟢 · D 🔴 | L 🟢 · D 🔴 |
| 8 | #8 [BEEP](https://boardgamegeek.com/thread/3508169/wip-beep-a-single-card-anticipation-game-1-card-pr) — Ready | #7 [Wildlife Garden](https://boardgamegeek.com/thread/3552498) — Ready | #7 [Grate Sword](https://boardgamegeek.com/thread/3459079) — Ready | #8 [Mermaids vs Dinosaurs](https://boardgamegeek.com/thread/3484120) — Ready | [Black Market](https://boardgamegeek.com/thread/3431335) — Withdrawn | #8 [Cupid Boards A Train](https://boardgamegeek.com/thread/3555269/wip-cupid-boards-a-train-2025-solitaire-pnp-contes) — Ready |
|   | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🟡 | L 🟢 · D 🔴 | L 🟢 · D 🔴 |
| 9 | #9 [Delivery Dash](https://boardgamegeek.com/thread/3494616/wip-delivery-dash-1-card-design-contest-2-or-more) — Ready | #8 [Surfboard Stealin' Sea Otters](https://boardgamegeek.com/thread/3543426) — Ready | [1865: Flying Confederacy Guns of Freedom](https://boardgamegeek.com/thread/3477165) — Withdrawn | #9 [Peng Wins!](https://boardgamegeek.com/thread/3449433) — Ready | [Crop Rotation](https://boardgamegeek.com/thread/3378438) — Ready | #9 [Lasercut](https://boardgamegeek.com/thread/3526117/wip-lasercut-2025-solo-pnp-contest-contest-ready) — Ready |
|   | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🟢 | L 🟢 · D 🔴 | L 🟢 · D 🔴 |
| 10 | #10 [Ship Under Sabotage](https://boardgamegeek.com/thread/3488497/wip-ship-under-sabotage-a-1-card-deduction-game-co) — Ready | #9 [The Gauntlet: Twenty Trials of Darkness](https://boardgamegeek.com/thread/3577099/wip-the-gauntlet-twenty-trials-of-darkness-2025-54) — Ready | [20 Dice](https://boardgamegeek.com/thread/3479228) — Ready | #10 [Hex Hive: Skirmish](https://boardgamegeek.com/thread/3449448) — Ready | [Dive Into The Dungeon](https://boardgamegeek.com/thread/3408691) — Ready | #10 [Underdice Kingdom](https://boardgamegeek.com/thread/3528152/wip-underdice-kingdom-2025-solitaire-print-and-pla) — Ready |
|   | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 |
| 11 | #11 [Way of the Goose](https://boardgamegeek.com/thread/3510065/wip-way-of-the-goose-a-snappy-dexterity-game-for-2) — Ready | [Bet and Bridle](https://boardgamegeek.com/thread/3569340/bet-and-bridle-2025-54-card-game-design-contest) — Ready | [7 PIONEERS](https://boardgamegeek.com/thread/3477202) — Ready | [Amusement park](https://boardgamegeek.com/thread/3496296) — Ready | [Downtown Las Palmas](https://boardgamegeek.com/thread/3410393) — Withdrawn | #11 [Landscapes](https://boardgamegeek.com/thread/3534010/wip-landscapes-solo-set-collection-card-game-5-min) — Ready |
|   | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 |
| 12 | #12 [Lucky Words](https://boardgamegeek.com/thread/3491766/wip-lucky-words-entry-into-the-2025-1-card-print-a) — Ready | [Card Champs](https://boardgamegeek.com/thread/3577095/wip-card-champs-a-1v1-tag-team-wrestling-character-card-game) — Ready | [9 Days of Kyiv](https://boardgamegeek.com/thread/3446532) — Ready | [Crab Boil](https://boardgamegeek.com/thread/3495781) — Ready | [Dreadspire Keep](https://boardgamegeek.com/thread/3429956) — Withdrawn | #12 [My Journal](https://boardgamegeek.com/thread/3568823/wip-my-journal-2025-solitaire-p-and-p-design-conte) — Ready |
|   | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 |
| 13 | #13 [Rabbit Race](https://boardgamegeek.com/thread/3505789/wip-rabbit-race-1-card-racing-game-1-4-players-202) — Ready | [Dreadful Deductions](https://boardgamegeek.com/thread/3548061) — Ready | [9 RIP](https://boardgamegeek.com/thread/3454676) — Ready | [Guesstrictions](https://boardgamegeek.com/thread/3496460) — Ready | [Duel: Clash of Metal](https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest) — Withdrawn | #13 [Covert Tricks](https://boardgamegeek.com/thread/3521431/wip-covert-tricks-a-solo-trick-taking-game-1-playe) — Ready |
|   | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 |
| 14 | #14 [Don’t Get Snaked!](https://boardgamegeek.com/thread/3487751/wip-dont-get-snaked-a-1-card-background-party-game) — Ready | [Hack-a-Pad](https://boardgamegeek.com/thread/3558118) — Ready | [9th Maze](https://boardgamegeek.com/thread/3438996) — Ready | [Head In The Clouds](https://boardgamegeek.com/thread/3469238) — Ready | [Handicam](https://boardgamegeek.com/thread/3423424) — Withdrawn | #14 [It's Not Rocket Science](https://boardgamegeek.com/thread/3520767/wip-its-not-rocket-science-a-solitaire-game-of-dic) — Ready |
|   | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 |
| 15 | #15 [Boom!](https://boardgamegeek.com/thread/3501760/wip-boom-2025-1-card-pnp-design-contest-contest-re) — Ready | [Harlequin](https://boardgamegeek.com/thread/3543743) — Ready | [A Seat at the Table](https://boardgamegeek.com/thread/3477933) — Withdrawn | [Ice Cream Heist](https://boardgamegeek.com/thread/3462311) — Ready | [HandMaze](https://boardgamegeek.com/thread/3423398) — Withdrawn | #15 [Lost in Spaceship](https://boardgamegeek.com/thread/3567188/lost-in-spaceship-2025-solitaire-contest-puzzle-1) — Ready |
|   | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🟢 | L 🟢 · D 🔴 | L 🟢 · D 🔴 |
| 16 | [Archipelago Rebels](https://boardgamegeek.com/thread/3505950/wip-archipelago-rebels-2025-1-card-print-and-play) — Ready | [Kill The Queen](https://boardgamegeek.com/thread/3548538) — Ready | [All Amongst Cats and Pigeons](https://boardgamegeek.com/thread/3469230) — Ready | [Island of Peril](https://boardgamegeek.com/thread/3482193) — Ready | [Hellheim In-Hand Duel](https://boardgamegeek.com/thread/3403303) — Withdrawn | #16 [Never Ending West](https://boardgamegeek.com/thread/3523039/wip-never-ending-west-1-page-procedurally-generate) — Ready |
|   | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 |
| 17 | [Breathless Tango](https://boardgamegeek.com/thread/3495445/wip-breathless-tango-2025-1-card-pnp-design-contes) — Ready | [One More?](https://boardgamegeek.com/thread/3576425) — Ready | [Brawl](https://boardgamegeek.com/thread/3436343/2025-9-card-nanogame-print-and-play-design-contest) — Withdrawn | [Isles of Odd](https://boardgamegeek.com/thread/3441309) — Ready | [Librarian’s Cat](https://boardgamegeek.com/thread/3431954) — Ready | #17 [Aqua Fluens](https://boardgamegeek.com/thread/3534737/wip-aqua-fluens-2025-solitaire-p-and-p-design-cont) — Ready |
|   | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🟡 | L 🟢 · D 🔴 | L 🟢 · D 🔴 |
| 18 | [Cuéntame (Tell me)](https://boardgamegeek.com/thread/3505085/cuentame-tell-me) — Ready | [Perilous Quest](https://boardgamegeek.com/thread/3566750) — Ready | [Buddy System](https://boardgamegeek.com/thread/3449122) — Ready | [Origami Champions](https://boardgamegeek.com/thread/3451743) — Ready | [Maze Shift](https://boardgamegeek.com/thread/3384043) — Ready | #18 [Coup de Jarnac](https://boardgamegeek.com/thread/3568785/wip-coup-de-jarnac-2025-solo-pnp-contest-contest-r) — Ready |
|   | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 |
| 19 | [Deceive to Succeed](https://boardgamegeek.com/thread/3491405/wip-deceive-to-succeed-duel-game-10-minutes-based) — Ready | [Pip's Quest](https://boardgamegeek.com/thread/3539855/pips-quest-2025-54-card-contest-contest-ready) — Ready | [Bug Brain](https://boardgamegeek.com/thread/3441992) — Ready | [Panic Picasso!](https://boardgamegeek.com/thread/3496634) — Ready | [Memory Trick](https://boardgamegeek.com/thread/3388612) — Withdrawn | #19 [Drone Workshop](https://boardgamegeek.com/thread/3556332/wip-drone-workshop-2025-solitaire-print-and-play-c) — Ready |
|   | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🟢 | L 🟢 · D 🔴 | L 🟢 · D 🔴 |
| 20 | [Disturbance at Darkholm Manor](https://boardgamegeek.com/thread/3520521/wip-disturbance-at-darkholm-manor-2025-1-card-pnp) — Ready | [Racket](https://boardgamegeek.com/thread/3555689) — Ready | [Call the Crew](https://boardgamegeek.com/thread/3440581) — Withdrawn | [Pets Rescue](https://boardgamegeek.com/thread/3441653) — Ready | [Office Quest: Data Kraken](https://boardgamegeek.com/thread/3402030) — Ready | #20 [Johnny Appleseed](https://boardgamegeek.com/thread/3521035/wip-johnny-appleseed-contest-ready-2025-solo-pnp-c) — Ready |
|   | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 |
| 21 | [Finger Twister](https://boardgamegeek.com/thread/3516506/operation-d-2-2025-1-card-print-and-play-design-co) — Ready | [Ranicide](https://boardgamegeek.com/thread/3549419) — Ready | [Calling Card Warriors](https://boardgamegeek.com/thread/3475937) — Ready | [Pirate Treasures](https://boardgamegeek.com/thread/3435409) — Ready | [On the Trail of the Letter Cutter](https://boardgamegeek.com/thread/3388256) — Withdrawn | #21 [Miskatonic Confidential](https://boardgamegeek.com/thread/3486464/wip-miskatonic-confidential-2025-solitaire-print-a) — Ready |
|   | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 |
| 22 | [Flip Fart](https://boardgamegeek.com/thread/3515359/wip-flip-fart-2025-1-card-print-and-play-design-co) — Ready | [Rekta](https://boardgamegeek.com/thread/3541265) — Ready | [Cotton Candy Stampede](https://boardgamegeek.com/thread/3468802) — Withdrawn | [Potions Master Tournament](https://boardgamegeek.com/geeklist/351008/2025-children-and-family-game-design-contest?itemid=11448984#11448984) — Ready | [One Banner](https://boardgamegeek.com/thread/3379074) — Ready | #22 [Bread & Circuits](https://boardgamegeek.com/thread/3530627/wip-bread-and-circuits-1p-investment-bag-building) — Ready |
|   | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 |
| 23 | [Going the Difference!](https://boardgamegeek.com/thread/3509254/wip-going-the-difference-a-1-card-1v1-dice-strateg) — Ready | [Tinker Turtle](https://boardgamegeek.com/thread/3576051) — Ready | [Daily Dungeon](https://boardgamegeek.com/thread/3443671) — Withdrawn | [Slowpoke](https://boardgamegeek.com/thread/3451616) — Ready | [Prime Minister](https://boardgamegeek.com/thread/3378860) — Withdrawn | #23 [Brothers in Arms](https://boardgamegeek.com/thread/3545944/wip-brothers-in-arms-solo-pnp-contest-25) — Ready |
|   | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🟡 | L 🟢 · D 🔴 | L 🟢 · D 🔴 |
| 24 | [Hovercraft in a Minefield: Alligator Rescue](https://boardgamegeek.com/thread/3510163/wip-hovercraft-in-a-minefield-alligator-rescue-a-s) — Ready | [Tower Guard](https://boardgamegeek.com/thread/3560716) — Ready | [Dice Production](https://boardgamegeek.com/thread/3479765) — Withdrawn | [Sorry! That's My Dungeon](https://boardgamegeek.com/thread/3442526) — Ready | [Spellbooked!](https://boardgamegeek.com/thread/3430680) — Ready | #24 [Urban Planner](https://boardgamegeek.com/thread/3526943/wip-urban-planner-component-ready-2025-solitaire-p) — Ready |
|   | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🟢 | L 🟢 · D 🔴 | L 🟢 · D 🔴 |
| 25 | [In the Trench](https://boardgamegeek.com/thread/3495777/wip-in-the-trench) — Ready | [Trick Trick Boom](https://boardgamegeek.com/thread/3576183) — Ready | [Echoing Howls](https://boardgamegeek.com/thread/3449028) — Ready | [Squirelly](https://boardgamegeek.com/thread/3465485) — Ready | [Starcrossed](https://boardgamegeek.com/thread/3400721) — Withdrawn | #25 [Have some Cheese](https://boardgamegeek.com/thread/3568849/wip-have-some-cheese-solo-spatial-puzzle-10-mins-2) — Ready |
|   | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🟡 | L 🟢 · D 🔴 | L 🟢 · D 🔴 |
| 26 | [Know B4 U Go](https://boardgamegeek.com/thread/3520264/know-b4-u-go-2p-5-10min-cooperative-2025-1-card-pr) — Ready | [Victorian Villainy](https://boardgamegeek.com/thread/3573515/wip-victorian-villainy) — Ready | [Elementa](https://boardgamegeek.com/thread/3476068) — Withdrawn | [Swirls](https://boardgamegeek.com/thread/3387063) — Ready | [Valley of Gems](https://boardgamegeek.com/thread/3399221) — Ready | [Abydos](https://boardgamegeek.com/thread/3522182/wip-abydos-1p-30-min-real-time-puzzle-game-2025-so) — Ready |
|   | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 |
| 27 | [Laced Up](https://boardgamegeek.com/thread/3509555/wip-laced-up-2025-1-card-pnp-design-contest-contes) — Ready | [Wager in the Fog](https://boardgamegeek.com/thread/3572929/wager-in-the-fog-the-keeper-s-last-hand-54-card-ga) — Ready | [Flip Dungeon](https://boardgamegeek.com/thread/3479370) — Ready | [Zoo Rush](https://boardgamegeek.com/thread/3495361) — Ready | [Withering Grove](https://boardgamegeek.com/thread/3425504) — Ready | [Advance The Ranch](https://boardgamegeek.com/thread/3524433/wip-advance-the-ranch-2025-solo-pnp-contest-compon) — Ready |
|   | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 |
| 28 | [One Card Battle](https://boardgamegeek.com/thread/3512843/wip-one-card-battle-2025-1-card-print-and-play-des) — Ready | [Yaminabe](https://boardgamegeek.com/thread/3546692) — Ready | [FOR9E](https://boardgamegeek.com/thread/3449728) — Ready |   |   | [Arachnacrisis](https://boardgamegeek.com/thread/3554850/wip-arachnacrisis-1p-dice-pool-team-management-202) — Ready |
|   | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 |   |   | L 🟢 · D 🔴 |
| 29 | [One Card Guard](https://boardgamegeek.com/thread/3489141/wip-one-card-guard-a-solo-dice-driven-boss-battle) — Ready |   | [Forest Tip](https://boardgamegeek.com/thread/3477855) — Ready |   |   | [Bletchley Park](https://boardgamegeek.com/thread/3567447/bletchley-park-join-the-select-group-of-codebreake) — Ready |
|   | L 🟢 · D 🔴 |   | L 🟢 · D 🔴 |   |   | L 🟢 · D 🔴 |
| 30 | [One Intersection](https://boardgamegeek.com/thread/3511086/wip-one-intersection-1p-15-20min-dice-manipulation) — Ready |   | [Fruit Sort Company](https://boardgamegeek.com/thread/3479222) — Ready |   |   | [Calculated Risk](https://boardgamegeek.com/thread/3527694/wip-calculated-risk-1p-15min-tableau-building-puzz) — Ready |
|   | L 🟢 · D 🔴 |   | L 🟢 · D 🔴 |   |   | L 🟢 · D 🔴 |
| 31 | [Pass the Dice](https://boardgamegeek.com/thread/3493787/wip-pass-the-dice-quick-dice-roller-for-2-4-player) — Ready |   | [Gems Make Goblin Kings](https://boardgamegeek.com/thread/3473847) — Ready |   |   | [Carthago Servanda Est](https://boardgamegeek.com/thread/3563889/wip-carthago-servanda-est) — Ready |
|   | L 🟢 · D 🔴 |   | L 🟢 · D 🔴 |   |   | L 🟢 · D 🔴 |
| 32 | [Piece of Cake](https://boardgamegeek.com/thread/3512039/wip-piece-of-cake-2025-1-card-print-and-play-desig) — Ready |   | [Haunted Hunting Grounds](https://boardgamegeek.com/thread/3475192) — Ready |   |   | [Charming the Belle](https://boardgamegeek.com/thread/3566520/charming-the-belle-2025-solitaire-print-and-play-c) — Ready |
|   | L 🟢 · D 🔴 |   | L 🟢 · D 🔴 |   |   | L 🟢 · D 🔴 |
| 33 | [Saltatorial](https://boardgamegeek.com/thread/3517033/wip-saltatorial-a-whimsical-cricket-simulator-2025) — Ready |   | [HMS Ulven](https://boardgamegeek.com/thread/3436343/2025-9-card-nanogame-print-and-play-design-contest) — Withdrawn |   |   | [Contubernium: Rome at War](https://boardgamegeek.com/thread/3528184/complete-contubernium-rome-at-war-2025-solitaire-p) — Ready |
|   | L 🟢 · D 🔴 |   | L 🟢 · D 🔴 |   |   | L 🟢 · D 🔴 |
| 34 | [Some Strings Attached](https://boardgamegeek.com/thread/3512037/wip-some-strings-attached-2025-1-card-print-and-pl) — Ready |   | [Hydra Wrangler](https://boardgamegeek.com/thread/3439122) — Ready |   |   | [Courtful of Tricks](https://boardgamegeek.com/thread/3526900/wip-courtful-of-tricks-solo-pnp-design-contest-tri) — Ready |
|   | L 🟢 · D 🔴 |   | L 🟢 · D 🔴 |   |   | L 🟢 · D 🔴 |
| 35 | [The Moving Fortress](https://boardgamegeek.com/thread/3489442/wip-the-moving-fortress-a-1-card-resource-manageme) — Ready |   | [If Only Fireflies Exist](https://boardgamegeek.com/thread/3477927) — Ready |   |   | [Crikey!](https://boardgamegeek.com/thread/3568329/crikey-contest-ready) — Ready |
|   | L 🟢 · D 🔴 |   | L 🟢 · D 🔴 |   |   | L 🟢 · D 🔴 |
| 36 | [The Peak](https://boardgamegeek.com/thread/3512510/wip-the-peak-2025-1-card-print-and-play-design-con) — Ready |   | [Into the Arcanum](https://boardgamegeek.com/thread/3440248) — Ready |   |   | [D6 Alchemist](https://boardgamegeek.com/thread/3525435/wip-d6-alchemist-2025-solitaire-print-and-play-con) — Ready |
|   | L 🟢 · D 🔴 |   | L 🟢 · D 🔴 |   |   | L 🟢 · D 🔴 |
| 37 | [Wobbly Bridge](https://boardgamegeek.com/thread/3503056/wip-wobbly-bridge-contest-ready-2025-1-card-pnp-de) — Ready |   | [Katsuka](https://boardgamegeek.com/thread/3469537) — Withdrawn |   |   | [Delve in Your Pocket: The Folded Depths Await](https://boardgamegeek.com/thread/3519938/wip-delve-in-your-pocket-the-folded-depths-await-1) — Ready |
|   | L 🟢 · D 🔴 |   | L 🟢 · D 🔴 |   |   | L 🟢 · D 🔴 |
| 38 | [Zombie Apocalypse](https://boardgamegeek.com/thread/3514360/wip-zombie-apocalypse-2025-1-card-pnp-design-conte) — Ready |   | [Kodokuna: The Lone Hermit](https://boardgamegeek.com/thread/3447990) — Ready |   |   | [Diemon](https://boardgamegeek.com/thread/3535235/wip-diemon-2025-solitaire-pnp-contest-components-a) — Ready |
|   | L 🟢 · D 🔴 |   | L 🟢 · D 🔴 |   |   | L 🟢 · D 🔴 |
| 39 |   |   | [Labyrinth Nine](https://boardgamegeek.com/thread/3447052) — Withdrawn |   |   | [Dominate](https://boardgamegeek.com/thread/3565711/dominate-machines-and-trees-2025-solitaire-p-and-p) — Ready |
|   |   |   | L 🟢 · D 🔴 |   |   | L 🟢 · D 🔴 |
| 40 |   |   | [Let's Have a Wedding](https://boardgamegeek.com/thread/3477894) — Ready |   |   | [DonJon Defense](https://boardgamegeek.com/thread/3534318/wip-donjon-defense-a-solo-tower-defense-card-game) — Ready |
|   |   |   | L 🟢 · D 🔴 |   |   | L 🟢 · D 🔴 |
| 41 |   |   | [Little Ruins of Arnakiny](https://boardgamegeek.com/thread/3455234) — Ready |   |   | [Eighteen Eggs](https://boardgamegeek.com/thread/3523615/wip-eighteen-eggs-1p-10-min-memory-matching-puzzle) — Ready |
|   |   |   | L 🟢 · D 🔴 |   |   | L 🟢 · D 🔴 |
| 42 |   |   | [Lola High Up in the Ocean](https://boardgamegeek.com/thread/3456714) — Ready |   |   | [Fairway Fantasy](https://boardgamegeek.com/thread/3568475/wip-fairway-fantasy-an-entry-in-the-2025-solitaire) — Ready |
|   |   |   | L 🟢 · D 🔴 |   |   | L 🟢 · D 🔴 |
| 43 |   |   | [Main Line Mayhem](https://boardgamegeek.com/thread/3479751) — Withdrawn |   |   | [Four-Armed Robot Blaster: Hunt for the Arqu](https://boardgamegeek.com/thread/3533740/wip-four-armed-robot-blaster-hunt-for-the-arqu-a-s) — Ready |
|   |   |   | L 🟢 · D 🔴 |   |   | L 🟢 · D 🔴 |
| 44 |   |   | [Monster Restaurant](https://boardgamegeek.com/thread/3461857) — Withdrawn |   |   | [Going Knowhere](https://boardgamegeek.com/thread/3546467/wip-2042026-update-going-knowhere-solo-fantasy-rog) — Ready |
|   |   |   | L 🟢 · D 🔴 |   |   | L 🟢 · D 🔴 |
| 45 |   |   | [Network with an Octopuse](https://boardgamegeek.com/thread/3479008) — Withdrawn |   |   | [He Watches With No Eyes](https://boardgamegeek.com/thread/3544732/wip-he-watches-with-no-eyes-a-mournington-game-sub) — Ready |
|   |   |   | L 🟢 · D 🔴 |   |   | L 🟢 · D 🔴 |
| 46 |   |   | [Nine Tails](https://boardgamegeek.com/thread/3457895) — Ready |   |   | [Here they come... AGAIN!](https://boardgamegeek.com/thread/3530072/wip-here-they-come-again-2025-solitaire-print-and) — Ready |
|   |   |   | L 🟢 · D 🔴 |   |   | L 🟢 · D 🔴 |
| 47 |   |   | [No More Dragons](https://boardgamegeek.com/thread/3446445) — Ready |   |   | [Island Stranding](https://boardgamegeek.com/thread/3559890/wip-island-stranding-hand-management-18-cards-puzz) — Ready |
|   |   |   | L 🟢 · D 🔴 |   |   | L 🟢 · D 🔴 |
| 48 |   |   | [Obscurum](https://boardgamegeek.com/thread/3479007) — Ready |   |   | [Jacobites 1745](https://boardgamegeek.com/thread/3528153/wip-jacobites-1745-solo-pnp-roll-and-write) — Ready |
|   |   |   | L 🟢 · D 🔴 |   |   | L 🟢 · D 🔴 |
| 49 |   |   | [Ocean Path](https://boardgamegeek.com/thread/3442893) — Ready |   |   | [Jelly](https://boardgamegeek.com/thread/3564034/wip-jelly-a-puzzle-book-2025-solitaire-pnp-game-co) — Ready |
|   |   |   | L 🟢 · D 🔴 |   |   | L 🟢 · D 🔴 |
| 50 |   |   | [Oppidum](https://boardgamegeek.com/thread/3436697) — Ready |   |   | [Micro-Cosmic Confrontation](https://boardgamegeek.com/thread/3555735/wip-micro-cosmic-confrontation-solitaire-pnp-game) — Ready |
|   |   |   | L 🟢 · D 🔴 |   |   | L 🟢 · D 🔴 |
| 51 |   |   | [Orangutan Rescue Duet](https://boardgamegeek.com/thread/3475151) — Ready |   |   | [Moonsail](https://boardgamegeek.com/thread/3563993/wip-moonsail-a-solitaire-roll-and-write-pirate-adv) — Ready |
|   |   |   | L 🟢 · D 🔴 |   |   | L 🟢 · D 🔴 |
| 52 |   |   | [Particular Pigeons](https://boardgamegeek.com/thread/3466979) — Ready |   |   | [Nan's Heroes](https://boardgamegeek.com/thread/3547246/nans-heroes-pnp) — Ready |
|   |   |   | L 🟢 · D 🔴 |   |   | L 🟢 · D 🔴 |
| 53 |   |   | [Passcode](https://boardgamegeek.com/thread/3453394) — Ready |   |   | [null_pr0xy](https://boardgamegeek.com/thread/3549054/wip-null-pr0xy-solo-dice-manipulation-push-your-lu) — Ready |
|   |   |   | L 🟢 · D 🔴 |   |   | L 🟢 · D 🔴 |
| 54 |   |   | [Penny Poltergeist](https://boardgamegeek.com/thread/3461958) — Ready |   |   | [Of Memories and Decay](https://boardgamegeek.com/thread/3566728/wip-of-memories-and-decay-a-solo-dungeon-crawl-gam) — Ready |
|   |   |   | L 🟢 · D 🔴 |   |   | L 🟢 · D 🔴 |
| 55 |   |   | [Primary Colors](https://boardgamegeek.com/thread/3478441) — Withdrawn |   |   | [Only Diced Words](https://boardgamegeek.com/thread/3519694/wip-only-diced-words-solo-pnp-contest-25contest-re) — Ready |
|   |   |   | L 🟢 · D 🔴 |   |   | L 🟢 · D 🔴 |
| 56 |   |   | [Psychodynamic Fronts](https://boardgamegeek.com/thread/3479778) — Withdrawn |   |   | [Oregon Trail](https://boardgamegeek.com/thread/3530234/wip-oregon-trail-2025-solitaire-print-and-play-con) — Ready |
|   |   |   | L 🟢 · D 🔴 |   |   | L 🟢 · D 🔴 |
| 57 |   |   | [Puebleando](https://boardgamegeek.com/thread/3477928) — Withdrawn |   |   | [Overstep: Balance or Collapse](https://boardgamegeek.com/thread/3569021/wip-overstep-balance-or-collapse-2025-solitaire-pr) — Ready |
|   |   |   | L 🟢 · D 🔴 |   |   | L 🟢 · D 🔴 |
| 58 |   |   | [Quick Dishes](https://boardgamegeek.com/thread/3461354) — Ready |   |   | [Pilzgrim](https://boardgamegeek.com/thread/3545369/wip-pilzgrim-solo-36-cards-map-maze-components-and) — Ready |
|   |   |   | L 🟢 · D 🔴 |   |   | L 🟢 · D 🔴 |
| 59 |   |   | [Rapid Words](https://boardgamegeek.com/thread/3443351) — Ready |   |   | [Plague Vector](https://boardgamegeek.com/thread/3530383/wip-plague-vector-2025-solitaire-print-and-play-co) — Ready |
|   |   |   | L 🟢 · D 🔴 |   |   | L 🟢 · D 🔴 |
| 60 |   |   | [Red Is Hungry](https://boardgamegeek.com/thread/3452360) — Withdrawn |   |   | [Pocket Submarine](https://boardgamegeek.com/thread/3535810/wip-pocket-submarine-2025-solitaire-p-and-p-design) — Ready |
|   |   |   | L 🟢 · D 🔴 |   |   | L 🟢 · D 🔴 |
| 61 |   |   | [Right-Hand-Man](https://boardgamegeek.com/thread/3447498) — Withdrawn |   |   | [Poker's Rogue Reckoning](https://boardgamegeek.com/thread/3560847/wip-pokers-rogue-reckoning) — Ready |
|   |   |   | L 🟢 · D 🔴 |   |   | L 🟢 · D 🔴 |
| 62 |   |   | [Risky Riches](https://boardgamegeek.com/thread/3479685) — Ready |   |   | [ROME](https://boardgamegeek.com/thread/3521436/wip-rome-a-solitaire-game-for-bored-citizens-2025) — Ready |
|   |   |   | L 🟢 · D 🔴 |   |   | L 🟢 · D 🔴 |
| 63 |   |   | [Royal Courier](https://boardgamegeek.com/thread/3436550) — Ready |   |   | [Rourke's Relics: Jungle Quest](https://boardgamegeek.com/thread/3548740/rourkes-relics-jungle-quest-a-solo-adventure-card) — Ready |
|   |   |   | L 🟢 · D 🔴 |   |   | L 🟢 · D 🔴 |
| 64 |   |   | [SagaSaurus: Dino Duel](https://boardgamegeek.com/thread/3471323) — Ready |   |   | [Run Time Zombie](https://boardgamegeek.com/thread/3523083/wip-run-time-zombie-a-solitaire-game-of-zombie-apo) — Ready |
|   |   |   | L 🟢 · D 🔴 |   |   | L 🟢 · D 🔴 |
| 65 |   |   | [Skyward Parcel](https://boardgamegeek.com/thread/3453464) — Ready |   |   | [SNAP](https://boardgamegeek.com/thread/3524851/components-ready-open-for-playtests-snap-2025-solo) — Ready |
|   |   |   | L 🟢 · D 🔴 |   |   | L 🟢 · D 🔴 |
| 66 |   |   | [Slayer](https://boardgamegeek.com/thread/3472477) — Ready |   |   | [South Shore Vibes](https://boardgamegeek.com/thread/3524180/wip-2025-solitaire-pnp-contest-south-shore-vibes) — Ready |
|   |   |   | L 🟢 · D 🔴 |   |   | L 🟢 · D 🔴 |
| 67 |   |   | [Smuggler's Sky: Fool's Gambit](https://boardgamegeek.com/thread/3476092) — Ready |   |   | [The Wretch](https://boardgamegeek.com/thread/3568463/wip-the-wretch-a-2025-solitaire-pnp-contest-entry) — Ready |
|   |   |   | L 🟢 · D 🔴 |   |   | L 🟢 · D 🔴 |
| 68 |   |   | [Soda Wars](https://boardgamegeek.com/thread/3441059) — Withdrawn |   |   | [Thru The Thicket](https://boardgamegeek.com/thread/3551597/wip-thru-the-thicket-a-cozy-solo-exploration-game) — Ready |
|   |   |   | L 🟢 · D 🔴 |   |   | L 🟢 · D 🔴 |
| 69 |   |   | [Sound Check](https://boardgamegeek.com/thread/3457687) — Ready |   |   | [Toborochi](https://boardgamegeek.com/thread/3521022/wiptoborochi2025-solitaire-game-design-contesttest) — Ready |
|   |   |   | L 🟢 · D 🔴 |   |   | L 🟢 · D 🔴 |
| 70 |   |   | [Space Traders](https://boardgamegeek.com/thread/3479556) — Withdrawn |   |   | [Tron: Origin](https://boardgamegeek.com/thread/3520697/wip-tron-origin-2025-solitaire-contest-contest-rea) — Ready |
|   |   |   | L 🟢 · D 🔴 |   |   | L 🟢 · D 🔴 |
| 71 |   |   | [SPLAT!](https://boardgamegeek.com/thread/3479036) — Withdrawn |   |   | [Vesuvius 79](https://boardgamegeek.com/thread/3558753/vesuvius-79-2025-solitaire-p-and-p-design-contest) — Ready |
|   |   |   | L 🟢 · D 🔴 |   |   | L 🟢 · D 🔴 |
| 72 |   |   | [Squunchies](https://boardgamegeek.com/thread/3472458) — Ready |   |   | [Vicinity](https://boardgamegeek.com/thread/3459416/wip-vicinity-a-simple-solo-tile-placement-game-con) — Ready |
|   |   |   | L 🟢 · D 🔴 |   |   | L 🟢 · D 🔴 |
| 73 |   |   | [Stand of Supremacy](https://boardgamegeek.com/thread/3449049) — Ready |   |   | [X-Stream Squatters](https://boardgamegeek.com/thread/3536789/x-stream-squatters-contest-ready) — Ready |
|   |   |   | L 🟢 · D 🔴 |   |   | L 🟢 · D 🔴 |
| 74 |   |   | [Submerge](https://boardgamegeek.com/thread/3462494) — Withdrawn |   |   | [Yokocho](https://boardgamegeek.com/thread/3543546/wip-yokocho-2025-solitaire-game-design-contest-con) — Ready |
|   |   |   | L 🟢 · D 🔴 |   |   | L 🟢 · D 🔴 |
| 75 |   |   | [Supernova Albion](https://boardgamegeek.com/thread/3478380) — Ready |   |   |   |
|   |   |   | L 🟢 · D 🔴 |   |   |   |
| 76 |   |   | [Surround the King](https://boardgamegeek.com/thread/3458414) — Withdrawn |   |   |   |
|   |   |   | L 🟢 · D 🔴 |   |   |   |
| 77 |   |   | [The 7th Island](https://boardgamegeek.com/thread/3465605) — Ready |   |   |   |
|   |   |   | L 🟢 · D 🔴 |   |   |   |
| 78 |   |   | [The Corridor](https://boardgamegeek.com/thread/3440241) — Withdrawn |   |   |   |
|   |   |   | L 🟢 · D 🔴 |   |   |   |
| 79 |   |   | [The King of Arcades](https://boardgamegeek.com/thread/3478326) — Ready |   |   |   |
|   |   |   | L 🟢 · D 🔴 |   |   |   |
| 80 |   |   | [The Remnant](https://boardgamegeek.com/thread/3440855) — Ready |   |   |   |
|   |   |   | L 🟢 · D 🔴 |   |   |   |
| 81 |   |   | [Three Buccaneers](https://boardgamegeek.com/thread/3466260) — Ready |   |   |   |
|   |   |   | L 🟢 · D 🔴 |   |   |   |
| 82 |   |   | [Three-Legged Race](https://boardgamegeek.com/thread/3475750) — Withdrawn |   |   |   |
|   |   |   | L 🟢 · D 🔴 |   |   |   |
| 83 |   |   | [Tiny, Dicey, and Starry](https://boardgamegeek.com/thread/3458095) — Ready |   |   |   |
|   |   |   | L 🟢 · D 🔴 |   |   |   |
| 84 |   |   | [Titolo non indicato (entry ritirata 12)](https://boardgamegeek.com/thread/3436343/2025-9-card-nanogame-print-and-play-design-contest) — Withdrawn |   |   |   |
|   |   |   | L 🟢 · D 🔴 |   |   |   |
| 85 |   |   | [Titolo non indicato (entry ritirata 3)](https://boardgamegeek.com/thread/3436343/2025-9-card-nanogame-print-and-play-design-contest) — Withdrawn |   |   |   |
|   |   |   | L 🟢 · D 🔴 |   |   |   |
| 86 |   |   | [Tower of Babel](https://boardgamegeek.com/thread/3474024) — Ready |   |   |   |
|   |   |   | L 🟢 · D 🔴 |   |   |   |
| 87 |   |   | [Tralim](https://boardgamegeek.com/thread/3468551) — Ready |   |   |   |
|   |   |   | L 🟢 · D 🔴 |   |   |   |
| 88 |   |   | [Tunnels and Treasures](https://boardgamegeek.com/thread/3467451) — Ready |   |   |   |
|   |   |   | L 🟢 · D 🔴 |   |   |   |
| 89 |   |   | [UHBC](https://boardgamegeek.com/thread/3475125) — Withdrawn |   |   |   |
|   |   |   | L 🟢 · D 🔴 |   |   |   |
| 90 |   |   | [Water Keeper](https://boardgamegeek.com/thread/3449763) — Ready |   |   |   |
|   |   |   | L 🟢 · D 🔴 |   |   |   |
| 91 |   |   | [WAYGATES](https://boardgamegeek.com/thread/3451301) — Ready |   |   |   |
|   |   |   | L 🟢 · D 🔴 |   |   |   |
| 92 |   |   | [Weird Spells](https://boardgamegeek.com/thread/3479202) — Withdrawn |   |   |   |
|   |   |   | L 🟢 · D 🔴 |   |   |   |
| 93 |   |   | [Word Flower](https://boardgamegeek.com/thread/3473382) — Ready |   |   |   |
|   |   |   | L 🟢 · D 🔴 |   |   |   |
| 94 |   |   | [Yattactics](https://boardgamegeek.com/thread/3479781) — Withdrawn |   |   |   |
|   |   |   | L 🟢 · D 🔴 |   |   |   |

#### Gruppo 2 di 4

| N. | [2025 Solomode Contest](https://boardgamegeek.com/thread/3470244/2025-solomode-contest) | [2025 Traditional Deck Game Design Contest](https://boardgamegeek.com/thread/3569158/2025-traditional-deck-game-design-contest) | [2025 Two-Player Print and Play Game Design Contest](https://boardgamegeek.com/thread/3530940/2025-two-player-print-and-play-game-design-contest) | [2025 Wargame Print and Play Design Contest](https://boardgamegeek.com/thread/3441044/results-in-2025-wargame-print-and-play-design-cont) | [January–February 2025 — 24 Hour Design Challenge (GUARD)](https://boardgamegeek.com/geeklist/355982/community-pnp-contests-and-winners) | [July–August 2025 — 24 Hour Design Challenge (PAD)](https://boardgamegeek.com/geeklist/355982/community-pnp-contests-and-winners) |
|---:|:---|:---|:---|:---|:---|:---|
| **Classifica utilizzata per l'ordinamento delle Entry** | **Best AI System** | **Best Solo Game** | **Best Overall** | **Best Overall Wargame** | **ordine alfabetico** | **ordine alfabetico** |
| 1 | #1 [Throne Alone](https://boardgamegeek.com/thread/3383061) — Ready | #1 [Jack's Dream](https://boardgamegeek.com/thread/3583045) | #1 [Scissor Wizards](https://boardgamegeek.com/thread/3535282/wip-scissor-wizards-2025-two-player-print-and-play) — Ready | #1 [Armored Fury](https://boardgamegeek.com/thread/3539132/playtest-ready-armored-fury-2025-wargame-print-and) — Ready | [Guard the Bard](https://boardgamegeek.com/thread/3452558/article/45584159#45584159) — Ready | [ALT](https://boardgamegeek.com/thread/3542704/article/46335246#46335246) — Ready |
|   | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |
| 2 | #2 [Sabi](https://boardgamegeek.com/thread/3466096) — Ready | #2 [Shadow Solitaire: Gambit for the City](https://boardgamegeek.com/thread/3581665) | #1 [WordStorm](https://boardgamegeek.com/thread/3560398/wip-wordstorm-2025-two-player-print-and-play-game) — Ready | #1 [Armées de Papier: Combined Arms Battles in the Napoleonic Era](https://boardgamegeek.com/thread/3548198/complete-armees-de-papier-combined-arms-battles-in) — Ready | [Guarded Words](https://boardgamegeek.com/thread/3452558/article/45584159#45584159) — Ready | [CareFlight](https://boardgamegeek.com/thread/3542704/article/46335246#46335246) — Ready |
|   | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |
| 3 | #3 [YRO Solo Campaign](https://boardgamegeek.com/thread/3422271) — Ready | #3 [Against The Clock](https://boardgamegeek.com/thread/3579229) | #2 [Quickdraw: Battle for Silver City](https://boardgamegeek.com/thread/3553161/wip-quickdraw-18-card-wild-west-squad-building-asy) — Ready | #3 [Monster Cross](https://boardgamegeek.com/thread/3582983/playtest-ready-monster-cross-2025-wargame-print-an) — Ready | [Handguards](https://boardgamegeek.com/thread/3452558/article/45584159#45584159) — Ready | [Cycle Of The Lotus](https://boardgamegeek.com/thread/3542704/article/46335246#46335246) — Ready |
|   | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |
| 4 | #4 [boop. Solo Mode](https://boardgamegeek.com/thread/3478437) — Ready | #4 [Soluna](https://boardgamegeek.com/thread/3615827) | #3 [Narrow Seas](https://boardgamegeek.com/thread/3567950/wip-narrow-seas-2025-two-player-pnp-contest-2-play) — Ready | #4 [Rough & Tumble Multilateral](https://boardgamegeek.com/thread/3576203/playtest-ready-rough-and-tumble-multilateral-2025) — Ready | [Maroons and Doubloons](https://boardgamegeek.com/thread/3452558/article/45584159#45584159) — Ready | [Lunch Pad](https://boardgamegeek.com/thread/3542704/article/46335246#46335246) — Ready |
|   | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |
| 5 | #5 [SUPERCAT](https://boardgamegeek.com/thread/3425290) — Ready | #5 [Swamp](https://boardgamegeek.com/thread/3569304) | #4 [Collapsi](https://boardgamegeek.com/thread/3548846/wip-collapsi-2025-two-player-print-and-play-design) — Ready | #5 [1453: Siege of Constantinople](https://boardgamegeek.com/thread/3495795/wip-1453-siege-of-constantinople-2025-wargames-pnp) — Ready | [Oh My Pies!](https://boardgamegeek.com/thread/3452558/article/45584159#45584159) — Ready | [Pad Your Stats](https://boardgamegeek.com/thread/3542704/article/46335246#46335246) — Ready |
|   | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |
| 6 | #6 [Lord d'Automa](https://boardgamegeek.com/thread/3512047) — Ready | #6 [River Black](https://boardgamegeek.com/thread/3569557) | #5 [OiSH!i](https://boardgamegeek.com/thread/3565566/wip-oishi-a-tasty-card-game-free-pnp) — Ready | #6 [StrikeFirstNow](https://boardgamegeek.com/thread/3585042/wip-strikefirstnow-from-hexstorical-playtest-ready) — Ready | [Valor](https://boardgamegeek.com/thread/3452558/article/45584159#45584159) — Ready |   |
|   | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |
| 7 | #7 [Solisauron](https://boardgamegeek.com/thread/3486373) — Ready | #7 [The Four Musketeers](https://boardgamegeek.com/thread/3575515) | #6 [Automon](https://boardgamegeek.com/thread/3548268/wip-automon-2025-two-player-game-design-contest) — Ready | #7 [The Ground Between](https://boardgamegeek.com/thread/3491589/released-the-ground-between-2025-wargame-pnp-desig) — Ready |   |   |
|   | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🔴 · D 🔴 |   |   |
| 8 | #8 [Cavemono](https://boardgamegeek.com/thread/3344024) — Ready | #8 [Alchemy](https://boardgamegeek.com/thread/3574744) | #6 [Bone Machine](https://boardgamegeek.com/thread/3556560/bone-machine-tile-laying-hand-management-2025-2-pl) — Ready | #8 [Finger Guns: A Wargame Played Using Only Fingers](https://boardgamegeek.com/thread/3555005/playtest-ready-finger-guns-a-wargame-played-using) — Ready |   |   |
|   | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🔴 · D 🔴 |   |   |
| 9 | #9 [Junk Punk](https://boardgamegeek.com/thread/3446309) — Ready | #9 [S.O.L. SIX ORBIT LOCKDOWN](https://boardgamegeek.com/thread/3576314) | #6 [Constellate](https://boardgamegeek.com/thread/3531905/wip-constellate-1-to-4-players-30-to-45-minutes-ti) — Ready | #9 [Fortuna & Virtu](https://boardgamegeek.com/thread/3564942/playtest-ready-fortuna-and-virtu-medieval-themed-w) — Ready |   |   |
|   | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🔴 · D 🔴 |   |   |
| 10 | #10 [Nemesis](https://boardgamegeek.com/thread/3504827) — Ready | #10 [Candles & Cannons](https://boardgamegeek.com/thread/3569308) | #6 [Heartseekers](https://boardgamegeek.com/thread/3532140/wip-heartseekers-2p-print-and-play-contest-2025) — Ready | #10 [Deadlock!](https://boardgamegeek.com/boardgame/446550/deadlock) — Ready |   |   |
|   | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🔴 · D 🔴 |   |   |
| 11 | [b-AI-rista](https://boardgamegeek.com/thread/3490914) — Ready | [Arsenal: Duel of Kings](https://boardgamegeek.com/thread/3620533) | #6 [Momentum](https://boardgamegeek.com/thread/3566864/wip-momentum-2-players) — Ready | #11 [In the Trench](https://boardgamegeek.com/thread/3530510/in-the-trench-war-game) — Ready |   |   |
|   | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🔴 · D 🔴 |   |   |
| 12 | [Bot Families](https://boardgamegeek.com/thread/3480600) — Ready | [Beanstalks](https://boardgamegeek.com/thread/3570031) | #6 [Mush Puppies](https://boardgamegeek.com/thread/3532583/wip-mush-puppies-18-cards-2025-2-player-pnp-design) — Ready | #12 [Night Strike: 418 Squadron RCAF](https://boardgamegeek.com/thread/3441750/night-strike-2025-cmc-war-game-pnp-contest-play-te) — Ready |   |   |
|   | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🔴 · D 🔴 |   |   |
| 13 | [Cathy](https://boardgamegeek.com/thread/3327279) — Ready | [Cardello](https://boardgamegeek.com/thread/3610656) | #6 [Parry](https://boardgamegeek.com/thread/3542787/wip-parry) — Ready | [Battle Stations!](https://boardgamegeek.com/thread/3522597/wip-battle-stations-a-space-dogfight-cardgame-2025) — Ready |   |   |
|   | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🔴 · D 🔴 |   |   |
| 14 | [Codenames Rush](https://boardgamegeek.com/thread/3475523) — Ready | [Council of Dragons](https://boardgamegeek.com/thread/3583048) | #6 [PAWND](https://boardgamegeek.com/thread/3547608/wip-pawnd-entry-for-2025-bgg-2-player-pnp-game-des) — Ready | [Project 01: Ferrum Front](https://boardgamegeek.com/thread/3582082/playtest-ready-project-01-ferrum-front-2025-wargam) — Ready |   |   |
|   | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🔴 · D 🔴 |   |   |
| 15 | [Enchanted Forest Solo Variant](https://boardgamegeek.com/thread/3406119) — Ready | [Court & Crown](https://boardgamegeek.com/thread/3576802) | #6 [Roll and Pull](https://boardgamegeek.com/thread/3542280/wip-tractor-pull-2025-two-player-print-and-play-de) — Ready | [S.P.A.T.](https://boardgamegeek.com/thread/3461799/wip-spat-2025-wargame-print-and-play-game-design-c) — Ready |   |   |
|   | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🔴 · D 🔴 |   |   |
| 16 | [Felipe I / Felipe II](https://boardgamegeek.com/thread/3490911) — Ready | [Divide](https://boardgamegeek.com/thread/3569799) | #6 [Senjin](https://boardgamegeek.com/thread/3534862/wip-senjin-2025-two-player-pnp-contest-components) — Ready | [Shootout in the Bardo](https://boardgamegeek.com/boardgame/417655/shootout-in-the-bardo) — Ready |   |   |
|   | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🔴 · D 🔴 |   |   |
| 17 | [Florek & Florka](https://boardgamegeek.com/thread/3454362) — Ready | [Edgar Shovelhands](https://boardgamegeek.com/thread/3569329) | #6 [Unlucky Spirits](https://boardgamegeek.com/thread/3544761/wip-unlucky-spirits-original-edition-1-3-players-6) — Ready | [Star Carrier Assault](https://boardgamegeek.com/thread/3542290/wip-star-carrier-assault-2025-wargame-print-and-pl) — Ready |   |   |
|   | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🔴 · D 🔴 |   |   |
| 18 | [Forest Link](https://boardgamegeek.com/thread/3496730) — Ready | [Feuda Rivalia](https://boardgamegeek.com/thread/3612376) | #6 [War Weavers: Vikings](https://boardgamegeek.com/thread/3567825/wip-war-weavers-vikings-2025-two-player-print-and) — Ready | [Tank Board Game II: Hex](https://boardgamegeek.com/boardgame/440996/tank-board-game-ii-hex) — Ready |   |   |
|   | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🔴 · D 🔴 |   |   |
| 19 | [Full Auto](https://boardgamegeek.com/thread/3483643) — Ready | [FIRE](https://boardgamegeek.com/thread/3586578) | #6 [Word Dungeon Duel](https://boardgamegeek.com/thread/3551113/wip-word-dungeon-duel-2-player-pnp-contest-compone) — Ready | [Ukrainian F-16: Peace has a price](https://boardgamegeek.com/boardgame/424102/ukrainian-f-16-peace-has-a-price) — Ready |   |   |
|   | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🔴 · D 🔴 |   |   |
| 20 | [Grandma & Grandpa](https://boardgamegeek.com/thread/3511290) — Ready | [Flock Rocks: Sheep vs. Wolves](https://boardgamegeek.com/thread/3576804) | #6 [World Trip](https://boardgamegeek.com/thread/3531092/playtest-ready-world-trip-2p-18-cardspnp-pcio-avai) — Ready |   |   |   |
|   | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 |   |   |   |
| 21 | [Humanoid Monsters Have Brains](https://boardgamegeek.com/thread/3471610) — Ready | [Grazer](https://boardgamegeek.com/thread/3616770) | [5 Spells](https://boardgamegeek.com/thread/3553927/wip-5-spells-2025-two-player-pnp-contest-2-player) — Ready |   |   |   |
|   | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 |   |   |   |
| 22 | [Lone Digger](https://boardgamegeek.com/thread/3474645) — Ready | [Hedgerow](https://boardgamegeek.com/thread/3579886) | [Cloud's Edge](https://boardgamegeek.com/thread/3568231/wip-clouds-edge-2025-2-player-pnp-contest-entry-pl) — Ready |   |   |   |
|   | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 |   |   |   |
| 23 | [M. KloneUs](https://boardgamegeek.com/thread/3511300) — Ready | [Hightower](https://boardgamegeek.com/thread/3573372) | [Cube Wars](https://boardgamegeek.com/thread/3538610/wip-cube-wars-a-compact-4x-for-the-2025-two-player) — Ready |   |   |   |
|   | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 |   |   |   |
| 24 | [Malakar](https://boardgamegeek.com/thread/3398741) — Ready | [Hocken](https://boardgamegeek.com/thread/3569651) | [Diskochet](https://boardgamegeek.com/thread/3545142/wip-diskochet-a-two-player-paddle-sport-card-game) — Ready |   |   |   |
|   | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 |   |   |   |
| 25 | [Midnight Racetrack](https://boardgamegeek.com/thread/3472592) — Ready | [Necromancer](https://boardgamegeek.com/thread/3615564) | [Duel of Fates](https://boardgamegeek.com/thread/3563553/wip-duel-of-fates-two-player-pnp-contest) — Ready |   |   |   |
|   | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 |   |   |   |
| 26 | [Pharaoh Code Solo Mode](https://boardgamegeek.com/geeklist/353866/2025-solomode-design-contest-submissions/?itemid=11794744#11794744) — Ready | [Olm](https://boardgamegeek.com/thread/3583037) | [Florentine Towers](https://boardgamegeek.com/thread/3567502/wip-florentine-towers) — Ready |   |   |   |
|   | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 |   |   |   |
| 27 | [RuneBot](https://boardgamegeek.com/thread/3510981) — Ready | [Pippins Aplenty](https://boardgamegeek.com/thread/3620605) | [Goal Rush](https://boardgamegeek.com/thread/3533918/goal-rush-wip) — Ready |   |   |   |
|   | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 |   |   |   |
| 28 | [Shrimpy](https://boardgamegeek.com/thread/3502388) — Ready | [Polarité](https://boardgamegeek.com/thread/3569377) | [GRDNN](https://boardgamegeek.com/thread/3567200/wip-grdnn-entry-for-2025-bgg-2-player-pnp-game-des) — Ready |   |   |   |
|   | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 |   |   |   |
| 29 | [Solo Automa for Avignon](https://boardgamegeek.com/thread/3472563) — Ready | [Relic Solitaire](https://boardgamegeek.com/thread/3600542) | [Hex Barons](https://boardgamegeek.com/thread/3566327/hex-barons-a-crunchy-streamlined-old-school-hex-sk) — Ready |   |   |   |
|   | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 |   |   |   |
| 30 | [Splendor Solo Mode](https://boardgamegeek.com/geeklist/353866/2025-solomode-design-contest-submissions/?itemid=11799886#11799886) — Ready | [Rules of Engagement](https://boardgamegeek.com/thread/3571024) | [Intramural](https://boardgamegeek.com/thread/3536316/wip-intramural-the-soccer-trick-taking-poker-game) — Ready |   |   |   |
|   | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 |   |   |   |
| 31 | [The Bus Conspiracy](https://boardgamegeek.com/thread/3445556) — Ready | [Safes](https://boardgamegeek.com/thread/3570149) | [KONSPIRO](https://boardgamegeek.com/thread/3538971/wip-konspiro-2025-two-player-pnp-reverse-deck-buil) — Ready |   |   |   |
|   | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 |   |   |   |
| 32 | [The Wily Widow](https://boardgamegeek.com/thread/3455165) — Ready | [Shadow Market](https://boardgamegeek.com/thread/3617857) | [KORxSOL](https://boardgamegeek.com/thread/3537614/wip-korxsol-fantasy-tabletop-pvp-card-and-dice-ski) — Ready |   |   |   |
|   | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 |   |   |   |
| 33 | [Unfinished Window](https://boardgamegeek.com/thread/3350683) — Ready | [Share Tactics](https://boardgamegeek.com/thread/3578872) | [Lemonade Stand](https://boardgamegeek.com/thread/3533425/wip-lemonade-stand-designed-by-lance-schricke-2025) — Ready |   |   |   |
|   | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 |   |   |   |
| 34 | [Unofficial Automa for Deep Regrets](https://boardgamegeek.com/thread/3503201) — Ready | [Sniper](https://boardgamegeek.com/thread/3618340) | [Orbits](https://boardgamegeek.com/thread/3552316/orbits-an-entry-into-the-two-player-game-design-co) — Ready |   |   |   |
|   | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 |   |   |   |
| 35 | [Unofficial Solo Mode & Campaign Mode](https://boardgamegeek.com/thread/3385154) — Ready | [Super Snap Showdown](https://boardgamegeek.com/thread/3616651) | [Perfect Gardens](https://boardgamegeek.com/thread/3568111/wip-perfect-gardens-2025-2-player-pnp-contest-entr) — Ready |   |   |   |
|   | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 |   |   |   |
| 36 | [Up Front Browser Automa](https://boardgamegeek.com/thread/3512452) — Ready | [The Four Winds](https://boardgamegeek.com/thread/3595594) | [Pond Pals](https://boardgamegeek.com/thread/3563455/wip-pond-pals-2025-two-player-pnp-contest-digital) — Ready |   |   |   |
|   | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 |   |   |   |
| 37 | [Veteran Solo Mode](https://boardgamegeek.com/thread/3418473) — Ready | [The House Always Wins](https://boardgamegeek.com/thread/3581612) | [SubMerge](https://boardgamegeek.com/thread/3557308/wip-submerge-pnp-components-available-and-pcio-202) — Ready |   |   |   |
|   | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 |   |   |   |
| 38 | [War Against the Chtorr](https://boardgamegeek.com/thread/3471614) — Ready | [This Ol' Cowboy](https://boardgamegeek.com/thread/3615878) | [The Greatest Unknown Artist Beneath the Moonlight](https://boardgamegeek.com/thread/3568011/the-greatest-unknown-artist-beneath-the-moonlight) — Ready |   |   |   |
|   | L 🟢 · D 🔴 | L 🟢 · D 🔴 | L 🟢 · D 🔴 |   |   |   |
| 39 |   | [Train Trekker](https://boardgamegeek.com/thread/3613703) | [Under One Sky](https://boardgamegeek.com/thread/3436540/wip-under-one-sky) — Ready |   |   |   |
|   |   | L 🟢 · D 🔴 | L 🟢 · D 🔴 |   |   |   |
| 40 |   | [Trick Tac Foe](https://boardgamegeek.com/thread/3576027) | [Voidsmiths](https://boardgamegeek.com/thread/3544288/wip-voidsmiths-2025-two-player-print-and-play-desi) — Ready |   |   |   |
|   |   | L 🟢 · D 🔴 | L 🟢 · D 🔴 |   |   |   |
| 41 |   | [Undergrowth](https://boardgamegeek.com/thread/3577980) |   |   |   |   |
|   |   | L 🟢 · D 🔴 |   |   |   |   |
| 42 |   | [Winner Take All!](https://boardgamegeek.com/thread/3573345) |   |   |   |   |
|   |   | L 🟢 · D 🔴 |   |   |   |   |

#### Gruppo 3 di 4

| N. | [March–April 2025 — 24 Hour Design Challenge (REVEAL)](https://boardgamegeek.com/geeklist/355982/community-pnp-contests-and-winners) | [May–June 2025 — 24 Hour Design Challenge (GREEN)](https://boardgamegeek.com/geeklist/355982/community-pnp-contests-and-winners) | [November–December 2025 — 24 Hour Design Challenge (_ _ _ ANKS)](https://boardgamegeek.com/geeklist/355982/community-pnp-contests-and-winners) | [September–October 2025 — 24 Hour Design Challenge (PATCH)](https://boardgamegeek.com/geeklist/355982/community-pnp-contests-and-winners) | [The 2025 Roll & Write Game Design Contest](https://boardgamegeek.com/thread/3585125/the-2025-roll-and-write-game-design-contest) |
|---:|:---|:---|:---|:---|:---|
| **Classifica utilizzata per l'ordinamento delle Entry** | **ordine alfabetico** | **ordine alfabetico** | **ordine alfabetico** | **ordine alfabetico** | **Best Overall Game** |
| 1 | [Dungeon Encounter](https://boardgamegeek.com/thread/3473961/article/45765525#45765525) — Ready | [Cash Crop](https://boardgamegeek.com/thread/3510376/article/46069059#46069059) — Ready | [Ankhs before Isfet](https://boardgamegeek.com/thread/3607485/article/46858357#46858357) — Ready | [Autumn's Ghost](https://boardgamegeek.com/thread/3576315/article/46608341#46608341) — Ready | #1 [Rolling Fiefdoms](https://boardgamegeek.com/thread/3596654) — Ready |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🟢 · D 🟡 |
| 2 | [Intent](https://boardgamegeek.com/thread/3473961/article/45765525#45765525) — Ready | [Chlorophyllium](https://boardgamegeek.com/thread/3510376/article/46069059#46069059) — Ready | [Apothecaries & Quacks](https://boardgamegeek.com/thread/3607485/article/46858357#46858357) — Ready | [Berry Patch](https://boardgamegeek.com/thread/3576315/article/46608341#46608341) — Ready | #2 [Doodle Bash!](https://boardgamegeek.com/thread/3606967) — Ready |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🟢 · D 🟢 |
| 3 | [King's Claim](https://boardgamegeek.com/thread/3473961/article/45765525#45765525) — Ready | [Flag Finish](https://boardgamegeek.com/thread/3510376/article/46069059#46069059) — Ready | [Crank! Clank! Crank!](https://boardgamegeek.com/thread/3607485/article/46858357#46858357) — Ready | [Captain Plankwalker](https://boardgamegeek.com/thread/3576315/article/46608341#46608341) — Ready | #3 [The Leaning Tower of Pisa](https://boardgamegeek.com/thread/3613315) — Ready |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🟢 · D 🟡 |
| 4 | [Robotika](https://boardgamegeek.com/thread/3473961/article/45765525#45765525) — Ready | [Fruit Tumbler](https://boardgamegeek.com/thread/3510376/article/46069059#46069059) — Ready | [Gee, Thanks!](https://boardgamegeek.com/thread/3607485/article/46858357#46858357) — Ready | [Grandma's Quilts](https://boardgamegeek.com/thread/3576315/article/46608341#46608341) — Ready | #4 [Dawn Chorus](https://boardgamegeek.com/thread/3618849) — Ready |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🟢 · D 🔴 |
| 5 | [Shuffle & Sleuth](https://boardgamegeek.com/thread/3473961/article/45765525#45765525) — Ready | [Green Gold](https://boardgamegeek.com/thread/3510376/article/46069059#46069059) — Ready | [Lost Ranks](https://boardgamegeek.com/thread/3607485/article/46858357#46858357) — Ready | [Krak-in'](https://boardgamegeek.com/thread/3576315/article/46608341#46608341) — Ready | #4 [Mainframe: System Shutdown](https://boardgamegeek.com/thread/3617159) — Ready |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🟢 · D 🟢 |
| 6 | [What Happened?](https://boardgamegeek.com/thread/3473961/article/45765525#45765525) — Ready | [Green Thumb](https://boardgamegeek.com/thread/3510376/article/46069059#46069059) — Ready | [Pip Blanks](https://boardgamegeek.com/thread/3607485/article/46858357#46858357) — Ready | [Mishi's Bedtime](https://boardgamegeek.com/thread/3576315/article/46608341#46608341) — Ready | #6 [Natura](https://boardgamegeek.com/thread/3621278) — Ready |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🟢 · D 🟢 |
| 7 |   | [Shipmates](https://boardgamegeek.com/thread/3510376/article/46069059#46069059) — Ready | [Planks & Piers](https://boardgamegeek.com/thread/3607485/article/46858357#46858357) — Ready | [Patch Monsters](https://boardgamegeek.com/thread/3576315/article/46608341#46608341) — Ready | #7 [Ancient World](https://boardgamegeek.com/thread/3614076) — Ready |
|   |   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🟢 · D 🟡 |
| 8 |   | [Sustainibattle](https://boardgamegeek.com/thread/3510376/article/46069059#46069059) — Ready | [SHANKS](https://boardgamegeek.com/thread/3607485/article/46858357#46858357) — Ready | [Patch-22](https://boardgamegeek.com/thread/3576315/article/46608341#46608341) — Ready | #8 [Skyfall](https://boardgamegeek.com/thread/3600730) — Ready |
|   |   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🟢 · D 🟡 |
| 9 |   |   |   | [Picking Pumpkins](https://boardgamegeek.com/thread/3576315/article/46608341#46608341) — Ready | #9 [Vanguard Multi Asset Global Command](https://boardgamegeek.com/thread/3619638) — Ready |
|   |   |   |   | L 🔴 · D 🔴 | L 🟢 · D 🟢 |
| 10 |   |   |   | [Rough Patch: Motel Lives](https://boardgamegeek.com/thread/3576315/article/46608341#46608341) — Ready | #10 [Labyrinth of Shadows](https://boardgamegeek.com/thread/3584529) — Ready |
|   |   |   |   | L 🔴 · D 🔴 | L 🟢 · D 🟡 |
| 11 |   |   |   | [Veg Patch](https://boardgamegeek.com/thread/3576315/article/46608341#46608341) — Ready | [1899](https://boardgamegeek.com/thread/3600465) — Withdrawn |
|   |   |   |   | L 🔴 · D 🔴 | L 🟢 · D 🟡 |
| 12 |   |   |   | [Zero-Day Triage](https://boardgamegeek.com/thread/3576315/article/46608341#46608341) — Ready | [A Dragon's Die](https://boardgamegeek.com/thread/3607359) — Withdrawn |
|   |   |   |   | L 🔴 · D 🔴 | L 🟢 · D 🔴 |
| 13 |   |   |   |   | [City Lights](https://boardgamegeek.com/thread/3621048) — Withdrawn |
|   |   |   |   |   | L 🟢 · D 🟡 |
| 14 |   |   |   |   | [Compass & Ink](https://boardgamegeek.com/thread/3593066) — Ready |
|   |   |   |   |   | L 🟢 · D 🟢 |
| 15 |   |   |   |   | [Dicease Control: The 4.D-10 Pathogen](https://boardgamegeek.com/thread/3603070) — Ready |
|   |   |   |   |   | L 🟢 · D 🟡 |
| 16 |   |   |   |   | [Fortify!](https://boardgamegeek.com/thread/3615315) — Ready |
|   |   |   |   |   | L 🟢 · D 🟢 |
| 17 |   |   |   |   | [Fortune Script](https://boardgamegeek.com/thread/3621017) — Withdrawn |
|   |   |   |   |   | L 🟢 · D 🟡 |
| 18 |   |   |   |   | [INFRARED](https://boardgamegeek.com/thread/3593194) — Withdrawn |
|   |   |   |   |   | L 🟢 · D 🔴 |
| 19 |   |   |   |   | [Lithomacy](https://boardgamegeek.com/thread/3617600) — Ready |
|   |   |   |   |   | L 🟢 · D 🔴 |
| 20 |   |   |   |   | [Master of Thievery](https://boardgamegeek.com/thread/3620403) — Ready |
|   |   |   |   |   | L 🟢 · D 🟡 |
| 21 |   |   |   |   | [Necromancy: Roll Them Bones!](https://boardgamegeek.com/thread/3592805) — Withdrawn |
|   |   |   |   |   | L 🟢 · D 🔴 |
| 22 |   |   |   |   | [On the Trail of Bigfoot](https://boardgamegeek.com/thread/3592032) — Withdrawn |
|   |   |   |   |   | L 🟢 · D 🟢 |
| 23 |   |   |   |   | [On-LINE Kasino](https://boardgamegeek.com/thread/3619168) — Ready |
|   |   |   |   |   | L 🟢 · D 🟢 |
| 24 |   |   |   |   | [PIXIX](https://boardgamegeek.com/thread/3620811) — Withdrawn |
|   |   |   |   |   | L 🟢 · D 🟢 |
| 25 |   |   |   |   | [Ringleader](https://boardgamegeek.com/thread/3617946) — Withdrawn |
|   |   |   |   |   | L 🟢 · D 🟢 |
| 26 |   |   |   |   | [Roll & Pose](https://boardgamegeek.com/thread/3620499) — Withdrawn |
|   |   |   |   |   | L 🟢 · D 🟢 |
| 27 |   |   |   |   | [Rolling Parks](https://boardgamegeek.com/thread/3619248) — Ready |
|   |   |   |   |   | L 🟢 · D 🟢 |
| 28 |   |   |   |   | [Scribe](https://boardgamegeek.com/thread/3592781) — Withdrawn |
|   |   |   |   |   | L 🟢 · D 🟡 |
| 29 |   |   |   |   | [Spellwrights Codex](https://boardgamegeek.com/thread/3617539) — Ready |
|   |   |   |   |   | L 🟢 · D 🟢 |
| 30 |   |   |   |   | [STRATOS](https://boardgamegeek.com/thread/3592669) — Withdrawn |
|   |   |   |   |   | L 🟢 · D 🔴 |
| 31 |   |   |   |   | [The Legend of Whispervale](https://boardgamegeek.com/thread/3621367) — Ready |
|   |   |   |   |   | L 🟢 · D 🟡 |
| 32 |   |   |   |   | [The Thirteenth Dimension](https://boardgamegeek.com/thread/3595192) — Withdrawn |
|   |   |   |   |   | L 🟢 · D 🔴 |
| 33 |   |   |   |   | [Thieves of Bandervon](https://boardgamegeek.com/thread/3596433) — Ready |
|   |   |   |   |   | L 🟢 · D 🟡 |
| 34 |   |   |   |   | [U2: Flights of the Dragon Lady](https://boardgamegeek.com/thread/3585469) — Withdrawn |
|   |   |   |   |   | L 🟢 · D 🟢 |
| 35 |   |   |   |   | [Wizard's Tutelage](https://boardgamegeek.com/thread/3592976) — Withdrawn |
|   |   |   |   |   | L 🟢 · D 🔴 |
| 36 |   |   |   |   | [Word Builders](https://boardgamegeek.com/thread/3620974) — Ready |
|   |   |   |   |   | L 🟢 · D 🟡 |
| 37 |   |   |   |   | [Yadoya](https://boardgamegeek.com/thread/3618848) — Withdrawn |
|   |   |   |   |   | L 🟢 · D 🟢 |

#### Gruppo 4 di 4

| N. | Solomode Design Contest | Roll & Write Game Design Contest |
|---:|:---|:---|


### 2024

#### Gruppo 1 di 3

| N. | [54 Card Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Children & Family Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [In-Hand Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [January–February 2024 — 24 Hour Design Challenge (Jam)](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [July–August 2024 — 24 Hour Design Challenge (Rome)](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [March–April 2024 — 24 Hour Design Challenge (Three)](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) |
|---:|:---|:---|:---|:---|:---|:---|
| **Classifica utilizzata per l'ordinamento delle Entry** | **Best Overall Games** | **Best Family Game** | **BEST OVERALL MULTIPLAYER GAME** | **ordine alfabetico** | **ordine alfabetico** | **ordine alfabetico** |
| 1 | #1 [Flapjack Stacks / Kittens in Space](https://boardgamegeek.com/thread/3340312/wip-flapjack-stacks-kittens-in-space-a-light-weigh) | #1 [Joy's Bakery](https://boardgamegeek.com/thread/3281904/wip-joys-bakery-2-6-players-age-8-plus-20-25-mins) | #1 [... those who dig](https://boardgamegeek.com/thread/3192413/wip-those-who-dig-contest-ready) |   |   |   |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |   |   |
| 2 | #2 [The Fate Experiment](https://boardgamegeek.com/thread/3328329/wip-the-fate-experiment-2024-54-card-game-design-c) — Ready | #2 [Buffalo Buffalo Buffalo Buffalo Buffalo](https://boardgamegeek.com/thread/3247659/wip-buffalo-buffalo-buffalo-buffalo-buffalo-compon) | #2 [Ham-fisted](https://boardgamegeek.com/thread/3174617/wip-ham-fisted-1-3-players-15mins-puzzle-dexterity) |   |   |   |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |   |   |
| 3 | #3 [Banana Boy VS Uni-Cone](https://boardgamegeek.com/thread/3329754/now-on-sale-banana-boy-vs-uni-cone-2024-54-card-ga) | #3 [VLKNO](https://boardgamegeek.com/thread/3278336/vlkno-entry-for-bgg-2024-children-and-family-game) | #3 [Splitbrain](https://boardgamegeek.com/thread/3217309/wip-splitbrain-2-player-co-op-platformer-20-min-20) |   |   |   |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |   |   |
| 4 | #4 [Years Ago](https://boardgamegeek.com/thread/3329356/closed-years-ago-2024-54-card-game-design-contest) — Ready | #4 [Mushroom Mages](https://boardgamegeek.com/thread/3251700/wip-mushroom-mages-2-5p-6-plus-dice-rolling-set-co) | #4 [Hand On Fire](https://boardgamegeek.com/thread/3211882/wip-hand-on-fire-2024-in-hand-game-design-contest) |   |   |   |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |   |   |
| 5 | #5 [Rainbow Rumble](https://boardgamegeek.com/thread/3330241/wip-rainbow-rumble-2024-54-card-game-design-contes) — Ready | #5 [Bramblewood Bash](https://boardgamegeek.com/thread/3267995/wip-bramblewood-bash-contest-ready) | #5 [Composer's Cat](https://boardgamegeek.com/thread/3216056/wip-composers-cat-1-4p-15-45min-adjustable-difficu) |   |   |   |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |   |   |
| 6 | #6 [Astropuzzler](https://boardgamegeek.com/thread/3368451/wip-astropuzzler-2024-54-card-game-design-contest) — Ready | #6 [Alley Cat Ninjas](https://boardgamegeek.com/thread/3243385/alley-cat-ninjas) | #6 [Silent Night](https://boardgamegeek.com/thread/3215874/wip-silent-night-2024-in-hand-game-design-contest) |   |   |   |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |   |   |
| 7 | #7 [Nínive](https://boardgamegeek.com/thread/3369083/wip-ninive-2024-54-card-game-design-contest-contes) — Ready | #7 [Wallaby](https://boardgamegeek.com/thread/3259566/wip-wallaby-2024-children-and-family-game-design-c) | #7 [Super Battle Mon](https://boardgamegeek.com/thread/3177897/wip-super-battle-mon-2024-in-hand-game-design-cont) |   |   |   |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |   |   |
| 8 | #8 [Harper Has a Day](https://boardgamegeek.com/thread/3330362/wip-harper-has-a-day-solo-card-game-about-grief-54) — Components | #8 [Forbidden Finals](https://boardgamegeek.com/thread/3254258/wip-forbidden-finals-components-ready-an-entry-to) | #8 [ROUGHSHOT](https://boardgamegeek.com/thread/3212855/wip-roughshot-2024-in-hand-design-contest-componen) |   |   |   |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |   |   |
| 9 | #8 [Pax Feudalis](https://boardgamegeek.com/thread/3329951/wip-pax-feudalis-printandplay-resource-management) | #9 [Pixel Golf](https://boardgamegeek.com/thread/3228002/wip-pixel-golf-components-available) | [9-Card Moose Simulator](https://boardgamegeek.com/thread/3194590/wip-9-card-moose-simulator-1-plus-players-15-minut) — Disqualified |   |   |   |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |   |   |
| 10 | #8 [Starfall Command: Spaceship Duels](https://boardgamegeek.com/thread/3329517/wip-starfall-command-spaceship-duels-2024-54-card) — Ready | #10 [Geleé on tour!](https://boardgamegeek.com/thread/3276793/wip-gelee-on-tour-contest-ready-an-entry-to-the-20) | [a bird in the hand](https://boardgamegeek.com/thread/3202098/wip-a-bird-in-the-hand-ft-functional-tuckbox-in-ha) — Withdrawn |   |   |   |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |   |   |
| 11 | [13. The Visitor](https://boardgamegeek.com/thread/3340399/wipcontest-ready-the-visitor-a-trick-taking-bluffi) — Ready | #11 [Chariots of Dice](https://boardgamegeek.com/thread/3227038/wip-chariots-of-dice-4p-20min-pnp-components-avail) | [Alchemist Surplus](https://boardgamegeek.com/thread/3164059/alchemist-surplus-2024-in-hand-design-contest-comp) |   |   |   |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |   |   |
| 12 | [2024 54-Card Design Contest](https://boardgamegeek.com/thread/3334001/wip-2024-54-card-design-contest-ecliptic-2-player) — Components | #12 [Save the Moon-eyed Loris](https://boardgamegeek.com/thread/3281527/wip-save-the-moon-eyed-loris-2-4p-pnp-components-a) | [Animarathon](https://boardgamegeek.com/thread/3177055/wip-animarathon-2024-in-hand-game-contest) — Disqualified |   |   |   |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |   |   |
| 13 | [65 to Juneau](https://boardgamegeek.com/thread/3362671/65-to-juneau-entry-to-54-card-design-contest-compo) — Components | [Battle Hex](https://boardgamegeek.com/thread/3244974/battle-hex-an-entry-to-the-2024-children-and-famil) | [Deck-A-Tec](https://boardgamegeek.com/thread/3170876/wip-deck-a-tec-a-dexterity-and-card-throwing-game) |   |   |   |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |   |   |
| 14 | [Alliance](https://boardgamegeek.com/thread/3369196/wip-alliance-2024-54-card-game-design-contest-idea) — Withdrawn | [Birds vs Fey](https://boardgamegeek.com/thread/3276586/birds-vs-fey) | [Fiddle Sort](https://boardgamegeek.com/thread/3217543/fiddle-sort-contest-ready) |   |   |   |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |   |   |
| 15 | [Beast Friends For Ever!](https://boardgamegeek.com/thread/3366857/wip-beast-friends-for-ever-2024-54-card-game-desig) — Ready | [Build a Playground with Bill & Gary](https://boardgamegeek.com/thread/3238127/wipbuild-a-playground-with-bill-and-garyformerly-k) | [Fist Shuffle](https://boardgamegeek.com/thread/3209880/wip-fist-shuffle-2-players-18-cards-game-print-and) — Disqualified |   |   |   |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |   |   |
| 16 | [Blackjack Lite: An In-Hand Solo Card Game (Standard Deck)](https://boardgamegeek.com/thread/3329039/wip-blackjack-lite-an-in-hand-solo-card-game-stand) — Ready | [Dibs!](https://boardgamegeek.com/thread/3240744/wip-dibs-the-family-game-of-reading-minds-ranking) | [Glitch3D](https://boardgamegeek.com/thread/3176849/wip-glitch3d-2024-in-hand-game-contest) — Disqualified |   |   |   |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |   |   |
| 17 | [Captain Jack](https://boardgamegeek.com/thread/3346031/wip-captain-jack-2024-54-card-game-design-contest) — Components | [Fast Food](https://boardgamegeek.com/thread/3252876/wip-fast-food-cook-and-deliver-your-food-first-fam) | [Han D. Solo](https://boardgamegeek.com/thread/3196243/wip-hand-solo-2024-in-hand-pnp-components-ready) |   |   |   |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |   |   |
| 18 | [Cromix](https://boardgamegeek.com/thread/3364280/wip-cromix-2024-54-card-game-design-contest-contes) — Ready | [Finders Keepers](https://boardgamegeek.com/thread/3283122/wip-finders-keepers-1-4p-10-30-min-push-your-luck) | [Handy Man](https://boardgamegeek.com/thread/3196499/wip-handy-man-2024-in-hand-contest-components-read) |   |   |   |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |   |   |
| 19 | [Dragon Kingdoms](https://boardgamegeek.com/thread/3344859/wip-dragon-kingdoms-2024-54-card-game-design-conte) — Ready | [Karang Guni](https://boardgamegeek.com/thread/3267607/wip-karang-guni-component-ready-2024-children-boar) | [HavenwoodZ](https://boardgamegeek.com/thread/3171742/wip-havenwoodz-2024-in-hand-design-contest-contest) |   |   |   |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |   |   |
| 20 | [Fold 'em](https://boardgamegeek.com/thread/3356629/wip-fold-em-2024-54-card-game-design-contest-compo) — Components | [Mandai Tactics](https://boardgamegeek.com/thread/3271763/wip-mandai-tactics-2024-children-and-family-game-d) | [Heist](https://boardgamegeek.com/thread/3165563/heist-solo-puzzle-pnp-available) — Withdrawn |   |   |   |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |   |   |
| 21 | [Hunting Grounds](https://boardgamegeek.com/thread/3329475/hunting-grounds-entry-into-the-54-card-game-design) — Withdrawn | [Mother's Errands](https://boardgamegeek.com/thread/3267602/wip-mothers-errands-2024-children-and-family-games) | [In Davy's Grip](https://boardgamegeek.com/thread/3197852/wip-in-davys-grip-2024-in-hand-game-design-contest) — Withdrawn |   |   |   |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |   |   |
| 22 | [Kidnapping](https://boardgamegeek.com/geeklist/338815/2024-54-card-game-design-contest-entries?itemid=11080840#11080840) | [New Choice: Improv Your Life! 2.0](https://boardgamegeek.com/thread/3284087/wip-new-choice-improv-your-life-20-2-30-players-8) | [Innsmouth Investigator](https://boardgamegeek.com/thread/3177320/wip-innsmouth-investigator-2024-in-hand-game-desig) — Withdrawn |   |   |   |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |   |   |
| 23 | [Knick Knacks: Shaker Showdown (1-3p, 20-45 min, set collection game)](https://boardgamegeek.com/thread/3344314/wip-knick-knacks-shaker-showdown-1-3p-20-45-min-se) | [Number Explorers](https://boardgamegeek.com/thread/3253658/wip-number-explorers-a-space-adventure-2024-childr) | [Journey to the Core](https://boardgamegeek.com/thread/3190605/wip-journey-to-the-core-2024-in-hand-game-design-c) — Withdrawn |   |   |   |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |   |   |
| 24 | [Patron of the Arts](https://boardgamegeek.com/thread/3333551/wip-patron-of-the-arts-2024-54-card-game-design-co) — Ready | [SLAP Monster](https://boardgamegeek.com/thread/3255136/wip-slap-monster-a-slap-bracelet-game-2-4p-2024-ch) | [Monotheism](https://boardgamegeek.com/thread/3186311/wip-monotheism-2024-in-hand-game-design-contest-co) |   |   |   |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |   |   |
| 25 | [Qanqash: The Card Game](https://boardgamegeek.com/thread/3367678/wip-qanqash-the-card-game-54-card-game-design-cont) — Ready | [Squidbeard Island](https://boardgamegeek.com/thread/3253571/wip-squidbeard-island-a-treasure-hunting-game-2024) | [Obverse Configuration](https://boardgamegeek.com/thread/3186174/wip-obverse-configuration-12-card-puzzle-box-game) |   |   |   |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |   |   |
| 26 | [Rockin' Rivals](https://boardgamegeek.com/thread/3369447/wip-rockin-rivals-2024-54-card-game-design-contest) — Ready | [The Tortoise & The Hare](https://boardgamegeek.com/thread/3284076/the-tortoise-and-the-hare-entry-for-bgg-2024-child) | [Over Crest Rally](https://boardgamegeek.com/thread/3186458/wip-over-crest-rally-2024-in-hand-game-design-cont) |   |   |   |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |   |   |
| 27 | [Take your part!](https://boardgamegeek.com/thread/3368851/wip-take-your-part-2024-54-card-game-design-contes) — Ready | [Three Alarm Fire](https://boardgamegeek.com/thread/3260522/three-alarm-fire) | [Palmistry & Perils: A Fantasy RPG Handventure](https://boardgamegeek.com/thread/3183769/wip-palmistry-and-perils-2024-in-hand-game-design) — Disqualified |   |   |   |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |   |   |
| 28 | [The Last Conspiracy Theorist](https://boardgamegeek.com/thread/3369200/wip-the-last-conspiracy-theorist-2024-54-card-game) — Withdrawn | [Toastie Toss Smash](https://boardgamegeek.com/thread/3265982/wip-toastie-toss-smash-a-sandwich-making-speed-gam) | [Peeps Caught in a Mexican Standoff](https://boardgamegeek.com/thread/3184261/wip-peeps-caught-in-a-mexican-standoff-contest-rea) |   |   |   |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |   |   |
| 29 | [Twineheart](https://boardgamegeek.com/thread/3328936/wip-twineheart-2024-54-card-game-design-contest-id) — Withdrawn | [Woodland Maze](https://boardgamegeek.com/thread/3279229/woodland-maze) | [ROCK PAPER SCISSORS 2](https://boardgamegeek.com/thread/3187794/rock-paper-scissors-2-2-plus-players-2-mins-2024-i) |   |   |   |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |   |   |
| 30 | [Wuxia Showdown for the](https://boardgamegeek.com/thread/3368972/wuxia-showdown-for-the-2024-54-card-game-design-co) — Ready |   | [Rudiments](https://boardgamegeek.com/thread/3172444/wip-rudiments-2024-in-hand-contest-1p-20-30-min-tr) |   |   |   |
|   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 |   |   |   |
| 31 |   |   | [Strange World](https://boardgamegeek.com/thread/3170605/wipstrange-world-solo-5-min-2024-in-hand-contest-c) |   |   |   |
|   |   |   | L 🔴 · D 🔴 |   |   |   |
| 32 |   |   | [The Cursed Gauntlet](https://boardgamegeek.com/thread/3185508/wip-the-cursed-gauntlet-a-2024-in-hand-game-design) |   |   |   |
|   |   |   | L 🔴 · D 🔴 |   |   |   |
| 33 |   |   | [The Dreadheart](https://boardgamegeek.com/thread/3177166/wip-the-dreadheart-solo-no-table-needed-adventure1) |   |   |   |
|   |   |   | L 🔴 · D 🔴 |   |   |   |
| 34 |   |   | [Villain's Veil](https://boardgamegeek.com/thread/3175604/wip-villains-veil-2024-in-hand-game-contest) |   |   |   |
|   |   |   | L 🔴 · D 🔴 |   |   |   |
| 35 |   |   | [WizFist](https://boardgamegeek.com/thread/3200081/wip-wizfist-a-2-player-duelling-card-game-componen) — Disqualified |   |   |   |
|   |   |   | L 🔴 · D 🔴 |   |   |   |

#### Gruppo 2 di 3

| N. | [May–June 2024 — 24 Hour Design Challenge (Party)](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Nine Card Nanogame Print and Play Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [November–December 2024 — 24 Hour Design Challenge (Letter)](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [One Card Print and Play Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Roll & Write Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [September–October 2024 — 24 Hour Design Challenge (Trick)](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) |
|---:|:---|:---|:---|:---|:---|:---|
| **Classifica utilizzata per l'ordinamento delle Entry** | **ordine alfabetico** | **Best Overall Games** | **ordine alfabetico** | **BEST OVERALL GAME** | **BEST OVERALL GAME** | **ordine alfabetico** |
| 1 |   | #1 [Guards & Goblins](https://boardgamegeek.com/thread/3227901/wip-guards-and-goblins-2024-9-card-pnp-design-cont) — Ready |   | #1 [Picky Roaches](https://boardgamegeek.com/thread/3289592/closed-picky-roaches-2024-1-card-print-and-play-de) — Ready | #1 [Forest Floor](https://boardgamegeek.com/thread/3370315/wip-forest-floor-2024-roll-and-write-game-design-c) |   |
|   |   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |
| 2 |   | #2 [Habits](https://boardgamegeek.com/thread/3225462/wip-habits-2024-9-card-pnp-design-contest-ready) — Ready |   | #2 [Creak... Clink...Clang... Bang!](https://boardgamegeek.com/thread/3284072/wip-creak-clinkclang-bang-2024-1-card-pnp-design-c) — Ready | #2 [Legend Seeker](https://boardgamegeek.com/thread/3377794/wip-legend-seeker-2024-roll-and-write-game-design) |   |
|   |   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |
| 3 |   | #3 [SPORES](https://boardgamegeek.com/thread/3261913/wip-spores-2024-9-card-pnp-design-contest-contest) — Ready |   | #3 [DADOMON](https://boardgamegeek.com/thread/3306183/wip-dadomon-2024-1-card-print-and-play-design-cont) — Components | #3 [The Coffin Factory](https://boardgamegeek.com/thread/3377628/wip-the-coffin-factory-2024-roll-and-write-game-de) |   |
|   |   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |
| 4 |   | #4 [Logicards](https://boardgamegeek.com/thread/3224205/logicards-1-player-puzzle-5-minutes-2024-9-card-co) — Ready |   | #4 [Micromend](https://boardgamegeek.com/thread/3292380/post-contest-micromend-2024-1-card-print-and-play) | #4 [Rolling Slimes](https://boardgamegeek.com/thread/3378003/wip-rolling-slimes-2024-roll-and-write-game-design) |   |
|   |   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |
| 5 |   | #5 [The Cubes of Europe](https://boardgamegeek.com/thread/3265352/wip-the-cubes-of-europe-2024-9-card-nanogame-pnp-d) — Ready |   | #5 [Little Awesome Pyramid](https://boardgamegeek.com/thread/3310308/wip-little-awesome-pyramid-formerly-one-card-pyram) — Ready | #5 [Parkineers](https://boardgamegeek.com/thread/3378706/wip-parkineers-2024-roll-and-write-game-design-con) |   |
|   |   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |
| 6 |   | #6 [Nintle](https://boardgamegeek.com/thread/3266350/wip-nintle-2024-9-card-pnp-design-contest-componen) — Ready |   | #6 [U.F.Go](https://boardgamegeek.com/thread/3287645/wip-ufgo-2024-1-card-print-and-play-design-contest) | #6 [Our Favorite People](https://boardgamegeek.com/thread/3376172/wip-contest-ready-over-favorite-people-the-wedding) |   |
|   |   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |
| 7 |   | #7 [The Starspeaker](https://boardgamegeek.com/thread/3237752/wip-the-starspeaker-2024-9-card-nanogame-pnp-desig) — Ready |   | #7 [Word Wheel](https://boardgamegeek.com/thread/3288827/word-wheel-1-plus-players-puzzleword-game-5-min-20) | #7 [Wizard in training](https://boardgamegeek.com/thread/3366172/closed-wizard-in-training-2024-roll-and-write-game) |   |
|   |   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |
| 8 |   | #8 [Footfalls](https://boardgamegeek.com/thread/3260465/wip-footfalls-2024-9-card-pnp-design-contest-conte) — Ready |   | #8 [UFO: COW'EM ALL](https://boardgamegeek.com/thread/3309832/wip-ufo-cowem-all-2024-1-card-print-and-play-desig) — Ready | #8 [Gloop](https://boardgamegeek.com/thread/3356641/contest-ready-gloop-puzzley-roll-and-write-you-are) |   |
|   |   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |
| 9 |   | [234](https://boardgamegeek.com/thread/3267023/wip-234-2024-9-card-pnp-design-contest-ideas-phase) — Withdrawn |   | #9 [One Card Kursk](https://boardgamegeek.com/thread/3282414/one-card-kursk-1-2-players-20-minutes-2024-1-card) — Ready | #9 [Nib Quest: Mystery of the Hidden Grail Pen](https://boardgamegeek.com/thread/3369299/wip-nib-quest-mystery-of-the-hidden-grail-pen-cont) |   |
|   |   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |
| 10 |   | [9 CARDS AT 20 PACES](https://boardgamegeek.com/thread/3222831/wip-9-cards-at-20-paces-2024-9-card-pnp-design-con) — Ready |   | #10 [Fruits & Veggies](https://boardgamegeek.com/thread/3279815/wip-fruits-and-veggies-micro-pub-game-2024-1-card) | [270toWIN: Electoroll College](https://boardgamegeek.com/thread/3378030/270towin-electoroll-college-contest-ready) |   |
|   |   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |
| 11 |   | [Ancient Wars](https://boardgamegeek.com/thread/3266794/wip-ancient-wars-2024-9-card-nanogame-pnp-design-c) — Withdrawn |   | #11 [Fungi Grove](https://boardgamegeek.com/thread/3289758/wip-fungi-grove-2024-1-card-print-and-play-design) — Ready | [A Tour of the Realm](https://boardgamegeek.com/thread/3362245/wip-a-tour-of-the-realm-a-classic-travelling-game) |   |
|   |   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |
| 12 |   | [Bacteria Evolution](https://boardgamegeek.com/thread/3222234/wip-bacteria-evolution-2024-9-card-pnp-design-cont) — Ready |   | #12 [Pythagoras](https://boardgamegeek.com/thread/3307529/wip-pythagoras-2024-1-card-print-and-play-design-c) — Components | [Accordions](https://boardgamegeek.com/thread/3370462/wip-accordions-2024-rolln-write-design-contest-con) |   |
|   |   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |
| 13 |   | [Cannon War](https://boardgamegeek.com/thread/3265578/wip-cannon-war-2024-9-card-pnp-design-contest-cont) — Ready |   | #13 [Minitaur](https://boardgamegeek.com/thread/3302360/wip-pnp-files-available-minitaur-a-15-minute-solo) | [BlusterMon](https://boardgamegeek.com/thread/3359910/wip-blustermon) — Withdrawn |   |
|   |   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |
| 14 |   | [CHANGEBALL](https://boardgamegeek.com/thread/3255722/wip-changeball-2024-9-card-pnp-design-contest-cont) — Ready |   | #14 [Foxtrot](https://boardgamegeek.com/thread/3300509/wip-contest-ready-foxtrot-a-15-minute-strategy-dic) — Ready | [Boneyard](https://boardgamegeek.com/thread/3378056/wip-boneyard-a-domino-flip-and-write-game-2024-rol) |   |
|   |   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |
| 15 |   | [Clip-Its](https://boardgamegeek.com/thread/3224065/wip-clip-its-2024-9-card-pnp-design-contest-contes) — Ready |   | #15 [Rivers of ambition: An unnecesarily dramatic game of farmer's greed and crossing rivers. Now with flying carrots!!](https://boardgamegeek.com/thread/3307201/wip-rivers-of-ambition-an-unnecesarily-dramatic-ga) — Ready | [Brewfest Buzz](https://boardgamegeek.com/thread/3375409/wip-brewfest-buzz) — Withdrawn |   |
|   |   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |
| 16 |   | [DETECTIVE CASEBOOK](https://boardgamegeek.com/thread/3265737/wip-detective-casebook-2024-9-card-pnp-design-cont) — Withdrawn |   | #16 [PEACHBOY ATTACKS](https://boardgamegeek.com/thread/3297782/contest-ready-peachboy-attacks-2024-1-card-print-a) — Ready | [CIEL](https://boardgamegeek.com/thread/3378368/contest-ready-ciel-roll-and-write-contest-2024) |   |
|   |   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |
| 17 |   | [DIMUNY](https://boardgamegeek.com/thread/3242514/wip-dimuny-2024-9-card-pnp-design-contest-contest) — Ready |   | #17 [Pursuit of Madness](https://boardgamegeek.com/thread/3279395/wip-pursuit-of-madness-2024-1-card-print-and-play) — Ready | [Cosmic Delivery](https://boardgamegeek.com/thread/3378722/wip-cosmic-delivery-2024-roll-and-write-game-desig) |   |
|   |   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |
| 18 |   | [Elements](https://boardgamegeek.com/thread/3264417/wip-elements-1p-2-10-min-mostly-in-hand-deck-manag) — Ready |   | #18 [Page Mage](https://boardgamegeek.com/thread/3300957/wip-page-mage-2024-1-card-print-and-play-design-co) — Ready | [Crop Circles](https://boardgamegeek.com/thread/3361401/crop-circles-2024-roll-and-write-game-design-conte) |   |
|   |   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |
| 19 |   | [Ent rising](https://boardgamegeek.com/thread/3266529/wip-ent-rising-2024-9-card-pnp-design-contest-cont) — Ready |   | #19 [At the Mesas of Madness](https://boardgamegeek.com/thread/3279974/wip-at-the-mesas-of-madness-2024-1-card-pnp-design) — Ready | [Decathlon](https://boardgamegeek.com/thread/3360838/wip-decathlon-the-roll-and-write-2024-roll-and-wri) — Withdrawn |   |
|   |   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |
| 20 |   | [Fattest Bear Wins](https://boardgamegeek.com/thread/3266506/wip-fattest-bear-wins-2024-9-card-pnp-design-conte) — Withdrawn |   | #20 [Index Fusion](https://boardgamegeek.com/thread/3290349/index-fusion-2024-1-card-print-and-play-design-con) — Ready | [DEXAGONE-The Archipelago of 7 treasures](https://boardgamegeek.com/thread/3368706/wip-dexagone-the-archipelago-of-7-treasures-2024-r) — Withdrawn |   |
|   |   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |
| 21 |   | [Fin Feast](https://boardgamegeek.com/thread/3243277/wip-fin-feast-2024-9-card-pnp-design-contest-compo) — Withdrawn |   | [A Book To Die For: A Mind-Tearing Game for One Player](https://boardgamegeek.com/thread/3310331/wip-a-book-to-die-for-a-mind-tearing-game-for-one) — Components | [DJ Jimmy Shimmy](https://boardgamegeek.com/thread/3373020/wip-dj-jimmy-shimmy-2024-roll-and-write-design-con) |   |
|   |   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |
| 22 |   | [Fruit Delivery](https://boardgamegeek.com/thread/3220939/wip-fruit-delivery-2024-9-card-pnp-design-contest) — Ready |   | [Away M1ssion (Formerly Kn1ghts; formerly formerly Squared Away)](https://boardgamegeek.com/thread/3280524/wipaway-m1ssion-formerly-kn1ghts-formerly-formerly) — Components | [Draw n' Draw: Panel Crawler](https://boardgamegeek.com/thread/3361740/draw-n-draw-panel-crawler-2024-roll-and-write-desi) — Withdrawn |   |
|   |   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |
| 23 |   | [Gravio](https://boardgamegeek.com/thread/3225557/wip-gravio-2024-9-card-pnp-design-contest) — Ready |   | [Battle of Reflexes. A fun and fast 2-player game.](https://boardgamegeek.com/thread/3302727/wip-battle-of-reflexes-a-fun-and-fast-2-player-gam) | [Fire Mission WW2](https://boardgamegeek.com/thread/3369226/wip-fire-mission-ww2-2024-roll-and-write-game-desi) |   |
|   |   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |
| 24 |   | [Here There Be Dragons](https://boardgamegeek.com/thread/3236901/wip-here-there-be-dragons-2024-9-card-nanogame-pnp) — Withdrawn |   | [Boss Flip Demo](https://boardgamegeek.com/thread/3308109/wip-boss-flip-demo-contest-ready) — Ready | [Floriana](https://boardgamegeek.com/thread/3369617/wip-floriana-2024-roll-and-write-game-design-conte) |   |
|   |   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |
| 25 |   | [Heroes of a Minor Kingdom](https://boardgamegeek.com/thread/3235358/wip-heroes-of-a-minor-kingdom-2024-9-card-nano-des) — Withdrawn |   | [Call your number: One card roulette](https://boardgamegeek.com/thread/3309541/wipcall-your-number-one-card-roulette) | [Grasping Nettles](https://boardgamegeek.com/thread/3363206/wip-grasping-nettles-the-dice-game-2024-roll-and-w) — Withdrawn |   |
|   |   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |
| 26 |   | [Hickory Dickory Dock](https://boardgamegeek.com/thread/3227538/wip-hickory-dickory-dock-2024-9-card-nano-contest) — Withdrawn |   | [Dead in the Water](https://boardgamegeek.com/thread/3295624/wip-dead-in-the-water-fish-bait-1-card-print-and-p) | [Homesteaders](https://boardgamegeek.com/thread/3376698/wip-homesteaders-2024-roll-and-write-game-design-c) |   |
|   |   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |
| 27 |   | [Islote](https://boardgamegeek.com/thread/3266249/wip-islote-2024-9-card-pnp-design-contest-contest) — Ready |   | [Epic Grip](https://boardgamegeek.com/thread/3286810/epic-grip) | [House of Chance](https://boardgamegeek.com/thread/3360746/component-ready-house-of-chance-2024-roll-and-writ) |   |
|   |   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |
| 28 |   | [Kamaitachi](https://boardgamegeek.com/thread/3266950/wip-kamaitachi-2024-9-card-pnp-design-contest-cont) — Ready |   | [Escape Hunt](https://boardgamegeek.com/thread/3291348/wip-escape-hunt-2024-1-card-print-and-play-design) — Components | [Madnext](https://boardgamegeek.com/thread/3378060/component-ready-madnext-2024-roll-and-write-game-d) |   |
|   |   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |
| 29 |   | [King Johns Tournament](https://boardgamegeek.com/thread/3235103/wip-king-johns-tournament-2024-9-card-pnp-design-c) — Withdrawn |   | [Gods of the Shore](https://boardgamegeek.com/thread/3310330/wip-gods-of-the-shore-2024-1-card-print-and-play-d) — Ready | [RAD echoes](https://boardgamegeek.com/thread/3361998/paused-rad-echoes-a-post-apocalyptic-adventure) |   |
|   |   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |
| 30 |   | [Little Fairy Tale Hero for Nanogame](https://boardgamegeek.com/thread/3264245/little-fairy-tale-hero-for-nanogame-2024-9-card-pn) — Withdrawn |   | [Healing Paws](https://boardgamegeek.com/thread/3302384/wip-healing-paws-2024-1-card-print-and-play-design) — Ready | [Roll & Blight](https://boardgamegeek.com/thread/3377190/roll-and-blight-2024-roll-and-write-game-design-co) — Withdrawn |   |
|   |   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |
| 31 |   | [Little Investors](https://boardgamegeek.com/thread/3245287/wip-little-investors-2024-9-card-pnp-design-contes) — Ready |   | [History Heist](https://boardgamegeek.com/thread/3297833/wip-history-heist-1p-10-min-color-filter-reveal-pu) | [Roll through time](https://boardgamegeek.com/thread/3357009/wip-roll-through-time-contest-ready-roll-and-write) |   |
|   |   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |
| 32 |   | [Men on Mars](https://boardgamegeek.com/thread/3253941/wip-men-on-mars-2024-9-card-pnp-design-contest-com) — Withdrawn |   | [JUMP SHIP](https://boardgamegeek.com/thread/3300179/jump-ship-3-6-players-10-minutes-2024-1-card-print) — Ready | [Scuba Dice](https://boardgamegeek.com/thread/3374054/wip-scuba-dice-2024-roll-and-write-game-design-con) |   |
|   |   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |
| 33 |   | [Micro Stellar Conquest](https://boardgamegeek.com/thread/3266205/wip-micro-stellar-conquest-2024-9-card-nanogame-pr) — Ready |   | [King Crabber](https://boardgamegeek.com/thread/3296976/wip-king-crabber-2024-1-card-print-and-play-design) — Ready | [Stroll & Hike](https://boardgamegeek.com/thread/3360277/contest-ready-stroll-and-hike-rnw-about-making-a-n) |   |
|   |   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |
| 34 |   | [Monsters will die](https://boardgamegeek.com/thread/3227572/wip-monsters-will-die-contest-ready) — Ready |   | [Labyrinthio](https://boardgamegeek.com/thread/3304526/wip-labyrinthio-2024-1-card-print-and-play-design) | [The Labyrinth of Versailles](https://boardgamegeek.com/thread/3360606/wip-the-labyrinth-of-versailles-2024-roll-and-writ) |   |
|   |   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |
| 35 |   | [MORK BOARD](https://boardgamegeek.com/thread/3264484/wip-mork-board-into-the-dying-lands-2024-9-card-pn) — Ready |   | [LIMB-O](https://boardgamegeek.com/thread/3302536/wip-limb-o-a-silly-party-game-to-stretch-your-limb) | [Uncrossing Stars](https://boardgamegeek.com/thread/3376735/uncrossing-stars-a-solo-roll-and-write-survival-ga) |   |
|   |   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |
| 36 |   | [Naptime Nightmare](https://boardgamegeek.com/thread/3241351/wip-naptime-nightmare-2024-9-card-nanogame-design) — Withdrawn |   | [Massive Floating Supermarket: A Solo-One-Card Game](https://boardgamegeek.com/thread/3290234/wip-massive-floating-supermarket-a-solo-one-card-g) | [What Hides in the Dark](https://boardgamegeek.com/thread/3365896/wip-what-hides-in-the-dark-stand-by) — Withdrawn |   |
|   |   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |
| 37 |   | [Pulling Pirates](https://boardgamegeek.com/thread/3240485/wip-pulling-pirates-2024-9-card-pnp-design-contest) — Ready |   | [Navigate the Leviathan Sea](https://boardgamegeek.com/thread/3302007/wip-navigate-the-leviathan-sea-1-4-players-20-minu) | [What's Eating the Danish Prince?](https://boardgamegeek.com/thread/3364269/whats-eating-the-danish-prince-a-solo-crisis-manag) |   |
|   |   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |
| 38 |   | [Rainbow Creators {formerly The Machine}](https://boardgamegeek.com/thread/3257829/wip-rainbow-creators-formerly-the-machine-2024-9-c) — Withdrawn |   | [One-Card Siege. An asymmetrical 1v1 Siege face-off](https://boardgamegeek.com/thread/3302524/wip-one-card-siege-an-asymmetrical-1v1-siege-face) |   |   |
|   |   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 |   |   |
| 39 |   | [Skies of Arras](https://boardgamegeek.com/thread/3250065/wip-skies-of-arras-2024-9-card-pnp-design-contest) — Ready |   | [Pals](https://boardgamegeek.com/thread/3272801/wippals1-4-players-10-minutes2024-1-card-print-and) |   |   |
|   |   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 |   |   |
| 40 |   | [Slopestyle](https://boardgamegeek.com/thread/3262332/wip-slopestyle-2-3-players-a-9-cards-quick-and-exc) — Ready |   | [Sho’gloth snags some snacks](https://boardgamegeek.com/thread/3299978/wip-sho-gloth-snags-some-snacks-2024-1-card-design) — Components |   |   |
|   |   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 |   |   |
| 41 |   | [SPACERS STANDOFF](https://boardgamegeek.com/thread/3264009/wip-spacers-standoff-2024-9-card-pnp-design-contes) — Ready |   | [Smugglonauts ( formerly knwon as Market Rush)](https://boardgamegeek.com/thread/3307185/wip-smugglonauts-formerly-knwon-as-market-rush-202) |   |   |
|   |   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 |   |   |
| 42 |   | [Teddies and Terrors](https://boardgamegeek.com/thread/3265412/wip-teddies-and-terrors-2024-9-card-pnp-design-con) — Withdrawn |   | [Stomping Ground](https://boardgamegeek.com/thread/3302882/stomping-ground-1p15mins) |   |   |
|   |   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 |   |   |
| 43 |   | [The Big Bad](https://boardgamegeek.com/thread/3266711/wip-the-big-bad-2024-9-card-nanogame-print-and-pla) — Withdrawn |   | [The magic castle](https://boardgamegeek.com/thread/3289741/wip-the-magic-castle-concurso-de-diseno-de-impresi) — Ready |   |   |
|   |   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 |   |   |
| 44 |   | [The Fast Food Drive-Thru Dash](https://boardgamegeek.com/thread/3248461/wip-the-fast-food-drive-thru-dash-2024-9-card-pnp) — Ready |   | [The magic well](https://boardgamegeek.com/thread/3286340/wip-the-magic-well-concurso-de-diseno-de-impresion) — Ready |   |   |
|   |   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 |   |   |
| 45 |   | [Throne of Cubes](https://boardgamegeek.com/thread/3260261/wip-throne-of-cubes-2024-9-card-pnp-design-contest) — Ready |   | [Threadful Paws](https://boardgamegeek.com/thread/3299977/wip-threadful-paws-2024-1-card-design-contest-comp) — Components |   |   |
|   |   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 |   |   |
| 46 |   | [Tiger 825](https://boardgamegeek.com/thread/3237057/wip-tiger-825-2024-9-card-nanogame-pnp-design-cont) — Withdrawn |   | [Tic Tic BOOM!](https://boardgamegeek.com/thread/3305334/wip-tic-tic-boom-2024-1-card-print-and-play-design) — Components |   |   |
|   |   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 |   |   |
| 47 |   | [Titolo non osservabile](https://boardgamegeek.com/thread/3218618/2024-9-card-nanogame-print-and-play-design-contest) — Ready |   | [Town Square Tussle](https://boardgamegeek.com/thread/3303650/wip-town-square-tussle-2024-1-card-pnp-design-cont) |   |   |
|   |   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 |   |   |
| 48 |   | [Titolo non osservabile](https://boardgamegeek.com/thread/3218618/2024-9-card-nanogame-print-and-play-design-contest) — Withdrawn |   | [TRAP TEMPLE ROOM](https://boardgamegeek.com/thread/3299960/wip-trap-temple-room-2024-1-card-print-and-play-de) — Components |   |   |
|   |   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 |   |   |
| 49 |   | [Wereduck](https://boardgamegeek.com/thread/3263259/wereduck-pvp-for-9-card-pnp-design-contest) — Withdrawn |   | [Tree-Wreckoning](https://boardgamegeek.com/thread/3301384/wip-tree-wreckoning-2024-1-card-pnp-contest) |   |   |
|   |   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 |   |   |
| 50 |   | [Wizardry Wars](https://boardgamegeek.com/thread/3229096/wip-wizardry-wars-2024-9-card-pnp-design-contest-c) — Ready |   | [Wessex Harvest](https://boardgamegeek.com/thread/3296626/wip-wessex-harvest-2024-1-card-pnp-contest-entry-c) — Ready |   |   |
|   |   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 |   |   |

#### Gruppo 3 di 3

| N. | [Solitaire Print and Play Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Solo Mode Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Traditional Deck Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Two Player Print and Play Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Wargame Print and Play Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) |
|---:|:---|:---|:---|:---|:---|
| **Classifica utilizzata per l'ordinamento delle Entry** | **BEST OVERALL GAME** | **Best AI System** | **Best Game with Theme "Dream World"** | **Best game for date night** | **BEST OVERALL WARGAME** |
| 1 | #1 [Awaken the Ancients](https://boardgamegeek.com/thread/3305266/published-awaken-the-ancients-solitaire-mancala-ga) | #1 [Compact Mahjong Solo Variant](https://boardgamegeek.com/thread/3290793/2024-solomode-compact-mahjong-solo-variant-only-50) | #1 [Troll Forest](https://boardgamegeek.com/thread/3361905/2024-traditional-deck-game-design-contest-troll-fo) | #1 [Peep Spotting by ToToTam](https://boardgamegeek.com/thread/3241734/wip-peep-spotting-by-tototam-2024-2-player-pnp-con) — Ready | #1 [Israel 1948: The First Arab-Israeli War. (Entry for](https://boardgamegeek.com/thread/3347020/contest-ready-israel-1948-the-first-arab-israeli-w) — Ready |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |
| 2 | #2 [Whodunit In Your Pocket](https://boardgamegeek.com/thread/3316295/wip-whodunit-in-your-pocket-1p-15min-clue-inspired) — Ready | #2 [Solo Shuffle](https://boardgamegeek.com/thread/3294885/2024-solomode-solo-shuffle-a-scenario-based-solomo) | #2 [Alice's Nightmare](https://boardgamegeek.com/thread/3379753/wip-alices-nightmares-solitaire-2024-traditional-d) | #2 [Your New Tattoo (CONTEST READY](https://boardgamegeek.com/thread/3222546/wip-your-new-tattoo-contest-ready-2p-10-min-drawin) — Ready | #2 [Barricade Brigade](https://boardgamegeek.com/thread/3238256/wip-barricade-brigade-1p-60-90min-tower-defense-ad) |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |
| 3 | #3 [Sherlock Holmes: The Pocket Adventures](https://boardgamegeek.com/thread/3358548/wip-sherlock-holmes-the-pocket-adventures-2024-pnp) — Ready | #3 [Carcassonne against Jacques](https://boardgamegeek.com/thread/3288753/2024-solomode-carcassonne-against-jacques) | #3 [You See What I Must Dream](https://boardgamegeek.com/thread/3391112/you-see-what-i-must-dream-2-4-players-20-minutes-c) | #3 [Kundalini](https://boardgamegeek.com/thread/3233778/wip-kundalini-post-contest) | #3 [Barefoot to Glory!: Estigarribia's Western Chaco Campaign in 1934](https://boardgamegeek.com/geeklist/326943/2024-wargame-print-and-play-game-design-contest-en?itemid=10911382#10911382) |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |
| 4 | #4 [Cajun Cauldron](https://boardgamegeek.com/thread/3312376/wip-cajun-cauldron-2024-solitaire-print-and-play-d) — Ready | #4 [Capek](https://boardgamegeek.com/thread/3290545/2024-solomode-capek) | #4 [Jack's Nightmare](https://boardgamegeek.com/thread/3393631/wip-jack-s-nightmare-a-solo-puzzle-game-traditiona) | #4 [At the Wedding Table](https://boardgamegeek.com/thread/3244476/wip-at-the-wedding-table-2024-two-player-print-and) — Ready | #3 [Heralds of Defeat](https://boardgamegeek.com/geeklist/326943/2024-wargame-print-and-play-game-design-contest-en?itemid=10909337#10909337) |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |
| 5 | #5 [VaporTube](https://boardgamegeek.com/thread/3322016/wip-vaportube-2024-solitaire-pnp-design-contest-co) — Ready | #5 [Captain Blackwhisker](https://boardgamegeek.com/thread/3244422/2024-solomode-captain-blackwhisker-the-pirat-bot) | #5 [Night Dungeon](https://boardgamegeek.com/thread/3387624/wip-night-dungeon-2024-traditional-deck-game-desig) | #5 [Fireworks for the 4th (1-2p, 27-card, 10 min, real-time, cooperative game)](https://boardgamegeek.com/thread/3224707/wip-fireworks-for-the-4th-1-2p-27-card-10-min-real) | #4 [Plane Strider](https://boardgamegeek.com/thread/3378539/plane-strider-2024-wargames-pnp-competition-submis) |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |
| 6 | #6 [Q-Ra Code](https://boardgamegeek.com/thread/3318889/wip-q-ra-code-a-qr-code-manipulation-pen-and-paper) — Ready | #6 [Breeze](https://boardgamegeek.com/thread/3282756/2024-solomode-breeze) | [Abroad](https://boardgamegeek.com/thread/3414952/wip-abroad-2024-traditional-deck-game-design-conte) | #6 [Arcane Dice Machine](https://boardgamegeek.com/thread/3234434/contest-ready-arcane-dice-machine) — Ready | #5 [Henry Knox: Noble Train of Artillery](https://boardgamegeek.com/thread/3344304/wip-henry-knox-noble-train-of-artillery-2024-warga) — Components |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |
| 7 | #7 [The Devil. (Tarot Solitaire, 20 min.,](https://boardgamegeek.com/thread/3237101/wip-the-devil-tarot-solitaire-20-min-2024-solitair) — Ready | #7 [Sea Salt and Solo](https://boardgamegeek.com/thread/3171959/2024-solomode-sea-salt-and-solo) | [Bandit Guilds](https://boardgamegeek.com/thread/3389050/bandit-guilds-2024-traditional-deck-game-design-co) | #7 [SnacKing: A combat game where you eat snacks](https://boardgamegeek.com/thread/3221260/wip-snacking-a-combat-game-where-you-eat-snacks-20) | #6 [The Last Roar of the Lion](https://boardgamegeek.com/thread/3338124/wip-the-last-roar-of-the-lion-a-solitaire-postcard) |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |
| 8 | #8 [Growing Grounds](https://boardgamegeek.com/thread/3310410/closed-growing-grounds-2024-solitaire-print-and-pl) — Ready | #8 [Autopirate](https://boardgamegeek.com/thread/3269468/2024-solomode-autopirate-solomode-for-ahoy) | [Base of Spades](https://boardgamegeek.com/thread/3372614/wip-base-of-spades-solo-game-2024-traditional-deck) | #8 [Crystalline Creature Hunters](https://boardgamegeek.com/thread/3221720/contest-ready-crystalline-creature-hunters) — Ready | #7 [Warring States: China](https://boardgamegeek.com/thread/3293808/wip-warring-states-china-2024-wargames-pnp-competi) |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |
| 9 | #9 [The Ants & The Grasshopper (Children's Worker Placement Game For](https://boardgamegeek.com/thread/3320156/the-ants-and-the-grasshopper-childrens-worker-plac) — Ready | #9 [Adventurous Indiana](https://boardgamegeek.com/thread/3264548/2024-solomode-adventurous-indiana-for-artifacts-in) | [Beast Tamer](https://boardgamegeek.com/thread/3365277/wip-leafbearer-solo-mancala-playing-card-game) — Withdrawn | #9 [Get Crackin'](https://boardgamegeek.com/thread/3197126/wip-get-crackin-a-2-player-deduction-game-contest) — Ready | [A Conflict of Interest](https://boardgamegeek.com/thread/3367699/wip-a-conflict-of-interest-2024-wargame-print-and) — Components |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |
| 10 | #10 [Building Stonehenge](https://boardgamegeek.com/thread/3321481/wip-building-stonehenge-2024-solitaire-pnp-contest) — Ready | #10 [Coffee Rush Solo Mode](https://boardgamegeek.com/thread/3244337/2024-solomode-solo-mode-for-coffee-rush) | [Black◆Diamond](https://boardgamegeek.com/thread/3395585/blackdiamond-solo-10-min-2024-traditional-deck-con) | #10 [KAY OH!](https://boardgamegeek.com/thread/3228663/kay-oh-2024-two-player-print-and-play-game-design) — Ready | [Armored Counters](https://boardgamegeek.com/thread/3229624/wip-armored-counters-idea-phase-2024-wargame-conte) — Idea |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |
| 11 | #11 [Cheese Security, Inc.](https://boardgamegeek.com/thread/3310258/wip-cheese-security-inc-1p-15min-movement-puzzle-2) | [Autohunters](https://boardgamegeek.com/thread/3301580/2024-solomode-autohunters-a-lightweight-solo-mode) | [Cardbury](https://boardgamegeek.com/thread/3387202/wip-cardburysolitaire2024-traditional-deck-game-de) | [24 a micro trick taking game for 2 players](https://boardgamegeek.com/thread/3246790/wip-24-a-micro-trick-taking-game-for-2-players-two) — Ready | [Haitian Dawn](https://boardgamegeek.com/thread/3323580/wip-haitian-dawn-the-haitian-revolution-1791-1804) — Withdrawn |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |
| 12 | #12 [Roman Excavator](https://boardgamegeek.com/thread/3359663/wip-roman-excavator-1p-15-min-card-removal-scoring) | [Autosaurs!](https://boardgamegeek.com/thread/3288438/2024-solomode-autosaurs-add-automated-players-to-e) | [Chapel](https://boardgamegeek.com/thread/3360803/contest-ready-chapel-solitaire-puzzle-game-2024-tr) | [Aspire](https://boardgamegeek.com/thread/3224787/wipaspiretwo-player-game-design-contest-2024contes) — Ready | [Katipunan](https://boardgamegeek.com/thread/3352429/closed-katipunan-2024-wargame-print-and-play-game) — Ready |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |
| 13 | #13 [The Cat's Meow: Back in Business (a solitaire deckbuilding game,](https://boardgamegeek.com/thread/3300435/wip-the-cats-meow-back-in-business-a-solitaire-dec) — Ready | [Borgo Automa](https://boardgamegeek.com/thread/3301392/2024-solomode-borgo-automa-for-the-new-era-solo-pl) | [Checkmate in Your Pocket](https://boardgamegeek.com/thread/3358487/wip-checkmate-in-your-pocket-2024-traditional-deck) | [Begone!](https://boardgamegeek.com/thread/3137847/wip-begone-2-4-player-yokai-card-game-contest-read) — Ready | [Operation Rummy: The North Sea](https://boardgamegeek.com/thread/3347395/wip-operation-rummy-the-north-sea-2024-wargame-pri) — Withdrawn |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |
| 14 | #14 [‘TAKING SPACE’](https://boardgamegeek.com/thread/3312613/wip-taking-space-54-card-starcharting-pattern-layi) — Components | [Cat Factor and Bee Market](https://boardgamegeek.com/thread/3283876/2024-solomode-cat-factor-and-bee-market-variant-fo) | [Chowdah](https://boardgamegeek.com/thread/3361126/wip-chowdah-a-card-game-for-2-to-4-2024-traditiona) | [Chewmongus](https://boardgamegeek.com/thread/3221189/wip-chewmongus-2p-15mins-36-cardsrules-components) — Components | [USS Lox](https://boardgamegeek.com/thread/3231728/wip-uss-lox-2024-wargame-print-and-play-game-desig) |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |
| 15 | #15 [Runekin](https://boardgamegeek.com/thread/3348339/wip-runekin-2024-solitaire-pnp-contest-1p-45mins-d) — Ready | [Forest Shuffle Automa](https://boardgamegeek.com/thread/3299926/2024-solomode-unofficial-solo-mode-contest-entry) | [Commitment](https://boardgamegeek.com/thread/3375795/commitment-2-4p-card-battle-game-2024-traditional) | [Feral State Chapter 1. Solo/Co-op PnP Zombie Tactics Game.](https://boardgamegeek.com/thread/3218721/wip-feral-state-chapter-1-soloco-op-pnp-zombie-tac) |   |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |
| 16 | #16 [Rpage](https://boardgamegeek.com/thread/3353305/wip-rpage-the-lair-of-the-adorned-worm-1p-30min-pa) | [Frankly Simple Vikings SoloBot](https://boardgamegeek.com/thread/3284241/frankly-simple-vikings-solobot) | [Court of Deception](https://boardgamegeek.com/thread/3404884/wip-court-of-deception-card-game-2024-traditional) | [Gears of Gloristan](https://boardgamegeek.com/thread/3221287/wip-gears-of-gloristan-a-2p-semi-coop-factory-buil) — Idea |   |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |
| 17 | #17 [Touch the Moon (つ▀¯▀ )つ ☾ (1P, 10min)](https://boardgamegeek.com/thread/3312226/wip-touch-the-moon-tsu-tsu-1p-10min-mid-2024-solit) — Ready | [Harmonies: Solo Scenarios](https://boardgamegeek.com/thread/3286220/2024-solomode-harmonies-solo-scenarios) | [Crash Cars](https://boardgamegeek.com/thread/3363458/wip-crash-cars-the-ultimate-race-2024-traditional) | [Gladiators of Dice](https://boardgamegeek.com/thread/3218765/wip-gladiators-of-dice-2p-10min-pnp-component-avai) — Components |   |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |
| 18 | #18 [Scaffolding](https://boardgamegeek.com/thread/3300911/wip-scaffolding-1-player-20min-contest-ready-2024) — Ready | [Harmonies: Steve Automa](https://boardgamegeek.com/thread/3299923/2024-solomode-unofficial-solo-mode-contest-entry) | [Death to the Goblin King](https://boardgamegeek.com/thread/3371498/wip-death-to-the-goblin-king-2024-traditional-deck) | [Houdesca](https://boardgamegeek.com/thread/3234760/wip-houdesca-the-annual-houdini-escape-contest-202) |   |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |
| 19 | #19 [Minos](https://boardgamegeek.com/thread/3350336/minos-2024-solitaire-pnp-contest-contest-ready) — Ready | [Keyforge Adventures: Escape from Selva Oscura](https://boardgamegeek.com/thread/3278092/2024-solomode-keyforge-adventures-escape-from-selv) | [Depth Charges](https://boardgamegeek.com/thread/3396994/depth-charges-an-entry-into-the-2024-traditional-d) | [MANCALA FROGS](https://boardgamegeek.com/thread/3236511/mancala-frogs-2024-two-player-print-and-play-game) — Components |   |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |
| 20 | #20 [Sand Requiem](https://boardgamegeek.com/thread/3333729/wip-sand-requiem-in-hand-dungeon-crawler-2024-soli) | [Medina (Second Edition) Solomode](https://boardgamegeek.com/thread/3257849/2024-solomode-medina-second-edition-solomode) | [Diamond Mine](https://boardgamegeek.com/thread/3392447/wip-diamond-mine-competitive-card-game-for-1-4-pla) | [Piggies](https://boardgamegeek.com/thread/3241812/wip-piggies-2024-two-player-print-and-play-game-de) — Ready |   |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |
| 21 | [10 Minutes to Midnight](https://boardgamegeek.com/thread/3293731/wip-10-minutes-to-midnight-1p-10min-push-your-luck) | [My Octobot Teacher](https://boardgamegeek.com/thread/3301073/2024-solomode-my-octobot-teacher-unofficial-solomo) | [Digging Graves](https://boardgamegeek.com/thread/3360696/contest-readydigging-graves-casino-style-game-feat) | [Primary](https://boardgamegeek.com/thread/3225068/wip-primary-abstract-strategy-game-for-2-4-players) — Ready |   |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |
| 22 | [10-card Moose Evolution Simulator](https://boardgamegeek.com/thread/3310547/wip-10-card-moose-evolution-simulator-1-player-10) — Ready | [Neobot](https://boardgamegeek.com/thread/3300684/neotopia-unofficial-solo-mode-against-the-neobot) | [Final Trick](https://boardgamegeek.com/thread/3403008/wip-final-trick-2024-traditional-deck-game-design) | [The Floor is Llama](https://boardgamegeek.com/thread/3246504/wip-the-floor-is-llama-2p-co-op-dice-rolling-and-p) — Components |   |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |
| 23 | [A Perilous Road: an Anti-Tower Defense Game](https://boardgamegeek.com/thread/3351785/wip-a-perilous-road-an-anti-tower-defense-game-202) — Ready | [Non-Player Racers](https://boardgamegeek.com/thread/3288299/2024-solomode-non-player-racers) | [Grand Suit Slam](https://boardgamegeek.com/thread/3363668/withdrawn-wip-grand-suit-slam-2p-hand-court-manage) — Withdrawn | [Tipping Ice](https://boardgamegeek.com/thread/3243394/tipping-ice) |   |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |
| 24 | [Agent Down](https://boardgamegeek.com/thread/3320629/wip-agent-down-2024-solitaire-pnp-contest-contest) — Ready | [Ragtag Rescuers](https://boardgamegeek.com/thread/3272588/2024-solomode-ragtag-rescuers-a-mlem-space-agency) | [Gridiron Kings](https://boardgamegeek.com/thread/3361901/2024-traditional-deck-game-design-contest-gridiron) — Withdrawn | [Trust Issues](https://boardgamegeek.com/thread/3229320/wip-trust-issues-2024-two-player-pnp-game-design-c) |   |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |
| 25 | [Alpaca, Goat, Tiger, Crocodile](https://boardgamegeek.com/thread/3360861/wip-alpaca-goat-tiger-crocodile-working-title-2024) — Components | [Simple Six](https://boardgamegeek.com/thread/3123687/simple-six-solomode-for-rainforest-city) | [Hex](https://boardgamegeek.com/thread/3415500/wip-hex-fantasy-combat-for-two-2024-traditional-de) | [Undercharged](https://boardgamegeek.com/thread/3245724/wip-undercharged-2-player-10mins-2024-two-player-p) — Ready |   |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |
| 26 | [Arcane Engine](https://boardgamegeek.com/thread/3329390/wip-arcane-engine-2024-solitaire-print-and-play-de) — Components | [STARDUST](https://boardgamegeek.com/thread/3287913/mode-solo-2024-stardust-invaders-solo-mode-with-cd) | [House of Valois](https://boardgamegeek.com/thread/3396703/wip-house-of-valois-a-traditional-deck-game-design) — Withdrawn | [We are Hiring](https://boardgamegeek.com/thread/3231097/wip-we-are-hiring-2024-two-player-pnp-contest) |   |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |
| 27 | [Book Fair RulZ: a roll and write game,](https://boardgamegeek.com/thread/3332337/wip-book-fair-rulz-a-roll-and-write-game-2024-soli) — Components | [The Council of Naqala](https://boardgamegeek.com/thread/3267665/2024-solomode-five-tribes-the-council-of-naqala-v1) | [Huscarl](https://boardgamegeek.com/thread/3369620/huscarl-for-the-2024-traditional-deck-game-design) — Withdrawn | [When Worlds Collide (mint tin friendly)](https://boardgamegeek.com/thread/3221272/wip-when-worlds-collide-mint-tin-friendly-2-player) — Idea |   |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |
| 28 | [cityPOP!SKATEboard](https://boardgamegeek.com/thread/3360152/wip-citypopskateboard-1p-deck-building-hand-manage) | [Tritone Solo Mode](https://boardgamegeek.com/thread/3283558/2024-solomode-tritone-solo-mode) | [Look Ma No Hands](https://boardgamegeek.com/thread/3360805/wiplook-ma-no-hands-2024-traditional-deck-card-con) | [Butterflyzzz / Maripozazzz](https://boardgamegeek.com/thread/3246917/wip-butterflyzzz-maripozazzz-rules-and-components) — Components |   |
|   | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |
| 29 | [Dicepicking](https://boardgamegeek.com/thread/3332407/wip-dicepicking-components-available-solitaire-pnp) — Components |   | [Measure and Tempo](https://boardgamegeek.com/thread/3376640/measure-and-tempo-2p-pseudo-trick-taking-game-2024) | [Yokai Garden](https://boardgamegeek.com/thread/3244812/wip-yokai-garden-2024-two-player-print-and-play-ga) — Ready |   |
|   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 | L 🔴 · D 🔴 |   |
| 30 | [Dino Mites- an explosive skirmish movement puzzle game (for solo and multiplayer)](https://boardgamegeek.com/thread/3307556/wip-dino-mites-an-explosive-skirmish-movement-puzz) — Ready |   | [Mole](https://boardgamegeek.com/thread/3362089/wip-mole-2024-traditional-deck-game-design-contest) |   |   |
|   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 |   |   |
| 31 | [Elevator Operator](https://boardgamegeek.com/thread/3349426/wip-elevator-operator-2024-solitaire-print-and-pla) — Ready |   | [Packs Kingdoms](https://boardgamegeek.com/thread/3367319/wip-packs-kingdoms-2024-traditional-deck-game-desi) |   |   |
|   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 |   |   |
| 32 | [Eradication](https://boardgamegeek.com/thread/3350853/eradication-a-solo-jungle-war-game-2024-solitaire) |   | [Peak Warrior](https://boardgamegeek.com/thread/3400297/wip-2024-traditional-deck-game-design-contest-peak) |   |   |
|   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 |   |   |
| 33 | [Fleece The Hobbits](https://boardgamegeek.com/thread/3311993/wip-fleece-the-hobbits-2024-solitaire-pnp-contest) — Components |   | [Peek and Run](https://boardgamegeek.com/thread/3373080/peek-and-run-2024-traditional-deck-game-design-con) |   |   |
|   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 |   |   |
| 34 | [Florapunk 2](https://boardgamegeek.com/thread/3217580/wip-florapunk-2-solitaire-pnp-contest-2024-roll-an) — Components |   | [Petri-Fight](https://boardgamegeek.com/thread/3396449/2024-traditional-deck-game-design-contestrules-ava) — Withdrawn |   |   |
|   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 |   |   |
| 35 | [Grandfather](https://boardgamegeek.com/thread/3318209/wip-grandfather-2024-solitaire-pnp-contest-compone) — Components |   | [Puzzle Poker](https://boardgamegeek.com/thread/3360704/puzzle-poker-a-match-3-duel-w-solo-variant-2024-tr) |   |   |
|   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 |   |   |
| 36 | [Hieroglyph Historian](https://boardgamegeek.com/thread/3358045/wip-hieroglyph-historian-2024-pnp-solitaire-contes) — Ready |   | [Quarters](https://boardgamegeek.com/thread/3415510/wip-quarters-court-building-card-game-for-two-2024) |   |   |
|   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 |   |   |
| 37 | [Horizon](https://boardgamegeek.com/thread/3300812/wiphorizon-a-solitaire-safari2024-solitaire-game-d) — Components |   | [Quint](https://boardgamegeek.com/thread/3398513/wip-quint-2024-traditional-deck-game-design-contes) |   |   |
|   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 |   |   |
| 38 | [Impossible Mission](https://boardgamegeek.com/thread/3310210/wip-impossible-mission-2024-solitaire-pnp-contest) — Ready |   | [River Rats](https://boardgamegeek.com/thread/3360328/wip-river-rats-cooperative-card-game-for-1-4-playe) |   |   |
|   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 |   |   |
| 39 | [Junktions](https://boardgamegeek.com/thread/3317621/wip-junktions-2024-solitaire-pnp-contest-contest-r) — Ready |   | [RoboRummy](https://boardgamegeek.com/thread/3392975/wip-roborummy-2-5p-2024-traditional-deck-game-desi) |   |   |
|   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 |   |   |
| 40 | [LAUNDROLLMAT](https://boardgamegeek.com/thread/3318300/wip-laundrollmat-1p-20min-roll-and-write-dice-draf) — Components |   | [Roofs](https://boardgamegeek.com/thread/3361402/wip-roofs-2024-traditional-deck-game-design-contes) |   |   |
|   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 |   |   |
| 41 | [Marbelous Clouds](https://boardgamegeek.com/thread/3342264/wip-marbelous-clouds-1p-constrained-bidding-set-co) — Ready |   | [Seat and Eat](https://boardgamegeek.com/thread/3360483/2024-traditional-deck-game-design-contest-seat-and) |   |   |
|   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 |   |   |
| 42 | [Nature Trails Solo](https://boardgamegeek.com/thread/3308514/wip-nature-trails-solo-components-available-for-20) — Components |   | [Sinbad and the Seven Isles](https://boardgamegeek.com/thread/3380997/wip-sinbad-and-the-seven-isles-a-solitaire-game-wi) |   |   |
|   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 |   |   |
| 43 | [Outpost 47](https://boardgamegeek.com/thread/3311413/wip-outpost-47-2024-solitaire-pnp-design-contest) |   | [Snakeheads](https://boardgamegeek.com/thread/3381857/wip-snakeheads-its-species-invasion-time-in-the-la) |   |   |
|   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 |   |   |
| 44 | [Petryk: The beach balls game](https://boardgamegeek.com/thread/3318945/wip-petryk-the-beach-balls-game-1-2p-15min-roll-an) — Ready |   | [Snakes & Aces](https://boardgamegeek.com/thread/3375597/snakes-and-aces-a-hidden-ladder-climbing-for-3-4-b) — Withdrawn |   |   |
|   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 |   |   |
| 45 | [Plyndret](https://boardgamegeek.com/thread/3312577/wip-plyndret-1p-20-40m-2024-solitaire-pnp-contest) — Components |   | [Speculation](https://boardgamegeek.com/thread/3389642/wip-speculation-for-2-4-players-2024-traditional-d) |   |   |
|   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 |   |   |
| 46 | [Right of Rebel](https://boardgamegeek.com/thread/3310451/wip-right-of-rebel-2024-solitaire-print-and-play-d) — Components |   | [Starships](https://boardgamegeek.com/thread/3398263/wip-2024-traditional-deck-game-design-contest-rule) |   |   |
|   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 |   |   |
| 47 | [Roll and Robot](https://boardgamegeek.com/thread/3314081/wip-roll-and-robot-2024-solitaire-pnp-contest-cont) — Ready |   | [Suited for Battle](https://boardgamegeek.com/thread/3367152/wip-suited-for-battle-solitaire-playing-card-game) — Withdrawn |   |   |
|   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 |   |   |
| 48 | [Ruination Warlock](https://boardgamegeek.com/thread/3350347/wip-ruination-warlock-2024-solitaire-pnp-design-co) — Ready |   | [The Lost Library of Eryndor](https://boardgamegeek.com/thread/3365972/wip-the-lost-library-of-eryndor-2024-traditional-d) |   |   |
|   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 |   |   |
| 49 | [Set Swap](https://boardgamegeek.com/thread/3318900/wip-components-available-set-swap-36-card-set-crea) — Components |   | [Tripleto](https://boardgamegeek.com/thread/3408772/wip-tripleto-2024-traditional-deck-game-design-con) |   |   |
|   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 |   |   |
| 50 | [Solo PnP: S.O.S Insurance INC. (Naval rescue; dice-as-workers, memory, standard card deck) CONTEST READY](https://boardgamegeek.com/thread/3233893/wip-solo-pnp-sos-insurance-inc-naval-rescue-dice-a) — Ready |   | [Voleur](https://boardgamegeek.com/thread/3403308/wip-voleur-duel-card-game-2024-traditional-deck-ga) |   |   |
|   | L 🔴 · D 🔴 |   | L 🔴 · D 🔴 |   |   |
| 51 | [Starry Night](https://boardgamegeek.com/thread/3356623/wip-starry-night-1p-20-min-paper-and-pencil-2024-s) — Ready |   |   |   |   |
|   | L 🔴 · D 🔴 |   |   |   |   |
| 52 | [survival_protocol](https://boardgamegeek.com/thread/3353794/wip-survival-protocol-1p-deckbuilding-drafting-sci) |   |   |   |   |
|   | L 🔴 · D 🔴 |   |   |   |   |
| 53 | [Tandem Venit](https://boardgamegeek.com/thread/3322317/wip-tandem-venit-worker-placementcyoahorror-franke) |   |   |   |   |
|   | L 🔴 · D 🔴 |   |   |   |   |
| 54 | [The Brambles II](https://boardgamegeek.com/thread/3322461/wip-the-brambles-ii-rune-rituals-matrix-ritual-202) — Components |   |   |   |   |
|   | L 🔴 · D 🔴 |   |   |   |   |
| 55 | [The Debutante's Ball at Dramaton Hall](https://boardgamegeek.com/thread/3332767/wip-the-debutantes-ball-at-dramaton-hall-2024-soli) — Ready |   |   |   |   |
|   | L 🔴 · D 🔴 |   |   |   |   |
| 56 | [Three Gates](https://boardgamegeek.com/thread/3316338/wip-three-gates-2024-solitaire-pnp-contest-contest) — Ready |   |   |   |   |
|   | L 🔴 · D 🔴 |   |   |   |   |
| 57 | [Tranquility Blooms](https://boardgamegeek.com/thread/3218607/wip-tranquility-blooms-2024-solitaire-pnp-design-c) — Ready |   |   |   |   |
|   | L 🔴 · D 🔴 |   |   |   |   |


### 2023

#### Gruppo 1 di 4

| N. | [14th ROLL & WRITE GAME DESIGN CONTEST](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [15th ROLL & WRITE GAME DESIGN CONTEST](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [54-Card Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [April 2023 — 24 Hour Design Challenge (Terminal)](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Children & Family Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [February 2023 — 24 Hour Design Challenge (Outfit)](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) |
|---:|:---|:---|:---|:---|:---|:---|

#### Gruppo 2 di 4

| N. | [In-Hand Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [January 2023 — 24 Hour Design Challenge (Temperature)](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [July 2023 — 24 Hour Design Challenge (Host)](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [June 2023 — 24 Hour Design Challenge (Lobby)](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [March 2023 — 24 Hour Design Challenge (Fence)](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [May 2023 — 24 Hour Design Challenge (Leftover)](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) |
|---:|:---|:---|:---|:---|:---|:---|

#### Gruppo 3 di 4

| N. | [Nine Card Nanogame Print and Play Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [November–December 2023 — 24 Hour Design Challenge (Order)](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [One Card Print and Play Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [September–October 2023 — 24 Hour Design Challenge (Scatter)](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Solitaire Print and Play Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Solomode Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) |
|---:|:---|:---|:---|:---|:---|:---|

#### Gruppo 4 di 4

| N. | [Traditional Deck Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Two Player Print and Play Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Wargame Print and Play Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) |
|---:|:---|:---|:---|


### 2022

#### Gruppo 1 di 2

| N. | [11th ROLL & WRITE GAME DESIGN CONTEST](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [12th ROLL & WRITE GAME DESIGN CONTEST](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [13th ROLL & WRITE GAME DESIGN CONTEST](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [54-Card Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Children and Family Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [In-Hand Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) |
|---:|:---|:---|:---|:---|:---|:---|

#### Gruppo 2 di 2

| N. | [Nine Card Nanogame Print and Play Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [One Card Print and Play Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Solitaire Print and Play Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Traditional Deck Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Two Player Print and Play Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Wargame Print and Play Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) |
|---:|:---|:---|:---|:---|:---|:---|


### 2021

#### Gruppo 1 di 3

| N. | [10th ROLL & WRITE GAME DESIGN CONTEST](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [54-Card Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [6th ROLL & WRITE GAME DESIGN CONTEST](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [7th ROLL & WRITE GAME DESIGN CONTEST](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [8th ROLL & WRITE GAME DESIGN CONTEST](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [9 Card Nanogame Print and Play Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) |
|---:|:---|:---|:---|:---|:---|:---|

#### Gruppo 2 di 3

| N. | [9th ROLL & WRITE GAME DESIGN CONTEST](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [DTR Pewter Heroes Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [One Card Print and Play Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Solitaire Print and Play Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Solomode Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Traditional Deck Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) |
|---:|:---|:---|:---|:---|:---|:---|

#### Gruppo 3 di 3

| N. | [Two Player Print and Play Game Design](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Wargame Print and Play Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) |
|---:|:---|:---|


### 2020

#### Gruppo 1 di 4

| N. | [10th anniversary Christmas Print and Play Game contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [3rd ROLL & WRITE GAME DESIGN CONTEST](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [4th ROLL & WRITE GAME DESIGN CONTEST](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [54-Card Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [5th ROLL & WRITE GAME DESIGN CONTEST](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [9 Card Game Print and Play Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) |
|---:|:---|:---|:---|:---|:---|:---|

#### Gruppo 2 di 4

| N. | [April 2020 — 24 Hour Game Design Contest (home)](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [August 2020 — 24 Hour Game Design Contest (hoover)](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Children's Print and Play Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [December 2020 — 24 Hour Game Design Contest (advent)](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [February 2020 — 24 Hour Game Design Contest (palindrome)](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [January 2020 — 24 Hour Game Design Contest (eccentric)](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) |
|---:|:---|:---|:---|:---|:---|:---|

#### Gruppo 3 di 4

| N. | [July 2020 — 24 Hour Game Design Contest (dam)](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [June 2020 — 24 Hour Game Design Contest (beaver)](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [March 2020 — 24 Hour Game Design Contest (crown)](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [May 2020 — 24 Hour Game Design Contest (heart)](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [November 2020 — 24 Hour Game Design Contest (family)](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [October 2020 — 24 Hour Game Design Contest (orc)](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) |
|---:|:---|:---|:---|:---|:---|:---|

#### Gruppo 4 di 4

| N. | [One Card Print and Play Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Solitaire Print and Play Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Solomode Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Two Player Print and Play Game Design](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Video Stream Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Wargame Print and Play Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) |
|---:|:---|:---|:---|:---|:---|:---|


### 2019

#### Gruppo 1 di 4

| N. | [2nd ROLL & WRITE GAME DESIGN CONTEST](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [54-Card Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [9 Card Game Print and Play Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [April 2019 — 24 Hour Game Design Contest (electronics)](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [August 2019 — 24 Hour Game Design Contest (tag)](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Children's Game Print and Play Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) |
|---:|:---|:---|:---|:---|:---|:---|

#### Gruppo 2 di 4

| N. | [December 2019 — 24 Hour Game Design Contest (frost)](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [February 2019 — 24 Hour Game Design Contest (bureaucracy)](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [January 2019 — 24 Hour Game Design Contest (pitchfork)](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [July 2019 — 24 Hour Game Design Contest (sun)](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [June 2019 — 24 Hour Game Design Contest (miniature)](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [March 2019 — 24 Hour Game Design Contest (mask)](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) |
|---:|:---|:---|:---|:---|:---|:---|

#### Gruppo 3 di 4

| N. | [May 2019 — 24 Hour Game Design Contest (bug)](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [November 2019 — 24 Hour Game Design Contest (parody)](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [October 2019 — 24 Hour Game Design Contest (spirit)](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [One Page PnP Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Postcard Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [ROLL & WRITE GAME DESIGN CONTEST](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) |
|---:|:---|:---|:---|:---|:---|:---|

#### Gruppo 4 di 4

| N. | [September 2019 — 24 Hour Game Design Contest (school)](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Single Page Solo Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Solitaire Print and Play Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Two Player Print and Play Game Design](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Wargame Print and Play Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) |
|---:|:---|:---|:---|:---|:---|


### 2018

#### Gruppo 1 di 4

| N. | [54-Card Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [9-Card Nanogame Print and Play Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [April 2018 — 24 Hour Game Design Contest (egg)](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [August 2018 — 24 Hour Game Design Contest (clown)](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Children's Game Print and Play Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [December 2018 — 24 Hour Game Design Contest (rod)](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) |
|---:|:---|:---|:---|:---|:---|:---|

#### Gruppo 2 di 4

| N. | [February 2018 — 24 Hour Game Design Contest (technique)](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [January 2018 — 24 Hour Game Design Contest (hope)](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [July 2018 — 24 Hour Game Design Contest (heat)](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [June 2018 — 24 Hour Game Design Contest (queen)](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [League of Designers Workshop and Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [March 2018 — 24 Hour Game Design Contest (rune)](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) |
|---:|:---|:---|:---|:---|:---|:---|

#### Gruppo 3 di 4

| N. | [May 2018 — 24 Hour Game Design Contest (delay)](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Mint Tin Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [November 2018 — 24 Hour Game Design Contest (leaf)](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [October 2018 — 24 Hour Game Design Contest (eight)](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [September 2018 — 24 Hour Game Design Contest (bunny)](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Solitaire Print and Play Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) |
|---:|:---|:---|:---|:---|:---|:---|

#### Gruppo 4 di 4

| N. | [Starfarm! Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Summer 2018 Green Box of Games Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Two Player Print and Play Game Design](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [War Game Print and Play Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) |
|---:|:---|:---|:---|:---|


### 2017

#### Gruppo 1 di 4

| N. | [18 Card MicroGame Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [2 Player PnP Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [9-Card Nanogame Print and Play Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [April 2017 — 24 Hour Game Design Contest (puns)](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [August 2017 — 24 Hour Game Design Contest (procrastination)](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Children's Game Print and Play Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) |
|---:|:---|:---|:---|:---|:---|:---|

#### Gruppo 2 di 4

| N. | [December 2017 — 24 Hour Game Design Contest (reindeer)](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Eff the Rules Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [February 2017 — 24 Hour Game Design Contest (honey)](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Gamer Deck 1 Mechanics Design Challenge](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [January 2017 — 24 Hour Game Design Contest (discipline)](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [July 2017 — 24 Hour Game Design Contest (book)](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) |
|---:|:---|:---|:---|:---|:---|:---|

#### Gruppo 3 di 4

| N. | [June 2017 — 24 Hour Game Design Contest (nightfall)](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [March 2017 — 24 Hour Game Design Contest (march)](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [May 2017 — 24 Hour Game Design Contest (gold)](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Mint Tin Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [November 2017 — 24 Hour Game Design Contest (solo)](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [October 2017 — 24 Hour Game Design Contest (toy)](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) |
|---:|:---|:---|:---|:---|:---|:---|

#### Gruppo 4 di 4

| N. | [September 2017 — 24 Hour Game Design Contest (island)](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Solitaire Print and Play Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) |
|---:|:---|:---|


### 2016

#### Gruppo 1 di 4

| N. | [18 Card MicroGame Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [2 Player PnP Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [2016-17 Wargame Print and Play Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [9-Card Nanogame Print and Play Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [April 2016 — 24 Hour Game Design Contest (Atlantis)](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [August 2016 — 24 Hour Game Design Contest (wedding)](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) |
|---:|:---|:---|:---|:---|:---|:---|

#### Gruppo 2 di 4

| N. | [Children's Game Print and Play Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [December 2016 — 24 Hour Game Design Contest (charcoal)](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [February 2016 — 24 Hour Game Design Contest (beverages)](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [January 2016 — 24 Hour Game Design Contest (food)](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [July 2016 — 24 Hour Game Design Contest (moon landing)](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [June 2016 — 24 Hour Game Design Contest (kitten)](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) |
|---:|:---|:---|:---|:---|:---|:---|

#### Gruppo 3 di 4

| N. | [March 2016 — 24 Hour Game Design Contest (attention)](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [May 2016 — 24 Hour Game Design Contest (six)](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [MicroGame Print and Play Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Mint Tin Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [November 2016 — 24 Hour Game Design Contest (music)](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [October 2016 — 24 Hour Game Design Contest (pasta)](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) |
|---:|:---|:---|:---|:---|:---|:---|

#### Gruppo 4 di 4

| N. | [One Page PNP Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [September 2016 — 24 Hour Game Design Contest (divorce)](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Solitaire Print and Play Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) |
|---:|:---|:---|:---|


### 2015

#### Gruppo 1 di 4

| N. | [18 Card MicroGame Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [2015-16 Wargame Print and Play Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [April 2015 — 24 Hour Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [August 2015 — 24 Hour Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Badger Rainbow Deck Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Children's Game Print and Play Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) |
|---:|:---|:---|:---|:---|:---|:---|

#### Gruppo 2 di 4

| N. | [December 2015 — 24 Hour Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [February 2015 — 24 Hour Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [January 2015 — 24 Hour Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [July 2015 — 24 Hour Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [June 2015 — 24 Hour Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [M80 World Languages Card Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) |
|---:|:---|:---|:---|:---|:---|:---|

#### Gruppo 3 di 4

| N. | [March 2015 — 24 Hour Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [May 2015 — 24 Hour Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [MicroGame Print and Play Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Mint Tin Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [November 2015 — 24 Hour Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [October 2015 — 24 Hour Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) |
|---:|:---|:---|:---|:---|:---|:---|

#### Gruppo 4 di 4

| N. | [September 2015 — 24 Hour Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Solitaire Print and Play Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [The Pug Life Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Travel Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Two-Player PnP Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Wibbell++ Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) |
|---:|:---|:---|:---|:---|:---|:---|


### 2014

#### Gruppo 1 di 4

| N. | [18 Card MicroGame Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [April 2014 — 24 Hour Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [August 2014 — 24 Hour Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Card Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Classic Novel Microgame Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [December 2014 — 24 Hour Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) |
|---:|:---|:---|:---|:---|:---|:---|

#### Gruppo 2 di 4

| N. | [Dexterity Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Dice Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [February 2014 — 24 Hour Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [January 2014 — 24 Hour Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [July 2014 — 24 Hour Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [June 2014 — 24 Hour Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) |
|---:|:---|:---|:---|:---|:---|:---|

#### Gruppo 3 di 4

| N. | [March 2014 — 24 Hour Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [May 2014 — 24 Hour Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [MicroGame Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [November 2014 — 24 Hour Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [October 2014 — 24 Hour Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Randall's Dice Or No Dice Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) |
|---:|:---|:---|:---|:---|:---|:---|

#### Gruppo 4 di 4

| N. | [September 2014 — 24 Hour Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Solitaire Print and Play Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Two-Player Print-and-Play Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Unique Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) |
|---:|:---|:---|:---|:---|


### 2013

#### Gruppo 1 di 3

| N. | [April 2013 — 24 Hour Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [August 2013 — 24 Hour Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [December 2013 — 24 Hour Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [February 2013 — 24 Hour Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [In-A-Tin / Express Print-and-Play Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [January 2013 — 24 Hour Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) |
|---:|:---|:---|:---|:---|:---|:---|

#### Gruppo 2 di 3

| N. | [July 2013 — 24 Hour Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [June 2013 — 24 Hour Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [March 2013 — 24 Hour Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Mashup Game Design and Artwork Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [May 2013 — 24 Hour Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [November 2013 — 24 Hour Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) |
|---:|:---|:---|:---|:---|:---|:---|

#### Gruppo 3 di 3

| N. | [October 2013 — 24 Hour Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [PNP Hidden Role / Bluffing Card Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [PnP Postcard Game Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [September 2013 — 24 Hour Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Solitaire Print and Play Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Two Player PnP Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) |
|---:|:---|:---|:---|:---|:---|:---|


### 2012

#### Gruppo 1 di 2

| N. | [4 Year Old D12 Game Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Art and Game contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [August 2012 — 24 Hour Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [December 2012 — 24 Hour Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Gimme a Hand contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Historical Themed Board Game contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) |
|---:|:---|:---|:---|:---|:---|:---|

#### Gruppo 2 di 2

| N. | [July 2012 — 24 Hour Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [June 2012 — 24 Hour Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Mashup Game Design and Artwork Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [November 2012 — 24 Hour Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [October 2012 — 24 Hour Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Solitaire Print and Play Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) |
|---:|:---|:---|:---|:---|:---|:---|


### 2011

#### Gruppo 1 di 2

| N. | [10d12 Dice Game contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Easy Builds Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Four Poppels and Six Dice Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Iron Game Designer Challenge](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Little Box Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [One Page PnP contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) |
|---:|:---|:---|:---|:---|:---|:---|

#### Gruppo 2 di 2

| N. | [Quick Print and Play contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Solitaire Print and Play Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Synergy Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) |
|---:|:---|:---|:---|


### 2010

| N. | [Christmas Print and Play Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Confuse a Gamer Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Dicefest Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Many Monster Dice Game Competition](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Sneaky Sci-Fi Game Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) |
|---:|:---|:---|:---|:---|:---|


### 2009

| N. | [$1,000 Budget Design Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Co-Operative Game Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Four Cards or Tiles contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [PnP Dice contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Themed Rummy Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) | [Traditional Card Game Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) |
|---:|:---|:---|:---|:---|:---|:---|


### 2008

| N. | [BoardGameCreate Contest](https://boardgamegeek.com/geeklist/207777/community-pnp-contests-and-winners-2008-to-2024) |
|---:|:---|


<!-- END GENERATED ANNUAL PROGRESS -->

## Legenda

| Stato | Significato |
|---|---|
| `non iniziato` | Nessuna attività registrata nel perimetro indicato. |
| `in corso` | Attività aperta con lavorazione effettiva in corso. |
| `parziale` | Una parte del perimetro è verificata; la parte residua è nota o ancora da delimitare. |
| `completo` | Perimetro e criteri dichiarati sono soddisfatti alla data indicata. |
| `da aggiornare` | Esiste una copertura precedente, ma una nuova finestra di controllo è scaduta o imminente. |
| `bloccato` | È registrato un impedimento che richiede una decisione o un evento esterno. |
| `non applicabile` | Aspetto escluso esplicitamente dal perimetro della riga. |

Le percentuali misurano soltanto unità con copertura esplicitamente registrata. Non certificano completezza semantica dei dati e non trasformano record mancanti in assenze.

## Quadro sintetico

| Area | Stato | Evidenza corrente | Prossimo risultato verificabile | Riferimento |
|---|---|---|---|---|
| Perimetro e architettura | completo | Scope, modello operativo e separazione PnP/adiacenti formalizzati | Riesame solo se emerge un nuovo ciclo di vita | `PROJECT.md` |
| Contest ed entry | parziale | 306 contest e 951 entry nel database; censimento globale 2008–2026 finalizzato | Completare i censimenti annuali delle entry senza riaprire il censimento globale | database; registri globali in `sources/` |
| WIP e risorse dichiarate | parziale | 190/951 entry scansionate; 386 risorse e menzioni; Wargame 2026 completo 23/23 | Estendere la scansione tramite task per singolo contest | database; registri in `sources/` |
| Requisiti materiali | parziale | 190/951 entry scansionate; 387 requisiti; Wargame 2026 completo `first_post_only` | Completare il primo post e integrare le regole solo nei task dedicati | database; registri in `sources/` |
| Risultati e priorità | parziale | 1.054 osservazioni di classifica; risultati disponibili navigabili | Colmare risultati mancanti e definire la regola di priorità acquisizioni | database; app locale |
| Monitoraggio periodico | da aggiornare | Calendario presente; ultimo rilevamento registrato 2026-09-10 | Eseguire la prima finestra scaduta senza duplicare controlli giornalieri | `sources/MONITORING_CALENDAR.md` |
| Selezione e acquisizione | parziale | Primo lotto Kanare approvato e acquisito: 3 giochi, 3 PDF EN | Valutare un secondo lotto in un task separato | database; manifest Kanare; `library/README.md` |
| Integrità e versioni dei file | completo per il lotto | 3 originali immutati con URL, dimensione, MIME e SHA-256; 3 hash distinti | Ripetere lo stesso protocollo per ogni lotto futuro | schema; manifest Kanare; verificatore acquisizione |
| Consultazione locale | completo | Contest, entry, risorse, classifiche e sintesi navigabili in sola lettura | Miglioramenti solo sulla base di bisogni osservati | `app/` |
| Documentazione e tracciabilità | completo | PWS inizializzato, task auditabili e fonti separate | Aggiornare questo cruscotto alla chiusura di ogni incremento | `.workspace/PROJECT_STATE.md`; `tasks/` |

## Copertura per annualità

| Anno | Contest censiti | Entry censite | Scansioni WIP/risorse | Copertura risorse | Scansioni materiali | Copertura materiali | Stato annualità | Ultima verifica del quadro |
|---:|---:|---:|---:|---:|---:|---:|---|---|
| 2026 | 18 | 430 | 23 | 5,3% | 23 | 5,3% | contest importati; entry parziali; Wargame analizzato | 2026-10-02 |
| 2025 | 17 | 509 | 167 | 32,8% | 167 | 32,8% | roster completi: PnP 9/9 (384 entry), adiacenti 8/8 (125 entry) | 2026-10-04 |
| 2024 | 17 | 409 | 0 | 0,0% | 0 | 0,0% | PnP principali 10/10 (381 entry); adiacenti 1/7 (28 entry); limiti nominali espliciti | 2026-10-04 |
| 2023 | 21 | 0 | 0 | non avviata | 0 | non avviata | soli contest | 2026-09-18 |
| 2022 | 12 | 0 | 0 | non avviata | 0 | non avviata | soli contest | 2026-09-18 |
| 2021 | 14 | 0 | 0 | non avviata | 0 | non avviata | soli contest | 2026-09-18 |
| 2020 | 24 | 0 | 0 | non avviata | 0 | non avviata | soli contest | 2026-09-18 |
| 2019 | 23 | 0 | 0 | non avviata | 0 | non avviata | soli contest | 2026-09-18 |
| 2018 | 22 | 0 | 0 | non avviata | 0 | non avviata | soli contest | 2026-09-18 |
| 2017 | 20 | 0 | 0 | non avviata | 0 | non avviata | soli contest | 2026-09-18 |
| 2016 | 21 | 0 | 0 | non avviata | 0 | non avviata | soli contest | 2026-09-18 |
| 2015 | 24 | 0 | 0 | non avviata | 0 | non avviata | soli contest | 2026-09-18 |
| 2014 | 22 | 0 | 0 | non avviata | 0 | non avviata | soli contest | 2026-09-18 |
| 2013 | 18 | 0 | 0 | non avviata | 0 | non avviata | soli contest | 2026-09-18 |
| 2012 | 12 | 0 | 0 | non avviata | 0 | non avviata | soli contest | 2026-09-18 |
| 2011 | 9 | 0 | 0 | non avviata | 0 | non avviata | soli contest | 2026-09-18 |
| 2010 | 5 | 0 | 0 | non avviata | 0 | non avviata | soli contest | 2026-09-18 |
| 2009 | 6 | 0 | 0 | non avviata | 0 | non avviata | soli contest | 2026-09-18 |
| 2008 | 1 | 0 | 0 | non avviata | 0 | non avviata | soli contest | 2026-09-18 |
| **Totale** | **306** | **951** | **190** | **20,0% delle entry** | **190** | **20,0% delle entry** | **baseline contest importata** | **2026-10-02** |

La conclusione dell'esplorazione contest 2025 riguarda l'individuazione delle edizioni e il censimento delle entry, non implica che ogni WIP, risorsa o requisito materiale sia già stato esaminato.

## Completezza delle informazioni

| Oggetto informativo | Unità registrate | Denominatore utile | Stato | Criterio di completamento | Fonte del conteggio |
|---|---:|---:|---|---|---|
| Contest | 305 | Baseline globale 2008–2026 | importato e finalizzato; un'anomalia storica `unknown` documentata | Ogni edizione ha titolo, anno, stato prudenziale e fonte BGG | `contests`, `contest_sources` |
| Entry | 951 | Roster dei contest con censimento avviato | completo per le baseline concluse; dinamico per contest attivi | Ogni item autorevole riconciliato e stato preservato | `entries` |
| Scansioni WIP/risorse | 190 | 951 entry | parziale | Ogni entry ha un esito esplicito, incluso WIP non trovato o non osservabile | `entry_resource_scans` |
| Risorse dichiarate | 386 | Nessun denominatore certo | parziale | Ogni menzione è collegata a entry e fonte; nessuna destinazione esterna è presunta verificata | `remote_resources`, `entry_resource_mentions` |
| Scansioni materiali | 190 | 951 entry | parziale | Ogni entry ha copertura ed esito espliciti | `entry_material_scans` |
| Requisiti materiali | 387 | Nessun denominatore certo | parziale | Testo originale, normalizzazione, quantità e provenienza preservati quando osservabili | `entry_material_requirements` |
| Osservazioni di classifica | 1.054 | Dipende dalle categorie pubblicate | parziale | Risultati disponibili acquisiti senza fondere sistemi di voto incompatibili | `rankings` |
| Acquisizioni | 46 | Lotti Kanare, Children & Family e Roll & Write 2025; estrazione locale APP-005 senza nuove acquisizioni | completo per i lotti eseguiti | Ogni gioco acquisito ha decisione, fonte, condizioni e data | `acquisitions`; manifest Kanare e BGG |
| File acquisiti | 198 | 187 originali (3 Kanare, 38 Children & Family, 146 Roll & Write) e 11 contenuti estratti da due ZIP; uso personale esclusivo | completo per i lotti eseguiti, con limiti remoti espliciti | Dimensione, MIME, SHA-256 e provenienza per ogni file; ZIP e DOCX verificati strutturalmente | `acquired_files`; verificatori acquisizione |
| Titoli Kanare_Abstract | 64 giochi canonici conservativi, 76 record nativi, 39 prodotti e 54 implementazioni | Censimento Kanare del 2026-09-20; destinazioni verificate il 2026-09-21 | censimento completo sulle superfici autorizzate; destinazioni parzialmente verificate | 14 implementazioni `verified`, 40 `uncertain`; 10 matching confermati, 1 respinto e 15 ancora `candidate` | `catalog/verify_kanare_abstract_import.py`; task destinazioni |

## Pipeline operativa

| Fase | Input minimo | Output atteso | Stato complessivo | Controllo di qualità | Prossima azione |
|---:|---|---|---|---|---|
| 1. Scoperta contest | Pagine BGG autorevoli | Edizione candidata con fonte e data | baseline globale importata | Ricognizione finale e anomalie documentate | Verificare fonti dirette e stati ancora `unknown` |
| 2. Classificazione perimetro | Evidenza sul tipo di contest | `scope_type` e `treatment_profile` | completo per i contest noti | PnP autonomi separati dagli adiacenti | Riesame soltanto su nuova evidenza |
| 3. Censimento entry | Roster o fonte equivalente | Entry, gioco, stato originale e normalizzato | completo per baseline; dinamico sui contest attivi | Totali riconciliati con la fonte | Nuovi snapshot completi nei controlli periodici |
| 4. WIP e risorse dichiarate | Entry censita e primo post WIP | Esito scansione, menzioni e provenienza | parziale; Wargame 2026, 54-Card, Solitaire e Traditional Deck 2025 completi nei rispettivi perimetri MAT; Two-Player 2025: 39/40 completi, Parry non osservabile | Stati negativi distinti; URL identici deduplicati | Completare i contest non ancora scansionati con task separati |
| 5. Requisiti materiali | Primo post; regole solo se autorizzate | Requisiti originali e normalizzati | parziale | Copertura `first_post_only` distinta da `rules_integrated` | Proseguire insieme alla scansione WIP |
| 6. Risultati e segnali | Risultati BGG o segnale sostitutivo | Posizione, categoria, voto, ufficialità e fonte | parziale | Nessuna inferenza di vincitore senza posizione esplicita | Verificare contest conclusi con risultati incompleti |
| 7. Selezione acquisizioni | Priorità, disponibilità e condizioni applicabili | Decisione motivata per ciascun gioco | Tutte le entry Children & Family e Roll & Write 2025 selezionate esplicitamente | Segnali ufficiali distinti dai sostitutivi | Definire soglie generali soltanto prima di selezioni prive di risultati sufficienti |
| 8. Verifica host esterno | Entry selezionata e risorsa dichiarata | Osservazione di disponibilità | completata nei perimetri Children & Family e Roll & Write 2025 | Esiti su 27/27 e 37/37 entry; 61 verifiche di risorse Roll & Write; nessun aggiramento | Ripetere per ogni nuovo contest selezionato |
| 9. Acquisizione | Verifica positiva e condizioni compatibili | Record di acquisizione e file originale | parziale sul progetto; Kanare, Children & Family e Roll & Write trattati nei rispettivi perimetri | Roll & Write: 29 giochi, 146 file; una entry ristretta e sette senza risorsa dichiarata | Selezionare un altro singolo contest già analizzato |
| 10. Integrità e versioni | File acquisito | Manifest, hash e relazione tra versioni | completo per i primi lotti Kanare e BGG | Hash per ogni file; versioni precedenti preservate | Applicare lo stesso protocollo ai lotti futuri |
| 11. Consultazione e report | Database locale | App e output rigenerabili | completo per le funzioni correnti | Lettura SQLite in sola lettura; nessuna rete implicita | Evolvere solo con requisiti concreti |

## Attività operative aperte

Aggiornamento 2026-10-04, TSK-0015: concluso l'incremento richiesto sulla barra verde 2024, **10/10 PnP principali, 381 entry** (+352). Totale annuale 409; adiacenti invariati 1/7, 28 entry. L'enumerazione dei roster principali è completa, con due titoli 9-Card non osservabili e altri metadati assenti dichiarati nel rapporto `sources/2024-CORE-ROSTER-COMPLETION.md`. Prossimo approfondimento utile: MAT di un singolo contest 2024; sei challenge adiacenti da trattare in un successivo incremento BGG-A 2024, senza ampliamento silenzioso dell'obiettivo verde.

Aggiornamento 2026-10-04, TSK-0005: completati i sei roster delle 24 Hour Design Challenge 2025, **8/8 contest adiacenti attestati e 125 entry** complessive (+45). L'incremento conserva soltanto titolo, autore dichiarato, ordine e fonte del roster; classifiche, WIP e materiali sono esclusi. Il 2025 raggiunge 509 entry censite fra perimetro PnP e adiacente.

Questa tabella contiene soltanto attività non concluse che attraversano o seguono più task. I dettagli di esecuzione restano nei rispettivi `TASK.md`.

| Priorità | Attività | Stato | Motivo | Dipendenze | Prossimo passo | Riferimento |
|---:|---|---|---|---|---|---|
| 1 | Completare il censimento globale dei contest PnP BGG | completo; aggiornamento del 2 ottobre | 306 contest importati, incluso il nuovo Roll & Write 2026; una anomalia storica `unknown` documentata; integrità SQLite verificata | Skill BGG; indici comunitari; forum | Passare ai task annuali, per contest o di monitoraggio; aggiornare il censimento se emerge un nuovo contest | `sources/BGG-PNP-CONTEST-GLOBAL-COVERAGE.md` |
| 2 | Proseguire il monitoraggio BGG per contest | in corso | Wargame 2026 controllato il 2 ottobre: submission chiuse, 23 entry e snapshot confrontabile completo; restano finestre scadute di altri contest | Calendario; accesso BGG | Eseguire task separati per le finestre scadute; prossimo Wargame il 12 novembre | `sources/MONITORING_CALENDAR.md`; `tasks/2026-10-02 - Monitoraggio - 2026 Print and Play Wargame Design Contest/TASK.md` |
| 3 | Introdurre Kanare_Abstract nel modello multifonte | primo lotto acquisito | Migrazioni 009-010 applicate; censimento completo; 3 PDF EN acquisiti; 15 matching ancora candidati | Censimento, manifest e verificatori Kanare | Valutare separatamente un secondo lotto oppure un controllo mirato dei matching residui | fonte e task Kanare |
| 4 | Completare WIP, risorse e materiali per singolo contest | parziale | Wargame 2026 completo 23/23; 9-Card 2025: 89/94 completi, 5 bloccati; 54-Card 2025 completo 28/28; Solitaire 2025 completo 74/74; Traditional Deck 2025 completo 42/42; Two-Player 2025: 39/40 completi e Parry non osservabile; 445/509 entry 2025 con scansione registrata, distinta dalla completezza (2026-10-05) | Skill BGG; task per singolo contest | MAT separato di un contest non ancora scansionato; riconciliare ElementaBrawl e approfondire Parry; eventuale ACQ di un singolo contest già analizzato dopo selezione | `sources/2026-WARGAME-MATERIALS.md`; `sources/2025-NINE-CARD-MATERIALS.md`; `sources/2025-54-CARD-MATERIALS.md`; `sources/2025-SOLITAIRE-MATERIALS.md`; `sources/2025-TRADITIONAL-MATERIALS.md`; `sources/2025-TWO-PLAYER-MATERIALS.md` |
| 5 | Consolidare la tassonomia delle risorse | parziale | Le categorie restano provvisorie fino al confronto trasversale 2025 | Completamento scansioni 2025 | Confrontare funzioni, forme tecniche ed evidenze | `PROJECT.md` |
| 6 | Definire la priorità di acquisizione | parziale | Per Children & Family 2025 è stato adottato il criterio dei vincitori ufficiali; mancano soglie generali quando voti o risultati non bastano | Risultati e segnali disponibili | Formalizzare soglie generali solo quando serviranno a una selezione ambigua | `PROJECT.md`; manifest Children & Family |
| 7 | Proseguire le acquisizioni selettive | Children & Family e Roll & Write 2025 trattati | Kanare: 3 giochi/3 PDF; Children & Family: 14 giochi/38 PDF; Roll & Write: 29 giochi/146 file, esiti su 37/37 entry | Nuova selezione esplicita per ogni contest | Prossima acquisizione suggerita: 1-Card 2025; recuperi remoti in incrementi separati | manifest dei tre perimetri; `library/README.md` |

APP-005, 2026-10-03: due ZIP estratti in 11 contenuti (10 PDF e 1 PNG), con hash e relazione archivio/contenuto. Originali invariati: 187 record e hash verificati. File totali 198; acquisizioni 46; nessun accesso esterno. I conteggi annuali di file includono i derivati e non indicano nuove risorse remote o completezza. Manifest: `catalog/archive_contents_batch_2026-10-03.json`.

TSK-0048, 2026-10-04: primi due incrementi delle skill conclusi; attivazione sistematica formalizzata; contenitore GPR aperto su richiesta, senza automazione. Inventario in sources/SKILL_INVENTORY.md; prossima manutenzione dopo esperienza verificata o bisogno ricorrente.

## Salute degli strumenti e della governance

| Componente | Stato | Ultima evidenza | Regola di manutenzione |
|---|---|---|---|
| Skill locali | base BGG e sei specialistiche verificate offline | 2026-10-04 TSK-0048: audit, inventario e procedura annuale entry distinta; applicazione delle skill pertinenti obbligatoria anche nelle riprese; nessuna nuova operazione esterna | Mantenere tramite GPR su richiesta; esperienze verificate, EPR per cambi contrattuali |
| Efficacia delle skill | protocollo prospettivo adottato | 2026-10-05 TSK-0069: verifica breve degli incrementi significativi e confronto offline con casi documentati; nessun collaudo operativo nuovo | TASK_GOVERNANCE.md; attestazione nel task sorgente, migliorie collegate a TSK-0048; nessun audit per invocazione o riesame retroattivo obbligatorio |
| Schema e migrazioni | completo | Migrazioni 001-011 presenti; 011 applicata all’operativo il 2026-10-03 dopo backup verificato | Ogni modifica passa da nuova migrazione numerata |
| Database operativo | completo | 306 contest BGG; 951 entry; 190 scansioni WIP/materiali, 386 risorse e 387 requisiti; 46 acquisizioni e 198 file registrati (187 originali, 11 contenuti ZIP); integrità e chiavi esterne verificate il 2026-10-03 | Non versionare; preservare cronologia e provenienza |
| Catalogo versionabile | destinazioni Kanare parzialmente verificate | 14 implementazioni verificate, 40 incerte; 15 matching candidati e un omonimo respinto | Mantenere separata la futura acquisizione selettiva |
| App locale | Libreria per gioco; lettori PDF/PNG/DOCX; APP-001–007 corrette | 2026-10-04 APP-007: DOCX formattato con immagini interne e caselle di testo, confronto Word, 40 test backend/45 frontend e browser 1400/390 px; limiti di impaginazione espliciti.  APP-005: 36 test backend e 43 frontend, Edge desktop/mobile su fixture e file reali, hash originali e idempotenza ZIP verificati; DOCX semantico senza impaginazione/immagini Word. 2026-10-03: APP-002 layout per orientamento e fit alla finestra verificati con 39 test frontend, 7 backend PDF ed Edge headless portrait/landscape/misti su desktop e mobile; screenshot esaminati. APP-001 verificata con 37 test frontend; categorie circoscritte al contest e precedenza overall. Libreria e primo visualizzatore PDF per ID; prove browser Children & Family/Kanare, tastiera e layout stretto; 29 test backend e 34 frontend; database e 41 hash invariati | PDF.js fissato e locale; mantenere confinamento, token/same-origin e assenza di rete esterna |
| Report tecnico contest | completo ma rigenerabile | `outputs/contest-monitoring-dashboard.md` | Rigenerare dal database; non trattarlo come fonte primaria |
| Calendario monitoraggio | aggiornato per Wargame | Rilevamento Wargame del 2026-10-02 registrato; altri contest mantengono finestre scadute separate | Aggiornare dopo ogni rilevamento dovuto; prossimo Wargame 2026-11-12 |
| Task auditabili | protocollo adottato; registro centrale disponibile | 2026-10-04: TASK_GOVERNANCE.md e tasks/REGISTRY.json formalizzano 44 registri, inclusi task corrente e copia immutata del Wargame sospeso; categorie, naming, modalità e versionamento separati; storia preservata | Riesaminare stati ambigui 2025/Kanare; proseguire 2024 nel task esistente; definire workflow immagini in task EPR distinto |
| Git/GitHub | finalizzazione Libreria e PDF su main autorizzata | 2026-10-03: partenza da main pulito e allineato a origin/main; branch codex/libreria-locale-materiali verificato; commit e push del branch autorizzati dall’utente, senza unione in main. Libreria committata e pubblicata con eb95408; nuovo branch codex/visualizzatore-pdf-locale autorizzato da tale base, commit, push e fast-forward in main del nuovo incremento autorizzati il 2026-10-03 | Commit, push e unione solo dopo autorizzazioni distinte dell'utente |
| Libreria nell’app locale | completo per PDF/PNG/DOCX idonei e ZIP estratti offline | 2026-10-03: APP-005; 198 file registrati, 46 acquisizioni; 11 contenuti ZIP con hash e provenienza; 187 originali invariati; DOCX semantico; Starter_Cards.pdf supera 128 MiB | Altri formati in task autonomi; preservare limiti e tracciabilità; hash PDF.js tramite `.gitattributes` |

## Registro degli aggiornamenti del cruscotto

- 2026-10-05 — TSK-0069: protocollo skill e raccordi committati in c023530 e pubblicati su origin/main; hash remoto verificato. Audit dei due commit in uscita senza rilievi, candidati preesistenti esclusi e revisione TSK-0066 aperta. Esito salvato in commit documentale successivo; altre modifiche locali preservate.

- 2026-10-05 — TSK-0069 EPR: adottata verifica obbligatoria dell’efficacia delle skill per nuovi incrementi significativi, comprese riprese storiche. Definiti criteri pratici, evidenze/causa/incertezze e confine manutenzione tecnica autonoma/evoluzione da deliberare; TSK-0048 resta contenitore aperto. Coerenza verificata offline su esempi locali, senza fonti esterne, acquisizioni o nuove prove dei workflow. Dati operativi invariati, sezioni A/B non rigenerate. Modifiche locali da committare, nessuna operazione Git autorizzata.

- 2026-10-04 — GPR Titoli compatti: eliminate da 11 chat le etichette operative già espresse da ACQ/MAT/BGG-M/BGG-G/BGG-A. Protocollo e registro aggiornati, storico preservato, documentazione ancora locale da committare. Evidenza: `tasks/2026-10-04 - Monitoraggio e classificazione dei task/CHAT_TITLE_SIMPLIFICATION.json`. Dati operativi invariati, sezioni annuali non rigenerate.

- 2026-10-04 — GPR Rinomina dei task: 38 chat con contenuto verificate, 36 rinominate e 2 già conformi (bootstrap incluso); codici di categoria e date originarie applicati, identificativi di segnalazione rimossi dai titoli APP. Registro centrale integrato con collegamenti e storico prima/dopo; 44 percorsi locali preservati. Evidenza: `tasks/2026-10-04 - Monitoraggio e classificazione dei task/CHAT_RENAMING.json`. Incremento documentale locale da committare; dati operativi e sezioni A/B invariati.

- 2026-10-04 — GPR Monitoraggio e classificazione dei task: protocollo adottato su richiesta dell'utente; registro centrale con 44 ID, classificazione storica datata e nuova convenzione dei titoli. Salvata copia immutata del TASK.md Wargame sospeso; nessuna acquisizione riattivata. PWS e dati operativi invariati, sezioni annuali non rigenerate. Evidenza: `TASK_GOVERNANCE.md`, `tasks/REGISTRY.json` e task corrente.

- 2026-10-04 — Monitoraggio e classificazione dei task: pre-analisi dei 43 registri preesistenti osservati, proposta di categorie e dimensioni degli stati; rilevato TASK.md Wargame sospeso solo in worktree e non tracciato. Regole e nomi storici invariati; nessun dato operativo modificato, sezioni A/B non rigenerate. Evidenza: `tasks/2026-10-04 - Monitoraggio e classificazione dei task/PRE_ANALISI.md`.

Confronto esteso nella stessa giornata: BGG 88/100 e Kanare_Abstract 48/100 aggiunte alla graduatoria con stato già integrato; PerGioco resta la prima nuova fonte suggerita. Dettaglio ed evidenze in `sources/MULTISOURCE-SOURCE-RANKING.md`.

Priorità nuove fonti al 2026-10-03: regolamenti completi gratuiti obbligatori per i giochi da integrare; PerGioco 70/100, itch.io gratuito e World of Abstract Games 68/100 guidano la graduatoria esplorativa. Nessuna nuova fonte importata. Metodo, sottopunteggi, esclusioni A PAGAMENTO e sospensioni sono in `sources/MULTISOURCE-SOURCE-RANKING.md`; prossimo incremento suggerito: censimento dedicato PerGioco.

| Data | Task | Modifica registrata | Evidenza |
|---|---|---|---|
| 2026-09-15 | Cruscotto avanzamento raccolta | Creato il quadro iniziale e aggiunte viste annuali generate per tipologia, contest e tutte le entry | Query in sola lettura al database; `app/generate_project_progress.py` |
| 2026-09-15 | Censimento globale contest PnP BGG | Avviata la ricognizione 2008–2026; estratti 191 record indice prima di deduplicazione ed espansione delle challenge brevi | `sources/BGG-PNP-CONTEST-GLOBAL-COVERAGE.md`; task dedicato |
| 2026-09-15 | Censimento globale contest PnP BGG | Espansi i meta-record in 127 challenge brevi e integrati i contest 2026 mancanti dalla GeekList; bacino preliminare successivamente corretto a 305 unità includendo Solomode 2026 | `sources/BGG-PNP-24H-CHALLENGES.md`; forum BGG |
| 2026-09-16 | Censimento globale contest PnP BGG | Estratti i titoli di 166/166 record storici e 26/26 elementi recenti; chiarito che i conteggi non sostituiscono il registro nominativo | GeekList BGG renderizzate; task dedicato |
| 2026-09-16 | Cruscotto avanzamento raccolta | Ordinato il censimento globale per anno decrescente ed estesa la sezione A al 2008–2026 in cinque gruppi di massimo quattro anni | `app/generate_project_progress.py`; database locale |
| 2026-09-16 | Cruscotto avanzamento raccolta | Ordinata la sezione B dal 2026 al 2008 e aggiunte tabelle di stato per le annualità non ancora importate, senza inventare entry | `app/generate_project_progress.py`; database locale |
| 2026-09-16 | Cruscotto avanzamento raccolta | Nella sezione A omesse le tipologie interamente vuote per gruppo; nella sezione B aggiunte intestazioni nominative dei contest in gruppi di massimo sei, senza righe di entry per i contest non importati | `catalog/bgg_contest_census_titles.json`; `app/generate_project_progress.py` |
| 2026-09-18 | Cruscotto navigabile nell'app | Integrata una vista annuale interattiva con accessi a contest, entry, classifiche, letture materiali e download; aggiunti filtri per anno e stato materiali | API SQLite in sola lettura; test backend e frontend dell'app |
| 2026-09-18 | Cruscotto navigabile nell'app | Adottata la veste grafica Pipeline per le annualità importate; aggiunto il conteggio delle entry presenti in almeno una classifica e raccolti separatamente gli anni non importati | API SQLite in sola lettura; 16 test backend e 18 frontend |
| 2026-09-18 | Censimento globale contest PnP BGG | Importata nel database la baseline deduplicata di 305 contest per 19 annualità; nessuna entry storica aggiunta | `catalog/global-contest-census.sql`; verifica su copia; integrità SQLite |
| 2026-09-18 | Censimento globale contest PnP BGG | Finalizzati quattro stati 2026; mantenuto `unknown` per l'anomalia storica 2018; escluse nuove discussioni e concorsi esterni non appartenenti al perimetro | `catalog/global-contest-census-finalization.sql`; controllo fonti BGG e calendario |
| 2026-10-02 | Censimento globale contest PnP BGG | Aggiunto il nuovo Roll & Write 2026 annunciato oggi; totale da 305 a 306, senza entry | Thread ufficiale BGG 3776341; `catalog/global-contest-census-2026-10-02.sql` |
| 2026-10-02 | Monitoraggio 2026 Wargame PnP | Registrati chiusura submission, roster completo di 23 entry, cinque nuove entry e due transizioni; snapshot confrontabile di stato, fasi e metriche | GeekList 369157; `catalog/2026-wargame-monitor-2026-10-02.sql`; task dedicato |
| 2026-10-02 | Analisi materiali 2026 Wargame PnP | Analizzati 23/23 primi post: 59 URL pertinenti in 18 entry, 5 `none_declared`, 48 requisiti in 12 entry; destinazioni esterne non aperte | `catalog/2026-wargame-materials.sql`; `sources/2026-WARGAME-MATERIALS.md`; task dedicato |
| 2026-09-18 | Standardizzazione esplorazioni BGG | Definiti cinque workflow non sovrapponibili; entry per anno, analisi e acquisizione per singolo contest, monitoraggio separato | `PROJECT.md`; `AGENTS.md`; skill BGG |
| 2026-09-20 | Censimento Kanare Abstract | Riconciliati indice opere, 39 prodotti e pagina Online Play; separati 64 candidati gioco/variante da prodotti, raccolte e accessori | `sources/KANARE-ABSTRACT-TITLE-CENSUS.md`; task dedicato |
| 2026-09-20 | Modello dati multifonte Kanare Abstract | Aggiunto e verificato il nucleo additivo per fonti, record nativi, prodotti, relazioni, risorse, implementazioni e crediti; nessun record Kanare importato | `database/migrations/009_multisource_catalog.sql`; task dedicato |
| 2026-09-20 | Importazione censimento Kanare Abstract | Applicata la migrazione 009 dopo backup verificato e importati 64 giochi, 58 record nativi, 39 prodotti, 56 relazioni prodotto–gioco, 28 implementazioni e 62 crediti; 26 matching ambigui restano `candidate` | `catalog/import_kanare_abstract.py`; `catalog/verify_kanare_abstract_import.py`; task dedicato |
| 2026-09-20 | Completamento censimento Kanare Abstract | Completati gli URL dei 39 prodotti e registrati 141 collegamenti dichiarati; 54 implementazioni attribuite a 9 piattaforme senza aprire destinazioni; 26 matching restano `candidate` | `catalog/enrich_kanare_abstract.py`; fonte e task dedicati |
| 2026-09-21 | Verifica destinazioni Kanare Abstract | Verificate 14 implementazioni; 40 mantenute incerte. Confermati 10 matching, respinto l'omonimo BGG `Ripples` e mantenuti 15 candidati | `catalog/verify_kanare_abstract_destinations.py`; fonte e task dedicati |
| 2026-09-21 | Acquisizione selettiva materiali Kanare Abstract | Acquisiti per uso personale 3 PDF EN ufficiali relativi a Pentwall, ViceVeresi e Chess Territorial; originali fuori Git con manifest, MIME, dimensioni e SHA-256 | manifest e verificatore acquisizione; task dedicato |
| 2026-10-02 | Interfaccia multifonte BGG e Kanare | Aggiunte vista comune Giochi, ricerca e filtri per fonte/ambiguità, scheda canonica e vista Kanare; preservate le viste specializzate BGG e il contratto offline/read-only | `app/`; 17 test backend e 23 frontend; fotografia del database operativo con hash verificato |
| 2026-10-03 | Acquisizione materiali Children & Family 2025 | Acquisiti 5 PDF originali relativi a ICBRG e Good Breeding; registrati 3 host disponibili e 2 link Zoo Rush scaduti; Pirate Treasures senza risorsa dichiarata verificabile | manifest, applicatore e verificatore dedicati; file locali con dimensioni e SHA-256 |
| 2026-10-03 | Completamento acquisizione Children & Family 2025 | Verificate tutte le 23 entry residue; acquisiti 33 PDF per 12 giochi e registrati gli esiti negativi, ristretti o parziali; totale contest 14 giochi e 38 PDF | secondo manifest; 26 osservazioni host; hash e database verificati |

| 2026-10-03 | Libreria locale nell’app | Aggiunta consultazione sicura di acquisizioni e file, filtri e schede gioco; 41 file presenti, nessuna modifica operativa | app; task Libreria; 22 test backend e 28 frontend |

| 2026-10-03 | Visualizzatore PDF locale | Lettore con pagine, zoom e ritorno; renderer vendorizzato, endpoint per ID protetto da sessione/same-origin e handle confinato; nessuna modifica ai dati | task PDF; 29 test backend e 34 frontend; browser BGG/Kanare e fixture di errore |

| 2026-10-03 | Acquisizione Roll & Write 2025 | 37 esiti entry, 29 acquisizioni e 146 file: 133 PDF, 7 PNG, 4 DOCX, 2 ZIP; 61 osservazioni remote; byte PDF.js preservati dopo conversione CRLF | manifest Roll & Write; hash, CRC, membri estratti e SQLite verificati; applicazione idempotente; task dedicato |

| 2026-10-03 | Categorie classifiche per contest | Chiusa APP-001: menu categorie per contest, precedenza overall e transizioni coerenti; dati invariati | task dedicato; 37 test frontend |

## Protocollo di manutenzione automatica

- 2026-10-04 — EPR TSK-0052: registrate in `PROJECT.md` due proposte collegate e non adottate, EPR-001 fasi/calendario BGG ed EPR-002 approfondimento WIP. Evidenze datate, alternative e decisioni aperte conservate; ricognizione storica, monitoraggio futuro e vista APP distinti. Registrazione documentale conclusa, nessuna rilevazione esterna, modifica dati/app o autorizzazione del pilota. Sezioni A/B invariate. Prossimo passo su richiesta: scegliere quale proposta valutare e deliberarne il contratto.

L'agente che esegue un incremento nel repository aggiorna questo file senza attendere una richiesta separata quando cambia almeno uno dei seguenti elementi:

- perimetro di contest o annualità;
- numero di contest, entry, scansioni, risorse, requisiti, risultati, acquisizioni o file;
- stato di una fase della pipeline o di un'attività operativa aperta;
- priorità, blocco, dipendenza o prossimo passo;
- stato di un componente strutturale o documentale.

L'aggiornamento deve avvenire nello stesso incremento che produce il cambiamento e prima della chiusura del relativo `TASK.md`. Deve inoltre:

1. rigenerare le sezioni A e B con `app/generate_project_progress.py` quando cambiano i dati da cui dipendono;
2. usare conteggi ottenuti dal database o da file autorevoli, mai stimati;
3. indicare data e provenienza dello stato;
4. preservare la distinzione tra non osservato, assenza verificata e non applicabile;
5. aggiornare solo le righe qualitative coinvolte, evitando di riscrivere lo storico esterno;
6. aggiungere una riga sintetica al registro degli aggiornamenti;
7. verificare coerenza con `PROJECT.md`, `.workspace/PROJECT_STATE.md` e `sources/MONITORING_CALENDAR.md` quando pertinenti.

Il cruscotto non viene aggiornato per una semplice rigenerazione di output che non modifica dati o stato. Se una misura è costosa o non ricavabile con affidabilità, si mantiene lo stato qualitativo e si registra il limite invece di inventare una percentuale.

- 2026-10-03 — Layout PDF per orientamento (APP-002): chiusa dopo prove frontend/backend e browser sintetico; nessuna modifica ai dati, sezioni annuali non rigenerate. Evidenza: `tasks/2026-10-03 - Layout PDF per orientamento/TASK.md`.

- 2026-10-03 — Contatore giochi Kanare (APP-003): chiusa; conteggio dinamico di 64 giochi canonici, aggiornato alla rilettura. 32 test frontend e verifica caricamento 2/0/1 superati; stile responsive esistente verificato strutturalmente. Dati invariati, sezioni annuali non rigenerate. Evidenza: `tasks/2026-10-03 - Contatore giochi Kanare/TASK.md`.

- 2026-10-03 — Righe compatte avanzamento BGG (APP-004): chiusa; risolta collisione della classe empty sugli indicatori zero. 41 test frontend/PDF; responsive verificato strutturalmente, senza prova visiva browser. Dati invariati, sezioni annuali non rigenerate. Evidenza: tasks/2026-10-03 - Righe compatte avanzamento BGG/TASK.md.

- 2026-10-04 — APP-006 contenuti e varianti Libreria: icone per funzione, descrizioni, nomi originali e legenda delle sigle; inferenze marcate e attributi ignoti omessi. 45 test frontend, 36 backend, Edge 1400/390 px e 198 hash verificati. Dati invariati, sezioni annuali non rigenerate. Evidenza: `tasks/2026-10-04 - Contenuti e varianti Libreria APP-006/TASK.md`.

- 2026-10-04 — APP-007 formattazione DOCX: stili, testo, paragrafi, elenchi, tabelle e PNG/JPEG interni; confronto visivo Word sui quattro originali, completezza e hash invariati, browser desktop/mobile e fixture. 40 test backend e 45 frontend superati. Database invariato, sezioni annuali non rigenerate. Evidenza: `tasks/2026-10-04 - Formattazione DOCX APP-007/TASK.md`. Prossimo passo utile: verifica utente del DOCX segnalato; impaginazione esatta Word richiederebbe un incremento distinto.

- 2026-10-04 — BGG-A Classifiche 2025 (TSK-0045): aperto contenitore continuativo su richiesta, estensione annuale deliberata. Baseline SQLite: PnP 207/384 (53,91%), adiacenti 40/80 (50,00%), totale 247/464 (53,23%); variazione 0. Priorità 9-Card (19/94); post ufficiale vincitori osservato in browser dopo verifica Cloudflare: 11 categorie già registrate, eventuali voti completi ancora da cercare. Dati operativi invariati, sezioni A/B non rigenerate. Evidenza: TASK.md e BASELINE.json del task; nessuna automazione.

- 2026-10-04 — TSK-0045 Classifiche 2025: prima verifica completa delle fonti ufficiali per 11/11 contest nel perimetro iniziale; 797 osservazioni già raccolte, nessun nuovo risultato recuperato. Copertura invariata: PnP 207/384 (53,91%), adiacenti 40/80 (50,00%), totale 247/464 (53,23%). Ritiri e liste top-N impediscono di assimilare la barra blu alla completezza della verifica; sei challenge 24h senza roster restano dipendenza. Contenitore aperto su richiesta; prossima ripresa su nuovi annunci/rettifiche. Evidenza: tasks/2026-10-04 - BGG-A - Classifiche BGG 2025/VERIFICA_2026-10-04.md. Dati invariati, A/B non rigenerate.

- 2026-10-04 — TSK-0046 Classifiche 2024: conclusa riconciliazione delle liste ufficiali di 11 contest; importati 869 risultati. PnP 225/381 (59,06%), adiacenti 14/28 (50%); confronto esplicito completato per tutte le 409 entry. Sei challenge senza roster escluse. Backup, integrità, chiavi esterne e importazione idempotente verificati. Evidenze nel task dedicato; sezioni A/B rigenerate. Prossimo approfondimento solo su nuove tabelle ufficiali/rettifiche.

- 2026-10-04 — APP-008 (TSK-0047): cinque barre di lavoro, metriche condivise, migrazione 012 e attestazioni locali. Classifiche 2025 verificate 384/384 PnP e 80/80 adiacenti, distinte da 207/40 entry classificate; roster attestati 9/9 e 2/8, sei challenge dipendenti. Materiali/acquisizioni distinguono completezza, N/A, ignoti e blocchi; immagini 0% non implementate. 45 test Python distinti, 46 frontend/PDF, browser 1400/390 px; righe originarie preservate e aggiunte TSK-0046 distinte. Sezioni A/B rigenerate dal database; nessuna nuova osservazione BGG. Evidenza: tasks/2026-10-04 - APP - Barre di completamento del lavoro/VERIFICATION.json.
- 2026-10-04 — APP-008, incremento correttivo TSK-0047: roster storici recuperati (2024 PnP 10/10; 2026 9/10 PnP e 7/8 adiacenti con limiti espliciti); classifiche 2026 132/356 complete e 12 parziali PnP, 21/74 adiacenti. Acquisizioni 2025 riconciliate con manifest: 39/363 complete PnP, 13 bloccate e 3 parziali; dati originari preservati. Box annuali allineati in alto a 15 px, desktop/mobile; 47 test Python e 46 frontend/PDF. Tutte le cinque fasi/annualità controllate e A/B rigenerate, nessun rilevamento BGG. Audit: tasks/2026-10-04 - APP - Barre di completamento del lavoro/HISTORY_AUDIT.md.

- 2026-10-04 — BGG-A 2025 (TSK-0005): censiti i sei roster ufficiali delle challenge GUARD, REVEAL, GREEN, PAD, PATCH e `_ _ _ ANKS`: 45 nuove entry, **8/8 contest adiacenti attestati e 125 entry**. Importazione offline idempotente verificata su copia e applicata al database operativo; integrità e chiavi esterne valide, zero classifiche e zero scansioni WIP/materiali introdotte. Sezioni A/B rigenerate. Evidenza: `catalog/2025-24h-challenge-rosters-verification-2026-10-04.json`.

- 2026-10-04 — MAT 9-Card Nanogame 2025 (TSK-0051): 94 esiti espliciti, 89 primi post completi e 5 blocchi; 208 URL distinti per gioco in 80 entry, 414 requisiti. WIP mancanti, post originale Three Buccaneers non osservabile e scissione ElementaBrawl distinti. Importazione additiva con backup, integrità, chiavi esterne, idempotenza e preservazione dei dati precedenti verificate; API e browser locali controllati, A/B rigenerate. Host esterni e download esclusi. Evidenza: `sources/2025-NINE-CARD-MATERIALS.md` e `tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/VERIFICATION.json`. Prossimo passo: riconciliazione roster e ACQ separato per lo stesso contest dopo selezione.

- 2026-10-05 — MAT 54-Card Game Design Contest 2025 (TSK-0053): 28/28 primi post originali censiti, 27 entry con risorse e Villains Incorporated senza URL dichiarato ma con componenti espliciti; 86 URL esatti, 89 menzioni e 46 requisiti. Importazione additiva con backup, fingerprint DOM URL/etichette, integrità, FK, isolamento e idempotenza verificati su copia e operativo; schede locali verificate. A/B rigenerate; 289/509 entry 2025 con scansione. Host e download esclusi. Evidenze: `sources/2025-54-CARD-MATERIALS.md`, TSK-0053/EVIDENCE.json e VERIFICATION.json. Prossimo passo: eventuale ACQ dello stesso contest dopo selezione; gratuità limitata alla durata contest dichiarata per Surfboard Stealin’ Sea Otters da verificare in ACQ. Commit 8de9833 e push main verificati sul server il 2026-10-05; esito registrato nel successivo commit documentale.

- 2026-10-05 — MAT Solitaire 2025 (TSK-0054): 74/74 primi post originali censiti; 71 entry con risorse, 236 URL distinti per gioco, 244 menzioni e 239 requisiti in 64 entry. Nan’s Heroes, Vicinity e Fairway Fantasy senza URL pertinente nel primo post; assenza di link distinta dall’assenza di requisiti. Importazione additiva verificata su copia e operativo, backup, integrità/FK, conservazione delle righe pregresse, isolamento e idempotenza; tutte le 74 righe locali mostrano lettura registrata. A/B rigenerate, 363/509 entry 2025 con scansione. Nessun host/file aperto o download. Evidenze: sources/2025-SOLITAIRE-MATERIALS.md e TSK-0054/EVIDENCE.json, VERIFICATION.json. Prossimo passo: ACQ dello stesso singolo contest dopo selezione dei giochi e verifica delle condizioni. Commit 7464101 e push main verificati sul server il 2026-10-05; esito nel successivo commit documentale.

- 2026-10-05 — MAT Traditional Deck 2025 (TSK-0055): 42/42 primi post originali completi, 38 entry con risorse, 53 URL esatti/menzioni e 54 requisiti in 37 entry. Quattro esiti senza URL con regole nel post; soundtrack, strumenti e manuali immagine distinti. Importazione su copia e operativo con backup, integrità/FK, isolamento, idempotenza e confronto DOM di URL/etichette/identità/evidenze verificati; API 42/42, browser su due pagine e tre casi. A/B rigenerate, 405/509 entry 2025 con scansione. Nessun host/file aperto o download; evidenze sources/2025-TRADITIONAL-MATERIALS.md e TSK-0055/VERIFICATION.json. Task concluso; commit a4affa9 e push main verificati sul server il 2026-10-05, esito nel successivo commit documentale. Prossimo passo: eventuale ACQ del solo Traditional Deck 2025 dopo selezione e verifica condizioni.

- 2026-10-05 — MAT Two-Player PnP 2025 (TSK-0056): 40 esiti espliciti, 39 primi post originali completi e Parry non osservabile; 87 URL, 95 menzioni, 131 requisiti in 34 entry. Trascrizioni URL/etichette/identità e roster 40/40 verificati; importazione su copia e operativo con backup, integrità/FK, idempotenza e isolamento. API 40/40 e scheda Parry verificate; A/B rigenerate, 445/509 entry 2025 con scansione. Nessun host/file aperto o download. Task concluso con blocco esplicito; commit e63fe64 e push main verificati sul server il 2026-10-05, esito nel successivo commit documentale. Prossimo passo: eventuale ACQ dello stesso singolo contest dopo selezione; recupero originale Parry o fonte alternativa autorizzata.

- 2026-10-05 — MAT GUARD 2025 (TSK-0058): 6/6 entry complete, cinque post originali (uno condiviso da due giochi), 4 entry con URL, 4 URL unici globali e 5 associazioni gioco–URL, 13 requisiti. Maroons and Doubloons e Handguards con regole nel post e nessun URL materiali. Importazione su copia e operativo con backup, integrità/FK, idempotenza, conservazione storia e isolamento verificati; API 6/6 e browser con sei letture registrate. A/B rigenerate, 470/509 entry 2025 con scansione registrata. Nessun host/file aperto o download. Evidenza: sources/2025-GUARD-MATERIALS.md e TSK-0058/VERIFICATION.json. Prossimo passo: eventuale ACQ del solo GUARD dopo selezione e verifica condizioni/host; incremento da committare su richiesta.

- 2026-10-05 — TSK-0059: avviato coordinamento di cinque MAT separati per REVEAL, GREEN, PAD, PATCH e ANKS 2025 (39 entry), TSK-0060–0064. Evidenze dedicate, integrazioni seriali e unico commit finale autorizzato; GUARD escluso perché completato. Nessun nuovo rilevamento in GPR.

- 2026-10-05 — TSK-0060 MAT REVEAL 2025: 6/6 entry complete, 11 URL e 18 requisiti dichiarati. Integrazione seriale TSK-0059 con backup/hash, integrità/FK, conservazione, isolamento e idempotenza verificati; API 6/6. A/B rigenerate. Host e file non aperti, nessun download. Commit finale del lotto in preparazione. Evidenza: TSK-0059/REVEAL_INTEGRATION.json.

- 2026-10-05 — TSK-0062 MAT PAD 2025: 5/5 entry complete, 5 URL per 4 giochi e 15 requisiti espliciti. Integrazione seriale TSK-0059 con backup/hash, integrità/FK, conservazione, isolamento e idempotenza verificati; API 5/5. A/B rigenerate. Nessun host/file aperto o download; commit finale del lotto in preparazione. Evidenza: TSK-0059/PAD_INTEGRATION.json.

- 2026-10-05 — TSK-0064 MAT ANKS 2025: 8/8 entry complete, 9 URL e 21 requisiti dichiarati. Rimando WIP Pip Blanks irrisolto distinto dalla presentazione originale completa; idee Planks & Piers non attestano requisiti finali. Integrazione TSK-0059 con backup/hash, integrità/FK, conservazione, isolamento, idempotenza e API 8/8 verificate; A/B rigenerate. Nessun host/file aperto o download. Evidenza: TSK-0059/ANKS_INTEGRATION.json.

- 2026-10-05 — TSK-0061 MAT GREEN 2025: 8/8 entry complete, 16 URL e 14 requisiti dichiarati. Fruit Tumbler: risorsa dichiarata, nessun requisito esplicito. Integrazione TSK-0059 con backup/hash, integrità/FK, conservazione, isolamento, idempotenza e API 8/8 verificate; A/B rigenerate. Nessun host/file aperto o download. Evidenza: TSK-0059/GREEN_INTEGRATION.json.

- 2026-10-05 — TSK-0063 MAT PATCH 2025: 12/12 entry complete, 12 URL per 10 giochi e 26 requisiti. Immagine Picking Pumpkins esclusa per assenza di istruzione esplicita di stampa. Integrazione TSK-0059 con backup/hash, integrità/FK, conservazione, isolamento, idempotenza e API 12/12 verificate; A/B rigenerate. Nessun host/file aperto o download. Evidenza: TSK-0059/PATCH_INTEGRATION.json.

- 2026-10-05 — TSK-0059: conclusi e integrati cinque MAT distinti TSK-0060–0064 (REVEAL, GREEN, PAD, PATCH, ANKS): 39/39 entry, 53 URL unici/associazioni e 94 requisiti. API e metriche 39/39, storia e altri contest preservati. Sei challenge 24h 2025 ora censite (45 entry incluso GUARD). Nel 2025 509/509 entry hanno scansione registrata, distinta da 495/509 complete, 10 bloccate e 4 senza attestazione completa. Commit finale del lotto in esecuzione, modifiche pregresse preservate; nessun push. Evidenza: TSK-0059/FINAL_VERIFICATION.json.

- 2026-10-05: TSK-0065 EPR aperto, brainstorming immagini rappresentative e uso nell'app. Workflow IMG da deliberare; nessun download o modifica delle metriche. Prossimo passo: concordare finalita e selezione.

- 2026-10-05: TSK-0065 aggiornato con requisiti immagini: raccolta di tutte le immagini utili, estrazioni MAN/PNP per componente e senza duplicati, selezione varianti superiori, Artwork/Titolo grafico/Icona, AI e futura skill dedicata. Codici provenienza e workflow ancora in discussione; nessuna acquisizione o implementazione.

- 2026-10-05: TSK-0065, provenienze leggibili e tassonomia immagini concordate con l'utente; categoria principale distinta da tag aggiuntivi e ruolo nell'app. Prossimo punto: naming. Workflow IMG complessivo e skill ancora da definire; nessuna implementazione.

- 2026-10-05: TSK-0065, naming immagini approvato (gioco, contest/anno o fonte, categoria, provenienza, numero stabile, versione). Prossimo punto: equivalenza e priorita delle varianti dei materiali. Nessuna acquisizione o implementazione.

- 2026-10-05: TSK-0065, criteri di selezione varianti approvati e requisito di tracciamento lacune per categoria per integrazione AI automatica su richiesta. Matrice e filtri da concordare; nessuna generazione, automazione ricorrente o implementazione.

- 2026-10-05: TSK-0065, copertura immagini per categoria approvata, conteggi originali/AI separati e Icona/Titolo grafico/Artwork desiderati per tutti i giochi. Prossimo punto: metodo di estrazione componenti. Nessuna implementazione o generazione.

- 2026-10-05: TSK-0065, procedimento estrazione componenti approvato: ritagli fedeli, lati collegati, deduplicazione con occorrenze, provenienza puntuale, verifica e scontorni separati. Prossimo punto: organizzazione libreria immagini. Nessuna estrazione eseguita.

- 2026-10-05: TSK-0065, struttura libreria immagini per gioco approvata con originali/estratti/ai/derivati e manifest separato versionabile. Prossimo punto: comportamento generazione AI su richiesta. Nessuna cartella binaria o generazione creata.

- 2026-10-05: TSK-0065, generazione AI iniziale tramite Codex su richiesta; app per lacune e risultati. Generazione direttamente nell'app tracciata come potenziale evoluzione APP autonoma. Revisione risultati ancora da concordare; nessuna implementazione.

- 2026-10-05: TSK-0065, validazione utente obbligatoria delle immagini AI approvata, anche per lotto; risultati Da valutare prima della adozione. Prossimo punto: presentazione immagini e scelta principale. Nessuna generazione o implementazione.

- 2026-10-05: TSK-0065, presentazione immagini app approvata: miniature nascondibili, galleria filtrabile, vista componenti, proposte AI separate, lacune e principale esplicita con fallback provvisorio Copertina/Setup. Prossimo punto: contratto operativo IMG. Nessuna implementazione.

- 2026-10-05: TSK-0065, perimetro IMG approvato per singolo contest/anno BGG e per Kanare con giochi espliciti; modello non esteso alle fonti future. Riprese incrementali, completamento per perimetro/data e AI facoltativa distinta. Prossimo punto: accessibilita e condizioni, poi workflow/skill.

- 2026-10-05: TSK-0065, esiti acquisizione e riferimenti senza file approvati; condizioni per rielaborazione AI distinte dalla acquisizione, con fonte/data. Prossimo punto: conservazione immagini scartate/superate, poi consolidamento workflow e skill.

- 2026-10-05: TSK-0065, conservazione storico immagini approvata: originali superati preservati, varianti inferiori non acquisite solo riferimenti, AI scartate conservate e fuori copertura; pulizia definitiva esplicita. Prossimo punto: contenuto skill dedicata e formalizzazione workflow.

- 2026-10-05: TSK-0065 completato: workflow IMG deliberato e promosso, skill game-image-acquisition installata con riferimenti fonti/estrazione/AI, routing e documenti autorevoli allineati. 14 controlli documentali locali riusciti; validatore standard limitato da PyYAML assente. Nessun lotto o implementazione immagini. Prossimi task separati: APP dati/consultazione e IMG pilota BGG o Kanare selezionato. PWS 1.5.0.

- 2026-10-05: TSK-0065, workflow/skill immagini committati in 986dd93 e inviati a origin/main; hash remoto verificato. Altre modifiche del workspace escluse dal commit, audit sui contenuti pubblicati senza rilievi.

## Progettazione supporto immagini — TSK-0067

TSK-0067, 2026-10-05: aperto APP Catalogazione e consultazione immagini dei giochi, fase brainstorming progressivo. Base TSK-0065 concluso; persistenza, manifest, UI e metriche da concordare prima dell'implementazione. Nessun codice, migrazione o lotto IMG avviato; metriche immagini invariate. Prossimo passo: discutere immagini a livello gioco e collegamenti a contesti specifici. Contratto in `tasks/2026-10-05 - APP - Catalogazione e consultazione immagini dei giochi/TASK.md`.

TSK-0067, integrazione 2026-10-05: raccolta per gioco approvata; preferenza sempre per la revisione più recente dello stesso materiale promossa in IMAGE_WORKFLOW.md. Originali/storico preservati e componenti unici recuperabili dalle revisioni precedenti; revisione materiale distinta da versione immagine. Nessuna implementazione o variazione delle metriche. Prossimo punto: identità e versioni immagini/componenti.

TSK-0067, decisione successiva 2026-10-05: approvati materiale e versione di origine nei dettagli delle immagini estratte, con segnalazione della revisione precedente. Prossimo punto di brainstorming: associazioni componente/lati e dorsi condivisi. Implementazione e metriche invariate.

TSK-0067, componenti 2026-10-05: approvati componenti distinti dalle immagini, associazioni dei lati per revisione e dorso condiviso senza duplicare file. Prossimo punto: importazione offline e riconciliazione manifest IMG. Nessun codice o dato operativo modificato.

TSK-0067, manifest 2026-10-05: approvato percorso manifest IMG → importatore offline con anteprima/backup/idempotenza/conflitti → database → app consultiva. Assenza dal manifest non elimina record; decisioni AI esplicite importate. Prossimo punto: copertura per categoria e filtri. Nessuna implementazione o variazione dati/metriche.

TSK-0067, copertura 2026-10-05: approvate tabella per categoria con ricerca/originali/AI approvate/proposte separate e filtri combinabili per lacune, ricerca incompleta e AI pendenti. Prossimo punto: scheda immagini, galleria e zoom. Metriche aggregate ancora da discutere; nessuna implementazione.

TSK-0067, scheda immagini 2026-10-05: approvate galleria adottata, componenti/lati affiancati, proposte AI separate, storico chiuso, zoom e dettagli di provenienza. Tabella copertura collegata ai filtri galleria. Prossimo punto: principale/fallback e miniature liste. Nessuna implementazione.

TSK-0067, principale 2026-10-05: approvati principale esplicita e fallback provvisorio Copertina/Setup/segnaposto, originali prioritari entro categoria, ordine stabile e miniature nascondibili. File principale mancante segnalato senza perdere la scelta. Prossimo punto: cronologia validazione AI e stato corrente. Implementazione/metriche invariate.

TSK-0067, AI e prerequisito 2026-10-05: approvate valutazione AI e uso corrente distinti, con decisioni storicizzate. L'utente richiede completamento di un task IMG contest 2025 prima dell'implementazione APP; contest/ID da collegare quando noti. Brainstorming continua, poi riesame dei manifest reali e piano prima del codice. Prossimo punto: file/formati e compatibilità Libreria. Nessuna implementazione.

TSK-0067, file 2026-10-05: approvati accesso locale per ID con protezioni Libreria, PNG/JPEG/WebP, altri formati catalogati con limite anteprima esplicito, miniature rigenerabili/caricate progressivamente e originali aperti per zoom. Prossimo punto: metriche ricerca e copertura. Prerequisito IMG 2025 invariato; nessun codice/dato operativo modificato.

TSK-0067, metriche 2026-10-05: utente indica denominatore entry controllate, comprese quelle senza immagini. Distinzione lavoro/copertura accettata; numeratore e significato di controllate da chiarire prima di deliberare la formula. Nessuna metrica operativa cambiata; implementazione subordinata a IMG 2025.

TSK-0067, chiarimento metriche 2026-10-05: controllate = ricerca conclusa. Concordata una sola barra/torta immagini; da provare tre segmenti (conclusa con immagini adottate, conclusa senza, non conclusa), percentuale principale concluse/totale entry. Tooltip distingue originali/AI approvate, pendenti escluse. Prossimo punto: migrazione/compatibilità e piano incrementi. Nessuna implementazione prima del completamento IMG 2025.

TSK-0067, migrazione 2026-10-05: approvata estensione additiva con collegamenti al catalogo/Libreria, nessuna conversione automatica PNG, importazione lotto reale su copia e compatibilità senza dati IMG. Proposta tre incrementi da confermare prima del riepilogo piano; implementazione attende IMG 2025.

TSK-0067, brainstorming concluso 2026-10-05: approvati tre incrementi (dati/importazione, scheda/file, liste/filtri/metriche), riepilogo decisioni nel TASK.md. APP resta aperto, nessuna implementazione; prossimo passo completare IMG contest 2025 e riesaminare manifest reale prima del primo incremento. Contest/ID del prerequisito ancora da comunicare. Generazione AI UI esclusa dalla fase iniziale.
