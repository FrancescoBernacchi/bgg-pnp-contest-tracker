"""TSK-0054: normalizzazione offline dei primi post osservati con CUA."""
import json, re, hashlib, sqlite3
from pathlib import Path
from urllib.parse import urlsplit
from build_2025_54_card_materials import sql_for as shared_sql, access
import build_2025_54_card_materials as shared

ROOT=Path(__file__).resolve().parents[1]
TASK=ROOT/'tasks/2026-10-05 - MAT - Solitaire Print and Play Contest 2025'
RAW=ROOT/'outputs/2025-solitaire-materials/FIRST_POSTS.json'
DATE='2026-10-05'
EVIDENCE=TASK.relative_to(ROOT).as_posix()+'/EVIDENCE.json'
# Indici degli anchor osservati: selezione editoriale, non crawling degli host.
SELECT={1:[5,6,7],2:[3,4,6],3:[1,2,3,4,5],4:[4,5],5:[1,2],6:[2,3,4],7:[2,3,4,5],8:[2,3],9:[2],10:[3,4],11:[1],12:[1,2,3],13:[2,3,4,5],14:[2,3,4],15:[1,2,3,5],16:[2],17:[1,2,3],18:[2,3,6,8],19:[3],20:[],21:[3],22:[3,4,5],23:[4],24:[1],25:[3,4,5,6],26:[4],27:[2,3],28:[1,2,3,6,7,8,9],29:[7,8,9,10,11,12],30:[2],31:[2],32:[2,3,4,5,6,8,10],33:[1,2,5,7,9,10,12,13],34:[2,3,4,5],35:[2,3],36:list(range(5,16)),37:[1,2],38:[3,4,5,6,7,11],39:[3,4,5],40:[3,4,5,6,7,8,9],41:[17,18,23],42:[2,3,4],43:[2,3],44:[2,3,4,5,6,7,11,13,16,17,18,19,20],45:[3,4,5,6,8,9,11,12,13],46:[0,4],47:[],48:[2,3,4,5],49:[6,7],50:[2,3,4,5],51:[2,5],52:[6,7,8,9,10],53:[2,3,4,5],54:[1,2],55:[1,2],56:[1]+list(range(4,19)),57:[2,3,4],58:[2,3],59:[1,2,3,4,5,6],60:[0],61:[2,3],62:[1],63:[2,3,4],64:[0,1,2,3,4],65:[0,5,6],66:[2,3],67:[0],68:[11,18],69:[2],70:[],71:[2,3,5],72:[2,3],73:[5,6,7,8],74:[1]}
# Funzioni dichiarate quando l'etichetta è generica o solo un URL.
ROLES={1:{6:'game_files'},2:{3:'game_files'},3:{1:'other',2:'rules',3:'rules',4:'game_files'},4:{4:'game_files'},6:{2:'rules',3:'component'},8:{2:'component',3:'rules'},12:{1:'game_files'},13:{2:'game_files',4:'game_files',5:'game_files'},14:{2:'rules',3:'component'},17:{1:'rules',2:'component',3:'component'},18:{2:'game_files'},21:{3:'game_files'},23:{4:'other'},25:{3:'rules',4:'component',5:'rules',6:'component'},27:{2:'game_files',3:'game_files'},28:{1:'rules'},29:{7:'rules',8:'component',9:'component',10:'game_files'},33:{2:'game_files',9:'component',10:'component',12:'component',13:'component'},36:{5:'rules',6:'component',7:'component',8:'component',9:'component',10:'rules',11:'component',12:'component',14:'online_play'},37:{1:'rules',2:'component'},38:{3:'rules',4:'rules',5:'component',6:'component',7:'component'},39:{3:'component',4:'component',5:'rules'},40:{3:'rules',4:'component',5:'component',6:'component',7:'component'},41:{23:'game_files'},44:{2:'project_page',3:'rules',4:'component',5:'component',7:'online_play',16:'rules',17:'component',18:'component',20:'online_play'},45:{3:'project_page',11:'rules',12:'rules',13:'rules'},48:{2:'rules',3:'rules',4:'component'},49:{6:'rules'},50:{2:'rules',3:'component',5:'playtest_form'},51:{5:'rules'},52:{9:'audio',10:'audio'},53:{2:'rules',3:'component'},54:{1:'rules',2:'component'},55:{1:'game_files',2:'component'},56:{4:'rules',**{j:'component' for j in range(5,19)}},57:{4:'rules'},59:{1:'rules',2:'rules',3:'component',4:'component',5:'component'},60:{0:'rules'},61:{2:'game_files',3:'game_files'},63:{2:'rules',3:'component',4:'component'},64:{0:'component',1:'component',2:'player_aid',3:'player_aid',4:'rules'},65:{0:'project_page',5:'rules'},67:{0:'game_files'},68:{11:'game_files',18:'game_files'},69:{2:'game_files'},72:{2:'component',3:'component'},73:{5:'rules',6:'component',7:'online_play'}}

