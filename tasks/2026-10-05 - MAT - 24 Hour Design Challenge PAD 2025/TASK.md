# 2026-10-05 - MAT - 24 Hour Design Challenge PAD 2025

ID: TSK-0062. Apertura 2026-10-05. Stato: completato.

## Contratto

Un solo contest: 295, 5 entry. Censimento first_post_only dei post introduttivi originali degli autori, WIP o presentazioni nel thread quando ammesso. URL dichiarati e requisiti con fonte/data/esito; esclusi host esterni, file/download, risposte successive, roster e classifiche. Skill base BGG e bgg-material-census obbligatorie. Evidenze e importazione riproducibile provata su copia; database operativo e file condivisi gestiti dal coordinamento TSK-0059. Nessun commit autonomo. Successo: tutte le entry con esito esplicito, storia preservata, isolamento e idempotenza verificati.

## Incremento 2026-10-05

Preflight sandbox riuscito; main ahead 1 con modifiche parallele preesistenti. PWS canonico e aligned_version 1.5.0, consultati metodologia, PROJECT.md, AGENTS.md, TASK_GOVERNANCE.md e inventario. Applicate skill bgg-contest-navigation, bgg-material-census e playbook. Titolo visibile impostato conforme. Browser neutro inizializzato prima della navigazione BGG.

Input: catalog/2025-24h-challenge-rosters-2026-10-04.json e baseline operativa aperta mode=ro. Roster autorevole articolo 46335246 riconciliato 5/5. Regole articolo 46335243: WIP facoltativo, presentazioni nel thread ammesse. Cinque presentazioni originali collegate dal roster lette integralmente; identità/autore/data e link verificati mediante DOM renderizzato CUA. Le risposte incidentalmente renderizzate dalla pagina non alimentano il censimento; estrazione limitata agli articoli originali. Nessun host esterno o file aperto, nessun download.

Risultati: 5/5 complete nel perimetro first_post_only; 4 entry con 5 URL unici; 15 requisiti su 4 entry. Pad Your Stats: URL none_declared, regole nel post e mazzo tradizionale esplicito. CareFlight: risorsa dichiarata, requisiti none_declared; nessuna inferenza da roll n write. Nessuna fonte non osservabile o WIP non individuato. Cycle Of The Lotus: carte e plance incluse nello stesso mazzo; tre mazzi per due giocatori, wild e guida sempre richiesti; URL annidati nel regolamento non osservati. Lunch Pad: segnalino primo giocatore opzionale, immagine illustrativa esclusa. ALT: ulteriori componenti dichiarati genericamente, senza inventario dedotto.

Deliverable dedicati: catalog/build_2025_pad_materials.py, catalog/2025-pad-materials.sql, sources/2025-PAD-MATERIALS.md; nel task EVIDENCE.json, DOM_WITNESS.json, ROSTER_BASELINE.json, VERIFICATION.json e questo TASK.md. Copia privata rigenerabile outputs/2025-pad-materials/verification.sqlite3 (esclusa da Git).

Verifiche: conteggi e roster 5/5; autore/date/URL DOM 5/5; SQLite integrity_check e foreign_key_check validi; righe precedenti preservate per ID; nuove righe limitate alle cinque entry e giochi PAD, solo wip_thread_url aggiornabile quando nullo. Tutte le altre tabelle e contest, classifiche e acquisizioni inalterati sulla copia. Seconda applicazione SQL identica. Script non offre --apply e apre la fonte soltanto mode=ro; nessuna scrittura operativa effettuata. Hash SQL e risultato in VERIFICATION.json.

## Comandi per il coordinatore

Rigenerazione SQL/evidenze e prova privata (nessuna importazione operativa):

```powershell
& 'C:\Users\39348\.cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe' catalog/build_2025_pad_materials.py
```

Integrazione seriale, soltanto dal coordinatore dopo backup:

```powershell
@'
import sqlite3
from pathlib import Path
p=Path('database/pnp_collection.sqlite3')
backup=Path('outputs/2025-pad-materials/before-coordinator-import.sqlite3')
assert not backup.exists(), 'Preservare il backup precedente'
with sqlite3.connect(p.resolve().as_uri()+'?mode=ro',uri=True) as src, sqlite3.connect(backup) as dst:
    src.backup(dst)
with sqlite3.connect(p) as db:
    db.executescript(Path('catalog/2025-pad-materials.sql').read_text(encoding='utf8'))
    assert db.execute('pragma integrity_check').fetchall()==[('ok',)]
    assert not db.execute('pragma foreign_key_check').fetchall()
'@ | & 'C:\Users\39348\.cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe' -
```

Il coordinatore aggiorna REGISTRY, catalog/README e PROJECT_PROGRESS (A/B dal generatore) e registra la chiusura dopo integrazione. Commit finale a suo carico; nessuno staging/commit/push da questa chat. Salvato locale da_committare, integrazione da_integrare.

Limiti: dichiarazioni del primo post, disponibilità e condizioni esterne non verificate; tassonomia provvisoria. Nessun nuovo pattern promosso nei file condivisi. Prossimo passo utile eventuale ACQ del solo PAD dopo selezione e verifica condizioni/host, senza controllo ordinario del contest concluso.

## Chiusura dopo integrazione — 2026-10-05

Stato: completato. TSK-0059 ha integrato il SQL dopo prova su copia e backup con SHA-256; integrità/FK, conservazione della storia, isolamento e idempotenza verificate. Funzioni API verificate per 5/5 entry. Registro e A/B del cruscotto aggiornati prima della chiusura. Evidenza: TSK-0059/PAD_INTEGRATION.json. Commit finale autorizzato e in preparazione; nessun push.
