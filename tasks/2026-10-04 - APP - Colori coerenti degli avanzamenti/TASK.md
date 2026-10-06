# Colori coerenti degli avanzamenti

ID: TSK-0050 · APP · circoscritto · su_richiesta
Stato: completato

## Contratto
Risolvere APP-010 usando esattamente la palette PnP principali per barre di entrambi i perimetri e torte aggregate di tutti gli anni. Centralizzare colori, preservare metriche APP-008/009, etichette accessibili e stati ignoti/N/A. Verificare browser desktop/mobile, 0%, 100%, indisponibili e regressioni. Predecessore TSK-0049 completato: incremento autonomo di presentazione. PWS 1.5.0 verificato e allineato. Inventario skill consultato: nessuna skill specialistica pertinente alla modifica frontend locale. Modifiche preesistenti preservate; nessuna operazione Git autorizzata.

La richiesta esplicita della palette esistente prevale sul requisito precedente di cinque colori distinti: entry/acquisizione materiali/immagini verde #3d855e, classifiche blu #587f99, censimento materiali ambra #d08a22.

## Risultati e verifiche — 2026-10-04
Colori centralizzati in variabili CSS per fase, applicate a progress e SVG; sfondo incompleto comune #edf1e9. Eliminata la distinzione cromatica degli adiacenti. Etichette, valori e segni — preservati; dati e formule invariati.

47 test frontend/PDF superati. Regressione APP-009 in Edge headless 1400/1000/780/390 px: tastiera, espansione esclusiva, navigazione e assenza overflow. Test app/test_app010_browser.cjs: colori calcolati delle dieci barre e cinque torte corrispondenti, fixture 0%/100%/N/A/ignoti, 1400/390 px, nessun errore JS. Screenshot outputs/app010, mobile ispezionato. Il test sintetico ricarica la pagina dopo sostituzione del DOM; corretta un'aspettativa frontend obsoleta sul viola.

Contrasto testo su bianco: #203d39 11,75:1 e #62716b 5,13:1. Palette conservata per richiesta utente: verde 4,45:1, blu 4,28:1, ambra 2,86:1 su bianco; ambra sotto 3:1, limite della palette esistente, compensato per l'identificazione da nomi/valori scuri, senza attestare conformità grafica WCAG completa. Tre fasi condividono intenzionalmente il verde. Nessuna nuova acquisizione, schema o metrica modificata; sezioni A/B non rigenerate.

APP-010 chiusa; registro e cruscotto aggiornati. git diff --check senza errori; .gitignore conserva esclusione outputs/library/database. Nessun commit/push eseguito. Prossimo passo: verifica utente e commit autorizzato dell'incremento con messaggio “Uniforma i colori degli avanzamenti alla palette PnP principali”.
