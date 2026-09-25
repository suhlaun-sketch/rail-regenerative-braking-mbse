from common import *
def main():
 c=load_config(); data=read_json(GRAPH_DATA_PATH); d,s=neo4j_driver(c)
 try:
  verify_server(d,s); q="UNWIND $rows AS x MERGE (p:Product {code:x.code}) SET p += x"; cypher_rows(d,s['database'],q,data['products'])
  q="UNWIND $rows AS x MATCH (p:Product {code:x.parent_code}),(ch:Product {code:x.child_code}) MERGE (p)-[r:CONTAINS {relation_id:x.relation_id}]->(ch) SET r += x"; cypher_rows(d,s['database'],q,data['contains']); print('products loaded')
 finally:d.close()
if __name__=='__main__':main()
