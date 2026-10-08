"""Prepara patch selettiva/audit in outputs; non modifica Git o working tree."""
import difflib
import importlib.util
import json
import subprocess
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
TASK=Path(__file__).resolve().parent
OUT=ROOT/'outputs/tsk0080-git'
OUT.mkdir(parents=True,exist_ok=True)
def git(*args): return subprocess.check_output(['git',*args],cwd=ROOT)
staged=git('diff','--cached','--name-only').decode().splitlines()
assert all(p.startswith('tasks/2026-10-08 - CAT - Estensione censimento PerGioco/') or p=='catalog/pergioco_extension_carta_matita_2026-10-08.json' for p in staged), 'Index contiene file inattesi'
old_registry=git('show','HEAD:tasks/REGISTRY.json').decode('utf-8')
old=json.loads(old_registry)
current=json.loads((ROOT/'tasks/REGISTRY.json').read_text(encoding='utf-8'))
assert not any(t['id']=='TSK-0080' for t in old['tasks'])
old['tasks'].append(next(t for t in current['tasks'] if t['id']=='TSK-0080'))
old['updated_at']='2026-10-08'
new_registry=json.dumps(old,ensure_ascii=False,indent=2)+'\n'
old_progress=git('show','HEAD:PROJECT_PROGRESS.md').decode('utf-8')
lines=[l for l in (ROOT/'PROJECT_PROGRESS.md').read_text(encoding='utf-8').splitlines() if l.startswith('- 2026-10-08 — TSK-0080 ')]
assert len(lines)==2
new_progress=old_progress.rstrip()+'\n\n'+'\n\n'.join(lines)+'\n'
(OUT/'registry.selected.json').write_text(new_registry,encoding='utf-8')
(OUT/'progress.selected.md').write_text(new_progress,encoding='utf-8')
patch=''
for path,before,after in [('tasks/REGISTRY.json',old_registry,new_registry),('PROJECT_PROGRESS.md',old_progress,new_progress)]:
    patch+=''.join(difflib.unified_diff(before.splitlines(True),after.splitlines(True),fromfile='a/'+path,tofile='b/'+path))
(OUT/'shared.patch').write_text(patch,encoding='utf-8')
spec=importlib.util.spec_from_file_location('audit',ROOT/'catalog/audit_publication.py')
audit=importlib.util.module_from_spec(spec);spec.loader.exec_module(audit)
findings=[]
blobs={'tasks/REGISTRY.json':new_registry.encode(),'PROJECT_PROGRESS.md':new_progress.encode()}
paths=[ROOT/'catalog/pergioco_extension_carta_matita_2026-10-08.json']+[p for p in TASK.iterdir() if p.is_file() and p.suffix in ('.py','.md','.json')]
for p in paths: blobs[p.relative_to(ROOT).as_posix()]=p.read_bytes()
for path,data in blobs.items(): findings+=audit.inspect(path,data,'prospective_commit',False)
commits=git('rev-list','origin/main..HEAD').decode().splitlines()
for commit in commits:
    for path in filter(None,git('diff-tree','--no-commit-id','--name-only','-r','-z',commit).decode().split('\0')):
        try:data=git('show',commit+':'+path)
        except subprocess.CalledProcessError:continue
        findings+=audit.inspect(path,data,commit,True)
report=dict(task_id='TSK-0080',checked_at='2026-10-08',prospective_paths=list(blobs),outgoing_commits=commits,findings=findings,ready=not findings,scope='Solo CAT e sue due note cruscotto/voce registro; altri delta condivisi esclusi.',manual_review='Metadati/sintesi originali, nessun materiale o contenuto integrale terzo; baseline contiene soltanto percorsi/hash.',limits='Audit euristico, non certificazione diritti; nessuna verifica remota implicita.')
(OUT/'PUBLICATION.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
assert not findings, findings
print(json.dumps(dict(paths=list(blobs),outgoing_commits=commits,findings=len(findings)),ensure_ascii=False))
