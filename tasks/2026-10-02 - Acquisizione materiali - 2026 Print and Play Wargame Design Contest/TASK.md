# Acquisizione materiali - 2026 Print and Play Wargame Design Contest

## Stato

Sospeso su richiesta dell'utente il 2026-10-03. La selezione non è stata approvata; nessun host esterno è stato aperto e nessun file è stato scaricato. Il task potrà essere ripreso dopo l'avanzamento del contest, preferibilmente quando votazioni o risultati offriranno segnali di priorità più solidi.

## Contratto

- Tipo standard: **Acquisizione materiali del contest**.
- Unità di lavoro: solo `2026 Print and Play Wargame Design Contest`.
- Obiettivo: selezionare un primo lotto limitato, verificare condizioni e disponibilità delle sole risorse approvate e acquisire esclusivamente originali autorizzati per uso personale.
- Input: analisi materiali conclusa del 2026-10-02, snapshot del contest con 23 entry, database operativo, schema e protocollo di acquisizione già sperimentato nel progetto.
- Esclusioni: altri contest; acquisizione dell'intera annualità; risorse non approvate; account, login o aggiramento di restrizioni; moduli di gioco online; redistribuzione; commit, push o altre modifiche Git senza autorizzazione.

## Fonti iniziali

- `sources/2026-WARGAME-MATERIALS.md`.
- `catalog/2026-wargame-materials.sql`.
- `catalog/2026-wargame-monitor-2026-10-02.sql`.
- `tasks/2026-10-02 - Analisi materiali - 2026 Print and Play Wargame Design Contest/TASK.md`.
- Thread ufficiale BGG e GeekList 369157 già registrati nell'analisi; non riaperti prima dell'approvazione.

## Deliverable

- selezione motivata e approvazione dell'utente registrata prima di qualunque verifica esterna;
- verifica per le sole risorse selezionate di liceità e condizioni osservabili, accessibilità, versione, URL finale e tipo di contenuto;
- originali immutati sotto `library/`, esclusi da Git, senza sovrascrivere versioni precedenti;
- manifest versionabile con provenienza, data, dimensione, MIME, SHA-256, versione e osservazioni;
- registrazione nel database di decisione, acquisizione, file e osservazioni remote, preservando lo storico;
- backup verificato del database prima delle modifiche e procedura riproducibile/idempotente;
- aggiornamento di `PROJECT_PROGRESS.md` e chiusura documentata con verifiche e prossimo passo utile.

## Criteri di successo

- nessun host esterno viene aperto e nessun download avviene prima dell'approvazione esplicita;
- ogni file acquisito appartiene a una entry approvata ed è offerto pubblicamente dal relativo autore o dalla fonte dichiarata, senza eludere controlli di accesso;
- condizioni e limiti d'uso osservabili sono registrati; in assenza di licenza aperta la copia resta per uso personale e non viene redistribuita;
- ogni originale ha percorso stabile, URL di provenienza, nome, versione osservata, byte, MIME e SHA-256;
- manifest, database e filesystem concordano; `PRAGMA foreign_key_check` è vuoto e `PRAGMA integrity_check` restituisce `ok`;
- le sezioni annuali A e B di `PROJECT_PROGRESS.md` sono rigenerate prima dell'aggiornamento qualitativo e i test pertinenti superano.

## Preflight

- 2026-10-02: PWS del progetto e copia canonica entrambi alla versione `1.5.0`.
- 2026-10-02: sandbox ordinario, lettura locale e repository verificati; working tree pulita.
- 2026-10-02: `HEAD`, `main` e `origin/main` coincidono al commit `8a3a7a8` (`Analizza materiali Wargame PnP 2026`); il worktree gestito usa un `HEAD` staccato.
- 2026-10-02: l'analisi materiali dello stesso contest risulta conclusa; il monitoraggio dello stesso contest resta un flusso separato e non include acquisizioni.
- 2026-10-02: titolo visibile impostato secondo la convenzione del progetto.

