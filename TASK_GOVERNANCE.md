# Classificazione e monitoraggio dei task

Protocollo operativo adottato il 2026-10-04 su richiesta dell'utente («proceduralizza quanto definito»). Si applica ai nuovi task; la classificazione dei registri esistenti è una formalizzazione successiva, senza riscrivere date, nomi, contratti e stati originari. Riferimento centrale: `tasks/REGISTRY.json`.

## Categorie

Ogni task ha una categoria primaria, scelta per il risultato principale, ed eventuali categorie secondarie. La categoria non dipende dalla durata e non amplia il perimetro autorizzato.

| Codice | Nome | Criterio e casi |
|---|---|---|
| EPR | Evoluzione del progetto | Scopo, regole, organizzazione, strategie e obiettivi; bootstrap, standardizzazione BGG, direzione multifonte |
| GPR | Gestione del progetto | Coordinamento, registri, priorità e supporto Git; registro segnalazioni e monitoraggio dei task |
| APP | Sviluppo e manutenzione dell'app | Funzionalità, correzioni, refactoring e relative verifiche; comprende il launcher destinato all'utente |
| INF | Ambiente e strumenti | Runtime, sandbox e strumenti di lavoro; diagnosi Windows dell'11 settembre |
| FON | Ricerca e valutazione delle fonti | Scoperta, confronto e prima esplorazione di una o più fonti candidate; verifica dell'utilità e dell'idoneità |
| CAT | Censimento del catalogo di una fonte | Inventario di giochi e metadati di una fonte individuata, con perimetro, provenienza e copertura; censimento Kanare |
| DAT | Modello e gestione dei dati | Schema, migrazioni, importazioni e correzioni strutturali; modello multifonte e importazione Kanare |
| VER | Verifica e riconciliazione | Verifica autonoma di destinazioni o identità già censite, senza acquisizione; verifica destinazioni Kanare |
| BGG-G | Censimento globale BGG | Identità dei contest su tutte le annualità; contratto specifico in PROJECT.md |
| BGG-A | Censimento annuale BGG | Contest e roster di un solo anno; contratto specifico in PROJECT.md |
| BGG-M | Monitoraggio contest BGG | Snapshot di un solo contest secondo calendario; contratto specifico in PROJECT.md |
| MAT | Analisi dei materiali | Risorse e requisiti dichiarati; per BGG un solo contest, senza verifica degli host né download |
| ACQ | Acquisizione dei materiali | Verifica degli host e acquisizione nel perimetro selezionato e approvato, con originali, manifest, hash e versioni |
| IMG | Acquisizione delle immagini | Immagini rappresentative del gioco; workflow autonomo deliberato in TSK-0065, sources/IMAGE_WORKFLOW.md |
| ALT | Altro | Eccezione motivata; annotare perché le categorie esistenti non bastano e riesaminare al prossimo controllo |

FON decide quali fonti approfondire; CAT costruisce il catalogo di una fonte; DAT ne progetta la persistenza o ne importa i dati; VER verifica asserzioni già raccolte. BGG usa i suoi tipi specifici. Test dell'app, integrità del database e verifica degli hash appartengono al task che verificano: VER si usa soltanto quando la verifica informativa è il deliverable autonomo. Le modifiche dati necessarie a una funzionalità non impongono automaticamente un secondo task DAT. Documentazione e verifiche seguono la finalità principale.

## Naming e identità

Titolo visibile e cartella dei nuovi task: `YYYY-MM-DD - CODICE - descrizione`, con la data di apertura. La descrizione deve identificare l'intero scope della chat. Categoria e data restano separate dall'ID di una segnalazione: esempio `2026-10-04 - APP - Formattazione DOCX (APP-007)`.

Per BGG inserire il codice dopo la data e mantenere descrizione e unità del tipo standard: BGG-G Censimento globale contest PnP BGG; BGG-A Esplorazione contest BGG AAAA; MAT Analisi materiali - NOME CONTEST AAAA; ACQ Acquisizione materiali - NOME CONTEST AAAA; BGG-M Monitoraggio - NOME CONTEST AAAA. Non perdere il nome del contest o confondere anno dell'edizione e data di apertura.