# nome|quantità|needle del testo originale|tipo|livello|approvvigionamento.
# Quantità e sottogruppi non sono sommabili automaticamente; le alternative restano distinte.
SPECS={
1:'carte|1 pagina|Cards 1 page;regole|1 pagina|Rules 1 page|rules;dadi bianchi|7|7 blank dice|randomizer|alternative|common;dadi normali e foglio Roll & Write|7 + foglio|7 regular dice|randomizer|alternative|common',
2:'stampe|minimo 6 pagine|min. 6 pages',
3:'penna o matita||Required Components|writing_tool|required|common;dadi d6|5|Required Components|randomizer|alternative|common;biglietto BARD marcato||Required Components|randomizer|alternative|household;foglio avventura|US Letter o A4|Required Components',
4:'plance Grid|4|4 Grid Game;carte programmazione Tron|15|15 Tron;carte programmazione MCP|15|15 MCP;Bit card|1|1 Bit card;set anelli Hyperball|2|2 Hyperball;scie light cycle|40 (20 per colore)|40 light;pezzi Tron|4|4 Tron;pezzi nemici|17|17;crepe|4|crack;marcatori|4|marker',
7:'carte|28 / 4 A4|28 cards;segnalini|3|3 cubes|marker|required|common;plancia doppia faccia|1 / 1 pagina|double-sided board;playmat|1 A3 o 2 A4|optional: 1 playmat|printable_component|optional',
8:'mazzo standard|1|standard deck|standard_deck|required|common;moneta|1|1 Lucky Coin|marker|required|common;carta e penna||paper|writing_tool|required|household;mazzo ROME personalizzato||customized ROME|printable_component|optional',
9:'carte Field|48|48;carte Mission|32|32;carte aiuto||Player Aid|player_aid;playmat e tuckbox||tuck|printable_component|optional;espansione SENTRY gadget|8|SENTRY|printable_component|optional',
10:'carte Mural/Labyrinth|25|25 Mural;carte Labyrinth|15|15;carte Tool|6|Tool Cards;Trowel|1|Trowel;marcatore attrezzo attivo|1|Active;tracker progresso|1|Player Progress|marker|alternative|supplied_or_printable;pedina o moneta|1|Player Progress|marker|alternative|common;Use tokens|8|8 Use;Damage tokens|8|8 Damage;timer con pausa||Pause-able Timer|timer|required|common;tuckbox opzionali||tuckbox|printable_component|optional;colla||glue|assembly_tool|required|household',
11:'foglio di gioco|1 US Letter/A4|1 sheet;strumento per scrivere||writin|writing_tool|required|common',
12:'carte|54 / 12 A4|Components:;regole|12 A4|Components:|rules;meeple o segnalini|2 colori diversi|Components:|marker|required|common;set poliedrico|d4 d6 d8 d10 percentile d12 d20|Components:|randomizer|required|common',
13:'carte quadrate|27|27 Square;aiuti poker|2|Poker|player_aid;carte Rain Rain|2|Rain, Rain Mini-Expansion|printable_component|optional;tuckbox||tuckbox|printable_component|optional',
14:'carte previste|meno di 40|40|printable_component|unclear;dadi previsti|circa 10|10|randomizer|unclear|common;segnalini previsti||tokens|marker|unclear|unspecified',
15:'foglio gioco|1|Game sheet;dado d4|1|D4|randomizer|required|common;d6 color A|1|D6 die Color A|randomizer|required|common;d6 color B|10|D6 dice Color B|randomizer|required|common;d6 color C|3|D6 dice Color C|randomizer|required|common;cubi|9|9 - Cubes|marker|required|common',
16:'carte doppia faccia|25|25 double',17:'carte|18|18 cards',
18:'carte stampabili|poche pagine|few pages;mazzo carte standard||deck of playing cards|standard_deck|required|common;dadi||some dice|randomizer|required|common;segnalini||few tokens|marker|required|common',
19:'stampe|3 pagine|Components:;dadi d6|7 (preferiti 6+1 colori)|Components:|randomizer|required|common;strumento scrittura||Components:|writing_tool|required|common',
20:'stampe dichiarate in aggiornamento|3 pagine|only 3 pages|printable_component|unclear',
21:'matita e carta||Optionally|writing_tool|optional|household',
23:'plancia|1 A4|1 A4 game board;regole|1 pagina|Rules (1 pages)|rules;penna o matita||Pencil or pen|writing_tool|required|common',
25:'carte Pop/Spot Luchador|16|16 Cards|printable_component|alternative;carte Emperor e Injury Luchador|1+1|Emperor Card|printable_component|alternative;carte Pop/Spot Ballet|16|Critic Card|printable_component|alternative;carte Critic e Injury Ballet|1+1|Critic Card|printable_component|alternative',
26:'Foundation dice|2|2 Foundation|randomizer|required|common;Craft dice|5|5 Craft|randomizer|required|common;Scout dice|6|6 Scout|randomizer|required|common;Hazard dice|6|6 Hazard|randomizer|required|common;Runic dice|3|3 Runic|randomizer|optional|common;schede scenario||optional scenario|printable_component|optional',
27:'carte|40 / 5 fogli|Printable Components;regole|20 pagine A5|Printable Components|rules;dadi d6|13 (6A 5B 2C)|Additional Components|randomizer|required|common;segnalini|20 / 8x8mm|Additional Components|marker|required|common;sacchetto|1|Additional Components|container|required|household',
28:'plancia giocatore|24x14 pollici|24 x 14;plancia Beast|US Letter|8.5 x 11;carte||cards for deck;cubi gialli/arancio e rossi|10mm|10mm|marker|required|common',
29:'penna o matita||Required Components|writing_tool|required|common;d6|6|Required Components|randomizer|required|common;gamesheet||Required Components',
30:'tessere hex|18 / 3 A4 Letter fronte retro|18 HEX;d6|1|1 d6|randomizer|required|common;cubi|24 (12 rossi 12 verdi)|24 Cubes|marker|required|common;regole||-Rules|rules',
31:'carte|27|27 cards;cubi|3|3 cubes|marker|required|common',
32:'dadi|circa 30|about 30 dice|randomizer|required|common;cubi legno|pochi|wooden cubes|marker|required|common;pedine|un paio|couple of pawns|marker|required|common',
33:'carte|46|46 cards;cubi||46 cards|marker|required|common;token rot e annaffiatoio 3D||3D rot|printable_component|alternative|specialized',
34:'Combat Board|1|1 Combat;Personal Board|1|Personal;draw bag|1|1 Draw Bag|container|required|household;Prisoner cards|5|Prisoner;Arenamaton cards|5|Arenamaton;Augmentum cards|18|Augmentum;Clash Tactics|10|10 Clash;Maneuver tokens|50 (10 per 5 tipi)|50 Maneuver;Calamity tokens|12|12 Calamity;Guild tokens|15 (5 per 3)|15 Guild;cubi tracking|8|8 tracking|marker|required|common',
36:'carte|36 / insieme token 4 A4|Components:;token|9|Components:;token 3D alternativi||3D printed|printable_component|alternative|specialized;Finishing touches carte|7|7 cards|printable_component|optional',
37:'carte|52 / 7 A4|Components:',
38:'regole|8 pagine|Rules v2.2|rules;campagna|12 pagine|Campaign v1.0|rules|optional;tessere tre formati alternativi|48 / 4 pagine|48 tiles|printable_component|alternative',
39:'foglio e carte|1 + 9|PNP Files;pencil||pencil or similar|writing_tool|required|common;d6|3|3d6|randomizer|required|common;set poliedrico|1 (2 colori per immersione)|Set of polyhedral|randomizer|required|common',
40:'regole|4 A4/Letter|Rules (4|rules;demo e gioco completo|27 + 27 / 6 + 8 pagine|27 (demo)|printable_component|alternative',
42:'mazzo standard||Components needed|standard_deck|required|common;cubi 8mm|35|Components needed|marker|required|common',
44:'carte CORE|7 pagine doppia faccia / 9 per pagina|7 double;carte RUNMODE|5 pagine doppia faccia / 9 per pagina|5 double|printable_component|optional;player aid RUNMODE|1 pagina aggiuntiva|additional single|player_aid|optional;schema token RUNMODE||optional schema|printable_component|optional',
45:'carte|36|36 cards;cubi o monete scoring||Cubes or coins|marker|optional|common;manuale JPG|3 pagine|Illustrated 3-page manual|rules',
46:'mazzo standard||standard pack|standard_deck|required|common;pamphlet progresso|1|single character;regole pamphlet||game rules pamphlet|rules',
48:'carte|36|36;dado|1|die|randomizer|required|common',
49:'carte|66 / 8 A4 totali|Components:;cubi|21|Components:|marker|required|common;d6|9|Components:|randomizer|required|common;tracker board|1|Components:',
51:'carte|45|45',52:'carte in mano|18|18',
53:'carte fronte retro|9 / 2 pagine|Components - 2 pages;dadi|10|10 dice|randomizer|required|common;token|1|1 token|marker|required|common',
54:'d6|7|Components needed|randomizer|required|common;marcatori||marker|marker|alternative|supplied_or_printable',
55:'penna o matita||Pen or pencil|writing_tool|required|common;d6|6|6 six-sided|randomizer|required|common;token direzione|1|direction token|marker|required|common;token bersagli|12|12 tokens|marker|required|common;stampe||Print out',
56:'d6 raccomandati|6–12|6-12 Six|randomizer|unclear|common;pezzi con o senza spazio||Pieces (|printable_component|alternative;Bravery board||Bravery Dice Action Board;Team Record||Team Record Sheet;Team Control||Team Control Board;plancia The Village|1|Level 1;plancia Sunny Side|1|Sunny Side" Level Board;plancia Town Meeting|1|Town Meeting" Level Board;plancia The Snake|1|The Snake" Level Board;scenario Village|1|Village" Scenario Card;scenario Sunny Side|1|Sunny Side" Scenario Card;scenario Town Meeting|1|Town Meeting" Scenario Card;scenario The Snake|1|The Snake" Scenario Card;Campaign Record||Campaign Record Sheet',
57:'d6|2|Required components|randomizer|required|common;pedina|1|Required components|marker|required|common;plancia|1 A4|Required components;carte|43|Required components',
59:'mazzo|54|54-card deck|printable_component|unclear;dadi rossi HP||Red dice|randomizer|required|common;dadi gialli o contatore denaro||Yellow dice|marker|alternative|common;dadi blu ATK||Blue dice|randomizer|required|common;dadi bianchi|3|3 White|randomizer|required|common;dadi neri|3|3 Black|randomizer|required|common',
60:'mazzo standard|52 + joker|52 card standard|standard_deck|required|common',
61:'pacchetto A4|16 pagine (journal opzionale)|16 pages;d6|6 (3+2+1 colori)|6 D6|randomizer|required|common;d3 d4 d5||actual polyhedral|randomizer|optional|common;segnalini navi|4 (3 pirata 1 navy)|4 ships|marker|required|common;matita|1|1 pencil|writing_tool|required|common;versione No Tables|4 pagine|No Tables|printable_component|alternative',
62:'puzzle booklet|10 A4 fronte retro colore|10 printed;graffette montaggio||Staple|assembly_tool|required|household',
63:'dado|1|Additional components|randomizer|required|common;dadi aggiuntivi o piccoli token|8|8 more dice|randomizer|optional|common;cubi|8 (4 per 2 colori)|total 8|marker|required|common;versione low ink|2 pagine|Only two pages|printable_component|alternative',
64:'carte Task|32|Task deck;Belles|14|14 Belles;d6|2|2 D6|randomizer|required|common;dadi tracking|4 aggiuntivi|4 more dice|randomizer|optional|common;time tracker||time tracker|player_aid;helper cards||additional helper|player_aid|optional;regole||rules document|rules',
65:'mazzo standard||Required Components|standard_deck|required|common;tarot cards|4|Required Components;poker cards|3|Required Components;dado 16mm|1|Required Components|randomizer|required|common;dadi 10mm|8|Required Components|randomizer|required|common;cubi 12mm|6|Required Components|marker|required|common;cubi 8mm|16 / due colori|Required Components|marker|required|common',
66:'carte doppia faccia|4 (2 nave 2 missione)|Components:',
67:'d6|5|5 x d6|randomizer|required|common;d10|5 (10 vale 0)|5 x d10|randomizer|required|common;penna o matita||Pen/pencil|writing_tool|required|common;Sheet 1 base|1|Sheet 1;Sheet 3 e/o 5 moduli||Sheet 3|printable_component|optional',
68:'regole e componenti|5 pagine|5 Pages',
69:'stampe US Legal|2|Components:;dadi colorati|6 (2 per 3 colori)|Components:|randomizer|required|common',
70:'penna e carta||All that is required|writing_tool|required|household;d6|2 colori diversi|2 different coloured|randomizer|required|common',
71:'carte|18 / 2 pagine|Components:;regole|1 pagina|Components:|rules;carte gutterfold|6 pagine|GUTTERFOLD FRONT|printable_component|alternative',
72:'journal|2 A4 doppia faccia|Journal -;Goal cards|9 + dorsi / 2 A4|Goal cards -',
73:'carte|18|Components:;regole e aiuti|2 + 8 pagine|Rulebook:|rules',
74:'stampe US Letter|3|Required Components;d6|3|Required Components|randomizer|required|common;cubi bianchi|10|Required Components|marker|required|common;cubi rossi|15|Required Components|marker|required|common'
}
NOTES={3:'Accesso ai gamesheet dichiarato per iscritti Substack. Unbound è side game fuori contest, conservato come riferimento dichiarato.',5:'Nessun inventario esplicito nel primo post: non importati i requisiti del roster.',10:'Gratuità dichiarata limitata alla durata del contest; condizioni correnti non verificate. Tuckbox opzionali.',13:'Primo post aggiornato alla seconda edizione 2026; [Coming Soon!] preservato come stato storico. Tre menzioni della stessa pagina Files.',14:'Inventario dichiarato come stima futura, non distinta finale.',20:'Pagina gioco identitaria esclusa: non dichiarata come destinazione dei file. Tre pagine dichiarate in aggiornamento storico.',23:'Leaderboard incluso come supporto; Kickstarter promozionale escluso. Nessun URL PnP corrente individuato nel primo post.',26:'Contraddizione originale preservata: nota 2/5/6/6/3 con Runic opzionali; sintesi 22 dadi in 4 tipi ma elenco 2A/5B/6C/7D/3E. Nessun totale corretto inferito.',27:'Etichetta Contubernium on itch.io punta in realtà a Drive: destinazione esatta preservata.',32:'PCIO/Screentop/video ripetuti: menzioni conservate, URL identici accorpati. Versione 1.3 9/26/26 dichiarata nel post.',36:'Crediti artisti e strumenti Protograf esclusi. Token 3D alternativi; espansione Finishing Touches distinta.',39:'Set poliedrico dichiarato; due set di colori differenti per immersione, non requisito minimo dedotto.',40:'A4 e Letter/demo e completo sono alternative; mazzi base e missione non sommati ai totali stampabili.',41:'Pagina BGG dichiarata come destinazione Files; artwork e votazioni esclusi.',45:'Tre immagini BGG incluse solo perché espressamente dichiarate manuale JPG. Cartella ripetuta con/senza parametri conservata. Sito dichiarato non ancora attivo.',47:'Nessuna risorsa o requisito esplicito nel primo post originale; URL del roster non sostituiscono la copertura first_post_only.',49:'PNP dichiarato non ancora pubblicato. Drive quickstart Protograf è uno strumento di sviluppo, escluso dai materiali del gioco.',50:'URL regole con usp=sharingWIP preservato senza correzione. Modulo feedback dichiarato, non aperto.',52:'Audio distinto dai video. The Game Crafter commerciale e pagina gioco identitaria esclusi.',53:'PCIO v1 non aggiornato, versione regole dichiarata v3.0: differenza preservata.',62:'URL download firmato originale preservato; eventuale scadenza non verificata. Istruzioni v0.4 e stato v1.0 distinti; PDF giocabile senza stampa.',64:'Etichetta 2 D6 dice punta a Counter.html; supporto digitale distinto dai dadi fisici.',66:'Lost in Xmas Town dichiarato gioco diverso: link escluso dal lotto di questa entry.',68:'Pagina BGG dichiarata per Files. Nessun requisito dadi inferito dalla sola descrizione del turno.',70:'Regole integrate nel primo post; nessun collegamento dichiarato, ma penna/carta e 2d6 espliciti.'}

