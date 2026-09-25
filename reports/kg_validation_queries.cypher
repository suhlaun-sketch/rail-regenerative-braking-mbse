// Read-only validation samples; this file intentionally contains no connection creation.
MATCH (root:Product {code:'5000'})-[:CONTAINS*0..]->(p:Product) RETURN p;
MATCH (p:Product {code:'5311'})-[r:EXPOSES]->(i:Item) RETURN r,i;
MATCH (p:Product)-[r:EXPOSES]->(i:Item {item_name_cn:'旋转机械能'}) RETURN p,r;
MATCH (p:Product)-[r:EXPOSES {profile_id:'CRH_AC25KV_SC',profile_active:true}]->(i:Item) WHERE r.port_category='物理' RETURN p,r,i;
MATCH (p:Product)-[r:EXPOSES {profile_id:'CRH_AC25KV_SC',profile_active:false}]->(i:Item) RETURN p,r,i;
MATCH (root:Product {code:'X000'})-[:CONTAINS*0..]->(p:Product) RETURN p;
MATCH (p:Product)-[r:EXPOSES]->(i:Item {item_code:'ITM-PHY-003'}) RETURN p,r;
MATCH (n:Port) RETURN count(n) AS port_nodes;
