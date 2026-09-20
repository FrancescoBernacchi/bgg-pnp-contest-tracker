# Censimento globale contest PnP BGG

## Stato

Completato il 18 settembre 2026. Perimetro confermato, estrazione completa degli indici BGG 2008–2026, importazione dei 305 contest e finalizzazione degli stati conclusa.

## Scopo e confini

Individuare su BoardGameGeek le edizioni dei contest di game design Print and Play di tutti gli anni e costruire un elenco verificabile limitato ai contest stessi.

Per ogni edizione registrare:

- nome pubblicato;
- anno o etichetta temporale dichiarata;
- stato di completamento originale, quando esplicito;
- stato normalizzato prudenziale;
- URL della fonte BGG e data di verifica.

Non analizzare, enumerare o acquisire entry, WIP, classifiche, risorse o materiali di gioco. Le entry già presenti nel progetto non vengono modificate da questo task.

## Input

- Forum BGG `Design Contests` e relativi indici o Hub.
- Thread, GeekList e pagine BGG ufficiali utili a provare identità e stato del contest.
- Serie ed edizioni già censite nel progetto come punti di partenza, senza presumere che esauriscano il perimetro storico.
- Skill locale `.agents/skills/bgg-contest-navigation/` e relativo playbook.

## Strategia

1. Includere contest annuali e challenge brevi di design ospitati su BGG; escludere challenge di gioco e concorsi esterni soltanto annunciati su BGG.
2. Costruire un indice delle serie e delle edizioni candidate usando fonti BGG autorevoli.
3. Verificare ogni edizione senza aprire roster o pagine delle singole entry.
4. Registrare separatamente evidenza originale, normalizzazione e casi incerti o esclusi.
5. Verificare copertura, duplicati, continuità apparente delle serie e lacune; una ricerca negativa non prova l'inesistenza.
6. Produrre un incremento riproducibile per il catalogo e applicarlo al database solo dopo verifica su copia.

## Deliverable

- Registro versionabile delle fonti e della copertura storica, con inclusioni, esclusioni e lacune motivate.
- Importazione riproducibile delle sole entità `contest_series`, `contests`, `contest_sources` e, se necessarie per lo stato, osservazioni di contest; nessun dato di entry.
- Elenco consultabile dei contest con nome, anno e stato di completamento.
- Aggiornamento del cruscotto di progetto se cambiano copertura o conteggi.

## Criteri di successo

- Ogni contest incluso ha almeno una fonte BGG verificata e una data di osservazione.
- Stato originale e stato normalizzato restano distinti; l'assenza di prova resta `unknown`.
- Nessuna entry, WIP, classifica o risorsa viene analizzata o aggiunta.
- Duplicati e rinomini sono riconciliati senza perdere i nomi storici osservati.
- Copertura e limiti della scansione sono documentati per anno e per serie.
- Gli incrementi SQL superano integrità SQLite e controllo delle chiavi esterne su una copia prima dell'applicazione.

## Stato iniziale del repository

Il branch è `main` e coincide con il riferimento locale `origin/main`. All'apertura erano già presenti modifiche non committate relative all'approfondimento delle risorse 2025; appartengono a un lavoro precedente e devono essere preservate e tenute separate da questo censimento.

## Decisioni e punti aperti

- Decisione dell'utente: il task riguarda tutti gli anni e si limita all'elenco dei contest, al nome e allo stato di completamento; le entry sono fuori scope.
- Chiarimento dell'utente: il deliverable deve contenere una riga nominativa per ogni singolo contest, con almeno anno, titolo e stato. I soli conteggi sono controlli intermedi e non soddisfano il task.
- Decisione dell'utente del 15 settembre 2026: includere anche le challenge brevi di design ospitate su BGG; escludere le challenge di gioco e i concorsi esterni soltanto annunciati nel forum BGG.

## Verifiche e risultati

### Prima ricognizione degli indici — 15 settembre 2026

Il thread BGG `START HERE` indica come fonti principali due GeekList comunitarie consecutive. La lista storica 2008–2024 contiene 166 record numerati senza lacune; la continuazione contiene 26 elementi, uno dei quali è soltanto il separatore fra contest chiusi e correnti. Sono quindi emersi 191 record iniziali di contest o meta-contest prima della deduplicazione con il database e dell'espansione delle challenge aggregate.

La lista 2008–2024 aggrega in alcuni anni le challenge da 24 ore sotto un solo meta-thread annuale. La lista nuova, invece, espone separatamente le sei challenge bimestrali del 2025. Poiché l'utente ha incluso le challenge brevi, i meta-thread storici devono essere espansi prima di poter dichiarare completo il numero dei contest.

