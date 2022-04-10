% coeffs = [coefAm, Mf]

function martCoeff = martTempDelta(temp, martTempZero, martStressZero, coeffs)
    martCoeff = (1 - martTempZero - martStressZero) * (cos(coeffs(1) * (temp - coeffs(2))) + 1) / 2;
end