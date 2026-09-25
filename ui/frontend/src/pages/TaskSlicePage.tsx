import {Alert,Button,Card,Checkbox,Collapse,Empty,Input,Modal,Space,Tag,Typography} from 'antd'
import {useEffect,useMemo,useState,useCallback} from 'react'
import {api} from '../api'
import TaskSliceGraph from '../components/engineering/TaskSliceGraph'
import {ArrowRightOutlined,PlusCircleOutlined,ThunderboltOutlined} from '@ant-design/icons'
import {useSearchParams} from 'react-router-dom'
import {semanticApi} from '../services/semanticApi'

const STAGE_META=[
  {key:0,title:'① Functions',subtitle:'工程师声明的目标功能',color:'#1677ff',icon:'📋',
   why:'仅列出 SysML v2 中由 action def 声明、并通过正式 allocation 分配到产品的目标功能。无产品、无接口、无上下游。'},
  {key:1,title:'② Function → Product',subtitle:'正式 allocation 分配关系',color:'#13a8a8',icon:'🔗',
   why:'显示 Function 与 Product 之间的正式 allocation 关系（来自 SysML `allocate` 语句）。每个 Function 至少有 1 个目标产品。'},
  {key:2,title:'③ L2 Products',subtitle:'沿包含关系投影到 L2 边界',color:'#f59e0b',icon:'📦',
   why:'沿产品包含关系把已分配的 L3/L4 产品向上投影到 L2 边界，形成 16 个 L2 主组件子集。'},
  {key:3,title:'④ L2 Aggregated Interfaces',subtitle:'L4 接口 → L2 归纳',color:'#7c3aed',icon:'🔌',
   why:'由 SysML 真实 L4 connection 归纳到 L2 边界。每个聚合接口包含真实存在的物理/控制/状态/数据传递内容（电压、电流、功率、转矩、控制请求、SOC 等）。'},
  {key:4,title:'⑤ Dependency Closure',subtitle:'迭代补齐上游依赖',color:'#cf1322',icon:'⚡',
   why:'沿物理/控制输入接口迭代补齐上游依赖（供电、控制、储能），直到集合不再变化。新加入的组件用紫色标识并显示加入原因。'},
]

function fmtName(value:any){
  if(!value) return '—'
  if(value.display_name && value.code) return `${value.display_name}（${value.code}）`
  return value.display_name || value.name || value.code || value.id || '—'
}

function endpointName(id:string|undefined,model:any[]){
  if(!id) return '—'
  const node=model?.find((n:any)=>n.data.id===id)?.data
  return node ? fmtName(node) : id
}

function ReasonList({items,empty}:{items:any[];empty:string}){
  if(!items||!items.length) return <div className="rs-empty">{empty}</div>
  return <ul className="rs-reasons">{items.map((r:any,i:number)=><li key={i}>
    <span className="rs-text">{typeof r==='string'?r:r.text}</span>
    {r?.source_path && <Tag className="rs-evidence">{r.source_path}</Tag>}
  </li>)}</ul>
}

