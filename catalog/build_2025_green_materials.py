"""TSK-0061: serialize BGG declarations; operational database is read-only.

Run with bundled Python. Generates SQL and verifies it twice on a private copy.
Does not offer automatic operational import; integration belongs to TSK-0059.
"""
import argparse
import hashlib
import json
import sqlite3
from pathlib import Path
from urllib.parse import urlsplit

import build_2025_54_card_materials as shared

ROOT = Path(__file__).resolve().parents[1]
TASK = ROOT / 'tasks/2026-10-05 - MAT - 24 Hour Design Challenge GREEN 2025'
DATE = '2026-10-05'
EVIDENCE = (TASK.relative_to(ROOT) / 'EVIDENCE.json').as_posix()
CONTEST = 297
ROLES = {
    1: [('rules', 'Rules'), ('reference', 'SellSheet'), ('component', 'Cards')],
    2: [('rules', "Here's the rules"), ('game_files', 'and the PnP')],
    3: [('game_files', 'Link to Files')],
    4: [('rules', 'Green Gold rules'), ('component', 'Green Gold cards')],
    5: [('rules', 'Rulebook:'), ('component', 'Card and Token Designs:'),
        ('game_files', 'PnP:'), ('video', 'Gameplay and Tutorial Video:')],
    6: [('game_files', 'Link to the site with PnP materials etc.')],
    7: [('rules', 'Here are the rules:'), ('component', 'Here are the cards:')],
    8: [('game_files', 'Fruit Tumbler')],
}
# Only explicit named declarations. Quantities are never inferred from mechanics.
# Fruit Tumbler's unlabelled file does not disclose any component inventory.
REQUIREMENTS = {
    1: [('rules', 'regolamento', 'Rules', 'unspecified'),
        ('printable_component', 'carte', 'Cards', 'unspecified')],
    2: [('rules', 'regolamento', "Here's the rules", 'unspecified'),
        ('printable_component', 'materiali PnP non specificati', 'and the PnP', 'printable')],
    3: [('rules', 'regolamento', 'changes in rules and cards', 'unspecified'),
        ('printable_component', 'carte pianta', 'the different plant cards', 'unspecified')],
    4: [('rules', 'regolamento', 'Green Gold rules', 'unspecified'),
        ('printable_component', 'carte', 'Green Gold cards', 'unspecified')],
    5: [('rules', 'regolamento', 'an official rulebook of the game', 'unspecified'),
        ('printable_component', 'carte', 'card and token designs', 'supplied_or_printable'),
        ('printable_component', 'segnalini', 'card and token designs', 'supplied_or_printable')],
    6: [('printable_component', 'materiali PnP non specificati', 'PnP materials etc.', 'printable')],
    7: [('rules', 'regolamento', 'Here are the rules:', 'unspecified'),
        ('printable_component', 'carte', 'Here are the cards:', 'unspecified')],
    8: [],
}
NOTES = {
    1: 'Regole, carte e sell sheet dichiarati; adattamento digitale ancora da finire, senza URL. Nessuna quantità esplicita.',
    2: 'Regole e cartella PnP dichiarate. Testo visualizzato con suffisso .0 dopo il link: nessuna versione inferita.',
    3: 'Post finale originale collegato dal roster, distinto dai precedenti annunci/progressi. Regole e carte pianta menzionate; nessun formato, istruzione di montaggio o quantità importati dai post precedenti.',
    4: 'Regole e carte dichiarate; nessun mazzo tradizionale o quantità inferiti dal precedente annuncio.',
    5: 'Regolamento, design carte/segnalini, PnP e video tutorial/gameplay. Il PnP non genera una seconda copia dei requisiti carte/segnalini; nessuna quantità dedotta.',
    6: 'Pagina dichiarata con materiali PnP; inventario e regole non specificati nel post.',
    7: 'Due link con etichetta identica [link], distinti per destinazione e contesto regole/carte. Estensione PDF osservata nella destinazione dichiarata; file non aperti.',
    8: 'File dichiarato con titolo del gioco; ruolo game_files provvisorio. Nessun componente o requisito sufficientemente esplicito nel post; none_declared non indica gioco privo di materiali.',
}


def compact(value):
    return json.dumps(value, ensure_ascii=False, separators=(',', ':'))


def fnv(value):
    h = 2166136261
    raw = value.encode('utf-16-le')
    for i in range(0, len(raw), 2):
        h = ((h ^ int.from_bytes(raw[i:i+2], 'little')) * 16777619) & 0xffffffff
    return f'{h:08x}'


