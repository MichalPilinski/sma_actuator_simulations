% Coil basic paramethers
wireDiameter = 0.25 * 10^-3;
wireLength = 70 * 10^-3;

density = 6450;

wireSurfaceArea = wireLength * pi * wireDiameter;
wireVolume = wireLength * pi * wireDiameter^2 / 4;
wireMass = wireVolume * density;

% Coil physical paramethers
emissivity = 0.75;
austeniteResistivity  = 8.2 * 10^-7;
martensiteResistivity  = 7.6 * 10^-7; 
specificHeat = 465.2;

austeniteLatentCoef = 12188;
martensiteLatentCoef = 2920;

% Physical consts
BOLTZ_CONST = 5.6703 * 10^-8;
ABS_ZERO_TEMP = -273.15;

% Electric heating paramethers
voltage = 2;
resistanceAustenite = 4 * pi * wireLength * austeniteResistivity / wireDiameter^2;
resistanceMartensite = 4 * pi * wireLength * martensiteResistivity / wireDiameter^2;

% Temp start
tempStart = 80 + 273;
tempEnd = 80 + 273;

% Nitinol characteristic proprties
Ms = 50 - ABS_ZERO_TEMP;
Mf = 40 - ABS_ZERO_TEMP;
As = 70 - ABS_ZERO_TEMP;
Af = 80 - ABS_ZERO_TEMP;
