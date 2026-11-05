import {chromium} from 'playwright-core'
import {mkdir,writeFile} from 'node:fs/promises'
import path from 'node:path'

const project=path.resolve(import.meta.dirname,'../../..'),outDir=path.join(project,'reports','assets','nebula_workbench_stages')
await mkdir(outDir,{recursive:true})
const browser=await chromium.launch({headless:true,executablePath:'C:/Program Files/Google/Chrome/Application/chrome.exe',args:['--enable-webgl','--ignore-gpu-blocklist']})
const page=await browser.newPage({viewport:{width:1600,height:900},deviceScaleFactor:1})
const consoleErrors=[],pageErrors=[],requestFailures=[]
page.on('console',message=>{if(message.type()==='error')consoleErrors.push(message.text())})
page.on('pageerror',error=>pageErrors.push(error.message))
page.on('requestfailed',request=>requestFailures.push(request.method()+' '+request.url()+' '+(request.failure()?.errorText||'')))
await page.goto('http://127.0.0.1:5173/knowledge-graph/nebula-engineering',{waitUntil:'networkidle',timeout:120000})
await page.waitForFunction(()=>document.querySelector('.nek-status b')?.textContent==='CONNECTED',{timeout:30000})
await page.locator('.nek-topbar input').fill('常用制动平均减速度需求')
await page.locator('.nek-topbar form button').first().click()
await page.waitForFunction(()=>document.querySelector('.nek-stage-caption b')?.textContent==='输入指令'&&document.querySelectorAll('.nek-group-list article button').length>5,{timeout:120000})
await page.screenshot({path:path.join(outDir,'00_query_ready.png')})

const stageData=[]
const capture=async(index,name)=>{
  await page.waitForFunction(expected=>document.querySelector('.nek-stage-caption small')?.textContent?.includes('阶段 '+String(expected).padStart(2,'0')),index,{timeout:90000})
  await page.waitForTimeout(1000)
  const data=await page.evaluate(()=>{const host=document.querySelector('[data-nebula-native]'),diag=host.__nebulaController.getDiagnostics();return {stage:document.querySelector('.nek-stage-caption b')?.textContent,caption:document.querySelector('.nek-stage-caption span')?.textContent,counts:document.querySelector('.nek-stage-caption em')?.textContent,diag,corner:document.querySelector('.nek-corner')?.textContent}})
  stageData.push(data);await page.screenshot({path:path.join(outDir,String(index).padStart(2,'0')+'_'+name+'.png')})
}
await page.locator('.nek-toolbar button').filter({hasText:'自动演示'}).click()
await capture(1,'requirement')
await page.waitForFunction(()=>document.querySelector('.nek-stage-caption b')?.textContent==='关联功能',{timeout:90000})
await page.locator('.nek-toolbar button').filter({hasText:'暂停'}).click()
const pausedBefore=await page.locator('.nek-stage-caption em').textContent();await page.waitForTimeout(1400);const pausedAfter=await page.locator('.nek-stage-caption em').textContent()
await page.locator('.nek-toolbar button').filter({hasText:'继续'}).click()
await capture(2,'function')
await capture(3,'architecture')
await capture(4,'interface')
await capture(5,'signal')
await capture(6,'complete')
await page.waitForTimeout(3500)

await page.locator('.nek-toolbar button').filter({hasText:'上一步'}).click()
const previousStage=await page.locator('.nek-stage-caption b').textContent()
await page.locator('.nek-toolbar button').filter({hasText:'下一步'}).click()
const nextStage=await page.locator('.nek-stage-caption b').textContent()
await page.locator('.nek-toolbar button').filter({hasText:'重播'}).click()
await page.waitForFunction(()=>document.querySelector('.nek-stage-caption b')?.textContent==='需求检索',{timeout:10000})
await page.locator('.nek-toolbar button').filter({hasText:'暂停'}).click()

await page.locator('canvas.gl').hover();await page.mouse.wheel(0,150);await page.waitForTimeout(250)
const manualMode=await page.locator('.nek-corner').textContent()
await page.locator('.nek-toolbar button').filter({hasText:'查询全貌'}).click();await page.waitForTimeout(600)
const queryOverview=await page.locator('.nek-stage-caption b').textContent()

