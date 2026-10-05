# TSK-0065 — Immagini dei giochi e integrazione nell'app

Apertura 2026-10-05. EPR, secondarie APP/IMG. Circoscritto, su richiesta. Stato corrente: completato il 2026-10-05 (brainstorming e formalizzazione).

## Contratto
Brainstorming richiesto dall'utente: finalità, immagini da selezionare, fonti candidate, categorie, versioni, conservazione, provenienza e utilizzi nell'app. Deliverable: proposta discussa e decisioni esplicite prima di definire il workflow IMG. Nessun download o implementazione autorizzati da questo incremento.

## Verifiche
PWS locale e canonico 1.5.0; preflight riuscito. Registro consultato: workflow IMG ancora da definire, nuovo task EPR autonomo. Main ahead 1 rispetto a origin/main locale e molte modifiche pregresse preservate; remoto non verificato. Titolo chat rinominato. Inventario skill letto: nessuna skill pertinente al brainstorming puro; nessuna attività esterna BGG/FON/ACQ.

## Proposta iniziale, non deliberata
Una principale e fino a due secondarie utili per riconoscimento e comprensione. Tipi: copertina, setup, componenti, partita, dettaglio e diagramma; ruolo principale separato dal tipo. Fonti candidate: BGG, autore/editore, fonti adottate, eventuali derivati da materiali locali acquisiti. Verificare condizioni nella fase operativa. Originali con hash fuori Git, derivati separati; collegamenti a gioco e specifica versione/entry/prodotto. Miniature facoltative nelle liste, galleria con didascalie e provenienza nella scheda, zoom. Ricerca completata distinta dalla copertura immagini. Armonizzare precedente Kanare (principale acquisita, secondarie censite per URL). Possibile pilota futuro su pochi giochi di un solo contest, IMG e APP separati.

## Prossimo passo
Discutere priorità fra riconoscimento e comprensione del gioco, affinare la proposta e registrare le scelte dell'utente. Task aperto.

