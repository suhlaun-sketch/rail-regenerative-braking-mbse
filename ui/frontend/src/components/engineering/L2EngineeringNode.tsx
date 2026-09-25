import {memo} from 'react'
import {Handle,Position,NodeProps} from 'reactflow'

const family=(code:string)=>code==='4500'?'transformer':code==='5100'?'converter':code==='5300'?'motor':code==='X100'?'storage':code==='4100'?'pantograph':code.startsWith('4')?'cabinet':code.startsWith('7')||code.startsWith('8')?'controller':code.startsWith('3')?'mechanical':'module'

function L2EngineeringNode({data,selected}:NodeProps){
  const kind=family(String(data.code||''))
  return <div className={`rf-node rf-l2 rf-l2-25d rf-family-${kind} ${data.isNew?'rf-closure-new':''} ${selected?'selected':''}`}>
    <div className="rf-device-visual" aria-hidden="true"><span className="device-shadow"/><span className="device-body"/><span className="device-detail"/></div>
    <div className="rf-node-title">{data.display_name}</div>
    <div className="rf-node-code">（{data.code}）</div>
    <div className="rf-node-sub">{data.lane} · L2 · 接口 {data.interface_count||0}</div>
    <Handle type="target" position={Position.Left} className="rf-handle"/>
    <Handle type="source" position={Position.Right} className="rf-handle"/>
  </div>
}

export default memo(L2EngineeringNode)
