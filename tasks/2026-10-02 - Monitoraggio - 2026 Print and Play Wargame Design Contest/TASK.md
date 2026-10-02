# Monitoraggio - 2026 Print and Play Wargame Design Contest

## Contratto

- Tipo standard: **Monitoraggio del contest**.
- Unità di lavoro: solo `2026 Print and Play Wargame Design Contest`.
- Input: thread ufficiale BGG, GeekList ufficiale delle entry, baseline del 4 settembre 2026, calendario di monitoraggio e database operativo primario.
- Esclusioni: altri contest, lettura dei WIP oltre i metadati resi nella GeekList, apertura o download di file e materiali, verifica degli host esterni.

## Criteri di successo

- confrontare stato, fasi, roster completo e metriche con l'ultima osservazione;
- preservare le osservazioni storiche e registrare uno snapshot completo collegato a un controllo confrontabile;
- aggiornare database operativo, calendario e cruscotto; verificare integrità e riferimenti.

## Evidenze e metodo

- Verifica esterna: 2026-10-02, sessione BGG autenticata in Chrome.
- Thread ufficiale: `https://boardgamegeek.com/thread/3627732/submissions-closed-2026-print-and-play-wargame-des`.
- GeekList ufficiale: `https://boardgamegeek.com/geeklist/369157/2026-wargame-design-contest-entries`.
- Metodo: lettura del primo post per stato e calendario; estrazione completa dei 23 item renderizzati della GeekList, con posizione, titolo, autore/username e destinazione BGG. Nessuna destinazione di materiali è stata aperta.
- Database operativo identificato e verificato prima della modifica: `C:\PROGETTI CODEX\Progetto PnP Collection\database\pnp_collection.sqlite3`; il worktree corrente non conteneva un database locale.

## Risultato osservato

- Il titolo del thread è ora `[SUBMISSIONS CLOSED]`.
- Le submission si sono chiuse il 1 ottobre; dal 2 ottobre le entry esistenti possono continuare lo sviluppo fino all'apertura del voto dell'11 novembre. Chiusura voto invariata al 21 dicembre.
- La GeekList riporta **23 item**, contro i 18 della baseline: cinque nuove entry in coda (`Glières 1944`, `Sitka ever lost`, `The Lost Eagles`, `Garland 1942`, `Imposed Cost`).
- Tra le 18 entry già presenti, `CYBERAIDER` passa da WIP a Playtest Ready e `Balled Moves` da Idea Phase a Components Ready. Nessuna entry baseline manca dal roster corrente.
- Distribuzione prudenziale dai soli titoli: 13 `playtest_ready`, 2 `components_available`, 1 `idea`, 6 `wip`, 1 `unknown`. `Imposed Cost` resta `unknown` perché il titolo non espone un marcatore di stato.

## Deliverable e verifiche

- Snapshot riproducibile: `catalog/2026-wargame-monitor-2026-10-02.sql`.
- Backup pre-aggiornamento: `C:\PROGETTI CODEX\Progetto PnP Collection\database\pnp_collection.pre-wargame-monitor-20261002.sqlite3`.
- Database operativo aggiornato in modo append-only per controlli, stato, fasi, metriche e cronologia delle 23 entry; i campi correnti sono stati riallineati senza cancellare la baseline. Il controllo confrontabile ha `check_id=58` e `check_kind=scheduled_deadline_monitor`.
- `sources/MONITORING_CALENDAR.md` e `PROJECT_PROGRESS.md` aggiornati nello stesso incremento.
- Verifiche finali: 23 entry correnti; 23 righe nello snapshot entry; 5 snapshot di fase; 6 metriche; nuove posizioni 19–23; `PRAGMA foreign_key_check` senza righe e `PRAGMA integrity_check = ok`.

## Chiusura

Task circoscritto al monitoraggio post-chiusura del contest. Prossimo controllo utile: **12 novembre 2026**, dopo il freeze/apertura voto dell'11 novembre, per verificare roster finale, stati, modulo e finestra di voto senza aprire materiali.
