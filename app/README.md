# Applicazione locale

Questa area ospiterà l'interfaccia locale di ricerca e consultazione. Lo stack tecnico sarà scelto nel task del PoC privilegiando avvio semplice, dipendenze contenute e accesso in sola lettura ai materiali archiviati.

`generate_monitoring_report.py` legge in sola lettura il database operativo e genera `outputs/contest-monitoring-dashboard.md` usando le viste di monitoraggio. Non effettua accessi di rete e non legge la libreria dei materiali.

La sezione `Cambiamenti dall'ultimo rilevamento` considera come confronto soltanto controlli periodici o legati a scadenze, escludendo baseline, completamenti del censimento e verifiche tecniche. Per alimentarla, un nuovo controllo deve registrare un `contest_checks.check_kind` contenente `monitor`, `scheduled`, `deadline` o `follow_up` e collegare tramite `check_id` gli snapshot di stato, entry, metriche e fasi.
