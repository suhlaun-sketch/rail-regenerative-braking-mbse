import {useEffect,useMemo,useRef,useState,useCallback} from 'react'
import ReactFlow,{Background,Controls,MiniMap,ReactFlowProvider,useReactFlow} from 'reactflow'
import 'reactflow/dist/style.css'
import ELK from 'elkjs/lib/elk.bundled.js'
import {L1Node,L2Node,L3Node,L4Node,PortNode,FnNode,FlowEdge,ContainmentEdge} from './SysMLFlowNodes'
import L2EngineeringNode from './L2EngineeringNode'

const NODE_TYPES={l1:L1Node,l2:L2EngineeringNode,l3:L3Node,l4:L4Node,port:PortNode,fn:FnNode}
const EDGE_TYPES={flow:FlowEdge,containment:ContainmentEdge}

const elk=new ELK()

const LANE_COLORS:Record<string,string>={
  '外部能源':'#d9eaf6','高压供电':'#dcefe5','功率变换':'#f7edce','牵引机械':'#f4dfd6',
  '车辆':'#e5e6f2','控制':'#e8e0f1','储能':'#dcefeb','其他':'#eceff2',
}
const FLOW_COLORS:Record<string,string>={
  physical:'#2f6f4f', control:'#4e6680', state:'#9b6a2c', data:'#5c4ea8', unknown:'#9aa8b2',
}

export type FlowGraph=any

type Props={
  graph:FlowGraph
  focusId?:string
  selectedId?:string
  flowKindFilter?:string
  flowMode?:'all'|'selected-types'|'focus-path'
  selectedFlowTypes?:string[]
  focusPath?:string[]
  selectedFlowId?:string
  viewMode?:'structure'|'interface'|'flow'
  showAnimation?:boolean
  onSelect?:(v:any)=>void
  onDrillDown?:(v:any)=>void
}

function nodeSize(d:any):{w:number,h:number}{
  if(d.level===1) return {w:220,h:80}
  if(d.level===2) return {w:230,h:82}
  if(d.level===3) return {w:200,h:70}
  if(d.level===4) return {w:180,h:58}
  if(d.level==='function' || d.type==='Function') return {w:200,h:72}
  return {w:150,h:50}
}

function buildElkElements(graph:FlowGraph,viewMode:string,flowKindFilter:string){
  const ns:any[]=graph?.nodes||[]
  const es:any[]=graph?.edges||[]
  // Build raw elk graph
  const elkGraph:any={
    id:'root',layoutOptions:{
      'elk.algorithm':'layered','elk.direction':'RIGHT','elk.edgeRouting':'ORTHOGONAL',
      'elk.layered.spacing.nodeNodeBetweenLayers':'90','elk.spacing.nodeNode':'44',
      'elk.layered.crossingMinimization.strategy':'LAYER_SWEEP',
      'elk.padding':'[top=24,left=24,bottom=24,right=24]',
    },
    children:[],edges:[],
  }
  const idMap=new Map<string,string>()
  ns.forEach((n:any,i:number)=>{
    const elkId=`n${i}`
    idMap.set(n.data.id,elkId)
    const {w,h}=nodeSize(n.data)
    elkGraph.children.push({id:elkId,width:w,height:h,layoutOptions:{}} )
  })
  es.forEach((e:any,i:number)=>{
    const sId=idMap.get(e.data.source), tId=idMap.get(e.data.target)
    if(!sId||!tId) return
    elkGraph.edges.push({id:`e${i}`,sources:[sId],targets:[tId],layoutOptions:{}})
  })
  return {elkGraph,idMap}
}

async function layout(elkGraph:any){
  try{
    return await elk.layout(elkGraph)
  }catch(e){
    console.warn('ELK layout failed',e)
    // Fallback: simple grid
    const nodes=elkGraph.children.map((c:any,i:number)=>({
      ...c,x:120+Math.floor(i/4)*260,y:80+(i%4)*120,
    }))
    return {...elkGraph,children:nodes}
  }
}

