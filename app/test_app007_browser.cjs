const {chromium}=require('C:/Users/39348/.cache/codex-runtimes/codex-primary-runtime/dependencies/node/node_modules/playwright');
const assert=require('node:assert/strict');
(async()=>{
 const browser=await chromium.launch({headless:true,channel:'msedge'});
 try{
  const page=await browser.newPage();const errors=[],external=[];
  page.on('pageerror',e=>errors.push(e.message));
  page.on('request',r=>{if(!r.url().startsWith('http://127.0.0.1:8776/')&&!r.url().startsWith('blob:'))external.push(r.url());});
  await page.goto('http://127.0.0.1:8776/#library');await page.waitForSelector('.file-icon');
  const files=await page.evaluate(async()=> (await(await fetch('/api/library')).json()).files.filter(f=>f.viewer_kind==='docx'));
  const report=[];
  for(const width of [1400,390]){
   await page.setViewportSize({width,height:1000});
   for(const file of files){
    await page.goto(`http://127.0.0.1:8776/#docx/${file.id}/library`);
    await page.waitForFunction(()=>document.querySelector('[data-material-status]')?.textContent==='Documento pronto.');
    await page.waitForFunction(()=>[...document.querySelectorAll('.docx-image')].every(i=>i.complete&&i.naturalWidth));
    assert.equal(await page.evaluate(()=>document.documentElement.scrollWidth>innerWidth),false);
    assert.equal(await page.locator('[data-material-content] script').count(),0);
    const metrics=await page.evaluate(()=>({images:document.querySelectorAll('.docx-image').length,lists:document.querySelectorAll('.docx-list').length,bold:[...document.querySelectorAll('.docx-document span')].filter(x=>getComputedStyle(x).fontWeight==='700').length,paragraphs:document.querySelectorAll('.docx-document p').length}));
    await page.screenshot({path:`outputs/app007/docx-${file.id}-${width}.png`});
    if(file.original_filename.includes('Portugu')){
     assert.equal(metrics.images,43);assert.ok(metrics.bold>100);
     await page.locator('[data-material-content]').evaluate(n=>{n.scrollTop=1300});
     await page.screenshot({path:`outputs/app007/docx-${file.id}-${width}-body.png`});
    }
    await page.locator('[data-material-content]').focus();assert.equal(await page.locator('[data-material-content]').evaluate(n=>n===document.activeElement),true);
    report.push({id:file.id,name:file.original_filename,width,...metrics});
   }
  }
  // Synthetic OOXML-derived structure covers headings, nested cells and passive text.
  await page.route('**/api/files/160/docx',route=>route.fulfill({json:{blocks:[
    {kind:'paragraph',heading:1,style:{textAlign:'center'},runs:[{kind:'text',text:'Titolo',style:{fontWeight:'bold',fontSize:'24pt'}}]},
    {kind:'paragraph',list:{id:'1',level:0,ordered:true,marker:'3.'},runs:[{kind:'text',text:'Voce'}]},
    {kind:'table',cells:[[{span:2,blocks:[{kind:'paragraph',runs:[{kind:'text',text:'<script>passivo</script>',style:{fontStyle:'italic'}}]}]}]]}
  ]}}));
  await page.reload();await page.goto('http://127.0.0.1:8776/#docx/160/library');
  await page.waitForSelector('.docx-document h1');
  assert.equal(await page.locator('.docx-document h1').innerText(),'Titolo');
  assert.equal(await page.locator('.docx-document li').innerText(),'3. Voce');
  assert.equal(await page.locator('.docx-document td').getAttribute('colspan'),'2');
  assert.equal(await page.locator('.docx-document td').innerText(),'<script>passivo</script>');
  assert.equal(await page.locator('.docx-document script').count(),0);
  assert.equal(await page.locator('.docx-document td span').evaluate(n=>getComputedStyle(n).fontStyle),'italic');
  await page.locator('.docx-document .table-wrap').focus();assert.equal(await page.locator('.docx-document .table-wrap').evaluate(n=>n===document.activeElement),true);
  await page.screenshot({path:'outputs/app007/synthetic-390.png'});
  assert.deepEqual(errors,[]);assert.deepEqual(external,[]);
  require('node:fs').writeFileSync('outputs/app007/browser.json',JSON.stringify(report,null,2));console.log(report);
 }finally{await browser.close();}
})().catch(e=>{console.error(e);process.exitCode=1});
