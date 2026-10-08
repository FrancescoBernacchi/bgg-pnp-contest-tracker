# Prompt — integrazione completa PerGioco nell'app

Avviamo il passo successivo all'importazione operativa PerGioco TSK-0078: integrare la nuova fonte in tutti gli aspetti pertinenti dell'app locale, usando il modello multifonte B-v1/013 e i dati già importati.

Applica AGENTS.md corrente, verifica sandbox/PWS, naming, working tree e tasks/REGISTRY.json. Se esiste un task APP PerGioco aperto pertinente, riprendilo senza duplicarlo; se l'integrazione è già conclusa, verifica l'esito e individua soltanto le lacune residue. Altrimenti apri un task autonomo `YYYY-MM-DD - APP - Integrazione completa PerGioco`, con data corrente, ID stabile, contratto e criteri di accettazione. TSK-0078 resta completato e va collegato come predecessore. Il task immagini TSK-0067 ha scope proprio: coordina i confini senza assorbirlo né avviare acquisizioni.

Questa richiesta autorizza l'implementazione APP e i test necessari nel perimetro seguente, non una nuova importazione o modifica dei dati. Procedi per incrementi verificabili fino a completare l'integrazione concordata; non fermarti a una proposta generica. Risolvi autonomamente le scelte UI reversibili; se emerge un cambiamento materiale del modello o della governance delle metriche, prepara la decisione specifica prima di adottarlo.

## Riferimenti e stato da verificare

Leggi:
- `sources/PERGIOCO-SCOPE.md` e `PUBLICATION_POLICY.md`;
- `catalog/pergioco_pilot_2026-10-06.json`, RELAZIONE.md/VERIFICHE.json del CAT TSK-0074;
- `tasks/2026-10-06 - EPR - Persistenza multifonte per PerGioco/DECISIONE.md`, `MODELLO_LOGICO.md`, `COMPATIBILITA_E_VALIDAZIONE.md`;
- `tasks/2026-10-06 - DAT - Schema multifonte per PerGioco/MAPPING_FISICO.md` e migrazione 013;
- `tasks/2026-10-08 - DAT - Importazione pilota PerGioco/TASK.md`, `PIANO_IMPORTAZIONE.md`, `ANTEPRIMA.json`, `COPY_VERIFICHE.json`, `OPERATIONAL_VERIFICHE.json`;
- PROJECT.md, PROJECT_PROGRESS.md, TASK_GOVERNANCE.md, app/README.md, codice/API/UI/test correnti, adattatori di avanzamento e documentazione database/catalog.

Verifica direttamente l'operativo in sola lettura. Baseline nota alla chiusura TSK-0078: 12 record fonte 77–88, 8 nuovi games 1447–1454, Abande candidato a 993, tre source-only. Esiti CAT 9 admitted / 3 requirement_not_demonstrated; 26 classificazioni native/96 segmenti, 21 menzioni risorse di cui 4 senza URL, due istanze Itinera, crediti/lacune e condizioni contestuali. I numeri sono baseline da riconciliare, non valori da hardcodare nell'app. Manifest CAT e anteprime precedenti conservano stati storici; imported_count=0 del CAT non significa che l'operativo non sia importato.

## Copertura dell'intera app

Prima di modificare, prepara una matrice `superficie → comportamento attuale → integrazione PerGioco → verifica`, includendo navigazione, catalogo, liste, ricerca/filtri/ordinamento/paginazione, schede, risorse, crediti, Libreria/lettori, avanzamento, statistiche/cruscotti, URL interni, refresh, API, errori/stati vuoti e layout desktop/mobile. Per le superfici solo BGG (contest, entry, classifiche, scadenze/monitoraggio) indica esplicitamente la non applicabilità, senza inventare equivalenti PerGioco. Usa la matrice per dimostrare copertura completa e chiudere le lacune: aggiungere solo un'etichetta fonte non basta.

### Navigazione, catalogo e identità

