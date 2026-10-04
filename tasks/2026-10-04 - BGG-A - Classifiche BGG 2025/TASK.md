# Classifiche BGG 2025

## Identità e stato

- ID: TSK-0045.
- Apertura: 2026-10-04.
- Categoria: BGG-A, estensione annuale classifiche deliberata dall'utente il 2026-10-04.
- Modalità: continuativo; cadenza: su_richiesta, con riprese periodiche nella stessa chat.
- Stato: in_corso. Nessuna automazione o frequenza calendario definita.
- Chat: 01a10694-e681-7d93-9cbb-53cdbe34464f.
- Predecessore: TSK-0005, raccolta originaria roster e risultati 2025. TSK-0009 riguarda materiali e resta distinto.

## Decisione e contratto

Richiesta: «dedichiamo questo task alle classifiche del 2025 e vediamo a che % arriviamo rispetto a dove siamo ora. Poi torneremo periodicamente su questo task fino al completamento del 2025».

Estensione esplicita del censimento annuale BGG al solo asse risultati e votazioni: raccolta delle classifiche di gioco, categorie, posizione, punteggio e voti pubblicati, distinguendo ufficialità, dati originali e normalizzati, fonti e date. Incrementi per contest all'interno del contenitore annuale. Non è monitoraggio multi-contest né analisi materiali. Esclusi WIP, risorse, host esterni, file di gioco e download. Conservare osservazioni storiche, ex aequo, titoli e alias; non attribuire posizione zero o inventare risultati alle entry prive di evidenza. Premi esclusivamente personali non entrano in rankings.

Perimetro iniziale: 11 contest con 464 entry già censite, separati in 9 PnP principali e 2 adiacenti. Le 6 challenge 24h del 2025 sono registrate ma prive di roster: documentare la dipendenza dal censimento annuale dedicato, senza aggiungere roster in questo task. Il denominatore iniziale è fissato per confrontare gli incrementi; eventuali ampliamenti futuri si riportano separatamente.

## Input e deliverable

Database operativo, catalog/2025-*-entries-results.sql, fonti BGG autorevoli dei singoli contest, skill locale bgg-contest-navigation e playbook. BASELINE.json conserva query, conteggi e fonti iniziali per contest.

Deliverable: registro delle verifiche per contest/categoria/fonte, importazioni riproducibili dei nuovi risultati, confronti prima/dopo, esiti espliciti per dati assenti o non osservabili, cruscotto rigenerato quando cambiano i dati. Ogni importazione va verificata su copia prima dell'operativo con backup, integrità, chiavi esterne e confronto dei conteggi; nessun duplicato tecnico e nessuna perdita di osservazioni.

## Criteri di completamento

Tutti i contest nel perimetro hanno fonti risultati esaminate integralmente, categorie e risultati pubblicati riconciliati con i dati locali, anomalie residue risolte o limitazioni documentate. Completamento della verifica distinto dalla percentuale di entry presenti in rankings: il 100% della barra blu non è requisito quando la fonte non classifica tutte le entry. Le challenge senza roster rimangono una dipendenza esplicita per la copertura dell'intera annualità.

## Incremento 1 — 2026-10-04: apertura e baseline

PWS locale e canonico entrambi 1.5.0. Preflight sandbox riuscito; main con modifiche documentali preesistenti del task governance, preservate. TSK-0005 ancora in_corso nel registro per storia da riconciliare; nessuna riapertura del suo perimetro misto. Nuovo contenitore autonomo autorizzato.

Baseline verificata in SQLite: PnP principali 207/384 = 53,91%; adiacenti 40/80 = 50,00%; totale 247/464 = 53,23%. Variazione in questo incremento: 0 entry, 0 punti percentuali. Nessun risultato importato.

Priorità iniziale: 9-Card Nanogame (19/94, 75 entry senza osservazioni), poi Solitaire (48/74, 26 senza), Traditional Deck (21/42, 21 senza) e Two-Player (20/40, 20 senza). Si tratta di priorità di ricerca, non di risultati sicuramente recuperabili. Wargame è già 19/19, ma completezza delle categorie da verificare separatamente.

Tentativo tecnico fonte 9-Card: web restituisce HTTP 403; browser in-app mostra verifica di sicurezza Cloudflare. Non è assenza di risultati. Dopo il caricamento, il browser supera autonomamente la verifica e rende osservabile il post ufficiale dei risultati. Nessuna cadenza di monitoraggio aggiornata.

## Prossimo incremento

Accedere alla fonte autorevole 9-Card 2025 e verificare se esistano tabelle complete oltre ai premiati già importati; confrontare categorie e giochi con il catalogo originario. Registrare esito e nuova percentuale, anche se invariata. Riprendere questa stessa chat su richiesta; il contenitore resta aperto.

### Prima verifica fonte 9-Card

Il post ufficiale dell’organizzatore Michael Murphy nella pagina 1 del thread 3436343 è stato letto il 2026-10-04: 11 categorie associate ai giochi, più Best Playtester (persone). SQLite contiene già 56 osservazioni nelle 11 categorie: nove blocchi da 5, Best New Designer con 6 associazioni gioco (Scott indica due giochi), Best Overall con 8 risultati incluso pari merito al secondo posto, Jury Prize con 2. Nessuna categoria di gioco mancante nel post dei vincitori osservato; 19 giochi distinti già presenti. Non è stata ancora verificata l’esistenza di un riepilogo completo dei voti nei post successivi: contest resta parzialmente verificato. Nessuna importazione, percentuali invariate.

## Incremento 2 — 2026-10-04: verifica completa fonti ufficiali

Supera lo stato parziale e il prossimo passo dell’incremento 1. Verificati ora tutti gli 11 contest: categorie/liste ufficiali e annunci finali, inclusi Jury Prize e menzioni. Nessun nuovo risultato recuperato; 797 osservazioni e 247/464 entry invariati. Registro CHECKS_2026-10-04.json e rapporto VERIFICA_2026-10-04.md con fonti, pagine, conteggi ed esclusioni. Confronto manuale delle liste pubblicate con raccolta locale, non ricerca di tabelle private o dei WIP. Le difficoltà di caricamento di Solitaire pagina 30 risolte con successiva navigazione. Nessuna importazione né modifica alle date storiche.

Incremento concluso; il contenitore resta in_corso per le riprese richieste dall’utente. La verifica 11/11 non equivale al 100% delle entry nella barra: ritiri e top-N documentati; sei challenge senza roster restano escluse. Prossimo passo utile: nuovi annunci/rettifiche/tabelle autorevoli o completamento del censimento annuale delle challenge, senza ricontrolli ordinari dei contest conclusi. Nessuna automazione.

## Salvataggio Git — 2026-10-04

Commit e push autorizzati dall’utente. Incremento 2025 isolato nei documenti condivisi; modifiche dei task governance e censimento 2024 preservate nella working tree. Versionati solo documenti, baseline e osservazioni testuali; database e materiali esclusi. Esito e identificativo del commit verificabili nella cronologia Git e nella risposta di chiusura.
