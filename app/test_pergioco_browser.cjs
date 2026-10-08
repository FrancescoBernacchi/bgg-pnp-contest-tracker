const assert=require('node:assert/strict'),fs=require('node:fs');
const {chromium}=require('C:/Users/39348/.cache/codex-runtimes/codex-primary-runtime/dependencies/node/node_modules/playwright');
const base='http://127.0.0.1:8793';
(async()=>{
 const browser=await chromium.launch({headless:true,channel:'msedge'});
 const page=await browser.newPage(),errors=[],external=[];
 page.on('pageerror',e=>errors.push(e.message));
 await page.route('**/*',route=>{if(!route.request().url().startsWith(base+'/')){external.push(route.request().url());return route.abort();}return route.continue();});
 fs.mkdirSync('outputs/pergioco-qa',{recursive:true});
 try{
  const response=await page.request.get(base+'/api/catalog');assert.equal(response.status(),200);
  const catalog=await response.json(),records=catalog.source_records.filter(r=>r.source_key==='pergioco');assert.equal(records.length,12);
  for(const width of [1400,780,390]){
   await page.setViewportSize({width,height:950});await page.goto(base+'/#source/pergioco');
   await page.waitForSelector('#record-results');assert.equal(await page.locator('#record-results tbody tr').count(),12);
   assert.equal(await page.locator('#pergioco-count').textContent(),'12');
   assert.equal(await page.locator('[data-nav="source/pergioco"]').getAttribute('aria-current'),'page');
   await page.getByLabel('Cerca nei record').fill('Blockade');assert.equal(await page.locator('#record-results tbody tr').count(),2);
   await page.getByLabel('Esito del requisito').selectOption('requirement_not_demonstrated');assert.equal(await page.locator('#record-results tbody tr').count(),2);
   await page.getByLabel('Cerca nei record').fill('');await page.getByLabel('Identità',{exact:true}).selectOption('source_only');assert.equal(await page.locator('#record-results tbody tr').count(),3);
   await page.getByLabel('Esito del requisito').selectOption('');await page.getByLabel('Identità',{exact:true}).selectOption('');
   await page.getByLabel('Campo ricercato').selectOption('credits');await page.getByLabel('Cerca nei record').fill('Marino');assert.equal(await page.locator('#record-results tbody tr').count(),12);
   await page.getByLabel('Cerca nei record').fill('');await page.getByLabel('Campo ricercato').selectOption('all');
   await page.screenshot({path:`outputs/pergioco-qa/roster-${width}.png`});
   assert.equal(await page.evaluate(()=>document.documentElement.scrollWidth>innerWidth),false);
   await page.goto(base+'/#progress/pergioco');await page.waitForSelector('#source-progress-panel');
   const text=await page.locator('#source-progress-panel').innerText();assert.match(text,/12\/12 · 100%/);assert.match(text,/9\/12 · 75%/);assert.match(text,/non intero sito|non l’intero sito/);
   await page.locator('#refresh').click();await page.waitForFunction(()=>!document.querySelector('#refresh').disabled);
   assert.equal(await page.locator('[role=tab][aria-selected=true]').textContent(),'PerGioco');
   await page.locator('[data-progress-source="pergioco"]').focus();await page.keyboard.press('ArrowLeft');await page.waitForSelector('.source-metric');
   assert.equal(await page.locator('[role=tab][aria-selected=true]').textContent(),'Kanare');
   await page.locator('[data-progress-source="boardgamegeek"]').click();await page.waitForSelector('.year-toggle');
   for(const r of records){
    await page.goto(base+'/#source-record/'+r.id);await page.waitForSelector('h1');
    await page.waitForFunction(id=>document.querySelector('#main').dataset.recordId===String(id),r.id);
    assert.match(await page.locator('#main').innerText(),/Crediti dichiarati e lacune/);
    assert.equal(await page.locator('#main a.back[href^="#source/"]').count(),1);
    assert.equal(await page.evaluate(()=>document.documentElement.scrollWidth>innerWidth),false);
   }
   const abande=records.find(r=>r.title_raw==='Abande');await page.goto(base+'/#source-record/'+abande.id);await page.waitForSelector('h1');
   await page.waitForFunction(id=>document.querySelector('#main').dataset.recordId===String(id),abande.id);assert.match(await page.locator('#main').innerText(),/Equivalenza da valutare/);
   const itinera=records.find(r=>r.title_raw==='Itinera');await page.goto(base+'/#source-record/'+itinera.id);await page.waitForSelector('h1');
   await page.waitForFunction(id=>document.querySelector('#main').dataset.recordId===String(id),itinera.id);assert.match(await page.locator('#main').innerText(),/18\/06\/2021/);assert.match(await page.locator('#main').innerText(),/23\/07\/2021/);
   await page.screenshot({path:`outputs/pergioco-qa/itinera-${width}.png`});
   await page.locator('.skip').focus();await page.keyboard.press('Enter');assert.equal(await page.evaluate(()=>document.activeElement.id),'main');
   await page.goto(base+'/#library');await page.waitForSelector('#library-results');assert.match(await page.locator('#main').innerText(),/Libreria/);
  }
  await page.goto(base+'/#source/pergioco');await page.waitForSelector('#record-results');
  await page.locator('#record-matching').selectOption('source_only');
  await page.locator('#refresh').click();await page.waitForFunction(()=>!document.querySelector('#refresh').disabled);assert.equal(await page.locator('#record-results tbody tr').count(),3);
  await page.goto(base+'/#games');await page.waitForSelector('#game-results');
  await page.locator('#game-source').selectOption('pergioco');assert.equal(await page.locator('#game-results tbody tr').count(),9);
  for(const r of records.filter(r=>r.matches.some(m=>m.match_status==='confirmed'))){
   await page.goto(base+'/#game/'+r.matches[0].game_id);await page.waitForSelector('h1');
   assert.ok(await page.locator(`a[href="#source-record/${r.id}"]`).count());
  }
  const invalid=await page.request.get(base+'/api/source-records/999999');assert.equal(invalid.status(),404);
  const params=await page.request.get(base+'/api/source-records/'+records[0].id+'?url=bad');assert.equal(params.status(),400);
  // Frontend-only synthetic roster exercises paging without changing SQLite or scope evidence.
  const paged=JSON.parse(JSON.stringify(catalog));
  paged.source_records.push(...Array.from({length:15},(_,i)=>({...records[0],id:10000+i,titles:['Synthetic record '+i]})));
  await page.route(base+'/api/catalog',route=>route.fulfill({status:200,contentType:'application/json',body:JSON.stringify(paged)}));
  await page.goto(base+'/#source/pergioco');await page.reload();await page.waitForSelector('#record-results');
  assert.equal(await page.locator('#record-results tbody tr').count(),25);assert.equal(await page.locator('#pergioco-count').textContent(),'27');
  await page.locator('#record-next').click();assert.equal(await page.locator('#record-results tbody tr').count(),2);
  assert.match(await page.locator('#record-results').innerText(),/27 record corrispondenti \/ 27 record della fonte/);
  await page.goto(base+'/#progress/pergioco');await page.waitForSelector('#source-progress-panel');assert.match(await page.locator('#source-progress-panel').innerText(),/12\/12 · 100%/);
  await page.goto(base+'/#source/synthetic_absent');await page.waitForSelector('#record-results');assert.match(await page.locator('#main').innerText(),/Fonte assente/);
  assert.equal(await page.locator('#record-results tbody tr').count(),0);
  assert.deepEqual(errors,[]);assert.deepEqual(external,[]);
  console.log('PerGioco browser: desktop/tablet/mobile, all 12 records, filters, candidates, instances, canonical links, refresh, keyboard, API errors; no external requests or page errors.');
 }finally{await browser.close();}
})().catch(e=>{console.error(e);process.exit(1);});
