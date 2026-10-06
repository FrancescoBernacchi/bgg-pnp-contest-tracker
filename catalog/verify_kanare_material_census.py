"""Verify MAT coverage, attribution, immutable originals and read-only database preservation."""
import hashlib
import importlib.util
import json
import sqlite3
from pathlib import Path

ROOT=Path(__file__).resolve().parents[1]
TASK=ROOT/'tasks/2026-10-06 - MAT - Kanare Abstract'
def sha(path):return hashlib.sha256(path.read_bytes()).hexdigest()

def main():
    m=json.loads((ROOT/'catalog/kanare_material_census_2026-10-06.json').read_text(encoding='utf8'))
    b=json.loads((ROOT/'outputs/kanare-mat-2026-10-06/BASELINE.json').read_text(encoding='utf8'))
    game_ids={g['id'] for g in b['games']};resource_ids={r['id'] for r in b['resources']}
    assert len(m['games'])==len(game_ids)==64
    assert {g['game_id'] for g in m['games']}==game_ids and 907 not in game_ids
    assert {r['id'] for r in m['resources']}==resource_ids and len(m['resources'])==141
    assert len(m['products'])==39 and len({p['product_id'] for p in m['products']})==39
    consultations={x['url']:x for x in m['consultations']}
    for g in m['games']:
        assert g['verified_at']=='2026-10-06' and g['official_pages'] and g['credits']
        assert set(g['resource_ids'])<=resource_ids
        if g['analysis_status']!='blocked':
            evidence=g['rule_evidence']; assert evidence['locator']
            assert consultations[evidence['url']]['status']=='read'
            assert consultations[evidence['url']]['language']=='en'
            assert g['reviewed_rule_resource_id'] in g['resource_ids']
    assert len(m['consultations'])==len(consultations) # no duplicate observations
    assert not any(x['kind']=='pdf' and x['status']=='read' and x['language']!='en' for x in m['consultations'])
    assert m['counts']['analysis']=={'complete':62,'partial':1,'blocked':1}
    assert {g['title'] for g in m['games'] if g['analysis_status']!='complete'}=={'Candy Chain','Swarm'}
    for title in ['Bloody Queen','Stacking Morris','Custodial Pah-Tum','Tori Shogi＋']:
        g=next(g for g in m['games'] if g['title']==title)
        assert len(g['resource_ids'])==1 and any('puntuale' in n for n in g['limits'])
    acquired=json.loads((ROOT/'catalog/kanare_abstract_acquisition_batch_2026-09-21.json').read_text(encoding='utf8'))
    hashes=[]
    for f in acquired['items']:
        path=ROOT/'library'/f['relative_path'];assert sha(path)==f['sha256']
        hashes.append({'game':f['game_title'],'sha256':f['sha256'],'unchanged':True})
    conn=sqlite3.connect(f'file:{ROOT / "database/pnp_collection.sqlite3"}?mode=ro',uri=True);conn.row_factory=sqlite3.Row
    for field,sql in [('source_records','SELECT * FROM source_records WHERE source_id=1'),('products','SELECT * FROM products'),('product_games','SELECT * FROM product_games'),('product_source_records','SELECT * FROM product_source_records'),('resources','SELECT * FROM catalog_resources'),('resource_links','SELECT * FROM resource_links')]:
        current=[dict(x) for x in conn.execute(sql)]
        canonical=lambda rows:sorted(json.dumps(r,sort_keys=True,ensure_ascii=False) for r in rows)
        assert canonical(current)==canonical(b[field]),field
    assert conn.execute('PRAGMA integrity_check').fetchone()[0]=='ok'
    assert not conn.execute('PRAGMA foreign_key_check').fetchall()
    conn.close()
    manifest=ROOT/'catalog/kanare_material_census_2026-10-06.json';inventory=TASK/'INVENTORY.md'
    before=(sha(manifest),sha(inventory))
    spec=importlib.util.spec_from_file_location('kanare_builder',ROOT/'catalog/build_kanare_material_census.py');builder=importlib.util.module_from_spec(spec);spec.loader.exec_module(builder);builder.main()
    assert before==(sha(manifest),sha(inventory))
    report={'verified_at':'2026-10-06','coverage':m['counts'],'duplicate_games':0,'duplicate_consultations':0,
      'baseline_tables_preserved':True,'sqlite_integrity':'ok','foreign_key_violations':0,
      'originals':hashes,'offline_rebuild_idempotent':True,'manifest_sha256':sha(manifest),
      'limits':'Verifica di integrità/copertura e riesame delle evidenze; non certificazione di licenze o completezza universale dei dati non dichiarati. Nessuna scrittura DB.'}
    (TASK/'VERIFICATION.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n',encoding='utf8')
    print('Coverage, attribution, original hashes, baseline preservation, integrity and offline rebuild: OK')

if __name__=='__main__':main()
