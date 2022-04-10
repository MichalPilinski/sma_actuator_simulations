% Temperatures
Mf = 9 + 273;
Ms = 18.4 + 273;

coefAm = pi / (Ms - Mf);

dT = 0.01;
tStart = As;
tEnd = Af + 30;
tempArr = tStart:dT:tEnd;

martTempArr = [];
martStressArr = [];
for temp=tempArr
    [martStress, martTemp] = martHeating(temp, cSs, 0.5, 0.3, [coefAa, As, Ca]);
    
    martTempArr = [martTempArr, martTemp];
    martStressArr = [martStressArr, martStress];
end

hold on;
plot(tempArr, martTempArr);
plot(tempArr, martStressArr);
ylim([0 1]);

% sigmaStart = cSs;
% sigmaEnd = cSf;
% dSigma = (sigmaEnd - sigmaStart) / 10000;
% 
% sigmaArr = sigmaStart:dSigma:sigmaEnd;
% 
% martTempZero = 0;
% martStressZero = 0;
% 
% martCoefTempArr = [];
% martCoefStressArr = [];
% for sigma=sigmaArr
%     [martStress, martTemp] = martStressing(sigma, 0, 1, [cSs, cSf, Mf]);
%  
%     martCoefStressArr = [martCoefStressArr, martStress];
%     martCoefTempArr = [martCoefTempArr, martTemp];
% end
% 
% hold on;
% plot(sigmaArr, martCoefTempArr);
% plot(sigmaArr, martCoefStressArr);