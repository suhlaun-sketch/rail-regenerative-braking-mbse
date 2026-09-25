import {useEffect,useMemo,useState} from 'react'
import ReactFlow,{Background,Controls,ReactFlowProvider,useEdgesState,useNodesState} from 'reactflow'
import 'reactflow/dist/style.css'
import {L1Node,L3Node,L4Node,FnNode,FlowEdge,ContainmentEdge} from './SysMLFlowNodes'
import L2EngineeringNode from './L2EngineeringNode'

const nodeTypes={l1:L1Node,l2:L2EngineeringNode,l3:L3Node,l4:L4Node,fn:FnNode}
const edgeTypes={flow:FlowEdge,containment:ContainmentEdge}
const DIM={fn:{w:240,h:82},product:{w:210,h:90},l2:{w:230,h:130}}

function typeFor(d:any){
  if(d.level==='function'||d.type==='Function') return 'fn'
  if(d.level===2) return 'l2'
  if(d.level===3) return 'l3'
  return 'l4'
}
function dimensions(d:any){
  if(d.level==='function'||d.type==='Function') return DIM.fn
  if(d.level===2) return DIM.l2
  return DIM.product
}
function initialGraph(graph:any,stage:number){
  const sourceNodes=graph?.nodes||[]
  const ns=sourceNodes.map((n:any)=>n.data)
  const column=(d:any)=>{
    if(stage===1) return d.level==='function'?0:1
    if(stage===2) return d.level===2?1:0
    if(stage===3){ const order:any={'4500':0,'5100':1,'5300':2,'X100':3}; return order[d.code]??0 }
    if(stage===4){ const core=new Set(['4500','5100','5300','X100']); return core.has(d.code)?1:(d.isNew?0:2) }
    return 0
  }
  const counters=[0,0]
  const nodes=ns.map((d:any)=>{
    const col=column(d), index=counters[col]++, size=dimensions(d)
    const yStep=stage===3?170:(size.h+42)
    const x=stage===3?80+col*360:80+col*360
    const y=stage===3?100:45+index*yStep
    return {id:d.id,type:typeFor(d),position:{x,y},data:d,dragHandle:'.rf-node-title'}
  })
  const edges=(graph?.edges||[]).map((e:any)=>({
    id:String(e.data.id),type:e.data.relation==='containment'?'containment':'flow',source:e.data.source,target:e.data.target,
    data:{...e.data,showLabel:false,animated:e.data.flow_kind==='physical'}
  }))
  return {nodes,edges}
}

function TaskSliceGraphInner({graph,stage,selectedId,onSelect,onEdgeSelect}:{graph:any;stage:number;selectedId?:string;onSelect?:(v:any)=>void;onEdgeSelect?:(v:any)=>void}){
  const signature=useMemo(()=>`${stage}|${(graph?.nodes||[]).map((n:any)=>n.data.id).sort().join(',')}|${(graph?.edges||[]).map((e:any)=>e.data.id).sort().join(',')}`,[graph,stage])
  const initial=useMemo(()=>initialGraph(graph,stage),[signature])
  const [nodes,setNodes,onNodesChange]=useNodesState(initial.nodes)
  const [edges,setEdges,onEdgesChange]=useEdgesState(initial.edges)
  const [showAllEdges,setShowAllEdges]=useState(stage!==4)

  useEffect(()=>{
    setNodes(initial.nodes); setEdges(initial.edges); setShowAllEdges(stage!==4)
  },[initial,stage,setNodes,setEdges])

  const visibleEdges=useMemo(()=>{
    if(stage!==4||showAllEdges) return edges
    const core=new Set(['4500','5100','5300','X100'])
    const coreIds=new Set([...core].map(x=>`product::${x}`))
    const related=new Set<string>()
    const perNew=new Map<string,number>()
    edges.forEach(e=>{
      const sourceNew=nodes.find(n=>n.id===e.source)?.data?.isNew
      const targetNew=nodes.find(n=>n.id===e.target)?.data?.isNew
      const newId=sourceNew?e.source:targetNew?e.target:undefined
      if(newId){ const count=perNew.get(newId)||0; if(count<2){related.add(e.id);perNew.set(newId,count+1)} }
    })
    return edges.filter(e=>related.has(e.id))
  },[stage,showAllEdges,edges,nodes])

  const selectedNodes=useMemo(()=>nodes.map(n=>({...n,selected:n.id===selectedId})),[nodes,selectedId])
  const selectedEdges=useMemo(()=>visibleEdges.map(e=>({...e,selected:e.id===selectedId})),[visibleEdges,selectedId])

  if(!nodes.length) return null
  return <div className="ts-graph-inner">
    <div className="ts-graph-toolbar"><span>{nodes.length} 节点 · {visibleEdges.length} 边</span><button type="button" onClick={()=>setNodes(initial.nodes)}>重置位置</button><button type="button" onClick={()=>setNodes(initial.nodes)}>自动布局</button>{stage===4&&<button type="button" onClick={()=>setShowAllEdges(v=>!v)}>{showAllEdges?'核心依赖':'全部接口'}</button>}</div>
    <ReactFlow nodes={selectedNodes} edges={selectedEdges} nodeTypes={nodeTypes} edgeTypes={edgeTypes} onNodesChange={onNodesChange} onEdgesChange={onEdgesChange} nodesDraggable={true} nodesConnectable={false} elementsSelectable panOnDrag fitView fitViewOptions={{padding:.2}} minZoom={.12} maxZoom={2} proOptions={{hideAttribution:true}} onNodeClick={(_,n)=>onSelect?.(n.data)} onEdgeClick={(_,e)=>onEdgeSelect?.(e.data)}>
      <Background gap={24} color="#e0e6ec"/><Controls showInteractive={false}/>
    </ReactFlow>
  </div>
}

export default function TaskSliceGraph(props:{graph:any;stage:number;selectedId?:string;onSelect?:(v:any)=>void;onEdgeSelect?:(v:any)=>void}){
  return <ReactFlowProvider><TaskSliceGraphInner {...props}/></ReactFlowProvider>
}
