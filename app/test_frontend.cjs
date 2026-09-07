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
