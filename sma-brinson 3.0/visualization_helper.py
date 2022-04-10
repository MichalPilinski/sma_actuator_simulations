import matplotlib.pyplot as plt
import numpy as np


def drawFractionPlot(rangeArray, tupleArray):
    castedResultArrat = np.asarray(tupleArray)

    twinnedMartArr = castedResultArrat[:, 0]
    detwinnedMartArr = castedResultArrat[:, 1]
    austArr = 1 - twinnedMartArr - detwinnedMartArr

    plt.plot(rangeArray, twinnedMartArr)
    plt.plot(rangeArray, detwinnedMartArr)
    plt.plot(rangeArray, austArr)

    plt.grid()
    plt.show()


def calcFractions(rangeStart, rangeFinish, callback):
    rangeArray = np.linspace(rangeStart, rangeFinish, 10 ** 4)
    fractionsArray = []

    for value in rangeArray:
        fractionsArray.append(callback(value))

    drawFractionPlot(rangeArray, fractionsArray)
