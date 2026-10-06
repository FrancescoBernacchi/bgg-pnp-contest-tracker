# Compatibilità, accettazione e autorizzazioni — B-v1

Stato corrente: piano B-v1 confermato il 2026-10-06 in [DECISIONE.md](DECISIONE.md). I punti di autorizzazione per DAT/importazione/APP restano distinti e pendenti; nessuna prova esecutiva compiuta.

TSK-0076, 2026-10-06. Piano da deliberare, nessuna prova di migrazione/importazione eseguita.

## Compatibilità BGG/Kanare e storia

La B aggiunge contratti al nucleo 009; non sostituisce entries/contests, remote_resources, scansioni/menzioni 006, requisiti 007, snapshot monitoraggio o attestazioni 012. Non converte ammissione PerGioco in stati di sviluppo BGG. Le viste/app BGG e metriche Kanare di TSK-0071 mantengono contratti, denominatori e valori. Il MAT Kanare resta nel manifest dedicato TSK-0070, non nelle entry BGG e non viene importato per effetto di questa decisione.

Nessun backfill richiesto per adottare B. Tabelle nuove inizialmente vuote per BGG/Kanare; assenza di osservazione B non significa lavoro storico assente. Le query future devono distinguere dati legacy osservati, dati B attestati, evidenze non formalizzate e ambito non selezionato; fallback legacy con provenienza esplicita, senza inventare completezza. I record Kanare esistenti non ricevono esiti CAT PerGioco; 993 non riceve crediti/categorie PerGioco finché il match è candidato. Matching e credito sono due decisioni: neppure un matching confermato promuove automaticamente tutte le attribuzioni della fonte.

Se successivamente autorizzata, la formalizzazione di prove pregresse registra artefatto/pointer/hash, task originario, observed_at originale, formalized_at successivo e mapping_version. Date ignote restano NULL con motivo; stato legacy non equivale a osservazione nuova. Correzione di una trascrizione mantiene l'originale e registra rettifica, senza attribuirle una nuova visita esterna. L'operazione dovrà avere contratto e denominatore separati: nessun riesame o consolidamento tassonomico implicito.

I metadati globali legacy delle risorse possono avere provenienza incompleta. La B non li reinterpreta come attestazioni su ogni menzione. Una risorsa condivisa rimane riusabile, ma accesso e costo sono letti dalla prova contestuale. Lo storico URL pregresso non ricostruibile rimane ignoto; mai generare redirect fittizi per colmare buchi. Autorità del CAT resta il manifest fissato per hash, con limiti di esattezza e osservabilità originari.

## Casi di accettazione sulle dodici candidate

| Candidato | Piano futuro | Prova semantica da mantenere |
|---|---|---|
| PGP-001 Achi | Nuovo game, admitted | Care alias dichiarato; tradizionale, designer non dichiarato; variante interna non game |
| PGP-002 Krypte | Nuovo game, admitted | I-K/K nel breadcrumb e I-J-K nell'indice; attrezzatura simile non obbligo prodotto |
| PGP-003 Abande | candidate→993, admitted | Niente game nuovo né crediti canonici; alternative tavoliere interne; menzione PDF senza URL |
| PGP-004 Abande Libre | Nuovo game, admitted | Variante distinta, regole base+variante gratuite; due asserzioni verso record Abande, zero arco canonico verso 993 |
| PGP-005 Chomp | Nuovo game, admitted | Carta e matita osservata; nessuna categoria matematica inferita; rettangoli diversi non giochi |
| PGP-006 Itinera | Un nuovo game, admitted | Due istanze 18/06/2021 e 23/07/2021; soluzioni separate, final login preservato, nessun solution_for |
| PGP-007 Azul | source-only, requirement_not_demonstrated | Introduzione gratuita distinta da regole complete non dimostrate; varianti editoriali non nuove candidate |
| PGP-008 Reversi | Nuovo game, admitted | Crediti concorrenti/editori distinti, Reversino alias; Othello rimando non fusione automatica |
| PGP-009 Blockade (1975) | source-only, requirement_not_demonstrated | Slater e Lakeside attribuiti dalla fonte; Cul-de-Sac alias; PDF non verificato |
| PGP-010 Blockade (2001) | source-only, requirement_not_demonstrated | Kristin Looney, 5x5 senza genitore inferito; Cooper/Andrew Looney riferiti a Icehouse, non a Blockade |
| PGP-011 Beeline (1968) | Nuovo game, admitted | Heading Beeline/indice qualificato, Winston N. Allen; immagine etichettata Abande non prova identità |
| PGP-012 Beeline (1984) | Nuovo game, admitted | Heading Beeline/indice qualificato, John Brassell; URL storico diverso dal finale, vittoria simultanea parametrica preservata |