def excerpt(text,needle):
    m=re.search(re.escape(needle),text,re.I)
    if not m: raise ValueError('Needle assente: '+needle)
    start=text.rfind('\n',0,m.start())+1
    end=text.find('\n',m.end());end=len(text) if end<0 else end
    return text[start:end].strip()

def build():
    capture=json.loads((TASK/'CENSUS_INPUT.json').read_text(encoding='utf8'))
    raw=capture['posts']
    roster=json.loads((TASK/'ROSTER_BASELINE.json').read_text(encoding='utf-8-sig'))
    assert len(raw)==len(roster)==74
    rows=[]
    for i,(x,b) in enumerate(zip(raw,roster),1):
        assert x['entry_id']==b['id'] and x['all_first_post_read'] and x['author'] and x['postLinks']
        resources=[]
        for j in SELECT[i]:
            l=x['links'][j];u=l['url'];label=l['label'];ctx=l['context'] or label
            role=ROLES.get(i,{}).get(j)
            if not role:
                if any(s in u for s in ['youtube.com','youtu.be']):role='video'
                elif any(s in u for s in ['playingcards.io','screentop.gg','steamcommunity','play.unity']):role='online_play'
                else:role='game_files'
            if len(ctx)>700:ctx=excerpt(x['text'],label) if label and label in x['text'] else label
            if not ctx:ctx={18:'Click Google Drive icon to access files; Screentop icon to play',45:'The manual in JPG format'}.get(i,'Anchor dichiarato nel primo post')
            resources.append(dict(url=u,label_raw=label,content_role=role,context_raw=ctx,version_raw=None,host=urlsplit(u).netloc,access_type=access(u),anchor_index=j))
        requirements=[]
        for spec in SPECS.get(i,'').split(';'):
            if not spec:continue
            parts=spec.split('|');name,quantity,needle=parts[:3]
            kind=parts[3] if len(parts)>3 else 'printable_component'
            level=parts[4] if len(parts)>4 else 'required'
            supply=parts[5] if len(parts)>5 else 'printable'
            ctx=excerpt(x['text'],needle)
            requirements.append(dict(material_kind=kind,name_normalized=name,name_raw=ctx,quantity_raw=quantity or None,requirement_level=level,supply_mode=supply,context_raw=ctx))
        rows.append(dict(entry_id=b['id'],game_id=b['game_id'],position=i,title=b['canonical_title'],source_url=x['postLinks'][0],wip_url=b['wip_thread_url'],author_raw=x['author'],post_timestamp_raw=x['header'],checked_at=DATE,wip_status='found',resource_listing_status='observed' if resources else 'none_declared',material_listing_status='observed' if requirements else 'none_declared',coverage_scope='first_post_only',outcome='complete',resources=resources,requirements=requirements,declarations_raw=x.get('declarations_raw',[]),notes=NOTES.get(i,'Primo post originale letto integralmente; nessun host esterno/file aperto.')))
    return rows