function InnerGraph(props:Props){
  const {graph,focusId,selectedId,flowKindFilter='all',flowMode='all',selectedFlowTypes=[],focusPath=[],selectedFlowId,viewMode='structure',showAnimation=true,onSelect,onDrillDown}=props
  const containerRef=useRef<HTMLDivElement>(null)
  const {fitView,zoomIn,zoomOut,setCenter,getZoom}=useReactFlow()
  const [rfNodes,setRfNodes]=useState<any[]>([])
  const [rfEdges,setRfEdges]=useState<any[]>([])
  const [hoverId,setHoverId]=useState<string|null>(null)
  const [hoverEdgeId,setHoverEdgeId]=useState<string|null>(null)
  const topologyKeyRef=useRef('')

  const lanes=graph?.meta?.lanes||[]
  const ns:any[]=graph?.nodes||[]
  const es:any[]=graph?.edges||[]
  // Filter edges by flow kind
  // One filtering pipeline only: branch edges -> optional type union -> optional path.
  const filteredEdges=useMemo(()=>{
    let result=es
    if(flowMode==='selected-types' && selectedFlowTypes.length){
      result=result.filter((e:any)=>selectedFlowTypes.includes(e.data.flow_kind||'unknown'))
    } else if(flowMode!=='selected-types' && flowKindFilter!=='all') {
      result=result.filter((e:any)=>(e.data.flow_kind||'unknown')===flowKindFilter)
    }
    if(flowMode==='focus-path' && focusPath.length){
      const allowed=new Set(focusPath)
      result=result.filter((e:any)=>allowed.has(e.data.id)||allowed.has(e.id)||allowed.has(e.data.source)||allowed.has(e.data.target))
    }
    return result
  },[es,flowMode,selectedFlowTypes,flowKindFilter,focusPath])

  // Build & layout only when topology signature changes (or first mount)
  const sig=useMemo(()=>{
    const nodeIds=ns.map((n:any)=>n.data.id).sort().join(',')
    const edgeIds=filteredEdges.map((e:any)=>e.data.id).sort().join(',')
    return `${nodeIds}|${edgeIds}|${viewMode}|${flowMode}|${selectedFlowTypes.join(',')}|${focusPath.join(',')}`
  },[ns,filteredEdges,viewMode,flowMode,selectedFlowTypes,focusPath])

  useEffect(()=>{
    let cancelled=false
    async function run(){
      if(topologyKeyRef.current===sig) return
      topologyKeyRef.current=sig
      if(ns.length===0){setRfNodes([]);setRfEdges([]);return}
      const {elkGraph,idMap}=buildElkElements({nodes:ns,edges:filteredEdges},viewMode,flowKindFilter)
      const result=await layout(elkGraph)
      if(cancelled) return
      const positionMap=new Map<string,{x:number,y:number}>()
      result.children.forEach((c:any)=>{
        const orig=ns.find((n:any,i:number)=>`n${i}`===c.id)
        if(orig) positionMap.set(orig.data.id,{x:c.x||0,y:c.y||0})
      })
      const outNodes=ns.map((n:any)=>{
        const pos=positionMap.get(n.data.id)||{x:0,y:0}
        let kind:string='l2'
        if(n.data.level===1) kind='l1'
        else if(n.data.level===2) kind='l2'
        else if(n.data.level===3) kind='l3'
        else if(n.data.level===4) kind='l4'
        else if(n.data.level==='function' || n.data.type==='Function') kind='fn'
        else if(n.data.type==='Port' || n.data.level==='port') kind='port'
        const className=n.data._neighbor?'rf-neighbor':''
        return {
          id:n.data.id,type:kind,position:pos,data:{...n.data},
          className,draggable:true,
        }
      })
      const outEdges=filteredEdges.map((e:any,i:number)=>({
        id:`e_${i}_${e.data.id}`,type:e.data.relation==='containment'?'containment':'flow',
        source:e.data.source,target:e.data.target,
        data:{...e.data,animated:showAnimation && e.data.flow_kind==='physical'},
      }))
      setRfNodes(outNodes); setRfEdges(outEdges)
      // Fit after layout settles
      setTimeout(()=>fitView({padding:0.18,duration:300}),60)
    }
    run()
    return ()=>{cancelled=true}
  },[ns,es,viewMode,flowMode,selectedFlowTypes,flowKindFilter,focusPath,showAnimation])

  // Hover/select styling without destroying/recreating
  const styledNodes=useMemo(()=>{
    return rfNodes.map(n=>{
      const isSelected=selectedId===n.id
      const isHover=hoverId===n.id
      const isRelated=isRelatedNode(rfEdges,selectedId,n.id) || isRelatedNode(rfEdges,hoverId||undefined,n.id)
      const dimmed=flowMode==='focus-path' && !!(selectedId||hoverId) && !isSelected && !isHover && !isRelated
      const baseClass=n.data._neighbor?'rf-neighbor':''
      const activeClass=dimmed?'rf-dimmed':baseClass
      return {...n,className:activeClass}
    })
  },[rfNodes,selectedId,hoverId,rfEdges,flowMode])

  const styledEdges=useMemo(()=>{
    if(flowMode!=='focus-path' || (!selectedId && !hoverId)) return rfEdges
    return rfEdges.map(e=>{
      const touchesSel=selectedId && (e.source===selectedId || e.target===selectedId)
      const touchesHover=hoverId && (e.source===hoverId || e.target===hoverId)
      const dimmed=!!(selectedId || hoverId) && !touchesSel && !touchesHover
      const active=selectedFlowId && (e.data.id===selectedFlowId || e.id===selectedFlowId)
      return {...e,selected:!!active,className:dimmed?'rf-dimmed':''}
    })
  },[rfEdges,selectedId,hoverId,flowMode,selectedFlowId])

  // Focus effect: pan to node without relayout
  useEffect(()=>{
    if(!focusId) return
    const node=rfNodes.find(n=>n.id===focusId)
    if(node){ setCenter(node.position.x+110, node.position.y+38, {zoom:Math.max(getZoom(),1.0),duration:400}) }
  },[focusId,rfNodes])

  const onNodeClick=useCallback((_e:any,node:any)=>{
    onSelect?.(node.data)
  },[onSelect])
  const onNodeDoubleClick=useCallback((_e:any,node:any)=>{
    onDrillDown?.(node.data)
  },[onDrillDown])
  const onEdgeClick=useCallback((_e:any,edge:any)=>{
    onSelect?.(edge.data)
  },[onSelect])
  const onEdgeMouseEnter=useCallback((_e:any,edge:any)=>setHoverEdgeId(edge.id),[])
  const onEdgeMouseLeave=useCallback(()=>setHoverEdgeId(null),[])
  const onNodeMouseEnter=useCallback((_e:any,node:any)=>setHoverId(node.id),[])
  const onNodeMouseLeave=useCallback(()=>setHoverId(null),[])

  return <div ref={containerRef} className="rf-canvas-wrap">
    <div className="rf-lane-legend">
      {lanes.map((x:string)=><span key={x} style={{background:LANE_COLORS[x]||LANE_COLORS['其他']}}>{x}</span>)}
      <span className="rf-zoom-info">{rfNodes.length} 节点 · {rfEdges.length} 边</span>
    </div>
    <ReactFlow
      nodes={styledNodes}
      edges={styledEdges.map(e=>({...e,data:{...e.data,showLabel:e.data.showLabel||e.id===hoverEdgeId||e.data.id===selectedFlowId}}))}
      nodeTypes={NODE_TYPES}
      edgeTypes={EDGE_TYPES}
      onNodeClick={onNodeClick}
      onNodeDoubleClick={onNodeDoubleClick}
      onEdgeClick={onEdgeClick}
      onEdgeMouseEnter={onEdgeMouseEnter}
      onEdgeMouseLeave={onEdgeMouseLeave}
      onNodeMouseEnter={onNodeMouseEnter}
      onNodeMouseLeave={onNodeMouseLeave}
      fitView
      minZoom={0.1}
      maxZoom={2.5}
      proOptions={{hideAttribution:true}}
    >
      <Background gap={24} color="#e0e6ec"/>
      <Controls position="bottom-right" showInteractive={false}/>
      <MiniMap pannable zoomable nodeColor={(n:any)=>LANE_COLORS[n?.data?.lane]||'#cfd8df'} maskColor="rgba(238,243,247,0.55)"/>
    </ReactFlow>
  </div>
}

function isRelatedNode(edges:any[],selId:string|undefined,nodeId:string){
  if(!selId) return false
  if(selId===nodeId) return true
  return edges.some(e=>(e.source===selId && e.target===nodeId)||(e.target===selId && e.source===nodeId))
}

export default function EngineeringFlow(props:Props){
  return <ReactFlowProvider>
    <InnerGraph {...props}/>
  </ReactFlowProvider>
}
