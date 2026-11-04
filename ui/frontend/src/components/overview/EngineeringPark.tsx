import {useEffect,useRef,useState} from 'react'
import {useNavigate} from 'react-router-dom'

export type ParkMetric={label:string;value:string|number}
export type ParkZone={id:string;name:string;english:string;responsibility:string;input:string;output:string;route:string;routes?:Array<{label:string;route:string}>;metrics:ParkMetric[];position:string;status:string}

export default function EngineeringPark({zones,baseline}:{zones:ParkZone[];baseline:string}){
  const nav=useNavigate(),drag=useRef<{x:number;y:number;rx:number;rz:number}|null>(null)
  const [view,setView]=useState({rx:58,rz:-42,scale:.88,panX:0,panY:0}),[focus,setFocus]=useState<string|null>(null)
  const reduced=useRef(matchMedia('(prefers-reduced-motion: reduce)').matches)
  const reset=()=>{setView({rx:58,rz:-42,scale:.88,panX:0,panY:0});setFocus(null)}
  useEffect(()=>{const esc=(e:KeyboardEvent)=>e.key==='Escape'&&reset();window.addEventListener('keydown',esc);return()=>window.removeEventListener('keydown',esc)},[])
  const select=(id:string)=>{const pan:Record<string,[number,number]>={'01':[190,95],'02':[0,120],'03':[-170,90],'04':[190,-100],'05':[0,-125],'06':[-170,-95]};setFocus(id);if(!reduced.current)setView(v=>({...v,scale:1.05,panX:pan[id]?.[0]||0,panY:pan[id]?.[1]||0}))}
  const active=zones.find(z=>z.id===focus)
  return <section className={'park-shell'+(focus?' is-focused':'')}>
    <div className="park-toolbar" aria-label="沙盘视角控制">
      <span><i/> ENGINEERING PARK / {baseline}</span>
      <div><button onClick={()=>setView({rx:72,rz:0,scale:.82,panX:0,panY:0})}>俯视</button><button onClick={()=>setView({rx:58,rz:-42,scale:.88,panX:0,panY:0})}>斜视</button><button onClick={()=>setView({rx:50,rz:-22,scale:.72,panX:0,panY:0})}>全景</button><button onClick={reset}>复位</button></div>
    </div>
    <div className="park-viewport" onDoubleClick={reset} onWheel={e=>setView(v=>({...v,scale:Math.max(.58,Math.min(1.25,v.scale-e.deltaY*.0007))}))}>
      <div className="park-horizon"><span/><span/><span/></div>
      <div className="park-stage" style={{transform:`translate(calc(-50% + ${view.panX}px),calc(-50% + ${view.panY}px)) perspective(1200px) rotateX(${view.rx}deg) rotateZ(${view.rz}deg) scale(${view.scale})`}}
        onPointerDown={e=>{if((e.target as HTMLElement).closest('button'))return;drag.current={x:e.clientX,y:e.clientY,rx:view.rx,rz:view.rz};e.currentTarget.setPointerCapture(e.pointerId)}}
        onPointerMove={e=>{if(!drag.current)return;setView(v=>({...v,rx:Math.max(38,Math.min(76,drag.current!.rx-(e.clientY-drag.current!.y)*.16)),rz:drag.current!.rz+(e.clientX-drag.current!.x)*.18}))}}
        onPointerUp={()=>{drag.current=null}}>
        <div className="park-ground-grid"/>
        <svg className="park-routes" viewBox="0 0 1000 700" aria-hidden="true"><path className="park-main-route" d="M135 162 L500 350 L825 158 M500 350 L862 520 M500 350 L142 535 M500 350 L500 90"/><path className="park-evidence-route" d="M142 535 Q210 255 500 350"/><circle cx="500" cy="350" r="132"/></svg>
        <button className="park-control-center" onClick={()=>setFocus(null)} aria-label="轨道车辆智能工程总控中心">
          <span className="park-control-roof">RAIL ENGINEERING</span><b>轨道车辆智能工程总控中心</b><small>牵引 · 制动 · 储能 · 调度</small>
          <span className="park-rail"><i/><i/><i/></span><span className="park-train"><i/><i/><i/><i/></span>
        </button>
        {zones.map(z=><button key={z.id} className={`park-building ${z.position}${focus===z.id?' active':''}${focus&&focus!==z.id?' dimmed':''}`} onClick={()=>select(z.id)} title={`${z.name}\n${z.responsibility}\n输入：${z.input}\n输出：${z.output}\n状态：${z.status}`}>
          <span className="park-building-roof"><i>{z.id}</i><em/></span><span className="park-building-face"><small>{z.english}</small><b>{z.name}</b><em>{z.status}</em></span>
        </button>)}
      </div>
      <div className="park-axis"><span>N</span><i/></div>
      <div className="park-gesture">拖动旋转 · 滚轮缩放 · 双击或 Esc 复位</div>
    </div>
    {active&&<aside className="park-focus-panel">
      <button className="park-close" onClick={reset} aria-label="返回全景">×</button><small>WORKSHOP {active.id}</small><h2>{active.name}</h2><p>{active.responsibility}</p>
      <dl><div><dt>输入</dt><dd>{active.input}</dd></div><div><dt>输出</dt><dd>{active.output}</dd></div><div><dt>状态</dt><dd>{active.status}</dd></div></dl>
      <div className="park-metrics">{active.metrics.map(m=><div key={m.label}><span>{m.label}</span><b>{m.value}</b></div>)}</div>
      <button className="park-enter" onClick={()=>nav(active.route)}>进入工程区域 →</button>
      {active.routes&&<div className="park-subroutes">{active.routes.map(x=><button key={x.route} onClick={()=>nav(x.route)}>{x.label}</button>)}</div>}
    </aside>}
  </section>
}

