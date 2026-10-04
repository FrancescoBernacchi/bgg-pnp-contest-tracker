---
name: bgg-material-census
description: Analizza WIP, risorse e requisiti dichiarati nel primo post BGG per un singolo contest MAT. Non apre host esterni e non scarica file.
---

# Censimento materiali BGG

## Input e attivazione

Per task MAT di un solo contest: roster, URL BGG, scansioni pregresse, PROJECT.md e [base BGG](../bgg-contest-navigation/SKILL.md). Leggi nel playbook i pattern primo post, risorse, immagini stampabili e varianti dipendenti. Non applicare al censimento annuale entry o a più contest. Verifica destinazioni e acquisizione seguono una skill/task ACQ distinti.

## Procedura

1. Risolvi sistematicamente i WIP dalla fonte ufficiale del roster, poi fallback sui residui. Registra WIP non individuato senza attribuire assenza di risorse.
2. Verifica che il primo post sia quello originale dell'autore, con timestamp e contesto; una risposta rimasta dopo rimozione non è equivalente. Registra `not_observable` per dichiarazioni non osservabili.
3. Leggi integralmente il primo post renderizzato, risolvendo componenti BGG dinamici. Estrai anchor, iframe, video e source; conserva destinazione dichiarata senza aprire host esterni o file.
4. Escludi navigazione, profili, decorazioni e link tecnici dei player. Un'immagine BGG è risorsa stampabile soltanto con istruzione operativa esplicita, come Lucky Words; non scaricarla in MAT.
5. Accorpa URL identici senza perdere menzioni, funzione dichiarata, testo e contesto. Funzione e forma tecnica sono dimensioni separate e provvisorie fino al confronto dei MAT di tutti i contest dell'anno.
6. Censisci separatamente requisiti senza URL: testo originale, quantità, obbligatorietà, approvvigionamento e alternative. Non dedurre componenti dalla meccanica. Per Solomode conserva dipendenza dal gioco base e soltanto componenti aggiuntivi/sostitutivi espliciti.
7. Separa WIP non trovato, risorse non osservabili, `none_declared` e risorse dichiarate ma non verificate. `none_declared` richiede lettura completa del primo post e non prova che il gioco sia privo di materiali. Dichiarazione non equivale a disponibilità.

## Deliverable e verifiche

Scansione per ogni entry con fonte/data/esito, menzioni e requisiti riconciliati, copertura `first_post_only`, limiti e anomalie. `rules_integrated` appartiene a un'integrazione successiva autorizzata, non a questa scansione. Successo: tutte le entry del perimetro hanno esito esplicito, anche bloccato, senza attestare completa una lettura parziale.

Usa come esempi `sources/2025-ROLL-WRITE-WIPS-RESOURCES.md`, `sources/2025-IN-HAND-WIPS-RESOURCES.md` e `sources/2026-WARGAME-MATERIALS.md`; script `catalog/build_2025_*_resources.py` e relativi verificatori sono specifici del lotto: ispeziona date/ID prima del riuso. Verifica conteggi, unicità e coerenza degli esiti; per importazione autorizzata prova su copia e rigenera A/B se cambiano dati. Nuove anomalie restano nel task finché verificate; promozione nel playbook condiviso e inventario TSK-0048.