## Decisioni e requisiti espressi dall'utente — 2026-10-05
- Obiettivi entrambi: riconoscimento/estetica e comprensione pratica del gioco. Discussione un punto alla volta, proposta dell'agente e domanda di integrazione/modifica.
- La raccolta mira a tutte le immagini disponibili e utili del gioco o dei giochi del contest esplorato; il limite iniziale di tre immagini è superato. Selezione per l'app successiva alla raccolta.
- Fonti direttamente collegate al gioco/contest accettate, incluse estrazioni da manuali e materiali PnP da stampare e ritagliare.
- Componenti estratti separatamente: foglio con nove carte genera nove immagini distinte se i contenuti differiscono; nove dorsi identici generano un solo contenuto, preservando provenienza e occorrenze.
- Nella raccolta immagini escludere le varianti inferiori draft/bn/bassa risoluzione quando sono presenti equivalenti superiori qualità/colore/hi-res. Non alterare o eliminare i materiali originali acquisiti. Equivalenza, differenze di contenuto e priorità in conflitto da precisare nel workflow.
- Produrre una skill apposita per acquisizione immagini, inclusa estrazione complessa; sviluppo con skill-creator dopo definizione sufficiente del workflow, senza anticipare procedure non verificate.
- Fonti classificate con parola/frase/sigla breve; naming futuro include gioco, categoria e contest con sigla/anno.
- AI ammessa nel modello futuro come generazione ex novo e rielaborazione: possibili integrazioni per giochi o categorie senza immagini. Nessuna generazione richiesta in questo incremento.
- Tipologie aggiunte: Artwork (anche sfondi), Titolo grafico, Icona (anche generabile tramite AI per l'app).

## Proposta successiva da discutere
Separare fonte di reperimento (BGG-WIP, BGG-GAL, BGG-CON, AUT, MAN, PNP, AI, altre fonti identificate) da tipo di immagine e origine creativa. Per AI distinguere generata da rielaborata e mantenere riferimenti agli input. Per estrazioni mantenere documento/versione, pagina e regione del componente, incluse occorrenze duplicate. Domanda successiva: affinare la classificazione breve delle provenienze.

## Provenienze e classificazione concordate — 2026-10-05
L'utente accetta le etichette leggibili di provenienza: BGG-WIP, BGG-Galleria, BGG-Contest, Autore, Editore, Manuale, PnP, Kanare, Personale, AI-Generata, AI-Rielaborata. Altre fonti adottate avranno nome breve riconoscibile. Per estrazioni e rielaborazioni preservare la catena a monte nei metadati.

L'utente concorda su tutta la classificazione proposta:
- Copertina: gioco, confezione o regolamento.
- Titolo-Grafico: nome del gioco realizzato graficamente.
- Artwork: illustrazioni, sfondi ed elementi artistici.
- Icona: simbolo compatto identificativo del gioco, anche per l'app.
- Setup: disposizione iniziale.
- Partita: situazione durante il gioco, eventualmente con giocatori.
- Componenti: vista d'insieme di più componenti.
- Componente: singolo elemento; sottotipi possibili Carta, Plancia, Tabellone, Pedina, Segnalino, Dado, Tessera, Schermo; lato Fronte/Retro/Dorso quando pertinente.
- Dettaglio: ingrandimento significativo.
- Diagramma: schema esplicativo.
- Preparazione: stampa, ritaglio, montaggio e costruzione.

Una categoria principale per immagine usata nel nome del file, categorie aggiuntive nei metadati. Estrazioni separate collegate all'originale. Ruolo principale nell'app separato dalla categoria. Dorso condiviso unico collegato alle carte pertinenti. Tassonomia concordata nel brainstorming; implementazione e promozione completa del workflow ancora da definire.

Prossimo punto proposto: naming dei file, sigle contest/anno, identificatore stabile gioco, progressivo e versione; da discutere senza considerare adottato un formato anticipato.

## Naming approvato — 2026-10-05
L'utente approva il formato Gioco__Contest-Anno__Categoria__Provenienza__Numero__Versione.ext.
- Titolo leggibile con trattini al posto degli spazi; titolo originale e ID stabile nei metadati.
- Sigla contest in registro condiviso, anno a quattro cifre. Sigle puntuali da definire: 9C negli esempi resta illustrativa.
- Categoria principale con sottotipo/lato quando pertinenti; provenienze leggibili concordate.
- Numero stabile dell'immagine nel gioco; versione dell'immagine archiviata distinta dalla versione dei materiali di partenza, conservata nei metadati.
- Giochi senza contest: fonte al posto di Contest-Anno, per esempio Kanare.
- Un'immagine condivisa fra contest: unico file con tutti i collegamenti nei metadati; criterio di scelta del contest nel nome ancora da precisare.

Prossimo punto: regole di equivalenza e preferenza fra materiali prima dell'estrazione; tutela di contenuti distinti, originali preservati e verifica dei ritagli. Nessuna acquisizione o implementazione.

## Selezione materiali e lacune per AI — 2026-10-05
L'utente approva il criterio proposto di confronto prima dell'estrazione: equivalenti per componente e revisione, preferenza finale/colore/alta risoluzione/integrità, recupero di componenti unici da varianti inferiori, originali preservati. Differenze di contenuto o grafica registrate come varianti distinte, comprese vecchie revisioni; conflitti qualitativi da segnalare per scelta.

Nuovo requisito utente: tracciare facilmente i giochi che difettano di immagini in determinate categorie, per generarne automaticamente con AI alla bisogna e aggiungerle alle originali. Automazione intesa come futura funzione eseguita su richiesta, non pianificazione ricorrente o autorizzazione a generare ora.

Proposta da discutere: matrice gioco/categoria con ricerca non effettuata, originali disponibili, assenza verificata, soli risultati AI, originali e AI, non applicabile esplicito; contatori originali/AI separati. Filtri categorie mancanti e azione di generazione su lotto selezionato; mantenere rilevabile l'assenza di originali anche dopo integrazione AI. Selezionare categorie pertinenti al gioco, senza imporre tutte le categorie a tutti i giochi. Registrare origine generata/rielaborata e input. Artwork, Titolo-Grafico e Icona adatti a proposte creative; setup/componenti generati richiedono evidenza del gioco e verifica prima di presentarli come rappresentazione fedele. Proposta ancora da approvare.

## Copertura per categoria approvata — 2026-10-05
L'utente risponde OK alla proposta di tracciamento delle lacune: stati Da esplorare, Originali presenti, Assenza verificata, Solo AI, Originali + AI, Non applicabile; conteggi originali/AI separati. Filtri per categoria e assenza di originali, selezione lotto e generazione AI automatica su richiesta; immagini aggiunte senza sostituire originali né cancellare la lacuna di originali. Nessuna generazione autorizzata ora.

Accettata la proposta di Icona, Titolo grafico e Artwork come categorie desiderate per tutti i giochi; altre categorie definite caso per caso. Per Setup/Componenti generati, riferimenti sufficienti e verifica di fedeltà prima di presentarli come reali.

Nota progettuale per la futura implementazione: conservare ricerca (non effettuata/completata), applicabilità e disponibilità originale/AI come dimensioni indipendenti, per non perdere ricerca incompleta quando esiste già una immagine; etichette UI concordate sopra.

Prossimo punto: metodo di estrazione dei componenti PnP, confini dei ritagli, fronte/dorso, duplicati e controllo prima della catalogazione.

## Procedimento di estrazione approvato — 2026-10-05
L'utente conferma di procedere come suggerito nel brainstorming:
1. Individuare i componenti nella versione migliore dei materiali.
2. Estrarre ogni componente intero, preservando grafica/testo/bordo di gioco ed escludendo margini del foglio, crocini e istruzioni di stampa.
3. Separare fronte/dorso e collegarli; dorso comune unico associato a più componenti.
4. Deduplicare i contenuti effettivamente identici e registrare le occorrenze; differenze di numeri/simboli/testi preservate.
5. Verificare integrità del ritaglio, leggibilità, orientamento e classificazione prima della catalogazione.
Documento, pagina e regione di ritaglio conservati per riproducibilità. Componenti irregolari: prima estrazione rettangolare fedele; scontorno/trasparenza come derivato separato. Automazione nei casi chiari, segnalazione dei casi dubbi (sovrapposizioni, confini incerti, componenti multi-pagina).

La conferma approva il metodo; non identifica ancora un lotto operativo né richiede download o estrazioni in questo incremento. Prossimo punto: struttura della libreria per gioco, originali/estratti/AI/derivati, collegamenti contest e manifest. Proposta da discutere.

## Organizzazione libreria approvata — 2026-10-05
L'utente accetta la proposta: library/immagini/<ID-stabile>__<Titolo>/ con sottocartelle originali, estratti, ai, derivati. G000123 nell'esempio è illustrativo, non un ID assegnato o una nuova convenzione ID deliberata. File con naming approvato, senza sottocartelle per categoria; filtri dal catalogo. Organizzazione per gioco per evitare copie fra contest, collegamenti e titoli storici nei metadati. Manifest versionabile separato dai binari per provenienza, classificazione, hash, versioni e relazioni. Struttura approvata nel brainstorming; creazione fisica e integrazione architetturale da eseguire nel successivo incremento di definizione/implementazione, non anticipate ora.

Prossimo punto proposto: modalità di generazione AI su richiesta, preparazione contestuale dai dati del gioco, tracciabilità e revisione dei risultati prima dell'adozione nell'app. Nessuna generazione effettuata.

## Modalità AI chiarita e deliberata — 2026-10-05
Generazione iniziale tramite Codex confermata dall'utente: app per consultare lacune e risultati, richiesta nella chat per generare e registrare immagini nel lotto selezionato.
Generazione direttamente dentro l'app tracciata su richiesta come potenziale evoluzione APP autonoma: selezione giochi/categorie e avvio dalla UI, integrazione AI, credenziali, costi e scrittura/catalogazione da progettare. Nessuna implementazione o generazione avviata.
La proposta precedente di generazione dalla UI non è adottata nella fase iniziale. Revisione dei risultati o accettazione automatica ancora da concordare: la domanda precedente non ha ricevuto risposta.

## Validazione immagini AI approvata — 2026-10-05
L'utente richiede e approva una fase di validazione utente: risultati salvati e catalogati come Da valutare, presentati nella chat, adottati per l'app soltanto dopo approvazione esplicita anche per lotto. Nessuna adozione automatica. File generato distinto da immagine validata; proposta non approvata non copre la categoria ai fini dell'uso nell'app. Visibilità delle proposte nell'app da definire.
Prossimo punto: presentazione immagini nell'app e scelta della principale. Nessuna implementazione o generazione.

## Presentazione immagini nella app approvata — 2026-10-05
L'utente approva tutta la proposta:
- Miniatura principale nelle liste, nascondibile per mantenere righe compatte.
- Galleria nella scheda gioco filtrabile per categoria, zoom, didascalia, provenienza e versione.
- Vista componenti per sottotipo con collegamenti fronte/dorso.
- Provenienza AI visibile e proposte non validate in sezione separata.
- Riepilogo categorie mancanti e filtro trasversale fra giochi.
- Principale scelta esplicitamente e registrata nel catalogo; in assenza scelta provvisoria automatica privilegiando Copertina poi Setup.
La sezione proposte resta separata dalla raccolta adottata; validazione tramite Codex nella fase iniziale. Nessuna modifica app eseguita.

Prossimo punto proposto: perimetro operativo dei task IMG (singolo contest o fonte, possibile singolo gioco), riprese incrementali, tracciamento esplorazione e criteri di completamento. Workflow da deliberare prima dell'uso; non estendere MAT/ACQ/monitoraggio esistenti.

## Perimetro operativo approvato con limite Kanare — 2026-10-05
L'utente approva la proposta con precisazione vincolante:
- BGG: un task IMG per singolo contest e anno, incrementi su uno o più giochi; possibile acquisire un solo gioco senza completare immediatamente il contest.
- Kanare: task IMG della fonte con elenco esplicito dei giochi nel perimetro.
- Fonti future: il modello per fonte NON è confermato né generalizzato. Definire unità di lavoro e contratto alla valutazione della specifica fonte.
- Per gioco registrare fonti/materiali esplorati, residui e impedimenti; riprese su contenuti nuovi o migliorativi, preservando versioni/provenienze.
- Completamento: esplorazione conclusa nel perimetro dichiarato alla data indicata, con assenze e fonti non accessibili esplicite; non promessa di completezza universale.
- Generazione AI incremento distinto facoltativo: lacune non obbligano a generare per completare acquisizione dalle fonti.

Prossimo punto proposto: accessibilità e condizioni per acquisizione/estrazione/rielaborazione, esiti verificati e provenienza; poi formalizzazione del workflow e skill dedicata. Nessuna acquisizione o implementazione.

## Esiti di acquisizione e condizioni approvati — 2026-10-05
L'utente approva la conservazione dei riferimenti nel catalogo anche senza file, con esiti:
- Acquisita: file, provenienza e hash registrati.
- Solo riferimento: immagine individuata tramite URL, non acquisita.
- Accesso impedito: autenticazione, collegamento non funzionante o altro limite tecnico esplicito.
- Condizioni da chiarire: utilizzo previsto ancora da verificare.
- Esclusa: duplicato, variante inferiore o contenuto non pertinente, con motivazione.
Acquisizione distinta dalla possibilità di rielaborazione AI; condizioni per l'uso previsto con fonte e data. Esclusioni distinte da ricerca incompleta. Per duplicati conservare collegamento al contenuto mantenuto e provenienze.

Prossimo punto proposto: ciclo di vita dei risultati AI scartati e delle immagini superate, conservazione vs cancellazione, stato operativo e cronologia; proposta non deliberata. Poi consolidamento workflow e sviluppo skill dedicata con skill-creator e limiti/prove espliciti.

## Ciclo di vita immagini approvato — 2026-10-05
L'utente approva la conservazione dello storico:
- Originali già acquisiti preservati; versione precedente Superata e nascosta dalla galleria ordinaria quando sostituita da migliore.
- Varianti inferiori individuate prima dell'acquisizione: solo riferimento e motivo di esclusione.
- Risultati AI rifiutati: Scartata, esclusi da galleria ordinaria e copertura; conservazione iniziale di file, richiesta e motivo del rifiuto.
- Miniature/derivati rigenerabili sostituibili con collegamento all'origine preservato.
- Cancellazione definitiva dei file conservati solo tramite operazione esplicita di pulizia.

Prossimo punto proposto: contenuto della skill dedicata (contratto IMG, esplorazione fonti, varianti, estrazione/deduplicazione, naming/manifest, copertura, AI e validazione, riprese/controlli) con riferimenti specialistici; poi formalizzazione nei documenti autorevoli. Creazione skill con skill-creator, verifica proprietario/ACL di .agents prima della manutenzione e prove locali. Nessuna skill ancora scritta né procedura tecnica di estrazione dichiarata collaudata.


## Formalizzazione e chiusura — 2026-10-05
L'utente approva nome e organizzazione della skill game-image-acquisition. Skill-creator letta e applicata. Deliberazioni promosse in sources/IMAGE_WORKFLOW.md; registro sigle sources/IMAGE_CONTEST_CODES.md predisposto senza assegnare sigle illustrative. Skill installata con tre riferimenti fonti/estrazione/AI; routing BGG aggiornato. PROJECT.md, AGENTS.md, TASK_GOVERNANCE.md, stato workspace, inventario skill e guide library/app aggiornati insieme. Precedente Kanare armonizzato come storia, fonti future non generalizzate. Requisiti app documentati, nessun codice app modificato da questo task.

Proprietario .agents verificato prima e dopo: NOTEBOOK-OMEN\Francesco1; ACL lette, non modificate. Installazione dei quattro file e piccolo aggiornamento routing BGG effettuati con escalation autorizzata dal reviewer; nessuna directory di controllo sostituita. Stage temporaneo rimosso dopo confronto SHA-256 dei quattro file.

14 controlli documentali locali riusciti (verify_workflow.py, VERIFICATION.json): frontmatter scalar, nome, riferimenti, documenti, registro ID univoci, esclusione Git dei binari e whitespace dei diff. Validatore bundled quick_validate.py non eseguibile per assenza PyYAML: verifica locale limitata ai due scalar usati, non parser YAML generale. Nessuna installazione dipendenze eseguita. Revisione delle decisioni: nove dorsi identici restano un contenuto con occorrenze; draft con dorso unico recuperabile; vecchie revisioni graficamente distinte preservate; AI non approvata non copre categoria; fonte futura richiede contratto; conferme illustrate nel workflow, non prove di acquisizione.

Task concluso per il deliverable EPR richiesto. Nessun download, estrazione, generazione, migrazione dati o implementazione immagini nell'app. Tecniche operative da collaudare in primo lotto reale; sigle contest puntuali da assegnare nel task pertinente. Sezioni annuali generate non toccate: dati operativi e metriche invariati.

Prossimi incrementi separati: APP per persistenza/catalogazione immagini e consultazione lacune/galleria; IMG pilota di un solo contest/anno e giochi selezionati, oppure Kanare selezionato. Generazione AI tramite Codex facoltativa con validazione utente; integrazione di generazione nella UI solo evoluzione potenziale.

Git finale: main ahead 2 rispetto al riferimento locale origin/main; molte modifiche di altre attività presenti e preservate, remoto non interrogato. Nessun commit/push/branch eseguito in questo task. Incremento documentale e skill da committare, previa revisione mirata e policy pubblicazione; messaggio proposto: Definisci workflow immagini e aggiungi skill dedicata.


## Commit e push autorizzati — 2026-10-05
Commit 986dd93c36459c1b10ecd852fe6f078b01025ef5: Definisci workflow immagini e aggiungi skill dedicata. Push origin/main riuscito; hash remoto verificato uguale e confronto 0/0 nella chiamata Git precedente. Solo 19 contenuti IMG inclusi, selezionando le modifiche pertinenti nei documenti condivisi; altre attività preservate nella working tree. Audit pubblicazione con zero rilievi sui contenuti selezionati e sul commit in uscita; rilievi nella working tree estranei al lotto esclusi. Esito registrato dopo il successo in incremento documentale separato.
