"""Offline, dichiarativo MAT TSK-0051; nessun accesso di rete o download."""
import argparse
import hashlib
import json
import re
import sqlite3
from pathlib import Path
from urllib.parse import urlsplit

ROOT = Path(__file__).resolve().parents[1]
TASK = ROOT / 'tasks/2026-10-04 - MAT - 9-Card Nanogame 2025'
DATE = '2026-10-04'
SOURCE = 'https://boardgamegeek.com/thread/3436343/2025-9-card-nanogame-print-and-play-design-contest'
EVIDENCE = TASK.relative_to(ROOT).as_posix() + '/EVIDENCE.json'
PREFIX = ['https://drive.google.com/file/d/', 'https://drive.google.com/drive/folders/',
          'https://docs.google.com/document/d/', 'https://steamcommunity.com/sharedfiles/filedetails/?id=',
          'https://boardgamegeek.com/thread/', 'https://youtube.com/watch?v=',
          'https://www.dropbox.com/scl/fi/', 'https://www.dropbox.com/scl/fo/']
ENTRY_IDS = list(range(393,456)) + [456,457,460,461,462,463,464,465,466,468,469,470,471,472,473] + list(range(475,487))
NOTES = {
    7: 'Non richiesti i due colori dei dadi; i 12 dadi restano richiesti. Dischi solo nello scenario opzionale.',
    10: 'Meeple, tre dadi e 18 cubi soltanto nella campagna. Quantità del dado non specificata.',
    12: 'Due menzioni dello stesso URL, accorpate senza perdere la molteplicità.',
    18: 'Requisiti per giocatore distinti da quelli globali; custodia dichiarata nei file, non obbligatorietà.',
    20: 'Totali e sottogruppi non sommati due volte; dadi senza numero di facce dichiarato.',
    25: 'La sinossi dichiara 10d6 per giocatore mentre la lista componenti dichiara 5d6: conflitto non risolto.',
    26: '14 cubi, due set da 6 e due neutrali: preservata la formulazione originale senza sommare i due neutrali al totale.',
    30: 'Autrice: ora Nine Tails: A Solitaire Game; file gratuiti rimossi da Google Drive per uscita Game Crafter; modulo TTS dichiarato ancora disponibile con arte originale. Nessuna verifica host. Introduzione 10 carte/5 token e lista 9 carte/6 token preservate come versioni discordanti.',
    31: 'Download links Version 4.2. Penna o alternativa pennarello cancellabile su carte imbustate.',
    39: '23 token in 6 colori, ma la ripartizione (4,4,4,4,4,4,3) dà 27 in 7 gruppi. Sacchetto esplicitamente richiesto.',
    49: 'Roster Stand of Supremacy; primo post attuale Supremacy Defense. Manuali V4.0 e PnP V3.0 22/3/2025.',
    54: 'Primo articolo rimasto @AaronMin 3/3/2025 è Update, seguito da feedback 14/4 e risposta 16/4. Post introduttivo originale non osservabile: nessuna assenza di materiali dedotta.',
    55: 'Roster Tiny, Dicey, and Starry; primo post originale @UdaAC3S_ 10/2/2025 è Dicey Railways in fase idea. Requisiti e link si riferiscono a questo post, non attestano la versione rinominata.',
    57: '23 cubi dichiarati, cinque gruppi da tre più 3/6 tracker non coerenti col totale; quantità conservate senza rettifica.',
    63: 'Altri componenti TBD: censimento del primo post completo, progetto materiali incompleto.',
    65: 'Taglio delle carte tesoro e alternativa cubi proposti, non scelta definitiva.',
    67: 'Quantità dadi e cubi X/TBD: requisiti osservati, quantità non determinata.',
    69: 'Autore dichiara Not print ready; versione online pronta. Non assimilare link a stampabilità verificata.',
    70: 'Components: tbc e Download Links: tbc. Placeholder espliciti; nessun requisito o URL pertinente dichiarato.',
    71: 'D10 omesso dalla v1.2; conservato nel testo storico, escluso dai requisiti correnti.',
    72: '5 cubi generici ma quattro impieghi enumerati; dadi Several senza quantità. Non risolto.',
    77: 'Un solo ElementaBrawl nel roster ufficiale; baseline locale scissa in 473 Elementa e 474 Brawl. Evidenze collegate soltanto a 473 come corrispondenza provvisoria; 474 bloccato, nessun merge o duplicazione.',
    83: 'Dadi dichiarati nella descrizione di gioco; quantità e facce non dedotte dal risultato 6.',
    85: 'Stesso URL per Cards [1.0] e Rules [1.0]: una risorsa, due menzioni funzionali.'}
