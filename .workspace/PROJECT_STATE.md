---
standard_id: project-workspace-standard
status: initialized
initialized_with: 1.3.0
aligned_version: 1.3.0
initialized_at: 2026-09-04
last_alignment_at: 2026-09-07
---

# Stato del Project Workspace

## Sintesi dell'architettura

Archivio locale di giochi Print and Play individuati su BoardGameGeek, con catalogazione completa delle entries e acquisizione selettiva dei materiali. Il progetto separa applicazione (`app/`), persistenza operativa (`database/`), metadati versionabili (`catalog/`), materiali binari locali (`library/`), provenienza e calendario di monitoraggio (`sources/`), task auditabili (`tasks/`) e risultati rigenerabili (`outputs/`).

## Deviazioni locali dallo Standard

Nessuna deviazione iniziale. I materiali PnP e il database SQLite operativo sono intenzionalmente esclusi da Git; schema, migrazioni, manifest ed esportazioni testuali restano versionabili.

Il repository GitHub privato `FrancescoBernacchi/bgg-pnp-contest-tracker` conserva i contenuti versionabili sul branch `main`. Il remoto locale è `origin`; database operativo, output rigenerabili e materiali di terzi restano esclusi.

## Storico migrazioni

- 2026-09-04: inizializzazione diretta con PWS 1.3.0; nessuna migrazione pregressa.
- 2026-09-04: formalizzato il protocollo di monitoraggio ricorrente e aggiunto `sources/MONITORING_CALENDAR.md`; modifica procedurale applicata al progetto corrente su richiesta esplicita dell'utente.
- 2026-09-05: introdotta la distinzione durevole fra contest PnP autonomi e contest adiacenti; Solomode è incluso come variante dipendente dal gioco base e resta predisposto a filtri o trattamenti futuri differenti.
- 2026-09-05: aggiunto un generatore di cruscotto Markdown basato sulle viste SQLite; l'output è rigenerabile e il processo non accede alle fonti esterne né ai materiali di gioco.
- 2026-09-05: esteso il modello con la cronologia delle fasi e predisposto il cruscotto al confronto automatico fra rilevamenti periodici, mantenendo escluse baseline e verifiche tecniche giornaliere.
- 2026-09-07: consolidata retroattivamente, su richiesta dell'utente, la conoscenza emersa nel task ricorrente: perimetro, profili adiacenti, contratto degli snapshot, calendario, dashboard differenziale e configurazione del repository privato. Nessun nuovo rilevamento BGG e nessuna modifica ai dati operativi.
- 2026-09-07: formalizzato il supporto proattivo dell'agente a un utente non esperto di Git, con spiegazioni contestuali e suggerimenti motivati su commit, branch, push, sincronizzazione e verifiche; aggiunto `GIT_GUIDE.md`.
