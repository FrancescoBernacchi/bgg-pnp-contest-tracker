const assert=require('node:assert/strict'),fs=require('node:fs');
const {chromium}=require('C:/Users/39348/.cache/codex-runtimes/codex-primary-runtime/dependencies/node/node_modules/playwright');
const base=process.env.PNP_QA_BASE||'http://127.0.0.1:8795';
const manifest=JSON.parse(fs.readFileSync('catalog/2025_children_family_images_2026-10-05.json','utf8'));
(async()=>{
 const browser=await chromium.launch({headless:true,channel:'msedge'}),page=await browser.newPage();
 const errors=[],external=[];page.on('pageerror',e=>errors.push(e.message));
 await page.route('**/*',route=>{if(!route.request().url().startsWith(base+'/')&&!route.request().url().startsWith('blob:')){external.push(route.request().url());return route.abort();}return route.continue();});
 fs.mkdirSync('outputs/image-qa',{recursive:true});
 const pilots=manifest.games.filter(g=>g.research_complete);
 const headers={'Sec-Fetch-Site':'same-origin'};
 try{
  const session=await(await page.request.get(base+'/api/viewer-session',{headers})).json();
  const guarded={...headers,'X-PnP-Viewer':session.token};
  for(const width of [1400,780,390]){
   await page.setViewportSize({width,height:900});
   for(const game of pilots){
    await page.goto(base+'/#game/'+game.game_id);
    await page.waitForSelector('[data-image-gallery]');
    const expected=manifest.images.filter(i=>i.game_id===game.game_id).length;
    assert.equal(await page.locator('[data-image-gallery] .img-card').count(),expected);
    assert.match(await page.locator('.img-research').innerText(),/Ricerca conclusa/);
    const first=page.locator('[data-image-gallery] [data-image-open]').first();await first.scrollIntoViewIfNeeded();
    await page.waitForFunction(()=>document.querySelector('[data-image-gallery] .img-preview img'));
    await first.click();await page.waitForSelector('dialog[open] .img-zoom-surface img');
    await page.locator('[data-image-zoom]').selectOption('1.5');assert.equal(await page.locator('.img-zoom-surface').evaluate(n=>n.classList.contains('img-actual')),true);
    await page.locator('[data-image-zoom]').selectOption('fit');
    await page.locator('[data-image-next]').click();await page.waitForSelector('dialog[open] .img-zoom-surface img');
    await page.locator('[data-image-close]').focus();await page.keyboard.press('ArrowLeft');await page.waitForSelector('dialog[open] .img-zoom-surface img');
    assert.match(await page.locator('.img-metadata').innerText(),/Crediti|Provenienze/);
    await page.keyboard.press('Escape');await page.waitForSelector('dialog',{state:'detached'});
    const choices=await page.locator('[data-image-category] option').evaluateAll(nodes=>nodes.map(n=>n.value));
    const cat=choices.find(c=>c&&manifest.images.filter(i=>i.game_id===game.game_id&&[i.category,...(i.additional_categories||[])].includes(c)).length<expected);
    if(cat){await page.locator('[data-image-category]').selectOption(cat);assert.ok(await page.locator('[data-image-gallery] .img-card').count()<expected);await page.locator('[data-image-category]').selectOption('');}
    await page.locator('.img-components > summary').click();
    assert.equal(await page.locator('.img-component').count(),manifest.components.filter(c=>c.game_id===game.game_id).length);
    const regions=manifest.images.find(i=>i.game_id===game.game_id&&i.side_regions?.length);
    if(regions){
     const metadata=await(await page.request.get(base+`/api/games/${game.game_id}/images`,{headers})).json();
     const file=metadata.files.find(f=>f.image_id===regions.image_id);
     await page.locator(`[data-image-gallery] [data-image-open="${file.id}"]`).click();await page.waitForSelector('dialog[open] .img-zoom-surface img');
     await page.getByText('Regioni fronte / retro / base e assemblaggio',{exact:true}).click();
     assert.match(await page.locator('.img-metadata').innerText(),/Fronte/);assert.match(await page.locator('.img-metadata').innerText(),/Retro/);assert.match(await page.locator('.img-metadata').innerText(),/Base/);
     await page.keyboard.press('Escape');
    }
    await page.locator('.img-history > summary').click();
    assert.equal(await page.locator('[data-image-history] .img-card').count(),(manifest.historical_files||[]).filter(i=>i.game_id===game.game_id).length);
    await page.locator('.image-catalog > h2').evaluate(n=>n.scrollIntoView({block:'start'}));
    await page.waitForFunction(()=>[...document.querySelectorAll('[data-image-gallery] .img-preview')].filter(n=>{const b=n.getBoundingClientRect();return b.top>=0&&b.bottom<=innerHeight;}).every(n=>n.querySelector('img')));
    await page.screenshot({path:`outputs/image-qa/game-${game.game_id}-${width}.png`});
    assert.equal(await page.evaluate(()=>document.documentElement.scrollWidth>innerWidth),false);
   }
  }
  const partial=manifest.games.find(g=>!g.research_complete);
  await page.goto(base+'/#game/'+partial.game_id);await page.waitForSelector('[data-image-gallery]');
  assert.match(await page.locator('.img-research').innerText(),/non conclusa/);assert.equal(await page.locator('[data-image-gallery] .img-card').count(),0);
  const meta=await(await page.request.get(base+`/api/games/${pilots[0].game_id}/images`,{headers})).json(),first=meta.files[0];
  assert.equal((await page.request.get(base+`/api/image-files/${first.id}/original`)).status(),403);
  assert.equal((await page.request.get(base+`/api/image-files/${first.id}/thumbnail`,{headers:guarded})).status(),200);
  assert.equal((await page.request.get(base+`/api/image-files/${first.id}/original?path=escape`,{headers:guarded})).status(),400);
  // UI-only fixture: no SQLite write, generation or new image acquisition.
  const synth=structuredClone(meta);synth.files=[{...first,is_current:true,origin_kind:'ai_generated',validation_state:'pending',current_use:'not_adopted',title:'Risultato sintetico <img src=x>'},
   {...meta.files[1],is_current:true,origin_kind:'ai_reworked',validation_state:'rejected',current_use:'not_adopted'}];synth.components=[];
  await page.route(base+`/api/games/${pilots[0].game_id}/images`,r=>r.fulfill({status:200,contentType:'application/json',body:JSON.stringify(synth)}));
  await page.goto(base+'/#game/'+pilots[0].game_id);await page.waitForSelector('[data-image-gallery]');
  assert.equal(await page.locator('[data-image-gallery] .img-card').count(),0);assert.equal(await page.locator('[data-image-ai] .img-card').count(),1);assert.equal(await page.locator('[data-image-history] .img-card').count(),1);
  assert.equal(await page.locator('[data-image-ai] img[src=x]').count(),0);
  await page.unroute(base+`/api/games/${pilots[0].game_id}/images`);
  await page.goto(base+'/#library');await page.waitForSelector('#library-results');assert.match(await page.locator('#main').innerText(),/Libreria/);
  assert.deepEqual(errors,[]);assert.deepEqual(external,[]);
  const report={passed:true,widths:[1400,780,390],pilots:pilots.length,external_requests:external,page_errors:errors,
   checks:['adopted counts','lazy thumbnails','zoom fit/150%','navigation keyboard/Escape','category filter','components/shared sides','assembly regions','history','partial research','AI synthetic groups','XSS text escaping','HTTP token/parameters','library regression']};
  fs.writeFileSync('outputs/image-qa/browser-report.json',JSON.stringify(report,null,2));console.log(JSON.stringify(report));
 }finally{await browser.close();}
})().catch(e=>{console.error(e);process.exit(1);});
