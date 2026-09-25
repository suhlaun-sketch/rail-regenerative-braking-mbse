function build_all16_models(projectRoot,selectedCodes)
%BUILD_ALL16_MODELS Generate executable discrete Simulink models from the frozen interface.
if nargin < 2, selectedCodes = {}; end
baseDir = fullfile(projectRoot,'work','simulation','simulink_fmu_v2_1_final');
interfaceDir = fullfile(projectRoot,'work','simulation','implementation_binding','components');
modelDir = fullfile(baseDir,'01_models');
parameterDir = fullfile(baseDir,'02_parameters');
addpath(parameterDir);
[P, metadata] = Rail_MBSE_Simulation_Parameters_v2();

parameterJson = fullfile(parameterDir,'Rail_MBSE_Simulation_Parameters_v2.json');
fid = fopen(parameterJson,'w'); assert(fid>=0,'Cannot write parameter JSON.');
fprintf(fid,'%s',jsonencode(struct('parameters',P,'metadata',metadata),PrettyPrint=true)); fclose(fid);

files = dir(fullfile(interfaceDir,'L2_*_executable_interface.json'));
assert(numel(files)==16,'Expected 16 component interface JSON files.');
fullBuild = isempty(selectedCodes);
if ~fullBuild
    selectedCodes = cellstr(string(selectedCodes));
    keep = false(numel(files),1);
    for q = 1:numel(files)
        probe = jsondecode(fileread(fullfile(files(q).folder,files(q).name)));
        keep(q) = any(strcmp(char(probe.l2_code),selectedCodes));
    end
    files = files(keep);
    assert(numel(files)==numel(selectedCodes),'Selected component code was not found.');