# Ruolo dichiarato nel contesto del primo post, separato dall'etichetta dell'anchor.
ROLES = {6:['rules','component','component','online_play'],12:['game_files','game_files'],
         13:['component','rules','component'],18:['game_files','game_files'],24:['game_files'],
         28:['video','game_files'],29:['rules','component','online_play','online_play','video'],
         30:['game_files','online_play'],31:['rules','component'],
         33:['rules','rules','component','component'],34:['game_files'],35:['component','rules','online_play'],
         41:['game_files','online_play'],43:['game_files'],49:['rules','rules','component'],
         58:['rules','rules','component','component','online_play'],69:['rules','online_play'],
         78:['game_files'],79:['video','game_files'],84:['game_files'],86:['component','rules']}

def classify_resource(url, label):
    low = label.lower()
    if any(host in url for host in ('youtu.be','youtube.com')): return 'video'
    if any(host in url for host in ('playingcards.io','steamcommunity.com','tabletopia.com','screentop.gg')): return 'online_play'
    if ('rule' in low and ('card' in low or 'files' in low)): return 'game_files'
    if any(x in low for x in ('reference sheet','box')): return 'player_aid' if 'reference' in low else 'component'
    if any(x in low for x in ('rule','manual','how to play')): return 'rules'
    if any(x in low for x in ('card','component','pnp')): return 'component'
    return 'game_files'

def access(url):
    if 'folders/' in url or '/scl/fo/' in url: return 'folder'
    if 'steamcommunity.com' in url: return 'workshop_module'
    if any(x in url for x in ('youtu.be','youtube.com')): return 'video'
    if any(x in url for x in ('playingcards.io','tabletopia.com','screentop.gg')): return 'web_app'
    if 'itch.io' in url: return 'download_page'
    if 'docs.google.com' in url or '1drv.ms/w/' in url: return 'document'
    if 'boardgamegeek.com' in url: return 'bgg_article'
    return 'file' if ('file/d/' in url or '/scl/fi/' in url or url.endswith('.pdf')) else 'download_page'

def req(kind, name, quantity, context, level='required', supply=None):
    return dict(material_kind=kind,name_normalized=name,name_raw=context,
                quantity_raw=quantity,requirement_level=level,
                supply_mode=supply or ('printable' if kind in ('printable_component','rules','player_aid') else 'household' if kind in ('timer','container') else 'common'),context_raw=context)

