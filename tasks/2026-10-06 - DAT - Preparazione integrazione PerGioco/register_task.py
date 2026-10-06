"""Register authorized DAT preparation; preserves predecessor completion."""
import copy
import json
from pathlib import Path

root = Path(__file__).resolve().parents[2]
path = root / 'tasks/REGISTRY.json'
r = json.loads(path.read_text(encoding='utf-8'))
previous = next(t for t in r['tasks'] if t['id'] == 'TSK-0074')
if not any(t['id'] == 'TSK-0075' for t in r['tasks']):
    assert max(int(t['id'].split('-')[1]) for t in r['tasks']) == 74
    t = copy.deepcopy(previous)
    title = '2026-10-06 - DAT - Preparazione integrazione PerGioco'
    t.update(id='TSK-0075', original_title=title, display_title=title,
             task_path=f'tasks/{title}/TASK.md', category='DAT',
             status='completato',
             status_basis='2026-10-06: proposta, mapping, alternative EPR e anteprima offline 12/12 verificati; database invariato. Nessuna importazione o architettura adottata.',
             dependencies=['TSK-0074', 'TSK-0073'], successors=[],
             chat_ids=['01a112e4-6a22-75b2-8a7f-ed6e6f11bdd3'],
             coverage={'preview_candidates':12,'CAT_admitted':9,'CAT_requirement_not_demonstrated':3,'proposed_new_games':8,'candidate_links':1,'imported_identities':0,'architecture_adopted':False},
             next_action='Deliberare alternativa A/B e piano identità; eventuale EPR/importazione DAT e APP in passi autonomi.')
    t['events'] = [{'date':'2026-10-06','status':'in_corso','evidence':'Contratto TASK.md predisposto prima della costruzione anteprima.'}, {'date':'2026-10-06','status':'completato','evidence':'VERIFICHE.json e PROPOSTA.md; preparazione conclusa, decisioni esecutive pendenti.'}]
    r['tasks'].append(t)
if 'TSK-0075' not in previous['successors']:
    previous['successors'].append('TSK-0075')
previous['next_action'] = 'Successore DAT preparatorio TSK-0075 completato; decidere architettura/piano identità prima di task esecutivi separati.'
assert previous['status'] == 'completato'
r['updated_at'] = '2026-10-06'
path.write_text(json.dumps(r, ensure_ascii=False, indent=2)+'\n', encoding='utf-8')
progress = root / 'PROJECT_PROGRESS.md'
note = '\n- 2026-10-06 — TSK-0075 DAT preparazione PerGioco completato: proposta/mapping e anteprima offline delle 12 candidate, 9 ammissibili CAT e 3 source-only; otto nuove identità proposte e Abande 993 solo candidato. Itinera un sistema/due istanze. Modello corrente verificato in sola lettura, hash DB invariato; alternative A (metadati strutturati) / B (estensione additiva EPR) da deliberare. Nessuna importazione/schema/app/acquisizione o adozione architetturale; TSK-0074 resta completato e collegato. A/B annuali non rigenerate perché dati invariati; incremento da committare, prossimo passo decisione prima di esecuzione DAT separata.\n'
content = progress.read_text(encoding='utf-8')
if 'TSK-0075 DAT preparazione PerGioco completato' not in content:
    progress.write_text(content+note, encoding='utf-8')
