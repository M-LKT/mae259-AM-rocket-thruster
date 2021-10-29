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

% asprt = Aspect Ratio, Height/Base

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

% D = 2(base*height)/(base + height), hydraulic diameter of a rectangle
% base = D*(1 + asprt)/(2*asprt)

%% Properties
k = 320; % W/m^2-K Thermal conductivity of chamber wall
Tmax = 480 + 273; % K, service temp of C18150 = 500C

%% Parameters
L = 1*10^-3; % Wall thickness of combustion chamber, m
asprt = 2; % Aspect Ratio

TL_lox = 90; % K, LOX temperature
TL_CH4 = 111; % K, CH4 temperature

mdot = 0.66138; % kg/s
mdot_lox = 0.50007; % kg/s

Twa = 2500; % K, Addiabatic wall temperature = Free Stream Stagnation Temp = Service Temp, approx

hg = 2.6*10^3; % W/m^2-K Hot-Gas side heat transfer coefficient
qr = 0; % Neglecting radiative heat transfer

%% Calculations
qw = hg*(Twa - Tmax); % Heat flux, W/m^2
Twa_e = Twa + qr/hg;

% Hydraulic Diameter for LOX Cooling Channels
H_lox = qw/(Twa_e - TL_lox);

hL_lox = (1/H_lox - 1/hg - 1/(k/L))^-1;

D_lox = (1/hL_lox)^(1/1.8); % Hydraulic diameter for LOX cooled section

% Hydraulic Diameter for CH4 Cooling Channels
H_CH4 = qw/(Twa_e - TL_lox);

hL_CH4 = (1/H_CH4 - 1/hg - 1/(k/L))^-1;

D_CH4 = (1/hL_CH4)^(1/1.8); % Hydraulic diameter for CH4 cooled section

% Calculate dimension of rectangle based on hydraulic diameter
base_lox = D_lox*(1 + asprt)/(2*asprt);
height_lox = asprt*base_lox;

base_CH4 = D_CH4*(1 + asprt)/(2*asprt);
height_CH4 = asprt*base_CH4;

%% Printing Dimensions for the Cooling Channel
fprintf('CH4 Cooling Channel Dimension: Base = %2.4f mm, Height = %2.4f mm\n', base_CH4*10^3, height_CH4*10^3)
fprintf('LOX Cooling Channel Dimension: Base = %2.4f mm, Height = %2.4f mm\n', base_lox*10^3, height_lox*10^3)

%% Heat Removed
hg_bar = 2.6*10^3;
qw_bar = hg_bar*(Twa - Tmax);
H_bar = qw_bar/(Twa_e - TL_CH4);
hL_bar = (1/H_bar - 1/hg_bar - 1/(k/L))^-1;

n = (1/hL_CH4)/(1/hg + 1/(k/L));
Twc = (TL_CH4 + n*Twa_e)/(1 + n); % Average surface temperature, K


