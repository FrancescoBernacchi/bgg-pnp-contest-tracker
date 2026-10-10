"""Read-only IMG projection and verified local raster responses; no acquisition."""
from collections import OrderedDict
import hashlib
import io
import json
import os
from pathlib import Path
import threading
import warnings

from pdf_files import PDFError, confined_path, check_handle

FORMATS={'PNG':'image/png','JPEG':'image/jpeg','WEBP':'image/webp'}
_cache=OrderedDict()
_cache_lock=threading.Lock()
_decode_slots=threading.BoundedSemaphore(2)
_CACHE_BYTES=24*1024*1024

def select(db,sql,args=()):
    cursor=db.execute(sql,args)
    return [dict(zip([c[0] for c in cursor.description],row)) for row in cursor]

def supported(db):
    return db.execute("SELECT 1 FROM sqlite_master WHERE type='view' AND name='img_current_assets'").fetchone() is not None

def file_record(db,file_id):
    if not supported(db):raise LookupError('Catalogo immagini non disponibile')
    result=select(db,'SELECT f.*,a.game_id FROM img_files f JOIN img_assets a ON a.image_id=f.image_id WHERE f.id=?',(file_id,))
    if not result:raise LookupError('Immagine non registrata')
    return result[0]

def local_status(root,file):
    if file['format'] not in FORMATS:return 'unsupported'
    try:
        if not file['relative_path'].replace('\\','/').startswith('immagini/'):
            return 'invalid_path'
        _,path=confined_path(root,file['relative_path'])
        return 'ready' if path.stat().st_size==file['byte_size'] else 'changed'
    except PDFError as e:return e.code
    except OSError:return 'unverifiable'

def material_revision_notice(payload):
    """A prior material revision requires an explicit status AND succession evidence."""
    scopes=[payload,payload.get('extraction') or {},*(payload.get('contexts') or [])]
    for scope in scopes:
        if not isinstance(scope,dict):continue
        status=scope.get('material_revision_status',scope.get('revision_status'))
        evidence=scope.get('material_revision_evidence',scope.get('revision_evidence'))
        if status in ('previous','precedente') and evidence:
            return {'status':'previous','evidence':evidence}
        if status in ('current','corrente') and evidence:
            return {'status':'current','evidence':evidence}
    return {'status':'unknown','evidence':None}

def image_catalog(db,game_id,library_root):
    result={'available':supported(db),'files':[],'components':[],'research':[],'principal':None}
    if not result['available']:return result
    current={r['image_id']:r for r in select(db,'SELECT id,image_id,file_id FROM img_current_assets WHERE game_id=?',(game_id,))}
    for f in select(db,'''SELECT f.* FROM img_files f JOIN img_assets a ON a.image_id=f.image_id
                         WHERE a.game_id=? ORDER BY f.image_id COLLATE NOCASE,f.id''',(game_id,)):
        observations=select(db,'''SELECT * FROM img_asset_observations WHERE file_id=?
                               ORDER BY julianday(observed_at) DESC,id DESC''',(f['id'],))
        if not observations:continue
        active=current.get(f['image_id'])
        is_current=active is not None and active['file_id']==f['id']
        o=next(obs for obs in observations if obs['id']==active['id']) if is_current else observations[0]
        payload=json.loads(o['payload_json'])
        f['filename']=Path(f.pop('relative_path')).name
        private=file_record(db,f['id'])
        f['local_status']=local_status(library_root,private)
        f.update({k:o[k] for k in ('origin_kind','current_use','validation_state','material_version_raw','side','subtype','observed_at')})
        f['title']=o['label'] or f['original_filename'] or f['filename']
        f['is_current']=is_current
        f['categories']=[r['category'] for r in select(db,'SELECT category FROM img_categories WHERE observation_id=? ORDER BY is_primary DESC,category',(o['id'],))]
        f['provenances']=[json.loads(r['payload_json']) for r in select(db,'SELECT payload_json FROM img_all_provenances WHERE image_id=? ORDER BY label,source_url',(f['image_id'],))]
        for name,table in [('occurrences','img_occurrences'),('regions','img_regions'),('contexts','img_contexts'),('relations','img_relations')]:
            f[name]=[json.loads(r['payload_json']) for r in select(db,f'SELECT payload_json FROM {table} WHERE observation_id=? ORDER BY id',(o['id'],))]
        f['credits']=payload.get('credits',[]);f['conditions']=payload.get('conditions',{})
        f['generation']=payload.get('generation',{});f['extraction']=payload.get('extraction',{})
        f['material_revision']=material_revision_notice(payload)
        f['decisions']=select(db,'''SELECT outcome,decided_at,confirmation_ref,reason FROM img_decisions
                                  WHERE file_id=? ORDER BY julianday(decided_at),id''',(f['id'],))
        f['history']=[{k:obs[k] for k in ('observed_at','current_use','validation_state','material_version_raw')} for obs in reversed(observations)]
        result['files'].append(f)
    for c in select(db,'''SELECT o.* FROM img_current_components o JOIN img_components c ON c.component_id=o.component_id
                         WHERE c.game_id=? ORDER BY o.component_id''',(game_id,)):
        payload=json.loads(c['payload_json'])
        result['components'].append({'component_id':c['component_id'],'type':c['subtype'],'label':c['label'] or payload.get('name') or c['component_id'],
            'material_revision':c['material_revision_raw'],'physical_count':c['physical_count'],
            'assembly':payload.get('assembly',payload.get('assembly_note')),
            'links':select(db,'SELECT image_id,side FROM img_component_links WHERE component_observation_id=? ORDER BY side,image_id',(c['id'],))})
    for r in select(db,'SELECT * FROM img_current_research WHERE game_id=? ORDER BY id',(game_id,)):
        result['research'].append({'complete':bool(r['complete']),'status':r['status_raw'],'observed_at':r['observed_at'],
            'entry_id':r['entry_id'],'contest_id':r['contest_id'],'details':json.loads(r['payload_json']),
            'categories':select(db,'SELECT category,research_raw,applicability,verified_absence,original_count,ai_count,pending_count,payload_json FROM img_category_research WHERE research_id=? ORDER BY category',(r['id'],))})
    p=select(db,'SELECT image_id,selected_at,evidence_ref FROM img_current_primary WHERE game_id=?',(game_id,))
    result['principal']=p[0] if p else None
    from image_progress import image_summaries
    summary=image_summaries(db,library_root).get(game_id,{})
    result['main']=summary.get('main',{})
    result['coverage']=summary.get('coverage',[])
    return result

