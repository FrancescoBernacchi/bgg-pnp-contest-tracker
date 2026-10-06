"""Formalizza metadati originali CAT; legge SQLite soltanto in mode=ro. Nessuna rete."""
import hashlib
import json
from pathlib import Path
import sqlite3

ROOT = Path(__file__).resolve().parents[2]
TASK = Path(__file__).resolve().parent
DATE = '2026-10-06'
BASE = 'https://www.pergioco.net/'
PRE = 'tasks/2026-10-06 - FON - Preanalisi PerGioco/RELAZIONE.md'
MANIFEST = ROOT / 'catalog/pergioco_pilot_2026-10-06.json'

def resource(kind, url, access, completeness='not_verified', origin='pilot_residual', **extra):
    return dict(kind=kind, url=url, access=access, completeness=completeness,
                observed_at=DATE, provenance=origin, **extra)

rows = [
    ('PGP-001','Achi','1/achi.html','achi.html',None,None,'21/09/2026',['A-B','A-Aiy','Achi'],'admitted',
     'Preparazione, azioni e vittoria osservate nella preanalisi; HTML pubblico sufficiente.',
     'Tavoliere a nove intersezioni e pedine; figure illustrative nella pagina.',
     ['Variante interna a tre pedine; non nuova candidata.','Care: nome dichiarato in Senegal.','Affinità con Tapatan e variante Kurna del Mulino 3x3 dichiarata dalla fonte; nessuna fusione.']),
    ('PGP-002','Krypte','3/krypte.html','krypte.html','Marino Carpignano',2016,'17/09/2026',['I-K','K','Krypte'],'admitted',
     'Regole complete HTML italiane già osservate in TSK-0072.',
     'Tavoliere 8x8 e pedine bicolori; esempi e trascrizione partite in pagina.',
     ['Attrezzatura condivisibile con Othello: nessuna dipendenza da prodotto specifico.','Somiglianze dichiarate con Forza 4x4 Spider, Othello e Forza 4; non matching.']),
    ('PGP-003','Abande','1/abande.html','abande.html','Dieter Stein',2005,'21/09/2026',['A-B','A-Aiy','Abande'],'admitted',
     'Regole complete HTML già osservate; due alternative di tavoliere interne.',
     'Tavoliere esagonale e 36 pedine; figure e due varianti di tavoliere.',
     ['Base di Abande Libre.','Variante 1 e Variante 2: etichette interne originali, non nuove identità nel pilota.','Matching locale candidato game_id 993: titolo e designer concordanti; equivalenza delle versioni non verificata.']),
    ('PGP-004','Abande Libre','1/abande-libre.html','abande-libre.html','Dieter Stein',2009,'21/09/2026',['A-B','A-Aiy','Abande Libre'],'admitted',
     'Percorso gratuito base Abande più variante; rinvio alle regole base esplicito.',
     '36 pedine, senza tavoliere fisso; esempi illustrati.',
     ['Variante di Abande con regole proprie; distinta nel campione.','Dipendenza informativa dalle regole base; nessun obbligo di acquistare il gioco base attestato.']),
    ('PGP-005','Chomp','a/chomp.html','chomp.html','David Gale',1973,'25/09/2026',['Elenco alfabetico','Chomp'],'admitted',
     'Regole, preparazione e termine HTML sufficienti già osservati.',
     'Carta quadrettata e strumento per scrivere; nessun pacchetto PnP richiesto.',
     ['Dimensioni del rettangolo variabili nel sistema; nessuna ulteriore identità.','Anno e designer sono asserzioni PerGioco, senza verifica storica indipendente.']),
    ('PGP-006','Itinera','a/itinera.html','itinera.html','Marino Carpignano',2021,'25/09/2026',['Elenco alfabetico','G-L','Itinera'],'admitted',
     'Vincoli e obiettivo pubblici sufficienti per il sistema logico; soluzione non necessaria per ammissione.',
     'Esempio nella scheda; due schemi pubblici separati, soluzioni riservate.',
     ['Un sistema di regole; schemi e soluzioni sono risorse/istanze.','Due problemi datati 18/06/2021 e 23/07/2021 osservati in TSK-0072.']),
    ('PGP-007','Azul','1/azul.html','azul.html','Michael Kiesling',2017,'21/09/2026',['A-B','Ata-Ayu','Azul'],'requirement_not_demonstrated',
     'Introduzione e rimandi; preparazione e turni dettagliati non osservati. Non attestato un regolamento completo gratuito.',
     'Pagina di varianti e rinvii a titoli successivi; nessun regolamento completo verificato.',
     ["Etichetta editoriale Varianti: Sintra, Summer Pavilion, Queen's Garden; dipendenza/prodotto non dedotti.", 'Questi titoli non entrano nel denominatore del pilota.']),
    ('PGP-008','Reversi','5/reversi.html','reversi.html','Lewis Waterman',None,'03/10/2026',['Dalla A alla Z','R-S','R','Reversi'],'admitted',
     'HTML pubblico descrive materiale, apertura, catture, passaggio e termine: percorso completo nella scheda.',
     'Tavoliere 8x8, 64 pedine bicolori; figure, immagini storiche e dicitura PDF.',
     ['Reversino: alias dichiarato.','John W. Mollett rivendica la paternità secondo la fonte; ambiguità preservata.','Fonte considera Reversi variante di Othello, pur descrivendo la precedenza storica; nessuna inversione/fusione automatica.','Rimando ad Annexation; non nuova candidata.']),
    ('PGP-009','Blockade (1975)','1/blockade.html','blockade.html','Philip Slater',1975,'21/09/2026',['A-B','Blo-Blu','Blockade 1975'],'requirement_not_demonstrated',
     'HTML descrive materiale, spostamenti sintetici e obiettivo; uso/posizionamento delle barriere non dettagliato. PDF solo dichiarato e non aperto.',
     'Tavoliere 11x14, pedine e barriere; figure e dicitura regole PDF.',
     ['Cul-de-Sac: alias dichiarato.','Lakeside: editore dichiarato per la serie anni Settanta.','Fonte dichiara ispirazione di Pinko Pallino e Quoridor, senza dipendenza dal base.','Distinto da Blockade (2001) per designer, anno e materiale.']),
    ('PGP-010','Blockade (2001)','1/blockade2.html','blockade2.html','Kristin Looney',2001,'21/09/2026',['A-B','Blo-Blu','Blockade 2001'],'requirement_not_demonstrated',
     'Solo introduzione: assenti preparazione operativa, azioni e conclusione. Accesso pubblico non attesta regole complete.',
     'Tavoliere 5x5 e pezzi piramidali introdotti da Icehouse, secondo la scheda.',
     ['John Cooper e Andrew Looney: designer di Icehouse nella menzione collegata, non di questo Blockade.','Riuso materiale Icehouse dichiarato; necessità di un prodotto commerciale non verificata.','Etichetta Giochi su tavolieri 5x5 osservata nella scheda.']),
    ('PGP-011','Beeline','1/beeline-1968.html','beeline-1968.html','Winston N. Allen',1968,'21/09/2026',['A-B','B-Bla','Beeline 1968'],'admitted',
     'HTML contiene materiale, preparazione, turno, vincoli e termine: sufficiente nel pilota, senza playtest.',
     'Tavoliere esagonale e tessere di quattro tipi; immagine nella pagina.',
     ['Titolo indice Beeline (1968), heading Beeline: qualificatore conservato separatamente.','Omonimo del gioco 1984; fonte dichiara condivisione del nome, non identità.','Immagine con etichetta Abande: anomalia di metadati, non prova del titolo.']),
    ('PGP-012','Beeline','1/beeline.html','beeline-1984.html','John Brassell',1984,'13/09/2026',['A-B','B-Bla','Beeline 1984'],'admitted',
     'HTML contiene preparazione, turno, obiettivi e pareggio. Criterio di vittoria simultanea lasciato alla scelta dei giocatori dalla fonte.',
     'Tavoliere esagonale e 48 tessere triangolari di due tipi; immagine in pagina.',
     ['Titolo indice Beeline (1984), heading Beeline: qualificatore conservato separatamente.','Regola della vittoria simultanea parametrica: registrare scelta prima di giocare.','Immagine con etichetta Abande: anomalia, non matching.']),
]

