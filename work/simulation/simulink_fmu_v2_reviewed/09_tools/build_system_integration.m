function build_system_integration(projectRoot)
%BUILD_SYSTEM_INTEGRATION Create All16 topology from 87 frozen connection records.
baseDir = fullfile(projectRoot,'work','simulation','simulink_fmu_v2_reviewed');
modelDir = fullfile(baseDir,'01_models');
integrationDir = fullfile(baseDir,'04_system_integration');
ifaceDir = fullfile(projectRoot,'work','simulation','implementation_binding','components');
masterPath = fullfile(projectRoot,'work','simulation','implementation_binding','Rail_MBSE_Executable_FMU_Interface_v1.json');
data = jsondecode(fileread(masterPath));
connections = data.executable_signal_connections(:);
assert(numel(connections)==87,'Expected 87 executable connection records.');
addpath(modelDir);

componentFiles = dir(fullfile(ifaceDir,'L2_*_executable_interface.json'));
assert(numel(componentFiles)==16,'Expected 16 component interfaces.');
inputPorts = containers.Map('KeyType','char','ValueType','double');
outputPorts = containers.Map('KeyType','char','ValueType','double');
components = cell(numel(componentFiles),1);
for i=1:numel(componentFiles)
    c = jsondecode(fileread(fullfile(componentFiles(i).folder,componentFiles(i).name)));
    component = char(c.ssd_component); components{i}=component;
    ins=normalizeStructArray(c.inputs); outs=normalizeStructArray(c.outputs);
    for j=1:numel(ins), inputPorts([component '|' char(ins(j).variable_name)])=j; end
    for j=1:numel(outs), outputPorts([component '|' char(outs(j).variable_name)])=j; end
end

model = 'Rail_MBSE_All16_Integrated_v2';
modelPath = fullfile(integrationDir,[model '.slx']);
if bdIsLoaded(model), close_system(model,0); end
if isfile(modelPath), delete(modelPath); end
new_system(model,'Model');
set_param(model,'SolverType','Fixed-step','Solver','FixedStepDiscrete','FixedStep','0.01', ...
    'StopTime','50','ReturnWorkspaceOutputs','on','SignalLogging','on','SignalLoggingName','logsout', ...
    'SaveTime','on','TimeSaveName','tout');
set_param(model,'Description',['All16 executable integration generated from 87 frozen executable connection records. ' ...
    '77 unique target-input causal signals are realized once; 10 duplicate structural trace records are retained as trace aliases.']);

blocks = containers.Map('KeyType','char','ValueType','char');
for i=1:numel(components)
    component=components{i}; row=mod(i-1,4); col=floor((i-1)/4);
    block=[model '/' component];
    add_block('built-in/ModelReference',block,'ModelName',component, ...
        'Position',[120+420*col 90+230*row 330+420*col 190+230*row]);
    blocks(component)=block;
end

