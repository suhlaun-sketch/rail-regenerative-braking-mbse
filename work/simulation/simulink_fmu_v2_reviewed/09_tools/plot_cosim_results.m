function plot_cosim_results()
% Plot only the results produced by the actual 16-FMU co-simulation run.
thisFile = mfilename('fullpath');
workRoot = fileparts(fileparts(thisFile));
resultDir = fullfile(workRoot,'07_results');
csvFile = fullfile(resultDir,'Rail_MBSE_All16_FMU_CoSimulation_Results.csv');
plotDir = fullfile(resultDir,'fmu_cosim_plots');
if ~isfolder(plotDir), mkdir(plotDir); end
T = readtable(csvFile,'VariableNamingRule','preserve');

makePlot(T.time,T.v_train/3.6*3.6, ...
    'Train Speed vs Time','Time (s)','Train speed (m/s)', ...
    fullfile(plotDir,'01_train_speed'));

f = newFigure();
plot(T.time,T.Ptraction/1e3,'LineWidth',1.6); hold on;
plot(T.time,T.Pregen/1e3,'LineWidth',1.6);
formatAxes('Traction / Regenerative Power vs Time','Time (s)','Power (kW)');
legend({'Traction power','Regenerative power'},'Location','best');
saveBoth(f,fullfile(plotDir,'02_traction_regen_power'));

makePlot(T.time,T.Usc,'Supercapacitor Voltage vs Time','Time (s)','Voltage (V)', ...
    fullfile(plotDir,'03_supercapacitor_voltage'));
makePlot(T.time,100*T.SOCsc,'Supercapacitor SOC vs Time','Time (s)','SOC (%)', ...
    fullfile(plotDir,'04_supercapacitor_soc'));
makePlot(T.time,T.Eregen_kJ,'Recovered Energy vs Time','Time (s)','Recovered energy (kJ)', ...
    fullfile(plotDir,'05_recovered_energy'));

f = newFigure();
plot(T.time,T.Fregen/1e3,'LineWidth',1.6); hold on;
plot(T.time,T.Fmechanical/1e3,'LineWidth',1.6);
formatAxes('Regenerative vs Mechanical Braking Force','Time (s)','Force (kN)');
legend({'Regenerative braking','Mechanical braking'},'Location','best');
saveBoth(f,fullfile(plotDir,'06_regen_mechanical_braking'));

fprintf('FMU_COSIM_PLOTS = 6/6 PNG + 6/6 PDF\n');
end

function makePlot(x,y,titleText,xText,yText,fileBase)
f = newFigure();
plot(x,y,'LineWidth',1.6);
formatAxes(titleText,xText,yText);
saveBoth(f,fileBase);
end

function f = newFigure()
f = figure('Visible','off','Color','w','Position',[100 100 1000 560]);
end

function formatAxes(titleText,xText,yText)
grid on; box on;
xlabel(xText); ylabel(yText); title(titleText);
set(gca,'FontName','Arial','FontSize',11,'LineWidth',0.8);
xlim([0 50]);
end

function saveBoth(f,fileBase)
exportgraphics(f,[fileBase '.png'],'Resolution',180);
exportgraphics(f,[fileBase '.pdf'],'ContentType','vector');
close(f);
end
