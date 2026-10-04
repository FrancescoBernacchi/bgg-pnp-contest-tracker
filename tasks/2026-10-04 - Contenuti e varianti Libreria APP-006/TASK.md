# APP-006 — Contenuti e varianti Libreria

- Apertura: 2026-10-04.
- Stato: concluso il 2026-10-04.
- Incremento autonomo successivo ad APP-005 conclusa; registro segnalazioni attivo, nessun task duplicato individuato.
- PWS: aligned_version e VERSION canonica 1.5.0; main allineato a origin/main, working tree inizialmente pulita.

## Scope e criteri
Presentazione Libreria: icone per funzione, descrizione compatta, varianti documentate e legenda; originali, hash, versioni, dati e visualizzatori preservati. Nessuna attività BGG esterna o acquisizione.
Input: registro APP-006, corpus locale, metadati API, frontend APP-005.
Deliverable: classificazione conservativa, UI e dettagli di evidenza, test, documentazione e cruscotto aggiornati.
Successo: categorie rappresentative e miste, attributi ignoti e varianti verificati; routing dei lettori invariato, accessibilità e responsive controllati.

## Esame del corpus
Nomi locali mostrano rulebook/manual/rules/regras, cards/cartas, board/map, player boards, sheet/playsheet, tokens/scoring tiles, tuckbox e printing instructions. Adottate anche schede di gioco, segnalini, scatola e istruzioni di stampa. Una corrispondenza nel nome è un'inferenza, non una verifica del contenuto. Nomi opachi restano non determinabili; non si interpretano abbreviazioni come PS/FCMX o P1.
Varianti osservate: EN/ENG/English, pt-BR/Português, color/colour, black-white, gray-scale, low ink, printer friendly, A4/LTR/Letter. Low ink e printer friendly non implicano bianco e nero. Nessun DPI desunto dalla dimensione. Non è necessario consolidare una tassonomia dati: la classificazione è derivata nella presentazione e consultabile nei dettagli.

## Risultati e verifiche
- Implementazione in app/static/app.js e style.css; convenzione e legenda documentate in app/README.md. Nessuna modifica permanente all’architettura o allo schema.
- 45 test frontend/PDF e 36 test backend superati. Due test nuovi coprono funzione indipendente dal formato, player board prima di board, misti, ignoti, lingua registrata prioritaria, colori, low ink, DPI/pixel e qualità non desunta dai byte.
- Edge headless 1400/390 px: test_material_browser.cjs e test_app006_browser.cjs superati. Tastiera, paginazione 50+2 giochi, filtri, apertura PDF/PNG/DOCX, legenda e misti verificati; nessun overflow o richiesta esterna nelle prove dei lettori. Screenshot in outputs/app005-browser/app006-*.png.
- CORPUS.json registra tutti i 198 nomi/metadati osservati e 198 hash verificati, nessun errore. Originali non modificati.
- Registro APP-006 chiuso e PROJECT_PROGRESS.md aggiornato; nessuna rigenerazione A/B perché i dati operativi non cambiano.
- Limiti: contenuti non ispezionati pagina per pagina; funzione e attributi derivati dal nome restano inferenze esplicite, non verifiche editoriali. La tassonomia di presentazione può essere raffinata in seguito senza migrazione dati.
- Prossimo passo utile: revisione manuale dei materiali con nomi opachi e, se richiesta, introduzione di metadati editoriali verificati per file in un incremento dedicato.
- Git: nessun commit o push eseguito; incremento pronto per commit dopo revisione.
