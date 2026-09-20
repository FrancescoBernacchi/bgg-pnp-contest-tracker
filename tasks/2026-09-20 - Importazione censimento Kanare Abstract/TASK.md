# Importazione censimento Kanare Abstract

## Stato

Concluso. Migrazione 009 applicata e censimento Kanare_Abstract importato e verificato.

## Tipo di attività

Importazione locale di un censimento multifonte già documentato. Non appartiene ai cinque workflow BGG e non include un nuovo rilevamento esterno.

## Scopo

Applicare in sicurezza la migrazione multifonte 009 al database operativo e importare il censimento preliminare Kanare_Abstract osservato il 2026-09-20, preservando identità canoniche, record nativi, prodotti, relazioni, nomi, risorse, implementazioni, crediti, provenienza e stati di verifica.

## Input autorevoli

- `AGENTS.md` e le sezioni multifonte di `PROJECT.md`;
- `sources/KANARE-ABSTRACT-TITLE-CENSUS.md`;
- `tasks/2026-09-20 - Censimento Kanare Abstract/TASK.md`;
- `tasks/2026-09-20 - Modello dati multifonte Kanare Abstract/TASK.md`;
- `database/schema.sql`;
- `database/migrations/009_multisource_catalog.sql`;
- `database/README.md`.

## Perimetro

- backup verificato del database operativo;
- verifica preventiva e applicazione unica della migrazione 009;
- importazione riproducibile del censimento Kanare già documentato;
- riconciliazione quantitativa di 38 titoli dell'indice, 39 prodotti e 64 candidati gioco/variante;
- controlli di integrità, cardinalità, ambiguità, preservazione BGG e test applicativi;
- aggiornamento del cruscotto e della documentazione autorevole se cambia lo stato della pipeline.

## Esclusioni

- nuova esplorazione web o uso di archivi web;
- apertura o verifica di destinazioni BGG e piattaforme online;
- download o lettura integrale di immagini, PDF e regolamenti;
- inferenza di descrizioni, crediti, URL o relazioni assenti;
- fusione automatica di alias, versioni o giochi ambigui;
- modifica dell'app salvo necessità dimostrata;
- operazioni Git mutative.

## Deliverable

- copia di sicurezza verificata del database operativo;
- script di importazione versionabile e idempotente o equivalente procedura riproducibile;
- database operativo migrato e popolato;
- query di verifica riproducibili;
- documentazione di decisioni, conteggi, anomalie residue e limiti;
- `PROJECT_PROGRESS.md` e documentazione autorevole coerenti con lo stato raggiunto.

## Criteri di successo

- migrazione 009 applicata una sola volta e dati BGG invariati;
- conteggi 38/39/64 riconciliati senza duplicazioni non motivate;
- corrispondenze ambigue mantenute `candidate`;
- prodotti, raccolte e accessori non confusi con giochi;
- `PRAGMA foreign_key_check` vuoto e `PRAGMA integrity_check` uguale a `ok`;
- cardinalità prodotto–gioco e conteggi delle entità inserite verificabili;
- suite applicativa corrente superata;
- stato finale e diff Git controllati.

## Registro operativo

- 2026-09-20: preflight superato; branch `main`, working tree pulita, `HEAD` uguale al riferimento locale `origin/main` (`b94648e`, divergenza 0/0).
- 2026-09-20: PWS allineato alla versione canonica 1.5.0; nessuna migrazione PWS richiesta.
- 2026-09-20: lette integralmente istruzioni, fonti Kanare, task precedenti, schema, migrazione 009 e documentazione database.
- 2026-09-20: rilevato un limite documentale: i 64 candidati sono nominati individualmente, mentre parte dei 39 prodotti/accessori è descritta solo per categorie aggregate. Non saranno inventati URL o metadati puntuali mancanti.
- 2026-09-20: creato con l'API di backup SQLite `outputs/backups/pnp_collection-before-009-20260920.sqlite3`; dimensione 2.392.064 byte, SHA-256 `aaec0749e326e897b3049e87e7265b5078201e08e5fa1dea0cd9f0d71e2bbc5d`, integrità `ok`, nessuna violazione FK e conteggi identici all'operativo.
- 2026-09-20: provati migrazione e importazione su una seconda copia del backup; riconciliazione e controlli superati prima di modificare l'operativo.
- 2026-09-20: verificata l'assenza di `catalog_sources`, applicata una sola volta la migrazione 009 e confermati invariati i conteggi BGG prima/dopo la sola migrazione.
- 2026-09-20: eseguito l'importatore offline e atomico `catalog/import_kanare_abstract.py`; nessuna richiesta di rete, apertura di destinazioni o acquisizione di materiali.
- 2026-09-20: aggiunto `catalog/verify_kanare_abstract_import.py` e aggiornati `PROJECT.md`, `.workspace/PROJECT_STATE.md`, `database/README.md`, `catalog/README.md` e `PROJECT_PROGRESS.md`.

## Decisioni, anomalie e limiti

