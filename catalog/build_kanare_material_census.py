"""Build original, reviewed Kanare material summaries. No database or network mutation."""
import collections
import hashlib
import json
import re
from pathlib import Path

ROOT=Path(__file__).resolve().parents[1]
TASK=ROOT/'tasks/2026-10-06 - MAT - Kanare Abstract'
LOCAL=ROOT/'outputs/kanare-mat-2026-10-06'
DATE='2026-10-06'

# Reviewed observations: key, evidence pages, board, pieces, additional components/limits.
# Quantities are source quantities, not package quantities or a universal minimum.
DATA={
'Saiju':('pdf-20','1 COMPONENTS; 1–2 SETUP','36 celle esagonali, senza centro','36 pezzi: 3 colori × 3 simboli × 4 esemplari','3 pezzi neri Shadow, uno per simbolo; colori e simboli hanno funzioni distinte'),
'Iago':('pdf-5','1 COMPONENTS; 2 varianti','61 celle esagonali: 24 esterne e 37 interne, centro segnato','61 dischi bifacciali: 31 scuro/rosso e 30 chiaro/rosso','PDF storico Iago_EN e prodotto Iago_S_EN conservati distinti; requisito materiale concorde'),
'Borderland':('pdf-41','1 COMPONENTS','esagono lato 6, 91 celle','30 pezzi per colore (60 dichiarati)','Il regolamento ammette pezzi illimitati e sostituti se esauriti; confezione 70'),
'RosenKreuz':('pdf-57','1 COMPONENTS; 2 nota finale','scacchiera 8×8','32 pezzi: rosa/croce, 8 per ciascuna combinazione simbolo-colore','Versione iniziale 7×7 menzionata nella nota; non attribuire automaticamente materiali di implementazioni online'),
'Lines of Fixation':('pdf-48','1 COMPONENTS','esagono regolare, 61 intersezioni','18 dischi impilabili per colore','Il gioco usa intersezioni, non celle; impilabilità necessaria'),
'Ripples':('pdf-50','1 COMPONENTS','esagono lato 5, 61 celle','61 dischi bifacciali bianco/blu','Confezione 62; nessun collegamento al Ripples BGG respinto'),
'Meridians':('pdf-45','1 COMPONENTS','reticolo triangolare in esagono con due lati più corti degli altri quattro','75 pezzi per colore','Plancia bifacciale del prodotto; misure fisiche della confezione distinte dalla geometria'),
'Stairs':('pdf-26','1 COMPONENTS / SETUP','quadrata 6×6','18 pezzi impilabili per colore','Confezione con pezzi 20×20×10 mm; non richiede tutti i set di altre dimensioni'),
'Comune':('pdf-18','1 COMPONENTS / PLACEMENT','esagono lato 5','35 pezzi per colore','Pezzi rettangolari con orientamento distinguibile: tre angoli; confezione 20×20×10 mm'),
'Estate':('pdf-7','1 COMPONENTS','esagono lato 5 con aree concentriche di valori distinti','35 pezzi per colore','Le aree/valori della plancia sono necessari; non presumere equivalenza con plancia senza segni'),
'ViceVeresi':('viceveresi-pdf','1 SET UP','quadrata 8×8','64 dischi reversibili di due facce/colori','Pagina ufficiale ammette il set Othello/Reversi; grafia PDF ViceVersi'),
'Chess Territorial':('chess-pdf','1 COMPONENT; 2–3','set normale di scacchi, caselle chiare/scure','pezzi del normale set di scacchi','Fonte dichiara sufficiente un set normale; quantità non riscritta come distinta inventata'),
'Pentwall':('pentwall-pdf','1 foglio visuale; 2 PREPAREATION','1 foglio stampabile 10×10 con 12 sagome di riferimento','non sono richiesti pentomini fisici','Penne di due colori; ammesso un colore distinguendo riempimento/tratteggio'),
'Stoic':('pdf-81','1 introduzione / GAMEPLAY','esagono di dimensione variabile, consigliati lati 4 o 5','pezzi di due colori, quantità non dichiarata','Indice ufficiale: componenti comuni; quantità dipendente dalla plancia'),
'Stride':('pdf-82','1 SETUP','esagono lato 5','13 pezzi impilabili per colore','Nessun limite all’altezza delle pile dichiarato'),
'Squish':('pdf-83','1 SETUP e diagramma; 2 Flowish','esagono variabile, consigliati lati 4 o 5','pezzi di due colori secondo diagramma; quantità non numerata nel testo','Diagramma iniziale verificato; schema estendibile, non imposto un conteggio universale; Flowish è variante nel PDF, non nuovo gioco importato'),
'Unlace':('pdf-84','1 SETUP e diagramma','esagono lato 4 o più, schema estendibile','pezzi di due colori secondo diagramma; quantità non numerata nel testo','Diagramma verificato; condivide schema iniziale con Squish, non regole'),
'Skirt':('pdf-85','1 introduzione / THE BOARD','esagono di qualsiasi dimensione, bordo distinto dall’interno','pezzi di due colori, quantità non dichiarata','Componenti comuni secondo indice; esempio lato 6 non è requisito unico'),
'Node':('pdf-86','1 TERMS / PREPARATION','esagono, bordo distinto dall’interno, esempio lato 6','pezzi di due colori, quantità non dichiarata','Stessi tipi di componenti di Skirt dichiarati, ma diversa preparazione'),
'Orochi':('pdf-87','1 SETUP; 2 GAME END','esagono di dimensione scelta dai giocatori','pezzi di due colori, quantità non dichiarata','Pezzi sostituiti di colore durante il gioco; non equiparati automaticamente a dischi reversibili'),
'Sibling':('pdf-88','1 GAMEPLAY','esagono di dimensione scelta, esempio lato 5','pezzi di due colori, quantità non dichiarata','Indice ufficiale ne attesta componenti comuni; pie rule facoltativa non aggiunge materiali'),
'Mabi':('pdf-89','1 SETUP e diagramma','quadrata 8×8','pezzi di due colori; diagramma 16 per colore','Conteggio 32 totale ricavato dal diagramma verificato, distinto dalla dichiarazione testuale'),
'Tiptoe':('pdf-90','1 introduzione / SETUP; 2 varianti','quadrata di qualsiasi dimensione; esagonale ammessa','pezzi di due colori, quantità non dichiarata','Plance rettangolari o esagonali esplicitamente contemplate, senza minimo pezzi inventato'),
'Apart':('pdf-91','1 SETUP','quadrata 8×8','12 pezzi per colore','Componenti comuni secondo indice; conteggio distinto dal set Square da 69 pezzi'),
'Zong-Heng':('pdf-92','1 COMPONENTS','scacchiera con numero pari di caselle','pezzi pari al numero di caselle, metà per colore','Quantità dipendente dalla plancia; non convertita in 64 obbligatori'),
'Binary':('pdf-93','1 COMPONENTS','scacchiera 8×8; dimensioni maggiori ammesse','16 pezzi per colore per 8×8','Per plance più grandi totale pezzi pari a metà delle caselle; regola esplicita, non equivalenza inventata'),
'Incorrect Checkers':('pdf-94','1 COMPONENTS / SETUP','scacchiera 8×8','12 pezzi per colore','Componenti comuni secondo indice; distinto dal gioco Checkers eventualmente nel fascicolo condiviso'),
'Alquad':('pdf-95','1 SETUP','Alquerque 5×5 intersezioni','11 pezzi per colore in mano dopo la posa iniziale di un pezzo per colore','Totale 12 per colore è normalizzazione aritmetica della preparazione, non citazione del testo'),
'Sight':('pdf-96','1 SETUP / DEFINITIONS; 2','Alquerque 5×5 intersezioni','pezzi impilabili di due colori, quantità non dichiarata','Confezione Alquerq 26 per colore non assunta come requisito effettivo'),
'Collapse':('pdf-97','1 SETUP e diagramma','Fanorona 9×5 intersezioni','pezzi di due colori sul perimetro: diagramma 11 per colore','Conteggio 22 dal diagramma verificato; i due punti laterali intermedi restano vuoti'),
'Snaketrail':('pdf-98','1 SETUP / GAMEPLAY','esagono lato 5 o 6','pezzi bianchi e rossi in quantità uguali scelta dal setup, più pezzi neri','Tre colori effettivi; nessuna quantità fissa per nero dichiarata'),
'Nuts Sorting':('pdf-99','1 SETUP','esagono lato 5','10 pezzi per ciascuno di sei colori: rosso/blu/giallo/nero/bianco/grigio','60 totali; i marcatori fuori plancia nel diagramma indicano assegnazione colori, non conteggi aggiunti obbligatori'),
'Fruits Platter':('pdf-100','1 SETUP','esagono lato 4, centro vuoto','6 pezzi per ciascuno di sei colori sulla plancia','1 pezzo per colore fuori da ciascun lato come indicatore; 42 totali è normalizzazione di 36+6'),
'Candy Chain':('pdf-101','1 SETUP e figure 1/2','testo 5×5; diagramma visuale 8×8, divergenza irrisolta','8 pezzi per ciascuno di sei colori (48)','48 pezzi non entrano in 25 celle; nessuna correzione silenziosa della fonte'),
'Bloody Queen':('queens-pdf','1 COMPONENTS; 2 Variant Bloody Queen','esagono lato 6, trono centrale / anelli','7 pezzi per colore: regina e 6 guardie','Variante nominata a p.2 e link nominativo dall’indice; stessi materiali base'),
'Stacking Morris':('pdf-46','1 COMPONENTS; 2 Variant Stacking Morris','plancia Nine Men’s Morris con linee diagonali','9 pezzi impilabili per colore','Variante nominata p.2, distingue pile di altezza 2; confezione Morris 24'),
'Custodial Pah-Tum':('pdf-102','1 COMPONENTS; 2 variante / GAME END','quadrata 7×7','40 pietre gialle e 40 blu; 5 nere','Variante nominata p.2; termine esplicito della partita se si esauriscono le pietre'),
'Tori Shogi＋':('tori-pdf','1 COMPONENT; 3 Pieces for Expansion Rules','quadrata 7×7','set tradizionale di 32 pezzi con promozioni, più pezzi espansione selezionati','Civetta: una per giocatore sostituisce la gru destra; averla: una per giocatore aggiunta in riserva; una o entrambe espansioni ammesse'),
'Tori Shogi':('tori-pdf','1 COMPONENT / SETUP; 2 pezzi','quadrata 7×7','32 pezzi: 16 rondini, 4 gru, 4 fagiani, 4 quaglie (destra/sinistra), 2 falchi, 2 peng','Promozioni sul retro: rondine/oca e falco/aquila; civetta e averla p.3 sono espansioni facoltative, escluse dalla base; confezione 39'),
'LAG':('lag-pdf','1 COMPONENTS / SETUP','esagono lato 5 con contatore laterale','11 pedoni e 1 cubo per colore','Due URL EN sono byte-identici nel rilevamento, hash conservato senza inventare revisione'),
'Onager':('pdf-9','1 COMPONENTS / SETUP','esagono lato 6','13 pezzi impilabili per colore','3 tessere esagonali blu Lake'),
'Vault':('pdf-9','3 COMPONENTS / SETUP; 4','quadrata 10×10','10 pezzi per colore','La confezione Onager condivide pezzi/plancia bifacciale; le tre tessere Lake non sono elencate nei COMPONENTS di Vault'),
'Carpniches':('pdf-11','1 COMPONENTS / SETUP','quadrata 6×6','6 pezzi impilabili per colore','Illustrazioni cane/capibara della confezione non trasformate in requisito indispensabile'),
"Queen's Guard":('queens-pdf','1 COMPONENTS','esagono lato 6 con anelli e trono','7 pezzi per colore: regina e 6 guardie','Regina distinguibile, variante Bloody Queen nello stesso PDF p.2'),
'Quantum Control':('pdf-16','1 COMPONENTS; 2','esagono con 49 celle blu e 12 grigie, sette aree','25 pezzi neri e 24 bianchi','Confezione condivisa con Quantum Leap: 64 dischi; non tutti richiesti'),
'Quantum Leap':('pdf-16','3 COMPONENTS; 4','esagono con 61 celle','31 pezzi neri e 30 bianchi','Stesso fascicolo di Quantum Control, geometria/quantità diverse; riserve nella confezione dichiarate'),
'Circular Chess':('pdf-22','1 COMPORNENTS / PIECES','circolare con 64 spazi, centro escluso','32 pezzi normali di scacchi in due colori','Set di scacchi comune esplicitamente ammesso, ma plancia circolare specifica'),
'Abande':('trilogy-pdf','1 COMPONENTS; 2','esagonale con 37 intersezioni','18 dischi impilabili per colore','Plancia condivisa con Attangle; confezione 40 dischi'),
'Attangle':('trilogy-pdf','3 COMPONENTS; 4','esagonale con 37 intersezioni, centro marcato','18 dischi impilabili per colore','Centro non occupabile ma attraversabile; stesso lato della plancia Abande'),
'Accasta Pari':('trilogy-pdf','5 COMPONENTS; 6','esagonale con 37 intersezioni e aree Castle','20 dischi impilabili per colore','Lato dedicato della plancia Stacking Trilogy; Accasta original online non equiparata'),
'Slyde':('pdf-28','1 COMPONENTS / SETUP','quadrata 8×8 oppure 10×10','50 tessere nere e 80 dischi grigi dichiarati','Quantità della dotazione nel regolamento; tessere in scacchiera secondo dimensione scelta'),
'Trike':('pdf-30','1 COMPONENTS / SETUP','triangolare esagonale, fronte/retro illustrati','30 dischi bianchi e 30 blu','1 pedone neutrale giallo; pedone può stare sopra un disco'),
'Dryad':('pdf-32','1 COMPONENTS; 2','esagonale con 44 celle','45 dischi verdi e 45 bianchi','40 cubi blu nel PDF contro 35 nella confezione; quantità illimitata, sostituzioni da altri giochi esplicitamente ammesse'),
'Flower Shop':('pdf-34','1 COMPONENTS / SETUP','reticolo triangolare esagonale: lato 6 o 7 intersezioni','30 pezzi Flower rossi e 30 gialli','40 dischi Stem verdi condivisi; tre colori con ruoli distinti'),
'heXentafl':('pdf-37','1 COMPONENTS / SETUP visuale','esagonale lato 4 o 5, trono e uscite marcati','set grande: 1 re, 6 difensori, 12 attaccanti','Set piccolo: 1 re, 3 difensori, 6 attaccanti; re distinto e setup differenziati verificati visivamente'),
'Paintscape':('pdf-39','1 COMPONENTS / SETUP','quadrata 8×8','12 tessere quadrate per ciascuno di cinque colori','25 dischi bianchi e 25 neri; tessere e dischi sono componenti distinti'),
'Make Muster':('pdf-43','1 COMPONENTS / SETUP visuale','plancia dedicata bifacciale, area piccola/grande illustrata','30 dischi navy e 30 rosa','Muster Up è variante nello stesso PDF, non aggiunta al perimetro canonico'),
'Morris':('pdf-46','1 COMPONENTS e varianti; 2','Nine Men’s Morris; variante Six usa due quadrati interni, Twelve aggiunge diagonali','base 9 pezzi per colore; Six 6; Twelve 12','Confezione 24 dischi supporta le varianti, senza imporre 12 alla base'),
'Residuel':('pdf-52','1 COMPONENTS; 2','reticolo a rombi specifico','22 tessere esagonali nere e 22 bianche','25 dischi piccoli neri e 25 bianchi richiesti nel PDF, non elencati nella confezione'),
'Whirlpool':('pdf-55','1 COMPONENTS','91 celle esagonali suddivise in 13 sezioni a spirale','60 pezzi per colore','Geometria delle sezioni indispensabile; nessuna deduzione da sola plancia esagonale generica'),
'Volo':('pdf-59','1 COMPONENTS / SETUP','esagonale in due dimensioni, centro e angoli esclusi','50 dischi per colore','Posizioni iniziali e nests nel diagramma; non attribuire regole di implementazioni'),
'Enso':('pdf-61','1 COMPONENTS / SETUP','quadrata 6×6','16 dischi per colore','Confezione 36, requisito 32; surplus conservato'),
'Shape Chess':('pdf-63','1 COMPONENTS / SETUP','quadrata 13×13 intersezioni','35 pezzi per colore','10 segnapunti; pezzi sulle intersezioni, non nelle celle'),
}

