# Categorie classifiche per contest

- Apertura: 2026-10-03.
- Stato: concluso.
- Segnalazione: APP-001, registro segnalazioni app.
- PWS: 1.5.0, allineato alla copia canonica.

## Scope e criteri di successo

Correggere esclusivamente i filtri della vista Classifiche dei contest: categorie limitate al contest selezionato, precedenza e preselezione overall, ordine alfabetico delle altre categorie e transizione coerente fra contest. Preservare etichette originali e dati storici. Il registro è attivo ma non implementativo; questo incremento autonomo ne realizza APP-001.

## Input e deliverable

Registro APP-001, frontend esistente e classifiche locali. Deliverable: correzione frontend, test delle transizioni e di contest con una/più categorie, documentazione, registro aggiornato e cruscotto strumenti. Nessuna modifica a database o fonti esterne.

## Risultato e verifiche — 2026-10-03

Frontend corretto senza query, API, schema o dati modificati. Menu ricostruito al cambio contest e pagina azzerata; categoria valida conservata, altrimenti prima overall disponibile. Tutte le categorie resta selezionabile. Priorità alle etichette contenenti la parola overall, poi ordine alfabetico italiano; confronto trim/lowercase separato dalla grafia originale. Lo schema non ha un campo category_normalized: nessuna categoria equivalente viene fusa. Ordinamento risultati coerente nella sola vista classifiche.

37 test frontend/PDF superati, inclusi menu e handler onchange con DOM simulato, contest con più/una/zero categorie, categoria estranea, cambio contest, pagina e grafia preservata. node --check e git diff --check superati. Database operativo letto in sola lettura: tutti i contest con classifiche hanno almeno cinque categorie; il caso singola categoria è quindi sintetico. Etichette reali Best Overall Game/Best Overall verificate. Nessuna prova browser visiva eseguita; struttura e CSS invariati.

Aggiornati app/static/app.js, app/test_frontend.cjs, app/README.md, registro APP-001 e stato strumenti in PROJECT_PROGRESS.md. Sezioni annuali non rigenerate: dati invariati. Nessuna operazione Git mutativa eseguita. Prossimo passo utile: provare la vista nell'app e scegliere una successiva segnalazione in un task separato.
