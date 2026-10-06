"""Audit statico offline delle skill: non esegue workflow né modifica dati."""
import hashlib
import json
import re
from pathlib import Path
from urllib.parse import unquote

ROOT = Path(__file__).resolve().parents[2]
TASK = Path(__file__).resolve().parent
skills = sorted((ROOT / '.agents/skills').glob('*/SKILL.md'))
errors = []
checked_links = 0
results = []
for path in skills:
    text = path.read_text(encoding='utf-8-sig')
    match = re.match(r'^---\n(.*?)\n---\n', text, re.S)
    fields = {}
    if not match:
        errors.append(f'{path.name}: frontmatter assente')
    else:
        # Tutti i frontmatter locali usano soltanto scalari YAML semplici.
        for line in match[1].splitlines():
            key, sep, value = line.partition(': ')
            if not sep or ': ' in value or value.startswith(('[', '{', '&', '*', '!', '|', '>')):
                errors.append(f'{path.parent.name}: scalare non semplice; serve parser YAML')
            fields[key] = value
        if set(fields) != {'name', 'description'}:
            errors.append(f'{path.parent.name}: campi inattesi')
        if fields.get('name') != path.parent.name or not re.fullmatch(r'[a-z0-9]+(?:-[a-z0-9]+)*', fields.get('name', '')):
            errors.append(f'{path.parent.name}: nome incoerente')
        if len(fields.get('name', '')) > 64 or not 1 <= len(fields.get('description', '')) <= 1024:
            errors.append(f'{path.parent.name}: lunghezza invalida')
        if '<' in fields.get('description', '') or '>' in fields.get('description', ''):
            errors.append(f'{path.parent.name}: description invalida')
    for doc in [path, *sorted((path.parent / 'references').glob('*.md'))]:
        body = doc.read_text(encoding='utf-8-sig')
        if '[TODO:' in body:
            errors.append(f'{doc}: scaffold residuo')
        for link in re.findall(r'\[[^\]]+\]\(([^)]+)\)', body):
            if '://' in link or link.startswith('#'):
                continue
            checked_links += 1
            target = doc.parent / unquote(link.split('#')[0])
            if not target.exists():
                errors.append(f'{doc}: riferimento mancante {link}')
    results.append({'name': path.parent.name, 'sha256': hashlib.sha256(path.read_bytes()).hexdigest()})
for doc in [ROOT/'sources/SKILL_INVENTORY.md', TASK/'AUDIT.md']:
    for link in re.findall(r'\[[^\]]+\]\(([^)]+)\)', doc.read_text(encoding='utf-8')):
        if '://' not in link:
            checked_links += 1
            if not (doc.parent/unquote(link.split('#')[0])).exists():
                errors.append(f'{doc}: riferimento mancante {link}')
registry = json.loads((ROOT/'tasks/REGISTRY.json').read_text(encoding='utf-8-sig'))
assert len({t['id'] for t in registry['tasks']}) == len(registry['tasks'])
record = next(t for t in registry['tasks'] if t['id'] == 'TSK-0048')
assert record['status'] == 'in_corso' and record['mode'] == 'continuativo' and record['cadence'] == 'su_richiesta'
assert (ROOT/record['task_path']).exists()
report = {'verified_at': '2026-10-04', 'kind': 'offline_static', 'skills': results,
          'checked_links': checked_links, 'errors': errors,
          'official_validator': 'non eseguibile: PyYAML assente; verifica equivalente dei frontmatter semplici, non parser YAML generale'}
(TASK/'LOCAL_VERIFICATION.json').write_text(json.dumps(report, ensure_ascii=False, indent=2)+'\n', encoding='utf-8')
print(json.dumps({'skills': len(skills), 'checked_links': checked_links, 'errors': errors}, ensure_ascii=False))
raise SystemExit(bool(errors))
