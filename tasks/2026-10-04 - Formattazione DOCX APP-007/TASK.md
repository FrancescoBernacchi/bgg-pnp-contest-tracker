# APP-007 — Formattazione DOCX

- Apertura: 2026-10-04.
- Stato: concluso il 2026-10-04.
- Incremento autonomo dopo APP-005/006 concluse; nessun task implementativo APP-007 esistente.
- PWS: 1.5.0 allineata; main allineato a origin/main, modifiche APP-006 preesistenti preservate.

## Scope, input e deliverable
Correggere lettore DOCX locale: formattazione testo, paragrafi/stili, elenchi, tabelle, immagini e caselle di testo. Input: registro APP-007, quattro DOCX locali e codice APP-005. Nessuna acquisizione o modifica degli originali, del database o del contratto di accesso.
Deliverable: parser e renderer sicuri, prove backend/browser, confronto con Word, documentazione e registro aggiornati.
Successo: contenuto e ordine preservati, resa visiva confrontata, finestra stretta e tastiera, hash invariati, limiti espliciti. Impaginazione Word esatta non garantita dal flusso HTML.

## Diagnosi e soluzione
Il lettore APP-005 estraeva solo stringhe, eliminando formattazione e immagini e concatenando senza separatori i paragrafi nelle caselle di testo. Nei regolamenti sono presenti 47 drawing: 43 immagini e quattro caselle di testo; queste ultime ora mantengono paragrafi distinti. Parser OOXML bounded in docx_reader.py, renderer DOM passivo e CSS isolato; nessuna nuova dipendenza di runtime. Accesso registrato per ID, confinamento, token, same-origin e CSP invariati. Immagini incorporate trasferite nel JSON validato, convertite in blob e revocate alla chiusura.

## Verifiche
- 40 test backend e 45 frontend superati. Quattro nuove regressioni: ereditarietà/override stili, ordine nelle caselle di testo, elenchi/tabelle/immagini, XML non sicuro e confronto corpus. La regressione di compatibilità preesistente verifica ora il testo senza imporre l'assenza dei nuovi attributi.
- Quattro DOCX locali: testo completo e ordine confrontati con tutti i w:t dell'OOXML, scegliendo una sola rappresentazione di compatibilità; SHA-256 invariati (CORPUS.json). Regolamenti EN/PT: 441/446 blocchi e 43 immagini ciascuno; riepilogo PT: 26 blocchi e un elenco; riepilogo EN: un paragrafo con interruzioni come nell'originale.
- Microsoft Word: esportate copie PDF in outputs/app007, apertura read-only, AutomationSecurity=3, nessun salvataggio DOCX. Primo tentativo COM nel sandbox non disponibile (80070520); esportazione fuori sandbox autorizzata dal controllo automatico e riuscita. PDF di riferimento: 24/25/1/1 pagine.
- Confronto visivo delle copertine, corpo PT, riepiloghi e resa browser; immagini, font/dimensioni, grassetti/corsivi, colori, allineamenti e separazione del testo riconoscibili. Differenze di impaginazione esplicite; screenshot e PDF sono output locali di terzi esclusi da Git.
- Edge headless 1400/390 px: quattro documenti, tastiera/focus, nessun overflow, zero errori JS e zero richieste esterne; fixture titoli semantici, elenco, colspan, corsivo, tabella accessibile da tastiera e script reso come testo. BROWSER.json e app/test_app007_browser.cjs. Regressione test_material_browser.cjs superata (PDF/PNG/DOCX, filtri, paginazione e ritorno).
- Verificato git diff --check; modifiche preesistenti APP-006 preservate. Database/materiali/schema invariati. Nessuna rigenerazione A/B necessaria.

## Limiti e decisioni
Resa HTML in flusso adattabile. Non garantisce paginazione, posizionamenti flottanti, forme/crop/rotazioni, font non installati, colonne, header/footer, note, campi o revisioni. Tabelle: contenuto, formattazione e colspan; unioni verticali e layout esatto non ricostruiti. Numerazioni semplici; restart/override, romani/lettere e nesting multilivello non equivalenti a Word. Caselle di testo seguono l'ancoraggio nel flusso, senza geometria flottante. Limiti mostrati nel lettore e dettagliati in app/README.md.
L'incremento mantiene architettura e schema: migliora il contratto JSON del lettore esistente. APP-005 resta storicamente conclusa; registro APP-007 e cruscotto aggiornati prima della chiusura.

## Prossimo passo
Verifica utente del DOCX segnalato nell'app aggiornata. Un eventuale requisito di impaginazione Word identica va trattato in un incremento distinto, con generazione offline di derivati tracciati.
Git: nessun commit/push eseguito. Incremento pronto per commit insieme o separatamente da APP-006 dopo autorizzazione; messaggio suggerito: Fix APP-007 DOCX formatting and embedded images.

- 2026-10-04: utente autorizza commit e push su main; inclusi APP-006 e APP-007 conclusi. Verificati diff, file inattesi ed esclusioni: database, originali e output di terzi restano fuori Git.