Il bootstrap conserva l'eccezione originaria. I percorsi storici non vengono rinominati: il registro aggiunge categoria e data di classificazione. La chat corrente adotta subito GPR, mantenendo il percorso già creato come eccezione di transizione. Le altre chat storiche non vengono rinominate in blocco; alla ripresa adeguare il titolo con descrizione cumulativa e registrare il precedente. Un'eventuale migrazione dei percorsi richiede un incremento dedicato con aggiornamento dei riferimenti.

Ogni registro ha un ID stabile `TSK-NNNN`, indipendente da titolo e percorso. Assegnare il successivo numero libero, senza riutilizzare ID. Una chat può collegare più registri e un registro più chat; usare gli ID restituiti dall'app, mai inventarli. Un dato non osservato è `null` con limite esplicito, non assenza verificata.

## Modalità e stati

- Modalità: `circoscritto` (risultato delimitato, anche in più sessioni), `continuativo` (contenitore mantenuto nel tempo).
- Cadenza: `su_richiesta`, `periodica`, `per_evento`; eventuale prossima data con fonte. Continuativo non configura un'automazione.
- Ciclo di lavoro: `proposto`, `pianificato`, `in_corso`, `in_verifica`, `completato`, `sospeso`, `bloccato`, `annullato`.
- Sospeso richiede una decisione; bloccato un impedimento e condizione di sblocco; annullato abbandono esplicito. Riapertura è un evento che riporta in corso. Copertura parziale e relazione con un successore sono campi distinti.
- Per un task continuativo registrare gli incrementi conclusi senza chiudere il contenitore. Per BGG sono ammessi contenitori continuativi per singolo contest oppure rilevazioni circoscritte collegate: preservare la modalità già adottata finché non viene deliberato un cambiamento. Il coordinamento GPR non esegue rilevamenti multi-contest.

Versionamento separato dal ciclo di lavoro:

| Dimensione | Valori |
|---|---|
| Salvataggio locale | `da_committare`, `committato`, `non_applicabile`, `da_verificare` |
| Integrazione | `da_integrare`, `integrato_main`, `non_applicabile`, `da_verificare` |
| Sincronizzazione | `da_pushare`, `allineato_riferimento_locale`, `remoto_verificato`, `divergente`, `non_applicabile`, `da_verificare` |

Conservare evidenza e data per ogni verifica. Autorizzazione al commit non è esecuzione. Tracciamento del TASK.md non certifica tutti i deliverable. Un branch già integrato non comprende file non tracciati. Non dedurre lo stato operativo da idle/notLoaded/archiviata: runtime e archivio della chat sono dimensioni separate.

## Registro e manutenzione

`tasks/REGISTRY.json` conserva: ID, titolo e data originari, percorso/worktree, categorie, data della classificazione, modalità e cadenza, sintesi dello stato originario con evidenza, stato operativo distinto, copertura, dipendenze/successori, chat, prossima azione, stato Git con limiti e date. I campi ancora ignoti restano null o da_verificare. La prima classificazione riprende la pre-analisi; gli stati ambigui non vengono chiusi per deduzione.

All'apertura o ripresa:

1. Verificare PWS, sandbox, task esistenti, registro e stato Git; indicare eventuale continuità prima di duplicare il lavoro.
2. Definire categoria, modalità, scope, input, deliverable e criteri di successo nel TASK.md; registrare ID e collegamenti nel registro centrale. Consultare `sources/SKILL_INVENTORY.md`, leggere e applicare le skill pertinenti prima del lavoro coperto; annotare nel task quali sono state usate e gli eventuali limiti. Il controllo vale anche alla ripresa dei task storici; non implica riscriverne il contratto o la storia.
3. Applicare naming; per BGG verificare unità ed esclusioni in PROJECT.md. Registrare le eccezioni storiche senza estenderle.

Al termine di ogni incremento:

