const assert = require('node:assert/strict');
const fs = require('node:fs');
const {chromium} = require('C:/Users/39348/.cache/codex-runtimes/codex-primary-runtime/dependencies/node/node_modules/playwright');

const baseUrl=process.env.APP_PROGRESS_TEST_URL||'http://127.0.0.1:8791';
(async () => {
  const browser = await chromium.launch({headless:true,channel:'msedge'});
  try {
    const page = await browser.newPage();
    const errors=[],external=[];
    page.on('pageerror',e=>errors.push(e.message));
    page.on('request',r=>{if(!r.url().startsWith(baseUrl+'/'))external.push(r.url());});
    fs.mkdirSync('outputs/multisource-progress',{recursive:true});
    for(const width of [1400,780,390]){
      await page.setViewportSize({width,height:950});
      await page.goto(baseUrl+'/#progress/boardgamegeek');
      await page.waitForSelector('.year-toggle');
      assert.equal(await page.locator('[role=tab]').count(),2);
      await page.locator('[data-progress-year="2025"]').click();
      assert.equal(await page.locator('#year-detail-2025 .pipeline-scope').count(),2);
      const original=await page.locator('#year-detail-2025').textContent();
      await page.locator('[data-progress-source="kanare_abstract"]').click();
      await page.waitForSelector('.source-metric');
      assert.equal(await page.locator('#breadcrumb').textContent(),'Avanzamento');
      assert.equal(await page.locator('[data-nav="progress"]').getAttribute('aria-current'),'page');
      assert.deepEqual(await page.locator('.source-metric button strong').allTextContents(),['76/76 · 100%','62/64 · 97%','3/3 · 100%','—']);
      assert.equal(await page.locator('[data-kanare-game]').count(),64);
      await page.screenshot({path:`outputs/multisource-progress/kanare-${width}.png`,fullPage:true});
      await page.screenshot({path:`outputs/multisource-progress/overview-${width}.png`});
      await page.locator('[data-kanare-metric="materials"]').click();
      assert.equal(await page.locator('[data-kanare-game]').count(),2);
      assert.match(await page.locator('#kanare-progress-results').textContent(),/Candy Chain/);
      assert.match(await page.locator('#kanare-progress-results').textContent(),/Swarm/);
      await page.locator('[data-kanare-game]').first().click();
      assert.equal(await page.locator('[data-kanare-game]').first().getAttribute('aria-expanded'),'true');
      await page.locator('#kanare-progress-reset').click();
      await page.locator('#kanare-progress-search').fill('Pentwall');
      assert.equal(await page.locator('[data-kanare-game]').count(),1);
      await page.locator('#refresh').click();
      await page.waitForFunction(()=>!document.querySelector('#refresh').disabled);
      assert.equal(await page.locator('#kanare-progress-search').inputValue(),'Pentwall');
      assert.equal(await page.locator('[data-kanare-game]').count(),1);
      await page.locator('[data-kanare-game]').click();
      const detail=page.locator('tr[id^="kanare-detail-"]:not([hidden])');
      assert.match(await detail.textContent(),/plancia|stampa/i);
      assert.match(await detail.textContent(),/Pentwall_EN.pdf/);
      await page.screenshot({path:`outputs/multisource-progress/detail-${width}.png`});
      await page.locator('[data-kanare-metric="acquisition"]').click();
      assert.equal(await page.locator('[data-kanare-game]').count(),3);
      await page.locator('[data-kanare-metric="image"]').click();
      assert.equal(await page.locator('[data-kanare-game]').count(),0);
      await page.locator('[data-kanare-metric="census"]').click();
      assert.equal(await page.locator('#kanare-progress-results tbody tr').count(),76);
      await page.locator('[data-kanare-view="products"]').click();
      assert.equal(await page.locator('#kanare-progress-results tbody tr').count(),39);
      assert.match(await page.locator('#kanare-progress-results').textContent(),/Nessun gioco collegato/);
      await page.locator('[data-kanare-identities]').click();
      assert.equal(await page.locator('[data-kanare-game]').count(),15);
      await page.locator('#kanare-progress-reset').click();
      await page.locator('[data-progress-source="boardgamegeek"]').click();
      await page.waitForSelector('.year-toggle');
      assert.equal(await page.locator('#year-detail-2025').textContent(),original);
      assert.equal(await page.locator('[data-progress-year="2025"]').getAttribute('aria-expanded'),'true');
      await page.locator('[data-progress-source="boardgamegeek"]').focus();
      await page.keyboard.press('ArrowRight');
      await page.waitForSelector('.source-metric');
      await page.waitForFunction(()=>document.activeElement?.dataset?.progressSource==='kanare_abstract');
      assert.equal(await page.locator('[role=tab][aria-selected=true]').textContent(),'Kanare');
      assert.equal(await page.evaluate(()=>document.documentElement.scrollWidth>innerWidth),false);
      // Registered evidence reloads; source, filters and BGG year remain independent.
      await page.reload();
      await page.waitForSelector('.source-metric');
      assert.equal(await page.locator('[role=tab][aria-selected=true]').textContent(),'Kanare');
      console.log(JSON.stringify({width,tabs:true,filters:true,details:true,packages:true,keyboard:true,overflow:false}));
    }
    assert.deepEqual(errors,[]);
    assert.deepEqual(external,[]);
  } finally {await browser.close();}
})().catch(e=>{console.error(e);process.exitCode=1;});
