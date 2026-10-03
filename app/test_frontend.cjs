// Test dei formatter e della semantica del confronto; nessun browser o rete.
const {test} = require('node:test');
const assert = require('node:assert/strict');
const vm = require('node:vm');
const fs = require('node:fs');
const path = require('node:path');
const context = vm.createContext({URL,document:{querySelector:()=>({})},window:{addEventListener:()=>{}},fetch:()=>new Promise(()=>{})});
vm.runInContext(fs.readFileSync(path.join(__dirname,'static/app.js'),'utf8'),context);
const run = text => vm.runInContext(text,context);
test('testo non fidato reso come testo, mai markup',()=>{
  assert.equal(run('esc(`<img src=x onerror="alert(1)">`)'),'&lt;img src=x onerror=&quot;alert(1)&quot;&gt;');
});
test('indicatori avanzamento distinguono completo, parziale e non iniziato',()=>{
  assert.match(run("progressMark(4,4,'ratio')"),/progress-mark done/);
  assert.match(run("progressMark(2,4,'ratio')"),/progress-mark partial/);
  assert.match(run("progressMark(0,4,'ratio')"),/progress-mark empty/);
  assert.match(run("progressMark(2,4,'ratio')"),/>2\/4<\/span>/);
});
test('pipeline annuale calcola percentuali senza dividere per zero',()=>{
  assert.equal(run('progressPercent(3,4)'),75);
  assert.equal(run('progressPercent(0,0)'),0);
  const html=run("pipelineRow('Lettura materiali',3,4,'amber')");
  assert.match(html,/3\/4 · 75%/);
  assert.match(html,/<progress class="pipeline-progress amber"/);
  assert.match(html,/value="3" max="4"/);
  assert.ok(!html.includes('style='));
});
test('pipeline annuale separa PnP principali e adiacenti',()=>{
  const source=fs.readFileSync(path.join(__dirname,'static/app.js'),'utf8');
  assert.match(source,/Contest con entry censite/);
  assert.match(source,/scopePipeline\(scopeSummary\(y,'pnp_core'\),'PnP principali'\)/);
  assert.match(source,/scopePipeline\(scopeSummary\(y,'adjacent'\),'Adiacenti','violet'\)/);
  assert.ok(!source.includes("pipelineRow('Stati entry noti',y.known_status_count,y.entry_count)"));
});
test('riepilogo per perimetro funziona anche con il vecchio formato API',()=>{
  run("data={progress:{contests:[{year:2024,scope_type:'pnp_core',entry_count:29,ranked_entry_count:2,materials_read_count:1,downloaded_entry_count:0},{year:2024,scope_type:'adjacent',entry_count:0,ranked_entry_count:0,materials_read_count:0,downloaded_entry_count:0}]}};");
  assert.equal(run("JSON.stringify(scopeSummary({year:2024},'pnp_core'))"),JSON.stringify({contest_count:1,contests_with_entries_count:1,entry_count:29,ranked_entry_count:2,materials_read_count:1,downloaded_entry_count:0}));
});
test('solo link BGG di metadati, nessun download o host esterno',()=>{
  for(const url of ['javascript:alert(1)','https://example.com/thread/123','https://boardgamegeek.com/filepage/123','https://boardgamegeek.com/file/download/test','https://boardgamegeek.com.evil.example/thread/123','https://user:pass@boardgamegeek.com/thread/123']){
    assert.ok(!run(`source(${JSON.stringify(url)})`).includes('<a '));
  }
  assert.match(run('source("https://boardgamegeek.com/thread/123/title","2026-09-07")'),/rel="noopener noreferrer"/);
});
test('le risorse accettano solo HTTPS senza credenziali e si aprono in modo isolato',()=>{
  for(const url of ['javascript:alert(1)','http://example.com/file','file:///tmp/game.pdf','https://user:pass@example.com/file'])
    assert.ok(!run(`externalLink(${JSON.stringify(url)},'Apri')`).includes('<a '));
  const html=run(`externalLink('https://drive.google.com/file/d/123/view?x=1','Regole <PDF>')`);
  assert.match(html,/target="_blank"/);assert.match(html,/rel="noopener noreferrer"/);
  assert.match(html,/Regole &lt;PDF&gt; ↗/);
});
test('ricerca giochi attraversa titoli, alias, fonti e ambiguità senza fondere record',()=>{
  run(`data={games:[
    {id:1,canonical_title:'River',aliases:['川'],source_keys:['kanare_abstract'],candidate_count:1},
    {id:2,canonical_title:'Forest',aliases:['Bosco'],source_keys:['boardgamegeek'],candidate_count:0}
  ]};gameFilters.query='川';gameFilters.source='';gameFilters.ambiguity='';`);
  assert.equal(run(`matchingGames().map(g=>g.id).join(',')`),'1');
  run(`gameFilters.query='';gameFilters.source='boardgamegeek';`);
  assert.equal(run(`matchingGames().map(g=>g.id).join(',')`),'2');
  run(`gameFilters.source='';gameFilters.ambiguity='candidate';`);
  assert.equal(run(`matchingGames().map(g=>g.id).join(',')`),'1');
});
test('la vista Kanare non eredita il filtro fonte nascosto dalla vista comune',()=>{
  run(`data={games:[{id:1,canonical_title:'Kanare Game',aliases:[],source_keys:['kanare_abstract'],candidate_count:0}],sources:[]};gameFilters.query='';gameFilters.source='boardgamegeek';gameFilters.ambiguity='';`);
  run(`applySpecializedSource('kanare_abstract')`);
  assert.equal(run(`gameFilters.source`),'');
  assert.equal(run(`matchingGames('kanare_abstract').length`),1);
});
test('badge fonti e link multifonte rendono sicuro il testo non fidato',()=>{
  const html=run(`sourceBadges({source_keys:['kanare_abstract','<script>']})`);
  assert.match(html,/Kanare_Abstract/);assert.ok(!html.includes('<script>'));
  assert.match(run(`externalLink('https://kanare-abstract.com/game/1','Pagina Kanare')`),/noopener noreferrer/);
});
test('sezione risorse distingue scansione, provenienza, tipo, accesso e disponibilità',()=>{
  const detail={resource_scans:[{checked_at:'2026-09-02',source_url:'https://boardgamegeek.com/thread/123',resource_listing_status:'observed',notes:'Primo post'}],resources:[{id:1,url:'https://drive.google.com/file/d/123/view',host:'drive.google.com',label:'Fallback',label_raw:'File di gioco',kind:'game_files',content_role:'game_files',access_type:'file',availability_status:'unknown',version_raw:'1.2',is_primary:1,mention_source_url:'https://boardgamegeek.com/thread/123',mention_first_seen_at:'2026-09-01',mention_last_seen_at:'2026-09-02',observations:[{observed_at:'2026-09-03',observation_kind:'availability_check',availability_status:'available'}]}]};
  const html=run(`resourceSection(${JSON.stringify(detail)})`);
  for(const text of ['File di gioco ↗','Materiali di gioco','Risorsa principale dichiarata','File','Disponibile','Fonte BGG della risorsa ↗','Fonte della scansione BGG ↗','Versione: 1.2']) assert.ok(html.includes(text));
});
test('stati senza risorse restano distinti e non inventano link',()=>{
  for(const [status,text] of [['none_declared','non ha rilevato risorse dichiarate'],['not_observable','non era osservabile'],['not_checked','non sono ancora state controllate']]) {
    const html=run(`resourceSection({resource_scans:[{resource_listing_status:${JSON.stringify(status)},source_url:'https://boardgamegeek.com/thread/123',checked_at:'2026-09-02'}],resources:[]})`);
    assert.ok(html.includes(text));
  }
  assert.match(run(`resourceSection({resource_scans:[],resources:[]})`),/Nessuna scansione/);
});
test('materiali dichiarati preservano originale, classificazione, necessità e provenienza',()=>{
  const detail={material_scans:[{checked_at:'2026-09-11',source_url:'https://boardgamegeek.com/thread/123',material_listing_status:'observed',coverage_scope:'rules_integrated',notes:'Primo post e regolamento'}],materials:[{name_normalized:'dado d6',name_raw:'2 D6 <dice>',material_kind:'randomizer',supply_mode:'common',quantity_raw:null,requirement_level:'alternative',context_raw:'Use <two> dice',source_url:'https://boardgamegeek.com/thread/123',first_seen_at:'2026-09-10',last_seen_at:'2026-09-11'}]};
  const html=run(`materialSection(${JSON.stringify(detail)})`);
  for(const text of ['2 D6 &lt;dice&gt;','Normalizzato: dado d6','Randomizzatore','Comune','Non specificata','Alternativa','Copertura: Integrato dalle regole','Fonte BGG del requisito ↗','ultimo riscontro']) assert.ok(html.includes(text));
  assert.ok(!html.includes('Use <two> dice'));
  assert.match(html,/include le regole/);
});
test('stati dei materiali restano distinti e la copertura non viene inventata',()=>{
  for(const [status,text] of [['none_declared','non espone requisiti'],['not_observable','non era osservabile'],['not_checked','non sono stati controllati']]) {
    const html=run(`materialSection({material_scans:[{material_listing_status:${JSON.stringify(status)},coverage_scope:'first_post_only',source_url:'https://boardgamegeek.com/thread/123',checked_at:'2026-09-11'}],materials:[]})`);
    assert.ok(html.includes(text));
  }
  assert.match(run(`materialSection({material_scans:[],materials:[]})`),/Nessuna scansione/);
});
test('materiali dichiarati mostrano quantità, classificazione, evidenza e limite di copertura',()=>{
  const detail={material_scans:[{checked_at:'2026-09-11',source_url:'https://boardgamegeek.com/thread/123',material_listing_status:'observed',coverage_scope:'first_post_only',notes:'Regole non aperte'}],materials:[{name_normalized:'dado d6',name_raw:'2 D6 dice',material_kind:'randomizer',supply_mode:'common',quantity_raw:'2',requirement_level:'required',context_raw:'Components: 2 D6 dice',source_url:'https://boardgamegeek.com/thread/123',last_seen_at:'2026-09-11'}]};
  const html=run(`materialSection(${JSON.stringify(detail)})`);
  for(const text of ['dado d6','Randomizzatore','Comune','Components: 2 D6 dice','Solo primo post','potrà essere integrato']) assert.ok(html.includes(text));
});
test('le date preservano giorno, orario e offset originali',()=>{
  assert.equal(run('day("2026-10-16T23:59:00-05:00")'),'16/10/2026 · 23:59 UTC-05:00');
  assert.equal(run('day("2026-09-07")'),'07/09/2026');
  assert.equal(run('day(null)'),'Non registrata');
});
test('confronto senza entità comuni esplicita insufficienza dei dati',()=>{
  const result={notice:'Completezza non certificata',before:{outcome:'complete'},after:{outcome:'no_change'},sections:{entries:{before_count:1,after_count:0,shared_count:0,changes:[],only_before:[{entity_id:1,label:'Gioco'}],only_after:[]}}};
  const html=run(`renderComparison(${JSON.stringify(result)})`);
  assert.match(html,/Dati insufficienti/);
  assert.match(html,/nessuna rimozione\/aggiunta dedotta/);
  assert.ok(!html.includes('Nessuna variazione nei campi'));
});

