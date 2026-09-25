import ReactFlow,{Background,Controls,MarkerType,Position} from 'reactflow'
import 'reactflow/dist/style.css'
import {useMemo} from 'react'

const colors={requirement:'#2f5f79',function:'#376f68',product:'#76603b'}

export default function TraceGraph({result,onEntity}:{result:any;onEntity:(type:string,id:string)=>void}){
  const graph=useMemo(()=>{
    const paths=(result?.paths||[]).slice(0,30)
    const reqIds=[...new Set(paths.map((p:any)=>p.requirement_id))].slice(0,8) as string[]
    const fnIds=[...new Set(paths.filter((p:any)=>reqIds.includes(p.requirement_id)).map((p:any)=>p.function_id))].slice(0,12) as string[]
    const productIds=[...new Set(paths.filter((p:any)=>fnIds.includes(p.function_id)).map((p:any)=>p.product_id))].slice(0,12) as string[]
    const reqMap=new Map((result?.requirements||[]).map((x:any)=>[x.requirement_id,x]))
    const fnMap=new Map((result?.functions||[]).map((x:any)=>[x.function_id,x]))
    const productMap=new Map((result?.products||[]).map((x:any)=>[x.product_id,x]))
    const make=(type:'requirement'|'function'|'product',id:string,index:number,x:number,value:any)=>({
      id:`${type}:${id}`,position:{x,y:index*96},sourcePosition:Position.Right,targetPosition:Position.Left,
      data:{label:<div className="semantic-node"><small>{type.toUpperCase()}</small><b>{id}</b><span>{value?.name||'—'}</span></div>},
      style:{width:250,minHeight:68,border:`2px solid ${colors[type]}`,borderRadius:8,background:'#fff',color:'#17324a'},
    })
    const nodes=[...reqIds.map((id,i)=>make('requirement',id,i,0,reqMap.get(id))),
      ...fnIds.map((id,i)=>make('function',id,i,360,fnMap.get(id))),...productIds.map((id,i)=>make('product',id,i,720,productMap.get(id)))]
    const edgeSeen=new Set<string>();const edges:any[]=[]
    for(const p of paths){if(!reqIds.includes(p.requirement_id)||!fnIds.includes(p.function_id)||!productIds.includes(p.product_id))continue
      for(const [source,target,label] of [[`requirement:${p.requirement_id}`,`function:${p.function_id}`,'SATISFIED_BY'],[`function:${p.function_id}`,`product:${p.product_id}`,'ALLOCATED_TO']]){const id=`${source}->${target}`;if(edgeSeen.has(id))continue;edgeSeen.add(id);edges.push({id,source,target,label,markerEnd:{type:MarkerType.ArrowClosed},style:{stroke:'#8296a3'},labelStyle:{fontSize:9,fill:'#536a78'}})}}
    return {nodes,edges}
  },[result])
  if(!graph.nodes.length)return <div className="semantic-empty">没有找到可追溯的工程关系</div>
  return <div className="semantic-trace-graph"><ReactFlow nodes={graph.nodes} edges={graph.edges} fitView fitViewOptions={{padding:.18}} minZoom={.3} maxZoom={1.4} nodesDraggable={false} onNodeClick={(_,n)=>{const split=n.id.indexOf(':');onEntity(n.id.slice(0,split),n.id.slice(split+1))}}><Background gap={22} color="#e1e8ed"/><Controls showInteractive={false}/></ReactFlow></div>
}