db = ROOT / 'database/pnp_collection.sqlite3'
db_before = hashlib.sha256(db.read_bytes()).hexdigest()
con = sqlite3.connect(db.resolve().as_uri()+'?mode=ro', uri=True)
con.execute('PRAGMA query_only=ON')
records = []
for i,title,final,historic,designer,year,page_date,tail,outcome,reason,components,relations in rows:
    reused = i in {f'PGP-{n:03}' for n in range(1,8)}
    category = 'Giochi con carta e matita' if i=='PGP-005' else 'Giochi logici e di induzione' if i=='PGP-006' else 'Giochi di tavoliere astratti'
    qualified = f'Beeline ({year})' if title=='Beeline' else title
    origin = 'TSK-0072_reused' if reused else 'pilot_residual'
    url = BASE+final
    credits = []
    if designer:
        credits.append(dict(name=designer,role='designer',status='declared_by_source',source_url=url,observed_at=DATE,provenance=origin))
    else:
        credits.append(dict(name=None,role='designer',status='not_declared',note='Gioco tradizionale originario del Ghana; nessun designer individuale dichiarato.',source_url=url,observed_at=DATE))
    if i=='PGP-008':
        credits.append(dict(name='John W. Mollett',role='claimed_designer',status='disputed_by_source',source_url=url,observed_at=DATE))
        credits.extend([dict(name=n,role='historical_publisher',status='declared_by_source',source_url=url,observed_at=DATE) for n in ['Jacques & Son','Ravensburger']])
    if i=='PGP-009':
        credits.append(dict(name='Lakeside',role='publisher',status='declared_by_source',source_url=url,observed_at=DATE))
    credits.append(dict(name='Marino Carpignano',role='site_curator_owner',status='declared_in_FAQ',source_url=BASE+'faq.html',observed_at=DATE,provenance='TSK-0072_reused',note='Non attribuisce automaticamente redazione/traduzione o design del gioco.'))
    aliases = {'PGP-001':['Care'],'PGP-008':['Reversino'],'PGP-009':['Cul-de-Sac']}.get(i,[])
    lookup = [qualified,title]+aliases
    if i=='PGP-008': lookup += ['Othello']
    matches=[]
    for name in dict.fromkeys(lookup):
        for gid, canonical in con.execute('SELECT DISTINCT g.id,g.canonical_title FROM games g LEFT JOIN game_names a ON a.game_id=g.id WHERE lower(g.canonical_title)=lower(?) OR lower(a.name)=lower(?)',(name,name)):
            if gid not in [m['game_id'] for m in matches]: matches.append(dict(game_id=gid,canonical_title=canonical,status='candidate',basis='Titolo e designer concordanti con evidenza TSK-0072; nessun confronto completo tra versioni.'))
    resources=[resource('rules_html' if outcome=='admitted' else 'presentation_html',url,'public_no_login_observed','complete_base_plus_variant' if i=='PGP-004' else 'sufficient_system' if i=='PGP-006' else 'complete_pilot_assessment' if outcome=='admitted' else 'incomplete',origin,language='it',free_observed=True)]
    if i=='PGP-004': resources.append(resource('base_rules_html',BASE+'1/abande.html','public_no_login_observed','complete_pilot_assessment','TSK-0072_reused',language='it',free_observed=True))
    if i in ['PGP-003','PGP-004','PGP-008','PGP-009']:
        resources.append(resource('rules_pdf_mention',None,'unknown','not_verified',origin,declared=True,destination_status='Dicitura osservata; URL utilizzabile non attestato. Nessun file aperto.',language=None,free_observed=None))
    if i=='PGP-006':
        resources += [resource('problem_instances_html',BASE+'a/itinera-diagrammi.html','public_no_login_observed','two_schemes_observed','TSK-0072_reused',instance_dates=['2021-06-18','2021-07-23'],counts_as_game=False),resource('solutions',BASE+'a/itinera-soluzioni.php','reserved_login_observed','not_observed','TSK-0072_reused',final_url=BASE+'a/imlogin.php?loginstatus=-3',counts_as_game=False,free_observed=None,note='Registrazione/newsletter dichiarate gratuite; accesso autenticato non collaudato.')]
    if i=='PGP-007': resources.append(resource('editorial_variants_html',BASE+'1/azul-varianti.html','public_no_login_observed','not_rules_evidence','TSK-0072_reused',counts_as_candidate=False))
    if i=='PGP-008': resources.append(resource('historical_images_page',BASE+'5/reversi-immagini.html','public_no_login_observed','not_rules_evidence','TSK-0072_reused',downloaded=False))
    memberships=[dict(label=category,path=['Giochi',category]+tail,source_url=url,observed_at=DATE,provenance='pilot_residual',kind='breadcrumb')]
    if i=='PGP-001': memberships.append(dict(label='giochi di allineamento',path=None,source_url=url,observed_at=DATE,kind='family_declared_in_text',note='Gerarchia ulteriore non dichiarata; non inferita.'))
    if i=='PGP-010': memberships.append(dict(label='Giochi su tavolieri 5x5',path=None,source_url=url,observed_at=DATE,kind='page_label',note='Appartenenza testuale osservata; nessuna gerarchia superiore inferita.'))
    index = 'giochi-con-carta-e-matita.html' if i=='PGP-005' else 'giochi-logici-2.html' if i=='PGP-006' else 'giochi-di-tavoliere-astratti-6.html' if i=='PGP-002' else 'giochi-di-tavoliere-astratti-10.html' if i=='PGP-008' else 'giochi-di-tavoliere-astratti.html'
    memberships.append(dict(label=category,path=['Giochi',category,'Elenco alfabetico'],segment='G-L' if i=='PGP-006' else 'I-J-K' if i=='PGP-002' else 'R-S' if i=='PGP-008' else None if i=='PGP-005' else 'A-B',source_url=BASE+index,observed_at=DATE,kind='index_membership',index_title=qualified))
    records.append(dict(candidate_id=i,candidate_title=qualified,title_original=title,title_normalized=qualified,year_declared=year,aliases_declared=aliases,source_url=url,historical_urls=[BASE+historic],final_url_status='browser_observed' if not reused else 'TSK-0072_observed_and_pilot_residual_read',page_updated_raw=page_date,observed_at=DATE,formalized_at=DATE,credits=credits,missing_credits=['illustrator_not_registered','page_writer_translator_not_attributed']+([] if i in ['PGP-008','PGP-009'] else ['publisher_not_registered']),native_classification=memberships,classification_exhaustiveness='all_observed_memberships_retained; no_whole_site_exhaustiveness_claim',rules=dict(language='it',completeness=resources[0]['completeness'],public_content_free=True,complete_rules_free=True if outcome=='admitted' else None,assessment=reason,source_url=url,observed_at=DATE,provenance=origin,playtested=False),outcome=outcome,components_declared_summary=components,resources=resources,relations_and_dependencies=relations,local_matching=dict(checked_at=DATE,method='Read-only exact case-insensitive games.canonical_title + game_names.name; qualified title, heading and recorded aliases; Othello also for Reversi.',queried_names=list(dict.fromkeys(lookup)),matches=matches,status='candidate' if matches else 'no_exact_match',limit='Assenza di match esatto non prova assenza di equivalenti o alias non riconciliati.'),evidence=dict(reused_from=PRE if reused or i=='PGP-008' else None,original_observed_at=DATE if reused or i=='PGP-008' else None,residual_checked_at=DATE,residual_fields=['native_classification','resource_declarations','credit_gaps'] if reused else ['identity','credits','rules','native_classification','resource_declarations']),conditions_ref='PG-CONDITIONS-20261006'))
