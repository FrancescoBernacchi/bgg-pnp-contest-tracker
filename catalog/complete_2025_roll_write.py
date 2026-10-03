"""Completa enumerazione pubblica di cartelle e link osservati; non applica dati."""
import importlib.util, json, re, urllib.error
from pathlib import Path
from urllib.parse import urljoin, urlparse, parse_qsl, urlencode, urlunparse
spec=importlib.util.spec_from_file_location('collector',Path(__file__).with_name('acquire_2025_roll_write.py'))
a=importlib.util.module_from_spec(spec); spec.loader.exec_module(a)
def folder(url,row,depth=0):
    if depth>3: return ['Profondità cartelle oltre tre livelli: da verificare']
    body,final,mime,_=a.fetch(url); text=body.decode('utf-8','replace'); page=a.Page(text)
    subfolders=[(name,fid) for fid,name in page.folders.items()]
    a.m['page_audits'].append(dict(resource_id=row['id'],url=url,files=page.files,subfolders=subfolders))
    notes=[]
    for fid,name in page.files.items():
        if re.search(r'sell.?sheet|pitch|promo|^title\.|^cover\.',name,re.I): notes.append('Promozionale escluso: '+name); continue
        try:
            ok=a.download('https://drive.usercontent.google.com/download?id='+fid+'&export=download',name,row)
            if not ok: notes.append('Download non PDF: '+name)
        except Exception as ex: notes.append(name+': '+str(ex))
    for name,fid in subfolders:
        if re.search(r'old|archive|previous|obsolete|tts|tabletop',name,re.I): notes.append('Archivio storico o implementazione digitale esclusa: '+name); continue
        notes+=folder('https://drive.google.com/drive/folders/'+fid,row,depth+1)
    notes.append(f'Cartella enumerata: {len(page.files)} PDF e {len(subfolders)} sottocartelle')
    return notes
for row in a.rows:
    if row['kind'] in ('video','online_play','tool'): continue
    obs=next(x for x in a.m['resource_observations'] if x['remote_resource_id']==row['id'])
    url=row['url']; notes=[]; before=len(a.m['items'])
    try:
        if 'drive.google.com/drive/folders/' in url: notes=folder(url,row)
        elif 'dropbox.com/scl/fi/' in url:
            parts=urlparse(url); query=dict(parse_qsl(parts.query)); query['dl']='1'
            ok=a.download(urlunparse(parts._replace(query=urlencode(query))),None,row)
            notes.append('Download diretto Dropbox PDF' if ok else 'Dropbox non ha restituito un PDF')
        elif obs['availability_status']=='unknown' and 'drive.google.com/file/d/' not in url:
            links=[link for audit in a.m['page_audits'] if audit['resource_id']==row['id'] for link in audit.get('links',[])]
            for link in dict.fromkeys(links):
                try:
                    if '/drive/folders/' in link: notes+=folder(link,row)
                    elif '/file/d/' in link:
                        fid=link.split('/file/d/')[1].split('/')[0]
                        a.download('https://drive.usercontent.google.com/download?id='+fid+'&export=download',None,row)
                    elif '.pdf' in link or 'sdm_process_download' in link: a.download(link,None,row)
                except Exception as ex: notes.append(link+': '+str(ex))
    except Exception as ex: notes.append(str(ex))
    if any(x['remote_resource_id']==row['id'] for x in a.m['items']): obs['availability_status']='available'
    if notes: obs['notes']='; '.join(notes)
    a.save(); print(row['game_title'],row['id'],len(a.m['items'])-before,'; '.join(notes)[:180],flush=True)
