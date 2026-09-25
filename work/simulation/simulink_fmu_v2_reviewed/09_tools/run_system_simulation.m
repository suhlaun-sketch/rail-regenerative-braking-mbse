function run_system_simulation(projectRoot)
%RUN_SYSTEM_SIMULATION Execute the integrated traction-to-regeneration scenario.
baseDir=fullfile(projectRoot,'work','simulation','simulink_fmu_v2_reviewed');
modelDir=fullfile(baseDir,'01_models'); integrationDir=fullfile(baseDir,'04_system_integration');
resultDir=fullfile(baseDir,'07_results'); reportDir=fullfile(baseDir,'08_reports');
if ~exist(resultDir,'dir'), mkdir(resultDir); end
if ~exist(reportDir,'dir'), mkdir(reportDir); end
addpath(modelDir,integrationDir,fullfile(baseDir,'02_parameters'));
[P,~]=Rail_MBSE_Simulation_Parameters_v2();
model='Rail_MBSE_All16_Integrated_v2'; load_system(fullfile(integrationDir,[model '.slx']));
set_param(model,'SimulationCommand','update');
simIn=Simulink.SimulationInput(model).setModelParameter('StopTime','50','CaptureErrors','on');
tic; simOut=sim(simIn); runtime=toc;
if ~isempty(simOut.ErrorMessage), error('%s',simOut.ErrorMessage); end
t=simOut.tout(:);
omegaWheel=signal(simOut,'mon_L2_3100_out_omega_wheel');
Udc=signal(simOut,'mon_L2_5100_out_dc_link_voltage');
Idc=signal(simOut,'mon_L2_5100_out_dc_link_current');
Pregen=signal(simOut,'mon_L2_5100_out_regenerative_power_actual');
motorSpeed=signal(simOut,'mon_L2_5300_out_motor_speed');
motorTorque=signal(simOut,'mon_L2_5300_out_motor_torque_actual');
Tbrake=signal(simOut,'mon_L2_7200_out_T_brake');
Fregen=signal(simOut,'mon_L2_8100_out_achieved_dynamic_brake_force');
SOCsc=signal(simOut,'mon_L2_X100_out_super_cap_soc');
Pess=signal(simOut,'mon_L2_X100_out_ess_absorbed_power');
tractionCommand=signal(simOut,'mon_L2_D100_out_traction_command');
serviceBrake=signal(simOut,'mon_L2_D100_out_service_brake_request');
n=min([numel(t),numel(omegaWheel),numel(Udc),numel(Idc),numel(Pregen), ...
    numel(motorSpeed),numel(motorTorque),numel(Tbrake),numel(Fregen), ...
    numel(SOCsc),numel(Pess),numel(tractionCommand),numel(serviceBrake)]);
t=t(1:n); omegaWheel=omegaWheel(1:n); Udc=Udc(1:n); Idc=Idc(1:n);
Pregen=Pregen(1:n); motorSpeed=motorSpeed(1:n); motorTorque=motorTorque(1:n);
Tbrake=Tbrake(1:n); Fregen=Fregen(1:n); SOCsc=SOCsc(1:n); Pess=Pess(1:n);
tractionCommand=tractionCommand(1:n); serviceBrake=serviceBrake(1:n);

v_train=P.vehicle.wheel_radius_m*omegaWheel;
Pmech=motorTorque.*motorSpeed;
Ptraction=max(Pmech,0);
Pdc=Udc.*Idc;
Fmechanical=max(Tbrake,0)/P.vehicle.wheel_radius_m;
Emin=0.5*P.supercap.capacitance_F*P.supercap.voltage_min_V^2;
Emax=0.5*P.supercap.capacitance_F*P.supercap.voltage_max_V^2;
Esc=Emin+SOCsc*(Emax-Emin);
Usc=sqrt(max(0,2*Esc/P.supercap.capacitance_F));
Esc_kJ=Esc/1000;
Eregen_kJ=cumtrapz(max(Pess,0))*P.sample_time_s/1000;

R=table(t,v_train,Ptraction,Pregen,Fregen,Fmechanical,Pdc,Usc,SOCsc,Esc_kJ,Eregen_kJ, ...
    tractionCommand,serviceBrake,'VariableNames',{'time','v_train','Ptraction','Pregen', ...
    'Fregen','Fmechanical','Pdc','Usc','SOCsc','Esc_kJ','Eregen_kJ','traction_command','service_brake_request'});
writetable(R,fullfile(resultDir,'Rail_MBSE_All16_Integrated_Diagnostic_v2.csv'));
save(fullfile(resultDir,'Rail_MBSE_All16_Integrated_Diagnostic_v2.mat'),'R','runtime','P');

