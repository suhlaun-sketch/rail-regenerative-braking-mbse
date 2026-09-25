%% Build Rail_RegenerativeBraking_SC_v1 from the verified PMSM baseline
% This file intentionally builds and saves the model in stages. It does not
% modify PMSM_PI_decomposition.slx or PMSM_PI_decomposition_baseline.slx.

projectRoot = fileparts(fileparts(mfilename('fullpath')));
baselineFile = fullfile(projectRoot, 'models', ...
    'PMSM_PI_decomposition_baseline.slx');
targetFile = fullfile(projectRoot, 'models', ...
    'Rail_RegenerativeBraking_SC_v1.slx');
parameterFile = fullfile(projectRoot, 'config', 'SC_v1_parameters.m');

assert(isfile(baselineFile), 'Baseline model not found: %s', baselineFile);
assert(isfile(parameterFile), 'Parameter file not found: %s', parameterFile);
run(parameterFile);
assignin('base', 'SCv1', SCv1);
assignin('base', 'Ts', Ts);

requiredLibraries = {
    'spspowerguiLib/powergui'
    'spsCurrentMeasurementLib/Current Measurement'
    'spsVoltageMeasurementLib/Voltage Measurement'
    'spsSeriesRLCBranchLib/Series RLC Branch'
    'spsControlledCurrentSourceLib/Controlled Current Source'
    'spsDiodeLib/Diode'};
for libraryIndex = 1:numel(requiredLibraries)
    libraryModel = extractBefore(requiredLibraries{libraryIndex}, '/');
    assert(~isempty(which(libraryModel)), ...
        'Required SPS library is unavailable: %s', libraryModel);
    load_system(libraryModel);
    assert(getSimulinkBlockHandle(requiredLibraries{libraryIndex}) > 0, ...
        'Required SPS block is unavailable: %s', ...
        requiredLibraries{libraryIndex});
    fprintf('Discovered SPS block: %s\n', requiredLibraries{libraryIndex});
end

%% Stage 1 - clone the baseline
modelName = 'Rail_RegenerativeBraking_SC_v1';
baselineName = 'PMSM_PI_decomposition_baseline';
if bdIsLoaded(modelName)
    close_system(modelName, 0);
end
load_system(baselineFile);
save_system(baselineName, targetFile);
fprintf('Stage 1 saved: %s\n', targetFile);

%% Stage 2 - preserve and expose the existing traction drive
buildTractionDrive(modelName);
save_system(modelName);
fprintf('Stage 2 saved: TractionDrive\n');

%% Stage 3 - vehicle dynamics and mechanical brake
buildVehicleDynamics(modelName);
buildMechanicalBrake(modelName);
save_system(modelName);
fprintf('Stage 3 saved: VehicleDynamics and MechanicalBrake\n');

%% Stage 4 - DC bus with source blocking and aggregate drive power
buildDCBus(modelName);
save_system(modelName);
fprintf('Stage 4 saved: DCBus\n');

%% Stages 5 and 6 - physical supercapacitor and average bidirectional DC/DC
buildSuperCapBranch(modelName);
save_system(modelName);
fprintf('Stages 5-6 saved: Supercapacitor and BidirectionalDCDC_SC\n');

%% Stage 7 - test scenario and traction/brake supervisor
buildTestScenario(modelName);
buildSupervisor(modelName);
save_system(modelName);
fprintf('Stage 7 saved: TestScenario and TractionBrakeSupervisor\n');

%% Stages 8 and 9 - connect the full vehicle and energy paths
connectTopLevel(modelName);
buildEnergyAccounting(modelName);
buildMeasurements(modelName);
save_system(modelName);
fprintf('Stages 8-9 saved: full vehicle, EnergyAccounting, Measurements\n');

%% Stages 10 and 11 - update, validate and save
applyModelConfiguration(modelName, projectRoot);
set_param(modelName, 'SimulationCommand', 'update');
arrangeTopLevel(modelName);
save_system(modelName, targetFile);
fprintf('Stage 10 update succeeded. Final model saved: %s\n', targetFile);


function buildTractionDrive(modelName)
scopeNames = {'Nr', 'iabc', 'id/iq', '实际转矩Te', '电压', '电流', ...
    '给定转矩Te3'};
for blockIndex = 1:numel(scopeNames)
    scopeHandle = getChildBlockHandle(modelName, scopeNames{blockIndex});
    if scopeHandle > 0
        delete_block(scopeHandle);
    end
end

excluded = {'DC Voltage Source', 'Series RLC Branch', ...
    'Series RLC Branch1', 'Current Measurement', ...
    'Voltage Measurement', 'powergui'};
blockNames = get_param(modelName, 'Blocks');
driveHandles = [];
for blockIndex = 1:numel(blockNames)
    if ~ismember(blockNames{blockIndex}, excluded)
        blockHandle = getChildBlockHandle(modelName, blockNames{blockIndex});
        if blockHandle > 0
            driveHandles(end + 1) = blockHandle; %#ok<AGROW>
        end
    end
end
Simulink.BlockDiagram.createSubsystem(driveHandles, ...
    'Name', 'TractionDrive', 'MakeNameUnique', 'off');
tractionDrive = [modelName '/TractionDrive'];

obsolete = {'Error', 'mec', 'Out2', 'Out3', 'D', 'Te', 'Iabc', ...
    'id/iq', 'TL', 'TL1', 'TL2', 'TL3', 'Add4', 'Add3', '转速', ...
    'Add1', 'Constant1'};
for blockIndex = 1:numel(obsolete)
    deleteIfPresent([tractionDrive '/' obsolete{blockIndex}]);
end

% Rebuild the d-axis error path.
add_block('simulink/Sources/Constant', [tractionDrive '/Id_ref'], ...
    'Position', [80 430 120 450], 'Value', '0');
add_block('simulink/Math Operations/Sum', [tractionDrive '/Id_Error'], ...
    'Position', [190 420 220 460], 'Inputs', '+-');
connectSignal(tractionDrive, [tractionDrive '/Id_ref'], 1, ...
    [tractionDrive '/Id_Error'], 1);
connectSignal(tractionDrive, [tractionDrive '/Plark'], 1, ...
    [tractionDrive '/Id_Error'], 2);
clearInputLine([tractionDrive '/Id'], 1);
connectSignal(tractionDrive, [tractionDrive '/Id_Error'], 1, ...
    [tractionDrive '/Id'], 1);

% Torque command directly supplies the q-axis current reference.
add_block('simulink/Ports & Subsystems/In1', ...
    [tractionDrive '/Tmotor_ref'], 'Position', [60 330 90 350], ...
    'Port', '1');
add_block('simulink/Math Operations/Gain', ...
    [tractionDrive '/Torque_to_Iq'], 'Position', [130 320 190 360], ...
    'Gain', '1/SCv1.motor.Kt');
clearInputLine([tractionDrive '/Add2'], 1);
connectSignal(tractionDrive, [tractionDrive '/Tmotor_ref'], 1, ...
    [tractionDrive '/Torque_to_Iq'], 1);
connectSignal(tractionDrive, [tractionDrive '/Torque_to_Iq'], 1, ...
    [tractionDrive '/Add2'], 1);

machine = find_system(tractionDrive, 'SearchDepth', 1, ...
    'MaskType', 'Permanent Magnet Synchronous Machine');
assert(numel(machine) == 1, 'Expected one PMSM in TractionDrive.');
clearInputLine(machine{1}, 1);
add_block('simulink/Ports & Subsystems/In1', ...
    [tractionDrive '/Tload_Nm'], 'Position', [60 110 90 130], ...
    'Port', '2');
connectSignal(tractionDrive, [tractionDrive '/Tload_Nm'], 1, ...
    machine{1}, 1);
set_param(machine{1}, 'Mechanical', ...
    '[SCv1.motor.J_equivalent SCv1.motor.B_motor 4]');

% Use measured DC voltage in the existing SVPWM calculation.
svpwm = [tractionDrive '/SVPWM'];
deleteIfPresent([svpwm '/Vdc']);
add_block('simulink/Ports & Subsystems/In1', [svpwm '/Udc'], ...
    'Position', [65 285 95 305], 'Port', '3');
