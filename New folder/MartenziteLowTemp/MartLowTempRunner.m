load_system('MartLowTempMechanicalModel')

%% Simulation paramethers 
tempStart = -10 + 273;
tempFinish = Mf;

iterations = 1000;
timeStep = 10^-2;
simDuration = 10;
temp_range = linspace(tempStart, tempFinish, iterations);
martDetwiningArray = [];
%% Simulation loop
tic
for i=1:iterations
   temp = temp_range(i);
   simOut = sim('MartLowTempMechanicalModel', ...
       'StartTime', '0', ...
       'StopTime', num2str(simDuration), ...
       'FixedStep', num2str(timeStep), ...
       'SaveOutput', 'on', ...
       'OutputSaveName', 'yOut', ...
       'SaveTime', 'on', ...
       'TimeSaveName', 'tOut');
   t = simOut.get('tOut');
   martDetwiningArray(:,i) = simOut.yOut{1}.Values.Data;
end
toc
%% Postprocessing
save('MartDetwiningLowTempArray.mat', 'martDetwiningArray')