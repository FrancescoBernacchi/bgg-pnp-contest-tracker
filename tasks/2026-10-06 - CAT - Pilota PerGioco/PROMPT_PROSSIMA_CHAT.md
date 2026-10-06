# Prompt per una nuova chat

Avviamo il passo successivo al censimento pilota PerGioco TSK-0074: preparazione DAT dell'integrazione, senza importare ancora dati.

Applica AGENTS.md, verifica sandbox/PWS, naming e task esistenti. Se esiste già un task DAT PerGioco pertinente, riprendilo senza duplicarlo; altrimenti apri un task autonomo `YYYY-MM-DD - DAT - Preparazione integrazione PerGioco`, con ID stabile e contratto. TSK-0074 resta completato e va collegato come predecessore.

Leggi:
- `sources/PERGIOCO-SCOPE.md`
- `catalog/pergioco_pilot_2026-10-06.json`
- `tasks/2026-10-06 - CAT - Pilota PerGioco/RELAZIONE.md`
- `tasks/2026-10-06 - CAT - Pilota PerGioco/VERIFICHE.json`
- schema, migrazioni e documentazione multifonte correnti.

Prepara una proposta concreta e un'anteprima offline della persistenza delle 12 candidate: 9 ammissibili, 3 con requisito non dimostrato (Azul e i due Blockade). Definisci il trattamento dei tre record senza renderli automaticamente giochi ammessi e senza perdere gli esiti del CAT. Conserva classificazioni originali PerGioco, etichette, gerarchie, segmenti e appartenenze multiple con URL/data; eventuale mapping comune separato. Non inferire categorie ulteriori.

Distingui identità, record di fonte, crediti per ruolo, risorse e condizioni di accesso, variante/base e dipendenza informativa. Itinera deve contare un solo gioco, con due schemi e soluzioni come risorse/istanze separate. Abande game_id 993 resta matching candidato finché non vi sia una decisione motivata; nessuna fusione per solo titolo. Preserva omonimi Beeline e Blockade, alias, URL storici/finali e date originali delle evidenze.

Verifica in sola lettura se il modello corrente rappresenta questi dati. Produci mapping campo-entità, lacune, alternative, anteprima dei record da creare/collegare, controlli di idempotenza e validazione, strategia di backup/ripristino e criteri di accettazione. Se serve un'evoluzione architetturale, prepara la decisione EPR da deliberare senza adottarla automaticamente.

Non scrivere nel database operativo, applicare migrazioni, modificare app/schema, acquisire file/immagini, fare iscrizioni, verificare piattaforme o ampliare il campione. Nessuna nuova navigazione esterna se non necessaria a una lacuna esplicitamente autorizzata. Concludi con la proposta verificabile e le decisioni necessarie prima dell'esecuzione dell'importazione. Importazione e APP restano passi separati; non avviarli automaticamente.
