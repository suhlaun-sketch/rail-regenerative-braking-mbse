function run_component_tests(projectRoot)
%RUN_COMPONENT_TESTS Compile and dynamically simulate all 16 generated models.
baseDir = fullfile(projectRoot,'work','simulation','simulink_fmu_v2_reviewed');
modelDir = fullfile(baseDir,'01_models');
ifaceDir = fullfile(projectRoot,'work','simulation','implementation_binding','components');
resultDir = fullfile(baseDir,'03_component_tests','results');
cacheDir = fullfile(baseDir,'logs','simulink_cache');
codeDir = fullfile(baseDir,'logs','simulink_codegen');
if ~exist(resultDir,'dir'), mkdir(resultDir); end
if ~exist(cacheDir,'dir'), mkdir(cacheDir); end
if ~exist(codeDir,'dir'), mkdir(codeDir); end
Simulink.fileGenControl('set','CacheFolder',cacheDir,'CodeGenFolder',codeDir,'createDir',true);
addpath(modelDir);
addpath(fullfile(baseDir,'02_parameters'));
[P,~] = Rail_MBSE_Simulation_Parameters_v2();

files = dir(fullfile(ifaceDir,'L2_*_executable_interface.json'));
records = cell(numel(files),1);
for k = 1:numel(files)
    iface = jsondecode(fileread(fullfile(files(k).folder,files(k).name)));
    code = char(iface.l2_code); model = ['L2_' code];
    inVars = normalizeStructArray(iface.inputs); outVars = normalizeStructArray(iface.outputs);
    modelPath = fullfile(modelDir,[model '.slx']);
    rec = struct('component',model,'model_file',modelPath,'load_status','FAIL', ...
        'update_status','FAIL','simulation_status','FAIL','finite_outputs',false, ...
        'port_interface_status','FAIL','dynamic_test_status','FAIL','status','FAIL', ...
        'port_counts',struct(),'external_names_match',false,'datatypes_match',false, ...
        'units_set_where_supported',0,'units_traced_where_not_supported',0, ...
        'output_ranges',struct(),'error','');
    try
        load_system(modelPath); rec.load_status = 'PASS';
        set_param(model,'SimulationCommand','update'); rec.update_status = 'PASS';
        actualIn = find_system(model,'SearchDepth',1,'BlockType','Inport');
        actualOut = find_system(model,'SearchDepth',1,'BlockType','Outport');
        if ~isempty(actualIn), [~,ix] = sort(str2double(get_param(actualIn,'Port'))); actualIn = actualIn(ix); end
        if ~isempty(actualOut), [~,ox] = sort(str2double(get_param(actualOut,'Port'))); actualOut = actualOut(ox); end
        if isempty(inVars), expectedIn = strings(0,1); else, expectedIn = string({inVars.variable_name})'; end
        if isempty(outVars), expectedOut = strings(0,1); else, expectedOut = string({outVars.variable_name})'; end
        actualInNames = string(cellfun(@(x)get_param(x,'Name'),actualIn,'UniformOutput',false));
        actualOutNames = string(cellfun(@(x)get_param(x,'Name'),actualOut,'UniformOutput',false));
        namesOk = numel(expectedIn)==numel(actualInNames) && numel(expectedOut)==numel(actualOutNames) && ...
            all(expectedIn(:)==actualInNames(:)) && all(expectedOut(:)==actualOutNames(:));
        typesOk = true; unitsSupported = 0; unitsUnsupported = 0;
        for i = 1:numel(inVars)
            typesOk = typesOk && strcmp(get_param(actualIn{i},'OutDataTypeStr'),slType(inVars(i).datatype));
            [ok,supported] = unitCheck(actualIn{i},char(inVars(i).unit));
            typesOk = typesOk && ok; unitsSupported = unitsSupported + supported; unitsUnsupported = unitsUnsupported + ~supported;
        end
        for i = 1:numel(outVars)
            typesOk = typesOk && strcmp(get_param(actualOut{i},'OutDataTypeStr'),slType(outVars(i).datatype));
            [ok,supported] = unitCheck(actualOut{i},char(outVars(i).unit));
            typesOk = typesOk && ok; unitsSupported = unitsSupported + supported; unitsUnsupported = unitsUnsupported + ~supported;
        end
        rec.port_counts = struct('inputs',numel(actualIn),'expected_inputs',numel(inVars), ...
            'outputs',numel(actualOut),'expected_outputs',numel(outVars));
        rec.external_names_match = namesOk;
        rec.datatypes_match = typesOk;
        rec.units_set_where_supported = unitsSupported;
        rec.units_traced_where_not_supported = unitsUnsupported;
        if namesOk && typesOk && numel(actualIn)==numel(inVars) && numel(actualOut)==numel(outVars)
            rec.port_interface_status = 'PASS';
        end

        t = (0:P.sample_time_s:10)';
        ds = Simulink.SimulationData.Dataset;
        for i = 1:numel(inVars)
            values = testProfile(char(inVars(i).variable_name),char(inVars(i).datatype),t);
            ds = ds.addElement(timeseries(values,t),char(inVars(i).variable_name));
        end
        simIn = Simulink.SimulationInput(model);
        if numel(inVars)>0, simIn = simIn.setExternalInput(ds); end
        simIn = simIn.setModelParameter('StopTime','10','CaptureErrors','on');
        simOut = sim(simIn);
        if ~isempty(simOut.ErrorMessage), error('%s',simOut.ErrorMessage); end
        rec.simulation_status = 'PASS';
        tableOut = table(t,'VariableNames',{'time'});
        finite = true; outputRanges = struct();
        if numel(outVars)>0
            yout = simOut.yout;
            for i = 1:numel(outVars)
                element = yout.getElement(i);
                values = squeeze(element.Values.Data);
                if size(values,1) ~= numel(t), values = reshape(values,[],1); end
                name = char(outVars(i).variable_name);
                tableOut.(name) = values;
                finite = finite && all(isfinite(double(values(:))));
                outputRanges.(matlab.lang.makeValidName(name)) = double(max(values(:))-min(values(:)));
            end
        end
        writetable(tableOut,fullfile(resultDir,[model '_component_test.csv']));
        rec.finite_outputs = finite;
        rec.output_ranges = outputRanges;
        rec.dynamic_test_status = dynamicCriterion(code,tableOut);
        if strcmp(rec.load_status,'PASS') && strcmp(rec.update_status,'PASS') && ...
                strcmp(rec.simulation_status,'PASS') && rec.finite_outputs && ...
                strcmp(rec.port_interface_status,'PASS') && strcmp(rec.dynamic_test_status,'PASS')
            rec.status = 'PASS';
        end
        close_system(model,0);
    catch ME
        rec.error = getReport(ME,'extended','hyperlinks','off');
        if bdIsLoaded(model), close_system(model,0); end
    end
    records{k} = rec;
    fprintf('COMPONENT_TEST %s = %s\n',model,rec.status);
