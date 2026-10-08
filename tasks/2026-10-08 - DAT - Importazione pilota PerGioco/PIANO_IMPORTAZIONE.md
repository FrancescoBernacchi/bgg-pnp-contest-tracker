# TSK-0078 — Contenuto e autorizzazione finale

Preparazione 2026-10-08, sulla baseline CAT verificata 2026-10-06. Importer `catalog/import_pergioco_pilot.py`, test su copie `catalog/test_pergioco_import.py`; schema vigente B-v1/013 verificato per definizioni esatte. Nessuna migrazione/schema/app modificati. Operativo non scritto; nessun commit/push.

## Contenuto preciso del lotto

Fonte PerGioco: una nuova catalog_sources, dodici source_records di tipo game_page, native_id NULL, dodici chiavi locali PGP-001..012 distinte dagli ID nativi; URL finale, originale, titolo qualificato e intero payload CAT canonico. SHA-256 del manifest: `ab15231c9185b93b78e8896d28edc91f46d671c0bb434067a24e6e707eeef45e`. Oggetti JSON ordinati, array nell'ordine originale, NULL preservati; hash canonico separato dall'hash file. L'evento resta TSK-0074:2026-10-06, formalized_at registra il momento dell'importazione futura con timezone. Il mapper non interpreta il payload mutato come nuova visita: rifiuta manifest diverso; rettifiche/nuove visite richiedono altro contratto, non questo importer del pilota congelato.

| Record | Piano canonico | Esito CAT |
|---|---|---|
| PGP-001 Achi | nuovo game | admitted |
| PGP-002 Krypte | nuovo game | admitted |
| PGP-003 Abande | candidato a 993, nessun nuovo game | admitted |
| PGP-004 Abande Libre | nuovo game, relazione solo fonte verso Abande | admitted |
| PGP-005 Chomp | nuovo game | admitted |
| PGP-006 Itinera | nuovo game, due istanze datate | admitted |
| PGP-007 Azul | source-only | requirement_not_demonstrated |
| PGP-008 Reversi | nuovo game | admitted |
| PGP-009 Blockade (1975) | source-only | requirement_not_demonstrated |
| PGP-010 Blockade (2001) | source-only | requirement_not_demonstrated |
| PGP-011 Beeline (1968) | nuovo game distinto | admitted |
| PGP-012 Beeline (1984) | nuovo game distinto | admitted |

Le quantità esatte per tabella sono in COPY_VERIFICHE.json/table_deltas. Baseline della copia: 1446 games → 1454, 76 record fonte → 88. Dodici snapshot ed esiti ammissione, 26 classificazioni con 96 segmenti ordinati, 24 URL storici/finali, 21 menzioni (quattro PDF senza URL), 16 nuove destinazioni catalog_resources per 17 menzioni dotate di URL, 17 resource_links sul record fonte. Abande/base Libre condividono URL e conservano contesti separati.

73 osservazioni accesso/costo distinte per ambito, quattro riferimenti a condizioni aggregate riusate con applicabilità uncertain (292 link); nessuna licenza di riuso attestata. I quattro ambiti mantengono unknown quando non osservati. Le soluzioni Itinera rimangono risorsa riservata, URL richiesto solutions.php/finale login separati, gratuità dopo autenticazione NULL; due istanze 2021-06-18 e 2021-07-23, due appears_in, zero solution_for. Nessuna catena redirect intermedia inventata.

62 osservazioni crediti/lacune sul record fonte: nomi, ruoli, URL e date conservati; nessun people o credit_assertions nuovi, nessuna risoluzione persona per nome. Le organizzazioni e i soggetti citati conservano il contesto originale, party_kind unknown senza inferenze aggiuntive. I soggetti irrisolti restano leggibili nel payload e nelle osservazioni. Dieci nomi/alias proiettati solo per le otto identità confermate, con ledger tipizzato; alias dei source-only conservati nel payload senza games fittizi. Lingua degli alias non attestata resta NULL.

