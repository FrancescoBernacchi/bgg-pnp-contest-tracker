---
name: game-image-acquisition
description: Acquisisce e cataloga immagini di giochi nel perimetro IMG approvato per un contest BGG o giochi Kanare, estrae componenti da materiali acquisiti e gestisce integrazioni AI su richiesta con validazione utente. Non acquisisce pacchetti PnP ACQ né implementa l'app.
---

# Immagini dei giochi

Leggi il contratto IMG del task e `sources/IMAGE_WORKFLOW.md`, riferimento autorevole delle decisioni TSK-0065. Acquisisci tutte le immagini utili nel perimetro, distinguendo raccolta da selezione nell'app. BGG: un contest/anno, incrementi per gioco; Kanare: giochi espliciti. Fonti future richiedono contratto proprio, senza generalizzare Kanare.

## Riferimenti per modalità

- Esplorazione BGG/Kanare: [fonti](references/sources.md). Per BGG applica anche `.agents/skills/bgg-contest-navigation/SKILL.md`, usando il routing IMG aggiuntivo senza estendere MAT/ACQ/monitoraggio.
- Estrazione manuali/componenti: [estrazione](references/extraction.md). Materiali già acquisiti; nuovi pacchetti richiedono ACQ distinto.
- Generazione/rielaborazione: [AI](references/ai.md), solo quando richiesta. App iniziale consultiva; genera tramite Codex.

## Incremento verificabile

1. Verifica scope, giochi/versioni, task preesistenti, manifest e condizioni per l'uso previsto. Consulta `PUBLICATION_POLICY.md`; conserva crediti/fonti dichiarati, senza inventarli. Usa ID del catalogo; segnala matching incerti.
2. Esplora/estrai/genera soltanto la modalità autorizzata. Registra fonti, date, copertura e residui anche quando non ottieni file. Non equiparare pagina pubblica a permesso di acquisizione/trasformazione.
3. Confronta contenuti e versioni prima della selezione. Deduplica contenuti identici preservando provenienze e occorrenze; non fondere componenti simili con differenze. Preferisci varianti superiori equivalenti, recuperando contenuti unici e preservando originali/storico.
4. Applica categorie, etichette provenienza e naming di IMAGE_WORKFLOW.md; sigle contest nel registro IMAGE_CONTEST_CODES.md. Binari in library/immagini per gioco, sottocartelle originali/estratti/ai/derivati; manifest testuali in catalog. Verifica formato, SHA-256, dimensioni, origine e legami; niente sovrascritture con contenuto diverso.
5. Mantieni separati ricerca/applicabilità, disponibilità originali/AI, validazione e adozione. Risultati AI Da valutare finché l'utente approva; Scartate/Superate fuori copertura corrente pertinente e galleria ordinaria. Cancellazione definitiva solo in pulizia esplicita.
6. Verifica integrità dei file, associazioni gioco/componenti/lati, link del manifest e completezza nel perimetro. Per i nuovi incrementi IMG, decisione utente 2026-10-11: l'acquisizione autorizza anche l'importazione verificata nel modello immagini operativo già implementato, senza ulteriore conferma. Usa l'importatore esistente con prove su copia, backup/ripristino verificati e transazione; verifica galleria e avanzamento nell'app prima della chiusura. Aggiorna task, registro e cruscotto. Non alterare metriche/database privi di modello implementato: nuove migrazioni o sviluppo APP richiedono un task distinto. Completamento dichiarativo con perimetro/data/limiti, non promessa di tutte le immagini esistenti.

## Maturità

Regole deliberate 2026-10-05; quattro giochi verificati in TSK-0068 entro il 2026-10-11, con prove e limiti nei riferimenti fonti/estrazione. Render+crop, oggetti nativi interi, tabellone su più fogli e controllo ID del download collaudati nei casi documentati; nessuna estrazione automatica o deduplicazione visiva universale. Registra ulteriori prove prima di trasferire geometrie o equivalenze. Persistenza/consultazione implementate in TSK-0067; dal 2026-10-11 l'importazione dei nuovi incrementi IMG è inclusa nell'autorizzazione di acquisizione. Sviluppo app o schema in task distinto; niente nuove migrazioni implicite.
