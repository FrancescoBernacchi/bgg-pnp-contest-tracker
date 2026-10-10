# Monitoraggio e classificazione dei task

- Apertura: 2026-10-04.
- Stato: attivo; primo incremento di pre-analisi completato.
- Modalità: continuativo, con revisioni su richiesta; nessuna automazione configurata.
- ID stabile: TSK-0044; categoria primaria GPR, secondaria EPR.
- Titolo visibile: `2026-10-04 - GPR - Monitoraggio e classificazione dei task`.
- Titolo originario: `2026-10-04 - Monitoraggio e classificazione dei task`; percorso preservato come eccezione di transizione.
- PWS: progetto e copia canonica entrambi 1.5.0.

## Contratto

Analizzare i registri locali e le chat pertinenti disponibili; confrontare le categorie proposte con PROJECT.md; proporre terminologia, naming e dimensioni del monitoraggio. Questo è un task di governance non BGG: non esegue rilevamenti esterni, acquisizioni o implementazioni dell'app.

Input: richiesta dell'utente, AGENTS.md, PROJECT.md, PROJECT_PROGRESS.md, PROJECT_STATE.md, TASK.md esistenti, elenco chat e storia pertinente, riferimenti Git e worktree.

Deliverable: PRE_ANALISI.md con inventario, classificazione preliminare, anomalie, stato Git verificabile e decisioni ancora da deliberare.

Criteri di successo: copertura dei 42 registri della checkout principale; inclusione del registro Wargame sospeso in worktree; distinzione tra chat e registro, stato dichiarato e inferito, completamento e versionamento; conservazione dello storico; proposte compatibili o esplicitamente segnalate come evoluzioni.

## Continuità

La chat `2026-10-02 - Quadro Kanare e verifica task Git` aveva già verificato il versionamento, senza creare un registro locale dedicato. La richiesta corrente introduce una governance continuativa e una tassonomia generale: costituisce un incremento autonomo più ampio, non un nuovo censimento Kanare. Il registro segnalazioni app resta attivo e distinto: raccoglie segnalazioni, mentre questo task coordina i task.

## Verifiche e risultati del primo incremento

- Preflight sandbox, lettura locale e Git riusciti.
- 42 TASK.md nella checkout principale; un ulteriore TASK.md sospeso esclusivamente nella worktree 52fb.
- Sei checkout Git controllate in sola lettura: cinque pulite, una con il solo task Wargame non tracciato.
- Prima di questo incremento main pulito a 2987d51; confronto con il riferimento locale origin/main: 0/0. Nessun fetch, quindi nessuna certificazione remota aggiornata.
- Tutti i branch locali risultano contenuti in main; non significa che ogni file non tracciato sia integrato.
- PRE_ANALISI.md include tutti i 43 registri preesistenti osservati. Questo registro è il 44° nell'inventario complessivo osservato, il 43° nella checkout principale.
- Nessuna rinomina storica, modifica di workflow, commit, push, merge, acquisizione o automazione.
- PROJECT_PROGRESS.md aggiornato nella sola governance qualitativa; sezioni annuali intatte perché dati operativi invariati.

## Decisioni in attesa

Estensione sistematica del censimento annuale alle classifiche e workflow immagini restano incrementi da definire. Tassonomia, sigle, naming e dimensioni del monitoraggio sono adottati nel secondo incremento seguente; i workflow operativi non sono ampliati dalla classificazione.

## Secondo incremento — proceduralizzazione del 2026-10-04