# Factual package quantities and dimensions, normalized in Italian from Components/description.
PACK={
1:'39 dischi legno 19×6 mm con adesivi',2:'62 dischi legno 15×4 mm bianco/nero con adesivi',3:'70 dischi legno 15×4 mm, 35 per colore',4:'32 dischi legno 20×5 mm con adesivi',5:'36 dischi legno 19×6 mm',6:'62 dischi legno 15×4 mm, adesivi sulle due facce',7:'150 dischi legno 10×4 mm, 75 per colore',8:'36 pezzi 20×20×10 mm, 18 per colore',9:'70 pezzi 20×20×10 mm, 35 per colore',10:'70 pezzi 20×20×10 mm, 35 per colore',11:'22 pedoni legno 28×15 mm; 2 cubi 8×8×8 mm',12:'26 dischi cilindrici legno 15×10 mm; 3 tessere acrilico 15×17×2 mm',13:'12 dischi legno 25×7 mm con adesivi',14:'14 pezzi legno 12×24 mm, corone sulle regine',15:'64 dischi legno 15×4 mm, 32 per colore; esclusi variante Pieceless',16:'32 pezzi scacchi plastica, pedone 10×18 mm fino a re 12×33 mm',17:'40 dischi legno 19×6 mm',18:'50 tessere legno 20×20×5 mm; 80 dischi 10×5 mm',19:'1 pedone legno 16×28 mm; 60 dischi 20×5 mm',20:'90 dischi legno 20×5 mm; 35 cubi acrilico 8×8×8 mm',21:'40 dischi Stem verdi 15×4 mm; 60 pezzi Flower, 30 rossi/30 gialli, 15×4 mm',22:'1 re legno 19×38×12 mm; 6 difensori e 12 attaccanti 16×25×12 mm',23:'60 tessere legno: 12 per colore, misura dichiarata 20×20×4 (unità finale non esplicitata); 50 dischi 15×4 mm',24:'60 dischi legno 20×5 mm',25:'24 dischi legno 15×10 mm',26:'44 tessere esagonali acrilico 26×20×2 mm',27:'120 dischi legno 10×4 mm, 60 per colore; esclusi Pieceless',28:'100 dischi legno 15×4 mm blu/giallo',29:'36 dischi legno 19×6 mm',30:'70 dischi legno 15×4 mm; 10 segnapunti 20×5 mm',31:'39 pezzi legno 19×6 mm con adesivi',32:'10 dischi per colore: rosso/blu/giallo/grigio (40); scatola e quattro regolamenti; variante Pieceless senza pezzi',33:'dischi supplementari acquistabili per colore e quantità; non gioco né confezione ludica unica',34:'52 dischi 15×4 mm, 26 per colore; Pieceless senza dischi; 5 fogli regole EN',35:'69 dischi 15×4 mm: 32 bianchi, 32 neri, 5 rossi; Pieceless senza dischi; 8 fogli regole EN',36:'64 dischi 15×4 mm, 32 per colore; Pieceless senza dischi; 6 fogli regole EN',37:'121 dischi 15×4 mm: 61 rossi e 60 blu; Lite 80, Pieceless zero; nessun regolamento puntuale in pagina',38:'92 dischi 15×4 mm, 46 per colore; Lite 62, Pieceless zero; 8 fogli regole EN',39:'base legno 215×215 mm; scatola 220×220 mm; accessorio distinto dai giochi'}

