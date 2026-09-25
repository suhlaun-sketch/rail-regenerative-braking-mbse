import React from 'react'

type State={err:Error|null}
export class ErrorBoundary extends React.Component<{children:React.ReactNode},{err:Error|null}>{
  state:State={err:null}
  static getDerivedStateFromError(err:Error){return {err}}
  componentDidCatch(err:Error,info:React.ErrorInfo){
    console.error('[ErrorBoundary]',err,info?.componentStack)
  }
  render(){
    if(this.state.err){
      return <div style={{padding:24,fontFamily:'monospace',color:'#cf1322',background:'#fff5f5',margin:16,border:'1px solid #ffa39e',borderRadius:6}}>
        <h3 style={{margin:'0 0 12px'}}>页面渲染异常</h3>
        <pre style={{whiteSpace:'pre-wrap',fontSize:12}}>{String(this.state.err?.message||this.state.err)}</pre>
        <pre style={{whiteSpace:'pre-wrap',fontSize:11,color:'#888'}}>{this.state.err?.stack||''}</pre>
        <button onClick={()=>this.setState({err:null})} style={{marginTop:12,padding:'6px 14px',cursor:'pointer'}}>重试</button>
      </div>
    }
    return this.props.children
  }
}
