# 2026-10-05 - MAT - 24 Hour Design Challenge GUARD 2025

ID: TSK-0058. MAT circoscritto su richiesta, apertura 2026-10-05. Stato: in_corso.

## Contratto

Unico contest 294, sei entry già censite. Dichiarazioni, URL e requisiti del primo post originale di ciascun gioco, first_post_only. La challenge ammette presentazioni direttamente nel thread e WIP facoltativi: usare i post introduttivi degli autori collegati dal roster ufficiale, senza confonderli con risposte di terzi. Esclusi risposte successive, host esterni, file/download, classifiche e altri contest. Input: roster articolo 45584159 del thread 3452558 e baseline SQLite. Deliverable: evidenze per sei entry, fonte/data/autore/esiti, SQL riproducibile, relazione, importazione su copia e operativo con backup, registro e cruscotto. Successo: sei esiti verificati, conservazione storia e isolamento.

PWS locale/canonico 1.5.0; sandbox e browser neutro verificati. Nessun MAT GUARD preesistente: task autonomo distinto dal roster annuale TSK-0005. Skill bgg-contest-navigation e bgg-material-census applicate, inventario e playbook consultati. Working tree main con modifiche pregresse preservate, nessuna operazione Git autorizzata. Titolo visibile rinominato secondo convenzione.

## Risultati e chiusura — 2026-10-05

Stato completato. 6/6 entry riconciliate, cinque post originali integralmente letti e identità/data verificate: Guard the Bard e Oh My Pies! condividono un post e una cartella, ma restano giochi distinti. Il regolamento challenge dichiara WIP facoltativo e presentazioni direttamente nel thread; le fonti sono i post introduttivi degli autori collegati nel roster, non risposte usate come sostituti. Nessuna estensione alla storia successiva del thread. Quattro entry con URL, quattro URL unici globali e cinque associazioni gioco–URL, tredici requisiti. Maroons and Doubloons e Handguards: none_declared per gli URL, observed per i requisiti, regole nel post. Handguards: mazzo 29 carte incluso joker, contatori oppure penna/carta; la frase No components non annulla i requisiti elencati. Quantità non specificate degli altri componenti restano null, nessuna inferenza dalle meccaniche.

EVIDENCE.json conserva dichiarazioni selezionate, fonte/autore/data/forme tecniche/esiti; DOM_WITNESS.json conserva fonte, identità, lunghezze testo e collegamenti pertinenti, escludendo profili e navigazione. Roster 6/6 e URL/etichette/identità 6/6 confrontati. Nessun media incorporato pertinente. Baseline originale conservata. Le sei destinazioni introduttive aggiunte al campo wip_thread_url includono articolo e frammento per evitare di aprire il primo post organizzatore. entry_url del roster e altri campi storici invariati.

SQL idempotente provato su copia, poi importato con backup outputs/2025-guard-materials/before-import.sqlite3 e SHA-256. integrity_check ok, zero violazioni FK, righe precedenti preservate, modifiche additive isolate ai giochi target e soli aggiornamenti wip_thread_url delle sei entry. Nessun cambiamento schema/roster/classifiche/acquisizioni/file/altri contest. API_VERIFICATION.json: risorse e requisiti coerenti 6/6. Browser: sei righe con L verde. A/B rigenerate; 470/509 entry 2025 con scansione registrata. Registro, catalog/README e cruscotto aggiornati prima della chiusura.

Deliverable: ROSTER_BASELINE.json, DOM_WITNESS.json, EVIDENCE.json, VERIFICATION.json, API_VERIFICATION.json, catalog/build_2025_guard_materials.py e 2025-guard-materials.sql, sources/2025-GUARD-MATERIALS.md. Script di importazione una tantum protegge il backup originale; per riproduzione usare SQL su copia. Tassonomia provvisoria; quantità raccolte non inventario verificato dei file esterni. Nessun host/file aperto o download, nessun controllo periodico; calendario invariato. Struttura documentata nel task come applicazione del pattern già noto roster nel thread, senza nuove modifiche skill o PWS.

Nessun commit/push; modifiche pregresse preservate. Incremento da committare su richiesta: Censisci materiali GUARD 2025. Prossimo passo utile: selezione dei giochi per eventuale ACQ dedicato al solo GUARD, con verifica condizioni e host.
