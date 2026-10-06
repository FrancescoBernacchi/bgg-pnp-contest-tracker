const assert=require('node:assert/strict'),fs=require('node:fs');
const {chromium}=require('C:/Users/39348/.cache/codex-runtimes/codex-primary-runtime/dependencies/node/node_modules/playwright');
const url=process.env.APP008_TEST_URL||'http://127.0.0.1:8789/#progress';
(async()=>{
  const browser=await chromium.launch({headless:true,channel:'msedge'});
  try{
    const page=await browser.newPage();
    const snapshot=await (await page.request.get(new URL('/api/catalog',url).href)).json();
    const errors=[];page.on('pageerror',e=>errors.push(e.message));
    fs.mkdirSync('outputs/app008',{recursive:true});
    for(const width of [1560,1400,390]){
      await page.setViewportSize({width,height:900});
      await page.goto(url);await page.reload();
      await page.waitForSelector('[data-progress-year="2025"]');
      for(const year of [2025,2024,2026]){
        const proof=snapshot.progress.years.find(y=>y.year===year);
        await page.locator(`[data-progress-year="${year}"]`).click();
        const card=page.locator(`#year-detail-${year}`);
        assert.equal(await card.locator('progress').count(),10);
        const sections=await card.locator('.pipeline-scope').all();
        for(const [index,scope] of [proof.pnp_core,proof.adjacent].entries()){
          const bars=await sections[index].locator('progress').all();
          const values=[[scope.census_complete_count,scope.contest_count],
            [scope.ranking_complete_count,scope.ranking_total],
            [scope.materials_complete_count,scope.materials_total],
            [scope.acquisition_complete_count,scope.acquisition_total],[0,scope.entry_count]];
          for(const [position,[value,total]] of values.entries()){
            assert.equal(Number(await bars[position].getAttribute('value')),value);
            assert.equal(Number(await bars[position].getAttribute('max')),total||1);
          }
          assert.match(await sections[index].textContent(),/entry effettivamente classificate/);
          assert.match(await sections[index].textContent(),/non ancora implementata/);
        }
      }
      assert.equal(await page.evaluate(()=>document.documentElement.scrollWidth>innerWidth),false);
      const offsets=await page.locator('.year-pipeline').evaluateAll(cards=>cards.slice(0,5).map(card=>card.querySelector('.pipeline-title').getBoundingClientRect().top-card.getBoundingClientRect().top));
      assert.ok(offsets.every(offset=>offset>=10&&offset<=12),JSON.stringify(offsets));
      await page.locator('#year-detail-2026').screenshot({path:`outputs/app008/annual-${width}.png`});
      console.log(JSON.stringify({width,bars:10,years:[2025,2024,2026],matchesDatedAPI:true,overflow:false}));
    }
    assert.deepEqual(errors,[]);
  }finally{await browser.close();}
})().catch(e=>{console.error(e);process.exitCode=1;});