def raster_response(root,file,thumbnail=False):
    """Verify a stable confined handle every time, including before cache reuse."""
    if file['format'] not in FORMATS:raise PDFError(415,'unsupported','Formato conservato ma senza anteprima disponibile.')
    if not file['relative_path'].replace('\\','/').startswith('immagini/'):
        raise PDFError(403,'invalid_path','Percorso immagini non autorizzato.')
    root,path=confined_path(root,file['relative_path'])
    with _decode_slots:
        try:
            with os.fdopen(os.open(path,os.O_RDONLY|getattr(os,'O_BINARY',0)|getattr(os,'O_NOFOLLOW',0)),'rb') as handle:
                check_handle(handle,root,path);before=os.fstat(handle.fileno())
                if before.st_size>128*1024*1024:raise PDFError(413,'too_large','Immagine oltre il limite di visualizzazione.')
                data=handle.read()
                after=os.fstat(handle.fileno());check_handle(handle,root,path)
                if before.st_size!=file['byte_size'] or (before.st_size,before.st_mtime_ns)!=(after.st_size,after.st_mtime_ns) or hashlib.sha256(data).hexdigest()!=file['sha256']:
                    raise PDFError(409,'changed','Il file non corrisponde più alla versione registrata. Riesaminare il manifest IMG.')
        except FileNotFoundError:raise PDFError(404,'missing','Il file immagine locale non è più presente.') from None
        key=(file['sha256'],file['format'],file['width'],file['height'])
        if thumbnail:
            with _cache_lock:
                if key in _cache:
                    _cache.move_to_end(key);return _cache[key],'image/png'
        from PIL import Image,ImageOps,UnidentifiedImageError
        try:
            with warnings.catch_warnings():
                warnings.simplefilter('error',Image.DecompressionBombWarning)
                with Image.open(io.BytesIO(data)) as im:
                    if im.format!=file['format'] or im.size!=(file['width'],file['height']):
                        raise PDFError(409,'changed','Formato o dimensioni discordanti dal catalogo.')
                    if im.width*im.height>40_000_000 or max(im.size)>16000:
                        raise PDFError(413,'too_large','Immagine oltre i limiti di decodifica.')
                    if getattr(im,'n_frames',1)!=1:raise PDFError(415,'unsupported','Immagine animata o multipagina non supportata.')
                    im.load()
                    if thumbnail:
                        oriented=ImageOps.exif_transpose(im);oriented.thumbnail((360,240));out=io.BytesIO()
                        oriented.convert('RGBA' if 'A' in oriented.getbands() else 'RGB').save(out,format='PNG')
                        body=out.getvalue()
                        with _cache_lock:
                            _cache[key]=body;_cache.move_to_end(key)
                            while len(_cache)>128 or sum(map(len,_cache.values()))>_CACHE_BYTES:_cache.popitem(last=False)
                        return body,'image/png'
        except (OSError,ValueError,UnidentifiedImageError,Image.DecompressionBombError,Image.DecompressionBombWarning):
            raise PDFError(422,'corrupt','Immagine non decodificabile in sicurezza.') from None
    return data,FORMATS[file['format']]
