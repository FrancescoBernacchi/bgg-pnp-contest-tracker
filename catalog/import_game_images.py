"""Manifest IMG v1 -> additive catalog 014. Default is a read-only preview.

No network, file acquisition, legacy writes, implicit deletion or image generation.
Pillow is used offline to verify image bytes/format/dimensions; server unchanged.
"""
import argparse
import hashlib
import json
import math
import os
import sqlite3
import sys
import warnings
from collections import Counter
from pathlib import Path, PurePosixPath, PureWindowsPath

ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT/'database'))
sys.path.insert(0,str(ROOT/'app'))
from image_catalog import (Conflict, MIGRATION, backup, canonical, digest, installed,
                           inventory, legacy_names, migrate, now, open_db, require, validate)
from pdf_files import PDFError, check_handle, confined_path

MAPPING='img-v1/014-v1'
MAX_MANIFEST=32*1024*1024
MAX_IMAGE=128*1024*1024
MAX_PIXELS=40_000_000

def read_json(path):
    path=Path(path).resolve(strict=True)
    require(path.stat().st_size<=MAX_MANIFEST,'Manifest exceeds 32 MiB')
    def unique(pairs):
        result={}
        for key,value in pairs:
            require(key not in result,f'Duplicate JSON key: {key}')
            result[key]=value
        return result
    result=json.loads(path.read_text(encoding='utf-8-sig'),object_pairs_hook=unique,
                      parse_constant=lambda v: (_ for _ in ()).throw(Conflict(f'Nonfinite JSON: {v}')))
    require(isinstance(result,dict),'Manifest must be an object')
    return result

def text(value,name):
    require(isinstance(value,str) and bool(value.strip()),f'Missing/invalid {name}')
    return value

def integer(value,name,minimum=0):
    require(type(value) is int and value>=minimum,f'Invalid {name}')
    return value

def date(db,value):
    text(value,'observation date')
    require(db.execute('SELECT julianday(?)',(value,)).fetchone()[0] is not None,'Invalid observation date')
    return value

def parent(db,table,identifier):
    integer(identifier,table+' id',1)
    require(db.execute(f'SELECT 1 FROM {table} WHERE id=?',(identifier,)).fetchone(),f'Unknown {table} ID: {identifier}')

def context(db,record,game_id):
    parent(db,'games',game_id)
    entry,contest=record.get('entry_id'),record.get('contest_id')
    if contest is not None:
        parent(db,'contests',contest)
    if entry is not None:
        parent(db,'entries',entry)
        actual=db.execute('SELECT game_id,contest_id FROM entries WHERE id=?',(entry,)).fetchone()
        require(actual[0]==game_id and (contest is None or actual[1]==contest),'Entry/game/contest mismatch')
    if record.get('product_id') is not None:
        parent(db,'products',record['product_id'])
        require(db.execute('SELECT 1 FROM product_games WHERE product_id=? AND game_id=?',
                           (record['product_id'],game_id)).fetchone(),'Product/game link absent')
    if record.get('source_record_id') is not None:
        parent(db,'source_records',record['source_record_id'])
        require(db.execute("SELECT 1 FROM game_source_records WHERE source_record_id=? AND game_id=? AND match_status='confirmed'",
                           (record['source_record_id'],game_id)).fetchone(),'Source identity is not confirmed for game')

def safe_relative(relative,image=False):
    text(relative,'relative_path')
    parts=relative.replace('\\','/').split('/')
    w=PureWindowsPath(relative)
    require(not w.drive and not w.root and ':' not in relative and '\x00' not in relative
            and all(p not in ('','..','.') and p==p.rstrip(' .') for p in parts),'Invalid local path')
    if image:
        require(parts[:2]==['library','immagini'] and len(parts)>3,'Image path must be under library/immagini')
        parts=parts[1:]
    return '/'.join(parts)

