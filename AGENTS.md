# AGENTS.md

## Missione del progetto

Costruire e mantenere una collezione locale, ricercabile e tracciabile di giochi Print and Play scoperti inizialmente nei contest di BoardGameGeek.

## Modello operativo

Catalogare tutte le entries comprese nel perimetro del task e acquisire i materiali soltanto per i giochi selezionati. Partire dai contest attivi più recenti. Basare la priorità principalmente su classifiche e votazioni BGG, distinguendo sempre risultati ufficiali da segnali sostitutivi.

Conservare separatamente i contest PnP autonomi e i contest adiacenti autorizzati. Per le varianti dipendenti da un gioco base, registrare tale dipendenza e non presumere che esistano componenti PnP aggiuntivi.

## Mappa del progetto

- `README.md`: introduzione operativa e stato sintetico per il repository GitHub.
- `GIT_GUIDE.md`: guida semplice e protocollo di supporto Git/GitHub per l'utente.
- `PROJECT.md`: scopo, vincoli e architettura autorevole.
- `.workspace/PROJECT_STATE.md`: stato di inizializzazione e allineamento PWS.
- `app/`: interfaccia locale Python/HTML/CSS/JavaScript in sola lettura; `server.py`, asset in `static/`, launcher `start.ps1`, test e guida `README.md`; include il generatore Markdown preesistente.
- `database/schema.sql`: modello relazionale autorevole iniziale.
- `database/migrations/`: evoluzioni ordinate dello schema.
- `catalog/`: manifest ed esportazioni testuali versionabili.
- `library/`: materiali PnP acquisiti; contenuto escluso da Git.
- `sources/`: registri e note di provenienza riutilizzabili.
- `sources/MONITORING_CALENDAR.md`: taccuino autorevole delle prossime finestre di controllo BGG e degli ultimi rilevamenti.
- `tasks/`: workspace auditabili delle attività non banali.
- `outputs/`: risultati rigenerabili, esclusi da Git salvo documentazione.

## Workflow dei task

Per ogni attività autonoma o multi-step creare `tasks/YYYY-MM-DD - descrizione/TASK.md`. Il task di bootstrap usa eccezionalmente `2026-09-04 - SETUP INIZIALE PROGETTO`. Definire scope, input, deliverable e criteri di successo prima di operare; lavorare per incrementi verificabili; chiudere registrando verifiche, decisioni e risultati riutilizzabili.

## Regole della conoscenza

Conservare separatamente dati originali, valori normalizzati e inferenze. Ogni informazione volatile deve includere fonte e data di verifica. Una nota di task diventa conoscenza condivisa solo dopo verifica e promozione deliberata. Non perdere nomi o stati storici quando un gioco viene rinominato, ritirato o aggiornato.

## Regole degli output

Il database SQLite è operativo e locale. Schema, migrazioni, manifest ed esportazioni testuali sono versionabili. Materiali scaricati e output rigenerabili non entrano in Git. Non modificare i file originali acquisiti; eventuali derivati devono essere chiaramente separati e riconducibili alla fonte.

## Protocollo di monitoraggio

- Prima di un controllo periodico consultare `sources/MONITORING_CALENDAR.md` e privilegiare la prima finestra scaduta o l'evento più vicino.
- Non ripetere un rilevamento esterno nello stesso giorno, salvo correzione di un errore, nuovo annuncio BGG o richiesta esplicita dell'utente.
- Distinguere una verifica tecnica di importazione o consistenza da un rilevamento dello stato esterno; soltanto il secondo alimenta la cadenza periodica.
- Per contest con entry o sviluppo aperti usare normalmente una cadenza settimanale, intensificata nei sette giorni prima delle scadenze e il giorno successivo agli eventi di fase.
- Non ricontrollare ordinariamente i contest conclusi, salvo risultati incompleti, rettifiche o nuovi riferimenti autorevoli.
- Registrare anche gli esiti `no_change`, ma soltanto quando il controllo era dovuto; aggiornare sempre il taccuino con esito e prossima finestra.
- Usare per i rilevamenti effettivi un `contest_checks.check_kind` contenente `monitor`, `scheduled`, `deadline` o `follow_up`; riservare `baseline`, `census` e `consistency` alle attività che non devono alimentare il confronto periodico.
- Ogni rilevamento confrontabile deve rappresentare uno snapshot completo dell'entità osservata e collegare tramite `check_id` stato del contest, entry, metriche e fasi disponibili. Non interpretare l'assenza da uno snapshot parziale come rimozione.
- Nei task di solo monitoraggio non aprire né scaricare file di gioco: usare thread, GeekList, Hub, titoli, tabelle e metadati pubblici.
- Al termine di ogni incremento indicare autonomamente il prossimo controllo o approfondimento utile, senza attendere che venga richiesto.

