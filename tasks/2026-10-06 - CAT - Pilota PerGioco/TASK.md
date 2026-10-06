# TSK-0074 â€” Pilota PerGioco

- Apertura: 2026-10-06; categoria CAT; modalitÃ  circoscritto; cadenza su richiesta.
- Stato corrente: completato il 2026-10-06. Stato originario: pianificato; contratto pronto, censimento non ancora eseguito.
- Dipendenza: TSK-0073 completato; preanalisi TSK-0072.
- Chat: 01a112a8-cda7-79e2-8d36-d8fb6cc59cea.
- Autorizzazione: percorso passo passo richiesto, giochi logici inclusi esplicitamente. Perimetro sources/PERGIOCO-SCOPE.md.

## Contratto e campione

Censire 12 identitÃ  candidate: Achi, Krypte, Abande, Abande Libre, Chomp, Itinera, Azul, Reversi, Blockade (1975), Blockade (2001), Beeline (1968), Beeline (1984). Titoli/collegamenti individuati nella preanalisi, non tutti verificati. Campione motivato: tradizionale, originale del curatore, materiale comune, base/variante, corrispondenza locale, gioco logico, controllo negativo e omonimi qualificati. Nuovi esiti non aumentano silenziosamente il perimetro.

Per Itinera registrare separatamente sistema, due schemi osservati e accesso alle soluzioni; contare un gioco. Schemi/soluzioni non sono nuove identitÃ . Per i titoli incompleti conservare requisito non dimostrato, non inferire pagamento.

## Input e deliverable

Requisito utente 2026-10-06: rilevare classificazione originale PerGioco, etichette, gerarchia e appartenenze multiple con URL/data, senza sostituirle con categorie inferite. Deliverable utilizzabili per database e app; categorie non osservate ignote.

Relazione datata TSK-0072 e sue evidenze riutilizzabili, perimetro adottato, schema multifonte e dati locali read-only. Manifest versionabile di metadati, esiti di completezza/gratuitÃ /accesso, crediti, URL storici/finali, matching candidato e relazioni; relazione di copertura e verifiche. Data originale delle osservazioni riutilizzate distinta dalla formalizzazione nel pilota. Nessun contenuto integrale di terzi nei deliverable.

Successo: 12/12 candidate con esito esplicito (anche non ammesse/non osservabili), denominatore distinto dai giochi ammessi; identitÃ /crediti/risorse/provenienza e lacune tracciabili; controlli sugli omonimi, base/variante, Abande e Itinera. Non promettere 12 giochi ammessi.

## Confini

Nessuna importazione SQLite, nuova adozione, modifica app/schema, PDF/download, immagini, iscrizione, sessione di gioco o verifica piattaforme. Riutilizzare osservazioni del giorno; nuove letture soltanto per parti ancora non verificate o correzioni motivate. Le skill locali FON non coprono automaticamente un censimento CAT: al primo incremento verificare routing e procedura pertinente senza ampliarne lo scope; eventuale bisogno di skill CAT da valutare in TSK-0048, non blocco automatico.

## Prossimo incremento previsto all'apertura (storico)

TSK-0074 Ã¨ un task locale autonomo pianificato, con contratto predisposto in questa chat; non Ã¨ giÃ  una nuova chat Codex e non Ã¨ iniziato. Eseguire in chat dedicata riprendendo questo ID/percorso, senza duplicare il registro. Questa chat conserva preanalisi, adozione e requisiti. DAT, APP, eventuale MAT e lotti ACQ/IMG sono attivitÃ  distinte con contratti propri; PerGioco non assume automaticamente i contratti BGG.

Preparare manifest e attestazioni dalle evidenze esistenti, poi verificare le candidate residue con navigazione pubblica e chiudere il pilota. DAT/APP successivi distinti.

## Risultati e chiusura â€” 2026-10-06

Campione esatto: 12/12 esiti, nove ammissibili al pilota e tre con requisito non dimostrato (Azul, Blockade 1975, Blockade 2001); zero importazioni e acquisizioni. Nessuna scheda principale rimasta non osservabile dopo recupero browser. Un gioco Itinera, due schemi come risorse, soluzioni riservate con osservazione TSK-0072 preservata. Abande game_id 993 unico match esatto locale, ancora candidato per PerGioco; nessuna fusione/scrittura. Omonimi separati, crediti/ruoli e lacune espliciti. Classificazioni da breadcrumb e indici, piÃ¹ famiglia Achi ed etichetta 5x5 Blockade 2001; nessuna esaustivitÃ  dell'intero sito attestata.

Deliverable: `catalog/pergioco_pilot_2026-10-06.json`, `RELAZIONE.md`, `VERIFICHE.json`, `PUBLICATION_REVIEW.json`, `PROMPT_PROSSIMA_CHAT.md`. `build_manifest.py` formalizza offline le osservazioni e legge SQLite mode=ro/query_only; non accede alla rete e non importa. Fonti/date nel manifest e relazione. Le sette schede preanalizzate sono riutilizzate per regole/crediti con data originaria e rilette soltanto per dati residui; cinque schede nuove complete valutate. Nessun login, PDF, download o verifica piattaforma.

