// @ts-nocheck
// Source-derived NEBULA renderer. See src/vendor/agent-display/NOTICE.md.
import * as Three from 'three'
import {EffectComposer} from 'three/examples/jsm/postprocessing/EffectComposer.js'
import {RenderPass} from 'three/examples/jsm/postprocessing/RenderPass.js'
import {UnrealBloomPass} from 'three/examples/jsm/postprocessing/UnrealBloomPass.js'
import {mountShadowTemplate} from '../shared/shadowHost'
import {nebulaMarkup} from './nebulaTemplate'
import {nebulaStyles} from './nebulaStyles'
import type {NebulaRendererOptions,NebulaSceneController} from './nebulaTypes'

const THREE_COMPAT = {...Three, EffectComposer, RenderPass, UnrealBloomPass}

export function createNebulaRenderer(host: HTMLElement, options: NebulaRendererOptions = {}): NebulaSceneController {
  const shadowRoot = mountShadowTemplate(host, nebulaStyles, nebulaMarkup)
  return mountNebulaRuntime(host, shadowRoot, options) as NebulaSceneController
}

function mountNebulaRuntime(host, SR, options){
'use strict';

const listeners = [];
const intervals = new Set();
const timeouts = new Set();
let resizeObserver = null;
let rafId = 0;
let disposed = false;
const listen = (target, type, handler, opts) => { target.addEventListener(type, handler, opts); listeners.push([target, type, handler, opts]); };
const scheduleFrame = cb => { if (!disposed) rafId = requestAnimationFrame(cb); };
const scheduleTimeout = (cb, ms) => { const id = window.setTimeout(() => { timeouts.delete(id); if (!disposed) cb(); }, ms); timeouts.add(id); return id; };
const scheduleInterval = (cb, ms) => { const id = window.setInterval(() => { if (!disposed) cb(); }, ms); intervals.add(id); return id; };

/* ================= 0. 工具 ================= */
const $ = s => SR.querySelector(s), $$ = s => SR.querySelectorAll(s);
const TAU = Math.PI * 2, HP = Math.PI / 2;
const rnd = (a, b) => a + Math.random() * (b - a);
const pick = a => a[(Math.random() * a.length) | 0];
const clamp = (v, a, b) => v < a ? a : v > b ? b : v;
const lerp = (a, b, t) => a + (b - a) * t;
const pad = (n, w = 2) => String(n).padStart(w, '0');
const fmt = n => Math.round(n).toLocaleString('en-US');
const hms = d => `${pad(d.getHours())}:${pad(d.getMinutes())}:${pad(d.getSeconds())}`;
const hex3 = h => { const n = parseInt(h.slice(1), 16); return [(n >> 16 & 255) / 255, (n >> 8 & 255) / 255, (n & 255) / 255]; };
const ease2 = u => u < .5 ? 2 * u * u : 1 - Math.pow(-2 * u + 2, 2) / 2;
const shuffle = a => { for (let i = a.length - 1; i > 0; i--) { const j = (Math.random() * (i + 1)) | 0; [a[i], a[j]] = [a[j], a[i]]; } return a; };
function mulberry32(a){ return function(){ a |= 0; a = a + 0x6D2B79F5 | 0; let t = Math.imul(a ^ a >>> 15, 1 | a); t = t + Math.imul(t ^ t >>> 7, 61 | t) ^ t; return ((t ^ t >>> 14) >>> 0) / 4294967296; }; }
const rng = mulberry32(20261023);
const gauss = () => { let u = 0, v = 0; while (u === 0) u = rng(); v = rng(); return Math.sqrt(-2 * Math.log(u)) * Math.cos(TAU * v); };
const angLerp = (a, b, t) => { let d = (b - a) % TAU; if (d > Math.PI) d -= TAU; if (d < -Math.PI) d += TAU; return a + d * t; };
const minsToday = () => { const d = new Date(); return d.getHours() * 60 + d.getMinutes(); };

/* ================= 1. 配置：和前几款同一套智能体 / 工作流（换成你自己的即可） ================= */
// words = 这个工区的需求里常见的词；颜色换成星云色
const AG = [
  {k:'CHIEF',  zh:'总调度', role:'只拆不干，答疑拍板',   col:'#f4f7ff'},
  {k:'SCOUT',  zh:'检索',   role:'读全网，找资料',       col:'#7cc8ff', words:['竞品', '关键词', '热点', '数据源', '行业报告', '对标账号', '用户画像', '搜索量', '爆款样本', '评论区', '价格带', '渠道', '季节性', '舆情']},
  {k:'SPLIT',  zh:'拆解',   role:'把需求切成小块',       col:'#a093ff', words:['里程碑', '负责人', '截止日', '依赖', '子任务', '验收标准', '优先级', '风险', '交付物', '排期', '资源', '评审节点', '范围', '回滚方案']},
  {k:'COPY',   zh:'文案',   role:'脚本 · 话术 · 标书',   col:'#ff86c2', words:['卖点', '标题', '口播稿', '话术', '分镜', '字数', '语气', '结尾钩子', '开头 5 秒', '痛点', 'CTA', '人设', '金句', '标签']},
  {k:'DESIGN', zh:'设计',   role:'封面 · 海报 · 页面',   col:'#ffae80', words:['主视觉', '配色', '版式', '海报', '封面', '尺寸', '字体', '品牌色', '留白', '图标', '动效', '质感', '构图', '对比度']},
  {k:'CODE',   zh:'代码',   role:'页面 · 接口 · 脚本',   col:'#49e3f2', words:['接口', '页面', '部署', '埋点', '表单', '缓存', '回滚', '域名', '鉴权', '日志', '限流', '数据库', '灰度', '监控']},
  {k:'TEST',   zh:'测试',   role:'跑用例，卡发版',       col:'#8ef0c4', words:['用例', '回归', '兼容性', '压测', '截图', '边界', '冒烟', '复现', '机型', '弱网', '断言', '覆盖率', '性能', '崩溃率']},
  {k:'PROOF',  zh:'审校',   role:'不过不发，打回重写',   col:'#ffd27a', words:['错别字', '敏感词', '事实核验', '合规', '品牌口径', '引用', '数据出处', '重复率', '版权', '极限词', '口径一致', '时效', '署名', '链接']},
  {k:'DATA',   zh:'数据',   role:'拉数 · 报表 · 归因',   col:'#6f8dff', words:['转化率', '留存', '漏斗', 'ROI', '周报', '归因', '样本量', '看板', '同比', '环比', 'GMV', '客单价', '复购', '口径']},
  {k:'CUT',    zh:'剪辑',   role:'切片 · 字幕 · 节奏',   col:'#ff9a6a', words:['字幕', 'BGM', '节奏', '片头', '转场', '时长', '封面帧', '口播切片', '比例', '调色', '音效', '花字', '卡点', '片尾']},
  {k:'ADS',    zh:'投放',   role:'小预算跑 AB',          col:'#e07bff', words:['人群包', '出价', '素材', '预算', '投放时段', 'AB 组', '落地页', '点击率', 'CPM', '转化目标', '地域', '定向', '冷启动', '频控']},
  {k:'CARE',   zh:'客服',   role:'评论 · 私信 · 回访',   col:'#9ee6ff', words:['话术', '退款', 'FAQ', '回访', '差评', '工单', '满意度', '安抚', '响应时长', '升级', '赔付', '标签化', '黑名单', '复购券']},
  {k:'VAULT',  zh:'归档',   role:'打标签，进知识库',     col:'#d6c4ff', words:['归档', '版本号', '备份', '权限', '交付包', '标签', '索引', '知识库', '命名规范', '归属', '有效期', '脱敏', '目录', '检索词']},
  {k:'CRAWLER',zh:'星云蛛', role:'逐字读需求，模糊就问', col:'#d8ecff'}
];
const CRAWLER = 13;
const WF = [
  {id:'W01', zh:'短视频',   path:[1,3,9,7,10],  names:['口播短视频','产品种草短视频','教程短视频']},
  {id:'W02', zh:'落地页',   path:[2,4,5,6,7],   names:['落地页改版','活动页上线','官网首页']},
  {id:'W03', zh:'投标文件', path:[1,2,3,7,12],  names:['投标文件生成','技术方案标书','资质材料整理']},
  {id:'W04', zh:'周报',     path:[8,3,7,12],    names:['周报数据汇总','月度经营复盘','客户报表']},
  {id:'W05', zh:'广告素材', path:[4,10,8],      names:['广告素材测试','信息流素材','投放 AB 组']},
  {id:'W06', zh:'私域话术', path:[11,3,7],      names:['私域话术更新','社群活动文案','回访话术']},
  {id:'W07', zh:'发版',     path:[5,6,12],      names:['发版检查','接口联调','热修复']},
  {id:'W08', zh:'用户反馈', path:[11,8,2],      names:['用户反馈聚类','差评归因','需求池整理']},
  {id:'W09', zh:'直播切片', path:[9,7,10],      names:['直播切片','直播高光','回放剪辑']},
  {id:'W10', zh:'知识库',   path:[1,12],        names:['知识库更新','竞品资料检索','行业报告收集']},
  {id:'W11', zh:'封面图',   path:[4,7],         names:['封面图六版','海报设计','详情页主图']}
];
// 模糊词 → 问完 CHIEF 之后补成的具体要求
const VAGUE = [['尽快', '周五 18:00 前'], ['大概', '误差 ±5%'], ['高级感', '黑金 + 大留白'], ['优化一下', '首屏 < 1.5s'], ['差不多', '对齐竞品 A'], ['适当', '每屏 ≤ 3 个卖点'],
  ['等等', '只要这 4 项'], ['看着办', '按 B 方案'], ['爆款', '完播 > 35%'], ['年轻化', '18–25 岁'], ['简洁点', '≤ 120 字'], ['多弄几版', '3 版'], ['醒目', '主色 #FF6FAE'],
  ['尽量', '必须'], ['可能要', '确认：要'], ['后面再说', '本周内'], ['大气', '全屏主图'], ['有质感', '实拍 + 暗调']];
const PASS = 80;
const AXES = ['完整', '可执行', '可度量', '负责人', '截止', '无歧义', '可验收'];
const AGC = AG.map(a => hex3(a.col));
const S = .44;
let SS = S;                                     // 当前实际缩放：趴在星核上时放大一点，免得被星核吃掉                                 // 星云蛛整体缩放

/* ================= 2. 星图布局 ================= */
// 12 团星云分在三条椭圆公转轨道上，绕着正中的 CHIEF 转（里圈快、外圈慢）；每团顺着轨道方向拉长一点。
// 每团星云有自己的局部坐标（x 顺着轨道方向），词位、星云蛛的位置都记在局部坐标里，所以会跟着星云一起公转。
const ORBITS = [{ax: 19.5, az: 11.2, n: 3, R: 4.6, T: 150}, {ax: 30, az: 16.8, n: 4, R: 5.3, T: 230}, {ax: 40.5, az: 22.4, n: 5, R: 5.8, T: 320}];
const CORE_Y = 2.2, CORE_R = 6.3;                // 星核中心高度 / 星云蛛趴的那层「球面」半径
const CL = [{core: true, x: 0, z: 0, R: CORE_R, cr: 1, sr: 0, y0: CORE_Y, top: CORE_R, cy: CORE_Y, words: []}];
{ let k = 1; ORBITS.forEach((o, oi) => { const ph = rng() * TAU; for (let j = 0; j < o.n; j++, k++) {
  const c = {orb: oi, ph: ph + j * TAU / o.n + (rng() - .5) * .3, R: o.R * (.92 + rng() * .16), y0: (rng() - .5) * .9, words: [], seed: rng() * TAU, x: 0, z: 0, cr: 1, sr: 0};
  c.top = c.R * .32; c.cy = c.y0 + c.top + .3; CL.push(c);
} }); }
let orbT = 37;
function orbitStep(){
  for (let k = 1; k <= 12; k++) {
    const c = CL[k], o = ORBITS[c.orb], f = c.ph + TAU * orbT / o.T;
    c.x = Math.cos(f) * o.ax; c.z = Math.sin(f) * o.az;
    const tx = -Math.sin(f) * o.ax, tz = Math.cos(f) * o.az, tl = Math.hypot(tx, tz);
    const rot = Math.atan2(-tz / tl, tx / tl); c.rot = rot; c.cr = Math.cos(rot); c.sr = Math.sin(rot);
  }
}
orbitStep();
// 局部 ↔ 世界（和 three.js 的 rotation.y 一致）
function anchorW(a, lx, lz, out = {}){ const c = CL[a]; out.x = c.x + lx * c.cr + lz * c.sr; out.z = c.z - lx * c.sr + lz * c.cr; out.y = surfL(c, lx, lz); return out; }
function toLocal(c, wx, wz){ const dx = wx - c.x, dz = wz - c.z; return [dx * c.cr - dz * c.sr, dx * c.sr + dz * c.cr]; }
// 表面高度：星云是一团鼓起来的云顶；星核是个球，星云蛛趴在球顶上
function surfL(c, lx, lz){
  if (c.core) return CORE_Y + Math.sqrt(Math.max(0, CORE_R * CORE_R - lx * lx - lz * lz)) * .95;
  const q = (lx / (c.R * 1.12)) ** 2 + (lz / (c.R * .9)) ** 2; return c.y0 + c.top * Math.exp(-q * 2.1);
}
function surfW(c, wx, wz){ const [lx, lz] = toLocal(c, wx, wz); return surfL(c, lx, lz); }
CL.slice(1).forEach(c => { for (let j = 0; j < 14; j++) { const ang = c.seed + j * 2.39996, rad = c.R * (.2 + .7 * Math.sqrt((j + .5) / 14)), lx = Math.cos(ang) * rad * 1.1, lz = Math.sin(ang) * rad * .85; c.words.push({lx, lz, y: surfL(c, lx, lz) + .3 + rng() * .45}); } });
const REST = {a: 0, lx: 0, lz: 3.1};               // 待命：趴在星核球面朝镜头的那一侧
// 跳进一团星云时，落在靠近来路那一侧的云顶上，然后再往里扒
const standOf = k => { const c = CL[k], [lx, lz] = toLocal(c, spider.x, spider.z), L = Math.hypot(lx / 1.1, lz / .85) || 1; return {a: k, lx: lx / L * c.R * .55, lz: lz / L * c.R * .42}; };

/* ================= 3. 模拟（接真实数据时替换这一段） ================= */
let simT = 0, animT = 0, frameN = 0, tid = 46;
let externalMode = false, engineeringState = null;
let shipped = Math.floor(minsToday() / 1.7) + 18, wordsToday = shipped * 27 + 140, fixesToday = shipped * 3 + 9;
const scoreHist = Array.from({length: 24}, () => Math.round(rnd(80, 93)));
const load = AG.map(() => rnd(.2, .8)), flash = AG.map(() => 0);
let task = null;
const crawl = {phase: 'brief', t: 0, sec: -1, wi: 0, wt: 0, ship: 0};
const logs = []; let logDirty = true;
const readTimes = [];
let codeHL = 1, codeChars = 0, capText = '—';
const jobs = [];                                // 定时小事件（快进时也按模拟时间走）
const later = (s, fn) => jobs.push({t: simT + s, fn});

function log(verb, text){
  const d = new Date();
  logs.unshift({tm: `${pad(d.getMinutes())}:${pad(d.getSeconds())}`, verb, text});
  if (logs.length > 30) logs.pop();
  logDirty = true; capText = `${verb} · ${text}`;
}
function newTask(){
  const wf = WF[(tid + 3) % WF.length];
  const vagues = shuffle(VAGUE.slice()).slice(0, wf.path.length >= 4 ? 4 + (Math.random() < .5 ? 1 : 0) : 3);
  let vi = 0;
  const sections = wf.path.map((ai, si) => {
    const n = 9 + ((Math.random() * 4) | 0);
    const ws = shuffle(AG[ai].words.slice()).slice(0, n).map(w => ({w, kind: 'ok'}));
    const nv = si === wf.path.length - 1 ? vagues.length - vi : Math.min(vagues.length - vi, Math.random() < .55 ? 1 : (Math.random() < .5 ? 2 : 0));
    for (let q = 0; q < nv && vi < vagues.length; q++, vi++) ws.splice(1 + ((Math.random() * (ws.length - 1)) | 0), 0, {w: vagues[vi][0], fix: vagues[vi][1], kind: 'vague'});
    ws.length = Math.min(ws.length, 14);
    const slots = shuffle([...Array(14).keys()]);
    ws.forEach((w, i) => Object.assign(w, {slot: slots[i], state: 'idle', sec: si, ai, f: 0}));
    return {ai, words: ws, done: false, read: 0};
  });
  tid++;
  task = {id: 'T-' + pad(tid, 3), name: pick(wf.names), wf, path: wf.path, sections, base: rnd(28, 36), score: 0, shown: 0,
          reads: 0, links: 0, flags: 0, fixes: 0, total: sections.reduce((s, x) => s + x.words.length, 0), t0: simT, hist: [], final: 0};
  task.vagueTotal = sections.reduce((s, x) => s + x.words.filter(w => w.kind === 'vague').length, 0);
  calcScore(); task.shown = task.score;
  trail.length = 0; trailFade = 1;
  log('load', `${task.id} ${task.name} · ${sections.length} 个工区 · ${task.total} 个词`);
  codeChars = 0; codeHL = 2; flash[0] = 1.2;
}
function openFlags(){ return task ? task.sections.reduce((s, x) => s + x.words.filter(w => w.state === 'flag' || w.state === 'ask').length, 0) : 0; }
function calcScore(){
  const t = task; t.score = clamp(t.base + t.reads * .36 + t.links * .7 + t.fixes * 6.2 - openFlags() * 3.2, 0, 99);
  if (t.final) t.score = t.final;
}
function curSec(){ return task && crawl.sec >= 0 && crawl.sec < task.sections.length ? task.sections[crawl.sec] : null; }
function wordPos(w, out){ const c = CL[w.ai], L = c.words[w.slot]; out = out || {}; out.x = c.x + L.lx * c.cr + L.lz * c.sr; out.z = c.z - L.lx * c.sr + L.lz * c.cr; out.y = L.y; return out; }
const cloudP = k => () => ({x: CL[k].x, y: CL[k].cy, z: CL[k].z});

const META = [['#负责人', '.p-rad'], ['#截止', '.p-rad'], ['#指标', '.p-heat'], ['#范围', '.p-sec'], ['#出处', '.p-heat'], ['#验收', '.p-rad'], ['#依赖', '.p-sec']];
function readWord(w){
  w.state = 'read'; w.f = 1; task.reads++; task.sections[w.sec].read++; wordsToday++; readTimes.push(simT);
  threadTo(w); later(.08, () => flyChip(w, 'read'));
  if (w.kind !== 'vague' && Math.random() < .42) later(.2, () => { const [tag, sel] = pick(META); flyFrom(wordPos(w), `${tag}<i>${w.w}</i>`, '#d8ecff', sel); });
  log('read', w.w); codeHL = 6;
  if (w.kind === 'vague') {
    later(.18, () => {
      w.state = 'flag'; task.flags++; log('flag', `${w.w} · 模糊`); codeHL = 8; flash[w.ai] += .4; flyChip(w, 'flag');
      later(.28, () => {
        w.state = 'ask'; log('ask', `CHIEF：「${w.w}」具体指什么？`);
        const p = () => wordPos(w);
        comet(p, CORE_P, '#ff6fae', .55, .5, () => {
          flash[0] += .8; coreSay = {t: 1.6, txt: `ANSWER · ${w.w}`};
          later(rnd(.12, .4), () => comet(CORE_P, p, '#ffd27a', .5, .5, () => {
            w.state = 'fix'; task.fixes++; fixesToday++; log('fix', `${w.w} → ${w.fix}`); codeHL = 9; flash[w.ai] += .5; flyChip(w, 'fix');
          }));
        });
      });
    });
  } else if (Math.random() < .34) {
    const nxt = task.sections[w.sec + 1];
    if (nxt) later(.1, () => { w.state = 'lnk'; task.links++; log('link', `${w.w} → ${AG[nxt.ai].k}`); codeHL = 11; flyChip(w, 'link'); comet(() => wordPos(w), cloudP(nxt.ai), '#62e3ff', .8, .38, () => { flash[nxt.ai] += .35; }); });
  }
}
function crawlStep(dt){
  crawl.t += dt;
  switch (crawl.phase) {
    case 'brief':
      if (!task) newTask();
      if (crawl.t > .25 && !crawl.stroll && !spider.air && spider.a === 0) { crawl.stroll = 1; walkTo({a: 0, lx: rnd(-1.8, 1.8), lz: rnd(2.2, 3.8)}); }
      if (crawl.t > 1.3 && !spider.walking) { crawl.stroll = 0; crawl.sec = 0; crawl.phase = 'walk'; walkTo(standOf(task.sections[0].ai), () => startRead(), true); log('walk', `→ ${AG[task.sections[0].ai].k.toLowerCase()}`); codeHL = 5; }
      break;
    case 'read': {
      const s = curSec();
      if (spider.walking || spider.air) break;
      crawl.wt -= dt;
      if (crawl.wi >= s.words.length) {
        if (crawl.wt > -.2) break;
        s.done = true; retractThreads();
        const nx = crawl.sec + 1;
        if (nx < task.sections.length) { crawl.sec = nx; crawl.phase = 'walk'; walkTo(standOf(task.sections[nx].ai), () => startRead(), true); log('walk', `→ ${AG[task.sections[nx].ai].k.toLowerCase()}`); codeHL = 5; }
        else { crawl.phase = 'return'; crawl.sec = task.sections.length; walkTo({a: 0, lx: rnd(-1.2, 1.2), lz: rnd(2.6, 3.6)}, () => { crawl.phase = 'ship'; crawl.t = 0; }, true); log('walk', '→ chief · 回星核'); codeHL = 12; }
        break;
      }
      if (crawl.wt > 0) break;
      if (crawl.batch > 0) { const w = s.words[crawl.wi++]; readWord(w); crawl.batch--; crawl.wt = w.kind === 'vague' ? .3 : .13; }
      else {
        // 换个位置：朝下一个要读的词爬过去一段，不出这团星云
        const c = CL[s.ai], nw = c.words[s.words[crawl.wi].slot];
        let lx = lerp(spider.lx, nw.lx, rnd(.45, .75)) + rnd(-.8, .8), lz = lerp(spider.lz, nw.lz, rnd(.45, .75)) + rnd(-.5, .5);
        const dd = Math.hypot(lx / (c.R * .9), lz / (c.R * .68)); if (dd > 1) { lx /= dd; lz /= dd; }
        log('crawl', `${AG[s.ai].k.toLowerCase()} · 换个位置`); codeHL = 6;
        walkTo({a: s.ai, lx, lz}, () => { crawl.batch = 4 + ((rng() * 3) | 0); crawl.wt = .06; });
      }
      break; }
    case 'ship':
      if (openFlags() > 0 && crawl.t < 6) break;
      if (!crawl.ship) {
        task.sections.forEach(s => s.words.forEach(w => { if (w.state === 'flag' || w.state === 'ask') { w.state = 'fix'; task.fixes++; fixesToday++; } }));
        calcScore(); task.final = Math.round(clamp(Math.max(task.score, PASS + rnd(1, 6)), 0, 97));
        crawl.ship = 1; shipPulse.on = true; shipPulse.d = 0; codeHL = 13; flash[0] += 1.4; coreSay = {t: 3, txt: `SHIP ✓ ${task.final}`}; deliverFx();
        log('ship', `${task.id} · 评分 ${task.final} · 派单 → ${task.path.map(i => AG[i].k).join(' → ')}`);
      } else if (!shipPulse.on) { crawl.phase = 'rest'; crawl.t = 0; shipped++; scoreHist.push(task.final); if (scoreHist.length > 24) scoreHist.shift(); }
      break;
    case 'rest':
      trailFade = Math.max(0, 1 - crawl.t / 1.0);
      task.sections.forEach(s => s.words.forEach(w => { w.f = Math.max(0, w.f - dt * 1.3); }));
      if (crawl.t > 1.1) { crawl.phase = 'brief'; crawl.t = 0; crawl.sec = -1; crawl.ship = 0; newTask(); }
      break;
  }
}
const CORE_TOP = {x: 0, y: CORE_Y + 6.2, z: 0};
function deliverFx(){
  // 交付回执飞进底部六个框体
  const t = task, route = t.path.map(i => AG[i].k).join(' → ');
  [['.p-score', `✓ SHIP<i>${t.final} 分</i>`], ['.p-sec', `→ ${route}`], ['.p-log', `${t.id}<i>已派单</i>`], ['.p-rad', `✓ SPEC<i>可验收</i>`], ['.p-heat', `${t.reads} 词<i>已读完</i>`], ['.p-code', `dispatch()<i>ok</i>`]]
    .forEach(([sel, html], i) => later(.3 + i * .1, () => flyFrom(CORE_TOP, html, '#6ff0c0', sel, true)));
  // 星云蛛在星核上原地蹦一下
  later(.12, () => { if (spider.a === 0 && !spider.air) { walkTo({a: 0, lx: spider.lx, lz: spider.lz}, null, true); spider.jump.h = .55; spider.jump.dur = .42; } });
  later(.75, () => { if (spider.a === 0 && !spider.air) { walkTo({a: 0, lx: spider.lx, lz: spider.lz}, null, true); spider.jump.h = .35; spider.jump.dur = .32; } });
}
function startRead(){ crawl.phase = 'read'; crawl.wi = 0; crawl.wt = .1; crawl.batch = 4 + ((rng() * 3) | 0); flash[curSec().ai] += .6; }
let bgT = .5;
function simStep(dt){
  simT += dt; orbT += dt; orbitStep();
  for (let i = jobs.length - 1; i >= 0; i--) if (jobs[i].t <= simT) { const j = jobs[i]; jobs.splice(i, 1); j.fn(); }
  if (externalMode) {
    cometStep(dt);
    for (let k = 0; k <= 12; k++) flash[k] *= Math.exp(-dt * 1.35);
    return;
  }
  crawlStep(dt);
  spiderMove(dt);
  cometStep(dt);
  if (task) { calcScore(); task.shown += (task.score - task.shown) * Math.min(1, dt * 3); if ((task.hist.length === 0 || simT - task.hist.at(-1)[0] > .5) && crawl.phase !== 'rest') task.hist.push([simT, task.shown]); }
  for (let k = 1; k <= 12; k++) load[k] = clamp(load[k] + rnd(-.25, .25) * dt, .1, 1);
  // 背景：别的需求也在智能体之间交接（淡色流星）
  if ((bgT -= dt) <= 0) { bgT = rnd(.5, 1.3); const a = 1 + ((Math.random() * 12) | 0); let b = 1 + ((Math.random() * 12) | 0); if (b === a) b = b % 12 + 1; comet(cloudP(a), cloudP(b), AG[a].col, rnd(1.3, 2), .22, () => { flash[b] += .25; load[b] = clamp(load[b] + .1, 0, 1); }); }
  while (readTimes.length && simT - readTimes[0] > 6) readTimes.shift();
}

/* ---------- 星云蛛：趴在云顶上扒来扒去，读完一团再跳到下一团；位置记在所在星云的局部坐标里，跟着星云一起公转 ---------- */
const spider = {a: 0, lx: REST.lx, lz: REST.lz, x: 0, y: 0, z: 0, head: Math.PI, vx: 0, vz: 0, dx: 0, dz: 0, path: null, d: 0, jump: null, onArrive: null, walking: false, air: false, bob: 0, land: 0, n: [0, 1, 0]};
{ const p = anchorW(0, REST.lx, REST.lz); spider.x = p.x; spider.y = p.y; spider.z = p.z; }
const trail = []; let trailFade = 1;           // 丝线：{a, lx, lz} 贴在云面上的点，或 {j, u} 跳跃弧线上的点
const shipPulse = {on: false, d: 0};
const _p0 = {}, _p1 = {};
function jumpAt(J, u, o){ anchorW(J.a0, J.l0x, J.l0z, _p0); anchorW(J.a1, J.l1x, J.l1z, _p1); const e = lerp(u, u * u * (3 - 2 * u), .3); o.x = lerp(_p0.x, _p1.x, e); o.z = lerp(_p0.z, _p1.z, e); o.y = lerp(_p0.y, _p1.y, u) + 4 * J.h * u * (1 - u); return o; }
function trailAt(e, o){ return e.j ? jumpAt(e.j, e.u, o) : anchorW(e.a, e.lx, e.lz, o); }
// jump = 跨星云的大跳（越远跳得越高、越久，最长不到 1 秒）；否则在当前这团星云 / 星核上爬一小段弯路
function walkTo(tg, cb, jump){
  spider.onArrive = cb || null;
  if (jump || tg.a !== spider.a) {
    const p1 = anchorW(tg.a, tg.lx, tg.lz), L = Math.hypot(p1.x - spider.x, p1.z - spider.z);
    spider.jump = {a0: spider.a, l0x: spider.lx, l0z: spider.lz, a1: tg.a, l1x: tg.lx, l1z: tg.lz, h: Math.min(6, 1.4 + L * .2), t: 0, dur: clamp(.38 + L * .02, .42, .95)};
    spider.air = true; spider.walking = false;
    if (crawl.phase !== 'brief' && crawl.phase !== 'rest' && crawl.phase !== 'ship') trail.push({j: spider.jump, u: 0});
  } else {
    const x0 = spider.lx, z0 = spider.lz, dx = tg.lx - x0, dz = tg.lz - z0, L = Math.hypot(dx, dz) || 1;
    const side = Math.random() < .5 ? -1 : 1, bend = L * rnd(.12, .3) * side;
    const cx = (x0 + tg.lx) / 2 - dz / L * bend, cz = (z0 + tg.lz) / 2 + dx / L * bend, pts = [], cum = [0];
    for (let i = 0; i <= 48; i++) { const u = i / 48, a = (1 - u) * (1 - u), b = 2 * u * (1 - u), c = u * u; pts.push([a * x0 + b * cx + c * tg.lx, a * z0 + b * cz + c * tg.lz]); if (i) cum.push(cum[i - 1] + Math.hypot(pts[i][0] - pts[i - 1][0], pts[i][1] - pts[i - 1][1])); }
    spider.path = {pts, cum, L: cum[48]}; spider.d = 0; spider.walking = true;
  }
}
function pathAt(P, d){ let i = 1; while (i < 48 && P.cum[i] < d) i++; const u = (d - P.cum[i - 1]) / Math.max(1e-6, P.cum[i] - P.cum[i - 1]); return [lerp(P.pts[i - 1][0], P.pts[i][0], u), lerp(P.pts[i - 1][1], P.pts[i][1], u)]; }
function arrive(){ const cb = spider.onArrive; spider.onArrive = null; cb && cb(); }
const _sp = {};
function spiderMove(dt){
  const ox = spider.x, oz = spider.z;
  spider.dx = spider.dz = 0;
  if (spider.jump) {
    const J = spider.jump; J.t += dt / J.dur; const u = Math.min(1, J.t);
    jumpAt(J, u, _sp); spider.x = _sp.x; spider.y = _sp.y; spider.z = _sp.z;
    const last = trail[trail.length - 1];
    if (last && last.j === J && u - last.u > .04) trail.push({j: J, u});
    if (u >= 1) { spider.jump = null; spider.air = false; spider.a = J.a1; spider.lx = J.l1x; spider.lz = J.l1z; spider.land = 1; arrive(); }
  } else {
    // 星云在公转：这一帧星云带着它挪了多少（脚也要跟着挪）
    anchorW(spider.a, spider.lx, spider.lz, _sp); spider.dx = _sp.x - ox; spider.dz = _sp.z - oz;
    if (spider.walking) {
      const P = spider.path, v = 3.8 * clamp(Math.min(spider.d + .35, P.L - spider.d + .3) / .9, .3, 1);
      spider.d = Math.min(P.L, spider.d + v * dt); [spider.lx, spider.lz] = pathAt(P, spider.d);
      if (spider.d >= P.L) { spider.walking = false; arrive(); }
    }
    anchorW(spider.a, spider.lx, spider.lz, _sp); spider.x = _sp.x; spider.y = _sp.y; spider.z = _sp.z;
    const last = trail[trail.length - 1];
    if (crawl.phase !== 'rest' && crawl.phase !== 'brief' && crawl.phase !== 'ship' && (!last || last.j || last.a !== spider.a || Math.hypot(last.lx - spider.lx, last.lz - spider.lz) > .3)) trail.push({a: spider.a, lx: spider.lx, lz: spider.lz});
  }
  spider.land *= Math.exp(-dt * 7);
  spider.vx = (spider.x - ox - spider.dx) / Math.max(dt, 1e-4); spider.vz = (spider.z - oz - spider.dz) / Math.max(dt, 1e-4);
  const sp = Math.hypot(spider.vx, spider.vz);
  let want = spider.head;
  if (sp > .3) want = Math.atan2(spider.vx, spider.vz);
  else if (crawl.phase === 'read') { const s = curSec(), w = s && s.words[Math.max(0, crawl.wi - 1)]; if (w) { const p = wordPos(w); want = Math.atan2(p.x - spider.x, p.z - spider.z); } }
  else if (crawl.phase === 'ship' || crawl.phase === 'brief' || crawl.phase === 'rest') want = Math.PI;
  spider.head = angLerp(spider.head, want, Math.min(1, dt * (spider.air ? 9 : sp > .3 ? 6 : 4)));
  spider.bob += dt * (spider.walking ? 12 : 2.2);
  // 身体顺着云面 / 球面倾斜
  if (!spider.air) { const c = CL[spider.a], e = .35, h0 = surfW(c, spider.x, spider.z), hx = surfW(c, spider.x + e, spider.z), hz = surfW(c, spider.x, spider.z + e);
    let nx = -(hx - h0) / e, nz = -(hz - h0) / e; const nl = Math.hypot(nx, 1, nz); spider.n[0] += (nx / nl - spider.n[0]) * Math.min(1, dt * 8); spider.n[1] += (1 / nl - spider.n[1]) * Math.min(1, dt * 8); spider.n[2] += (nz / nl - spider.n[2]) * Math.min(1, dt * 8); }
  else { spider.n[0] *= .9; spider.n[2] *= .9; spider.n[1] += (1 - spider.n[1]) * .1; }
  if (shipPulse.on) { shipPulse.d += dt; if (shipPulse.d >= 2.4) shipPulse.on = false; }
}
let trailLenW = 0;

/* ---------- 流星：交接 / 提问 / 回答 / 连线 ---------- */
const CORE_P = {x: 0, y: CORE_Y, z: 0};
const comets = [];
function comet(a, b, col, dur, size, cb){ comets.push({a, b, col, dur, size, t: 0, cb}); }
function cometAt(c, u, o){
  const A = typeof c.a === 'function' ? c.a() : c.a, B = typeof c.b === 'function' ? c.b() : c.b, L = Math.hypot(B.x - A.x, B.z - A.z);
  const my = Math.max(A.y, B.y) + Math.min(4, L * .22), a = (1 - u) * (1 - u), b = 2 * u * (1 - u), d = u * u;
  o.x = a * A.x + b * (A.x + B.x) / 2 + d * B.x; o.y = a * A.y + b * my + d * B.y; o.z = a * A.z + b * (A.z + B.z) / 2 + d * B.z; return o;
}
function cometStep(dt){ for (let i = comets.length - 1; i >= 0; i--) { const c = comets[i]; c.t += dt / c.dur; if (c.t >= 1) { comets.splice(i, 1); c.cb && c.cb(); } } }
let coreSay = {t: 0, txt: ''};

/* ================= 4. 3D 星云 ================= */
const THREE = THREE_COMPAT;
const cv = $('#gl');
let renderer = null, scene, camera, composer = null, bloom = null, world, glOK = false, pr = 1;
let engineeringLineObj = null, engineeringLinePos = null, engineeringLineCol = null;
const U = {time: {value: 0}, px: {value: 600}, b: {value: new Float32Array(16).fill(1)}, sp: {value: null}};
let starsObj, threadObj, sparkObj, trailLine, coreBall, abdBall, legG, ringsG, streakG, cometSprites = [], pulseSpr, GLOW;
const legs = [];
const v3 = THREE ? new THREE.Vector3() : null;

const PT_VS = `attribute vec3 aCol; attribute float aSize; attribute float aPh; attribute float aCid;
uniform float uTime, uPx; uniform float uB[16]; uniform vec4 uSp;
varying vec3 vCol; varying float vA;
void main(){
  vec4 mv = modelViewMatrix * vec4(position, 1.);
  gl_Position = projectionMatrix * mv;
  float tw = .62 + .38 * sin(uTime * (1.1 + aPh * .9) + aPh * 37.);
  float pk = 1.;
  if (aCid < 12.5) { vec4 wp = modelMatrix * vec4(position, 1.); pk = mix(.16, 1., smoothstep(uSp.w * .45, uSp.w * 1.5, length(wp.xz - uSp.xz))); }
  vA = tw * uB[int(aCid + .5)] * pk;
  vCol = aCol;
  gl_PointSize = max(1., aSize * uPx / -mv.z);
}`;
const PT_FS = `varying vec3 vCol; varying float vA;
void main(){ vec2 c = gl_PointCoord - .5; float d = dot(c, c); if (d > .25) discard; float a = smoothstep(.25, .0, d); gl_FragColor = vec4(vCol, a * a * vA); }`;
const RB_VS = `attribute vec2 aUV; attribute vec3 aNrm; uniform float uTime, uPh, uAmp; varying vec2 vUV;
void main(){ vec3 p = position + aNrm * sin(aUV.x * 18.85 + uTime * 1.5 + uPh) * uAmp; vUV = aUV; gl_Position = projectionMatrix * modelViewMatrix * vec4(p, 1.); }`;
const RB_FS = `uniform vec3 uC1, uC2; uniform float uTime, uPh, uA; varying vec2 vUV;
void main(){
  float e = abs(vUV.y * 2. - 1.);
  float edge = pow(e, 5.) * 1.1 + .14;
  float str = .5 + .5 * sin(vUV.y * 70. + vUV.x * 30.);
  float along = .25 + .75 * pow(.5 + .5 * sin(vUV.x * 12.566 + uTime * .6 + uPh), 2.);
  vec3 col = mix(uC1, uC2, .5 + .5 * sin(vUV.x * 6.2832 * 2. + uPh));
  gl_FragColor = vec4(col, edge * (.55 + .45 * str) * along * uA);
}`;
const LEG_VS = `varying vec3 vN; varying vec3 vV; void main(){ vec4 mv = modelViewMatrix * vec4(position, 1.); vN = normalize(normalMatrix * normal); vV = normalize(-mv.xyz); gl_Position = projectionMatrix * mv; }`;
const LEG_FS = `uniform vec3 uC; uniform float uA; varying vec3 vN; varying vec3 vV; void main(){ float f = 1. - abs(dot(vN, vV)); gl_FragColor = vec4(uC, (pow(f, 2.2) * .95 + .1) * uA); }`;
const ST_VS = `attribute float aA; attribute float aPh; attribute float aY; uniform float uTime; varying float vA; varying float vY;
void main(){ vA = aA * (.45 + .55 * sin(uTime * (.35 + aPh * .5) + aPh * 40.)); vY = aY; gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.); }`;
const ST_FS = `uniform vec3 uC; varying float vA; varying float vY; void main(){ float f = 1. - abs(vY * 2. - 1.); gl_FragColor = vec4(uC, vA * f * f); }`;

function ptMat(){ return new THREE.ShaderMaterial({uniforms: {uTime: U.time, uPx: U.px, uB: U.b, uSp: U.sp}, vertexShader: PT_VS, fragmentShader: PT_FS, transparent: true, depthWrite: false, blending: THREE.AdditiveBlending}); }
function pointsObj(n){
  const g = new THREE.BufferGeometry();
  g.setAttribute('position', new THREE.BufferAttribute(new Float32Array(n * 3), 3));
  g.setAttribute('aCol', new THREE.BufferAttribute(new Float32Array(n * 3), 3));
  g.setAttribute('aSize', new THREE.BufferAttribute(new Float32Array(n), 1));
  g.setAttribute('aPh', new THREE.BufferAttribute(new Float32Array(n), 1));
  g.setAttribute('aCid', new THREE.BufferAttribute(new Float32Array(n), 1));
  const p = new THREE.Points(g, ptMat()); p.frustumCulled = false; return p;
}
function setPt(o, i, x, y, z, c, s, cid){ const g = o.geometry.attributes; g.position.setXYZ(i, x, y, z); g.aCol.setXYZ(i, c[0], c[1], c[2]); g.aSize.setX(i, s); g.aPh.setX(i, rng()); g.aCid.setX(i, cid); }
const mix3 = (a, b, t) => [lerp(a[0], b[0], t), lerp(a[1], b[1], t), lerp(a[2], b[2], t)];
const WHITE = [1, 1, 1], ICE = hex3('#9fd4ff'), PEACH = hex3('#ffb48f');
function canvasTex(w, h, draw){ const c = document.createElement('canvas'); c.width = w; c.height = h; draw(c.getContext('2d'), w, h); const t = new THREE.CanvasTexture(c); t.needsUpdate = true; return t; }

/* ---------- 12 团星云（每团一个组，跟着公转）+ 星核尘埃 + 轨道 ---------- */
const cloudG = [], hazes = [];
// 六种星云形态轮流分给 12 团，相邻的不重样：
// puff 蓬松团云 · swirl 旋涡（两三条旋臂）· ring 环状星云（中间空）· stream 彗尾流（顺着轨道拖尾巴）· twin 双瓣（蝴蝶状）· fiber 纤维丝团
const STYLES = ['puff', 'swirl', 'ring', 'stream', 'twin', 'fiber'];
const STYLE_OF = [null, 'swirl', 'ring', 'puff', 'stream', 'twin', 'fiber', 'ring', 'puff', 'swirl', 'fiber', 'stream', 'twin'];
function buildNebulae(){
  const ND = 1600;
  const HAZE = canvasTex(128, 128, (x, w) => { const g = x.createRadialGradient(64, 64, 0, 64, 64, 64); g.addColorStop(0, 'rgba(255,255,255,.9)'); g.addColorStop(.35, 'rgba(255,255,255,.38)'); g.addColorStop(.7, 'rgba(255,255,255,.08)'); g.addColorStop(1, 'rgba(255,255,255,0)'); x.fillStyle = g; x.fillRect(0, 0, w, w); });
  for (let k = 1; k <= 12; k++) {
    const c = CL[k], col = AGC[k], R = c.R, st = STYLE_OF[k], grp = new THREE.Group(); world.add(grp); cloudG[k] = grp; c.style = st;
    const N = st === 'fiber' ? 1900 : 3400, NF = st === 'fiber' ? 150 : st === 'puff' ? 50 : 26, FP = 46;
    const pts = pointsObj(N + NF * FP); let i = 0;
    const arms = 2 + (rng() < .5 ? 1 : 0), spin = rng() < .5 ? 1 : -1, a0 = rng() * TAU;
    const lobes = st === 'twin' ? [{x: -R * .55, z: (rng() - .5) * R * .2, r: R * .46}, {x: R * .55, z: (rng() - .5) * R * .2, r: R * .42}]
      : Array.from({length: 4}, () => { const a = rng() * TAU, rr = R * rng() * .4; return {x: Math.cos(a) * rr * 1.1, z: Math.sin(a) * rr * .8, r: R * (.38 + rng() * .22)}; });
    // 每种形态的光雾位置
    const hz = st === 'ring' ? Array.from({length: 6}, (_, q) => { const a = q / 6 * TAU; return {x: Math.cos(a) * R * .62 * 1.1, z: Math.sin(a) * R * .62 * .8, r: R * .34}; })
      : st === 'stream' ? [{x: R * .5, z: 0, r: R * .42}, {x: -R * .1, z: 0, r: R * .36}, {x: -R * .7, z: 0, r: R * .28}]
      : st === 'swirl' ? [{x: 0, z: 0, r: R * .3}, {x: 0, z: 0, r: R * .75}]
      : st === 'fiber' ? [{x: 0, z: 0, r: R * .85}]
      : lobes.concat([{x: 0, z: 0, r: R * .8}]);
    hz.forEach((L, q) => {
      const h = new THREE.Sprite(new THREE.SpriteMaterial({map: HAZE, color: new THREE.Color(...mix3(col, WHITE, .12)), transparent: true, opacity: st === 'fiber' ? .06 : .08, blending: THREE.AdditiveBlending, depthWrite: false}));
      h.position.set(L.x, c.y0 + c.top * .4, L.z); h.scale.setScalar(L.r * 2.4); h.userData.k = k; h.userData.o = h.material.opacity; grp.add(h); hazes.push(h);
    });
    for (let n = 0; n < N; n++, i++) {
      let x, z, br = 1;
      if (st === 'swirl') {
        if (rng() < .22) { x = gauss() * R * .16; z = gauss() * R * .13; br = 1.25; }
        else { const t = Math.pow(rng(), .8), a = a0 + ((n % arms) / arms) * TAU + spin * t * 3.4, rr = R * (.12 + .86 * t), wd = R * (.13 - .07 * t); x = Math.cos(a) * rr * 1.1 + gauss() * wd; z = Math.sin(a) * rr * .82 + gauss() * wd; br = 1.1 - t * .4; }
      } else if (st === 'ring') {
        if (rng() < .1) { x = gauss() * R * .25; z = gauss() * R * .2; br = .6; }
        else { const a = rng() * TAU, rr = R * (.64 + gauss() * .08); x = Math.cos(a) * rr * 1.1; z = Math.sin(a) * rr * .8; br = .9 + .3 * Math.max(0, Math.cos(a - a0)); }
      } else if (st === 'stream') {
        const t = Math.pow(rng(), 1.3), wd = R * (.34 * (1 - t) + .06); x = R * (.75 - 1.85 * t) + gauss() * R * .06; z = gauss() * wd + Math.sin(t * 5 + a0) * R * .12 * t; br = 1.15 - t * .55;
      } else if (st === 'fiber') {
        x = gauss() * R * .5; z = gauss() * R * .38; br = .7;
      } else {
        const L = lobes[(rng() * lobes.length) | 0]; x = L.x + gauss() * L.r * .58; z = L.z + gauss() * L.r * (st === 'twin' ? .62 : .5);
        if (st === 'twin' && rng() < .08) { x = gauss() * R * .1; z = gauss() * R * .3; br = 1.3; }   // 两瓣之间的腰
      }
      const top = surfL(c, x, z), y = c.y0 - .35 + (top - c.y0 + .35) * Math.pow(rng(), .5) + gauss() * .06, w = Math.pow(rng(), 3.5);
      setPt(pts, i, x, y, z, mix3(col, WHITE, w * .8).map(v => v * Math.min(1.2, (.5 + rng() * .5) * br)), .045 + Math.pow(rng(), 9) * .34 + w * .05, k);
    }
    for (let f = 0; f < NF; f++) {
      let x0, z0, dir;
      if (st === 'ring') { const a = rng() * TAU; x0 = Math.cos(a) * R * .64 * 1.1; z0 = Math.sin(a) * R * .64 * .8; dir = a + HP + (rng() - .5) * .5; }
      else if (st === 'stream') { x0 = R * (.6 - 1.5 * rng()); z0 = (rng() - .5) * R * .4; dir = (rng() - .5) * .35; }
      else if (st === 'swirl') { const t = rng(), a = a0 + ((f % arms) / arms) * TAU + spin * t * 3.4, rr = R * (.15 + .8 * t); x0 = Math.cos(a) * rr * 1.1; z0 = Math.sin(a) * rr * .82; dir = a + spin * HP; }
      else { x0 = (rng() - .5) * R * 1.4; z0 = (rng() - .5) * R * .9; dir = (rng() - .5) * (st === 'fiber' ? TAU : 1.8); }
      const len = R * (st === 'fiber' ? .4 + rng() * 1.1 : .4 + rng() * .7), amp = R * (.05 + rng() * .12), fr = 2 + rng() * 4, ph = rng() * TAU, hf = .55 + rng() * .45;
      const cc0 = mix3(col, WHITE, .25 + rng() * .4);
      for (let q = 0; q < FP; q++, i++) {
        const u = q / (FP - 1) - .5, bend = Math.sin(u * fr + ph) * amp;
        const x = x0 + Math.cos(dir) * u * len - Math.sin(dir) * bend, z = z0 + Math.sin(dir) * u * len * .6 + Math.cos(dir) * bend * .6;
        const y = c.y0 + (surfL(c, x, z) - c.y0) * hf + Math.sin(u * 5 + ph) * .15, fade = 1 - Math.abs(u) * 1.6;
        setPt(pts, i, x + gauss() * .03, y, z + gauss() * .03, cc0.map(v => v * ((st === 'fiber' ? .55 : .4) + .55 * Math.max(0, fade))), .04 + rng() * .03, k);
      }
    }
    grp.add(pts);
  }
  // 三条公转轨道：细线 + 沿轨道散开的一层淡尘埃
  const NO = 900, od = pointsObj(NO * 3 + ND); let i = 0;
  ORBITS.forEach((o, oi) => {
    const P = []; for (let j = 0; j <= 240; j++) { const f = j / 240 * TAU; P.push(new THREE.Vector3(Math.cos(f) * o.ax, -.35, Math.sin(f) * o.az)); }
    world.add(new THREE.LineLoop(new THREE.BufferGeometry().setFromPoints(P), new THREE.LineBasicMaterial({color: oi === 1 ? 0xffc2a6 : 0x9fd4ff, transparent: true, opacity: .2, blending: THREE.AdditiveBlending, depthWrite: false})));
    for (let n = 0; n < NO; n++, i++) { const f = rng() * TAU, j = 1 + gauss() * .035; const cc = (rng() < .3 ? PEACH : rng() < .5 ? ICE : WHITE).map(v => v * (.25 + rng() * .4)); setPt(od, i, Math.cos(f) * o.ax * j, -.35 + gauss() * .15, Math.sin(f) * o.az * j, cc, .035 + Math.pow(rng(), 8) * .18, 13); }
  });
  for (let n = 0; n < ND; n++, i++) {
    const a = rng() * TAU, r = 6.2 + Math.abs(gauss()) * 3.2;
    const cc = (rng() < .3 ? PEACH : rng() < .5 ? ICE : WHITE).map(v => v * (.4 + rng() * .5));
    setPt(od, i, Math.cos(a) * r * 1.15, gauss() * .35 + .4, Math.sin(a) * r * .8, cc, .04 + Math.pow(rng(), 6) * .22, 0);
  }
  world.add(od);
  // 远处星空：平面下方一层 + 上方稀疏一层
  const NS = 2600; starsObj = pointsObj(NS);
  for (let n = 0; n < NS; n++) {
    const up = rng() < .18, cc = (rng() < .25 ? PEACH : rng() < .5 ? ICE : WHITE).map(v => v * (.35 + rng() * .65));
    setPt(starsObj, n, (rng() - .5) * 170, up ? 6 + rng() * 14 : -6 - rng() * 26, (rng() - .5) * 110, cc, .08 + Math.pow(rng(), 8) * .9, 13);
  }
  world.add(starsObj);
}

/* ---------- 丝带星核（图三那种发光丝带缠成的球）：星核和蜘蛛腹部共用 ---------- */
function ribbonMat(c1, c2, amp, alpha){ return new THREE.ShaderMaterial({uniforms: {uTime: U.time, uPh: {value: rng() * TAU}, uAmp: {value: amp}, uC1: {value: new THREE.Color(c1)}, uC2: {value: new THREE.Color(c2)}, uA: {value: alpha}}, vertexShader: RB_VS, fragmentShader: RB_FS, transparent: true, depthWrite: false, blending: THREE.AdditiveBlending, side: THREE.DoubleSide}); }
function ribbonGeo(R, w0, seg){
  const q = new THREE.Quaternion().setFromEuler(new THREE.Euler(rng() * TAU, rng() * TAU, rng() * TAU));
  const p1 = rng() * TAU, p2 = rng() * TAU, k1 = 2 + ((rng() * 2) | 0);
  const P = [];
  for (let i = 0; i <= seg; i++) { const u = i / seg * TAU; const rr = R * (1 + .14 * Math.sin(3 * u + p1)); const v = new THREE.Vector3(Math.cos(u) * rr, R * .22 * Math.sin(k1 * u + p2), Math.sin(u) * rr).applyQuaternion(q); P.push(v); }
  const pos = new Float32Array((seg + 1) * 6), uv = new Float32Array((seg + 1) * 4), nrm = new Float32Array((seg + 1) * 6), idx = [];
  const T = new THREE.Vector3(), N = new THREE.Vector3(), B = new THREE.Vector3();
  for (let i = 0; i <= seg; i++) {
    const a = P[(i + seg - 1) % seg], b = P[(i + 1) % seg], p = P[i];
    T.subVectors(b, a).normalize(); N.copy(p).normalize(); B.crossVectors(T, N).normalize();
    const u = i / seg, w = w0 * (.25 + .75 * Math.pow(.5 + .5 * Math.sin(u * TAU * 2 + p1), 1.5));
    for (let s = 0; s < 2; s++) { const sg = s ? .5 : -.5, o = (i * 2 + s); pos[o * 3] = p.x + B.x * w * sg; pos[o * 3 + 1] = p.y + B.y * w * sg; pos[o * 3 + 2] = p.z + B.z * w * sg; uv[o * 2] = u; uv[o * 2 + 1] = s; nrm[o * 3] = N.x; nrm[o * 3 + 1] = N.y; nrm[o * 3 + 2] = N.z; }
    if (i < seg) { const o = i * 2; idx.push(o, o + 1, o + 2, o + 1, o + 3, o + 2); }
  }
  const g = new THREE.BufferGeometry();
  g.setAttribute('position', new THREE.BufferAttribute(pos, 3)); g.setAttribute('aUV', new THREE.BufferAttribute(uv, 2)); g.setAttribute('aNrm', new THREE.BufferAttribute(nrm, 3)); g.setIndex(idx);
  return g;
}
function makeRibbonBall(R, n, w0, seg, amp, alpha){
  const g = new THREE.Group(), PAL = [['#d9ecff', '#7fb6ff'], ['#ffffff', '#ffc2a6'], ['#9fd4ff', '#ffffff'], ['#ffb48f', '#d9ecff'], ['#7aa8ff', '#e6f2ff']];
  for (let i = 0; i < n; i++) { const [c1, c2] = PAL[i % PAL.length]; const m = new THREE.Mesh(ribbonGeo(R * (.82 + rng() * .3), w0 * (.6 + rng() * .8), seg), ribbonMat(c1, c2, amp, alpha * (.6 + rng() * .5))); m.frustumCulled = false; m.userData.ax = new THREE.Vector3(rng() - .5, rng() - .5, rng() - .5).normalize(); m.userData.sp = (rng() - .5) * .5; g.add(m); }
  return g;
}
function buildCore(){
  coreBall = makeRibbonBall(6.1, 24, 1.7, 220, .22, .66); coreBall.position.set(0, CORE_Y, 0); world.add(coreBall);
  // 星核外的几圈轨道椭圆（图三的元素），上面有光点在跑
  ringsG = new THREE.Group(); ringsG.position.copy(coreBall.position); world.add(ringsG);
  [[8.0, .35, .1], [9.4, -.28, -.18], [10.6, .16, .26]].forEach(([r, rx, rz], i) => {
    const pts = []; for (let j = 0; j <= 160; j++) { const a = j / 160 * TAU; pts.push(new THREE.Vector3(Math.cos(a) * r, 0, Math.sin(a) * r)); }
    const line = new THREE.LineLoop(new THREE.BufferGeometry().setFromPoints(pts), new THREE.LineBasicMaterial({color: i === 1 ? 0xffc2a6 : 0x9fd4ff, transparent: true, opacity: .22, blending: THREE.AdditiveBlending, depthWrite: false}));
    const holder = new THREE.Group(); holder.rotation.set(rx, 0, rz); holder.add(line);
    const dot = new THREE.Sprite(new THREE.SpriteMaterial({map: GLOW, color: i === 1 ? 0xffd0b8 : 0xcfe6ff, transparent: true, blending: THREE.AdditiveBlending, depthWrite: false})); dot.scale.setScalar(.55); holder.add(dot);
    holder.userData = {r, dot, sp: [.35, -.22, .16][i]}; ringsG.add(holder);
  });
}
/* ---------- 背景竖向光丝（图三里那种从上到下的细光线），贴在镜头上 ---------- */
function buildStreaks(){
  const n = 140, pos = [], aA = [], aPh = [], aY = [], idx = [];
  for (let i = 0; i < n; i++) {
    const x = rng() * 2 - 1, w = .0008 + Math.pow(rng(), 3) * .0026, h = .3 + rng() * 1.5, y = (rng() - .5) * 1.4, a = .08 + Math.pow(rng(), 2) * .4, ph = rng(), o = i * 4;
    pos.push(x - w, y - h / 2, 0, x + w, y - h / 2, 0, x + w, y + h / 2, 0, x - w, y + h / 2, 0);
    for (let q = 0; q < 4; q++) { aA.push(a); aPh.push(ph); }
    aY.push(0, 0, 1, 1); idx.push(o, o + 1, o + 2, o, o + 2, o + 3);
  }
  const g = new THREE.BufferGeometry();
  g.setAttribute('position', new THREE.Float32BufferAttribute(pos, 3)); g.setAttribute('aA', new THREE.Float32BufferAttribute(aA, 1)); g.setAttribute('aPh', new THREE.Float32BufferAttribute(aPh, 1)); g.setAttribute('aY', new THREE.Float32BufferAttribute(aY, 1)); g.setIndex(idx);
  const m = new THREE.Mesh(g, new THREE.ShaderMaterial({uniforms: {uTime: U.time, uC: {value: new THREE.Color('#8fb8ff')}}, vertexShader: ST_VS, fragmentShader: ST_FS, transparent: true, depthWrite: false, depthTest: false, blending: THREE.AdditiveBlending}));
  m.frustumCulled = false; m.renderOrder = -10;
  streakG = new THREE.Group(); streakG.position.z = -100; streakG.add(m); camera.add(streakG);
}

/* ---------- 星云蛛（图二）：粒子头 + 两只大圆眼 + 丝带星云腹部 + 8 条半透明腿 ---------- */
const HEAD = new (THREE ? THREE.Vector3 : Object)(0, 1.0, .55);
function buildSpider(){
  const g = new THREE.Group(); world.add(g); spider.g = g; g.scale.setScalar(S);
  const HR = .72, AR = 1.38, AC = [0, 1.32, -1.25];
  // 身体里垫一层深色实心球：让粒子像长在一个实体上，也挡住身后的星云
  const dark = new THREE.MeshBasicMaterial({color: 0x050a1a});
  const hd = new THREE.Mesh(new THREE.SphereGeometry(HR * .8, 24, 18), dark); hd.position.copy(HEAD); g.add(hd);
  const ab = new THREE.Mesh(new THREE.SphereGeometry(AR * .74, 24, 18), dark); ab.position.set(...AC); g.add(ab);
  const nH = 3200, nA = 1500, sp = pointsObj(nH + nA); let i = 0;
  for (let n = 0; n < nH; n++, i++) {
    const v = new THREE.Vector3(gauss(), gauss(), gauss()).normalize().multiplyScalar(HR * (n < nH * .85 ? .9 + rng() * .16 : rng() * .9));
    const cc = (rng() < .1 ? PEACH : rng() < .45 ? ICE : WHITE).map(q => q * (.6 + rng() * .4));
    setPt(sp, i, HEAD.x + v.x, HEAD.y + v.y, HEAD.z + v.z, cc, (.045 + Math.pow(rng(), 6) * .12) * S, 14);
  }
  for (let n = 0; n < nA; n++, i++) {
    const v = new THREE.Vector3(gauss(), gauss() * .9, gauss() * 1.08).normalize().multiplyScalar(AR * (n < nA * .7 ? .97 + rng() * .08 : rng() * .95));
    const cc = (rng() < .2 ? PEACH : rng() < .55 ? ICE : WHITE).map(q => q * (.4 + rng() * .5));
    setPt(sp, i, AC[0] + v.x, AC[1] + v.y, AC[2] + v.z, cc, (.03 + Math.pow(rng(), 7) * .1) * S, 14);
  }
  sp.renderOrder = 4; g.add(sp);
  abdBall = makeRibbonBall(AR * .98, 10, .45, 90, .05, 1.05); abdBall.children.forEach(m => m.renderOrder = 4); abdBall.position.set(...AC); abdBall.scale.set(1, .92, 1.08); g.add(abdBall);
  // 两只大圆眼：白色亮环 + 深色眼底 + 亮瞳
  const eyeT = canvasTex(128, 128, (x, w) => { const c = w / 2; const gl = x.createRadialGradient(c, c, 34, c, c, 62); gl.addColorStop(0, 'rgba(190,225,255,.55)'); gl.addColorStop(1, 'rgba(190,225,255,0)'); x.fillStyle = gl; x.fillRect(0, 0, w, w); x.beginPath(); x.arc(c, c, 40, 0, TAU); x.fillStyle = '#071024'; x.fill(); x.lineWidth = 7; x.strokeStyle = '#f2f8ff'; x.stroke(); const p = x.createRadialGradient(c, c, 0, c, c, 18); p.addColorStop(0, '#ffffff'); p.addColorStop(.6, '#dff0ff'); p.addColorStop(1, 'rgba(160,210,255,0)'); x.fillStyle = p; x.beginPath(); x.arc(c, c, 18, 0, TAU); x.fill(); });
  spider.eyes = [-1, 1].map(s => { const e = new THREE.Sprite(new THREE.SpriteMaterial({map: eyeT, transparent: true, depthWrite: false})); e.position.set(s * .28, HEAD.y + .1, HEAD.z + HR * .96); e.scale.setScalar(.5); e.renderOrder = 5; g.add(e); return e; });
  // 脚下的暗影：星云再亮，蜘蛛也压在一块暗底上
  const shT = canvasTex(128, 128, (x, w) => { const g = x.createRadialGradient(64, 64, 0, 64, 64, 64); g.addColorStop(0, 'rgba(2,4,12,.95)'); g.addColorStop(.45, 'rgba(2,4,12,.7)'); g.addColorStop(1, 'rgba(2,4,12,0)'); x.fillStyle = g; x.fillRect(0, 0, w, w); });
  spider.shadow = new THREE.Sprite(new THREE.SpriteMaterial({map: shT, transparent: true, depthWrite: false, depthTest: false, opacity: .8})); spider.shadow.renderOrder = 3; spider.shadow.scale.setScalar(4.4 * S); world.add(spider.shadow);
  // 8 条腿：根部绕在头部两侧，前两对朝前、后两对朝后
  legG = new THREE.Group(); world.add(legG);
  const legMat = new THREE.ShaderMaterial({uniforms: {uC: {value: new THREE.Color('#b8dcff')}, uA: {value: .95}}, vertexShader: LEG_VS, fragmentShader: LEG_FS, transparent: true, depthWrite: false, blending: THREE.AdditiveBlending});
  const segGeo = new THREE.CylinderGeometry(.72, 1, 1, 12, 1, true);
  const ANG = [38, 72, 108, 142];
  sparkObj = pointsObj(8 * 3 * 20);
  for (let s = -1, li = 0; s <= 1; s += 2) for (let n = 0; n < 4; n++, li++) {
    const a = ANG[n] * Math.PI / 180;
    const L = {side: s, n, grp: (n + (s > 0 ? 1 : 0)) % 2,
      rootL: new THREE.Vector3(s * .5, .98, HEAD.z + .32 - n * .26),
      restL: new THREE.Vector3(s * Math.sin(a) * 3.1, 0, HEAD.z + Math.cos(a) * 3.0),
      foot: new THREE.Vector3(), step: null, segs: [], joints: [], P: [new THREE.Vector3(), new THREE.Vector3(), new THREE.Vector3(), new THREE.Vector3()], spk: []};
    for (let q = 0; q < 3; q++) { const m = new THREE.Mesh(segGeo, legMat); m.frustumCulled = false; m.renderOrder = 4; legG.add(m); L.segs.push(m); }
    for (let q = 0; q < 4; q++) { const j = new THREE.Sprite(new THREE.SpriteMaterial({map: GLOW, color: q === 3 ? 0xffe2cf : q === 0 ? 0x9fd4ff : 0xffc7a8, transparent: true, blending: THREE.AdditiveBlending, depthWrite: false})); j.userData.s = q === 3 ? .5 : q === 0 ? .26 : .4; j.scale.setScalar(j.userData.s * S); j.material.opacity = q === 3 ? .9 : .75; j.renderOrder = 4; legG.add(j); L.joints.push(j); }
    for (let q = 0; q < 60; q++) L.spk.push({seg: q % 3, t: rng(), a: rng() * TAU, r: rng() * .8});
    legs.push(L);
  }
  legs.forEach((L, li) => L.spk.forEach((k, q) => { const cc = (rng() < .3 ? PEACH : rng() < .6 ? ICE : WHITE).map(v => v * (.6 + rng() * .4)); setPt(sparkObj, li * 60 + q, 0, 0, 0, cc, (.03 + Math.pow(rng(), 5) * .07) * S, 14); }));
  sparkObj.renderOrder = 4; legG.add(sparkObj);
}
const LEN = [1.5, 1.85, .78];
const tA = THREE ? [new THREE.Vector3(), new THREE.Vector3(), new THREE.Vector3(), new THREE.Vector3()] : [];
const UPV = THREE ? new THREE.Vector3(0, 1, 0) : null, XV = THREE ? new THREE.Vector3(1, 0, 0) : null;
const qN = THREE ? new THREE.Quaternion() : null, qY = THREE ? new THREE.Quaternion() : null, qP = THREE ? new THREE.Quaternion() : null;
function setSeg(m, a, b, r){ const d = tA[3].subVectors(b, a), len = d.length(); m.position.addVectors(a, b).multiplyScalar(.5); m.quaternion.setFromUnitVectors(UPV, d.divideScalar(len || 1)); m.scale.set(r, len, r); }
function legsStep(dt){
  const g = spider.g; g.updateMatrixWorld();
  const walking = spider.walking, l1 = LEN[0] * SS, l2 = LEN[1] * SS, l3 = LEN[2] * SS, landing = spider.land > .25;
  const stepping = [0, 0]; legs.forEach(L => { if (L.step) stepping[L.grp]++; });
  const SC = CL[spider.a], ddx = spider.dx, ddz = spider.dz;
  legs.forEach((L, li) => {
    const R = L.P[0].copy(L.rootL).applyMatrix4(g.matrixWorld);
    const T = tA[0].copy(L.restL).applyMatrix4(g.matrixWorld); if (walking) { T.x += spider.vx * .2; T.z += spider.vz * .2; } T.y = surfW(SC, T.x, T.z);
    if (!spider.air) { L.foot.x += ddx; L.foot.z += ddz; if (L.step) { L.step.from.x += ddx; L.step.from.z += ddz; L.step.to.x += ddx; L.step.to.z += ddz; } }
    if (!L.init) { L.foot.copy(T); L.init = true; }
    if (spider.air) {
      const tuck = tA[1].set(L.restL.x * .5, -.45, L.restL.z * .55).applyMatrix4(g.matrixWorld);
      L.foot.lerp(tuck, Math.min(1, dt * 22)); L.step = null;
    } else if (L.step) {
      L.step.t += dt / L.step.dur; const u = Math.min(1, L.step.t), e = ease2(u);
      L.foot.lerpVectors(L.step.from, L.step.to, e); L.foot.y += Math.sin(Math.PI * u) * .45 * SS;
      if (u >= 1) { L.foot.copy(L.step.to); L.step = null; }
    } else {
      const d = Math.hypot(L.foot.x - T.x, L.foot.z - T.z), thr = walking ? .7 * SS : .32 * SS;
      if (d > 4 * SS) L.foot.copy(T);
      else if (d > thr && (landing || (walking ? stepping[1 - L.grp] === 0 : stepping[0] + stepping[1] < 2))) {
        L.step = {from: L.foot.clone(), to: T.clone(), t: 0, dur: landing ? .09 : walking ? .13 : .2}; stepping[L.grp]++;
      }
      // 读词时前腿轻点（像在敲键）
      if (!L.step) L.foot.y = surfW(SC, L.foot.x, L.foot.z) + (!walking && crawl.phase === 'read' && L.n === 0 ? Math.max(0, Math.sin(animT * 9 + L.side) * .16 * SS) : 0);
    }
    // 腿的逆解：踝点在脚尖上方偏内，膝盖朝上
    const F = L.P[3].copy(L.foot);
    const o = tA[1].set(F.x - R.x, 0, F.z - R.z); const ol = o.length() || 1; o.divideScalar(ol);
    const A = L.P[2].set(F.x - o.x * l3 * .3, F.y + l3 * .92, F.z - o.z * l3 * .3);
    const dir = tA[2].subVectors(A, R); let d = dir.length(); dir.divideScalar(d || 1); d = clamp(d, .2, (l1 + l2) * .995);
    const ca = clamp((l1 * l1 + d * d - l2 * l2) / (2 * l1 * d), -1, 1), sa2 = Math.sqrt(1 - ca * ca);
    const perp = tA[3].copy(UPV).addScaledVector(dir, -UPV.dot(dir)).normalize();
    const K = L.P[1].copy(R).addScaledVector(dir, ca * l1).addScaledVector(perp, sa2 * l1);
    A.copy(R).addScaledVector(dir, d);   // 够不着时踝点贴着最远处
    setSeg(L.segs[0], R, K, .1 * SS); setSeg(L.segs[1], K, A, .08 * SS); setSeg(L.segs[2], A, F, .055 * SS);
    L.joints.forEach((j, q) => { j.position.copy(L.P[q]); j.scale.setScalar(j.userData.s * SS); });
    // 腿里的亮粒子
    const pa = sparkObj.geometry.attributes.position;
    L.spk.forEach((k, q) => {
      const a = L.P[k.seg], b = L.P[k.seg + 1], rr = [.09, .07, .05][k.seg] * SS * k.r;
      const x = lerp(a.x, b.x, k.t), y = lerp(a.y, b.y, k.t), z = lerp(a.z, b.z, k.t);
      pa.setXYZ(li * 60 + q, x + Math.cos(k.a + animT * .8) * rr, y + Math.sin(k.a * 1.7 + animT) * rr, z + Math.sin(k.a + animT * .8) * rr);
    });
  });
  sparkObj.geometry.attributes.position.needsUpdate = true;
}

/* ---------- 触须：从蜘蛛头部伸到词上的点线；丝线：蜘蛛走过的路 ---------- */
const TH = 16, TD = 26;
const threads = Array.from({length: TH}, () => ({on: false, w: null, g: 0, ret: false}));
function threadTo(w){ let t = threads.find(x => !x.on) || threads.reduce((a, b) => (a.g < b.g ? a : b)); Object.assign(t, {on: true, w, g: 0, ret: false}); }
function retractThreads(){ threads.forEach(t => { if (t.on) t.ret = true; }); }
function buildThreads(){
  threadObj = pointsObj(TH * TD); threadObj.renderOrder = 4;
  for (let i = 0; i < TH * TD; i++) setPt(threadObj, i, 0, -999, 0, [.85, .92, 1], .07, 15);
  world.add(threadObj);
  const cap = 3002, g = new THREE.BufferGeometry(); g.setAttribute('position', new THREE.BufferAttribute(new Float32Array(cap * 3), 3)); g.setDrawRange(0, 0);
  trailLine = new THREE.Line(g, new THREE.LineBasicMaterial({color: 0xe6f0ff, transparent: true, opacity: .45, blending: THREE.AdditiveBlending, depthWrite: false})); trailLine.frustumCulled = false; world.add(trailLine);
  pulseSpr = new THREE.Sprite(new THREE.SpriteMaterial({map: GLOW, color: 0xfff1e6, transparent: true, blending: THREE.AdditiveBlending, depthWrite: false})); pulseSpr.scale.setScalar(2.2); pulseSpr.visible = false; world.add(pulseSpr);
  for (let i = 0; i < 60; i++) { const s = new THREE.Sprite(new THREE.SpriteMaterial({map: GLOW, color: 0xffffff, transparent: true, blending: THREE.AdditiveBlending, depthWrite: false})); s.visible = false; world.add(s); cometSprites.push(s); }
}

function buildEngineeringRelations(){
  const max = 96;
  engineeringLinePos = new Float32Array(max * 6); engineeringLineCol = new Float32Array(max * 6);
  const geo = new THREE.BufferGeometry();
  geo.setAttribute('position', new THREE.BufferAttribute(engineeringLinePos, 3));
  geo.setAttribute('color', new THREE.BufferAttribute(engineeringLineCol, 3)); geo.setDrawRange(0, 0);
  engineeringLineObj = new THREE.LineSegments(geo, new THREE.LineBasicMaterial({vertexColors:true,transparent:true,opacity:.68,depthWrite:false,blending:THREE.AdditiveBlending}));
  engineeringLineObj.frustumCulled = false; world.add(engineeringLineObj);
}

function engineeringRelationsStep(){
  if (!engineeringLineObj || !engineeringState) return;
  const edges = engineeringState.edges.slice(0, 96); let n = 0;
  edges.forEach((edge, i) => {
    const a = clusterIndex(edge.sourceClusterId), b = clusterIndex(edge.targetClusterId);
    if (a < 0 || b < 0) return;
    const A = CL[a], B = CL[b], same = a === b, phase = ((i * 2.39996) % TAU);
    const ax = same ? A.x + Math.cos(phase) * A.R * .32 : A.x, az = same ? A.z + Math.sin(phase) * A.R * .24 : A.z;
    const bx = same ? B.x + Math.cos(phase + 1.5) * B.R * .32 : B.x, bz = same ? B.z + Math.sin(phase + 1.5) * B.R * .24 : B.z;
    engineeringLinePos.set([ax,A.cy+.4,az,bx,B.cy+.4,bz],n*6);
    const c = new THREE.Color(edge.active ? '#ffffff' : edge.color || '#62e3ff'), gain = edge.active ? 1.4 : .72;
    engineeringLineCol.set([c.r*gain,c.g*gain,c.b*gain,c.r*gain,c.g*gain,c.b*gain],n*6); n++;
  });
  engineeringLineObj.geometry.setDrawRange(0,n*2);
  engineeringLineObj.geometry.attributes.position.needsUpdate = true; engineeringLineObj.geometry.attributes.color.needsUpdate = true;
}
const PINK = hex3('#ff6fae'), GOLD3 = hex3('#ffd27a'), GOODC = hex3('#6ff0c0'), CYANC = hex3('#62e3ff');
function threadsStep(dt){
  const g = spider.g, H = tA[0].set(0, 1.08, HEAD.z + .55).applyMatrix4(g.matrixWorld);
  const pa = threadObj.geometry.attributes.position, ca = threadObj.geometry.attributes.aCol; let nOn = 0;
  threads.forEach((t, ti) => {
    if (t.on) { t.g = t.ret ? t.g - dt * 2.6 : Math.min(1, t.g + dt * 3.2); if (t.g <= 0) t.on = false; }
    if (t.on) nOn++;
    const w = t.w, p = w && wordPos(w), col = !w ? ICE : w.state === 'flag' || w.state === 'ask' ? PINK : w.state === 'fix' ? GOODC : w.state === 'lnk' ? CYANC : [.85, .92, 1];
    for (let j = 0; j < TD; j++) {
      const s = j / (TD - 1), o = ti * TD + j;
      if (!t.on || s > t.g) { pa.setXYZ(o, 0, -999, 0); continue; }
      const L = Math.hypot(p.x - H.x, p.z - H.z), arc = Math.sin(Math.PI * s) * Math.min(1, L * .1);
      pa.setXYZ(o, lerp(H.x, p.x, s), lerp(H.y, p.y, s) + arc, lerp(H.z, p.z, s)); ca.setXYZ(o, col[0], col[1], col[2]);
    }
  });
  pa.needsUpdate = true; ca.needsUpdate = true; tentacles = nOn;
  // 丝线
  const tp = trailLine.geometry.attributes.position, n = Math.min(trail.length, 3000), o = {};
  let L = 0, px = 0, py = 0, pz = 0, hit = null;
  for (let i = 0; i < n; i++) {
    trailAt(trail[i], o); tp.setXYZ(i, o.x, o.y + .06, o.z);
    if (i) L += Math.hypot(o.x - px, o.y - py, o.z - pz);
    px = o.x; py = o.y; pz = o.z;
  }
  if (n) { tp.setXYZ(n, spider.x, spider.y + .06, spider.z); }
  trailLenW = L;
  tp.needsUpdate = true; trailLine.geometry.setDrawRange(0, n ? n + 1 : 0); trailLine.material.opacity = .45 * trailFade;
  pulseSpr.visible = false;
}
let tentacles = 0;
function cometsDraw(){
  let si = 0; const o = {x: 0, y: 0, z: 0};
  comets.forEach(c => {
    for (let q = 0; q < 5 && si < cometSprites.length; q++, si++) {
      const u = clamp(c.t - q * .035, 0, 1), s = cometSprites[si]; cometAt(c, u, o);
      s.visible = true; s.position.set(o.x, o.y, o.z); s.material.color.set(c.col); s.material.opacity = q ? .55 - q * .1 : 1; s.scale.setScalar(c.size * (q ? 1.4 - q * .2 : 1.9));
    }
  });
  for (; si < cometSprites.length; si++) cometSprites[si].visible = false;
}

/* ---------- 镜头 ---------- */
const MODES = [{id: 'follow', zh: '跟随'}, {id: 'over', zh: '俯瞰'}, {id: 'tilt', zh: '斜看'}, {id: 'orbit', zh: '环绕'}];
const EL_OVER = 1.16;
let modeI = 0, baseAz = 0;
const cam = {pos: null, tgt: null, want: null, wantT: null, yaw: 0, pitch: 0, zoom: 1, userT: 0, focus: -1, frame: null};
let PRC = [], fitD = 50, offX = 0, offY = 0, W = 1, H = 1, narrow = false, bs = .5, BW = 1920, BH = 1080;
function camWant(t){
  const m = MODES[modeI].id; let az = baseAz, el = EL_OVER, r = fitD * cam.zoom, tx = 0, ty = 0, tz = 0;
  if (cam.frame) { tx=cam.frame.tx;ty=cam.frame.ty;tz=cam.frame.tz;r=cam.frame.r*cam.zoom;el=cam.frame.el;az+=cam.frame.az; }
  else if (cam.focus >= 0) { const c = CL[cam.focus]; tx = c.x; tz = c.z; ty = c.y0 + c.top * .5; r = Math.max(30, 10 / (.61 * (W / H) * .8)) * cam.zoom; el = .95; }
  else switch (m) {
    case 'over':   az += .04 * Math.sin(t * .05); break;
    case 'tilt':   az += .36 + .05 * Math.sin(t * .04); el = .7; r *= .86; break;
    case 'follow': {   // 读词时镜头框住整团星云（偏向蜘蛛），跳的时候紧跟蜘蛛
      const s = curSec(), c = s && crawl.phase === 'read' && !spider.air ? CL[s.ai] : null;
      tx = c ? lerp(c.x, spider.x, .4) : spider.x; tz = c ? lerp(c.z, spider.z, .4) : spider.z; ty = c ? c.y0 + c.top * .5 : spider.y * .5;
      r = Math.max(40, 14 / (.61 * (W / H) * .8)) * cam.zoom; el = 1.02; az += .14 * Math.sin(t * .05);
      // 回星核派单 / 接新单时拉回全景，看派单光沿丝线跑完整条路线
      if (crawl.phase === 'ship' || crawl.phase === 'rest' || crawl.phase === 'brief') { tx = 0; ty = 2; tz = 0; r = fitD * .6 * cam.zoom; el = 1.02; }
      break; }
    case 'orbit':  az += t * .04; el = .9; r *= .92; break;
  }
  az += cam.yaw; el = clamp(el + cam.pitch, .15, 1.45);
  cam.want.set(r * Math.sin(az) * Math.cos(el) + tx, r * Math.sin(el) + ty, r * Math.cos(az) * Math.cos(el) + tz);
  cam.wantT.set(tx, ty, tz);
}
const FIT_PTS = [];
{ const o = ORBITS[2], R = o.R; for (let i = 0; i < 36; i++) { const f = i / 36 * TAU, sn = Math.sin(f); FIT_PTS.push([Math.cos(f) * (o.ax + R * 1.05), 0, sn * (o.az + R * .55) - (sn < 0 ? R * .9 * -sn : 0)]); } }
function panelRects(){
  const hr = host.getBoundingClientRect(), out = [];
  SR.querySelectorAll('.board .dp, .board .hd .eb, .board .hd h1 > span, .board .hd .sub, .board .hd .sub2, .board .sec > *, .board .top, .board .tools, .board .sb').forEach(el => { const r = el.getBoundingClientRect(); if (r.width > 2) out.push([r.left - hr.left - 8, r.top - hr.top - 8, r.right - hr.left + 8, r.bottom - hr.top + 8]); });
  return out;
}
function fitCamera(){
  const rects = narrow ? [] : panelRects(), mg = narrow ? 6 : 8; PRC = rects;
  const v = new THREE.Vector3(), az = baseAz, el = EL_OVER;
  const oxs = narrow ? [0] : [-4, -3, -2, -1, 0, 1, 2, 3, 4].map(i => i * W * .02), oys = narrow ? [H / 2 - (64 + H - 150) / 2] : Array.from({length: 13}, (_, i) => (i - 6) * H * .022);
  let best = null;
  for (const ox of oxs) for (const oy of oys) {
    camera.setViewOffset(W, H, ox, oy, W, H); camera.updateProjectionMatrix();
    let lo = 8, hi = 400;
    for (let it = 0; it < 22; it++) {
      const D = (lo + hi) / 2;
      camera.position.set(D * Math.sin(az) * Math.cos(el), D * Math.sin(el), D * Math.cos(az) * Math.cos(el)); camera.lookAt(0, 0, 0); camera.updateMatrixWorld();
      let ok = true;
      for (const p of FIT_PTS) {
        v.set(p[0], p[1], p[2]).project(camera); const sx = (v.x + 1) / 2 * W, sy = (1 - v.y) / 2 * H;
        if (sx < mg || sx > W - mg || sy < (narrow ? 64 : mg) || sy > H - (narrow ? 150 : mg)) { ok = false; break; }
        for (const r of rects) if (sx > r[0] && sx < r[2] && sy > r[1] && sy < r[3]) { ok = false; break; }
        if (!ok) break;
      }
      if (ok) hi = D; else lo = D;
    }
    if (!best || hi < best.D - .01) best = {D: hi, ox, oy};
  }
  offX = best.ox; offY = best.oy; fitD = best.D;
  camera.setViewOffset(W, H, offX, offY, W, H); camera.updateProjectionMatrix();
}

/* ---------- 建场景（WebGL 不可用时只跑面板） ---------- */
try {
  if (!THREE) throw new Error('three.js 没加载');
  renderer = new THREE.WebGLRenderer({canvas: cv, antialias: true, powerPreference: 'high-performance'});
  renderer.outputColorSpace = THREE.SRGBColorSpace;
  renderer.toneMapping = THREE.NoToneMapping;
  renderer.setClearColor(0x03050c, 1);
  pr = Math.min(window.devicePixelRatio || 1, 1.75); renderer.setPixelRatio(pr);
  scene = new THREE.Scene();
  camera = new THREE.PerspectiveCamera(34, 16 / 9, .5, 600); scene.add(camera);
  world = new THREE.Group(); scene.add(world);
  GLOW = canvasTex(64, 64, (x, w) => { const g = x.createRadialGradient(32, 32, 0, 32, 32, 32); g.addColorStop(0, 'rgba(255,255,255,1)'); g.addColorStop(.25, 'rgba(255,255,255,.6)'); g.addColorStop(1, 'rgba(255,255,255,0)'); x.fillStyle = g; x.fillRect(0, 0, w, w); });
  buildNebulae(); buildCore(); buildStreaks(); buildSpider(); buildThreads(); buildEngineeringRelations();
  if (THREE.EffectComposer && THREE.UnrealBloomPass && THREE.RenderPass) {
    composer = new THREE.EffectComposer(renderer);
    composer.addPass(new THREE.RenderPass(scene, camera));
    bloom = new THREE.UnrealBloomPass(new THREE.Vector2(512, 512), .72, .5, .22); composer.addPass(bloom);
  }
  cam.pos = new THREE.Vector3(0, 60, 30); cam.tgt = new THREE.Vector3(); cam.want = new THREE.Vector3(); cam.wantT = new THREE.Vector3();
  glOK = true;
} catch (e) {
  console.error(e);
  $('#glFail').hidden = false;
}

/* ================= 5. HUD ================= */
const nr = $('#nr'), board = $('#board'), fitIn = $('#fitIn'), lblLayer = $('#lbls'), tip = $('#tip');
const clEls = AG.slice(0, 13).map((a, k) => {
  const el = document.createElement('div');
  if (k === 0) { el.className = 'core'; el.innerHTML = `<b>chief</b><i>总调度</i><small>LISTENING</small>`; }
  else { el.className = 'cl idle'; el.style.setProperty('--c', a.col); el.innerHTML = `<b>${a.k.toLowerCase()}</b><i>${a.zh}</i><small>—</small>`; }
  lblLayer.appendChild(el); return el;
});
const wtPool = Array.from({length: 40}, () => { const el = document.createElement('div'); el.className = 'wt'; el.style.display = 'none'; el.style.pointerEvents='auto'; listen(el,'click',e=>{e.stopPropagation();const id=el.dataset.nodeId;if(id&&options&&options.onNodeSelect)options.onNodeSelect(id);});listen(el,'dblclick',e=>{e.stopPropagation();const id=el.dataset.nodeId;if(id){focusById(id);if(options&&options.onNodeSelect)options.onNodeSelect(id);}}); lblLayer.appendChild(el); return {el, w: null, key: ''}; });
const logEl = $('#log'), secsEl = $('#secs'), tabsEl = $('#tabs'), codeEl = $('#code');
const VB = {crawl: 'crawl', walk: 'jump', read: 'read', link: 'link', flag: 'flag', ask: 'ask', fix: 'fix', ship: 'ship', load: 'load'};
function renderLog(){
  if (!logDirty) return; logDirty = false;
  logEl.innerHTML = logs.slice(0, 11).map(l => `<li><span class="tm">${l.tm}</span><span class="vb ${l.verb}">${VB[l.verb] || l.verb}</span><span class="tx">${l.text}</span></li>`).join('');
}
function secState(si){ if (!task) return 'w'; if (si < crawl.sec || (task.sections[si] && task.sections[si].done)) return 'd'; if (si === crawl.sec && (crawl.phase === 'read' || crawl.phase === 'walk')) return 'c'; return 'w'; }
function renderTabs(){
  if (!task) return;
  const cells = [`<i class="${crawl.phase === 'brief' ? 'c' : 'd'}" style="--c:#f4f7ff">00 brief</i>`]
    .concat(task.sections.map((s, i) => { const st = secState(i); return `<i class="${st === 'w' ? '' : st}" style="--c:${AG[s.ai].col}">${pad(i + 1)} ${AG[s.ai].k.toLowerCase()}</i>`; }))
    .concat([`<i class="${crawl.phase === 'ship' || crawl.phase === 'return' ? 'c' : crawl.phase === 'rest' ? 'd' : ''}" style="--c:#ffb48f">${pad(task.sections.length + 1)} ship</i>`]);
  const h = cells.join(''); if (tabsEl._h !== h) { tabsEl.innerHTML = h; tabsEl._h = h; }
}
function renderSec(){
  if (!task) return;
  const ph = crawl.phase, s = curSec(), sec = $('#sec');
  $('#secT').innerHTML = `TASK ${task.id} · <b>${task.name}</b> · ${task.sections.length} 个工区 · ${task.total} 个词`;
  let no, name, zh, sub, col;
  if (ph === 'brief') { no = '00'; name = 'BRIEF'; zh = '读需求'; col = '#f4f7ff'; sub = `CHIEF 收到新需求，星云蛛准备起跳 · 初始评分 ${Math.round(task.shown)}`; }
  else if (s && (ph === 'walk' || ph === 'read')) {
    const a = AG[s.ai], v = s.words.filter(w => w.kind === 'vague' && w.state !== 'idle'), fx = v.filter(w => w.state === 'fix').length;
    no = pad(crawl.sec + 1); name = a.k; zh = `${a.zh} · ${a.role}`; col = a.col;
    sub = ph === 'walk' ? `星云蛛正在跳向 ${a.k.toLowerCase()} · ${s.words.length} 个词待读` : `已读 ${s.read} / ${s.words.length}` + (v.length ? ` · <em>模糊 ${v.length}</em>` + (fx ? ` · <u>已补齐 ${fx}</u>` : '') : ' · 没有模糊词') + (s.done ? ' · 审完' : ' · 审查中');
  } else { no = pad(task.sections.length + 1); name = 'SHIP'; zh = '派单'; col = '#ffb48f'; sub = ph === 'return' ? '审完，回星核汇总' : openFlags() ? `等 CHIEF 答完 ${openFlags()} 个问题` : `评分 ${task.final || Math.round(task.shown)} · 沿丝线派单 → ${task.path.map(i => AG[i].k).join(' → ')}`; }
  $('#secNo').textContent = no; $('#secName').textContent = name; $('#secZh').textContent = zh; $('#secS').innerHTML = sub; sec.style.setProperty('--c', col);
}
function renderStrip(){
  if (!task) return;
  $('#sTen').textContent = tentacles; $('#sRead').textContent = `${task.reads}/${task.total}`; $('#sLink').textContent = task.links; $('#sFlag').textContent = task.flags;
  $('#sT').textContent = (simT - task.t0).toFixed(2); $('#sFrame').textContent = pad(frameN % 10000, 4);
}
function renderSecs(){
  if (!task) return;
  const rows = [`<div class="${crawl.phase === 'brief' ? 'c' : ''}" style="--c:#f4f7ff"><span>brief</span><u><s style="width:${crawl.phase === 'brief' ? Math.min(100, crawl.t / 2.2 * 100) : 100}%"></s></u><em>${task.total}</em></div>`]
    .concat(task.sections.map((s, i) => { const st = secState(i); return `<div class="${st === 'c' ? 'c' : st === 'w' ? 'w' : ''}" style="--c:${AG[s.ai].col}"><span>${AG[s.ai].k.toLowerCase()}</span><u><s style="width:${s.read / s.words.length * 100}%"></s></u><em>${s.read}/${s.words.length}</em></div>`; }));
  const h = rows.join(''); if (secsEl._h !== h) { secsEl.innerHTML = h; secsEl._h = h; }
  $('#secMeta').textContent = `${task.sections.filter(s => s.done).length} / ${task.sections.length} 审完`;
}
function renderCounters(){
  if (!task) return;
  const wpm = readTimes.length / 6 * 60;
  $('#logMeta').textContent = `${(readTimes.length / 6).toFixed(1)} w/s`;
  $('#wpm').innerHTML = `${Math.round(wpm)}<small>/m</small>`;
  $('#cRead').textContent = task.reads; $('#cLink').textContent = task.links; $('#cFlag').textContent = task.flags; $('#cFix').textContent = task.fixes; $('#cGuess').textContent = 0;
  $('#heatMeta').textContent = `${task.reads} / ${task.total} 词`;
  const claims = task.fixes + task.links, owners = task.sections.filter((s, i) => i < crawl.sec || s.done).length + (crawl.phase === 'read' ? 1 : 0), checks = Math.round(task.reads / 3);
  $('#nClaim').textContent = claims; $('#nOwn').textContent = owners; $('#nChk').textContent = checks;
  $('#nClaimB').style.width = Math.min(100, claims / 10 * 100) + '%'; $('#nOwnB').style.width = Math.min(100, owners / task.sections.length * 100) + '%'; $('#nChkB').style.width = Math.min(100, checks / 12 * 100) + '%';
  $('#openN').textContent = openFlags();
  $('#codeMeta').textContent = `${task.id} · ${crawl.phase}`;
  $('#sbShip').textContent = fmt(shipped); $('#sbWords').textContent = fmt(wordsToday); $('#sbFix').textContent = fmt(fixesToday);
  $('#sbAvg').textContent = (scoreHist.reduce((a, b) => a + b, 0) / scoreHist.length).toFixed(1);
  $('#mTask').textContent = task.name; $('#mScore').textContent = Math.round(task.shown); $('#mShip').textContent = fmt(shipped); $('#mCap').textContent = capText;
}
/* 爬虫脚本：每单开头重新敲一遍，当前在干的那一行高亮 */
const CODE_SRC = () => [
  [['cm', '# crawler.py · 逐字审需求，先问再做']],
  [['', 'brief  = '], ['fn', 'load'], ['', '('], ['st', `"${task ? task.id + ' ' + task.name : '—'}"`], ['', ')']],
  [['', 'spider = '], ['fn', 'Crawler'], ['', '(legs=8, tentacles=16)']],
  [['kw', 'for'], ['', ' section '], ['kw', 'in'], ['', ' brief.sections:']],
  [['', '    spider.'], ['fn', 'jump_to'], ['', '(section.owner)']],
  [['', '    '], ['kw', 'for'], ['', ' word '], ['kw', 'in'], ['', ' spider.'], ['fn', 'read'], ['', '(section):']],
  [['', '        kind = '], ['fn', 'classify'], ['', '(word)']],
  [['', '        '], ['kw', 'if'], ['', ' kind == '], ['st', '"vague"'], ['', ':']],
  [['', '            '], ['fn', 'ask'], ['', '(CHIEF, word)   '], ['cm', '# 不猜']],
  [['', '        '], ['kw', 'else'], ['', ':']],
  [['', '            '], ['fn', 'link'], ['', '(word, section.next)']],
  [['', 'score = '], ['fn', 'spec_score'], ['', '(brief)   '], ['cm', `# 过 ${PASS} 才派单`]],
  [['kw', 'if'], ['', ` score >= ${PASS}: `], ['fn', 'dispatch'], ['', '(brief)']]
];
const esc = s => s.replace(/&/g, '&amp;').replace(/</g, '&lt;');
function renderCode(){
  const src = CODE_SRC(); let left = codeChars, h = '';
  src.forEach((line, li) => {
    let txt = '', len = 0;
    for (const [cls, t] of line) { const take = Math.max(0, Math.min(t.length, left)); left -= take; len += take; if (take) txt += cls ? `<span class="${cls}">${esc(t.slice(0, take))}</span>` : esc(t.slice(0, take)); }
    const full = line.reduce((s, x) => s + x[1].length, 0), typing = len > 0 && len < full;
    if (len === 0 && li > 0 && left <= 0) return;
    h += `<li class="${li + 1 === codeHL && left > 0 ? 'hl' : ''}${typing ? ' cur' : ''}">${txt || ' '}</li>`;
  });
  if (codeEl._h !== h) { codeEl.innerHTML = h; codeEl._h = h; }
}
function clockTick(){ $('#clock').textContent = hms(new Date()); }

/* ---------- 底部画布：雷达 / 热力格 / 评分 ---------- */
const radX = $('#radC').getContext('2d'), heatX = $('#heatC').getContext('2d'), spX = $('#spC').getContext('2d'), gX = $('#gaugeC').getContext('2d');
let radV = AXES.map(() => .2);
function axesNow(){
  if (!task) return AXES.map(() => .2);
  const t = task, prog = t.reads / t.total, vt = Math.max(1, t.vagueTotal), fx = t.fixes / vt, open = openFlags();
  return [prog, .25 + .75 * fx, .2 + .55 * fx + .25 * prog, (t.sections.filter(s => s.done).length + (crawl.phase === 'read' ? .5 : 0)) / t.sections.length, .3 + .7 * Math.min(1, fx * 1.2), 1 - open / (vt + 1) - (1 - prog) * .35, Math.min(1, t.links / Math.max(1, t.total * .3)) * .6 + prog * .4].map(v => clamp(v, .08, 1));
}
function drawRadar(){
  const X = radX, Wc = X.canvas.width, Hc = X.canvas.height, cx = Wc / 2, cy = Hc / 2 + 6, R = Hc / 2 - 22, n = AXES.length;
  const want = axesNow(); radV = radV.map((v, i) => v + (want[i] - v) * .25);
  X.clearRect(0, 0, Wc, Hc); X.lineWidth = 1.5;
  for (let ring = 1; ring <= 4; ring++) { X.beginPath(); for (let i = 0; i <= n; i++) { const a = -HP + i / n * TAU, r = R * ring / 4; i ? X.lineTo(cx + Math.cos(a) * r, cy + Math.sin(a) * r) : X.moveTo(cx + Math.cos(a) * r, cy + Math.sin(a) * r); } X.strokeStyle = 'rgba(150,190,255,.12)'; X.stroke(); }
  X.font = '500 17px "Noto Sans SC", sans-serif'; X.textAlign = 'center'; X.textBaseline = 'middle';
  for (let i = 0; i < n; i++) { const a = -HP + i / n * TAU; X.beginPath(); X.moveTo(cx, cy); X.lineTo(cx + Math.cos(a) * R, cy + Math.sin(a) * R); X.strokeStyle = 'rgba(150,190,255,.12)'; X.stroke(); X.fillStyle = '#7f8ca8'; X.fillText(AXES[i], cx + Math.cos(a) * (R + 16) * 1.25, cy + Math.sin(a) * (R + 12)); }
  X.beginPath(); radV.forEach((v, i) => { const a = -HP + i / n * TAU; i ? X.lineTo(cx + Math.cos(a) * R * v, cy + Math.sin(a) * R * v) : X.moveTo(cx + Math.cos(a) * R * v, cy + Math.sin(a) * R * v); }); X.closePath();
  const ok = task && task.shown >= PASS; X.fillStyle = ok ? 'rgba(111,240,192,.22)' : 'rgba(98,227,255,.18)'; X.fill(); X.strokeStyle = ok ? '#6ff0c0' : '#62e3ff'; X.lineWidth = 2.5; X.shadowColor = X.strokeStyle; X.shadowBlur = 10; X.stroke(); X.shadowBlur = 0;
}
function drawHeat(){
  const X = heatX, Wc = X.canvas.width, Hc = X.canvas.height; X.clearRect(0, 0, Wc, Hc);
  if (!task) return;
  const rows = task.sections, cols = 14, lw = 64, cw = (Wc - lw) / cols, rh = Math.min(38, (Hc - 6) / Math.max(rows.length, 4));
  X.font = '500 17px "JetBrains Mono", monospace'; X.textBaseline = 'middle'; X.textAlign = 'left';
  rows.forEach((s, r) => {
    const y = r * rh + 3; X.fillStyle = AG[s.ai].col; X.globalAlpha = secState(r) === 'w' ? .45 : 1; X.fillText(AG[s.ai].k.slice(0, 3), 0, y + rh / 2); X.globalAlpha = 1;
    for (let c = 0; c < cols; c++) {
      const w = s.words[c], x = lw + c * cw;
      let col = 'rgba(150,190,255,.07)';
      if (w) col = w.state === 'idle' ? 'rgba(150,190,255,.14)' : w.state === 'flag' || w.state === 'ask' ? '#ff6fae' : w.state === 'fix' ? '#6ff0c0' : w.state === 'lnk' ? '#62e3ff' : AG[s.ai].col;
      X.fillStyle = col; X.globalAlpha = w && w.state === 'read' ? .8 : 1; X.fillRect(x + 2, y + 3, cw - 4, rh - 6); X.globalAlpha = 1;
    }
  });
}
function drawScore(){
  // 评分曲线
  let X = spX, Wc = X.canvas.width, Hc = X.canvas.height; X.clearRect(0, 0, Wc, Hc);
  if (!task) return;
  const hs = task.hist.length ? task.hist : [[simT, task.shown]], t0 = hs[0][0], t1 = Math.max(t0 + 20, hs.at(-1)[0]);
  const py = v => Hc - 4 - v / 100 * (Hc - 8);
  X.strokeStyle = 'rgba(255,210,122,.25)'; X.setLineDash([6, 6]); X.beginPath(); X.moveTo(0, py(PASS)); X.lineTo(Wc, py(PASS)); X.stroke(); X.setLineDash([]);
  X.beginPath(); hs.forEach(([t, v], i) => { const x = (t - t0) / (t1 - t0) * Wc; i ? X.lineTo(x, py(v)) : X.moveTo(x, py(v)); }); X.strokeStyle = '#ffd27a'; X.lineWidth = 3; X.shadowColor = '#ffd27a'; X.shadowBlur = 8; X.stroke(); X.shadowBlur = 0;
  // 仪表
  X = gX; Wc = X.canvas.width; Hc = X.canvas.height; X.clearRect(0, 0, Wc, Hc);
  const cx = Wc / 2, cy = Hc - 14, R = Math.min(Wc / 2, Hc) - 22, a0 = Math.PI * .85, a1 = Math.PI * 2.15, v = task.shown / 100;
  X.lineCap = 'round'; X.lineWidth = 16; X.strokeStyle = 'rgba(150,190,255,.1)'; X.beginPath(); X.arc(cx, cy, R, a0, a1); X.stroke();
  const ok = task.shown >= PASS, col = ok ? '#6ff0c0' : task.shown >= 60 ? '#ffd27a' : '#ff6fae';
  X.strokeStyle = col; X.shadowColor = col; X.shadowBlur = 14; X.beginPath(); X.arc(cx, cy, R, a0, a0 + (a1 - a0) * v); X.stroke(); X.shadowBlur = 0;
  const ap = a0 + (a1 - a0) * PASS / 100; X.lineWidth = 3; X.lineCap = 'butt'; X.strokeStyle = 'rgba(255,255,255,.6)'; X.beginPath(); X.moveTo(cx + Math.cos(ap) * (R - 14), cy + Math.sin(ap) * (R - 14)); X.lineTo(cx + Math.cos(ap) * (R + 14), cy + Math.sin(ap) * (R + 14)); X.stroke();
  X.fillStyle = '#eaf1ff'; X.font = '700 60px "JetBrains Mono", monospace'; X.textAlign = 'center'; X.textBaseline = 'alphabetic'; X.fillText(Math.round(task.shown), cx, cy - 18);
  X.fillStyle = '#7f8ca8'; X.font = '500 17px "JetBrains Mono", monospace'; X.fillText('spec score', cx, cy + 6);
}
function drawPanels(){ drawRadar(); drawHeat(); drawScore(); }

/* ================= 6. 每帧画面 ================= */
function updateScene(dt){
  U.time.value = animT;
  // 星云亮度：负载 + 闪光 + 正在被审的那团更亮
  const s = curSec(), inTask = externalMode && engineeringState ? new Set(engineeringState.nodes.map(n=>clusterIndex(n.clusterId)).filter(k=>k>=0)) : task ? new Set(task.path) : new Set();
  for (let k = 0; k <= 12; k++) {
    let b = k === 0 ? .9 + flash[0] * .4 : .55 + load[k] * .28 + flash[k] * .4 + (inTask.has(k) ? .1 : 0);
    // 星云蛛趴着的那团：轻轻闪烁，提示它在这里干活
    if (!externalMode && k === spider.a && !spider.air && k > 0) b *= .78 + .22 * (.5 + .5 * Math.sin(animT * 13)) * (.7 + .3 * Math.sin(animT * 3.1));
    U.b.value[k] = b; flash[k] *= Math.exp(-dt * 2.2);
  }
  for (let k = 1; k <= 12; k++) { const c = CL[k], gp = cloudG[k]; gp.position.set(c.x, 0, c.z); gp.rotation.y = c.rot; }
  U.b.value[13] = 1; U.b.value[14] = .62; U.b.value[15] = 1.3;
  hazes.forEach(h => { h.material.opacity = h.userData.o * Math.min(1.7, U.b.value[h.userData.k] / .6) * (h.userData.k === spider.a && !spider.air ? .7 : 1); });
  if (!U.sp.value) U.sp.value = new THREE.Vector4();
  U.sp.value.set(externalMode?999:spider.x, externalMode?999:spider.y, externalMode?999:spider.z, externalMode ? .001 : (spider.air ? .001 : 2.1 * SS));
  coreBall.children.forEach(m => m.rotateOnAxis(m.userData.ax, m.userData.sp * dt));
  coreBall.scale.setScalar(externalMode ? .68 : 1);ringsG.scale.setScalar(externalMode ? .78 : 1);
  coreBall.rotation.y += dt * .08;
  coreBall.children.forEach(m => { m.material.uniforms.uA.value = Math.min(1.4, (m.userData.a0 || (m.userData.a0 = m.material.uniforms.uA.value)) * (1 + flash[0] * .5)); });
  ringsG.children.forEach(h => { const u = h.userData; const a = animT * u.sp; u.dot.position.set(Math.cos(a) * u.r, 0, Math.sin(a) * u.r); });
  ringsG.rotation.y += dt * .03;
  if(!externalMode){abdBall.children.forEach(m => m.rotateOnAxis(m.userData.ax, m.userData.sp * 1.6 * dt)); abdBall.rotation.y += dt * .25;}
  // 星云蛛本体
  const g = spider.g;
  if(!externalMode){g.position.set(spider.x, spider.y + Math.abs(Math.sin(spider.bob)) * (spider.walking ? .07 : .03), spider.z);
  qN.setFromUnitVectors(UPV, tA[0].set(spider.n[0], spider.n[1], spider.n[2]).normalize()); qY.setFromAxisAngle(UPV, spider.head);
  qP.setFromAxisAngle(XV, spider.air && spider.jump ? (spider.jump.t - .5) * .5 : 0); g.quaternion.copy(qN).multiply(qY).multiply(qP);
  SS += ((spider.a === 0 && !spider.air ? 1.5 : 1) * S - SS) * Math.min(1, dt * 4);
  const sq = spider.land; g.scale.set(SS * (1 + .14 * sq), SS * (1 - .24 * sq), SS * (1 + .14 * sq));
  spider.shadow.scale.setScalar(4.4 * SS); spider.shadow.position.set(spider.x, spider.y + .1, spider.z); spider.shadow.material.opacity = spider.air ? .25 : .8;
  const bl = (animT % 4.2) < .12 ? .25 : 1; spider.eyes.forEach(e => e.scale.set(.5, .5 * bl, 1));
  legsStep(dt); threadsStep(dt);}
  cometsDraw(); engineeringRelationsStep();
}

/* ---------- 拔取的信息小框体：读到的词 → 爬取日志 / 读词热力；模糊 → 评分；补齐 → 需求雷达；连线 → 章节 ---------- */
let ffing = false, chipN = 0;
const CHIP_TO = {flag: '.p-score', fix: '.p-rad', link: '.p-sec'};
function flyChip(w, kind){
  const nxt = task && task.sections[w.sec + 1];
  const col = kind === 'flag' ? '#ff6fae' : kind === 'fix' ? '#6ff0c0' : kind === 'link' ? '#62e3ff' : AG[w.ai].col;
  const html = kind === 'flag' ? `⚑ VAGUE<i>${w.w}</i>` : kind === 'fix' ? `✓ FIX<i>${w.fix}</i>` : kind === 'link' ? `→ ${nxt ? AG[nxt.ai].k : 'NEXT'}<i>${w.w}</i>` : `${AG[w.ai].k.slice(0, 4)}<i>${w.w}</i>`;
  flyFrom(wordPos(w), html, col, CHIP_TO[kind] || (Math.random() < .55 ? '.p-log' : '.p-heat'));
}
function flyFrom(p, html, col, sel, big){
  if (ffing || narrow || !glOK || host.hidden || document.hidden || chipN >= 44) return;
  v3.set(p.x, p.y, p.z).project(camera); if (v3.z > 1 || Math.abs(v3.x) > 1.05 || Math.abs(v3.y) > 1.05) return;
  const x0 = (v3.x + 1) / 2 * W, y0 = (1 - v3.y) / 2 * H;
  const pn = $(sel); if (!pn) return;
  const hr = host.getBoundingClientRect(), r = pn.getBoundingClientRect();
  const x1 = r.left - hr.left + r.width * rnd(.2, .8), y1 = r.top - hr.top + r.height * rnd(.25, .55), sc = clamp(bs * 1.05, .62, 1.2) * (big ? 1.15 : 1);
  const el = document.createElement('div'); el.className = 'chip' + (big ? ' big' : ''); el.style.setProperty('--c', col); el.innerHTML = html;
  lblLayer.appendChild(el); chipN++;
  const mx = lerp(x0, x1, .35) + rnd(-90, 90) * sc, my = Math.min(y0, y1) - rnd(20, 70) * sc;
  const T = (x, y, k, o, e, f) => ({transform: `translate(${x.toFixed(1)}px,${y.toFixed(1)}px) translate(-50%,-50%) scale(${k.toFixed(3)})`, opacity: o, easing: e, offset: f});
  const an = el.animate([T(x0, y0, .3 * sc, 0, 'ease-out', 0), T(x0, y0 - 26 * sc, sc * 1.05, 1, 'ease-in-out', .16), T(mx, my, sc, 1, 'cubic-bezier(.55,0,.9,.45)', .44), T(x1, y1, sc * .45, .1, 'linear', 1)],
    {duration: 720, fill: 'forwards'});
  an.onfinish = () => {
    el.remove(); chipN--;
    pn.animate([{borderColor: col, boxShadow: `0 0 0 1px ${col} inset, 0 0 26px -6px ${col}`}, {borderColor: 'rgba(140,185,255,.2)', boxShadow: 'inset 0 1px 0 rgba(190,215,255,.07), 0 12px 30px rgba(0,0,0,.45)'}], {duration: 520, easing: 'ease-out'});
  };
}

/* ---------- 浮层：星云标签 / 词标签 / 星核状态 ---------- */
function project(x, y, z){ v3.set(x, y, z).project(camera); return [(v3.x + 1) / 2 * W, (1 - v3.y) / 2 * H, v3.z]; }
function placeOverlays(){
  if (!glOK || narrow) return;
  const sc = clamp(bs * 1.05, .62, 1.2) * (cam.focus >= 0 ? 1.25 : MODES[modeI].id === 'follow' ? 1.12 : 1);
  const s = curSec();
  for (let k = 1; k <= 12; k++) {
    const c = CL[k], el = clEls[k], [x, y, z] = project(c.x - c.R * .5, c.y0 + c.top * .4, c.z - c.R * .86);
    if (z > 1) { el.style.display = 'none'; continue; }
    el.style.display = '';
    const idx = task ? task.path.indexOf(k) : -1, sec = idx >= 0 ? task.sections[idx] : null;
    let cls = 'cl idle', txt = `待命 · 负载 ${Math.round(load[k] * 100)}%`;
    if (externalMode && engineeringState) {
      const nodes=engineeringState.nodes.filter(n=>clusterIndex(n.clusterId)===k),active=nodes.some(n=>n.active);
      if(!nodes.length){el.style.display='none';continue;}
      cls=active?'cl on':nodes.length?'cl queue':'cl idle'; txt=nodes.length?`${nodes.length} 个真实实体${active?' · 当前命中':''}`:'无查询命中';
    } else if (sec) {
      if (s === sec && crawl.phase === 'read') { cls = 'cl on'; txt = `${sec.read}/${sec.words.length} 词 · 审查中`; }
      else if (sec.done) { const v = sec.words.filter(w => w.kind === 'vague').length; cls = 'cl done'; txt = `${sec.words.length}/${sec.words.length} 词 · 审完` + (v ? ` · 补齐 ${v}` : ''); }
      else { cls = 'cl queue'; txt = `${sec.words.length} 词 · 待审`; }
    }
    if (el.className !== cls) el.className = cls;
    const sm = el.lastChild; if (sm.textContent !== txt) sm.textContent = txt;
    const lw = (el.offsetWidth || 120) * sc, lh = 34 * sc, under = PRC.some(r => x + lw > r[0] && x < r[2] && y > r[1] && y - lh < r[3]);
    el.style.setProperty('--f', under ? '.12' : '1');
    el.style.transform = `translate(${x.toFixed(1)}px,${y.toFixed(1)}px) translateY(-100%) scale(${sc.toFixed(3)})`;
  }
  // 星核
  { const el = clEls[0], [x, y] = project(0, CORE_Y, -7.4), sm = el.lastChild;
    let txt = 'LISTENING', cls = '';
    if (externalMode && engineeringState) { txt=`KG ${engineeringState.status} · ${engineeringState.nodes.length}N/${engineeringState.edges.length}R`; cls=engineeringState.status==='ERROR'||engineeringState.status==='UNAVAILABLE'?'ans':'ship'; }
    else if (coreSay.t > 0) { txt = coreSay.txt; cls = coreSay.txt.startsWith('SHIP') ? 'ship' : 'ans'; }
    else if (crawl.phase === 'brief' && task) { txt = `PARSING ${task.id}`; }
    if (sm.textContent !== txt) sm.textContent = txt; if (sm.className !== cls) sm.className = cls;
    el.style.transform = `translate(${x.toFixed(1)}px,${y.toFixed(1)}px) translate(-50%,-100%) scale(${sc.toFixed(3)})`; }
  // 词标签：当前章节 + 刚审完的章节（渐隐）
  const show = [];
  if (externalMode && engineeringState) [...engineeringState.nodes].sort((a,b)=>Number(b.active)-Number(a.active)||a.slot-b.slot).slice(0,cam.focus>=0?24:18).forEach(n=>{
    const ai=clusterIndex(n.clusterId); if(ai<1)return;
    show.push({w:`${n.nodeType} · ${n.label}`,kind:'engineering',state:n.active?'lnk':'read',f:1,ai,slot:n.slot,sec:-99,externalId:n.id});
  });
  else if (task) task.sections.forEach((sec, si) => sec.words.forEach(w => { if (w.state !== 'idle' && w.f > .02 && (si === crawl.sec || si === crawl.sec - 1 || crawl.phase === 'ship' || crawl.phase === 'rest' || crawl.phase === 'return')) show.push(w); }));
  if (!externalMode && crawl.phase !== 'read' && crawl.phase !== 'walk') { /* 回星核后只留模糊词的结果 */ for (let i = show.length - 1; i >= 0; i--) if (show[i].kind !== 'vague') show.splice(i, 1); }
  else if (!externalMode) { const cur = curSec(), recent = cur ? cur.words.slice(Math.max(0, crawl.wi - 6), crawl.wi) : []; for (let i = show.length - 1; i >= 0; i--) { const w = show[i]; if (w.kind !== 'vague' && w.state !== 'lnk' && !recent.includes(w)) show.splice(i, 1); } }
  const placed = [];
  show.slice(0, wtPool.length).forEach((w, i) => {
    const P = wtPool[i], p = wordPos(w), [x, y, z] = project(p.x, p.y, p.z);
    if (z > 1) return;
    const key = w.w + w.state;
    if (P.key !== key) {
      P.key = key;
      P.el.className = 'wt' + (w.state === 'flag' ? ' flag' : w.state === 'ask' ? ' ask' : w.state === 'fix' ? ' fix' : w.state === 'lnk' ? ' lnk' : '');
      if(w.kind==='engineering')P.el.textContent=w.w;
      else P.el.innerHTML = w.state === 'flag' ? `${w.w} ⚑ 模糊` : w.state === 'ask' ? `${w.w} ? 问 CHIEF` : w.state === 'fix' ? `<s>${w.w}</s>${w.fix}` : w.state === 'lnk' ? `${w.w} → ${AG[(task.sections[w.sec + 1] || task.sections[w.sec]).ai].k.toLowerCase()}` : w.w;
    }
    P.el.dataset.nodeId = w.externalId || '';
    P.el.style.display = ''; P.el.style.setProperty('--f', (w.f * (w.sec === crawl.sec || crawl.phase !== 'read' ? 1 : .55)).toFixed(2));
    placed.push({P, x, y, w: P.el.offsetWidth * sc, h: 20 * sc});
  });
  for (let i = placed.length; i < wtPool.length; i++) if (wtPool[i].el.style.display !== 'none') { wtPool[i].el.style.display = 'none'; wtPool[i].key = ''; wtPool[i].el.dataset.nodeId=''; }
  placed.sort((a, b) => a.y - b.y); const done = [];
  const hr = host.getBoundingClientRect();
  for (let k = 0; k <= 12; k++) { const el = clEls[k]; if (el.style.display === 'none') continue; const r = el.getBoundingClientRect(); if (r.width < 2) continue; done.push({l: r.left - hr.left, r: r.right - hr.left, t: r.top - hr.top, b: r.bottom - hr.top}); }
  PRC.forEach(r => done.push({l: r[0], r: r[2], t: r[1], b: r[3]}));
  // 词标签也让开星云蛛本体，别把它盖住
  if(!externalMode){ const [sx, sy] = project(spider.x, spider.y + .5 * SS / S, spider.z), [ex] = project(spider.x + 1.6 * SS, spider.y + .5 * SS / S, spider.z), rr = Math.max(24, Math.abs(ex - sx)); done.push({l: sx - rr, r: sx + rr, t: sy - rr * .85, b: sy + rr * .7}); }
  const off = 8 * sc, minY = 8;
  placed.forEach(q => {
    let ty = q.y;
    const l = q.x - q.w / 2, r = q.x + q.w / 2;
    for (let it = 0; it < 6; it++) { const t = ty - q.h - off, b = ty - off; const hit = done.find(o => l < o.r + 3 && r > o.l - 3 && t < o.b + 2 && b > o.t - 2); if (!hit) break; const up = hit.t - 3 + off; ty = up - q.h - off < minY || hit.t < H * .14 ? hit.b + 3 + q.h + off : up; }
    q.ty = ty; done.push({l, r, t: ty - q.h - off, b: ty - off});
    const P = q.P; P.dy = P.dy == null ? ty - q.y : P.dy + (ty - q.y - P.dy) * .25;
    P.el.style.transform = `translate(${(q.x - q.w / 2).toFixed(1)}px,${(q.y + P.dy - q.h - 8 * sc).toFixed(1)}px) scale(${sc.toFixed(3)})`;
    P.el.style.transformOrigin = '0 0';
  });
}

/* ================= 7. 主循环 ================= */
let uiAcc = 0, panAcc = 0, lastNow = performance.now();
let fps = 60, fpsN = 0, fpsT = 0, lowT = 0;
function frame(now){
  scheduleFrame(frame);
  if (host.hidden || document.hidden) { lastNow = now; return; }
  const real = (now - lastNow) / 1000, dt = Math.min(.1, real); lastNow = now;
  simStep(dt); animT += dt; frameN++; coreSay.t -= dt;
  if (codeChars < 2000) codeChars += dt * 90;
  uiAcc += dt;
  if (uiAcc >= .2) { uiAcc = 0; if (externalMode) renderEngineeringHud(); else { renderLog(); renderTabs(); renderSec(); renderStrip(); renderSecs(); renderCounters(); renderCode(); } }
  if ((panAcc += dt) >= .12 && !narrow) { panAcc = 0; if (!externalMode) drawPanels(); }
  if (!glOK) return;
  camStep(dt);
  updateScene(dt);
  placeOverlays();
  if (composer) composer.render(); else renderer.render(scene, camera);
  fpsN++; fpsT += Math.min(real, 2);
  if (fpsT >= 1) {
    fps = Math.round(fpsN / fpsT); fpsN = 0; fpsT = 0;
    if (fps < 30) lowT++; else lowT = 0;
    if (lowT >= 3) { lowT = 0; if (pr > 1) { pr = 1; layout(); } else if (pr > .75) { pr = .75; layout(); } else if (composer) { composer = null; } }
  }
  if (hover >= 0 && !tip.hidden) showTip(hover);
}
function camStep(dt){
  if (cam.userT > 0) cam.userT -= dt; else { cam.yaw *= Math.exp(-dt * .6); cam.pitch *= Math.exp(-dt * .6); }
  camWant(animT);
  const kk = 1 - Math.exp(-dt * (MODES[modeI].id === 'follow' && cam.focus < 0 ? (spider.air ? 4.2 : 2.6) : 1.6));
  cam.pos.lerp(cam.want, kk); cam.tgt.lerp(cam.wantT, kk);
  camera.position.copy(cam.pos); camera.lookAt(cam.tgt);
}

/* ---------- 尺寸 ---------- */
function layout(){
  if (host.hidden || host.clientWidth < 2) return;
  const r = host.getBoundingClientRect();
  W = Math.max(1, r.width); H = Math.max(1, r.height);
  narrow = W < 760 || W / H < 1.05;
  nr.classList.toggle('narrow', narrow); lblLayer.style.display = narrow ? 'none' : '';
  const fr = fitIn.getBoundingClientRect();
  bs = Math.min(fr.width / 1920, fr.height / 1080) || .2;
  BW = fr.width / bs; BH = fr.height / bs;
  board.style.width = BW + 'px'; board.style.height = BH + 'px';
  board.style.setProperty('--s', bs);
  if (!glOK) return;
  baseAz = narrow && W / H < 1 ? HP : 0;
  renderer.setPixelRatio(pr); renderer.setSize(W, H, false);
  if (composer) { composer.setPixelRatio(pr); composer.setSize(W, H); }
  camera.aspect = W / H;
  fitCamera();
  const t = Math.tan(camera.fov * Math.PI / 360);
  U.px.value = H * pr / (2 * t);
  streakG.scale.set(100 * t * camera.aspect, 100 * t, 1);
}

/* ---------- 交互 ---------- */
let hover = -1, drag = null;
function screenOf(k){ const c = CL[k]; const [x, y] = project(c.x, c.cy, c.z); return [x, y]; }
function pickAt(x, y){
  if (!glOK) return -1;
  let best = -1, bd = Infinity;
  for (let k = 0; k <= 12; k++) { const [sx, sy] = screenOf(k), r = k === 0 ? 100 : 90; const d = (sx - x) ** 2 + (sy - y) ** 2; if (d < r * r && d < bd) { bd = d; best = k; } }
  if(!externalMode){const [qx, qy] = project(spider.x, spider.y + .5, spider.z); if ((qx - x) ** 2 + (qy - y) ** 2 < 40 * 40) best = CRAWLER;}
  return best;
}
function showTip(k){
  const a = AG[k]; let now;
  if(externalMode&&k>=0&&k<13){const count=engineeringState?engineeringState.nodes.filter(n=>clusterIndex(n.clusterId)===k).length:0;tip.style.setProperty('--c',a.col);tip.innerHTML=`<span><b>${a.zh}</b></span><span>${a.role}</span><span>当前查询：${count} 个真实对象</span>`;tip.hidden=false;const [sx,sy]=screenOf(k),tw=tip.offsetWidth,th=tip.offsetHeight;tip.style.left=clamp(sx+24,8,W-tw-8)+'px';tip.style.top=clamp(sy-th/2,8,H-th-8)+'px';return;}
  if (k === 0) now = task ? `${task.id} ${task.name} · 评分 ${Math.round(task.shown)} · 待答 ${openFlags()}` : '—';
  else if (k === CRAWLER) { const s = curSec(); now = spider.air ? `跳向 ${s ? AG[s.ai].k : 'CHIEF'}` : crawl.phase === 'read' && s ? `在读 ${AG[s.ai].k} · ${s.read}/${s.words.length}` : '待命'; }
  else { const idx = task ? task.path.indexOf(k) : -1, sec = idx >= 0 ? task.sections[idx] : null; now = sec ? (sec.done ? '本单已审完' : curSec() === sec ? `正在被审 · ${sec.read}/${sec.words.length}` : '本单待审') : `负载 ${Math.round(load[k] * 100)}%`; }
  tip.style.setProperty('--c', a.col);
  tip.innerHTML = `<span><b>${a.k}</b><strong>${a.zh}</strong></span><span>${a.role}</span><span>当前：${now}</span>` + (k > 0 && k < 13 ? `<span class="h">${cam.focus === k ? '再点一次返回全景' : '点击拉近看这团星云'}</span>` : '');
  tip.hidden = false;
  const [sx, sy] = k === CRAWLER ? project(spider.x, spider.y + .5, spider.z) : screenOf(k), tw = tip.offsetWidth, th = tip.offsetHeight;
  let x = sx + 24, y = sy - th / 2; if (x + tw > W - 12) x = sx - tw - 24;
  tip.style.left = clamp(x, 8, W - tw - 8) + 'px'; tip.style.top = clamp(y, 8, H - th - 8) + 'px';
}
function setFocus(k){ cam.frame=null;cam.focus = (k <= 0 || k === CRAWLER || cam.focus === k) ? -1 : k; cam.zoom = 1; cam.yaw = cam.pitch = 0; syncButtons(); }
listen(cv, 'pointerdown', e => { if(externalMode&&options&&options.onManualControl)options.onManualControl();drag = {x: e.clientX, y: e.clientY, sx: e.clientX, sy: e.clientY, moved: false}; try { cv.setPointerCapture(e.pointerId); } catch (_) {} });
listen(cv, 'pointermove', e => {
  const r = host.getBoundingClientRect(), x = e.clientX - r.left, y = e.clientY - r.top;
  if (drag) {
    const dx = e.clientX - drag.x, dy = e.clientY - drag.y; drag.x = e.clientX; drag.y = e.clientY;
    if (Math.abs(e.clientX - drag.sx) + Math.abs(e.clientY - drag.sy) > 5) { drag.moved = true; cv.classList.add('drag'); }
    if (drag.moved && glOK) { cam.yaw -= dx * .005; cam.pitch += dy * .004; cam.userT = 6; tip.hidden = true; hover = -1; }
    return;
  }
  const k = pickAt(x, y); hover = k; cv.classList.toggle('hov', k >= 0);
  if (k >= 0) showTip(k); else tip.hidden = true;
});
listen(cv, 'pointerup', e => {
  const wasDrag = drag && drag.moved; drag = null; cv.classList.remove('drag');
  if (wasDrag || !glOK) return;
  const r = host.getBoundingClientRect(), k = pickAt(e.clientX - r.left, e.clientY - r.top);
  if (k > 0 && k < 13) setFocus(k); else if (cam.focus >= 0) setFocus(cam.focus);
});
listen(cv, 'pointerleave', () => { if (!drag) { tip.hidden = true; hover = -1; } });
listen(cv, 'wheel', e => { if (!glOK) return; e.preventDefault();if(externalMode&&options&&options.onManualControl)options.onManualControl(); cam.zoom = clamp(cam.zoom * Math.exp(e.deltaY * .0012), .3, 1.6); }, {passive: false});
function syncButtons(){ $$('[data-f="mode"]').forEach(b => b.textContent = cam.focus >= 0 ? '返回' : MODES[modeI].zh); }
function act(name){
  if (name === 'mode') { if (cam.focus >= 0) cam.focus = -1; else modeI = (modeI + 1) % MODES.length; cam.yaw = cam.pitch = 0; cam.zoom = 1; }
  else if (name === 'full') {
    try {
      if (document.fullscreenElement) document.exitFullscreen().catch(() => {});
      else if (document.documentElement.requestFullscreen) document.documentElement.requestFullscreen().catch(() => { const b = $('[data-f="full"]'); b.textContent = '不支持'; scheduleTimeout(() => b.textContent = '全屏', 1500); });
    } catch (e) { /* 部分窗口不允许全屏 */ }
  }
  syncButtons();
}
$$('[data-act]').forEach(b => listen(b, 'click', () => act(b.dataset.act)));
listen(document, 'fullscreenchange', () => { const b = $('[data-f="full"]'); if (b) b.textContent = document.fullscreenElement ? '退出全屏' : '全屏'; });
listen(document, 'keydown', e => {
  if (host.hidden) return;
  const tag = (e.target && e.target.tagName) || '';
  if (/INPUT|TEXTAREA|SELECT/.test(tag) || e.metaKey || e.ctrlKey || e.altKey) return;
  if (e.key === 'v' || e.key === 'V') act('mode');
  if (e.key === 'Escape' && cam.focus >= 0) setFocus(cam.focus);
});

/* ---------- 开场 ---------- */
newTask();
resizeObserver = new ResizeObserver(() => layout()); resizeObserver.observe(host);
layout();
renderLog(); renderTabs(); renderSec(); renderStrip(); renderSecs(); renderCounters(); renderCode(); drawPanels();
clockTick(); scheduleInterval(clockTick, 1000);
syncButtons();
// 调试用：快进模拟若干秒（控制台里 document.getElementById('host-nebula').__ff(20)）
host.__ff = sec => { ffing = true; for (let t = 0; t < sec; t += .05) { simStep(.05); animT += .05; frameN++; coreSay.t -= .05; codeChars += 4.5; if (glOK) { camStep(.05); updateScene(.05); } } ffing = false; };
host.__st = () => ({phase: externalMode?'engineering':crawl.phase, sec: crawl.sec, wi: crawl.wi, score: task && Math.round(task.shown), reads: task && task.reads, flags: task && task.flags, fixes: task && task.fixes, open: openFlags(), comets: comets.length, engineeringNodes:engineeringState?.nodes?.length||0,engineeringEdges:engineeringState?.edges?.length||0,crawlerVisible:!!(spider.g&&spider.g.visible),agentHudVisible:nr.style.display!=='none',x: spider.x.toFixed(1), z: spider.z.toFixed(1)});
host.__mode = i => { modeI = i; syncButtons(); };
host.__focus = k => setFocus(k);
host.__ui = () => { if(externalMode)renderEngineeringHud(true);else{logDirty = true; renderLog(); renderTabs(); renderSec(); renderStrip(); renderSecs(); renderCounters(); renderCode(); drawPanels();} placeOverlays(); };
host.__info = () => glOK ? (renderer.info.autoReset = false, renderer.info.reset(), renderer.render(scene, camera), renderer.info.autoReset = true, {calls: renderer.info.render.calls, tris: renderer.info.render.triangles, pts: renderer.info.render.points}) : null;

function clusterIndex(id){
  if (id == null) return -1;
  const q = String(id).toLowerCase();
  return AG.findIndex(a => a.k.toLowerCase() === q || a.zh === id);
}
let engineeringHudKey='';
function escText(value){return String(value??'').replace(/[&<>"']/g,ch=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[ch]));}
function renderEngineeringHud(force=false){
  if(!engineeringState)return;
  const key=[engineeringState.status,engineeringState.query,engineeringState.nodes.length,engineeringState.edges.length,engineeringState.activeNodeId,engineeringState.activeEdgeId,engineeringState.logs.join('|')].join('::');
  if(!force&&key===engineeringHudKey)return; engineeringHudKey=key;
  const layerCounts={REQUIREMENT:0,FUNCTION:0,ARCHITECTURE:0,PHYSICAL:0}; engineeringState.nodes.forEach(n=>{if(layerCounts[n.layer]!=null)layerCounts[n.layer]++;});
  const sub=$('.hd .sub'),sub2=$('.hd .sub2'); if(sub)sub.textContent='真实工程知识融合 · 查询驱动关系展开'; if(sub2)sub2.innerHTML='Neo4j READ ONLY · '+escText(engineeringState.status)+' · 无正式 Logical 实体时保持缺口 · <b id="clock">--:--:--</b>';
  $('#secT').textContent='ENGINEERING QUERY'; $('#secNo').textContent='KG'; $('#secName').textContent=engineeringState.status; $('#secZh').textContent='真实图谱'; $('#secS').textContent=engineeringState.query||'等待查询';
  $('#sTen').textContent=engineeringState.nodes.length; $('#sRead').textContent=layerCounts.REQUIREMENT+'/'+layerCounts.FUNCTION; $('#sLink').textContent=engineeringState.edges.length; $('#sFlag').textContent=engineeringState.edges.filter(e=>e.provenance==='AI_CANDIDATE').length; $('#sT').textContent=simT.toFixed(2); $('#sFrame').textContent=pad(frameN%10000,4);
  tabsEl.innerHTML=[['REQ',layerCounts.REQUIREMENT],['FUNCTION',layerCounts.FUNCTION],['LOGICAL',0],['ARCH',layerCounts.ARCHITECTURE],['PHYSICAL',layerCounts.PHYSICAL]].map(([n,c],i)=>`<i class="${c?'d':''}" style="--c:${['#7cc8ff','#a093ff','#ff6fae','#49e3f2','#8ef0c4'][i]}">${escText(n)} ${c}</i>`).join('');
  logEl.innerHTML=engineeringState.logs.slice(-11).reverse().map((line,i)=>`<li><span class="tm">${pad(i+1)}</span><span class="vb link">kg</span><span class="tx">${escText(line)}</span></li>`).join('');
  secsEl.innerHTML=[['Requirement','REQUIREMENT','#7cc8ff'],['Function','FUNCTION','#a093ff'],['Logical','LOGICAL','#ff6fae'],['Architecture','ARCHITECTURE','#49e3f2'],['Physical','PHYSICAL','#8ef0c4']].map(([name,layer,color])=>`<div class="${layerCounts[layer]?'c':'w'}" style="--c:${color}"><span>${name}</span><u><s style="width:${Math.min(100,(layerCounts[layer]||0)*12)}%"></s></u><em>${layerCounts[layer]||0}</em></div>`).join('');
  $('#secMeta').textContent=`${engineeringState.nodes.length} nodes`; $('.secs-f').textContent='Logical = 0：图谱无正式逻辑实体，不补造';
  $$('.dp').forEach(el=>el.style.opacity='.25'); $('.p-log').style.opacity='.96'; $('.p-sec').style.opacity='.96';
  const logTitle=$('.p-log .dp-h b'),secTitle=$('.p-sec .dp-h b'); if(logTitle)logTitle.textContent='QUERY LOG';if(secTitle)secTitle.textContent='ENGINEERING LAYERS';
}
function applySnapshot(snapshot){
  if (!snapshot || !Array.isArray(snapshot.clusters)) return;
  snapshot.clusters.forEach(c => {
    const k = clusterIndex(c.id) >= 0 ? clusterIndex(c.id) : AG.findIndex(a => a.k === c.key);
    if (k < 0 || k > 12) return;
    AG[k].zh = c.label || AG[k].zh; AG[k].role = c.role || AG[k].role; AG[k].col = c.color || AG[k].col;
    const el = clEls[k]; if (!el) return;
    el.style.setProperty('--c', AG[k].col);
    const b = el.querySelector('b'), i = el.querySelector('i');
    if (b) b.textContent = snapshot.engineering ? AG[k].zh : AG[k].k.toLowerCase(); if (i) i.textContent = snapshot.engineering ? AG[k].role : AG[k].zh;
  });
  const nextExternal=!!snapshot.engineering;
  if(nextExternal&&!externalMode){task=null;jobs.length=0;comets.length=0;trail.length=0;threads.forEach(t=>{t.on=false;t.ret=false;});crawl.phase='external';crawl.sec=-1;}
  externalMode=nextExternal;engineeringState=snapshot.engineering||null;
  nr.style.display=externalMode?'none':'';
  if(spider.g)spider.g.visible=!externalMode;if(spider.shadow)spider.shadow.visible=!externalMode;if(legG)legG.visible=!externalMode;if(threadObj)threadObj.visible=!externalMode;if(trailLine)trailLine.visible=!externalMode;if(pulseSpr)pulseSpr.visible=!externalMode;
  if(externalMode)renderEngineeringHud(true);else if(engineeringLineObj)engineeringLineObj.geometry.setDrawRange(0,0);
}
function focusById(id){const node=engineeringState&&engineeringState.nodes.find(n=>n.id===id);const k=clusterIndex(node?node.clusterId:id); if (k > 0 && k < 13) setFocus(k); else { cam.frame=null;cam.focus = -1; cam.zoom = 1; cam.yaw = cam.pitch = 0; syncButtons(); } }
function frameEngineering(clusterIds,mode){
  const ids=[...new Set((clusterIds||[]).map(clusterIndex).filter(k=>k>0&&k<13))];
  if(!ids.length){cam.frame={tx:0,ty:1.5,tz:0,r:fitD*(mode==='global'?1:.82),el:1.05,az:0};}
  else{let minX=Infinity,maxX=-Infinity,minZ=Infinity,maxZ=-Infinity;ids.forEach(k=>{const c=CL[k];minX=Math.min(minX,c.x-c.R);maxX=Math.max(maxX,c.x+c.R);minZ=Math.min(minZ,c.z-c.R);maxZ=Math.max(maxZ,c.z+c.R);});const span=Math.max(maxX-minX,(maxZ-minZ)/Math.max(.65,W/H));cam.frame={tx:(minX+maxX)/2,ty:1.5,tz:(minZ+maxZ)/2,r:Math.max(mode==='focus'?30:38,span*1.18),el:mode==='focus'?.86:1.02,az:0};}
  cam.focus=-1;cam.zoom=1;cam.yaw=cam.pitch=0;syncButtons();
}
function dispatchSceneEvent(event){
  if (!event || disposed) return;
  if (event.type === 'focus') focusById(event.id);
  else if (event.type === 'flash') { const k = clusterIndex(event.id); if (k >= 0 && k < flash.length) flash[k] += 1.2; }
  else if (event.type === 'relation') { const a = clusterIndex(event.sourceId), b = clusterIndex(event.targetId); if (a >= 0 && b >= 0) comet(cloudP(a), cloudP(b), event.color || '#62e3ff', .85, .48, () => { flash[b] += .6; }); }
  else if (event.type === 'engineering-step') { const a=clusterIndex(event.sourceClusterId),b=clusterIndex(event.targetClusterId);if(a>=0&&b>=0){flash[a]+=.7;flash[b]+=1.3;comet(cloudP(a),cloudP(b),event.color||'#62e3ff',.85,.5,()=>{flash[b]+=.7;});} }
  else if(event.type==='frame')frameEngineering(event.clusterIds,event.mode);
  else if (event.type === 'view') { modeI = clamp(Number(event.index) || 0, 0, MODES.length - 1); cam.frame=null;cam.focus = -1; cam.yaw = cam.pitch = 0; cam.zoom = 1; syncButtons(); }
  else if (event.type === 'fast-forward') host.__ff(clamp(Number(event.seconds) || 0, 0, 120));
}
function getDiagnostics(){
  if (disposed) return {disposed:true, fps:0, state:null, render:null, memory:null, webgl:null, gpu:null};
  const info = host.__info();
  let gpu = null;
  if (glOK) {
    const gl = renderer.getContext(), ext = gl.getExtension('WEBGL_debug_renderer_info');
    gpu = ext ? {vendor: String(gl.getParameter(ext.UNMASKED_VENDOR_WEBGL)), renderer: String(gl.getParameter(ext.UNMASKED_RENDERER_WEBGL))} : {vendor: String(gl.getParameter(gl.VENDOR)), renderer: String(gl.getParameter(gl.RENDERER))};
  }
  return {
    disposed,
    fps,
    state: host.__st(),
    render: info ? {calls: info.calls, triangles: info.tris, points: info.pts} : null,
    memory: glOK ? {geometries: renderer.info.memory.geometries, textures: renderer.info.memory.textures, programs: renderer.info.programs ? renderer.info.programs.length : 0} : null,
    webgl: glOK ? {context: renderer.capabilities.isWebGL2 ? 'WebGL2' : 'WebGL', pixelRatio: renderer.getPixelRatio(), composer: !!composer} : null,
    gpu,
  };
}
function disposeMaterial(material, textures){
  if (!material) return;
  Object.values(material).forEach(value => { if (value && value.isTexture && !textures.has(value)) { textures.add(value); value.dispose(); } });
  if (material.uniforms) Object.values(material.uniforms).forEach(u => { const value = u && u.value; if (value && value.isTexture && !textures.has(value)) { textures.add(value); value.dispose(); } });
  material.dispose && material.dispose();
}
function disposeRuntime(){
  if (disposed) return;
  disposed = true;
  if (rafId) cancelAnimationFrame(rafId);
  resizeObserver && resizeObserver.disconnect();
  listeners.splice(0).reverse().forEach(([target, type, handler, opts]) => target.removeEventListener(type, handler, opts));
  intervals.forEach(id => clearInterval(id)); intervals.clear();
  timeouts.forEach(id => clearTimeout(id)); timeouts.clear();
  try { host.getAnimations({subtree:true}).forEach(a => a.cancel()); } catch (_) {}
  const textures = new Set();
  if (scene && scene.traverse) scene.traverse(obj => {
    if (obj.geometry && obj.geometry.dispose) obj.geometry.dispose();
    const mats = Array.isArray(obj.material) ? obj.material : obj.material ? [obj.material] : [];
    mats.forEach(m => disposeMaterial(m, textures));
  });
  composer && composer.dispose && composer.dispose();
  if (renderer) { renderer.renderLists && renderer.renderLists.dispose(); renderer.dispose(); renderer.forceContextLoss && renderer.forceContextLoss(); }
  scene && scene.clear && scene.clear();
  ['__ff','__st','__mode','__focus','__ui','__info','__nebulaController'].forEach(k => { try { delete host[k]; } catch (_) { host[k] = undefined; } });
  SR.replaceChildren();
}

const controller = {setSnapshot: applySnapshot, dispatch: dispatchSceneEvent, resize: layout, focus: focusById, getDiagnostics, dispose: disposeRuntime};
host.__nebulaController = controller;
applySnapshot(options && options.snapshot);
scheduleFrame(frame);
return controller;
}
