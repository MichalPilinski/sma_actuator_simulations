load_system('AustMechanicalModel')

%% Simulation paramethers 
tempStart = As - 273;
tempFinish = 100;

martStressFrac = 1;
martTempFrac = 0;
martFrac = martStressFrac + martTempFrac;

strainZero = rEmax;

iterations = 1000;
timeStep = 10^-2;
simDuration = 10;
stress_range = linspace(0, 5 * 10^8, iterations);
austRecoveryArray = [];
%% Simulation loop
tic
for i=1:iterations
   stressParam = stress_range(i);
   simOut = sim('AustMechanicalModel', ...
       'StartTime', '0', ...
       'StopTime', num2str(simDuration), ...
       'FixedStep', num2str(timeStep), ...
       'SaveOutput', 'on', ...
       'OutputSaveName', 'yOut', ...
       'SaveTime', 'on', ...
       'TimeSaveName', 'tOut');
   t = simOut.get('tOut');
   austRecoveryArray(:,i) = simOut.yOut{1}.Values.Data;
end
toc
%% Postprocessing
save('AustRecoveryArray.mat', 'austRecoveryArray')