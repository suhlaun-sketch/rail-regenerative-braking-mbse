import {useCallback,useEffect,useMemo,useRef,useState} from 'react'
import type {GraphEdge,GraphNode,GraphSummary,Subgraph} from '../api/knowledgeGraph'
import {getGraphSummary,getNeighbors,getRequirementTrace,getReverseTrace,mergeGraphs,searchEntities} from '../api/knowledgeGraph'
import NebulaScene from '../components/scenes/NebulaScene'
import {adaptEdge,graphSnapshot,orderedEngineeringEdges,provenanceOf} from '../scenes/nebula/nebulaAdapter'
import type {NebulaSceneController,NebulaSnapshot} from '../scenes/nebula/nebulaTypes'
import './nebulaEngineering.css'

type QueryMode='main'|'neighbors'|'reverse'
const EMPTY:Subgraph={nodes:[],edges:[],truncated:false}
const EMPTY_SNAPSHOT:NebulaSnapshot={...graphSnapshot(EMPTY,'',undefined,undefined,['等待 Neo4j 只读连接']),engineering:{...graphSnapshot(EMPTY,'').engineering!,status:'IDLE'}}

function text(value:unknown){return value==null?'':String(value)}
function requirementId(node:GraphNode){return text(node.properties.requirement_id)||node.id}
function delay(ms:number,signal:AbortSignal){return new Promise<void>((resolve,reject)=>{const timer=setTimeout(resolve,ms);signal.addEventListener('abort',()=>{clearTimeout(timer);reject(new DOMException('Aborted','AbortError'))},{once:true})})}
function capGraph(graph:Subgraph,seedId:string,maxNodes:number):Subgraph{
  const byId=new Map(graph.nodes.map(n=>[n.id,n])),keep=new Set<string>(byId.has(seedId)?[seedId]:[]),edges:GraphEdge[]=[]
  const counts=new Map<string,number>(),caps:Record<string,number>={TRACE_TO_FUNCTION:4,SUPPORTS_IMPLEMENTATION:3,ALLOCATED_TO:5,PARTICIPATES_IN:3,USES_PORT:6,HAS_PORT:9,EXPOSES:7,CONNECTED_VIA:6,CONNECTS_TO:8,DERIVED_CONNECTS_TO:5,TERMINATES_AT:4,CONTAINS:4}
  const outgoing=new Map<string,GraphEdge[]>();graph.edges.forEach(e=>outgoing.set(e.sourceId,[...(outgoing.get(e.sourceId)??[]),e]))
  const queue:{id:string;path:GraphEdge[]}[]=[{id:seedId,path:[]}],visited=new Set([seedId]);let physicalPath:GraphEdge[]=[]
  while(queue.length&&!physicalPath.length){const current=queue.shift()!;if(current.path.length>=7)continue;const next=[...(outgoing.get(current.id)??[])].sort((a,b)=>a.relationType.localeCompare(b.relationType)||a.id.localeCompare(b.id));for(const edge of next){if(visited.has(edge.targetId))continue;const path=[...current.path,edge],target=byId.get(edge.targetId);if(target&&(target.nodeType==='PhysicalNet'||target.nodeType==='ExternalBoundary')){physicalPath=path;break}visited.add(edge.targetId);queue.push({id:edge.targetId,path})}}
  physicalPath.forEach(edge=>{if(keep.size<maxNodes){keep.add(edge.sourceId);keep.add(edge.targetId);edges.push(edge);counts.set(edge.relationType,(counts.get(edge.relationType)??0)+1)}})
  for(const edge of orderedEngineeringEdges(graph,seedId,Math.max(graph.edges.length,maxNodes*3))){
    if(edges.some(e=>e.id===edge.id))continue
    if((counts.get(edge.relationType)??0)>=(caps[edge.relationType]??8))continue
    const additions=[edge.sourceId,edge.targetId].filter(id=>!keep.has(id))
    if(keep.size+additions.length>maxNodes)continue
    if(!byId.has(edge.sourceId)||!byId.has(edge.targetId))continue
    keep.add(edge.sourceId);keep.add(edge.targetId);edges.push(edge);counts.set(edge.relationType,(counts.get(edge.relationType)??0)+1)
  }
  if(!keep.size)graph.nodes.slice(0,maxNodes).forEach(n=>keep.add(n.id))
  return {nodes:graph.nodes.filter(n=>keep.has(n.id)),edges,truncated:graph.truncated||graph.nodes.length>keep.size}
}
function evidenceRows(edge:GraphEdge){return Object.entries(edge.evidence).filter(([,v])=>text(v).trim())}

