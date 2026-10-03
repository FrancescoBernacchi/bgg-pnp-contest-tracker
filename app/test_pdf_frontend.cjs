const {test}=require('node:test');
const assert=require('node:assert/strict');
const fs=require('node:fs');
const vm=require('node:vm');
const path=require('node:path');
function setup({error=null,gate=null,defaultFetch=false}={}) {
  const nodes=new Map();
  const root={querySelector:key=>{if(!nodes.has(key))nodes.set(key,{textContent:'',value:1,clientWidth:640,style:{},setAttribute(k,v){this[k]=v;},getContext:()=>({})});return nodes.get(key);}};
  const calls=[],renders=[],cancellations=[];
  const doc={numPages:3,getPage:async(number)=>({getViewport:({scale})=>({width:300*scale,height:400*scale}),
    render:options=>{renders.push({number,options});return {promise:Promise.resolve(),cancel:()=>cancellations.push(number)};},
    getTextContent:async()=>({items:[{str:'<script>safe plain text</script>',hasEOL:true}]}),cleanup(){}})};
  let options, destroyed=0;
  const engine={GlobalWorkerOptions:{},getDocument(input){options=input;return {promise:error?Promise.reject(error):Promise.resolve(doc),destroy:()=>{destroyed++;return Promise.resolve();}};}};
  const fetcher=async function(url,init){
    if(defaultFetch)assert.equal(this,context.window,'fetch richiede il receiver Window');
    calls.push({url,init});
    if(gate&&url.endsWith('/pdf'))await gate;
    return {ok:true,headers:{get:()=>20},json:async()=>url.endsWith('session')?{token:'temporary'}:{viewer_status:'ready',original_filename:'<unsafe>.pdf',canonical_title:'Game',version_raw:'v2',acquisition_id:7,acquired_at:'2026-10-03'},arrayBuffer:async()=>new ArrayBuffer(20)};
  };
  const context=vm.createContext({window:{devicePixelRatio:2},AbortController,Uint8Array,fetch:fetcher});
  vm.runInContext(fs.readFileSync(path.join(__dirname,'static/pdf-viewer.js'),'utf8'),context);
  const reader=new context.window.PnPViewers.pdf(root,{...(defaultFetch?{}:{fetch:fetcher}),engine:async()=>engine});
  return {reader,nodes,root,calls,renders,cancellations,options:()=>options,destroyed:()=>destroyed};
}
test('PDF: fetch solo per ID locali, token solo in header, scripting e annotazioni esclusi',async()=>{
  const s=setup();await s.reader.open(12);
  assert.deepEqual(s.calls.map(c=>c.url),['/api/viewer-session','/api/files/12','/api/files/12/pdf']);
  assert.equal(s.calls[2].init.headers['X-PnP-Viewer'],'temporary');
  assert.ok(s.calls.every(c=>!c.url.includes('temporary')));
  assert.equal(s.options().isEvalSupported,false);assert.equal(s.options().enableXfa,false);
  assert.equal(s.options().useWorkerFetch,false);assert.equal(s.options().useWasm,false);
  assert.equal(s.options().disableRange,true);assert.equal(s.renders[0].options.annotationMode,0);
  assert.equal(s.nodes.get('[data-pdf-title]').textContent,'<unsafe>.pdf');
  assert.equal(s.nodes.get('[data-pdf-text]').textContent,'<script>safe plain text</script>\n');
  assert.equal(s.nodes.get('[data-pdf-page]').max,3);
});
test('PDF: pagine, limiti, zoom, tastiera e cancellazione del rendering precedente',async()=>{
  const s=setup();await s.reader.open(1);
  await s.reader.setPage(2);
  assert.equal(s.nodes.get('[data-pdf-page]').value,2);
  s.reader.setPage(999);assert.equal(s.reader.page,2);
  s.reader.zoom='1.5';await s.reader.render();
  assert.match(s.nodes.get('[data-pdf-status]').textContent,/150%/);
  let prevented=false;s.root.onkeydown({target:{tagName:'DIV'},key:'ArrowRight',preventDefault(){prevented=true;}});
  await s.reader.renderQueue;
  assert.equal(s.reader.page,3);assert.ok(prevented);
  assert.equal(s.nodes.get('[data-pdf-next]').disabled,true);
  assert.ok(s.cancellations.length>0);
  const before=s.reader.page;s.root.onkeydown({target:{tagName:'INPUT'},key:'ArrowLeft',preventDefault(){throw Error('unexpected');}});assert.equal(s.reader.page,before);
  s.reader.destroy();assert.ok(s.reader.abort.signal.aborted);assert.equal(s.destroyed(),1);
});
test('PDF: navigazione durante il download impedisce rendering e aggiornamenti tardivi',async()=>{
  let release;const gate=new Promise(resolve=>release=resolve);
  const s=setup({gate});const pending=s.reader.open(1);
  await new Promise(resolve=>setImmediate(resolve));s.reader.destroy();release();await pending;
  assert.equal(s.renders.length,0);assert.equal(s.options(),undefined);
});
test('PDF: errori corrotti e cifrati restano locali e comprensibili',async()=>{
  for(const [name,text] of [['InvalidPDFException','danneggiato'],['PasswordException','cifrato']]){
    const s=setup({error:Object.assign(new Error('private/internal/path'),{name})});await s.reader.open(1);
    assert.ok(s.nodes.get('[data-pdf-status]').textContent.includes(text));
    assert.ok(!s.nodes.get('[data-pdf-status]').textContent.includes('private/internal/path'));
    assert.equal(s.nodes.get('[data-pdf-status]').role,'alert');
  }
});
test('PDF: il fetch del browser mantiene il receiver corretto',async()=>{
  const s=setup({defaultFetch:true});await s.reader.open(1);assert.equal(s.renders.length,1);
});
