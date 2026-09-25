function export_selected_fmus_v2_1(projectRoot, selectedCodes)
% Incremental FMI 2.0 Co-Simulation export for explicitly selected models.
baseDir = fullfile(projectRoot,'work','simulation','simulink_fmu_v2_1_final');
modelDir = fullfile(baseDir,'01_models');
fmuDir = fullfile(baseDir,'05_fmu');
ifaceDir = fullfile(projectRoot,'work','simulation','implementation_binding','components');
addpath(modelDir);
for k = 1:numel(selectedCodes)
    model = ['L2_' char(selectedCodes{k})];
    iface = jsondecode(fileread(fullfile(ifaceDir,[model '_executable_interface.json'])));
    modelPath = fullfile(modelDir,[model '.slx']);
    fmuPath = fullfile(fmuDir,[model '.fmu']);
    load_system(modelPath);
    set_param(model,'SimulationCommand','update');
    inputs = normalize(iface.inputs);
    outputs = normalize(iface.outputs);
    args = {'FMIVersion','2.0','FMUType','CS','SaveDirectory',fmuDir, ...
        'FMUName',model,'AddIcon','off','CreateModelAfterGeneratingFMU','off', ...
        'SaveSourceCodeToFMU','off','DataTypeConversion','off','EnableFMUState','on'};
    if ~isempty(inputs), args=[args {'ExportedInputNames',{inputs.variable_name}}]; end %#ok<AGROW>
    if ~isempty(outputs), args=[args {'ExportedOutputNames',{outputs.variable_name}}]; end %#ok<AGROW>
    if isfile(fmuPath), delete(fmuPath); end
    exportToFMU(model,args{:});
    assert(isfile(fmuPath),'FMU not created: %s',fmuPath);
    close_system(model,0);
    fprintf('INCREMENTAL_FMU_EXPORT %s = PASS\n',model);
end
end

function a = normalize(v)
if isempty(v), a=struct([]); else, a=v(:); end
end