Ogni caso ha crediti, URL diretti e data 2026-10-06 nelle evidenze CAT riusate e CASI_PILOTA; anni e autori non verificati indipendentemente. Marino Carpignano quale site_curator_owner dalla FAQ non implica designer/traduttore delle dodici schede. Le mancanze per ruolo restano esplicite, non persone senza nome. La tabella sintetica non sostituisce il manifest.

## Criteri di accettazione del futuro DAT

1. Migrazione additiva su copia: tutti gli ID, valori, FK, viste e conteggi legacy preservati; niente inserimenti PerGioco nel solo task di schema. Vincoli append-only, FK RESTRICT, chiavi/unicità/NULL e catene di rettifica collaudati; schema versionato e mapping fisico completo del modello logico. Integrità e foreign_key_check validi, lettura app precedente funzionante.
2. Import separato: dodici record fonte, 9/3 esiti, otto nuovi games, un candidato a 993 e tre senza game link automatico. Niente products/game_implementations creati. Identità decise per mapping stabile, non titolo. Baseline completa, tutte le appartenenze/menzioni/crediti/gap e date ricostruibili campo per campo; count classificazioni/menzioni riconciliato con matrice, non dedotto da URL.
3. Quattro menzioni PDF senza URL restano presenti senza catalog_resources inventati. Abande/base Libre riusano la destinazione esatta, mantenendo menzioni e prove separate. Soluzioni Itinera rimangono richieste a solutions.php, final imlogin distinto; account dichiarato gratuito non rende osservato/costo zero il contenuto riservato. Condizioni per ambito e NULL invariati.
4. Itinera 1 game/2 istanze/0 solution_for; Libre game distinto/2 relazioni fonte/0 relazione canonica confermata verso 993. Beeline e Blockade omonimi separati; categorie native originali, mapping comune vuoto; nessuna categoria matematica Chomp.
5. Import senza rete, manifest/anteprima fissati per hash, transazione unica con foreign_keys ON, ledger import e decisione autorizzante. Replay identico zero delta su tutte le tabelle e proiezioni; nuova visita identica crea evento storico; rettifica crea nuova versione senza perdita. Payload originale verificato con hash canonico e confronto semantico.
6. Collisioni di chiave locale/URL corrente, titolo uguale, stesso nome persona, più prove stesso URL, URL NULL, booleani NULL, duplicate join con NULL, data uguale di istanze, snapshot parziale e errore intermedio collaudati su copia con fixture sintetiche. Collisione non risolta rifiuta l'intera transazione, mai INSERT OR REPLACE; cambi input non autorizzati bloccano il lotto.
7. Backup consistente e restore su copia provati prima dell'operativo; dopo esecuzione, verifica conteggi/diff legacy, integrità e lettura app. Nessun automatismo di disponibilità/costo/licenza o avanzamento APP.

Questi sono test richiesti a strumenti futuri: il presente incremento verifica soltanto la matrice offline e coerenza degli input. Una prova JSON riuscita non dimostra replay SQL, integrità delle nuove FK o efficacia del backup.

