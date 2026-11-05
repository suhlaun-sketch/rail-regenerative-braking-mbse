import type {GraphEdge,GraphNode,Subgraph} from '../../api/knowledgeGraph'
import {NEBULA_FIXTURE} from './nebulaConstants'
import type {EngineeringLayer,EngineeringProvenance,NebulaClusterId,NebulaEngineeringEdge,NebulaEngineeringNode,NebulaSnapshot} from './nebulaTypes'

const TYPE_CLUSTER:Record<string,NebulaClusterId>={Requirement:'scout',Function:'split',Product:'code',Port:'design',Item:'data',PhysicalNet:'test',ExternalBoundary:'vault',Profile:'proof'}
const TYPE_COLOR:Record<string,string>={Requirement:'#68A9B9',Function:'#9990BA',Product:'#799AB2',Port:'#C39879',Item:'#84AD96',PhysicalNet:'#B9A17D',ExternalBoundary:'#9C927F',Profile:'#8D9AA5'}
const CLUSTER_INDEX:Record<NebulaClusterId,number>={chief:0,scout:1,split:2,copy:3,design:4,code:5,test:6,proof:7,data:8,cut:9,ads:10,care:11,vault:12}

export function engineeringLayer(nodeType:string):EngineeringLayer{
  if(nodeType==='Requirement')return 'REQUIREMENT'
  if(nodeType==='Function')return 'FUNCTION'
  if(nodeType==='Port')return 'INTERFACE'
  if(nodeType==='Item')return 'PARAMETER_SIGNAL'
  if(nodeType==='PhysicalNet'||nodeType==='ExternalBoundary')return 'PHYSICAL'
  return 'ARCHITECTURE'
}

export function provenanceOf(edge:GraphEdge):EngineeringProvenance{
  const e=edge.evidence
  const text=[e.status,e.source,e.sourceFile,e.mappingType,e.provenanceClass,e.relationRole,e.evidence].join(' ').toLowerCase()
  if(/predicted|\bai\b|llm|candidate/.test(text))return 'AI_CANDIDATE'
  if(/simulation|simulink|fmu|ssp|cosim|physical_vv/.test(text))return 'SIMULATION_EXECUTION'
  if(/authoritative|frozen_v2|sysml|formal final|formal requirement/.test(text))return 'FORMAL_MODEL'
  return 'EVIDENCE_DERIVED'
}

export function stableSlot(id:string):number{
  let h=2166136261
  for(let i=0;i<id.length;i++){h^=id.charCodeAt(i);h=Math.imul(h,16777619)}
  return Math.abs(h) % 14
}

export function adaptNode(node:GraphNode,active=false):NebulaEngineeringNode{
  const clusterId=TYPE_CLUSTER[node.nodeType]??'care'
  return {id:node.id,label:node.name,nodeType:node.nodeType,layer:engineeringLayer(node.nodeType),clusterId,slot:stableSlot(node.id),color:TYPE_COLOR[node.nodeType]??'#9ee6ff',active}
}

export function adaptEdge(edge:GraphEdge,nodes:Map<string,GraphNode>,active=false):NebulaEngineeringEdge{
  const source=adaptNode(nodes.get(edge.sourceId)??{id:edge.sourceId,name:edge.sourceId,nodeType:'Unknown',properties:{}})
  const target=adaptNode(nodes.get(edge.targetId)??{id:edge.targetId,name:edge.targetId,nodeType:'Unknown',properties:{}})
  const provenance=provenanceOf(edge)
  const colors:Record<EngineeringProvenance,string>={FORMAL_MODEL:'#62e3ff',EVIDENCE_DERIVED:'#a093ff',AI_CANDIDATE:'#ff6fae',SIMULATION_EXECUTION:'#ffd27a'}
  return {id:edge.id,sourceId:edge.sourceId,targetId:edge.targetId,sourceClusterId:source.clusterId,targetClusterId:target.clusterId,relationType:edge.relationType,provenance,color:colors[provenance],active}
}

export function graphSnapshot(graph:Subgraph,query:string,activeNodeId?:string,activeEdgeId?:string,logs:string[]=[]):NebulaSnapshot{
  const sourceNodes=new Map(graph.nodes.map(n=>[n.id,n]))
  return {
    ...NEBULA_FIXTURE,
    id:`engineering-${query}`,
    title:'真实工程知识查询',
    fixture:false,
    clusters:NEBULA_FIXTURE.clusters.map(c=>({...c,...({
      chief:{label:'工程关系核心',role:'本次查询的真实工程子图'},scout:{label:'需求',role:'Requirement · 正式需求'},split:{label:'功能',role:'Function · 系统功能'},design:{label:'接口',role:'Port / Interface'},code:{label:'架构与产品',role:'Product · SysML 产品层级'},test:{label:'物理网络',role:'PhysicalNet'},data:{label:'参数与信号',role:'Item / Flow · 仅显示真实数据'},proof:{label:'证据来源',role:'来源与状态'},vault:{label:'外部边界',role:'ExternalBoundary'},care:{label:'未分类',role:'仅承载真实未分类对象'}
    } as Record<string,Partial<typeof c>>)[c.id]})),
    engineering:{query,status:'READY',nodes:graph.nodes.map(n=>adaptNode(n,n.id===activeNodeId)),edges:graph.edges.map(e=>adaptEdge(e,sourceNodes,e.id===activeEdgeId)),activeNodeId,activeEdgeId,logs},
  }
}

const REL_RANK:Record<string,number>={TRACE_TO_FUNCTION:0,SUPPORTS_IMPLEMENTATION:0,ALLOCATED_TO:1,PARTICIPATES_IN:2,USES_PORT:2,HAS_PORT:3,EXPOSES:4,CONNECTED_VIA:5,CONNECTS_TO:5,DERIVED_CONNECTS_TO:6,TERMINATES_AT:6,CONTAINS:7,CONNECTS:7,DERIVED_FROM:8}

export function orderedEngineeringEdges(graph:Subgraph,seedId:string,limit=40):GraphEdge[]{
  const seen=new Set([seedId]),remaining=[...graph.edges],ordered:GraphEdge[]=[]
  while(remaining.length&&ordered.length<limit){
    remaining.sort((a,b)=>(REL_RANK[a.relationType]??99)-(REL_RANK[b.relationType]??99)||a.id.localeCompare(b.id))
    let index=remaining.findIndex(e=>seen.has(e.sourceId)||seen.has(e.targetId))
    if(index<0)index=0
    const [edge]=remaining.splice(index,1)
    if(edge.sourceId===edge.targetId)continue
    ordered.push(edge);seen.add(edge.sourceId);seen.add(edge.targetId)
  }
  return ordered
}

export function clusterIndex(id:NebulaClusterId):number{return CLUSTER_INDEX[id]}
