% temp = linspace(tempStart , tempFinish, (simDuration/timeStep) + 1);
% surf(stress_range, temp, austRecoveryArray)

% strain = linspace(0 , 1.5 * rEmax, (simDuration/timeStep) + 1);
% surf(temp_range, strain, martDetwiningArray)

plot(tempOut, strainOut);