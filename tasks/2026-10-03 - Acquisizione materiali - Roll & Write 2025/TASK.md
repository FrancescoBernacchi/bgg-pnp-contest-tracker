# Acquisizione materiali - Roll & Write 2025

- Apertura: 2026-10-03.
- Stato: concluso il 2026-10-03 nel perimetro delle risorse dichiarate, con limiti remoti espliciti.
- Tipo standard: Acquisizione materiali del contest; unica unità Roll & Write 2025.
- PWS 1.5.0 allineato; main pulito e allineato a origin/main.
- Predecessore: analisi 37/37 WIP del 10 settembre 2026, 82 risorse dichiarate. Children & Family concluso; nessuna acquisizione Roll & Write aperta individuata.
- Selezione autorizzata: tutte le 37 entry e tutti i file di gioco pubblicamente offerti dalla fonte dichiarata.

## Contratto

Verificare destinazioni e condizioni osservabili, enumerare materiali correnti, acquisire originali senza alterazioni, preservare versioni, produrre manifest con URL, data, MIME, dimensioni e SHA-256. Video, implementazioni online e promozioni esclusi; accessi ristretti e limiti tecnici non vengono aggirati. Nessuna redistribuzione. File e database fuori Git.

## Successo

Esito esplicito per 37 entry e ogni risorsa pertinente; hash e formato verificati per tutti i file; applicazione idempotente provata su copia e backup SQLite; integrità e chiavi esterne verificate; cruscotto rigenerato e chiusura con limiti e prossimo passo.

## Risultato e provenienza

- Rilevamento e acquisizione: 2026-10-03, a partire dagli URL autorevoli già dichiarati nei WIP BGG il 2026-09-10. Gli URL per singola entry e risorsa sono conservati nel manifest.
- 37/37 entry riconciliate: 27 con acquisizione dalle risorse pertinenti, 2 con limiti di distribuzione residui, 1 con accesso ristretto e 7 senza file dichiarati nella precedente analisi.
- 29 giochi con almeno un file, 146 record locali: 133 PDF, 7 PNG, 4 DOCX e 2 ZIP; 1.452.794.942 byte registrati, inclusi gli archivi e i rispettivi membri stampabili estratti.
- 61 osservazioni di disponibilità; 21 collegamenti a video, implementazioni o strumenti online esclusi esplicitamente. I duplicati dello stesso percorso sono riconciliati conservando le menzioni delle fonti aggiuntive.
- Cartelle Google Drive enumerate anche nei sottolivelli: esclusi archivi storici, TTS, schede promozionali e immagini di titolo. File correnti A4/Letter, colore/low ink e varianti sono mantenuti separati.
- Fortify!: conservato ZIP pubblico Dropbox e nove PDF membri estratti senza alterazione. Leaning Tower: conservato ZIP pubblico, PNG e PDF membri. Il verificatore confronta ogni membro con il suo archivio originale.
- Yadoya: cartella Proton pubblica enumerata nel browser; due PDF acquisiti usando i pulsanti Scarica. Conferma UI: 2/2 trasferimenti completati. Copie dal percorso Downloads alla libreria, senza rimuovere i download dell'utente.
- I quattro file DOCX di 1899–1907 Black Death Brazil sono identificati mediante struttura OOXML, senza esecuzione o conversione; preservati anche i percorsi iniziali del trasferimento annotati nel manifest.
- Gli URL di download HTTP conservati sono destinazioni di trasferimento riproducibili; i redirect temporanei non sono stati conservati. Il manifest distingue questa limitazione tramite `final_url_note`. Nessuna licenza aperta è stata inferita dall'accessibilità pubblica; copie personali senza redistribuzione.

## Limiti espliciti