def requirements(r):
    i,raw = r['i'],r['material_raw']
    if i in (54,70): return []
    # Inventari con subtotali/righe di colore: estrazione deliberata senza doppio conteggio.
    manual = {
      20:[('printable_component','carte principali','8'),('printable_component','carte helper mezzo formato','2'),('randomizer','dadi giocatore 12mm','4'),('token_marker','meeple giocatore','3'),('token_marker','cubi giocatore 8mm','2'),('randomizer','dadi mostri 12mm','4'),('token_marker','meeple mostri','3'),('token_marker','cubi mostri 8mm','3'),('writing_tool','pennarello cancellabile',None)],
      34:[('printable_component','carte mutanti/nemici','6'),('printable_component','carta core','1'),('printable_component','carta knight','1'),('printable_component','carta fear','1')],
      42:[('printable_component','carte',None),('rules','regolamento',None)],
      51:[('printable_component','carte','9'),('rules','regolamento',None),('randomizer','dadi facce non specificate','2'),('token_marker','cubi','12'),('token_marker','monete','5'),('token_marker','meeple navi','3'),('token_marker','meeple kraken','1'),('token_marker','meeple sirena','1')],
      58:[('token_marker','segnalini gemme','5'),('token_marker','segnalini livelli','3'),('token_marker','segnalino scudi','1'),('token_marker','segnalini salute','5'),('token_marker','segnalini bombe','2')],
      66:[('randomizer','dadi calamità rossi','4'),('randomizer','dadi lanci bianchi','2'),('randomizer','dadi passeggeri altro colore','8'),('token_marker','cubi tracker','8')],
      72:[('printable_component','carte','9'),('token_marker','cubi rossi HP','5'),('token_marker','cubi tracker altri colori','5'),('randomizer','d6 combattimento','1'),('randomizer','d6 nemici','Several'),('randomizer','d6 colori differenti','Several')],
      78:[('randomizer','d6 blu','3'),('randomizer','d6 bianco','1'),('token_marker','meeple kobun per giocatore','4 per player'),('token_marker','meeple mafia straniera','2'),('token_marker','meeple polizia','1'),('token_marker','meeple boss','1'),('printable_component','carte kinjo','6'),('printable_component','carta centrale','1'),('printable_component','carta kaichou/keisatsu/mafia','1'),('printable_component','carta oyabun','1')],
      89:[('printable_component','carte','9'),('randomizer','dadi facce non specificate','12')],
    }
    if i in manual: return [req(k,n,q,raw,'unclear' if i in (42,51) and k=='rules' else 'required') for k,n,q in manual[i]]
    if i==11:
        return [req('printable_component','carte','9',raw),req('token_marker','dischi, uno per colore','2',raw),req('token_marker','cubi, dieci per colore','20',raw),req('randomizer','dado per solo module 2','1',raw,'optional')]
    if i==65:
        return [req('printable_component','carte labirinto','9',raw),req('printable_component','carte tesoro ritagliate',None,raw,'alternative'),req('token_marker','cubi per tesori',None,raw,'alternative')]
    out=[];campaign=False;per_player=False
    for line in raw.splitlines():
        text=line.strip().lstrip('-*• ').strip();low=text.lower()
        if not text or text==':' or 'components total' in low or 'components [' in low: continue
        if 'campaign mode only' in low: campaign=True;continue
        if low=='per player:':per_player=True;continue
        if i==8 and (text.startswith('•') or re.match(r'\d+ (red Hit|blue Miss|Damage|Valor|Medal)',text)):continue
        if i==9 and text.startswith(('a)','b)','c)')):continue
        if i==57 and (low.startswith('3 white') or low.startswith('cubes per player')):continue
        if i==82 and text.startswith(('1 Space','4 System','2 double-sided')):continue
        if i==89 and re.match(r'\d+x ',text):continue
        if i==71 and 'omitted' in low:continue
        if 'grayscale version' in low or 'not print ready' in low:continue
        if i==75 and text.startswith('(The colors'):continue
        if i==75 and text.startswith('2 cups'):
            out.append(req('container','contenitori copridado o mani','2',text,'alternative'));continue
        if re.search(r'(?<![a-z])d(?:4|6|10|12|20)s?\b|\bdices?\b|\bdie\b|six.sided|sided dice',low):kind='randomizer';name='dadi'
        elif 'rule' in low or 'instruction' in low:kind='rules';name='regolamento'
        elif 'reference sheet' in low:kind='player_aid';name='foglio riferimento'
        elif 'tuckbox' in low:kind='printable_component';name='scatola'
        elif 'timer' in low:kind='timer';name='timer'
        elif any(x in low for x in ('pencil','pen ','pens','pen (','marker on')) or low in ('pen','pen or pencil'):kind='writing_tool';name='strumento scrittura'
        elif 'bag' in low or 'cup' in low or 'container' in low:kind='container';name='contenitore'
        elif 'card' in low:kind='printable_component';name='carte'
        elif any(x in low for x in ('cube','token','meeple','meepel','coin','disc','chip','stone','pawn','ring','paperclip','model','arrow','marker')):kind='token_marker';name='segnalini'
        elif 'scenario' in low:kind='printable_component';name='scenario'
        else:continue
        quantity=re.match(r'^\[?((?:up to )?\d+)(?:\s*[dx]|\]|\s|$)',text,re.I)
        q=quantity.group(1) if quantity else 'X' if text.startswith('[X]') else None
        if i in (68,86) and kind=='printable_component':q='9'
        if i==21 and kind=='token_marker':q='11'
        if i==26 and '2 cubes of a different' in low:continue
        if i==57 and '23x8mm' in low:q='23 dichiarati; dettaglio discordante'
        if i==57 and '3 cubes (solo' in low:q='3 solo / 6 pvp'
        if i==16 and 'player meeples' in low:q='2 (2-player) / 4 (3-4 player)'
        if i==36 and 'd6 dice' in low:q='up to 21; 10 solo; 5 per player'
        if i==71 and '8 double-sided' in low:q='8 double-sided + 1 single-sided'
        level='optional' if 'optional' in low or campaign else 'unclear' if 'tbd' in low or 'tbc' in low or q=='X' or i==83 and kind=='randomizer' else 'required'
        name += ': '+re.sub(r'^[\[\d\] x-]+','',text).strip()[:100]
        if per_player or 'per player' in low and i==62:q=(q or 'non specificata')+' per player'
        out.append(req(kind,name,q,text,level))
        if i==39 and 'bag' in low:out[-1]=req('token_marker','token, ripartizione discordante','23',text);out.append(req('container','sacchetto',None,text))
    if i==9:out.append(req('printable_component','unit token card, ritagliare 15 componenti dalla carta inclusa','15',raw))
    for x in out:x['context_raw']=raw
    return out