con.close()
records[7]['year_declared_raw'] = 'attorno al 1880; paternità rivendicata anche da John W. Mollett'
records[7]['year_normalization_status'] = 'approximate_and_disputed; no_exact_year_asserted'
db_after=hashlib.sha256(db.read_bytes()).hexdigest()
assert db_before==db_after
manifest=dict(schema_version=1,task_id='TSK-0074',source_key='pergioco',observed_at=DATE,formalized_at=DATE,scope_reference='sources/PERGIOCO-SCOPE.md',candidate_denominator=12,admitted_count=sum(r['outcome']=='admitted' for r in records),requirements_not_demonstrated_count=sum(r['outcome']=='requirement_not_demonstrated' for r in records),not_observable_count=0,imported_count=0,downloaded_count=0,conditions=dict(id='PG-CONDITIONS-20261006',observed_at=DATE,provenance='TSK-0072_reused',references=[BASE+'termini-e-condizioni.html',BASE+'faq.html',BASE+'registrazione.html',BASE+'newsletter.html'],summary='Preanalisi: consultazione pubblica distinta da riuso. Copia/modifica/distribuzione limitate senza consenso; conservazione e stampa personale di estratti previste nelle condizioni osservate. Newsletter e registrazione dichiarate gratuite ma distinte; nessuna iscrizione o accesso autenticato collaudato. Gratuità HTML non attesta licenza di redistribuzione né gratuità di prodotti/materiali.',page_updated_raw='26/09/2026',reuse_permission_for_publication='not_attested; deliverables contain metadata and original summaries only'),method=dict(reused_evidence=PRE,new_reads='Browser public HTML for residual fields and five previously unread main sheets; web cache used for orientation only. No PDF, images, files, login or online implementations opened.',classification_limits='Schede e indici pertinenti A-B, I-J-K, R-S, carta e matita, logici G-L; indice matematici controllato senza match. Menu globale non usato come appartenenza del gioco. Altre categorie/elenchi non completamente censiti.',local_database_mode='ro + query_only',source_fact_independence='Crediti e anni dichiarati da PerGioco; non verificati storicamente su altre fonti.'),records=records)
MANIFEST.write_text(json.dumps(manifest,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
verification=dict(task_id='TSK-0074',date=DATE,expected_candidates=[r[1] if r[1]!='Beeline' else f'Beeline ({r[5]})' for r in rows],unique_ids=len({r['candidate_id'] for r in records}),unique_urls=len({r['source_url'] for r in records}),explicit_outcomes=len(records),admitted=manifest['admitted_count'],not_demonstrated=manifest['requirements_not_demonstrated_count'],itinera_system_count=1,itinera_instance_count=2,local_match_candidates=[r['candidate_title'] for r in records if r['local_matching']['matches']],database_sha256_before=db_before,database_sha256_after=db_after,database_unchanged=db_before==db_after,manifest_sha256=hashlib.sha256(MANIFEST.read_bytes()).hexdigest(),checks={})
expected=['Achi','Krypte','Abande','Abande Libre','Chomp','Itinera','Azul','Reversi','Blockade (1975)','Blockade (2001)','Beeline (1968)','Beeline (1984)']
verification['checks']={'exact_sample':set(expected)=={r['candidate_title'] for r in records},'12_unique_ids':verification['unique_ids']==12,'12_unique_urls':verification['unique_urls']==12,'all_required_metadata':all(all(k in r for k in ['credits','missing_credits','native_classification','rules','resources','local_matching','outcome','evidence']) for r in records),'classification_has_url_date':all(all('source_url' in c and 'observed_at' in c for c in r['native_classification']) for r in records),'no_missing_outcome':all(r['outcome'] in ['admitted','requirement_not_demonstrated'] for r in records),'count_reconciliation':manifest['admitted_count']+manifest['requirements_not_demonstrated_count']==12,'base_variant_explicit':'base_rules_html' in [s['kind'] for s in records[3]['resources']],'itinera_solutions_not_admission_requirement':records[5]['outcome']=='admitted' and len([x for x in records[5]['resources'] if x['kind']=='solutions'])==1,'database_unchanged':db_before==db_after}
assert all(verification['checks'].values())
(TASK/'VERIFICHE.json').write_text(json.dumps(verification,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
report = '''# TSK-0074 — Relazione del censimento pilota PerGioco

Verifica e formalizzazione: **6 ottobre 2026**. Campione autorizzato: dodici identità candidate, senza estensioni. Fonte editoriale PerGioco, curatore/proprietario Marino Carpignano secondo le FAQ. Designer, altri crediti e fonti dirette sono registrati per ciascuna candidata; le mancanze non vengono colmate col copyright del sito.

## Risultato e denominatori

**12/12 candidate censite, 9 ammissibili nel perimetro adottato, 3 con requisito non dimostrato.** Ammissibili: Achi, Krypte, Abande, Abande Libre, Chomp, Itinera, Reversi, Beeline (1968), Beeline (1984). Requisito non dimostrato: Azul, Blockade (1975), Blockade (2001). Nessuna candidata è dichiarata a pagamento o definitivamente esclusa da altre fonti. Nessuna scheda principale è rimasta non osservabile dopo il recupero nel browser. Censimento chiuso non significa catalogo importato: importazioni 0, acquisizioni 0.

Un'etichetta Introduzione non determina da sola completezza: Chomp e i due Beeline contengono anche le regole nella sezione così denominata. La valutazione considera presenza di materiale/preparazione, azioni o vincoli, obiettivo e termine; per Itinera basta un sistema logico intelligibile. Non certifica correttezza storica, assenza di ogni ambiguità o funzionamento dopo playtest. Beeline (1984) lascia ai giocatori il criterio per vittoria simultanea: questa scelta va conservata, non normalizzata in una regola inventata.

## Evidenze, date e limiti del metodo

Le sette schede principali TSK-0072, le risorse Itinera, immagini storiche Reversi, FAQ e condizioni sono riutilizzate preservando la verifica originaria 2026-10-06 e il riferimento alla relazione precedente. Formalizzazione CAT e osservazione storica hanno campi distinti, anche se cadono nello stesso giorno. Non abbiamo ripetuto il login soluzioni Itinera o le condizioni già osservate. Le nuove letture delle sette schede hanno coperto classificazioni, dichiarazioni di risorse e lacune di crediti residue; non costituiscono un nuovo monitoraggio.

Nuove schede integralmente valutate: Reversi, Blockade (1975), Blockade (2001), Beeline (1968), Beeline (1984). Lo strumento web ha restituito cache miss per alcune destinazioni e pagine memorizzate diverse dalla navigazione corrente. Il browser ha recuperato le schede pubbliche; tali errori non sono stati trasformati in indisponibilità del sito. Un click sull'indice è stato ostacolato dal consenso cookie; è stata usata la navigazione all'URL già esposto, senza accettare moduli, iscrizioni o condizioni contrattuali.

Date di aggiornamento delle pagine sono metadati della fonte, distinti dall'anno di ideazione e dalla data di verifica. Per Krypte resta operativa la data browser 17/09/2026; la precedente pagina memorizzata 07/06/2026 resta storia nella preanalisi, senza inferire cambiamenti alle regole. Nessun testo integrale, diagramma o dump entra nei deliverable; le sintesi non ricostruiscono i regolamenti.

## Classificazione originale e appartenenze

Le gerarchie sono trascritte come metadati dai breadcrumb delle schede, senza sostituire le categorie native con una tassonomia comune. Sono distinti breadcrumb, indice, famiglia descritta nel testo e semplice etichetta di pagina. Segmenti non uniformi sono preservati: Krypte espone I-K > K nella scheda e I-J-K nell'indice. Achi dichiara inoltre la famiglia giochi di allineamento. Blockade (2001) espone anche Giochi su tavolieri 5x5, senza una gerarchia superiore ricostruita.

Indici pertinenti letti: astratti A-B, I-J-K, R-S, carta e matita e logici G-L. Controllato inoltre l'indice matematici, senza riscontri del campione. Chomp è osservato sotto Giochi con carta e matita; non gli assegniamo Giochi matematici e con i numeri per conoscenza generale. Itinera è osservato sotto Giochi logici e di induzione. Le categorie nel menu globale sono navigazione del sito e non appartenenze di ogni gioco.

Tutte le appartenenze osservate sono conservate, ma non è attestata esaustività su ogni elenco tematico, segmento o categoria dell'intero sito. Categorie ulteriori restano ignote. Questo limite è esplicito nel manifest per ogni candidata e non riduce il denominatore dei dodici esiti.

## Crediti, accessi e risorse

Crediti e anni sono asserzioni PerGioco, non verifiche indipendenti della storia dei giochi. Il curatore del sito non viene assunto come autore della traduzione o delle figure. Illustratori e redattori/traduttori delle schede non sono registrati; editori sono registrati soltanto dove esplicitamente osservati. Nel caso Reversi sono conservate attribuzione e rivendicazione concorrente, con ruoli distinti. John Cooper e Andrew Looney, citati per Icehouse nella scheda Blockade (2001), non diventano designer di Blockade.

Tutte le schede HTML sono leggibili pubblicamente in italiano senza login nel percorso osservato. Costo delle regole complete è attestato gratuito soltanto per le nove ammissibili. Le tre introduzioni incomplete sono pubbliche e gratuite come contenuto, ma il costo/accesso di un regolamento completo non è dimostrato. Gratuità dei componenti, PDF, libri o implementazioni online non viene dedotta da quella delle pagine.

Diciture PDF su Abande, Abande Libre, Reversi e Blockade (1975) non attestano un URL utilizzabile, il contenuto del file o il suo accesso; restano risorse dichiarate non verificate con URL nullo. Nessun PDF aperto. Le figure e le pagine d'immagini sono dichiarazioni della scheda, senza acquisizione né autorizzazione di riuso. Newsletter, pubblicazioni e archivi sono contesto editoriale già osservato, non pacchetti PnP individuali automaticamente associati ai dodici titoli. Destinazioni online non aperte o collaudate.

Condizioni riutilizzate dalla preanalisi: [termini](https://www.pergioco.net/termini-e-condizioni.html), [FAQ](https://www.pergioco.net/faq.html), [registrazione](https://www.pergioco.net/registrazione.html), [newsletter](https://www.pergioco.net/newsletter.html), verifica originale 2026-10-06. Consultazione gratuita non autorizza redistribuzione; i deliverable pubblicabili consistono in metadati, link e sintesi originali secondo PUBLICATION_POLICY.md. Accessi dopo account/newsletter non sono collaudati. La valutazione delle condizioni specifiche dei futuri file appartiene a un task successivo autorizzato.

## Identità, varianti e matching

Abande e Abande Libre hanno identità separate nel campione e relazione base/variante esplicita. Le due alternative di tavoliere interne ad Abande restano varianti descritte, senza nuova identità. Per Achi la variante interna a tre pedine e i giochi dichiarati affini non comportano nuove candidate o fusioni.

I due Blockade e i due Beeline restano quattro candidate distinte. Nei Beeline il titolo originale dell'heading è Beeline; qualificatori 1968/1984 provengono dagli indici e breadcrumb. Il secondo URL storico beeline-1984.html conduce a 1/beeline.html: non derivare la data dall'URL finale. Le etichette immagini Abande nelle due pagine Beeline sono anomalie dei metadati accessibili; non alterano il titolo del contenuto. Le etichette scorrette dell'indice autori già osservate in TSK-0072 restano nel precedente, senza riaprire l'indice.

Itinera conta **un gioco**. [Diagrammi](https://www.pergioco.net/a/itinera-diagrammi.html): due schemi osservati nella preanalisi, datati 18/06/2021 e 23/07/2021; disponibili pubblicamente, senza acquisizione. [Soluzioni](https://www.pergioco.net/a/itinera-soluzioni.php): accesso riservato osservato, rinvio a login; contenuto e gratuità effettiva dopo autenticazione non verificati. Soluzioni protette non invalidano le regole del sistema. Non contiamo schemi, esempio o soluzioni come giochi.

Matching locale 2026-10-06: query SQLite mode=ro e query_only su games.canonical_title e game_names.name, confronto esatto senza distinzione maiuscole dei titoli qualificati/originali e alias registrati (Care, Reversino, Cul-de-Sac; Othello per il rimando Reversi). Una corrispondenza: **Abande, game_id 993**, designer Dieter Stein già dichiarato; record locali Kanare Online Play e Stacking Trilogy confermati nel catalogo esistente. Il matching PerGioco resta candidato: versioni/regole non confrontate integralmente. Nessun matching scritto. Nessun match esatto degli altri undici significa soltanto mancato riscontro in questa query. Ricerca supplementare di frammenti distintivi nei titoli non ha aggiunto riscontri. Nessun confronto esterno sistematico BGG.

## Schede dettagliate

'''
for r in records:
    names = '; '.join(f"{c['name'] or 'Autore individuale non dichiarato'} — {c['role']} ({c['status']})" for c in r['credits'])
    paths = '\n'.join('- '+ (' > '.join(c['path']) if c['path'] else c['label']) + f"; tipo {c['kind']}; fonte [pagina]({c['source_url']}), {c['observed_at']}." for c in r['native_classification'])
    res = '\n'.join('- '+s['kind']+': '+(f"[fonte]({s['url']})" if s['url'] else 'URL non attestato')+f"; accesso {s['access']}; completezza {s['completeness']}; osservazione {s['observed_at']}; provenienza {s['provenance']}." for s in r['resources'])
    report += f"### {r['candidate_id']} — {r['candidate_title']}\n\nTitolo originale: **{r['title_original']}**. [Scheda finale]({r['source_url']}); URL storico: [collegamento]({r['historical_urls'][0]}). Lingua: italiano; verifica 2026-10-06; aggiornamento dichiarato {r['page_updated_raw']}; anno di ideazione dichiarato {r['year_declared'] if r['year_declared'] else 'non fissato: tradizione o attribuzione approssimativa'}.\n\nCrediti: {names}. Mancanze: {', '.join(r['missing_credits'])}.\n\nEsito: **{r['outcome']}**. {r['rules']['assessment']}\n\nClassificazione nativa:\n\n{paths}\n\nComponenti/risorse dichiarati: {r['components_declared_summary']}\n\n{res}\n\nRelazioni e limiti:\n\n"+'\n'.join('- '+x for x in r['relations_and_dependencies'])+f"\n\nMatching: {r['local_matching']['status']}; {r['local_matching']['limit']} Evidenza precedente: {r['evidence']['reused_from'] or 'nuova scheda nel pilota'}; parti residue verificate il {DATE}.\n\n"
report += '''## Verifiche e chiusura

VERIFICHE.json controlla il campione esatto, dodici ID e URL distinti, esiti e campi richiesti, URL/date delle appartenenze, conteggi 9+3=12, base/variante e sistema/soluzioni Itinera. Hash SQLite prima/dopo identico; nessuna modifica database. Il controllo strutturale non certifica correttezza della fonte o esaustività dei crediti. Manifest JSON decodificabile, risorse protette e non verificate esplicite. Il generatore offline non accede alla rete e non importa dati.

Il contratto del CAT è soddisfatto anche dai tre esiti incompleti. PerGioco resta un pilota di metadati non operativo nel database/app. Il campione motivato non consente stime sull'intero sito. Ammissibilità nel pilota non equivale a diritti di acquisizione/pubblicazione né a disponibilità di pacchetti stampabili.

## Passo successivo proposto

Aprire un task **DAT — Preparazione integrazione PerGioco** dopo controllo dei registri. Prima definire un piano e un'anteprima offline: come conservare classificazioni native molti-a-molti/gerarchie/provenienza, risorse e relativi accessi, Itinera sistema/istanze e matching candidato Abande. Stabilire il trattamento dei tre record non ammissibili operativamente, mantenendone evidenze e stato nel manifest. Solo dopo revisione e decisione esplicita eseguire eventuali migrazioni/importazione. Nessuna acquisizione e nessun APP in quel contratto preparatorio. Prompt completo in PROMPT_PROSSIMA_CHAT.md.
'''
(TASK/'RELAZIONE.md').write_text(report,encoding='utf-8')
print(json.dumps({k:verification[k] for k in ['unique_ids','explicit_outcomes','admitted','not_demonstrated','database_unchanged','checks']},ensure_ascii=False,indent=2))
