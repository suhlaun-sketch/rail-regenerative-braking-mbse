import {Breadcrumb,Button,Card,Checkbox,Collapse,Descriptions,Empty,Input,Segmented,Select,Space,Spin,Statistic,Switch,Tag,Tree,Typography} from 'antd'
import {ArrowLeftOutlined,HomeOutlined,SearchOutlined} from '@ant-design/icons'
import {useEffect,useMemo,useState,useCallback} from 'react'
import {api} from '../api'
import EngineeringFlow from '../components/engineering/EngineeringFlow'
import {useSearchParams} from 'react-router-dom'

/* ─── Helpers & Constants ─── */
const TECHNICAL_KEYS=new Set(['code','l2_code','sysml_id','raw_id','raw_name','source_path','definition_type','mapping_id','id','laneOrder','rank','parent','parent_code'])
const safe=(v:any)=>v!==undefined&&v!==null&&v!==''
const FLOW_KIND_LABEL:Record<string,string>={physical:'能量流',control:'控制流',state:'状态流',data:'数据流',unknown:'其它'}
const LABEL_MAP:Record<string,string>={
  display_name:'名称',name:'名称',level:'层级',type:'类型',children_count:'子节点数量',interface_count:'接口数量',
  direction:'方向',source_node_id:'源组件',target_node_id:'目标组件',flow_domain:'传递类型',derived:'来源',
  lane:'泳道',flow_kind:'流类型',label:'标注',source:'源',target:'目标',relation:'关系',
  raw_name:'原名',raw_id:'原ID',source_path:'源文件',definition_type:'定义类型',code:'编码',
  sysml_id:'SysML ID',l2_code:'所属L2',parent_code:'父编码',parent:'父节点',
}
function TagKind({kind}:{kind:string}){ if(!kind) return null; return <Tag className={`kind-tag kind-${kind}`}>{FLOW_KIND_LABEL[kind]||kind}</Tag> }

/* ─── Property Panel ─── */
function PropertyPanel({value,onTrace,onNavigate,traceItems}:{value:any;onTrace:()=>void;onNavigate:(id:string)=>void;traceItems:any[]}){
  if(!value) return <div className="empty-hint"><p><b>使用提示</b></p><ul>
    <li>Tree 单击：切到该节点分支</li><li>Canvas 单击：高亮 + 查属性</li><li>双击：下钻一级</li></ul></div>
  const normal:any[]=[], tech:any[]=[]
  Object.entries(value).filter(([k,v])=>safe(v)&&typeof v!=='object'&&!['leaf','_dimmed','_focus','_neighbor','drillable'].includes(k))
    .forEach(([k,v])=>{
      const target=TECHNICAL_KEYS.has(k)?tech:normal
      target.push({key:k,label:LABEL_MAP[k]||k,children:k==='derived'?(v?'由下层接口归纳':'SysML真实接口'):String(v)})
    })
  const flows=value.flow_items||value.interface?.flow_items
  const childCount=value.child_interfaces?.length||value.leaf_connections?.length||value.interface?.leaf_connections?.length||0
  return <>
    {value.display_name && <div className="prop-header">
      <div className="prop-title">{value.display_name}</div>
      {value.code && <div className="prop-code">编码 {value.code}</div>}
      <div className="prop-badges">
        {value.level && <Tag color="blue">L{value.level}</Tag>}
        {value.lane && <Tag>{value.lane}</Tag>}
        {value.flow_domain && <TagKind kind={value.flow_domain}/>}
        {value.flow_kind && <TagKind kind={value.flow_kind}/>}
      </div>
    </div>}
    <Descriptions column={1} size="small" items={normal}/>
    {value.children_count>0 && value.level && value.level<4 &&
      <Button block type="primary" onClick={()=>onNavigate(value.id)} style={{marginTop:8}}>进入 → 查看子节点</Button>}
    {flows?.length>0 && <Card size="small" title="传递内容 (Flow Items)" className="prop-flows">
      {flows.map((f:any)=><div key={f.id} className="prop-flow-item">
        <div><b>{f.display_name}</b>{f.unit && f.unit!=='无' && <span className="unit"> · {f.unit}</span>}</div>
        <div><TagKind kind={f.kind}/>{f.raw_name && <span className="raw-name"> {f.raw_name}</span>}</div>
        {f.fmi_variables?.length>0 && <div className="fmi-vars">FMI: {f.fmi_variables.slice(0,3).join(', ')}{f.fmi_variables.length>3?` +${f.fmi_variables.length-3}`:''}</div>}
      </div>)}
    </Card>}
    {value.source_node_id && value.target_node_id && <div className="prop-endpoints">
      <div>源: <b>{value.source_node_id}</b></div><div>目标: <b>{value.target_node_id}</b></div>
    </div>}
    {(childCount>0) && <Button block onClick={onTrace} className="prop-trace-btn">查看接口构成（{childCount}）</Button>}
    {traceItems?.length>0 && <div className="trace-tree"><b>接口追溯</b>
      {traceItems.map((item,i)=><div key={`${item.id}-${i}`} className="trace-node" style={{paddingLeft:Math.min(i,3)*12}}>
        <span className="trace-arrow">└</span><span>{item.display_name}</span>
        {item.flow_items?.[0]?.kind && <TagKind kind={item.flow_items[0].kind}/>}
      </div>)}
    </div>}
    <Collapse ghost items={[{key:'technical',label:'技术信息 / SysML 元数据',children:<Descriptions column={1} size="small" items={tech}/>}]}/>
  </>
}

