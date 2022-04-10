% coeffs = [coefAm, Mf]

function [martStress, martTemp] = martCooling(temp, martTempZero, martStressZero, coeffs)
	martDelta = martTempDelta(temp, martTempZero, martStressZero, coeffs);
    
    martTemp = martTempZero + martDelta;
    martStress = 0;
end
