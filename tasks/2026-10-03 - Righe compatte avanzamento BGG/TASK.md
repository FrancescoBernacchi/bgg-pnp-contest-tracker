# Righe compatte avanzamento BGG

- Apertura: 2026-10-03.
- Stato: concluso.
- Segnalazione: APP-004.
- PWS: 1.5.0, allineato alla copia canonica.

## Scope, input e criteri di successo

Incremento autonomo del registro segnalazioni attivo; APP-001–003 concluse. Implementare APP-004 nel dettaglio annuale Avanzamento BGG: eliminare i riquadri vuoti dei contatori zero preservando valori, denominatori, link, etichette e distinzione dai dati assenti. Input: registro e frontend esistente. Deliverable: correzione, verifiche di righe zero/positive e responsive, documentazione, registro e stato strumenti aggiornati. Nessuna modifica ai dati.

## Risultato e verifiche — 2026-10-03

Risolta collisione CSS: progressMark usava empty, classe dei grandi pannelli senza dati. Ora usa zero; i valori assenti hanno unavailable e testo Non disponibile. Conteggi zero, denominatori, indicatori positivi, link ed etichette preservati. Nessuna modifica a query, dati o altre viste; progressMark è usato solo nel dettaglio annuale. 41 test frontend/PDF superati, incluso rendering con DOM simulato; node --check e git diff --check superati. Responsive verificato strutturalmente: inline-flex, tabella scorrevole sotto 720 px e regione accessibile da tastiera. Nessuna prova visiva browser eseguita.

Aggiornati README app, registro APP-004 e cruscotto strumenti; sezioni annuali non rigenerate perché dati invariati. Nessuna operazione Git mutativa. Prossimo incremento utile: APP-005 in task dedicato. Commit suggerito: Rendi compatti i contatori zero nell'avanzamento BGG.
