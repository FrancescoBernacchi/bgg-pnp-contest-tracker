# PerGioco — perimetro adottato

Decisione del 2026-10-06, TSK-0073: l'utente autorizza il percorso passo passo dopo la preanalisi TSK-0072 e sceglie esplicitamente di includere subito i giochi logici. Fonte editoriale adottata per un pilota; non ancora importata nel database.

## Inclusione e unità di catalogazione

Giochi astratti e tradizionali, carta e matita, giochi logici e problemi solitari, con varianti identificabili. Il gioco/sistema di regole è l'identità catalogata. Singoli schemi, problemi numerati, diagrammi e soluzioni sono istanze o risorse associate, senza incrementare il conteggio dei giochi. Una variante con regole proprie resta distinguibile con relazione motivata al base.

Il requisito è il percorso completo di regole gratuitamente leggibile, anche HTML o base+variante. Per un problema logico servono vincoli e obiettivo sufficienti a comprenderlo: la soluzione non è requisito di gratuità delle regole e può avere accesso distinto. Disponibilità di uno schema utilizzabile e accesso alla soluzione si attestano separatamente. Presentazioni, video e PDF solo menzionati non attestano completezza.

## Accessi e provenienza

Decisione utente 2026-10-06: mantenere nel database e nell'app la classificazione originale PerGioco. Conservare etichette, gerarchia/sezione e appartenenze multiple osservate, collegate al record della fonte con URL/data. Le descrizioni del perimetro non sostituiscono le categorie native; categoria non osservata resta ignota. Eventuale mapping comune separato, senza sovrascrivere le categorie native o estenderle automaticamente al gioco condiviso. CAT raccoglie questi dati, DAT ne definisce la persistenza, APP li mostra e li rende navigabili con etichette originali. Requisito adottato, non ancora implementato.

Valutazione individuale: credito e ruolo oppure mancanza esplicita, URL e data, lingua, completezza, costo/accesso e condizioni. Costi di regole, componenti/prodotti e gioco online separati. Account/newsletter gratuiti sono condizioni ammissibili dichiarate, non prove di contenuto osservato; nessuna iscrizione automatica o aggiramento. Il primo pilota privilegia pagine pubbliche e registra limiti.

Conservare titolo sorgente, titolo normalizzato, URL storico/finale, rinomini e relazioni. Matching manuale documentato, senza fusioni per solo titolo o etichetta editoriale. Abande già Kanare è un caso di arricchimento candidato, non una nuova identità automatica.

## Confini del percorso

CAT pilota: 12 identità candidate, inventario metadati ed esiti individuali; eventuali esclusioni restano nel denominatore verificato. DAT e APP successivi separati. Nessuna importazione operativa, modifica schema/app, acquisizione file/immagini o verifica piattaforme per effetto dell'adozione. Libri e newsletter sono risorse/prodotti editoriali, non giochi ulteriori. Tornei Masters non sono classifiche di qualità dei giochi.

PUBLICATION_POLICY.md governa i contenuti versionabili: sintesi originali, metadati necessari e link; materiali di terzi richiedono condizioni specifiche. Nessun cambiamento retroattivo ai dati BGG/Kanare, nessuna automazione. PWS 1.5.0.

## Persistenza multifonte PerGioco — B-v1 adottata

TSK-0076, 2026-10-06: architettura logica B-v1 e piano delle dodici candidate confermati; perimetro TSK-0073 invariato. Decisione e contratto in `tasks/2026-10-06 - EPR - Persistenza multifonte per PerGioco/DECISIONE.md` e `MODELLO_LOGICO.md`. Otto nuove identita previste, Abande solo matching candidato 993, tre record con requisito non dimostrato senza giochi automatici; esiti CAT 9/3 preservati. Itinera un gioco/due istanze, soluzioni separate; categorie native mantenute e mapping comune vuoto. Adottato il modello logico, non eseguita l'importazione: schema/app/database invariati; migrazione DAT, importazione e APP autonomi con autorizzazioni distinte, nessun backfill/riesame implicito.


## Migrazione 013 operativa — TSK-0077, 2026-10-06

Schema multifonte B-v1 disponibile nell'operativo, migrazione 013 autorizzata e verificata dopo adozione TSK-0076. Tutte le 21 tabelle nuove sono vuote; PerGioco resta non importato e perimetro TSK-0073/CAT 12 candidate invariato. Nessun backfill/matching o game creato, nessuna APP o acquisizione. Prossimo DAT importazione separato richiede autorizzazione, strumenti e verifiche del piano 9/3, otto nuove identita, Abande candidato 993 e tre source-only; Itinera un gioco/due istanze. Evidenze in `tasks/2026-10-06 - DAT - Schema multifonte per PerGioco/`.

## Pilota importato — stato corrente 2026-10-08

TSK-0078, 2026-10-08: dopo 26 controlli su copie e consenso esplicito utente, pilota PerGioco importato nello schema B-v1/013. Dodici record fonte 77–88, otto nuovi games 1447–1454, Abande candidato 993, Azul/Blockade 1975/2001 source-only. Esiti CAT 9/3 e classificazioni/risorse/crediti/date preservati; Itinera un gioco/due istanze e soluzioni separate, Libre senza arco canonico verso 993. Nessun backfill/rete/acquisizione/APP/schema modificato. Backup/restore, legacy completo e replay zero delta verificati in tasks/2026-10-08 - DAT - Importazione pilota PerGioco/OPERATIONAL_VERIFICHE.json. Precedenti documenti/manifest restano evidenze storiche, non lo stato operativo corrente.
