# Esplorazione contest BGG 2025 - Parte 2

## Stato

In corso dall'11 settembre 2026, in continuità con il task `2026-09-07 - Esplorazione contest BGG 2025` (Parte 1).

## Scopo

Completare per incrementi il censimento dei collegamenti alle risorse dichiarati nei primi post dei WIP dei contest BGG 2025, senza aprire le destinazioni esterne né scaricare materiali. Dopo In-Hand, l'incremento corrente riguarda Children & Family 2025.

## Input

- Censimento annuale 2025 già completato: 11 contest e 464 entry.
- In-Hand 2025: 27 entry, di cui 15 finali e 12 ritirate.
- 26 WIP individuati; `Duel: Clash of Metal` non possiede un WIP.
- Skill locale `bgg-contest-navigation`, relativo playbook e incremento Roll & Write già verificato.

## Deliverable

- Scansione DOM completa del primo post dei 26 WIP BGG.
- Registro versionabile di URL, dominio, etichetta originale, contesto e classificazione provvisoria.
- Generatore e verificatore riproducibili equivalenti all'incremento Roll & Write, se appropriati.
- Aggiornamento del database SQLite e delle fonti versionabili.
- Tabella riepilogativa completa e proposta di commit, senza eseguire commit o push.

## Criteri di successo

- Copertura esplicita di tutte le 27 entry e dei 26 WIP.
- Estrazione da `a[href]`, `gg-item-link`, `iframe[src]`, `video[src]` e `source[src]` nel primo post renderizzato.
- Esclusione di navigazione, profili, immagini decorative, duplicati tecnici e canali YouTube automatici.
- Nessuna destinazione esterna aperta e nessun materiale scaricato.
- Tassonomia mantenuta provvisoria.
- Conteggi riproducibili, `PRAGMA integrity_check=ok`, nessuna violazione delle foreign key e test pertinenti superati.

## Stato iniziale verificato

- Branch: `main`.
- Working tree: pulita.
- Relazione locale: `main...origin/main`, senza divergenze indicate.
- Commit Roll & Write atteso come precedente pubblicato: `3cd53db`.

## Ripristino tecnico e metodo

Il preflight successivo alla correzione del sandbox ha verificato nel percorso ordinario: `Get-Location`, stato Git, lettura locale, creazione e rimozione di un file temporaneo e inizializzazione CUA su `example.com`. Il browser disponibile è il Codex In-app Browser; Edge non era esposto come superficie controllabile.

Dal primo post del thread ufficiale sono stati attivati progressivamente i 26 `gg-item-link` del roster. La cardinalità coincide con le 27 entry meno `Duel: Clash of Metal`, pubblicata senza collegamento WIP. Ogni URL risolto è un thread BGG univoco. I 26 WIP sono stati quindi aperti direttamente e il primo post renderizzato è stato letto integralmente tramite DOM, estraendo `a[href]`, `iframe[src]`, `video[src]` e `source[src]`.

## Risultati dell’incremento In-Hand

- 27 entry coperte: 26 WIP aperti direttamente e 1 WIP effettivamente assente.
- 23 WIP con almeno una risorsa dichiarata.
- 2 WIP senza risorse pertinenti osservate: `Hellheim In-Hand Duel` e `Dreadspire Keep`.
- 1 WIP non integralmente osservabile: `Black Market`; il post originale non è più presente e il primo messaggio residuo segnala un Google link ristretto senza mostrarne l’URL.
- 63 URL distinti conservati.
- Nessuna destinazione esterna aperta e nessun file scaricato.

Sono stati esclusi profili, navigazione, immagini decorative, riferimenti a giochi d’ispirazione, duplicati tecnici e collegamenti automatici ai canali YouTube. I singoli video incorporati sono stati conservati. La canzone didattica di `Starcrossed` su Suno introduce un contenuto audio istruttivo, classificato provvisoriamente come `video`/`web_app` senza consolidare la tassonomia.

## File e riproducibilità

- `catalog/build_2025_in_hand_resources.py`: dataset osservato e generazione riproducibile.
- `catalog/2025-in-hand-wips-resources.sql`: aggiornamento transazionale di WIP, scansioni, risorse, menzioni e osservazioni.
- `catalog/verify_2025_in_hand_resources.py`: verifica su copia temporanea.
- `sources/2025-IN-HAND-WIPS-RESOURCES.md`: tabella completa di entry e risorse con URL, dominio, etichetta, contesto e classificazione provvisoria.

Il generatore produce 63 risorse per 27 entry. Il verificatore sulla copia temporanea restituisce `integrity=ok`, zero violazioni delle foreign key, 26 WIP, 27 scansioni, 63 menzioni e 63 risorse distinte.

## Applicazione e verifiche finali

Lo script SQL è stato applicato al database operativo dopo la verifica su copia. Il controllo successivo restituisce `PRAGMA integrity_check=ok`, zero violazioni delle foreign key, 26 WIP, 63 risorse distinte e questa distribuzione completa delle scansioni: 23 `observed`, 2 `none_declared`, 1 `not_observable`, 1 `not_checked`.

Il cruscotto locale è stato rigenerato. Sono superati gli 8 test Python dell’applicazione e i 4 test JavaScript del frontend. Nessun commit o push è stato eseguito.

## Incremento Children & Family

La GeekList ufficiale conferma 27 entry e 26 collegamenti WIP. `Potions Master Tournament` non possiede un WIP: la sua voce contiene tre risorse dirette, mantenute come evidenza separata e non attribuite a un primo post inesistente.

I 26 WIP sono stati aperti direttamente in BGG. Per ciascuno è stato atteso il montaggio effettivo del primo `article .post-body`, letto integralmente il DOM ed estratti anchor, `gg-item-link`, iframe, `video` e `source`. I collegamenti dinamici sono stati portati nel viewport e attesi prima di stabilirne la destinazione. Non sono state aperte destinazioni esterne e non sono stati scaricati materiali.

Risultato:

- 27 entry coperte: 26 WIP osservati e 1 WIP non individuato;
- 21 WIP con almeno una risorsa dichiarata;
- 5 WIP senza collegamenti pertinenti: `Pirate Treasures`, `Pets Rescue`, `Hex Hive: Skirmish`, `Head In The Clouds`, `Guesstrictions`;
- 43 URL distinti conservati.

Sono stati esclusi navigazione, profili, immagini decorative, riferimenti al contest, pagine BGG del gioco non presentate come risorse e canali YouTube automatici. Il link testuale e l'incorporamento di `Allmende` indicavano lo stesso video e sono stati accorpati. L'URL Google Drive di `Allmende` contiene due prefissi concatenati: è conservato esattamente come dichiarato e marcato non verificato.

File riproducibili dell'incremento:

- `catalog/build_2025_children_family_resources.py`;
- `catalog/2025-children-family-wips-resources.sql`;
- `catalog/verify_2025_children_family_resources.py`;
- `sources/2025-CHILDREN-FAMILY-WIPS-RESOURCES.md`.

Il generatore produce 43 risorse per 27 entry. Il verificatore su copia temporanea restituisce `integrity=ok`, zero violazioni delle foreign key, 26 WIP, 27 scansioni, 43 menzioni e 43 risorse distinte. Lo script è stato applicato al database operativo, che restituisce a sua volta `integrity=ok`, zero violazioni delle foreign key, 27 entry, 26 WIP e 43 menzioni. Sono superati i 12 test Python dell’applicazione e i 13 test JavaScript del frontend.