def file_check(library,relative,sha,size,fmt=None,width=None,height=None,image=False):
    require(isinstance(sha,str) and len(sha)==64 and all(c in '0123456789abcdef' for c in sha),'Invalid SHA-256')
    integer(size,'bytes',1)
    require(not image or size<=MAX_IMAGE,'Image exceeds 128 MiB')
    rel=safe_relative(relative,image)
    root,path=confined_path(library,rel)
    with os.fdopen(os.open(path,os.O_RDONLY|getattr(os,'O_BINARY',0)|getattr(os,'O_NOFOLLOW',0)),'rb') as handle:
        check_handle(handle,root,path)
        before=os.fstat(handle.fileno())
        require(before.st_size==size,f'Byte size mismatch: {relative}')
        hasher=hashlib.sha256()
        for chunk in iter(lambda:handle.read(1024*1024),b''):
            hasher.update(chunk)
        require(hasher.hexdigest()==sha,f'Hash mismatch: {relative}')
        if image:
            from PIL import Image
            integer(width,'width',1);integer(height,'height',1)
            require(width*height<=MAX_PIXELS and max(width,height)<=16000,'Image dimensions exceed bounds')
            with warnings.catch_warnings():
                warnings.simplefilter('error',Image.DecompressionBombWarning)
                handle.seek(0)
                with Image.open(handle) as im:
                    require(im.format==fmt and im.size==(width,height),'Image format/dimensions mismatch')
                    require(getattr(im,'n_frames',1)==1,'Animated/multipage image requires explicit future handling')
                    im.verify()
                handle.seek(0)
                with Image.open(handle) as im:
                    im.load()
        after=os.fstat(handle.fileno())
        require((before.st_size,before.st_mtime_ns)==(after.st_size,after.st_mtime_ns),'File changed during verification')
        check_handle(handle,root,path)
    return rel

def rectangle(record):
    rect=record.get('rectangle')
    if rect is None:
        return None
    require(isinstance(rect,list) and len(rect)==4 and all(type(x) in (int,float) and math.isfinite(x) for x in rect)
            and rect[0]>=0 and rect[1]>=0 and rect[2]>rect[0] and rect[3]>rect[1],'Invalid rectangle')
    text(record.get('coordinate_system'),'coordinate_system')
    integer(record.get('page'),'page',1)
    return canonical(rect)

def document_identifier(record):
    return record.get('acquired_file_id',record.get('document_id',record.get('source_document_id')))

def document_ref(db,record,game_id,library,verified):
    identifier=document_identifier(record)
    if identifier is None:
        return None
    parent(db,'acquired_files',identifier)
    row=db.execute('SELECT f.relative_path,f.sha256,f.byte_size,a.game_id,f.acquisition_status FROM acquired_files f '
                   'JOIN acquisitions a ON a.id=f.acquisition_id WHERE f.id=?',(identifier,)).fetchone()
    require(row[3]==game_id and row[4]=='acquired','Source document belongs to another game or was not acquired')
    claimed=record.get('document_sha256',record.get('source_document_sha256',record.get('sha256')))
    require(claimed is None or claimed==row[1],'Source document hash disagrees with catalog')
    if identifier not in verified:
        file_check(library,row[0],row[1],row[2])
        verified.add(identifier)
    if record.get('page') is not None:
        integer(record['page'],'page',1)
    rectangle(record)
    return identifier

def origin(record):
    labels={p.get('label') for p in record.get('provenance',[])}
    labels.add(record.get('origin_kind'))
    require(not (labels & {'AI-Generata','ai_generated'} and labels & {'AI-Rielaborata','ai_reworked'}),
            'Conflicting AI origins')
    if labels & {'AI-Generata','ai_generated'}:
        return 'ai_generated'
    if labels & {'AI-Rielaborata','ai_reworked'}:
        return 'ai_reworked'
    if 'derived' in labels:
        return 'derived'
    return 'original'

