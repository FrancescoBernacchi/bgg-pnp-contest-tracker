"""Temporary loopback form to save observed browser metadata privately.

One fixed JSON output; no database, shell, remote requests, arbitrary paths or uploads.
"""
import json,html
from pathlib import Path
from http.server import ThreadingHTTPServer,BaseHTTPRequestHandler
from urllib.parse import parse_qs
R=Path(__file__).resolve().parents[2];DEST=R/'outputs/tsk0088/browser-evidence.json'
PAGE=b'''<!doctype html><html><head><title>TSK-0088 local evidence</title></head><body><h1>TSK-0088 local evidence</h1><p>Save observed metadata to outputs/tsk0088/browser-evidence.json only.</p><form method="post" action="/save"><label for="payload">Observed metadata JSON</label><textarea id="payload" name="payload" rows="16" cols="100"></textarea><button type="submit">Save local evidence</button></form></body></html>'''
class Handler(BaseHTTPRequestHandler):
 def do_GET(self):
  if self.path!='/':self.send_error(404);return
  page=PAGE
  if DEST.exists():page=PAGE.replace(b'</textarea>',html.escape(DEST.read_text(encoding='utf-8')).encode()+b'</textarea>')
  self.send_response(200);self.send_header('Content-Type','text/html; charset=utf-8');self.end_headers();self.wfile.write(page)
 def do_POST(self):
  if self.path!='/save' or self.headers.get('Origin')!='http://127.0.0.1:8880':self.send_error(403);return
  count=int(self.headers.get('Content-Length','0'))
  if count>8*1024*1024:self.send_error(413);return
  try:
   data=json.loads(parse_qs(self.rfile.read(count).decode())['payload'][0]);assert data['task_id']=='TSK-0088'
   DEST.parent.mkdir(parents=True,exist_ok=True);DEST.write_text(json.dumps(data,ensure_ascii=False,indent=2),encoding='utf-8')
   self.send_response(200);self.send_header('Content-Type','text/html; charset=utf-8');self.end_headers();self.wfile.write(('<h1>Evidence saved</h1><p>WIP pages: '+str(len(data.get('scans',[])))+'; original links: '+str(len(data.get('remoteCandidates',[])))+'</p><a href="/">Back to form</a>').encode())
  except Exception as error:self.send_error(400,str(error))
 def log_message(self,*args):pass
print('TSK-0088 receiver listening on 127.0.0.1:8880',flush=True)
ThreadingHTTPServer(('127.0.0.1',8880),Handler).serve_forever()
