function audit_matlab_environment(outputDir)
%AUDIT_MATLAB_ENVIRONMENT Record reproducible MATLAB/Simulink/FMU capability evidence.
if nargin < 1
    outputDir = fullfile(pwd, 'work', 'simulation', 'simulink_fmu_v1');
end
logDir = fullfile(outputDir, 'logs');
if ~exist(logDir, 'dir'), mkdir(logDir); end
diaryFile = fullfile(logDir, 'matlab_environment_audit.log');
if exist(diaryFile, 'file'), delete(diaryFile); end
diary(diaryFile);
cleanupDiary = onCleanup(@() diary('off'));

info = struct();
info.timestamp = char(datetime('now','TimeZone','Asia/Shanghai','Format','yyyy-MM-dd HH:mm:ss XXX'));
info.matlab_version = version;
info.matlab_release = version('-release');
info.arch = computer('arch');
info.simulink_license = logical(license('test','Simulink'));
info.simulink_available = ~isempty(ver('simulink'));
info.simulink_coder_license = logical(license('test','Real-Time_Workshop'));
info.simulink_coder_available = ~isempty(ver('rtw')) || ~isempty(ver('simulinkcoder'));
info.matlab_coder_license = logical(license('test','MATLAB_Coder'));
info.exportToFMU_exists = exist('exportToFMU','file') ~= 0;
info.fmi2_variants = {
    'Co-Simulation via exportToFMU';
    'Model Exchange via exportToFMU'
};
info.fmi3_support_probe = exist('simulink.exportToFMU3','file') ~= 0 || exist('exportToFMU3','file') ~= 0;

products = ver;
info.installed_products = arrayfun(@(x) struct('name',x.Name,'version',x.Version,'release',x.Release), products);

try
    cc = mex.getCompilerConfigurations('C++','Installed');
    info.cpp_compilers = arrayfun(@(x) struct('name',x.Name,'manufacturer',x.Manufacturer,'version',x.Version,'location',x.Location), cc);
catch ME
    info.cpp_compilers = struct([]);
    info.compiler_probe_error = ME.message;
end

try
    load_system('simulink');
    info.simulink_load_system = true;
    close_system('simulink',0);
catch ME
    info.simulink_load_system = false;
    info.simulink_load_error = ME.message;
end

jsonPath = fullfile(logDir, 'matlab_environment_audit.json');
fid = fopen(jsonPath,'w');
assert(fid >= 0, 'Cannot create %s', jsonPath);
cleanupFile = onCleanup(@() fclose(fid));
fprintf(fid, '%s', jsonencode(info, PrettyPrint=true));

disp(jsonencode(info, PrettyPrint=true));
fprintf('MATLAB_ENVIRONMENT_AUDIT = PASS\n');
end
