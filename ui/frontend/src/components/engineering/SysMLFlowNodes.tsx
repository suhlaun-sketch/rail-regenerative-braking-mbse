import {memo} from 'react'
import {Handle,Position,NodeProps} from 'reactflow'

const LANE_COLORS:Record<string,string>={
  '外部能源':'#d9eaf6','高压供电':'#dcefe5','功率变换':'#f7edce','牵引机械':'#f4dfd6',
  '车辆':'#e5e6f2','控制':'#e8e0f1','储能':'#dcefeb','其他':'#eceff2',
}
const FLOW_COLORS:Record<string,string>={
  physical:'#2f6f4f', control:'#4e6680', state:'#9b6a2c', data:'#5c4ea8', unknown:'#9aa8b2',
}

function L2NodeImpl({data,selected}:NodeProps){
  const bg=LANE_COLORS[data.lane]||LANE_COLORS['其他']
  return <div className={`rf-node rf-l2 ${selected?'selected':''}`} style={{background:bg}}>
    <div className="rf-node-title">{data.display_name}</div>
    <div className="rf-node-code">（{data.code}）</div>
    <div className="rf-node-sub">{data.lane} · L2 · 接口 {data.interface_count||0}</div>
    <Handle type="target" position={Position.Left} className="rf-handle"/>
    <Handle type="source" position={Position.Right} className="rf-handle"/>
  </div>
}
export const L2Node=memo(L2NodeImpl)

function L1NodeImpl({data,selected}:NodeProps){
  return <div className={`rf-node rf-l1 ${selected?'selected':''}`}>
    <div className="rf-node-title">{data.display_name}</div>
    <div className="rf-node-code">（{data.code}）</div>
    <div className="rf-node-sub">L1 · 顶层系统</div>
    <Handle type="target" position={Position.Left} className="rf-handle"/>
    <Handle type="source" position={Position.Right} className="rf-handle"/>
    <Handle type="source" position={Position.Bottom} className="rf-handle" id="b"/>
  </div>
}
export const L1Node=memo(L1NodeImpl)

function L3NodeImpl({data,selected}:NodeProps){
  const bg=LANE_COLORS[data.lane]||LANE_COLORS['其他']
  return <div className={`rf-node rf-l3 ${selected?'selected':''}`} style={{background:bg}}>
    <div className="rf-node-title">{data.display_name}</div>
    <div className="rf-node-code">（{data.code}）</div>
    <div className="rf-node-sub">L3 · {data.lane}</div>
    <Handle type="target" position={Position.Left} className="rf-handle"/>
    <Handle type="source" position={Position.Right} className="rf-handle"/>
  </div>
}
export const L3Node=memo(L3NodeImpl)

function L4NodeImpl({data,selected}:NodeProps){
  const bg=LANE_COLORS[data.lane]||LANE_COLORS['其他']
  return <div className={`rf-node rf-l4 ${selected?'selected':''}`} style={{background:bg}}>
    <div className="rf-node-title">{data.display_name}</div>
    <div className="rf-node-code">（{data.code}）</div>
    <Handle type="target" position={Position.Left} className="rf-handle"/>
    <Handle type="source" position={Position.Right} className="rf-handle"/>
  </div>
}
export const L4Node=memo(L4NodeImpl)

function PortNodeImpl({data,selected}:NodeProps){
  return <div className={`rf-node rf-port ${selected?'selected':''}`}>
    <div className="rf-port-name">▣ {data.portName}</div>
    <div className="rf-port-kind">{data.kind}</div>
    <Handle type="target" position={Position.Left} className="rf-handle"/>
    <Handle type="source" position={Position.Right} className="rf-handle"/>
  </div>
}
export const PortNode=memo(PortNodeImpl)

function FnNodeImpl({data,selected}:NodeProps){
  return <div className={`rf-node rf-fn ${selected?'selected':''}`}>
    <div className="rf-node-title">{data.display_name}</div>
    <div className="rf-node-code">Function</div>
    <div className="rf-node-sub">{data.category||'action def'}</div>
    <Handle type="target" position={Position.Left} className="rf-handle"/>
    <Handle type="source" position={Position.Right} className="rf-handle"/>
  </div>
}
export const FnNode=memo(FnNodeImpl)

function FlowEdgeImpl({id,data,selected,sourceX,sourceY,targetX,targetY,markerEnd}:any){
  // Animated SVG path for energy flows
  const color=FLOW_COLORS[data.flow_kind]||FLOW_COLORS.unknown
  const dx=targetX-sourceX, dy=targetY-sourceY
  const dist=Math.hypot(dx,dy)
  // Curved bezier
  const cx=(sourceX+targetX)/2, cy=(sourceY+targetY)/2 - Math.min(60,dist*0.15)
  const path=`M ${sourceX} ${sourceY} Q ${cx} ${cy} ${targetX} ${targetY}`
  const kind=data.flow_kind||'unknown'
  const animated = data.animated && kind==='physical'
  const dash=kind==='control'?'7 4':kind==='state'?'2 3':kind==='data'?'1 4':undefined
  const showLabel=Boolean(data.showLabel||selected)
  const markerId=`rf-arrow-${data.flow_kind||'unknown'}`
  return <>
    <defs><marker id={markerId} viewBox="0 0 10 10" refX="9" refY="5" markerWidth="6" markerHeight="6" orient="auto-start-reverse"><path d="M 0 0 L 10 5 L 0 10 z" fill={color}/></marker></defs>
    <path d={path} fill="none" stroke={color} strokeWidth={selected?3:2} strokeDasharray={dash} markerEnd={`url(#${markerId})`}
      opacity={0.95} className={animated?'rf-edge-animated':''}/>
    {data.label && showLabel && <foreignObject x={Math.min(sourceX,targetX)+Math.abs(dx)/2-120} y={cy-28} width={240} height={56}>
      <div className={`rf-edge-label ${selected?'selected':''}`} style={{borderColor:color}}>
        <b>{data.label}</b>
        {data.flow_items?.length>0 && <span>{data.flow_items.map((f:any)=>f.display_name).join('、')}</span>}
        {(data.source||data.target) && <small>{data.source_name||data.source} → {data.target_name||data.target} · {data.flow_kind}</small>}
      </div>
    </foreignObject>}
    {animated && <circle r="3" fill={color}>
      <animateMotion dur={`${Math.max(1.5, dist/120)}s`} repeatCount="indefinite" path={path}/>
    </circle>}
  </>
}
export const FlowEdge=memo(FlowEdgeImpl)

function ContainmentEdgeImpl({sourceX,sourceY,targetX,targetY}:any){
  return <path d={`M ${sourceX} ${sourceY} L ${targetX} ${targetY}`} fill="none" stroke="#9aa8b2" strokeWidth={1.2} strokeDasharray="3 4" opacity={0.55}/>
}
export const ContainmentEdge=memo(ContainmentEdgeImpl)
