% Temperatures
Mf = 40 + 273;
Ms = 50 + 273;
As = 70 + 273;
Af = 80 + 273;

% Moduli
Da = 6.7 * 10^4 * 10^6; % Austenite Young modulus 
Dm = 2.63 * 10^4 * 10^6; % Martenzite Young modulus 
Theta = 0.55 * 10^6; % SMA specific thermal expansion coef

% Transformation paramethers
Cm = 8 * 10^6; % Martenzitic transformations stress-temp slope
Ca = 13.8 * 10^6; % Austenitic transformations stress-temp slope
cSs = 100 * 10^6; % Start of martenzite detwining
cSf = 170 * 10^6; % End of martenzite detwining
rEmax = 0.05; % Maximum residual strain
