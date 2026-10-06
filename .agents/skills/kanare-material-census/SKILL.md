---
name: kanare-material-census
description: Censisce materiali e requisiti dei giochi Kanare già catalogati da pagine e regolamenti ufficiali nel perimetro MAT autorizzato, senza acquisizioni o piattaforme online.
---

# Censimento materiali Kanare

Leggere il contratto MAT corrente, PROJECT.md (decisioni Kanare), PUBLICATION_POLICY.md e i task CAT/VER/ACQ collegati. Questa fonte non-BGG non eredita il limite del primo post. La skill non autorizza nuove fonti, lingue, acquisizioni o modifiche architetturali.

## Procedura

1. Esportare in sola lettura giochi, record, prodotti, legami risorse e crediti. Mantenere ID stabili e matching candidati separati. Il prodotto/set non è il gioco; non attribuire a ogni gioco tutti i pezzi della confezione.
2. Consultare pagine ufficiali nominative e prodotti associati; censire URL di tutte le lingue, ma leggere solo regolamenti ufficiali IT/EN autorizzati. Riutilizzare PDF locali con hash verificato. Consultazione remota senza salvataggio nella library; se richiede login/acquisizione persistente esclusa, registrare blocco e continuare.
3. Ricostruire requisiti da sezioni componenti/setup e diagrammi pertinenti: tipo, quantità, dimensioni/caratteristiche dichiarate. Separare confezione, necessità di gioco, sostituzioni esplicitamente ammesse, componenti comuni e specifici/stampabili. Non dedurre misure da immagini o equivalenze dalla sola somiglianza.
4. Ogni osservazione conserva URL diretto, data, pagina/sezione, crediti dichiarati e ruolo; dichiarazione riassunta, normalizzazione e inferenza distinta. Conservare conflitti fra pagina, confezione e regolamento. Versione solo se dichiarata: il parametro URL non è una revisione del regolamento.
5. Varianti e materiali condivisi richiedono attribuzione ufficiale puntuale; legami aggregati restano limiti finché non chiariti. Non aprire piattaforme online né seguire matching candidati per attribuire materiali.
6. Contabilizzare risorse censite e risorse effettivamente lette separatamente; ricerca conclusa non significa tutte le informazioni dichiarate. Usare completo/parziale/bloccato per analisi e non_osservabile/assenza_esplicita/non_dichiarato per singole informazioni.

## Collaudo e conservazione

Per la prima adozione TSK-0070: v1, pilota 1 (1–2), verifica/revisione/riesame, pilota 2 (5 ulteriori), verifica/revisione/riesame, restante perimetro. Riutilizzare risultati dei piloti. Dopo le due revisioni intervenire soltanto per una novità non gestita dimostrata; differenze nei dati non sono difetti procedurali.

Riepiloghi originali/metadati nei manifest versionabili; testi integrali, screenshot e prove terze solo locali fuori Git. Verificare compatibilità del modello prima di importare; nessuna migrazione implicita. Registrare efficacia e revisioni nel task sorgente e collegare TSK-0048. Aggiornare inventario, registro e cruscotto.

## Maturità

2026-10-06 v3, secondo pilota Chess Territorial/Abande/LAG/Bloody Queen/Tori Shogi: PDF EN remoti letti in memoria senza salvare binari. Letture condivise deduplicate per URL completo; una raccolta ha sezioni/pagine distinte per gioco, da attribuire separatamente. Confezione Stacking Trilogy 40 dischi, Abande ne richiede 36: mantenere entrambi. LAG espone due URL EN con parametro diverso: confrontare contenuto prima di deduplicare, senza inventare revisione. Indice ufficiale collega Bloody Queen al PDF QueensGuard, la variante è nominata a p.2: evidenza puntuale risolve l'attribuzione di quel caso, non delle altre tre varianti. Tori Shogi distingue 32 pezzi tradizionali, espansioni facoltative e 39 pezzi nella confezione; non inferire che tutti servano simultaneamente.

Restano verificati dal primo pilota: escludere legami rejected dal denominatore (Ripples); controllare visivamente pagine PDF a scarso testo (Pentwall p.1 è plancia stampabile); distinguere sagome di riferimento da pezzi fisici e grafia canonica ViceVeresi dalla fonte ViceVersi. Strumenti di lettura in catalog/inspect_kanare_materials.py: HTMLParser standard e pdfplumber; prove integrali solo in outputs escluso da Git. Hash di lettura remoto è impronta di consultazione, non file acquisito né licenza.
