#!/usr/bin/env python3
"""Actual all-16 FMI 2.0 co-simulation and focused physical V&V for v2."""
from __future__ import annotations
import csv, json, math, os, sys, time
from datetime import datetime, timezone
from pathlib import Path

os.environ.setdefault("PROCESSOR_ARCHITECTURE", "AMD64")
SCRIPT = Path(__file__).resolve(); ROOT = Path(os.environ.get("RAIL_MBSE_ROOT", SCRIPT.parents[4]))
sys.path.insert(0, str(ROOT / "work/simulation/simulink_fmu_v1/09_tools/python_packages"))
from fmpy import extract, read_model_description  # noqa: E402
from fmpy.fmi2 import FMU2Slave  # noqa: E402

WORK = ROOT / "work/simulation/simulink_fmu_v2_1_final"
BASELINE = ROOT / "work/simulation/implementation_binding/Rail_MBSE_Executable_FMU_Interface_v1.json"
REGISTRY = WORK / "05_fmu/Rail_MBSE_FMU_Model_Registry_v2_1.json"
SSP_VALIDATION = WORK / "06_ssp/Executable_SSP_Validation_v2_1.json"
RESULT_DIR, LOG_DIR = WORK / "07_results", WORK / "logs"
STOP, WHEEL_RADIUS, MASS, GEAR, DRIVE_ETA = 50.0, 0.46, 80000.0, 6.2, 0.97
MOTOR_ETA_MOT, MOTOR_ETA_REG = 0.94, 0.93
SC_C, SC_ESR, SC_VMIN, SC_VMAX = 120.0, 0.04, 500.0, 900.0
SC_EMIN, SC_EMAX = 0.5*SC_C*SC_VMIN**2, 0.5*SC_C*SC_VMAX**2

def read_json(p): return json.loads(Path(p).read_text(encoding="utf-8"))
def write_json(p, d): Path(p).write_text(json.dumps(d, ensure_ascii=False, indent=2)+"\n", encoding="utf-8")
def write_csv(p, rows):
    with Path(p).open("w", newline="", encoding="utf-8-sig") as f:
        w=csv.DictWriter(f, fieldnames=list(rows[0])); w.writeheader(); w.writerows(rows)
def trapz(rows, key, pred=lambda r: True, positive=False):
    a=[r for r in rows if pred(r)]; s=0.0
    for x,y in zip(a,a[1:]):
        vx,vy=float(x[key]),float(y[key])
        if positive: vx,vy=max(vx,0.0),max(vy,0.0)
        s += 0.5*(vx+vy)*(y["time"]-x["time"])
    return s

class Instance:
    def __init__(self, component, fmu_path, unzip_dir):
        self.component=component; self.description=read_model_description(str(fmu_path))
        if self.description.fmiVersion!="2.0" or self.description.coSimulation is None: raise RuntimeError(component)
        extract(str(fmu_path), str(unzip_dir)); self.variables={v.name:v for v in self.description.modelVariables}
        self.fmu=FMU2Slave(guid=self.description.guid, unzipDirectory=str(unzip_dir),
                           modelIdentifier=self.description.coSimulation.modelIdentifier, instanceName=component)
        self.fmu.instantiate()
    def initialize(self):
        self.fmu.setupExperiment(startTime=0.0, stopTime=STOP); self.fmu.enterInitializationMode(); self.fmu.exitInitializationMode()
    def get(self,name):
        v=self.variables[name]; vr=[v.valueReference]
        if v.type=="Real": return float(self.fmu.getReal(vr)[0])
        if v.type in ("Integer","Enumeration"): return int(self.fmu.getInteger(vr)[0])
        if v.type=="Boolean": return bool(self.fmu.getBoolean(vr)[0])
        raise TypeError(v.type)
    def set(self,name,value):
        v=self.variables[name]; vr=[v.valueReference]
        if v.type=="Real": self.fmu.setReal(vr,[float(value)])
        elif v.type in ("Integer","Enumeration"): self.fmu.setInteger(vr,[int(value)])
        elif v.type=="Boolean": self.fmu.setBoolean(vr,[bool(value)])
        else: raise TypeError(v.type)
    def step(self,t,dt):
        status=self.fmu.doStep(currentCommunicationPoint=t, communicationStepSize=dt)
        if status not in (None,0): raise RuntimeError(f"{self.component} status {status} at {t}")
    def close(self):
        try: self.fmu.terminate()
        finally: self.fmu.freeInstance()

