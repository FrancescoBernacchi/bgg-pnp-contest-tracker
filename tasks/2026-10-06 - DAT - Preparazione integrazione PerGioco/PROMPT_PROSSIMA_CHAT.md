# Prompt — deliberazione dell'opzione B

Avviamo il passo successivo a TSK-0075: deliberazione EPR dell'opzione B per l'integrazione PerGioco, senza implementare né importare dati.

Applica AGENTS.md e verifica sandbox, PWS, naming e task esistenti. Se esiste un task EPR pertinente, riprendilo senza duplicarlo; altrimenti apri un task autonomo `YYYY-MM-DD - EPR - Persistenza multifonte per PerGioco`, con ID stabile e contratto. TSK-0074 e TSK-0075 restano completati; collega TSK-0075 come predecessore e TSK-0073 come decisione di perimetro. La presente richiesta autorizza la preparazione della decisione, non l'adozione automatica dell'architettura.

Leggi:
- `sources/PERGIOCO-SCOPE.md`;
- `catalog/pergioco_pilot_2026-10-06.json`;
- `tasks/2026-10-06 - CAT - Pilota PerGioco/RELAZIONE.md` e `VERIFICHE.json`;
- `tasks/2026-10-06 - DAT - Preparazione integrazione PerGioco/PROPOSTA.md`, `ANTEPRIMA.json`, `MODELLO_CORRENTE.json`, `VERIFICHE.json` e `TASK.md`;
- schema, migrazioni, documentazione multifonte e policy di pubblicazione correnti.

Trasforma l'opzione B in una decisione architetturale concreta e verificabile. Definisci entità, relazioni, cardinalità, chiavi stabili, vincoli, storia delle osservazioni e responsabilità di ogni dato. Distingui ciò che è già rappresentabile dal modello corrente dalle aggiunte indispensabili e dalle estensioni future rinviabili; evita duplicazioni e un sottocatalogo PerGioco isolato.

Copri almeno:
- osservazioni append-only dei record fonte e degli esiti di ammissione/completezza, separate dagli stati di sviluppo e dal matching;
- classificazioni native con etichette, percorsi ordinati, segmenti, tipi di osservazione e appartenenze multiple, sempre con URL/data; mapping comune separato e inizialmente vuoto, senza categorie inferite;
- URL storici, richiesti e finali, preservando redirect e destinazioni login senza confonderli con l'identità della risorsa;
- menzioni di risorse anche senza URL, destinazioni URL condivise e prove contestuali distinte;
- condizioni, completezza e accessi/costi separati per contenuto pubblico, regole complete, componenti/prodotti e implementazioni online, senza dedurre licenze dalla gratuità;
- istanze di problemi, crediti per ruolo e mancanze esplicite senza persone fittizie;
- relazioni dichiarate fra record di fonte, variante/base e dipendenza informativa distinta dal possesso/acquisto del gioco base; proiezione canonica soltanto dopo decisione sulle identità.

Verifica il disegno sulle dodici candidate già censite, senza ampliare il campione. Mantieni nove esiti CAT ammissibili e tre con requisito non dimostrato. Il piano da sottoporre a decisione prevede otto nuove identità canoniche, Abande con solo matching candidato a game_id 993 e Azul/Blockade (1975)/Blockade (2001) come record di fonte senza creare automaticamente giochi ammessi. Non fondere per solo titolo; preserva omonimi, alias, crediti ambigui, date originali e limiti delle evidenze.

Itinera deve contare un solo gioco: due schemi datati come istanze distinte e soluzioni come risorsa separata, senza associare una soluzione a uno schema in assenza di prova. Abande Libre resta variante distinta; finché il matching di Abande non è deliberato, non creare una relazione canonica confermata verso 993. Le alternative interne di tavoliere non generano ulteriori giochi.

Produci:
1. una proposta di decisione EPR con motivazione, alternative, tradeoff, confini e domande decisionali residue;
2. un modello logico e dizionario dei campi proposti, con mapping dall'anteprima DAT e casi concreti del pilota;
3. un piano di compatibilità con BGG/Kanare e trattamento delle evidenze pregresse, distinguendo eventuale formalizzazione successiva dalle osservazioni originarie, senza backfill o riesami impliciti;
4. criteri di accettazione, idempotenza, gestione delle collisioni/NULL, validazione su copia, backup e ripristino;
5. separazione esplicita fra futura implementazione/migrazione DAT, importazione PerGioco e sviluppo APP, con prerequisiti e punti di autorizzazione.

Non scrivere nel database operativo, applicare o creare migrazioni eseguibili, modificare schema/app, acquisire file/immagini, fare iscrizioni o verificare piattaforme. Nessuna nuova navigazione esterna o ampliamento del campione. Puoi produrre documenti, diagrammi testuali e anteprime offline; verifica SQLite soltanto in sola lettura se necessario. Non modificare lo Standard PWS.

Concludi proponendo la decisione concreta da confermare. Non dichiarare l'opzione B adottata sulla base di questo prompt. Dopo una mia conferma esplicita, registra la decisione e aggiorna i documenti autorevoli pertinenti, senza avviare automaticamente migrazione, importazione o APP. Se restano scelte materiali, esplicita soltanto quelle necessarie a deliberare il modello.
