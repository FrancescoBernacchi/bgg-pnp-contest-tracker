const assert=require('node:assert/strict'),fs=require('node:fs');
const {chromium}=require('C:/Users/39348/.cache/codex-runtimes/codex-primary-runtime/dependencies/node/node_modules/playwright');
const base=process.env.PNP_QA_BASE;
(async()=>{
 const browser=await chromium.launch({headless:true,channel:'msedge'}),page=await browser.newPage();
 const errors=[],external=[];page.on('pageerror',e=>errors.push(e.message));
 await page.route('**/*',r=>{if(!r.request().url().startsWith(base+'/')&&!r.request().url().startsWith('blob:')){external.push(r.request().url());return r.abort();}return r.continue();});
 try{
  const catalog=await(await page.request.get(base+'/api/catalog',{headers:{'Sec-Fetch-Site':'same-origin'}})).json();
  const contest=catalog.progress.contests.find(c=>c.image_complete_count),entry=catalog.entries.find(e=>catalog.images[e.game_id]?.research.some(r=>r.complete));
  for(const width of [1400,780,390]){
   await page.setViewportSize({width,height:900});await page.goto(base+'/#progress');await page.waitForSelector('.contest-image-progress');
   const year=page.locator('[data-progress-year="2025"]');await year.click();
   const row=page.locator('.contest-image-progress').filter({hasText:`${contest.image_complete_count}/${contest.entry_count}`});
   assert.equal(await row.count(),1);assert.match(await row.innerText(),/2 concluse con immagini/);await row.scrollIntoViewIfNeeded();
   assert.equal(await page.evaluate(()=>document.documentElement.scrollWidth>innerWidth),false);await page.screenshot({path:`outputs/image-qa/completion-contests-${width}.png`});
   await page.goto(base+'/#entry/'+entry.id);await page.waitForSelector('.entry-images-link');assert.equal(await page.locator('.entry-images-link').getAttribute('href'),'#game/'+entry.game_id);
   await page.locator('.entry-images-link').click();await page.waitForSelector('[data-image-gallery]');
   const absent=await page.locator('[data-image-cover]').evaluateAll(nodes=>nodes.map(n=>n.dataset.imageCover));
   const category=(catalog.images[entry.game_id].coverage||[]).find(c=>c.original_count===0&&c.ai_count===0&&absent.includes(c.category));
   if(category){await page.locator(`[data-image-cover="${category.category}"]`).click();assert.equal(await page.locator('[data-image-category]').inputValue(),category.category);assert.equal(await page.locator('[data-image-gallery] .img-card').count(),0);await page.locator('[data-image-category]').selectOption('');}
   await page.locator('.img-components > summary').click();const types=await page.locator('[data-image-component-type] option').evaluateAll(nodes=>nodes.map(n=>n.value).filter(Boolean));
   assert.equal(await page.locator('.img-component-group').count(),types.length);
   if(types.length){await page.locator('[data-image-component-type]').selectOption(types[0]);assert.equal(await page.locator('.img-component-group').count(),1);}
  }
  // Independent filters and category status, with metadata fixtures only.
  const synth=structuredClone(catalog),games=synth.games.slice(0,3);
  games.forEach((g,i)=>{g.canonical_title='IMG Synthetic '+i;synth.images[g.id]={original_count:i===2?1:0,ai_count:0,pending_count:i===0?1:0,research:[{complete:true}],coverage:[{category:'Setup',applicability:'desired',original_count:i===2?1:0,ai_count:0,pending_count:i===0?1:0,verified_absence:false,research_observations:[{complete:i===1}]}]};});
  await page.route(base+'/api/catalog',r=>r.fulfill({status:200,contentType:'application/json',body:JSON.stringify(synth)}));
  await page.goto(base+'/#games');await page.reload();await page.locator('#game-search').fill('IMG Synthetic');await page.locator('[data-list-category]').selectOption('Setup');
  await page.locator('[data-image-condition="original_missing"]').check();await page.locator('[data-image-condition="incomplete"]').check();await page.locator('[data-image-condition="pending"]').check();
  assert.equal(await page.locator('#game-results tbody tr').count(),1);assert.match(await page.locator('#game-results').innerText(),/IMG Synthetic 0/);
  await page.locator('[data-image-filter-reset]').click();await page.locator('[data-list-category]').selectOption('Setup');await page.locator('[data-image-condition="no_adopted"]').check();assert.equal(await page.locator('#game-results tbody tr').count(),2);
  await page.locator('[data-image-filter-reset]').click();await page.locator('[data-list-category]').selectOption('Setup');await page.locator('[data-list-state]').selectOption('without');assert.equal(await page.locator('#game-results tbody tr').count(),1);assert.match(await page.locator('#game-results').innerText(),/IMG Synthetic 1/);
  await page.unroute(base+'/api/catalog');
  const meta=await(await page.request.get(base+`/api/games/${entry.game_id}/images`,{headers:{'Sec-Fetch-Site':'same-origin'}})).json();
  const file=meta.files.find(f=>f.is_current&&f.current_use==='adopted'&&f.extraction&&Object.keys(f.extraction).length)||meta.files[0];
  file.material_revision={status:'previous',evidence:{statement:'Explicit synthetic succession, no inferred date'}};
  await page.route(base+`/api/games/${entry.game_id}/images`,r=>r.fulfill({status:200,contentType:'application/json',body:JSON.stringify(meta)}));
  await page.goto(base+'/#game/'+entry.game_id);await page.waitForSelector('[data-image-gallery]');await page.locator(`[data-image-gallery] [data-image-open="${file.id}"]`).click();await page.waitForSelector('.img-revision-notice');assert.match(await page.locator('.img-revision-notice').innerText(),/revisione precedente/);await page.keyboard.press('Escape');
  assert.deepEqual(errors,[]);assert.deepEqual(external,[]);
  const result={passed:true,widths:[1400,780,390],checks:['contest image indicator 2/27 and breakdown','entry-to-game image link','empty-category gallery filter','component subtype groups and filter','independent AND filters','category incomplete despite game complete','no adopted regardless research','previous material revision evidence notice','no overflow/errors/external requests']};
  fs.writeFileSync('outputs/image-qa/completion-browser-report.json',JSON.stringify(result,null,2));console.log(JSON.stringify(result));
 }finally{await browser.close();}
})().catch(e=>{console.error(e);process.exit(1);});