/* ─── Build antd Tree ─── */
function buildTree(nodes:any[]){
  const map=new Map<string,any>()
  nodes.forEach(n=>{
    map.set(n.data.id,{key:n.data.id,title:`${n.data.display_name}（${n.data.code}）`,children:[],_data:n.data})
  })
  const roots:any[]=[]
  for(const n of nodes){
    const item=map.get(n.data.id); if(!item) continue
    const p=n.data.parent && map.get(n.data.parent)
    if(p) p.children.push(item); else roots.push(item)
  }
  return roots
}

/* ─── View type: either global or focused on a specific node ─── */
// focusNodeId = the node whose CHILDREN are shown on canvas
// selectedId  = highlighted node (may differ from focusNodeId)
type FocusState={focusNodeId:string|null; selectedId:string|null}

export default function SysMLPage(){
  const [searchParams]=useSearchParams()
  const [full,setFull]=useState<any>()
  const [focus,setFocus]=useState<FocusState>({focusNodeId:null,selectedId:null})
  const [selectedElement,setSelectedElement]=useState<any>(null)
  const [search,setSearch]=useState('')
  const [flowKind,setFlowKind]=useState('all')
  const [flowMode,setFlowMode]=useState<'all'|'selected-types'|'focus-path'>('all')
  const [selectedFlowTypes,setSelectedFlowTypes]=useState<string[]>(['physical','control','state','data'])
  const [focusPath,setFocusPath]=useState<string[]>([])
  const [selectedFlowId,setSelectedFlowId]=useState<string|undefined>()
  const [viewMode,setViewMode]=useState<'structure'|'interface'|'flow'|'energy'>('structure')
  const [trace,setTrace]=useState<any[]>([])
  const [showAnim,setShowAnim]=useState(true)
  const [treeCollapsed,setTreeCollapsed]=useState(false)
  const [detailsCollapsed,setDetailsCollapsed]=useState(false)
  const [treeExpandedKeys,setTreeExpandedKeys]=useState<string[]>([])

  useEffect(()=>{
    api.get('/model/full').then(r=>{
      setFull(r.data)
      setTreeExpandedKeys(r.data.nodes.filter((n:any)=>n.data.level<=1).map((n:any)=>n.data.id))
      const requested=searchParams.get('focus')
      if(requested){const node=r.data.nodes.find((n:any)=>n.data.code===requested||n.data.id===requested)?.data;if(node){setFocus({focusNodeId:null,selectedId:node.id});setSelectedElement(node)}}
    })
  },[searchParams])

  const nodeMap=useMemo<Map<string,any>>(
    ()=>new Map<string,any>((full?.nodes||[]).map((n:any)=>[n.data.id,n.data])),[full],
  )

  const selectedFromNode=useMemo(()=>focus.selectedId?nodeMap.get(focus.selectedId):null,[focus.selectedId,nodeMap])
  const selected=selectedElement || selectedFromNode
  const focusNode=useMemo(()=>focus.focusNodeId?nodeMap.get(focus.focusNodeId):null,[focus.focusNodeId,nodeMap])

  /* ─── visibleGraph: depends on focusNodeId ─── */
  const visibleGraph=useMemo(()=>{
    if(!full) return {nodes:[],edges:[],meta:{lanes:[]}}
    const lanes=full.swimlanes||[]

    // Global view: L1+L2
    if(!focus.focusNodeId){
      const searching=search && search.length>0
      const list=full.nodes.filter((n:any)=>{
        if(searching){
          const q=search.toLowerCase()
          return (n.data.display_name||'').toLowerCase().includes(q) ||
                 (n.data.code||'').toLowerCase().includes(q) ||
                 (n.data.raw_name||'').toLowerCase().includes(q)
        }
        return n.data.level<=2
      })
      const ids=new Set(list.map((n:any)=>n.data.id))
      const nodes=list.map((n:any)=>({data:{...n.data,drillable:n.data.level<=2,parent:ids.has(n.data.parent)?n.data.parent:undefined}}))
      if(viewMode==='structure'){
        const edges=full.containment.filter((e:any)=>ids.has(e.data.source)&&ids.has(e.data.target))
          .map((e:any)=>({data:{...e.data,flow_kind:'containment'}}))
        return {nodes,edges,meta:{lanes}}
      }
      const l2Ifaces=full.aggregated_interfaces.filter((i:any)=>i.level===2)
      // Keep the branch complete. EngineeringFlow applies the single final
      // type/path filter so multi-type selection remains a union.
      const filtered=l2Ifaces
      const activeIds=new Set<string>()
      filtered.forEach((i:any)=>{activeIds.add(i.source_node_id);activeIds.add(i.target_node_id)})
      const an=[...activeIds].map(id=>{const n=nodeMap.get(id);return n?{data:{...n,drillable:true}}:null}).filter(Boolean) as any[]
      const edges=filtered.map((i:any)=>({data:{id:i.id,source:i.source_node_id,target:i.target_node_id,
        label:`${i.display_name}${i.flow_items?.length>1?` +${i.flow_items.length-1}`:''}`,
        flow_kind:i.flow_domain,interface:i,relation:'interface',flow_items:i.flow_items}}))
      return {nodes:an,edges,meta:{lanes}}
    }

    // Focused view
    const fn=focusNode!
    const level=fn.level
    const focusCode=fn.code

    // Children
    let children:any[]=[]
    if(level===1) children=full.nodes.filter((n:any)=>n.data.level===2&&n.data.parent===fn.id)
    else if(level===2) children=full.nodes.filter((n:any)=>n.data.level===3&&n.data.l2_code===focusCode)
    else if(level===3) children=full.nodes.filter((n:any)=>n.data.level===4&&n.data.parent_code===focusCode)
    // L4: no product children, but interfaces

    // Nodes: focus + children
    const nodes:any[]=[{data:{...fn,_focus:true,drillable:false}}]
    children.forEach(c=>nodes.push({data:{...c.data,drillable:c.data.level<4}}))

    const childIds=new Set(children.map(c=>c.data.id))
    childIds.add(fn.id)

    // Edges + neighbor context
    const edges:any[]=[]
    const neighborIds=new Set<string>()

    if(level===1){
      // L2 children + L2 aggregated interfaces among them
      const l2Ifaces=full.aggregated_interfaces.filter((i:any)=>i.level===2 &&
        childIds.has(i.source_node_id)&&childIds.has(i.target_node_id))
      l2Ifaces.forEach((i:any)=>edges.push({data:{id:i.id,source:i.source_node_id,target:i.target_node_id,
        label:i.display_name,flow_kind:i.flow_domain,interface:i,relation:'interface',flow_items:i.flow_items}}))
      // Containment: focus -> children
      children.forEach(c=>edges.push({data:{id:`c-${fn.id}-${c.data.id}`,source:fn.id,target:c.data.id,flow_kind:'containment',relation:'containment'}}))
    } else if(level===2){
      // L3 aggregated interfaces: prioritize internal (both ends are children),
      // then optional boundary edges to context L3s in other L2s
      const l3Ifaces=full.aggregated_interfaces.filter((i:any)=>i.level===3 &&
        (childIds.has(i.source_node_id)||childIds.has(i.target_node_id)))
      // Internal edges first
      l3Ifaces.forEach((i:any)=>{
        const internal=childIds.has(i.source_node_id)&&childIds.has(i.target_node_id)
        if(internal || viewMode!=='structure'){
          edges.push({data:{id:i.id,source:i.source_node_id,target:i.target_node_id,
            label:i.display_name,flow_kind:i.flow_domain,interface:i,relation:'interface',flow_items:i.flow_items}})
          if(!childIds.has(i.source_node_id)) neighborIds.add(i.source_node_id)
          if(!childIds.has(i.target_node_id)) neighborIds.add(i.target_node_id)
        }
      })
      // Containment
      children.forEach(c=>edges.push({data:{id:`c-${fn.id}-${c.data.id}`,source:fn.id,target:c.data.id,flow_kind:'containment',relation:'containment'}}))
    } else if(level===3){
      // Leaf interfaces among L4 children
      full.leaf_interfaces.forEach((li:any)=>{
        const src=li.source?.node_id, tgt=li.target?.node_id
        if((childIds.has(src)||childIds.has(tgt))&&src&&tgt){
          edges.push({data:{id:li.id,source:src,target:tgt,label:li.display_name,
            flow_kind:li.flow_items?.[0]?.kind||'unknown',leaf:li,relation:'interface',flow_items:li.flow_items}})
          if(!childIds.has(src)) neighborIds.add(src)
          if(!childIds.has(tgt)) neighborIds.add(tgt)
        }
      })
      children.forEach(c=>edges.push({data:{id:`c-${fn.id}-${c.data.id}`,source:fn.id,target:c.data.id,flow_kind:'containment',relation:'containment'}}))
    } else if(level===4){
      // L4 detail: show leaf interfaces touching this L4
      full.leaf_interfaces.forEach((li:any)=>{
        const src=li.source?.node_id, tgt=li.target?.node_id
        if((src===fn.id||tgt===fn.id)&&src&&tgt){
          edges.push({data:{id:li.id,source:src,target:tgt,label:li.display_name,
            flow_kind:li.flow_items?.[0]?.kind||'unknown',leaf:li,relation:'interface',flow_items:li.flow_items}})
          if(src!==fn.id) neighborIds.add(src)
          if(tgt!==fn.id) neighborIds.add(tgt)
        }
      })
    }

    // Add neighbor context nodes
    neighborIds.forEach(nid=>{
      if(childIds.has(nid)) return
      const n=nodeMap.get(nid)
      if(n) nodes.push({data:{...n,_neighbor:true}})
    })

    return {nodes,edges,meta:{lanes}}
  },[full,focus.focusNodeId,viewMode,flowKind,search,nodeMap,focusNode])

  /* ─── Navigation: set focus to a node (show its children on canvas) ─── */
  const navigateToFocus=useCallback((nodeId:string,alsoSelect?:boolean)=>{
    if(!nodeMap.has(nodeId)) return
    setFocus({focusNodeId:nodeId,selectedId:alsoSelect?nodeId:focus.selectedId})
    setSelectedElement(null)
      setTrace([])
      setSelectedFlowId(undefined)
    // Expand tree ancestors
    const chain:string[]=[]
    let cur=nodeMap.get(nodeId)
    while(cur){chain.push(cur.id); cur=cur.parent?nodeMap.get(cur.parent):null}
    setTreeExpandedKeys(prev=>{const s=new Set([...prev,...chain]); return [...s]})
  },[nodeMap,focus.selectedId])

  /* ─── Tree click: set focus to clicked node → canvas shows it + its children ─── */
  const handleTreeSelect=useCallback((nodeId:string)=>{
    const node=nodeMap.get(nodeId)
    if(!node) return
    setFocus({focusNodeId:nodeId,selectedId:nodeId})
    setSelectedElement(null)
      setTrace([])
      setSelectedFlowId(undefined)
    // Expand ancestors in tree
    const chain:string[]=[]
    let cur=node
    while(cur){chain.push(cur.id); cur=cur.parent?nodeMap.get(cur.parent):null}
    setTreeExpandedKeys(prev=>{const s=new Set([...prev,...chain]); return [...s]})
  },[nodeMap])

  /* ─── Canvas single click: just select, no view change ─── */
  const handleCanvasSelect=useCallback((v:any)=>{
    const val=v.interface||v.leaf||v
    if(v.source&&v.target){
      setFocusPath([v.id,v.source,v.target].filter(Boolean))
      setFlowMode('focus-path')
      setFocus(prev=>({...prev,selectedId:v.source}))
      setSelectedElement(val)
      setSelectedFlowId(v.id)
    } else {
      setFocus(prev=>({...prev,selectedId:val.id||prev.selectedId}))
      setSelectedElement(val)
      setSelectedFlowId(undefined)
    }
    setTrace([])
  },[])

  /* ─── Canvas double click: drill down = navigate focus to this node ─── */
  const handleCanvasDrill=useCallback((v:any)=>{
    if(!v?.id) return
    navigateToFocus(v.id,true)
  },[navigateToFocus])

  /* ─── Search: find node, navigate to its parent branch ─── */
  const handleSearch=useCallback((q:string)=>{
    setSearch(q)
    if(!q||!full) return
    const ql=q.toLowerCase()
    const match=full.nodes.find((n:any)=>
      n.data.code?.toLowerCase()===ql ||
      n.data.display_name?.toLowerCase().includes(ql))
    if(match) handleTreeSelect(match.data.id)
  },[full,handleTreeSelect])

  const back=useCallback(()=>{
    if(!focusNode) return
    // Back = focus on the parent (which shows current node + siblings)
    if(focusNode.parent){
      setFocus({focusNodeId:focusNode.parent,selectedId:focusNode.id})
    } else {
      setFocus({focusNodeId:null,selectedId:focusNode.id})
    }
    setTrace([])
    setSelectedElement(null)
    setSelectedFlowId(undefined)
  },[focusNode])

  const home=useCallback(()=>{
    setFocus({focusNodeId:null,selectedId:null})
    setSelectedElement(null)
    setFlowMode('all')
    setFocusPath([])
    setSelectedFlowId(undefined)
    setTrace([])
  },[])

  const handleTrace=useCallback(async()=>{
    const root=selected?.interface||selected?.leaf||selected
    if(!root?.id) return
    const result=[root]; let current=[root]
    for(let i=0;i<3;i++){
      const next:any[]=[]
      for(const item of current){ try{const r=await api.get(`/model/interface/${encodeURIComponent(item.id)}/children`);next.push(...r.data)}catch{} }
      if(!next.length) break; result.push(...next); current=next
    }
    setTrace(result)
  },[selected])

  const treeData=useMemo(()=>full?buildTree(full.nodes):[],[full])
  const stats=full?.statistics

  /* ─── Breadcrumb from ancestor chain ─── */
  const breadcrumbItems:any[]=useMemo(()=>{
    const items:any[]=[{title:<a onClick={home}>全局 L1+L2</a>}]
    if(!focusNode) return items
    const chain:any[]=[]
    let cur:any=focusNode
    while(cur){ chain.unshift(cur); cur=cur.parent?nodeMap.get(cur.parent):null }
    chain.forEach((n,idx)=>{
      const label=`${n.display_name}（${n.code}）`
      const isLast=idx===chain.length-1
      items.push({
        title:isLast ? <b>{label}</b> :
          <a onClick={()=>setFocus({focusNodeId:n.id,selectedId:n.id})}>{label}</a>
      })
    })
    return items
  },[focusNode,nodeMap,home])

  if(!full) return <div className="sysml-loading"><Spin size="large" tip="载入 SysML v2 四层系统模型..."><div style={{width:160,height:80}}/></Spin></div>

  const isDrill=!!focus.focusNodeId

  /* ─── Canvas title ─── */
  let canvasTitle=''
  if(!isDrill) canvasTitle=`分层结构浏览（默认 L1 + L2，共 ${visibleGraph.nodes.length} 节点）`
  else if(focusNode){
    const fl=focusNode.level
    const childCount=visibleGraph.nodes.filter((n:any)=>!n.data._focus&&!n.data._neighbor).length
    if(fl===1) canvasTitle=`L1 视图：${focusNode.display_name}（${focusNode.code}） · L2 ${childCount} 项`
    else if(fl===2) canvasTitle=`L2 下钻：${focusNode.display_name}（${focusNode.code}） · L3 ${childCount} 项`
    else if(fl===3) canvasTitle=`L3 下钻：${focusNode.display_name}（${focusNode.code}） · L4 ${childCount} 项`
    else if(fl===4) canvasTitle=`L4 详情：${focusNode.display_name}（${focusNode.code}） · 接口 ${visibleGraph.edges.length} 项`
  }

  return <div className="sysml-page-v2">
    <div className="sysml-header">
      <div className="sysml-title">
        <Typography.Title level={3}>SysML v2 四层系统模型</Typography.Title>
        <Space size="middle">
          <Statistic title="L1" value={stats.level_1_nodes} className="stat-mini"/>
          <Statistic title="L2" value={stats.level_2_nodes} className="stat-mini"/>
          <Statistic title="L3" value={stats.level_3_nodes} className="stat-mini"/>
          <Statistic title="L4" value={stats.level_4_nodes} className="stat-mini"/>
          <Statistic title="接口" value={stats.aggregated_l2_interfaces} suffix="(L2)" className="stat-mini"/>
        </Space>
      </div>
    </div>
    <div className="sysml-toolbar">
      <Space wrap>
        <Button icon={<HomeOutlined/>} onClick={home} disabled={!isDrill}>全局</Button>
        <Button icon={<ArrowLeftOutlined/>} onClick={back} disabled={!isDrill}>返回上级</Button>
        <Breadcrumb items={breadcrumbItems}/>
      </Space>
      <Space wrap>
        <Segmented value={viewMode} onChange={(v:any)=>setViewMode(v)}
          options={[{label:'结构',value:'structure'},{label:'接口',value:'interface'},{label:'流',value:'flow'},{label:'能量流',value:'energy'}]}/>
        {(viewMode==='flow'||viewMode==='energy'||viewMode==='interface') && <>
          <Select value={flowMode} onChange={(v:any)=>{setFlowMode(v);if(v!=='focus-path'){setFocusPath([]);setSelectedFlowId(undefined)}}} style={{width:150}}
            options={[{label:'全部 Flow',value:'all'},{label:'选择类型',value:'selected-types'},{label:'仅看相关路径',value:'focus-path'}]}/>
          {flowMode==='selected-types' && <Select mode="multiple" value={viewMode==='energy'?['physical']:selectedFlowTypes} onChange={(v:any)=>{setSelectedFlowTypes(v);setFlowMode('selected-types')}} style={{width:240}}
            options={[{label:'能量 / physical',value:'physical'},{label:'控制 / control',value:'control'},{label:'状态 / state',value:'state'},{label:'数据 / data',value:'data'}]}/>} 
        </>}
        {flowMode==='focus-path' && <Button size="small" onClick={()=>{setFlowMode('all');setFocusPath([]);setSelectedFlowId(undefined)}}>退出路径聚焦</Button>}
        <Input.Search placeholder="搜索名称/编码" allowClear prefix={<SearchOutlined/>}
          onSearch={(v:string)=>handleSearch(v)} style={{width:220}}/>
        <Switch checkedChildren="动画开" unCheckedChildren="动画关" checked={showAnim} onChange={setShowAnim}/>
      </Space>
    </div>
    <div className={`sysml-three-pane ${treeCollapsed?'tree-hide':''} ${detailsCollapsed?'details-hide':''}`}>
      <Card className="pane-tree" size="small"
        title={<span>模型树 <Tag color="blue">{full.nodes.length}</Tag></span>}
        extra={<Button size="small" type="text" onClick={()=>setTreeCollapsed(v=>!v)}>{treeCollapsed?'展开':'折叠'}</Button>}>
        {!treeCollapsed && <Tree
          treeData={treeData}
          height={640}
          expandedKeys={treeExpandedKeys}
          onExpand={(keys:any)=>setTreeExpandedKeys(keys)}
          selectedKeys={focus.selectedId?[focus.selectedId]:[]}
          onSelect={(keys:any)=>{
            const key=String(keys[0])
            if(key) handleTreeSelect(key)
          }}
        />}
      </Card>
      <Card className="pane-canvas" size="small" title={<span>{canvasTitle}</span>}>
        {visibleGraph.nodes.length===0
          ? <Empty description="无节点可显示"/>
          : <EngineeringFlow
              graph={visibleGraph}
              focusId={focus.selectedId||undefined}
              selectedId={focus.selectedId||undefined}
              viewMode={viewMode==='energy'?'flow':viewMode}
              flowKindFilter="all"
              flowMode={viewMode==='energy'?'selected-types':flowMode}
              selectedFlowTypes={viewMode==='energy'?['physical']:selectedFlowTypes}
              focusPath={focusPath}
              selectedFlowId={selectedFlowId}
              showAnimation={showAnim}
              onSelect={handleCanvasSelect}
              onDrillDown={handleCanvasDrill}
            />}
      </Card>
      <Card className="pane-details" size="small" title="属性 / 接口 / 追溯"
        extra={<Button size="small" type="text" onClick={()=>setDetailsCollapsed(v=>!v)}>{detailsCollapsed?'展开':'折叠'}</Button>}>
        {!detailsCollapsed && <PropertyPanel
          value={selected}
          onTrace={handleTrace}
          onNavigate={(id:string)=>navigateToFocus(id,true)}
          traceItems={trace}
        />}
      </Card>
    </div>
  </div>
}
