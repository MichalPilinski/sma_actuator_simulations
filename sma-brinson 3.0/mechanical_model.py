from brinsom_coeffs import BrinsonSmaCoeffs


class SmaMechanicalModel:
    coeffsModel: BrinsonSmaCoeffs

    def initializeCoeffs(self, coeffsModel):
        self.coeffsModel = coeffsModel

    def getYoungsModulus(self, martFrac):
        modulusDifference = self.coeffsModel.martYoungModulus - self.coeffsModel.austYoungModulus
        return self.coeffsModel.austYoungModulus + modulusDifference * martFrac

    def getTransformationModulus(self, martFrac):
        return -self.getYoungsModulus(martFrac) * self.coeffsModel.maxResidualStrain

    def getStress(self, martFrac, martFracZero, detwinnedMartFrac, detwinnedMartFrazZero, temp, tempZero, stressZero, strain, strainZero):
        youngDerivedStress = self.getYoungsModulus(martFrac) * strain - self.getYoungsModulus(martFracZero) * strainZero
        tranformationDerivedStress = self.getTransformationModulus(martFrac) * detwinnedMartFrac - self.getTransformationModulus(martFracZero) * detwinnedMartFrazZero
        expansionDerivedStress = self.coeffsModel.thermalExpansionCoef * (temp - tempZero)

        return youngDerivedStress + tranformationDerivedStress + expansionDerivedStress + stressZero

    def getStrain(self, martFrac, martFracZero, detwinnedMartFrac, detwinnedMartFrazZero, temp, tempZero, stress, stressZero, strainZero):
        youngDerivedStress = self.getYoungsModulus(martFracZero) * strainZero
        tranformationDerivedStress = -self.getTransformationModulus(martFrac) * detwinnedMartFrac + self.getTransformationModulus(martFracZero) * detwinnedMartFrazZero
        expansionDerivedStress = self.coeffsModel.thermalExpansionCoef * (temp - tempZero)

        return (stress - stressZero + youngDerivedStress + tranformationDerivedStress + expansionDerivedStress) / self.getYoungsModulus(martFrac)
