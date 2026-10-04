---
name: bgg-ranking-census
description: Raccoglie e riconcilia risultati e votazioni pubblicati BGG, separando verifica completa e presenza in classifica. Usa solo il perimetro del contratto autorizzato; esclude nuovi roster e materiali.
---

# Censimento classifiche BGG

## Attivazione e input

Per risultati, categorie, piazzamenti, punteggi e votazioni. Leggi contratto, roster esistente, baseline `rankings` e attestazioni di lavoro. Usa la [base BGG](../bgg-contest-navigation/SKILL.md), il pattern spoiler/immagini numeriche nel playbook e schema/migrazione 012.

Le estensioni annuali sono deliberate soltanto per TSK-0045 (2025, continuativo) e TSK-0046 (2024, circoscritto). Non autorizzano annualità ulteriori né ampliamento dei cinque workflow. Per altro perimetro verifica il contratto esplicito; se manca proponi EPR. Challenge senza roster restano dipendenza del censimento, fuori dal denominatore iniziale.

## Procedura

1. Congela baseline e denominatore per contest; individua post ufficiali risultati e annunci finali, distinguendo segnali sostitutivi e ufficialità.
2. Leggi interi blocchi pubblicati, categorie e spoiler annidati. Le immagini `d10-N` danno un numero esplicito; ordine delle righe, premi GeekGold e totali dei votanti non provano posizione o voti di un gioco.
3. Conserva categoria originale, rank, score e vote_count distinti; preserva pari merito, menzioni senza posizione e valori mancanti. Escludi premi ai playtester.
4. Riconcilia titoli/autori/alias con roster; non fondere corrispondenze ambigue né aggiungere entry. Documenta rettifiche e conserva precedenti osservazioni.
5. Confronta tutte le entry del roster con tutte le liste osservabili nel perimetro. Registra attestazione datata `complete` o `absent` solo quando il confronto lo prova; `absent` significa assenza dalle liste pubblicate esaminate, non assenza universale di risultati. Accesso fallito o lista parziale restano incompleti/non osservabili.
6. Produci confronto prima/dopo e attestazioni separate dai piazzamenti. Non inferire lavoro non svolto da un'attestazione storica non ancora convertita: riconcilia task e prove pregresse.

## Deliverable e successo

Baseline, righe con URL articolo e data, rapporto per contest, anomalie e denominatori separati: fonti/entry verificate rispetto al perimetro e entry effettivamente presenti in classifica. Un 100% delle verifiche non implica 100% delle entry premiate né tabella integrale dei voti.

Se il task autorizza importazione, usa append-only, prova su copia e ripetizione senza duplicati, backup verificato, integrità/chiavi esterne; rigenera sezioni A/B del cruscotto dopo cambi ai dati. Ispeziona `catalog/import_2024_rankings.py` e `catalog/document_2024_rankings.py` come precedenti con anno/path fissi. Non riaprire ordinariamente contest conclusi senza rettifiche o nuova evidenza. Registra anomalie nel task; promuovi pattern verificati nel playbook condiviso e aggiorna inventario TSK-0048.
