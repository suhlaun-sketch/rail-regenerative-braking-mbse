import {Layout,Menu,Steps,Tag} from 'antd'
import {useMemo} from 'react'
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
import {ErrorBoundary} from './components/ErrorBoundary'

const items=[
['/','01 项目总览'],['/semantic','需求语义解析与追溯'],['/sysml','02 SysML v2系统模型'],['/task-slice','03 任务语义切片'],['/ssd','04 SSI结构投影'],['/binding','05 实施接口绑定'],['/fmu','06 FMU组件库'],['/ssp','07 SSP系统装配'],['/cosim','08 联合仿真'],['/vv','09 物理一致性验证'],['/trace','10 数字线程追溯'],['/reports','11 结果与报告']
]

function withBoundary(page:React.ReactNode){return <ErrorBoundary>{page}</ErrorBoundary>}

export default function App(){const nav=useNavigate(),loc=useLocation();const selected=useMemo(()=>loc.pathname==='/'?'/':loc.pathname,[loc.pathname]);return <Layout className="app-shell">
<Layout.Header className="top"><div><div className="title">轨道列车牵引—再生制动数字工程工作台</div><div className="subtitle">基于 SysML v2、SSI、FMI/SSP 的仿真集成模型驱动系统工程平台</div></div><Tag color="green">v2.1 FINAL · 已冻结</Tag></Layout.Header>
<div className="process"><Steps size="small" current={5} items={['SysML v2','SSI / SSD','接口绑定','Simulink / FMU','SSP装配','联合仿真与V&V'].map(title=>({title}))}/></div>
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
  <Route path="/vv" element={withBoundary(<VVPage/>)}/>
  <Route path="/trace" element={withBoundary(<DigitalThreadPage/>)}/>
  <Route path="*" element={withBoundary(<PlaceholderPage/>)}/>
</Routes></Layout.Content></Layout></Layout>}
