"""Verifica documentale locale TSK-0065; non collauda acquisizione/estrazione."""
import hashlib
import json
import re
import subprocess
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
TASK = Path(__file__).resolve().parent
SKILL = ROOT / '.agents/skills/game-image-acquisition'


def main():
    checks = []
    def check(label, condition):
        checks.append({'check': label, 'passed': bool(condition)})
        if not condition:
            raise AssertionError(label)

    content = (SKILL / 'SKILL.md').read_text(encoding='utf-8')
    match = re.match(r'^---\n(.*?)\n---\n', content, re.S)
    check('Frontmatter delimitato', match is not None)
    # This skill uses only two plain scalar fields; this is not a general YAML parser.
    fields = dict(line.split(': ', 1) for line in match[1].splitlines())
    check('Campi scalar frontmatter name/description', set(fields) == {'name', 'description'})
    check('Nome coincide con directory e convenzione', fields['name'] == SKILL.name and bool(re.fullmatch(r'[a-z0-9-]{1,64}', fields['name'])))
    check('Descrizione breve non vuota', 0 < len(fields['description']) <= 1024)
    check('Nessun placeholder scaffold', '[TODO:' not in content)
    links = re.findall(r'\]\((references/[^)]+)\)', content)
    check('Tre riferimenti scoperti', set(links) == {'references/sources.md', 'references/extraction.md', 'references/ai.md'})
    for link in links:
        check('Riferimento esistente ' + link, (SKILL / link).is_file())
    workflow = ROOT / 'sources/IMAGE_WORKFLOW.md'
    codes = ROOT / 'sources/IMAGE_CONTEST_CODES.md'
    check('Documenti autorevoli presenti', workflow.is_file() and codes.is_file())
    reg = json.loads((ROOT / 'tasks/REGISTRY.json').read_text(encoding='utf-8-sig'))
    ids = [entry['id'] for entry in reg['tasks']]
    check('ID registro univoci', len(ids) == len(set(ids)))
    entry = next(entry for entry in reg['tasks'] if entry['id'] == 'TSK-0065')
    check('Task registro presente', (ROOT / entry['task_path']).is_file())
    git = 'C:/Users/39348/.cache/codex-runtimes/codex-primary-runtime/dependencies/native/git/cmd/git.exe'
    ignored = subprocess.run([git, 'check-ignore', 'library/immagini/G000123__Esempio/originali/esempio.png'], cwd=ROOT, capture_output=True, text=True)
    check('Binari libreria immagini esclusi da Git', ignored.returncode == 0)
    whitespace = subprocess.run([git, 'diff', '--check', '--', 'PROJECT.md', 'AGENTS.md', 'TASK_GOVERNANCE.md', '.workspace/PROJECT_STATE.md', 'sources/SKILL_INVENTORY.md', 'library/README.md', 'app/README.md', '.agents/skills/bgg-contest-navigation/SKILL.md'], cwd=ROOT, capture_output=True, text=True)
    check('Diff documenti senza errori whitespace', whitespace.returncode == 0)
    artifacts = [SKILL / 'SKILL.md', *(SKILL / 'references').glob('*.md'), workflow, codes]
    result = {
        'date': '2026-10-05', 'task_id': 'TSK-0065',
        'scope': 'verifica documentale locale; nessun rilevamento esterno o lotto immagini',
        'checks': checks,
        'standard_validator': 'quick_validate.py non eseguibile: ModuleNotFoundError yaml; controllo locale dei soli campi scalar utilizzati, non parser YAML generale',
        'artifacts': [{'path': p.relative_to(ROOT).as_posix(), 'sha256': hashlib.sha256(p.read_bytes()).hexdigest()} for p in artifacts],
        'limitations': ['download/estrazione/deduplicazione visiva/AI non collaudati', 'nessuna implementazione dati/API/app', 'sigle contest operative da assegnare nel primo lotto']
    }
    (TASK / 'VERIFICATION.json').write_text(json.dumps(result, indent=2, ensure_ascii=False) + '\n', encoding='utf-8')
    print(f'{len(checks)} controlli documentali riusciti; limiti in VERIFICATION.json')


if __name__ == '__main__':
    main()
