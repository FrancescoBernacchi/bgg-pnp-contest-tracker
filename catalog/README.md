# Catalogo versionabile

Contiene importazioni SQL, esportazioni testuali e manifest che rendono riproducibili i dati conservati nel database operativo. I file sono versionabili, leggibili e privi dei materiali binari originali.

Gli script 2026 costituiscono la provenienza riproducibile della baseline e dei successivi approfondimenti. Un nuovo rilevamento non deve riscrivere lo script storico: deve aggiungere un incremento separato, preservando valori precedenti, fonte, data, natura ufficiale o inferita e collegamento al relativo `contest_checks.id`.

Gli script dedicati a censimenti, risultati o verifiche tecniche non sono automaticamente rilevamenti periodici. Per alimentare il confronto del cruscotto, un incremento deve dichiarare un `check_kind` confrontabile e registrare snapshot completi delle entità effettivamente osservate.