def source(post):
    return f'https://boardgamegeek.com/thread/3510376/article/{post}#{post}'


def validate_witness(witness):
    rows = witness['entries']
    assert len(rows) == 8 and [r['position'] for r in rows] == list(range(1, 9))
    assert [r['post'] for r in rows] == witness['roster_posts']
    fingerprints = witness['live_dom_fingerprints']
    assert fnv(compact([[r['title'], source(r['post'])] for r in rows])) == fingerprints['roster_links_fnv']
    for i, r in enumerate(rows):
        assert fnv(r['body']) == fingerprints['body_fnv'][i], ('DOM body', i+1)
        assert fnv(compact([[x['url'], x['label']] for x in r['links']])) == fingerprints['url_label_fnv'][i], ('DOM links', i+1)
        header = r['author'] + ('\nDesigner' if r['position'] in (4, 8) else '') + '\n@' + r['username'] + '\n' + r['time']
        assert fnv(header) == fingerprints['header_fnv'][i], ('DOM identity', i+1)
        assert not r['media'] and not r['dynamic_links']
        assert all(x['url'].startswith('https://') for x in r['links'])
        for _, context in ROLES[r['position']]:
            assert context in r['body']
        for _, _, context, _ in REQUIREMENTS[r['position']]:
            assert context in r['body']
    roster = next(c for c in json.loads((ROOT/'catalog/2025-24h-challenge-rosters-2026-10-04.json').read_text(encoding='utf8'))['contests'] if c['contest_id'] == CONTEST)
    assert roster['source'] == witness['roster_source']
    assert [(r['position'], r['title'], r['author']) for r in rows] == [(r['position'], r['title'], r['author']) for r in roster['rows']]


def build(db, witness):
    db.row_factory = sqlite3.Row
    baseline = [dict(r) for r in db.execute('SELECT e.*,g.canonical_title FROM entries e JOIN games g ON g.id=e.game_id WHERE contest_id=? ORDER BY position', (CONTEST,))]
    assert len(baseline) == 8
    rows = []
    for b, w in zip(baseline, witness['entries']):
        assert b['position'] == w['position'] and b['canonical_title'] == w['title']
        assert b['entry_url'] == witness['roster_source']
        i = w['position']
        resources = []
        assert len(w['links']) == len(ROLES[i])
        for link, (role, context) in zip(w['links'], ROLES[i]):
            url = link['url']
            access = 'file' if urlsplit(url).path.lower().endswith('.pdf') else 'document' if ('1drv.ms' in url or 'canva.com' in url) else shared.access(url)
            resources.append(dict(url=url, label_raw=link['label'], content_role=role,
                                  context_raw=context, version_raw=None, host=urlsplit(url).netloc, access_type=access))
        requirements = [dict(material_kind=kind, name_normalized=name, name_raw=context, quantity_raw=None,
                             requirement_level='required', supply_mode=supply, context_raw=context)
                        for kind, name, context, supply in REQUIREMENTS[i]]
        rows.append(dict(entry_id=b['id'], game_id=b['game_id'], position=i, title=b['canonical_title'],
                         source_url=source(w['post']), wip_url=source(w['post']), author_raw=w['author'],
                         username_raw=w['username'], post_timestamp_raw=w['time'], checked_at=DATE,
                         wip_status='found', resource_listing_status='observed',
                         material_listing_status='observed' if requirements else 'none_declared',
                         coverage_scope='first_post_only', outcome='complete', all_first_post_read=True,
                         source_structure='original_game_submission_in_contest_thread',
                         resources=resources, requirements=requirements, notes=NOTES[i]))
    return rows, baseline


def snapshot(db):
    return {n: db.execute('SELECT * FROM "'+n+'" ORDER BY rowid').fetchall()
            for (n,) in db.execute("SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%'")}


