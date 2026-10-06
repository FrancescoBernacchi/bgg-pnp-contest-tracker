# Schede annuali compatte e righe espandibili

ID: TSK-0049 · APP · circoscritto · su_richiesta
Stato: completato

## Contratto
Implementare APP-009 del registro segnalazioni: quattro anni per riga desktop, righe inizialmente chiuse con espansione esclusiva, cinque indicatori aggregati per anno e dettaglio separato PnP/adiacenti. Responsive, tastiera, dati ignoti/N/A e navigazione da verificare. Input: registro, metriche APP-008, frontend locale. Deliverable: frontend, prove e documentazione. Nessuna modifica dati o acquisizione. Predecessore TSK-0047 concluso; incremento autonomo di presentazione. PWS 1.5.0 allineato. Inventario skill consultato: nessuna skill BGG/FON applicabile alla sola modifica APP locale. Modifiche di governance preesistenti preservate.

## Risultati e verifiche — 2026-10-04
Frontend implementato: quattro schede desktop; responsive 3/2/1; espansione esclusiva ancorata all’anno attivato al cambio di colonne; focus conservato dopo click/tastiera. Testi eliminati/abbreviati come richiesto. Torte SVG compatibili con CSP, etichette e valori accessibili, indicazione ignoti/N/A e funzione immagini non implementata. Dettagli separati e navigazione esistente conservati.

47 test frontend/PDF passati. Browser Edge headless 1400/1000/780/390 px: stato iniziale chiuso, espansione esclusiva, Enter/Spazio, focus, cambio responsive, 464/464 classifiche 2025, collegamento entry e nessun overflow/errori JS. Screenshot in outputs/app009, verificati desktop/mobile. Aggregazioni sintetiche: 10/100 rispetto a perimetri 10/10 e 0/90, censimento 9/10, denominatore assente e N/A espliciti. Dati e schema invariati; nessuna rigenerazione A/B necessaria. Limite: immagini rappresentative non implementate, coerentemente con APP-008.

Prossimo passo: verifica utente della vista e commit del solo incremento APP con messaggio suggerito “Compatta le schede annuali con righe espandibili”. Nessuna operazione Git autorizzata/eseguita.

Regressione browser APP-008 aggiornata alla struttura espandibile: passata a 1560/1400/390 px con dieci barre, attestazioni storiche e assenza overflow. Controllo finale diff senza errori di whitespace.