def build(db):
    materials=json.loads((TASK/'MATERIAL_RAW.json').read_text(encoding='utf8'))
    labels=json.loads((TASK/'LABEL_RAW.json').read_text(encoding='utf8'))
    evidence=sum([json.loads(p.read_text(encoding='utf8')) for p in sorted(TASK.glob('EVIDENCE_*.json'))],[])
    assert len(evidence)==90 and [r['i'] for r in evidence]==list(range(90))
    result=[]
    for r,eid in zip(evidence,ENTRY_IDS):
        r=dict(r);r['entry_id']=eid;r['source_url']='https://boardgamegeek.com/thread/'+r['w'];r['checked_at']=DATE
        r['material_raw']=materials.get(str(r['i']),r['m'])
        if r['i']==12:r['material_raw']=':\n'+r['material_raw']
        r['notes']=NOTES.get(r['i'],'')
        r['wip_status']='found';r['outcome']='blocked' if r['i']==54 else 'complete'
        r['resource_listing_status']='not_observable' if r['i']==54 else 'observed' if r['l'] else 'none_declared'
        r['material_listing_status']='not_observable' if r['i']==54 else 'observed' if r['material_raw'] else 'none_declared'
        resources=[]
        for j,(p,s,label) in enumerate(r['l']):
            label=labels.get(str(r['i']),[x[2] for x in r['l']])[j]
            url=PREFIX[p]+s if isinstance(p,int) else p
            role=ROLES.get(r['i'],[])[j] if r['i'] in ROLES else classify_resource(url,label)
            resources.append(dict(url=url,label_raw=label,content_role=role,access_type=access(url),host=urlsplit(url).hostname,
                                  version_raw=(re.search(r'\b(?:v(?:ersion)?\.?\s*)\d+(?:\.\d+)*',label,re.I).group(0) if re.search(r'\b(?:v(?:ersion)?\.?\s*)\d+(?:\.\d+)*',label,re.I) else None)))
        r['resources']=resources;r['requirements']=requirements(r)
        # Documenti/componenti dichiarati soltanto nei link: registrati con obbligatorietà incerta, mai dedotta.
        for kind,roles,name in [('rules',{'rules'},'regolamento dichiarato nei link'),('printable_component',{'component'},'componenti PnP dichiarati nei link')]:
            matching=[x for x in resources if x['content_role'] in roles]
            if matching and not any(x['material_kind']==kind for x in r['requirements']):
                context=' | '.join(x['label_raw'] for x in matching)
                r['requirements'].append(req(kind,name,None,context,'unclear'))
        result.append(r)
    for eid,note in [(458,'N/A, Amo / @zardon'),(459,'HMS Ulven, Jörgen Bengtsson / @cabal_se'),(467,'N/A, Ryan Shaffer / @ryanshaffer'),(474,'Brawl: secondo frammento della scissione locale ElementaBrawl; identità distinta non attestata')]:
        result.append(dict(entry_id=eid,t=note,source_url=SOURCE,checked_at=DATE,wip_status='not_checked' if eid==474 else 'not_found',
                           resource_listing_status='not_checked',material_listing_status='not_checked',outcome='blocked',
                           notes=note+'; nessun requisito o risorsa inferiti. Roster ufficiale e pagine 2–24 controllati; nessun WIP pertinente individuato.',resources=[],requirements=[],material_raw=''))
    assert len(result)==94 and {r['entry_id'] for r in result}==set(range(393,487))
    for r in result:
        row=db.execute('SELECT game_id FROM entries WHERE id=? AND contest_id=13',(r['entry_id'],)).fetchone();assert row
        r['game_id']=row[0]
    return sorted(result,key=lambda r:r['entry_id'])

