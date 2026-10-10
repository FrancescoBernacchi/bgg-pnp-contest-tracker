const assert=require('node:assert/strict'),fs=require('node:fs');
const {chromium}=require('C:/Users/39348/.cache/codex-runtimes/codex-primary-runtime/dependencies/node/node_modules/playwright');
const base=process.env.PNP_QA_BASE;
(async()=>{
 const browser=await chromium.launch({headless:true,channel:'msedge'}),page=await browser.newPage();
 const errors=[],external=[];page.on('pageerror',e=>errors.push(e.message));
 await page.route('**/*',r=>{if(!r.request().url().startsWith(base+'/')&&!r.request().url().startsWith('blob:')){external.push(r.request().url());return r.abort();}return r.continue();});
 try{
  const catalog=await(await page.request.get(base+'/api/catalog',{headers:{'Sec-Fetch-Site':'same-origin'}})).json();
  const games=Object.entries(catalog.images).filter(([id,g])=>g.research.some(r=>r.complete));
  assert.equal(games.length,2);
  const contest=catalog.progress.contests.find(c=>c.image_complete_count);
  assert.equal(contest.image_complete_count,2);assert.equal(contest.image_with_images_count,2);
  assert.equal(contest.image_incomplete_count,contest.entry_count-2);
  for(const width of [1400,780,390]){
   await page.setViewportSize({width,height:900});await page.goto(base+'/#games');await page.waitForSelector('[data-list-images]');
   await page.locator('[data-list-images]').uncheck();await page.locator('[data-list-category]').selectOption('');await page.locator('[data-list-state]').selectOption('');
   await page.locator('#game-search').fill(catalog.games.find(g=>g.id===Number(games[0][0])).canonical_title);
   assert.equal(await page.locator('.img-list-thumb').count(),0);
   await page.locator('[data-list-images]').check();
   await page.locator('.img-list-thumb[data-image-thumb]').first().scrollIntoViewIfNeeded();
   await page.waitForSelector('.img-list-thumb img');assert.equal(await page.locator('#game-results tbody tr').count(),1);
   await page.locator('[data-list-images]').uncheck();assert.equal(await page.locator('.img-list-thumb').count(),0);
   await page.locator('[data-list-state]').selectOption('without');assert.equal(await page.locator('#game-results tbody tr').count(),0);
   await page.locator('[data-list-state]').selectOption('');
   await page.goto(base+'/#entries/contest/'+contest.contest_id);await page.waitForSelector('#entry-results');
   await page.locator('[data-list-state]').selectOption('incomplete');assert.equal(await page.locator('#entry-results tbody tr').count(),contest.entry_count-2);
   await page.locator('[data-list-state]').selectOption('');await page.locator('[data-list-images]').check();await page.locator('.img-list-thumb[data-image-thumb]').first().scrollIntoViewIfNeeded();await page.waitForSelector('.img-list-thumb img');
   await page.screenshot({path:`outputs/image-qa/entries-progress-${width}.png`});
   await page.goto(base+'/#progress');await page.waitForSelector('.year-pipeline');
   const yearButton=page.locator('[data-progress-year="2025"]');if(await yearButton.getAttribute('aria-expanded')!=='true')await yearButton.click();
   await page.waitForSelector('#year-detail-2025 .image-progress-bar',{state:'visible'});
   assert.ok((await page.locator('#year-detail-2025 .image-progress-bar').first().getAttribute('aria-label')).includes('2/'));
   assert.equal(await page.locator('#year-detail-2025 .image-progress-bar').count(),2);
   assert.equal(await page.evaluate(()=>document.documentElement.scrollWidth>innerWidth),false);
   await page.locator('#year-detail-2025').scrollIntoViewIfNeeded();await page.screenshot({path:`outputs/image-qa/progress-${width}.png`});
   await page.goto(base+'/#game/'+games[0][0]);await page.waitForSelector('.img-main');assert.match(await page.locator('.img-main').innerText(),/Principale provvisoria/);
   const category=page.locator('[data-image-cover]').first();await category.click();assert.equal(await page.locator('[data-image-category]').inputValue(),await category.getAttribute('data-image-cover'));
  }
  // The agreed 12/8/80 example, rendered through the same functions without database writes.
  const demo=await page.evaluate(()=>({bar:imageBar({entry_count:100,image_complete_count:20,image_with_images_count:12,image_without_images_count:8}),pie:imagePie({total:100,value:20,withImages:12,withoutImages:8})}));
  assert.match(demo.bar,/20%/);assert.match(demo.bar,/data-image-percent="12"/);assert.match(demo.bar,/data-image-percent="8"/);assert.match(demo.pie,/20%/);
  assert.equal(await page.evaluate(()=>imagePercent(2,509)),0.4);
  const adjacent=await page.evaluate(()=>{const panel=document.createElement('section');panel.className='panel';panel.innerHTML=imageBar({entry_count:100,image_complete_count:20,image_with_images_count:12,image_without_images_count:8});document.querySelector('#main').replaceChildren(panel);applyImageBarWidths(panel);const parts=panel.querySelectorAll('.image-progress-bar i');return Math.abs(parts[0].getBoundingClientRect().right-parts[1].getBoundingClientRect().left)<1;});
  assert.equal(adjacent,true);await page.locator('#main .panel').scrollIntoViewIfNeeded();await page.screenshot({path:'outputs/image-qa/progress-demo-390.png'});
  const segments=await page.locator('.image-progress-bar i').evaluateAll(nodes=>nodes.map(n=>({width:n.getBoundingClientRect().width,height:n.getBoundingClientRect().height,color:getComputedStyle(n).backgroundColor,parent:getComputedStyle(n.parentElement).height})));
  assert.ok(segments.every(s=>s.width>0&&s.height>0),JSON.stringify(segments));
  assert.deepEqual(errors,[]);assert.deepEqual(external,[]);
  const result={passed:true,widths:[1400,780,390],contest_entry_total:contest.entry_count,complete:2,checks:['optional list thumbnails','game/entry coverage filters','principal provisional','coverage click filters gallery','single three-part bar and pie','12/8/80 example','no overflow','no external requests','no page errors']};
  fs.writeFileSync('outputs/image-qa/progress-browser-report.json',JSON.stringify(result,null,2));console.log(JSON.stringify(result));
 }finally{await browser.close();}
})().catch(e=>{console.error(e);process.exit(1);});
