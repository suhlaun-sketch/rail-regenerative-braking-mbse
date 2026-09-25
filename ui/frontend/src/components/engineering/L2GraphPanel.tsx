import {Card} from 'antd'
import {useEffect,useState} from 'react'
import {api} from '../../api'
import EngineeringGraph from './EngineeringGraph'
export default function L2GraphPanel({title='L2 应用投影'}:{title?:string}){const [g,setG]=useState<any>();useEffect(()=>{api.get('/model/l2').then(r=>setG(r.data))},[]);return <Card title={title} className="l2-panel"><EngineeringGraph graph={g}/></Card>}
