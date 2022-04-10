%coil basic paramethers
wireDiameter = 0.25 * 10^-3; %mm
wireLength = 77 * 10^-3; %mm

density = 6450;

wireSurfaceArea = wireLength * pi * wireDiameter;
wireVolume = wireLength * pi * wireDiameter^2 / 4;
wireMass = wireVolume * density;

%coil physical paramethers
emissivity = 0.72;

resistivityAustenite  = 82 * 10^-6; %austenite
resistivityMartensite  = 76 * 10^-6; %austenite

specificHeatHeating = 466;
specificHeatCooling = 260;

%physical consts
BOLTZ_CONST = 5.6703 * 10^-8;
ABS_ZERO_TEMP = -273.15;

%transformation heat constants
austeniteStartTemp = 80 - ABS_ZERO_TEMP;
austeniteEndTemp = 100 - ABS_ZERO_TEMP;

martensiticStartTemp = 40 - ABS_ZERO_TEMP;
martensiticEndTemp = 20 - ABS_ZERO_TEMP; %propably wrong

endoLatentCoef = 12188;
exoLatentCoef = 4137;

%enviromental consts
temperature = 20 - ABS_ZERO_TEMP;
envTemp = 0;

%electric heating paramethers
voltage = 2;
resistanceAustenite = 4 * pi * wireLength * resistivityAustenite / wireDiameter^2;
resistanceMartensite = 4 * pi * wireLength * resistivityMartensite / wireDiameter^2;

%program
timeDelta = 0.02;
simulationTime = 500/timeDelta;
temperatureArr = [];
energyUsed = 0;

for step = 1:simulationTime
    heatFlow = 0;

    %radiationHeat
    heatFlow = heatFlow - BOLTZ_CONST * wireSurfaceArea * emissivity * (temperature^4 - envTemp^4);        
    
    %mechanicalWork
    heatFlow = heatFlow - 0;
    
    %sunHeat
    %heatFlow = heatFlow + wireLength*wireDiameter*1000;
    
    %julesHeat
    heatFlow = heatFlow + voltage * current;
    if temperature < austeniteEndTemp
        energyUsed = energyUsed + current * voltage * timeDelta;
    end
    
    %thermalMass
    innerHeat = 0;
    innerHeat = innerHeat + specificHeat;
 
    %transformation latent
    %heating
    if temperature > austeniteStartTemp && temperature < austeniteEndTemp
        tempDiff = austeniteEndTemp - austeniteStartTemp;
        innerHeat = innerHeat + endoLatentCoef * (pi / tempDiff) * (sin(pi / tempDiff)*(temperature - austeniteStartTemp))/2;
    end
    %cooling
    %if temperature < martensiticStartTemp && temperature > martensiticEndTemp
    %	tempDiff = martensiticEndTemp - martensiticStartTemp;
    %	innerHeat = innerHeat + exoLatentCoef * (pi / tempDiff) * (sin(pi / tempDiff)*(temperature - martensiticStartTemp))/2;
    %end
    
    innerHeat = innerHeat * wireMass;
    
    temperature = temperature + (heatFlow/innerHeat * timeDelta);
    temperatureArr(step) = temperature;
end

hold on;
grid on;
plot((1:simulationTime)*0.02, temperatureArr+ABS_ZERO_TEMP);
xlabel('Czas [s]');
ylabel('Temperatura [°C]');

text(33,75, 'Maks temp mart-aust = 80°C', 'FontSize',8, 'Color', 'red')
text(33,57, 'Min temp mart-aust = 60°C', 'FontSize',8, 'Color', 'red')

text(33,51, 'Maks temp aust-mart = 40°C', 'FontSize',8, 'Color', 'green')
text(33,18, 'Min temp aust-mart = 20°C', 'FontSize',8, 'Color', 'green')


line([0,simulationTime*0.02],[austeniteStartTemp+ABS_ZERO_TEMP,austeniteStartTemp+ABS_ZERO_TEMP],'Color','red','LineStyle','--')
line([0,simulationTime*0.02],[austeniteEndTemp+ABS_ZERO_TEMP,austeniteEndTemp+ABS_ZERO_TEMP],'Color','red','LineStyle','--')

line([0,simulationTime*0.02],[martensiticStartTemp+ABS_ZERO_TEMP,martensiticStartTemp+ABS_ZERO_TEMP],'Color','green','LineStyle','--')
line([0,simulationTime*0.02],[martensiticEndTemp+ABS_ZERO_TEMP,martensiticEndTemp+ABS_ZERO_TEMP],'Color','green','LineStyle','--')