const ranking = (id, extra={}) => ({id,game_id:id,entry_id:id,contest_id:1,contest_name:'Contest uno',year:2026,scope_type:'pnp_core',category:'Overall',canonical_title:`Gioco ${id}`,credits:'Autrice à',rank:id,score:null,vote_count:null,is_official:1,evidence_url:'https://boardgamegeek.com/thread/123',verified_at:'2026-09-01',...extra});
const baseFilters={query:'',contest:'',year:'',scope:'',category:'',official:'',position:'',sort:'category'};
const sample=[ranking(1),ranking(2,{rank:1,score:0,vote_count:0}),ranking(3,{rank:null,category:'Jury Prize',score:9.5}),ranking(4,{rank:3,is_official:0}),ranking(5,{rank:10,year:2025,scope_type:'adjacent',contest_id:2,contest_name:'Altro',credits:'Secondo autore'})];
const selected=f=>JSON.parse(run(`JSON.stringify(selectRankings(${JSON.stringify(sample)},${JSON.stringify({...baseFilters,...f})}).map(r=>r.id))`));
test('filtri combinabili: contest, anno, perimetro, categoria, natura e autore',()=>{
  assert.deepEqual(selected({contest:'1',year:'2026',scope:'pnp_core',category:'Overall',official:'1',query:' AUTRICE À '}),[1,2]);
  assert.deepEqual(selected({query:'gioco 3'}),[3]);
  assert.deepEqual(selected({query:'secondo',scope:'adjacent'}),[5]);
  assert.deepEqual(selected({official:'0'}),[4]);
  assert.deepEqual(selected({contest:'2',year:'2026'}),[]);
});
test('posizioni numeriche, mancanti sempre in fondo, ex aequo non rinumerati',()=>{
  assert.deepEqual(selected({position:'1'}),[1,2]);
  assert.deepEqual(selected({position:'missing'}),[3]);
  assert.deepEqual(selected({position:'podium'}),[1,2,4]);
  assert.deepEqual(selected({sort:'rank-asc'}),[1,2,4,5,3]);
  assert.deepEqual(selected({sort:'rank-desc'}),[5,4,1,2,3]);
  assert.deepEqual(selected({sort:'title'}),[1,2,3,4,5]);
});
test('render risultati mantiene null e zero, link entry e contest, fonti e intestazioni',()=>{
  const html=run(`rankingTable(${JSON.stringify(sample)},true)`);
  for(const title of ['Posizione','Punteggio','Voti'])assert.ok(html.includes(`scope="col">${title}`));
  assert.match(html,/<td>0<\/td><td>0<\/td>/);
  assert.match(html,/Non registrata/);
  assert.match(html,/9.5/);
  assert.match(html,/#entry\/2/);assert.match(html,/#contest\/2/);
  assert.match(html,/Verificato: 01\/09\/2026/);
  assert.match(html,/Segnale sostitutivo · non ufficiale/);
  assert.match(html,/tabindex="0" role="region"/);
});
test('ex aequo riconosciuti anche in pagina o scheda singola, mai fra fonti o nature diverse',()=>{
  const tied=run(`rankingTable([${JSON.stringify(sample[0])}],false,${JSON.stringify(sample)})`);
  assert.match(tied,/Ex aequo registrato/);
  for(const extra of [{is_official:0},{verified_at:'2026-09-02'},{evidence_url:'https://boardgamegeek.com/thread/456'},{category:'Altro'},{contest_id:2},{game_id:1}]) {
    const html=run(`rankingTable(${JSON.stringify([sample[0],ranking(2,{rank:1,...extra})])})`);
    assert.ok(!html.includes('Ex aequo registrato'));
  }
});
test('sintesi separa osservazioni e non deduce vincitori dai punteggi o da posizioni incomplete',()=>{
  const records=[...sample,ranking(6,{rank:1,is_official:0}),ranking(7,{rank:2,category:'Senza primo',score:999}),ranking(8,{rank:null,category:'Menzione'}),ranking(9,{verified_at:'2026-09-02'})];
  const html=run(`rankingSummary(${JSON.stringify(records)})`);
  assert.equal((html.match(/<section class="panel">/g)||[]).length,7);
  assert.match(html,/Primi posti non ufficiali/);
  assert.match(html,/Nessuna posizione #1 registrata/);
  assert.match(html,/Posizione non registrata<b>1<\/b>/);
  assert.match(html,/#1<b>2<\/b>/);
  assert.match(run('rankingSummary([])'),/Nessun risultato registrato/);
});
test('titoli e categorie non fidati non eseguono markup; entry non collegata esplicita',()=>{
  const r=ranking(1,{canonical_title:'<img src=x onerror=alert(1)>',category:'<script>bad()</script>',entry_id:null,evidence_url:'javascript:alert(1)'});
  for(const fn of ['rankingSummary','rankingTable']) {
    const html=run(`${fn}([${JSON.stringify(r)}],true)`);
    assert.ok(!html.includes('<img'));assert.ok(!html.includes('<script>'));
    assert.match(html,/Entry non collegata/);assert.ok(!html.includes('href="javascript:'));
  }
});

test('libreria: filtri combinabili e ordinamenti deterministici',()=>{
  run(`libraryData={files:[
    {id:1,game_id:1,canonical_title:'Alpha',original_filename:'z.pdf',acquired_at:'2026-01-01',byte_size:30,source_key:'bgg',contests:[{id:2,year:2025}],language_code:'en',media_type:'application/pdf',acquisition_status:'acquired',local_status:'present'},
    {id:2,game_id:1,canonical_title:'Alpha',original_filename:'a.pdf',acquired_at:'2026-02-01',byte_size:20,source_key:'bgg',contests:[{id:2,year:2025}],language_code:'en',media_type:'application/pdf',acquisition_status:'acquired',local_status:'missing'},
    {id:3,game_id:2,canonical_title:'Beta',original_filename:'b.pdf',acquired_at:'2026-03-01',byte_size:10,source_key:'kanare',contests:[],language_code:'ja',media_type:'text/plain',acquisition_status:'failed',local_status:'missing'}]};`);
  run(`Object.assign(libraryFilters,{query:'Alpha',game:'1',contest:'2',source:'bgg',year:'2025',language:'en',type:'application/pdf',status:'acquired',presence:'present'});`);
  assert.equal(run('matchingLibrary().map(x=>x.id).join()'),'1');
  run(`Object.keys(libraryFilters).forEach(k=>libraryFilters[k]='');`);
  for(const [sort,expected] of [['title','1,2,3'],['date','3,2,1'],['size','1,2,3'],['name','2,3,1']]) {
    run(`libraryFilters.sort=${JSON.stringify(sort)}`);
    assert.equal(run('matchingLibrary().map(x=>x.id).join()'),expected);
  }
});
test('libreria: versioni, hash e testo non fidato sono visibili e sicuri',()=>{
  const f={id:1,game_id:1,acquisition_id:7,canonical_title:'<script>evil</script>',source_name:'Kanare',contests:[],original_filename:'<img src=x>.pdf',acquired_at:'2026-01-01',media_type:'application/pdf',language_code:'en',version_raw:'2.1',byte_size:1024,sha256:'abc',usage_conditions:'Uso <personale>',local_status:'missing',local_present:false,remote_status:'available',acquisition_status:'acquired',source_url:'javascript:evil()'};
  const html=run(`localFileRows([${JSON.stringify(f)}])`);
  for(const token of ['&lt;script&gt;','&lt;img','2.1','abc','Uso &lt;personale&gt;','mancante localmente','completezza non determinabile'])assert.ok(html.includes(token),token);
  assert.ok(!html.includes('<script>'));assert.ok(!html.includes('href="javascript:'));
  const grouped=run(`localMaterials({acquisitions:[{id:7,acquired_at:'2026-01-01',files:[${JSON.stringify(f)}]},{id:8,acquired_at:'2026-02-01',files:[]}]})`);
  assert.ok(grouped.includes('Acquisizione #7'));assert.ok(grouped.includes('Acquisizione #8'));
});
test('libreria: stati distinti e zero non confuso con dati assenti',()=>{
  for(const key of ['present','missing','partial','unavailable','not_observable','access_restricted','excluded','none_declared','unknown'])assert.ok(run(`libraryLabel('${key}')`).length);
  assert.equal(run('bytes(0)'),'0 B');assert.equal(run('bytes(null)'),'Non registrata');
  assert.match(run('localMaterials({acquisitions:[]})'),/Nessuna acquisizione registrata/);
});

test('libreria: rendering, filtri da tastiera e paginazione a 50 file',()=>{
  run(`globalThis.libraryNodes={};document.querySelector=selector=>libraryNodes[selector]||(libraryNodes[selector]={innerHTML:'',value:''});
    const template={game_id:1,canonical_title:'Game',source_name:'BGG',source_key:'bgg',contests:[{id:2,name:'Contest',year:2025}],original_filename:'file.pdf',acquired_at:'2026-01-01',media_type:'application/pdf',language_code:'en',byte_size:1,local_status:'present',local_present:true,acquisition_status:'acquired',batch_status:'unknown'};
    const files=Array.from({length:51},(_,i)=>({...template,id:i+1,acquisition_id:1}));
    Object.assign(libraryFilters,{query:'',game:'',contest:'',source:'',year:'',language:'',type:'',status:'',presence:'',sort:'title',page:1});
    renderLibrary({files,acquisitions:[],library_available:false,summary:{games:1,acquisitions:1,files:51,bytes:51,present:51,missing:0,unverifiable:0,contests:[],sources:[],languages:[],types:[]}});`);
  assert.match(run(`libraryNodes['#main'].innerHTML`),/Libreria locale assente/);
  assert.equal(run(`(libraryNodes['#library-results'].innerHTML.match(/file.pdf/g)||[]).length`),50);
  run(`libraryNodes['#library-next'].onclick()`);
  assert.equal(run(`(libraryNodes['#library-results'].innerHTML.match(/file.pdf/g)||[]).length`),1);
  run(`libraryNodes['#library-query'].value='non esiste';libraryNodes['#library-query'].oninput()`);
  assert.match(run(`libraryNodes['#library-results'].innerHTML`),/0 file corrispondenti/);
  assert.equal(run('libraryFilters.page'),1);
});

test('scheda gioco: materiali locali collegati senza fondere le acquisizioni',()=>{
  run(`renderGameDetail({game:{id:1,canonical_title:'Test'},source_records:[],products:[],resources:[],implementations:[],relationships:[],entries:[],names:[],local_materials:{acquisitions:[{id:21,acquired_at:'2026-01-01',files:[]},{id:22,acquired_at:'2026-02-01',files:[]}]}})`);
  const html=run(`libraryNodes['#main'].innerHTML`);
  assert.match(html,/Materiali locali/);assert.match(html,/Acquisizione #21/);assert.match(html,/Acquisizione #22/);
});
test('PDF: link nelle due viste solo per file idonei e ritorno al contesto corretto',()=>{
  const file={id:4,game_id:9,viewer_kind:'pdf',viewer_status:'ready',canonical_title:'Game',contests:[],local_present:true};
  assert.match(run(`localFileRows([${JSON.stringify(file)}])`),/href="#pdf\/4\/library"/);
  assert.match(run(`localMaterials({acquisitions:[{id:1,game_id:9,files:[${JSON.stringify(file)}]}]})`),/href="#pdf\/4\/game\/9"/);
  for(const status of ['missing','unsupported','invalid_path','corrupt'])assert.ok(!run(`viewerLink({id:4,viewer_status:'${status}'})`).includes('href='));
});

test('APP-001 categorie per contest, overall prima e grafia preservata',()=>{
  run("data={rankings:[{contest_id:1,category:'Zeta'},{contest_id:1,category:' Overall '},{contest_id:1,category:'Alpha'},{contest_id:1,category:'Alpha'},{contest_id:2,category:'Solo'}]}");
  assert.equal(run("JSON.stringify(rankingCategories(data.rankings,'1'))"),JSON.stringify([' Overall ','Alpha','Zeta']));
  assert.equal(run("JSON.stringify(rankingCategories(data.rankings,'2'))"),JSON.stringify(['Solo']));
  assert.equal(run("rankingCategories(data.rankings,'3').length"),0);
  run("rankingFilters.category='';reconcileRankingCategory(rankingCategories(data.rankings,'1'),rankingFilters)");
  assert.equal(run('rankingFilters.category'),' Overall ');
  run("rankingFilters.category='Alpha';reconcileRankingCategory(rankingCategories(data.rankings,'1'),rankingFilters)");
  assert.equal(run('rankingFilters.category'),'Alpha');
  run("reconcileRankingCategory(rankingCategories(data.rankings,'2'),rankingFilters)");
  assert.equal(run('rankingFilters.category'),'');
  run("reconcileRankingCategory(rankingCategories(data.rankings,'1'),rankingFilters)");
  assert.equal(run('rankingFilters.category'),' Overall ');
});

test('APP-001 cambio contest ricostruisce il menu e azzera la pagina',()=>{
  const elements={};
  const main={set innerHTML(html){for(const match of html.matchAll(/<select id="([^"]+)">([\s\S]*?)<\/select>/g)){elements['#'+match[1]]={options:[...match[2].matchAll(/<option value="([^"]*)"/g)].map(m=>({value:m[1]}))};}}};
  const local=vm.createContext({URL,document:{querySelector:s=>s==='#main'?main:(elements[s]??={})},window:{addEventListener:()=>{}},fetch:()=>new Promise(()=>{})});
  vm.runInContext(fs.readFileSync(path.join(__dirname,'static/app.js'),'utf8'),local);
  vm.runInContext("rankingResults=()=>{};data={contests:[{contest_id:1,contest_name:'Multi'},{contest_id:2,contest_name:'Solo'}],rankings:[{contest_id:1,category:'overall'},{contest_id:1,category:'art'},{contest_id:2,category:'solo'}]};renderRankings('1')",local);
  assert.deepEqual(elements['#ranking-category'].options.map(o=>o.value),['','overall','art']);
  elements['#ranking-category'].value='art';elements['#ranking-category'].onchange();
  vm.runInContext('rankingFilters.page=3',local);
  elements['#ranking-contest'].value='2';elements['#ranking-contest'].onchange();
  assert.deepEqual(elements['#ranking-category'].options.map(o=>o.value),['','solo']);
  assert.equal(elements['#ranking-category'].value,'');
  assert.equal(vm.runInContext('rankingFilters.page',local),1);
  elements['#ranking-contest'].value='1';elements['#ranking-contest'].onchange();
  assert.equal(elements['#ranking-category'].value,'overall');
});

test('APP-001 riconosce overall nelle etichette originali del catalogo',()=>{assert.equal(run("JSON.stringify(rankingCategories([{category:'Best Art'},{category:'Best Overall Game'},{category:'Best Overall Solo Game'}],''))"),JSON.stringify(['Best Overall Game','Best Overall Solo Game','Best Art']));});