v5=sampleAt(t,v_train,5); v20=sampleAt(t,v_train,20); v30=sampleAt(t,v_train,30); v45=sampleAt(t,v_train,45);
soc30=sampleAt(t,SOCsc,30); soc45=sampleAt(t,SOCsc,45);
deltaE=sampleAt(t,Esc,45)-sampleAt(t,Esc,30);
absorbedE=trapz(t(t>=30 & t<=45),max(Pess(t>=30 & t<=45),0));
energyError=abs(deltaE-absorbedE)/max(absorbedE,1);
checks=struct();
checks.acceleration = v20 > v5+2;
checks.braking_deceleration = v45 < v30-2;
checks.regen_power_direction = min(Pregen)>-1e-9 && max(Pregen)>1000;
checks.supercap_charging = soc45 > soc30+1e-4;
checks.soc_bounds = min(SOCsc)>=-1e-9 && max(SOCsc)<=1+1e-9;
checks.mechanical_brake_supplement = max(Fmechanical(t>=30))>100;
checks.finite = all(isfinite(R{:,:}),'all');
checks.power_plausibility = max(abs([Ptraction;Pregen;Pdc;Pess])) < 2e6;
checks.energy_balance = energyError < 0.08;
names=fieldnames(checks); passed=all(structfun(@(x)logical(x),checks));
metrics=struct('runtime_s',runtime,'v5_mps',v5,'v20_mps',v20,'v30_mps',v30,'v45_mps',v45, ...
    'peak_traction_power_W',max(Ptraction),'peak_regen_power_W',max(Pregen), ...
    'peak_mechanical_force_N',max(Fmechanical),'soc_initial',SOCsc(1),'soc_30s',soc30,'soc_45s',soc45, ...
    'recovered_energy_kJ',Eregen_kJ(end),'energy_balance_relative_error',energyError);
vv=struct('scenario','0-20 s traction; 20-30 s coast; 30-45 s regenerative braking; 45-50 s stop hold', ...
    'checks',checks,'metrics',metrics,'status',ternary(passed,'PASS','FAIL'));
fid=fopen(fullfile(reportDir,'Rail_MBSE_Integration_Test_v2.json'),'w'); assert(fid>=0,'Cannot write V&V JSON.');
fprintf(fid,'%s',jsonencode(vv,PrettyPrint=true)); fclose(fid);
plotResults(resultDir,R);
writeReport(fullfile(reportDir,'Rail_MBSE_Integration_Test_v2.md'),vv,names);
close_system(model,0);
fprintf('SYSTEM_SIMULATION_RUNTIME_S = %.3f\n',runtime);
fprintf('SYSTEM_VV_STATUS = %s\n',vv.status);
if ~passed, error('System V&V gate failed.'); end
end

function x=signal(simOut,name)
ts=simOut.get(name); x=double(squeeze(ts.Data)); x=x(:);
end

function y=sampleAt(t,x,time)
[~,i]=min(abs(t-time)); y=x(i);
end

function value=ternary(condition,a,b)
if condition, value=a; else, value=b; end
end

function plotResults(resultDir,R)
specs={
    '01_train_speed','Train Speed vs Time','Speed (m/s)',R.v_train,[];
    '02_traction_regen_power','Traction / Regenerative Power','Power (kW)',R.Ptraction/1000,R.Pregen/1000;
    '03_supercapacitor_voltage','Supercapacitor Voltage','Voltage (V)',R.Usc,[];
    '04_supercapacitor_soc','Supercapacitor SOC','SOC (1)',R.SOCsc,[];
    '05_recovered_energy','Recovered Energy','Energy (kJ)',R.Eregen_kJ,[];
    '06_regen_mechanical_braking','Regenerative vs Mechanical Braking Force','Force (kN)',R.Fregen/1000,R.Fmechanical/1000};
for i=1:size(specs,1)
    f=figure('Visible','off','Color','w','Position',[100 100 1000 520]);
    plot(R.time,specs{i,4},'LineWidth',1.7); hold on;
    if ~isempty(specs{i,5}), plot(R.time,specs{i,5},'LineWidth',1.7); legend('Primary','Secondary','Location','best'); end
    grid on; xlabel('Time (s)'); ylabel(specs{i,3}); title(specs{i,2}); xlim([R.time(1) R.time(end)]);
    exportgraphics(f,fullfile(resultDir,[specs{i,1} '.png']),'Resolution',180);
    exportgraphics(f,fullfile(resultDir,[specs{i,1} '.pdf']),'ContentType','vector'); close(f);
end
end

function writeReport(path,vv,names)
fid=fopen(path,'w'); assert(fid>=0,'Cannot write V&V report.'); c=onCleanup(@()fclose(fid));
fprintf(fid,'# Rail MBSE System V&V Report\n\n');
fprintf(fid,'Scenario: %s.\n\n',vv.scenario);
fprintf(fid,'Overall status: **%s**\n\n',vv.status);
fprintf(fid,'| Check | Result |\n|---|---|\n');
for i=1:numel(names), fprintf(fid,'| %s | %s |\n',names{i},string(vv.checks.(names{i}))); end
fprintf(fid,'\n## Key metrics\n\n');
metrics=fieldnames(vv.metrics);
for i=1:numel(metrics), fprintf(fid,'- %s: %.9g\n',metrics{i},vv.metrics.(metrics{i})); end
fprintf(fid,'\nThe energy balance compares supercapacitor stored-energy increase with integrated exposed absorbed power during the braking interval.\n');
end
