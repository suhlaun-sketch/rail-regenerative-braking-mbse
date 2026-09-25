function run_brake_component_tests_v2_1(projectRoot)
% Incremental compile/simulation/interface tests for the two changed brake FMUs.
baseDir=fullfile(projectRoot,'work','simulation','simulink_fmu_v2_1_final');
modelDir=fullfile(baseDir,'01_models'); ifaceDir=fullfile(projectRoot,'work','simulation','implementation_binding','components');
outDir=fullfile(baseDir,'03_component_tests'); addpath(modelDir); codes={'7200','8100'}; records=cell(2,1);
for k=1:2
    code=codes{k}; model=['L2_' code]; iface=jsondecode(fileread(fullfile(ifaceDir,[model '_executable_interface.json'])));
    load_system(fullfile(modelDir,[model '.slx'])); set_param(model,'SimulationCommand','update');
    inBlocks=find_system(model,'SearchDepth',1,'BlockType','Inport'); outBlocks=find_system(model,'SearchDepth',1,'BlockType','Outport');
    ins=normalize(iface.inputs); outs=normalize(iface.outputs);
    assert(numel(inBlocks)==numel(ins) && numel(outBlocks)==numel(outs),'Port count mismatch for %s',model);
    simOut=sim(model,'StopTime','0.2','CaptureErrors','on'); assert(isempty(simOut.ErrorMessage),'%s',simOut.ErrorMessage);
    records{k}=struct('component',model,'compile','PASS','simulation','PASS','inputs',numel(ins),'outputs',numel(outs),'status','PASS');
    close_system(model,0); fprintf('BRAKE_COMPONENT_TEST %s = PASS\n',model);
end
records=[records{:}]; fid=fopen(fullfile(outDir,'Brake_Component_Test_Results_v2_1.json'),'w');
fprintf(fid,'%s',jsonencode(records,PrettyPrint=true)); fclose(fid);
fid=fopen(fullfile(outDir,'Brake_Component_Test_Report_v2_1.md'),'w');
fprintf(fid,'# v2.1 Brake Component Tests\n\nL2_7200: PASS\n\nL2_8100: PASS\n'); fclose(fid);
fprintf('BRAKE_COMPONENT_TESTS = 2/2\n');
end
function a=normalize(v)
if isempty(v),a=struct([]);else,a=v(:);end
end
