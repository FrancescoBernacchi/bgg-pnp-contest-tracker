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

## Estensione: materiali dichiarati senza collegamento

È stato aggiunto un censimento distinto dei requisiti materiali leggibili direttamente nel primo post. Sono stati riesaminati tramite DOM effettivo 89 WIP dei tre contest già approfonditi: 37 Roll & Write, 26 In-Hand e 26 Children & Family. `Duel: Clash of Metal` e `Potions Master Tournament` restano senza WIP; il post originale di `Black Market` non è osservabile.

Il nuovo modello separa la scansione (`entry_material_scans`) dai requisiti (`entry_material_requirements`) e conserva categoria provvisoria, nome originale e normalizzato, quantità dichiarata, obbligatorietà, modalità di approvvigionamento, evidenza testuale, fonte e date. La copertura corrente è marcata `first_post_only`: nessun regolamento esterno è stato aperto o scaricato e un futuro incremento `rules_integrated` potrà completare o correggere l’inventario preservando la provenienza.

Sono stati registrati 201 requisiti distinti per 69 entry. Le categorie provvisorie comprendono componenti stampabili, randomizzatori, strumenti di scrittura, mazzi standard, pedine e segnalini, oggetti domestici, accessori, strumenti e materiali di montaggio, timer, strumenti segnapunti e dispositivi digitali. Per 19 WIP non è emerso un requisito sufficientemente esplicito; questo stato non certifica l’assenza di materiali.

File riproducibili: `database/migrations/007_entry_declared_materials.sql`, `catalog/build_2025_declared_materials.py`, `catalog/2025-declared-materials.sql`, `catalog/verify_2025_declared_materials.py` e `sources/2025-DECLARED-MATERIALS.md`. L’interfaccia locale mostra ora una sezione separata “Materiali richiesti”, con quantità, classificazione, evidenza e avviso sul limite del primo post.

La migrazione e l'incremento sono stati applicati al database operativo. Il verificatore restituisce `integrity=ok`, zero violazioni delle foreign key, 91 scansioni, 201 requisiti e nessun requisito attribuito a entry senza WIP. Sono superati i 13 test Python e i 14 test JavaScript dell'interfaccia.

## Punti aperti per verifica umana

Le anomalie non risolvibili con le sole evidenze correnti sono state promosse nel registro versionato `sources/OPEN-VERIFICATION-POINTS.md`. Il registro distingue problemi di provenienza, post non osservabili, WIP assenti e inventari materiali incompleti; per ciascun punto conserva evidenza, azione futura e criterio di chiusura. Non vi sono confluite anomalie tecniche già risolte e verificate.

I dieci punti iniziali riguardano `Allmende`, `Potions Master Tournament`, `Black Market`, `Duel: Clash of Metal`, `Yadoya`, `Crab Boil`, `On-LINE Kasino`, `Hex Hive: Skirmish`, `Peng Wins!` e `Librarian's Cat`. Le verifiche che richiedono regole o file PnP restano differite al futuro task di acquisizione; nessuna destinazione esterna è stata aperta in questo incremento.

## Incremento 1-Card

Sono stati aperti direttamente tutti i 38 WIP della GeekList ufficiale 1-Card 2025 e letti integralmente i primi post tramite DOM effettivo. Il primo caricamento di alcune pagine restituiva temporaneamente un corpo vuoto: la classificazione è stata effettuata solo dopo il montaggio del `post-body`, senza interpretare il ritardo come assenza. Sono stati estratti anchor, collegamenti dinamici e media incorporati senza aprire destinazioni esterne.

Il censimento conserva 72 collegamenti distinti: 35 WIP dichiarano almeno una risorsa, `The Moving Fortress` e `Zombie Apocalypse` non mostrano collegamenti pertinenti, mentre il post originale di `Disturbance at Darkholm Manor` non è più osservabile. Il primo articolo residuo appartiene a un altro utente; le risorse discusse nelle risposte non sono state attribuite al primo post e la situazione è stata registrata come `OVP-2025-011`.

L'immagine BGG di `Lucky Words` è stata inclusa come risorsa perché il testo ordina esplicitamente di stamparla; questa eccezione verificata rispetto all'esclusione delle immagini decorative è stata promossa nel playbook. Per `Finger Twister` è preservata l'etichetta storica `Operation D-2`; `Flip Fart`, `Shadow Heist` e `Sliminal Pursuit` dichiarano la stessa cartella dell'autore, mantenuta separatamente nella provenienza di ciascuna entry.

Il censimento materiali è stato esteso a 1-Card. La copertura trasversale dei quattro contest ora comprende 129 entry e 307 requisiti distinti per 102 entry; per 1-Card sono 106 requisiti in 33 entry. La copertura rimane `first_post_only`: non sono state aperte regole esterne né scaricati file.

Oltre al post non osservabile, il registro dei punti aperti conserva tre ambiguità da integrare con le regole: quantità e tipo dei dadi di `Going the Difference!`, distinta dei cubetti di `The Moving Fortress` e natura letterale o sostituibile della torta in `Piece of Cake`.

File riproducibili dell'incremento: `catalog/build_2025_one_card_resources.py`, `catalog/2025-one-card-wips-resources.sql`, `catalog/verify_2025_one_card_resources.py` e `sources/2025-ONE-CARD-WIPS-RESOURCES.md`; il generatore e verificatore trasversali dei materiali sono stati aggiornati. Gli script sono stati applicati al database operativo dopo la verifica su copia; `PRAGMA integrity_check` restituisce `ok` e le foreign key non presentano violazioni.