- Dawn Chorus: il browser Drive richiede autorizzazione. Nessuna richiesta di accesso inviata.
- Labyrinth of Shadows: regolamento Google Docs acquisito; la pagina Substack corrente non offre più un link puntuale ai fogli del gioco, e il profilo Itch collegato non mostra il titolo.
- Rolling Fiefdoms: acquisiti regolamento, fogli e sfide pubblici Drive; nessun trasferimento gratuito dalla risorsa PnP Stash. Questo collegamento resta incerto, separato dai file effettivamente acquisiti.
- Lithomacy, A Dragon's Die, INFRARED, Necromancy: Roll Them Bones!, The Thirteenth Dimension, STRATOS e Wizard's Tutelage: nessuna risorsa di gioco dichiarata nel primo post del rilevamento precedente. Il tentativo di lettura BGG corrente incontra il challenge Cloudflare; non è stato aggirato e non si afferma che non esistano materiali altrove.
- Anteprima interna: i PNG, DOCX e ZIP sono registrati e disponibili localmente, ma l'app segnala il formato non supportato. Richiedono task autonomi di visualizzazione secondo PROJECT.md; nessuna modifica al contratto PDF in questa acquisizione.
- `Starter_Cards.pdf` di Whispervale (258.021.701 byte) supera il limite interno di 128 MiB. Originale valido e conservato, apribile con un lettore esterno.
- Lingua `und` mantenuta quando non accertata; versione tratta dal nome quando esplicita. Nessuna lettura sistematica delle regole o integrazione dell'inventario materiali eseguita.

## Verifiche e registrazione

- Manifest: `catalog/2025_roll_write_acquisition_batch_2026-10-03.json`.
- Raccolta incrementale: `acquire_2025_roll_write.py`, `complete_2025_roll_write.py`, `finish_2025_roll_write_downloads.py`; riconciliazione locale: `finalize_2025_roll_write_manifest.py`. Gli script usano solo risorse dichiarate e collegamenti pubblici osservati.
- Applicatore e verificatore: `apply_2025_roll_write_acquisition.py`, `verify_2025_roll_write_acquisition.py`. Prova su copia e seconda applicazione: 29 acquisizioni, 146 file, 61 osservazioni, nessun duplicato.
- La prima prova ha individuato l'etichetta non ammessa `restricted`: corretta nel manifest in `access_restricted` prima dell'applicazione operativa; la transazione fallita è stata annullata integralmente.
- Backup operativo: `database/pnp_collection.pre-roll-write-acquisition-20261003.sqlite3`, SHA-256 `CA9E0EE2C6C6001FE65A7B5CE86BA460C14A004AE3B298C43DD503D9C9BAFDC0`.
- Verifica operativa: 146/146 hash e dimensioni coincidenti, terminatori PDF presenti, CRC ZIP/DOCX validi, struttura Word presente, membri estratti coincidenti byte per byte. `foreign_key_check` vuoto e `integrity_check = ok`.
- Totali operativi: 46 giochi/acquisizioni e 187 file. API Libreria in sola lettura: 187 presenti, zero mancanti o non verificabili; Roll & Write 146. Visualizzatore: 173 PDF idonei, 13 formati non supportati e 1 PDF oltre soglia.
- Sezioni annuali A/B rigenerate con `app/generate_project_progress.py`; righe qualitative aggiornate preservando modifiche di altre attività contemporanee.
- Suite app: inizialmente 28/29 test backend e 34/34 frontend. L'unico fallimento era preesistente nell'integrità degli asset PDF.js: 15 file del checkout convertiti in CRLF da Git. Tutti tornano esattamente agli hash del manifest sostituendo CRLF con LF. Ripristinati i byte originali e aggiunta `.gitattributes` con `app/static/vendor/pdfjs/** -text`; nessuna modifica di contenuto o aggiornamento della libreria. Tutti i 7 test PDF backend rieseguiti e superati; i restanti 22 erano già passati. Sintassi script e `git diff --check` verificati.
- Database, backup, originali e output temporanei esclusi da Git; nessun commit, branch o push eseguito.

## Chiusura e prossimo passo

Acquisizione conclusa con esiti documentati, senza trasformare i blocchi in assenza certa. Prossima acquisizione suggerita: task autonomo **Acquisizione materiali - 1-Card 2025**, già analizzato. Per consultare tutte le nuove tipologie nell'app serve invece un task autonomo di visualizzazione PNG/DOCX; il PDF molto grande richiede una valutazione separata del limite di memoria. Nessun monitoraggio ordinario aggiunto per il contest storico.

Commit e push su main autorizzati esplicitamente dall'utente il 2026-10-03. Messaggio: `Acquisisci materiali Roll & Write 2025 e preserva hash PDF.js`. Includere soltanto manifest, script, task, cruscotto e `.gitattributes`; preservare separati i file di altre attività contemporanee. Database e materiali restano esclusi da Git.
