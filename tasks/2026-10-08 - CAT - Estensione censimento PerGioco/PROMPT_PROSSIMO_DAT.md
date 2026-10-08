# Prompt per il prossimo task DAT

Copia il testo seguente in una nuova chat del progetto.

---

Avviamo un task autonomo DAT per preparare e collaudare l'importazione del lotto CAT PerGioco completato in TSK-0080.

Titolo: YYYY-MM-DD - DAT - Importazione lotto Carta e matita PerGioco
Usa la data effettiva di apertura.

Applica AGENTS.md corrente, verifica allineamento PWS e consulta tasks/REGISTRY.json per evitare duplicazioni. Collega il nuovo task a TSK-0080, all'adozione TSK-0073, al modello B-v1 TSK-0076, alla migrazione 013 TSK-0077 e all'importazione/consultazione del pilota TSK-0078/0079, senza riaprirli. Registra contratto, ID stabile e criteri di successo secondo TASK_GOVERNANCE.md.

Input autorevoli:
- catalog/pergioco_extension_carta_matita_2026-10-08.json;
- tasks/2026-10-08 - CAT - Estensione censimento PerGioco/TASK.md, RELAZIONE.md e VERIFICHE.json;
- sources/PERGIOCO-SCOPE.md e PUBLICATION_POLICY.md;
- tasks/2026-10-06 - EPR - Persistenza multifonte per PerGioco/DECISIONE.md, MODELLO_LOGICO.md e COMPATIBILITA_E_VALIDAZIONE.md;
- mapping fisico e contratto della migrazione 013, schema operativo corrente e importer/verifiche del pilota TSK-0078, da riutilizzare soltanto dopo verifica della compatibilità con questo lotto.

Il lotto comprende esattamente nove candidate locali PGCM-001…009: Battaglia Navale con Carta e Matita, Engel, Labirinto, Numerino, Piattola, Punti e linee, Quadratini, Sqez, Stripes!. CAT concluso 9/9: sette admitted, due requirement_not_demonstrated (Battaglia Navale; Punti e linee, raccolta editoriale), zero schede principali non osservabili. Questi sono esiti CAT, non nove giochi nuovi né sette identità canoniche già deliberate. Chomp e i dodici record del pilota sono esclusi da nuova importazione o ricensimento, salvo confronti locali necessari a evitare collisioni, senza alterarne le prove storiche.

Obiettivo: predisporre un piano delle identità e un'importazione additiva conforme a B-v1/013, con prove su copie del database. Preserva integralmente il payload CAT, provenienza/date, titoli originali/alias/qualificazioni, classificazioni native multiple e percorsi, crediti per ruolo e contesto/lacune, menzioni e accessi/completezza/costi per ambito, esiti CAT e limiti. Nessun mapping comune implicito, NULL trasformato in assenza/pagamento, credito trasferito al soggetto errato o identità fusa per solo nome. Nessun INSERT OR REPLACE delle prove, Python -O o schema.sql applicato all'operativo.

Tratta esplicitamente questi casi prima di costruire la proiezione canonica:
- Il controllo CAT non ha trovato match esatti locali, ma non prova assenza di equivalenti: verifica nuovamente il catalogo corrente in sola lettura e proponi matching soltanto come candidati documentati, senza conferme o fusioni automatiche.
- Punti e linee è una raccolta di enigmi; non convertirla in un gioco ammesso o fonderla con Quadratini, che dichiara Punti e Linee come alias. I quattro titoli collegati restano riferimenti fuori lotto.
- Battaglia Navale ha requisito non dimostrato: conserva il record fonte e l'esito; nessuna creazione automatica di gioco ammesso, acquisizione di regole mancanti o conclusione sul pagamento.
- Piattola conserva sette varianti nominate, incluse le solitarie, con alias e crediti contestuali. Mantienile distinguibili come asserzioni; non creare ulteriori giochi/record candidati fuori lotto e non assorbirle come equivalenze confermate. Eventuali identità autonome richiedono perimetro e decisione separati.
- Labirinto resta un sistema con tre istanze dichiarate/datate; schema utilizzabile non attestato, soluzione non aperta. Preserva metadati e qualificazioni, senza attestare fruibilità né promuovere collegamenti soluzione–istanza non dimostrati.
- Crediti di libri, traduzioni e adattamenti commerciali non diventano designer del sistema principale; nomi ambigui e iniziali restano irrisolti. Alias Boxes/Squares e giochi ispirati mantengono contesti distinti.

Prima dell'applicazione operativa presenta un piano concreto e verificato: trattamento di ciascuna candidata, record fonte e giochi proposti, corrispondenze candidate, istanze/varianti/relazioni e dati rinviati. Puoi preparare l'importer e collaudare tutte le alternative necessarie su copie entro questo perimetro. Se emergono incompatibilità reali di B-v1/013, documentale e proponi EPR/DAT schema separato: non modificare lo schema in questo task.

Collaudi richiesti: preservazione completa del legacy e del pilota, integrità/FK, corrispondenza payload/hash canonico e proiezioni tipizzate, chiavi/eventi stabili, path/segment_count completi, NULL/collisioni, rollback atomico, replay idempotente senza delta, backup consistente e ripristino verificato, letture app esistenti senza regressioni. Usa transazione e protocolli del runner/importer verificati, senza presumere che gli ID liberi osservati su copia restino disponibili sull'operativo.

Questa richiesta autorizza preparazione, importer e prove su copie. L'applicazione al database operativo e il piano finale delle identità richiedono la mia conferma esplicita dopo il rapporto dei collaudi: chiedila soltanto quando il risultato è concreto e verificabile. Se confermo, applica con backup fresco, rivalida collisioni/legacy, verifica l'operativo e il replay, poi chiudi il task. Non fermarti per scelte tecniche reversibili già comprese nella preparazione.

Esclusioni: nessun nuovo censimento esterno, verifica VER autonoma, MAT/ACQ/IMG, host esterni, download, modifica app o schema, backfill BGG/Kanare, ricensimento pilota, automazione, commit o push. Eventuali operazioni Git le richiederò separatamente.

Deliverable: piano identità/mapping, importer offline nel perimetro, prove su copie e rapporto di confronto, controlli backup/ripristino, eventuale verifica operativa dopo conferma, TASK.md/registro/PROJECT_PROGRESS.md aggiornati secondo i rispettivi protocolli. Metadati e sintesi originali versionabili; database, copie/backup ed evidenze integrali di terzi locali fuori Git. Nessuna copertura dell'intero sito dedotta dal lotto. Alla chiusura distingui record fonte importati, esiti CAT, identità confermate/candidate/source-only, istanze e varianti rinviate; indica un eventuale APP successivo come task separato.
