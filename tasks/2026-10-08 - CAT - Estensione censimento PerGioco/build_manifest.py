"""Formalizzazione CAT da osservazioni browser; sola lettura SQLite, nessuna rete."""
import hashlib
import json
import sqlite3
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
TASK = Path(__file__).resolve().parent
DATE = '2026-10-08'
BASE = 'https://www.pergioco.net/'
INDEX = BASE + 'giochi-con-carta-e-matita.html'
MANIFEST = ROOT / 'catalog/pergioco_extension_carta_matita_2026-10-08.json'
DB = ROOT / 'database/pnp_collection.sqlite3'

def digest(p):
    return hashlib.sha256(p.read_bytes()).hexdigest()

def snapshot():
    paths = [p for folder in ('app','database') for p in (ROOT/folder).rglob('*')
             if p.is_file() and '__pycache__' not in p.parts]
    paths += [ROOT/'catalog/pergioco_pilot_2026-10-06.json']
    return {p.relative_to(ROOT).as_posix():digest(p) for p in sorted(paths)}

baseline_path = TASK/'BASELINE.json'
if not baseline_path.exists():
    baseline_path.write_text(json.dumps(dict(checked_at=DATE,files=snapshot()),indent=2)+'\n',encoding='utf-8')

def credit(name, role, context, status='declared_by_source'):
    return dict(name_raw=name,role_raw=role,subject_context_raw=context,status_raw=status)

def relation(label, kind, url=None, note=None):
    return dict(target_label_raw=label,target_url=url,relation_type_raw=kind,
                assertion_status='declared_by_source',information_requirement='unknown',
                ownership_requirement='unknown',purchase_requirement='unknown',summary_original=note)

