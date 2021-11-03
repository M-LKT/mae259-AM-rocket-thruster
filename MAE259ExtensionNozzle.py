# -*- coding: utf-8 -*-
"""
Created on Sat Oct 30 12:50:41 2021

@author: MuqingYang
"""

import numpy as np
import pandas as pd 
import matplotlib.pyplot as plt
data = pd.read_csv("rocketdata.csv")

mask = data["MACH"] > 1

data= data[mask]

rodata = data.reset_index(drop=True)

Position = rodata["X"]   #m
Diameter = 2*rodata["Y"]  #m

#Parameters
Tmelt = 2573.15  #K

ys  = 59.3  #Mpa at 2016.15 K
# Hook Stress
P = rodata["Pressure"]*0.101325   #Mpa
Hoop = ys/2    #Mpa
Thickness = ((P*Diameter)/Hoop)/2

plt.xlabel('Poistion After Throat')
plt.ylabel('Thickness')
plt.plot(Position,Thickness,linewidth=1)
plt.show()


#Conviection
hg = rodata["h_g"]
Tf = rodata["TEMP"]
qh = rodata["FLUX"]

#Radiation and Energy Balanece
stefan = 5.67*(10**-8)  #w/((m**2)(k**4)
e  = 0.8
Ra = rodata["FLUX"]  #W/m^2
# Tw  = Tf - ((((Ra/stefan)/e)**(1/4))/hg)

value = np.zeros([len(Tf),4])

for i in range(0,len(Tf)):
    coeff = [1,0,0,-((hg[i]/stefan)/e),(((hg[i]*Tf[i])/stefan)/e)]
    value[i] = -1*np.roots(coeff)
    
plt.xlabel('Poistion After Throat')
plt.ylabel('Temperature at Wall(K)')
plt.plot(Position,value[:,0],linewidth=1,label ="T melt")
plt.plot(Position,Tmelt*np.ones(len(Tf)),linewidth=1, label= "T Wall")

plt.legend()