def state(record):
    kind=origin(record)
    use={'adottata':'adopted','Superata':'superseded','superata':'superseded','Scartata':'not_adopted',
         'Da valutare':'not_adopted','non adottata':'not_adopted','adopted':'adopted',
         'superseded':'superseded','not_adopted':'not_adopted'}.get(record.get('current_use'))
    require(use is not None,'Unknown current_use: use a declared state')
    validation=record.get('validation_state','pending' if kind in ('ai_generated','ai_reworked') else 'not_required')
    require(validation in ('not_required','pending','approved','rejected'),'Unknown validation_state')
    if kind in ('ai_generated','ai_reworked'):
        require(validation!='not_required','AI needs explicit validation state')
        require(use!='adopted' or validation=='approved','Unapproved AI cannot be adopted')
        require(validation!='rejected' or use=='not_adopted','Rejected AI cannot be current/superseded adoption')
    return kind,use,validation

def add(db,table,values):
    columns=list(values)
    db.execute(f'INSERT INTO {table} ({",".join(columns)}) VALUES ({",".join("?" for _ in columns)})',
               tuple(values[c] for c in columns))
    return db.execute('SELECT last_insert_rowid()').fetchone()[0]

def immutable(db,table,key,values):
    cols=list(values)
    where=' AND '.join(c+'=?' for c in key)
    existing=db.execute(f'SELECT {",".join(cols)} FROM {table} WHERE {where}',tuple(key.values())).fetchone()
    if existing:
        require(existing==tuple(values.values()),f'Immutable identity/file conflict in {table}: {key}')
    else:
        add(db,table,values)

def event(db,table,key,values):
    where=' AND '.join(c+' IS ?' for c in key)
    existing=db.execute(f'SELECT id FROM {table} WHERE {where}',tuple(key.values())).fetchone()
    return (existing[0],False) if existing else (add(db,table,values),True)