def isolation(before, after, db, rows):
    ids = {r['entry_id'] for r in rows}
    gids = {r['game_id'] for r in rows}
    affected = {'entries', 'entry_resource_scans', 'entry_material_scans', 'entry_work_observations',
                'remote_resources', 'entry_resource_mentions', 'remote_resource_observations', 'entry_material_requirements'}
    assert before.keys() == after.keys()
    for table, old in before.items():
        new = after[table]
        if table not in affected:
            assert old == new, ('unrelated table', table)
            continue
        cols = [r[1] for r in db.execute('PRAGMA table_info('+table+')')]
        if table == 'entries':
            ix = cols.index('wip_thread_url')
            assert len(old) == len(new)
            for a, b in zip(old, new):
                assert a[:ix]+a[ix+1:] == b[:ix]+b[ix+1:]
                if a[0] not in ids or a[ix] is not None:
                    assert a == b
            continue
        byid = {r[0]: r for r in new}
        assert all(byid.get(r[0]) == r for r in old), ('history', table)
        oldids = {r[0] for r in old}
        for r in new:
            if r[0] in oldids:
                continue
            if table == 'remote_resource_observations':
                assert db.execute('SELECT game_id FROM remote_resources WHERE id=?', (r[cols.index('remote_resource_id')],)).fetchone()[0] in gids
            else:
                key = 'game_id' if table == 'remote_resources' else 'entry_id'
                assert r[cols.index(key)] in (gids if key == 'game_id' else ids), ('scope', table)


