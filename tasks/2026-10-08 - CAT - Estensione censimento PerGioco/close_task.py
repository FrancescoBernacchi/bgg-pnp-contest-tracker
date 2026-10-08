"""Chiude i registri documentali CAT; nessuna importazione o operazione Git."""
import hashlib
import json
import re
from pathlib import Path

ROOT=Path(__file__).resolve().parents[2]
TASK=Path(__file__).resolve().parent
checks=json.loads((TASK/'VERIFICHE.json').read_text(encoding='utf-8'))
assert checks['failed']==0 and checks['passed']==22
mp=ROOT/'catalog/pergioco_extension_carta_matita_2026-10-08.json'
assert hashlib.sha256(mp.read_bytes()).hexdigest()==checks['manifest_sha256']
p=ROOT/'tasks/REGISTRY.json'
r=json.loads(p.read_text(encoding='utf-8'))
t=next(t for t in r['tasks'] if t['id']=='TSK-0080')
t.update(status='completato',status_basis='9/9 candidate valutate; 7 admitted, 2 requisito non dimostrato; 22 verifiche riuscite, database/app/schema/pilota invariati, nessuna importazione.',closed_at='2026-10-08',last_verified_at='2026-10-08',coverage=dict(candidates=9,censused=9,admitted=7,requirements_not_demonstrated=2,not_observable=0,full_site=False,pilot_recensused=0,imported=0,downloaded=0,native_classifications=18,declared_Labirinto_instances=3,embedded_Piattola_variants=7,matching_records_with_exact_candidates=0),next_action='DAT separato su autorizzazione: piano identità e importazione delle sole nove candidate secondo B-v1/013, con raccolta/varianti/NULL/collisioni/idempotenza e prove su copia/backup/ripristino.')
t['git']['evidence']='Deliverable locali verificati su main; nessun commit/push autorizzato o eseguito in TSK-0080. Modifiche pregresse preservate; nessuna verifica server nuova.'
t['events']=[dict(date='2026-10-08',status='in_corso',evidence='Conferma esplicita lotto nove voci; contratto prima della raccolta.'),dict(date='2026-10-08',status='completato',evidence='Manifest/RELAZIONE.md e VERIFICHE.json: 9/9, 7/2, 22 controlli.')]
r['updated_at']='2026-10-08'
p.write_text(json.dumps(r,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
q=ROOT/'PROJECT_PROGRESS.md'
s=q.read_text(encoding='utf-8')
generated=re.findall(r'<!-- BEGIN GENERATED ANNUAL PROGRESS -->.*?<!-- END GENERATED ANNUAL PROGRESS -->',s,flags=re.S)
s+='\n- 2026-10-08 — TSK-0080 CAT Estensione PerGioco completato: nove voci residue Carta e matita valutate, 7 ammissibili e 2 con requisito non dimostrato (Battaglia Navale; Punti e linee, raccolta). Indice riconciliato 10 voci = Chomp già nel pilota + 9 del lotto; nessuna copertura sito intero attestata. 18 classificazioni native, 3 istanze dichiarate Labirinto (schema utilizzabile non attestato), 7 varianti Piattola preservate fuori denominatore e omonimia Punti e linee/Quadratini non fusa. Zero matching esatti locali; equivalenti non esclusi. Manifest catalog/pergioco_extension_carta_matita_2026-10-08.json e relazione/verifiche nel task: 22 controlli, 286 file baseline invariati, audit nuovi deliverable zero rilievi. Pilota CAT storico 12/12 e nuovo lotto 9/9 restano distinti; operativo/APP ancora 12 record, nessuna importazione o nuova identità. Schema/app/materiali invariati; A/B annuali non rigenerate né modificate. TSK-0073/0074/0078/0079 restano conclusi; nessuna acquisizione, automazione, commit/push. Prossimo passo DAT autonomo da autorizzare per piano identità/importazione del solo lotto.\n'
q.write_text(s,encoding='utf-8')
assert generated==re.findall(r'<!-- BEGIN GENERATED ANNUAL PROGRESS -->.*?<!-- END GENERATED ANNUAL PROGRESS -->',q.read_text(encoding='utf-8'),flags=re.S)
print('TSK-0080 completato; cruscotto aggiornato; sezioni annuali preservate')