## Evoluzione strutturale

Cambiare la struttura solo quando emerge un ciclo di vita distinto o un pattern stabile. Aggiornare insieme `PROJECT.md`, questa mappa e lo stato del progetto quando una modifica architetturale diventa permanente.

## Supporto Git e GitHub

- Assumere che l'utente non sia esperto di Git. Quando un'azione Git diventa opportuna, segnalarla autonomamente e spiegarne in linguaggio semplice scopo, vantaggio e possibile effetto.
- Prima di iniziare un incremento, controllare quando utile branch, stato della working tree e relazione con `origin`; avvisare se esistono modifiche non committate o divergenze remote.
- Suggerire un commit quando è concluso un incremento coerente e verificato. Riassumere cosa includerà e proporre un messaggio di commit chiaro.
- Suggerire un branch prima di modifiche sperimentali, rischiose, di lunga durata o con alternative da confrontare. Evitare branch inutili per cambiamenti piccoli e lineari.
- Suggerire il push dopo un commit significativo o alla fine di una sessione, spiegando che trasferisce su GitHub commit già locali. Verificare poi l'allineamento fra branch locale e remoto.
- Spiegare `fetch`, `pull`, `merge`, conflitti e pull request nel momento in cui diventano rilevanti; non presumere che i termini siano noti.
- Non eseguire automaticamente commit, creazione/rinomina di branch, push, pull, merge o altre modifiche Git solo perché sarebbero consigliabili: proporre l'azione e procedere quando l'utente la richiede o la autorizza chiaramente.
- Prima di commit e push verificare `.gitignore` e segnalare file inattesi, sensibili, generati o di terzi. Dopo ogni operazione verificare e comunicare risultato, commit, branch e stato residuo.
- Quando si mostrano comandi da eseguire nella PowerShell ordinaria, tenere conto che Git potrebbe non essere nel `PATH`; usare la convenzione `$git` descritta in `GIT_GUIDE.md` o offrire di eseguire l'azione tramite Codex.

## Relazione con lo Standard

Questo progetto segue Project Workspace Standard versione 1.3.0. Consultare lo Standard per metodologia, governance, evoluzione e migrazioni. Non modificare lo Standard da questo progetto.

## Vincoli specifici

- BoardGameGeek è l'unica fonte iniziale; aggiungerne altre solo tramite task esplicito.
- Non aggirare autenticazione, limitazioni tecniche o condizioni di accesso.
- Verificare liceità e condizioni applicabili prima di acquisire o utilizzare materiali.
- Non redistribuire opere di terzi.
- Calcolare un hash per ogni file acquisito e preservare tutte le versioni.
- Mantenere lo stato specifico dichiarato oltre allo stato normalizzato.
- Preservare i conteggi precedenti quando una rilevazione successiva li corregge; marcare chiaramente quale osservazione è operativa.
- Il repository GitHub privato versiona soltanto contenuti ammessi da `.gitignore`; il branch principale è `main` e il remoto convenzionale è `origin`.

## Definition of Done

Un task è concluso quando i deliverable sono verificati, fonti e date sono registrate, i materiali acquisiti hanno manifest e hash, le decisioni durevoli sono promosse nei file autorevoli e `TASK.md` documenta la chiusura.