def adapt(db,m,s,library):
    """Validate against the target snapshot. All legacy IDs are resolved explicitly."""
    require(m.get('manifest_version')==1,'Only IMG manifest_version 1 is supported')
    text(m.get('task_id'),'task_id')
    date(db,m.get('checked_at'))
    require(s.get('task_id')==m['task_id'],'Source/image task mismatch')
    scope=m.get('scope',{})
    require(isinstance(scope,dict),'Missing scope')
    allowed=scope.get('authorized_game_ids')
    require(isinstance(allowed,list) and len(allowed)==len(set(allowed)),'Invalid authorized_game_ids')
    for game in allowed:
        parent(db,'games',game)
    for name in ('contest_id','series_id'):
        if scope.get(name) is not None:
            require(s.get(name)==scope[name],f'Source/image {name} mismatch')
    if scope.get('contest_id') is not None:
        parent(db,'contests',scope['contest_id'])
        series,year=db.execute('SELECT series_id,year FROM contests WHERE id=?',(scope['contest_id'],)).fetchone()
        require(series==scope.get('series_id') and year==scope.get('year'),'Contest scope identity/year mismatch')
    verified=set()
    for doc in s.get('documents',[]):
        require(doc.get('game_id') in allowed,'Source document outside authorized games')
        context(db,doc,doc['game_id'])
        document_ref(db,doc,doc['game_id'],library,verified)
        dbdoc=db.execute('SELECT relative_path,sha256,byte_size FROM acquired_files WHERE id=?',(doc['acquired_file_id'],)).fetchone()
        require(dbdoc==(doc['relative_path'],doc['sha256'],doc['byte_size']),'Source manifest disagrees with registered document')
    games=m.get('games',[])
    require(len(games)==len({g['game_id'] for g in games}),'Duplicate game observations')
    for g in games:
        require(g['game_id'] in allowed,'Research outside authorized games')
        context(db,g,g['game_id'])
        require(type(g.get('research_complete')) is bool,'Research completeness must be explicit boolean')
        date(db,g.get('checked_at',m['checked_at']))
        text(g.get('research_status'),'research_status')
        cats=g.get('categories',[])
        require(len(cats)==len({c['category'] for c in cats}),'Duplicate research category')
        for cat in cats:
            text(cat.get('research'),'category research')
            require(type(cat.get('verified_absence')) is bool,'Verified absence must be explicit boolean')
            for count in ('adopted_original_count','validated_ai_count','pending_ai_count'):
                integer(cat.get(count),count)
            require(not cat['verified_absence'] or cat['adopted_original_count']==0,'Absence contradicts original count')
        for docid in g.get('acquired_file_ids',[]):
            document_ref(db,{'acquired_file_id':docid},g['game_id'],library,verified)
    components=m.get('components',[])
    require(len(components)==len({c['component_id'] for c in components}),'Duplicate component ID')
    compmap={c['component_id']:c for c in components}
    existing_components={cid:gid for cid,gid in db.execute('SELECT component_id,game_id FROM img_components')}
    images=m.get('images',[])
    require(len(images)==len({i['image_id'] for i in images}),'Duplicate current image ID')
    all_files=[(i,True) for i in m.get('historical_files',[])]+[(i,False) for i in images]
    keys=set();owners={};paths=set()
    for i,historical in all_files:
        gid=i.get('game_id');require(gid in allowed,'Image outside authorized games');context(db,i,gid)
        identity=text(i.get('image_id'),'image_id');ver=text(i.get('version'),'version')
        require((identity,ver) not in keys,'Duplicate image version');keys.add((identity,ver))
        require(identity not in owners or owners[identity]==gid,'Image identity crosses games');owners[identity]=gid
        date(db,i.get('acquired_at'));text(i.get('category'),'category')
        require(type(i.get('principal',False)) is bool,'principal must be an explicit boolean')
        kind,use,val=state(i)
        require(not historical or use!='adopted','Historical file cannot be adopted')
        rel=file_check(library,i['relative_path'],i['sha256'],i['bytes'],i['format'],i['width'],i['height'],True)
        require(rel not in paths,'Duplicate local path');paths.add(rel)
        for p in i.get('provenance',[]):
            text(p.get('label'),'provenance label');document_ref(db,p,gid,library,verified)
            if p.get('observed_at'):
                date(db,p['observed_at'])
        for p in i.get('occurrences',[]):
            document_ref(db,p,gid,library,verified);rectangle(p)
        for p in i.get('credits',[]):
            document_ref(db,p,gid,library,verified)
        if i.get('extraction'):
            document_ref(db,i['extraction'],gid,library,verified)
        for cid in i.get('component_ids',[]):
            owner=compmap[cid]['game_id'] if cid in compmap else existing_components.get(cid)
            require(owner==gid,'Missing/wrong component association')
        for ctx in i.get('contexts',[]):
            context(db,ctx,gid)
        for target in i.get('generation',{}).get('input_image_ids',[]):
            present=next((f for f,_ in all_files if f['image_id']==target),None)
            if present is None:
                found=db.execute('SELECT game_id FROM img_assets WHERE image_id=?',(target,)).fetchone() if installed(db) else None
                require(found is not None,'Unknown AI input image')
            require(target!=identity,'AI input cannot be itself')
        regions=i.get('side_regions',[])
        regionmap={r['side_region_id']:r for r in regions}
        require(len(regions)==len(regionmap),'Duplicate side region')
        for region in regions:
            require(rectangle(region) is not None,'Side region needs rectangle/system/page')
            document_ref(db,region,gid,library,verified)
            for target in region.get('linked_side_region_ids',[]):
                require(target in regionmap and target!=region['side_region_id'],'Invalid side region link')
        for r in i.get('relationships',[]):
            text(r.get('type'),'relationship type')
            image_target=r.get('target_image_id');component_target=r.get('target_component_id')
            require((image_target is not None)+(component_target is not None)==1,'Relationship needs one target')
            if component_target:
                owner=compmap[component_target]['game_id'] if component_target in compmap else existing_components.get(component_target)
                require(owner==gid,'Wrong target component')
            if image_target:
                target=next((f for f,_ in all_files if f['image_id']==image_target and
                             (r.get('target_version') is None or f['version']==r['target_version'])),None)
                if target is None:
                    row=db.execute('SELECT game_id FROM img_assets WHERE image_id=?',(image_target,)).fetchone() if installed(db) else None
                    require(row and row[0]==gid,'Unknown/wrong target image')
                else:
                    require(target['game_id']==gid,'Cross-game image relation requires a different explicit contract')
    for c in components:
        require(c.get('game_id') in allowed,'Component outside scope');parent(db,'games',c['game_id'])
        text(c.get('type'),'component type')
        if c.get('physical_occurrence_count') is not None:
            integer(c['physical_occurrence_count'],'physical_count')
        for side,target in component_targets(c):
            owner=owners.get(target)
            if owner is None:
                row=db.execute('SELECT game_id FROM img_assets WHERE image_id=?',(target,)).fetchone()
                owner=row[0] if row else None
            require(owner==c['game_id'],'Missing/wrong component image')
            current=next((i for i in images if i['image_id']==target),None)
            if current is not None:
                require(c['component_id'] in current.get('component_ids',[]),
                        'Component/image association must agree in both directions')
    return all_files,verified

