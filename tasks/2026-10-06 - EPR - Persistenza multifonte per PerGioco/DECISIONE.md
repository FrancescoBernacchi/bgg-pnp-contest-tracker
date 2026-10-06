# Decisione B-v1 adottata — TSK-0076

Data: 2026-10-06. Conferma esplicita dell'utente nella chat 01a112f5-19f1-74c0-873d-c32a9b043631: «OK, confermo», in risposta alla proposta di confermare B-v1 e il piano delle dodici candidate. Stato: adottata come architettura logica; non implementata e non importata.

## Ambito deliberato

Adottata l'estensione additiva generica del nucleo multifonte descritta in MODELLO_LOGICO.md e nei confini di COMPATIBILITA_E_VALIDAZIONE.md: record fonte, giochi canonici e matching distinti; osservazioni append-only con provenienza e date originarie/formalizzazione separate; ammissione e completezza indipendenti dallo sviluppo e dal matching; classificazioni native multiple con etichette, percorsi ordinati e segmenti, mapping comune separato inizialmente vuoto; URL storici/richiesti/finali e login distinti dall'identità della destinazione; menzioni anche prive di URL, risorse URL condivise e prove contestuali separate.

Condizioni, accessi, completezza e costi separati per contenuto pubblico, regole complete, componenti/prodotti e implementazioni online. Gratuità non attesta licenza. Istanze di problemi, crediti per ruolo, soggetti irrisolti e mancanze esplicite senza persone fittizie; relazioni dichiarate tra record prima della proiezione canonica, con dipendenza informativa distinta da possesso/acquisto. Baseline CAT conservata con hash/versione e responsabilità dei campi strutturati definite dal modello, senza sottocatalogo PerGioco isolato.

Approvato il piano per una futura importazione distinta delle sole dodici candidate:

- Otto nuove identità canoniche conservative: Achi, Krypte, Abande Libre, Chomp, Itinera, Reversi, Beeline (1968), Beeline (1984).
- Abande: solo matching candidato a game_id 993; nessuna conferma di equivalenza/versioni e nessun gioco duplicato.
- Azul, Blockade (1975), Blockade (2001): record fonte con requisito non dimostrato, senza creazione automatica di giochi ammessi.

Restano nove esiti CAT ammissibili e tre con requisito non dimostrato. Itinera conta un solo gioco con due istanze datate 2021-06-18 e 2021-07-23; soluzioni risorsa separata, nessun collegamento soluzione–schema senza prova. Abande Libre resta variante distinta, con relazioni verso il record Abande; nessuna relazione canonica confermata verso 993 finché il matching base non viene deliberato. Alternative interne di tavoliere non creano giochi. Omonimi, alias, crediti ambigui, date e limiti delle evidenze preservati.

## Confini e conseguenze

Autorizzata la registrazione di questa decisione, la promozione nei documenti autorevoli e la chiusura EPR. Nessun avvio automatico di migrazione/schema DAT, importazione PerGioco, VER Abande, APP, acquisizioni o immagini; nessuna rete, piattaforma o iscrizione. Nessun backfill/riesame implicito BGG o Kanare; eventuale formalizzazione successiva ha proprio contratto e mantiene l'osservazione originaria distinta dalla registrazione successiva. PWS resta 1.5.0, Standard invariato.

Il futuro DAT esecutivo richiede autorizzazione separata, mapping fisico del modello, collaudi su copia, vincoli append-only/NULL/collisioni, replay idempotente, backup consistente e ripristino provato prima dell'operativo. L'importazione richiede un altro contratto separato dopo disponibilità dello schema e verifiche; APP segue contratto proprio. Cambiamenti materiali del modello tornano in EPR; nomi fisici possono essere adattati documentando equivalenza semantica e cardinalità.

## Storia e riferimenti

TSK-0073 resta decisione di perimetro; TSK-0074 e TSK-0075 restano completati. PROPOSTA.md, CASI_PILOTA.json, VERIFICHE.json e PUBLICATION_CHECK.json documentano la preparazione precedente: i valori architecture_adopted=false nelle anteprime e verifiche originarie sono storici, non lo stato corrente della decisione. Non riscriverli. Decisione corrente in questo documento, registro e riferimenti autorevoli.

MODELLO_LOGICO.md è il contratto logico B-v1 adottato, non DDL vigente; COMPATIBILITA_E_VALIDAZIONE.md è il piano vincolante per compatibilità e passi futuri. Lo schema operativo resta quello preesistente. Verifica della sola formalizzazione in DECISION_VERIFICHE.json; nessun collaudo SQL eseguito.