def check_import(db, rows):
    assert db.execute('PRAGMA integrity_check').fetchall() == [('ok',)]
    assert not db.execute('PRAGMA foreign_key_check').fetchall()
    assert db.execute('SELECT count(*) FROM entry_work_observations WHERE evidence_path=? AND phase=\'materials\' AND outcome=\'complete\'', (EVIDENCE,)).fetchone()[0] == 8
    for r in rows:
        eid, src = r['entry_id'], r['source_url']
        for table, col in [('entry_resource_scans', 'resource_listing_status'), ('entry_material_scans', 'material_listing_status')]:
            assert db.execute('SELECT '+col+' FROM '+table+' WHERE entry_id=? AND source_url=? AND checked_at=?', (eid, src, DATE)).fetchone()[0] == r[col]
        got = set(db.execute('SELECT rr.url,m.label_raw,m.content_role FROM entry_resource_mentions m JOIN remote_resources rr ON rr.id=m.remote_resource_id WHERE m.entry_id=? AND m.source_url=?', (eid, src)))
        assert got == {(x['url'], x['label_raw'], x['content_role']) for x in r['resources']}
        actual = set(db.execute('SELECT material_kind,name_normalized,quantity_raw,requirement_level,supply_mode,context_raw FROM entry_material_requirements WHERE entry_id=? AND source_url=?', (eid, src)))
        assert actual == {(x['material_kind'], x['name_normalized'], x['quantity_raw'], x['requirement_level'], x['supply_mode'], x['context_raw']) for x in r['requirements']}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--database', type=Path, default=ROOT/'database/pnp_collection.sqlite3', help='Read-only source, never imported into')
    args = parser.parse_args()
    witness = json.loads((TASK/'DOM_WITNESS.json').read_text(encoding='utf8'))
    validate_witness(witness)
    # mode=ro and query_only also protect a caller-supplied source database.
    with sqlite3.connect(args.database.resolve().as_uri()+'?mode=ro', uri=True) as db:
        db.execute('PRAGMA query_only=ON')
        rows, baseline = build(db, witness)
    counts = dict(entries=8, complete=8, unique_original_posts=8, resource_entries=8,
                  resources=16, resource_mentions=16, unique_resource_urls=16,
                  requirements=sum(len(r['requirements']) for r in rows),
                  material_observed_entries=7, material_none_declared_entries=1,
                  not_observable=0, wip_not_found=0)
    assert counts['requirements'] == 14
    assert sum(len(r['resources']) for r in rows) == 16
    (TASK/'ROSTER_BASELINE.json').write_text(json.dumps(baseline, ensure_ascii=False, indent=2)+'\n', encoding='utf8')
    payload = dict(task_id='TSK-0061', contest_id=CONTEST, checked_at=DATE, coverage_scope='first_post_only',
                   method=witness['method'], counts=counts, entries=rows,
                   limits='Declarations only; no external hosts/files opened. Original roster-linked submission is valid under optional-WIP challenge rule. No subsequent replies used.')
    (TASK/'EVIDENCE.json').write_text(json.dumps(payload, ensure_ascii=False, indent=2)+'\n', encoding='utf8')
    shared.DATE = DATE
    shared.EVIDENCE = EVIDENCE
    sql = shared.sql_for(rows).replace('TSK-0053', 'TSK-0061')
    sqlpath = ROOT/'catalog/2025-green-materials.sql'
    sqlpath.write_text(sql, encoding='utf8')
    out = ROOT/'outputs/2025-green-materials'
    out.mkdir(parents=True, exist_ok=True)
    copy = out/'verification.sqlite3'
    assert copy.resolve() != args.database.resolve()
    with sqlite3.connect(args.database.resolve().as_uri()+'?mode=ro', uri=True) as src, sqlite3.connect(copy) as dst:
        src.execute('PRAGMA query_only=ON')
        src.backup(dst)
    with sqlite3.connect(copy) as db:
        before = snapshot(db)
        db.executescript(sql)
        after = snapshot(db)
        isolation(before, after, db, rows)
        check_import(db, rows)
        db.executescript(sql)
        assert snapshot(db) == after
    verification = dict(task_id='TSK-0061', checked_at=DATE, counts=counts,
                        dom_body_identity_links_checks=8, official_roster_reconciled=8,
                        copy_integrity='ok', foreign_keys='ok', idempotent=True,
                        prior_rows_preserved=True, other_contests_rankings_acquisitions_unchanged=True,
                        added_rows={table: len(after[table])-len(before[table]) for table in before if len(after[table]) != len(before[table])},
                        filled_wip_urls=sum(a != b for a, b in zip(before['entries'], after['entries'])),
                        operational_database_open_mode='ro/query_only', operational_import=False,
                        sql_sha256=hashlib.sha256(sqlpath.read_bytes()).hexdigest(),
                        witness_sha256=hashlib.sha256((TASK/'DOM_WITNESS.json').read_bytes()).hexdigest(),
                        private_copy=copy.relative_to(ROOT).as_posix())
    (TASK/'VERIFICATION.json').write_text(json.dumps(verification, ensure_ascii=False, indent=2)+'\n', encoding='utf8')
    report = ['# 24 Hour Design Challenge GREEN 2025 — censimento materiali', '',
              'TSK-0061, verifica BGG 2026-10-05. [Roster ufficiale](https://boardgamegeek.com/thread/3510376/article/46069059#46069059): otto entry riconciliate, otto post originali degli autori letti integralmente. Le regole della challenge rendono facoltativo il WIP separato: i post di presentazione collegati dal roster sono la fonte first_post_only. Annunci iniziali, progressi precedenti e risposte successive esclusi.', '',
              '8/8 esiti completi; 16 URL esatti e 16 menzioni, 14 requisiti dichiarativi senza quantità esplicite. Risorse observed per tutte le entry; requisiti observed per sette, none_declared per Fruit Tumbler. Nessun host esterno o file aperto, nessun download. Disponibilità e condizioni non verificate.', '',
              '| Entry | Gioco / post originale | Autore | Data post | URL | Requisiti | Note |',
              '|---:|---|---|---|---:|---:|---|']
    for r in rows:
        report.append(f"| {r['entry_id']} | [{r['title']}]({r['source_url']}) | {r['author_raw']} | {r['post_timestamp_raw']} | {len(r['resources'])} | {len(r['requirements'])} | {r['notes']} |")
    report += ['', 'Funzione dichiarata e forma tecnica restano distinte e provvisorie. I percorsi PDF sono dichiarazioni di file, non verifica del contenuto. Il sell sheet di Shipmates è reference; il video di Cash Crop è video; nessuno genera requisiti materiali. Il file di Fruit Tumbler non permette di inferire componenti o regole. Le quantità di carte, segnalini, pagine e l’elenco completo dei componenti rimangono ignoti.', '',
               'Evidenze integrali del testo renderizzato, autore, username, timestamp e URL in DOM_WITNESS.json; impronte FNV rilevate nel browser confrontate offline per tutti gli otto testi, header e liste URL/etichette. Riconciliazione operativa in EVIDENCE.json e ROSTER_BASELINE.json; VERIFICATION.json documenta prova su copia privata, integrità, chiavi esterne, storia preservata, isolamento e seconda applicazione idempotente. Database operativo in sola lettura; integrazione e cruscotto demandati a TSK-0059.', '',
               'Prossimo passo utile: integrazione seriale del SQL da parte del coordinatore; eventuale task ACQ del solo GREEN dopo selezione esplicita dei giochi e verifica di condizioni/host. Nessun controllo periodico ordinario del contest concluso.', '']
    (ROOT/'sources/2025-GREEN-MATERIALS.md').write_text('\n'.join(report), encoding='utf8')
    print(json.dumps(verification, ensure_ascii=False))


if __name__ == '__main__':
    main()
