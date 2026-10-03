# Layout PDF per orientamento

- Apertura: 2026-10-03.
- Stato: concluso il 2026-10-03.
- Segnalazione: APP-002; incremento autonomo del registro esistente.
- PWS: consumer e canonico 1.5.0; main pulito e allineato a origin/main all'apertura.

## Scope e deliverable

Layout PDF stabile secondo orientamento prevalente, comandi a sinistra per portrait, area superiore compatta, adattamento a larghezza e altezza e comportamento responsive. Nessuna modifica a originali, database, accessi HTTP o altre segnalazioni. Codice, prove, documentazione, registro e cruscotto aggiornati.

## Criteri di successo

Conteggio su tutte le pagine con dimensioni del viewport (rotazione dichiarata inclusa). Quadrate escluse; pareggio risolto dalla prima pagina non quadrata, tutte quadrate portrait. Layout invariato nella navigazione; zoom esplicito preservato. Verificare maggioranze, pareggi, quadrate, cancellazione e dimensioni disponibili, oltre alle suite esistenti e alla resa desktop/stretto.

## Risultati e verifiche

Modificati app/static/app.js, pdf-viewer.js e style.css: rimossa intestazione ridondante del lettore, colonna comandi e canvas affiancati per portrait sopra 900 px, toolbar compatta landscape, fit a larghezza/altezza e resize. Pagina quadrata esclusa dalla maggioranza; pareggio prima non quadrata, tutte quadrate portrait. Zoom numerico e controlli/tastiera esistenti preservati. Analisi sequenziale senza rendering complessivo; controlli di cancellazione impediscono aggiornamenti dopo uscita.

- `node --test app/test_pdf_frontend.cjs app/test_frontend.cjs`: 39 test superati.
- `python -m unittest discover -s app -p test_pdf_viewer.py`: 7 test superati; token, confinamento e asset invariati.
- `outputs/check-pdf-layout.cjs`: DOM/CSS reali con pagine simulate, 1400/1100/800/390 px, portrait e landscape, pagina alternativa di orientamento opposto: dimensioni contenute e layout stabile.
- `outputs/check-pdf-real.cjs`: server fixture 8772, Edge headless, PDF.js locale, PDF sintetici reali portrait/landscape/misti, 1400/390 px, pagina 1 e 2. Sei casi superati, nessun errore JavaScript, nessun overflow orizzontale. Screenshot `outputs/pdf-viewer-browser-fixtures/app002-*.png`; esaminati desktop portrait e mobile landscape.
- La prova completa ha rilevato il restringimento eccessivo dei campi toolbar mobile; corretto con basi minime per pagina/zoom e ripetuta con successo.

CUA non inizializzabile per errore runtime `apply deny-read ACLs`; non modificati ACL o configurazione. Verifica browser completata mediante Edge headless locale disponibile, senza installazioni. Le prove visive usano fixture sintetiche, non certificano ogni PDF acquisito. Documenti molto lunghi richiedono l'ispezione iniziale di tutte le pagine; finestre molto basse hanno una superficie minima di 180 px e possono richiedere scorrimento esterno. Nessun file originale o database operativo modificato; solo fixture sotto outputs.

Aggiornati README app, registro APP-002 (chiusa) e salute strumenti nel cruscotto; sezioni annuali non rigenerate perché dati invariati. Nessuna operazione Git mutativa. Prossimo incremento utile: APP-003 in un task dedicato oppure APP-005 coordinata con il layout ora disponibile. Commit suggerito: `Adatta il lettore PDF all'orientamento prevalente`.