def main():
    rows=build()
    stats=dict(entries=74,complete=74,resource_entries=sum(bool(r['resources']) for r in rows),resources=sum(len({x['url'] for x in r['resources']}) for r in rows),resource_mentions=sum(len(r['resources']) for r in rows),material_entries=sum(bool(r['requirements']) for r in rows),requirements=sum(len(r['requirements']) for r in rows))
    payload=dict(task_id='TSK-0054',contest_id=17,checked_at=DATE,coverage_scope='first_post_only',method='Primi post originali renderizzati, lettura integrale; soli estratti pertinenti versionati; nessun host/file aperto.',counts=stats,raw_sha256=json.loads((TASK/'CENSUS_INPUT.json').read_text(encoding='utf8'))['raw_sha256'],entries=rows)
    (TASK/'EVIDENCE.json').write_text(json.dumps(payload,ensure_ascii=False,indent=2)+'\n',encoding='utf8')
    shared.DATE=DATE;shared.EVIDENCE=EVIDENCE
    clean=[dict(r,requirements=r['requirements'],resources=[{k:v for k,v in x.items() if k!='anchor_index'} for x in r['resources']]) for r in rows]
    sql=shared_sql(clean).replace('TSK-0053','TSK-0054')
    (ROOT/'catalog/2025-solitaire-materials.sql').write_text(sql,encoding='utf8')
    report=['# Solitaire Print and Play Contest 2025 — materiali','',f'Verifica {DATE}, TSK-0054. Roster ufficiale GeekList 358652: 74 entry su tre pagine, tutte riconciliate con le entry locali 590–663. Tutti i primi post originali letti integralmente. Host esterni, file e download esclusi.','',json.dumps(stats,ensure_ascii=False),'','Copertura first_post_only. Risorsa dichiarata non significa disponibile: nessuna verifica degli host. Quantità, sottogruppi e alternative non vanno sommati automaticamente. Tassonomia provvisoria. Le modifiche correnti al primo post possono essere successive al contest; date/stati discordanti preservati.','', '| Entry | Gioco | URL | Requisiti | Note |','|---:|---|---:|---:|---|']
    for r in rows:report.append(f"| {r['entry_id']} | [{r['title']}]({r['source_url']}) | {len({x['url'] for x in r['resources']})} | {len(r['requirements'])} | {r['notes']} |")
    report+=['','Le assenze dichiarative riguardano esclusivamente il primo post. Nan’s Heroes, Vicinity e Fairway Fantasy non hanno URL pertinente; Fairway contiene regole e requisiti. Le immagini decorative sono escluse; soltanto le tre immagini del manuale Pilzgrim hanno dichiarazione operativa.','', 'Prossimo approfondimento: ACQ del solo Solitaire 2025, previa selezione dei giochi e verifica delle condizioni. Abydos dichiara gratuità limitata al contest; Delve richiede iscrizione Substack per i gamesheet; Jelly ha URL firmato da verificare. Nessun monitoraggio periodico avviato.','']
    (ROOT/'sources/2025-SOLITAIRE-MATERIALS.md').write_text('\n'.join(report),encoding='utf8')
    print(json.dumps(stats))

if __name__=='__main__':main()



