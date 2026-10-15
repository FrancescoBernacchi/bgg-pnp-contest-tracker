# TSK-0088 — IMG - 9-Card Nanogame 2025

Apertura: 2026-10-14. Stato: completato. Modalità: circoscritto, su_richiesta.

## Richiesta e continuità

L'utente corregge «scarica i materiali» in «acquisisci immagini» e richiede la correzione del titolo. La verifica iniziale dei 56 originali ACQ ha confermato presenza, dimensioni e SHA-256. TSK-0087 resta concluso e immutato: questo è il workflow autonomo IMG, non una riapertura ACQ. Titolo precedente di questa chat: T0087-26.10.13 - ACQ - 9-Card Nanogame 2025; corretto in T0088-26.10.14 - IMG - 9-Card Nanogame 2025.

## Contratto

Un solo contest: 9-Card Nanogame 2025, contest_id 13. Selezione deterministica dei 17 giochi con esito ACQ complete nel manifest catalog/2025_nine_card_ranked_acquisition_2026-10-13.json. Esclusi Dragons Horde (demo parziale) e Three Buccaneers (bloccato). Ricerca immagini in WIP/aggiornamenti, gallerie e pagine direttamente collegate; estrazioni fedeli da materiali già acquisiti, confronto revisioni e varianti, deduplicazione con provenienze conservate. Nessuna AI richiesta, nessun nuovo pacchetto ACQ, censimento o sviluppo APP/schema, commit/push.

Deliverable: selezione con ID, inventario fonti/materiali e limiti, manifest IMG, immagini locali con hash e provenienza, componenti/lati/occorrenze dove pertinenti, verifica visiva, importazione verificata nel modello 014 e controllo app/avanzamento. Successo per gioco: ricerca conclusa nel perimetro effettivamente osservato e limiti espliciti, mai completezza universale. Importazione inclusa nell'autorizzazione IMG secondo decisione 2026-10-11, previa copia/backup/ripristino/transazione/replay.

## Verifiche iniziali

PWS consumer/canonico 1.5.0, preflight locale riuscito con avviso PowerShell InitializeDefaultDrives che non impedisce letture. Main senza divergenza dal riferimento locale origin/main; server remoto non ricontrollato. Numerose modifiche preesistenti preservate. Nessun IMG del contest già registrato; successivo ID libero TSK-0088. Browser inizializzato su about:blank.

Skill applicate: game-image-acquisition, base bgg-contest-navigation e riferimenti fonti/estrazione; PDF per ispezione/estrazione dai documenti, computer-use per navigazione. Efficacia da valutare a conclusione dell'incremento.

## Prossimo passo

Enumerare i materiali dei 17 giochi e osservare le fonti immagini; collaudare estrazioni e confronto visivo prima della catalogazione.

## Checkpoint iniziale — 2026-10-14

Inventario offline predisposto: 53 documenti per i 17 giochi, 198 pagine PDF. Hash degli originali verificati, contact sheet e testo di lavoro in outputs/tsk0088, esclusi da Git. Nessuna estrazione catalogata o importazione operativa effettuata.

9 RIP: osservate le pagine WIP 1 e 3 di 3 (54 post dichiarati); pagina 2, galleria e confronto versioni restano da svolgere. Aggiornamento del 2025-05-03 dichiara modifiche a tre carte, immagini 8862902/8862903/8862904; non dedurre equivalenza con i PDF dal solo nome versione. Pagina immagine 8862902 osservata: uploader Vova Semeniv @ftd86, didascalia card 1, data 2025-05-03, All rights reserved. Originale PNG dichiarato 1905×2640, 2357770 byte trasferito in C:/Users/39348/Downloads/pic8862902.png, con esito download verificato nel filesystem; sorgente https://boardgamegeek.com/image/8862902 e collegamento Original esposto dalla pagina. Il file è ancora materiale di lavoro da confrontare visivamente, non adottato/importato. Originale utente preservato. Il ritorno dell'operazione browser ha richiesto circa undici minuti: non confondere latenza del ritorno con download fallito.

Efficacia iniziale: skill IMG ha distinto selezione ACQ completa, versioni, ricerca parziale e adozione; PDF ha consentito inventario/render verificabili. Browser utilizzabile ma download con ritorno molto lento; nessuna nuova tecnica promossa. Il lotto IMG resta in corso: nessun gioco dichiarato completato, nessuna modifica alle metriche.


