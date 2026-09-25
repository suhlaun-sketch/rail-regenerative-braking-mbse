function export_all16_fmus(projectRoot)
%EXPORT_ALL16_FMUS Export tested components as real FMI 2.0 Co-Simulation FMUs.
baseDir=fullfile(projectRoot,'work','simulation','simulink_fmu_v2_reviewed');
modelDir=fullfile(baseDir,'01_models'); fmuDir=fullfile(baseDir,'05_fmu');
ifaceDir=fullfile(projectRoot,'work','simulation','implementation_binding','components');
addpath(modelDir);
files=dir(fullfile(ifaceDir,'L2_*_executable_interface.json'));
assert(numel(files)==16,'Expected 16 component interfaces.');
records=cell(numel(files),1);
for k=1:numel(files)
    iface=jsondecode(fileread(fullfile(files(k).folder,files(k).name)));
    model=char(iface.ssd_component); modelPath=fullfile(modelDir,[model '.slx']);
    fmuPath=fullfile(fmuDir,[model '.fmu']);
    if isfile(fmuPath), delete(fmuPath); end
    rec=struct('component',model,'model_file',modelPath,'fmu_file',fmuPath, ...
        'fmi_version','2.0','fmi_type','Co-Simulation','export_status','FAIL', ...
        'duration_s',0,'error','');
    try
        load_system(modelPath); set_param(model,'SimulationCommand','update');
        inputs=normalizeStructArray(iface.inputs); outputs=normalizeStructArray(iface.outputs);
        args={'FMIVersion','2.0','FMUType','CS','SaveDirectory',fmuDir, ...
            'FMUName',model,'AddIcon','off','CreateModelAfterGeneratingFMU','off', ...
            'SaveSourceCodeToFMU','off','DataTypeConversion','off','EnableFMUState','on'};
        if ~isempty(inputs), args=[args {'ExportedInputNames',{inputs.variable_name}}]; end %#ok<AGROW>
        if ~isempty(outputs), args=[args {'ExportedOutputNames',{outputs.variable_name}}]; end %#ok<AGROW>
        tic; exportToFMU(model,args{:}); rec.duration_s=toc;
        assert(isfile(fmuPath),'Exporter returned without creating %s',fmuPath);
        rec.export_status='PASS'; close_system(model,0);
    catch ME
        rec.error=getReport(ME,'extended','hyperlinks','off');
        if bdIsLoaded(model), close_system(model,0); end
    end
    records{k}=rec;
    writeProgress(fullfile(fmuDir,'FMU_Export_Results_v2.json'),records(1:k));
    fprintf('FMU_EXPORT %s = %s (%.3f s)\n',model,rec.export_status,rec.duration_s);
end
records=[records{:}]; passCount=sum(strcmp({records.export_status},'PASS'));
writeProgress(fullfile(fmuDir,'FMU_Export_Results_v2.json'),num2cell(records));
fprintf('FMUS_GENERATED = %d/16\n',passCount);
if passCount~=16, error('FMU export gate failed: %d/16',passCount); end
end

function a=normalizeStructArray(value)
if isempty(value), a=struct([]); else, a=value(:); end
end

function writeProgress(path,cells)
valid=cells(~cellfun(@isempty,cells));
if isempty(valid), payload=struct([]); else, payload=[valid{:}]; end
fid=fopen(path,'w'); assert(fid>=0,'Cannot write export progress.');
fprintf(fid,'%s',jsonencode(payload,PrettyPrint=true)); fclose(fid);
end
