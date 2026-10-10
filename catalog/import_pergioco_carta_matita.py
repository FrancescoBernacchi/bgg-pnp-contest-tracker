"""Frozen PGCM batch, B-v1/013. Inspection is read-only; no network or schema writes.

Copy rehearsal is authorized by TSK-0081. Operational use requires the human's
final identity-plan approval and --apply --authorization. No automatic restore.
"""
import argparse
import json
import re
import sqlite3
import sys
import unicodedata
from datetime import datetime, timezone
from pathlib import Path
from uuid import uuid4

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / 'catalog'))
from import_pergioco_pilot import canon, digest, filehash, require, put
sys.path.insert(0, str(ROOT / 'database'))
from apply_source_evidence_migration import open_db, inventory, installed, validate, expected_objects

MANIFEST = ROOT / 'catalog/pergioco_extension_carta_matita_2026-10-08.json'
DB = ROOT / 'database/pnp_collection.sqlite3'
TASK = ROOT / 'tasks/2026-10-08 - DAT - Importazione lotto Carta e matita PerGioco'
VERSION = 'pergioco-carta-matita-B-v1.1'
PREFIX = 'pergioco:carta-matita:20261008:'
NEW = {f'PGCM-{n:03}' for n in (2, 3, 4, 5, 7, 8, 9)}
PLAN_REF = (TASK / 'PIANO_IDENTITA.md').relative_to(ROOT).as_posix()
PLAN = {f'PGCM-{n:03}': ('create_new' if f'PGCM-{n:03}' in NEW else 'source_only') for n in range(1, 10)}


def load(path=MANIFEST):
    require(__debug__, 'Python -O unsupported')
    checks = json.loads((ROOT / 'tasks/2026-10-08 - CAT - Estensione censimento PerGioco/VERIFICHE.json').read_text(encoding='utf-8'))
    require(filehash(path) == checks['manifest_sha256'], 'Frozen CAT changed: new review required')
    p = json.loads(Path(path).read_text(encoding='utf-8'))
    require(len(p['records']) == 9 and {r['candidate_id'] for r in p['records']} == set(PLAN), 'Batch expanded/colliding')
    for field in ('local_record_key', 'event_key', 'source_url'):
        require(len({r[field] for r in p['records']}) == 9, 'Collision: ' + field)
    require(sum(r['outcome'] == 'admitted' for r in p['records']) == 7, 'CAT denominator changed')
    for r in p['records']:
        require(r['local_record_key'] == PREFIX + r['candidate_id'], 'Local key mismatch')
        require(r['observed_at'] == '2026-10-08' and r['native_id'] is None, 'Date/native ID changed')
        for c in r['native_classification']:
            require(c['source_url'] and c['observed_at'], 'Classification provenance missing')
            require(c['path'] is None or (isinstance(c['path'], list) and all(isinstance(s, str) and s.strip() for s in c['path'])), 'Invalid path')
        require(len({m['mention_key'] for m in r['resources']}) == len(r['resources']), 'Mention collision')
        require(len({i['instance_key'] for i in r['instances']}) == len(r['instances']), 'Instance collision')
    return p


def normalized(name):
    return re.sub(r'[^\w]+', ' ', unicodedata.normalize('NFKC', name).casefold()).strip()


def matching(db, p, exclude=()):
    """Local names only, no equivalence inference. Broader thematic hits stay unlinked."""
    names = db.execute('SELECT id,canonical_title FROM games UNION SELECT game_id,name FROM game_names').fetchall()
    result = []
    for r in p['records']:
        q = list(dict.fromkeys([r['title_original'], r['candidate_title']] + r['aliases_declared']))
        eq = [(gid, title) for gid, title in names if gid not in exclude and any(title.casefold() == n.casefold() for n in q)]
        norm = [(gid, title) for gid, title in names if gid not in exclude and any(normalized(title) == normalized(n) for n in q) and (gid, title) not in eq]
        urls = db.execute('SELECT id,title_raw FROM source_records WHERE canonical_url IN (?,?,?)', (r['source_url'], r['requested_url'], r['final_url'])).fetchall()
        result.append(dict(candidate_id=r['candidate_id'], queried_names=q, exact_candidates=sorted(eq), normalized_candidates=sorted(norm), source_url_collisions=urls,
                           limit='No semantic equivalence guaranteed; names are candidates only. Piattola variant names are outside canonical matching scope.'))
    return result


