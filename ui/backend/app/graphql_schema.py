"""KG V2 GraphQL schema backed only by read-only Neo4j queries."""
from __future__ import annotations

import strawberry
from enum import Enum
from starlette.concurrency import run_in_threadpool
from strawberry.scalars import JSON
from .kg_v2_query_service import graph_queries
from .full_graph_service import full_graph, NODE_TYPES, REL_TYPES
from .design_query_service import design_queries

@strawberry.type
class Requirement:
    id: str
    name: str
    text: str
    source_type: str
    properties: JSON

@strawberry.type
class Function:
    id: str
    name: str
    category: str
    properties: JSON

@strawberry.type
class Product:
    code: str
    name: str
    level: int
    properties: JSON

@strawberry.type
class Port:
    id: str
    name: str
    product_code: str
    item_code: str
    profile_active: bool
    properties: JSON

@strawberry.type
class Item:
    code: str
    name: str
    properties: JSON

@strawberry.type
class RelationshipEvidence:
    status: str
    source: str
    source_file: str
    evidence: str
    mapping_type: str
    allocation_id: str
    connection_id: str
    relation_role: str
    provenance_class: str
    relation_status: str
    derivation_basis: str

@strawberry.type
class GraphNode:
    id: str
    node_type: str
    name: str
    properties: JSON

@strawberry.type
class GraphEdge:
    id: str
    relation_type: str
    source_id: str
    target_id: str
    evidence: RelationshipEvidence

@strawberry.type
class Subgraph:
    nodes: list[GraphNode]
    edges: list[GraphEdge]
    truncated: bool

@strawberry.type
class FunctionRoute:
    function: GraphNode
    owner_product: GraphNode | None
    participating_products: list[GraphNode]
    ports: list[GraphNode]
    items: list[GraphNode]
    formal_connections: list[GraphEdge]
    derived_connections: list[GraphEdge]
    physical_nets: list[GraphNode]
    graph: Subgraph

@strawberry.type
class ItemTransfer:
    source_product: GraphNode
    source_port: GraphNode
    target_port: GraphNode
    target_product: GraphNode
    connection: GraphEdge

@strawberry.type
class ItemRoute:
    item: GraphNode
    ports: list[GraphNode]
    transfers: list[ItemTransfer]
    physical_nets: list[GraphNode]
    external_boundaries: list[GraphNode]
    boundary_connections: list[GraphEdge]

def as_subgraph(data):
    return Subgraph(nodes=[GraphNode(**n) for n in data['nodes']],edges=[GraphEdge(id=e['id'],relation_type=e['relation_type'],source_id=e['source_id'],target_id=e['target_id'],evidence=RelationshipEvidence(**e['evidence'])) for e in data['edges']],truncated=data['truncated'])

def as_edge(edge):
    return GraphEdge(id=edge['id'],relation_type=edge['relation_type'],source_id=edge['source_id'],
                     target_id=edge['target_id'],evidence=RelationshipEvidence(**edge['evidence']))

NodeType = strawberry.enum(Enum('NodeType', {name:name for name in NODE_TYPES}))
RelationshipType = strawberry.enum(Enum('RelationshipType', {name:name for name in REL_TYPES}))

@strawberry.type
class GraphPayload(Subgraph):
    node_count: int
    edge_count: int
    node_counts: JSON
    relationship_counts: JSON

@strawberry.type
class GraphFocusInstruction:
    node_ids: list[str]
    edge_ids: list[str]
    node_types: list[str]
    relationship_types: list[str]
    fit_to_selection: bool
    dim_others: bool
    layout: str

@strawberry.type
class DesignCandidate:
    node: GraphNode
    score: float
    category: str
    metrics: JSON
    provenance: list[str]
    matched_terms: list[str]
    evidence: str
    source: str

@strawberry.type
class DesignRequirementResult:
    stage: str
    query: str
    answer: str
    candidates: list[DesignCandidate]
    stats: JSON
    graph: Subgraph
    graph_focus: GraphFocusInstruction
    provider: JSON
    selection: JSON

def as_design(data):
    return DesignRequirementResult(stage=data['stage'],query=data['query'],answer=data['answer'],
        candidates=[DesignCandidate(**{**c,'node':GraphNode(**c['node'])}) for c in data['candidates']],
        stats=data['stats'],graph=as_subgraph(data['graph']),graph_focus=GraphFocusInstruction(**data['graph_focus']),
        provider=data['provider'],selection=data['selection'])

