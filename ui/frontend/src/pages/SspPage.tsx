import {Tag,Typography} from 'antd'
import {useEffect,useState} from 'react'
import {api} from '../api'
import EngineeringGraph from '../components/engineering/EngineeringGraph'
export default function SspPage(){const [d,setD]=useState<any>();useEffect(()=>{api.get('/application/ssp').then(r=>setD(r.data))},[]);return <><div className="page-title"><Typography.Title level={3}>SSP系统装配</Typography.Title><Tag color="green">{d?.status} · {d?.causalPaths}条唯一因果路径</Tag></div><div className="standalone-graph"><EngineeringGraph graph={d?.l2_graph}/></div></>}
