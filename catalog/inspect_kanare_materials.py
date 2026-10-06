"""Consult official HTML/PDF in memory. Store only local text evidence, never new PDF files."""
import argparse
import hashlib
import io
import json
import re
from pathlib import Path
from urllib.parse import urljoin, urlparse
from urllib.request import Request, urlopen
from html.parser import HTMLParser
import pdfplumber

ROOT=Path(__file__).resolve().parents[1]
OUT=ROOT/'outputs/kanare-mat-2026-10-06'
ALLOWED={'kanare-abstract.com','kanareabstract.myshopify.com','cdn.shopify.com'}

class MainParser(HTMLParser):
    def __init__(self):
        super().__init__(); self.active=False; self.skip=0; self.parts=[]; self.links=[]; self.images=[]; self.anchor=None
    def handle_starttag(self,tag,attrs):
        d=dict(attrs)
        if tag=='main': self.active=True
        if not self.active: return
        if tag in ('script','style'): self.skip+=1
        if tag=='a': self.anchor={'url':d.get('href',''),'label':''}; self.links.append(self.anchor)
        if tag=='img': self.images.append({'url':d.get('src',''),'alt':d.get('alt')})
    def handle_endtag(self,tag):
        if tag=='main': self.active=False
        if tag in ('script','style') and self.skip: self.skip-=1
        if tag=='a': self.anchor=None
        if self.active and tag in ('p','div','li','h1','h2','h3','tr'): self.parts.append('\n')
    def handle_data(self,data):
        if self.active and not self.skip:
            self.parts.append(data)
            if self.anchor: self.anchor['label']+=data

def read(url):
    if urlparse(url).hostname not in ALLOWED: raise ValueError('Host excluded')
    with urlopen(Request(url,headers={'User-Agent':'Mozilla/5.0'}),timeout=35) as r:
        if urlparse(r.geturl()).hostname not in ALLOWED: raise ValueError('Redirect excluded')
        return r.geturl(),r.headers.get('Content-Type'),r.read()

def inspect(url, key, local=None):
    OUT.mkdir(exist_ok=True)
    final,mime,data=(url,'application/pdf',Path(local).read_bytes()) if local else read(url)
    result={'url':url,'final_url':final,'verified_at':'2026-10-06','mime':mime,'sha256':hashlib.sha256(data).hexdigest(), 'local_reuse':bool(local)}
    if mime and 'pdf' in mime:
        with pdfplumber.open(io.BytesIO(data)) as pdf:
            result['pages']=[{'page':i+1,'text':p.extract_text() or ''} for i,p in enumerate(pdf.pages)]
        result['text']='\n'.join(f"[Page {p['page']}]\n{p['text']}" for p in result['pages'])
        result['status']='text_extracted_requires_review'
    else:
        parser=MainParser();parser.feed(data.decode('utf-8','replace'))
        result['links']=[{'url':urljoin(final,a['url']),'label':a['label'].strip()} for a in parser.links]
        result['images']=[{'url':urljoin(final,i['url']),'alt':i['alt']} for i in parser.images]
        result['text']='\n'.join(x.strip() for x in ''.join(parser.parts).splitlines() if x.strip())
        result['status']='text_extracted_requires_review'
    (OUT/(key+'.json')).write_text(json.dumps(result,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
    print(result['text'])
    if 'links' in result: print('\nPDF LINKS',json.dumps([x for x in result['links'] if '.pdf' in x['url']],ensure_ascii=False))
    return result

if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('url');p.add_argument('key');p.add_argument('--local');a=p.parse_args()
    inspect(a.url,a.key,a.local)