xyz = [svpwm '/XYZ' newline 'Caculate'];
clearInputLine(xyz, 4);
connectSignal(svpwm, [svpwm '/Udc'], 1, xyz, 4);
add_block('simulink/Ports & Subsystems/In1', ...
    [tractionDrive '/Udc'], 'Position', [60 250 90 270], 'Port', '3');
connectSignal(tractionDrive, [tractionDrive '/Udc'], 1, svpwm, 3);

% Measure single-drive DC current on the positive inverter rail.
positivePort = findPmioByPort(tractionDrive, 1);
clearPhysicalPortLine(positivePort, 'RConn', 1);
add_block('spsCurrentMeasurementLib/Current Measurement', ...
    [tractionDrive '/Idc_Unit_Measurement'], ...
    'Position', [830 100 870 140]);
bridge = [tractionDrive '/Universal Bridge'];
connectPhysical(tractionDrive, positivePort, 'RConn', 1, ...
    [tractionDrive '/Idc_Unit_Measurement'], 'LConn', 1);
connectPhysical(tractionDrive, ...
    [tractionDrive '/Idc_Unit_Measurement'], 'RConn', 1, ...
    bridge, 'RConn', 1);

outputNames = {'Te', 'omega_m', 'Iabc', 'id', 'iq', 'Idc_unit'};
for outputIndex = 1:numel(outputNames)
    add_block('simulink/Ports & Subsystems/Out1', ...
        [tractionDrive '/' outputNames{outputIndex}], ...
        'Position', [1120 50 + 55 * outputIndex 1150 70 + 55 * outputIndex], ...
        'Port', num2str(outputIndex));
end
muxBlock = [tractionDrive '/Mux'];
parkBlock = [tractionDrive '/Plark'];
connectSignal(tractionDrive, muxBlock, 1, [tractionDrive '/Te'], 1);
connectSignal(tractionDrive, muxBlock, 4, [tractionDrive '/omega_m'], 1);
connectSignal(tractionDrive, muxBlock, 3, [tractionDrive '/Iabc'], 1);
connectSignal(tractionDrive, parkBlock, 1, [tractionDrive '/id'], 1);
connectSignal(tractionDrive, parkBlock, 2, [tractionDrive '/iq'], 1);
connectSignal(tractionDrive, [tractionDrive '/Idc_Unit_Measurement'], 1, ...
    [tractionDrive '/Idc_unit'], 1);

switchBlock = [tractionDrive '/SVPWM/T1T1' newline ...
    'Caculate/Multiport Switch1'];
if getSimulinkBlockHandle(switchBlock) > 0
    set_param(switchBlock, 'DiagnosticForDefault', 'None');
end
set_param(tractionDrive, 'BackgroundColor', 'lightBlue');
end


function buildVehicleDynamics(modelName)
subsystem = [modelName '/VehicleDynamics'];
createEmptySubsystem(subsystem, [950 210 1170 455]);
inputNames = {'omega_m', 'Te', 'Fmechanical', 'grade', 'mu', 'mass'};
outputNames = {'v_train', 'Fmotor', 'Fresistance', ...
    'Fadhesion_max', 'Tload'};
addSignalPorts(subsystem, inputNames, outputNames);

functionBlock = [subsystem '/Longitudinal_Dynamics'];
addMatlabFunction(functionBlock, [250 70 520 330], [
    "function [v_train,Fmotor,Fresistance,Fadhesion_max,Tload] = fcn(omega_m,Te,Fmechanical,grade,mu,mass,wheel_radius,gear_ratio,gear_efficiency,drive_units,A,B,C,g)"
    "v_signed = omega_m * wheel_radius / gear_ratio;"
    "v_train = max(v_signed,0);"
    "Fmotor = drive_units * Te * gear_ratio * gear_efficiency / wheel_radius;"
    "Fadhesion_max = max(mu,0) * max(mass,1) * g;"
    "dirMotion = sign(v_signed);"
    "if abs(v_signed) < 0.05"
    "    dirMotion = sign(Te);"
    "end"
    "if dirMotion == 0"
    "    dirMotion = 1;"
    "end"
    "Fdavis = A + B*abs(v_signed) + C*v_signed*v_signed;"
    "if abs(v_signed) < 0.02 && abs(Te) < 1"
    "    Fdavis = 0;"
    "end"
    "Fgrade = mass*g*grade;"
    "Fresistance = dirMotion*Fdavis + Fgrade;"
    "FmechLimited = min(max(Fmechanical,0),Fadhesion_max);"
    "Fload = Fresistance + dirMotion*FmechLimited;"
    "Tload = (Fload/drive_units)*wheel_radius/(gear_ratio*gear_efficiency);"
    "end"]);

constantNames = {'wheel_radius', 'gear_ratio', 'gear_efficiency', ...
    'drive_units', 'A', 'B', 'C', 'g'};
constantValues = {'SCv1.vehicle.wheel_radius', ...
    'SCv1.vehicle.gear_ratio', 'SCv1.vehicle.gear_efficiency', ...
    'SCv1.vehicle.drive_units', 'SCv1.vehicle.A', ...
    'SCv1.vehicle.B', 'SCv1.vehicle.C', 'SCv1.vehicle.g'};
addConstants(subsystem, constantNames, constantValues, 90, 350);
for inputIndex = 1:numel(inputNames)
    connectSignal(subsystem, [subsystem '/' inputNames{inputIndex}], 1, ...
        functionBlock, inputIndex);
end
for constantIndex = 1:numel(constantNames)
    connectSignal(subsystem, [subsystem '/' constantNames{constantIndex}], 1, ...
        functionBlock, numel(inputNames) + constantIndex);
end
for outputIndex = 1:numel(outputNames)
    connectSignal(subsystem, functionBlock, outputIndex, ...
        [subsystem '/' outputNames{outputIndex}], 1);
end
set_param(subsystem, 'BackgroundColor', 'lightBlue');
end


function buildMechanicalBrake(modelName)
subsystem = [modelName '/MechanicalBrake'];
createEmptySubsystem(subsystem, [690 565 875 675]);
addSignalPorts(subsystem, {'Fmechanical_ref'}, {'Fmechanical'});
add_block('simulink/Discontinuities/Saturation', ...
    [subsystem '/Force_Limit'], 'Position', [120 55 180 95], ...
    'UpperLimit', 'SCv1.brake.mechanical_force_max', 'LowerLimit', '0');
add_block('simulink/Continuous/Transfer Fcn', ...
    [subsystem '/Brake_Lag'], 'Position', [250 55 350 95], ...
    'Numerator', '1', ...
    'Denominator', '[SCv1.brake.mechanical_tau 1]');
connectSignal(subsystem, [subsystem '/Fmechanical_ref'], 1, ...
    [subsystem '/Force_Limit'], 1);
connectSignal(subsystem, [subsystem '/Force_Limit'], 1, ...
    [subsystem '/Brake_Lag'], 1);
connectSignal(subsystem, [subsystem '/Brake_Lag'], 1, ...
    [subsystem '/Fmechanical'], 1);
set_param(subsystem, 'BackgroundColor', 'orange');
end


function buildDCBus(modelName)
sourceBlocks = {'DC Voltage Source', 'Series RLC Branch', ...
    'Series RLC Branch1', 'Current Measurement', 'Voltage Measurement'};
sourceHandles = zeros(1, numel(sourceBlocks));
for blockIndex = 1:numel(sourceBlocks)
    sourceHandles(blockIndex) = getSimulinkBlockHandle( ...
        [modelName '/' sourceBlocks{blockIndex}]);
end
Simulink.BlockDiagram.createSubsystem(sourceHandles, ...
    'Name', 'DCBus', 'MakeNameUnique', 'off');
subsystem = [modelName '/DCBus'];
pmio = find_system(subsystem, 'SearchDepth', 1, 'BlockType', 'PMIOPort');
assert(numel(pmio) == 2, 'DCBus requires two electrical boundary ports.');
[~, order] = sort(cellfun(@(p) str2double(get_param(p, 'Port')), pmio));
pmio = pmio(order);
set_param(pmio{1}, 'Name', 'Bus_Pos');
set_param(pmio{2}, 'Name', 'Bus_Neg');

% Remove generated signal boundary ports and add named measurement outputs.
generatedPorts = find_system(subsystem, 'SearchDepth', 1, ...
    'RegExp', 'on', 'BlockType', 'Outport');
if ~isempty(generatedPorts)
    delete_block(generatedPorts);