@strawberry.type
class Query:
    @strawberry.field
    async def sysml_view(self,selection:JSON,view_type:str='INTERCONNECTION')->JSON:
        from .sysml_view_service import sysml_view
        return await run_in_threadpool(sysml_view,selection,view_type)

    @strawberry.field
    async def product_recommendation_evidence(self,product_code:str,requirement_ids:list[str]|None=None,function_ids:list[str]|None=None)->JSON:
        from .sysml_view_service import product_evidence
        return await run_in_threadpool(product_evidence,product_code,requirement_ids,function_ids)

    @strawberry.field
    async def full_graph(self,node_types:list[NodeType]|None=None,relationship_types:list[RelationshipType]|None=None,
                         include_derived:bool=True)->GraphPayload:
        data=await run_in_threadpool(full_graph,[v.value for v in node_types or []],
                                    [v.value for v in relationship_types or []],include_derived)
        graph=as_subgraph(data)
        return GraphPayload(nodes=graph.nodes,edges=graph.edges,truncated=graph.truncated,
            node_count=data['node_count'],edge_count=data['edge_count'],node_counts=data['node_counts'],
            relationship_counts=data['relationship_counts'])

    @strawberry.field
    async def design_requirements(self,query:str,limit:int=30)->DesignRequirementResult:
        return as_design(await run_in_threadpool(design_queries.requirements,query,limit))

    @strawberry.field
    async def design_functions(self,requirement_ids:list[str])->DesignRequirementResult:
        return as_design(await run_in_threadpool(design_queries.functions,requirement_ids))

    @strawberry.field
    async def design_products(self,requirement_ids:list[str],function_ids:list[str])->DesignRequirementResult:
        return as_design(await run_in_threadpool(design_queries.products,requirement_ids,function_ids))

    @strawberry.field
    async def design_interfaces(self,requirement_ids:list[str],function_ids:list[str],product_ids:list[str],
                                include_derived:bool=True)->DesignRequirementResult:
        return as_design(await run_in_threadpool(design_queries.interfaces,requirement_ids,function_ids,product_ids,include_derived))

    @strawberry.field
    async def design_question(self,query:str,requirement_ids:list[str]|None=None,function_ids:list[str]|None=None,
                              product_ids:list[str]|None=None,selected_node_id:str|None=None)->DesignRequirementResult:
        return as_design(await run_in_threadpool(design_queries.question,query,requirement_ids,function_ids,product_ids,selected_node_id))

    @strawberry.field
    def requirement(self,id:str)->Requirement|None:
        n=graph_queries.get('Requirement',id)
        return Requirement(id=n['id'],name=n['name'],text=n['properties'].get('text',''),source_type=n['properties'].get('source_type',''),properties=n['properties']) if n else None
    @strawberry.field(name='function')
    def function_node(self,id:str)->Function|None:
        n=graph_queries.get('Function',id)
        return Function(id=n['id'],name=n['name'],category=n['properties'].get('category',''),properties=n['properties']) if n else None
    @strawberry.field
    def product(self,code:str)->Product|None:
        n=graph_queries.get('Product',code)
        return Product(code=n['id'],name=n['name'],level=int(n['properties'].get('level',0)),properties=n['properties']) if n else None
    @strawberry.field
    def port(self,id:str)->Port|None:
        n=graph_queries.get('Port',id)
        p=n['properties'] if n else {}
        return Port(id=n['id'],name=n['name'],product_code=p.get('product_code',''),item_code=p.get('item_code',''),profile_active=bool(p.get('profile_active')),properties=p) if n else None
    @strawberry.field
    def item(self,code:str)->Item|None:
        n=graph_queries.get('Item',code)
        return Item(code=n['id'],name=n['name'],properties=n['properties']) if n else None
    @strawberry.field
    def search(self,text:str,types:list[str]|None=None)->list[GraphNode]:
        return [GraphNode(**n) for n in graph_queries.search(text,types)]
    @strawberry.field
    def neighbors(self,node_id:str,relation_types:list[str]|None=None,depth:int=1,max_nodes:int=100)->Subgraph:
        return as_subgraph(graph_queries.subgraph([node_id],depth,relation_types,max_nodes))
    @strawberry.field
    def path(self,source_id:str,target_id:str)->Subgraph:
        return as_subgraph(graph_queries.path(source_id,target_id))
    @strawberry.field
    def reverse_trace(self,node_id:str,max_nodes:int=80)->Subgraph:
        return as_subgraph(graph_queries.reverse_trace(node_id,max_nodes))
    @strawberry.field
    def requirement_trace(self,requirement_id:str)->Subgraph:
        return as_subgraph(graph_queries.requirement_trace(requirement_id))
    @strawberry.field
    def function_trace(self,function_id:str)->Subgraph:
        return as_subgraph(graph_queries.function_trace(function_id))
    @strawberry.field
    def function_route(self,function_id:str)->FunctionRoute|None:
        data=graph_queries.function_route(function_id)
        if not data: return None
        nodes=lambda rows: [GraphNode(**n) for n in rows]
        return FunctionRoute(function=GraphNode(**data['function']),
                             owner_product=GraphNode(**data['owner_product']) if data['owner_product'] else None,
                             participating_products=nodes(data['participating_products']),ports=nodes(data['ports']),
                             items=nodes(data['items']),formal_connections=[as_edge(e) for e in data['formal_connections']],
                             derived_connections=[as_edge(e) for e in data['derived_connections']],
                             physical_nets=nodes(data['physical_nets']),graph=as_subgraph(data['graph']))
    @strawberry.field
    def item_route(self,item_code:str)->ItemRoute|None:
        data=graph_queries.item_route(item_code)
        if not data: return None
        return ItemRoute(item=GraphNode(**data['item']),ports=[GraphNode(**n) for n in data['ports']],
                         physical_nets=[GraphNode(**n) for n in data['physical_nets']],
                         external_boundaries=[GraphNode(**n) for n in data['external_boundaries']],
                         boundary_connections=[as_edge(e) for e in data['boundary_connections']],
                         transfers=[ItemTransfer(source_product=GraphNode(**row['source_product']),
                                                 source_port=GraphNode(**row['source_port']),
                                                 target_port=GraphNode(**row['target_port']),
                                                 target_product=GraphNode(**row['target_product']),
                                                 connection=as_edge(row['connection'])) for row in data['transfers']])
    @strawberry.field
    def product_context(self,product_code:str)->Subgraph:
        return as_subgraph(graph_queries.product_context(product_code))
    @strawberry.field
    def subgraph(self,seed_ids:list[str],depth:int=1,relation_types:list[str]|None=None,max_nodes:int=100)->Subgraph:
        return as_subgraph(graph_queries.subgraph(seed_ids,depth,relation_types,max_nodes))

@strawberry.type
class Mutation:
    @strawberry.mutation
    async def export_design_ssi(self,selection:JSON)->JSON:
        from .sysml_ssi_service import export_ssi
        return await run_in_threadpool(export_ssi,selection)

schema=strawberry.Schema(query=Query,mutation=Mutation)
