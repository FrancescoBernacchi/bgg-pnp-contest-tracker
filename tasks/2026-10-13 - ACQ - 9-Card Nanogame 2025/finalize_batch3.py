import json,hashlib
from pathlib import Path
from datetime import datetime,timezone
ROOT=Path(__file__).resolve().parents[2];TASK=Path(__file__).parent;OUT=ROOT/'outputs/nine-card-acq-2026-11-06';MAN=ROOT/'catalog/2025_nine_card_batch3_acquisition_2026-11-06.json'
m=json.loads(MAN.read_text(encoding='utf8'));assert not m.get('verification'), 'Finalized manifest is immutable; prepare a new increment';s=json.loads((TASK/'SELECTION_2026-11-06.json').read_text(encoding='utf8'));evidence=json.loads((ROOT/'tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json').read_text(encoding='utf8'))
m['selection']=s['entries'];m.update(target_complete_games=20,original_selection_count=20,replacement_candidates=5,acquired_at='2026-11-06',scope_note='Regole, componenti e aiuti stampabili gratuiti IT/EN nel perimetro MAT del primo post; versioni offerte nelle cartelle, esclusi video/PCIO/implementazioni/asset IMG e sorgenti grafici. Nessuna redistribuzione.')
for e in m['selection']:
 ev=next((v for v in evidence['entries'] if v.get('entry_id')==e['entry_id']),{});e.update(wip_post_author=ev.get('h','Non osservabile').split(';')[0] or 'Non osservabile',credit_source_date='2026-10-04',credit_role='wip_post_author',credit_limit='Non equiparato a designer/illustratore/editore; ruoli mancanti non ricostruiti per inferenza.')
for x in m['items']:
 data=(ROOT/'library'/x['relative_path']).read_bytes();assert len(data)==x['byte_size'] and hashlib.sha256(data).hexdigest()==x['sha256']
 x.update(selection_reason='Ulteriori 20 giochi dello stesso contest richiesti 2026-11-06, candidati successivi per sostituire blocchi e parziali',source_remote_resource_ids=x.get('source_remote_resource_ids',[x['remote_resource_id']]),transferred_at=datetime.fromtimestamp((ROOT/'library'/x['relative_path']).stat().st_mtime,timezone.utc).isoformat(),language_code='en',language_status='content_review; rendering_first_page_pending',status='acquired_pending_render_verification')
 if x['media_type']=='text/plain':assert data.decode('utf8').strip();x['language_status']='English printing instructions verified, original UTF-8 text'
 if x['entry_id']==427 and 'Multilingual' in x['original_filename']:x['language_code']='mul';x['language_status']='Multilingual components compatible with English rules; original indivisible PDF preserved'
blocked={423:'Cartella Drive richiede accesso: nessun aggiramento o richiesta al proprietario.',438:'Cartella dichiarata HTTP 404 alla verifica; video/TTS esclusi.',442:'Tutti e tre i PDF dichiarati HTTP 404.'}
partial={450:'Solo Cards v4.0 acquisito; due riferimenti (regole/componenti) HTTP 404, video escluso.',464:'Esportazione PDF delle regole PCIO acquisita; cartella offre solo regole e PCIO, nessun componente stampabile osservato. Implementazione esclusa.'}
m['entry_outcomes']=[]
for e in m['selection']:
 eid=e['entry_id'];items=[x for x in m['items'] if x['entry_id']==eid];outcome='blocked' if eid in blocked else 'partial' if eid in partial else 'complete';notes=blocked.get(eid) or partial.get(eid) or 'Regole e componenti/aiuti IT/EN offerti acquisiti; inventario cartelle confrontato dove pertinente, esclusioni documentate.'
 m['entry_outcomes'].append(dict(entry_id=eid,game_id=e['game_id'],title=e['title'],files=len(items),outcome=outcome,notes=notes))
assert sum(e['outcome']=='complete' for e in m['entry_outcomes'])==20
for o in m['resource_observations']:
 rid=o['remote_resource_id']
 if rid==542:o.update(status='excluded',reason='Regolamento HU ungherese fuori perimetro; originale trasferito prima della verifica preservato nelle esclusioni.')
 if rid==472:o.update(status='available',enumeration='complete_browser_inventory',reason='Quattro PDF offerti: tre nel perimetro acquisiti, PT BR escluso. No thanks senza pagamento/email/account.',files=[dict(name=x['original_filename'],sha256=x['sha256']) for x in m['items'] if x['remote_resource_id']==rid])
 if rid in (502,503,530):o['reason']='Originale offerto pubblicamente scaricato tramite download ufficiale; nessuna redistribuzione attestata.'
 for f in o.get('files',[]):
  if 'Rules ES' in f.get('name',''):f.update(status='excluded',reason='Lingua ES fuori perimetro')
 if o.get('enumeration')=='partial_html':o['enumeration']='complete_browser_comparison_in_scope';o['enumeration_evidence']='tasks/2026-10-13 - ACQ - 9-Card Nanogame 2025/FOLDER_AUDITS_2026-11-06.json'
 if rid==558:o.update(status='partial',reason=partial[464])
m['browser_audits']=json.loads((TASK/'FOLDER_AUDITS_2026-11-06.json').read_text(encoding='utf8'))['audits']
MAN.write_text(json.dumps(m,ensure_ascii=False,indent=2)+'\n',encoding='utf8');print(json.dumps(dict(files=len(m['items']),complete=20,partial=2,blocked=3,games_with_files=len({x['game_id'] for x in m['items']}))))
