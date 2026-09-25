function inspect_existing_simulink_assets(projectRoot, outputDir)
%INSPECT_EXISTING_SIMULINK_ASSETS Read-only inventory of candidate models.
assets = {
    fullfile(projectRoot,'PMSM_PI_decomposition.slx');
    fullfile(projectRoot,'models','PMSM_PI_decomposition_baseline.slx');
    fullfile(projectRoot,'models','Rail_RegenerativeBraking_SC_v1.slx')
};
records = cell(numel(assets),1);
for k = 1:numel(assets)
    file = assets{k};
    rec = struct('file',file,'exists',isfile(file),'load_status','NOT_AVAILABLE');
    if isfile(file)
        [~,model] = fileparts(file);
        try
            load_system(file);
            rec.load_status = 'AVAILABLE';
            rec.block_count = numel(find_system(model,'LookUnderMasks','all','FollowLinks','on','Type','Block'));
            ins = find_system(model,'SearchDepth',1,'BlockType','Inport');
            outs = find_system(model,'SearchDepth',1,'BlockType','Outport');
            rec.inports = cellfun(@(x) get_param(x,'Name'),ins,'UniformOutput',false);
            rec.outports = cellfun(@(x) get_param(x,'Name'),outs,'UniformOutput',false);
            rec.solver = get_param(model,'Solver');
            rec.stop_time = get_param(model,'StopTime');
            rec.model_version = get_param(model,'ModelVersion');
            blockTypes = find_system(model,'LookUnderMasks','all','FollowLinks','on','Type','Block');
            types = cellfun(@(x) get_param(x,'BlockType'),blockTypes,'UniformOutput',false);
            [u,~,idx] = unique(types);
            counts = accumarray(idx,1);
            rec.block_types = cell2struct(num2cell(counts),matlab.lang.makeValidName(u),1);
            close_system(model,0);
        catch ME
            rec.load_status = 'NOT_AVAILABLE';
            rec.error = ME.message;
            if bdIsLoaded(model), close_system(model,0); end
        end
    end
    records{k} = rec;
end
records = [records{:}];
outPath = fullfile(outputDir,'logs','existing_simulink_assets.json');
fid = fopen(outPath,'w');
assert(fid>=0,'Cannot write %s',outPath);
c = onCleanup(@() fclose(fid));
fprintf(fid,'%s',jsonencode(records,PrettyPrint=true));
disp(jsonencode(records,PrettyPrint=true));
end