end
records = [records{:}];
jsonPath = fullfile(baseDir,'03_component_tests','Component_Test_Results_v2.json');
fid = fopen(jsonPath,'w'); assert(fid>=0,'Cannot write component test results.');
fprintf(fid,'%s',jsonencode(records,PrettyPrint=true)); fclose(fid);
passCount = sum(strcmp({records.status},'PASS'));
writeReport(fullfile(baseDir,'03_component_tests','Component_Test_Report_v2.md'),records,passCount);
fprintf('SIMULINK_COMPONENT_TESTS_PASS = %d/16\n',passCount);
if passCount ~= 16, error('Component test gate failed: %d/16',passCount); end
end

function a = normalizeStructArray(value)
if isempty(value), a = struct([]); else, a = value(:); end
end

function type = slType(fmiType)
switch char(fmiType)
    case 'Float64', type = 'double';
    case 'Int32', type = 'int32';
    case 'Boolean', type = 'boolean';
    otherwise, error('Unsupported type %s',char(fmiType));
end
end

function [ok,supported] = unitCheck(block,expected)
try
    actual = get_param(block,'Unit');
    supported = strcmp(actual,expected);
    if supported
        ok = true;
    else
        attr = get_param(block,'AttributesFormatString');
        ok = contains(attr,['Frozen unit: ' expected]);
    end