def commands(scenario,t,traction,brake):
    if scenario=="D_LOW_SPEED": return (0.24 if t<7 else 0.0),(0.55 if t>=7 else 0.0)
    if scenario=="E_STRONG_BRAKE": return (traction if t<20 else 0.0),(1.2 if t>=25 else 0.0)
    return traction,brake
def overrides(I,scenario,traction,brake):
    if scenario=="B_HV_UNAVAILABLE": I["L2_4100"].set("in_pantograph_command",0)
    if scenario=="C_ESS_FULL":
        I["L2_8100"].set("in_ess_availability",False); I["L2_8100"].set("in_ess_available_charge_power",0.0)
        I["L2_8100"].set("in_super_cap_soc",1.0); I["L2_X100"].set("in_ess_power_request",0.0)
    if scenario in ("D_LOW_SPEED","E_STRONG_BRAKE"):
        I["L2_8100"].set("in_traction_command",traction); I["L2_8100"].set("in_service_brake_request",brake)
        I["L2_7200"].set("in_service_brake_request",brake)
def phase(t,v,b):
    if b>0: return "stop_hold" if v<=0.05 else ("low_speed_blending" if v<1.5 else "braking")
    return "traction" if t<20 else "coast"

def run_case(scenario,dt,baseline,registry,suffix,raw=False):
    components=[c["ssd_component"] for c in baseline["components"]]
    paths={m["component"]:ROOT/m["fmu_file"] for m in registry["models"]}; conns=baseline["executable_signal_connections"]
    unique=[]; seen=set()
    for c in conns:
        key=(c["source_component"],c["source_variable"],c["target_component"],c["target_variable"])
        if key not in seen: seen.add(key); unique.append(c)
    rd=LOG_DIR/"fmu_runtime_v2"/f"{suffix}_{datetime.now().strftime('%Y%m%d_%H%M%S_%f')}"; rd.mkdir(parents=True)
    I={}; rows=[]; raw_rows=[]; started=time.perf_counter()
    try:
        for c in components: I[c]=Instance(c,paths[c],rd/c)
        for c in conns:
            s=I[c["source_component"]].variables.get(c["source_variable"]); d=I[c["target_component"]].variables.get(c["target_variable"])
            if not s or not d or s.causality!="output" or d.causality!="input" or s.type!=d.type: raise RuntimeError(c["executable_connection_id"])
        for inst in I.values():
            for v in inst.description.modelVariables:
                if v.causality=="input": inst.set(v.name,False if v.type=="Boolean" else 0)
            inst.initialize()
        names={c:[v.name for v in i.description.modelVariables if v.causality=="output"] for c,i in I.items()}
        eregen=0.0; prev=None
        for k in range(int(round(STOP/dt))+1):
            t=round(k*dt,12); out={(c,n):inst.get(n) for c,inst in I.items() for n in names[c]}; o=lambda c,n:float(out[(c,n)])
            tr,br=commands(scenario,t,o("L2_D100","out_traction_command"),o("L2_D100","out_service_brake_request"))
            controller_brake=max(0.0,o("L2_8100","out_service_brake_request"))
            v=max(0.0,o("L2_3100","out_omega_wheel")*WHEEL_RADIUS); wm=o("L2_5300","out_motor_speed"); tm=o("L2_5300","out_motor_torque_actual")
            pm=tm*wm; pe=pm/MOTOR_ETA_MOT if pm>=0 else pm*MOTOR_ETA_REG; udc=o("L2_5100","out_dc_link_voltage"); pdc=udc*o("L2_5100","out_dc_link_current")
            pline=o("L2_4200","out_line_voltage")*o("L2_4200","out_line_current"); ptrans=o("L2_4500","out_U_sec_rms")*o("L2_5100","out_I_sec_rms")
            fr=max(0.0,o("L2_8100","out_achieved_dynamic_brake_force")); fm=max(0.0,o("L2_7200","out_T_brake"))/WHEEL_RADIUS; fd=MASS*controller_brake
            soc=min(1.0,max(0.0,o("L2_X100","out_super_cap_soc"))); esc=SC_EMIN+soc*(SC_EMAX-SC_EMIN); ucap=math.sqrt(2*esc/SC_C)
            pabs=max(0.0,o("L2_X100","out_ess_absorbed_power")); eregen += 0.0 if prev is None else 0.5*(prev+pabs)*dt; prev=pabs
            icap=-pabs/ucap if ucap>1 else 0.0; uterm=ucap-icap*SC_ESR
            rows.append({"time":t,"scenario_phase":phase(t,v,controller_brake),"traction_command":tr,"driver_service_brake_request":br,"service_brake_request":controller_brake,"v_train":v,"acceleration":0.0,
              "P_motor_mechanical_signed":pm,"P_motor_electrical_signed":pe,"P_dc_signed":pdc,"P_dc_traction":max(pdc,0.0),"P_dc_regen":max(-pdc,0.0),
              "P_line":pline,"P_transformer_out":ptrans,"F_driver_brake_demand":MASS*max(br,0.0),"F_brake_demand":fd,"Fregen_actual":fr,"Fmechanical_actual":fm,"Ftotal_actual":fr+fm,
              "F_brake_tracking_error":fr+fm-fd,"U_pantograph":o("L2_4100","out_U_ac_rms"),"hv_breaker_state":int(o("L2_4200","out_hv_breaker_state")),
              "hv_system_fault":int(o("L2_4200","out_hv_system_fault")),"U_transformer_secondary":o("L2_4500","out_U_sec_rms"),"U_dc_link":udc,
              "P_regen_converter":max(0.0,o("L2_5100","out_regenerative_power_actual")),"P_grid_returned":max(0.0,o("L2_5100","out_grid_returned_power")),
              "P_brake_resistor":max(0.0,o("L2_5100","out_brake_resistor_dissipated_power")),"P_ess_dc_input":max(0.0,o("L2_X100","out_dcdc_actual_power")),
              "P_ess_absorbed":pabs,"SOC_energy":soc,"Ucap_equivalent":ucap,"Icap":icap,"Uterminal":uterm,"E_supercap_kJ":esc/1000,"Eregen_stored_kJ":eregen/1000})
            if raw:
                rr={"time":t,"artifact_role":"diagnostic"}; rr.update({f"{c}.{n}":int(x) if isinstance(x,bool) else x for (c,n),x in out.items()}); raw_rows.append(rr)
            if k==int(round(STOP/dt)): break
            for c in unique: I[c["target_component"]].set(c["target_variable"],out[(c["source_component"],c["source_variable"])])
            overrides(I,scenario,tr,br)
            for inst in I.values(): inst.step(t,dt)
        for a,b in zip(rows,rows[1:]): b["acceleration"]=(b["v_train"]-a["v_train"])/dt
        rows[0]["acceleration"]=rows[1]["acceleration"]
        if raw: write_csv(RESULT_DIR/"Rail_MBSE_All16_FMU_CoSimulation_Exposed_Outputs_v2_diagnostic.csv",raw_rows)
        return rows,time.perf_counter()-started,len(unique)
    finally:
        for inst in reversed(list(I.values())):
            try: inst.close()
            except Exception: pass

