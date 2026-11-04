import {Background,Controls,MarkerType,ReactFlow,useReactFlow} from '@xyflow/react'
import '@xyflow/react/dist/style.css'
import {useMemo} from 'react'

export type KgNode={id:string;display_name?:string;labels?:string[];properties?:Record<string,unknown>;relationship?:string}
export type KgEdge={id:string;source:string;target:string;label:string;path?:boolean}

const colors:Record<string,string>={Requirement:'#627e8f',Function:'#78958f',Product:'#84968a',Component:'#84968a',Port:'#a88c65',Interface:'#a88c65',FMU:'#718897',KPI:'#9b9082'}
function GraphReset(){const flow=useReactFlow();return <button className="nebula-reset" onClick={()=>flow.fitView({padding:.24,duration:400})}>复位视图</button>}

export default function KnowledgeNebulaGraph({nodes,edges,selectedId,onSelect}:{nodes:KgNode[];edges:KgEdge[];selectedId?:string;onSelect:(n:KgNode)=>void}){
  const data=useMemo(()=>{
    const count=Math.max(nodes.length,1),cx=490,cy=310
    const rfNodes=nodes.map((n,i)=>{const a=i/count*Math.PI*2-Math.PI/2,ring=i%3,rx=ring===0?220:ring===1?330:410,ry=ring===0?132:ring===1?210:260;const kind=n.labels?.[0]||'Entity';return {id:n.id,position:{x:cx+Math.cos(a)*rx-70,y:cy+Math.sin(a)*ry-26},data:{label:<div className="nebula-node-label"><small>{kind}</small><b>{n.display_name||n.id}</b>{n.relationship&&<em>{n.relationship}</em>}</div>},className:`nebula-node ${selectedId===n.id?'selected':''}`,style:{'--node-color':colors[kind]||'#7d8f95'} as any}})
    const rfEdges=edges.filter(e=>nodes.some(n=>n.id===e.source)&&nodes.some(n=>n.id===e.target)).map(e=>({id:e.id,source:e.source,target:e.target,label:e.label,animated:!!e.path,markerEnd:{type:MarkerType.ArrowClosed},className:e.path?'nebula-edge path':'nebula-edge'}))
    return {nodes:rfNodes,edges:rfEdges}
  },[nodes,edges,selectedId])
  if(!nodes.length)return <div className="nebula-empty"><div className="nebula-core-mark"><i/><i/><i/></div><b>等待真实工程实体</b><span>搜索后将在星核空间展示知识节点；当前未生成任何模拟节点。</span></div>
  return <ReactFlow nodes={data.nodes} edges={data.edges} minZoom={.3} maxZoom={1.8} fitView fitViewOptions={{padding:.24}} onNodeClick={(_,n)=>{const found=nodes.find(x=>x.id===n.id);if(found)onSelect(found)}} proOptions={{hideAttribution:true}}><Background color="rgba(194,214,218,.07)" gap={34}/><Controls showInteractive={false}/><GraphReset/></ReactFlow>
}

