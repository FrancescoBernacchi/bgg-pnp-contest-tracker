# Acquisizione selettiva materiali Kanare Abstract

## Stato

Concluso. Primo lotto approvato, acquisito e verificato per uso personale esclusivo.

## Classificazione

Acquisizione selettiva da una singola fonte non-BGG. È un incremento autonomo dell'evoluzione multifonte e non appartiene ai cinque workflow dei contest BGG.

## Obiettivo

Selezionare consapevolmente un primo lotto limitato di giochi Kanare_Abstract e, soltanto dopo approvazione esplicita dell'utente, acquisire i materiali autorizzati verificandone provenienza, disponibilità e condizioni d'uso osservabili.

## Input

- database operativo e fonti versionabili Kanare;
- censimento e verificatori Kanare esistenti;
- task di completamento censimento e verifica destinazioni;
- pagine e risorse ufficiali dichiarate da Kanare_Abstract;
- istruzioni di progetto su modello multifonte, acquisizioni e conservazione.

## Perimetro

- ricostruzione dei giochi Kanare con materiali potenzialmente acquisibili;
- proposta di un lotto piccolo e motivato;
- verifica puntuale delle sole risorse approvate;
- acquisizione degli originali approvati sotto `library/`;
- registrazione riproducibile di esiti, metadati, hash e associazioni.

## Esclusioni

- acquisizione prima dell'approvazione esplicita del lotto;
- acquisizione massiva del catalogo o di materiali BGG;
- matching `candidate` e destinazioni `uncertain`, `rejected` o non osservabili;
- regolamenti esclusivamente giapponesi e loro lettura integrale;
- gallerie complete e immagini secondarie non selezionate;
- archivi web, account, login, installazioni o aggiramento di limitazioni;
- verifica massiva delle implementazioni online, modifiche dell'app e nuove esplorazioni generali;
- commit, push, pull, merge o modifica di branch/worktree senza autorizzazione.

## Deliverable

- proposta documentata del lotto, con motivazioni e materiali previsti;
- approvazione dell'utente registrata prima di ogni acquisizione;
- backup verificato del database prima degli aggiornamenti;
- script e verificatori versionabili, idempotenti e riproducibili;
- originali immutati, manifest e SHA-256 per ogni file acquisito;
- aggiornamento delle fonti e dei documenti autorevoli interessati;
- verifiche finali di conteggi, integrità, regressioni e stato Git.

## Criteri di successo

- il lotto proposto è limitato e rispetta tutti i criteri di inclusione ed esclusione;
- nessun download avviene prima dell'approvazione esplicita;
- ogni risorsa acquisita ha provenienza, condizioni osservabili, metadati tecnici, associazione e hash;
- dati BGG non pertinenti e matching `candidate` restano invariati;
- `PRAGMA foreign_key_check` e `PRAGMA integrity_check` superati;
- verificatori Kanare e test applicativi correnti superati;
- documentazione e cruscotto riflettono lo stato effettivo della pipeline.

## Registro operativo

- 2026-09-21: preflight completato; `main` pulito e allineato a `origin/main`.
- 2026-09-21: PWS del progetto e copia canonica entrambi alla versione 1.5.0.
- 2026-09-21: titolo visibile impostato a `2026-09-21 - Acquisizione selettiva materiali Kanare Abstract`.
- 2026-09-21: task classificato come acquisizione selettiva da una singola fonte non-BGG.
- 2026-09-21: avviata la fase obbligatoria di selezione; nessun file scaricato.
- 2026-09-21: ricostruite 141 risorse dichiarate e individuato un lotto prudenziale di 3 giochi/3 PDF EN; rilevata e isolata l'associazione non discriminante dei PDF variante al record aggregato `work_index`.
- 2026-09-21: consultate le pagine ufficiali di classificazione e dettaglio e i termini del sito; i file sono offerti direttamente ma non è stata osservata una licenza aperta o un'autorizzazione alla redistribuzione.

## Proposta del lotto

### Ricostruzione

- Il database contiene 141 risorse Kanare dichiarate: 39 immagini rappresentative e 102 regolamenti (62 EN, 37 JA, 2 ES e 1 ZH).
- Il join tecnico fra record confermati e regolamenti EN restituisce 63 giochi, ma non è assunto come insieme acquisibile: i quattro PDF di varianti collegati al record aggregato `work_index` risultano attribuiti in modo non discriminante a più giochi e sono esclusi dal primo lotto.
- Restano esclusi i 15 matching `candidate`, tutte le destinazioni incerte o respinte, i 37 regolamenti JA, le immagini secondarie e le implementazioni online.
- Le pagine ufficiali distinguono esplicitamente `Pentwall` come Print & Play, `ViceVeresi`/`ViceVersi` e `Chess Territorial` come giochi utilizzabili con componenti classici.

### Lotto proposto — 3 giochi, 3 file

| Gioco | Identità | Materiale previsto | Motivazione | Limite noto |
|---|---|---|---|---|
| Pentwall | matching Kanare `confirmed`; pagina ufficiale dedicata | PDF EN `Pentwall_EN.pdf`, dichiarato come `Rules + Printable Board` | unico titolo classificato esplicitamente Print & Play dalla fonte; file autosufficiente con plancia stampabile | nessuna licenza esplicita osservata; uso personale locale, nessuna redistribuzione |
| ViceVeresi | matching Kanare `confirmed`; titolo pagina `ViceVersi` preservato come anomalia nota | PDF EN `ViceVersi_rules_EN.pdf` | gioco “solo regole” con componenti Othello/Reversi comuni; piccolo ingombro e valore pratico per la collezione | grafia divergente da preservare; nessuna licenza esplicita osservata |
| Chess Territorial | matching Kanare `confirmed`; pagina ufficiale dedicata | PDF EN `Chess_Territorial_EN.pdf` | gioco “solo regole” utilizzabile con un normale set di scacchi; identità e provenienza nette | nessuna licenza esplicita osservata |