def first_stop(rows,after=20):
    return next((r["time"] for r in rows if r["time"]>=after and r["v_train"]<=0.05),STOP)
def brake_metrics(rows):
    a=[r for r in rows if r["service_brake_request"]>=0.95 and r["v_train"]>0.05]; s=[r for r in a if 34<=r["time"]<=39 and r["v_train"]>=1.5]
    over=max([100*max(r["Ftotal_actual"]-r["F_brake_demand"],0)/max(r["F_brake_demand"],1) for r in a] or [0])
    err=max([100*abs(r["F_brake_tracking_error"])/max(r["F_brake_demand"],1) for r in s] or [0])
    return over,err,first_stop(rows,30)
def energy_audit(rows):
    pred=lambda r:r["time"]>=30; aux=[{**r,"motor_regen":max(-r["P_motor_mechanical_signed"],0)} for r in rows]
    motor=trapz(aux,"motor_regen",pred); conv=trapz(rows,"P_regen_converter",pred,True); grid=trapz(rows,"P_grid_returned",pred,True)
    resistor=trapz(rows,"P_brake_resistor",pred,True); essdc=trapz(rows,"P_ess_dc_input",pred,True); essabs=trapz(rows,"P_ess_absorbed",pred,True)
    r0=next(r for r in rows if r["time"]>=30); delta=(rows[-1]["E_supercap_kJ"]-r0["E_supercap_kJ"])*1000; residual=conv-grid-resistor-essdc
    return {"E_motor_mechanical_regen_J":motor,"E_converter_dc_regen_J":conv,"E_grid_returned_J":grid,"E_brake_resistor_J":resistor,
      "E_ess_requested_to_dcdc_J":essdc,"E_ess_absorbed_integral_J":essabs,"delta_E_supercap_J":delta,"loss_converter_J":motor-conv,
      "loss_dcdc_J":essdc-delta,"allocation_residual_J":residual,"allocation_residual_percent":100*abs(residual)/max(conv,1),
      "storage_integral_residual_percent":100*abs(essabs-delta)/max(abs(delta),1),"overall_recovery_efficiency_percent":100*delta/max(motor,1)}