class Writer:
    """Same declarative mapper inserts or verifies every typed field on replay."""
    def __init__(self, db, formalized, authorization, checking=False):
        self.db, self.formalized, self.authorization, self.checking = db, formalized, authorization, checking
        self.keys = {}

    def add(self, table, key, **data):
        data = dict(stable_key=key, **data)
        self.keys.setdefault(table, set()).add(key)
        if not self.checking:
            return put(self.db, table, **data)
        cols = [c[1] for c in self.db.execute('PRAGMA table_info(' + table + ')')]
        rows = self.db.execute('SELECT * FROM ' + table + ' WHERE stable_key=?', (key,)).fetchall()
        require(len(rows) == 1, 'Missing/duplicate typed row: ' + key)
        actual = dict(zip(cols, rows[0]))
        # Check defaults and absent optional fields too, not only explicit columns.
        for c in self.db.execute('PRAGMA table_info(' + table + ')'):
            name, default = c[1], c[4]
            if name == 'id': continue
            value = data[name] if name in data else (self.db.execute('SELECT ' + default).fetchone()[0] if default is not None else None)
            require(actual[name] == value, 'Typed projection differs: ' + table + '.' + name + ' / ' + key)
        return actual['id']

    def ev(self, table, key, item, pointer, url, **data):
        return self.add(table, key, **{**dict(source_url=item.get('source_url', url), observed_at=item.get('observed_at', '2026-10-08'),
            observed_precision='day', formalized_at=self.formalized, evidence_path=MANIFEST.relative_to(ROOT).as_posix(),
            evidence_pointer=pointer, provenance_kind='reused', raw_value=canon(item), mapping_version=VERSION), **data})

    def legacy(self, table, where, params, **data):
        if not self.checking:
            require(not self.db.execute('SELECT 1 FROM ' + table + ' WHERE ' + where, params).fetchone(), 'Legacy collision: ' + table)
            return put(self.db, table, **data)
        rows = self.db.execute('SELECT * FROM ' + table + ' WHERE ' + where, params).fetchall()
        require(len(rows) == 1, 'Legacy projection missing/duplicate: ' + table)
        cols = [c[1] for c in self.db.execute('PRAGMA table_info(' + table + ')')]
        actual = dict(zip(cols, rows[0]))
        require(all(actual[k] == v for k, v in data.items()), 'Legacy projection differs: ' + table)
        return actual.get('id')

    def finish(self):
        for table in (o[1] for o in expected_objects() if o[0] == 'table'):
            actual = {r[0] for r in self.db.execute('SELECT stable_key FROM ' + table + ' WHERE substr(stable_key,1,?)=?', (len(PREFIX), PREFIX))}
            require(actual == self.keys.get(table, set()), 'Extra/missing batch rows: ' + table)


