"""Bounded, read-only Neo4j queries for KG V2 GraphQL."""
from __future__ import annotations

import os
from neo4j import GraphDatabase

DB='motor-brake-system'
URI='neo4j://127.0.0.1:7687'
LABELS={'Requirement':'requirement_id','Function':'function_id','Product':'code','Port':'port_id','Item':'item_code'}
RELATION_TYPES={'TRACE_TO_FUNCTION','SUPPORTS_IMPLEMENTATION','DERIVED_FROM','ALLOCATED_TO','CONTAINS','HAS_PORT','EXPOSES','CONNECTS_TO','DERIVED_CONNECTS_TO','TERMINATES_AT','CONNECTED_VIA','CONNECTS','NET_MEMBER','USES_PORT','PARTICIPATES_IN'}
TRACE_TYPES=['TRACE_TO_FUNCTION','SUPPORTS_IMPLEMENTATION','ALLOCATED_TO','PARTICIPATES_IN','USES_PORT','HAS_PORT','EXPOSES','CONNECTS_TO','DERIVED_CONNECTS_TO','TERMINATES_AT','CONNECTED_VIA','CONNECTS']

class GraphQueryService:
    def __init__(self): self._driver=None
    @property
    def driver(self):
        if self._driver is None:
            password=os.environ.get('NEO4J_PASSWORD')
            if not password: raise RuntimeError('NEO4J_PASSWORD is absent from local environment')
            if os.environ.get('NEO4J_DATABASE',DB)!=DB: raise ValueError('NEO4J_DATABASE must be exactly motor-brake-system')
            if os.environ.get('NEO4J_URI',URI)!=URI: raise ValueError('NEO4J_URI differs from approved endpoint')
            if os.environ.get('NEO4J_USER','neo4j')!='neo4j': raise ValueError('NEO4J_USER differs from approved user')
            self._driver=GraphDatabase.driver(URI,auth=('neo4j',password),connection_timeout=10)
            self._driver.verify_connectivity()
        return self._driver
    def close(self):
        if self._driver: self._driver.close(); self._driver=None
    def records(self,query,**params):
        with self.driver.session(database=DB,default_access_mode='READ') as session:
            return [dict(r) for r in session.run(query,**params)]
    @staticmethod
    def node(row):
        p=row.get('properties') or {}
        return {'id':row['id'],'node_type':next((t for t in row['labels'] if t in LABELS or t in ('Profile','PhysicalNet','ExternalBoundary')),row['labels'][0] if row['labels'] else ''),'name':p.get('name') or p.get('item_name_cn') or row['id'],'properties':p}
    @staticmethod
    def edge(row):
        p=row.get('properties') or {}
        return {'id':row['id'],'relation_type':row['relation_type'],'source_id':row['source_id'],'target_id':row['target_id'],'evidence':{'status':p.get('status',''),'source':p.get('source',''),'source_file':p.get('source_file',''),'evidence':p.get('evidence',''),'mapping_type':p.get('mapping_type',''),'allocation_id':p.get('allocation_id',''),'connection_id':p.get('connection_id',''),'relation_role':p.get('relation_role',''),'provenance_class':p.get('provenance_class',p.get('status','')),'relation_status':p.get('relation_status',''),'derivation_basis':p.get('derivation_basis','')}}
    def get(self,label,value):
        if label not in LABELS: raise ValueError('Unknown node label')
        key=LABELS[label]
        rows=self.records(f'MATCH (n:{label} {{{key}:$value}}) WHERE n.kg_v2=true RETURN n.kg_v2_id AS id, labels(n) AS labels, properties(n) AS properties LIMIT 1',value=value)
        return self.node(rows[0]) if rows else None
    def search(self,text,types=None):
        query='MATCH (n) WHERE n.kg_v2=true AND ($types=[] OR any(t IN $types WHERE t IN labels(n))) AND (any(k IN ["name","text","description","code","requirement_id","function_id","port_id","item_code","kg_v2_id"] WHERE n[k] IS NOT NULL AND toLower(toString(n[k])) CONTAINS toLower($text)) OR any(t IN labels(n) WHERE toLower(t)=toLower($text))) RETURN n.kg_v2_id AS id, labels(n) AS labels, properties(n) AS properties ORDER BY CASE WHEN n.kg_v2_id=$text THEN 0 ELSE 1 END, id LIMIT 50'
        if types and any(t not in LABELS and t not in ('Profile','PhysicalNet','ExternalBoundary') for t in types): raise ValueError('Unknown node type filter')
        allowed=[t for t in (types or []) if t in LABELS or t in ('Profile','PhysicalNet','ExternalBoundary')]
        return [self.node(r) for r in self.records(query,text=text.strip(),types=allowed)]
    def subgraph(self,seed_ids,depth=1,relation_types=None,max_nodes=200):
        depth=max(0,min(int(depth),5)); max_nodes=max(1,min(int(max_nodes),200)); max_edges=min(max_nodes*4,500)
        seeds=list(dict.fromkeys(seed_ids))[:20]
        if relation_types and any(r not in RELATION_TYPES for r in relation_types): raise ValueError('Unknown relationship type filter')
        rels=[r for r in (relation_types or []) if r in RELATION_TYPES]
        start=self.records('MATCH (n) WHERE n.kg_v2=true AND n.kg_v2_id IN $ids RETURN n.kg_v2_id AS id, labels(n) AS labels, properties(n) AS properties LIMIT 20',ids=seeds)
        nodes={r['id']:self.node(r) for r in start}; edges={}; frontier=list(nodes); seen=set(frontier)
        query='UNWIND $frontier AS fid MATCH (a {kg_v2_id:fid})-[r]-(b) WHERE r.kg_v2=true AND b.kg_v2=true AND ($types=[] OR type(r) IN $types) RETURN b.kg_v2_id AS id,labels(b) AS labels,properties(b) AS properties,coalesce(r.enrichment_relation_id,r.v2_relation_id,r.relation_id) AS edge_id,type(r) AS relation_type,startNode(r).kg_v2_id AS source_id,endNode(r).kg_v2_id AS target_id,properties(r) AS edge_properties LIMIT $cap'
        for _ in range(depth):
            if not frontier or len(nodes)>=max_nodes or len(edges)>=max_edges: break
            rows=self.records(query,frontier=frontier,types=rels,cap=max_edges-len(edges)); next_frontier=[]
            for r in rows:
                if r['id'] not in nodes:
                    if len(nodes)>=max_nodes: continue
                    nodes[r['id']]=self.node(r)
                if r['edge_id'] and r['edge_id'] not in edges and r['source_id'] in nodes and r['target_id'] in nodes and len(edges)<max_edges:
                    edges[r['edge_id']]=self.edge({'id':r['edge_id'],'relation_type':r['relation_type'],'source_id':r['source_id'],'target_id':r['target_id'],'properties':r['edge_properties']})
                if r['id'] not in seen:
                    seen.add(r['id']);next_frontier.append(r['id'])
            frontier=next_frontier
        return {'nodes':list(nodes.values()),'edges':list(edges.values()),'truncated':len(nodes)>=max_nodes or len(edges)>=max_edges}
    def path(self,source_id,target_id):
        q='MATCH (a {kg_v2_id:$source}), (b {kg_v2_id:$target}) MATCH p=shortestPath((a)-[*..6]-(b)) WHERE all(r IN relationships(p) WHERE r.kg_v2=true) RETURN [n IN nodes(p) | {id:n.kg_v2_id, labels:labels(n), properties:properties(n)}] AS nodes,[r IN relationships(p) | {id:coalesce(r.enrichment_relation_id,r.v2_relation_id,r.relation_id), relation_type:type(r), source_id:startNode(r).kg_v2_id,target_id:endNode(r).kg_v2_id,properties:properties(r)}] AS edges LIMIT 1'
        rows=self.records(q,source=source_id,target=target_id)
        if not rows: return {'nodes':[],'edges':[],'truncated':False}
        return {'nodes':[self.node(n) for n in rows[0]['nodes']],'edges':[self.edge(e) for e in rows[0]['edges']],'truncated':False}

    def reverse_trace(self,node_id,max_nodes=80):
        """Return bounded, directed Requirement-to-target paths using existing KG V2 relations only."""
        max_nodes=max(2,min(int(max_nodes),120))
        rows=self.records('''MATCH (target {kg_v2_id:$target})
            MATCH p=(req:Requirement)-[rels*1..6]->(target)
            WHERE req.kg_v2=true AND target.kg_v2=true
              AND all(r IN rels WHERE r.kg_v2=true AND type(r) IN $types)
            RETURN [n IN nodes(p) | {id:n.kg_v2_id,labels:labels(n),properties:properties(n)}] AS nodes,
                   [r IN relationships(p) | {id:coalesce(r.enrichment_relation_id,r.v2_relation_id,r.relation_id),relation_type:type(r),source_id:startNode(r).kg_v2_id,target_id:endNode(r).kg_v2_id,properties:properties(r)}] AS edges,
                   length(p) AS length ORDER BY length LIMIT 30''',target=node_id,types=TRACE_TYPES)
        nodes={};edges={};truncated=False
        for row in rows:
            for raw in row['nodes']:
                if raw['id'] in nodes: continue
                if len(nodes)>=max_nodes: truncated=True; continue
                nodes[raw['id']]=self.node(raw)
            for raw in row['edges']:
                if not raw['id'] or raw['id'] in edges: continue
                if raw['source_id'] in nodes and raw['target_id'] in nodes:
                    edges[raw['id']]=self.edge(raw)
        return {'nodes':list(nodes.values()),'edges':list(edges.values()),'truncated':truncated}
    def _structured_trace(self,kind,ident):
        """Follow the engineering chain in order; never expand reverse trace branches."""
        nodes={}; edges={}; truncated=False; limit=200
        start=self.get(kind,ident)
        if not start: return {'nodes':[],'edges':[],'truncated':False}
        nodes[start['id']]=start
        link_return='RETURN a.kg_v2_id AS a_id,labels(a) AS a_labels,properties(a) AS a_properties,b.kg_v2_id AS b_id,labels(b) AS b_labels,properties(b) AS b_properties,coalesce(r.enrichment_relation_id,r.v2_relation_id,r.relation_id) AS edge_id,type(r) AS relation_type,startNode(r).kg_v2_id AS source_id,endNode(r).kg_v2_id AS target_id,properties(r) AS edge_properties LIMIT $cap'
        def add_links(query,**params):
            nonlocal truncated
            rows=self.records(query+' '+link_return,cap=500,**params)
            for r in rows:
                if not r['edge_id']: continue
                if r['a_id'] not in nodes:
                    if len(nodes)>=limit: truncated=True; continue
                    nodes[r['a_id']]=self.node({'id':r['a_id'],'labels':r['a_labels'],'properties':r['a_properties']})
                if r['b_id'] not in nodes:
                    if len(nodes)>=limit: truncated=True; continue
                    nodes[r['b_id']]=self.node({'id':r['b_id'],'labels':r['b_labels'],'properties':r['b_properties']})
                if r['source_id'] in nodes and r['target_id'] in nodes:
                    edges[r['edge_id']]=self.edge({'id':r['edge_id'],'relation_type':r['relation_type'],'source_id':r['source_id'],'target_id':r['target_id'],'properties':r['edge_properties']})
        if kind=='Requirement':
            add_links('MATCH (a:Requirement {requirement_id:$id})-[r:TRACE_TO_FUNCTION|SUPPORTS_IMPLEMENTATION]->(b:Function) WHERE r.kg_v2=true',id=ident)
            function_ids=[n['id'] for n in nodes.values() if n['node_type']=='Function']
            add_links('MATCH (a:Function)-[r:ALLOCATED_TO]->(b:Product) WHERE a.function_id IN $ids AND r.kg_v2=true',ids=function_ids)
        elif kind=='Function':
            add_links('MATCH (a:Function {function_id:$id})-[r:ALLOCATED_TO]->(b:Product) WHERE r.kg_v2=true',id=ident)
            add_links('MATCH (a:Function {function_id:$id})-[r:PARTICIPATES_IN]->(b:Product) WHERE r.kg_v2=true',id=ident)
            add_links('MATCH (a:Function {function_id:$id})-[r:USES_PORT]->(b:Port) WHERE r.kg_v2=true',id=ident)
        product_ids=[n['id'] for n in nodes.values() if n['node_type']=='Product']
        if kind!='Function':
            add_links('MATCH (a:Product)-[r:HAS_PORT]->(b:Port) WHERE a.code IN $ids AND r.kg_v2=true',ids=product_ids)
        port_ids=[n['id'] for n in nodes.values() if n['node_type']=='Port']
        if kind=='Function':
            add_links('MATCH (a:Product)-[r:HAS_PORT]->(b:Port) WHERE b.port_id IN $ids AND r.kg_v2=true',ids=port_ids)
        add_links('MATCH (a:Port)-[r:EXPOSES]->(b:Item) WHERE a.port_id IN $ids AND r.kg_v2=true',ids=port_ids)
        # Reserve room for neighbor Products and their HAS_PORT edges.
        connection_rows=self.records('MATCH (a:Port)-[r:CONNECTS_TO|DERIVED_CONNECTS_TO|TERMINATES_AT]-(b) WHERE a.port_id IN $ids AND r.kg_v2=true '+link_return,ids=port_ids,cap=500)
        neighbor_ids=[]
        for r in connection_rows:
            if not r['edge_id'] or r['edge_id'] in edges: continue
            if r['b_id'] not in nodes and len(nodes)>=limit-35: truncated=True; continue
            if r['b_id'] not in nodes:
                nodes[r['b_id']]=self.node({'id':r['b_id'],'labels':r['b_labels'],'properties':r['b_properties']})
            if r['source_id'] in nodes and r['target_id'] in nodes:
                edges[r['edge_id']]=self.edge({'id':r['edge_id'],'relation_type':r['relation_type'],'source_id':r['source_id'],'target_id':r['target_id'],'properties':r['edge_properties']})
            if nodes[r['b_id']]['node_type']=='Port': neighbor_ids.append(r['b_id'])
        add_links('MATCH (a:Product)-[r:HAS_PORT]->(b:Port) WHERE b.port_id IN $ids AND r.kg_v2=true',ids=list(set(neighbor_ids)))
        if kind=='Function':
            add_links('MATCH (a:Port)-[r:CONNECTED_VIA]->(b:PhysicalNet) WHERE a.port_id IN $ids AND r.kg_v2=true',ids=port_ids)
        return {'nodes':list(nodes.values()),'edges':list(edges.values()),'truncated':truncated}
    def requirement_trace(self,requirement_id): return self._structured_trace('Requirement',requirement_id)
    def function_trace(self,function_id): return self._structured_trace('Function',function_id)
    def product_context(self,product_code): return self._structured_trace('Product',product_code)

    def function_route(self,function_id):
        """A bounded function route assembled from indexed Neo4j identities."""
        function=self.get('Function',function_id)
        if not function: return None
        graph=self.function_trace(function_id)
        nodes={n['id']:n for n in graph['nodes']}
        edges={e['id']:e for e in graph['edges']}
        formal_ids=list(dict.fromkeys(function['properties'].get('route_formal_connection_ids') or []))[:100]
        net_ids=list(dict.fromkeys(function['properties'].get('route_physical_net_ids') or []))[:20]
        extra=self.records("""MATCH (a)-[r:CONNECTS_TO|TERMINATES_AT]->(b)
            WHERE r.kg_v2=true AND r.connection_id IN $ids
            RETURN a.kg_v2_id AS a_id, labels(a) AS a_labels, properties(a) AS a_properties,
            b.kg_v2_id AS b_id, labels(b) AS b_labels, properties(b) AS b_properties,
            coalesce(r.v2_relation_id,r.relation_id) AS edge_id, type(r) AS relation_type,
            properties(r) AS edge_properties LIMIT 100""",ids=formal_ids)
        for row in extra:
            nodes[row['a_id']]=self.node({'id':row['a_id'],'labels':row['a_labels'],'properties':row['a_properties']})
            nodes[row['b_id']]=self.node({'id':row['b_id'],'labels':row['b_labels'],'properties':row['b_properties']})
            if row['edge_id']:
                edges[row['edge_id']]=self.edge({'id':row['edge_id'],'relation_type':row['relation_type'],
                                                 'source_id':row['a_id'],'target_id':row['b_id'],
                                                 'properties':row['edge_properties']})
        for row in self.records("""MATCH (n:PhysicalNet) WHERE n.net_id IN $ids AND n.kg_v2=true
            RETURN n.kg_v2_id AS id,labels(n) AS labels,properties(n) AS properties LIMIT 20""",ids=net_ids):
            nodes[row['id']]=self.node(row)
        port_ids=[n['id'] for n in nodes.values() if n['node_type']=='Port']
        for row in self.records("""MATCH (owner:Product)-[r:HAS_PORT]->(port:Port)
            WHERE port.port_id IN $ids AND r.kg_v2=true
            RETURN owner.kg_v2_id AS a_id,labels(owner) AS a_labels,properties(owner) AS a_properties,
            port.kg_v2_id AS b_id,labels(port) AS b_labels,properties(port) AS b_properties,
            r.v2_relation_id AS edge_id,type(r) AS relation_type,properties(r) AS edge_properties LIMIT 100""",ids=port_ids):
            nodes[row['a_id']]=self.node({'id':row['a_id'],'labels':row['a_labels'],'properties':row['a_properties']})
            if row['edge_id']:
                edges[row['edge_id']]=self.edge({'id':row['edge_id'],'relation_type':row['relation_type'],
                                                 'source_id':row['a_id'],'target_id':row['b_id'],
                                                 'properties':row['edge_properties']})
        for row in self.records("""MATCH (port:Port)-[r:EXPOSES]->(item:Item)
            WHERE port.port_id IN $ids AND r.kg_v2=true
            RETURN item.kg_v2_id AS id,labels(item) AS labels,properties(item) AS properties,
            port.kg_v2_id AS source_id,r.v2_relation_id AS edge_id,properties(r) AS edge_properties LIMIT 100""",ids=port_ids):
            nodes[row['id']]=self.node(row)
            if row['edge_id']:
                edges[row['edge_id']]=self.edge({'id':row['edge_id'],'relation_type':'EXPOSES',
                                                 'source_id':row['source_id'],'target_id':row['id'],
                                                 'properties':row['edge_properties']})
        graph={'nodes':list(nodes.values())[:200], 'edges':[], 'truncated':graph['truncated'] or len(nodes)>200}
        included={n['id'] for n in graph['nodes']}
        graph['edges']=[e for e in edges.values() if e['source_id'] in included and e['target_id'] in included][:500]
        owner_id=next((e['target_id'] for e in graph['edges'] if e['source_id']==function_id and e['relation_type']=='ALLOCATED_TO'),None)
        return {
            'function':function,
            'owner_product':nodes.get(owner_id),
            'participating_products':[nodes[e['target_id']] for e in graph['edges']
                                      if e['source_id']==function_id and e['relation_type']=='PARTICIPATES_IN'
                                      and e['target_id'] in nodes],
            'ports':[n for n in graph['nodes'] if n['node_type']=='Port'],
            'items':[n for n in graph['nodes'] if n['node_type']=='Item'],
            'formal_connections':[e for e in graph['edges'] if e['relation_type'] in ('CONNECTS_TO','TERMINATES_AT')],
            'derived_connections':[e for e in graph['edges'] if e['relation_type']=='DERIVED_CONNECTS_TO'],
            'physical_nets':[n for n in graph['nodes'] if n['node_type']=='PhysicalNet'],
            'graph':graph,
        }

    def item_route(self,item_code):
        """Return actual directed Port transfers for one Item, including provenance."""
        item=self.get('Item',item_code)
        if not item: return None
        exposed=self.records("""MATCH (port:Port)-[r:EXPOSES]->(item:Item {item_code:$code})
            WHERE r.kg_v2=true RETURN port.kg_v2_id AS id,labels(port) AS labels,
            properties(port) AS properties LIMIT 100""",code=item_code)
        ports=[self.node(row) for row in exposed]
        port_ids=[port['id'] for port in ports]
        rows=self.records("""MATCH (source_product:Product)-[:HAS_PORT]->(source_port:Port)
            -[connection:CONNECTS_TO|DERIVED_CONNECTS_TO]->(target_port:Port)<-[:HAS_PORT]-(target_product:Product)
            WHERE connection.kg_v2=true AND connection.item_code=$code
            RETURN source_product.kg_v2_id AS sp_id,labels(source_product) AS sp_labels,properties(source_product) AS sp_properties,
            source_port.kg_v2_id AS source_id,labels(source_port) AS source_labels,properties(source_port) AS source_properties,
            target_port.kg_v2_id AS target_id,labels(target_port) AS target_labels,properties(target_port) AS target_properties,
            target_product.kg_v2_id AS tp_id,labels(target_product) AS tp_labels,properties(target_product) AS tp_properties,
            coalesce(connection.enrichment_relation_id,connection.v2_relation_id) AS edge_id,
            type(connection) AS relation_type,properties(connection) AS edge_properties LIMIT 100""",code=item_code)
        transfers=[]
        for row in rows:
            transfers.append({
                'source_product':self.node({'id':row['sp_id'],'labels':row['sp_labels'],'properties':row['sp_properties']}),
                'source_port':self.node({'id':row['source_id'],'labels':row['source_labels'],'properties':row['source_properties']}),
                'target_port':self.node({'id':row['target_id'],'labels':row['target_labels'],'properties':row['target_properties']}),
                'target_product':self.node({'id':row['tp_id'],'labels':row['tp_labels'],'properties':row['tp_properties']}),
                'connection':self.edge({'id':row['edge_id'],'relation_type':row['relation_type'],
                                        'source_id':row['source_id'],'target_id':row['target_id'],
                                        'properties':row['edge_properties']}),
            })
        physical_nets=[self.node(row) for row in self.records("""MATCH (port:Port)-[r:CONNECTED_VIA]->(net:PhysicalNet)
            WHERE port.port_id IN $ids AND r.kg_v2=true
            RETURN DISTINCT net.kg_v2_id AS id,labels(net) AS labels,properties(net) AS properties LIMIT 20""",ids=port_ids)]
        boundary_rows=self.records("""MATCH (port:Port)-[r:TERMINATES_AT]->(boundary:ExternalBoundary)
            WHERE port.port_id IN $ids AND r.kg_v2=true
            RETURN boundary.kg_v2_id AS id,labels(boundary) AS labels,properties(boundary) AS properties,
            port.kg_v2_id AS source_id,r.v2_relation_id AS edge_id,properties(r) AS edge_properties LIMIT 30""",ids=port_ids)
        boundaries={row['id']:self.node(row) for row in boundary_rows}
        boundary_connections=[self.edge({'id':row['edge_id'],'relation_type':'TERMINATES_AT',
                                         'source_id':row['source_id'],'target_id':row['id'],
                                         'properties':row['edge_properties']}) for row in boundary_rows if row['edge_id']]
        return {'item':item,'ports':ports,'transfers':transfers,'physical_nets':physical_nets,
                'external_boundaries':list(boundaries.values()),'boundary_connections':boundary_connections}

graph_queries=GraphQueryService()
