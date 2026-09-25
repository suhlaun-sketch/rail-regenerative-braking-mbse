import axios from 'axios'
export const api=axios.create({baseURL:'/api',timeout:15000})
export type GraphPayload={level:number;focus?:string;nodes:Array<{data:Record<string,any>}>;edges:Array<{data:Record<string,any>}>;meta:{nodeCount:number;portsExpanded:boolean;edgeAggregation:boolean;layout:Record<string,string>;lanes:string[]}}