end
records = cell(numel(files),1);
for k = 1:numel(files)
    iface = jsondecode(fileread(fullfile(files(k).folder,files(k).name)));
    code = char(iface.l2_code);
    model = ['L2_' code];
    modelPath = fullfile(modelDir,[model '.slx']);
    if bdIsLoaded(model), close_system(model,0); end
    if isfile(modelPath), delete(modelPath); end
    new_system(model,'Model');
    set_param(model, ...
        'SolverType','Fixed-step','Solver','FixedStepDiscrete', ...
        'FixedStep',num2str(P.sample_time_s,17),'StopTime','50', ...
        'SaveTime','on','TimeSaveName','tout','SaveOutput','on', ...
        'OutputSaveName','yout','SaveFormat','Dataset', ...
        'SignalLogging','on','SignalLoggingName','logsout', ...
        'ReturnWorkspaceOutputs','on','SimulationMode','normal');
    set_param(model,'Description',sprintf(['Rail MBSE executable component %s. ' ...
        'Root ports are unchanged from Rail_MBSE_Executable_FMU_Interface_v1.json; internal behavior is physical-consistency review v2.'],model));

    inVars = normalizeStructArray(iface.inputs);
    outVars = normalizeStructArray(iface.outputs);
    monitorNames = internalMonitors(code);
    externalOutNames = arrayfun(@(x) string(x.variable_name),outVars,'UniformOutput',true);
    allOutNames = [externalOutNames(:); string(monitorNames(:))];

    clockPath = [model '/time_s'];
    add_block('simulink/Sources/Digital Clock',clockPath, ...
        'SampleTime',num2str(P.sample_time_s,17),'Position',[35 25 95 55]);
    behaviorPath = [model '/EngineeringBehavior'];
    add_block('simulink/User-Defined Functions/MATLAB Function',behaviorPath, ...
        'Position',[300 80 610 max(180,110+45*max(1,numel(allOutNames)))]);
    chart = find(sfroot,'-isa','Stateflow.EMChart','Path',behaviorPath);
    scriptText = behaviorScript(code,inVars,outVars,monitorNames,P);
    behaviorDir = fullfile(baseDir,'00_baseline','generated_behaviors');
    if ~exist(behaviorDir,'dir'), mkdir(behaviorDir); end
    scriptPath = fullfile(behaviorDir,[model '_behavior.m']);
    fidScript = fopen(scriptPath,'w'); assert(fidScript>=0,'Cannot write %s',scriptPath);
    fprintf(fidScript,'%s',scriptText); fclose(fidScript);
    chart.Script = scriptText;

    for i = 1:numel(inVars)
        name = char(inVars(i).variable_name);
        path = [model '/' name];
        add_block('simulink/Sources/In1',path,'Port',num2str(i), ...
            'OutDataTypeStr',slType(inVars(i).datatype), ...
            'SampleTime',num2str(P.sample_time_s,17), ...
            'Position',[35 90+45*i 165 110+45*i]);
        setUnitOrTrace(path,char(inVars(i).unit),char(inVars(i).quantity));
    end
    for i = 1:numel(outVars)
        name = char(outVars(i).variable_name);
        path = [model '/' name];
        add_block('simulink/Sinks/Out1',path,'Port',num2str(i), ...
            'OutDataTypeStr',slType(outVars(i).datatype), ...
            'Position',[760 90+45*i 890 110+45*i]);
        setUnitOrTrace(path,char(outVars(i).unit),char(outVars(i).quantity));
    end

    if ~strcmp(code,'8100')
        try
            set_param(model,'SimulationCommand','update');
        catch ME
            fprintf(2,'MODEL_UPDATE_DIAGNOSTIC %s\n%s\n',model,getReport(ME,'extended','hyperlinks','off'));
            try
                lastError = sllasterror;
                fprintf(2,'SIMULINK_LAST_ERROR %s\n',jsonencode(lastError,PrettyPrint=true));
            catch
            end
            rethrow(ME);
        end
    end
    ph = get_param(behaviorPath,'PortHandles');
    clockPh = get_param(clockPath,'PortHandles');
    add_line(model,clockPh.Outport(1),ph.Inport(1),'autorouting','on');
    if strcmp(code,'8100')
        typeNames = {'Float64','Int32','Boolean'};
        muxNames = {'DoubleInputs','Int32Inputs','BooleanInputs'};
        demuxNames = {'DoubleOutputs','Int32Outputs','BooleanOutputs'};
        for t = 1:numel(typeNames)
            inputIdx = find(arrayfun(@(x) strcmp(char(x.datatype),typeNames{t}),inVars));
            muxPath = [model '/' muxNames{t}];
            add_block('simulink/Signal Routing/Mux',muxPath,'Inputs',num2str(numel(inputIdx)), ...
                'Position',[210 120+160*(t-1) 215 145+160*(t-1)]);
            mph = get_param(muxPath,'PortHandles');
            for j = 1:numel(inputIdx)
                i = inputIdx(j);
                iph = get_param([model '/' char(inVars(i).variable_name)],'PortHandles');
                add_line(model,iph.Outport(1),mph.Inport(j),'autorouting','on');
            end
            add_line(model,mph.Outport(1),ph.Inport(t+1),'autorouting','on');

            outputIdx = find(arrayfun(@(x) strcmp(char(x.datatype),typeNames{t}),outVars));
            demuxPath = [model '/' demuxNames{t}];
            add_block('simulink/Signal Routing/Demux',demuxPath,'Outputs',num2str(numel(outputIdx)), ...
                'Position',[660 120+160*(t-1) 665 145+160*(t-1)]);
            dph = get_param(demuxPath,'PortHandles');
            add_line(model,ph.Outport(t),dph.Inport(1),'autorouting','on');
            for j = 1:numel(outputIdx)
                i = outputIdx(j);
                oph = get_param([model '/' char(outVars(i).variable_name)],'PortHandles');
                line = add_line(model,dph.Outport(j),oph.Inport(1),'autorouting','on');
                set_param(line,'Name',char(outVars(i).variable_name));
            end
        end
        monitorOffset = 3;
    else
        for i = 1:numel(inVars)
            iph = get_param([model '/' char(inVars(i).variable_name)],'PortHandles');
            add_line(model,iph.Outport(1),ph.Inport(i+1),'autorouting','on');
        end
        for i = 1:numel(outVars)
            oph = get_param([model '/' char(outVars(i).variable_name)],'PortHandles');
            line = add_line(model,ph.Outport(i),oph.Inport(1),'autorouting','on');
            set_param(line,'Name',char(outVars(i).variable_name));
        end
        monitorOffset = numel(outVars);
    end
    for i = 1:numel(monitorNames)
        mon = char(monitorNames{i});
        sink = [model '/' mon '_sink'];
        add_block('simulink/Sinks/Terminator',sink, ...
            'Position',[760 130+45*(numel(outVars)+i) 790 150+45*(numel(outVars)+i)]);
        sph = get_param(sink,'PortHandles');
        line = add_line(model,ph.Outport(monitorOffset+i),sph.Inport(1),'autorouting','on');
        set_param(line,'Name',mon);
        try
            set_param(ph.Outport(monitorOffset+i),'DataLogging','on');
        catch
            % Named internal signal remains available for simulation tracing.
        end
    end
    set_param(model,'SimulationCommand','update');
    save_system(model,modelPath);
    close_system(model,0);
    records{k} = struct('component',model,'model_file',modelPath, ...
        'inputs',numel(inVars),'outputs',numel(outVars), ...
        'internal_monitors',{monitorNames},'fidelity',fidelity(code), ...
        'build_status','PASS');
    fprintf('MODEL_BUILT = %s (%d inputs, %d outputs)\n',model,numel(inVars),numel(outVars));
end
records = [records{:}];
if fullBuild
    manifestPath = fullfile(baseDir,'00_baseline','Simulink_Model_Build_Manifest_v2.json');
    fid = fopen(manifestPath,'w'); assert(fid>=0,'Cannot write build manifest.');
    fprintf(fid,'%s',jsonencode(records,PrettyPrint=true)); fclose(fid);
    fprintf('SIMULINK_MODELS_BUILT = %d/16\n',numel(records));
else
    fprintf('SIMULINK_MODELS_INCREMENTAL = %d/%d\n',numel(records),numel(selectedCodes));
end
end

function a = normalizeStructArray(value)
if isempty(value), a = struct([]); else, a = value(:); end
end

