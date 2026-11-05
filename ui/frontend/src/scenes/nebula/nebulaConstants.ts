import type {NebulaSnapshot} from './nebulaTypes'

export const NEBULA_FIXTURE: NebulaSnapshot = {
  id: 'agent-display-nebula-visual-fixture-v1',
  title: 'Agent Display NEBULA 静态视觉 Fixture',
  fixture: true,
  clusters: [
    {id:'chief',key:'CHIEF',label:'总调度',role:'中央星核与调度中枢',color:'#f4f7ff'},
    {id:'scout',key:'SCOUT',label:'检索',role:'读取与检索',color:'#7cc8ff'},
    {id:'split',key:'SPLIT',label:'拆解',role:'分解与结构化',color:'#a093ff'},
    {id:'copy',key:'COPY',label:'文案',role:'文本处理',color:'#ff86c2'},
    {id:'design',key:'DESIGN',label:'设计',role:'视觉与布局',color:'#ffae80'},
    {id:'code',key:'CODE',label:'代码',role:'代码与接口',color:'#49e3f2'},
    {id:'test',key:'TEST',label:'测试',role:'测试与校验',color:'#8ef0c4'},
    {id:'proof',key:'PROOF',label:'审校',role:'证据审校',color:'#ffd27a'},
    {id:'data',key:'DATA',label:'数据',role:'数据与分析',color:'#6f8dff'},
    {id:'cut',key:'CUT',label:'剪辑',role:'片段组织',color:'#ff9a6a'},
    {id:'ads',key:'ADS',label:'投放',role:'发布与试验',color:'#e07bff'},
    {id:'care',key:'CARE',label:'客服',role:'问题处理',color:'#9ee6ff'},
    {id:'vault',key:'VAULT',label:'归档',role:'归档与索引',color:'#d6c4ff'},
  ],
}
