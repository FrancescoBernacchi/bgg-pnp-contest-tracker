# Taccuino dei controlli BGG

Ultimo aggiornamento documentale: 2026-10-02. Ultimo rilevamento periodico BGG su un singolo contest: 2026-09-05. Il censimento globale del 2026-10-02 ha aggiunto Roll & Write 2026, senza anticiparne il monitoraggio periodico.

Questo registro governa i controlli periodici sui contest. Le date sono finestre operative: un controllo può essere anticipato soltanto in presenza di un annuncio BGG, di un errore da correggere o di una richiesta esplicita. I controlli tecnici di consistenza non costituiscono nuovi rilevamenti dello stato esterno.

La revisione del 7 settembre ha consolidato le regole del progetto senza consultare BGG e non costituisce un rilevamento. La finestra Turkish PnP dell'8 settembre resta quindi il prossimo controllo dovuto.

## Prossimi controlli mirati

| Data / finestra | Contest | Motivo | Cosa verificare | Stato |
|---|---|---|---|---|
| 2026-09-08 | Turkish PnP | giorno successivo alla proroga del playtest | modulo di voto, nuovo calendario, entry ammesse | pianificato |
| 2026-09-11 | contest 2026 attivi | primo controllo settimanale | nuove entry e cambiamenti di stato in Solitaire, 54-Card, Traditional Deck e Wargame | pianificato |
| 2026-09-25 | Wargame PnP | avvicinamento alla chiusura entry | WIP/idea diventati giocabili, ritiri e nuove entry | pianificato |
| 2026-10-02 | Wargame PnP | primo controllo dopo la chiusura del 1 ottobre | lista congelata e fase successiva | pianificato |
| 2026-10-16 | Roll & Write 2026 | giorno successivo all'apertura delle iscrizioni del 15 ottobre | confermare fase, eventuale roster e prossima finestra | pianificato |
| 2026-10-16 | Solitaire PnP | apertura voto dopo il termine sviluppo del 15 ottobre | entry finali, ritiri, modulo e calendario voto | pianificato |
| 2026-10-17 | 54-Card | primo controllo dopo la chiusura entry del 16 ottobre | totale definitivo provvisorio, ritiri e stati | pianificato |
| 2026-11-01 | 24 Hour NINE | primo controllo dopo la fine del bimestre | roster finale, eventuali ritiri, apertura del voto e prossimo tema | pianificato |
| 2026-11-02 | 54-Card | dopo la scadenza Component Ready del 1 novembre | entry giocabili e ritiri | pianificato |
| 2026-11-12 | Wargame PnP | dopo il freeze previsto dell'11 novembre | finalisti e apertura/finestra voto | pianificato |
| 2026-11-16 | Solitaire PnP | dopo la chiusura voto del 15 novembre | risultati o data prevista di pubblicazione | pianificato |
| 2026-11-16 | 54-Card | dopo la scadenza Contest Ready del 15 novembre | finalisti e avvio playtest ufficiale | pianificato |
| 2026-12-01 | Traditional Deck | chiusura submission | entry definitive e fase successiva | pianificato |
| 2026-12-01 | 54-Card | apertura voto | modulo, categorie e finalisti | pianificato |
| 2026-12-16 | Traditional Deck | apertura voto prevista il 15 dicembre | modulo, categorie e finalisti | pianificato |
| 2026-12-22 | Wargame PnP | dopo la chiusura voto del 21 dicembre | risultati ufficiali | pianificato |
| 2027-01-01 | 54-Card e Traditional Deck | dopo la chiusura voto del 31 dicembre | risultati ufficiali o data prevista | pianificato |

## Cadenza ordinaria

- Contest con entry aperte o sviluppo attivo: controllo settimanale, evitando duplicati nella stessa giornata.
- Nei 7 giorni precedenti una scadenza: controllo mirato aggiuntivo se non già coperto dalla cadenza settimanale.
- Il giorno successivo a chiusura entry, freeze, apertura/chiusura voto o data risultati: controllo dell'evento.
- Contest conclusi: nessun controllo ordinario; riesame solo per rettifiche, risultati mancanti o nuovi collegamenti autorevoli.
- Stato esterno invariato: registrare `no_change` solo quando il controllo era effettivamente dovuto.

## Ultimi controlli

| Data | Contest | Esito | Nota |
|---|---|---|---|
| 2026-09-05 | Children & Family | baseline completata | 36 finali, 2 ritirate e 43 piazzamenti in 5 categorie |
| 2026-09-05 | Solomode | baseline adiacente completa | 21 modalità dipendenti da giochi base, 63 piazzamenti di gioco e statistiche di voto |
| 2026-09-04 | 54-Card | verifica di consistenza, nessuna variazione | secondo accesso nello stesso giorno; non vale come rilevamento periodico |
| 2026-09-04 | tutti i contest della baseline | baseline / approfondimenti | prima ricognizione e censimenti 2026 |

## Regola di manutenzione

Dopo ogni rilevamento aggiornare questo file indicando data, esito e prossima finestra utile. Se una fonte annuncia una proroga o modifica una scadenza, preservare la data precedente nello storico del database e sostituire qui la prossima azione operativa.

Nel database classificare il controllo con un `check_kind` confrontabile (`monitor`, `scheduled`, `deadline` o `follow_up`) e collegare tramite `check_id` gli snapshot completi disponibili. Le attività `baseline`, `census` e `consistency` non avanzano la cadenza periodica.