function type = slType(fmiType)
switch char(fmiType)
    case 'Float64', type = 'double';
    case 'Int32', type = 'int32';
    case 'Boolean', type = 'boolean';
    otherwise, error('Unsupported frozen datatype %s',char(fmiType));
end
end

function setUnitOrTrace(blockPath,unit,quantity)
try
    set_param(blockPath,'Unit',unit);
catch
    set_param(blockPath,'AttributesFormatString',sprintf('Frozen unit: %s\nQuantity: %s',unit,quantity));
end
end

function names = internalMonitors(code)
switch code
    case '3100', names = {'internal_v_train'};
    case '3500', names = {'internal_driveline_loss_power'};
    case '3600', names = {'internal_sensor_residual'};
    case '3800', names = {'internal_adhesion_coefficient'};
    case '4100', names = {'internal_contact_quality','internal_pantograph_power'};
    case '4200', names = {'internal_line_power','internal_hv_available'};
    case '4400', names = {'internal_return_temperature'};
    case '4500', names = {'internal_transformer_primary_power','internal_transformer_secondary_power','internal_transformer_loss_power'};
    case '5100', names = {'internal_Pdc_signed','internal_Pmotor_electrical','internal_Ptransformer_request','internal_converter_supply_available'};
    case '5300', names = {'internal_Pmechanical','internal_Pelectrical'};
    case '7100', names = {'internal_compressor_duty'};
    case '7200', names = {'internal_Fmechanical','internal_Ftotal_actual','internal_brake_tracking_error'};
    case '8100', names = {'internal_brake_demand_force','internal_regen_fade'};
    case 'D100', names = {'internal_scenario_phase'};
    case 'E100', names = {'internal_safety_permit'};
    case 'X100', names = {'internal_Ucap_equivalent','internal_Uterminal','internal_Icap','internal_SOC_energy','internal_Esc_kJ','internal_Eregen_kJ'};
    otherwise, names = {'internal_monitor'};
end
end

function level = fidelity(code)
if any(strcmp(code,{'3100','3500','5100','5300','7200','X100'}))
    level = 'FIDELITY_A';
elseif any(strcmp(code,{'4200','4500'}))
    level = 'FIDELITY_B';
else
    level = 'FIDELITY_C';
end
end

function script = behaviorScript(code,inVars,outVars,monitorNames,P)
inNames = arrayfun(@(x) string(x.variable_name),inVars,'UniformOutput',true);
outNames = arrayfun(@(x) string(x.variable_name),outVars,'UniformOutput',true);
allOut = [outNames(:); string(monitorNames(:))];
args = ["time_s"; inNames(:)];
lines = strings(0,1);
compact8100 = strcmp(code,'8100');
if compact8100
    lines(end+1,1) = "function [yDouble, yInt32, yBoolean, internal_brake_demand_force, internal_regen_fade] = behavior(time_s, uDouble, uInt32, uBoolean)";
else
    continuation = ", ..." + newline + "    ";
    lines(end+1,1) = "function [" + strjoin(allOut,continuation) + "] = behavior(" + strjoin(args,continuation) + ")";
end
lines(end+1,1) = "%#codegen";
if compact8100
    typeNames = {'Float64','Int32','Boolean'};
    vectorNames = {'uDouble','uInt32','uBoolean'};
    for t = 1:numel(typeNames)
        idx = 0;
        for i = 1:numel(inVars)
            if strcmp(char(inVars(i).datatype),typeNames{t})
                idx = idx + 1;
                lines(end+1,1) = string(inVars(i).variable_name) + " = " + vectorNames{t} + "(" + idx + ");";
            end
        end
    end
end
for i = 1:numel(outVars)
    name = string(outVars(i).variable_name);
    switch char(outVars(i).datatype)
        case 'Float64', init = '0.0';
        case 'Int32', init = 'int32(0)';
        case 'Boolean', init = 'false';
    end
    lines(end+1,1) = name + " = " + init + ";";