Non sono proposte immagini: per questi tre titoli il valore del lotto è nei materiali giocabili, mentre l'acquisizione di immagini non è necessaria e le immagini secondarie sono escluse.

### Condizioni osservate prima dell'approvazione

- I tre PDF sono collegati direttamente dalle rispettive pagine ufficiali Kanare e sono pubblicamente accessibili senza account nella navigazione osservata.
- Le pagine presentano i collegamenti come regole; per Pentwall il collegamento è dichiarato anche come plancia stampabile.
- I termini del sito non espongono una licenza aperta o un permesso di redistribuzione e vietano la copia o lo sfruttamento del servizio senza autorizzazione espressa. L'eventuale acquisizione sarà quindi limitata alla copia locale per uso personale dei file che il titolare offre direttamente, senza pubblicazione, redistribuzione o derivati.
- Disponibilità finale, URL finale, MIME, dimensione e hash saranno verificati soltanto dopo approvazione, durante l'acquisizione controllata.

### Esclusi dal primo lotto

- tutti i 15 matching `candidate`;
- varianti collegate al record aggregato `work_index`, per associazione non sufficientemente puntuale;
- titoli commerciali con soli regolamenti quando non aggiungono un vantaggio specifico al primo test della pipeline;
- tutti i regolamenti JA, immagini e destinazioni online.

## Approvazione dell'utente

Ricevuta il 2026-09-21 per l'intero lotto proposto. L'utente ha inoltre confermato che tutto il progetto è destinato esclusivamente all'uso personale.

## Verifiche, risultati e chiusura

### Backup

- `database/pnp_collection.pre-kanare-acquisition-20260921.sqlite3`, verificato prima dell'aggiornamento;
- SHA-256 `f032c436e464a48f8be7df4b04e70586ecdb0af7c9d4248ad5a71a38dbf476e4`;
- `integrity_check=ok` e nessuna violazione di chiave esterna.

### Materiali acquisiti

| Gioco | Percorso locale | Byte | MIME | SHA-256 |
|---|---|---:|---|---|
| Pentwall | `library/kanare-abstract/pentwall/originals/Pentwall_EN.pdf` | 1.499.855 | `application/pdf` | `c96cceee5b7326b7d84877321214e82c3173486656bfe84c407b08ca63481fac` |
| ViceVeresi | `library/kanare-abstract/viceveresi/originals/ViceVersi_rules_EN.pdf` | 189.925 | `application/pdf` | `88aa59877d6b2f28e0280bc2ede7db2f8e7d9b18f0261bccd7917df6594718da` |
| Chess Territorial | `library/kanare-abstract/chess-territorial/originals/Chess_Territorial_EN.pdf` | 621.622 | `application/pdf` | `7ef2766a8a47efc4eae22bd09e3738c92b2242b1d40db247ac3ce40920f5e784` |

Tutti i download hanno restituito HTTP 200 e `application/pdf`; la firma `%PDF-` è stata verificata. Gli originali non sono stati modificati e non sono stati creati derivati.

### Implementazione riproducibile

- migrazione generale `010_multisource_acquired_files.sql` per collegamento a `catalog_resources`, URL finale, lingua, esito e condizioni d'uso;
- manifest `catalog/kanare_abstract_acquisition_batch_2026-09-21.json`;
- applicatore idempotente `catalog/apply_kanare_abstract_acquisition.py`;
- verificatore `catalog/verify_kanare_abstract_acquisition.py`.

### Rendiconto e conteggi

- proposti, approvati e acquisiti: 3 giochi / 3 file;
- falliti, selezionati ma non acquisiti e non disponibili nel lotto: 0;
- esclusi: 15 matching `candidate`, 37 regolamenti JA, immagini, implementazioni online, varianti con attribuzione aggregata e titoli non selezionati;
- `acquisitions`: 0 → 3; `acquired_files`: 0 → 3;
- invarianti Kanare: 64 giochi canonici, 76 record, 141 risorse e 15 matching `candidate`;
- invarianti BGG: 305 contest, 946 entry, 1.054 classifiche e 327 risorse remote;
- tre hash distinti, nessun duplicato byte-identico.

### Verifiche finali

- applicatore rieseguito con conteggi invariati a 3/3;
- corrispondenza completa manifest–database–file locali;
- verificatori acquisizione e import Kanare superati;
- test migrazione multifonte superato;
- `foreign_key_check` vuoto e `integrity_check=ok`;
- backend 16/16 e frontend 20/20 superati;
- nessun matching `candidate` modificato implicitamente;
- `.gitignore` esclude originali, database operativo e backup.

### Limiti e prossimo incremento

Non è stata osservata una licenza aperta o un'autorizzazione alla redistribuzione: i file restano per uso personale esclusivo. Le varianti associate al record aggregato `work_index` richiedono una futura correzione puntuale della provenienza.

Il prossimo incremento utile è un eventuale **secondo lotto selettivo Kanare_Abstract**, in un nuovo task; in alternativa, un task distinto può correggere l'attribuzione delle quattro varianti senza acquisirle.

Messaggio di commit proposto, non eseguito: `Acquisisce il primo lotto personale Kanare Abstract`.