- Sono state create 64 identità canoniche Kanare conservative. L'omonimia esatta `Ripples` con un gioco BGG preesistente non è stata fusa: il record Kanare ha un legame `confirmed` con la nuova identità e un legame separato `candidate` con l'identità BGG.
- `ViceVeresi` è il titolo canonico conservato dall'indice; `ViceVersi` è un alias dichiarato dalla pagina. `Whirlpool` è canonico e `Whirpool` resta grafia alternativa dichiarata.
- `Accasta (original)` non è stato trasformato in alias di `Accasta Pari`: resta titolo grezzo di un'implementazione online e la riconciliazione tramite la pagina Online Play è `candidate`.
- `RosenKreuz (7×7)`, `Residuel (old rules)` e `Tori Shogi (no extra pieces)` sono implementazioni/versioni dichiarate collegate al gioco base, non nuovi giochi.
- `Tori Shogi＋` e `Tori Shogi` restano giochi distinti; la relazione `variant_of` è `uncertain` e non dichiara una dipendenza o un requisito di pezzi non verificato.
- `Swarm` conserva `unpublished` come stato grezzo, senza autore inventato. La presenza Abstract Play è `declared`, non verificata.
- `Vault` è collegato a `Onager` con `derived_from`, unica derivazione esplicitamente documentata. Non sono state inventate basi per Bloody Queen, Stacking Morris o Custodial Pah-Tum.
- I 39 prodotti sono distinti dai giochi: 31 prodotti/raccolte ludiche e 8 accessori/set generici. Stacking Trilogy contiene tre giochi; Onager e Quantum Control ne contengono due ciascuno. Cinque set generici sono collegati ai 21 giochi che l'indice dichiara supportati.
- Per 18 prodotti/accessori il censimento locale conserva solo appartenenza al catalogo o categorie aggregate, non una scheda URL individuale. Essi sono collegati al record nativo aggregato del catalogo e annotati; nessun URL è stato ricostruito per inferenza.
- Le 55 presenze di immagini e le 59 presenze di regolamenti/PDF sono conservate nei metadati grezzi dei record nativi. Poiché il documento locale non conserva gli URL puntuali, `catalog_resources` riceve 0 righe: creare URL sintetici avrebbe falsificato provenienza e verificabilità.
- Le 28 implementazioni online sono `declared`. Solo Swarm conserva la piattaforma nominata Abstract Play; le altre usano una piattaforma esplicitamente non specificata dal documento locale, senza URL di destinazione.
- Sono state create 13 persone e 62 asserzioni di credito esclusivamente dalle attribuzioni documentate. Tradizioni o famiglie di giochi non sono state trasformate in persone; Dave Reynolds usa il ruolo `modern_application` per Circular Chess.
- Nessuna modifica all'app è risultata necessaria.

## Verifiche

- Prima della migrazione: 305 contest, 946 entry, 946 giochi, 13 nomi, 322 persone, 407 crediti BGG, 1.054 classifiche e 327 risorse remote; `integrity_check=ok`, `foreign_key_check` vuoto.
- Dopo la sola migrazione 009: gli stessi conteggi risultano invariati; integrità `ok` e nessuna violazione FK.
- Import inserito: 1 fonte, 58 record nativi, 64 giochi canonici, 90 legami gioco–record (64 `confirmed`, 26 `candidate`), 39 prodotti, 56 relazioni prodotto–gioco, 2 alias, 2 relazioni fra giochi, 0 risorse URL, 28 implementazioni, 13 persone e 62 crediti.
- Riconciliazione: indice 38 = 34 pagine gioco + 4 varianti PDF; prodotti 39 = 31 ludici + 8 accessori; candidati 64 = 38 indice + 25 da prodotti + 1 solo online.
- Cardinalità prodotto–gioco: 35 `included_game` e 21 `supported_game`; totale 56. Prodotti con più giochi conservati senza duplicare il prodotto.
- Ambiguità: 26 legami `candidate`; nessun riferimento non-Swarm della pagina Online Play è `confirmed`. `Ripples` presenta esattamente un legame Kanare `confirmed` e uno BGG `candidate`.
- Duplicazioni: nessun titolo duplicato fra le 64 identità Kanare importate. La sola omonimia trasversale osservata, `Ripples`, è motivata e non fusa.
- Dati BGG invariati: 305 contest, 946 entry, 407 `game_credits`, 1.054 classifiche, 327 risorse remote e 13 nomi legacy privi di provenienza multifonte; i nuovi record sono aggiuntivi.
- `PRAGMA foreign_key_check`: nessuna riga. `PRAGMA integrity_check`: `ok`.
- `database/test_multisource_migration.py`: superato.
- Test backend: 16/16 superati, nessuno skip sul database reale.
- Test frontend: 20/20 superati.
- Il verificatore offline `catalog/verify_kanare_abstract_import.py database/pnp_collection.sqlite3` riproduce tutti i conteggi e gli invarianti sopra indicati.

## Risultato e prossimo incremento

Il censimento preliminare Kanare_Abstract è ora rappresentato nel database operativo senza confondere giochi, record di fonte, prodotti, accessori, versioni o implementazioni. Il successivo lavoro va mantenuto in tre incrementi distinti:

1. **Esplorazione esterna Kanare_Abstract**: nuovo rilevamento esplicitamente autorizzato per colmare URL individuali e metadati non conservati nel censimento locale, senza verificare destinazioni terze.
2. **Verifica destinazioni Kanare_Abstract**: controllo separato di BGG e piattaforme online, aggiornando i 26 matching `candidate` e gli stati `declared` senza acquisire materiali.
3. **Acquisizione materiali Kanare_Abstract**: soltanto dopo selezione e verifica delle condizioni, scaricando file autorizzati con manifest e hash; non va combinata con i primi due incrementi.

Messaggio di commit proposto, non eseguito: `Importa il censimento Kanare Abstract nel catalogo multifonte`.
