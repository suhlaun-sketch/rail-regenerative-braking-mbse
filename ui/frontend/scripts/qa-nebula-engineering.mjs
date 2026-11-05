import {chromium} from 'playwright-core'
import {mkdir,writeFile} from 'node:fs/promises'
import path from 'node:path'

const project=path.resolve(import.meta.dirname,'../../..'),outDir=path.join(project,'reports','assets')
await mkdir(outDir,{recursive:true})
const browser=await chromium.launch({headless:true,executablePath:'C:/Program Files/Google/Chrome/Application/chrome.exe',args:['--enable-webgl','--ignore-gpu-blocklist']})
const page=await browser.newPage({viewport:{width:1600,height:900},deviceScaleFactor:1})
const consoleErrors=[],pageErrors=[],requestFailures=[]
page.on('console',m=>{if(m.type()==='error')consoleErrors.push(m.text())})
page.on('pageerror',e=>pageErrors.push(e.message))
page.on('requestfailed',r=>requestFailures.push(`${r.method()} ${r.url()} ${r.failure()?.errorText||''}`))

await page.goto('http://127.0.0.1:5173/knowledge-graph/nebula-engineering',{waitUntil:'networkidle',timeout:120000})
await page.waitForFunction(()=>document.querySelector('.nek-query header span')?.textContent==='CONNECTED',{timeout:30000})
await page.locator('.nek-query input').fill('常用制动平均减速度需求')
await page.locator('.nek-query form button').first().click()
await page.waitForFunction(()=>document.querySelector('.nek-query form button')?.textContent==='查询主链'&&document.querySelectorAll('.nek-result-grid>div:first-child button').length>4,{timeout:120000})
await page.waitForTimeout(800)

const main=await page.evaluate(()=>{
  const host=document.querySelector('[data-nebula-native]'),diag=host.__nebulaController.getDiagnostics(),nodes=[...document.querySelectorAll('.nek-result-grid>div:first-child button')]
  return {fixture:host.dataset.fixture,diagnostics:diag,nodeCount:nodes.length,types:[...new Set(nodes.map(n=>n.querySelector('small')?.textContent))],logical:[...document.querySelectorAll('.nek-layer-strip span')].find(x=>x.textContent.includes('Logical'))?.textContent,sceneLabels:host.shadowRoot.querySelectorAll('.wt[data-node-id]:not([data-node-id=""])').length}
})
await page.screenshot({path:path.join(outDir,'nebula_engineering_real_query_1600x900.png')})

const sceneLabel=page.locator('[data-nebula-native]').locator('.wt[data-node-id]:not([data-node-id=""])').first()
await sceneLabel.click({timeout:15000,force:true})
await page.waitForFunction(()=>Boolean(document.querySelector('.nek-evidence .nek-detail>code')?.textContent),{timeout:10000})
const sceneNodeClick=await page.locator('.nek-evidence .nek-detail>code').textContent()

const pickedProduct=await page.evaluate(()=>{
  const buttons=[...document.querySelectorAll('.nek-result-grid>div:first-child button')],button=buttons.find(b=>b.querySelector('small')?.textContent==='Product');button?.click();return button?.querySelector('code')?.textContent||''
})
if(!pickedProduct)throw new Error('Expected a real Product reached from the Requirement chain')
await page.locator('.nek-controls button').filter({hasText:'反向追溯'}).click()
await page.waitForFunction(()=>document.querySelector('.nek-query form button')?.textContent==='查询主链'&&!document.querySelector('.nek-error'),{timeout:120000})
const reverse=await page.evaluate(()=>({nodes:document.querySelectorAll('.nek-result-grid>div:first-child button').length,relations:[...document.querySelectorAll('.nek-result-grid>div:last-child button span')].map(x=>x.textContent),selected:document.querySelector('.nek-evidence .nek-detail>code')?.textContent}))

await page.locator('.nek-controls button').filter({hasText:'邻居展开'}).click()
await page.waitForFunction(()=>document.querySelector('.nek-query form button')?.textContent==='查询主链'&&!document.querySelector('.nek-error'),{timeout:120000})
const neighbors=await page.evaluate(()=>({nodes:document.querySelectorAll('.nek-result-grid>div:first-child button').length,edges:document.querySelectorAll('.nek-result-grid>div:last-child button').length}))

const edgeButton=page.locator('.nek-result-grid>div:last-child button').first();await edgeButton.click()
const evidence=await page.evaluate(()=>({relation:document.querySelector('.nek-evidence h2')?.textContent,id:document.querySelector('.nek-evidence .nek-detail>code')?.textContent,rows:[...document.querySelectorAll('.nek-evidence dt')].map(x=>x.textContent)}))

await page.locator('.nek-query form button').first().click();await page.waitForSelector('.nek-query form button:nth-child(3)',{timeout:10000});await page.locator('.nek-query form button:nth-child(3)').click();await page.waitForTimeout(500)
const cancelled=await page.evaluate(()=>({busy:document.querySelector('.nek-query form button')?.textContent,error:document.querySelector('.nek-error')?.textContent||'',lastLog:[...document.querySelectorAll('.nek-result-grid button')].length}))
await page.screenshot({path:path.join(outDir,'nebula_engineering_interaction_1600x900.png')})

const finalDiag=await page.evaluate(()=>document.querySelector('[data-nebula-native]').__nebulaController.getDiagnostics())
const result={main,sceneNodeClick,pickedProduct,reverse,neighbors,evidence,cancelled,finalDiag,consoleErrors,pageErrors,requestFailures,
  passed:main.fixture==='false'&&main.diagnostics.state.phase==='engineering'&&main.diagnostics.state.engineeringNodes>0&&main.diagnostics.state.engineeringEdges>0&&main.sceneLabels>0&&main.logical.includes('0')&&(main.types.includes('PhysicalNet')||main.types.includes('ExternalBoundary'))&&Boolean(pickedProduct)&&reverse.relations.includes('TRACE_TO_FUNCTION')&&reverse.relations.includes('ALLOCATED_TO')&&neighbors.nodes<=36&&Boolean(evidence.id)&&evidence.rows.length>0&&cancelled.busy==='查询主链'&&!cancelled.error&&consoleErrors.length===0&&pageErrors.length===0&&requestFailures.length===0}
await writeFile(path.join(outDir,'nebula_engineering_qa.json'),JSON.stringify(result,null,2),'utf8')
console.log(JSON.stringify({passed:result.passed,main:{nodes:main.nodeCount,types:main.types,sceneLabels:main.sceneLabels,engineeringNodes:main.diagnostics.state.engineeringNodes,engineeringEdges:main.diagnostics.state.engineeringEdges},sceneNodeClick,pickedProduct,reverse:{nodes:reverse.nodes,relations:[...new Set(reverse.relations)]},neighbors,evidence,cancelled,render:finalDiag.render,fps:finalDiag.fps,errors:{console:consoleErrors.length,page:pageErrors.length,requests:requestFailures.length}},null,2))
await browser.close();if(!result.passed)process.exitCode=1