catch
    supported = false;
    attr = get_param(block,'AttributesFormatString');
    ok = contains(attr,['Frozen unit: ' expected]);
end
end

function values = testProfile(name,type,t)
n = numel(t);
switch type
    case 'Boolean'
        values = true(n,1);
        if contains(name,'fault_reset') || contains(name,'emergency'), values(:) = false; end
    case 'Int32'
        values = int32(ones(n,1));
        if contains(name,'fault'), values(:) = int32(0); end
    otherwise
        values = 0.2*ones(n,1);
        if contains(name,'U_ac'), values(:)=25000;
        elseif contains(name,'U_sec'), values(:)=1500;
        elseif contains(name,'dc_link_voltage'), values(:)=1800;
        elseif contains(name,'U_motor'), values(:)=900;
        elseif contains(name,'f_motor'), values(:)=70; values(t>=5)=30;
        elseif contains(name,'f_ac') || contains(name,'f_sec'), values(:)=50;
        elseif contains(name,'pressure'), values(:)=900000;
        elseif contains(name,'available_charge_power'), values(:)=600000;
        elseif contains(name,'available_discharge_power'), values(:)=400000;
        elseif contains(name,'dynamic_brake_force'), values(:)=60000;
        elseif contains(name,'regenerative_power'), values(:)=300000;
        elseif contains(name,'ess_power_request'), values(:)=300000; values(t>=5)=-100000;
        elseif contains(name,'motor_torque_request') || contains(name,'motor_torque_actual'), values(:)=4000; values(t>=5)=-4000;
        elseif contains(name,'T_shaft'), values(:)=4000; values(t>=5)=-2000;
        elseif contains(name,'T_brake'), values(:)=0; values(t>=5)=2500;
        elseif contains(name,'omega') || contains(name,'motor_speed'), values(:)=100;
        elseif contains(name,'service_brake_request'), values(:)=0; values(t>=5)=1.0;
        elseif contains(name,'traction_command'), values(:)=1; values(t>=5)=0;
        elseif contains(name,'soc'), values(:)=0.5;
        elseif contains(name,'voltage'), values(:)=1800;
        elseif contains(name,'current') || contains(name,'I_'), values(:)=100;
        end
end
end

function status = dynamicCriterion(code,T)
status = 'PASS';
switch code
    case '3100', ok = range(double(T.out_omega_wheel)) > 0.01;
    case '3500', ok = range(double(T.out_T_shaft)) > 1;
    case '5100', ok = max(double(T.out_regenerative_power_actual)) > 1 && range(double(T.out_f_motor_e)) > 1;
    case '5300', ok = range(double(T.out_motor_torque_actual)) > 1;
    case '7200', ok = max(double(T.out_T_brake)) > 1;
    case 'X100', ok = range(double(T.out_super_cap_soc)) > 1e-4;
    otherwise, ok = true;
end
if ~ok, status = 'FAIL'; end
end

function writeReport(path,records,passCount)
fid = fopen(path,'w'); assert(fid>=0,'Cannot write report.'); c = onCleanup(@() fclose(fid));
fprintf(fid,'# Component Test Report\n\n');
fprintf(fid,'Generated from actual MATLAB/Simulink load, update-diagram and simulation execution.\n\n');
fprintf(fid,'- Components tested: 16\n- Tests passed: %d\n- Tests failed: %d\n\n',passCount,16-passCount);
fprintf(fid,'| Component | Load | Update | Simulation | Interface | Finite | Dynamic | Overall |\n');
fprintf(fid,'|---|---|---|---|---|---|---|---|\n');
for i=1:numel(records)
    r=records(i); fprintf(fid,'| %s | %s | %s | %s | %s | %s | %s | %s |\n', ...
        r.component,r.load_status,r.update_status,r.simulation_status,r.port_interface_status, ...
        string(r.finite_outputs),r.dynamic_test_status,r.status);
end
fprintf(fid,'\nCore dynamic gates cover torque/speed response, motoring-to-regeneration transition, brake blending response, and supercapacitor charge/discharge SOC response.\n');
end
