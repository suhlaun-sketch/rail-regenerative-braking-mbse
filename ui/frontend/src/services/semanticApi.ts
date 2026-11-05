import {api} from '../api'

export type SemanticRequirement={requirement_id:string;name:string;description?:string;text?:string;source?:string;source_file?:string;status?:string;semantic_score?:number;match_reason?:string;matched_keywords?:string[]}
export type SemanticEvidence=Record<string,unknown>
export type SemanticFunction={function_id:string;name:string;description?:string;source?:string;source_file?:string;traceability?:string;matched_by_requirements:string[];mapping_evidence:SemanticEvidence[]}
export type SemanticProduct={product_id:string;name:string;description?:string;source?:string;source_file?:string;traceability?:string;matched_by_functions:string[];mapping_evidence:SemanticEvidence[]}
export type SemanticPath={requirement_id:string;function_id:string;product_id:string;requirement_function_evidence?:SemanticEvidence;function_product_evidence?:SemanticEvidence}
export type SemanticQueryResult={query:string;provider:string;cache_hit:boolean;interpretation?:Record<string,unknown>;requirements:SemanticRequirement[];functions:SemanticFunction[];products:SemanticProduct[];paths:SemanticPath[];stats?:Record<string,unknown>;next_actions?:string[]}
export type SemanticCatalog<T>={items?:T[];requirements?:T[];functions?:T[];products?:T[]}|T[]

export const semanticApi={
  catalog:()=>api.get('/semantic/catalog').then(r=>r.data),
  requirements:()=>api.get('/semantic/requirements').then(r=>r.data as SemanticRequirement[]),
  functions:()=>api.get('/semantic/functions').then(r=>r.data as SemanticFunction[]),
  products:()=>api.get('/semantic/products').then(r=>r.data),
  query:(query:string,mode:'auto'|'local'='auto')=>api.post('/semantic/query',{query,mode}).then(r=>r.data as SemanticQueryResult),
  requirement:(id:string)=>api.get(`/semantic/requirement/${encodeURIComponent(id)}`).then(r=>r.data),
  function:(id:string)=>api.get(`/semantic/function/${encodeURIComponent(id)}`).then(r=>r.data),
  product:(id:string)=>api.get(`/semantic/product/${encodeURIComponent(id)}`).then(r=>r.data),
  createEngineeringScope:(query:string)=>api.post('/syson/scope',{query}).then(r=>r.data),
  planSysONViews:(scope_id:string)=>api.post('/syson/views/plan',{scope_id}).then(r=>r.data),
  generateSysONViews:(scope_id:string)=>api.post('/syson/views/generate',{scope_id}).then(r=>r.data),
  containerIBD:(scope_id:string,container_product_id:string,create_in_syson=false)=>api.post('/syson/ibd/container',{scope_id,container_product_id,create_in_syson}).then(r=>r.data),
}