# Sintesi originali: nessuna riproduzione dei regolamenti o dei diagrammi.
rows = [
 dict(key='PGCM-001', title='Battaglia Navale con Carta e Matita', index_title='Battaglia Navale',
      slug='battaglia-navale-carta-e-matita', aliases=[], year=None, designer=None,
      outcome='requirement_not_demonstrated', completeness='incomplete',
      summary='Deduzione a due con flotte nascoste e coordinate. La scheda illustra il ciclo generale ma non specifica dimensioni, composizione della flotta o vincoli di schieramento sufficienti a una configurazione operativa completa.',
      credits=[credit('Milton Bradley','publisher','Edizione commerciale da tavolo citata dal 1967; non credito del sistema tradizionale.'),credit('Pierre Berloquin','historical_attribution_source','Ipotesi storica riportata; non designer attestato.')],
      relations=[relation('Battaglia Navale','commercial_boardgame_mentioned',BASE+'battaglia-navale.html','Rinvio alla versione da tavolo; non equivalenza/versione confermata.')],
      notes=['Attestazione italiana 1932 e commercializzazione 1967 sono contesti storici, non anno di ideazione fissato.','Varianti dimensionali e di flotta menzionate genericamente; nessuna nuova candidata.'],
      classification_end='Battaglia Navale'),
 dict(key='PGCM-002',title='Engel',index_title='Engel',slug='engel',aliases=[],year=1975,designer='D. Engel',outcome='admitted',completeness='complete_CAT_assessment',
      summary='Gioco a due di segmenti su carta quadrettata. La scheda pubblica contiene preparazione, turno, vincoli e condizione di fine; sufficiente per il requisito CAT senza playtest.',
      credits=[credit('Pierre Berloquin','reference_book_author','100 Jeux de Table (1976), edizione italiana Il Centogiochi (1979).')],relations=[],
      notes=['Iniziale D. preservata: nome completo non attestato.','Titolo Introduzione non implica regole incomplete.'],classification_end='Engel'),
 dict(key='PGCM-003',title='Labirinto',index_title='Labirinto',slug='labirinto',aliases=[],year=None,designer=None,outcome='admitted',completeness='sufficient_logical_system',
      summary='Sistema solitario di ricerca di un percorso fra entrata e uscita. Obiettivo e struttura del problema sono pubblici e sufficienti nel perimetro logico adottato; disponibilità di un diagramma giocabile attestata separatamente.',
      credits=[credit('Andrea Angiolino','reference_book_author','Dizionario dei Giochi (2010).'),credit('Beniamo Sidoti','reference_book_author','Nome riportato così nella scheda; non corretto né risolto automaticamente.'),credit('Zanichelli','reference_book_publisher','Dizionario dei Giochi (2010).')],
      relations=[],notes=['Tre diagrammi nominati e datati nella pagina associata; contano come istanze dichiarate, non tre giochi.','Screenshot di consultazione mostra intestazioni/date e banner editoriali, ma non un labirinto utilizzabile: usability non attestata; non equivale ad assenza permanente.','Il Diagramma 2 dichiara un vincolo narrativo aggiuntivo; conservato come qualificazione di istanza.'],classification_end='Labirinto'),
 dict(key='PGCM-004',title='Numerino',index_title='Numerino',slug='numerino',aliases=['Bulls and Cows','Numerello','Strike & Ball','Ball & Strike'],year=None,designer=None,outcome='admitted',completeness='complete_CAT_assessment',
      summary='Deduzione a due di un codice numerico con indizi. Regole del sistema pubblico sufficienti; numero di tentativi e opzioni del codice sono parametri da concordare, non valori inventati dal catalogo.',
      credits=[credit('Mordecai Meirowitz','designer','Solo Master Mind/Mastermind, adattamento citato nel 1971; non designer del Numerino tradizionale.'),credit('Invicta','publisher','Solo Master Mind/Mastermind, commercializzazione citata nel 1972.')],
      relations=[relation('Master Mind / Mastermind','adaptation_mentioned',BASE+'mastermind.html'),relation('Codice Segreto','see_also',BASE+'codice-segreto.html')],
      notes=['Diffusione italiana dagli anni trenta dichiarata; nessun anno preciso di invenzione.','Alternative su cifre/simboli/lettere registrate come opzioni interne; non nuove identità.'],classification_end='Numerino'),
 dict(key='PGCM-005',title='Piattola',index_title='Piattola',slug='piattola',aliases=['Morpion'],year=None,designer=None,outcome='admitted',completeness='complete_CAT_assessment',
      summary='Gioco a due di allineamenti su carta. La pagina contiene regole del base, varianti nominate e versioni solitarie; queste sono descritte separatamente nel record senza moltiplicare le nove candidate autorizzate.',
      credits=[credit('René Alleau','reference_book_author','Guida ai Giochi (1976), originale Dictionnaire des Jeux.'),credit('Donatella Cerutti','reference_book_translator','Traduzione di Dictionnaire des Jeux citata.'),credit('Pierre Berloquin','reference_book_author','Il CentoGiochi / 100 Jeux de Table; date editoriali dichiarate nella pagina.'),credit('Adriana Crespi Bartolini','reference_book_translator','Traduzione di 100 Jeux de Table citata.'),credit('Andrea Angiolino','reference_book_author','101 Giochi con Carta e Matita (2008), fonte delle prime tre varianti; non designer attribuito.'),credit('Marino Carpignano','designer','Solo Variante Simmetrica, esplicitamente ideata dal curatore.')],
      relations=[],notes=['Morpion è il termine francese da cui la fonte deriva il nome; equivalenza globale non verificata.','Autori dei volumi e traduttori non diventano designer del base.'],classification_end='Piattola'),
 dict(key='PGCM-006',title='Punti e linee',index_title='Punti e linee',slug='punti-e-linee',aliases=[],year=None,designer=None,outcome='requirement_not_demonstrated',completeness='collection_without_single_system',
      summary='La destinazione è una raccolta di enigmi con rinvii a quattro titoli, non una scheda con un sistema unitario di regole. Non assegnata identità di gioco né ammissione automatica ai titoli collegati.',
      credits=[],relations=[relation('Gioco dei 9 punti','collection_member',BASE+'e/gioco-dei-9-punti.html'),relation('Gioco dei 16 punti','collection_member',BASE+'e/gioco-dei-16-punti.html'),relation('Gioco dei 12 punti','collection_member',BASE+'e/gioco-dei-12-punti.html'),relation('Stella a 7 punti','collection_member',BASE+'e/stella-a-7-punti.html')],
      notes=['Punti e Linee è anche alias dichiarato di Quadratini: omonimia editoriale, non equivalenza provata.','Titoli collegati fuori denominatore: non censiti sistematicamente né ammessi.'],classification_end='Punti e linee'),
 dict(key='PGCM-007',title='Quadratini',index_title='Quadratini',slug='quadratini',aliases=['Punti e Linee','Battaglia sui Quadrati','Caccia alla Volpe','Dots and Boxes','Boxes','Squares','(Game of) Dots','Dots and Dashes','Dot to Dot Grid','La Pipopipette'],year=1889,designer='François Édouard Anatole Lucas',outcome='admitted',completeness='complete_CAT_assessment',
      summary='Gioco a due di conquista di celle. La scheda pubblica copre preparazione, turno e termine; la particolare cornice già delimitata resta caratteristica della versione descritta, senza equivalenza universale con altri regolamenti.',
      credits=[credit('Andrea Angiolino','reference_book_author','101 Giochi con Carta e Matita (2008), uso del titolo Quadratini.')],
      relations=[relation(t,'inspired_boardgame_mentioned',BASE+s+'.html') for t,s in [('Boxes','boxes'),('Squaresville','squaresville'),('Honeycomb','honeycomb'),('Box-It','box-it'),('Squares','squares'),('Punto e Linea','punto-e-linea')]],
      notes=['Boxes e Squares compaiono sia fra alias sia fra giochi di tavoliere ispirati: ruoli contestuali distinti, nessuna fusione.','(Game of) Dots preservato come notazione originale, non espanso in alias inventati.'],classification_end='Quadratini'),
 dict(key='PGCM-008',title='Sqez',index_title='Sqez',slug='sqez',aliases=[],year=1973,designer='Dan Laycock',outcome='admitted',completeness='complete_CAT_assessment',
      summary='Gioco a due di occupazione geometrica su carta. Preparazione, turno, vincoli e vittoria sono osservati nel testo pubblico; nessun playtest.',credits=[],relations=[],notes=[],classification_end='Sqez'),
 dict(key='PGCM-009',title='Stripes!',index_title='Stripes!',slug='stripes',aliases=[],year=2016,designer='Marino Carpignano',outcome='admitted',completeness='complete_CAT_assessment',
      summary='Gioco a due di strisce colorate su carta. Scheda pubblica con preparazione, azioni, vincoli, esito e punteggio; esempi illustrativi menzionati, senza estrazione delle figure.',credits=[],relations=[],notes=['Titolo con punto esclamativo preservato.','Refuso ripetitivo nella regola e) non normalizzato in una nuova regola; nessun effetto CAT individuato.'],classification_end='Stripes!'),
]

