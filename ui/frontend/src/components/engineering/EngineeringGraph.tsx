import cytoscape from 'cytoscape'
import elk from 'cytoscape-elk'
import {useEffect,useRef} from 'react'
cytoscape.use(elk as cytoscape.Ext)

const laneColors:Record<string,string>={'外部能源':'#d9eaf6','高压供电':'#dcefe5','功率变换':'#f7edce','牵引机械':'#f4dfd6','车辆':'#e5e6f2','控制':'#e8e0f1','储能':'#dcefeb','其他':'#eceff2'}
const flowKindColors:Record<string,string>={physical:'#2f6f4f',control:'#4e6680',state:'#9b6a2c',data:'#5c4ea8'}

type Props={
  graph?:any
  nodes?:any[]
  edges?:any[]
  compound?:boolean
  focusId?:string
  selectedId?:string
  onSelect?:(v:any)=>void
  onDrillDown?:(v:any)=>void
  layoutKey?:string
}

export default function EngineeringGraph(props:Props){
  const {graph,nodes,edges,compound=false,focusId,selectedId,onSelect,onDrillDown,layoutKey} = props
  const ref=useRef<HTMLDivElement>(null)
  const cyRef=useRef<any>(null)
  const topologyKey=useRef('')
  // Latest-handler refs so we can re-render without re-attaching listeners.
  const selectRef=useRef(onSelect)
  const drillRef=useRef(onDrillDown)
  useEffect(()=>{selectRef.current=onSelect},[onSelect])
  useEffect(()=>{drillRef.current=onDrillDown},[onDrillDown])

  const ns:any[] = nodes || graph?.nodes || []
  const es:any[] = edges || graph?.edges || []
  const topologySig=`${ns.length}|${es.length}|${compound?1:0}|${layoutKey||''}`

  // Topology / layout effect: only runs when structure changes.
  useEffect(()=>{
    if(!ref.current) return
    if(!cyRef.current){
      cyRef.current=cytoscape({
        container:ref.current,
        elements:[],
        style:[
          {selector:'node',style:{
              'background-color':(n:any)=>laneColors[n.data('lane')]||'#e5edf3',
              'border-color':'#55778e','border-width':'1.5px',
              'label':'data(name)','font-size':'12px','text-wrap':'wrap','text-max-width':'132px',
              'width':'150px','height':'48px','shape':'round-rectangle','text-valign':'center','color':'#17324a'
          }},
          {selector:'node:parent',style:{
              'background-opacity':.16,'border-style':'solid','border-width':'2px','padding':'24px',
              'text-valign':'top','text-halign':'left','font-weight':'bold'
          }},
          {selector:'node.level1',style:{'border-color':'#244f6d','font-size':'14px'}},
          {selector:'node.level3',style:{'font-size':'11px'}},
          {selector:'node.level4',style:{'font-size':'10px','width':'132px','height':'40px'}},
          {selector:'node.semantic-hidden',style:{'label':''}},
          {selector:'node.drillable',style:{'border-color':'#005ea8','border-style':'double','border-width':'2px'}},
          {selector:'node.dimmed',style:{'opacity':.28}},
          {selector:'edge.dimmed',style:{'opacity':.14}},
          {selector:'edge',style:{
              'width':'1.8px','line-color':(e:any)=>flowKindColors[e.data('flow_kind')]||'#708594',
              'target-arrow-color':(e:any)=>flowKindColors[e.data('flow_kind')]||'#708594',
              'target-arrow-shape':'triangle','curve-style':'taxi','taxi-direction':'rightward',
              'label':'data(label)','font-size':'10px','text-background-color':'#fff','text-background-opacity':.88,
              'text-background-padding':'3px','color':'#344e60'
          }},
          {selector:'edge[relation="containment"]',style:{'line-style':'dotted','line-color':'#9aa8b2','target-arrow-shape':'none','label':''}},
          {selector:'edge[flow_kind="control"],edge[flow_kind="state"]',style:{'line-style':'dashed'}},
          {selector:'edge[flow_kind="unknown"]',style:{'line-color':'#a0a6aa','target-arrow-color':'#a0a6aa'}},
          {selector:'node:selected',style:{'border-color':'#d35f28','border-width':'4px'}},
          {selector:'edge:selected',style:{'line-color':'#d35f28','target-arrow-color':'#d35f28','width':'3px'}},
        ],
        wheelSensitivity:.18,
      })
      const cy=cyRef.current
      cy.on('tap','node,edge',(e:any)=>{ selectRef.current?.(e.target.data()) })
      cy.on('dbltap','node',(e:any)=>{ drillRef.current?.(e.target.data()) })
      const semantic=()=>{
        const z=cy.zoom()
        cy.nodes('.level4').toggleClass('semantic-hidden',z<.95)
        cy.nodes('.level3').toggleClass('semantic-hidden',z<.55)
      }
      cy.on('zoom',semantic); semantic()
    }
    if(topologyKey.current !== topologySig){
      const cy=cyRef.current
      cy.elements().remove()
      cy.add([
        ...ns.map((x:any)=>({...x,classes:`level${x.data.level||2}${x.data.drillable?' drillable':''}`})),
        ...(compound?[]:es),
      ])
      const opts:any={
        name:'elk','elk.algorithm':'layered','elk.direction':'RIGHT','elk.edgeRouting':'ORTHOGONAL',
        'elk.spacing.nodeNode':'35','elk.layered.spacing.nodeNodeBetweenLayers':'75',
        animate:false,fit:true,padding:35,
      }
      if(compound) opts['elk.hierarchyHandling']='INCLUDE_CHILDREN'
      const layout=cy.layout(opts)
      layout.one('layoutstop',()=>{
        if(!compound){
          cy.nodes().forEach((n:any)=>{
            const d=n.data()
            if(typeof d.rank==='number'&&typeof d.laneOrder==='number')
              n.position({x:95+d.rank*195,y:70+d.laneOrder*82})
          })
        }
        cy.fit(undefined,35)
      })
      layout.run()
      topologyKey.current=topologySig
    }
  },[topologySig])

  // Selection: highlight only, no relayout.
  useEffect(()=>{
    const cy=cyRef.current; if(!cy) return
    cy.elements().unselect()
    if(selectedId){
      const el=cy.getElementById(selectedId)
      if(el.length){ el.select() }
    }
  },[selectedId])

  // Focus: pan-only, no zoom-reset, no relayout.
  useEffect(()=>{
    const cy=cyRef.current; if(!cy||!focusId) return
    const el=cy.getElementById(focusId)
    if(el.length){ cy.animate({center:{eles:el},duration:250}) }
  },[focusId])

  useEffect(()=>()=>{ if(cyRef.current){ cyRef.current.destroy(); cyRef.current=null } },[])

  const lanes=graph?.meta?.lanes||[]
  return <div className="graph-wrap"><div className="lane-legend">{lanes.map((x:string)=><span key={x} style={{background:laneColors[x]||laneColors['其他']}}>{x}</span>)}</div><div ref={ref} className="graph-canvas"/></div>
}