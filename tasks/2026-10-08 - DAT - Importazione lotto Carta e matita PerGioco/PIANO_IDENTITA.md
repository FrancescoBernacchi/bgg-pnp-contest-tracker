# TSK-0081 — Piano da confermare

Stato corrente: piano confermato esplicitamente dopo collaudo (DECISIONE.md); applicato 2026-10-08, accettazione e chiusura 2026-10-10 in OPERATIONAL_VERIFICHE.json. Il titolo e i riferimenti alla proposta nel testo seguente conservano la preparazione originale.

Preparazione: 2026-10-08. Questo piano è una proposta collaudata su copie, non una decisione operativa. Fonte delle dichiarazioni: CAT TSK-0080, osservazione 2026-10-08; [indice PerGioco](https://www.pergioco.net/giochi-con-carta-e-matita.html). Crediti, ruoli e lacune completi nel manifest CAT; anni e attribuzioni sono dichiarazioni editoriali, senza verifica storica indipendente.

## Nove record fonte, sette identità locali proposte

| Candidata / fonte diretta | Esito CAT | Proposta | Credito del sistema e qualificazioni |
|---|---|---|---|
| PGCM-001 [Battaglia Navale con Carta e Matita](https://www.pergioco.net/a/battaglia-navale-carta-e-matita.html) | requirement_not_demonstrated | Solo record fonte | Designer non dichiarato; configurazione completa non dimostrata, costo regole complete ignoto. Nessun gioco ammesso o equivalenza con edizione commerciale. |
| PGCM-002 [Engel](https://www.pergioco.net/a/engel.html) | admitted | Nuovo game locale | D. Engel, 1975; iniziale irrisolta. Berloquin autore di volume, non designer del sistema. |
| PGCM-003 [Labirinto](https://www.pergioco.net/a/labirinto.html) | admitted | Un nuovo game locale | Designer non dichiarato. Un sistema logico; tre istanze separate, non tre giochi. |
| PGCM-004 [Numerino](https://www.pergioco.net/a/numerino.html) | admitted | Nuovo game locale | Tradizionale; designer individuale non dichiarato. Alias Bulls and Cows, Numerello, Strike & Ball, Ball & Strike. Crediti Mastermind contestuali, non del base. |
| PGCM-005 [Piattola](https://www.pergioco.net/a/piattola.html) | admitted | Un nuovo game locale | Designer del base non dichiarato; Morpion alias dichiarato con limite di equivalenza globale. Sette varianti come asserzioni, nessun altro game/record. |
| PGCM-006 [Punti e linee](https://www.pergioco.net/e/punti-e-linee.html) | requirement_not_demonstrated | Solo record fonte, tipo editorial_collection | Raccolta, designer unitario non dichiarato. Non fusa con Quadratini. Quattro rinvii fuori lotto restano testo/URL. |
| PGCM-007 [Quadratini](https://www.pergioco.net/a/quadratini.html) | admitted | Nuovo game locale | François Édouard Anatole Lucas, 1889. Dieci alias dichiarati; Punti e Linee non identifica la raccolta, Boxes/Squares non fondono i giochi ispirati. |
| PGCM-008 [Sqez](https://www.pergioco.net/a/sqez.html) | admitted | Nuovo game locale | Dan Laycock, 1973. |
| PGCM-009 [Stripes!](https://www.pergioco.net/a/stripes.html) | admitted | Nuovo game locale | Marino Carpignano, 2016. Punto esclamativo preservato. |

Nessuna identità confermata nell'operativo durante questa preparazione. I sette collegamenti confirmed presenti sulle copie simulano il piano dopo eventuale conferma, con riferimento di autorizzazione COPY. Non attestano sette giochi sconosciuti altrove: sono identità locali conservative, riesaminabili tramite un futuro VER autonomo. Alternative reversibili collaudate: tutti e nove source-only, senza games/proiezioni; anche tale alternativa conserva esiti CAT 7/2.

## Matching locale e collisioni

MATCHING_LOCALE.json registra il confronto corrente in SQLite RO su games.canonical_title e game_names.name: titoli scheda/indice e alias, confronto casefold e NFKC con punteggiatura/spazi normalizzati; URL richiesto/finale esatti in source_records. Zero candidati esatti/normalizzati e zero collisioni URL. Il risultato non esclude equivalenti semantici o alias non registrati. I titoli a tema labirinto/battaglia nel catalogo non danno prova di corrispondenza del sistema: non sono promossi a matching per somiglianza tematica. Nessuna ricerca esterna o modifica delle prove legacy.

Omonimia interna nota: Punti e linee raccolta e alias Punti e Linee di Quadratini rimangono owner separati. Le varianti Piattola non partecipano al matching del base, non sono suoi alias canonici. Nessun candidato game_source_records nuovo proposto per questo lotto, nessuna fusione automatica. Se nuovi match o collisioni emergono al preflight operativo, l'importer rifiuta il lotto per riesame. ID numerici non riservati: si allocano in transazione, con prova di allocazione dopo inserimento concorrente preesistente su copia.

## Varianti, istanze e riferimenti rinviati

Piattola: Variante 1, Variante 2, Variante 3, Variante a tempo, Variante Simmetrica, Piattola Solitaria, Piattola Solitaria per Due. Sette source_relation_assertions con target_label e raw_value/pointer individuale; nessun to_record_id né arco canonico. Piattola Solitaria conserva Morpion Solitaire/Join Five nel proprio raw payload, non nei game_names del base. Variante Simmetrica conserva Marino Carpignano nel suo contesto; crediti dei volumi/traduzioni restano source_credit_observations contestuali. Le sette ammissioni delle varianti non sono state valutate separatamente. Eventuali identità autonome richiedono perimetro e decisione separati.

Labirinto: tre problem_instances con chiavi CAT già assegnate e tre osservazioni per Diagramma 1 (2021-02-01), Diagramma 2 (2021-02-08), Diagramma 3 (2023-12-29); tre appears_in verso la menzione diagrammi. Date raw, qualificazione pecora/lupo e usability NULL nel raw_value e payload. Nessuna solution_for: URL soluzione comune dichiarato, destinazione non verificata. La presenza del rinvio nello stesso blocco non prova associazione del contenuto soluzione a un'istanza. Schema utilizzabile non attestato, senza trasformare NULL in assenza. Beniamo Sidoti resta scritto come nel CAT.

Punti e linee: Gioco dei 9/16/12 punti e Stella a 7 punti restano quattro asserzioni collection_member con testo/URL; nessun record/game aggiuntivo, nessuna ammissione loro attribuita. Battaglia Navale: riferimento commerciale soltanto asserzione. Numerino e Quadratini: riferimenti adattamenti/giochi ispirati mantengono testo/URL e dipendenze unknown, non identità risolte.

Tutti i 69 crediti/lacune conservano ruolo, soggetto, URL e data propri; nessuna persona fittizia, people o credit_assertions nuovi. Nome ambiguo/iniziale e organizzazione non sono risolti per nome. Nessun credito trasferito automaticamente al canonico. Nomi originali e quindici alias dei sette giochi producono 22 game_names con ledger tipizzato; alias non datati/non linguistici mantengono lingua NULL. I crediti relativi ai libri, traduzioni, publisher e curatore del sito non diventano designer del base.

## Mapping e protocollo

Importer dedicato catalog/import_pergioco_carta_matita.py; utility canon/hash/put e protocollo backup/inventario riusati dopo verifica dal pilota e runner 013, senza modificare gli strumenti storici. Guardia del pilota fonte già presente e conteggi globali non riutilizzati. Schema esatto 013 obbligatorio; nessuna incompatibilità strutturale reale emersa. Campi non presenti nello schema (usability, qualificazioni, alias varianti) conservati nei payload/raw_value con pointer, senza colonne inventate o perdita: possibile APP futura deve usare tali prove.

| Input | Proiezione B-v1/013 |
|---|---|
| local_record_key / candidate_id / event_key | source_record_keys e snapshot; chiavi originali indipendenti da nome/URL/ID SQL |
| record CAT integrale | source_record_observations.payload_json e raw_value, SHA-256 canonico; raw_metadata cache identica |
| rules / outcome | source_admission_observations, policy TSK-0073 e valutazione originale |
| 18 appartenenze / percorsi | source_classification_observations, 63 segmenti contigui; mapping comune senza delta |
| requested_url / final_url | 18 source_record_url_observations; endpoint attestati, catena intermedia NULL |
| 11 menzioni / URL | source_resource_mentions e versioni; 11 destinazioni e link, nessun file scaricato |
| access_assessments e menzioni secondarie | 38 accessi contestuali; quattro ambiti sulla pagina principale, osservazione public_content delle due menzioni Labirinto secondarie; complete_rules NULL non paid |
| condizioni sito e FAQ | 2 osservazioni con URL/data propri, 76 link applicability uncertain; permesso unknown con dichiarazione originale preservata, nessuna licenza inferita |
| crediti / relazioni / varianti | 69 crediti, 13 rinvii più 7 varianti, nessun target risolto o relazione canonica |
| istanze CAT Labirinto | 3 identità/3 osservazioni/3 appears_in, 0 solution_for |
| piano dopo conferma | 7 games/7 decisioni/7 game_source_records, 29 ledger: 7 identità + 22 nomi |

L'intero manifest CAT resta input autorevole intatto, fissato per hash file e hash canonico; metadati globali, indice e limiti non proiettati restano nel manifest senza ricensimento o inferenza di copertura globale. Ognuno dei nove record è preservato campo per campo nel payload. Un input mutato richiede nuova revisione, non visita o upsert impliciti. Stesso evento congelato: replay zero delta, inclusi join legacy nullable; eventi futuri/rettifiche esclusi da questo importer.

Applicazione futura: dopo conferma esplicita del piano e importazione, snapshot fresco SQLite backup API e restore verificato; BEGIN EXCLUSIVE, nuova baseline/hash/schema/collisioni, ID allocati al momento, tutti i nove record in una transazione, verifica prima del commit e dopo in RO. Nessun INSERT OR REPLACE/IGNORE, Python -O o schema.sql operativo. Qualunque errore pre-commit rollback. Nessun restore automatico post-commit: stato fallito/sidecar conservati, scrittori fermi, verifica incrementi successivi e autorizzazione specifica prima di sostituire l'operativo.

## Decisione finale richiesta

Confermare sette nuove identità locali sopra proposte, due record source-only e trattamento conservativo di istanze/varianti/crediti, e autorizzare l'applicazione dei soli nove record nell'operativo con backup fresco e verifiche/replay. Non comprende APP, MAT/ACQ/IMG, nuovi censimenti, schema, automazioni, commit o push. Il consenso non è ancora acquisito; TSK-0081 resta in_verifica dopo il collaudo.