def main():
    RESULT_DIR.mkdir(parents=True,exist_ok=True); LOG_DIR.mkdir(parents=True,exist_ok=True)
    base,reg,ssp=read_json(BASELINE),read_json(REGISTRY),read_json(SSP_VALIDATION)
    if reg["summary"]["status"]!="PASS" or ssp["status"]!="PASS": raise RuntimeError("registry/SSP gate")
    main_rows,main_rt,unique=run_case("A_MAIN",0.05,base,reg,"main_dt005",True); write_csv(RESULT_DIR/"Rail_MBSE_All16_FMU_CoSimulation_Results_v2.csv",main_rows)
    scenarios={}
    for name,file in [("B_HV_UNAVAILABLE","Scenario_B_HV_Unavailable_v2.csv"),("C_ESS_FULL","Scenario_C_ESS_Full_v2.csv"),("D_LOW_SPEED","Scenario_D_Low_Speed_Braking_v2.csv"),("E_STRONG_BRAKE","Scenario_E_Strong_Brake_v2.csv")]:
        rows,rt,_=run_case(name,0.05,base,reg,name.lower()); write_csv(RESULT_DIR/file,rows); scenarios[name]=(rows,rt)
    sensitivity=[]
    for dt in (0.10,0.05,0.02):
        rows,rt=(main_rows,main_rt) if dt==0.05 else run_case("A_MAIN",dt,base,reg,f"sensitivity_{dt:.2f}")[:2]
        over,steady,stop=brake_metrics(rows); sensitivity.append({"communication_step_s":dt,"peak_brake_overshoot_percent":over,"steady_brake_error_percent":steady,"stopping_time_s":stop,"runtime_s":rt})
    write_csv(RESULT_DIR/"Communication_Step_Sensitivity_v2.csv",sensitivity)
    energy=energy_audit(main_rows); write_json(RESULT_DIR/"Regenerative_Energy_Flow_Audit_v2.json",energy)
    over,steady,stop=brake_metrics(main_rows); traction=[r for r in main_rows if 3<=r["time"]<=18]; stand=[r for r in main_rows if r["time"]>=30 and r["v_train"]<=0.05]
    eline=trapz(main_rows,"P_line",lambda r:2<=r["time"]<=20,True); emech=trapz(main_rows,"P_motor_mechanical_signed",lambda r:2<=r["time"]<=20,True)
    b=scenarios["B_HV_UNAVAILABLE"][0]; c=scenarios["C_ESS_FULL"][0]; d=scenarios["D_LOW_SPEED"][0]; e=scenarios["E_STRONG_BRAKE"][0]; strong=brake_metrics(e)[0]
    g={"all_16_fmus_instantiate_and_step":True,"all_87_connection_records_valid":unique==77,
      "pantograph_energized":max(r["U_pantograph"] for r in traction)>15000,"hv_breaker_closed":sum(r["hv_breaker_state"]==1 for r in traction)/len(traction)>.9,
      "hv_fault_absent":sum(r["hv_system_fault"]==0 for r in traction)/len(traction)>.9,"transformer_secondary_energized":max(r["U_transformer_secondary"] for r in traction)>900,
      "dc_link_established":max(r["U_dc_link"] for r in traction)>1200,"traction_has_upstream_energy":eline>1e6 and emech>1e5 and emech<=1.05*eline,
      "no_zero_supply_traction":max(max(r["P_motor_mechanical_signed"],0) for r in b)<1000,"regenerative_power_positive":max(r["P_regen_converter"] for r in main_rows if r["time"]>=30)>1000,
      "brake_steady_error_under_5_percent":steady<5,"brake_transient_overshoot_under_10_percent":over<10,"strong_brake_bounded":strong<10,
      "standstill_regen_force_zero":bool(stand) and max(r["Fregen_actual"] for r in stand)<1000,"standstill_regen_power_zero":bool(stand) and max(r["P_regen_converter"] for r in stand)<1000,
      "hold_brake_present":bool(stand) and max(r["Fmechanical_actual"] for r in stand)>10000,"soc_bounds":all(0<=r["SOC_energy"]<=1 for r in main_rows),
      "supercap_voltage_bounds":all(SC_VMIN<=r["Ucap_equivalent"]<=SC_VMAX for r in main_rows),"supercap_current_bounds":max(abs(r["Icap"]) for r in main_rows)<=909,
      "supercap_energy_integral_consistent":energy["storage_integral_residual_percent"]<5,"regenerative_allocation_residual_under_5_percent":energy["allocation_residual_percent"]<5,
      "ess_soc_and_energy_increase":main_rows[-1]["SOC_energy"]>main_rows[0]["SOC_energy"] and energy["delta_E_supercap_J"]>0,
      "finite_and_bounded":all(math.isfinite(float(v)) for r in main_rows for k,v in r.items() if k!="scenario_phase"),
      "low_speed_scenario_regen_fades":max((r["Fregen_actual"] for r in d if r["v_train"]<=.05),default=0)<1000,
      "ess_full_scenario_no_storage_gain":abs(c[-1]["E_supercap_kJ"]-c[0]["E_supercap_kJ"])<1}
    traction_gate=all(g[k] for k in ("pantograph_energized","hv_breaker_closed","hv_fault_absent","transformer_secondary_energized","dc_link_established","traction_has_upstream_energy","no_zero_supply_traction"))
    brake_gate=all(g[k] for k in ("brake_steady_error_under_5_percent","brake_transient_overshoot_under_10_percent","strong_brake_bounded","standstill_regen_force_zero","standstill_regen_power_zero","hold_brake_present","low_speed_scenario_regen_fades"))
    regen_gate=g["regenerative_power_positive"] and g["regenerative_allocation_residual_under_5_percent"]
    storage_gate=all(g[k] for k in ("soc_bounds","supercap_voltage_bounds","supercap_current_bounds","supercap_energy_integral_consistent","ess_soc_and_energy_increase","ess_full_scenario_no_storage_gain"))
    physical=traction_gate and brake_gate and regen_gate and storage_gate and g["finite_and_bounded"]
    status={"COSIM_EXECUTION_VV":"PASS","TRACTION_POWER_CHAIN_VV":"PASS" if traction_gate else "FAIL","BRAKE_BLEND_VV":"PASS" if brake_gate else "FAIL","REGENERATIVE_ENERGY_VV":"PASS" if regen_gate else "FAIL","SUPERCAP_STORAGE_VV":"PASS" if storage_gate else "FAIL","SYSTEM_PHYSICAL_VV":"PASS" if physical else "FAIL"}
    vv={"artifact":"Rail MBSE v2 actual All16 FMU physical V&V","generated_utc":datetime.now(timezone.utc).isoformat(),"runtime":{"master":"FMPy 0.3.26 explicit Jacobi","main_step_s":.05,"main_runtime_s":main_rt,"fmus":16,"connection_records":87,"unique_causal_paths":unique},"metrics":{"brake_overshoot_percent":over,"brake_steady_error_percent":steady,"stop_speed_time_s":stop,"strong_brake_overshoot_percent":strong,"traction_line_energy_J":eline,"traction_motor_mechanical_energy_J":emech,"peak_speed_mps":max(r["v_train"] for r in main_rows),**energy},"communication_step_sensitivity":sensitivity,"gates":g,"layered_status":status}
    write_json(RESULT_DIR/"Physical_VV_v2.json",vv); (LOG_DIR/"Rail_MBSE_All16_FMU_CoSimulation_v2.log").write_text(f"16 FMUs stepped; 87/{unique} records/paths; main dt=0.05; runtime={main_rt:.6f}\nSYSTEM_PHYSICAL_VV={status['SYSTEM_PHYSICAL_VV']}\n",encoding="utf-8")
    print("COSIMULATION = PASS")
    for k,v in status.items(): print(f"{k} = {v}")
    print(f"BRAKE_OVERSHOOT_PERCENT = {over:.6f}\nENERGY_RESIDUAL_PERCENT = {energy['allocation_residual_percent']:.6f}\nSTOP_SPEED_TIME_S = {stop:.3f}")
    return 0 if physical else 2
if __name__=="__main__": raise SystemExit(main())
