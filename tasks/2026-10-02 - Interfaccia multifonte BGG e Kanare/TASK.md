# Interfaccia multifonte BGG e Kanare

## Stato

Concluso il 2026-10-02.

## Tipo e perimetro

Evoluzione applicativa trasversale, distinta dai cinque workflow operativi BGG. Il task non effettua censimenti, monitoraggi, verifiche esterne o acquisizioni: rende consultabile in sola lettura il nucleo multifonte già presente nel database locale.

## Input

- modello canonico e dati multifonte introdotti dalla migrazione `009_multisource_catalog.sql`;
- censimento locale Kanare_Abstract già importato e arricchito;
- applicazione locale BGG in `app/`;
- decisioni deliberate in `PROJECT.md` e nei task multifonte del 20–21 settembre 2026.

La checkout originale contiene modifiche Kanare non committate. Questo task opera nella worktree isolata e non le modifica; eventuali campi o verifiche presenti soltanto nella checkout originale non sono assunti come disponibili.

## Scope

1. Esaminare separazione e relazioni fra gioco canonico, prodotto, record di fonte, risorsa e implementazione.
2. Definire una navigazione con viste comuni e viste specializzate per fonte.
3. Implementare un primo incremento: vista trasversale **Giochi**, ricerca e filtri multifonte, scheda canonica con provenienza e ambiguità, accesso alle viste BGG già esistenti e a una prima vista specializzata Kanare.
4. Conservare server loopback, SQLite read-only e assenza di richieste esterne automatiche.
5. Aggiornare documentazione e test senza migrare o modificare i dati operativi.

## Esclusioni

- scraping, navigazione o richieste verso BGG, Kanare o destinazioni collegate;
- importazione, aggiornamento o riconciliazione dei dati;
- acquisizione di immagini, regolamenti o materiali;
- stati personali, simulatori e prototipazione 3D;
- commit, branch, push, pull, merge o altre mutazioni Git.

## Deliverable

- decisione documentata su viste comuni e specializzate;
- API locali read-only per catalogo e dettaglio multifonte;
- interfaccia navigabile per Giochi e Kanare_Abstract, integrata con le viste BGG esistenti;
- test server/frontend aggiornati e verifiche sul database reale quando disponibile;
- aggiornamento di `app/README.md` e chiusura auditabile del task.

## Criteri di successo

- un gioco è mostrato una sola volta come identità canonica, senza confonderlo con prodotti o record nativi;
- ricerca e filtri attraversano titoli/alias e fonti, esplicitando matching `candidate`, `confirmed` e `rejected` senza fusioni implicite;
- scheda gioco distingue provenienza, record, prodotti, risorse e implementazioni;
- le funzioni BGG specifiche (contest, entry, classifiche, monitoraggio) restano dedicate a BGG;
- Kanare dispone di una vista specializzata basata soltanto sui dati locali;
- ogni endpoint mantiene il contratto HTTP in sola lettura e nessun caricamento pagina causa traffico esterno;
- suite di test applicativa superata e decisioni/limiti registrati.

## Decisioni e verifiche

### Architettura della navigazione

- **Comuni a tutte le fonti:** vista Giochi, identità canonica, ricerca su titolo e alias, filtro per fonte, parametri generali, prodotti collegati, risorse, implementazioni, nomi e provenienza.
- **Specializzate BGG:** avanzamento, contest, entry, risultati, scadenze, rilevamenti, WIP e requisiti materiali. Sono concetti propri del workflow dei contest e non vengono generalizzati artificialmente.
- **Specializzate Kanare_Abstract:** prima vista di fonte sui giochi collegati ai record Kanare; prodotti/confezioni e implementazioni dichiarate restano accessibili dalla scheda comune. Ulteriori funzioni Kanare richiederanno evidenza di un ciclo di vita proprio.
- **Fonti future:** entrano nella vista comune tramite `catalog_sources`, `source_records` e matching. Una voce specializzata è aggiunta soltanto per funzioni non rappresentabili nel nucleo comune.

La vista comune conta righe di `games`, mai record nativi o prodotti. I record con matching `candidate` o `rejected` restano visibili nella scheda e non sono trattati come identità confermate. Le risorse della scheda sono attribuite esplicitamente via gioco, record non respinto o prodotto; il percorso di attribuzione è restituito dall'API.

BoardGameGeek compare nel filtro comune anche per le entry legacy che precedono la migrazione 009. L'etichetta è derivata dalla presenza in `entries` e non crea un record nativo fittizio. La futura materializzazione dei record BGG potrà sostituire questa compatibilità senza cambiare l'interfaccia.

### Implementazione

- esteso `/api/catalog` con fonti e metadati leggeri dei giochi;
- aggiunto `/api/games/ID` con record di fonte, alias, prodotti, risorse, implementazioni, relazioni ed entry;
- aggiunte rotte frontend `#games`, `#game/ID` e `#kanare`;
- mantenuti server loopback, SQLite `mode=ro` + `query_only`, CSP restrittiva, link esterni solo HTTPS e solo su click;
- aggiornati `app/README.md`, `PROJECT.md`, `.workspace/PROJECT_STATE.md` e la salute strumenti in `PROJECT_PROGRESS.md`.

### Verifiche

- `python -m unittest discover -s app -p test_server.py -v`: 17 test superati senza skip dopo aver copiato nella worktree una fotografia verificata del database operativo;
- `node --test app/test_frontend.cjs`: 23 test superati, incluso il mancato trascinamento del filtro fonte dalla vista comune alla vista Kanare;
- `git diff --check`: nessun errore di whitespace; soli avvisi attesi di conversione LF/CRLF;
- API multifonte verificata con fixture sintetica comprendente record confermato e candidato, alias giapponese, prodotto, implementazione e risorsa attribuita via record di fonte;
- nessuna richiesta esterna, migrazione, modifica del database o operazione Git mutativa eseguita.

### Limiti e dipendenze residue

- il database operativo è escluso da Git e inizialmente assente nella worktree isolata. Dopo il primo tentativo di avvio fallito, ne è stata copiata una fotografia dalla checkout principale senza modificare l'originale; gli hash SHA-256 coincidono (`21B3D441484AF236EFE2E87FA28EA9F870826D03F953B9E4682328DB178CF7CA`);
- le modifiche non committate del task Kanare del 2026-09-21 nella checkout originale non sono state lette o sovrascritte; se contengono evoluzioni non versionate dello schema o dei dati, servirà una verifica di integrazione separata;
- crediti multifonte e relazioni fra giochi sono restituiti o modellati dal backend ma la prima scheda privilegia record, prodotti, risorse, implementazioni ed entry; viste dedicate possono essere aggiunte in un incremento successivo;
- non sono stati introdotti stati personali, scrittura, importazione o aggiornamento delle fonti.

## Esito

Il primo incremento multifonte è coerente e verificato su dati sintetici e sulla fotografia del database operativo: 1.010 giochi canonici, 64 collegati a Kanare_Abstract, 15 con matching candidati, 305 contest e 946 entry. Il server locale risponde su `http://127.0.0.1:8765/`; database integro e nessuna violazione delle chiavi esterne.

Una verifica d'uso nel pannello interno ChatGPT ha rilevato che la vista Kanare poteva ereditare un filtro fonte selezionato nella vista comune, pur non mostrandone il controllo. Il filtro nascosto viene ora azzerato entrando in una vista specializzata; una sessione nuova, come quella aperta dall'icona Desktop, non manifestava il difetto.
