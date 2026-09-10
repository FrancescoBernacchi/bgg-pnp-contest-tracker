# Avvio semplificato dell'app

- Apertura: 2026-09-10.
- Stato: concluso il 2026-09-10.
- Branch: `main`; incremento piccolo e lineare sull'app già integrata.

## Scope

Permettere all'utente di avviare PnP Collection con un doppio clic dal Desktop, evitando i comandi manuali e il blocco della Execution Policy di PowerShell.

## Deliverable e criteri di successo

1. Launcher versionato che individua Python, avvia il server dalla cartella corretta e apre il browser.
2. Collegamento `PnP Collection.lnk` sul Desktop con icona riconoscibile.
3. Avvio verificato senza modifica del database SQLite e documentazione aggiornata.

## Decisioni

Si usa un file `.cmd` perché Windows lo esegue con doppio clic senza dipendere dalla Execution Policy di PowerShell. Il collegamento contiene soltanto il percorso del launcher; il server continua a essere locale e in sola lettura.

## Verifiche e chiusura

- `app/launch.cmd` eseguito dalla radice: ha individuato il runtime Python integrato, avviato il server su `127.0.0.1:8765` e restituito il catalogo reale.
- Endpoint `/api/catalog`: HTTP 200, 22 contest e 829 entry al momento della prova.
- Collegamento creato in `C:\Users\39348\OneDrive\Desktop\PnP Collection.lnk`; destinazione `C:\Windows\System32\cmd.exe`, argomento `/k call "C:\PROGETTI CODEX\Progetto PnP Collection\app\launch.cmd"`, directory di lavoro corretta e icona Windows associata.
- 8 test Python e 4 test JavaScript superati; controlli sintattici superati.
- SHA-256 del database dopo le verifiche: `6ADAD244EF121548F5AFC767BC1E47706E82DBDAD47691B8213F5B7D5E6B02CC`. Il launcher e i test non scrivono nel database.

La prova automatica del launcher versionato è riuscita. L'avvio del file `.lnk` attraverso il processo non interattivo di verifica non ha lasciato attivo il server; il collegamento è stato quindi verificato strutturalmente e usa il normale meccanismo Windows previsto per il doppio clic interattivo.

- Correzione successiva alla prova utente: `where python.exe` selezionava l'alias Microsoft Store presente nella sessione grafica, causando una finestra di errore a ogni doppio clic. Il launcher ora privilegia esplicitamente il runtime Python integrato verificato e usa il PATH soltanto come ripiego.
- Dopo la conferma dell'avvio da parte dell'utente, creata un'icona originale con scheda PnP, dado e forbici nei colori dell'app. Conservati il PNG sorgente e il file Windows multirisoluzione in `app/assets/`; collegamento Desktop aggiornato a `pnp-collection.ico`.

## Prossima azione utile

Salvare l'incremento con un commit, ad esempio `feat: aggiungi avvio rapido dal desktop`, e quindi eseguire il push su richiesta.
