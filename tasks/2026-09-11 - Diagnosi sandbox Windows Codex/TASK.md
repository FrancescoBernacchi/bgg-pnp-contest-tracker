# 2026-09-11 - Diagnosi sandbox Windows Codex

## Scope

Diagnosi tecnica del runtime sandbox Windows di Codex, del terminale, del filesystem helper e di Computer Use/browser CUA. Nessuna modifica ai dati del catalogo PnP e nessuna scansione BGG.

## Input

- errore `helper_unknown_error: setup refresh had errors`;
- log e configurazioni locali Codex;
- stato ACL del workspace;
- confronto temporale con l'incremento Roll & Write e con gli aggiornamenti dell'app.

## Deliverable

- causa e catena causale documentate;
- soluzione verificabile o procedura di ripristino;
- verifiche terminale, filesystem e CUA;
- condizioni sicure per riprendere il task BGG separato.

## Criteri di successo

- il sandbox avvia un comando banale;
- lettura e scrittura controllata funzionano nel workspace;
- CUA inizializza e apre una pagina;
- evidenze, decisioni e verifiche sono registrate senza modificare il catalogo.

## Stato

Concluso il 2026-09-11. Correzione applicata e verificata; resta consigliata una verifica di riavvio completo dell'app prima di riprendere il task BGG, perché chiudere Codex durante questa diagnosi avrebbe interrotto la registrazione del risultato.

## Ambiente osservato

- Codex desktop AppX: `OpenAI.Codex_26.903.9818.0_x64__2p2nqsd0c76g0`.
- Codex CLI/helper attivo: `codex-cli 0.153.4`, directory bin `7ac07f4ce733f89a`.
- Computer Use bundled: `26.903.71938`.
- Node CUA: `v24.20.0`.
- PowerShell incorporata: `7.6.5`.
- Windows API/version string osservata: `Microsoft Windows 10.0.26200`.
- Configurazione Codex: `[windows] sandbox = "elevated"`; progetto trusted.

## Evidenze e diagnosi

### Riproduzione iniziale

- `Get-Location` nel sandbox è fallito prima dell'avvio di PowerShell con `CreateProcess ... helper_unknown_error: setup refresh had errors`.
- La prima inizializzazione CUA è terminata con codice 1 e stderr `windows sandbox failed: helper_unknown_error: setup refresh had errors`.
- Fuori sandbox `git branch --show-current` e `git status --short --branch` hanno restituito `main` e `## main...origin/main` con soltanto i due task del giorno non tracciati.
- Una prima `apply_patch` ha creato questo `TASK.md`; la patch immediatamente successiva è fallita tramite filesystem helper con lo stesso errore.

### Log autorevole

- Errore sintetico: `C:\Users\39348\.codex\.sandbox\setup_error.json`.
- Log dettagliato: `C:\Users\39348\.codex\.sandbox\sandbox.2026-09-11.log` e log giornalieri precedenti nella stessa directory.
- Errore concreto ripetuto nel log: `deny ACE failed on C:\PROGETTI CODEX\Progetto PnP Collection\.agents: SetNamedSecurityInfoW failed ...: 5`.
- Windows error 5 significa accesso negato. `helper_unknown_error` è la classificazione generica con cui Codex propaga il fallimento del processo `codex-windows-sandbox-setup.exe`.

### Catena causale confermata

1. Alle 21:25:39 del 2026-09-10 il precedente sandbox ha creato la nuova directory locale `.agents` per la skill BGG. Il proprietario NTFS risultava `NOTEBOOK-OMEN\CodexSandboxOffline`, non l'utente interattivo `NOTEBOOK-OMEN\Francesco1`.
2. Il refresh delle 21:25:39, avvenuto appena prima che la directory comparisse, si era concluso con `errors=[]`.
3. Al refresh successivo, alle 21:25:49, il setup ha riconosciuto `.agents` come percorso speciale da proteggere in lettura e ha tentato di applicarvi una deny ACE.
4. Il setup, non essendo proprietario della directory e non avendo `WRITE_DAC`, ha ricevuto `SetNamedSecurityInfoW ... 5` e ha abortito l'intera inizializzazione.
5. Terminale unificato, filesystem helper e processi Node/CUA richiedono tutti lo stesso refresh del sandbox; per questo hanno fallito insieme prima di eseguire il proprio lavoro specifico.

