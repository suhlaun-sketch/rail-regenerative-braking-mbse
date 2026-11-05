import type {GraphEdge,Subgraph} from '../../api/knowledgeGraph'
import {graphSnapshot,orderedEngineeringEdges} from './nebulaAdapter'
import type {NebulaClusterId} from './nebulaTypes'

export type EngineeringStageId='INPUT'|'REQUIREMENT'|'FUNCTION'|'ARCHITECTURE'|'INTERFACE'|'SIGNAL'|'COMPLETE'
export type EngineeringStage={id:EngineeringStageId;label:string;message:string;graph:Subgraph;events:GraphEdge[];clusters:NebulaClusterId[]}
export type EngineeringPlayback={stage:number;eventCount:number;playing:boolean;mode:'AUTO'|'EXPLORE'}

export const ENGINEERING_STAGES:[EngineeringStageId,string,string][]=[
  ['INPUT','输入指令','真实查询已完成，等待播放工程关系。'],
  ['REQUIREMENT','需求检索','已检索到相关需求。'],
  ['FUNCTION','关联功能','沿正式追溯关系展开承担目标的系统功能。'],
  ['ARCHITECTURE','架构承接','依据功能分配展开产品架构；图谱没有独立 Logical 实体。'],
  ['INTERFACE','接口展开','展开产品所属端口与实际连接关系。'],
  ['SIGNAL','参数与信号','展示真实 Item、物理网络、外部边界及端口属性。'],
  ['COMPLETE','完整路径','保持本次查询的完整真实工程路径。'],
]

const EMPTY:Subgraph={nodes:[],edges:[],truncated:false}

function unique<T>(values:T[]){return [...new Set(values)]}
function graphByTypes(full:Subgraph,types:string[]):Subgraph{
  const allowed=new Set(full.nodes.filter(node=>types.includes(node.nodeType)).map(node=>node.id))
  return {nodes:full.nodes.filter(node=>allowed.has(node.id)),edges:full.edges.filter(edge=>allowed.has(edge.sourceId)&&allowed.has(edge.targetId)),truncated:full.truncated}
}
export function clustersOf(graph:Subgraph):NebulaClusterId[]{
  return unique((graphSnapshot(graph,'').engineering?.nodes??[]).map(node=>node.clusterId))
}
export function buildEngineeringPlan(full:Subgraph,seedId:string):EngineeringStage[]{
  const types=[['Requirement'],['Requirement','Function'],['Requirement','Function','Product','Profile'],['Requirement','Function','Product','Profile','Port'],['Requirement','Function','Product','Profile','Port','Item','PhysicalNet','ExternalBoundary']]
  const graphs=[EMPTY,...types.map(type=>graphByTypes(full,type)),full]
  return ENGINEERING_STAGES.map(([id,label,message],index)=>{
    const graph=graphs[index]??full,previous=graphs[Math.max(0,index-1)]??EMPTY,prior=new Set(previous.edges.map(edge=>edge.id))
    const events=orderedEngineeringEdges(graph,seedId,graph.edges.length).filter(edge=>!prior.has(edge.id)).slice(0,8)
    return {id,label,message,graph,events,clusters:clustersOf(graph)}
  })
}
export function graphAtPlayback(plan:EngineeringStage[],playback:EngineeringPlayback):Subgraph{
  const target=plan[playback.stage]?.graph??EMPTY
  if(playback.stage<=1)return target
  const previous=plan[playback.stage-1]?.graph??EMPTY,current=plan[playback.stage],count=Math.min(playback.eventCount,current.events.length)
  if(!current.events.length||count>=current.events.length)return target
  const nodes=new Map(previous.nodes.map(node=>[node.id,node])),edges=new Map(previous.edges.map(edge=>[edge.id,edge])),byId=new Map(target.nodes.map(node=>[node.id,node]))
  current.events.slice(0,count).forEach(edge=>{const source=byId.get(edge.sourceId),targetNode=byId.get(edge.targetId);if(source)nodes.set(source.id,source);if(targetNode)nodes.set(targetNode.id,targetNode);edges.set(edge.id,edge)})
  return {nodes:[...nodes.values()],edges:[...edges.values()],truncated:target.truncated}
}
