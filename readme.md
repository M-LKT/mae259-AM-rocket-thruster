# Goals for today

- Discussing Rocket Sizing Theory

- Determining Sizing Constraints for Rocket
    - Vehicle size (thrust)
        - Fully Fueled Mass
            - 1200 + 100 + 100 = 1400 t = 1,400,000 kg
        - Lenght
            - Length 50 m
            - Diameter 9 m

        - 0.3 rad/s^2

    - Machine print size (dimensions)
        - LaserTec 65
            - 28.9 in
            - 25.6 in
            - 22 in
            - 1322 

- Chemsitry
    - Propellants
    - Pressure

- Engine Contour Sizing
    - Chamber contour
    - Parabolic nozzle
    - Estimate for heat transfer

# Notes

Types of propellants

## Fuels (when with LOX)

- Kerosene (250-350s)
- Liquid Methane (300-380s)
- Liquid Hydrogen (400-460s)

- UDMH [Hydrazine] (250-300s)
    - monoprop (150-200s)

## Oxidizers

- Liquid Oxygen
- H202
- N20

- N2H4 [Dinitrogen Tetroxide]

# Assumptions about modeling rocket engine

- Isentropic process
- Use the Area-Mach equation to correlate gas properties throughout nozzle as a function of cross-sectional area (depends on isentropic gamma ratios)

- exhaust velocity equation

# Contour

Generated Contour
- Has regen section and a radiative nozzle extention section
- config file for RPA (evaluative copy)

Contour represents the inner surface of the rocket engine that our chamber has to meet.

# Components and CAD

For a summary of best practices and different design types, reference [This NASA Report](https://ntrs.nasa.gov/api/citations/19770009165/downloads/19770009165.pdf)

## Cooling regimes

We are choosing two cryogenic propellants in an autogenous pressurization scheme for in-space service. Therefore, the rocket engine has three distinct chamber sections.
- Fuel Jacket (LCH4 cooled section)
- Oxidizer Jacket (LOX cooled section)
- Nozzle extension (radiatively cooled high emmisivity coated refractory metal section)

The rocket engine heat supplies the energy needed to maintain pressure in the tanks. The control valves that actually feed propellant vapor back to the tanks is not in the scope of this project, so we will roughly estimate how much heat is needed for each propellant and design the cooling sections lengths based on that and an estimate of heat flux through the engine.

    Propellants recieve an equal ratio of total Q per their heat of vaporization. Where Q_fuel/h_vap_LCH4 = Q_ox/h_vap_LOX

Fuel is typically used in the chamber while a secondary oxygen section is added in the nozzle. Each section will have its own inlet and outlet, and its own cooling channel geometry.

## Chamber design

The chamber will roughly be composed of two material layers.

- Inner wall (with cooling channel geometry)
- Outer wall

### Inner wall

The inner wall needs to maintain a heat flux from the hot gases into the coolant fluid (LCH4 or LOX). It also needs to maintain pressure (the cooling jacket is approximately 20-30% higher pressure than the chamber due to injector pressure drop) in the jacket. The design parameters are:

- Material choice
    - High conductivity
    - High service temperature
    - High yeild strength at temperature (for thinness)
- Material thickness (or thickness profile)
    - Thinner = more heat flux

Material needs to also be alloyable with the outer wall material or they need to be the same material.

Cooling channel design is a complex problem, so we will simplify it basing the thickness on the worst case heating and bulk energy capacity without considering convective or cold side boundary layer effects (like nucleate boiling). With this simplification, the cooling channel design parameters become:

- Cooling channel width
- Cooling channel height (also expressible as an aspect ratio of width)
- Number of cooling channels

As mentioned above, the cooling channels must support the max expected heat flux at the worst point and the fluid must be able to support the bulk energy gain throughout the jacket without exceeding the boiling point at pressure. Jacket pressure drop effects and multiphase flow will not be considered.

### Outer wall

The outer wall is basically the pressure bearing structure of the chamber. It is optimized for weight. Design points:

- Material choice
    - Strength to weight ratio
- Material thickness

A safety factor of 1.15 is standard in stress. Loading condition: hoop stress, combined non-uniform pressure vessel stress. Vibration effects neglected.

## Inlet Outlet

Fuel jacket inlet is a external manifold at the bottom of the cooling section
Fuel jacket outlet is an internal manifold at the top of the engine to interface with injector

Oxidizer jacket inlet is an external manifold at the bottom of the printed engine
Oxidizer jacket outlet is an external manifodl at the top of the cooling section

Manifolds need to have a tapered profile to reduce static pressure variation over the jacket crossection.

## Nozzle extension

The nozzle extension design points are:
- Material choice
- Material thickness (or variable thickness profile)
- Coating material and thickness

These three parameters govern maximum equillibrium temperature, the pressure stress, and the thermal expansion stress on the components.

## Nozzle extension interface

The nozzle extension interface is the attach method between the 3D printed chamber and the nozzle extension. Roughly speaking, it needs to:

- Be manufacturable and easy to assemble with a semi-automated method
- Form a gas-vaccuum seal (pressure differential of less than 1 atm)
- Be thermally-compatible: maintain seal and not over-stress either component during the thermal expansion of the nozzle.
- Needs to withstand vibration and be flight-certifiable (if using fasteners, need lockwire probably)