Controlli: JSON leggibile, campione esatto, dodici ID/URL unici, tutti i campi ed esiti richiesti, URL/data delle classificazioni, 9+3=12, dipendenza base+variante e accesso distinto Itinera. Hash SQLite prima/dopo identico, in VERIFICHE.json. Query complementare sui frammenti distintivi dei titoli senza ulteriori match. App/schema e database invariati. `.gitignore` verificato; revisione euristica e manuale dei deliverable nuovi senza rilievi di contenuti integrali o binari. Revisione limitata al lotto, non ai contenuti pregressi/commit in uscita: non Ã¨ un via libera al push.

Registro TSK-0074 aggiornato senza nuova voce; chat originaria e corrente entrambe conservate. PROJECT_PROGRESS.md aggiornato; sezioni annuali A/B non rigenerate perchÃ© dati BGG, materiali e database non cambiati. PWS 1.5.0, Standard non modificato. Incremento locale da committare, nessun commit/branch/push eseguito e remoto non verificato sul server.

### Routing ed efficacia delle skill

`source-preanalysis` e inventario consultati per routing: nessuna skill CAT dedicata esistente; FON non applicata come autorizzazione per il CAT. Procedura CAT derivata dal contratto deliberato, non estensione della skill FON. BGG/MAT/ACQ/IMG non applicate perchÃ© fuori perimetro.

Skill `computer-use` applicata alla navigazione pubblica: dodici schede e classificazioni residue osservate senza acquisizione, risultato verificato. Le istruzioni locali del plugin descrivono automazione Windows, mentre il runtime espone CUA browser e disabilita app native: usata l'API browser documentata. Cache miss web risolti nel browser; un click indice bloccato dal consenso cookie Ã¨ stato sostituito con navigazione all'URL visibile giÃ  osservato. Origine osservata: differenze di cache e interfaccia della fonte/runtime, non difetto dimostrato della skill. Nessuna tecnica di aggiramento o manutenzione della skill. Limiti: schemi/soluzioni e condizioni sono evidenze storiche riutilizzate, classificazione non esaustiva dell'intero sito, nessun playtest o autenticazione. Eventuale skill CAT multifonte da valutare in TSK-0048 dopo altri casi, senza promozione generalizzata da questo singolo pilota.

### Prossimo passo e Git

DAT preparatorio autonomo: verificare prima task esistenti, definire mapping e anteprima offline per classificazioni native, risorse/istanze e matching. Decisione esplicita prima di modifiche architetturali o importazione; APP e acquisizioni separati. Prompt in PROMPT_PROSSIMA_CHAT.md; nessun successore aperto automaticamente.

Commit consigliato per salvare questo incremento coerente: `Censisci il pilota PerGioco con 12 esiti tracciati`. Includere soltanto manifest, cartella TSK-0074, aggiornamento della sua voce nel registro e cruscotto, distinguendo le molte modifiche pregresse. Prima di un eventuale push serve revisione dell'intero insieme di commit in uscita secondo PUBLICATION_POLICY.md.

## Ripresa autorizzata â€” 2026-10-06

Chat corrente: 01a112d6-cd21-7202-aaac-3fb038838d78; chat originaria preservata. Titolo verificato: 2026-10-06 - CAT - Pilota PerGioco. Stato corrente: in corso. Preflight ordinario riuscito, PWS locale/canonico 1.5.0. Main con modifiche pregresse preservate; riferimento locale origin/main senza divergenza indicata, server remoto non interrogato. Contratto e 12 candidate confermati dall'utente. Inventario e source-preanalysis consultati per routing: nessuna skill CAT dedicata; FON non applicata al censimento. Letture nuove limitate ai dati residui, evidenze TSK-0072 riutilizzate con data originaria.

## Commit e push autorizzati — 2026-10-06

Utente autorizza commit e push del pilota. Fetch origin riuscito; main allineato prima dell’operazione. Audit generale: 299 rilievi euristici in 30 percorsi pregressi, nessun commit in uscita preesistente. Quei percorsi non sono inclusi nel commit CAT; cronologia non riscritta. Pubblicazione circoscritta ai metadati e alle sintesi del pilota, previa revisione dell’esatto contenuto staged. Modifiche pregresse preservate fuori dal commit.

### Esito Git verificato — 2026-10-06

Commit pilota `9ad9337a601a399212f3d43d761a24dec6023778` su main: dieci file, inclusi solo aggiornamenti CAT nei documenti condivisi. Push origin/main riuscito; ls-remote stesso hash, confronto 0/0. Audit di tutti i file del commit in uscita senza rilievi; dati del registro estranei a TSK-0074 invariati. Modifiche pregresse preservate fuori dai commit. Esito registrato dopo successo in aggiornamento documentale separato.