end
clearOutputLine([subsystem '/Current Measurement'], 1);
clearOutputLine([subsystem '/Voltage Measurement'], 1);
add_block('simulink/Ports & Subsystems/Out1', [subsystem '/Igrid'], ...
    'Port', '1', 'Position', [690 80 720 100]);
add_block('simulink/Ports & Subsystems/Out1', [subsystem '/Udc'], ...
    'Port', '2', 'Position', [690 125 720 145]);
connectSignal(subsystem, [subsystem '/Current Measurement'], 1, ...
    [subsystem '/Igrid'], 1);
connectSignal(subsystem, [subsystem '/Voltage Measurement'], 1, ...
    [subsystem '/Udc'], 1);

set_param([subsystem '/DC Voltage Source'], ...
    'Amplitude', 'SCv1.dc.Vsource');
set_param([subsystem '/Series RLC Branch'], 'BranchType', 'RL', ...
    'Resistance', 'SCv1.dc.line_R', 'Inductance', 'SCv1.dc.line_L');
set_param([subsystem '/Series RLC Branch1'], 'BranchType', 'C', ...
    'Capacitance', 'SCv1.dc.Cdc', 'Setx0', 'on', ...
    'InitialVoltage', 'SCv1.dc.Udc_initial');
add_block('spsDiodeLib/Diode', [subsystem '/Line_Blocking_Diode'], ...
    'Position', [245 230 285 270], 'Ron', '1e-3', 'Lon', '0', ...
    'Vf', '0.8', 'UseSnubber', '1', 'Rs', '1e5', 'Cs', 'inf', ...
    'Measurements', 'off');

add_block('simulink/Ports & Subsystems/In1', [subsystem '/Te_unit'], ...
    'Port', '1', 'Position', [30 360 60 380]);
add_block('simulink/Ports & Subsystems/In1', [subsystem '/omega_m'], ...
    'Port', '2', 'Position', [30 400 60 420]);
powerFunction = [subsystem '/Power_to_Current'];
addMatlabFunction(powerFunction, [170 335 350 415], [
    "function I = fcn(Te,omega_m,drive_units,Vnom,eta,Ilimit)"
    "Pmech = Te*omega_m;"
    "if Pmech >= 0"
    "    Pelec = Pmech/max(eta,0.1);"
    "else"
    "    Pelec = Pmech*eta;"
    "end"
    "I = min(max((max(drive_units,1)-1)*Pelec/max(Vnom,100),-Ilimit),Ilimit);"
    "end"]);
constantNames = {'Drive_Units', 'Nominal_DC_Voltage', ...
    'Inverter_Efficiency', 'Aggregate_Current_Limit'};
constantValues = {'SCv1.vehicle.drive_units', 'SCv1.dc.Vsource', ...
    'SCv1.motor.inverter_efficiency', 'SCv1.dc.current_limit'};
addConstants(subsystem, constantNames, constantValues, 75, 445);
connectSignal(subsystem, [subsystem '/Te_unit'], 1, powerFunction, 1);
connectSignal(subsystem, [subsystem '/omega_m'], 1, powerFunction, 2);
for constantIndex = 1:numel(constantNames)
    connectSignal(subsystem, [subsystem '/' constantNames{constantIndex}], 1, ...
        powerFunction, 2 + constantIndex);
end
add_block('simulink/Continuous/Transfer Fcn', ...
    [subsystem '/Aggregate_Current_Dynamics'], ...
    'Position', [365 345 445 385], 'Numerator', '1', ...
    'Denominator', '[1e-3 1]');
add_block('spsControlledCurrentSourceLib/Controlled Current Source', ...
    [subsystem '/Aggregate_Drive_Current'], ...
    'Position', [500 325 560 405], 'Initialize', 'off', ...
    'Measurements', 'None');
connectSignal(subsystem, powerFunction, 1, ...
    [subsystem '/Aggregate_Current_Dynamics'], 1);
connectSignal(subsystem, [subsystem '/Aggregate_Current_Dynamics'], 1, ...
    [subsystem '/Aggregate_Drive_Current'], 1);

% Rebuild the physical DC source and bus nodes deterministically.
deletePhysicalLinesInSystem(subsystem);
busPositive = [subsystem '/Bus_Pos'];
busNegative = [subsystem '/Bus_Neg'];
source = [subsystem '/DC Voltage Source'];
diode = [subsystem '/Line_Blocking_Diode'];
lineBranch = [subsystem '/Series RLC Branch'];
currentMeasure = [subsystem '/Current Measurement'];
dcCapacitor = [subsystem '/Series RLC Branch1'];
voltageMeasure = [subsystem '/Voltage Measurement'];
aggregateSource = [subsystem '/Aggregate_Drive_Current'];
connectPhysical(subsystem, source, 'RConn', 1, diode, 'LConn', 1);
connectPhysical(subsystem, diode, 'RConn', 1, lineBranch, 'LConn', 1);
connectPhysical(subsystem, lineBranch, 'RConn', 1, ...
    currentMeasure, 'LConn', 1);
connectPhysical(subsystem, currentMeasure, 'RConn', 1, ...
    busPositive, 'RConn', 1);
connectPhysical(subsystem, busPositive, 'RConn', 1, ...
    dcCapacitor, 'LConn', 1);
connectPhysical(subsystem, busPositive, 'RConn', 1, ...
    voltageMeasure, 'LConn', 1);
connectPhysical(subsystem, busPositive, 'RConn', 1, ...
    aggregateSource, 'LConn', 1);
connectPhysical(subsystem, source, 'LConn', 1, ...
    busNegative, 'RConn', 1);
connectPhysical(subsystem, busNegative, 'RConn', 1, ...
    dcCapacitor, 'RConn', 1);
connectPhysical(subsystem, busNegative, 'RConn', 1, ...
    voltageMeasure, 'LConn', 2);
connectPhysical(subsystem, busNegative, 'RConn', 1, ...
    aggregateSource, 'RConn', 1);
set_param(subsystem, 'BackgroundColor', 'cyan');
end


function buildSuperCapBranch(modelName)
subsystem = [modelName '/SuperCapBranch'];
createEmptySubsystem(subsystem, [890 15 1110 165]);
addPmio(subsystem, 'Bus_Pos', 1, 'Left', [20 55 40 75]);
addPmio(subsystem, 'Bus_Neg', 2, 'Left', [20 105 40 125]);
inputNames = {'Udc', 'BrakeActive', 'SC_Enable'};
outputNames = {'Usc', 'Isc', 'Psc', 'SOCsc', 'Esc', 'Duty', 'Mode'};
addSignalPorts(subsystem, inputNames, outputNames);

supercapacitor = [subsystem '/Supercapacitor'];
buildPhysicalSupercapacitor(supercapacitor);
converter = [subsystem '/BidirectionalDCDC_SC'];
buildAverageDCDC(converter);

converterPorts = get_param(converter, 'PortHandles');
supercapPorts = get_param(supercapacitor, 'PortHandles');
busPositivePorts = get_param([subsystem '/Bus_Pos'], 'PortHandles');
busNegativePorts = get_param([subsystem '/Bus_Neg'], 'PortHandles');
add_line(subsystem, busPositivePorts.RConn, converterPorts.LConn(1), ...
    'autorouting', 'on');
add_line(subsystem, busNegativePorts.RConn, converterPorts.LConn(2), ...
    'autorouting', 'on');
add_line(subsystem, converterPorts.RConn(1), supercapPorts.LConn(1), ...
    'autorouting', 'on');
add_line(subsystem, converterPorts.RConn(2), supercapPorts.LConn(2), ...
    'autorouting', 'on');

connectSignal(subsystem, [subsystem '/Udc'], 1, converter, 1);
connectSignal(subsystem, supercapacitor, 1, converter, 2);
connectSignal(subsystem, supercapacitor, 4, converter, 3);
connectSignal(subsystem, [subsystem '/BrakeActive'], 1, converter, 4);
connectSignal(subsystem, [subsystem '/SC_Enable'], 1, converter, 5);

sourcePorts = {
    supercapacitor, 1
    supercapacitor, 2
    converter, 2
    supercapacitor, 4
    supercapacitor, 3
    converter, 3
    converter, 4};
for outputIndex = 1:numel(outputNames)
    connectSignal(subsystem, sourcePorts{outputIndex, 1}, ...
        sourcePorts{outputIndex, 2}, ...
        [subsystem '/' outputNames{outputIndex}], 1);
