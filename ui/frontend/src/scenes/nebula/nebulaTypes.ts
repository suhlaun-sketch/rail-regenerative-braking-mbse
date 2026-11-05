import type {SceneController} from '../shared/sceneTypes'

export type NebulaClusterId = 'chief'|'scout'|'split'|'copy'|'design'|'code'|'test'|'proof'|'data'|'cut'|'ads'|'care'|'vault'

export interface NebulaClusterFixture {
  id: NebulaClusterId
  key: string
  label: string
  role: string
  color: string
}

export interface NebulaSnapshot {
  id: string
  title: string
  fixture: boolean
  clusters: NebulaClusterFixture[]
  engineering?: NebulaEngineeringState
}

export type EngineeringLayer = 'REQUIREMENT'|'FUNCTION'|'ARCHITECTURE'|'PHYSICAL'|'INTERFACE'|'PARAMETER_SIGNAL'
export type EngineeringProvenance = 'FORMAL_MODEL'|'EVIDENCE_DERIVED'|'AI_CANDIDATE'|'SIMULATION_EXECUTION'

export interface NebulaEngineeringNode {
  id:string
  label:string
  nodeType:string
  layer:EngineeringLayer
  clusterId:NebulaClusterId
  slot:number
  color:string
  active:boolean
}

export interface NebulaEngineeringEdge {
  id:string
  sourceId:string
  targetId:string
  sourceClusterId:NebulaClusterId
  targetClusterId:NebulaClusterId
  relationType:string
  provenance:EngineeringProvenance
  color:string
  active:boolean
}

export interface NebulaEngineeringState {
  query:string
  status:'IDLE'|'QUERYING'|'READY'|'ERROR'|'UNAVAILABLE'
  nodes:NebulaEngineeringNode[]
  edges:NebulaEngineeringEdge[]
  activeNodeId?:string
  activeEdgeId?:string
  logs:string[]
}

export type NebulaEvent =
  | {type:'focus'; id:string|null}
  | {type:'flash'; id:string}
  | {type:'relation'; sourceId:string; targetId:string; color?:string}
  | {type:'engineering-step'; sourceClusterId:NebulaClusterId; targetClusterId:NebulaClusterId; color?:string}
  | {type:'frame'; clusterIds:NebulaClusterId[]; mode:'global'|'query'|'focus'}
  | {type:'view'; index:number}
  | {type:'fast-forward'; seconds:number}

export interface NebulaDiagnostics {
  disposed: boolean
  fps: number
  state: Record<string, unknown> | null
  render: {calls:number;triangles:number;points:number} | null
  memory: {geometries:number;textures:number;programs:number} | null
  webgl: {context:string;pixelRatio:number;composer:boolean} | null
  gpu: {vendor:string;renderer:string} | null
}

export interface NebulaRendererOptions {
  snapshot?: NebulaSnapshot
  onNodeSelect?: (nodeId:string)=>void
  onManualControl?: ()=>void
}

export type NebulaSceneController = SceneController<NebulaSnapshot, NebulaEvent, NebulaDiagnostics>
