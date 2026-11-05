import {chromium} from 'playwright-core'
import {readFile} from 'node:fs/promises'
import path from 'node:path'
const project=path.resolve(import.meta.dirname,'../../..')
const oldPath=path.join(project,'reports','assets','nebula_engineering_real_query_1600x900.png')
const newPath=path.join(project,'reports','assets','nebula_workbench_stages','06_complete.png')
const data=async file=>'data:image/png;base64,'+(await readFile(file)).toString('base64')
const browser=await chromium.launch({headless:true,executablePath:'C:/Program Files/Google/Chrome/Application/chrome.exe'})
const page=await browser.newPage({viewport:{width:1600,height:900},deviceScaleFactor:1})
const oldImage=await data(oldPath),newImage=await data(newPath)
await page.setContent('<style>*{box-sizing:border-box}body{margin:0;background:#02050a;color:#eaf2f5;font-family:Microsoft YaHei,sans-serif;padding:24px}header{height:72px}h1{font-size:25px;margin:0 0 8px}p{margin:0;color:#8399a3}.grid{display:grid;grid-template-columns:1fr 1fr;gap:18px}.card{border:1px solid #28414c;background:#071018;padding:10px}.card h2{font-size:15px;margin:0 0 9px}.card img{display:block;width:100%;height:650px;object-fit:contain;background:#000}.old h2{color:#9990ba}.new h2{color:#84ad96}footer{display:flex;justify-content:center;gap:36px;padding-top:20px;color:#9eb0b7;font-size:13px}footer b{color:#d9e7ea}</style><header><h1>工程知识图谱 UI 融合对比</h1><p>同一真实查询：常用制动平均减速度需求 · 1600×900 浏览器基线</p></header><div class=grid><section class="card old"><h2>改造前 · Agent HUD 与密集查询日志</h2><img src="'+oldImage+'"></section><section class="card new"><h2>融合版 · 工程阶段、精简结果与按需证据</h2><img src="'+newImage+'"></section></div><footer><span><b>视觉：</b>保留原生粒子、轨道与镜头</span><span><b>信息：</b>真实工程类型与中文语义</span><span><b>交互：</b>六阶段播放、暂停、追溯、自由探索</span></footer>')
await page.screenshot({path:path.join(project,'reports','assets','nebula_engineering_ui_comparison.png')})
await browser.close()