end

% Retain controller diagnostics without exposing unused top-level ports.
add_block('simulink/Sinks/Terminator', [subsystem '/Term_Isc_ref'], ...
    'Position', [535 360 555 380]);
add_block('simulink/Sinks/Terminator', [subsystem '/Term_Ibus_ref'], ...
    'Position', [535 405 555 425]);
connectSignal(subsystem, converter, 1, [subsystem '/Term_Isc_ref'], 1);
connectSignal(subsystem, converter, 5, [subsystem '/Term_Ibus_ref'], 1);
set_param(subsystem, 'BackgroundColor', 'magenta');
end


function buildPhysicalSupercapacitor(subsystem)
createEmptySubsystem(subsystem, [600 80 820 300]);
addPmio(subsystem, 'SC_Pos', 1, 'Left', [20 65 40 85]);
addPmio(subsystem, 'SC_Neg', 2, 'Left', [20 185 40 205]);
add_block('spsCurrentMeasurementLib/Current Measurement', ...
    [subsystem '/SC_Current'], 'Position', [105 55 145 95]);
add_block('spsSeriesRLCBranchLib/Series RLC Branch', ...
    [subsystem '/ESR'], 'Position', [205 55 245 95], ...
    'BranchType', 'R', 'Resistance', 'SCv1.supercap.ESR');
add_block('spsSeriesRLCBranchLib/Series RLC Branch', ...
    [subsystem '/Csc'], 'Position', [305 55 345 95], ...
    'BranchType', 'C', 'Capacitance', 'SCv1.supercap.C', ...
    'Setx0', 'on', 'InitialVoltage', 'SCv1.supercap.Uinit');
add_block('spsSeriesRLCBranchLib/Series RLC Branch', ...
    [subsystem '/Leakage'], 'Position', [220 165 260 205], ...
    'BranchType', 'R', 'Resistance', 'SCv1.supercap.leakage_R');
add_block('spsVoltageMeasurementLib/Voltage Measurement', ...
    [subsystem '/Terminal_Voltage'], 'Position', [420 95 470 145]);
add_block('spsVoltageMeasurementLib/Voltage Measurement', ...
    [subsystem '/Capacitor_Voltage'], 'Position', [420 180 470 230]);

deletePhysicalLinesInSystem(subsystem);
positivePort = [subsystem '/SC_Pos'];
negativePort = [subsystem '/SC_Neg'];
currentMeasure = [subsystem '/SC_Current'];
esr = [subsystem '/ESR'];
capacitor = [subsystem '/Csc'];
leakage = [subsystem '/Leakage'];
terminalVoltage = [subsystem '/Terminal_Voltage'];
capacitorVoltage = [subsystem '/Capacitor_Voltage'];
connectPhysical(subsystem, positivePort, 'RConn', 1, ...
    currentMeasure, 'LConn', 1);
connectPhysical(subsystem, currentMeasure, 'RConn', 1, esr, 'LConn', 1);
connectPhysical(subsystem, esr, 'RConn', 1, capacitor, 'LConn', 1);
connectPhysical(subsystem, capacitor, 'RConn', 1, ...
    negativePort, 'RConn', 1);
connectPhysical(subsystem, positivePort, 'RConn', 1, leakage, 'LConn', 1);
connectPhysical(subsystem, leakage, 'RConn', 1, negativePort, 'RConn', 1);
connectPhysical(subsystem, positivePort, 'RConn', 1, ...
    terminalVoltage, 'LConn', 1);
connectPhysical(subsystem, negativePort, 'RConn', 1, ...
    terminalVoltage, 'LConn', 2);
connectPhysical(subsystem, capacitor, 'LConn', 1, ...
    capacitorVoltage, 'LConn', 1);
connectPhysical(subsystem, capacitor, 'RConn', 1, ...
    capacitorVoltage, 'LConn', 2);

energyFunction = [subsystem '/Energy_SOC'];
addMatlabFunction(energyFunction, [560 130 735 235], [
    "function [Esc,SOCsc] = fcn(Ucap,C,Umin,Umax)"
    "Esc = 0.5*C*Ucap*Ucap;"
    "SOCsc = min(max((Ucap*Ucap-Umin*Umin)/(Umax*Umax-Umin*Umin),0),1);"
    "end"]);
constantNames = {'C_value', 'Umin', 'Umax'};
constantValues = {'SCv1.supercap.C', 'SCv1.supercap.Umin', ...
    'SCv1.supercap.Umax'};
addConstants(subsystem, constantNames, constantValues, 500, 260);
connectSignal(subsystem, capacitorVoltage, 1, energyFunction, 1);
for constantIndex = 1:numel(constantNames)
    connectSignal(subsystem, [subsystem '/' constantNames{constantIndex}], 1, ...
        energyFunction, 1 + constantIndex);
end

outputNames = {'Usc', 'Isc', 'Esc', 'SOCsc'};
for outputIndex = 1:numel(outputNames)
    add_block('simulink/Ports & Subsystems/Out1', ...
        [subsystem '/' outputNames{outputIndex}], ...
        'Port', num2str(outputIndex), ...
        'Position', [800 85 + 45 * outputIndex 830 105 + 45 * outputIndex]);
end
connectSignal(subsystem, terminalVoltage, 1, [subsystem '/Usc'], 1);
connectSignal(subsystem, currentMeasure, 1, [subsystem '/Isc'], 1);
connectSignal(subsystem, energyFunction, 1, [subsystem '/Esc'], 1);
connectSignal(subsystem, energyFunction, 2, [subsystem '/SOCsc'], 1);
end


function buildAverageDCDC(subsystem)
createEmptySubsystem(subsystem, [250 60 500 310]);
addPmio(subsystem, 'DC_Pos', 1, 'Left', [20 55 40 75]);
addPmio(subsystem, 'DC_Neg', 2, 'Left', [20 105 40 125]);
addPmio(subsystem, 'SC_Pos', 3, 'Right', [820 55 840 75]);
addPmio(subsystem, 'SC_Neg', 4, 'Right', [820 105 840 125]);
inputNames = {'Udc', 'Usc', 'SOCsc', 'BrakeActive', 'SC_Enable'};
outputNames = {'Isc_ref', 'Psc', 'Duty', 'Mode', 'Ibus_ref'};
addSignalPorts(subsystem, inputNames, outputNames);

controller = [subsystem '/Udc_Charge_Controller'];
addMatlabFunction(controller, [180 150 390 315], [
    "function [Isc_cmd,Duty,Mode] = fcn(Udc,Usc,SOCsc,BrakeActive,SC_Enable,Udc_on,Udc_target,Udc_discharge,SOCmax,SOCmin,Umax,Umin,Imax,Kp,enableDischarge)"
    "Isc_cmd = 0; Duty = 0; Mode = 0;"
    "if SC_Enable > 0.5 && BrakeActive > 0.5 && Udc > Udc_on && SOCsc < SOCmax && Usc < Umax"
    "    fsoc = min(max((SOCmax-SOCsc)/0.03,0),1);"
    "    fvolt = min(max((Umax-Usc)/10,0),1);"
    "    Isc_cmd = min(max(Kp*(Udc-Udc_target),0),Imax)*fsoc*fvolt;"
    "    Duty = min(max(Usc/max(Udc,100),0.02),0.95); Mode = 1;"
    "elseif SC_Enable > 0.5 && enableDischarge > 0.5 && BrakeActive < 0.5 && Udc < Udc_discharge && SOCsc > SOCmin && Usc > Umin"
    "    Isc_cmd = -min(Kp*(Udc_discharge-Udc),Imax);"
    "    Duty = min(max(1-Usc/max(Udc,100),0.02),0.95); Mode = 2;"
    "end"
    "end"]);
constantNames = {'Udc_on', 'Udc_target', 'Udc_discharge', ...
    'SOCmax', 'SOCmin', 'Umax', 'Umin', 'Imax', 'Kp', ...
    'enableDischarge'};
constantValues = {'SCv1.dc.Udc_charge_on', 'SCv1.dc.Udc_target', ...
    'SCv1.dcdc.Udc_discharge_on', 'SCv1.supercap.SOCmax', ...
    'SCv1.supercap.SOCmin', 'SCv1.supercap.Umax', ...
    'SCv1.supercap.Umin', 'SCv1.supercap.Imax', ...
    'SCv1.dcdc.Kp_charge', 'double(SCv1.dcdc.enable_discharge)'};