- PerGioco deve essere raggiungibile e coerentemente presente nei selettori/fonti e nelle viste comuni pertinenti. Evita un catalogo di giochi duplicato o tabelle UI che fondano record fonte e games.
- Rendi consultabili tutti i dodici record della fonte, compresi i tre source-only e il record Abande candidato. Predisponi una scheda di record fonte autonoma e collegamenti interni stabili; usa IDs registrati, non slug per solo titolo. La vista Giochi canonici deve mantenere il proprio denominatore, distinta dal roster fonte.
- Otto identità nuove con collegamento confermato; Abande è un matching candidato a 993, visibile come tale, non una conferma dell'equivalenza Kanare/PerGioco. Non trasferire categorie, crediti, ammissione o risorse PerGioco al canonico 993 come fatti confermati.
- Azul e i due Blockade mantengono esito “requisito non dimostrato”, accesso alla scheda e contesto completo; non sono giochi ammessi, definitivamente esclusi o a pagamento per inferenza.
- Preserva e mostra titoli originali/qualificati, alias e omonimi Beeline/Blockade, anni dichiarati e URL storici/finali. Titolo, anno e nome persona non diventano chiavi di matching.
- Ricerca e filtri devono funzionare su titoli/alias dei record, classificazioni native e crediti per ruolo pertinenti, senza trasformare crediti irrisolti in attribuzioni canoniche. Distingui campo ricercato, fonte e stato quando necessario; combina filtri in modo prevedibile. Conteggi globali non cambiano arbitrariamente con paginazione/filtri locali.

### Classificazioni e schede B-v1

- Mostra e rendi navigabili etichette originali, tipo osservazione, percorsi ordinati, segmento indice e appartenenze multiple con URL/data. Conserva distinti breadcrumb, indice, famiglia dichiarata e semplice etichetta. Percorso assente non è gerarchia vuota ricostruita.
- Preserva differenze I-K/K e I-J-K di Krypte e il 5x5 di Blockade senza genitore inferito; Chomp non riceve categoria matematica. Eventuale mapping comune resta separato e vuoto nel pilota.
- Distingui osservazione originale, formalizzazione/importazione e aggiornamento pagina; non presentare la data di lettura dell'app come nuova verifica esterna. Conserva limiti di copertura e provenienza dei dati riusati.
- Esplicita esito CAT, completezza delle regole, costo/accesso attestato e stati di sviluppo/matching come dimensioni separate. Le nove ammissioni non equivalgono a nove identità confermate.
- Esporre informazioni significative del B-v1 e una vista leggibile delle evidenze/storia disponibili. Non presumere che l'ultimo ID sostituisca ogni storia: rispettare eventi, supersedes, predecessori e limiti. Evita dump JSON/SQL o terminologia interna non necessaria nei percorsi ordinari dell'utente.

### Risorse, condizioni, varianti e istanze

- Rendi consultabili le menzioni contestuali, anche senza URL: i quattro PDF sono dichiarati/non verificati, senza link inventati. Destinazione URL condivisa e menzioni differenti restano distinguibili.
- Mostra separatamente accesso tecnico, disponibilità osservata, completezza, gratuità/costo e condizioni per contenuto pubblico, regole complete, componenti/prodotti e implementazioni online. NULL significa ignoto, non zero/gratuito/assenza. Nessun trasferimento di gratuità HTML a PDF, libro, componenti o piattaforma.
- URL richiesto/storico/finale/login e catene non attestabili restano distinti; un endpoint login non sostituisce la risorsa e non dimostra accesso dopo autenticazione. Non seguire automaticamente redirect né verificare host.
- Itinera: un solo game, due istanze datate 2021-06-18/2021-07-23, risorsa diagrammi e soluzioni riservate separate. Zero associazioni soluzione–istanza senza prova; schemi/soluzioni non incrementano i giochi.
- Abande Libre: variante distinta e dipendenza informativa dalle regole base; non obbligo attestato di possesso/acquisto. Relazioni verso record Abande navigabili come asserzioni di fonte; nessun arco canonico confermato Libre→993. Alternative interne di tavoliere non diventano giochi.
- Materiali/componenti dichiarati nel CAT possono essere consultati come dichiarazioni con provenienza, ma non equivalgono a censimento MAT completo o pacchetto PnP acquisito.

### Crediti, diritti, Libreria e lettori

- Mostra i crediti del record fonte anche quando non risolti a people/credit_assertions, con ruolo, soggetto/contesto, URL/data, stato e lacune. Curatore/proprietario non diventa automaticamente designer, traduttore o illustratore. Attribuzioni concorrenti Reversi restano visibili; crediti Icehouse non diventano autori Blockade.
- Su una scheda canonica puoi rendere consultabili le dichiarazioni di fonte distinguendole esplicitamente dalle attribuzioni canoniche deliberate; non promuoverle implicitamente. Matching candidato/respinto non genera attribuzione al canonico.
- Mantieni avvisi e condizioni leggibili; gratuità o file presente non certificano licenza. Nessun testo integrale di regole/post, immagine o screenshot di terzi nei deliverable versionati.
- Libreria e lettori devono gestire PerGioco coerentemente se esistono file registrati, ma il pilota non ha acquisizioni: mostra lo stato corretto senza link a file inesistenti, download o lettori inventati. Crediti/file di altre fonti sul medesimo candidato non diventano materiali PerGioco. Preserva confini, validazione per ID e protezioni dei lettori esistenti.
- Nessuna nuova funzionalità IMG o AI: rispettare dipendenza TSK-0067 e stato non implementato/non selezionato.