## Chiusura verificata — 2026-10-14

Richiesta «Riprendi e completa il lavoro» eseguita per tutti i 17 giochi selezionati. Il checkpoint iniziale sopra resta storia della prima interruzione, non stato corrente. Risultati e limiti in [RISULTATI.md](RISULTATI.md); verifiche in [VERIFICHE.json](VERIFICHE.json). Totale 175 originali distinti trasferiti, 336 estrazioni, 506 immagini catalogate dopo deduplicazione; 499 adottate e 7 non adottate. Importazione 014 e app verificate, nessun nuovo materiale PnP o sviluppo. Sigla operativa 9C registrata senza collisioni. Sezioni annuali A/B rigenerate dal database operativo; registro e cruscotto aggiornati nello stesso incremento.

Verifica efficacia: skill IMG e base BGG hanno mantenuto i confini e consentito il lotto completo dichiarativo con limiti; PDF e computer-use hanno consentito confronto e acquisizione degli originali. Problemi osservati: ritorno browser lento sul primo download; chiamata CUA a batch troppo lungo ha richiesto ripristino da evidenze salvate; la conversione raster CMYK nativa non rispettava il colore visibile, corretta con render PDF. QA ha respinto 15 isolamenti e corretto tre coordinate prima di importare. Cause: limiti della fonte/runtime e geometrie del lotto, non prova di difetto generale delle skill. Salvataggi per batch, controllo ID pagina prima di Original, render contestuale e QA su tutti i componenti hanno risolto i casi. Tecniche e limiti documentati negli script del task; nessuna generalizzazione automatica. Evidenza collegata a TSK-0048 per futura manutenzione delle istruzioni su CMYK e coordinate dei fogli duplex; nessun cambiamento contrattuale o a .agents.

Prossimo passo: eventuale incremento IMG su richiesta per fonti nuove o giochi aggiuntivi. Nessun controllo periodico dovuto per questo lotto concluso. Commit consigliato dopo revisione selettiva: `IMG: immagini 9-Card Nanogame 2025 per 17 giochi`. Nessun commit, push o altra modifica Git eseguita; modifiche preesistenti preservate.

Revisione pubblicazione: audit diretto dei 19 file nuovi del lotto, zero candidati euristici; controllo manuale di metadati, riepiloghi originali e collegamenti, senza dump dei post o binari. L'audit generale degli 812 file già tracciati segnala 299 candidati su 30 percorsi preesistenti: non attesta che l'intero repository sia pronto per pubblicazione. Report privati `outputs/tsk0088/publication-audit-new.json` e `publication-audit-tracked.json`. Nessun commit in uscita rispetto al riferimento locale origin/main; server remoto non ricontrollato. Servizi temporanei di salvataggio delle evidenze terminati, scheda app mantenuta aperta. Collegamento manutenzione: [TSK-0048](../2026-10-04%20-%20GPR%20-%20Gestione%20delle%20skill%20di%20progetto/TASK.md), evidenze concrete nella verifica efficacia sopra, senza modifiche alle skill.


## Commit e push — 2026-10-15

Autorizzazione esplicita utente: «commit e push», poi «continua». Commit dati `b1c6342be3c1d38adbf2d1faf192de76cea9bce2` su main: 22 file selezionati, manifest/fonti, script e documentazione del lotto, sigla 9C, sola voce TSK-0088 del registro e sola sezione/riga IMG 9-Card del cruscotto. Le altre modifiche pregresse dei documenti condivisi sono rimaste locali. Database, immagini e prove integrali esclusi tramite .gitignore e controllo della selezione.

Repository pubblico e branch main verificati tramite GitHub; fetch iniziale e confronto 0/0. Audit del contenuto selezionato e di tutti i commit in uscita: 22 file, zero rilievi; git diff --cached --check superato. Le 299 segnalazioni generali su altri 30 percorsi restano fuori dal commit. Push origin/main riuscito; ls-remote verifica direttamente l'hash b1c6342be3c1d38adbf2d1faf192de76cea9bce2 sul server e confronto 0/0. Questa attestazione è successiva al commit dati e ne documenta il risultato, senza anticipare l'hash del commit documentale che la contiene. Stato IMG completato e dati operativi invariati durante il salvataggio Git. Prossimo passo soltanto su richiesta: nuovo incremento IMG.
