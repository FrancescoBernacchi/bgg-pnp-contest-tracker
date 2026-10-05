"""Stage only this authorized increment, preserving pre-existing working tree changes."""
import json
import subprocess
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
TASK = Path(__file__).resolve().parent
GIT = r'C:\Users\39348\.cache\codex-runtimes\codex-primary-runtime\dependencies\native\git\cmd\git.exe'
IDS = {f'TSK-{number:04}' for number in range(59, 65)}

def git(*args, data=None):
    return subprocess.check_output([GIT, *args], cwd=ROOT, input=data)

def stage_text(path, content):
    blob = git('hash-object', '-w', '--stdin', data=content.encode('utf8')).decode().strip()
    git('update-index', '--add', '--cacheinfo', f'100644,{blob},{path}')

def main():
    assert not git('diff', '--cached', '--name-only').strip(), 'Preserve existing staging; review first'
    current = json.loads((ROOT / 'tasks/REGISTRY.json').read_text(encoding='utf-8-sig'))
    head = json.loads(git('show', 'HEAD:tasks/REGISTRY.json').decode('utf-8-sig'))
    new = [t for t in current['tasks'] if t['id'] in IDS]
    assert len(new) == 6 and all(t['status'] == 'completato' for t in new)
    assert not IDS.intersection(t['id'] for t in head['tasks'])
    head['tasks'].extend(new)
    head['updated_at'] = '2026-10-05'
    stage_text('tasks/REGISTRY.json', json.dumps(head, ensure_ascii=False, indent=2) + '\n')
    baseline = (ROOT / 'outputs/24h-2025-coordination/PROJECT_PROGRESS.md').read_text(encoding='utf-8-sig')
    current_progress = (ROOT / 'PROJECT_PROGRESS.md').read_text(encoding='utf-8-sig')
    notes = [line for line in current_progress.splitlines() if line.startswith('- 2026-10-05')
             and any(task_id in line for task_id in IDS) and line not in baseline.splitlines()]
    assert len(notes) == 7, len(notes)
    progress_head = git('show', 'HEAD:PROJECT_PROGRESS.md').decode('utf8')
    stage_text('PROJECT_PROGRESS.md', progress_head.rstrip() + '\n\n' + '\n\n'.join(notes) + '\n')
    catalog_head = git('show', 'HEAD:catalog/README.md').decode('utf8')
    catalog_current = (ROOT / 'catalog/README.md').read_text(encoding='utf-8-sig')
    notes = [line for line in catalog_current.splitlines() if line.startswith('- 2026-10-05 — TSK-0059:')]
    assert len(notes) == 1
    stage_text('catalog/README.md', catalog_head.rstrip() + '\n\n' + notes[0] + '\n')
    paths = [TASK.relative_to(ROOT).as_posix(), 'catalog/integrate_2025_24h_materials.py']
    for theme in ['reveal', 'green', 'pad', 'patch', 'anks']:
        paths.extend([f'catalog/build_2025_{theme}_materials.py', f'catalog/2025-{theme}-materials.sql',
                      f'sources/2025-{theme.upper()}-MATERIALS.md',
                      f'tasks/2026-10-05 - MAT - 24 Hour Design Challenge {theme.upper()} 2025'])
    git('add', '--', *paths)
    staged = git('diff', '--cached', '--name-only').decode('utf8').splitlines()
    assert all(not p.startswith(('library/', 'database/', 'outputs/')) for p in staged)
    assert all(p in ['tasks/REGISTRY.json', 'PROJECT_PROGRESS.md', 'catalog/README.md']
               or any(p == allowed or p.startswith(allowed + '/') for allowed in paths) for p in staged)
    git('diff', '--cached', '--check')
    print(json.dumps({'files': staged, 'shared_files_staged_from_head': True,
                      'preexisting_generated_progress_left_unstaged': True}, ensure_ascii=False, indent=2))

if __name__ == '__main__':
    main()
