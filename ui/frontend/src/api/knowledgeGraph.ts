import { graphqlRequest } from './graphqlClient'

export const ENTITY_TYPES = ['Requirement', 'Function', 'Product', 'Port', 'Item', 'PhysicalNet', 'ExternalBoundary'] as const
export const RELATION_TYPES = ['TRACE_TO_FUNCTION', 'SUPPORTS_IMPLEMENTATION', 'DERIVED_FROM', 'ALLOCATED_TO', 'PARTICIPATES_IN', 'CONTAINS', 'HAS_PORT', 'EXPOSES', 'CONNECTS_TO', 'DERIVED_CONNECTS_TO', 'TERMINATES_AT', 'CONNECTED_VIA', 'CONNECTS', 'NET_MEMBER', 'USES_PORT'] as const
export const RELATION_STATUSES = ['AUTHORITATIVE', 'DERIVED', 'PREDICTED', 'CONFIRMED'] as const

export type EntityType = typeof ENTITY_TYPES[number]
export type RelationType = typeof RELATION_TYPES[number]
export type RelationStatus = typeof RELATION_STATUSES[number]
export type NodeProperties = Record<string, unknown>
export type GraphNode = { id: string; nodeType: string; name: string; properties: NodeProperties }
export type RelationshipEvidence = { status: string; source: string; sourceFile: string; evidence: string; mappingType: string; allocationId: string; connectionId: string; relationRole: string; provenanceClass: string; relationStatus: string; derivationBasis: string }
export type GraphEdge = { id: string; relationType: string; sourceId: string; targetId: string; evidence: RelationshipEvidence }
export type Subgraph = { nodes: GraphNode[]; edges: GraphEdge[]; truncated: boolean }
export type GraphSummary = { status: string; database: string; nodeCount: number; relationshipCount: number }
export type EntityCount = { count: number; capped: boolean }
export type FunctionRoute = { function: GraphNode; ownerProduct: GraphNode | null; participatingProducts: GraphNode[]; ports: GraphNode[]; items: GraphNode[]; formalConnections: GraphEdge[]; derivedConnections: GraphEdge[]; physicalNets: GraphNode[]; graph: Subgraph }
export type ItemTransfer = { sourceProduct: GraphNode; sourcePort: GraphNode; targetPort: GraphNode; targetProduct: GraphNode; connection: GraphEdge }
export type ItemRoute = { item: GraphNode; ports: GraphNode[]; transfers: ItemTransfer[]; physicalNets: GraphNode[]; externalBoundaries: GraphNode[]; boundaryConnections: GraphEdge[] }

const NODE_FIELDS = 'id nodeType name properties'
const EDGE_FIELDS = 'id relationType sourceId targetId evidence { status source sourceFile evidence mappingType allocationId connectionId relationRole provenanceClass relationStatus derivationBasis }'
const GRAPH_FIELDS = `nodes { ${NODE_FIELDS} } edges { ${EDGE_FIELDS} } truncated`

export async function getGraphSummary(signal?: AbortSignal): Promise<GraphSummary> {
  const response = await fetch('/api/kg/summary', { signal })
  if (!response.ok) throw new Error(`图谱统计获取失败（HTTP ${response.status}）`)
  return response.json() as Promise<GraphSummary>
}

export async function searchEntities(text: string, types: string[] = [], signal?: AbortSignal): Promise<GraphNode[]> {
  const data = await graphqlRequest<{ search: GraphNode[] }>(
    `query Search($text:String!,$types:[String!]) { search(text:$text,types:$types) { ${NODE_FIELDS} } }`,
    { text, types }, signal,
  )
  return data.search
}

export async function getEntityCounts(signal?: AbortSignal): Promise<Record<EntityType, EntityCount>> {
  const result = await Promise.all(ENTITY_TYPES.map(async type => {
    const nodes = await searchEntities('', [type], signal)
    return [type, { count: nodes.length, capped: nodes.length >= 50 }] as const
  }))
  return Object.fromEntries(result) as Record<EntityType, EntityCount>
}

