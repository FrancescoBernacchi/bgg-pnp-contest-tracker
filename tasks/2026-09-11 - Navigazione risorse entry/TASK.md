# Navigazione risorse entry

- Apertura: 2026-09-11.
- Stato: concluso; commit, push e integrazione in `main` autorizzati dall’utente l’11 settembre 2026.
- Scope: rendere navigabile nell'app locale la catena contest → entry → risorse dichiarate, senza apertura automatica, download o verifica remota.
- Input: URL dei contest e delle entry, `remote_resources`, `entry_resource_scans`, `entry_resource_mentions` e `remote_resource_observations` già presenti nel database SQLite.
- Deliverable: API di dettaglio entry estesa, collegamenti espliciti alle pagine contest/entry/WIP e sezione risorse con funzione, forma tecnica, provenienza, stato e date.
- Criteri di successo: tutte le risorse collegate all'entry sono visibili una sola volta e apribili solo su click; URL non HTTP(S) o con credenziali non diventano link; stati `none_declared`, `not_observable`, `not_checked` e assenza di scansione restano distinti; layout e tastiera verificati.
- Vincoli: SQLite in sola lettura; nessuna rete automatica; nessun materiale aperto o scaricato durante sviluppo e test; stack Python standard library e HTML/CSS/JavaScript invariato.
- Git: il task è sviluppato su `codex/app-rankings-navigation`, perché dipende dalla navigazione classifiche non ancora integrata. Su autorizzazione dell'utente, `main` (`01938c8`) è stato unito nel branch senza conflitti; il merge ha portato schema e censimenti risorse. Nessun nuovo branch, commit o push autorizzato per questo incremento.
- Titolo Codex verificato: `2026-09-11 - Navigazione risorse entry`.

## Decisioni

1. La catena navigabile è contest → entry → WIP/risorse. La pagina contest e le pagine BGG dell’entry mantengono il filtro preesistente per sole pagine di metadati BGG.
2. Le risorse sono ottenute tramite `entry_resource_mentions`, non con una semplice relazione sul gioco: l’app mostra soltanto le risorse attribuite esplicitamente all’entry e preserva etichetta, ruolo e provenienza della menzione.
3. Una destinazione di risorsa diventa link soltanto se è HTTPS e non contiene credenziali. Si apre in una nuova scheda con `noopener noreferrer`, esclusivamente su click. Nessun URL viene richiesto dal server o dal frontend durante il rendering.
4. Ogni risorsa mostra etichetta originale, host, ruolo, indicazione primaria, forma `access_type`, versione, disponibilità e date. L’ultima osservazione di disponibilità viene presentata senza eliminare la cronologia presente nel database.
5. `unknown` e `not_checked` significano “Non verificata”. Le condizioni `none_declared`, `not_observable`, `not_checked` e assenza di scansione hanno messaggi distinti; nessuna destinazione viene ricostruita o inventata.
6. Stack e schema non cambiano. L’avvio verifica ora la presenza delle quattro tabelle di provenienza delle risorse; SQLite resta `mode=ro` e `query_only`.

La skill locale `bgg-contest-navigation` ha guidato la separazione fra prova dell’iscrizione, WIP, collegamenti dichiarati e verifica successiva della disponibilità. Non è stato svolto un nuovo rilevamento BGG.

## Verifiche

- Database reale: 145 risorse, 145 menzioni, 53 entry coinvolte; ogni risorsa è associata esattamente una volta all’entry restituita dall’API. Tutte le destinazioni correnti sono HTTPS senza credenziali incorporate.
- Casi reali: `Ancient World` mostra pagina entry, WIP, cartella Drive e video YouTube con tipo, stato e provenienza; `Black Market` mostra correttamente `not_observable` senza inventare un link.
- Fixture sintetica: più risorse sullo stesso gioco, ordinamento della primaria, etichette originali, versioni, osservazione di disponibilità e entry senza risorse.
- Sicurezza frontend: `javascript:`, `file:`, HTTP e URL HTTPS con credenziali restano testo; HTTPS valido produce `target="_blank"` e `rel="noopener noreferrer"`; etichette non fidate vengono escapate.
- Test: `python -m unittest discover -s app -p test_server.py -v` — 12/12 passati; `node --test app/test_frontend.cjs` — 13/13 passati.
- Browser locale: struttura accessibile e resa desktop verificate sulle schede reali; link esterni, colonne della tabella, provenienza e stati sono esposti correttamente. Nessuna destinazione esterna è stata aperta durante i test.
- Integrità: SHA-256 del database invariato prima/dopo le verifiche: `2e44ced13daa93415aedd2b470753d8f0558d519fb89079b1ea707a436e95306`.
- Documentazione aggiornata: `app/README.md`, `PROJECT.md`, `README.md`, `AGENTS.md`, `.workspace/PROJECT_STATE.md`.

## Limiti residui e passo successivo

La disponibilità mostrata deriva soltanto dalle osservazioni registrate; l’app non prova che una risorsa sia ancora raggiungibile. Non è stata eseguita una certificazione formale con screen reader. Il prossimo approfondimento utile sarà valutare un’indicazione nella lista delle entry del numero di risorse, se il numero di giochi censiti renderà troppo costosa l’apertura di ogni scheda.

L’utente ha autorizzato commit, push e merge in `main`. Il risultato delle operazioni Git e gli identificativi finali saranno verificati e comunicati al termine dell’integrazione.
