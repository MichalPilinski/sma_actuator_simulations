% coeffs = [martSigmaStart, martSigmaEnd, Mf]

function [martStress, martTemp] = martStressing(sigma, martStressZero, martTempZero, coeffs)
    piCoef = pi / (coeffs(1) - coeffs(2));
    
    martStress = (1 - martStressZero) * cos(piCoef * (sigma - coeffs(2))) / 2 + (1 + martStressZero) / 2;
    martTemp = martTempZero - (((martStress - martStressZero) * martTempZero) / (1 - martStressZero));
end