1. Registrare risultati, verifiche, decisioni, stato del contenitore e prossimo passo nel TASK.md; se l’incremento significativo usa skill, includere la verifica dell’efficacia secondo il protocollo seguente.
2. Aggiornare nel registro i campi cambiati, con evidenza e data; non sostituire le dichiarazioni storiche con uno stato corrente inferito.
3. Controllare working tree, worktree pertinenti, commit e integrazione. Affermare sincronizzazione remota solo dopo verifica del server; il solo origin/main è un riferimento locale.
4. Aggiornare PROJECT_PROGRESS.md quando cambia la governance o lo stato operativo; sezioni annuali generate soltanto se cambiano i dati pertinenti.
5. Proporre commit/push o eseguirli se autorizzati; verificare file inclusi, esclusioni e stato residuo. Le registrazioni del risultato Git avvengono dopo il successo: possono costituire un piccolo commit documentale successivo, senza fingere di conoscere in anticipo l'hash del commit che le contiene.

Nel controllo trasversale su richiesta, esaminare tutti i registri, le worktree note e le chat accessibili; dichiarare il limite di elenchi paginati, chat archiviate e storia non letta. Priorità: lavoro non salvato, blocchi/dipendenze, scadenze, stati ambigui, titoli/categorie e prossime azioni. Non riaprire fonti esterne soltanto per verificare i task.

## Confini non modificati e sviluppi da definire

La classificazione non delibera nuove acquisizioni o allargamenti dei workflow. Il censimento annuale BGG mantiene il contratto vigente; l'estensione sistematica a categorie, voti e risultati richiede una definizione esplicita separata. L'acquisizione copre tutti i materiali nel perimetro approvato, senza promettere assenza di blocchi o completezza universale.

IMG distingue immagini catalogate dai PNG stampabili originali, già ACQ. TSK-0065 delibera il workflow autonomo in `sources/IMAGE_WORKFLOW.md`: un contest/anno BGG o giochi Kanare espliciti, titoli `YYYY-MM-DD - IMG - NOME CONTEST AAAA` oppure `YYYY-MM-DD - IMG - Kanare Abstract`; fonti future da valutare. Generazione AI facoltativa tramite Codex con validazione utente. Supporto app in task APP collegato. Il contratto di ciascun lotto deve esplicitare giochi e modalità; nessun download è autorizzato dalla sola categoria o dal brainstorming. Decisione storica Kanare armonizzata senza riscrittura dello storico.

## Estensione annuale classifiche BGG — 2026-10-04

Il 2026-10-04 l’utente delibera per TSK-0045 il task continuativo `BGG-A - Classifiche BGG 2025`: estensione annuale limitata a risultati e votazioni, con incrementi per contest, provenienza, confronto con baseline e distinzione fra completezza delle verifiche e percentuale di entry in classifica. Il censimento roster resta distinto; WIP, materiali, host esterni e download restano esclusi. Riprese su richiesta nella stessa chat, senza automazione. Le challenge prive di roster restano dipendenza esplicita. PWS resta 1.5.0. Contratto in `tasks/2026-10-04 - BGG-A - Classifiche BGG 2025/TASK.md`.

## Estensione annuale classifiche 2024 — 2026-10-04

L’utente ha confermato TSK-0046, `BGG-A - Classifiche BGG 2024`, incremento annuale circoscritto ai risultati e votazioni dei contest con roster esistente. Provenienza e confronto con baseline per contest; completezza della verifica separata dalla presenza in classifica. Roster aggiuntivi, WIP, materiali, host esterni e download esclusi. Le challenge senza roster restano dipendenza del censimento. Contratto: `tasks/2026-10-04 - BGG-A - Classifiche BGG 2024/TASK.md`. PWS invariato a 1.5.0.

## Gestione delle skill

TSK-0048 è un contenitore GPR continuativo su richiesta, senza automazione: inventario, verifiche, lacune e proposte motivate di procedure riutilizzabili. Gli incrementi conclusi non chiudono il contenitore. La manutenzione organizzativa resta GPR; modifiche ai contratti o all'architettura sono EPR da deliberare separatamente. Riferimento: `sources/SKILL_INVENTORY.md`.

### Verifica dell’efficacia — decisione TSK-0069, 2026-10-05

Al termine di ogni incremento significativo che utilizza skill è obbligatoria una breve verifica nel TASK.md sorgente. Vale per i nuovi incrementi, comprese le riprese di task storici; nessun riesame retroattivo obbligatorio delle attività già concluse. La verifica riguarda le skill effettivamente applicate, anche di sistema/plugin; può essere unica per le skill che collaborano allo stesso risultato, distinguendo eventuali problemi specifici. La sola consultazione di un inventario non equivale a uso di una skill. Nessun audit per singola invocazione, automazione, benchmark generalizzato o punteggio di efficacia.

