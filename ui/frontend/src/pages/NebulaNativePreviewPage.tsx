import NebulaScene from '../components/scenes/NebulaScene'
import {NEBULA_FIXTURE} from '../scenes/nebula/nebulaConstants'

export default function NebulaNativePreviewPage(){
  return <main style={{position:'fixed',inset:0,overflow:'hidden',background:'#02040a'}} aria-label="Agent Display NEBULA 原生移植验收页">
    <NebulaScene snapshot={NEBULA_FIXTURE}/>
  </main>
}
