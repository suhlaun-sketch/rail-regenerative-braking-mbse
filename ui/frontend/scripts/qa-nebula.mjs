import {chromium} from 'playwright-core'
import {mkdir,writeFile} from 'node:fs/promises'
import path from 'node:path'

const root=path.resolve(import.meta.dirname,'../../..')
const outDir=path.join(root,'reports','assets')
await mkdir(outDir,{recursive:true})
const browser=await chromium.launch({
  headless:true,
  executablePath:'C:/Program Files/Google/Chrome/Application/chrome.exe',
  args:['--enable-webgl','--ignore-gpu-blocklist']
})
const page=await browser.newPage({viewport:{width:1600,height:900},deviceScaleFactor:1})
const consoleErrors=[]
const pageErrors=[]
const requestFailures=[]
page.on('console',msg=>{if(msg.type()==='error')consoleErrors.push(msg.text())})
page.on('pageerror',error=>pageErrors.push(error.message))
page.on('requestfailed',request=>requestFailures.push(`${request.method()} ${request.url()} ${request.failure()?.errorText||''}`))

await page.goto('http://127.0.0.1:5173/knowledge-graph/nebula-native',{waitUntil:'networkidle',timeout:120000})
await page.waitForSelector('[data-nebula-native]',{timeout:60000})
await page.waitForFunction(()=>{
  const host=document.querySelector('[data-nebula-native]')
  return Boolean(host?.shadowRoot?.querySelector('canvas.gl')&&host.__nebulaController?.getDiagnostics()?.render)
},{timeout:60000})
await page.waitForTimeout(900)
await page.screenshot({path:path.join(outDir,'nebula_native_port_1600x900.png')})

const structure=await page.evaluate(()=>{
  const host=document.querySelector('[data-nebula-native]'),root=host.shadowRoot
  return {
    fixture:host.dataset.fixture,
    canvas:root.querySelectorAll('canvas.gl').length,
    clusters:root.querySelectorAll('.cl').length,
    core:root.querySelectorAll('.core').length,
    panels:root.querySelectorAll('section.dp').length,
    orbitLabels:[...root.querySelectorAll('.cl b')].map(x=>x.textContent),
    diagnostics:host.__nebulaController.getDiagnostics(),
  }
})

await page.waitForTimeout(9000)

const fpsSamples=[]
for(let i=0;i<6;i++){
  await page.waitForTimeout(1000)
  fpsSamples.push(await page.evaluate(()=>document.querySelector('[data-nebula-native]').__nebulaController.getDiagnostics().fps))
}

const hostBox=await page.locator('[data-nebula-native]').boundingBox()
if(!hostBox)throw new Error('NEBULA host has no bounding box')
await page.mouse.move(hostBox.x+800,hostBox.y+440)
await page.mouse.down()
await page.mouse.move(hostBox.x+940,hostBox.y+500,{steps:12})
await page.mouse.up()
await page.mouse.wheel(0,-420)
await page.waitForTimeout(800)
await page.evaluate(()=>document.querySelector('[data-nebula-native]').__nebulaController.focus('scout'))
await page.waitForTimeout(1600)
const focusButton=await page.evaluate(()=>document.querySelector('[data-nebula-native]').shadowRoot.querySelector('[data-f="mode"]').textContent)
await page.evaluate(()=>document.querySelector('[data-nebula-native]').__nebulaController.dispatch({type:'relation',sourceId:'scout',targetId:'design',color:'#62e3ff'}))
await page.waitForTimeout(500)
await page.screenshot({path:path.join(outDir,'nebula_native_port_focused_1600x900.png')})

const lifecycle=[]
for(let i=0;i<5;i++){
  await page.evaluate(()=>{
    const host=document.querySelector('[data-nebula-native]')
    window.__qaNebulaController=host.__nebulaController
    history.pushState({},'',`/nebula-unmount-check-${Date.now()}`)
    dispatchEvent(new PopStateEvent('popstate'))
  })
  await page.waitForFunction(()=>!document.querySelector('[data-nebula-native]'),{timeout:30000})
  lifecycle.push(await page.evaluate(()=>window.__qaNebulaController.getDiagnostics()))
  await page.evaluate(()=>{
    history.pushState({},'','/knowledge-graph/nebula-native')
    dispatchEvent(new PopStateEvent('popstate'))
  })
  await page.waitForFunction(()=>document.querySelector('[data-nebula-native]')?.__nebulaController?.getDiagnostics()?.render,{timeout:60000})
  await page.waitForTimeout(500)
}

const finalState=await page.evaluate(()=>{
  const hosts=[...document.querySelectorAll('[data-nebula-native]')]
  return {hosts:hosts.length,canvases:hosts.reduce((n,h)=>n+(h.shadowRoot?.querySelectorAll('canvas.gl').length||0),0),diagnostics:hosts[0]?.__nebulaController?.getDiagnostics()||null}
})
const result={
  url:page.url(),viewport:{width:1600,height:900},structure,focusButton,
  fpsSamples,fpsAverage:Number((fpsSamples.reduce((a,b)=>a+b,0)/fpsSamples.length).toFixed(1)),
  lifecycle,finalState,consoleErrors,pageErrors,requestFailures,
  passed:structure.canvas===1&&structure.clusters===12&&structure.core===1&&structure.panels===6&&focusButton==='返回'&&lifecycle.every(x=>x.disposed===true)&&finalState.hosts===1&&finalState.canvases===1&&consoleErrors.length===0&&pageErrors.length===0&&requestFailures.length===0
}
await writeFile(path.join(outDir,'nebula_native_qa.json'),JSON.stringify(result,null,2),'utf8')
console.log(JSON.stringify({passed:result.passed,draw:structure.diagnostics.render,memory:structure.diagnostics.memory,webgl:structure.diagnostics.webgl,gpu:structure.diagnostics.gpu,fpsAverage:result.fpsAverage,lifecycleDisposed:lifecycle.map(x=>x.disposed),final:{hosts:finalState.hosts,canvases:finalState.canvases},consoleErrors:consoleErrors.length,pageErrors:pageErrors.length,requestFailures:requestFailures.length},null,2))
await browser.close()
if(!result.passed)process.exitCode=1
