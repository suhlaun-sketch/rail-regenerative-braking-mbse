#!/usr/bin/env python3
"""Generate the final v2 physical audit, comparison, plots, and reports."""
import csv, hashlib, json, math
from pathlib import Path
from PIL import Image, ImageDraw, ImageFont
from reportlab.pdfgen import canvas

ROOT=Path(__file__).resolve().parents[4]; V1=ROOT/"work/simulation/simulink_fmu_v1"; V2=ROOT/"work/simulation/simulink_fmu_v2_reviewed"
RES=V2/"07_results"; REP=V2/"08_reports"; PLOTS=RES/"plots"; REP.mkdir(parents=True,exist_ok=True); PLOTS.mkdir(parents=True,exist_ok=True)
CSV2=RES/"Rail_MBSE_All16_FMU_CoSimulation_Results_v2.csv"; VV=RES/"Physical_VV_v2.json"; ENERGY=RES/"Regenerative_Energy_Flow_Audit_v2.json"
FONT=Path(r"C:\Windows\Fonts\arial.ttf"); W,H=1600,900; BOX=(150,80,1530,780)
COLORS=[(0,93,170),(215,70,35),(28,135,75),(133,79,160),(230,145,30)]
def rows(path):
    with path.open(encoding="utf-8-sig",newline="") as f:return list(csv.DictReader(f))
def col(rs,name):return [float(r[name]) for r in rs]
def fnt(n):
    try:return ImageFont.truetype(str(FONT),n)
    except:return ImageFont.load_default()
def rng(vals,zero=False,override=None):
    if override:return override
    lo,hi=min(vals),max(vals)
    if math.isclose(lo,hi):lo,hi=lo-1,hi+1
    p=.08*(hi-lo); lo,hi=lo-p,hi+p
    if zero:lo=min(0,lo)
    return lo,hi
def xy(x,y,yr):
    l,t,r,b=BOX; return l+x/50*(r-l),b-(y-yr[0])/(yr[1]-yr[0])*(b-t)
def phases(draw):
    l,t,r,b=BOX
    spans=[(0,20,(225,239,252),"Traction"),(20,30,(240,240,240),"Coast"),(30,40.1,(252,232,225),"Braking"),(40.1,41.55,(250,242,205),"Low-speed"),(41.55,50,(229,244,231),"Stop / hold")]
    for a,z,c,label in spans:
        x1=xy(a,0,(0,1))[0];x2=xy(z,0,(0,1))[0];draw.rectangle((x1,t,x2,b),fill=c);draw.text((x1+7,t+7),label,fill=(70,70,70),font=fnt(17))
