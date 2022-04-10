from brinson_model import BrinsonModel
from brinsom_coeffs import BrinsonSmaCoeffs
import numpy as np
import matplotlib.pyplot as plt

from mechanical_model import SmaMechanicalModel
from visualization_helper import drawFractionPlot, calcFractions


def getCoeffsModel():
    model: BrinsonSmaCoeffs = BrinsonSmaCoeffs()

    model.setTransformationsTemps(
        [9, 18.4, 34.5, 49]
    )  # [Mf, Ms, As, Af]

    model.setTransformationsStresses(
        [8 * 10**6, 13.8 * 10**6],
        [100 * 10**6, 170 * 10**6],
        0.067
    )  # [Cm, Ca], [sigmaCrS, sigmaCrF], El

    model.setMechanicalCoeffs(
        [2.63 * 10**10, 6.7 * 10**10],
        5.5 * 10**5
    )  # [Dm, Da], omega

    model.createDerivedCoefficients()

    return model


if __name__ == '__main__':
    coeffsModel = getCoeffsModel()

    smaModel: BrinsonModel = BrinsonModel(0, 0.046)
    smaModel.initializeCoeffs(coeffsModel)

    mechanicalModel: SmaMechanicalModel = SmaMechanicalModel()
    mechanicalModel.initializeCoeffs(coeffsModel)

    # Calculations
    # calcFractions(coeffsModel.austStartTemp * 0.8,
    #               coeffsModel.austFinishTemp * 1.2,
    #               lambda val: smaModel.austRecoveryBound(coeffsModel.detwinningStartStress, val))

    tempArray = np.linspace(20, coeffsModel.austFinishTemp + 50, 10 ** 2)
    stressArray = []
    austArray = []
    previousStress = 0

    for temp in tempArray:
        (twinned, detwinned) = smaModel.austRecoveryBound(previousStress, temp)
        previousStress = mechanicalModel.getStress(
            twinned + detwinned,
            0.046,
            detwinned,
            0.046,
            temp,
            20,
            128 * 10**6,
            0.005,
            0.005
        )
        stressArray.append(previousStress)
        austArray.append(twinned+detwinned)

    # plt.ylim([0, 400 * 10**6])
    # plt.xlim([0, 80])

    # plt.axline((coeffsModel.austStartTemp, 0), (coeffsModel.austStartTemp + 30, 30 * coeffsModel.austStressTempSlope))
    # plt.axline((coeffsModel.austFinishTemp, 0), (coeffsModel.austFinishTemp + 30, 30 * coeffsModel.austStressTempSlope))

    plt.plot(tempArray, austArray)
    plt.show()