def q(value):
    return 'NULL' if value is None else "'"+str(value).replace("'","''")+"'"

def insert(table, values, ignore=True):
    return 'INSERT '+('OR IGNORE ' if ignore else '')+'INTO '+table+' ('+','.join(values)+') VALUES ('+','.join(q(v) for v in values.values())+');'

def sql_for(rows):
    sql=['PRAGMA foreign_keys=ON;','BEGIN;']
    for r in rows:
        eid=r['entry_id'];source=r['source_url'];notes='TSK-0051; primo post originale soltanto; host non verificati. '+r['notes']
        if r['wip_status']=='found':sql.append('UPDATE entries SET wip_thread_url='+q(source)+' WHERE id='+str(eid)+' AND wip_thread_url IS NULL;')
        common=dict(entry_id=eid,checked_at=DATE,source_url=source,wip_status=r['wip_status'],notes=notes)
        sql.append(insert('entry_resource_scans',dict(common,resource_listing_status=r['resource_listing_status'])))
        sql.append(insert('entry_material_scans',dict(common,material_listing_status=r['material_listing_status'],coverage_scope='first_post_only')))
        sql.append(insert('entry_work_observations',dict(entry_id=eid,phase='materials',outcome=r['outcome'],observed_at=DATE,source_url=source,evidence_path=EVIDENCE,notes=notes)))
        # Per URL: risorsa unica, menzioni per funzione con tutte le etichette e loro molteplicità.
        urls={x['url'] for x in r['resources']}
        for url in sorted(urls):
            group=[x for x in r['resources'] if x['url']==url];x=group[0]
            sql.append(insert('remote_resources',dict(game_id=r['game_id'],kind=x['content_role'] if len({z['content_role'] for z in group})==1 else 'game_files',url=url,host=x['host'],label=' | '.join(dict.fromkeys(z['label_raw'] for z in group)),version_raw=x['version_raw'],availability_status='unknown',first_seen_at=DATE,last_verified_at=DATE,access_type=x['access_type'])))
            rid='(SELECT id FROM remote_resources WHERE game_id='+str(r['game_id'])+' AND url='+q(url)+')'
            for role in sorted({z['content_role'] for z in group}):
                labs=[z['label_raw'] for z in group if z['content_role']==role]
                sql.append('INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES ('+','.join([str(eid),rid,q(source),q(' | '.join(labs)),q(role),'1',q(DATE),q(DATE)])+');')
            sql.append('INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT '+','.join([rid,q(DATE),q(source),q('declared_in_wip'),q('not_checked'),q(x['version_raw']),q(notes)])+' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id='+rid+' AND observed_at='+q(DATE)+' AND evidence_url='+q(source)+" AND observation_kind='declared_in_wip');")
        for requirement in r['requirements']:
            values=dict(entry_id=eid,**requirement,source_url=source,first_seen_at=DATE,last_seen_at=DATE)
            identity=['entry_id','material_kind','name_normalized','quantity_raw','requirement_level','source_url']
            sql.append('INSERT INTO entry_material_requirements ('+','.join(values)+') SELECT '+','.join(q(v) for v in values.values())+' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE '+' AND '.join(k+' IS '+q(values[k]) for k in identity)+');')
    sql.extend(['COMMIT;','']);return '\n'.join(sql)

