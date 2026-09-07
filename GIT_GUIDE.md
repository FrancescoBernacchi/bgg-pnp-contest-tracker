# Guida Git e GitHub del progetto

Questa guida descrive il flusso ordinario del progetto per chi non usa Git abitualmente.

## Concetti essenziali

- **Commit**: salva un punto coerente della cronologia nel repository locale.
- **Branch**: crea una linea di lavoro separata, utile per modifiche sperimentali o ampie.
- **Push**: invia a GitHub i commit locali, creando una copia remota aggiornata.
- **Pull**: integra localmente i commit presenti su GitHub.
- **Merge**: unisce il lavoro di un branch in un altro.
- **Repository remoto**: copia del progetto ospitata su GitHub; in questo progetto si chiama `origin`.

## Quando conviene fare un commit

Creare un commit quando è terminato un incremento coerente e verificato, per esempio:

- aggiunta o aggiornamento completo di un contest;
- migrazione del database applicata e controllata;
- nuova funzione del cruscotto verificata;
- consolidamento coordinato della documentazione.

Evitare commit a metà di una modifica non funzionante, salvo che si voglia conservare intenzionalmente un checkpoint locale chiaramente descritto. Un buon commit dovrebbe poter essere spiegato con una sola frase.

Prima del commit controllare almeno:

```powershell
& $git status
& $git --no-pager diff
```

Dopo il commit controllare:

```powershell
& $git --no-pager log -1
& $git status
```

## Quando conviene creare un branch

Usare un branch prima di un lavoro che:

- richiede più passaggi e potrebbe lasciare temporaneamente il progetto incompleto;
- modifica schema, importazioni o codice in modo sperimentale;
- presenta alternative da confrontare;
- deve essere riesaminato prima di entrare in `main`.

Per una correzione piccola, lineare e facilmente verificabile può essere sufficiente lavorare direttamente su `main`. I branch creati da Codex usano normalmente il prefisso `codex/`, per esempio `codex/dashboard-filters`.

## Quando conviene fare push

Fare push dopo un commit importante o alla fine di una sessione di lavoro. Il push:

- conserva su GitHub una copia dei commit locali;
- permette di riprendere il lavoro da un altro computer;
- rende visibile se `main` locale e `origin/main` sono sincronizzati.

Il push non sostituisce il commit: trasferisce soltanto commit già creati. Prima di pubblicare verificare sempre che file riservati, database operativo, output e materiali di gioco siano esclusi.

## Quando usare pull o fetch

Se il repository può essere stato modificato da GitHub o da un altro computer, controllare il remoto prima di iniziare un nuovo incremento. `fetch` aggiorna la conoscenza del remoto senza cambiare i file locali; `pull` integra le modifiche remote e può richiedere la risoluzione di conflitti.

Codex deve spiegare la differenza e controllare lo stato locale prima di consigliare o eseguire un pull.

## Routine consigliata

1. Prima del lavoro: controllare branch, stato locale e sincronizzazione con `origin`.
2. Durante il lavoro: mantenere l'incremento circoscritto; proporre un branch se il rischio o la durata lo giustificano.
3. Dopo il lavoro: verificare modifiche e risultati.
4. Quando l'incremento è coerente: proporre un commit e un messaggio comprensibile.
5. Dopo il commit: verificare che la cartella sia pulita.
6. Alla fine della sessione: proporre il push e confermare l'allineamento con GitHub.

## Configurazione su questo computer

Nella PowerShell ordinaria `git` potrebbe non essere disponibile nel `PATH`. Se è stata definita la variabile della sessione:

```powershell
$git = "C:\Users\39348\.cache\codex-runtimes\codex-primary-runtime\dependencies\native\git\cmd\git.exe"
```

i comandi possono essere eseguiti con `& $git`. Il percorso della copia integrata di Codex può cambiare dopo un aggiornamento; per un uso generale e stabile è preferibile installare Git for Windows e abilitarlo nel `PATH`.

## Responsabilità di Codex

Codex deve segnalare il momento opportuno per commit, branch, push, fetch, pull o merge; spiegare in parole semplici il motivo e l'effetto; proporre comandi o svolgere l'operazione quando autorizzato; infine verificare e riferire l'esito. Non deve creare commit, branch o operazioni remote soltanto perché esistono modifiche non salvate.
