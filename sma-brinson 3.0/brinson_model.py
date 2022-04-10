import math

from brinsom_coeffs import BrinsonSmaCoeffs


class BrinsonModel:
    coeffsModel: BrinsonSmaCoeffs

    def __init__(self, twinnedMartFrac, detwinnedMartFrac):
        self.twinnedMartFrac = twinnedMartFrac
        self.detwinnedMartFrac = detwinnedMartFrac

    def initializeCoeffs(self, coeffsModel):
        self.coeffsModel = coeffsModel

    def martDetwiningLowTempBound(self, stress):
        if stress < self.coeffsModel.detwinningStartStress:
            return 0
        elif stress > self.coeffsModel.detwinningFinishStress:
            return 1
        else:
            return self.martDetwinningLowTemp(stress)

    def martDetwiningHighTempBound(self, stress, temp):
        stressTempDrift = self.coeffsModel.martStressTempSlope * (temp - self.coeffsModel.martStartTemp)

        if stress < self.coeffsModel.detwinningStartStress + stressTempDrift:
            return self.twinnedMartFrac, self.detwinnedMartFrac
        elif stress > self.coeffsModel.detwinningFinishStress + stressTempDrift:
            return 0, 1
        else:
            return self.detwiningHighTemp(stress, temp)

    def austRecoveryBound(self, stress, temp):
        tempStressDrift = stress / self.coeffsModel.austStressTempSlope

        if temp < self.coeffsModel.austStartTemp + tempStressDrift:
            return self.twinnedMartFrac, self.detwinnedMartFrac
        elif temp > self.coeffsModel.austFinishTemp + tempStressDrift:
            return 0, 0
        else:
            return self.austRecovery(stress, temp)

    def martDetwinningLowTemp(self, stress):
        cosCoeff = math.cos(
            self.coeffsModel.detwinningPiStressCoeff * (stress - self.coeffsModel.detwinningFinishStress)
        )

        detwinnedMartFracNew = ((1 - self.detwinnedMartFrac) * cosCoeff / 2) + ((1 + self.detwinnedMartFrac) / 2)
        twinnedMartFracNew = self.twinnedMartFrac - (self.twinnedMartFrac / (1 - self.detwinnedMartFrac)) * (detwinnedMartFracNew - self.detwinnedMartFrac)

        return twinnedMartFracNew, detwinnedMartFracNew

    def martDetwiningHighTemp(self, stress, temp):
        cosStressCoeff = stress - self.coeffsModel.detwinningFinishStress - self.coeffsModel.martStressTempSlope * (temp - self.coeffsModel.martStartTemp)
        cosCoeff = math.cos(
            self.coeffsModel.detwinningPiStressCoeff * cosStressCoeff
        )

        detwinnedMartFracNew = ((1 - self.detwinnedMartFrac) * cosCoeff / 2) + ((1 + self.detwinnedMartFrac) / 2)
        twinnedMartFracNew = self.twinnedMartFrac - (self.twinnedMartFrac / (1 - self.detwinnedMartFrac)) * (detwinnedMartFracNew - self.detwinnedMartFrac)

        return twinnedMartFracNew, detwinnedMartFracNew

    def austRecovery(self, stress, temp):
        martFraction = self.detwinnedMartFrac + self.twinnedMartFrac

        cosTempCoeff = temp - self.coeffsModel.austStartTemp - (stress / self.coeffsModel.austStressTempSlope)
        cosCoeff = math.cos(
            cosTempCoeff * self.coeffsModel.austPiTempCoeff
        )

        martFractionNew = (martFraction / 2) * (cosCoeff + 1)
        detwinnedMartFracNew = self.detwinnedMartFrac - ((self.detwinnedMartFrac / martFraction) * (martFraction - martFractionNew))
        twinnedMartFracNew = self.twinnedMartFrac - ((self.twinnedMartFrac / martFraction) * (martFraction - martFractionNew))

        return twinnedMartFracNew, detwinnedMartFracNew

