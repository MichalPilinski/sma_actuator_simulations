% Temperatures
Mf = 9 + 273;
Ms = 18.4 + 273;
As = 34.5 + 273;
Af = 49 + 273;

% Moduli
Da = 6.7 * 10^4 * 10^6; % Austenite Young modulus 
Dm = 2.63 * 10^4 * 10^6; % Martenzite Young modulus 
Theta = 0.55 * 10^6; % SMA specific thermal expansion coef

% Transformation paramethers
Cm = 8 * 10^6; % Martenzitic transformations stress-temp slope
Ca = 13.8 * 10^6; % Austenitic transformations stress-temp slope
cSs = 100 * 10^6; % Start of martenzite detwining
cSf = 170 * 10^6; % End of martenzite detwining
rEmax = 0.067; % Maximum residual strain