export async function getNeighbors(nodeId: string, relationTypes: string[] = [], depth = 1, maxNodes = 100, signal?: AbortSignal): Promise<Subgraph> {
  const data = await graphqlRequest<{ neighbors: Subgraph }>(
    `query Neighbors($nodeId:String!,$relationTypes:[String!],$depth:Int!,$maxNodes:Int!) { neighbors(nodeId:$nodeId,relationTypes:$relationTypes,depth:$depth,maxNodes:$maxNodes) { ${GRAPH_FIELDS} } }`,
    { nodeId, relationTypes, depth, maxNodes }, signal,
  )
  return data.neighbors
}

export async function getRequirementTrace(requirementId: string, signal?: AbortSignal): Promise<Subgraph> {
  const data = await graphqlRequest<{ requirementTrace: Subgraph }>(
    `query RequirementTrace($id:String!) { requirementTrace(requirementId:$id) { ${GRAPH_FIELDS} } }`,
    { id: requirementId }, signal,
  )
  return data.requirementTrace
}

export async function getFunctionTrace(functionId: string, signal?: AbortSignal): Promise<Subgraph> {
  const data = await graphqlRequest<{ functionTrace: Subgraph }>(
    `query FunctionTrace($id:String!) { functionTrace(functionId:$id) { ${GRAPH_FIELDS} } }`,
    { id: functionId }, signal,
  )
  return data.functionTrace
}

export async function getFunctionRoute(functionId: string, signal?: AbortSignal): Promise<FunctionRoute | null> {
  const data = await graphqlRequest<{ functionRoute: FunctionRoute | null }>(
    `query FunctionRoute($id:String!) { functionRoute(functionId:$id) { function { ${NODE_FIELDS} } ownerProduct { ${NODE_FIELDS} } participatingProducts { ${NODE_FIELDS} } ports { ${NODE_FIELDS} } items { ${NODE_FIELDS} } formalConnections { ${EDGE_FIELDS} } derivedConnections { ${EDGE_FIELDS} } physicalNets { ${NODE_FIELDS} } graph { ${GRAPH_FIELDS} } } }`,
    { id: functionId }, signal,
  )
  return data.functionRoute
}

export async function getItemRoute(itemCode: string, signal?: AbortSignal): Promise<ItemRoute | null> {
  const data = await graphqlRequest<{ itemRoute: ItemRoute | null }>(
    `query ItemRoute($code:String!) { itemRoute(itemCode:$code) { item { ${NODE_FIELDS} } ports { ${NODE_FIELDS} } physicalNets { ${NODE_FIELDS} } externalBoundaries { ${NODE_FIELDS} } boundaryConnections { ${EDGE_FIELDS} } transfers { sourceProduct { ${NODE_FIELDS} } sourcePort { ${NODE_FIELDS} } targetPort { ${NODE_FIELDS} } targetProduct { ${NODE_FIELDS} } connection { ${EDGE_FIELDS} } } } }`,
    { code: itemCode }, signal,
  )
  return data.itemRoute
}

export async function getProductContext(productCode: string, signal?: AbortSignal): Promise<Subgraph> {
  const data = await graphqlRequest<{ productContext: Subgraph }>(
    `query ProductContext($code:String!) { productContext(productCode:$code) { ${GRAPH_FIELDS} } }`,
    { code: productCode }, signal,
  )
  return data.productContext
}

export async function findPath(sourceId: string, targetId: string, signal?: AbortSignal): Promise<Subgraph> {
  const data = await graphqlRequest<{ path: Subgraph }>(
    `query Path($source:String!,$target:String!) { path(sourceId:$source,targetId:$target) { ${GRAPH_FIELDS} } }`,
    { source: sourceId, target: targetId }, signal,
  )
  return data.path
}

export async function getReverseTrace(nodeId:string,maxNodes=80,signal?:AbortSignal):Promise<Subgraph>{
  const data=await graphqlRequest<{reverseTrace:Subgraph}>(
    `query ReverseTrace($nodeId:String!,$maxNodes:Int!){reverseTrace(nodeId:$nodeId,maxNodes:$maxNodes){${GRAPH_FIELDS}}}`,
    {nodeId,maxNodes},signal,
  )
  return data.reverseTrace
}