end
for i = 1:numel(monitorNames), lines(end+1,1) = string(monitorNames{i}) + " = 0.0;"; end
dt = num2str(P.sample_time_s,17);
switch code
    case '3100'
        lines = [lines; string({
            'persistent omega_w'; 'if isempty(omega_w), omega_w = 0.0; end';
            sprintf('dt = %s;',dt); sprintf('J = %.17g;',P.vehicle.equivalent_rotational_inertia_kgm2);
            sprintf('T_res = %.17g + %.17g*omega_w*omega_w;',P.vehicle.rolling_resistance_torque_Nm,P.vehicle.aero_torque_coefficient);
            'T_net = in_T_shaft - max(in_T_brake,0.0) - T_res;';
            'if omega_w <= 0.0 && T_net < 0.0, T_net = 0.0; end';
            'omega_w = max(0.0,omega_w + dt*T_net/J);';
            'out_omega_axle = omega_w;'; 'out_omega_gearbox = omega_w;';
            'out_omega_shaft = omega_w;'; 'out_omega_wheel = omega_w;';
            sprintf('internal_v_train = %.17g*omega_w;',P.vehicle.wheel_radius_m)})];
    case '3500'
        lines = [lines; string({
            sprintf('ratio = %.17g;',P.driveline.gear_ratio); sprintf('eta = %.17g;',P.driveline.efficiency);
            'out_T_shaft = ratio*eta*in_T_shaft;'; 'out_omega_shaft = ratio*in_omega_shaft;';
            'internal_driveline_loss_power = abs(in_T_shaft*out_omega_shaft)*(1.0-eta);'})];
    case '3600'
        lines = [lines; string({'persistent sensed;'; 'if isempty(sensed), sensed = 0.0; end';
            sprintf('sensed = sensed + %s*(in_omega_motor-sensed)/0.15;',dt);
            'out_motor_speed = sensed;'; 'internal_sensor_residual = in_omega_motor-sensed;'})];
    case '3800'
        lines = [lines; string({'persistent mu;'; 'if isempty(mu), mu = 0.25; end';
            'target = 0.25;'; 'if in_sanding_request, target = 0.33; end';
            sprintf('mu = mu + %s*(target-mu)/1.0;',dt); 'internal_adhesion_coefficient = mu;'})];
    case '4100'
        lines = [lines; string({'persistent panto raiseTimer;'; 'if isempty(panto), panto = int32(0); raiseTimer = 0.0; end';
            sprintf('dt = %s;',dt);
            sprintf('if in_pantograph_command > 0, raiseTimer = min(%.17g,raiseTimer+dt); else, raiseTimer = 0.0; panto = int32(0); end',P.line.pantograph_raise_delay_s);
            sprintf('if raiseTimer >= %.17g, panto = int32(1); end',P.line.pantograph_raise_delay_s);
            sprintf('out_U_ac_rms = double(panto)*max(0.0,%.17g-%.17g*abs(in_I_ac_rms));',P.line.voltage_V,P.line.voltage_drop_V_per_A);
            sprintf('out_f_ac = double(panto)*%.17g;',P.line.frequency_Hz);
            'out_pantograph_state = panto;'; 'internal_contact_quality = double(panto);';
            'internal_pantograph_power = out_U_ac_rms*in_I_ac_rms;'})];
    case '4200'
        lines = [lines; string({'persistent breaker closeTimer;'; 'if isempty(breaker), breaker = int32(0); closeTimer = 0.0; end';
            sprintf('dt = %s;',dt);
            sprintf('supplyValid = (in_pantograph_state > 0) && (in_U_ac_rms >= %.17g) && (in_f_ac >= %.17g) && (in_f_ac <= %.17g);',P.hv.primary_voltage_min_V,P.hv.frequency_min_Hz,P.hv.frequency_max_Hz);
            'safetyClosed = (in_hv_safety_loop_state > 0);'; 'downstreamTrip = (in_hv_system_fault ~= 0);';
            'cmd = int32(safetyClosed && supplyValid && ~downstreamTrip);'; 'out_hv_breaker_command = cmd;';
            sprintf('if cmd > 0, closeTimer = min(%.17g,closeTimer+dt); else, closeTimer = 0.0; breaker = int32(0); end',P.hv.breaker_close_delay_s);
            sprintf('if closeTimer >= %.17g, breaker = int32(1); end',P.hv.breaker_close_delay_s);
            'out_hv_breaker_state = breaker;';
            'trueFault = ((in_pantograph_state > 0) && ~supplyValid) || downstreamTrip;';
            'out_hv_system_fault = int32(trueFault);';
            'out_pantograph_command = int32(1);'; 'out_U_ac_rms = double(breaker)*in_U_ac_rms;';
            'out_f_ac = double(breaker)*in_f_ac;'; 'out_I_ac_rms = double(breaker)*in_I_ac_rms;';
            'out_line_voltage = out_U_ac_rms;'; 'out_line_current = out_I_ac_rms;';
            'internal_line_power = out_line_voltage*out_line_current;'; 'internal_hv_available = double(breaker > 0 && ~trueFault);'})];
    case '4400'
        lines = [lines; string({'persistent temperature;'; 'if isempty(temperature), temperature = 25.0; end';
            sprintf('temperature = temperature + %s*(25.0-temperature)/30.0;',dt);
            'internal_return_temperature = temperature;'})];
    case '4500'
        lines = [lines; string({sprintf('ratio = %.17g;',P.transformer.ratio_secondary_to_primary);
            sprintf('eta = %.17g;',P.transformer.efficiency);
            sprintf('primaryValid = (in_U_ac_rms >= %.17g) && (in_f_ac >= %.17g) && (in_f_ac <= %.17g);',P.transformer.primary_voltage_min_V,P.transformer.frequency_min_Hz,P.transformer.frequency_max_Hz);
            'enabled = (in_hv_breaker_state > 0) && (in_hv_system_fault == 0) && primaryValid;';
            'out_U_sec_rms = double(enabled)*ratio*in_U_ac_rms;';
            'out_f_sec = double(enabled)*in_f_ac;';
            'out_I_ac_rms = double(enabled)*in_I_sec_rms*ratio/eta;';
            'out_hv_system_fault = int32((in_hv_breaker_state > 0) && ~primaryValid);';
            'internal_transformer_primary_power = in_U_ac_rms*out_I_ac_rms;';
            'internal_transformer_secondary_power = out_U_sec_rms*in_I_sec_rms;';
            'internal_transformer_loss_power = max(internal_transformer_primary_power-internal_transformer_secondary_power,0.0);'})];
    case '5100'
        lines = [lines; string({'persistent Edc;'; 'if isempty(Edc), Edc = 0.0; end';
            sprintf('dt = %s;',dt); sprintf('pmax = %.17g;',P.converter.power_limit_W);
            sprintf('Cdc = %.17g; Umax = %.17g;',P.converter.dc_link_capacitance_F,P.converter.dc_voltage_max_V);
            sprintf('supplyValid = (in_U_sec_rms >= %.17g) && (in_f_sec >= %.17g) && (in_f_sec <= %.17g);',P.converter.secondary_voltage_min_V,P.converter.secondary_frequency_min_Hz,P.converter.secondary_frequency_max_Hz);
            'Udc = sqrt(max(0.0,2.0*Edc/Cdc));';
            sprintf('inverterReady = supplyValid && (Udc >= %.17g) && (Udc <= Umax);',P.converter.dc_voltage_min_operating_V);
            sprintf('Treq = min(%.17g,max(-%.17g,in_motor_torque_request));',P.motor.torque_limit_Nm,P.motor.torque_limit_Nm);
            'if Treq >= 0.0 && ~inverterReady, Treq = 0.0; end';
            'if Treq < 0.0 && Udc >= Umax, Treq = 0.0; end';
            sprintf('slip = Treq/%.17g;',P.motor.torque_slip_gain_Nm_per_radps);
            sprintf('if Treq ~= 0.0, out_f_motor_e = %.17g*(in_motor_speed+slip)/(2.0*pi); else, out_f_motor_e = 0.0; end',P.motor.pole_pairs);
            sprintf('if Treq ~= 0.0 && Udc >= %.17g, out_U_motor_ll_rms = min(0.9*Udc,max(%.17g,abs(out_f_motor_e)*8.0)); else, out_U_motor_ll_rms = 0.0; end',P.converter.dc_voltage_min_operating_V,P.motor.minimum_operating_voltage_V);
            'Pmech = in_motor_torque_actual*in_motor_speed;';
            sprintf('if Pmech >= 0.0, PmotorElec = Pmech/%.17g; else, PmotorElec = Pmech*%.17g; end',P.motor.efficiency_motoring,P.motor.efficiency_generating);
            sprintf('if PmotorElec >= 0.0, PdcSigned = PmotorElec/%.17g; else, PdcSigned = PmotorElec*%.17g; end',P.converter.inverter_efficiency_motoring,P.converter.inverter_efficiency_generating);
            'Ptr = min(pmax,max(PdcSigned,0.0));'; 'Preg = min(pmax,max(-PdcSigned,0.0));';
            sprintf('targetU = %.17g*in_U_sec_rms;',P.converter.rectifier_voltage_gain);
            'Etarget = 0.5*Cdc*targetU*targetU;';
            sprintf('if supplyValid, Pprecharge = min(%.17g,max(0.0,(Etarget-Edc)/%.17g)); else, Pprecharge = 0.0; end',P.converter.precharge_power_limit_W,P.converter.precharge_time_constant_s);
            sprintf('if supplyValid, PsecondaryRequest = min(pmax,(Ptr+Pprecharge+%.17g)/%.17g); else, PsecondaryRequest = 0.0; end',P.converter.dc_link_bleed_power_W,P.converter.front_end_efficiency);
            'if supplyValid, out_I_sec_rms = PsecondaryRequest/in_U_sec_rms; else, out_I_sec_rms = 0.0; end';
            sprintf('PfromSupply = in_U_sec_rms*out_I_sec_rms*%.17g;',P.converter.front_end_efficiency);
            sprintf('out_grid_acceptable_regenerative_power = %.17g;',P.converter.grid_regen_acceptance_W);
            'out_grid_returned_power = min(Preg,out_grid_acceptable_regenerative_power);';
            'out_regenerative_power_actual = Preg;';
            sprintf('PessSink = min(max(Preg-out_grid_returned_power,0.0),%.17g);',P.supercap.charge_power_limit_W);
            'out_brake_resistor_dissipated_power = max(Preg-out_grid_returned_power-PessSink,0.0);';
            sprintf('Pbleed = double(Edc > 0.0)*%.17g;',P.converter.dc_link_bleed_power_W);
            'Pnet = PfromSupply + Preg - Ptr - PessSink - out_grid_returned_power - out_brake_resistor_dissipated_power - Pbleed;';
            'Edc = min(0.5*Cdc*Umax*Umax,max(0.0,Edc+Pnet*dt));'; 'Udc = sqrt(max(0.0,2.0*Edc/Cdc));';
            'out_dc_link_voltage = Udc;';
            sprintf('if Udc >= %.17g, out_dc_link_current = (Ptr-Preg)/Udc; else, out_dc_link_current = 0.0; end',0.25*P.converter.dc_voltage_min_operating_V);
            'out_traction_converter_fault = int32(~isfinite(Udc) || Udc > Umax*1.01);';
            'internal_Pdc_signed = Ptr-Preg;'; 'internal_Pmotor_electrical = PmotorElec;';
            'internal_Ptransformer_request = PsecondaryRequest;'; 'internal_converter_supply_available = double(inverterReady);'})];
    case '5300'
        lines = [lines; string({'persistent torque;'; 'if isempty(torque), torque = 0.0; end'; sprintf('dt = %s;',dt);
            sprintf('wsync = 2.0*pi*in_f_motor_e/%.17g;',P.motor.pole_pairs);
            sprintf('targetT = %.17g*(wsync-in_omega_shaft);',P.motor.torque_slip_gain_Nm_per_radps);
            sprintf('targetT = min(%.17g,max(-%.17g,targetT));',P.motor.torque_limit_Nm,P.motor.torque_limit_Nm);
            sprintf('energized = (in_U_motor_ll_rms >= %.17g);',P.motor.minimum_operating_voltage_V);
            'if ~energized, targetT = 0.0; end';
            sprintf('vVehicle = abs(in_omega_shaft)*%.17g/%.17g;',P.vehicle.wheel_radius_m,P.driveline.gear_ratio);
            sprintf('xFade = min(1.0,max(0.0,(vVehicle-%.17g)/(%.17g-%.17g)));',P.brake.regen_cutoff_low_mps,P.brake.regen_cutoff_high_mps,P.brake.regen_cutoff_low_mps);
            'regenFade = xFade*xFade*(3.0-2.0*xFade);'; 'if targetT < 0.0, targetT = targetT*regenFade; end';
            sprintf('if energized, tau = %.17g; else, tau = %.17g; end',P.motor.time_constant_s,P.motor.deenergized_time_constant_s);
            'alpha = 1.0-exp(-dt/tau);'; 'torque = torque + alpha*(targetT-torque);';
            'out_T_shaft = torque;'; 'out_motor_torque_actual = torque;';
            'out_motor_speed = in_omega_shaft;'; 'out_omega_motor = in_omega_shaft;';
            'out_motor_phase_voltage = in_U_motor_ll_rms/sqrt(3.0);';
            'Pshaft = torque*in_omega_shaft;';
            sprintf('if Pshaft >= 0.0, Pelec = Pshaft/%.17g; else, Pelec = Pshaft*%.17g; end',P.motor.efficiency_motoring,P.motor.efficiency_generating);
            sprintf('if abs(in_U_motor_ll_rms) >= %.17g, out_I_motor_rms = abs(Pelec)/(sqrt(3.0)*abs(in_U_motor_ll_rms)); else, out_I_motor_rms = 0.0; end',P.motor.minimum_operating_voltage_V);
            'internal_Pmechanical = Pshaft;'; 'internal_Pelectrical = Pelec;'})];
    case '7100'
        lines = [lines; string({'persistent pressure;'; sprintf('if isempty(pressure), pressure = %.17g; end',P.pneumatic.reservoir_pressure_nominal_Pa);
            sprintf('pressure = pressure + %s*(%.17g-pressure)/8.0;',dt,P.pneumatic.reservoir_pressure_nominal_Pa);
            'out_main_reservoir_pressure = pressure;';
            sprintf('internal_compressor_duty = double(pressure < %.17g);',0.9*P.pneumatic.reservoir_pressure_nominal_Pa)})];
    case '7200'
        lines = [lines; string({'persistent pcyl FmechState prevFtotal;'; 'if isempty(pcyl), pcyl = 0.0; FmechState = 0.0; prevFtotal = 0.0; end'; sprintf('dt = %s;',dt);
            sprintf('amax = %.17g;',P.brake.max_service_deceleration_mps2); sprintf('mass = %.17g;',P.brake.vehicle_mass_kg);
            'demand = min(amax,max(0.0,in_service_brake_request));';
            'if in_emergency_brake_request || in_safety_brake_request > 0, demand = amax; end';
            'Ftotal = mass*demand;';
            'Fdyn = 0.0;'; 'if in_dynamic_brake_availability, Fdyn = min(Ftotal,max(0.0,in_available_dynamic_brake_force)); end';
            'out_dynamic_brake_force_request = Fdyn;';
            'FregenActual = max(0.0,in_achieved_dynamic_brake_force);'; 'Ftarget = max(Ftotal-FregenActual,0.0);'; 'FstateTarget = Ftarget;';
            sprintf('vWheel = abs(in_omega_wheel)*%.17g;',P.brake.wheel_radius_m);
            sprintf('if vWheel < %.17g, FstateTarget = max(FstateTarget,Ftotal-Fdyn); end',P.brake.regen_cutoff_high_mps);
            sprintf('if FstateTarget >= FmechState, tauF = %.17g; else, tauF = %.17g; end',P.brake.mechanical_force_build_time_s,P.brake.mechanical_force_release_time_s);
            sprintf('if (vWheel < %.17g) && (FstateTarget > FmechState), tauF = %.17g; end',P.brake.regen_cutoff_high_mps,P.brake.low_speed_takeover_time_s);
            'if Ftotal < prevFtotal, FmechState = min(FmechState,Ftarget); end'; 'prevFtotal = Ftotal;';
            'alphaF = 1.0-exp(-dt/tauF);'; 'FmechState = FmechState + alphaF*(FstateTarget-FmechState);';
            'Fmech = min(max(FmechState,0.0),Ftarget);';
            sprintf('targetP = %.17g*min(1.0,Fmech/max(mass*amax,1.0));',P.brake.cylinder_pressure_max_Pa);
            sprintf('pcyl = pcyl + (1.0-exp(-dt/%.17g))*(targetP-pcyl);',P.brake.cylinder_time_constant_s);
            'out_brake_cylinder_pressure = pcyl;'; sprintf('out_T_brake = Fmech*%.17g;',P.brake.wheel_radius_m);
            'out_brake_availability = (in_main_reservoir_pressure > 600000.0) && (in_brake_safety_loop_state > 0);';
            'internal_Fmechanical = Fmech;'; 'internal_Ftotal_actual = Fmech+FregenActual;';
            'internal_brake_tracking_error = internal_Ftotal_actual-Ftotal;'})];
    case '8100'
        lines = [lines; string({sprintf('gear = %.17g;',P.driveline.gear_ratio); sprintf('eta = %.17g;',P.driveline.efficiency);
            sprintf('rw = %.17g;',P.vehicle.wheel_radius_m); sprintf('mass = %.17g;',P.brake.vehicle_mass_kg);
            'safety = (in_external_safety_system_state > 0) && (in_traction_converter_fault == 0);';
            'brakeReq = max(0.0,in_service_brake_request);';
            'if in_emergency_brake_request || in_safety_brake_request > 0, brakeReq = 1.2; end';
            'v = abs(in_motor_speed)*rw/max(gear,1.0);';
            sprintf('if ~(in_emergency_brake_request || in_safety_brake_request > 0) && (v <= %.17g) && (brakeReq > %.17g), brakeReq = %.17g; end',P.brake.stop_hold_entry_speed_mps,P.brake.hold_deceleration_mps2,P.brake.hold_deceleration_mps2);
            sprintf('Fmotor = %.17g*gear*eta/rw;',P.motor.torque_limit_Nm);
            'Paccept = max(0.0,in_ess_available_charge_power)+max(0.0,in_grid_acceptable_regenerative_power);';
            sprintf('xFade = min(1.0,max(0.0,(v-%.17g)/(%.17g-%.17g)));',P.brake.regen_cutoff_low_mps,P.brake.regen_cutoff_high_mps,P.brake.regen_cutoff_low_mps);
            'regenFade = xFade*xFade*(3.0-2.0*xFade);';
            sprintf('Favail = regenFade*min(%.17g,min(Fmotor,Paccept/max(v,%.17g)));',P.brake.max_dynamic_force_N,P.brake.regen_cutoff_high_mps);
            'dynAvailable = safety && (in_ess_availability || in_grid_acceptable_regenerative_power > 0.0) && (in_super_cap_soc < 0.98) && (regenFade > 0.0);';
            'if ~dynAvailable, Favail = 0.0; end';
            'out_available_dynamic_brake_force = Favail;';
            'out_dynamic_brake_availability = dynAvailable;';
            'Trequest = 0.0;';
            sprintf('if brakeReq > 0.0, Trequest = -min(%.17g,min(max(0.0,in_dynamic_brake_force_request),Favail)*rw/(gear*eta));',P.motor.torque_limit_Nm);
            sprintf('elseif safety && in_hv_breaker_command > 0 && in_dc_link_voltage >= %.17g, Trequest = %.17g*min(1.0,max(0.0,in_traction_command)); end',P.converter.dc_voltage_min_operating_V,0.75*P.motor.torque_limit_Nm);
            'out_motor_torque_request = Trequest;';
            'out_achieved_dynamic_brake_force = max(-in_motor_torque_actual*gear*eta/rw,0.0);';
            'out_ess_power_request = min(max(0.0,in_regenerative_power_actual-in_grid_returned_power),max(0.0,in_ess_available_charge_power));';
            'out_dcdc_enable_command = safety;'; 'out_ess_contactor_command = safety;';
            'out_ess_precharge_command = safety && (time_s < 1.0);'; 'out_ess_fault_reset_command = ~safety;';
            'out_emergency_brake_request = in_emergency_brake_request;';
            'out_service_brake_request = brakeReq;'; 'out_safety_brake_request = in_safety_brake_request;';
            'out_brake_safety_loop_state = int32(safety);'; 'out_hv_safety_loop_state = int32(safety);';
            'out_sanding_request = (brakeReq > 0.8) && (v > 5.0);';
            'out_brake_cylinder_pressure = in_brake_cylinder_pressure;';
            'out_main_reservoir_pressure = in_main_reservoir_pressure;';
            'internal_brake_demand_force = mass*brakeReq;'; 'internal_regen_fade = regenFade;'})];
    case 'D100'
        lines = [lines; string({'out_train_direction_command = int32(1);'; 'out_emergency_brake_request = false;';
            'if time_s < 20.0'; '    out_traction_command = min(1.0,time_s/3.0);'; '    out_service_brake_request = 0.0;'; '    internal_scenario_phase = 1.0;';
            'elseif time_s < 30.0'; '    out_traction_command = 0.0;'; '    out_service_brake_request = 0.0;'; '    internal_scenario_phase = 2.0;';
            'elseif time_s < 45.0'; '    out_traction_command = 0.0;'; '    out_service_brake_request = 1.0;'; '    internal_scenario_phase = 3.0;';
            'else'; '    out_traction_command = 0.0;'; '    out_service_brake_request = 0.3;'; '    internal_scenario_phase = 4.0;'; 'end'})];
    case 'E100'
        lines = [lines; string({'out_external_safety_system_state = int32(1);'; 'out_safety_brake_request = int32(0);'; 'internal_safety_permit = 1.0;'})];
    case 'X100'
        C = P.supercap.capacitance_F; Vmin=P.supercap.voltage_min_V; Vmax=P.supercap.voltage_max_V;
        Emin=0.5*C*Vmin^2; Emax=0.5*C*Vmax^2; E0=Emin+P.supercap.initial_soc*(Emax-Emin);
        lines = [lines; string({'persistent E Eregen PstoredPrev;'; sprintf('if isempty(E), E = %.17g; Eregen = 0.0; PstoredPrev = 0.0; end',E0); sprintf('dt = %s;',dt);
            sprintf('Emin = %.17g; Emax = %.17g;',Emin,Emax);
            sprintf('PchgLim = %.17g; PdisLim = %.17g;',P.supercap.charge_power_limit_W,P.supercap.discharge_power_limit_W);
            'enabled = in_dcdc_enable_command && in_ess_contactor_command && ~in_ess_fault_reset_command;';
            sprintf('Ucap = sqrt(max(0.0,2.0*E/%.17g));',C);
            'Preq = in_ess_power_request;'; 'Pactual = 0.0;';
            sprintf('PchgCurrentLimit = %.17g*Ucap/%.17g;',P.supercap.current_limit_A,P.supercap.dcdc_efficiency_charge);
            sprintf('PdisCurrentLimit = %.17g*Ucap*%.17g;',P.supercap.current_limit_A,P.supercap.dcdc_efficiency_discharge);
            sprintf('if enabled && Preq >= 0.0, Pactual = min([Preq,PchgLim,PchgCurrentLimit,(Emax-E)/(%s*%.17g)]); end',dt,P.supercap.dcdc_efficiency_charge);
            sprintf('if enabled && Preq < 0.0, Pactual = -min([-Preq,PdisLim,PdisCurrentLimit,(E-Emin)*%.17g/%s]); end',P.supercap.dcdc_efficiency_discharge,dt);
            sprintf('Pstored = max(Pactual,0.0)*%.17g + min(Pactual,0.0)/%.17g;',P.supercap.dcdc_efficiency_charge,P.supercap.dcdc_efficiency_discharge);
            'PstoredAvg = 0.5*(PstoredPrev+Pstored);'; 'E = min(Emax,max(Emin,E + PstoredAvg*dt));';
            'Eregen = Eregen + max(PstoredAvg,0.0)*dt;'; 'PstoredPrev = Pstored;';
            'out_dcdc_actual_power = Pactual;'; 'out_ess_absorbed_power = max(Pstored,0.0);';
            'out_ess_availability = enabled && (E > Emin) && (E < Emax);';
            sprintf('out_ess_available_charge_power = min([PchgLim,PchgCurrentLimit,max(0.0,(Emax-E)/(%s*%.17g))]);',dt,P.supercap.dcdc_efficiency_charge);
            sprintf('out_ess_available_discharge_power = min([PdisLim,PdisCurrentLimit,max(0.0,(E-Emin)*%.17g/%s)]);',P.supercap.dcdc_efficiency_discharge,dt);
            'out_ess_fault = int32(~isfinite(E));'; 'out_super_cap_soc = (E-Emin)/(Emax-Emin);';
            sprintf('internal_Ucap_equivalent = sqrt(2.0*E/%.17g);',C);
            'if internal_Ucap_equivalent > 0.0, internal_Icap = -Pstored/internal_Ucap_equivalent; else, internal_Icap = 0.0; end';
            sprintf('internal_Uterminal = internal_Ucap_equivalent-internal_Icap*%.17g;',P.supercap.esr_Ohm);
            'internal_SOC_energy = out_super_cap_soc;'; 'internal_Esc_kJ = E/1000.0;'; 'internal_Eregen_kJ = Eregen/1000.0;'})];
    otherwise
        error('No engineering behavior defined for L2_%s',code);
end
if compact8100
    typeNames = {'Float64','Int32','Boolean'};
    vectorNames = {'yDouble','yInt32','yBoolean'};
    for t = 1:numel(typeNames)
        selected = strings(0,1);
        for i = 1:numel(outVars)
            if strcmp(char(outVars(i).datatype),typeNames{t})
                selected(end+1,1) = string(outVars(i).variable_name); %#ok<AGROW>
            end
        end
        lines(end+1,1) = vectorNames{t} + " = [" + strjoin(selected,'; ') + "];";
    end
end
lines(end+1,1) = "end";
script = char(strjoin(lines,newline));
end
