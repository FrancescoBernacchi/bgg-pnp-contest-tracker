# Standardizzazione esplorazioni BGG

## Stato

Completato il 18 settembre 2026.

## Scopo

Definire i cinque tipi standard di attività BGG del progetto, separandone unità di lavoro, contenuti e criteri di instradamento. Rendere obbligatorio l'avviso all'utente quando una richiesta combina perimetri che devono essere gestiti con task distinti.

## Input

- decisioni dell'utente del 18 settembre 2026;
- workflow esistente in `AGENTS.md` e `PROJECT.md`;
- skill locale `bgg-contest-navigation`;
- protocollo di monitoraggio e regole di acquisizione esistenti.

## Deliverable

- tassonomia autorevole dei cinque tipi di attività in `PROJECT.md`;
- regole operative e di orientamento proattivo in `AGENTS.md`;
- aggiornamento dello stato metodologico del progetto;
- rimozione della precedente sovrapposizione fra censimento annuale e analisi dei materiali.

## Criteri di successo

- entry censite soltanto in task dedicati a un singolo anno;
- WIP, risorse e requisiti materiali analizzati soltanto in task dedicati a un singolo contest;
- download e acquisizioni eseguiti soltanto in task dedicati a un singolo contest;
- monitoraggio separato dalle attività di censimento e acquisizione;
- nelle richieste di pianificazione l'agente indica il prossimo task conforme e segnala eventuali deviazioni.

## Decisioni

I cinque tipi standard sono: `Censimento globale contest`, `Censimento annuale entry`, `Analisi materiali del contest`, `Acquisizione materiali del contest` e `Monitoraggio del contest`.

## Verifiche

- `PROJECT.md` contiene nomi, unità di lavoro, contenuti, esclusioni e convenzioni dei titoli per tutti e cinque i tipi.
- `AGENTS.md` impone la classificazione preventiva, l'avviso sulle deviazioni e l'uso della tassonomia anche nelle risposte sulle prossime attività.
- La skill BGG applica lo stesso instradamento prima della navigazione.
- Le precedenti indicazioni che collocavano WIP e materiali nel task annuale sono state sostituite nei documenti autorevoli; il sondaggio storico è marcato come superato su questo punto.
- `PROJECT_PROGRESS.md` indirizza analisi e acquisizione verso task per singolo contest.
- `git diff --check` non segnala errori di whitespace; restano soltanto gli avvisi attesi sulla conversione LF/CRLF.

## Esito

I cinque workflow sono ora la regola durevole del progetto. Nessun dato del database è cambiato in questo task.
