"""Read the remaining official Kanare pages and EN/IT PDFs, with local evidence outside Git."""
import contextlib
import io
import json
import re
from pathlib import Path
from inspect_kanare_materials import inspect, OUT, ROOT

BASE=OUT/'BASELINE.json'

def language(url,label=''):
    s=(url+' '+label).lower()
    for token,code in [('_jp','ja'),('_ja','ja'),('_en','en'),('_es','es'),('_cn','zh'),('_it','it')]:
        if token in s:return code
    return None

def main():
    baseline=json.loads(BASE.read_text(encoding='utf8'))
    journal_path=OUT/'consultations.json'
    journal=json.loads(journal_path.read_text(encoding='utf8')) if journal_path.exists() else []
    done={x['url'] for x in journal if x['status']=='read'}
    existing={json.loads(p.read_text(encoding='utf8'))['url']:p for p in OUT.glob('*.json') if p.name not in ('consultations.json','BASELINE.json') and 'url' in json.loads(p.read_text(encoding='utf8'))}
    pages=[r['canonical_url'] for r in baseline['source_records'] if r['record_type'] in ('game_page','product_page','work_index')]
    # Read actual source records by URL shape; never open platform matrices/destinations.
    pages=[r['canonical_url'] for r in baseline['source_records'] if '/products/' in r['canonical_url'] or '/pages/' in r['canonical_url'] and not r['canonical_url'].endswith('/online_play')]
    targets=list(dict.fromkeys(pages))
    for url in targets:
        if url in done:continue
        key='page-'+str(next(r['id'] for r in baseline['source_records'] if r['canonical_url']==url))
        try:
            if url in existing:
                data=json.loads(existing[url].read_text(encoding='utf8'));key=existing[url].stem
            else:
                with contextlib.redirect_stdout(io.StringIO()):data=inspect(url,key)
            journal.append({'url':url,'key':key,'status':'read','kind':'html','verified_at':'2026-10-06'})
            print('PAGE',key,len(data['text']))
        except Exception as e:
            journal.append({'url':url,'key':key,'status':'not_observable','error':str(e),'kind':'html','verified_at':'2026-10-06'});print('BLOCK',url,str(e))
        journal_path.write_text(json.dumps(journal,ensure_ascii=False,indent=2),encoding='utf8')
    pdfs={r['url']:r.get('language_code') for r in baseline['resources'] if r['resource_kind']=='rules'}
    for p in OUT.glob('*.json'):
        if p.name in ('consultations.json','BASELINE.json'):continue
        d=json.loads(p.read_text(encoding='utf8'))
        for a in d.get('links',[]):
            if '.pdf' in a['url'].lower():pdfs[a['url']]=language(a['url'],a['label'])
    local_manifest=json.loads((ROOT/'catalog/kanare_abstract_acquisition_batch_2026-09-21.json').read_text(encoding='utf8'))
    locals={i['resource_url']:ROOT/'library'/i['relative_path'] for i in local_manifest['items']}
    done={x['url'] for x in journal if x['status']=='read'}
    for n,(url,lang) in enumerate(pdfs.items(),1):
        if url in done:continue
        key='pdf-'+str(n)
        if lang not in ('en','it'):
            journal.append({'url':url,'key':None,'status':'metadata_only_language_excluded','language':lang,'kind':'pdf','verified_at':'2026-10-06'})
        else:
            try:
                if url in existing:
                    data=json.loads(existing[url].read_text(encoding='utf8'));key=existing[url].stem
                else:
                    with contextlib.redirect_stdout(io.StringIO()):data=inspect(url,key,locals.get(url))
                journal.append({'url':url,'key':key,'status':'read','language':lang,'kind':'pdf','pages':len(data['pages']),'verified_at':'2026-10-06','sha256':data['sha256']})
                print('PDF',key,len(data['pages']),url)
            except Exception as e:
                journal.append({'url':url,'key':key,'status':'not_observable','language':lang,'error':str(e),'kind':'pdf','verified_at':'2026-10-06'});print('BLOCK',url,str(e))
        journal_path.write_text(json.dumps(journal,ensure_ascii=False,indent=2),encoding='utf8')

if __name__=='__main__':main()