## Criterio di selezione

Il contest non dispone ancora di risultati o votazioni ufficiali: il voto aprirà l'11 novembre 2026. La selezione non è quindi una graduatoria. Usa come segnali sostitutivi, dichiarati e non equivalenti a un risultato:

1. stato `playtest_ready` osservato nello snapshot del contest;
2. presenza di un insieme giocabile dichiarato, con regole e componenti PnP;
3. versioni esplicite, quando disponibili;
4. lotto piccolo e tecnicamente vario, utile a verificare la pipeline senza acquisizione massiva;
5. esclusione prudenziale di alternative grafiche o linguistiche duplicate dal primo lotto.

## Proposta del primo lotto

| Entry | Stato/segnale | Risorse proposte | Motivazione | Esclusioni del lotto |
|---|---|---|---|---|
| Warring States: West Africa | `playtest_ready`; set dichiarato completo | regole v1.2; plancia standard; carte e segnalini standard | copre regole e componenti separati con versione esplicita del regolamento | varianti low-ink, per evitare duplicati funzionali nel primo lotto |
| The Ground Fortified | `playtest_ready`; bundle PnP dichiarato | regole v1.01; bundle mappa, counters, carte e aiuto giocatore v1.0 | set compatto di due file, con versioni esplicite e componenti raggruppati | nessuna risorsa aggiuntiva dichiarata |
| Glières 1944 | `playtest_ready`; PnP dichiarato | regole inglesi v0.5; PnP v0.5 | coppia regole/materiali con versione coerente e host diverso, utile alla verifica controllata | regole francesi duplicate linguisticamente; TTS senza URL nel primo post |

Totale proposto: **3 entry e 7 file dichiarati**. Le destinazioni non sono ancora state aperte; disponibilità, licenza/condizioni, contenuto effettivo, MIME, dimensione e URL finale restano da verificare dopo l'approvazione.

## Alternative non selezionate ora

- Le altre 15 entry con URL dichiarati restano nel catalogo ma non vengono verificate in questo lotto.
- Le 5 entry `none_declared` non sono interpretate come prive di materiali al di fuori del primo post.
- `Warhammer 40,000: Battle line` non entra nel primo lotto: prima di un'eventuale acquisizione richiede una valutazione specifica dell'uso di proprietà intellettuale di terzi.
- Cartelle ampie, documenti modificabili, moduli TTS/Vassal/Screentop, video e pagine progetto non vengono acquisiti automaticamente.
- Alternative low-ink o linguistiche potranno essere valutate in un lotto successivo senza sostituire gli originali già conservati.

## Approvazione dell'utente

Non ricevuta. Il 2026-10-03 l'utente ha ritirato la richiesta di procedere e ha chiesto di sospendere il task. La proposta resta una bozza non operativa e dovrà essere riesaminata, non applicata automaticamente, alla futura ripresa.

## Registro operativo

- 2026-10-02: task classificato come acquisizione per un singolo contest e distinto dal monitoraggio.
- 2026-10-02: skill locale e playbook consultati; l'analisi preesistente fornisce la catena entry → WIP → risorsa dichiarata.
- 2026-10-02: proposta ricostruita esclusivamente dai dati locali già integrati in `main`; nessuna destinazione esterna aperta.
- 2026-10-03: task sospeso su richiesta dell'utente prima dell'approvazione; nessuna verifica di host, acquisizione o modifica del database eseguita.

## Condizione di ripresa

Rivalutare il contest dopo l'apertura delle votazioni dell'11 novembre 2026 o, per una selezione basata sui risultati definitivi, dopo la chiusura del voto del 21 dicembre 2026. Alla ripresa occorrerà verificare lo stato corrente, aggiornare i criteri di priorità e richiedere una nuova approvazione esplicita prima di aprire host esterni.
