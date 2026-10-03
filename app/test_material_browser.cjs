// Edge headless opzionale: avviare prima prepare_material_browser_fixtures.py.
const assert=require('node:assert/strict');
const path=require('node:path');
const {chromium}=require(process.env.PNP_PLAYWRIGHT||'C:/Users/39348/.cache/codex-runtimes/codex-primary-runtime/dependencies/node/node_modules/playwright');
(async()=>{
  const browser=await chromium.launch({headless:true,channel:'msedge'});
  try{
    const page=await browser.newPage();const errors=[],external=[];
    page.on('pageerror',e=>errors.push(e.message));
    page.on('request',r=>{if(!r.url().startsWith('http://127.0.0.1:8774/')&&!r.url().startsWith('blob:'))external.push(r.url());});
    for(const width of [1400,390]){
      await page.setViewportSize({width,height:900});
      await page.goto('http://127.0.0.1:8774/#library');
      await page.waitForSelector('.file-icon');
      await page.locator('#library-query').fill('');
      assert.equal(await page.locator('#library-results tbody tr').count(),50);
      assert.equal(await page.locator('#library-results tbody tr').first().locator('.library-file').count(),4);
      await page.locator('#library-next').click();
      assert.equal(await page.locator('#library-results tbody tr').count(),2);
      await page.locator('#library-query').fill('rules.docx');
      assert.equal(await page.locator('#library-results tbody tr').count(),1);
      assert.equal(await page.locator('.library-file').count(),1);
      const icon=page.locator('.file-icon');await icon.focus();await page.keyboard.press('Enter');
      await page.waitForFunction(()=>document.querySelector('[data-material-status]')?.textContent==='Documento pronto.');
      assert.match(await page.locator('[data-material-content]').innerText(),/<script>test<\/script>/);
      assert.equal(await page.locator('[data-material-content] script').count(),0);
      assert.equal(await page.locator('[data-material-content] td').innerText(),'Cella');
      await page.screenshot({path:path.join('outputs/app005-browser',`docx-${width}.png`),fullPage:true});
      for(const [kind,id] of [['png',1],['pdf',3]]){
        await page.goto(`http://127.0.0.1:8774/#${kind}/${id}/library`);
        await page.waitForFunction(kind=>kind==='pdf'?document.querySelector('[data-pdf-status]')?.textContent.startsWith('Pagina 1 di'):document.querySelector('[data-material-status]')?.textContent==='Documento pronto.',kind);
        assert.equal(await page.evaluate(()=>document.documentElement.scrollWidth>innerWidth),false,`${kind} ${width} overflow`);
        await page.screenshot({path:path.join('outputs/app005-browser',`${kind}-${width}.png`),fullPage:true});
      }
      await page.goto('http://127.0.0.1:8774/#library');
      await page.locator('#library-query').fill('unsupported');
      await page.locator('.file-icon').focus();await page.keyboard.press('Enter');
      assert.equal(await page.locator('.library-file details').getAttribute('open'),'');
      assert.equal(await page.evaluate(()=>document.documentElement.scrollWidth>innerWidth),false,'library overflow');
      await page.screenshot({path:path.join('outputs/app005-browser',`library-${width}.png`),fullPage:true});
      console.log(JSON.stringify({width,pagination:'50+2 games',filter:'single file',keyboard:true,pdf:true,png:true,docx:true,overflow:false}));
    }
    assert.deepEqual(errors,[]);assert.deepEqual(external,[]);
  }finally{await browser.close();}
})().catch(error=>{console.error(error);process.exitCode=1;});