def map_batch(db, p, formalized, authorization, checking=False, fail_after=None, plan=None):
    plan = PLAN if plan is None else plan
    require(set(plan) == set(PLAN) and all(plan[c] in ('create_new', 'source_only') and (plan[c] != 'create_new' or c in NEW) for c in plan), 'Unapproved identity alternative')
    sid = db.execute("SELECT id FROM catalog_sources WHERE source_key='pergioco'").fetchone()
    require(sid is not None, 'Pilot source must already exist')
    sid = sid[0]
    w = Writer(db, formalized, authorization, checking)
    cond = p['conditions']
    condition = w.ev('condition_observations', PREFIX + 'conditions:CAT', cond, '/conditions', cond['url'], source_id=sid,
        condition_key=cond['condition_key'], scope_raw='Site consultation', scope_kind='source_consultation', condition_url=cond['url'],
        summary_original=cond['summary_original'], page_updated_raw=cond['page_updated_raw'], permission_state='unknown',
        assessment_note='CAT records no public redistribution permission; free account/newsletter declarations are FAQ scoped, not license.',
        registration_declared_free=None, newsletter_declared_free=None)
    faqcond = w.ev('condition_observations', PREFIX + 'conditions:FAQ', cond, '/conditions', cond['registration_source_url'],
        source_id=sid, condition_key=cond['condition_key'] + ':FAQ', scope_raw='Registration and newsletter declarations', scope_kind='account_declarations',
        condition_url=cond['registration_source_url'], summary_original='CAT reports free registration/newsletter; no registration performed or reserved content verified.',
        source_url=cond['registration_source_url'], observed_at=cond['registration_observed_at'], page_updated_raw=None, permission_state='unknown',
        registration_declared_free=int(cond['registration_declared_free']), newsletter_declared_free=int(cond['newsletter_declared_free']))
    for n, r in enumerate(p['records']):
        key = r['local_record_key']; ptr = '/records/' + str(n); url = r['source_url']; cid = r['candidate_id']
        typ = 'editorial_collection' if r['entity_kind_observed'] == 'editorial_collection' else 'game_page'
        rid = w.legacy('source_records', 'source_id=? AND canonical_url=?', (sid, url), source_id=sid, record_type=typ, native_id=None,
            canonical_url=url, title_raw=r['title_original'], status_normalized='unknown', observed_at=r['observed_at'], verification_status='verified',
            last_verified_at=r['observed_at'], raw_metadata=canon(r), notes='CAT TSK-0080; frozen batch TSK-0081. Admission independent from identity.')
        w.add('source_record_keys', key, source_id=sid, record_id=rid, local_key=cid, key_kind='local_CAT_batch_id', assigned_at=formalized, task_id='TSK-0081')
        oid = w.ev('source_record_observations', key + ':CAT', r, ptr, url, record_id=rid, event_key=r['event_key'], payload_json=canon(r), payload_sha256=digest(r),
            schema_version=str(p['schema_version']), title_raw=r['title_original'], display_title_qualified=r['title_normalized'],
            year_raw=str(r['year_declared']) if r['year_declared'] is not None else None, year_value=r['year_declared'],
            year_precision='year' if r['year_declared'] is not None else 'unknown', page_updated_raw=r['page_updated_raw'], coverage_kind='CAT_carta_matita_batch', coverage_state='complete')
        aid = w.ev('source_admission_observations', key + ':admission', r['rules'], ptr + '/rules', url, record_observation_id=oid,
            policy_ref='sources/PERGIOCO-SCOPE.md', policy_version='TSK-0073:2026-10-06', requirement_key='complete_free_rules',
            outcome_raw=r['outcome'], outcome_normalized=r['outcome'], completeness_raw=r['rules']['completeness'], assessment_kind='CAT_batch', assessment_note=r['rules']['assessment_original'])
        for j, c in enumerate(r['native_classification']):
            ck = key + ':classification:' + str(j)
            co = w.ev('source_classification_observations', ck, c, ptr + '/native_classification/' + str(j), url, record_observation_id=oid,
                label_raw=c['label'], kind_raw=c['kind'], path_state='observed' if c['path'] is not None else 'not_declared', segment_count=len(c['path'] or []),
                segment_raw=c.get('segment'), index_title_raw=c.get('index_title'), exhaustiveness_raw=r['classification_exhaustiveness'])
            for pos, label in enumerate(c['path'] or []):
                w.add('source_classification_segments', ck + ':' + str(pos), classification_id=co, position=pos, label_raw=label)
        for field, role in (('requested_url', 'requested'), ('final_url', 'final')):
            w.ev('source_record_url_observations', key + ':url:' + role, r, ptr + '/' + field, url, record_observation_id=oid, record_id=rid,
                url_raw=r[field], url_role=role, request_event_key=r['event_key'], destination_kind='content',
                technical_status_raw='CAT_requested_final_endpoints_observed; intermediate_chain_unknown', raw_value=canon(r[field]))
        for j, c in enumerate(r['credits']):
            w.ev('source_credit_observations', key + ':credit:' + str(j), c, ptr + '/credits/' + str(j), url, record_observation_id=oid,
                name_raw=c['name_raw'], role_raw=c['role_raw'], status_raw=c['status_raw'], subject_context_raw=c['subject_context_raw'], party_kind='unknown',
                assessment_note='Unresolved subject/party; no canonical designer or person projection.')
        mentions = {}
        for j, m in enumerate(r['resources']):
            mk = key + ':mention:' + m['mention_key']; mp = ptr + '/resources/' + str(j); ru = m.get('url'); resource = None
            if ru:
                found = db.execute('SELECT id,source_record_id FROM catalog_resources WHERE url=?', (ru,)).fetchone()
                if found:
                    resource = found[0]
                    if checking and found[1] == rid:
                        w.legacy('catalog_resources', 'id=?', (resource,), source_record_id=rid, resource_kind=m['kind'], url=ru, access_type='unknown',
                            availability_status='unknown', verification_status='declared', first_seen_at=m['observed_at'], notes='Contextual CAT evidence; no new destination verification.')
                else:
                    require(not checking, 'Missing URL destination')
                    resource = put(db, 'catalog_resources', source_record_id=rid, resource_kind=m['kind'], url=ru, access_type='unknown',
                        availability_status='unknown', verification_status='declared', first_seen_at=m['observed_at'], notes='Contextual CAT evidence; no new destination verification.')
                w.legacy('resource_links', 'resource_id=? AND source_record_id=? AND link_role=? AND evidence_record_id=? AND game_id IS NULL AND product_id IS NULL',
                    (resource, rid, m['kind'], rid), resource_id=resource, source_record_id=rid, link_role=m['kind'], evidence_record_id=rid)
            mid = w.add('source_resource_mentions', mk, record_id=rid, mention_key=m['mention_key'], first_observation_id=oid, function_raw=m['kind'])
            mo = w.ev('source_resource_mention_observations', mk + ':CAT', m, mp, url, mention_id=mid, record_observation_id=oid,
                declared_url=ru, resource_id=resource, function_raw=m['kind'], technical_form_raw='HTML' if m['kind'].endswith('html') else None,
                language_raw=m.get('language'), declaration_state='declared', destination_status_raw=m['access'], context_summary=m.get('usability_limit'))
            mentions[m['mention_key']] = mo
            if m['kind'] == 'rules_html':
                w.add('admission_evidence_mentions', mk + ':admission', admission_id=aid, mention_id=mid, mention_observation_id=mo, evidence_role='rules_html', evidence_pointer=mp)
            if ru:
                w.ev('resource_url_observations', mk + ':url', m, mp, url, mention_observation_id=mo, requested_url=ru,
                    final_url=(r['final_url'] if m['mention_key'] == 'main_html' else None), destination_kind='content' if m.get('content_observed') is True else 'unknown',
                    technical_status_raw=m['access'], scope_checked='CAT_reused_only')
            assessments = [(a, ptr + '/access_assessments/' + str(aidx)) for aidx, a in enumerate(r['access_assessments'])] if m['mention_key'] == 'main_html' else [(m, mp)]
            for a, ap in assessments:
                scope = a.get('subject_scope', 'public_content')
                content = (m.get('content_observed') if scope == 'public_content' else (True if scope == 'complete_rules' and r['rules']['complete_rules_free'] is True else None))
                cost = a.get('cost_status', 'free_observed' if m.get('free_observed') is True and content is True else 'unknown')
                comp = m.get('completeness') if scope == 'public_content' else (r['rules']['completeness'] if scope == 'complete_rules' else None)
                access = w.ev('resource_access_observations', mk + ':access:' + scope, a, ap, url, mention_observation_id=mo, subject_scope=scope,
                    access_raw=a['access'], access_normalized=a['access'], content_observed=int(content) if content is not None else None,
                    completeness_raw=comp, completeness_normalized=comp if comp is not None else 'unknown', cost_status=cost,
                    playtested=int(r['rules']['playtested']) if scope == 'complete_rules' else None)
                for suffix, condid in (('site', condition), ('FAQ', faqcond)):
                    w.add('access_condition_links', mk + ':conditions:' + scope + ':' + suffix, access_observation_id=access, condition_observation_id=condid,
                        applicability_status='uncertain', evidence_pointer=ptr + '/conditions_ref')
        require(db.execute('SELECT count(*) FROM resource_links WHERE source_record_id=?',(rid,)).fetchone()[0] == sum(m.get('url') is not None for m in r['resources']), 'Extra resource links')
        for j, inst in enumerate(r['instances']):
            ik = key + ':instance:' + inst['instance_key']; ip = ptr + '/instances/' + str(j)
            ins = w.add('problem_instances', ik, record_id=rid, instance_key=inst['instance_key'], instance_kind=inst['kind'], native_instance_id=None, created_at=formalized)
            io = w.ev('problem_instance_observations', ik + ':CAT', inst, ip, url, instance_id=ins, record_observation_id=oid,
                date_raw=inst['date_raw'], published_at=inst['published_at'], date_precision='day', label_raw=inst['label_raw'], context_locator=inst['label_raw'],
                assessment_note='Named/date metadata only; usable scheme unknown; qualification and solution declaration in raw payload.')
            w.ev('instance_mention_assertions', ik + ':appears', inst, ip, url, instance_observation_id=io, mention_observation_id=mentions['diagrams'],
                role='appears_in', assertion_status='CAT_named_metadata_observed')
        for j, rel in enumerate(r['relations_and_dependencies']):
            w.ev('source_relation_assertions', key + ':relation:' + str(j), rel, ptr + '/relations_and_dependencies/' + str(j), url,
                record_observation_id=oid, from_record_id=rid, target_label_raw=rel['target_label_raw'], target_url=rel.get('target_url'), relation_type_raw=rel['relation_type_raw'],
                relation_type_normalized='source_statement', assertion_status=rel['assertion_status'], information_requirement=rel['information_requirement'],
                ownership_requirement=rel['ownership_requirement'], purchase_requirement=rel['purchase_requirement'], assessment_note=rel.get('summary_original'))
        for j, variant in enumerate(r.get('embedded_variants', [])):
            w.ev('source_relation_assertions', key + ':embedded_variant:' + str(j), variant, ptr + '/embedded_variants/' + str(j), url,
                record_observation_id=oid, from_record_id=rid, target_label_raw=variant['label_raw'], relation_type_raw=variant['kind'], relation_type_normalized='embedded_variant_declared',
                assertion_status='declared_not_separately_assessed', assessment_note='Variant label/aliases/context retained; no target record/game or canonical equivalence.')
        if plan[cid] == 'create_new':
            if checking:
                dec = db.execute('SELECT game_id FROM source_identity_decisions WHERE stable_key=?', (key + ':identity',)).fetchone()
                require(dec is not None, 'Missing identity decision'); gid = dec[0]
                w.legacy('games', 'id=?', (gid,), canonical_title=r['title_normalized'], source_url=url, first_seen_at=r['observed_at'], last_verified_at=r['observed_at'], status_normalized='unknown')
            else:
                gid = put(db, 'games', canonical_title=r['title_normalized'], source_url=url, first_seen_at=r['observed_at'], last_verified_at=r['observed_at'], status_normalized='unknown')
            w.legacy('game_source_records', 'source_record_id=?', (rid,), game_id=gid, source_record_id=rid, match_status='confirmed', match_method='TSK-0081_approved_identity_plan',
                evidence=PLAN_REF, decided_at=formalized)
            decision = w.add('source_identity_decisions', key + ':identity', record_id=rid, game_id=gid, decision_kind='create_new', status='confirmed', decided_at=formalized,
                decision_ref=authorization, rationale='Approved conservative local identity; no semantic equivalence guarantee. CAT outcome distinct from identity.')
            w.add('canonical_projection_events', key + ':projection', identity_decision_id=decision, target_game_id=gid, target_kind='identity', projected_at=formalized, decision_ref=authorization, mapping_version=VERSION)
            for j, name in enumerate([r['title_original']] + r['aliases_declared']):
                nt = 'source_title' if j == 0 else 'alias'; np = ptr + '/title_original' if j == 0 else ptr + '/aliases_declared/' + str(j - 1)
                nid = w.legacy('game_names', 'source_record_id=? AND name=? AND name_type=?', (rid, name, nt), game_id=gid, name=name, name_type=nt,
                    language_code='it' if j == 0 else None, source_record_id=rid, observed_from=url, observed_at=r['observed_at'], verification_status='declared', evidence_url=url, last_verified_at=r['observed_at'])
                w.add('canonical_projection_events', key + ':name:' + str(j), identity_decision_id=decision, target_game_id=gid, target_kind='name', name_observation_id=oid,
                    name_evidence_pointer=np, target_name_id=nid, projected_at=formalized, decision_ref=authorization, mapping_version=VERSION)
            require(db.execute('SELECT count(*) FROM game_names WHERE source_record_id=?', (rid,)).fetchone()[0] == 1 + len(r['aliases_declared']), 'Extra names')
        else:
            require(not db.execute('SELECT 1 FROM game_source_records WHERE source_record_id=?', (rid,)).fetchone(), 'Source-only projected')
        if fail_after is not None and n + 1 >= fail_after: raise RuntimeError('Injected rollback failure')
    w.finish(); validate(db)