La causa immediata e la catena temporale sono confermate dai log e dalle ACL. L'origine sistemica è un difetto di interazione del runtime: una directory speciale `.agents` creata dal sandbox può essere posseduta dall'account sandbox, mentre il refresh successivo pretende di modificarne la DACL da un contesto che non ne ha il diritto.

### Cause escluse o ridimensionate

- Il repository, Git, PowerShell e il percorso workspace non erano guasti: funzionavano fuori sandbox.
- Il workflow In-Hand non aveva ancora raggiunto BGG; contenuto del comando, DOM, `gg-item-link`, Node e rete non possono aver causato il fallimento pre-avvio.
- L'aggiornamento alla directory bin attiva è stato installato alle 22:32 del 2026-09-10, oltre un'ora dopo il primo errore delle 21:25:49. Anche il precedente helper `fd4c151a749f3ab4` aveva già registrato il difetto: l'aggiornamento non è la causa iniziale, anche se non lo ha corretto.
- Plugin, antivirus, lock, cache, mapping dei tre/quattro write root e policy Windows non mostrano evidenza causale necessaria. Possono influire genericamente sulle ACL, ma qui non servono a spiegare la sequenza osservata.
- Il riavvio di Windows non poteva correggere un proprietario NTFS persistente: processi e lock vengono ricreati, la proprietà della directory resta su disco.

### Perché la prima patch riuscì e la successiva no

La prima operazione poteva partire usando lo stato già inizializzato, prima che il refresh osservasse il nuovo percorso speciale. Una volta creata `.agents`, il refresh immediatamente successivo tentò di aggiungere la deny ACE e fallì. La stessa sequenza si è ripetuta durante questa diagnosi: creazione iniziale di `TASK.md` riuscita, aggiornamento successivo fallito finché l'ACL non è stata riparata.

### Rapporto con esaurimento usage e ripresa dei task

- Nei log di sessione del 2026-09-10 è presente un `usage_limit_exceeded` alle 12:19 circa, con ripristino previsto alle 14:07. Il primo errore ACL su `.agents` avviene invece alle 21:25:49, oltre nove ore dopo.
- Alle 21:25:31 nasce una breve sessione interna con source `subagent/guardian`, collegata alla valutazione delle azioni; non è marcata come ripristino usage. Nello stesso intervallo il filesystem helper esegue più refresh ancora riusciti.
- Alle 21:25:39 viene materializzata `.agents` sotto l'identità sandbox; dieci secondi dopo il primo refresh che la include fallisce sulla proprietà/DACL.

Conclusione: l'esaurimento usage non è supportato come causa dell'ACL errata. Un'interruzione o una ripresa può provocare nuovi processi e quindi rendere immediatamente visibile uno stato già problematico, ma il difetto determinante è la creazione di un percorso speciale `.agents` con proprietario sandbox, seguita dal refresh che pretende di modificarne la DACL da un contesto diverso. Il blocco usage può essere al massimo un innesco indiretto non dimostrato, non la causa originaria.

## Correzione applicata

Con autorizzazione dell'utente è stato cambiato esclusivamente il proprietario della directory radice:

`C:\PROGETTI CODEX\Progetto PnP Collection\.agents`

da `NOTEBOOK-OMEN\CodexSandboxOffline` a `NOTEBOOK-OMEN\Francesco1` mediante `icacls /setowner` eseguito con elevazione UAC. Il primo tentativo fuori sandbox ma senza elevazione amministrativa ha restituito `Accesso negato` e non ha modificato nulla; il secondo, con UAC, ha restituito exit code 0.

Nessun file della skill è stato alterato. Al refresh seguente il setup ha potuto aggiungere le deny ACE previste al SID di capacità del sandbox. I permessi ereditati sono rimasti presenti, `AreAccessRulesProtected` è rimasto `False` e il proprietario è rimasto `Francesco1`.

Il rollback, se mai necessario, consiste nel reimpostare il proprietario precedente `NOTEBOOK-OMEN\CodexSandboxOffline`; non è raccomandato perché riprodurrebbe il guasto. Non sono state cancellate cache, configurazioni, sessioni, cronologia, plugin, skill, repository o working tree.

