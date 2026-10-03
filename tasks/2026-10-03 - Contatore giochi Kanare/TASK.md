# Contatore giochi Kanare

- Apertura: 2026-10-03.
- Stato: concluso.
- Segnalazione: APP-003.
- PWS: 1.5.0, allineato alla copia canonica.

## Scope, input e criteri di successo

Incremento autonomo del registro segnalazioni ancora attivo; i task APP-001 e APP-002 sono conclusi. Aggiungere alla navigazione Kanare il conteggio dinamico dei giochi canonici collegati alla fonte, usando gli stessi dati della vista e lo stile dei contatori esistenti. Il conteggio generale della fonte resta indipendente dai filtri di ricerca. Verificare aggiornamento alla rilettura del catalogo, corrispondenza con i dati locali e layout desktop/stretto. Nessuna modifica ai dati o accesso esterno.

Deliverable: frontend, documentazione, chiusura APP-003 nel registro e aggiornamento strumenti nel cruscotto.

## Risultato e verifiche — 2026-10-03

Aggiunto kanare-count con classe nav-count e conteggio dei giochi aventi source_keys kanare_abstract al caricamento del catalogo. La stessa fonte dati alimenta la vista Kanare; nessuna query o API modificata. Database letto in sola lettura: 64 giochi, 64 ID distinti. Verificato load con DOM simulato e riletture 2/0/1, filtri attivi e prodotti indipendenti dal conteggio. 32 test frontend, node --check e git diff --check superati. Verifica strutturale HTML/CSS: stile e allineamento condivisi, contatori nascosti sotto 720 px; nessuna prova visiva browser.

Aggiornati README app, registro APP-003 (chiusa) e stato strumenti nel cruscotto. Dati invariati, sezioni annuali non rigenerate. Nessuna operazione Git mutativa. Prossimo incremento utile: APP-004 in un task dedicato. Commit suggerito: Aggiungi contatore dinamico giochi Kanare.
