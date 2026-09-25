from common import *
def main():
 c=load_config(); d,s=neo4j_driver(c); pid=c['project_id']; prof=c['profile']['profile_id']; result={};
 try:
  verify_server(d,s)
  qs={'Product':"MATCH (n:Product {project_id:$p}) RETURN count(n) AS n",'Item':"MATCH (n:Item {project_id:$p}) RETURN count(n) AS n",'Profile':"MATCH (n:Profile {project_id:$p}) RETURN count(n) AS n",'CONTAINS':"MATCH ()-[r:CONTAINS {project_id:$p}]->() RETURN count(r) AS n",'EXPOSES':"MATCH ()-[r:EXPOSES {project_id:$p}]->() RETURN count(r) AS n",'Active':"MATCH ()-[r:EXPOSES {project_id:$p,profile_id:$pr,profile_active:true}]->() RETURN count(r) AS n",'Inactive':"MATCH ()-[r:EXPOSES {project_id:$p,profile_id:$pr,profile_active:false}]->() RETURN count(r) AS n"}
  for k,q in qs.items(): result[k]=d.execute_query(q,p=pid,pr=prof,database_=s['database'])[0][0]['n']
  result['Port_nodes']=d.execute_query('MATCH (n:Port) RETURN count(n) AS n',database_=s['database'])[0][0]['n']; expected=read_json(GRAPH_DATA_PATH)['meta']['counts']; result['QA']='PASS' if result['Port_nodes']==0 and result['EXPOSES']==expected['exposes'] else 'FAIL';
  report=['# KG Import Report','',f"- URI: {s['uri']}",f"- database: {s['database']}",f"- Product数量: {result['Product']}",f"- Item数量: {result['Item']}",f"- Profile数量: {result['Profile']}",f"- CONTAINS数量: {result['CONTAINS']}",f"- EXPOSES数量: {result['EXPOSES']}",f"- Active EXPOSES数量: {result['Active']}",f"- Inactive EXPOSES数量: {result['Inactive']}",f"- Port节点数量: {result['Port_nodes']}",f"- QA: {result['QA']}"]
  KG_REPORT.parent.mkdir(exist_ok=True); KG_REPORT.write_text('\n'.join(report)+'\n',encoding='utf-8'); print(result)
 finally:d.close()
if __name__=='__main__':main()
