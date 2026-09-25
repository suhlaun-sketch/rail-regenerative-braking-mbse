from common import *
def main():
 c=load_config(); data=read_json(GRAPH_DATA_PATH); d,s=neo4j_driver(c)
 try:
  verify_server(d,s); cypher_rows(d,s['database'],"UNWIND $rows AS x MERGE (i:Item {item_code:x.item_code}) SET i += x",data['items']); d.execute_query("MERGE (p:Profile {profile_id:$id}) SET p += $x",id=c['profile']['profile_id'],x={**c['profile'],"project_id":c['project_id']},database_=s['database']); print('items/profile loaded')
 finally:d.close()
if __name__=='__main__':main()
