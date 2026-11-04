import {Empty} from 'antd'

const stageInfo=[
  ['01','自然语言输入','INPUT'],['02','意图识别','INTENT'],['03','Requirement 检索','REQUIREMENT'],
  ['04','Function 关联','FUNCTION'],['05','Product 定位','PRODUCT'],['06','证据与追溯','EVIDENCE'],
]

function valuesFor(stage:number,result:any,query:string){
  if(stage===0)return [query]
  if(stage===1)return [result?.interpretation?.summary,result?.interpretation?.scope&&`范围：${result.interpretation.scope}`,...(result?.interpretation?.keywords||[]).slice(0,2)]
  if(stage===2)return (result?.requirements||[]).slice(0,3).map((x:any)=>`${x.requirement_id} · ${x.name}`)
  if(stage===3)return (result?.functions||[]).slice(0,3).map((x:any)=>`${x.function_id} · ${x.name}`)
  if(stage===4)return (result?.products||[]).slice(0,3).map((x:any)=>`${x.product_id} · ${x.name}`)
  return (result?.paths||[]).slice(0,3).map((x:any)=>`${x.requirement_id} → ${x.function_id} → ${x.product_id}`)
}

export default function SpiderKnowledgeFlow({query,result,loading,onEntity}:{query:string;result:any;loading:boolean;onEntity:(type:string,id:string)=>void}){
  return <div className={`spider-canvas${loading?' is-running':''}`}>
    <svg viewBox="0 0 900 620" aria-hidden="true"><g className="spider-web">{[110,190,270].map(r=><Hexagon key={r} r={r}/>)}{[0,60,120,180,240,300].map(a=><line key={a} x1="450" y1="310" x2={450+Math.cos(a*Math.PI/180)*285} y2={310+Math.sin(a*Math.PI/180)*285}/>)}</g><g className="spider-flow">{[0,1,2,3,4,5].map(i=><line key={i} x1="450" y1="310" x2={450+Math.cos((i*60-90)*Math.PI/180)*255} y2={310+Math.sin((i*60-90)*Math.PI/180)*255}/>)}</g></svg>
    <div className="spider-core"><span>SEMANTIC</span><b>ENGINE</b><small>{loading?'解析执行中':'工程知识中枢'}</small></div>
    {stageInfo.map((s,i)=>{const vals=valuesFor(i,result,query).filter(Boolean);return <article key={s[0]} className={`spider-stage spider-stage-${i+1}${result?' complete':''}`}>
      <header><i>{s[0]}</i><div><small>{s[2]}</small><b>{s[1]}</b></div></header>
      <div className="spider-stage-body">{vals.length?vals.map((v:any,j:number)=><button key={j} onClick={()=>{const id=String(v).split(' · ')[0];if(i===2)onEntity('requirement',id);if(i===3)onEntity('function',id);if(i===4)onEntity('product',id)}}>{String(v)}</button>):<Empty image={Empty.PRESENTED_IMAGE_SIMPLE} description="等待真实结果"/>}</div>
    </article>})}
  </div>
}

function Hexagon({r}:{r:number}){const pts=[0,60,120,180,240,300].map(a=>`${450+Math.cos((a-90)*Math.PI/180)*r},${310+Math.sin((a-90)*Math.PI/180)*r}`).join(' ');return <polygon points={pts}/>}

