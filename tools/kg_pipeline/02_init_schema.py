from common import *
def main():
 c=load_config(); d,s=neo4j_driver(c)
 try:
  verify_server(d,s)
  for x in c['constraints']+c['indexes']: d.execute_query(x['cypher'],database_=s['database'])
  print('Neo4j connectivity/auth/database/schema PASS')
 finally: d.close()
if __name__=='__main__': main()