## Idempotenza e vincoli pratici

Ledger per lotto/versione/hash e chiavi stabili candidato→record/game/persona risolta. Hash deterministico con oggetti ordinati e array nell'ordine originale, senza rimuovere NULL o normalizzare stringhe/date raw. Stesso hash ma evento diverso non si deduplica nella storia. Se la chiave è uguale ma il payload differisce: rettifica esplicita o rifiuto; nessun upsert sui fatti.

Non affidarsi ai vincoli UNIQUE legacy con colonne nullable (resource_links/person_names/game_implementations); confronti IS NULL e indici parziali o normalizzazione della chiave semantica da collaudare nel DAT. La stessa chiave semantica non deve fondere occorrenze contestuali diverse. Nessun sentinel URL/persona/anno. Un solo processo scrittore durante il lotto; lock e transazione impediscono race tra precheck e inserimento.

Le proiezioni su game_source_records/game_names/credit_assertions/game_relationships richiedono ledger e decisione specifica; storicizzare ogni variazione di match prima della proiezione. Ripetere una proiezione autorizzata non duplica alias/crediti/legami. Controllare che la proiezione abbia gli stessi proprietari/FK delle prove. Eventuali contraddizioni non cancellano asserzioni concorrenti.

## Backup e ripristino

Nel futuro DAT autorizzato: sospendere scrittori; registrare versione schema, journal mode, conteggi, hash input e ledger. Snapshot mediante SQLite backup API verso percorso locale escluso da Git: include stato consistente anche con WAL, non copia isolata del file principale durante scrittura. Verificare integrity_check/FK, conteggi e SHA-256 del backup; registrare data/percorso e provare lettura/ripristino su copia. Backup distinti prima della migrazione e prima dell'importazione.

Rollback della transazione su errore prima del commit. Se serve restore dopo commit: autorizzazione nel contratto DAT, scrittori fermi, database fallito e sidecar preservati per diagnosi; ripristinare lo snapshot consistente e verificare schema, FK, conteggi, ledger e app. Non sovrascrivere incrementi intervenuti dopo backup: prima riconciliazione e scelta esplicita. Una down-migration distruttiva non è il piano di ripristino predefinito. File library e originali non coinvolti.

## Passi e punti di autorizzazione

| Passo | Prerequisito | Autorizzazione e deliverable |
|---|---|---|
| EPR corrente | TSK-0073/0074/0075 | Preparazione già autorizzata. Conferma esplicita B-v1/piano identità, poi registrazione/promozione documentale; nessuna esecuzione |
| DAT schema/migrazione | EPR confermato | Nuovo contratto esecutivo autorizzato: DDL, prove su copia, backup e applicazione operativa se compresa esplicitamente; zero import PerGioco |
| DAT importazione PerGioco | Schema verificato, piano identità confermato | Contratto separato autorizzato: solo dodici candidate, ledger/idempotenza, backup/diff, 9/3 e otto games/candidato preservati |
| VER Abande eventuale | Richiesta distinta | Confronto identità/versioni entro perimetro autorizzato, decisione sul matching; nessun effetto retroattivo implicito |
| APP | Contratti dati stabili e import verificato o fixture approvate | Task autorizzato per schede fonte, classificazioni/esiti e metriche proprie; candidate/source-only mostrati senza ammissione fittizia |
| MAT/ACQ/IMG futuri | Perimetri propri e policy | Nessun passaggio precedente autorizza automaticamente verifiche, download o immagini |

Se la conferma riguarda solo B e non il piano identità, registrare la distinzione e non chiudere la parte decisionale sulle identità come adottata. Nessuna implementazione parte dalla conferma EPR. PROJECT/AGENTS/PROJECT_STATE/database README ricevono solo la direzione deliberata; il modello operativo resta quello vigente fino a DAT. Lo Standard PWS rimane read-only 1.5.0.