seen = containers.Map('KeyType','char','ValueType','double');
audit = cell(numel(connections),1);
causalCount=0; aliasCount=0;
for i=1:numel(connections)
    c=connections(i); sourceComponent=char(c.source_component); targetComponent=char(c.target_component);
    sourceVariable=char(c.source_variable); targetVariable=char(c.target_variable);
    key=[sourceComponent '|' sourceVariable '|' targetComponent '|' targetVariable];
    sourceBlock=blocks(sourceComponent); targetBlock=blocks(targetComponent);
    sourcePH=get_param(sourceBlock,'PortHandles'); targetPH=get_param(targetBlock,'PortHandles');
    sourceHandle=sourcePH.Outport(outputPorts([sourceComponent '|' sourceVariable]));
    if ~isKey(seen,key)
        seen(key)=1; causalCount=causalCount+1;
        delayName=sprintf('Connection_%03d',i); delayPath=[model '/' delayName];
        add_block('simulink/Discrete/Unit Delay',delayPath,'SampleTime','0.01','InitialCondition','0', ...
            'Position',[350+20*mod(i,8) 30+12*i 390+20*mod(i,8) 60+12*i]);
        delayPH=get_param(delayPath,'PortHandles');
        add_line(model,sourceHandle,delayPH.Inport(1),'autorouting','on');
        targetHandle=targetPH.Inport(inputPorts([targetComponent '|' targetVariable]));
        line=add_line(model,delayPH.Outport(1),targetHandle,'autorouting','on');
        set_param(line,'Name',[targetComponent '__' targetVariable]);
        try, set_param(delayPH.Outport(1),'DataLogging','on'); catch, end
        realization='CAUSAL_INPUT_WITH_UNIT_DELAY'; realizationBlock=delayPath;
    else
        seen(key)=seen(key)+1; aliasCount=aliasCount+1;
        sinkName=sprintf('TraceAlias_%03d',i); sinkPath=[model '/' sinkName];
        add_block('simulink/Sinks/Terminator',sinkPath,'Position',[650 30+12*i 680 60+12*i]);
        sinkPH=get_param(sinkPath,'PortHandles');
        line=add_line(model,sourceHandle,sinkPH.Inport(1),'autorouting','on');
        set_param(line,'Name',['trace_alias_' num2str(i)]);
        realization='TRACE_EQUIVALENT_DUPLICATE'; realizationBlock=sinkPath;
    end
    audit{i}=struct('executable_connection_id',char(c.executable_connection_id), ...
        'source_component',sourceComponent,'source_variable',sourceVariable, ...
        'target_component',targetComponent,'target_variable',targetVariable, ...
        'realization',realization,'simulink_element',realizationBlock,'status','PASS');
end

monitorSpecs = {
    'L2_3100','out_omega_wheel';
    'L2_5100','out_dc_link_voltage';
    'L2_5100','out_dc_link_current';
    'L2_5100','out_regenerative_power_actual';
    'L2_5300','out_motor_speed';
    'L2_5300','out_motor_torque_actual';
    'L2_7200','out_T_brake';
    'L2_8100','out_achieved_dynamic_brake_force';
    'L2_X100','out_super_cap_soc';
    'L2_X100','out_ess_absorbed_power';
    'L2_D100','out_traction_command';
    'L2_D100','out_service_brake_request'};
for i=1:size(monitorSpecs,1)
    component=monitorSpecs{i,1}; variable=monitorSpecs{i,2};
    block=blocks(component); ph=get_param(block,'PortHandles');
    sourceHandle=ph.Outport(outputPorts([component '|' variable]));
    variableName=['mon_' component '_' variable];
    sink=[model '/' variableName];
    add_block('simulink/Sinks/To Workspace',sink,'VariableName',variableName, ...
        'SaveFormat','Timeseries','MaxDataPoints','5000', ...
        'Position',[1800 60+55*i 1950 90+55*i]);
    sph=get_param(sink,'PortHandles'); add_line(model,sourceHandle,sph.Inport(1),'autorouting','on');
end

set_param(model,'SimulationCommand','update');
save_system(model,modelPath); close_system(model,0);
audit=[audit{:}];
manifest=struct('expected_connection_records',87,'validated_connection_records',numel(audit), ...
    'unique_causal_connections',causalCount,'duplicate_trace_aliases',aliasCount, ...
    'all_status_pass',all(strcmp({audit.status},'PASS')),'connections',audit);
manifestPath=fullfile(integrationDir,'Executable_Connection_Audit_v2.json');
fid=fopen(manifestPath,'w'); assert(fid>=0,'Cannot write connection audit.');
fprintf(fid,'%s',jsonencode(manifest,PrettyPrint=true)); fclose(fid);
fprintf('EXECUTABLE_CONNECTIONS_EXPECTED = 87\n');
fprintf('EXECUTABLE_CONNECTIONS_CREATED = %d\n',numel(audit));
fprintf('UNIQUE_CAUSAL_SIGNAL_PATHS = %d\n',causalCount);
fprintf('TRACE_EQUIVALENT_DUPLICATES = %d\n',aliasCount);
end

function a=normalizeStructArray(value)
if isempty(value), a=struct([]); else, a=value(:); end
end