def component_targets(c):
    result=[('whole',i) for i in c.get('image_ids',[])]
    for field,side in (('front_image_id','Fronte'),('back_image_id','Dorso')):
        if c.get(field):
            result.append((side,c[field]))
    return result

def ingest(db,m,s,library):
    files,verified=adapt(db,m,s,library)
    batchhash=digest({'manifest':m,'sources':s,'mapping':MAPPING})
    existing=db.execute('SELECT id FROM img_imports WHERE manifest_sha256=?',(batchhash,)).fetchone()
    if existing:
        return {'outcome':'already_imported','import_id':existing[0],'verified_image_files':len(files),
                'verified_documents':len(verified),'rows_added':{},'manifest_sha256':batchhash}
    counts_before={name:db.execute('SELECT count(*) FROM '+name).fetchone()[0]
                   for name, in db.execute("SELECT name FROM sqlite_master WHERE type='table' AND name LIKE 'img_%'")}
    batch=add(db,'img_imports',{'manifest_sha256':batchhash,'source_sha256':digest(s),'task_id':m['task_id'],
              'observed_at':m['checked_at'],'imported_at':now(),'manifest_json':canonical(m),
              'sources_json':canonical(s),'mapping_version':MAPPING})
    for i,_ in files:
        immutable(db,'img_assets',{'image_id':i['image_id']},{'image_id':i['image_id'],'game_id':i['game_id']})
        immutable(db,'img_files',{'image_id':i['image_id'],'version_raw':i['version']},
                  {'image_id':i['image_id'],'version_raw':i['version'],'relative_path':safe_relative(i['relative_path'],True),
                   'sha256':i['sha256'],'byte_size':i['bytes'],'format':i['format'],'width':i['width'],'height':i['height'],
                   'original_filename':i.get('original_filename'),'acquired_at':i['acquired_at']})
    for c in m.get('components',[]):
        immutable(db,'img_components',{'component_id':c['component_id']},{'component_id':c['component_id'],'game_id':c['game_id']})
    fileids={(i,v):ident for ident,i,v in db.execute('SELECT id,image_id,version_raw FROM img_files')}
    decisions=m.get('decisions',[])
    for i,historical in files:
        fileid=fileids[(i['image_id'],i['version'])]
        kind,use,val=state(i)
        if kind in ('ai_generated','ai_reworked') and val in ('approved','rejected'):
            require(any(d.get('image_id')==i['image_id'] and d.get('version')==i['version'] and d.get('outcome')==val
                        for d in decisions),'AI approval/rejection requires a dated user decision in this manifest')
        observed=date(db,i.get('observed_at',m['checked_at']))
        key={'file_id':fileid,'observed_at':observed,'payload_sha256':digest(i),'is_historical':int(historical)}
        obs,fresh=event(db,'img_asset_observations',key,{**key,'import_id':batch,'payload_json':canonical(i),
              'label':i.get('asset_title'),'subtype':i.get('subtype'),'side':i.get('side'),'origin_kind':kind,
              'material_version_raw':i.get('material_version'),'current_use':use,'validation_state':val})
        if not fresh:
            continue
        categories=[i['category'],*i.get('additional_categories',[])]
        require(len(categories)==len(set(categories)),'Duplicate image category')
        for ix,cat in enumerate(categories):
            add(db,'img_categories',{'observation_id':obs,'category':text(cat,'category'),'is_primary':int(ix==0)})
        ctxs=i.get('contexts',[{k:i[k] for k in ('entry_id','contest_id','product_id','source_record_id','material_version') if k in i}])
        for ctx in ctxs:
            context(db,ctx,i['game_id'])
            add(db,'img_contexts',{'observation_id':obs,'entry_id':ctx.get('entry_id'),'contest_id':ctx.get('contest_id'),
                'product_id':ctx.get('product_id'),'source_record_id':ctx.get('source_record_id'),
                'revision_raw':ctx.get('material_version'),'payload_json':canonical(ctx)})
        for p in unique_records(i.get('provenance',[])):
            add(db,'img_provenances',{'observation_id':obs,'label':p['label'],'source_url':p.get('source_url'),
                'acquired_file_id':document_identifier(p),'observed_at':p.get('observed_at'),'payload_json':canonical(p)})
        for p in unique_records(i.get('occurrences',[])):
            add(db,'img_occurrences',{'observation_id':obs,'acquired_file_id':document_identifier(p),
                'page':p.get('page'),'coordinates_json':rectangle(p),'coordinate_system':p.get('coordinate_system'),
                'payload_json':canonical(p)})
        regionids={}
        for r in i.get('side_regions',[]):
            regionids[r['side_region_id']]=add(db,'img_regions',{'observation_id':obs,'region_key':r['side_region_id'],
                'side':r['side'],'acquired_file_id':document_identifier(r),'page':r['page'],
                'coordinates_json':rectangle(r),'coordinate_system':r['coordinate_system'],'payload_json':canonical(r)})
        for r in i.get('side_regions',[]):
            for target in set(r.get('linked_side_region_ids',[])):
                add(db,'img_region_links',{'region_id':regionids[r['side_region_id']],'target_region_id':regionids[target]})
        for r in unique_records(i.get('relationships',[])):
            tid=r.get('target_image_id');tfile=None
            if r.get('target_version'):
                require((tid,r['target_version']) in fileids,'Unknown target file version')
                tfile=fileids[(tid,r['target_version'])];tid=None
                require(tfile!=fileid,'File cannot supersede/derive from itself')
            add(db,'img_relations',{'observation_id':obs,'relation_type':r['type'],'target_image_id':tid,
                'target_file_id':tfile,'target_component_id':r.get('target_component_id'),'payload_json':canonical(r)})
        for target in set(i.get('generation',{}).get('input_image_ids',[])):
            add(db,'img_relations',{'observation_id':obs,'relation_type':'ai_input','target_image_id':target,
                'target_file_id':None,'target_component_id':None,'payload_json':canonical({'input_image_id':target})})
    for c in m.get('components',[]):
        key={'component_id':c['component_id'],'observed_at':m['checked_at'],'payload_sha256':digest(c)}
        obs,fresh=event(db,'img_component_observations',key,{**key,'import_id':batch,'subtype':c['type'],
            'label':c.get('label'),'material_revision_raw':c.get('material_revision'),
            'physical_count':c.get('physical_occurrence_count'),'payload_json':canonical(c)})
        if fresh:
            for side,target in set(component_targets(c)):
                add(db,'img_component_links',{'component_observation_id':obs,'image_id':target,'side':side})
    applicability={'applicabile':'applicable','applicable':'applicable','desiderata':'desired','desired':'desired',
                   'non applicabile':'not_applicable','not_applicable':'not_applicable'}
    for g in m.get('games',[]):
        key={'game_id':g['game_id'],'entry_id':g.get('entry_id'),'contest_id':g.get('contest_id'),
             'observed_at':g.get('checked_at',m['checked_at']),'payload_sha256':digest(g)}
        research,fresh=event(db,'img_research_observations',key,{**key,'import_id':batch,'complete':int(g['research_complete']),
                      'status_raw':g['research_status'],'payload_json':canonical(g)})
        if fresh:
            for cat in g.get('categories',[]):
                add(db,'img_category_research',{'research_id':research,'category':cat['category'],'research_raw':cat['research'],
                    'applicability':applicability.get(cat.get('applicability'),'unknown'),
                    'verified_absence':int(cat['verified_absence']),'original_count':cat['adopted_original_count'],
                    'ai_count':cat['validated_ai_count'],'pending_count':cat['pending_ai_count'],'payload_json':canonical(cat)})
    for d in decisions:
        require((d.get('image_id'),d.get('version')) in fileids,'Decision references unknown image version')
        date(db,d.get('decided_at'))
        require(d.get('outcome') in ('pending','approved','rejected'),'Unknown decision outcome')
        if d['outcome']!='pending':
            text(d.get('confirmation_ref'),'user confirmation_ref')
        decisionkey=text(d.get('decision_key'),'decision_key')
        old=db.execute('SELECT payload_json FROM img_decisions WHERE decision_key=?',(decisionkey,)).fetchone()
        if old:
            require(old[0]==canonical(d),'Decision key reused with different content')
        else:
            add(db,'img_decisions',{'file_id':fileids[(d['image_id'],d['version'])],'import_id':batch,
                'decision_key':decisionkey,'outcome':d['outcome'],'decided_at':d['decided_at'],
                'confirmation_ref':d.get('confirmation_ref'),'reason':d.get('reason'),'payload_json':canonical(d)})
    selections=list(m.get('primary_selections',[]))
    selections += [{'game_id':i['game_id'],'image_id':i['image_id'],'selected_at':m['checked_at'],
                    'evidence_ref':m['task_id']+': manifest principal=true'} for i in m['images'] if i.get('principal') is True]
    require(len({p['game_id'] for p in selections})==len(selections),'Multiple principal selections for one game')
    for p in selections:
        require(p['game_id'] in m['scope']['authorized_game_ids'],'Principal outside scope')
        if p.get('image_id') is not None:
            row=db.execute('SELECT game_id FROM img_assets WHERE image_id=?',(p['image_id'],)).fetchone()
            require(row and row[0]==p['game_id'],'Principal refers to another/unknown game')
        date(db,p.get('selected_at'));text(p.get('evidence_ref'),'principal evidence_ref')
        key={'game_id':p['game_id'],'selected_at':p['selected_at'],'payload_sha256':digest(p)}
        event(db,'img_primary_selections',key,{**key,'import_id':batch,'image_id':p.get('image_id'),'evidence_ref':p['evidence_ref']})
    for image_id,val,outcome in db.execute('SELECT a.image_id,a.validation_state,d.outcome FROM img_current_assets a '
            "LEFT JOIN img_current_decisions d ON d.file_id=a.file_id WHERE a.origin_kind IN ('ai_generated','ai_reworked')"):
        require(val==(outcome or 'pending'),f'AI observation contradicts latest decision: {image_id}')
    after={name:db.execute('SELECT count(*) FROM '+name).fetchone()[0] for name in counts_before}
    return {'outcome':'imported','import_id':batch,'manifest_sha256':batchhash,
            'rows_added':{name:after[name]-count for name,count in counts_before.items() if after[name]!=count},
            'verified_image_files':len(files),'verified_documents':len(verified),
            'research_complete':sum(g['research_complete'] for g in m['games']),
            'research_partial_or_unknown':sum(not g['research_complete'] for g in m['games'])}

