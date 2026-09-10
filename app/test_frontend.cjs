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
test('solo link BGG di metadati, nessun download o host esterno',()=>{
  for(const url of ['javascript:alert(1)','https://example.com/thread/123','https://boardgamegeek.com/filepage/123','https://boardgamegeek.com/file/download/test','https://boardgamegeek.com.evil.example/thread/123','https://user:pass@boardgamegeek.com/thread/123']){
    assert.ok(!run(`source(${JSON.stringify(url)})`).includes('<a '));
  }
  assert.match(run('source("https://boardgamegeek.com/thread/123/title","2026-09-07")'),/rel="noopener noreferrer"/);
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
