# Catalogo versionabile

Contiene importazioni SQL, esportazioni testuali e manifest che rendono riproducibili i dati conservati nel database operativo. I file sono versionabili, leggibili e privi dei materiali binari originali.

Gli script annuali costituiscono la provenienza riproducibile delle baseline e dei successivi approfondimenti. `2025-contest-baseline.sql` introduce le undici edizioni 2025 verificate, senza censirne ancora integralmente le entry. Un nuovo rilevamento non deve riscrivere lo script storico: deve aggiungere un incremento separato, preservando valori precedenti, fonte, data, natura ufficiale o inferita e collegamento al relativo `contest_checks.id`.

Gli script dedicati a censimenti, risultati o verifiche tecniche non sono automaticamente rilevamenti periodici. Per alimentare il confronto del cruscotto, un incremento deve dichiarare un `check_kind` confrontabile e registrare snapshot completi delle entità effettivamente osservate.

`2025-in-hand-entries-results.sql` e `2025-9-card-nanogame-entries-results.sql` completano i primi due censimenti storici del 2025. Il secondo conserva 63 entry finali, 31 ritirate e 56 piazzamenti ufficiali; le due entry il cui titolo è pubblicato come `N/A` mantengono quel testo originale e ricevono un titolo canonico tecnico distinto.