- Autorizzazione: l'utente chiede «OK, proceduralizza quanto definito. Fai commit e push».
- Scope: rendere operative tassonomia e manutenzione, creare registro centrale, conservare il registro sospeso Wargame e versionare la documentazione. Nessuna rinomina massiva, implementazione app o acquisizione.
- Deliverable: TASK_GOVERNANCE.md, tasks/REGISTRY.json, aggiornamenti coordinati AGENTS.md/PROJECT.md/PROJECT_STATE.md/PROJECT_PROGRESS.md.
- Decisione di adozione: nuovi task con codice dopo la data; classificazione storica nel registro con data 2026-10-04; percorsi e date originari invariati. CAT denominata «Censimento del catalogo di una fonte»; INF/DAT/VER con confini e casi; FON distinta da CAT. Una categoria primaria e secondarie facoltative.
- Modalità circoscritto/continuativo e cadenza separate; stati lavoro, copertura, Git e runtime separati. Monitoraggio BGG conserva le modalità esistenti e il perimetro per singolo contest.
- Registro iniziale: 44 ID stabili; stati ambigui dichiarati, collegamenti chat non osservati lasciati vuoti. Versionamento dei registri storici verificato sul TASK.md, senza certificare tutti i deliverable.
- Il TASK.md Wargame è copiato in main dall'originale in 52fb: hash identici e sospensione preservata. La copia originale non viene modificata o rimossa; resta non tracciata nella worktree storica.
- Pre-analisi preservata come documento storico; il nuovo protocollo prevale per le decisioni adottate.
- Criteri di successo: tutti i TASK.md della checkout principale coperti una sola volta, ID univoci, codici validi, naming BGG coerente, percorsi esistenti, copia Wargame identica, esclusioni Git controllate e push verificato.
- Verifiche documentali superate: 44 TASK.md e 44 record, ID univoci, copertura esatta e codici validi; copia Wargame identica all'originale; git diff --check passato. Database, materiali e output esclusi. Fetch autorizzato eseguito; main e origin/main senza divergenza prima del commit. Nessun test applicativo necessario: codice e dati operativi invariati.
- Incremento completato: commit `7cad97e` («Formalizza categorie, naming e monitoraggio dei task»), pubblicato su origin/main il 2026-10-04. Riferimento main verificato anche sul server con ls-remote; working tree pulita dopo il primo push. Registro aggiornato successivamente con esito effettivo, in un commit documentale di finalizzazione. Il contenitore TSK-0044 resta attivo e continuativo; Wargame resta sospeso.

## Terzo incremento — rinomina dei titoli visibili

- Richiesta: rinominare tutti i task secondo le nuove regole, senza identificativi di segnalazione nei titoli APP.
- Scope: chat con contenuto del progetto e relativo registro; aggiornamento della regola di naming. Percorsi storici preservati; eccezione bootstrap; nessuna modifica a codice, dati operativi o contratti BGG.
- Input: registro centrale, elenco app, metadata locali in sola lettura per recuperare ID oltre il limite dell'elenco, read_thread per confermare titoli e date di apertura.
- Deliverable: titoli applicati tramite set_thread_title; storico prima/dopo e collegamenti chat in tasks/REGISTRY.json; evidenza di applicazione e verifica in CHAT_RENAMING.json.
- Criteri: tutte le 38 chat con contenuto inventariate trattate; titoli con data di apertura Europe/Rome e categoria, nessun APP-NNN nei titoli APP; nomi cumulativi per chat multi-registro; chat tecniche Guardian review e contenitore vuoto esclusi perché non task utente. Nessuna modifica diretta al database interno di Codex.
- Risultato: 36 titoli rinominati con successo; 2 già conformi, inclusa eccezione bootstrap. Read_thread riconferma 26 titoli integralmente e 12 tramite prefisso troncato coerente più esito positivo set_thread_title. Nessun errore di applicazione.
- Ripristinate le date di apertura della chat: monitoraggio generale 4 settembre, classifiche/risorse/materiali 10 settembre e contenuti/varianti Libreria 3 ottobre. Le date dei singoli incrementi e TASK.md non vengono riscritte.
- Registro aggiornato: 38 chat con storico prima/dopo e collegamenti osservati ai registri; 44 titoli di registro normalizzati separati dai titoli cumulativi delle chat. I 44 percorsi storici esistono ancora, senza rinomine. Tre registri non hanno un collegamento chat dimostrato e non vengono associati per deduzione.
- Protocollo e AGENTS.md aggiornati con divieto degli identificativi di segnalazione nei titoli APP. Documentazione locale di questo incremento ancora da committare; nessun commit/push richiesto per questa rinomina.
- Verifiche: unicità dei 38 ID chat, assenza APP-NNN nei titoli APP, percorsi storici esistenti e git diff --check superati. Codice, database e materiali invariati.