def unique_records(records):
    seen=set()
    for record in records:
        key=canonical(record)
        if key not in seen:
            seen.add(key);yield record

def simulate(path,m,s,library):
    with open_db(path) as ro:
        ro.execute('BEGIN');validate(ro)
        source_inventory=inventory(ro)
        mem=sqlite3.connect(':memory:')
        ro.backup(mem)
    try:
        mem.execute('PRAGMA foreign_keys=ON')
        names=legacy_names(mem);legacy=inventory(mem,names)
        mem.execute('BEGIN')
        migration_needed=migrate(mem)
        report=ingest(mem,m,s,library)
        validate(mem)
        require(inventory(mem,names)==legacy,'Legacy unexpectedly changed')
        report.update({'migration_needed':migration_needed,'legacy_preserved':True,'conflicts':[]})
        return report,source_inventory
    finally:
        mem.close()

def run(database,manifest,sources,library_root=ROOT/'library',apply=False,authorization='',backup_dir=ROOT/'outputs/image-catalog-014',fail_after_import=False):
    m=read_json(manifest);s=read_json(sources)
    require(Path(manifest).resolve()!=Path(database).resolve() and Path(sources).resolve()!=Path(database).resolve(),'Input/target collision')
    planned_sql_hash=hashlib.sha256(MIGRATION.read_bytes()).hexdigest()
    preview,before=simulate(database,m,s,library_root)
    if not apply:
        return {**preview,'outcome':'preview','would_outcome':preview['outcome'],'database_written':False}
    require(bool(authorization.strip()),'Explicit --authorization required for application')
    if preview['outcome']=='already_imported':
        return {**preview,'database_written':False}
    with open_db(database) as ro:
        ro.execute('BEGIN')
        require(inventory(ro)==before,'Target changed since preview')
        evidence,snap=backup(ro,backup_dir)
        names=legacy_names(ro);legacy=inventory(ro,names)
    with open_db(database,True) as db:
        try:
            db.execute('BEGIN EXCLUSIVE')
            require(inventory(db)==before==snap,'Target changed after backup')
            require(hashlib.sha256(MIGRATION.read_bytes()).hexdigest()==planned_sql_hash,'Migration changed since preview')
            require(read_json(manifest)==m and read_json(sources)==s,'Input changed since preview')
            migrate(db)
            result=ingest(db,m,s,library_root)
            if fail_after_import:
                raise Conflict('Synthetic failure before commit')
            validate(db)
            require(inventory(db,names)==legacy,'Legacy changed during import')
            db.commit()
        except BaseException:
            db.rollback();raise
    with open_db(database) as final:
        validate(final)
        require(inventory(final,names)==legacy,'Legacy mismatch after commit')
    return {**result,**evidence,'database_written':True,'legacy_preserved':True,
            'migration_sha256':planned_sql_hash,'authorization':authorization}

