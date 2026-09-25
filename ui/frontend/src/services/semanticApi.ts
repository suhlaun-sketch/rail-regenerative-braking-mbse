import {api} from '../api'

export const semanticApi={
  catalog:()=>api.get('/semantic/catalog').then(r=>r.data),
  requirements:()=>api.get('/semantic/requirements').then(r=>r.data),
  functions:()=>api.get('/semantic/functions').then(r=>r.data),
  products:()=>api.get('/semantic/products').then(r=>r.data),
  query:(query:string,mode:'auto'|'local'='auto')=>api.post('/semantic/query',{query,mode}).then(r=>r.data),
  requirement:(id:string)=>api.get(`/semantic/requirement/${encodeURIComponent(id)}`).then(r=>r.data),
  function:(id:string)=>api.get(`/semantic/function/${encodeURIComponent(id)}`).then(r=>r.data),
  product:(id:string)=>api.get(`/semantic/product/${encodeURIComponent(id)}`).then(r=>r.data),
  createEngineeringScope:(query:string)=>api.post('/syson/scope',{query}).then(r=>r.data),
  planSysONViews:(scope_id:string)=>api.post('/syson/views/plan',{scope_id}).then(r=>r.data),
  generateSysONViews:(scope_id:string)=>api.post('/syson/views/generate',{scope_id}).then(r=>r.data),
  containerIBD:(scope_id:string,container_product_id:string,create_in_syson=false)=>api.post('/syson/ibd/container',{scope_id,container_product_id,create_in_syson}).then(r=>r.data),
}
