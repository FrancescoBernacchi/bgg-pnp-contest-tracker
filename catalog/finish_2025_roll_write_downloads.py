"""Acquisisce immagini dichiarate e archivi Dropbox pubblici, senza eseguire contenuti."""
import importlib.util, re
from pathlib import Path
from urllib.parse import urlparse,parse_qsl,urlencode,urlunparse
spec=importlib.util.spec_from_file_location('collector',Path(__file__).with_name('acquire_2025_roll_write.py'))
a=importlib.util.module_from_spec(spec); spec.loader.exec_module(a)
for row in a.rows:
    if row['kind'] in ('video','online_play','tool'): continue
    obs=next(x for x in a.m['resource_observations'] if x['remote_resource_id']==row['id'])
    if obs['availability_status']=='available': continue
    url=row['url']; ok=False
    try:
        if 'drive.google.com/file/d/' in url:
            fid=url.split('/file/d/')[1].split('/')[0]
            body,final,mime,_=a.fetch(url); title=re.search(r'<title>(.*?)</title>',body.decode('utf-8','replace'),re.S)
            name=a.html.unescape(title.group(1)).replace(' - Google Drive','') if title else None
            ok=a.download('https://drive.usercontent.google.com/download?id='+fid+'&export=download',name,row)
        elif 'dropbox.com/scl/fo/' in url:
            parts=urlparse(url); query=dict(parse_qsl(parts.query)); query['dl']='1'
            ok=a.download(urlunparse(parts._replace(query=urlencode(query))),row['game_title']+' - shared folder.zip',row)
        if ok: obs['availability_status']='available'; obs['notes']='Originale acquisito; formato verificato dalla firma binaria.'
    except Exception as ex: obs['notes']+='; '+str(ex)
    a.save(); print(row['game_title'],row['id'],ok,flush=True)
