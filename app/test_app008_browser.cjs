const assert=require('node:assert/strict');
const {chromium}=require('C:/Users/39348/.cache/codex-runtimes/codex-primary-runtime/dependencies/node/node_modules/playwright');
(async()=>{
  const browser=await chromium.launch({headless:true,channel:'msedge'});
  try{
    const page=await browser.newPage();
    const errors=[];page.on('pageerror',e=>errors.push(e.message));
    for(const width of [1560,1400,390]){
      await page.setViewportSize({width,height:900});
      await page.goto(process.env.APP008_TEST_URL||'http://127.0.0.1:8789/#progress');
      await page.waitForSelector('[data-progress-year="2025"]');
      await page.locator('[data-progress-year="2025"]').click();
      const card=page.locator('[data-progress-year="2025"]');
      assert.equal(await card.locator('progress').count(),10);
      for(const section of await card.locator('.pipeline-scope').all()){
        const text=await section.innerText();
        assert.match(text,/Censimento classifica\s+(384\/384|80\/80) · 100%/);
        assert.match(text,/Acquisizione immagini\s+0\/(384|80) · 0%/);
        assert.match(text,/non ancora implementata/);
        assert.match(text,/entry effettivamente classificate/);
      }
      assert.equal(await page.evaluate(()=>document.documentElement.scrollWidth>innerWidth),false);
      const offsets=await page.locator('.year-pipeline').evaluateAll(cards=>cards.slice(0,5).map(card=>({year:card.dataset.progressYear,offset:card.querySelector('.pipeline-title').getBoundingClientRect().top-card.getBoundingClientRect().top})));
      assert.ok(offsets.every(item=>item.offset>=14&&item.offset<=16),JSON.stringify(offsets));
      assert.ok(Math.max(...offsets.map(x=>x.offset))-Math.min(...offsets.map(x=>x.offset))<=1);
      const restored=await page.locator('[data-progress-year="2024"]').innerText();
      assert.match(restored,/Censimento entry\s+10\/10 · 100%/);
      const current=await page.locator('[data-progress-year="2026"]').innerText();
      assert.match(current,/Censimento entry\s+9\/10 · 90%/);
      assert.match(current,/Censimento entry\s+7\/8 · 88%/);
      assert.match(current,/Censimento classifica\s+132\/356 · 37%/);
      assert.match(current,/12 verifiche parziali/);
      assert.match(current,/Censimento classifica\s+21\/74 · 28%/);
      const year2025=await card.innerText();
      assert.match(year2025,/Acquisizione materiali\s+39\/363 · 11%/);
      assert.match(year2025,/13 bloccate · 3 verifiche parziali/);
      await card.screenshot({path:`outputs/app008/annual-${width}.png`});
      if(width===1560) await page.locator('.year-pipeline-grid').screenshot({path:'outputs/app008/history-grid-1560.png'});
      console.log(JSON.stringify({width,bars:10,ranking:100,images:0,overflow:false,header_offsets:offsets,history_restored:true}));
    }
    assert.deepEqual(errors,[]);
  }finally{await browser.close();}
})().catch(e=>{console.error(e);process.exitCode=1;});
