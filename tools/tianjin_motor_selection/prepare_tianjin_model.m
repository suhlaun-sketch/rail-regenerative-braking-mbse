rootDir = fileparts(fileparts(fileparts(mfilename('fullpath'))));
src = fullfile(rootDir, 'models', 'Rail_RegenerativeBraking_SC_v1.slx');
dst = fullfile(rootDir, 'models', 'Rail_RegenerativeBraking_TianjinMetro_MotorSelection_v1.slx');
copyfile(src, dst, 'f');
load_system(dst);
mdl = bdroot;
set_param(mdl, 'Description', ['Tianjin Metro B-type 6-car motor selection derivative. ', ...
    'Candidate dynamics are supplied by parameterized published-nameplate FMUs.']);
ws = get_param(mdl, 'ModelWorkspace');
baseline = struct('city','Tianjin','train_type','metro_B','cars',6, ...
    'max_operation_speed_kmh',80,'design_speed_kmh',90, ...
    'wheel_radius_m',0.42,'motor_count',16,'aw2_mass_kg',292080,'aw3_mass_kg',316800);
assignin(ws, 'TianjinMetroBaseline', baseline);
assignin(ws, 'MotorCandidateIDs', {'A','B','C','D'});
assignin(ws, 'MotorSurrogateStatement', ...
    'parameterized surrogate traction motor model based on published nameplate data');
save_system(mdl, dst);
close_system(mdl, 0);
fprintf('TIANJIN_MODEL_COPY = PASS\n');