addConstants(subsystem, constantNames, constantValues, 70, 340);
for inputIndex = 1:numel(inputNames)
    connectSignal(subsystem, [subsystem '/' inputNames{inputIndex}], 1, ...
        controller, inputIndex);
end
for constantIndex = 1:numel(constantNames)
    connectSignal(subsystem, [subsystem '/' constantNames{constantIndex}], 1, ...
        controller, numel(inputNames) + constantIndex);
end

add_block('simulink/Continuous/Transfer Fcn', ...
    [subsystem '/Average_Current_Dynamics'], ...
    'Position', [440 170 550 210], 'Numerator', '1', ...
    'Denominator', '[SCv1.dcdc.current_tau 1]');
connectSignal(subsystem, controller, 1, ...
    [subsystem '/Average_Current_Dynamics'], 1);

powerFunction = [subsystem '/Power_Conservation'];
addMatlabFunction(powerFunction, [600 145 760 270], [
    "function [Psc,Ibus] = fcn(Isc,Usc,Udc,Mode,etaC,etaD)"
    "Psc = Usc*Isc;"
    "if Mode == 1"
    "    Ibus = Psc/(max(Udc,100)*etaC);"
    "elseif Mode == 2"
    "    Ibus = Psc*etaD/max(Udc,100);"
    "else"
    "    Ibus = 0; Psc = 0;"
    "end"
    "end"]);
add_block('simulink/Sources/Constant', [subsystem '/eta_charge'], ...
    'Value', 'SCv1.dcdc.eff_charge', 'Position', [480 285 565 305]);
add_block('simulink/Sources/Constant', [subsystem '/eta_discharge'], ...
    'Value', 'SCv1.dcdc.eff_discharge', 'Position', [480 320 565 340]);
connectSignal(subsystem, [subsystem '/Average_Current_Dynamics'], 1, ...
    powerFunction, 1);
connectSignal(subsystem, [subsystem '/Usc'], 1, powerFunction, 2);
connectSignal(subsystem, [subsystem '/Udc'], 1, powerFunction, 3);
connectSignal(subsystem, controller, 3, powerFunction, 4);
connectSignal(subsystem, [subsystem '/eta_charge'], 1, powerFunction, 5);
connectSignal(subsystem, [subsystem '/eta_discharge'], 1, powerFunction, 6);

add_block('spsControlledCurrentSourceLib/Controlled Current Source', ...
    [subsystem '/DC_Side_Average_Source'], ...
    'Position', [650 35 710 110], 'Initialize', 'off', ...
    'Measurements', 'None');
add_block('spsControlledCurrentSourceLib/Controlled Current Source', ...
    [subsystem '/SC_Side_Average_Source'], ...
    'Position', [650 355 710 430], 'Initialize', 'off', ...
    'Measurements', 'None');
add_block('simulink/Math Operations/Gain', ...
    [subsystem '/Charge_Current_Sign'], 'Position', [570 370 620 410], ...
    'Gain', '-1');
connectSignal(subsystem, powerFunction, 2, ...
    [subsystem '/DC_Side_Average_Source'], 1);
connectSignal(subsystem, [subsystem '/Average_Current_Dynamics'], 1, ...
    [subsystem '/Charge_Current_Sign'], 1);
connectSignal(subsystem, [subsystem '/Charge_Current_Sign'], 1, ...
    [subsystem '/SC_Side_Average_Source'], 1);

deletePhysicalLinesInSystem(subsystem);
connectPhysical(subsystem, [subsystem '/DC_Side_Average_Source'], ...
    'LConn', 1, [subsystem '/DC_Pos'], 'RConn', 1);
connectPhysical(subsystem, [subsystem '/DC_Side_Average_Source'], ...
    'RConn', 1, [subsystem '/DC_Neg'], 'RConn', 1);
connectPhysical(subsystem, [subsystem '/SC_Side_Average_Source'], ...
    'LConn', 1, [subsystem '/SC_Pos'], 'RConn', 1);
connectPhysical(subsystem, [subsystem '/SC_Side_Average_Source'], ...
    'RConn', 1, [subsystem '/SC_Neg'], 'RConn', 1);

connectSignal(subsystem, [subsystem '/Average_Current_Dynamics'], 1, ...
    [subsystem '/Isc_ref'], 1);
connectSignal(subsystem, powerFunction, 1, [subsystem '/Psc'], 1);
connectSignal(subsystem, controller, 2, [subsystem '/Duty'], 1);
connectSignal(subsystem, controller, 3, [subsystem '/Mode'], 1);
connectSignal(subsystem, powerFunction, 2, [subsystem '/Ibus_ref'], 1);
end


function buildTestScenario(modelName)
subsystem = [modelName '/TestScenario'];
createEmptySubsystem(subsystem, [35 80 220 325]);
add_block('simulink/Sources/Clock', [subsystem '/Clock'], ...
    'Position', [30 55 60 75]);
profile = [subsystem '/Speed_Profile'];
addMatlabFunction(profile, [190 35 410 165], [
    "function [v_ref,BrakeCmd] = fcn(t,target_speed,accel,start_time,brake_start,decel)"
    "t_reach = start_time + target_speed/max(accel,0.01);"
    "if t < start_time"
    "    v_ref = 0; BrakeCmd = 0;"
    "elseif t < t_reach"
    "    v_ref = min(accel*(t-start_time),target_speed); BrakeCmd = 0;"
    "elseif t < brake_start"
    "    v_ref = target_speed; BrakeCmd = 0;"
    "else"
    "    v_ref = max(target_speed-decel*(t-brake_start),0); BrakeCmd = 1;"
    "end"
    "end"]);
constantNames = {'target_speed', 'accel', 'start_time', ...
    'brake_start', 'decel', 'grade', 'mu', 'mass'};
constantValues = {'SCv1.scenario.target_speed', ...
    'SCv1.scenario.acceleration', 'SCv1.scenario.start_time', ...
    'SCv1.scenario.brake_start', 'SCv1.brake.deceleration', ...
    'SCv1.vehicle.grade', 'SCv1.vehicle.mu', 'SCv1.vehicle.mass'};
addConstants(subsystem, constantNames, constantValues, 75, 175);
outputNames = {'v_ref', 'BrakeCmd', 'grade_out', 'mu_out', 'mass_out'};
for outputIndex = 1:numel(outputNames)
    add_block('simulink/Ports & Subsystems/Out1', ...
        [subsystem '/' outputNames{outputIndex}], ...
        'Port', num2str(outputIndex), ...
        'Position', [520 40 + 55 * outputIndex 550 60 + 55 * outputIndex]);
end
connectSignal(subsystem, [subsystem '/Clock'], 1, profile, 1);
for constantIndex = 1:5
    connectSignal(subsystem, [subsystem '/' constantNames{constantIndex}], 1, ...
        profile, 1 + constantIndex);
end
connectSignal(subsystem, profile, 1, [subsystem '/v_ref'], 1);
connectSignal(subsystem, profile, 2, [subsystem '/BrakeCmd'], 1);
connectSignal(subsystem, [subsystem '/grade'], 1, [subsystem '/grade_out'], 1);
connectSignal(subsystem, [subsystem '/mu'], 1, [subsystem '/mu_out'], 1);
connectSignal(subsystem, [subsystem '/mass'], 1, [subsystem '/mass_out'], 1);
set_param(subsystem, 'BackgroundColor', 'yellow');
end


function buildSupervisor(modelName)
subsystem = [modelName '/TractionBrakeSupervisor'];
createEmptySubsystem(subsystem, [275 75 525 385]);
inputNames = {'v_ref', 'v_train', 'BrakeCmd', 'SOCsc', 'Udc', ...
    'mu', 'mass', 'SC_Enable', 'Usc'};
outputNames = {'Tmotor_ref', 'Fmechanical_ref', 'Fregen', 'BrakeActive'};
addSignalPorts(subsystem, inputNames, outputNames);

add_block('simulink/Math Operations/Gain', [subsystem '/vref_to_rpm'], ...
    'Position', [105 40 210 70], ...
    'Gain', 'SCv1.vehicle.gear_ratio/SCv1.vehicle.wheel_radius*30/pi');
