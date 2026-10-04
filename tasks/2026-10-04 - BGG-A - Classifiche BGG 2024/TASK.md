# Classifiche BGG 2024

## Contratto

- ID: TSK-0046; apertura 2026-10-04; categoria BGG-A.
- Modalità circoscritto, su_richiesta; stato completato.
- Chat: 01a106c3-8e8e-7c20-b431-764b602a28c7.
- Estensione annuale risultati deliberata dall'utente il 2026-10-04 («Confermo»): ricerca e riconciliazione delle classifiche e votazioni ufficiali dei 10 contest PnP principali e Solomode già censiti nel 2024. Incrementi per contest; esclusi roster aggiuntivi, WIP, materiali, host esterni e download.
- Predecessore: TSK-0015, roster 2024. Sei challenge adiacenti senza roster rimangono dipendenza del censimento, escluse dal denominatore iniziale.
- Input: database operativo, roster catalog/2024-*, fonti BGG autorevoli, skill bgg-contest-navigation.
- Deliverable: baseline, evidenze datate per contest, importazione riproducibile, verifica su copia e backup prima dell'operativo, cruscotto rigenerato, confronto prima/dopo e limiti espliciti.
- Successo: tutti i risultati pubblicati osservabili riconciliati; integrità e chiavi esterne valide, nessuna perdita storica o duplicazione tecnica. Il 100% delle verifiche è distinto dal 100% delle entry con risultati: nessuna posizione inventata per ritiri o giochi non premiati.

## Apertura

PWS locale/canonico 1.5.0; sandbox e browser neutro verificati. Main con modifiche documentali preesistenti preservate. Baseline attesa 0/381 principali, 0/28 adiacenti, da query operativa. Titolo visibile rinominato secondo convenzione. Nessuna operazione Git autorizzata.

## Chiusura — 2026-10-04

Importati 869 risultati ufficiali di 11 contest; 225/381 entry principali e 14/28 adiacenti presenti nelle liste. Confronto concluso per tutte le 409 entry con esiti espliciti complete/absent. Fonti e limiti in CHECKS_2026-10-04.json e VERIFICA_2026-10-04.md. Backup e verifiche in IMPORT_VERIFICATION.json; importazione idempotente, integrità e chiavi esterne valide. Sezioni annuali A/B rigenerate. Nessuna acquisizione o modifica Git. Prossimo approfondimento utile: solo nuove tabelle ufficiali/rettifiche; censimento delle challenge in task roster distinto.

## Salvataggio Git — 2026-10-04

Su richiesta dell’utente creato commit `8b316ad` (Completa classifiche ufficiali BGG 2024) e push a `origin/main` riuscito. Database operativo, backup e materiali esclusi; modifiche delle altre chat preservate. La presente registrazione viene salvata con un commit audit separato.
