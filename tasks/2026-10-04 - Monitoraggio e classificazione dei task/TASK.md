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

## Prossimo incremento utile

Riesaminare gli stati ambigui 2025/Kanare e monitorare il censimento 2024 nel task esistente. Definire il workflow immagini in un task EPR autonomo prima delle acquisizioni IMG; impatto applicativo in task APP collegato. Integrare progressivamente i collegamenti alle chat senza dedurre stati dal runtime.
