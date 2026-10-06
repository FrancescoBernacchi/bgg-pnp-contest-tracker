"""Render a consultation page in memory, outside the library and without PDF persistence."""
import io
import hashlib
import json
import sys
import pdfplumber
from inspect_kanare_materials import OUT, read

key=sys.argv[1]
data=json.loads((OUT/(key+'.json')).read_text(encoding='utf8'))
_,_,content=read(data['url'])
assert hashlib.sha256(content).hexdigest()==data['sha256'], 'Document changed since textual consultation; do not reuse the observation silently'
with pdfplumber.open(io.BytesIO(content)) as pdf:
    pdf.pages[int(sys.argv[2])-1].to_image(resolution=100).save(OUT/(key+'-p'+sys.argv[2]+'.png'))
print(key, 'rendered for consultation')
