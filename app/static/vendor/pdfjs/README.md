# PDF.js vendorizzato

- Versione fissata: **6.3.289**, verificata il 2026-10-03.
- Fonte: https://registry.npmjs.org/pdfjs-dist/-/pdfjs-dist-6.3.289.tgz
- Release ufficiale: https://github.com/mozilla/pdf.js/releases/tag/v6.3.289
- API ufficiale: https://mozilla.github.io/pdf.js/api/draft/module-pdfjsLib.html
- Licenza principale Apache-2.0, copia integrale in `LICENSE`. Le licenze dei CMap, font, decoder e profili sono mantenute nelle rispettive sottocartelle `cmaps`, `standard_fonts`, `wasm`, `iccs`.

Distribuzione limitata al core `build/pdf.mjs`, worker, CMap, font e asset di decodifica/colore: il viewer generico e il sandbox JavaScript non sono inclusi; QuickJS è escluso. Nessun eseguibile di sistema o pacchetto npm viene installato. I due riferimenti ai source map sono rimossi, nessun'altra modifica al codice upstream. Il renderer è codice software con licenza, separato dai materiali dei giochi esclusi da Git.

`MANIFEST.json` registra integrità SHA-512 del tarball e SHA-256/dimensione di ogni asset distribuito. La procedura riproducibile è `app/vendor_pdfjs.py`, da eseguire esplicitamente durante manutenzione: il server non la invoca e non verifica aggiornamenti online. La allowlist HTTP è ricavata dal manifest con nomi vincolati; README e manifest non diventano un file server generico. Ogni aggiornamento del renderer richiede revisione delle release, licenze, opzioni di sicurezza e test, incluse prove browser.

L'app usa la sola API core: byte caricati da endpoint locale autenticato, `isEvalSupported:false`, XFA e WASM disabilitati, font/CMap richiesti solo da percorsi locali fissati, nessun layer di annotazioni, script, allegati o azioni. Il testo estratto viene assegnato a `textContent`. Il rendering per pagina non è una sanificazione o modifica del PDF originale.