La continuazione non copre ancora tutti i contest 2026 visibili nel forum al 15 settembre 2026. Verrà quindi usata come indice, non come unica fonte di completezza. Metodo, conteggi, fonti e limiti sono registrati in `sources/BGG-PNP-CONTEST-GLOBAL-COVERAGE.md`.

Nessun roster, WIP, risultato di singola entry o materiale è stato aperto o acquisito.

### Espansione delle challenge brevi e verifica 2026 — 15 settembre 2026

Gli undici meta-record storici delle challenge da 24 ore sono stati espansi in 127 challenge mensili o bimestrali osservate fra il 2012 e il 2026. Di queste, 126 risultano concluse e una è attiva: `September / October 2026 Bi-Monthly 24 Hour Design Challenge - NINE`. Il ciclo novembre–dicembre 2026 è soltanto previsto nel meta-thread e non è ancora conteggiato come contest pubblicato.

Il forum Design Contests conferma le undici edizioni 2026 già note al progetto e mostra cinque contest non ancora presenti nella GeekList corrente: Solitaire, 54-Card, Traditional Deck, Turkish PnP e Bad Comet Cozy. Side event, thread di discussione, idee di contest e concorsi esterni soltanto annunciati sono stati esclusi.

Il bacino preliminare comprende 305 contest o challenge prima della deduplicazione finale e della verifica delle fonti dirette mancanti; il conteggio iniziale di 304 è stato corretto includendo Solomode 2026. Il dettaglio delle challenge è in `sources/BGG-PNP-24H-CHALLENGES.md`.

### Estrazione nominativa degli indici — 16 settembre 2026

La GeekList 2008–2024 è stata estratta elemento per elemento nel browser renderizzato: osservati tutti i 166 indici, senza lacune, con titolo, nome canonico quando presente, anno, URL, scadenza e segnali di stato. La continuazione 2025–2026 è stata estratta integralmente in 26 elementi, compreso il separatore non-contest `Caution, Under Construction!`.

BGG materializza progressivamente gli elementi durante lo scorrimento. Il DOM iniziale delle sette pagine restituiva soltanto 21 record; lo scorrimento sequenziale e il controllo degli indici hanno prodotto 166 record su 166. Il pattern è stato promosso nel playbook della skill. Il consolidamento nel registro nominativo, la sostituzione dei meta-record con le singole challenge e la deduplicazione contro database e forum sono stati completati con l'importazione descritta di seguito; resta la verifica puntuale delle fonti dirette e degli stati prudenziali.

### Importazione della baseline globale — 18 settembre 2026

Generato `catalog/global-contest-census.sql` dal manifest nominativo e dalle 127 challenge individualizzate. La verifica su copia ha portato il database da 22 a 305 contest, con 19 annualità dal 2008 al 2026, `PRAGMA foreign_key_check` vuoto e `integrity_check=ok`. Dopo la verifica lo stesso incremento è stato applicato al database operativo; nessuna entry è stata aggiunta. Gli stati storici sostenuti dall'indice ritirato o dalla sezione chiusa sono `complete`; cancellazioni e abbandoni noti restano distinti; gli stati 2026 non provati restano prudenzialmente `unknown`.

### Finalizzazione della baseline — 18 settembre 2026

Il controllo finale ha esaminato soltanto fonti contest e calendari BGG, senza roster o pagine di entry. `CULTURE` ha risultati pubblicati; `CLASSIC`, `STICK` e `DRAW` hanno concluso le finestre di voto entro il 18 settembre e sono stati normalizzati `complete`. `League of Designers Workshop and Contest` (2018) resta `unknown`: la fonte storica ne prova l'esistenza ma non consente di distinguere con affidabilità conclusione e cancellazione. Il forum 2026 ha inoltre confermato che il ciclo novembre–dicembre 24 Hour è solo previsto e che BoardSprints, Deck Hand, Tabletop Creator e altri annunci esterni non sono contest PnP BGG autonomi inclusi nel perimetro.

L'incremento riproducibile è `catalog/global-contest-census-finalization.sql`; il verifier su copia è `catalog/verify_global_contest_census_finalization.py`. Il database operativo contiene ora 305 contest, 19 anni e cinque controlli `global_census_finalization`, con integrità verificata.

## Esito e seguito

Task completato il 18 settembre 2026. Resta soltanto il monitoraggio periodico dei contest futuri e l'eventuale revisione dell'unica anomalia storica `unknown`; questi non riaprono il censimento globale.
