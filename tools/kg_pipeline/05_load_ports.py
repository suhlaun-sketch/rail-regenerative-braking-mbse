from common import *
def main():
 c=load_config(); data=read_json(GRAPH_DATA_PATH); d,s=neo4j_driver(c)
 try:
  verify_server(d,s); q="UNWIND $rows AS x MATCH (p:Product {code:x.product_code}),(i:Item {item_code:x.item_code}) MERGE (p)-[r:EXPOSES {port_id:x.port_id}]->(i) SET r += x"; cypher_rows(d,s['database'],q,data['exposes']); print('EXPOSES loaded')
 finally:d.close()
if __name__=='__main__':main()
