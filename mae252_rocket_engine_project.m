%% MAE 252 - Rocket Engine Project
% Cooling Channel Sizing for Rocket Engine
% Designing to maximum heat flux occuring at the throat.
clc, clear

%% Variable Definition
% k = Thermal Conductivity of the Wall Material, W/mK
% hL = Coolan Heat Transfer Coefficient, W/(Km^2)
% hg = Gas Heat Transfer Coefficient, W/(Km^2)
% H = Overall Heat Transfer Coefficient, W/(Km^2)

% qr = Radiative Hot-Gas Side Heat Flux, W/m^2
% qw = Heat flux through the wall, W/m^2

% L = Wall Thickness, m
% D = Hydraulic Diameter for Cooling Channel, m
% Dt = Diameter of the Throat, m

% Twa_e = Enhanced Adiabatic Wall Temperature, K
% Twa = Adiabatic wall Temperature, K
% Twh = Hot-Gas Wall Temperature, K
% Twc = Coolant-Side Wall Temperature, k
% TL = Coolant Free Stream Temperature, k
% Tg = Gas Temperature, k

% mf = Mass Flow Rate of Hot-Gas, kg/s

%% Equations
% qw = H(Twa_e - TL)
% 1/H = 1/hg + 1/(k/L) + 1/hL
% Twa_e = Twa + qr/hg

% Twh = (TL + eps*Twa_e)/(1 + eps)
% eps = hg(1/(k/L) + 1/hL)

% Twc = (Tl + n*Twa_e)/(1 +n)
% n = (1/hL)/(1/hg + 1/(k/l))

% hL = 1/(D^1.8), approximation
% hg = mf^0.8/(Dia of Chamber)^1.8, approximation

% qr = eps_g*sig*Tg^4

%% Properties
k = 1; % Thermal conductivity of chamber wall

%% Parameters
L = 1; % Wall thickness of combustion chamber

TL_lox = 90; % LOX temperature
TL_CH4 = 111; % CH4 temperature

Twa = 2500; % Addiabatic wall temperature
qw = 3000; % Heat flux at the throat

hg = 2.6*10^3; % Hot-Gas side heat transfer coefficient
qr = 0; % Neglecting radiative heat transfer

%% Calculations
Twa_e = Twa + qr/hg;

% Hydraulic Diameter for LOX Cooling Channels
H_lox = qw/(Twa_e - TL_lox);

hL_lox = (1/H_lox - 1/hg - 1/(k/L));

D_lox = (1/hL_lox)^(1/1.8); % Hydraulic diameter for LOX cooled section

% Hydraulic Diameter for CH4 Cooling Channels
H_CH4 = qw/(Twa_e - TL_lox);

hL_CH4 = (1/H_CH4 - 1/hg - 1/(k/L));

D_CH4 = (1/hL_CH4)^(1/1.8); % Hydraulic diameter for CH4 cooled section