def batch_presence(db, p):
    return db.execute('SELECT count(*) FROM source_record_keys WHERE stable_key IN (' + ','.join('?' for _ in p['records']) + ')', [r['local_record_key'] for r in p['records']]).fetchone()[0]


def verify(db, p, plan=None):
    require(installed(db), '013 missing/divergent'); validate(db)
    require(batch_presence(db, p) == 9, 'Partial/missing batch')
    row = db.execute('SELECT formalized_at FROM source_record_observations WHERE stable_key=?', (p['records'][0]['local_record_key'] + ':CAT',)).fetchone()
    require(row is not None, 'Missing snapshot')
    decision = db.execute('SELECT decision_ref FROM source_identity_decisions WHERE stable_key=?', (PREFIX + 'PGCM-002:identity',)).fetchone()
    map_batch(db, p, row[0], decision[0] if decision else 'copy:source-only-alternative', checking=True, plan=plan)
    return inventory(db)


def preserve(db, backup, before):
    require(inventory(db)['objects'] == before['objects'], 'Schema changed')
    b_tables = {o[1] for o in expected_objects() if o[0] == 'table'}
    allowed = b_tables | {'source_records', 'catalog_resources', 'resource_links', 'games', 'game_names', 'game_source_records'}
    with open_db(backup) as old:
        for table in before['tables']:
            previous = old.execute('SELECT * FROM "' + table + '"').fetchall()
            current = set(db.execute('SELECT * FROM "' + table + '"').fetchall())
            require(all(row in current for row in previous), 'Pre-existing row lost/changed: ' + table)
            if table not in allowed: require(len(current) == len(previous), 'Unapproved insert: ' + table)


