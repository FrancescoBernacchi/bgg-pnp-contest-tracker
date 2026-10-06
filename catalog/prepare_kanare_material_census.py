"""Export the existing Kanare perimeter read-only; register this authorized MAT task."""
import json
import sqlite3
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
TASK = ROOT / 'tasks/2026-10-06 - MAT - Kanare Abstract'

def main():
    conn = sqlite3.connect(f'file:{ROOT / "database/pnp_collection.sqlite3"}?mode=ro', uri=True)
    conn.row_factory = sqlite3.Row
    def rows(sql, args=()):
        return [dict(r) for r in conn.execute(sql, args)]
    games = rows('''SELECT DISTINCT g.* FROM games g JOIN game_source_records gs ON gs.game_id=g.id
                    JOIN source_records s ON s.id=gs.source_record_id WHERE s.source_id=1 AND gs.match_status!='rejected' ORDER BY g.id''')
    baseline = {'observed_at': '2026-10-06', 'games': games,
                'source_records': rows('SELECT * FROM source_records WHERE source_id=1'),
                'game_source_records': rows('SELECT gs.* FROM game_source_records gs JOIN source_records s ON s.id=gs.source_record_id WHERE s.source_id=1'),
                'products': rows('SELECT * FROM products'), 'product_games': rows('SELECT * FROM product_games'),
                'product_source_records':rows('SELECT * FROM product_source_records'),
                'resources': rows('SELECT * FROM catalog_resources'), 'resource_links': rows('SELECT * FROM resource_links'),
                'credits': rows('SELECT ca.*, p.* FROM credit_assertions ca JOIN people p ON p.id=ca.person_id')}
    TASK.mkdir(exist_ok=True)
    local = ROOT / 'outputs/kanare-mat-2026-10-06'
    local.mkdir(exist_ok=True)
    (local / 'BASELINE.json').write_text(json.dumps(baseline, ensure_ascii=False, indent=2)+'\n', encoding='utf-8')
    registry_path = ROOT / 'tasks/REGISTRY.json'
    reg = json.loads(registry_path.read_text(encoding='utf-8-sig'))
    if not any(t['id']=='TSK-0070' for t in reg['tasks']):
        reg['tasks'].append({'id':'TSK-0070', 'original_title':TASK.name, 'display_title':TASK.name,
          'opened_at':'2026-10-06', 'task_path':str((TASK/'TASK.md').relative_to(ROOT)).replace('\\','/'),
          'category':'MAT', 'secondary_categories':['GPR'], 'classified_at':'2026-10-06',
          'mode':'circoscritto', 'cadence':'su_richiesta', 'status':'in_corso',
          'status_basis':'Contratto esplicito utente, censimento singola fonte non-BGG con due piloti sequenziali.',
          'dependencies':['TSK-0019','TSK-0020','TSK-0021','TSK-0022','TSK-0023','TSK-0024','TSK-0048'],
          'successors':[], 'chat_ids':['01a1129f-6d87-7a83-b487-90746ab89813'],
          'coverage':{'baseline_games':len(games),'analyzed_games':0},
          'next_action':'Creare skill v1, poi piloti e censimento integrale.',
          'git':{'checked_at':'2026-10-06','local_save':'da_committare','integration':'integrato_main',
                 'synchronization':'da_verificare','evidence':'Working tree preesistente modificata; nessuna operazione Git mutativa.'}})
        reg['updated_at']='2026-10-06'
        registry_path.write_text(json.dumps(reg,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
    print(json.dumps({'games':len(games),'resources':len(baseline['resources']), 'titles':[g['canonical_title'] for g in games]}, ensure_ascii=False))

if __name__=='__main__': main()