records=[]
with sqlite3.connect(DB.resolve().as_uri()+'?mode=ro',uri=True) as db:
    db.row_factory=sqlite3.Row
    for row in rows:
        is_collection=row['key']=='PGCM-006'
        url=BASE+('e/' if is_collection else 'a/')+row['slug']+'.html'
        path=['Giochi','Giochi logici e di induzione','Enigmi logici',row['classification_end']] if is_collection else ['Giochi','Giochi con carta e matita','Elenco alfabetico',row['classification_end']]
        credits=row['credits'][:]
        credits.insert(0,credit(row['designer'],'designer','Sistema principale', 'declared_by_source' if row['designer'] else 'not_declared'))
        credits.append(dict(name_raw='Marino Carpignano',role_raw='site_curator_owner',subject_context_raw='Sito; nessuna attribuzione automatica di design/redazione/traduzione.',status_raw='declared_in_FAQ',source_url=BASE+'faq.html',observed_at=DATE))
        for c in credits:
            c.setdefault('source_url',url); c.setdefault('observed_at',DATE)
        for role in ('illustrator','page_writer','page_translator'):
            credits.append(dict(name_raw=None,role_raw=role,subject_context_raw='Scheda principale',status_raw='not_registered',source_url=url,observed_at=DATE))
        credits.append(dict(name_raw=None,role_raw='publisher',subject_context_raw='Sistema principale; editori di volumi/prodotti citati hanno contesto distinto.',status_raw='not_registered',source_url=url,observed_at=DATE))
        queries=list(dict.fromkeys([row['title'],row['index_title']]+row['aliases']))
        matches=[]
        for name in queries:
            for m in db.execute('SELECT id,canonical_title FROM games WHERE canonical_title = ? COLLATE NOCASE UNION SELECT g.id,g.canonical_title FROM game_names n JOIN games g ON g.id=n.game_id WHERE n.name = ? COLLATE NOCASE',(name,name)):
                matches.append(dict(queried_name=name,game_id=m['id'],canonical_title=m['canonical_title']))
        source_matches=[dict(m) for m in db.execute('SELECT id,source_id,title_raw,canonical_url FROM source_records WHERE canonical_url IN (?,?)',(url,BASE+row['slug']+'.html'))]
        resources=[dict(mention_key='main_html',kind='collection_index_html' if is_collection else 'rules_html' if row['outcome']=='admitted' else 'presentation_html',url=url,declared=True,access='public_no_login_observed',scope='public_content',content_observed=True,completeness=row['completeness'],free_observed=True,observed_at=DATE)]
        instances=[]
        if row['key']=='PGCM-003':
            resources += [dict(mention_key='diagrams',kind='problem_instances_html',url=BASE+'a/labirinto-diagrammi.html',declared=True,access='public_no_login_observed',content_observed=True,completeness='three_named_instances_dates_observed',usable_scheme_observed=None,usability_limit='Intestazioni/date osservate; immagine utilizzabile non attestata nello screenshot.',free_observed=True,observed_at=DATE),dict(mention_key='solutions',kind='solutions',url=BASE+'a/labirinto-soluzioni.php',declared=True,access='not_verified',content_observed=None,completeness='not_observed',free_observed=None,observed_at=DATE)]
            for n,raw,date in [(1,'1 febbraio 2021','2021-02-01'),(2,'8 febbraio 2021','2021-02-08'),(3,'29 dicembre 2023','2023-12-29')]:
                instances.append(dict(instance_key='PGCM-003:diagram:'+str(n),label_raw='Diagramma '+str(n),kind='problem_instance',date_raw=raw,published_at=date,source_url=BASE+'a/labirinto-diagrammi.html',observed_at=DATE,usable_scheme_observed=None,solution_relation='link_in_same_named_block; destination_content_not_verified',solution_url=BASE+'a/labirinto-soluzioni.php',qualification_raw='Vincolo pecora/lupo dichiarato' if n==2 else None))
        for rel in row['relations']:
            rel.update(source_url=url,observed_at=DATE)
        record=dict(candidate_id=row['key'],local_record_key='pergioco:carta-matita:20261008:'+row['key'],native_id=None,
            event_key='TSK-0080:browser:20261008:'+row['key'],candidate_title=row['index_title'],title_original=row['title'],title_normalized=row['title'],aliases_declared=row['aliases'],year_declared=row['year'],
            source_url=url,requested_url=BASE+row['slug']+'.html',final_url=url,redirect_chain=None,redirect_limit='Endpoint richiesto/finale osservati; passaggi intermedi non attestati.',observed_at=DATE,formalized_at=DATE,page_updated_raw='22/09/2026' if is_collection else '25/09/2026',
            entity_kind_observed='editorial_collection' if is_collection else 'logical_rule_system' if row['key']=='PGCM-003' else 'game_rule_system',
            credits=credits,native_classification=[dict(label='Giochi logici e di induzione' if is_collection else 'Giochi con carta e matita',kind='breadcrumb',path=path,source_url=url,observed_at=DATE),dict(label='Giochi con carta e matita',kind='index_membership',path=['Giochi','Giochi con carta e matita','Elenco alfabetico'],index_title=row['index_title'],source_url=INDEX,observed_at=DATE)],
            classification_exhaustiveness='all_observed_memberships_retained; no_whole_site_exhaustiveness_claim',
            rules=dict(language='it',completeness=row['completeness'],public_content_free=True,complete_rules_free=True if row['outcome']=='admitted' else None,assessment_original=row['summary'],source_url=url,observed_at=DATE,playtested=False),outcome=row['outcome'],
            access_assessments=[dict(subject_scope='public_content',access='public_no_login_observed',cost_status='free_observed',observed_at=DATE),dict(subject_scope='complete_rules',access='public_no_login_observed' if row['outcome']=='admitted' else 'unknown',cost_status='free_observed' if row['outcome']=='admitted' else 'unknown',observed_at=DATE),dict(subject_scope='components_product',access='not_verified',cost_status='unknown',observed_at=DATE),dict(subject_scope='online_implementation',access='not_verified',cost_status='unknown',observed_at=DATE)],
            resources=resources,instances=instances,relations_and_dependencies=row['relations'],notes_original=row['notes'],
            local_matching=dict(checked_at=DATE,method='SQLite mode=ro; titolo/alias esatti case-insensitive games.canonical_title + game_names.name; URL esatti source_records. Non cerca equivalenti semantici.',queried_names=queries,matches=matches,source_url_matches=source_matches,status='candidate' if matches or source_matches else 'no_exact_match',limit='Nessuna fusione o conferma; assenza di match esatto non prova assenza di equivalenti.'),
            conditions_ref='PG-CONDITIONS-20261008',normalizations=dict(title='Identico al titolo della scheda.',dates='Solo date editoriali esatte convertite ISO; anni di ideazione distinti.'),inferences=[],coverage_state='complete_CAT_candidate_assessment')
        if row['key']=='PGCM-005':
            record['embedded_variants']=[dict(label_raw=t,kind='variant_declared',cataloged_as_separate_candidate=False,source_url=url,observed_at=DATE,aliases_declared=['Morpion Solitaire','Join Five'] if t=='Piattola Solitaria' else [],designer_declared='Marino Carpignano' if t=='Variante Simmetrica' else None,admission_separately_assessed=False) for t in ['Variante 1','Variante 2','Variante 3','Variante a tempo','Variante Simmetrica','Piattola Solitaria','Piattola Solitaria per Due']]
        records.append(record)