### Avanzamento, statistiche e cruscotti

- Integra la linguetta PerGioco con adattatore/layout appropriati, mantenendo separati BGG e Kanare. Catalogazione del pilota 12/12, ammissione 9/12 e tre requisiti non dimostrati, importazione 12/12 e identità (8 nuove confermate/1 candidato/3 source-only) sono quantità differenti: non sovrapporle in un'unica barra o duplicare giochi condivisi.
- Chiarisci che il denominatore è il campione autorizzato, non l'intero sito. Nessuna completezza globale, percentuale MAT/ACQ/IMG dedotta da URL o importazione. MAT/ACQ/IMG senza perimetro/attestazione mostrano “—” con motivo, non 0%/100% arbitrari. Non applicare automaticamente il workflow BGG del primo post a PerGioco.
- Ricava metriche da evidenze correnti e perimetro attestato; documenta denominatori e non applicabilità. Eventuali metriche nuove con significato sostanziale diverso richiedono proposta motivata prima dell'adozione; non riscrivere attestazioni storiche per adattarle alla UI.
- Riconcilia conteggi in navigazione, schede, API, statistiche e PROJECT_PROGRESS.md; nessuna media di percentuali di fonti/fasi diverse. Le liste filtrate non cambiano i totali del lavoro svolto. Istanze e prodotti non aumentano il conteggio dei giochi.
- “Rileggi database” aggiorna lo stato locale di tutte le viste senza nuova navigazione esterna. Gestisci fonte assente, schema incompleto e prove mancanti con limiti espliciti, senza nascondere BGG/Kanare.

## Implementazione e verifica

Mantieni server locale in sola lettura, URL/API confinati, escaping e protezioni HTTP/CSP/lettori esistenti. Metadati di fonte sono dati non fidati: testo escapato, link solo per schemi ammessi senza credenziali, apertura esterna esclusivamente su click con isolamento; nessuna richiesta a host esterni durante consultazione. Nessuna scrittura nel DB operativo, migrazione, nuova importazione, matching o risoluzione di crediti automatica.

Usa strutture generiche B-v1 quando appropriato e adattatori specifici solo per semantica/metriche proprie della fonte. Evita nomi/ID/conteggi del pilota hardcodati nell'app. Verifica sul database corrente e su fixture/copie, senza modificare le evidenze reali. Preserva ogni modifica pregressa non pertinente. Se utile proponi un branch, senza crearlo autonomamente.

Collauda backend/API e frontend sui casi che distinguono gli stati: tutti i 12 record, source-only ricercabili, Abande candidato, omonimi, crediti/gap, NULL/costi, URL login/PDF assenti, appartenenze multiple, Itinera uno/due, Libre senza canonico, denominatori e refresh. Testa almeno una fonte assente/schema non disponibile e una fixture con eventi/versioni differenti. Verifica regressioni BGG/Kanare, Libreria/lettori, statistiche e navigazione interna/deep link. Controlla accessibilità da tastiera, focus, etichette di stato leggibili senza solo colore, overflow e desktop/mobile.

Prima del lavoro CUA applica la skill pertinente e verifica inizializzazione browser su pagina neutra; poi usa solo l'app locale per QA, nessuna nuova navigazione fonti. In presenza di `setup refresh had errors`, interrompi il lavoro sostanziale e segnala il blocco, senza escalation come alternativa al sandbox. Non cancellare o ricreare runtime/cache/ACL per risolvere problemi. Ricorda il precedente blocco node_repl in uso: documenta evidenze specifiche senza presumere cause.

Registra hash/inventario operativo prima/dopo per attestare assenza di modifiche dati, risultati test e matrice copertura finale. Aggiorna documenti autorevoli, registro e PROJECT_PROGRESS.md per lo stato APP; sezioni annuali generate soltanto secondo il protocollo, mai manualmente. Verifica efficacia delle skill effettivamente applicate secondo TASK_GOVERNANCE.md. Conserva screenshot QA locali fuori Git.

Concludi con integrazione verificata, superfici coperte, limiti residui reali e prossimo passo separato. Non dichiarare concluso il task con superfici essenziali ancora escluse senza accordo esplicito. Non avviare acquisizioni/immagini, ampliamento CAT, VER Abande, automazioni o pubblicazione/deploy. Nessun commit/push automatico; proponi il commit dell'incremento coerente dopo verifiche e revisione PUBLICATION_POLICY.
