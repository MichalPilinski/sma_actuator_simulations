import math


class BrinsonSmaCoeffs:
    # Transformations critical temperatures
    martStartTemp = None
    martFinishTemp = None

    austStartTemp = None
    austFinishTemp = None

    # Transformations stress related coeffs
    martStressTempSlope = None
    austStressTempSlope = None

    detwinningStartStress = None
    detwinningFinishStress = None

    maxResidualStrain = None

    # Mechanical coeffs
    martYoungModulus = None
    austYoungModulus = None
    thermalExpansionCoef = None

    # Derived coefficients
    martPiTempCoeff = None
    austPiTempCoeff = None
    detwinningPiStressCoeff = None

    def setTransformationsTemps(self, temps):
        self.martFinishTemp = temps[0]
        self.martStartTemp = temps[1]

        self.austStartTemp = temps[2]
        self.austFinishTemp = temps[3]

    def setTransformationsStresses(self, stressSlopeCoeffs, criticalStresses, maximumResStrain):
        self.martStressTempSlope = stressSlopeCoeffs[0]
        self.austStressTempSlope = stressSlopeCoeffs[1]

        self.detwinningStartStress = criticalStresses[0]
        self.detwinningFinishStress = criticalStresses[1]

        self.maxResidualStrain = maximumResStrain

    def setMechanicalCoeffs(self, youngModuli, thermalExpansionCoef):
        self.martYoungModulus = youngModuli[0]
        self.austYoungModulus = youngModuli[1]

        self.thermalExpansionCoef = thermalExpansionCoef

    def createDerivedCoefficients(self):
        self.martPiTempCoeff = math.pi / (self.martStartTemp - self.martFinishTemp)
        self.austPiTempCoeff = math.pi / (self.austFinishTemp - self.austStartTemp)
        self.detwinningPiStressCoeff = math.pi / (self.detwinningFinishStress - self.detwinningStartStress)
