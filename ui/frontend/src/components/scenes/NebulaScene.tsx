import {useLayoutEffect,useRef} from 'react'
import {createNebulaRenderer} from '../../scenes/nebula/nebulaRenderer'
import {NEBULA_FIXTURE} from '../../scenes/nebula/nebulaConstants'
import type {NebulaSceneController,NebulaSnapshot} from '../../scenes/nebula/nebulaTypes'

export interface NebulaSceneProps {
  snapshot?: NebulaSnapshot
  className?: string
  onReady?: (controller:NebulaSceneController)=>void
  onNodeSelect?: (nodeId:string)=>void
  onManualControl?: ()=>void
}

export default function NebulaScene({snapshot=NEBULA_FIXTURE,className,onReady,onNodeSelect,onManualControl}:NebulaSceneProps){
  const hostRef=useRef<HTMLDivElement>(null)
  const readyRef=useRef(onReady)
  readyRef.current=onReady

  useLayoutEffect(()=>{
    const host=hostRef.current
    if(!host)return
    const controller=createNebulaRenderer(host,{snapshot,onNodeSelect,onManualControl})
    readyRef.current?.(controller)
    return ()=>controller.dispose()
  },[])

  useLayoutEffect(()=>{
    const host=hostRef.current as (HTMLDivElement&{__nebulaController?:NebulaSceneController})|null
    host?.__nebulaController?.setSnapshot(snapshot)
  },[snapshot])

  return <div ref={hostRef} className={className} data-nebula-native data-fixture={snapshot.fixture?'true':'false'} style={{position:'absolute',inset:0,minWidth:0,minHeight:0,overflow:'hidden',background:'#02040a'}}/>
}