## Verifiche dopo la correzione

- Comando sandbox banale: `Get-Location` riuscito.
- Git nel sandbox: branch `main`, relazione `main...origin/main` riuscite.
- Lettura locale: prime righe di `.agents\skills\bgg-contest-navigation\SKILL.md` lette correttamente.
- Scrittura locale: creato con `apply_patch`, letto nel sandbox e poi rimosso `sandbox-write-probe.txt`.
- Refresh ripetuti: il log riporta più esecuzioni `processed 4 write roots ... errors=[]` e `setup binary completed`.
- Stato errore: `setup_error.json` è stato rimosso automaticamente dal runtime dopo il successo.
- CUA: inizializzazione riuscita dopo reset del kernel.
- Browser, pagina neutra: `https://example.com/` aperta con titolo `Example Domain` e DOM accessibile.
- BGG: aperto il thread `3378403`; dopo la verifica Cloudflare iniziale, titolo e DOM effettivo sono risultati accessibili.
- Persistenza CUA: dopo un secondo reset del kernel, la scheda BGG è stata recuperata e il DOM renderizzato ha mostrato titolo, primo post, lista giochi, risultati e link.
- Non sono state aperte destinazioni esterne né scaricati file.

## Limiti residui

- Non è stato chiuso e riaperto Codex dopo la correzione, per non interrompere questo stesso task. I numerosi refresh riusciti e il reset completo del kernel CUA verificano lo stato persistente rilevante, ma una riapertura dell'app resta il controllo finale consigliato.
- La documentazione pubblica ufficiale OpenAI cercata non descrive il messaggio interno `setup refresh had errors`; la semantica qui documentata deriva dai log locali del prodotto, che espongono il componente e la chiamata Windows esatti.
- La directory non tracciata `tasks/2026-09-11 - Esplorazione contest BGG 2025 - Parte 2/` è stata lasciata intatta come richiesto.

## Condizioni per riprendere l'esplorazione BGG

1. Chiudere e riaprire Codex una volta.
2. Nel task BGG separato eseguire prima `Get-Location`, `git status --short --branch` e una lettura breve della skill tramite sandbox ordinario, senza `require_escalated`.
3. Inizializzare CUA e aprire prima una pagina neutra, poi il thread BGG; attendere l'eventuale verifica Cloudflare senza aggirarla.
4. Confermare che il DOM del primo post sia leggibile prima di aprire i 26 WIP.
5. Non proseguire se ricompare `setup_error.json`; consultare subito il log giornaliero e verificare proprietario/ACL di eventuali nuove directory speciali `.agents` o `.git`.
6. Conservare separato questo task diagnostico dal task annuale e non includere nel commit diagnostico la cartella incompleta della Parte 2 senza una decisione esplicita.

## Esito

Tutti i criteri di successo verificabili senza riavviare l'app sono soddisfatti. Il guasto non era nel contest In-Hand né nel workflow BGG: era un conflitto persistente di proprietà/DACL sulla nuova directory `.agents`, introdotta nel precedente incremento e incontrata dal refresh successivo del sandbox.

## Mitigazione durevole applicata

Su richiesta dell'utente è stata promossa in `AGENTS.md` una salvaguardia operativa specifica per il sandbox Windows:

- non creare la radice `.agents` dall'interno del sandbox quando è assente;
- preservare la directory radice esistente e verificarne il proprietario prima della manutenzione strutturale;
- eseguire un preflight dopo usage limit, riavvio, aggiornamento o ripresa di un task;
- fermare il workflow sostanziale su `setup refresh had errors` invece di aggirarlo con esecuzioni elevate;
- diagnosticare log, percorso e ACL prima di proporre correzioni;
- richiedere autorizzazione per modifiche ACL o pulizie di stato;
- verificare distintamente terminale, filesystem e CUA dopo il ripristino.

La mitigazione riduce sia la probabilità di ricreare il difetto sia il rischio di mascherarlo. Non introduce riparazioni ACL automatiche e non modifica la struttura applicativa o i dati del catalogo.