export async function getSubgraph(seedIds: string[], depth: number, relationTypes: string[] = [], maxNodes = 120, signal?: AbortSignal): Promise<Subgraph> {
  const data = await graphqlRequest<{ subgraph: Subgraph }>(
    `query Subgraph($seedIds:[String!]!,$depth:Int!,$relationTypes:[String!],$maxNodes:Int!) { subgraph(seedIds:$seedIds,depth:$depth,relationTypes:$relationTypes,maxNodes:$maxNodes) { ${GRAPH_FIELDS} } }`,
    { seedIds, depth, relationTypes, maxNodes }, signal,
  )
  return data.subgraph
}

export function mergeGraphs(...graphs: Subgraph[]): Subgraph {
  const nodes = new Map<string, GraphNode>()
  const edges = new Map<string, GraphEdge>()
  graphs.forEach(graph => {
    graph.nodes.forEach(node => nodes.set(node.id, node))
    graph.edges.forEach(edge => edges.set(edge.id, edge))
  })
  return { nodes: [...nodes.values()], edges: [...edges.values()], truncated: graphs.some(graph => graph.truncated) }
}

export function initialRequirementView(graph: Subgraph, requirementId: string): Subgraph {
  const allDirect = graph.edges.filter(edge => edge.sourceId === requirementId && edge.relationType === 'TRACE_TO_FUNCTION')
  const allFunctionIds = new Set(allDirect.map(edge => edge.targetId))
  const allAllocations = graph.edges.filter(edge => edge.relationType === 'ALLOCATED_TO' && allFunctionIds.has(edge.sourceId))
  const featuredAllocation = allAllocations.find(edge => edge.targetId === '7211') ?? allAllocations[0]
  const direct = featuredAllocation ? allDirect.filter(edge => edge.targetId === featuredAllocation.sourceId) : allDirect
  const allocations = featuredAllocation ? [featuredAllocation] : []
  const ownerId = featuredAllocation?.targetId
  const included = new Set<string>([requirementId, ...direct.map(edge => edge.targetId), ...allocations.map(edge => edge.targetId)])
  const connectionTypes = new Set(['CONNECTS_TO', 'DERIVED_CONNECTS_TO', 'TERMINATES_AT'])
  const portEdges = graph.edges.filter(edge => edge.relationType === 'HAS_PORT' && edge.sourceId === ownerId)
    .filter(edge => graph.edges.some(connection => connectionTypes.has(connection.relationType) && (connection.sourceId === edge.targetId || connection.targetId === edge.targetId)))
    .sort((a, b) => {
      const aName = graph.nodes.find(node => node.id === a.targetId)?.name ?? ''
      const bName = graph.nodes.find(node => node.id === b.targetId)?.name ?? ''
      const rank = (name: string) => /再生|动态制动/.test(name) ? 0 : 1
      return rank(aName) - rank(bName) || a.targetId.localeCompare(b.targetId)
    }).slice(0, 2)
  portEdges.forEach(edge => included.add(edge.targetId))
  const connections = portEdges.flatMap(port => graph.edges
    .filter(edge => connectionTypes.has(edge.relationType) && (edge.sourceId === port.targetId || edge.targetId === port.targetId))
    .sort((a, b) => a.id.localeCompare(b.id)).slice(0, 1))
  connections.forEach(edge => { included.add(edge.sourceId); included.add(edge.targetId) })
  const neighborProducts = graph.edges.filter(edge => edge.relationType === 'HAS_PORT' && included.has(edge.targetId) && edge.sourceId !== ownerId)
  neighborProducts.forEach(edge => included.add(edge.sourceId))
  return {
    nodes: graph.nodes.filter(node => included.has(node.id)),
    edges: graph.edges.filter(edge => included.has(edge.sourceId) && included.has(edge.targetId) && (
      direct.includes(edge) || allocations.includes(edge) || portEdges.includes(edge) || connections.includes(edge) || neighborProducts.includes(edge)
    )),
    truncated: graph.truncated,
  }
}
