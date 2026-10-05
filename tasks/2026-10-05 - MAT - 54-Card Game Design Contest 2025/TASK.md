# TSK-0053 — 54-Card Game Design Contest 2025

Apertura: 2026-10-05. Categoria MAT, circoscritto, su richiesta. Stato: in_corso.

## Contratto

Censimento materiali del solo contest 19: tutte le 28 entry già catalogate. Input: roster BGG GeekList 360114, database e osservazioni pregresse. Lettura integrale del primo post originale dei WIP; risorse dichiarate, menzioni, requisiti senza URL, provenienza e data. Host esterni, file, download, risposte successive e modifiche roster esclusi. Copertura first_post_only; tassonomia provvisoria.

Deliverable: evidenze datate per entry, importazione riproducibile verificata su copia, rapporto, database e cruscotto aggiornati. Successo: 28 esiti espliciti; completezza attestata solo dopo lettura integrale, blocchi separati.

## Apertura e continuità

PWS locale/canonico 1.5.0; preflight sandbox riuscito. Main con modifiche preesistenti preservate, nessuna operazione Git autorizzata. TSK-0005 roster concluso. TSK-0009 è un contenitore MAT storico multi-contest con futura prosecuzione per singolo contest: questo task ne segue le evidenze senza ampliarlo o duplicare una scansione 54-Card già eseguita. TSK-0051 riguarda soltanto 9-Card.

Skill applicate: bgg-contest-navigation e bgg-material-census, playbook e inventario letti. Browser inizializzato su about:blank; verifica automatica Cloudflare conclusa senza intervento. GeekList osservata: 28 righe su due pagine, 28 URL WIP risolti dalle intestazioni.

Titolo visibile impostato: 2026-10-05 - MAT - 54-Card Game Design Contest 2025.

## Risultati e chiusura — 2026-10-05

Stato: completato. Le 28 entry locali 704–731 corrispondono alle 28 righe del roster ufficiale, tutte con WIP individuato e primo post originale osservabile. 19 URL WIP precedentemente null aggiunti; gli URL già registrati preservati. Autore e timestamp originale verificati; le modifiche al primo post sono incluse nella lettura corrente, senza attestare consultazione delle risposte.

27 entry con risorse dichiarate, 1 none_declared per soli collegamenti (Villains Incorporated); 86 URL esatti distinti per entry, 89 menzioni originali, 46 requisiti. Tutte le 28 scansioni materiali osservate; tutte le 28 attestazioni MAT complete. Quantità normalizzate separate dal contesto: Braggarts 3×9 teste e code; totali e sottogruppi non sommati due volte. Requisiti base, opzionali, espansioni e alternative separati. Nessun dado fisico inferito dalle carte dado e nessun utensile di montaggio inferito dalla stampabilità.

Varianti di URL dello stesso video/cartella preservate e annotate; 86 URL non equivalgono a 86 contenuti o file. Potemkin Villages dichiara la pagina file BGG del gioco. Racket richiede dorsi per entrambe le versioni; Tower Guard dichiara un JSON TTS alternativo. Per Surfboard Stealin’ Sea Otters la gratuità è dichiarata limitata alla durata del contest: condizioni/disponibilità correnti da verificare soltanto in ACQ. Ranicide conserva un video intitolato The Sixth Crypt, senza inferire rinomina canonica. La tassonomia resta provvisoria e la copertura first_post_only.

## Deliverable e verifiche

- `EVIDENCE.json`: esiti per entry, provenienza puntuale articolo, autore, timestamp, menzioni, contesti, quantità, versioni e note.
- `catalog/build_2025_54_card_materials.py`, SQL corrispondente e `catalog/verify_2025_54_card_materials.py`: importazione offline riproducibile e idempotente.
- `sources/2025-54-CARD-MATERIALS.md`: rapporto e limiti.
- `VERIFICATION.json`: confronto con 28 fingerprint URL e 28 fingerprint delle menzioni (URL/etichetta) calcolati sul DOM osservato; tutti coincidenti. Fingerprint non costituiscono snapshot integrale del testo: l'evidenza versionata conserva estratti pertinenti, non copie complete dei post.
- Importazione verificata prima su copia e poi sul database operativo, dopo backup in outputs escluso da Git. Integrity check ok, zero violazioni FK, seconda applicazione senza variazioni; tutte le righe pregresse e tutti i dati degli altri contest, classifiche, acquisizioni e file preservati.
- Sezioni annuali A/B rigenerate; pipeline qualitativa aggiornata: 289/509 entry 2025 con scansione registrata, distinta dalla completezza.
- Browser locale: tutte le 28 entry mostrano lettura registrata; Villains Incorporated mostra separatamente nessun URL dichiarato e due requisiti 42/12. Nessun cambiamento all'app, nessun test di codice frontend necessario.

Nessun blocco MAT; le destinazioni sono dichiarate e non verificate. Non avviata automazione né aggiornato il calendario periodico: è un censimento del primo post di contest concluso. Nessun pattern nuovo da promuovere alle skill.

Prossimo passo utile: eventuale ACQ del solo 54-Card 2025 dopo selezione esplicita dei giochi; in alternativa MAT separato di Solitaire 2025. Incremento locale da committare; proposta messaggio `Censisci materiali dichiarati del 54-Card Contest 2025`. Nessun commit o push eseguito; modifiche preesistenti preservate.

## Versionamento verificato — 2026-10-05

Su richiesta utente «commit e push», commit 8de9833 su main, push riuscito e HEAD uguale a refs/heads/main sul server. Inclusi nove file del censimento e soltanto il relativo delta di registro/cruscotto; gli altri incrementi non committati preservati. Database, backup e outputs esclusi da Git. Esito registrato nel successivo commit documentale.
