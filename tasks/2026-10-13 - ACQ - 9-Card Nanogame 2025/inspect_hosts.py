from pathlib import Path
import urllib.request,json,re
out=Path('outputs/nine-card-acq-2026-10-13')
for key,url in [('demo-notes','https://docs.google.com/document/d/1JsP__-QwJd119vnE_64PsV8tmAEr52_KBN41gffGDAk/export?format=txt'),('large-warning','https://drive.usercontent.google.com/download?id=1MM4mwYyeLAxcGfBl2QG2AD1_Lyix9zEf&export=download')]:
 with urllib.request.urlopen(url,timeout=25) as r: data=r.read()
 (out/(key+'.txt')).write_bytes(data)
 print(key,json.dumps(data.decode('utf-8','replace')[:9000],ensure_ascii=True))
