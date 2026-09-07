# Output

Report ed esportazioni rigenerabili prodotti dall'applicazione o dai task. Il contenuto è escluso da Git salvo documentazione e file segnaposto.

`contest-monitoring-dashboard.md` è il cruscotto operativo corrente, generato da `app/generate_monitoring_report.py` leggendo il database SQLite locale. Può essere cancellato e ricreato senza perdita di conoscenza: dati autorevoli, cronologie e fonti restano nel database e nei file versionabili del catalogo.

La presenza di un report in questa cartella non implica che sia stato eseguito un nuovo controllo BGG; la data di generazione indica soltanto quando è stata prodotta la vista locale.
