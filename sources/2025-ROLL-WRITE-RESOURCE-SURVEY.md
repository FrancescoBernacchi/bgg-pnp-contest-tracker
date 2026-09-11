# Sondaggio delle risorse Roll & Write 2025

## Scopo

Sondaggio metodologico del 10 settembre 2026 per definire quali collegamenti raccogliere durante l'esplorazione annuale dei contest. Il sondaggio non apre né scarica i materiali esterni.

## Distinzioni necessarie

Per ogni entry occorre distinguere almeno tre livelli:

1. la pagina di elenco o evidenza dell'entry nel contest;
2. il thread WIP dedicato su BoardGameGeek;
3. zero, una o più risorse dichiarate nel primo post del WIP.

Una risorsa dichiarata può essere un file diretto, una cartella, una pagina di distribuzione, un gioco nel browser o un modulo per un simulatore. La presenza del collegamento non dimostra che sia ancora raggiungibile; l'assenza nei risultati indicizzati non dimostra che il WIP sia privo di materiali.

## Campione

| Entry | WIP BGG | Quanto emerge dal primo post indicizzato | Esito del sondaggio |
|---|---|---|---|
| Rolling Fiefdoms | [thread 3596654](https://boardgamegeek.com/thread/3596654/wip-rolling-fiefdoms-2025-roll-and-write-contest-c) | Pagina gratuita aggiornata su [PnP Stash](https://pnpstash.com/product/rolling-fiefdoms/); collegamenti distinti dichiarati per rulebook, print sheet con varianti A4/US Letter e colore/low ink, solo challenges e versione online | Un WIP può esporre una risorsa corrente aggregata e più collegamenti storici o specializzati; servono ruolo, modalità di accesso e provenienza |
| Word Builders | [thread 3620974](https://boardgamegeek.com/thread/3620974/wip-word-builders-2025-roll-and-write-game-design) | `Folder with Files`, foglio giocatore, target cards aggiuntive e video di playthrough | Una cartella può contenere più artefatti e cambiare nel tempo; non va assimilata a un singolo file |
| Doodle Bash! | [thread 3606967](https://boardgamegeek.com/thread/3606967/wip-doodle-bash-2025-roll-and-write-game-design-co) | Il WIP dedicato è individuabile, ma il risultato indicizzato non espone i collegamenti del primo post | Stato `not_observed` per le risorse; non `absent` |
| The Leaning Tower of Pisa | [thread 3613315](https://boardgamegeek.com/thread/3613315/the-leaning-tower-of-pisa-an-entry-into-the-2025-r/page/0) | Il WIP dedicato è individuabile, ma i materiali non sono esposti nel risultato indicizzato consultato | Stato `not_observed` per le risorse; non `absent` |
| A Dragon's Die, ritirata | Nessun WIP dedicato verificato nel sondaggio | Nessuna informazione sui materiali | Il ritiro e la mancata individuazione del WIP sono fatti separati; nessuno dei due autorizza a concludere che i materiali non esistano |

## Valutazione dello schema corrente

`entries.wip_thread_url` è il posto corretto per il WIP BGG dedicato. `entries.entry_url` deve continuare a rappresentare la riga, GeekList o lista ufficiale che prova l'iscrizione al contest.

`remote_resources` rappresenta già la relazione uno-a-molti fra gioco e risorse, ma da sola non conserva in modo sufficiente come il collegamento è stato osservato in una specifica entry. In particolare mancano:

- il WIP o post BGG da cui proviene la menzione;
- il testo originale del collegamento;
- il ruolo del contenuto distinto dalla forma tecnica dell'endpoint;
- la distinzione fra dichiarazione nel WIP e verifica diretta di raggiungibilità;
- la storia delle osservazioni, necessaria quando URL, versioni o disponibilità cambiano.

## Modello proposto

Mantenere `entries.wip_thread_url` e `remote_resources`, aggiungendo due livelli relazionali:

### `entry_resource_mentions`

Una riga per ogni collegamento osservato nel WIP di una specifica entry:

- `entry_id`;
- `remote_resource_id`;
- `source_url`, preferibilmente URL del primo post BGG con article ID;
- `label_raw`, per esempio `Rulebook`, `Print Sheet` o `Folder with Files`;
- `content_role`, per esempio `rulebook`, `pnp_components`, `combined_pnp`, `low_ink`, `player_aid`, `supplement`, `digital_play`, `video` o `other`;
- `is_primary`, quando l'autore indica la risorsa corrente o principale;
- `first_seen_at` e `last_seen_at`.

La tabella consente allo stesso URL, per esempio una cartella, di coprire più ruoli senza duplicare la risorsa tecnica.

### `remote_resource_observations`

Una riga per ciascuna osservazione storica della risorsa:

- `remote_resource_id`;
- `observed_at`;
- `evidence_url`;
- `observation_kind`: `declared_in_wip` oppure, in un task successivo, `availability_check`;
- `availability_status`: `not_checked`, `available`, `unavailable`, `access_restricted` o `unknown`;
- `version_raw` e `notes`.

Durante l'esplorazione annuale si registra normalmente `declared_in_wip` con disponibilità `not_checked`. La verifica dell'host esterno e il download appartengono al task dedicato alle singole entry.

### Estensione di `remote_resources`

Separare il tipo tecnico dal contenuto:

- mantenere `kind` come ruolo compatibile con i dati esistenti oppure migrare gradualmente il ruolo in `entry_resource_mentions.content_role`;
- aggiungere `access_type`: `direct_file`, `folder`, `landing_page`, `browser_game`, `simulator_module`, `video` o `other`;
- conservare `url`, `host` e l'eventuale `version_raw` senza riscrivere una risorsa storica quando cambia destinazione.

## Conseguenza operativa

L'esplorazione annuale dovrebbe mirare a censire per ogni entry l'URL WIP BGG e tutti i collegamenti dichiarati nel primo post, senza seguirli. Il risultato può legittimamente essere:

- WIP non individuato;
- WIP individuato, risorse non osservabili;
- WIP individuato, nessuna risorsa dichiarata;
- una o più risorse dichiarate ma non verificate.

Questi stati devono restare distinti. La successiva attività sulle singole entry potrà verificare disponibilità, licenza, versione e contenuto, quindi decidere l'acquisizione e calcolare gli hash.

## Applicazione del sondaggio

La proposta è stata applicata al contest completo mediante la migrazione `006_entry_resource_provenance.sql` e il catalogo `2025-roll-write-wips-resources.sql`. Il risultato riga per riga è pubblicato in `2025-ROLL-WRITE-WIPS-RESOURCES.md`.