add_block('simulink/Math Operations/Gain', [subsystem '/v_to_rpm'], ...
    'Position', [105 90 210 120], ...
    'Gain', 'SCv1.vehicle.gear_ratio/SCv1.vehicle.wheel_radius*30/pi');
add_block('simulink/Math Operations/Sum', [subsystem '/Speed_Error'], ...
    'Position', [250 60 280 100], 'Inputs', '+-');
tractionDrive = [modelName '/TractionDrive'];
add_block([tractionDrive '/Speed'], [subsystem '/Speed_PI_Reused'], ...
    'Position', [320 55 430 105]);
add_block('simulink/Math Operations/Gain', [subsystem '/Iq_to_Torque'], ...
    'Position', [465 60 550 100], 'Gain', 'SCv1.motor.Kt');
connectSignal(subsystem, [subsystem '/v_ref'], 1, ...
    [subsystem '/vref_to_rpm'], 1);
connectSignal(subsystem, [subsystem '/vref_to_rpm'], 1, ...
    [subsystem '/Speed_Error'], 1);
connectSignal(subsystem, [subsystem '/v_train'], 1, ...
    [subsystem '/v_to_rpm'], 1);
connectSignal(subsystem, [subsystem '/v_to_rpm'], 1, ...
    [subsystem '/Speed_Error'], 2);
connectSignal(subsystem, [subsystem '/Speed_Error'], 1, ...
    [subsystem '/Speed_PI_Reused'], 1);
connectSignal(subsystem, [subsystem '/Speed_PI_Reused'], 1, ...
    [subsystem '/Iq_to_Torque'], 1);

blend = [subsystem '/Brake_Blend_Logic'];
addMatlabFunction(blend, [590 35 790 360], [
    "function [Tmotor_ref,Fmechanical_ref,Fregen,BrakeActive] = fcn(Traw,v_train,BrakeCmd,SOCsc,Udc,mu,mass,SC_Enable,Usc,torque_limit,drive_units,gear_ratio,gear_efficiency,wheel_radius,g,decel,v_zero,v_full,Udc_reduce,Udc_max,SOCmax,Iscmax,Umin,PnoSC)"
    "Fadh = max(mu,0)*max(mass,1)*g;"
    "Tadh = Fadh*wheel_radius/(max(drive_units,1)*gear_ratio*gear_efficiency);"
    "if BrakeCmd > 0.5"
    "    BrakeActive = 1;"
    "    Freq = min(mass*decel,Fadh);"
    "    if v_train <= v_zero"
    "        flow = 0;"
    "    elseif v_train >= v_full"
    "        flow = 1;"
    "    else"
    "        flow = (v_train-v_zero)/(v_full-v_zero);"
    "    end"
    "    fdc = min(max((Udc_max-Udc)/max(Udc_max-Udc_reduce,1),0),1);"
    "    fsc = min(max((SOCmax-SOCsc)/0.02,0),1);"
    "    if SC_Enable > 0.5"
    "        Pcap = Iscmax*max(Usc,Umin)*fsc;"
    "    else"
    "        Pcap = PnoSC;"
    "    end"
    "    omega = max(v_train*gear_ratio/wheel_radius,20);"
    "    Tpower = Pcap/(max(drive_units,1)*omega);"
    "    Tneed = Freq*wheel_radius/(max(drive_units,1)*gear_ratio*gear_efficiency);"
    "    Tregen = min([torque_limit,Tadh,Tpower,Tneed])*flow*fdc;"
    "    Tregen = max(Tregen,0);"
    "    Tmotor_ref = -Tregen;"
    "    Fregen = drive_units*Tregen*gear_ratio*gear_efficiency/wheel_radius;"
    "    Fmechanical_ref = max(Freq-Fregen,0);"
    "else"
    "    BrakeActive = 0;"
    "    Tmotor_ref = min(max(Traw,0),min(torque_limit,Tadh));"
    "    Fregen = 0;"
    "    Fmechanical_ref = 0;"
    "end"
    "end"]);
constantNames = {'torque_limit', 'drive_units', 'gear_ratio', ...
    'gear_efficiency', 'wheel_radius', 'g', 'decel', 'v_zero', ...
    'v_full', 'Udc_reduce', 'Udc_max', 'SOCmax', 'Iscmax', ...
    'Umin', 'PnoSC'};
constantValues = {'SCv1.motor.torque_limit', ...
    'SCv1.vehicle.drive_units', 'SCv1.vehicle.gear_ratio', ...
    'SCv1.vehicle.gear_efficiency', 'SCv1.vehicle.wheel_radius', ...
    'SCv1.vehicle.g', 'SCv1.brake.deceleration', ...
    'SCv1.brake.regen_zero_speed', 'SCv1.brake.regen_full_speed', ...
    'SCv1.dc.Udc_regen_reduce', 'SCv1.dc.Udc_max', ...
    'SCv1.supercap.SOCmax', 'SCv1.supercap.Imax', ...
    'SCv1.supercap.Umin', 'SCv1.brake.no_sc_regen_power'};
addConstants(subsystem, constantNames, constantValues, 350, 390);
connectSignal(subsystem, [subsystem '/Iq_to_Torque'], 1, blend, 1);
for inputIndex = 2:numel(inputNames)
    connectSignal(subsystem, [subsystem '/' inputNames{inputIndex}], 1, ...
        blend, inputIndex);
end
for constantIndex = 1:numel(constantNames)
    connectSignal(subsystem, [subsystem '/' constantNames{constantIndex}], 1, ...
        blend, numel(inputNames) + constantIndex);
end
for outputIndex = 1:numel(outputNames)
    connectSignal(subsystem, blend, outputIndex, ...
        [subsystem '/' outputNames{outputIndex}], 1);
end
deleteIfPresent([tractionDrive '/Speed']);
deleteIfPresent([tractionDrive '/wm->Nr']);
set_param(subsystem, 'BackgroundColor', 'green');
end


function connectTopLevel(modelName)
testScenario = [modelName '/TestScenario'];
supervisor = [modelName '/TractionBrakeSupervisor'];
vehicle = [modelName '/VehicleDynamics'];
drive = [modelName '/TractionDrive'];
dcBus = [modelName '/DCBus'];
supercap = [modelName '/SuperCapBranch'];
mechanicalBrake = [modelName '/MechanicalBrake'];

add_block('simulink/Sources/Constant', [modelName '/SC_Enable'], ...
    'Position', [300 440 380 470], 'Value', 'SCv1.case.enable_sc');
add_block('simulink/Discrete/Unit Delay', ...
    [modelName '/Udc_Control_Delay'], 'Position', [830 170 900 200], ...
    'SampleTime', 'Ts', 'InitialCondition', 'SCv1.dc.Udc_initial');

connectSignal(modelName, testScenario, 1, supervisor, 1);
connectSignal(modelName, vehicle, 1, supervisor, 2);
connectSignal(modelName, testScenario, 2, supervisor, 3);
connectSignal(modelName, supercap, 4, supervisor, 4);
connectSignal(modelName, [modelName '/Udc_Control_Delay'], 1, supervisor, 5);
connectSignal(modelName, testScenario, 4, supervisor, 6);
connectSignal(modelName, testScenario, 5, supervisor, 7);
connectSignal(modelName, [modelName '/SC_Enable'], 1, supervisor, 8);
connectSignal(modelName, supercap, 1, supervisor, 9);

connectSignal(modelName, supervisor, 1, drive, 1);
connectSignal(modelName, supervisor, 2, mechanicalBrake, 1);
connectSignal(modelName, mechanicalBrake, 1, vehicle, 3);
connectSignal(modelName, drive, 2, vehicle, 1);
connectSignal(modelName, drive, 1, vehicle, 2);
connectSignal(modelName, testScenario, 3, vehicle, 4);
connectSignal(modelName, testScenario, 4, vehicle, 5);
connectSignal(modelName, testScenario, 5, vehicle, 6);
connectSignal(modelName, vehicle, 5, drive, 2);

connectSignal(modelName, dcBus, 2, [modelName '/Udc_Control_Delay'], 1);
connectSignal(modelName, [modelName '/Udc_Control_Delay'], 1, drive, 3);
connectSignal(modelName, drive, 1, dcBus, 1);
connectSignal(modelName, drive, 2, dcBus, 2);
connectSignal(modelName, [modelName '/Udc_Control_Delay'], 1, supercap, 1);
connectSignal(modelName, supervisor, 4, supercap, 2);
connectSignal(modelName, [modelName '/SC_Enable'], 1, supercap, 3);