## Prossimo incremento utile

## Quarto incremento — eliminazione delle etichette ridondanti

- Richiesta utente: sostituire «ACQ - Acquisizione materiali -» con «ACQ -» e «MAT - Analisi materiali -» con «MAT -»; rimuovere le precedenti etichette ripetute.
- Risultato: 11 titoli semplificati, inclusi ACQ Kanare, MAT storico 2025, BGG-M e le forme compatte BGG-G/BGG-A. Date, categorie, fonte/contest e qualificazioni storiche preservati; 38 chat totali e 44 registri invariati.
- Applicazione: set_thread_title riuscito per tutti; read_thread verifica titolo o prefisso troncato coerente. Storico prima/dopo in REGISTRY.json; evidenza in CHAT_TITLE_SIMPLIFICATION.json. Protocollo, AGENTS.md e tabella titoli PROJECT.md aggiornati.
- Scope esclusivamente naming/documentazione, nessuna modifica dati o acquisizione. Percorsi storici preservati. Incremento locale da committare insieme alla rinomina precedente; nessun commit/push aggiuntivo eseguito.

## Prossimo incremento utile dopo le rinomine

Riesaminare gli stati ambigui 2025/Kanare e monitorare il censimento 2024 nel task esistente. Definire il workflow immagini in un task EPR autonomo prima delle acquisizioni IMG; impatto applicativo in task APP collegato. Integrare progressivamente i collegamenti alle chat senza dedurre stati dal runtime.

## Incremento del 2026-10-10 - ID nel prefisso dei titoli

Richiesta autorizzata: aggiornare i file di progetto e tutti i titoli visibili a `Txxxx-AA.MM.GG - ...`, lasciando invariata la parte successiva alla data. Scope: governance/naming; nessuna rinomina di cartelle, modifica di dati o sviluppo APP. Criteri: ID tracciabile, descrizioni preservate, copertura delle chat storiche e archiviate, verifica dopo applicazione.

Risultato: 76 chat rinominate, 86 titoli di registro aggiornati. Quattro chat storiche prive di ID ricevono TSK-0083..0086, con stato non ricostruito e percorsi non inventati. Chat con più registri espongono primary_task_id, conservando tutti i collegamenti. Evidenze e storico prima/dopo in CHAT_ID_PREFIX_2026-10-10.json e REGISTRY.json. Documenti autorevoli aggiornati: TASK_GOVERNANCE.md, AGENTS.md, PROJECT.md, sources/IMAGE_WORKFLOW.md e PROJECT_STATE.md; PWS 1.5.0 invariato.

Verifiche: set_thread_title applicato tramite API; 49 titoli confermati integralmente e 27 tramite prefisso troncato coerente. La chat archiviata TSK-0085 è stata ripristinata temporaneamente per la rinomina e nuovamente archiviata. Unicità ID, prefissi per tutti gli 86 registri, descrizioni dopo il separatore, assenza di identificativi segnalazione nei titoli APP e percorsi esistenti verificati. Nessuna skill specialistica applicabile a questa modifica documentale. Incremento concluso; contenitore GPR continuativo aperto. Documenti locali da committare; nessun commit/push eseguito. Prossimo passo utile: commit selettivo della governance, distinto dai deliverable DAT/APP.

## Correzione del progressivo iniziale - 2026-10-10

Autorizzazione esplicita utente allo scambio coordinato degli ID. Scope: registro, titoli visibili e riferimenti; setup ora TSK-0001 (chat creata 1788511326), monitoraggio BGG ora TSK-0002 (1788522536). Aggiornate dipendenze e collegamenti, preservando date, percorsi, descrizioni e titoli storici. Mappa della precedente assegnazione in REGISTRY.json.identity_corrections; nessuna ambiguità risolta con alias globali. Nessun commit/push autorizzato da questa correzione.
