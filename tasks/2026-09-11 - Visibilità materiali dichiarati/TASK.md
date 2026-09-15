# 2026-09-11 - Visibilità materiali dichiarati

## Scope

- Rendere consultabili nella scheda entry i requisiti materiali descritti testualmente nel primo post BGG o nei regolamenti e già registrati in SQLite.
- Preservare testo originale, valore normalizzato, quantità, obbligatorietà, modalità di approvvigionamento, contesto, fonte e date.
- Distinguere la copertura della rilevazione e gli esiti `observed`, `none_declared`, `not_observable` e `not_checked` senza dedurre dati mancanti.
- Mantenere SQLite in sola lettura, lo stack attuale e l’assenza di richieste di rete automatiche.

## Input

- `entry_material_scans` e `entry_material_requirements` nel database operativo.
- Schema e migrazione `007_entry_declared_materials.sql`.
- Scheda entry e navigazione delle risorse già presenti nell’app.

## Deliverable e criteri di successo

- API entry completa di scansioni e requisiti materiali, con ordinamento stabile.
- Sezione leggibile e responsive nella scheda entry, distinta dai link alle risorse.
- Provenienza e copertura esplicite anche per dati integrati dai regolamenti.
- Test sintetici per stati, valori mancanti, testo non fidato e copertura `rules_integrated`.
- Verifica sul database reale della copertura dei requisiti e dell’invarianza del file SQLite.
- Documentazione autorevole aggiornata e task chiuso con decisioni, test e limiti.

## Stato

Concluso il 2026-09-11.

## Decisioni

1. I materiali descritti restano una sezione distinta dalle risorse con URL: un requisito fisico non implica l’esistenza di un file o collegamento.
2. Il testo originale (`name_raw`, `context_raw`) è mostrato come evidenza primaria; nome, categoria, approvvigionamento e necessità normalizzati restano esplicitamente separati.
3. I requisiti sono ordinati per utilità operativa: richiesti, alternativi, opzionali, incerti; nessuna quantità o necessità viene dedotta.
4. La scansione più recente definisce stato e copertura. A parità di data `rules_integrated` precede `first_post_only`, perché rappresenta la copertura più ampia registrata, senza eliminare lo storico restituito dall’API.
5. I link di provenienza continuano a usare soltanto URL BGG ammessi e si aprono esclusivamente su click. La consultazione non segue collegamenti e non legge la libreria locale.

## Verifiche

- Test Python: 15 superati, inclusi database temporaneo, sola lettura, ordinamento, copertura integrata sintetica, API HTTP e copertura completa dei dati reali.
- Test JavaScript: 16 superati, inclusi escaping, quantità mancante, testo originale/normalizzato, stati negativi e `rules_integrated`.
- `git diff --check`: superato; soli avvisi informativi sulla conversione LF/CRLF della working copy Windows.
- Database reale: 307 requisiti appartenenti a 102 entry e 129 scansioni; 102 `observed`, 23 `none_declared`, 2 `not_observable`, 2 `not_checked`.
- Tutti i 307 requisiti reali restituiti dalle rispettive schede entry. `PRAGMA integrity_check=ok`.
- SHA-256 SQLite prima e dopo le verifiche: `c321eda48b9ed72a9a4b875296cd624278f9975b8f775f8251e4adb17a590330`, invariato.
- Verifica browser locale sulla entry 793 (`Ancient World`): sezioni risorse/materiali distinte, tre requisiti leggibili con quantità, necessità, contesto e fonte; nessun link esterno aperto.
- Layout a 390 × 844: nessun overflow della pagina; tabelle contenute in regioni scorrevoli orizzontalmente. Viewport ripristinato al termine.

## Limiti residui

- Le 129 scansioni reali correnti hanno copertura `first_post_only`; il comportamento `rules_integrated` è pronto e verificato con dati sintetici, ma diventerà osservabile nell’app quando tali scansioni saranno registrate nel database.
- La tassonomia dei materiali resta provvisoria fino al confronto completo dei contest 2025, come stabilito dalla documentazione autorevole.

## Risultato

La scheda entry rende consultabili i materiali dichiarati senza URL insieme a quantità, necessità, reperibilità, contesto e provenienza, preservando limiti di copertura e incertezza. Documentazione aggiornata in `PROJECT.md`, `README.md` e `app/README.md`. Nessun commit o push eseguito.
