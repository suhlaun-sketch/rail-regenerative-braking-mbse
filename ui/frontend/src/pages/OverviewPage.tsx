import {Tag,Typography} from 'antd'
import {useEffect,useMemo,useState} from 'react'
import {api} from '../api'
import EngineeringPark,{ParkZone} from '../components/overview/EngineeringPark'

const dash=(v:unknown)=>v===undefined||v===null||v===''?'—':String(v)
const count=(v:any,...keys:string[])=>{for(const k of keys){const x=k.split('.').reduce((a,p)=>a?.[p],v);if(typeof x==='number')return x;if(Array.isArray(x))return x.length}return '—'}

export default function OverviewPage(){
  const [data,setData]=useState<Record<string,any>>({}),[loaded,setLoaded]=useState(false)
  useEffect(()=>{let live=true;const requests=[['project','/project/status'],['kg','/kg/summary'],['semantic','/semantic/catalog'],['slice','/task-slice/catalog'],['thread','/digital-thread/summary'],['vv','/vv/summary']] as const
    Promise.allSettled(requests.map(([,url])=>api.get(url))).then(results=>{if(!live)return;const next:Record<string,any>={};results.forEach((r,i)=>{if(r.status==='fulfilled')next[requests[i][0]]=r.value.data});setData(next);setLoaded(true)});return()=>{live=false}},[])
  const zones=useMemo<ParkZone[]>(()=>[
    {id:'01',name:'需求语义解析',english:'SEMANTIC REQUIREMENT',responsibility:'从自然语言与正式需求中识别工程对象，建立需求、功能与产品关联。',input:'工程问题、正式需求',output:'Requirement / Function / Product 追溯',route:'/semantic',position:'zone-1',status:data.semantic?'数据可用':'数据待连接',metrics:[{label:'Requirement',value:count(data.semantic,'requirement_count')},{label:'Function',value:count(data.semantic,'function_count')},{label:'Product',value:count(data.semantic,'product_count')}]},
    {id:'02',name:'任务切片与架构推演',english:'TASK SLICE',responsibility:'根据目标功能逐层推演产品边界、接口与上游依赖。',input:'目标 Function',output:'L2 产品、接口与依赖闭包',route:'/task-slice',position:'zone-2',status:data.slice?'目录已载入':'数据待连接',metrics:[{label:'目标功能',value:count(data.slice,'functions','function_count')},{label:'L2 产品',value:count(data.slice,'products','l2_products','product_count')},{label:'接口',value:count(data.slice,'interfaces','interface_count')},{label:'依赖闭包',value:count(data.slice,'dependency_closure','dependency_count')}]},
    {id:'03',name:'工程知识图谱',english:'KNOWLEDGE GRAPH',responsibility:'以只读知识图谱查看真实工程实体、关系与来源证据。',input:'工程实体与查询词',output:'邻居、路径与证据',route:'/trace',position:'zone-3',status:data.kg?.status==='CONNECTED'?'Neo4j 已连接':'Neo4j 未连接',metrics:[{label:'节点',value:data.kg?.status==='CONNECTED'?dash(data.kg.nodeCount):'—'},{label:'关系',value:data.kg?.status==='CONNECTED'?dash(data.kg.relationshipCount):'—'}]},
    {id:'04',name:'SysML v2 系统模型',english:'SYSTEM ARCHITECTURE',responsibility:'查看系统层级、部件、端口、接口和结构关系。',input:'冻结 SysML v2 基线',output:'四层系统架构',route:'/sysml',position:'zone-4',status:data.project?.sysml==='PASS'?'模型 PASS':'数据待连接',metrics:[{label:'权威模型',value:data.project?.authorityModel||'—'},{label:'L2 组件',value:dash(data.project?.l2Components)}]},
    {id:'05',name:'SSI 仿真模型集成',english:'SSI / FMI / SSP',responsibility:'从系统结构定义进入 SSD、FMI 变量映射与 SSP 系统装配。',input:'SysML 结构与接口',output:'SSD / FMU / Executable SSP',route:'/ssd',routes:[{label:'SSD 结构',route:'/ssd'},{label:'接口绑定',route:'/binding'},{label:'FMU 组件',route:'/fmu'},{label:'SSP 装配',route:'/ssp'}],position:'zone-5',status:data.project?.ssp||'数据待连接',metrics:[{label:'FMI 变量',value:dash(data.project?.fmiVariables)},{label:'FMU',value:data.project?`${dash(data.project.fmusValid)}/${dash(data.project.fmusAvailable)}`:'—'},{label:'执行连接',value:dash(data.project?.connections)}]},
    {id:'06',name:'联合仿真与验证',english:'CO-SIMULATION & V&V',responsibility:'分析牵引、再生制动、储能状态与系统物理一致性。',input:'Executable SSP / 冻结工况',output:'联合仿真结果与 V&V 证据',route:'/cosim',routes:[{label:'联合仿真',route:'/cosim'},{label:'物理验证',route:'/vv'}],position:'zone-6',status:data.vv?.status||data.project?.physicalVv||'数据待连接',metrics:[{label:'联合仿真',value:dash(data.project?.cosimulation)},{label:'物理验证',value:dash(data.vv?.status||data.project?.physicalVv)},{label:'数字线程阶段',value:count(data.thread,'stages')}]},
  ],[data])
  return <div className="park-page"><header className="park-page-head"><div><Typography.Title level={2}>智轨跃迁</Typography.Title><p>轨道车辆智能设计与可解释验证平台</p></div><Tag className="park-baseline">当前工程基线 · {data.project?.baseline||'—'}{data.project?.frozen?' · FROZEN':''}</Tag></header><EngineeringPark zones={zones} baseline={loaded?(data.project?.baseline||'API PARTIAL'):'LOADING'}/></div>
}

