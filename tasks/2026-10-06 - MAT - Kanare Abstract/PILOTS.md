# Collaudo Kanare

## Pilota 1 — v1 → v2, 2026-10-06

Pentwall (ID 959) e ViceVeresi (ID 957), scelti per PnP con plancia nel PDF e gioco con componenti comuni; entrambi riusano gli originali ACQ TSK-0023.

Pagine ufficiali /en/pages/pentwall e /en/pages/viceversi consultate. Hash locali corrispondenti al manifest ACQ. Pentwall: PDF 2 pagine, foglio stampabile p.1 verificato visivamente; preparazione p.2 richiede un foglio e penne di due colori, ammette un colore distinguendo tratteggio/riempimento. Campo 10×10 e 12 forme di riferimento, senza dodici pezzi fisici. ViceVersi: PDF 1 pagina, SET UP: 64 dischi reversibili e plancia quadrata 8×8; pagina ufficiale ammette componenti Othello/Reversi. Designer: Kanare Kato, distinto dal marchio Kanare_Abstract. Nessuna confezione dichiarata per questi giochi solo-regole/PnP.

Anomalie: query iniziale contava 65 includendo un legame rejected Ripples BGG; corretta prima del pilota, baseline 64. Estrattore Pentwall p.1 produceva quasi solo marchio; rendering necessario per verificare il componente. Dipendenza bs4 assente: sostituita con HTMLParser standard, estrazione riuscita sulle due pagine. Validatore skill standard non eseguibile per PyYAML assente; non installato.

Revisione v2 circoscritta: denominatore senza rejected, controllo visuale PDF a scarso testo, distinzione sagome stampate/pezzi fisici e grafie. Riesame Pentwall p.1/p.2 e ViceVersi SET UP riuscito; nessuna quantità ricavata dalla confezione o da somiglianze. Efficacia skill-creator/pdf/kanare-material-census: primo pilota riuscito, limite tecnico validatore e consultazione remota ancora da provare; evidenze locali in outputs/kanare-mat-2026-10-06, escluse da Git. Non generalizzare a tutti i giochi l'assenza di confezione o l'uso di componenti comuni.

## Pilota 2 — v2 → v3, 2026-10-06

Cinque ulteriori giochi: Chess Territorial (terzo PDF locale/set classico), Abande (raccolta Stacking Trilogy), LAG (più lingue/versioni URL), Bloody Queen (variante con provenienza aggregata), Tori Shogi (pezzi speciali/set condiviso). Lettura PDF remota da verificare prima del restante perimetro.

Risultati: Chess Territorial, COMPONENT p.1, set normale di scacchi, versione dichiarata 1.0; hash locale confermato. Abande, Trilogy EN p.1, plancia esagonale 37 intersezioni e 18 dischi per colore; confezione Stacking Trilogy include 40 dischi e plancia bifacciale 200×200 mm. LAG EN p.1: esagono di lato 5 celle, 11 pedoni e un cubo per colore, contatore laterale; confezione 22 pedoni/2 cubi coerente, autore Takuro Kawasaki, regolamento con Kanare Kato, artwork Kanare Kato. ES/JA solo metadati. Bloody Queen è nominata a p.2 del QueensGuard EN, collegato puntualmente dall'indice; stessi componenti base p.1 (esagono lato 6, 7 pezzi per colore con regina distinta), variante di Kanare Kato; attribuzione aggregata chiarita nel manifest con prova puntuale. Tori Shogi p.1–3: plancia 7×7, 32 pezzi tradizionali (16 rondini, 4 gru, 4 fagiani, 4 quaglie, 2 falchi, 2 peng); espansioni civetta/averla distinte; confezione 39 pezzi, senza equipararla al requisito tradizionale.

Tutti i documenti del pilota letti (Trilogy 6 pp., LAG 2 pp., QueensGuard 2 pp., ToriShogi 3 pp.; Chess 3 pp. locale). Consultazione remota in memoria riuscita. Nessun PDF nuovo salvato. Riepiloghi originali distinti dai testi locali; ruoli e riferimenti per pagina conservati.

Revisione v3: deduplicazione letture condivise con attribuzione per sezione, confezione distinta dai requisiti, confronto URL versionati senza assumere revisione, prova puntuale per varianti. Riesame Abande p.1 vs confezione 40, Bloody Queen p.1/2 e ToriShogi p.1/3 riuscito. Il secondo URL LAG storico resta da confrontare nel lotto successivo, senza dichiarare identità byte. Efficacia: skill Kanare e PDF gestiscono le cinque casistiche; nessun blocco di fonte, differenze di confezione non sono errori. Limiti: altre lingue non lette, validatore standard privo di PyYAML; nessuna generalizzazione dell'allocazione pezzi a tutti i prodotti. Da questo punto revisione soltanto per novità procedurali dimostrate.

### Riesame nel restante perimetro

I due URL LAG EN consultati restituiscono lo stesso SHA-256 `b08136331702bbf7e50df9c0450339f77356c5cdab40b74616e5daa4c2a4c64a`: due riferimenti, una identità binaria osservata il 2026-10-06. Iago_EN e Iago_S_EN sono invece binari diversi con requisiti concordi. Stacking Morris, Custodial Pah-Tum e Tori Shogi＋ riconciliate puntualmente come Bloody Queen ma solo dopo lettura delle rispettive sezioni nominate. Nuove divergenze Candy Chain/Dryad/Residuel gestite con v3, senza revisione automatica. Rendering di pagine integrali per consultazione (Pentwall, Candy Chain, Squish, Unlace, Mabi, Collapse, Make Muster, Trike, heXentafl), senza ritaglio/catalogazione IMG. Verifiche finali e tre hash originali in VERIFICATION.json.
