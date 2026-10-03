# Visualizzatore PDF locale nell'app

- Apertura: 2026-10-03.
- Stato: concluso (implementazione e verifiche locali; finalizzazione Git autorizzata).
- Tipo: evoluzione autonoma non BGG, successiva al task Libreria concluso.
- Base: eb95408, checkout pulito e allineato a origin/codex/libreria-locale-materiali; PWS 1.5.0 allineato.
- Branch autorizzato: codex/visualizzatore-pdf-locale.

## Contratto prima dell'implementazione

- Scopo: leggere nell'app i PDF acquisiti, mantenendo originali e database intatti.
- Input: acquisizioni/file operativi, library autorizzata, API e frontend della Libreria, requisito multiformato di PROJECT.md.
- Deliverable: pulsante nelle due viste, lettore con pagina/zoom/ritorno, endpoint limitato agli ID registrati, renderer locale documentato, prove backend/frontend/browser e documentazione.
- Esclusioni: altri visualizzatori, richieste a risorse remote, apertura Windows, modifica dei dati/originali, migrazioni, commit/push/merge/PR.
- Autorizzazione: eccezione esplicita al divieto di byte/anteprime HTTP esclusivamente per PDF registrati e validati; nessun file server generico.
- Criteri di successo: percorso ricontrollato a ogni richiesta e mai esposto; richieste estranee respinte; nessun script/link/allegato eseguito dal documento; gestione degli errori e cancellazione; metadati/versioni conservati.
- Verifiche previste: suite intera e nuove fixture, due PDF operativi nel browser (BGG/Kanare), tastiera e schermo stretto, conteggi e integrità SQLite, hash database/originali, Git e licenze.

## Registro e decisioni

- 2026-10-03: preflight completato e titolo cumulativo della chat aggiornato. Nessun task PDF preesistente da riprendere. Ricerca su documentazione e release ufficiali del renderer prima di scegliere la dipendenza.

## Implementazione e decisioni finali

- PDF.js 6.3.289, core e worker locali, Apache-2.0 e licenze delle risorse conservate. Sorgente npm ufficiale verificata tramite SHA-512; manifest locale con SHA-256 per 201 asset (6.149.523 byte). Nessun CDN, generic viewer, sandbox scripting o QuickJS. Script riproducibile `app/vendor_pdfjs.py`, mai eseguito dal runtime dell'app.
- Verifica ufficiale del 2026-10-03: https://github.com/mozilla/pdf.js/releases/tag/v6.3.289 e https://mozilla.github.io/pdf.js/api/draft/module-pdfjsLib.html . Parametri verificati: isEvalSupported, useWorkerFetch, useWasm, stopAtErrors, canvasMaxAreaInBytes e maxImageSize. Quest'ultimo resta -1 per non omettere silenziosamente immagini grandi.
- API esclusivamente per ID registrati: sessione effimera in header, same-origin, MIME e acquisizione, confinamento del percorso e handle finale, rifiuto traversal/alias NTFS/reparse point, header/footer PDF, limite 128 MiB. Niente path nell'API, Range o file server generico; no-store, nosniff e CSP dedicata.
- Pulsante nella Libreria e nei materiali della scheda gioco; metadati, pagine, selettore, zoom, fit, tastiera, testo estratto sicuro, ritorno al contesto. Cancellazione di fetch/render e cleanup al cambio vista. Registro dei visualizzatori estendibile per formati futuri.
- Rendering solo canvas e testo: nessuna azione, script, collegamento o allegato del documento. PDF cifrati non supportati; errori espliciti per file mancanti, corrotti, non PDF, non autorizzati o troppo grandi. Canvas limitato a 16 MP e resize immagini OffscreenCanvas 64 MiB; la decodifica può richiedere memoria aggiuntiva.

## Verifiche e risultati

- Suite Python completa: 29 test superati. Suite Node completa dopo l'ultima modifica: 34 test superati, nessun fallimento o skip. Test dedicati coprono endpoint, confinamento, token, header, HEAD/Range, hash, licenze/asset, errori, cancellazione, paginazione, zoom, testo e receiver fetch.
- Browser reale locale: BGG Allmende (3 pagine), Kanare Pentwall (2 pagine), Good Breeding Cards (15 pagine, 49.880.064 byte). Verificati pagina successiva, zoom 150%, tastiera, ritorno alla Libreria e alla scheda gioco, filtri e viewport 390x844 senza overflow orizzontale.
- Fixture originali generate in outputs: PDF con OpenAction JavaScript e testo simile a HTML, PDF AES-256 cifrato, PDF malformato e file mancante. Nessun dialogo/script; testo letterale; messaggi corretti. Server fixture arrestato e tab chiusa.
- Database in sola lettura: integrity_check ok, foreign_key_check vuoto, SHA-256 database invariato ca9e0ee2c6c6001fe65a7b5ce86ba460c14a004ae3b298c43dd503d9c9bafdc0. Tutti i 41 hash originali identici alla baseline. Restano 17 acquisizioni, 17 giochi, 41 PDF (38 BGG e 3 Kanare), 173.596.698 byte.
- Evidenze locali ignorate da Git: outputs/pdf-viewer-baseline-2026-10-03.json e outputs/pdf-viewer-qa/{kanare-pentwall,bgg-good-breeding}.png. Server di verifica operativo lasciato su 127.0.0.1:8771 con tab lettore disponibile.
- Documentazione aggiornata insieme: PROJECT, mappa AGENTS, stato workspace, README app/library, licenze e cruscotto. Sezioni annuali generate del cruscotto intatte: nessun dato da rigenerare.
- git diff --check superato; database, library e outputs esclusi da Git, nessun PDF/SQLite/ZIP tracciato. I soli binari nuovi versionabili sono risorse software PDF.js con manifest e licenze, non materiali dei giochi.
- Branch codex/visualizzatore-pdf-locale, base eb95408. Nessun commit, push, merge, PR o review formale eseguito. Messaggio proposto: Aggiunge il visualizzatore PDF locale protetto.

## Prossimo incremento

Autorizzazione distinta per commit/push dell'incremento verificato. Aggiungere visualizzatori per nuovi formati soltanto quando compaiono materiali corrispondenti, mantenendo il registro estendibile e definendo un contratto sicuro specifico.

## Finalizzazione Git autorizzata

- 2026-10-03: utente autorizza commit, push e unione in main. Fetch completato: origin/main è antenato del branch, senza divergenze. Finalizzazione mediante commit dell’incremento, push del branch, fast-forward di main e push di main; controllo finale di allineamento e working tree. Include anche la Libreria eb95408. Nessun materiale operativo incluso.
