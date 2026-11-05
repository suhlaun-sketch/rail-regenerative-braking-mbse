import {Layout,Menu} from 'antd'
import {lazy,Suspense,useMemo,useState} from 'react'
import {Route,Routes,useLocation,useNavigate} from 'react-router-dom'
import OverviewPage from './pages/OverviewPage'
import SysMLPage from './pages/SysMLPage'
import SSDPage from './pages/SSDPage'
import VVPage from './pages/VVPage'
import ReplayPage from './pages/ReplayPage'
import TaskSlicePage from './pages/TaskSlicePage'
import PlaceholderPage from './pages/PlaceholderPage'
import BindingPage from './pages/BindingPage'
import FmuPage from './pages/FmuPage'
import SspPage from './pages/SspPage'
import DigitalThreadPage from './pages/DigitalThreadPage'
import SemanticRequirementPage from './pages/SemanticRequirementPage'
import GraphWorkbenchPage from './pages/GraphWorkbenchPage'
import {readSession} from './components/workbench/StageWorkspace'
import VerificationPage from './pages/VerificationPage'
import {ErrorBoundary} from './components/ErrorBoundary'

const CrawlerView=lazy(()=>import('./components/crawler/CrawlerView'))
const NebulaNativePreviewPage=lazy(()=>import('./pages/NebulaNativePreviewPage'))
const NebulaEngineeringPage=lazy(()=>import('./pages/NebulaEngineeringPage'))
const items=[
['/','项目总览'],['/semantic','需求语义解析与追溯'],['/sysml','SysML v2系统模型'],['/task-slice','任务语义切片'],['/knowledge-graph?workspace=ssi','06.1 SSI结构转换'],['/binding','06.2 实施接口绑定'],['/fmu','06.3 FMU组件库'],['/ssp','06.4 SSP系统装配'],['/cosim','06.5 联合仿真'],['/verification','06.6 需求验证'],['/vv','07 物理一致性验证'],['/trace','08 数字线程追溯'],['/knowledge-graph','09 模型知识图谱'],['/reports','10 结果与报告']
]

function withBoundary(page:React.ReactNode){return <ErrorBoundary>{page}</ErrorBoundary>}

export default function App(){const nav=useNavigate(),loc=useLocation();const [demo,setDemo]=useState(()=>sessionStorage.getItem('workbench-demo')!=='false');const session=readSession();const selected=useMemo(()=>loc.pathname==='/'?'/':loc.pathname,[loc.pathname]);if(loc.pathname==='/knowledge-graph/nebula-engineering')return withBoundary(<Suspense fallback={<div style={{background:'#02040a',color:'#b8d0da',height:'100vh',padding:40}}>正在连接真实工程知识图谱…</div>}><NebulaEngineeringPage/></Suspense>);if(loc.pathname==='/knowledge-graph/nebula-native')return withBoundary(<Suspense fallback={<div style={{background:'#02040a',color:'#b8d0da',height:'100vh',padding:40}}>正在载入 NEBULA 原生场景…</div>}><NebulaNativePreviewPage/></Suspense>);if(loc.pathname==='/knowledge-graph/crawler')return withBoundary(<Suspense fallback={<div style={{background:'#04070c',color:'#b8d0da',height:'100vh',padding:40}}>正在载入知识追踪视图…</div>}><CrawlerView/></Suspense>);if(loc.pathname==='/knowledge-graph')return withBoundary(<GraphWorkbenchPage/>);return <Layout className="app-shell ew-main-shell">
<Layout.Header className="top"><div><div className="title">轨道列车牵引—再生制动智能系统设计与联合仿真工作台</div><div className="subtitle">基于 SysML v2、SSI、FMI/SSP 的仿真集成模型驱动系统工程平台</div></div><div className="ew-shell-tools"><label><input type="checkbox" checked={demo} onChange={e=>{setDemo(e.target.checked);sessionStorage.setItem("workbench-demo",String(e.target.checked))}}/>演示模式</label><button onClick={()=>{sessionStorage.removeItem("kg-design-session-v2");sessionStorage.removeItem("workbench-scope");sessionStorage.removeItem("workbench-replay");nav("/knowledge-graph")}}>重置演示</button></div></Layout.Header>
<nav className="process ew-six" aria-label="数字工程流程">{[['需求识别','/semantic'],['功能展开','/task-slice'],['产品匹配','/task-slice'],['接口架构','/sysml'],['SysML建模','/sysml'],['仿真验证','/cosim']].map(([title,route],i)=><button key={`${title}-${i}`} className={loc.pathname===route?'active':''} onClick={()=>nav(route)}><i>{String(i+1).padStart(2,'0')}</i>{title}</button>)}</nav>
<Layout><Layout.Sider width={252} theme="light" className="side"><Menu mode="inline" selectedKeys={[selected]} items={items.map(([key,label])=>({key:key as string,label:label as string}))} onClick={({key})=>nav(key)}/></Layout.Sider>
<Layout.Content className="content"><Routes>
  <Route path="/" element={withBoundary(<OverviewPage/>)}/>
  <Route path="/sysml" element={withBoundary(<SysMLPage/>)}/>
  <Route path="/semantic" element={withBoundary(<SemanticRequirementPage/>)}/>
  <Route path="/task-slice" element={withBoundary(<TaskSlicePage/>)}/>
  <Route path="/ssd" element={withBoundary(<SSDPage/>)}/>
  <Route path="/binding" element={withBoundary(<BindingPage/>)}/>
  <Route path="/fmu" element={withBoundary(<FmuPage/>)}/>
  <Route path="/ssp" element={withBoundary(<SspPage/>)}/>
  <Route path="/cosim" element={withBoundary(<ReplayPage/>)}/>
  <Route path="/verification" element={withBoundary(<VerificationPage/>)}/><Route path="/vv" element={withBoundary(<VVPage/>)}/>
  <Route path="/trace" element={withBoundary(<DigitalThreadPage/>)}/>
  <Route path="*" element={withBoundary(<PlaceholderPage/>)}/>
</Routes></Layout.Content></Layout></Layout>}
