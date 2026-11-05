import type {SemanticFunction,SemanticRequirement} from '../../services/semanticApi'

export type DraftPhase='IDLE'|'REQUIREMENT_REVIEW'|'FUNCTION_REVIEW'|'ARCHITECTURE'
export type SuggestionAction='ADD'|'KEEP'|'VERIFY'
export type DraftSuggestion={id:string;action:SuggestionAction;functionId?:string;title:string;reason:string;requirementIds:string[];evidence:string[];risk:string;constraints:string;needsVerification:boolean;decision:'PENDING'|'ACCEPTED'|'REJECTED'}
export type EngineeringDraft={version:1;goal:string;phase:DraftPhase;requirements:SemanticRequirement[];selectedRequirementIds:string[];excludedRequirementIds:string[];functions:SemanticFunction[];selectedFunctionIds:string[];excludedFunctionIds:string[];manualFunctionIds:string[];confirmedRequirementIds:string[];confirmedFunctionIds:string[];suggestions:DraftSuggestion[];acceptedSuggestionIds:string[];updatedAt:string}

export const emptyDraft=():EngineeringDraft=>({version:1,goal:'',phase:'IDLE',requirements:[],selectedRequirementIds:[],excludedRequirementIds:[],functions:[],selectedFunctionIds:[],excludedFunctionIds:[],manualFunctionIds:[],confirmedRequirementIds:[],confirmedFunctionIds:[],suggestions:[],acceptedSuggestionIds:[],updatedAt:new Date().toISOString()})
export const touch=(draft:EngineeringDraft,patch:Partial<EngineeringDraft>):EngineeringDraft=>({...draft,...patch,updatedAt:new Date().toISOString()})
export function buildSuggestions(draft:EngineeringDraft):DraftSuggestion[]{
  const selected=new Set(draft.selectedFunctionIds),confirmedReqs=draft.confirmedRequirementIds
  const suggestions:DraftSuggestion[]=[]
  for(const rid of confirmedReqs){
    const linked=draft.functions.filter(fn=>fn.matched_by_requirements?.includes(rid))
    const covered=linked.some(fn=>selected.has(fn.function_id))
    if(!covered){
      const candidate=linked.find(fn=>!selected.has(fn.function_id))
      suggestions.push({id:`coverage:${rid}`,action:candidate?'ADD':'VERIFY',functionId:candidate?.function_id,title:candidate?`恢复正式功能 ${candidate.name}`:`需求 ${rid} 尚无功能承接`,reason:candidate?'该功能具有正式 Requirement→Function 映射，移除后该需求失去当前功能承接。':'现有正式语义映射未返回可承接功能，不能自动补造。',requirementIds:[rid],evidence:candidate?.mapping_evidence?.length?[`正式映射证据 ${candidate.mapping_evidence.length} 条`]:['语义目录与 Neo4j 精确 ID 回查'],risk:'需求覆盖不完整',constraints:'需由工程师确认适用工况和系统边界',needsVerification:true,decision:'PENDING'})
    }
  }
  for(const fn of draft.functions.filter(item=>selected.has(item.function_id))){
    if(!fn.matched_by_requirements?.some(id=>confirmedReqs.includes(id)))suggestions.push({id:`allocation:${fn.function_id}`,action:'VERIFY',functionId:fn.function_id,title:`核验 ${fn.name} 的需求依据`,reason:'该功能由工程师从正式功能库加入，但与当前需求集合没有正式映射。',requirementIds:[],evidence:[fn.source||'正式功能目录'],risk:'可能扩大设计范围',constraints:'确认需求依据后再进行正式分配',needsVerification:true,decision:'PENDING'})
  }
  const signatures=new Map<string,SemanticFunction[]>()
  draft.functions.filter(fn=>selected.has(fn.function_id)).forEach(fn=>{const key=[...(fn.matched_by_requirements||[])].filter(id=>confirmedReqs.includes(id)).sort().join('|');if(key)signatures.set(key,[...(signatures.get(key)||[]),fn])})
  signatures.forEach((items,key)=>{if(items.length>1)suggestions.push({id:`overlap:${key}`,action:'VERIFY',title:`核验 ${items.length} 个功能的覆盖重叠`,reason:'这些功能具有相同的正式需求关联集合；这只是证据触发的复核，不据名称判定冗余。',requirementIds:key.split('|'),evidence:items.map(item=>`${item.function_id} · ${item.name}`),risk:'直接删除可能损失不同工况或实现职责',constraints:'需比较功能描述、分配对象和接口约束',needsVerification:true,decision:'PENDING'})})
  return suggestions
}

export function catalogItems<T>(value:unknown,key:'requirements'|'functions'):T[]{if(Array.isArray(value))return value as T[];const obj=value as Record<string,unknown>|null;const direct=obj?.[key];if(Array.isArray(direct))return direct as T[];if(Array.isArray(obj?.items))return obj!.items as T[];return []}
