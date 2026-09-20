# Catalogo giochi multifonte e Kanare Abstract

## Stato

Concluso come task di esplorazione e formalizzazione. Nessuna migrazione del database, modifica dell'app o acquisizione di materiali è inclusa.

## Tipo di attività

Evoluzione architetturale non-BGG. Non appartiene ai cinque workflow BGG e non ne combina unità di lavoro.

## Scopo

Esplorare Kanare_Abstract come prima fonte aggiuntiva e definire, mediante intervista, la direzione del progetto verso un catalogo personale multifonte di giochi. Registrare inoltre due idee trasversali future senza progettarle o implementarle nel task corrente.

## Input

- sito pubblico Kanare_Abstract, osservato il 2026-09-20;
- schema e documentazione correnti del progetto;
- decisioni espresse dall'utente durante l'intervista;
- migrazioni PWS 1.3→1.4 e 1.4→1.5.

## Deliverable

- perimetro concettuale del futuro censimento Kanare_Abstract;
- principi del modello multifonte e della vista generale Giochi;
- requisiti preliminari di scraping, provenienza, media, regolamenti, materiali e classificazione;
- registrazione delle idee future Simulatore di giochi e Prototipazione 3D;
- allineamento deliberato del progetto a PWS 1.5.0.

## Decisioni principali

- Il progetto evolve da raccolta esclusivamente PnP/BGG a catalogo personale multifonte; il PnP resta una forma di fruizione.
- Il gioco è l'entità canonica. Record di fonte, prodotti, edizioni, risorse e implementazioni sono collegati senza duplicarne l'identità.
- L'app avrà una vista trasversale Giochi e menu specializzati per ciascuna fonte.
- Dati comuni e specifici della fonte restano separati, attribuiti ed etichettati.
- Lo scraping Kanare sarà completo rispetto ai giochi osservabili, prudente, aggiornabile manualmente e non distruttivo.
- Download di regolamenti e gallerie secondarie richiederanno selezione manuale; una sola immagine rappresentativa sarà acquisita durante il censimento.
- L'inventario dei materiali sarà completo e basato su evidenze con provenienza e grado di affidabilità.
- La classificazione interna sarà multidimensionale, con gerarchie locali e relazioni trasversali.
- Simulatore e prototipazione 3D saranno affrontati esclusivamente in task futuri dedicati.

Il dettaglio consolidato delle decisioni è promosso in `PROJECT.md`, sezione **Evoluzione multifonte deliberata**.

## Ricognizione Kanare_Abstract

Il sito è un negozio Shopify bilingue e una fonte editoriale dedicata ai giochi astratti. Espone giochi, prodotti o edizioni, designer, regolamenti, immagini, opere storiche ancora accessibili, giochi per componenti comuni e presenze su piattaforme digitali. Un prodotto può contenere più giochi e lo stesso gioco può avere più forme di accesso; per questo prodotto e gioco non sono sinonimi.

Fonti principali consultate:

- `https://kanare-abstract.com/`
- `https://kanare-abstract.com/en/pages/about_us`
- `https://kanare-abstract.com/en/pages/games_by_kanare`
- `https://kanare-abstract.com/en/pages/designers`
- `https://kanare-abstract.com/en/pages/online_play`
- `https://kanare-abstract.com/en/pages/abstract-games`
- `https://kanare-abstract.com/en/pages/saiju`

## Adozione PWS 1.5.0

L'utente ha deliberato il 2026-09-20 l'adozione delle migrazioni 1.4.0 e 1.5.0. Sono stati integrati nel progetto:

- controllo dinamico del titolo del task e mantenimento dei temi precedenti ancora rilevanti;
- confronto iniziale fra `aligned_version` e la versione canonica;
- aggiornamento di `aligned_version` e `last_alignment_at` senza modificare `initialized_with`.

Il titolo del task corrente è stato aggiornato due volte durante l'esplorazione fino alla forma cumulativa `2026-09-20 - Catalogo giochi multifonte e Kanare Abstract`. Non è stato eseguito un riesame massivo dei task storici: le modifiche locali già presenti e l'assenza di una necessità immediata rendono più sicuro svolgerlo, se desiderato, in un incremento separato.

## Verifiche

- confronto iniziale fra PWS locale 1.3.0 e versione canonica 1.5.0;
- lettura completa delle migrazioni 1.3→1.4 e 1.4→1.5;
- ricognizione in sola lettura dello schema corrente e delle pagine Kanare principali;
- nessuna modifica al database operativo, allo schema, all'app o ai dati BGG;
- nessun download di regolamenti o immagini.

## Risultato

Il brainstorming è stato consolidato come direzione autorevole ma non ancora implementata. I prossimi incrementi dovranno restare separati: progettazione/migrazione del modello multifonte, implementazione del censimento Kanare e adeguamento dell'app; simulatore e prototipazione 3D saranno task autonomi successivi.
