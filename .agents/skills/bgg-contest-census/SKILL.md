---
name: bgg-contest-census
description: Individua e riconcilia identità, serie ed edizioni dei contest BGG nel censimento globale BGG-G. Esclude roster annuali, classifiche e materiali.
---

# Censimento contest BGG

## Input e confini

Usa per identità dei contest su tutte le annualità o aggiornamenti dello stesso censimento. Leggi PROJECT.md e il contratto BGG-G; usa la [base BGG](../bgg-contest-navigation/SKILL.md) e i soli pattern pertinenti del suo playbook. Il censimento entry di un anno segue invece la [procedura annuale](../bgg-contest-navigation/references/annual-entry-census.md). Non ricostruire roster dai vincitori.

## Procedura

1. Confronta inventario locale, `sources/BGG-PNP-CONTEST-GLOBAL-COVERAGE.md` e indici BGG storici/correnti. Gli indici comunitari sono utili per copertura, ma non diventano fonti ufficiali per semplice uso.
2. Estrai tutti gli item/pagine, verifica indici mancanti e conteggi. Conserva nome originale, anno/edizione, serie, URL, natura della fonte e data.
3. Per novità confronta il forum Design Contests ordinato Recent e verifica il primo post ufficiale. Non usare Active come cronologia di creazione.
4. Deduplica per identità BGG, serie, anno ed eventuale edizione, mantenendo alias e ambiguità. La normalizzazione testuale genera candidati, non prova identità. Non fondere challenge multiple nello stesso anno.
5. Separa PnP autonomi e adiacenti autorizzati; escludi challenge di gioco e annunci di concorsi esterni. Non inventare annualità per colmare una serie.
6. Distingui stato dichiarato e inferito; una sezione retired/closed non prova da sola risultati ufficiali. Mantieni l'anomalia incerta e il conteggio storico.

## Deliverable e verifiche

Inventario delle edizioni con provenienza, confronto prima/dopo, duplicati risolti o sospesi, lacune e incremento riproducibile se previsto dal task. Prima di un'importazione autorizzata verifica su copia, idempotenza, integrità e chiavi esterne. Successo: copertura delle fonti dichiarata e conteggi riconciliati, senza entry/WIP/risorse.

`catalog/build_global_contest_census.py` e i verificatori globali documentano il precedente, ma contengono baseline e regole di stato storiche: ispezionali e adattali, non eseguirli come utility universali. Per anomalie usa fallback della base soltanto sui residui. Registra nuovi pattern nel task e promuovili nel playbook solo dopo verifica; aggiorna inventario skill e data tramite TSK-0048.