deletePhysicalLinesInSystem(modelName);
dcPorts = get_param(dcBus, 'PortHandles');
drivePorts = get_param(drive, 'PortHandles');
supercapPorts = get_param(supercap, 'PortHandles');
add_line(modelName, dcPorts.LConn(1), drivePorts.RConn(1), ...
    'autorouting', 'on');
add_line(modelName, dcPorts.LConn(1), supercapPorts.LConn(1), ...
    'autorouting', 'on');
add_line(modelName, dcPorts.LConn(2), drivePorts.RConn(2), ...
    'autorouting', 'on');
add_line(modelName, dcPorts.LConn(2), supercapPorts.LConn(2), ...
    'autorouting', 'on');
end


function buildEnergyAccounting(modelName)
subsystem = [modelName '/EnergyAccounting'];
createEmptySubsystem(subsystem, [1190 330 1405 625]);
inputNames = {'Te', 'omega_m', 'Udc', 'Idc_unit', 'Psc', 'Igrid', ...
    'Fmechanical', 'v_train'};
outputNames = {'Pmotor', 'Pdc', 'Pregen', 'Pgrid', 'Pmechanical', ...
    'Idc_total', 'Etraction_kJ', 'Eregen_kJ', 'Eregen_Wh', ...
    'Esc_kJ', 'Esc_Wh', 'Egrid_return_kJ', 'Emechanical_kJ', ...
    'RecoveryRatio', 'EnergyBalanceError_kJ'};
addSignalPorts(subsystem, inputNames, outputNames);

powerFunction = [subsystem '/Power_Sign_Convention'];
addMatlabFunction(powerFunction, [180 40 420 250], [
    "function [Pmotor,Pdc,Pregen,Ptraction,PscCharge,PgridReturn,Pmechanical,Idc_total,Pgrid] = fcn(Te,omega_m,Udc,Idc_unit,Psc,Igrid,Fmechanical,v_train,N,Vsource)"
    "Pmotor = N*Te*omega_m;"
    "Idc_total = N*Idc_unit;"
    "Pdc = Udc*Idc_total;"
    "Pregen = max(-Pdc,0);"
    "Ptraction = max(Pdc,0);"
    "PscCharge = max(Psc,0);"
    "Pgrid = Vsource*Igrid;"
    "PgridReturn = max(-Pgrid,0);"
    "Pmechanical = max(Fmechanical,0)*max(v_train,0);"
    "end"]);
add_block('simulink/Sources/Constant', [subsystem '/Drive_Units'], ...
    'Value', 'SCv1.vehicle.drive_units', 'Position', [60 330 145 350]);
add_block('simulink/Sources/Constant', [subsystem '/Vsource'], ...
    'Value', 'SCv1.dc.Vsource', 'Position', [60 370 145 390]);
for inputIndex = 1:numel(inputNames)
    connectSignal(subsystem, [subsystem '/' inputNames{inputIndex}], 1, ...
        powerFunction, inputIndex);
end
connectSignal(subsystem, [subsystem '/Drive_Units'], 1, powerFunction, 9);
connectSignal(subsystem, [subsystem '/Vsource'], 1, powerFunction, 10);

integratorNames = {'Etraction_J', 'Eregen_J', 'Esc_J', ...
    'EgridReturn_J', 'Emechanical_J'};
powerOutputIndices = [4 3 5 6 7];
for integratorIndex = 1:numel(integratorNames)
    add_block('simulink/Continuous/Integrator', ...
        [subsystem '/' integratorNames{integratorIndex}], ...
        'Position', [485 40 + 55 * integratorIndex ...
        525 70 + 55 * integratorIndex], 'InitialCondition', '0');
    connectSignal(subsystem, powerFunction, ...
        powerOutputIndices(integratorIndex), ...
        [subsystem '/' integratorNames{integratorIndex}], 1);
end

metricsFunction = [subsystem '/Energy_Metrics'];
addMatlabFunction(metricsFunction, [610 85 805 270], [
    "function [Etraction_kJ,Eregen_kJ,Eregen_Wh,Esc_kJ,Esc_Wh,Egrid_return_kJ,Emechanical_kJ,RecoveryRatio,BalanceError_kJ] = fcn(Etraction,Eregen,Esc,EgridReturn,Emechanical)"
    "Etraction_kJ=Etraction/1000; Eregen_kJ=Eregen/1000; Eregen_Wh=Eregen/3600;"
    "Esc_kJ=Esc/1000; Esc_Wh=Esc/3600; Egrid_return_kJ=EgridReturn/1000; Emechanical_kJ=Emechanical/1000;"
    "RecoveryRatio=Esc/max(Eregen,1);"
    "BalanceError_kJ=(Eregen-Esc-EgridReturn)/1000;"
    "end"]);
for integratorIndex = 1:numel(integratorNames)
    connectSignal(subsystem, [subsystem '/' integratorNames{integratorIndex}], ...
        1, metricsFunction, integratorIndex);
end

directIndices = [1 2 3 9 7 8];
for outputIndex = 1:6
    connectSignal(subsystem, powerFunction, directIndices(outputIndex), ...
        [subsystem '/' outputNames{outputIndex}], 1);
end
for outputIndex = 7:numel(outputNames)
    connectSignal(subsystem, metricsFunction, outputIndex - 6, ...
        [subsystem '/' outputNames{outputIndex}], 1);
end

drive = [modelName '/TractionDrive'];
dcBus = [modelName '/DCBus'];
supercap = [modelName '/SuperCapBranch'];
mechanicalBrake = [modelName '/MechanicalBrake'];
vehicle = [modelName '/VehicleDynamics'];
topSources = {
    drive, 1
    drive, 2
    dcBus, 2
    drive, 6
    supercap, 3
    dcBus, 1
    mechanicalBrake, 1
    vehicle, 1};
for inputIndex = 1:numel(inputNames)
    connectSignal(modelName, topSources{inputIndex, 1}, ...
        topSources{inputIndex, 2}, subsystem, inputIndex);
end
set_param(subsystem, 'BackgroundColor', 'gray');
end


function buildMeasurements(modelName)
subsystem = [modelName '/Measurements'];
createEmptySubsystem(subsystem, [1450 55 1645 665]);
signalNames = {'v_train', 'v_ref', 'omega_m', 'Te', 'Tmotor_ref', ...
    'Fregen', 'Fmechanical', 'Udc', 'Idc', 'Pdc', 'Pregen', ...
    'Usc', 'Isc', 'Psc', 'SOCsc', 'Esc', 'Duty', 'DCDC_Mode', ...
    'Pmotor', 'Pgrid', 'Pmechanical', 'Eregen_kJ', 'Eregen_Wh', ...
    'Esc_kJ', 'Esc_Wh', 'Emechanical_kJ', 'RecoveryRatio', ...
    'EnergyBalanceError_kJ', 'BrakeCmd', 'Etraction_kJ', ...
    'Egrid_return_kJ', 'Iabc', 'id', 'iq', 'Fmotor', ...
    'Fresistance', 'Fadhesion_max'};
for signalIndex = 1:numel(signalNames)
    inputBlock = [subsystem '/' signalNames{signalIndex} '_in'];
    terminator = [subsystem '/Term_' signalNames{signalIndex}];
    add_block('simulink/Ports & Subsystems/In1', inputBlock, ...
        'Port', num2str(signalIndex), ...
        'Position', [20 10 + 28 * signalIndex 50 25 + 28 * signalIndex]);
    add_block('simulink/Sinks/Terminator', terminator, ...
        'Position', [250 10 + 28 * signalIndex 270 30 + 28 * signalIndex]);
    connectSignal(subsystem, inputBlock, 1, terminator, 1);
    inputPorts = get_param(inputBlock, 'PortHandles');
    set_param(inputPorts.Outport, 'DataLogging', 'on', ...
        'DataLoggingNameMode', 'Custom', ...
        'DataLoggingName', signalNames{signalIndex}, ...
        'DataLoggingDecimateData', 'on', ...
        'DataLoggingDecimation', 'SCv1.scenario.log_decimation');
end