def apply(path, authorization, backup_dir, fail_after=None, plan=None, before_lock=None):
    p = load(); require(authorization.strip(), 'Explicit authorization reference required')
    path = Path(path).resolve(); formalized = datetime.now(timezone.utc).isoformat()
    with open_db(path) as ro:
        ro.execute('BEGIN'); require(installed(ro), '013 missing/divergent'); validate(ro)
        presence = batch_presence(ro, p)
        if presence:
            require(presence == 9, 'Partial batch: refusing any write')
            verify(ro, p, plan); return dict(outcome='already_imported', writes=0)
        require(not ro.execute('SELECT 1 FROM source_record_observations WHERE mapping_version=?', (VERSION,)).fetchone(), 'Orphan batch observation')
        matches = matching(ro, p)
        require(all(not m['exact_candidates'] and not m['normalized_candidates'] and not m['source_url_collisions'] for m in matches), 'New name/URL collision requires identity-plan review')
        baseline = inventory(ro)
        out = Path(backup_dir).resolve(); out.mkdir(parents=True, exist_ok=True)
        tag = datetime.now(timezone.utc).strftime('%Y%m%dT%H%M%S%f') + '-' + uuid4().hex[:8]
        backup = out / ('PGCM-before-' + tag + '.sqlite3'); restore = out / ('PGCM-restore-' + tag + '.sqlite3')
        with sqlite3.connect(backup) as dest: ro.backup(dest)
    with open_db(backup) as old:
        validate(old); require(inventory(old) == baseline, 'Backup differs')
        with sqlite3.connect(restore) as dest: old.backup(dest)
    with open_db(restore) as old: validate(old); require(inventory(old) == baseline, 'Restore differs')
    if before_lock is not None: before_lock(path)  # Test-only concurrent writer injection.
    with open_db(path, write=True) as db:
        try:
            db.execute('BEGIN EXCLUSIVE'); require(inventory(db) == baseline, 'Target changed since backup')
            map_batch(db, p, formalized, authorization, fail_after=fail_after, plan=plan)
            after = verify(db, p, plan); preserve(db, backup, baseline); db.commit()
        except BaseException:
            db.rollback(); raise
    with open_db(path) as db: require(verify(db, p, plan) == after, 'Post-commit mismatch'); preserve(db, backup, baseline)
    return dict(outcome='imported', target=str(path), authorization=authorization, backup=str(backup), backup_sha256=filehash(backup),
        restore_proof=str(restore), restore_sha256=filehash(restore), restore_inventory_matches=True, formalized_at=formalized,
        manifest_sha256=filehash(MANIFEST), manifest_canonical_sha256=digest(p), identity_plan=PLAN if plan is None else plan,
        table_deltas={t:after['tables'][t]['count'] - baseline['tables'][t]['count'] for t in after['tables'] if after['tables'][t]['count'] != baseline['tables'][t]['count']})


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--database', type=Path, default=DB); ap.add_argument('--apply', action='store_true'); ap.add_argument('--authorization', default='')
    ap.add_argument('--backup-dir', type=Path, default=ROOT / 'outputs/pergioco-carta-matita-backups'); ap.add_argument('--report', type=Path)
    args = ap.parse_args()
    if args.apply: result = apply(args.database, args.authorization, args.backup_dir)
    else:
        p = load()
        with open_db(args.database) as db:
            require(installed(db), '013 missing/divergent'); validate(db)
            result = dict(mode='read_only', batch_present=batch_presence(db,p), identity_plan=PLAN, matching=matching(db,p), manifest_sha256=filehash(MANIFEST))
    if args.report: args.report.parent.mkdir(parents=True,exist_ok=True); args.report.write_text(json.dumps(result,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
    print(json.dumps(result, ensure_ascii=False, indent=2))


if __name__ == '__main__': main()
