# Modello dati multifonte Kanare Abstract

## Stato

Concluso. Modello multifonte implementato e verificato; importazione Kanare non iniziata.

## Tipo di attività

Evoluzione strutturale del catalogo multifonte. Non appartiene ai cinque workflow BGG e non include un nuovo rilevamento esterno.

## Scopo

Progettare e implementare una migrazione SQLite minima, generale, incrementale e non distruttiva che renda esplicita la separazione fra gioco canonico e record nativo di fonte e rappresenti nomi, prodotti, relazioni prodotto–gioco, varianti e dipendenze, risorse, implementazioni online, persone/crediti, provenienza e stato di verifica.

## Input ed evidenze

- `AGENTS.md` e `PROJECT.md`;
- `sources/KANARE-ABSTRACT-TITLE-CENSUS.md`, rilevato il 2026-09-20;
- `tasks/2026-09-20 - Censimento Kanare Abstract/TASK.md`;
- `database/schema.sql`, `database/README.md` e tutte le migrazioni esistenti;
- schema e query correnti dell'applicazione, da preservare.

## Perimetro

- progettazione del nucleo relazionale multifonte;
- nuova migrazione numerata e additiva;
- aggiornamento coerente dello schema consolidato e della documentazione autorevole;
- prova della migrazione su database temporaneo, con fixture esclusivamente sintetiche;
- verifica di integrità, chiavi esterne, compatibilità delle query e non regressione dei dati BGG;
- aggiornamento di `PROJECT_PROGRESS.md` se lo stato della pipeline o degli strumenti cambia.

## Esclusioni

- importazione dei 64 candidati Kanare;
- acquisizione di immagini o regolamenti;
- verifica di BGG, piattaforme online o altre destinazioni esterne;
- fusione automatica di record o alias ambigui;
- modifica dell'app, salvo adattamento strettamente necessario e motivato;
- commit, push, pull, merge o altre operazioni Git mutative.

## Deliverable

- migrazione SQL numerata, incrementale e non distruttiva;
- `database/schema.sql` aggiornato come schema consolidato per nuove installazioni;
- documentazione del modello, dei suoi invarianti e del percorso di importazione Kanare;
- verifica riproducibile della migrazione con fixture sintetiche;
- registro delle decisioni, dei limiti e dei risultati in questo task.

## Criteri di successo

- i dati BGG esistenti restano invariati e le query correnti continuano a funzionare;
- gioco canonico e record nativo di fonte sono entità distinte;
- alias e nomi conservano lingua, natura, ufficialità, provenienza e verifica senza imporre fusioni;
- prodotti/confezioni possono contenere più giochi e un gioco può comparire in più prodotti;
- varianti e dipendenze fra giochi sono relazioni esplicite e tipizzate;
- regole, immagini e altre risorse sono distinguibili e attribuibili a gioco, prodotto o record di fonte senza tabelle Kanare-specifiche;
- implementazioni online e crediti supportano dichiarazioni non verificate e successive verifiche;
- provenienza, testo grezzo, valore normalizzato, data e stato di verifica restano separabili;
- una fixture sintetica dimostra le cardinalità principali e supera `PRAGMA foreign_key_check` e `PRAGMA integrity_check`;
- decisioni e limiti sono documentati e il successivo import Kanare ha una procedura precisa.

## Registro operativo

- 2026-09-20: preflight completato; working tree pulita e worktree in `detached HEAD`.
- 2026-09-20: verificato allineamento PWS 1.5.0 con la copia canonica 1.5.0.
- 2026-09-20: lette istruzioni, modello autorevole, evidenze Kanare, schema, migrazioni e documentazione database.
- 2026-09-20: progettata e applicata allo schema consolidato la migrazione additiva `009_multisource_catalog.sql`.
- 2026-09-20: aggiunta una prova riproducibile con fixture sintetiche e verificata la compatibilità dell'app senza modificarne il codice.
- 2026-09-20: applicata la migrazione a una copia temporanea del database operativo; l'originale non è stato modificato e la copia è stata rimossa dopo la verifica.
- 2026-09-20: aggiornati `PROJECT.md`, `.workspace/PROJECT_STATE.md`, `database/README.md` e `PROJECT_PROGRESS.md`.

## Decisioni e limiti

