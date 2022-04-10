% coeffs = [coefAm, As, Ca]

function [martStress, martTemp] = martHeating(temp, sigma, martTempZero, martStressZero, coeffs)
    equivTemp = temp - coeffs(2) - (sigma / coeffs(3));
    martZeroCoeff = (martTempZero + martStressZero);
    
    martCoeff = (cos(coeffs(1) * equivTemp) + 1) * (martZeroCoeff / 2);
    martStress = martStressZero - ((martStressZero / martZeroCoeff) * (martZeroCoeff - martCoeff));
    martTemp = martTempZero - ((martTempZero / martZeroCoeff) * (martZeroCoeff - martCoeff));
end