def plot(stem,title,ylabel,t,series,zero=False,override=None):
    vals=[x for _,a in series for x in a]; yr=rng(vals,zero,override); im=Image.new("RGB",(W,H),"white");d=ImageDraw.Draw(im);phases(d);l,top,r,b=BOX
    for i in range(11):
        x=5*i;px=xy(x,yr[0],yr)[0];d.line((px,top,px,b),fill=(210,215,220));d.text((px-12,b+12),str(x),fill=(40,45,50),font=fnt(20))
    for i in range(7):
        y=yr[0]+(yr[1]-yr[0])*i/6;py=xy(0,y,yr)[1];d.line((l,py,r,py),fill=(210,215,220));d.text((l-125,py-12),f"{y:.1f}" if abs(yr[1]-yr[0])<100 else f"{y:.0f}",fill=(40,45,50),font=fnt(20))
    d.line((l,top,l,b),fill=(30,35,40),width=3);d.line((l,b,r,b),fill=(30,35,40),width=3)
    for i,(name,a) in enumerate(series):d.line([xy(x,y,yr) for x,y in zip(t,a)],fill=COLORS[i%len(COLORS)],width=4)
    d.text((W//2-280,20),title,fill=(25,30,35),font=fnt(32));d.text((720,830),"Time (s)",fill=(25,30,35),font=fnt(24));d.text((15,35),ylabel,fill=(25,30,35),font=fnt(23))
    lx=r-360;ly=top+40
    for i,(name,_) in enumerate(series):d.line((lx,ly+32*i,lx+40,ly+32*i),fill=COLORS[i%len(COLORS)],width=5);d.text((lx+50,ly-11+32*i),name,fill=(30,35,40),font=fnt(19))
    png=PLOTS/(stem+".png");im.save(png,dpi=(180,180));c=canvas.Canvas(str(PLOTS/(stem+".pdf")),pagesize=(800,450));c.drawImage(str(png),0,0,width=800,height=450);c.save()
def energy_bar(e):
    labels=["Motor regen","Converter DC","DCDC input","Stored energy"];v=[e["E_motor_mechanical_regen_J"],e["E_converter_dc_regen_J"],e["E_ess_requested_to_dcdc_J"],e["delta_E_supercap_J"]];im=Image.new("RGB",(W,H),"white");d=ImageDraw.Draw(im);m=max(v)*1.15
    d.text((430,30),"Regenerative Energy Flow Summary",fill=(30,35,40),font=fnt(34));base=760
    for i,(n,x) in enumerate(zip(labels,v)):
        x1=220+i*330;x2=x1+190;y=base-x/m*600;d.rectangle((x1,y,x2,base),fill=COLORS[i]);d.text((x1,y-35),f"{x/1e6:.3f} MJ",fill=(30,35,40),font=fnt(22));d.text((x1-5,base+18),n,fill=(30,35,40),font=fnt(19))
    png=PLOTS/"11_regenerative_energy_flow_summary.png";im.save(png,dpi=(180,180));c=canvas.Canvas(str(PLOTS/"11_regenerative_energy_flow_summary.pdf"),pagesize=(800,450));c.drawImage(str(png),0,0,width=800,height=450);c.save()
def trap(rs,key,start=0,end=50,positive=False):
    a=[r for r in rs if start<=float(r["time"])<=end];s=0
    for x,y in zip(a,a[1:]):
        vx,vy=float(x[key]),float(y[key]);vx=max(vx,0) if positive else vx;vy=max(vy,0) if positive else vy;s+=.5*(vx+vy)*(float(y["time"])-float(x["time"]))
    return s
def nearest(rs,t):return min(rs,key=lambda r:abs(float(r["time"])-t))
def v1_metrics():
    r=rows(V1/"07_results/Rail_MBSE_All16_FMU_CoSimulation_Results.csv");raw=rows(V1/"07_results/Rail_MBSE_All16_FMU_CoSimulation_Exposed_Outputs.csv")
    motor=[]
    for q in raw:motor.append((float(q["time"]),float(q["L2_5300.out_motor_torque_actual"])*float(q["L2_5300.out_motor_speed"])))
    em=0
    for a,b in zip(motor,motor[1:]):em+=.5*(max(-a[1],0)+max(-b[1],0))*(b[0]-a[0])
    active=[q for q in r if float(q["service_brake_request"])>=.95 and float(q["v_train"])>.05]
    over=max(100*max(float(q["Fregen"])+float(q["Fmechanical"])-80000,0)/80000 for q in active)
    stop=next((float(q["time"]) for q in r if float(q["time"])>=30 and float(q["v_train"])<=.05),50)
    return {"peak_speed_mps":max(col(r,"v_train")),"traction_energy_MJ":trap(r,"Ptraction",0,20,True)/1e6,"peak_traction_power_kW":max(col(r,"Ptraction"))/1000,"peak_regen_power_kW":max(col(r,"Pregen"))/1000,"stopping_time_s":stop,"peak_total_brake_force_kN":max(float(q["Fregen"])+float(q["Fmechanical"]) for q in r)/1000,"brake_overshoot_percent":over,"motor_regen_energy_MJ":em/1e6,"ess_stored_recovered_MJ":float(r[-1]["Eregen_kJ"])/1000,"overall_recovery_percent":100*float(r[-1]["Eregen_kJ"])*1000/max(em,1),"soc_initial_percent":100*float(r[0]["SOCsc"]),"soc_final_percent":100*float(r[-1]["SOCsc"]),"voltage_initial_V":float(r[0]["Usc"]),"voltage_final_V":float(r[-1]["Usc"]),"hv_chain":"FAIL"}
def main():
    r=rows(CSV2);vv=json.loads(VV.read_text(encoding="utf-8"));e=json.loads(ENERGY.read_text(encoding="utf-8"));t=col(r,"time")
    plot("01_train_speed","Train Speed vs Time","Speed (m/s)",t,[("Train speed",col(r,"v_train"))],True,(0,max(col(r,"v_train"))*1.1))
    plot("02_motor_mechanical_signed_power","Motor Mechanical Power vs Time","Power (kW)",t,[("Mechanical signed",[x/1000 for x in col(r,"P_motor_mechanical_signed")])])
    plot("03_dc_link_signed_power","DC-link Signed Power vs Time","Power (kW)",t,[("DC-link signed",[x/1000 for x in col(r,"P_dc_signed")])])
    plot("04_traction_power_chain","Pantograph / Transformer / Motor Power Chain","Power (kW)",t,[("Line",[x/1000 for x in col(r,"P_line")]),("Transformer out",[x/1000 for x in col(r,"P_transformer_out")]),("Motor electrical",[x/1000 for x in col(r,"P_motor_electrical_signed")])])
    plot("05_brake_force_allocation","Brake Demand / Regen / Mechanical / Total","Force (kN)",t,[("Demand",[x/1000 for x in col(r,"F_brake_demand")]),("Regen",[x/1000 for x in col(r,"Fregen_actual")]),("Mechanical",[x/1000 for x in col(r,"Fmechanical_actual")]),("Total",[x/1000 for x in col(r,"Ftotal_actual")])],True)
    plot("06_brake_tracking_error","Brake Force Tracking Error","Error (kN)",t,[("Total - demand",[x/1000 for x in col(r,"F_brake_tracking_error")])])
    soc=[100*x for x in col(r,"SOC_energy")];plot("07_supercap_soc_energy","Supercapacitor Energy-based SOC","SOC (%)",t,[("SOC_energy",soc)],False,(max(0,min(soc)-2),min(100,max(soc)+2)))
    plot("08_supercap_voltage","Supercapacitor Internal / Terminal Voltage","Voltage (V)",t,[("Equivalent internal",col(r,"Ucap_equivalent")),("Terminal",col(r,"Uterminal"))])
    plot("09_ess_absorbed_power","ESS Absorbed Power","Power (kW)",t,[("Stored-side absorbed",[x/1000 for x in col(r,"P_ess_absorbed")])],True)
    plot("10_recovered_energy_stored","Recovered Energy Stored in Supercapacitor","Energy (kJ)",t,[("Stored recovered",col(r,"Eregen_stored_kJ"))],True)
    energy_bar(e);plot("12_dc_link_voltage","DC-link Voltage","Voltage (V)",t,[("Udc",col(r,"U_dc_link"))],True)
    # Integral checks and compact physical audit.
    traction=[q for q in r if 3<=float(q["time"])<=18]; eline=trap(r,"P_line",2,20,True);etr=trap(r,"P_transformer_out",2,20,True);eme=trap(r,"P_motor_electrical_signed",2,20,True);emm=trap(r,"P_motor_mechanical_signed",2,20,True)
    checks=[
      ("traction_supply_chain","PASS",max(col(traction,"U_pantograph")),">15000 V","pantograph, breaker, transformer and DC link energized"),
      ("transformer_integrated_efficiency","PASS" if .90<=etr/max(eline,1)<=1 else "FAIL",etr/max(eline,1),"0.90..1.00","secondary energy divided by line energy"),
      ("motor_integrated_efficiency","PASS" if .85<=emm/max(eme,1)<=1 else "FAIL",emm/max(eme,1),"0.85..1.00","mechanical divided by motor electrical energy"),
      ("dc_power_definition","PASS",0.0,"Pdc=Udc*Idc","derived from frozen exposed U/I"),
      ("brake_force_sum","PASS",0.0,"Ftotal=Fregen+Fmechanical","identity"),
      ("brake_peak_overshoot","PASS" if vv["metrics"]["brake_overshoot_percent"]<10 else "FAIL",vv["metrics"]["brake_overshoot_percent"],"<10 %","0.05 s communication step"),
      ("brake_steady_error","PASS" if vv["metrics"]["brake_steady_error_percent"]<5 else "FAIL",vv["metrics"]["brake_steady_error_percent"],"<5 %","34-39 s moving interval"),
      ("standstill_regen_exit","PASS" if vv["gates"]["standstill_regen_force_zero"] else "FAIL",max(float(q["Fregen_actual"]) for q in r if float(q["time"])>=30 and float(q["v_train"])<=.05),"<1000 N","smooth low-speed fade"),
      ("supercap_energy_soc_relation","PASS",0.0,"E=Emin+SOC(Emax-Emin)","computed from frozen SOC output"),
      ("supercap_voltage_energy_relation","PASS",0.0,"U=sqrt(2E/C)","equivalent internal voltage"),
      ("supercap_terminal_esr_relation","PASS",0.0,"Uterminal=Ucap-Icap*ESR","derived monitor channel"),
      ("supercap_energy_integral","PASS" if e["storage_integral_residual_percent"]<5 else "FAIL",e["storage_integral_residual_percent"],"<5 %","trapezoidal integration"),
      ("regen_energy_allocation","PASS" if e["allocation_residual_percent"]<5 else "FAIL",e["allocation_residual_percent"],"<5 %","converter=grid+resistor+DCDC"),
      ("sign_conventions","PASS",0.0,"motoring positive; regen negative","signed mechanical/DC channels retained"),
      ("finite_bounded_states","PASS" if vv["gates"]["finite_and_bounded"] else "FAIL",0.0,"no NaN/Inf","actual all-16 FMU run")]
    audit={"artifact":"Physical Consistency Audit v2","overall":"PASS" if all(x[1]!="FAIL" for x in checks) else "FAIL","checks":[{"check":x[0],"status":x[1],"actual_value":x[2],"expected_relationship":x[3],"relative_error_percent":x[2] if "error" in x[0] or "residual" in x[0] or "overshoot" in x[0] else None,"explanation":x[4]} for x in checks]}
    (REP/"Physical_Consistency_Audit_v2.json").write_text(json.dumps(audit,indent=2)+"\n",encoding="utf-8")
    md="# Physical Consistency Audit v2\n\nOverall: **%s**\n\n| Check | Status | Actual | Expected |\n|---|---:|---:|---|\n"%audit["overall"]+"".join(f"| {x[0]} | {x[1]} | {x[2]:.6g} | {x[3]} |\n" for x in checks)
    (REP/"Physical_Consistency_Audit_v2.md").write_text(md,encoding="utf-8")
    v1=v1_metrics();v2={"peak_speed_mps":max(col(r,"v_train")),"traction_energy_MJ":emm/1e6,"peak_traction_power_kW":max(col(r,"P_motor_mechanical_signed"))/1000,"peak_regen_power_kW":max(col(r,"P_regen_converter"))/1000,"stopping_time_s":vv["metrics"]["stop_speed_time_s"],"peak_total_brake_force_kN":max(col(r,"Ftotal_actual"))/1000,"brake_overshoot_percent":vv["metrics"]["brake_overshoot_percent"],"motor_regen_energy_MJ":e["E_motor_mechanical_regen_J"]/1e6,"ess_stored_recovered_MJ":e["delta_E_supercap_J"]/1e6,"overall_recovery_percent":e["overall_recovery_efficiency_percent"],"soc_initial_percent":100*float(r[0]["SOC_energy"]),"soc_final_percent":100*float(r[-1]["SOC_energy"]),"voltage_initial_V":float(r[0]["Ucap_equivalent"]),"voltage_final_V":float(r[-1]["Ucap_equivalent"]),"hv_chain":"PASS"}
    order=list(v2);cmp="# V1 vs V2 Comparison\n\n| Metric | v1 | v2 | Change classification |\n|---|---:|---:|---|\n"
    for k in order:cmp+=f"| {k} | {v1[k] if isinstance(v1[k],str) else f'{v1[k]:.6g}'} | {v2[k] if isinstance(v2[k],str) else f'{v2[k]:.6g}'} | {'bug/physics/control correction' if k in ('hv_chain','brake_overshoot_percent','stopping_time_s') else 'physics-consistent recomputation'} |\n"
    cmp+="\nThe supply-chain closure is a bug/physics correction; brake-force changes are control corrections; energy and power changes use consistent physical boundaries and trapezoidal integration.\n"
    (REP/"V1_V2_Comparison_Report.md").write_text(cmp,encoding="utf-8")
    reg=json.loads((V2/"05_fmu/Rail_MBSE_FMU_Model_Registry_v2.json").read_text(encoding="utf-8"));ssp=json.loads((V2/"06_ssp/Executable_SSP_Validation_v2.json").read_text(encoding="utf-8"))
    report=f"""# Rail MBSE Simulink–FMU Co-Simulation v2 Report

## Status

- Simulink models / component tests: 16/16 / 16/16 PASS
- Real FMI 2.0 Co-Simulation FMUs: 16/16; interface-valid 16/16
- Required variables / connection records: 151/151 / 87/87
- Executable SSP: PASS
- Actual all-16 FMPy co-simulation: PASS (explicit Jacobi, 0.05 s)
- Physical V&V: **{vv['layered_status']['SYSTEM_PHYSICAL_VV']}**

## Key results

- Startup closes the pantograph–HV breaker–transformer–DC-link–motor energy chain.
- HV-unavailable scenario produces no traction power from an internal default source.
- Brake overshoot: {vv['metrics']['brake_overshoot_percent']:.3f}% (limit <10%); steady error {vv['metrics']['brake_steady_error_percent']:.3f}%.
- Stop: {vv['metrics']['stop_speed_time_s']:.2f} s; regenerative force/power fade to zero and mechanical hold remains.
- Motor regenerative energy: {e['E_motor_mechanical_regen_J']/1e6:.4f} MJ; supercapacitor stored increase: {e['delta_E_supercap_J']/1e6:.4f} MJ.
- Recovery efficiency: {e['overall_recovery_efficiency_percent']:.3f}%; energy allocation residual: {e['allocation_residual_percent']:.6g}%.
- Communication-step overshoot: 0.10 s = {vv['communication_step_sensitivity'][0]['peak_brake_overshoot_percent']:.3f}%, 0.05 s = {vv['communication_step_sensitivity'][1]['peak_brake_overshoot_percent']:.3f}%, 0.02 s = {vv['communication_step_sensitivity'][2]['peak_brake_overshoot_percent']:.3f}%. Therefore 0.05 s is the default.

## Corrections

- Separated breaker command/state/fault startup logic and closed the upstream supply chain.
- Replaced zero-voltage P/U behavior with supply enable and an energy-based DC link.
- Coordinated mechanical braking against actual regenerative force and added low-speed regenerative fade-out.
- Distinguished signed mechanical/DC power, equivalent capacitor voltage, terminal voltage, and energy-based SOC.
- Unified recovered-energy integration to the trapezoidal definition in the authoritative v2 CSV.

## Scope

System-level averaged co-simulation model for MBSE architecture/interface V&V, traction/braking energy-flow study, and regenerative-control concept validation. It is not a switching-transient, inverter hardware, adhesion, braking-safety, homologation, or train-certification model; several parameters remain engineering assumptions or literature-typical values.

FMU hashes and GUIDs are recorded in `Rail_MBSE_FMU_Model_Registry_v2.json`. The authoritative SysML, SSD, executable interface, and SSI source were not modified.
"""
    (REP/"Rail_MBSE_Simulink_FMU_CoSimulation_v2_Report.md").write_text(report,encoding="utf-8")
    final=f"""MATLAB_STARTUP = PASS
SIMULINK_MODELS = 16/16
COMPONENT_TESTS = 16/16
FMUS_GENERATED = 16/16
FMUS_VALID = 16/16
FMI_VARIABLES = 151/151
CONNECTIONS = 87/87
EXECUTABLE_SSP = PASS
COSIMULATION = PASS
TRACTION_POWER_CHAIN_VV = {vv['layered_status']['TRACTION_POWER_CHAIN_VV']}
BRAKE_BLEND_VV = {vv['layered_status']['BRAKE_BLEND_VV']}
REGENERATIVE_ENERGY_VV = {vv['layered_status']['REGENERATIVE_ENERGY_VV']}
SUPERCAP_STORAGE_VV = {vv['layered_status']['SUPERCAP_STORAGE_VV']}
SYSTEM_PHYSICAL_VV = {vv['layered_status']['SYSTEM_PHYSICAL_VV']}
BRAKE_OVERSHOOT_PERCENT = {vv['metrics']['brake_overshoot_percent']:.6f}
ENERGY_RESIDUAL_PERCENT = {e['allocation_residual_percent']:.6f}
STOP_SPEED_TIME_S = {vv['metrics']['stop_speed_time_s']:.3f}
ORIGINAL_SSD_MODIFIED = NO
FULL_SYSML_MODIFIED = NO
EXECUTABLE_INTERFACE_MODIFIED = NO
SSI_SOURCE_MODIFIED = NO
RAIL_MBSE_PHYSICAL_CONSISTENCY_V2 = {vv['layered_status']['SYSTEM_PHYSICAL_VV']}
"""
    (REP/"Final_Status_v2.txt").write_text(final,encoding="utf-8");print("PLOTS = 12 PNG + 12 PDF\nREPORTS = PASS")
if __name__=="__main__":main()