- `games` resta l'identità canonica trasversale. `source_records` rappresenta invece ciò che una fonte pubblica come pagina, prodotto o altro record nativo.
- La relazione `game_source_records` porta uno stato `candidate`, `confirmed` o `rejected`: nessun titolo, alias o URL determina da solo una fusione canonica.
- `catalog_sources` e tutte le nuove tabelle sono generali; non esistono colonne o tabelle Kanare-specifiche.
- `products` è distinto dal gioco e `product_games` consente sia confezioni con più giochi sia giochi presenti in più prodotti.
- Varianti, derivazioni e dipendenze sono archi tipizzati in `game_relationships`; il requisito della dipendenza è separato dal tipo di relazione.
- `game_names` è stato esteso in modo compatibile con lingua, scrittura, tipo, ufficialità, fonte e verifica. Le righe esistenti ricevono soltanto default conservativi.
- `catalog_resources` e `resource_links` costituiscono il modello generale per regole, immagini e altre risorse. `remote_resources` rimane invariata come contratto legacy BGG dell'app: non è stata duplicata o migrata automaticamente perché tale trasformazione richiederebbe un task dati separato.
- Le implementazioni online sono distinte dal gioco e dalla piattaforma. `declared` significa soltanto che la fonte le dichiara; non certifica l'accessibilità della destinazione.
- `person_names` e `credit_assertions` aggiungono provenienza e verifica ai crediti multifonte; `game_credits` resta compatibile per le query BGG correnti.
- Le enumerazioni aperte come `record_type`, `product_kind`, `relationship_type`, `resource_kind`, `link_role` e `role` restano testo controllato dal processo di importazione: il campione Kanare non giustifica ancora vocabolari rigidi o tassonomie definitive.
- `raw_metadata` accetta una serializzazione testuale della porzione strutturata utile della fonte; non autorizza snapshot completi indiscriminati.
- Non sono stati importati record Kanare, scaricati file, aperte destinazioni esterne o risolte anomalie quali ViceVeresi/ViceVersi, Whirpool/Whirlpool o Accasta/Accasta Pari.

## Verifiche

- `database/test_multisource_migration.py`: superato; preservate le righe legacy e dimostrate fonte→record→gioco, prodotto con due giochi, variante dipendente, alias multilingue, regolamento, implementazione online e credito.
- Migrazione 009 applicata a una copia temporanea del database operativo: conteggi invariati prima/dopo per contest 305, entry 946, giochi 946, nomi 13, persone 322, crediti 407, classifiche 1.054 e risorse remote 327.
- `PRAGMA foreign_key_check` sulla fixture, sulla copia operativa migrata e sullo schema consolidato nuovo: nessuna violazione.
- `PRAGMA integrity_check` sulla fixture, sulla copia operativa migrata e sullo schema consolidato nuovo: `ok`.
- Test backend: suite di 16 casi senza errori, con 3 skip attesi.
- Test frontend: 20 superati.
- `git diff --check`: nessun errore; presenti soltanto avvisi di futura normalizzazione LF→CRLF da Git su file esistenti/modificati.
- Nessuna modifica all'applicazione necessaria: le tabelle e le viste interrogate restano compatibili.

## Risultato e incremento successivo

Il catalogo può ora rappresentare il censimento Kanare senza confondere identità canoniche, pagine native, prodotti, alias, varianti, risorse e implementazioni. Il successivo task di importazione dovrà procedere in questo ordine:

1. inserire una sola riga `catalog_sources` per Kanare_Abstract;
2. inserire in `source_records` le pagine gioco, prodotto e Online Play osservate il 2026-09-20, conservando URL, titolo grezzo, tipo, data e metadati utili;
3. creare o selezionare i `games` canonici soltanto dopo valutazione individuale e collegarli con `game_source_records`; usare `candidate` per ogni possibile corrispondenza BGG o anomalia non risolta;
4. registrare titoli ufficiali, grafie alternative e giapponesi in `game_names`, con lingua, tipo, fonte e stato di verifica;
5. creare i prodotti e collegarli ai rispettivi record nativi e giochi mediante `product_source_records` e `product_games`, senza trasformare accessori generici in giochi;
6. registrare varianti e dipendenze in `game_relationships`, mantenendo separate le anomalie di grafia dalle vere varianti;
7. censire regolamenti e immagini in `catalog_resources` e collegarli con `resource_links`; usare `declared` o `not_checked` per le destinazioni non aperte e non scaricare file;
8. creare piattaforme e `game_implementations` per le presenze dichiarate, ancora non verificate;
9. riconciliare persone solo con evidenza sufficiente, conservando alias in `person_names` e crediti dichiarati in `credit_assertions`;
10. rieseguire conteggi, controlli di chiave esterna e integrità, documentando separatamente record confermati, candidati e anomalie residue.

Il task successivo non dovrà includere acquisizione di immagini o regolamenti né verifica delle destinazioni BGG/piattaforme: restano incrementi distinti.