def main():
    b=json.loads((LOCAL/'BASELINE.json').read_text(encoding='utf8'))
    files={p.stem:json.loads(p.read_text(encoding='utf8')) for p in LOCAL.glob('*.json') if p.name not in ('consultations.json','BASELINE.json')}
    by_url={d['url']:d for d in files.values()}
    journal=json.loads((LOCAL/'consultations.json').read_text(encoding='utf8'))
    if not any(x['url']==files['online-source-page']['url'] for x in journal):
        journal.append({'url':files['online-source-page']['url'],'kind':'html','status':'read','key':'online-source-page','verified_at':DATE,'scope':'solo dichiarazione Kanare; nessuna destinazione online verificata'})
    consultations={x['url']:x for x in journal}
    for x in journal:
        if x['status']=='read':
            x['consultation_mode']='local_original_reused' if by_url[x['url']].get('local_reuse') else 'remote_in_memory' if x['kind']=='pdf' else 'official_html'
    sr={r['id']:r for r in b['source_records']}
    resources=[]
    for r in b['resources']:
        x=consultations.get(r['url'])
        resources.append({'id':r['id'],'url':r['url'],'kind':r['resource_kind'],'language':r['language_code'],
          'format':r['media_type'],'version_declared':r['version_raw'],'access':r['access_type'],'technical_access':'direct_url',
          'baseline_observed_at':r['first_seen_at'],'baseline_verification':r['verification_status'],
          'consultation':x['status'] if x else 'metadata_only_image_not_opened',
          'consultation_mode':x.get('consultation_mode') if x else None,
          'availability_observation':'local_original_read; current_official_page_links_url; remote_file_not_rechecked' if x and x.get('consultation_mode')=='local_original_reused' else 'remote_accessible_at_consultation' if x and x['status']=='read' else 'declared_url_only; file_not_opened',
          'pages_consulted':x.get('pages') if x else None,'sha256_of_consultation':x.get('sha256') if x else None,
          'verified_at':DATE if x else None,'license':'non attestata; nessun diritto di redistribuzione inferito',
          'source_record_id':r['source_record_id']})
    packs=[]
    for p in b['products']:
        record=None
        records=[sr[x['source_record_id']] for x in b['product_source_records'] if x['product_id']==p['id'] and x['source_record_id'] in sr and '/products/' in sr[x['source_record_id']]['canonical_url']]
        if not records:
            # The stable native ID is a Shopify product slug; names vary between normalized/source versions.
            aliases={32:'colorpack',33:'gamediscs',34:'generic-board-alquerq-set',35:'generic_board_square',36:'generic_board_checkered',37:'generic_board_parallelo',38:'generic_board_hexagonal',39:'woodbase'}
            record=next((s for s in sr.values() if s['canonical_url'].endswith('/'+aliases.get(p['id'],'__none__'))),None)
        else:record=records[0]
        if not record:
            raise ValueError(('Missing product provenance',p['id']))
        dimensions='plancia tessuto 200×200 mm; scatola 110×110×28 mm; foglio regole 195×195 mm'
        if p['id'] in (2,3):dimensions='plancia tessuto 200×200 mm; scatola 110×110×28 mm; foglio regole 195×293 mm'
        if p['id']==4:dimensions='plancia tessuto 200×200 mm; scatola 110×110×28 mm; foglio regole 293×195 mm'
        if p['id'] in (14,16,25):dimensions='plancia tessuto 200×200 mm; scatola 110×110×28 mm; foglio regole 195×292 mm'
        if p['id']==28:dimensions='plancia tessuto 200×200 mm; scatola 110×110×28 mm; foglio regole 195×293 mm'
        if p['id'] in (18,19,22,24):dimensions='plancia 220×252 mm; scatola 232×137×33 mm; regolamento 189×324 mm'
        if p['id'] in (32,33,39):dimensions='misure ulteriori non dichiarate nel riepilogo componenti'
        if p['id']==17:dimensions+='; 3 fogli regole; plancia bifacciale'
        if p['id'] in (12,15):dimensions+='; 2 fogli regole'
        packs.append({'product_id':p['id'],'name':p['canonical_name'],'source_url':record['canonical_url'],
          'verified_at':DATE,'locator':'Components e Description / varianti confezione',
          'declaration_summary':PACK[p['id']],'physical_dimensions':dimensions,
          'not_game_requirements':True,'historical_product_status':p['status_normalized']})
    games=[]
    for g in b['games']:
        title=g['canonical_title'];gid=g['id']
        relations=[x for x in b['game_source_records'] if x['game_id']==gid and x['match_status']!='rejected']
        pages=[sr[x['source_record_id']]['canonical_url'] for x in relations if sr[x['source_record_id']]['canonical_url'] in by_url]
        product_ids=[x['product_id'] for x in b['product_games'] if x['game_id']==gid]
        for p in packs:
            if p['product_id'] in product_ids:pages.append(p['source_url'])
        notes=[]; credits=[]
        for cr in b['credits']:
            if cr['game_id']==gid:
                credits.append({'name':cr['display_name'],'role':cr['role'],'evidence_url':sr[cr['evidence_record_id']]['canonical_url'] if cr['evidence_record_id'] in sr else None,'observed_at':cr['observed_at'],'status':'historical_declared_preserved'})
        if title=='Swarm':
            games.append({'game_id':gid,'title':title,'analysis_status':'blocked','search_status':'conclusa_nel_perimetro','verified_at':DATE,
              'official_pages':[g['source_url']],'resource_ids':[],'requirements':[], 'package_product_ids':[],
              'credits':credits or [{'name':None,'role':'designer','status':'autore_non_registrato'}],
              'limits':['Solo titolo Swarm (unpublished) nella matrice Kanare; nessun regolamento/materiale ufficiale puntuale osservato. Piattaforme escluse, non aperte.'],
              'common_components_suffice':'non_determinabile','inferences':[]});continue
        key,locator,board,pieces,extra=DATA[title];doc=files[key];pages=list(dict.fromkeys(pages))
        rid=next(r['id'] for r in resources if r['url']==doc['url'])
        attributable=set([rid]); historical=set()
        confirmed_record_ids={x['source_record_id'] for x in relations if x['match_status']=='confirmed'}
        confirmed_record_ids|={x['source_record_id'] for x in b['product_source_records'] if x['product_id'] in product_ids and x['match_status']=='confirmed'}
        for x in b['resource_links']:
            if x['game_id']==gid or x['product_id'] in product_ids or x['source_record_id'] in confirmed_record_ids and sr[x['source_record_id']]['record_type'] not in ['work_index','product_catalog','online_play']:
                historical.add(x['resource_id'])
        # Official current page mentions preserve direct resources, including all languages.
        for url in pages:
            for link in by_url[url].get('links',[]):
                matched=next((r['id'] for r in resources if r['url']==link['url']),None)
                if matched is not None: attributable.add(matched)
        # Aggregated variant provenance is resolved only by the named index link + exact PDF section.
        variant=title in ['Bloody Queen','Stacking Morris','Custodial Pah-Tum','Tori Shogi＋']
        if variant:
            attributable={rid};notes.append('Associazione puntuale verificata: link nominativo nell’indice ufficiale e sezione nominata nel PDF; baseline aggregata preservata nel database.')
        if title=='Candy Chain':notes.append('Contraddizione plancia: testo 5×5 contro diagramma 8×8 e 48 pezzi; requisito esatto da chiarire.')
        if title=='Dryad':notes.append('Confezione 35 cubi; regolamento 40 e quantità illimitate con sostituzioni ammesse.')
        if title=='Residuel':notes.append('Confezione elenca 44 tessere senza i 50 dischi piccoli richiesti nel PDF; contenuto non corretto implicitamente.')
        if title in ('Mabi','Collapse'):notes.append('Conteggio pezzi normalizzato dal diagramma, non dichiarazione testuale numerica.')
        if title in ('Stoic','Squish','Unlace','Skirt','Node','Orochi','Sibling','Tiptoe','Sight','Snaketrail'):notes.append('Quantità universale non dichiarata; schema o dimensione variabile conservati, nessun minimo inventato.')
        if title=='Chess Territorial':resources[rid-1]['version_declared']='1.0 (p.1)'
        docs_text=doc['text']
        for cr in credits:
            # Name occurrence alone cannot confirm a role: restrict current designer evidence to a labeled credit.
            if cr['role']=='designer' and cr['name'] and re.search(r'(?:Designed by|Game Design:)\s*'+re.escape(cr['name']),docs_text):
                cr.update({'status':'declared_current_document','evidence_url':doc['url'],'verified_at':DATE,'locator':'crediti/intestazione nelle pagine del fascicolo; ambito gioco da rispettare'})
        # Specific roles as read in footers; do not turn a copyright footer into designer attribution.
        extra_roles=[]
        if title in ['LAG','Abande','Attangle','Accasta Pari','Onager','Vault','Volo','Enso','Quantum Leap']:
            partners={'LAG':'Takuro Kawasaki','Abande':'Dieter Stein','Attangle':'Dieter Stein','Accasta Pari':'Dieter Stein','Onager':'Néstor Romeral Andrés','Vault':'Néstor Romeral Andrés','Volo':'Dieter Stein','Enso':'Dieter Stein','Quantum Leap':'Néstor Romeral Andrés'}
            extra_roles=[(partners[title]+' + Kanare Kato','rulebook'),('Kanare Kato' if title not in ['Volo','Enso'] else 'Dieter Stein + Kanare Kato','artwork' if title not in ['Onager','Vault','Quantum Leap'] else 'graphic_design')]
        elif title in ['Carpniches','Slyde','Trike','Dryad','Flower Shop','heXentafl','Paintscape','Make Muster','Residuel','Whirlpool','Shape Chess','Quantum Control']:
            art={'Carpniches':'Augusto Belmonte','heXentafl':'Kevin Kane + Kanare Kato','Make Muster':'Dale Walton + Kanare Kato'}.get(title,'Kanare Kato')
            extra_roles=[('Kanare Kato','rulebook'),(art,'artwork' if title not in ['Dryad','Whirlpool','Quantum Control'] else 'graphic_design')]
            if title=='Trike':extra_roles.append(('Alek Erickson + Josh Brown','original_logo_design'))
            if title=='Shape Chess':extra_roles.append(('Mingyang Tian','special_thanks'))
        elif title in ['Circular Chess','Morris','Tori Shogi','Tori Shogi＋','Bloody Queen','Stacking Morris','Custodial Pah-Tum',"Queen's Guard"]:
            extra_roles=[('Kanare Kato','rulebook')]
        for name,role in extra_roles:
            credits.append({'name':name,'role':role,'status':'declared_current_document','evidence_url':doc['url'],'verified_at':DATE,'locator':'footer / crediti del fascicolo, sezione '+locator})
        if not any(c['role'] in ['designer','game_design','modern_application'] for c in credits):
            credits.append({'name':None,'role':'designer','status':'autore_non_registrato_oppure_tradizionale_non_attribuito'})
        common=title in ['ViceVeresi','Chess Territorial','Stoic','Stride','Squish','Unlace','Skirt','Node','Orochi','Sibling','Mabi','Tiptoe','Apart','Zong-Heng','Binary','Incorrect Checkers','Alquad','Sight','Collapse','Snaketrail','Nuts Sorting','Fruits Platter','Candy Chain']
        games.append({'game_id':gid,'title':title,'analysis_status':'partial' if title=='Candy Chain' else 'complete',
          'search_status':'conclusa_nel_perimetro','verified_at':DATE,'official_pages':pages,
          'resource_ids':sorted(attributable|historical),'reviewed_rule_resource_id':rid,'rule_evidence':{'url':doc['url'],'locator':locator,'verified_at':DATE},
          'historical_resource_ids':sorted(historical),'requirements':[
             {'kind':'board','quantity':1,'declaration_summary':board,'normalization':board,'supply_mode':'printable' if title=='Pentwall' else 'common' if common else 'specific_or_marked','physical_measure':'non_dichiarata_nel_regolamento; vedere confezione'},
             {'kind':'playing_pieces','quantity_raw_summary':pieces,'normalization':pieces,'supply_mode':'common' if common else 'documented_characteristics'},
             {'kind':'additional_materials_or_constraints','declaration_summary':extra,'normalization':None}],
          'package_product_ids':product_ids,'credits':credits,'limits':notes,
          'resource_attribution_limit':'Le risorse di un prodotto/set sono riferimenti condivisi: non tutte le immagini raffigurano questo gioco, né tutte le sezioni del fascicolo ne descrivono i requisiti. Fa fede rule_evidence per la sezione analizzata.',
          'common_components_suffice':'fonte_ammette_componenti_comuni_con_plancia_conforme' if common else 'foglio_stampa_e_penne' if title=='Pentwall' else 'non_attestato; vedere caratteristiche_specifiche',
          'inferences':[{'type':'arithmetic_or_diagram_normalization','summary':pieces if title in ['Mabi','Collapse','Alquad'] else extra}] if title in ['Mabi','Collapse','Alquad','Fruits Platter'] else []})
    result={'task_id':'TSK-0070','verified_at':DATE,'scope':'64 giochi preesistenti, fonte Kanare ufficiale; IT/EN autorizzati; nessuna acquisizione',
      'status_definitions':{'complete':'fonti ufficiali puntuali consultate e inventario ricostruito; informazioni non dichiarate e divergenze restano esplicite','partial':'fonte consultata ma requisito plancia non riconciliabile','blocked':'mancanza di materiale ufficiale puntuale nel perimetro, dopo ricerca'},
      'baseline':{'games':64,'resources':141,'rejected_homonym_excluded_game_id':907,'source_date':'2026-09-20'},
      'counts':{'games':len(games),'analysis':dict(collections.Counter(g['analysis_status'] for g in games)),
         'html_pages_consulted':len([x for x in journal if x['kind']=='html' and x['status']=='read']),
         'pdf_urls_consulted':len([x for x in journal if x['kind']=='pdf' and x['status']=='read']),
         'pdf_unique_bytes_consulted':len({x['sha256'] for x in journal if x['kind']=='pdf' and x['status']=='read'}),
         'pdf_pages_consulted_url_count':sum(x.get('pages',0) for x in journal),
         'pdf_local_originals_reused':3,'new_pdf_files_acquired':0,'language_exclusions':dict(collections.Counter(x.get('language') for x in journal if x['status']=='metadata_only_language_excluded'))},
      'games':games,'resources':resources,'products':packs,
      'consultations':[{k:v for k,v in x.items() if k not in ('key','error')} for x in journal],
      'database_decision':'Sola lettura. catalog_resources/products/legami/crediti riutilizzati tramite ID. entry_material_requirements richiede entry BGG: nessuna migrazione o associazione fittizia; inventario nel manifest.',
      'excluded':'JA, ES, ZH solo metadati; nessuna piattaforma verificata, acquisizione, IMG, AI o modifica app/Git.'}
    path=ROOT/'catalog/kanare_material_census_2026-10-06.json'
    path.write_text(json.dumps(result,ensure_ascii=False,indent=2)+'\n',encoding='utf8')
    lines=['# Inventario materiali Kanare Abstract','',f'Rilevamento {DATE}, TSK-0070. 64 giochi; fonti ufficiali, regolamenti EN; IT non osservati. Quantità di confezione separate dai requisiti. Nessun nuovo PDF acquisito.','',
      'Analisi completa significa ricerca conclusa nel perimetro e requisiti ricostruiti dalle fonti; non certifica che ogni misura sia dichiarata, né una licenza. Dettagli e URL di tutte le lingue nel manifest catalog.','',
      '| Gioco / ID | Esito | Requisiti e caratteristiche | Fonte e posizione |','|---|---|---|---|']
    for g in games:
        if g['requirements']:
            text='; '.join(x.get('declaration_summary') or x.get('quantity_raw_summary') or '' for x in g['requirements'])
            evidence=f"[Regolamento]({g['rule_evidence']['url']}) — {g['rule_evidence']['locator']}"
        else:text='Materiali non osservati; solo dichiarazione Swarm (unpublished).';evidence=f"[Fonte]({g['official_pages'][0]}) — matrice titolo"
        lines.append(f"| {g['title']} / {g['game_id']} | {g['analysis_status']} | {text.replace('|','/')} | {evidence} |")
    lines+=['','## Confezioni e set','', 'Misure fisiche dei prodotti: riferimenti di confezione, non misure minime per giocare. Materiali, fogli e scatole distinti.','', '| Prodotto / ID | Contenuto dichiarato riassunto | Dimensioni | Fonte |','|---|---|---|---|']
    for p in packs:lines.append(f"| {p['name']} / {p['product_id']} | {p['declaration_summary']} | {p['physical_dimensions']} | [Scheda]({p['source_url']}) — Components/Description |")
    lines+=['','## Crediti per gioco','', 'Fonte e data dei crediti storici restano nel manifest. I ruoli attuali sono distinti; marchio/editore non trasformato in autore.','']
    for g in games:
        lines.append(f"- **{g['title']}**: "+'; '.join(f"{c['name'] or 'Autore non registrato'} ({c['role']})" for c in g['credits'])+'.')
    (TASK/'INVENTORY.md').write_text('\n'.join(lines)+'\n',encoding='utf8')
    print(json.dumps(result['counts'],ensure_ascii=False))

if __name__=='__main__':main()
