"""Idempotently UPSERT the resolved ConnectGraph into Neo4j."""
from __future__ import annotations
import os
from dotenv import load_dotenv
from neo4j import GraphDatabase
from common import *

def main():
 load_dotenv(ROOT/'tools'/'kg_pipeline'/'.env',override=False);cfg=read(ROOT/'tools'/'kg_pipeline'/'config'/'graph_schema.yaml');uri=os.getenv('NEO4J_URI',cfg['uri']).strip();db=os.getenv('NEO4J_DATABASE',cfg['database']).strip();user=os.getenv('NEO4J_USER',cfg['user']).strip();password=os.getenv('NEO4J_PASSWORD','')
 if db!='motor-brake-system' or not password:raise ValueError('Neo4j target/password configuration invalid')
 con=read(WORK/'final_connections.json')['connections'];net=read(WORK/'final_nets.json');driver=GraphDatabase.driver(uri,auth=(user,password),connection_timeout=10)
 try:
  driver.verify_connectivity()
  for q in ["CREATE CONSTRAINT physical_net_id_unique IF NOT EXISTS FOR (n:PhysicalNet) REQUIRE n.net_id IS UNIQUE","CREATE CONSTRAINT external_boundary_id_unique IF NOT EXISTS FOR (n:ExternalBoundary) REQUIRE n.boundary_id IS UNIQUE"]:driver.execute_query(q,database_=db)
  driver.execute_query("UNWIND $rows AS x MERGE (n:PhysicalNet {net_id:x.net_id}) SET n += x",rows=net['physical_nets'],database_=db)
  driver.execute_query("UNWIND $rows AS x MERGE (n:ExternalBoundary {boundary_id:x.boundary_id}) SET n += x",rows=net['external_boundaries'],database_=db)
  pp=[x for x in con if x['target_product']];pb=[x for x in con if x['target_boundary']]
  driver.execute_query("UNWIND $rows AS x MATCH (a:Product {code:x.source_product,project_id:x.project_id}),(b:Product {code:x.target_product,project_id:x.project_id}) MERGE (a)-[r:CONNECTS_TO {connection_id:x.connection_id}]->(b) SET r += x",rows=pp,database_=db)
  driver.execute_query("UNWIND $rows AS x MATCH (a:Product {code:x.source_product,project_id:x.project_id}),(b:ExternalBoundary {boundary_id:x.target_boundary}) MERGE (a)-[r:CONNECTS_TO {connection_id:x.connection_id}]->(b) SET r += x",rows=pb,database_=db)
  driver.execute_query("UNWIND $rows AS x MATCH (a:Product {code:x.product_code,project_id:x.project_id}),(b:PhysicalNet {net_id:x.net_id}) MERGE (a)-[r:NET_MEMBER {membership_id:x.membership_id}]->(b) SET r += x",rows=net['net_memberships'],database_=db)
  rec=driver.execute_query("MATCH ()-[r:CONNECTS_TO {project_id:$p,profile_id:$pr}]->() WITH count(r) AS c MATCH (n:PhysicalNet {project_id:$p,profile_id:$pr}) WITH c,count(n) AS nets MATCH ()-[m:NET_MEMBER {project_id:$p,profile_id:$pr}]->() RETURN c,nets,count(m) AS members",p='RAIL_MBSE_TRACTION_BRAKE',pr='CRH_AC25KV_SC',database_=db)[0][0]
  print(json.dumps(dict(rec),ensure_ascii=False))
 finally:driver.close()
if __name__=='__main__':main()