export default function NebulaEngineeringPage(){
  const controllerRef=useRef<NebulaSceneController|null>(null),abortRef=useRef<AbortController|null>(null),runRef=useRef(0),graphRef=useRef<Subgraph>(EMPTY)
  const [snapshot,setSnapshot]=useState<NebulaSnapshot>(EMPTY_SNAPSHOT),[graph,setGraph]=useState<Subgraph>(EMPTY)
  const [query,setQuery]=useState('常用制动平均减速度需求'),[mode,setMode]=useState<QueryMode>('main'),[maxNodes,setMaxNodes]=useState(36)
  const [summary,setSummary]=useState<GraphSummary|null>(null),[busy,setBusy]=useState(false),[error,setError]=useState('')
  const [selectedNode,setSelectedNode]=useState<GraphNode|null>(null),[selectedEdge,setSelectedEdge]=useState<GraphEdge|null>(null),[logs,setLogs]=useState<string[]>(['等待 Neo4j 只读连接'])
  const nodesById=useMemo(()=>new Map(graph.nodes.map(n=>[n.id,n])),[graph.nodes])

  const publish=useCallback((next:Subgraph,q:string,activeNodeId?:string,activeEdgeId?:string,nextLogs=logs)=>{
    graphRef.current=next;setGraph(next)
    const s=graphSnapshot(next,q,activeNodeId,activeEdgeId,nextLogs);setSnapshot(s);controllerRef.current?.setSnapshot(s)
  },[logs])

  useEffect(()=>{
    const abort=new AbortController()
    const timer=window.setTimeout(()=>getGraphSummary(abort.signal).then(s=>{
      setSummary(s)
      if(s.status!=='CONNECTED'){
        const nextLogs=['Neo4j 数据不可用；场景保持运行，未载入模拟查询结果']
        const unavailable={...EMPTY_SNAPSHOT,engineering:{...EMPTY_SNAPSHOT.engineering!,status:'UNAVAILABLE' as const,logs:nextLogs}}
        setLogs(nextLogs);setSnapshot(unavailable);controllerRef.current?.setSnapshot(unavailable)
      }else setLogs([`Neo4j CONNECTED · ${s.nodeCount} nodes · ${s.relationshipCount} relations · READ ONLY`])
    }).catch(e=>{
      if(e.name==='AbortError')return
      setError(e.message);const nextLogs=[`Neo4j 不可用：${e.message}`]
      const unavailable={...EMPTY_SNAPSHOT,engineering:{...EMPTY_SNAPSHOT.engineering!,status:'UNAVAILABLE' as const,logs:nextLogs}}
      setLogs(nextLogs);setSnapshot(unavailable);controllerRef.current?.setSnapshot(unavailable)
    }),0)
    return()=>{clearTimeout(timer);abort.abort()}
  },[])

  const animate=useCallback(async(full:Subgraph,seed:GraphNode,q:string,signal:AbortSignal,base:Subgraph,run:number)=>{
    const bounded=capGraph(full,seed.id,maxNodes),nodeMap=new Map(bounded.nodes.map(n=>[n.id,n])),allowed=new Set(nodeMap.keys()),visibleNodes=new Map(base.nodes.filter(n=>allowed.has(n.id)).map(n=>[n.id,n])),visibleEdges=new Map(base.edges.filter(e=>allowed.has(e.sourceId)&&allowed.has(e.targetId)).map(e=>[e.id,e]))
    visibleNodes.set(seed.id,seed)
    let nextLogs=[...logs,`命中种子 ${seed.nodeType} · ${seed.name} · ${seed.id}`].slice(-18)
    publish({nodes:[...visibleNodes.values()],edges:[...visibleEdges.values()],truncated:bounded.truncated},q,seed.id,undefined,nextLogs)
    for(const edge of orderedEngineeringEdges(bounded,seed.id,maxNodes*3)){
      if(signal.aborted||run!==runRef.current)throw new DOMException('Aborted','AbortError')
      const source=nodeMap.get(edge.sourceId),target=nodeMap.get(edge.targetId);if(!source||!target)continue
      visibleNodes.set(source.id,source);visibleNodes.set(target.id,target);visibleEdges.set(edge.id,edge)
      nextLogs=[...nextLogs,`${source.name} —${edge.relationType}→ ${target.name}`].slice(-18)
      const next={nodes:[...visibleNodes.values()],edges:[...visibleEdges.values()],truncated:bounded.truncated}
      publish(next,q,target.id,edge.id,nextLogs)
      const adapted=adaptEdge(edge,nodeMap,true)
      controllerRef.current?.dispatch({type:'engineering-step',sourceClusterId:adapted.sourceClusterId,targetClusterId:adapted.targetClusterId,color:adapted.color})
      await delay(360,signal)
    }
    const done={nodes:[...visibleNodes.values()],edges:[...visibleEdges.values()],truncated:bounded.truncated}
    nextLogs=[...nextLogs,`展开完成 · ${done.nodes.length} nodes · ${done.edges.length} relations${done.truncated?' · 已按上限截断':''}`].slice(-18)
    setLogs(nextLogs);publish(done,q,seed.id,undefined,nextLogs);setSelectedNode(seed);setSelectedEdge(null)
  },[logs,maxNodes,publish])

  const runQuery=useCallback(async(nextMode:QueryMode=mode,nodeOverride?:GraphNode)=>{
    if(summary?.status!=='CONNECTED'){setError('Neo4j 未连接，未执行查询');return}
    abortRef.current?.abort();const abort=new AbortController();abortRef.current=abort;const run=++runRef.current
    setBusy(true);setError('');setMode(nextMode)
    try{
      let seed=nodeOverride??selectedNode,full:Subgraph
      if(nextMode==='main'){
        const matches=await searchEntities(query.trim(),['Requirement'],abort.signal)
        if(!matches.length)throw new Error('未找到与问题匹配的真实 Requirement；未使用模拟结果')
        seed=matches.find(n=>n.name===query.trim())??matches[0]
        full=await getRequirementTrace(requirementId(seed),abort.signal)
        if(!full.nodes.length)throw new Error(`Requirement ${requirementId(seed)} 没有可回查的正式工程关系`)
        await animate(full,seed,query.trim(),abort.signal,EMPTY,run)
      }else{
        if(!seed)throw new Error('请先选择一个真实节点再继续展开')
        full=nextMode==='neighbors'?await getNeighbors(seed.id,[],1,maxNodes,abort.signal):await getReverseTrace(seed.id,maxNodes,abort.signal)
        if(!full.nodes.length)throw new Error(nextMode==='reverse'?'当前节点没有指向它的 Requirement 有向追溯链':'当前节点没有可展开邻居')
        const merged=mergeGraphs(graphRef.current,full)
        await animate(merged,seed,query.trim(),abort.signal,graphRef.current,run)
      }
    }catch(e){
      const err=e as Error;if(err.name!=='AbortError'){setError(err.message);const next=[...logs,`ERROR · ${err.message}`].slice(-18);setLogs(next);const failed={...snapshot,engineering:{...snapshot.engineering!,status:'ERROR' as const,logs:next}};setSnapshot(failed);controllerRef.current?.setSnapshot(failed)}
    }finally{if(run===runRef.current)setBusy(false)}
  },[animate,logs,maxNodes,mode,query,selectedNode,snapshot,summary?.status])

  const cancel=()=>{abortRef.current?.abort();runRef.current++;setBusy(false);setLogs(v=>[...v,'查询已取消；已生成节点保持可检查'].slice(-18))}
  const selectNode=useCallback((id:string)=>{const node=nodesById.get(id);if(!node)return;setSelectedNode(node);setSelectedEdge(null);const s=graphSnapshot(graphRef.current,query,node.id,undefined,logs);setSnapshot(s);controllerRef.current?.setSnapshot(s)},[logs,nodesById,query])
  const layerCounts=useMemo(()=>graph.nodes.reduce((a,n)=>{const k=n.nodeType==='Requirement'?'Requirement':n.nodeType==='Function'?'Function':n.nodeType==='PhysicalNet'||n.nodeType==='ExternalBoundary'?'Physical':'Architecture';a[k]=(a[k]||0)+1;return a},{} as Record<string,number>),[graph.nodes])

  return <main className="nebula-engineering-page">
    <NebulaScene snapshot={snapshot} onReady={c=>{controllerRef.current=c;c.setSnapshot(snapshot)}} onNodeSelect={selectNode}/>
    <section className="nek-query" aria-label="真实工程知识查询">
      <header><b>ENGINEERING KNOWLEDGE QUERY</b><span className={summary?.status==='CONNECTED'?'ok':'off'}>{summary?.status??'CHECKING'}</span><em>READ ONLY</em></header>
      <form onSubmit={e=>{e.preventDefault();void runQuery('main')}}><input value={query} onChange={e=>setQuery(e.target.value)} aria-label="工程问题"/><button disabled={busy||summary?.status!=='CONNECTED'}>{busy?'展开中':'查询主链'}</button>{busy&&<button type="button" onClick={cancel}>取消</button>}</form>
      <div className="nek-controls"><button className={mode==='main'?'active':''} onClick={()=>setMode('main')}>主链模式</button><button className={mode==='neighbors'?'active':''} disabled={!selectedNode||busy} onClick={()=>void runQuery('neighbors')}>邻居展开</button><button className={mode==='reverse'?'active':''} disabled={!selectedNode||busy} onClick={()=>void runQuery('reverse')}>反向追溯</button><div className="nek-provenance"><i className="formal"/>正式模型 <i className="derived"/>证据派生 <i className="ai"/>AI候选 <i className="simulation"/>仿真执行</div><label>上限 <select value={maxNodes} onChange={e=>setMaxNodes(Number(e.target.value))}><option>24</option><option>36</option><option>60</option><option>80</option></select></label></div>
      {error&&<p className="nek-error">{error}</p>}
    </section>
    <section className="nek-layer-strip"><span>Requirement <b>{layerCounts.Requirement??0}</b></span><i>→</i><span>Function <b>{layerCounts.Function??0}</b></span><i>→</i><span className="gap">Logical <b>0 · 无正式实体</b></span><i>→</i><span>Architecture <b>{layerCounts.Architecture??0}</b></span><i>→</i><span>Physical <b>{layerCounts.Physical??0}</b></span></section>
    <aside className="nek-evidence">
      <header><b>SOURCE EVIDENCE</b><span>节点与关系证据</span></header>
      {selectedNode?<div className="nek-detail"><small>{selectedNode.nodeType}</small><h2>{selectedNode.name}</h2><code>{selectedNode.id}</code><dl>{Object.entries(selectedNode.properties).filter(([,v])=>text(v)).slice(0,18).map(([k,v])=><div key={k}><dt>{k}</dt><dd>{Array.isArray(v)?v.join(' · '):typeof v==='object'?JSON.stringify(v):text(v)}</dd></div>)}</dl><footer><button disabled={busy} onClick={()=>void runQuery('neighbors',selectedNode)}>继续展开邻居</button><button disabled={busy} onClick={()=>void runQuery('reverse',selectedNode)}>回溯到需求</button></footer></div>:selectedEdge?<div className="nek-detail"><small>RELATION · {provenanceOf(selectedEdge)}</small><h2>{selectedEdge.relationType}</h2><code>{selectedEdge.id}</code><p>{selectedEdge.sourceId}<br/>↓<br/>{selectedEdge.targetId}</p><dl>{evidenceRows(selectedEdge).map(([k,v])=><div key={k}><dt>{k}</dt><dd>{text(v)}</dd></div>)}</dl></div>:<p className="nek-empty">运行查询后，点击星云内实体标签、节点清单或关系，查看真实 ID、类型和来源。</p>}
    </aside>
    <section className="nek-results"><header><b>QUERY EXPANSION LOG</b><span>{graph.nodes.length} NODES · {graph.edges.length} RELATIONS</span></header><div className="nek-result-grid"><div>{graph.nodes.slice(0,28).map(n=><button className={selectedNode?.id===n.id?'active':''} key={n.id} onClick={()=>selectNode(n.id)}><small>{n.nodeType}</small><span>{n.name}</span><code>{n.id}</code></button>)}</div><div>{graph.edges.slice(0,32).map(e=><button className={selectedEdge?.id===e.id?'active':''} key={e.id} onClick={()=>{setSelectedEdge(e);setSelectedNode(null);const s=graphSnapshot(graphRef.current,query,undefined,e.id,logs);setSnapshot(s);controllerRef.current?.setSnapshot(s)}}><span>{e.relationType}</span><small>{provenanceOf(e)}</small></button>)}</div></div></section>
  </main>
}
