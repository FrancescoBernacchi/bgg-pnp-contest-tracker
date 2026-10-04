# Censimento annuale delle entry BGG

Procedura identificabile mantenuta nella base BGG; non è un'estensione del censimento globale e non richiede attualmente una skill autonoma. Unità: un solo anno, categoria BGG-A secondo PROJECT.md.

Input: inventario contest dell'anno, indici/roster autorevoli, stato precedente, contratto e playbook condiviso. Separa PnP principali e adiacenti autorizzati; challenge senza roster sono lacune, non roster vuoti.

1. Individua per ciascun contest il roster ufficiale (post, GeekList o Hub) senza leggere i WIP di gioco. Paginazione, spoiler e link dinamici si risolvono sulla pagina roster.
2. Estrai tutte le sezioni incluse, conservando finali, ritirati, rinominati, titolo originale, autore, stato, ordine/posizione nel roster, URL e appartenenza. La posizione nel roster non è posizione in classifica.
3. Confronta cardinalità dichiarate, sezioni e identificativi. Non ricostruire partecipanti dalle liste premiati e non fondere omonimi senza prova.
4. Risolvi URL BGG dal roster; fallback su fonti roster/annunci BGG soltanto per residui, senza trasformare ricerca URL in analisi WIP. Conserva dati non osservabili e conteggi precedenti.
5. Registra copertura per contest e anno, fonte/data, snapshot e attestazioni roster (`contest_census_observations`); aggiorna attestazioni quando cambia snapshot. Le prove storiche non convertite restano lavoro documentato da riconciliare.

Deliverable: roster e incremento riproducibile se autorizzato, anomalie e copertura separata. Successo: tutte le fonti nel perimetro esaminate e righe riconciliate, senza inferire vuoto da blocchi. Prima di applicazioni operative prova su copia, idempotenza e integrità; rigenera A/B dopo modifiche ai dati.

Esclusioni: WIP, risorse/requisiti, host, download; classifiche solo nel contratto specifico deliberato, come task separato. Precedenti: TSK-0005 (2025), TSK-0015 (2024), TSK-0017 (2026), `sources/2024-CORE-ROSTER-COMPLETION.md` e `catalog/import_2024_core_rosters.py` (parametri storici da ispezionare). Documenta pattern nuovi nel task, promuovi nella base solo dopo verifica. Proporre una skill autonoma futura soltanto se uso ricorrente e istruzioni specifiche rendono insufficiente questo riferimento.