const firstNode=page.locator('.nek-group-list article button').first();await firstNode.click();await page.waitForSelector('.nek-inspector.open .nek-inspector-body h2')
const nodeEvidence=await page.evaluate(()=>({name:document.querySelector('.nek-inspector-body h2')?.textContent,id:document.querySelector('.nek-inspector-body code')?.textContent,rows:[...document.querySelectorAll('.nek-inspector-body dt')].map(x=>x.textContent)}))
const firstEdge=page.locator('.nek-relations>button').first();await firstEdge.click()
const relationEvidence=await page.evaluate(()=>({type:document.querySelector('.nek-inspector-body h2')?.textContent,id:document.querySelector('.nek-inspector-body code')?.textContent,rows:[...document.querySelectorAll('.nek-inspector-body dt')].map(x=>x.textContent)}))

const productButton=page.locator('.nek-group-list article').filter({hasText:'承接架构'}).locator('button').first();await productButton.click()
await page.locator('.nek-mode-switch button').filter({hasText:'反向追溯'}).click()
await page.waitForFunction(()=>document.querySelector('.nek-stage-caption b')?.textContent==='输入指令'&&!document.querySelector('.nek-error'),{timeout:120000})
const reverseReady=await page.locator('.nek-results>header span').textContent()
await page.locator('.nek-group-list article').filter({hasText:'承接架构'}).locator('button').first().click()
await page.locator('.nek-mode-switch button').filter({hasText:'邻居展开'}).click()
await page.waitForFunction(()=>document.querySelector('.nek-stage-caption b')?.textContent==='输入指令'&&!document.querySelector('.nek-error'),{timeout:120000})
const neighborsReady=await page.locator('.nek-results>header span').textContent()

await page.locator('.nek-topbar form button').first().click();await page.waitForSelector('.nek-topbar form button:nth-child(3)',{timeout:10000});await page.locator('.nek-topbar form button:nth-child(3)').click();await page.waitForTimeout(500)
const cancelled=!await page.locator('.nek-topbar form button:nth-child(3)').count()
const finalDiag=await page.evaluate(()=>document.querySelector('[data-nebula-native]').__nebulaController.getDiagnostics())
await page.screenshot({path:path.join(outDir,'07_interaction_evidence.png')})
const unexpectedFailures=requestFailures.filter(item=>!item.includes('net::ERR_ABORTED'))
const result={pausedStable:pausedBefore===pausedAfter,previousStage,nextStage,manualMode,queryOverview,nodeEvidence,relationEvidence,reverseReady,neighborsReady,cancelled,stageData,finalDiag,consoleErrors,pageErrors,requestFailures,unexpectedFailures}
result.passed=result.pausedStable&&previousStage==='参数与信号'&&nextStage==='完整路径'&&manualMode.includes('自由探索')&&queryOverview==='完整路径'&&Boolean(nodeEvidence.id)&&Boolean(relationEvidence.id)&&cancelled&&stageData.length===6&&stageData.every(item=>item.diag.state.crawlerVisible===false&&item.diag.state.agentHudVisible===false)&&stageData[1].diag.state.engineeringNodes>1&&consoleErrors.length===0&&pageErrors.length===0&&unexpectedFailures.length===0
await writeFile(path.join(project,'reports','assets','nebula_engineering_workbench_qa.json'),JSON.stringify(result,null,2),'utf8')
console.log(JSON.stringify({passed:result.passed,pausedStable:result.pausedStable,stages:stageData.map(item=>[item.stage,item.counts]),previousStage,nextStage,manualMode,queryOverview,nodeEvidence,relationEvidence,reverseReady,neighborsReady,cancelled,render:finalDiag.render,fps:finalDiag.fps,crawlerVisible:finalDiag.state.crawlerVisible,agentHudVisible:finalDiag.state.agentHudVisible,errors:{console:consoleErrors.length,page:pageErrors.length,requests:requestFailures.length}},null,2))
await browser.close();if(!result.passed)process.exitCode=1
