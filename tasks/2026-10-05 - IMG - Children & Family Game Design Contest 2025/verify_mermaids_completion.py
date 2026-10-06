"""Verifica file, identità, relazioni e copertura dell'incremento pilota."""
import hashlib
import json
from pathlib import Path
from PIL import Image

ROOT=Path(__file__).resolve().parents[2]
mp=ROOT/'catalog/2025_children_family_images_2026-10-05.json'
m=json.loads(mp.read_text(encoding='utf-8'))
docs=json.loads((ROOT/m['source_manifest']).read_text(encoding='utf-8'))['documents']
for d in docs:
    p=ROOT/'library'/d['relative_path']
    assert p.stat().st_size==d['byte_size']
    assert hashlib.sha256(p.read_bytes()).hexdigest()==d['sha256']
images=m['images']; historical=m.get('historical_files',[])
ids={i['image_id'] for i in images}; assert len(ids)==len(images)==17
for i in images+historical:
    p=ROOT/i['relative_path']; assert p.stat().st_size==i['bytes']
    assert hashlib.sha256(p.read_bytes()).hexdigest()==i['sha256']
    with Image.open(p) as im:
        assert im.size==(i['width'],i['height']) and im.format==i['format']; im.verify()
    assert i['game_id']==i['entry_id']==505 and i['contest_id']==14
    for r in i.get('relationships',[]):
        if 'target_image_id' in r: assert r['target_image_id'] in ids
components={c['component_id']:c for c in m['components']}
assert len(components)==10
for c in components.values():
    for k in ['front_image_id','back_image_id']:
        if k in c: assert c[k] in ids
for i in images:
    assert all(c in components for c in i.get('component_ids',[]))
lib=set((ROOT/'library/immagini/505__Mermaids-vs-Dinosaurs').rglob('*.png'))
assert lib=={ROOT/i['relative_path'] for i in images+historical}
game=next(g for g in m['games'] if g['game_id']==505)
assert len(game['categories'])==11
for c in game['categories']:
    count=sum(c['category']==i['category'] or c['category'] in i.get('additional_categories',[]) for i in images)
    assert count==c['adopted_original_count']
    assert c['verified_absence']==(count==0)
board=next(i for i in images if i['image_id']=='IMG-505-0015')
board['validation']='Originale estratta: controllo visivo completo superato 2026-10-05; tre spazi carte inclusi'
game['external_research']['live_rulebook']='Documento collegato aperto; interfaccia canvas senza contenuti/immagini esposti al DOM. Nessuna nuova esportazione ACQ. Verifica visuale integrale basata sulle 3 pagine PDF già acquisite, non attestata identità della revisione live.'
game['residuals'].append('Revisione live Google Docs non confrontata integralmente: nessuna nuova esportazione di manuali nel contratto IMG')
m['verification']=dict(checked_at='2026-10-05',pdf_hashes_verified=38,current_image_files_verified=17,historical_image_files_verified=1,component_relationships_verified=10,category_coverage_verified=11,originals_unchanged=True,game_research_completed=1,authorized_games=14)
mp.write_text(json.dumps(m,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
regp=ROOT/'tasks/REGISTRY.json'; reg=json.loads(regp.read_text(encoding='utf-8'))
t=next(t for t in reg['tasks'] if t['id']=='TSK-0068')
t['status_basis']='Pilota Mermaids vs Dinosaurs concluso nel perimetro osservabile, con limiti login/live dichiarati; altri 13 giochi ancora aperti'
t['coverage'].update(research_complete=1,library_images_total=17,downloaded_originals=6,historical_files=1,physical_library_files=18,pilot_complete=True)
t['next_action']='Applicare il procedimento verificato agli altri 13 giochi autorizzati; TSK-0067 resta dipendente dal lotto completo'
regp.write_text(json.dumps(reg,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
print(json.dumps(m['verification']))