vehicle = [modelName '/VehicleDynamics'];
testScenario = [modelName '/TestScenario'];
drive = [modelName '/TractionDrive'];
supervisor = [modelName '/TractionBrakeSupervisor'];
mechanicalBrake = [modelName '/MechanicalBrake'];
dcBus = [modelName '/DCBus'];
supercap = [modelName '/SuperCapBranch'];
energy = [modelName '/EnergyAccounting'];
sources = {
    vehicle, 1
    testScenario, 1
    drive, 2
    drive, 1
    supervisor, 1
    supervisor, 3
    mechanicalBrake, 1
    dcBus, 2
    energy, 6
    energy, 2
    energy, 3
    supercap, 1
    supercap, 2
    supercap, 3
    supercap, 4
    supercap, 5
    supercap, 6
    supercap, 7
    energy, 1
    energy, 4
    energy, 5
    energy, 8
    energy, 9
    energy, 10
    energy, 11
    energy, 13
    energy, 14
    energy, 15
    testScenario, 2
    energy, 7
    energy, 12
    drive, 3
    drive, 4
    drive, 5
    vehicle, 2
    vehicle, 3
    vehicle, 4};
for signalIndex = 1:numel(signalNames)
    connectSignal(modelName, sources{signalIndex, 1}, ...
        sources{signalIndex, 2}, subsystem, signalIndex);
end
set_param(subsystem, 'BackgroundColor', 'lightBlue');
end


function applyModelConfiguration(modelName, projectRoot)
callback = sprintf(['SCv1_root=fileparts(fileparts(get_param(bdroot,' ...
    '''FileName''))); run(fullfile(SCv1_root,''config'',' ...
    '''SC_v1_parameters.m'')); clear SCv1_root;']);
set_param(modelName, 'PreLoadFcn', callback, 'InitFcn', '', ...
    'StopTime', 'SCv1.scenario.stop_time', ...
    'SolverType', 'Variable-step', 'Solver', 'ode23tb', ...
    'MaxStep', 'Ts', 'SignalLogging', 'on', ...
    'SignalLoggingName', 'logsout', 'ReturnWorkspaceOutputs', 'on');
set_param(modelName, 'ModelVersionFormat', '1.%<AutoIncrement:1>');
set_param(modelName, 'Description', sprintf([ ...
    'Rail regenerative braking Gold Model V1\n' ...
    'Parameters: %s'], fullfile(projectRoot, 'config', ...
    'SC_v1_parameters.m')));
end


function arrangeTopLevel(modelName)
positions = {
    'TestScenario', [35 80 220 325]
    'TractionBrakeSupervisor', [275 75 525 385]
    'DCBus', [615 20 805 105]
    'TractionDrive', [610 145 855 505]
    'Udc_Control_Delay', [840 110 905 140]
    'SuperCapBranch', [900 15 1120 165]
    'VehicleDynamics', [950 210 1170 455]
    'MechanicalBrake', [690 565 875 675]
    'EnergyAccounting', [1190 330 1405 625]
    'Measurements', [1450 55 1645 665]
    'SC_Enable', [300 440 380 470]
    'powergui', [35 600 120 650]};
for blockIndex = 1:size(positions, 1)
    block = [modelName '/' positions{blockIndex, 1}];
    if getSimulinkBlockHandle(block) > 0
        set_param(block, 'Position', positions{blockIndex, 2});
    end
end
end


function createEmptySubsystem(path, position)
deleteIfPresent(path);
add_block('simulink/Ports & Subsystems/Subsystem', path, ...
    'Position', position);
children = find_system(path, 'SearchDepth', 1, 'Type', 'Block');
if numel(children) > 1
    delete_block(children(2:end));
end
end


function addSignalPorts(subsystem, inputNames, outputNames)
for inputIndex = 1:numel(inputNames)
    add_block('simulink/Ports & Subsystems/In1', ...
        [subsystem '/' inputNames{inputIndex}], ...
        'Port', num2str(inputIndex), ...
        'Position', [25 15 + 38 * inputIndex 55 35 + 38 * inputIndex]);
end
for outputIndex = 1:numel(outputNames)
    add_block('simulink/Ports & Subsystems/Out1', ...
        [subsystem '/' outputNames{outputIndex}], ...
        'Port', num2str(outputIndex), ...
        'Position', [850 30 + 42 * outputIndex 880 50 + 42 * outputIndex]);
end
end


function addConstants(subsystem, names, values, xPosition, yStart)
for constantIndex = 1:numel(names)
    yPosition = yStart + 30 * constantIndex;
    add_block('simulink/Sources/Constant', ...
        [subsystem '/' names{constantIndex}], ...
        'Value', values{constantIndex}, ...
        'Position', [xPosition yPosition xPosition + 100 yPosition + 20]);
end
end


function addMatlabFunction(path, position, codeLines)
add_block('simulink/User-Defined Functions/MATLAB Function', path, ...
    'Position', position);
root = sfroot;
chart = find(root, '-isa', 'Stateflow.EMChart', 'Path', path);
assert(~isempty(chart), 'Unable to locate MATLAB Function chart: %s', path);
chart.Script = char(join(codeLines, newline));
end


function addPmio(subsystem, name, portNumber, side, position)
add_block('built-in/PMIOPort', [subsystem '/' name], ...
    'Port', num2str(portNumber), 'Side', side, 'Position', position);
end


function connectSignal(system, sourceBlock, sourcePort, ...
    destinationBlock, destinationPort)
sourceHandles = get_param(sourceBlock, 'PortHandles');
destinationHandles = get_param(destinationBlock, 'PortHandles');
destinationLines = get_param(destinationBlock, 'LineHandles');
if destinationLines.Inport(destinationPort) ~= -1
    delete_line(destinationLines.Inport(destinationPort));
end
add_line(system, sourceHandles.Outport(sourcePort), ...
    destinationHandles.Inport(destinationPort), 'autorouting', 'on');
end


function connectPhysical(system, sourceBlock, sourceType, sourceIndex, ...
    destinationBlock, destinationType, destinationIndex)
sourceHandles = get_param(sourceBlock, 'PortHandles');
destinationHandles = get_param(destinationBlock, 'PortHandles');
add_line(system, sourceHandles.(sourceType)(sourceIndex), ...
    destinationHandles.(destinationType)(destinationIndex), ...
    'autorouting', 'on');
end


function clearInputLine(block, portIndex)
lineHandles = get_param(block, 'LineHandles');
if lineHandles.Inport(portIndex) ~= -1
    delete_line(lineHandles.Inport(portIndex));
end
end


function clearOutputLine(block, portIndex)
lineHandles = get_param(block, 'LineHandles');
if lineHandles.Outport(portIndex) ~= -1
    delete_line(lineHandles.Outport(portIndex));
end
end


function clearPhysicalPortLine(block, portType, portIndex)
lineHandles = get_param(block, 'LineHandles');
if lineHandles.(portType)(portIndex) ~= -1
    delete_line(lineHandles.(portType)(portIndex));
end
end


function deletePhysicalLinesInSystem(system)
blocks = find_system(system, 'SearchDepth', 1, 'Type', 'Block');
lineHandles = [];
for blockIndex = 2:numel(blocks)
    handles = get_param(blocks{blockIndex}, 'LineHandles');
    lineHandles = [lineHandles handles.LConn(:)' handles.RConn(:)']; %#ok<AGROW>
end
lineHandles = unique(lineHandles(lineHandles ~= -1));
for lineIndex = 1:numel(lineHandles)
    try
        delete_line(lineHandles(lineIndex));
    catch
        % A branch may already have been deleted with its parent line.
    end
end
end


function portBlock = findPmioByPort(subsystem, portNumber)
pmio = find_system(subsystem, 'SearchDepth', 1, 'BlockType', 'PMIOPort');
match = cellfun(@(p) str2double(get_param(p, 'Port')) == portNumber, pmio);
assert(nnz(match) == 1, 'Unable to identify PMIO port %d in %s.', ...
    portNumber, subsystem);
portBlock = pmio{match};
end


function deleteIfPresent(path)
if getSimulinkBlockHandle(path) > 0
    delete_block(path);
end
end


function blockHandle = getChildBlockHandle(parent, childName)
escapedName = strrep(childName, '/', '//');
blockHandle = getSimulinkBlockHandle([parent '/' escapedName]);
end
