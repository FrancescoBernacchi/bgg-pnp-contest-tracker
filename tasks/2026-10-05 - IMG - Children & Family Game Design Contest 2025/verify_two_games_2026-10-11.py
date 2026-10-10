from pathlib import Path
import json, hashlib
from PIL import Image

ROOT = Path(__file__).resolve().parents[2]
manifest = ROOT / 'catalog/2025_children_family_images_2026-10-11.json'
data = json.loads(manifest.read_text(encoding='utf-8'))
files = data['images'] + data['historical_files']
assert len({(i['image_id'], i['version']) for i in files}) == len(files)
assert len({i['image_id'] for i in data['images']}) == len(data['images'])
components = {c['component_id'] for c in data['components']}
ids = {i['image_id'] for i in files}
for item in files:
    path = ROOT / item['relative_path']
    assert path.stat().st_size == item['bytes'], path
    assert hashlib.sha256(path.read_bytes()).hexdigest() == item['sha256'], path
    with Image.open(path) as picture:
        assert picture.size == (item['width'], item['height']), path
        assert picture.format == item['format'], path
        picture.verify()
    assert item['game_id'] == item['entry_id']
    assert item['game_id'] in data['scope']['authorized_game_ids']
    assert set(item['component_ids']) <= components
    for relation in item['relationships']:
        if 'target_image_id' in relation:
            assert relation['target_image_id'] in ids
for game in data['games']:
    if game['game_id'] not in (498, 500):
        continue
    selected = [i for i in files if i['game_id'] == game['game_id']]
    folder = (ROOT / selected[0]['relative_path']).parents[1]
    assert {p for p in folder.rglob('*') if p.is_file()} == {ROOT / i['relative_path'] for i in selected}
    for category in game['categories']:
        assert category['adopted_original_count'] == sum(i['game_id'] == game['game_id'] and (i['category'] == category['category'] or category['category'] in i['additional_categories']) for i in data['images'])
old = json.loads((ROOT / 'catalog/2025_children_family_images_2026-10-05.json').read_text(encoding='utf-8'))
for item in old['images']:
    assert item == next(i for i in data['images'] if i['image_id'] == item['image_id'])
print(json.dumps({'current': len(data['images']), 'historical': len(data['historical_files']), 'files_verified': len(files), 'components': len(components), 'manifest_sha256': hashlib.sha256(manifest.read_bytes()).hexdigest(), 'new_games': {str(g): {'current': sum(i['game_id']==g for i in data['images']), 'historical':sum(i['game_id']==g for i in data['historical_files'])} for g in (500,498)}, 'mode':'read-only'}))