**Incremento significativo:** unità verificabile che produce o modifica un deliverable, completa una porzione concordata del lavoro, cambia una decisione o lo stato di copertura/blocco, oppure si arresta dopo tentativi rilevanti con un limite da conservare. Esempi: un lotto MAT, una riconciliazione classifiche, una revisione di skill, un’acquisizione parziale bloccata. Letture preparatorie, singole chiamate, retry ordinari risolti e ritocchi editoriali privi di effetti operativi confluiscono nella verifica dell’incremento; non creano attestazioni separate. Un incremento sospeso o bloccato può essere significativo anche senza risultato completo.

Valutare insieme: risultato atteso raggiunto e limiti; tentativi ripetuti, passaggi inutili e situazioni non previste; origine dei problemi (skill, ambiente, fonte, input o altro); eventuale miglioria. L’attribuzione della causa deve citare evidenze e mantenere esplicite incertezze e cause concorrenti. Un blocco esterno o un errore isolato non dimostrano un difetto della skill; un esito riuscito non dimostra validità universale.

- Se non emergono problemi, basta una frase: «Skill X applicata: risultato Y verificato nel perimetro Z; nessun tentativo ripetuto/passaggio inutile o caso imprevisto rilevante; nessuna criticità o miglioria emersa; limite L». Adattare alla prova disponibile, senza attestare controlli non eseguiti.
- Se emergono problemi, annotare nello stesso task evidenza concreta e riferimento, impatto sul risultato o sul percorso, causa osservata/ipotizzata e incertezze, soluzione sperimentata con esito oppure proposta non collaudata, residui e prossimo passo. Usare poche righe o una tabella soltanto se utile. Non copiare dump o materiali di terzi nei documenti versionabili.
- Collegare le migliorie pertinenti a TSK-0048 con riferimento al task e al passaggio sorgente. Prima cercare una voce già presente: aggiornarla o collegare un’ulteriore evidenza, senza duplicare audit e contenuti. L’inventario cambia soltanto quando cambia copertura, grado di verifica o prossima manutenzione di una competenza; nessun registro aggiuntivo per ogni uso riuscito. TSK-0048 resta aperto e non va chiuso per la conclusione di un incremento sorgente.

**Manutenzione tecnica autonoma:** correzione circoscritta di istruzioni, riferimenti, routing o helper che conserva obiettivo, input ammessi, output, unità di lavoro, esclusioni, autorizzazioni e modello del workflow. Può essere svolta nell’incremento sorgente e collegata a TSK-0048, oppure in quel contenitore se richiede lavoro autonomo. Applicare skill-creator e le salvaguardie Windows di .agents prima di modificarne i file; nessuna autorizzazione implicita a operazioni Git, ACL o azioni esterne. Validare i file/riferimenti e, quando pertinente, il comportamento sul caso concreto; una verifica statica non certifica efficacia operativa.

Non modificare una skill sulla sola base di una difficoltà isolata. Prima verificare un difetto circoscritto riproducibile o raccogliere evidenze concordanti di un pattern; un collegamento rotto dimostrato può essere corretto senza attendere un altro incidente. Conservare ipotesi ed esperimenti nel task. Promuovere nei riferimenti condivisi soltanto soluzioni con prova riuscita, contesto, data, limiti e utilità riutilizzabile, senza generalizzare un metodo specifico di un host a tutti gli host.

**Evoluzione da deliberare:** cambia scope, contratti o architettura: per esempio estende MAT oltre il primo post, aggiunge host/download, cambia unità annuale/singolo contest, adotta fonti, introduce workflow, modifica entità o autorizzazioni. Formulare una proposta EPR collegata e ottenere una decisione esplicita prima dell’adozione, anche quando la modifica del testo è piccola. In caso di dubbio conservare la proposta e l’incertezza, continuando il lavoro consentito dal contratto. La distinzione dipende dall’effetto operativo, non dal numero di righe modificate. PWS resta read-only e 1.5.0.