manifest=dict(schema_version=1,task_id='TSK-0080',source_key='pergioco',observed_at=DATE,formalized_at=DATE,
    scope_reference='sources/PERGIOCO-SCOPE.md + contratto TSK-0080',scope_label='Carta e matita: nove voci residue confermate',candidate_denominator=9,censused_count=9,admitted_count=7,requirements_not_demonstrated_count=2,not_observable_count=0,imported_count=0,downloaded_count=0,full_site_census=False,
    index_observation=dict(source_url=INDEX,observed_at=DATE,page_updated_raw='26/09/2026',entries=10,previously_censused=[dict(title='Chomp',pilot_id='PGP-005',task_id='TSK-0074',recensused=False)],new_candidate_count=9,stale_web_copy_limit='Copia web datata 28/08/2025 senza Battaglia Navale, superata per ricognizione corrente dal browser; nessuna deduzione di inserimento recente.'),
    conditions=dict(condition_key='PG-CONDITIONS-20261008',url=BASE+'termini-e-condizioni.html',observed_at=DATE,page_updated_raw='26/09/2026',summary_original='Condizioni del sito limitano copia/modifica/pubblicazione/distribuzione senza consenso; indicano conservazione sul computer e stampa di estratti per uso personale. Nessuna licenza aperta o permesso di redistribuzione attestato.',permission_state='not_attested_for_public_redistribution',registration_declared_free=True,registration_source_url=BASE+'faq.html',registration_observed_at=DATE,newsletter_declared_free=True,registration_performed=False),
    method=dict(primary='Browser corrente, lettura HTML e rinvii interni necessari; sintesi originali e metadati.',systematic_material_census=False,external_hosts_checked=False,solution_content_checked=False,classification_mapping=[],pilot_records_recensused=0,third_party_full_evidence_committed=False,coverage_limit='Nove voci indice, incluse raccolte/non ammissibili; sette esiti admitted non certificano sette nuove identità canoniche. Schede terze rinviate fuori lotto non censite.'),records=records)
MANIFEST.write_text(json.dumps(manifest,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
print(json.dumps(dict(records=9,admitted=7,requirements_not_demonstrated=2,matches={r['candidate_id']:r['local_matching']['matches'] for r in records},source_matches={r['candidate_id']:r['local_matching']['source_url_matches'] for r in records}),ensure_ascii=False))
