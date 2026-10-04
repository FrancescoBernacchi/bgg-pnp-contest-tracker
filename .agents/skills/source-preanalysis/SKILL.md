---
name: source-preanalysis
description: Esplora una sola fonte candidata di giochi e propone integrazione nel catalogo, modello dati e app, con accessi e ambiguità. Non importa, acquisisce o implementa automaticamente.
---

# Preanalisi di una specifica nuova fonte

## Input e attivazione

Una fonte candidata identificata, obiettivo del task FON, PROJECT.md, schema corrente/migrazioni, app/README.md e registri fonti in sources. Per ricerca comparativa di candidati usa [potential-source-discovery](../potential-source-discovery/SKILL.md). Una fonte già adottata non necessita nuova adozione: distingue preanalisi di estensione da riapertura della decisione storica.

## Procedura

1. Ricostruisci indice, pagine record, paginazione, lingue e collegamenti fra contenuti attraverso un campione motivato delle strutture diverse. Il campione non è censimento completo: annota selezione e lacune.
2. Distingui gioco, variante, prodotto/confezione, autore, record nativo, risorsa e implementazione online. Registra identificativi osservati, URL stabili/candidati, alias, relazioni molti-a-molti e possibili duplicati con catalogo esistente. Non fondere automaticamente omonimi.
3. Verifica condizioni osservabili, accesso pubblico/login, licenze, disponibilità delle regole complete gratuite per i record candidati e possibilità di aggiornamento; distingui dichiarato, osservato e non collaudato. Non aggirare restrizioni e non acquisire file.
4. Confronta con il nucleo multifonte (migrazione 009 e successive): mapping campo sorgente → entità/campo locale, valori originali/normalizzati, provenienza, stato matching e ambiguità. Proponi nuove strutture solo se il modello non rappresenta un ciclo di vita o relazione stabile.
5. Formula strategia di aggiornamento manuale/incrementale, gestione di rinomini/ritiri, costo di riconciliazione e mantenimento. Costi e stabilità futura restano stime da validare, non fatti.
6. Proponi percorso nell'app: ricerca comune Giochi e viste specializzate soltanto per semantiche specifiche. Presenta alternative, dipendenze, criteri di accettazione e decisioni necessarie; separa eventuali EPR, CAT, DAT, APP, VER e ACQ successivi.

## Deliverable e verifiche

Rapporto di una fonte con mappa pagine/entità, esempi sorgente datati, mapping proposto, limiti di accesso, rischi/costi, ambiguità e proposta motivata. Successo: l'utente può decidere integrazione e pilotaggio sulla base delle prove; nessuna adozione, importazione, modifica app/schema o download conseguente automaticamente.

Precedente: TSK-0018 Kanare_Abstract, 2026-09-20; `sources/KANARE-ABSTRACT-TITLE-CENSUS.md`, schema e TSK-0022 documentano la successiva evoluzione, non azioni autorizzate dalla preanalisi. Distinzione gioco/prodotto verificata su Kanare; generalizzazione ad altri host ancora da collaudare. Registra risultati specifici nel task; promuovi soltanto pattern verificati con limiti e aggiorna inventario TSK-0048. Non trasformare scelte specifiche Kanare (lingue, immagini) in regole universali.