def main():
    parser=argparse.ArgumentParser();parser.add_argument('--database',type=Path,default=ROOT/'database/pnp_collection.sqlite3');args=parser.parse_args()
    with sqlite3.connect('file:'+args.database.resolve().as_posix()+'?mode=ro',uri=True) as db:rows=build(db)
    payload=dict(task_id='TSK-0051',contest_id=13,checked_at=DATE,coverage_scope='first_post_only',entries=rows)
    (TASK/'EVIDENCE.json').write_text(json.dumps(payload,ensure_ascii=False,indent=2)+'\n',encoding='utf8')
    output=ROOT/'catalog/2025-nine-card-materials.sql';output.write_text(sql_for(rows),encoding='utf8')
    report=['# 2025 9-Card Nanogame — censimento materiali','',f'Verifica BGG {DATE}, TSK-0051. [Roster ufficiale]({SOURCE}). Copertura: primo post originale completo, senza host esterni o download.','',
            '94 record locali: 89 letture complete e 5 esiti bloccati. Roster osservato: 93 righe (63 finali, 30 ritirate); la baseline 94 conserva la scissione Elementa/Brawl. Nessuna correzione roster nel task MAT.','',
            f"{sum(bool(r['resources']) for r in rows)} entry con risorse dichiarate; {sum(len({x['url'] for x in r['resources']}) for r in rows)} URL distinti per gioco; {sum(len(r['requirements']) for r in rows)} requisiti dichiarativi. Disponibilità mai verificata; unknown/not_checked anche dove l'autore dichiara rimozione.",'',
            'Per i tre WIP mancanti controllati roster e messaggi ufficiali pagine 2–24; ricerca sostitutiva senza candidato pertinente. Per Three Buccaneers il primo post rimasto è un aggiornamento. ElementaBrawl assegnato provvisoriamente al record 473; 474 bloccato.','',
            'Le etichette, gli estratti originali e le menzioni ripetute sono nel dataset EVIDENCE.json. La tassonomia funzionale è provvisoria; quantificazioni discordanti e stati idea/TBD non equivalgono a censimento incompleto del post.','',
            '| Entry | Titolo locale/roster | Esito | URL | Requisiti | Note |','|---:|---|---|---:|---:|---|']
    for r in rows:
        report.append(f"| {r['entry_id']} | [{r['t'].replace('|','/').replace('[','(').replace(']',')')}]({r['source_url']}) | {r['outcome']} / {r['resource_listing_status']} | {len({x['url'] for x in r['resources']})} | {len(r['requirements'])} | {r['notes'].replace('|','/')} |")
    report.extend(['','Prossimo passo: riconciliazione roster ElementaBrawl in attività distinta; eventuale ACQ per questo singolo contest e giochi selezionati, con verifica host/condizioni. Nessun monitoraggio ordinario del contest concluso.',''])
    (ROOT/'sources/2025-NINE-CARD-MATERIALS.md').write_text('\n'.join(report),encoding='utf8')
    print(json.dumps(dict(entries=len(rows),complete=sum(r['outcome']=='complete' for r in rows),resource_entries=sum(bool(r['resources']) for r in rows),resources=sum(len({x['url'] for x in r['resources']}) for r in rows),requirements=sum(len(r['requirements']) for r in rows),sql_sha256=hashlib.sha256(output.read_bytes()).hexdigest())))

if __name__=='__main__':main()