export default function TaskSlicePage(){
  const [searchParams]=useSearchParams()
  const [catalog,setCatalog]=useState<any>()
  const [draftFunctionIds,setDraftFunctionIds]=useState<string[]>([])
  const [activeFunctionIds,setActiveFunctionIds]=useState<string[]>([])
  const [sliceData,setSliceData]=useState<any>()
  const [stage,setStage]=useState(0)
  const [selectedNode,setSelectedNode]=useState<any>(null)
  const [selectedEdge,setSelectedEdge]=useState<any>(null)
  const [showFunctionLibrary,setShowFunctionLibrary]=useState(false)
  const [modelFull,setModelFull]=useState<any>()
  const [scopeQuery,setScopeQuery]=useState('分析再生制动时超级电容储能相关的需求、功能和接口')
  const [scope,setScope]=useState<any>()
  const [scopeStatus,setScopeStatus]=useState<any>()
  const [scopeBusy,setScopeBusy]=useState(false)
  const [containerPlan,setContainerPlan]=useState<any>()
  const [containerBusy,setContainerBusy]=useState(false)
  const [containerStatus,setContainerStatus]=useState<any>()
  const [containerTrail,setContainerTrail]=useState<string[]>([])

  useEffect(()=>{
    api.get('/model/full').then(r=>setModelFull(r.data))
    api.get('/task-slice/catalog').then(r=>{
      setCatalog(r.data)
      const requested=searchParams.get('function')
      const def=requested&&r.data.functions?.some((f:any)=>f.id===requested)?[requested]:(r.data.default_function_ids||[])
      setDraftFunctionIds(def)
      setActiveFunctionIds(def)
    })
  },[searchParams])

  useEffect(()=>{
    if(!activeFunctionIds.length){
      setSliceData(null)
      return
    }
    api.get('/task-slice',{params:{function_ids:activeFunctionIds.join(',')}}).then(r=>{
      setSliceData(r.data)
      setSelectedNode(null); setSelectedEdge(null)
    })
  },[activeFunctionIds])

  const current=useMemo(()=>sliceData?.stages?.[stage], [sliceData,stage])

  // Build graph for the current stage (always visible, with stage-specific layout)
  const currentGraph=useMemo(()=>{
    if(!current || !catalog) return null
    const nodes:any[]=[]
    const edges:any[]=[]
    const LANE_COLORS:Record<string,string>={
      '外部能源':'#d9eaf6','高压供电':'#dcefe5','功率变换':'#f7edce','牵引机械':'#f4dfd6',
      '车辆':'#e5e6f2','控制':'#e8e0f1','储能':'#dcefeb','其他':'#eceff2',
    }
    if(stage===0){
      // Functions only - isolated bubbles
      for(const f of current.functions){
        nodes.push({data:{id:f.id,name:fmtName(f),code:f.id,display_name:f.display_name,raw_name:f.id,
          level:'function',type:'Function',lane:f.category==='PHYSICAL_CONVERSION'?'功率变换':'控制',
          category:f.category,source_path:f.source_path}})
      }
    } else if(stage===1){
      // Functions + allocation edges
      for(const f of current.functions){
        nodes.push({data:{id:f.id,name:fmtName(f),display_name:f.display_name,code:f.id,raw_name:f.id,
          level:'function',type:'Function',lane:'控制',source_path:f.source_path}})
      }
      for(const a of (current.allocations||[])){
        const pn=a.product_name||a.target
        if(!nodes.find(n=>n.data.id===a.target)){
          nodes.push({data:{id:a.target,name:fmtName({display_name:pn,code:a.product_code}),
            display_name:pn,code:a.product_code,raw_name:a.target,level:2,type:'Product',lane:'车辆'}})
        }
        edges.push({data:{id:`alloc_${a.id}`,source:a.source,target:a.target,
          label:'allocate',flow_kind:'control',relation:'allocation',source_path:a.source_path}})
      }
    } else if(stage===2){
      // Real allocated Product → projected L2 bipartite graph.
      // Keep the source product nodes; the previous implementation emitted
      // promotion edges whose source nodes did not exist in the graph.
      for(const a of (current.allocations||[])){
        if(!nodes.find(n=>n.data.id===a.target)) nodes.push({data:{id:a.target,
          name:fmtName({display_name:a.product_name,code:a.product_code}),display_name:a.product_name,
          code:a.product_code,raw_name:a.target,level:3,type:'Product',lane:'车辆'}})
      }
      for(const p of (current.products||[])){
        nodes.push({data:{id:p.id,name:fmtName(p),display_name:p.display_name,code:p.code,
          raw_name:p.raw_name,level:2,type:'Product',lane:p.lane||'车辆',
          parent_code:p.parent_code,reasons:p.reasons}})
      }
      const seenPromotions=new Set<string>()
      for(const promo of (current.promotions||[])){
        const key=`${promo.source}|${promo.target}`
        if(seenPromotions.has(key)) continue
        seenPromotions.add(key)
        edges.push({data:{id:`promo_${key}`,source:promo.source,target:promo.target,
          label:'投影到 L2',flow_kind:'state',relation:'projection'}})
      }
    } else if(stage===3){
      // L2 + aggregated interfaces with flow items
      for(const p of (current.products||[])){
        nodes.push({data:{id:p.id,name:fmtName(p),display_name:p.display_name,code:p.code,
          raw_name:p.raw_name,level:2,type:'Product',lane:p.lane||'车辆',
          parent_code:p.parent_code,reasons:p.reasons}})
      }
      for(const i of (current.interfaces||[])){
        const flows=i.flow_items||[]
        const label=flows.length>1 ? `${flows[0].display_name} +${flows.length-1}` : (flows[0]?.display_name||i.display_name)
        const sourceNode=modelFull?.nodes?.find((n:any)=>n.data.id===i.source_node_id)?.data
        const targetNode=modelFull?.nodes?.find((n:any)=>n.data.id===i.target_node_id)?.data
        edges.push({data:{id:i.id,source:i.source_node_id,target:i.target_node_id,
          label,flow_kind:i.flow_domain,relation:'interface',interface:i,
          source_path:i.source_path,flow_items:flows,
          source_name:sourceNode?fmtName(sourceNode):i.source_node_id,
          target_name:targetNode?fmtName(targetNode):i.target_node_id}})
      }
    } else if(stage===4){
      // Same as stage 3 but mark new closure products
      for(const p of (current.products||[])){
        nodes.push({data:{id:p.id,name:fmtName(p),display_name:p.display_name,code:p.code,
          raw_name:p.raw_name,level:2,type:p.dependency?'Product (闭包加入)':'Product',
          lane:p.lane||'车辆',parent_code:p.parent_code,reasons:p.reasons,dependency:p.dependency,
          isNew:!!p.dependency}})
      }
      for(const i of (current.interfaces||[])){
        const flows=i.flow_items||[]
        const label=flows.length>1 ? `${flows[0].display_name} +${flows.length-1}` : (flows[0]?.display_name||i.display_name)
        const sourceNode=modelFull?.nodes?.find((n:any)=>n.data.id===i.source_node_id)?.data
        const targetNode=modelFull?.nodes?.find((n:any)=>n.data.id===i.target_node_id)?.data
        edges.push({data:{id:i.id,source:i.source_node_id,target:i.target_node_id,
          label,flow_kind:i.flow_domain,relation:'interface',interface:i,
          source_path:i.source_path,flow_items:flows,
          source_name:sourceNode?fmtName(sourceNode):i.source_node_id,
          target_name:targetNode?fmtName(targetNode):i.target_node_id}})
      }
    }
    if(!nodes.length && !edges.length) return null
    return {nodes,edges,meta:{lanes:['外部能源','高压供电','功率变换','牵引机械','车辆','控制','储能']}}
  },[current,stage,catalog,modelFull])

  const toggleFn=useCallback((id:string)=>{
    setDraftFunctionIds(p=>p.includes(id)?p.filter(x=>x!==id):[...p,id])
  },[])

  const generateTaskModel=useCallback(()=>{
    if(!draftFunctionIds.length) return
    setActiveFunctionIds([...draftFunctionIds])
    setShowFunctionLibrary(false)
    setStage(0)
  },[draftFunctionIds])

  const selectionDirty=draftFunctionIds.join(',')!==activeFunctionIds.join(',')

  const openFunctionLibrary=useCallback(()=>{
    setDraftFunctionIds([...activeFunctionIds])
    setShowFunctionLibrary(true)
  },[activeFunctionIds])
  const cancelFunctionLibrary=useCallback(()=>{
    setDraftFunctionIds([...activeFunctionIds])
    setShowFunctionLibrary(false)
  },[activeFunctionIds])

  const stageDescriptor=STAGE_META[stage]
  const isClosureNewProduct=(p:any)=>p?.dependency===true

  const createEngineeringScope=async()=>{
    setScopeBusy(true);setScopeStatus(null)
    try{const value=await semanticApi.createEngineeringScope(scopeQuery);setScope(value)
      setContainerPlan(value.view_plan?.container_ibd_views?.find((v:any)=>v.container_product_id==='ROOT'))
      setContainerTrail(['ROOT']);setContainerStatus(null)}
    catch(error:any){setScopeStatus({status:'FAIL',diagnostics:[error?.response?.data?.detail||error.message||'Scope 生成失败']})}
    finally{setScopeBusy(false)}
  }
  const generateSysONViews=async()=>{
    if(!scope?.scope_id)return
    setScopeBusy(true);setScopeStatus(null)
    try{setScopeStatus(await semanticApi.generateSysONViews(scope.scope_id))}
    catch(error:any){setScopeStatus({status:'FAIL',diagnostics:[error?.response?.data?.detail||error.message||'SysON View 生成失败']})}
    finally{setScopeBusy(false)}
  }
  const openContainer=async(code:string,createInSysON=false)=>{
    if(!scope?.scope_id)return
    setContainerBusy(true);setContainerStatus(null)
    try{const result=await semanticApi.containerIBD(scope.scope_id,code,createInSysON)
      setContainerPlan(result.view_plan);setContainerStatus(result)
      setContainerTrail(prev=>{const index=prev.indexOf(code);return index>=0?prev.slice(0,index+1):[...prev,code]})}
    catch(error:any){setContainerStatus({status:'BLOCKED',reason:error?.response?.data?.detail||error.message||'IBD 加载失败'})}
    finally{setContainerBusy(false)}
  }

  // Compute closure summary stats
  const closureStats=useMemo(()=>{
    if(!sliceData||!sliceData.stages) return null
    const s0=sliceData.stages[0], s4=sliceData.stages[4]
    return {
      targetFunctions:s0.functions?.length||0,
      closedProducts:s4.products?.length||0,
      newAdded:s4.new_count||0,
      interfaces:s4.interfaces?.length||0,
    }
  },[sliceData])

  return <div className="sysml-page-v2 task-slice-page">
    <div className="sysml-header">
      <div className="sysml-title">
        <div><Typography.Title level={3}>任务模型推演 · 5 阶段语义生成</Typography.Title><Typography.Text type="secondary">从任务目标自动推导功能、组件、接口和系统依赖</Typography.Text></div>
        <Space>
          {closureStats && <>
            <Tag color="cyan">Functions {closureStats.targetFunctions}</Tag>
            <Tag color="geekblue">Core L2 {sliceData?.stages?.[2]?.products?.length||0}</Tag>
            <Tag color="purple">Interfaces {closureStats.interfaces}</Tag>
            <Tag color="red">Dependencies +{closureStats.newAdded}</Tag>
          </>}
        </Space>
      </div>
    </div>

    <Card title="自然语言 → Engineering Scope → SysON Views" style={{marginBottom:16}}>
      <Space.Compact style={{display:'flex',marginBottom:12}}>
        <Input value={scopeQuery} onChange={e=>setScopeQuery(e.target.value)} onPressEnter={createEngineeringScope} placeholder="描述要查看的需求、功能与接口"/>
        <Button type="primary" loading={scopeBusy} onClick={createEngineeringScope}>生成 Scope</Button>
      </Space.Compact>
      {scope && <div style={{display:'flex',gap:8,alignItems:'center',flexWrap:'wrap',marginBottom:10}}>
        <Tag color="blue">{scope.scope_id}</Tag><Tag>{scope.requirements.length} Requirements</Tag><Tag>{scope.functions.length} Functions</Tag>
        <Tag color="cyan">Interface Closure · Products: {scope.closure_stats.closure_product_count}</Tag>
        <Tag>Interactions: {scope.closure_stats.closure_edge_count}</Tag><Tag>Hierarchy Levels: {scope.closure_stats.hierarchy_levels_present.length}</Tag>
        <Button loading={scopeBusy} disabled={!scope.view_plan.container_ibd_views?.length} onClick={generateSysONViews}>在 SysON 中生成 Views</Button>
      </div>}
      {scope && <>
        <div style={{display:'flex',gap:6,flexWrap:'wrap',margin:'8px 0'}}>
          <Tag color="blue">Requirement View</Tag><Tag color="geekblue">Function–Product View</Tag>
          <Tag color="purple">Container IBD · 按产品逐层展开</Tag>
        </div>
        {containerPlan && <Card size="small" title={`IBD · ${containerPlan.container_product_name}（${containerPlan.container_product_id}）`} style={{marginBottom:10}}
          extra={<Button size="small" loading={containerBusy} disabled={containerPlan.container_product_id==='ROOT'} onClick={()=>openContainer(containerPlan.parent_container_id||'ROOT')}>返回上级</Button>}>
          <div style={{marginBottom:8}}>{containerTrail.map((code,i)=><Button size="small" type="link" key={`${code}-${i}`} onClick={()=>openContainer(code)}>{code}{i<containerTrail.length-1?' →':''}</Button>)}</div>
          <Space wrap style={{marginBottom:8}}>
            <Tag>直接子产品 {containerPlan.direct_children?.length||0}</Tag><Tag color="blue">内部连接 {containerPlan.internal_connections?.length||0}</Tag>
            <Tag color="green">真实边框接口 {containerPlan.real_boundary_ports?.length||0}</Tag><Tag color="orange">边框投影 {containerPlan.virtual_boundary_projections?.length||0}</Tag>
            <Tag>外部端点 {containerPlan.external_endpoints?.length||0}</Tag>
          </Space>
          <div style={{display:'flex',gap:8,flexWrap:'wrap',marginBottom:8}}>{(containerPlan.direct_children||[]).map((p:any)=><Button key={p.product_id} size="small" disabled={!p.has_children} loading={containerBusy} onClick={()=>openContainer(p.product_id)}>{p.name}（{p.product_id}）{p.has_children?' ↘':''}</Button>)}</div>
          <div>外部只显示边界端点：{(containerPlan.external_endpoints||[]).map((p:any)=>p.product_id).join('、')||'无'}</div>
          <div style={{marginTop:6}}>证据：{Object.entries(containerPlan.evidence_summary?.evidence_type_counts||{}).map(([type,count])=>`${type} ${count}`).join(' · ')||'无'}</div>
          {containerPlan.container_product_id!=='ROOT' && <Button style={{marginTop:8}} size="small" loading={containerBusy} onClick={()=>openContainer(containerPlan.container_product_id,true)}>创建 / 复用 SysON IBD</Button>}
          {containerStatus?.representation && <div style={{marginTop:6}}>SysON：{containerStatus.status} · {containerStatus.representation.representation?.id||containerStatus.representation.reason||'未创建'}</div>}
        </Card>}
        <Collapse size="small" items={[
          {key:'closure',label:'Seed / Closure Products',children:<div>
            <div><b>Seed Products：</b>{scope.seed_products.join('、')}</div>
            <div style={{marginTop:6}}><b>Closure Products ({scope.product_closure.length})：</b>{scope.product_closure.map((p:any)=>p.product_id).join('、')}</div>
            <div style={{marginTop:6}}>Fixed-point rounds: {scope.closure_stats.closure_rounds} · Canonical: {scope.closure_stats.canonical_product_count} · IBD: {scope.closure_stats.ibd_view_count}</div>
          </div>}
        ]} />
      </>}
      {scopeStatus && <Alert type={scopeStatus.status==='CREATED'?'success':scopeStatus.status==='PARTIAL'?'warning':'error'} showIcon message={`SysON View 状态：${scopeStatus.status} · 已创建 ${scopeStatus.created_count||0}/${scopeStatus.planned_count||0}`} description={(scopeStatus.views||[]).map((v:any)=>`${v.name}: ${v.status}${v.reason?` (${v.reason})`:''}`).join('；')||scopeStatus.diagnostics?.join(' ')}/>}
    </Card>

    {/* Stage progress strip */}
    <div className="ts-v2-progress">
      {STAGE_META.map((s,i)=><div key={i}
        className={`ts-v2-step ${i===stage?'active':''} ${i<stage?'completed':''}`}
        style={{background: i===stage?s.color: (i<stage?s.color+'80':'#f0f2f5'),
                color: i===stage||i<stage?'#fff':'#708395',
                borderColor: i===stage?s.color:'transparent'}}
        onClick={()=>setStage(i)}>
        <span className="ts-step-num">{i+1}</span>
        {s.title.replace(/^①|②|③|④|⑤/,'').trim()}
      </div>)}
    </div>

    {/* Keep the 191-function library behind an explicit modal. */}
    {stage===0 && <Card className="ts-catalog" title={<Space><span>当前任务：牵引—再生制动—能量回收</span>
      <Tag>{activeFunctionIds.length} 个生效功能</Tag></Space>}
      extra={<Space>
        <Button size="small" onClick={openFunctionLibrary}>修改功能</Button>
        <Button size="small" type="primary" disabled={!draftFunctionIds.length||draftFunctionIds.join(',')===activeFunctionIds.join(',')} onClick={generateTaskModel}>生成任务模型</Button>
      </Space>}>
      {!sliceData && <Empty/>}
      {selectionDirty && <div className="ts-draft-inline">功能选择已修改，点击“生成任务模型”后生效</div>}
      {sliceData && <div className="ts-active-function-cards">{sliceData.stages[0].functions.map((f:any)=><Card size="small" key={f.id}><b>{f.display_name}</b><div><Tag color="blue">{f.id}</Tag><Tag>{f.category||'Function'}</Tag></div></Card>)}</div>}
    </Card>}

    <Modal title="功能库（191 个真实 SysML Functions）" open={showFunctionLibrary} width={900} onCancel={cancelFunctionLibrary} onOk={()=>setShowFunctionLibrary(false)} okText="应用选择" cancelText="取消">
      <div className="ts-draft-status">当前草稿已选 {draftFunctionIds.length} 个。勾选后点击“生成任务模型”才请求新的切片。</div>
      <div className="ts-fn-list ts-library-list">{catalog?.functions?.map((f:any)=><div key={f.id} className={`ts-fn-item ${draftFunctionIds.includes(f.id)?'picked':''}`}>
        <Checkbox checked={draftFunctionIds.includes(f.id)} onChange={()=>toggleFn(f.id)}><span className="ts-fn-name">{f.display_name}</span><Tag className="ts-fn-cat">{f.category||'Function'}</Tag>{f.allocations?.[0]&&<Tag color="cyan">→ {f.allocations[0].product_code}</Tag>}</Checkbox>
      </div>)}</div>
    </Modal>

    {/* Stage card */}
    <Card className="ts-stage-card"
      title={<Space>
        <span style={{fontSize:18}}>{stageDescriptor.icon}</span>
        <span>阶段 {stage+1}/5：{stageDescriptor.title}</span>
        <Tag color="blue">{stageDescriptor.subtitle}</Tag>
      </Space>}
      style={{borderTop:`4px solid ${stageDescriptor.color}`,marginBottom:16}}>
      <div className="ts-stage-summary" style={{borderLeftColor:stageDescriptor.color}}>{stageDescriptor.subtitle}</div>

      {!current && <Empty description={activeFunctionIds.length===0?'请先选择至少一个 Function':'加载中...'}/>} 

      {/* Stage 0 — Functions only; no empty graph placeholder. */}
      {current && stage===0 && <>
        <div className="ts-pane-grid">
          <Card type="inner" title={`Functions (${current.functions.length})`}>
            {current.functions.map((f:any)=><div key={f.id} className="ts-row">
              <b>{fmtName(f)}</b>
              <Tag color="blue">Function</Tag>
              {f.category && <Tag color="cyan">{f.category}</Tag>}
              {f.source_path && <Tag className="rs-evidence">{f.source_path}</Tag>}
            </div>)}
          </Card>
          <Card type="inner" title="本阶段严格不出现" className="ts-negative">
            <ul>
              <li>无 Product 节点</li>
              <li>无 allocation 关系</li>
              <li>无 interface / flow</li>
              <li>无上下游闭包</li>
              <li>无 promoted products</li>
            </ul>
          </Card>
        </div>
      </>}

      {/* Stage 1 — Function → Product allocation */}
      {current && stage===1 && <>
        <div className="ts-pane-grid">
          <Card type="inner" title={`Allocations (${current.allocations?.length||0})`}>
            {(current.allocations||[]).map((a:any)=><div key={a.id} className="ts-row">
              <Tag color="blue">Function</Tag><b>{a.function_name||a.source}</b>
              <ArrowRightOutlined style={{color:'#1677ff'}}/>
              <Tag color="geekblue">Product</Tag><b>{a.product_name}（{a.product_code}）</b>
              {a.source_path && <Tag className="rs-evidence">{a.source_path}</Tag>}
            </div>)}
          </Card>
          <Card type="inner" title={`直接分配产品 (${current.products?.length||0})`}>
            {(current.products||[]).map((p:any)=><div key={p.id} className="ts-row">
              <b>{fmtName(p)}</b>
              <Tag color="geekblue">L{p.level||2}</Tag>
              <Tag>{p.lane}</Tag>
              <ReasonList items={p.reasons} empty="无理由"/>
            </div>)}
          </Card>
        </div>
        {currentGraph && <div className="ts-v2-graph"><TaskSliceGraph graph={currentGraph} stage={stage} selectedId={selectedNode?.id} onSelect={setSelectedNode}/></div>}
      </>}

      {/* Stage 2 — L2 Products via promotion */}
      {current && stage===2 && <>
        <div className="ts-pane-grid">
          <Card type="inner" title={`L2 Products 经投影后 (${current.products?.length||0})`}>
            {(current.products||[]).map((p:any)=><div key={p.id} className="ts-row">
              <b>{fmtName(p)}</b>
              <Tag color="geekblue">L2</Tag>
              <Tag>{p.lane}</Tag>
              <ReasonList items={p.reasons} empty="无投影理由"/>
            </div>)}
          </Card>
          <Card type="inner" title={`Promotions 沿包含关系向上 (${current.promotions?.length||0})`}>
            {(current.promotions||[]).map((p:any,i:number)=><div key={i} className="ts-row">
              <Tag>{p.source}</Tag>
              <ArrowRightOutlined style={{color:'#f59e0b'}}/>
              <Tag color="orange">{p.target}</Tag>
              <Tag color="gold">投影</Tag>
            </div>)}
          </Card>
        </div>
        {currentGraph && <div className="ts-v2-graph"><TaskSliceGraph graph={currentGraph} stage={stage} selectedId={selectedNode?.id} onSelect={setSelectedNode}/></div>}
      </>}

      {/* Stage 3 — L2 Aggregated Interfaces */}
      {current && stage===3 && <>
        <div className="ts-pane-grid">
              <Card type="inner" title={`L2 Aggregated Interfaces (${current.interfaces?.length||0})`}
            className="ts-iface-table">
            <div className="ts-iface-header">
              <span>源组件</span><span>传递内容 / 类型</span><span>目标组件</span>
            </div>
            {(current.interfaces||[]).map((i:any)=>{
              const flows=i.flow_items||[]
              return <div key={i.id} className="ts-iface-row" onClick={()=>setSelectedEdge(i)}
                style={{cursor:'pointer',background:selectedEdge?.id===i.id?'#e8f4ff':undefined}}>
                <div className="ts-cell"><b>{endpointName(i.source_node_id,modelFull?.nodes)}</b></div>
                <div className="ts-cell ts-flow-cell">
                  <Tag className={`kind-tag kind-${i.flow_domain}`}>{i.flow_domain}</Tag>
                  <span className="ts-flow-name">{i.display_name}</span>
                  {flows.map((f:any)=><Tag key={f.id} color="default">{f.display_name}{f.unit && f.unit!=='无'?` (${f.unit})`:''}</Tag>)}
                </div>
                <div className="ts-cell"><b>{endpointName(i.target_node_id,modelFull?.nodes)}</b></div>
              </div>
            })}
          </Card>
        </div>
        {currentGraph && <div className="ts-v2-graph"><TaskSliceGraph graph={currentGraph} stage={stage} selectedId={selectedEdge?.id} onEdgeSelect={setSelectedEdge}/></div>}
      </>}

      {/* Stage 4 — Dependency closure */}
      {current && stage===4 && <>
        <div className="ts-pane-grid">
          <Card type="inner" title={<Space>
            <ThunderboltOutlined style={{color:'#cf1322'}}/>
            <span>运行依赖补齐 · Dependency Completion（新增 <Tag color="purple">{current.new_count}</Tag> 个上游组件）</span>
          </Space>}>
            {(current.products||[]).map((p:any)=><div key={p.id} className={`ts-row ${isClosureNewProduct(p)?'ts-new':''}`}>
              <b>{fmtName(p)}</b>
              {isClosureNewProduct(p) ? <Tag color="purple" icon={<PlusCircleOutlined/>}>闭包加入</Tag>
                : <Tag color="geekblue">原有</Tag>}
              <Tag>{p.lane}</Tag>
              <ReasonList items={p.reasons} empty={isClosureNewProduct(p)?'无加入原因':'—'}/>
            </div>)}
          </Card>
          <Card type="inner" title="新增依赖说明" className="ts-closure-rule">
            <div>核心任务组件保持蓝色；紫色组件为本次真实物理/控制依赖闭包新增。</div>
            <div className="ts-closure-count">新增 {current.new_count} 个组件 · 接口 {current.interfaces?.length||0} 条</div>
          </Card>
        </div>
        {currentGraph && <div className="ts-v2-graph"><TaskSliceGraph graph={currentGraph} stage={stage} selectedId={selectedNode?.id} onSelect={setSelectedNode}/></div>}
      </>}
    </Card>
  </div>
}