def main():
    p=argparse.ArgumentParser(description=__doc__)
    for flag in ('database','manifest','sources'):
        p.add_argument('--'+flag,type=Path,required=True)
    p.add_argument('--library-root',type=Path,default=ROOT/'library')
    p.add_argument('--backup-dir',type=Path,default=ROOT/'outputs/image-catalog-014')
    p.add_argument('--apply',action='store_true');p.add_argument('--authorization',default='')
    p.add_argument('--report',type=Path)
    a=p.parse_args()
    if a.report:
        require(a.report.resolve() not in {a.database.resolve(),a.manifest.resolve(),a.sources.resolve()}
                and not a.report.resolve().is_relative_to((ROOT/'library').resolve()),
                'Report cannot overwrite input/target or acquired library')
    try:
        result=run(a.database,a.manifest,a.sources,a.library_root,a.apply,a.authorization,a.backup_dir)
        exitcode=0
    except (ValueError,KeyError,TypeError,OSError,sqlite3.Error,PDFError) as error:
        result={'outcome':'conflict','database_written':False,'conflicts':[str(error)]};exitcode=2
    if a.report:
        a.report.parent.mkdir(parents=True,exist_ok=True)
        a.report.write_text(json.dumps(result,ensure_ascii=False,indent=2)+'\n',encoding='utf8')
    print(json.dumps(result,ensure_ascii=False))
    return exitcode

if __name__=='__main__':
    raise SystemExit(main())
