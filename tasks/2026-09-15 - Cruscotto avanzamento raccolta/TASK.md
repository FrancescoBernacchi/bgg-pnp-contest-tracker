# Cruscotto avanzamento raccolta

- Apertura: 2026-09-15.
- Stato: concluso; estensione con viste annuali integrata.
- Scope: definire un documento Markdown versionabile che renda visibile l'avanzamento su tutte le fasi informative e operative della collezione.
- Input: database SQLite locale, `PROJECT.md`, `.workspace/PROJECT_STATE.md`, calendario di monitoraggio, documentazione di app, database, catalogo, fonti e libreria.
- Deliverable: `PROJECT_PROGRESS.md`, regole di manutenzione automatica e integrazione nella mappa autorevole del progetto.
- Criteri di successo: copertura, pipeline, attività aperte e salute degli strumenti sono distinguibili; conteggi e date hanno provenienza; gli stati mancanti non sono interpretati come assenze; ogni incremento futuro aggiorna il cruscotto senza una richiesta separata.
- Vincoli: nessun accesso BGG, nessun nuovo rilevamento esterno, nessuna modifica al database o ai materiali, nessuna operazione Git mutante.
- Titolo Codex verificato: `2026-09-15 - Cruscotto avanzamento raccolta`.

## Decisioni

1. `PROJECT_PROGRESS.md` è il quadro operativo autorevole dell'avanzamento trasversale, mentre il database resta la fonte dei dati e `sources/MONITORING_CALENDAR.md` governa le finestre dei rilevamenti.
2. Il cruscotto è manutenuto dall'agente nello stesso incremento che cambia dati, copertura, priorità o stato. Le sezioni annuali quantitative dipendono dal generatore; decisioni e attività qualitative restano curate dall'agente perché non sono ricavabili dal solo database.
3. Gli stati controllati distinguono `non iniziato`, `in corso`, `parziale`, `completo`, `da aggiornare`, `bloccato` e `non applicabile`.
4. Le percentuali sono usate soltanto quando esiste un denominatore esplicito. Risorse, requisiti e classifiche non ricevono percentuali artificiali quando il totale atteso non è conoscibile.
5. La copertura iniziale deriva da una query in sola lettura eseguita il 2026-09-15. Nessuna fonte esterna è stata consultata.
6. Le viste annuali A e B sono generate dal database tramite `app/generate_project_progress.py`. I pallini colorati usano emoji compatibili con Markdown e GitHub; la legenda distingue censimento, classifiche, lettura e download.
7. Le informazioni multilinea non usano tag HTML: nella sintesi ogni indicatore occupa una riga Markdown e nel dettaglio ogni contest occupa una colonna, con le entry disposte nelle righe sottostanti.
8. Su chiarimento dell'utente, “lettura materiali” misura l'esistenza di una scansione registrata per l'entry, inclusa `first_post_only`; non richiede `rules_integrated`. Nel dettaglio annuale i contest sono intestazioni di colonna e le entry sono elencate verticalmente nelle rispettive celle.
9. La sintesi mostra gli anni in ordine decrescente con il totale dei contest nell'intestazione; il titolo della tipologia resta su una riga vuota e gli indicatori sottostanti sono indentati senza simboli visibili. Poiché Markdown non può imporre bordi scuri, larghezze minime o scrollbar, i dettagli annuali sono suddivisi in gruppi di massimo quattro contest.
10. Nel dettaglio annuale il nome di ogni entry e gli indicatori `L`/`D` occupano due righe Markdown consecutive nella stessa colonna, evitando tag HTML per l'andata a capo.
11. Una colonna iniziale `N.` numera progressivamente le tipologie nella sintesi e le righe delle entry in ogni gruppo annuale; le righe subordinate e quelle degli indicatori restano senza numero.
12. Per impedire al visualizzatore di eliminare la prima cella vuota e far slittare gli indicatori `L/D`, le celle intenzionalmente vuote contengono uno spazio non separabile. Le colonne testuali dichiarano esplicitamente l'allineamento a sinistra.
13. Tutte le celle mancanti nei gruppi annuali usano un segnaposto invisibile, evitando lo slittamento quando un contest ha meno entry degli altri. I gruppi passano da quattro a sei contest.
14. I titoli descrittivi dei thread WIP vengono abbreviati soltanto nella vista: tag e descrizioni vengono rimossi e resta un'etichetta breve derivata dallo stato normalizzato. I valori originali nel database non cambiano.
15. Ogni tabella annuale include, sotto i nomi dei contest, una seconda riga di intestazione con la classifica usata per ordinare le entry; la precedente nota sotto la tabella è rimossa.
16. Nella sintesi l'anno e il relativo totale dei contest sono disposti su due righe consecutive e allineati a sinistra, senza HTML incorporato.
17. I nomi delle tipologie nella sintesi collegano l'edizione più recente disponibile; i nomi dei contest annuali collegano la relativa fonte e quelli delle entry il WIP dedicato, con fallback alla pagina entry registrata.

## Verifiche

- Preflight: branch `main` allineato a `origin/main`; working tree inizialmente pulita.
- Database locale: 22 contest, 829 entry, 1.054 osservazioni di classifica, 129 scansioni risorse, 260 risorse e menzioni, 129 scansioni materiali, 307 requisiti, 0 acquisizioni e 0 file acquisiti.
- Ripartizione: 2025 — 11 contest, 464 entry, 129 scansioni risorse e materiali; 2026 — 11 contest, 365 entry, nessuna scansione WIP/materiali ancora registrata.
- Controllo documentale: il nuovo file è collegato dalla mappa di progetto, dalla documentazione principale e dallo stato PWS; il protocollo è incluso nelle istruzioni permanenti dell'agente.
- Nessun rilevamento BGG, download, apertura di risorse esterne o modifica al database.
- Generatore compilato ed eseguito con Python 3.12; seconda esecuzione idempotente (SHA-256 del documento invariato).
- Sezioni generate delimitate da una sola coppia di marcatori; rilevate esattamente 829 entry nel dettaglio, pari al totale del database.
- Selezione della classifica principale dichiarata per ciascun contest; fallback alfabetico quando non esiste una categoria adatta.
- Correzione multilinea: rimossi tutti i tag `<br>` e `<small>` dal cruscotto; ogni indicatore della sintesi e ogni entry del dettaglio occupano ora una vera riga Markdown.

## Risultato e passo successivo

Il repository dispone ora di un unico cruscotto trasversale, leggibile e versionabile. La prima priorità evidenziata è recuperare il monitoraggio BGG scaduto; la seconda è completare la scansione WIP, risorse e materiali del 2025.
