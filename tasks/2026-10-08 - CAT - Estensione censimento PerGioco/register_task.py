"""Registra il contratto CAT locale; nessuna rete o scrittura SQLite."""
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
p = ROOT / 'tasks/REGISTRY.json'
r = json.loads(p.read_text(encoding='utf-8'))
assert not any(t['id'] == 'TSK-0080' for t in r['tasks'])
r['tasks'].append(dict(
    id='TSK-0080', original_title='2026-10-08 - CAT - Estensione censimento PerGioco',
    display_title='2026-10-08 - CAT - Estensione censimento PerGioco', opened_at='2026-10-08',
    task_path='tasks/2026-10-08 - CAT - Estensione censimento PerGioco/TASK.md',
    category='CAT', secondary_categories=[], classified_at='2026-10-08',
    mode='circoscritto', cadence='su_richiesta', status='in_corso',
    status_basis='Lotto nove candidate confermato esplicitamente; contratto registrato prima della raccolta.',
    dependencies=['TSK-0073'], related_tasks=['TSK-0074','TSK-0076','TSK-0078','TSK-0079'],
    successors=[], chat_ids=['01a11d49-b108-7742-a74a-a2353e76da26'],
    coverage=dict(candidates=9,censused=0,full_site=False,pilot_recensused=0,imported=0,downloaded=0),
    next_action='Censire le nove voci residue Carta e matita confermate.',
    git=dict(checked_at='2026-10-08',local_save='da_committare',integration='integrato_main',synchronization='da_verificare'),
    last_verified_at='2026-10-08'))
r['updated_at']='2026-10-08'
p.write_text(json.dumps(r,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
q=ROOT/'PROJECT_PROGRESS.md'
s=q.read_text(encoding='utf-8')
q.write_text(s+'\n- 2026-10-08 — TSK-0080 CAT Estensione PerGioco aperto: lotto confermato nove voci residue Carta e matita, Chomp già coperto dal pilota escluso. Raccolta 0/9, sito intero non attestato; nessuna importazione/schema/app/MAT/ACQ/IMG/automazione/Git. TSK-0073/0074/0078/0079 restano conclusi. PWS 1.5.0; sezioni annuali A/B invariate. Prossimo passo raccolta CAT autorizzata.\n',encoding='utf-8')
print('TSK-0080 registrato')