35 asserzioni relazionali: 33 note dichiarative del CAT mantenute come source_statement, senza dedurne matching o nuove identità, e due asserzioni tipizzate Libre→record Abande (variant_of e base_rules_information_required). Dipendenza informativa required solo per la seconda; possesso/acquisto unknown. Nove decisioni identità (otto confirmed create_new, un candidate match); 18 proiezioni ledger (otto identity, dieci name). Zero arco canonico Libre→993, zero nuove implementazioni/prodotti/acquisizioni, mapping comune vuoto.

## Prove e garanzie

COPY_VERIFICHE.json registra prove eseguite su copie da SQLite backup API: schema 013 esatto, campione/hash CAT, payload/pointer provenienza, 9/3, classificazioni e date, otto identità, source-only e candidato, istanze/soluzioni, NULL, nomi/crediti irrisolti; preservazione di ogni riga preesistente e schema; nessun inserimento in legacy non autorizzato. Replay confronta inventario completo prima/dopo e restituisce zero scritture. URL corrente mutato o fonte parziale provocano rifiuto, mai INSERT OR REPLACE/IGNORE. Le copie e i backup sono esclusi da Git in outputs.

Chiavi locali per candidato, menzione e istanza assegnate in ordine CAT documentato; URL non chiave della menzione, date non chiave globale. Dopo prima importazione la verifica precede ogni replay: nessuna aggiunta duplicata nelle join legacy con NULL. Un cambiamento del CAT richiede nuova revisione, non upsert implicito. Errore al sesto record produce rollback dell'intero lotto sulla copia. Primo difetto osservato (record_observation_id mancante nelle relazioni) corretto prima di qualsiasi operativo; test rieseguiti.

Nessuna rete o CUA: browser non richiesto per importare evidenze già censite. Ripristino sandbox verificato limitatamente al lavoro locale; InitializeDefaultDrives è ancora segnalato, quindi non attestiamo salute universale dell'ambiente. Nessuna skill specialistica pertinente a questo DAT offline; inventario consultato, efficacia non applicabile.

## Ambiguità residue

Abande 993 resta candidato senza confronto versioni; nessun credito/categoria/risorsa proiettati sul game Kanare. Le tre regole non dimostrate restano tali, non paid/rejected. Esaustività classificazioni dell'intero sito non attestata; anni/crediti sono dichiarazioni della fonte, non verifiche indipendenti. Menzioni PDF senza destinazione e soluzioni autenticate restano non verificate. Persone/editori e crediti non sono automaticamente riconciliati o promossi al canonico. APP invariata: non promettiamo visualizzazione delle nuove osservazioni B-v1 né delle schede source-only nella UI attuale.

## Backup e ripristino operativo proposto

Solo dopo autorizzazione finale: fermare scrittori, rileggere manifest/schema e stato operativo; snapshot consistente con SQLite backup API (include WAL) in outputs/pergioco-import-backups con timestamp unico. Verificare SHA-256, integrità/FK, inventario completo; restaurare su seconda copia e confrontare prima della transazione. Il runner prende BEGIN EXCLUSIVE, ricontrolla inventario contro backup e rifiuta mutazioni concorrenti. Foreign keys ON; una transazione per tutto il lotto, rollback su ogni errore; prove complete prima del commit.

Dopo commit: verificare in sola lettura i conteggi/evidenze e integrità, registrare report/ID/backup. L'app resta in sola lettura; l'eventuale verifica di consultazione non implementa nuove funzioni. Nessun ripristino automatico: se necessario, preservare DB fallito e sidecar, fermare scrittori, verificare assenza di incrementi successivi, ottenere autorizzazione specifica e ripristinare snapshot verificato. Nessuna down-migration o modifica library.

## Decisione richiesta

Autorizzare l'importazione nell'operativo del solo lotto sopra descritto, con backup/restore provati e piano identità TSK-0076 invariato. Questa preparazione non contiene tale autorizzazione. TSK-0078 resta in_verifica finché arriva la risposta; nessun commit/push automatico. Dopo importazione verificata, sviluppo APP è un task distinto.
