# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""


#import rpy2
#from rpy2.robjects.packages import importr
#from rpy2.robjects import pandas2ri
#from rpy2.robjects import r

#import sys
# sys.platform = 'win64'
import pandas as pd
import matplotlib.pyplot as plt
#import dreamtools as dt
#import os
#import numpy as np
#import statsmodels.api as sm

# Importerer priser - udregnet i excel
priser = pd.read_excel(r'priser.xlsx')

#Importerer mængder
maengderstor = pd.read_excel(r'fastepriser.xlsx')

#Splitter mængderne op i forskellige indkomstgrupper
maengder_gns        = maengderstor.iloc[:47,:] 
maengder_u250       = maengderstor.iloc[47:94,:]
maengder_250_450    = maengderstor.iloc[94:141,:]
maengder_450_700    = maengderstor.iloc[141:188,:]
maengder_700_1mio   = maengderstor.iloc[188:235,:]
maengder_o1mio      = maengderstor.iloc[235:,:]

#reset index number
maengder_gns.reset_index(drop=True, inplace=True) 
maengder_u250.reset_index(drop=True, inplace=True) 
maengder_250_450.reset_index(drop=True, inplace=True) 
maengder_450_700.reset_index(drop=True, inplace=True) 
maengder_700_1mio.reset_index(drop=True, inplace=True) 
maengder_o1mio.reset_index(drop=True, inplace=True) 

#Importerer løbende priser
loebpriser = pd.read_excel(r'loebpriser.xlsx')

#Splitter mængderne op i forskellige indkomstgrupper
loebpriser_gns        = loebpriser.iloc[:47,:] 
loebpriser_u250       = loebpriser.iloc[47:94,:]
loebpriser_250_450    = loebpriser.iloc[94:141,:]
loebpriser_450_700    = loebpriser.iloc[141:188,:]
loebpriser_700_1mio   = loebpriser.iloc[188:235,:]
loebpriser_o1mio      = loebpriser.iloc[235:,:]

#reset index number
loebpriser_gns.reset_index(drop=True, inplace=True) 
loebpriser_u250.reset_index(drop=True, inplace=True) 
loebpriser_250_450.reset_index(drop=True, inplace=True) 
loebpriser_450_700.reset_index(drop=True, inplace=True) 
loebpriser_700_1mio.reset_index(drop=True, inplace=True) 
loebpriser_o1mio.reset_index(drop=True, inplace=True) 

#danner grupper
loebpriser_gns_makro = loebpriser_gns.groupby("MAKRO_gruppe").sum()

indkomstkategorier = ["gns", "u250", "250_450", "450_700", "700_1mio" , "o1mio"]

makro_loebpris={}
rel_Tur_Tje={} 
TurTje={}
rel_TurTje_Var={}
TurTjeVar={}
rel_TurTjeVar_Ene={}
TurTjeVarEne={}
rel_TurTjeVarEne_Bil={}
ikkeBol={}

#Konstruerer nests og relative budgetandele
#Gemmer de forskellige variable som dicts.
for df,name in zip((loebpriser_gns, loebpriser_u250, loebpriser_250_450,
           loebpriser_450_700, loebpriser_700_1mio, loebpriser_o1mio)
           ,indkomstkategorier):
    makro_loebpris[name]= df.groupby("MAKRO_gruppe").sum()
    rel_Tur_Tje[name] = makro_loebpris[name].loc['Turisme',:]/makro_loebpris[name].loc['Tjenester',:]
    TurTje[name] = makro_loebpris[name].loc['Turisme',:]+makro_loebpris[name].loc['Tjenester',:]
    rel_TurTje_Var[name] = TurTje[name]/makro_loebpris[name].loc['Varer',:]
    TurTjeVar[name]=TurTje[name]+makro_loebpris[name].loc['Varer',:]
    rel_TurTjeVar_Ene[name]=TurTjeVar[name]/makro_loebpris[name].loc['Energi',:]
    TurTjeVarEne[name]=TurTjeVar[name]+makro_loebpris[name].loc['Energi',:]
    rel_TurTjeVarEne_Bil[name]=TurTjeVarEne[name]/makro_loebpris[name].loc['Biler',:]
    ikkeBol[name]=TurTjeVarEne[name]+makro_loebpris[name].loc['Biler',:]

    #plt.plot(rel_TurTjeVar_Ene[name],label=name)
    #plt.legend()

# Danner mængder for de forskellige indkomstgrupper

makro_maengder = {}
TurTje_maengde = {}
TurTjeVar_maengde ={}
TurTjeVarEne_maengde = {}
TurTjeVarEneBil_maengde = {}

for df,name in zip((maengder_gns, maengder_u250, maengder_250_450,
           maengder_450_700, maengder_700_1mio, maengder_o1mio)
           ,indkomstkategorier):  
    makro_maengder[name]= df.groupby("MAKRO_gruppe").sum()
    TurTje_maengde[name]= makro_maengder[name].loc['Turisme',:]+makro_maengder[name].loc['Turisme',:]
    TurTjeVar_maengde[name]= makro_maengder[name].loc['Turisme',:]+makro_maengder[name].loc['Turisme',:]+makro_maengder[name].loc['Varer',:]
    TurTjeVarEne_maengde[name]= makro_maengder[name].loc['Turisme',:]+makro_maengder[name].loc['Turisme',:]+makro_maengder[name].loc['Varer',:]+makro_maengder[name].loc['Energi',:]
    TurTjeVarEneBil_maengde[name]= makro_maengder[name].loc['Turisme',:]+makro_maengder[name].loc['Turisme',:]+makro_maengder[name].loc['Varer',:]+makro_maengder[name].loc['Energi',:]+makro_maengder[name].loc['Biler',:]
   
    
#Danner prisindeks
   
Prisindeks = {}

maengder_gns_MAKRO = {}
maengder_u250_MAKRO = {}
maengder_250_450_MAKRO = {}
maengder_450_700_MAKRO = {}
maengder_700_1mio_MAKRO = {}
maengder_o1mio_MAKRO = {}
    
Grupper = ["Turisme","Tjenester","Varer","Energi","Biler"]

for name in Grupper:
    Prisindeks[name] = ((priser[priser['MAKRO_gruppe']==name].iloc[:,1:27]*maengder_gns[maengder_gns['MAKRO_gruppe']==name]
         .iloc[:,1:27]).sum(axis=0))/(maengder_gns[maengder_gns['MAKRO_gruppe']==name].sum(axis=0))
    maengder_gns_MAKRO[name] = maengder_gns[maengder_gns['MAKRO_gruppe']==name].sum(axis=0)
    maengder_u250_MAKRO[name] = maengder_u250[maengder_u250['MAKRO_gruppe']==name].sum(axis=0)
    maengder_250_450_MAKRO[name] = maengder_250_450[maengder_250_450['MAKRO_gruppe']==name].sum(axis=0) 
    maengder_450_700_MAKRO[name] = maengder_450_700[maengder_450_700['MAKRO_gruppe']==name].sum(axis=0)
    maengder_700_1mio_MAKRO[name] = maengder_700_1mio[maengder_700_1mio['MAKRO_gruppe']==name].sum(axis=0)
    maengder_o1mio_MAKRO[name] = maengder_o1mio[maengder_o1mio['MAKRO_gruppe']==name].sum(axis=0)
#printer prisindekset for turisme
Prisindeks_tur = Prisindeks["Turisme"]
#print(Prisindeks_tur)
#print(Prisindeks)
#print(maengder_gns_MAKRO)

#danner prisindeks for nests
Prisindeks_TurTje =    (Prisindeks["Turisme"]*maengder_gns_MAKRO["Turisme"]+Prisindeks["Tjenester"]*maengder_gns_MAKRO["Tjenester"]
                         )/(maengder_gns_MAKRO["Turisme"]+maengder_gns_MAKRO["Tjenester"])
Prisindeks_TurTjeVar = (
                        Prisindeks["Turisme"]*maengder_gns_MAKRO["Turisme"]+Prisindeks["Tjenester"]*maengder_gns_MAKRO["Tjenester"]
                         +Prisindeks["Varer"]*maengder_gns_MAKRO["Varer"]
                     )/(maengder_gns_MAKRO["Turisme"]+maengder_gns_MAKRO["Tjenester"]
                     +  maengder_gns_MAKRO["Varer"])
Prisindeks_TurTjeVarEne = (
                        Prisindeks["Turisme"]*maengder_gns_MAKRO["Turisme"]+Prisindeks["Tjenester"]*maengder_gns_MAKRO["Tjenester"] +
                        Prisindeks["Varer"]*maengder_gns_MAKRO["Varer"] + Prisindeks["Energi"]*maengder_gns_MAKRO["Energi"]
                     )/(maengder_gns_MAKRO["Turisme"]+maengder_gns_MAKRO["Tjenester"]
                     +  maengder_gns_MAKRO["Varer"] + maengder_gns_MAKRO["Energi"] )
Prisindeks_TurTjeVarEneBil = (
                        Prisindeks["Turisme"]*maengder_gns_MAKRO["Turisme"]+Prisindeks["Tjenester"]*maengder_gns_MAKRO["Tjenester"] +
                        Prisindeks["Varer"]*maengder_gns_MAKRO["Varer"] + Prisindeks["Energi"]*maengder_gns_MAKRO["Energi"] +
                        Prisindeks["Biler"]*maengder_gns_MAKRO["Biler"]
                     )/(maengder_gns_MAKRO["Turisme"]+maengder_gns_MAKRO["Tjenester"] +
                        maengder_gns_MAKRO["Varer"] + maengder_gns_MAKRO["Energi"]  +
                        maengder_gns_MAKRO["Biler"])                        

#danner relative priser
relp_Tur_Tje = Prisindeks["Turisme"] / Prisindeks["Tjenester"]
relp_TurTje_Var = Prisindeks_TurTje /  Prisindeks["Varer"]
relp_TurTjeVar_Ene = Prisindeks_TurTjeVar /  Prisindeks["Energi"]
relp_TurTjeVarEne_Bil = Prisindeks_TurTjeVarEne /  Prisindeks["Biler"]

import matplotlib.pylab as pylab
params = {'legend.fontsize': 'x-large',
          'figure.figsize': (10, 10),
         'axes.labelsize': 'x-large',
         'axes.titlesize':'x-large',
         'xtick.labelsize':'x-large',
         'ytick.labelsize':'x-large'}
pylab.rcParams.update(params)

#Tegner figur som i MAKRO202
fig, axs = plt.subplots(4, 2)
axs[0, 0].plot(rel_Tur_Tje["gns"])
axs[0, 0].set_title('Relative budgetandele')
axs[0, 0].set_ylabel('TurTje')
axs[0, 1].plot(relp_Tur_Tje)
axs[0, 1].set_title('Relative priser')
axs[1, 0].plot(rel_TurTje_Var["gns"])
axs[1, 0].set_ylabel('TurTjeVar')
axs[1, 1].plot(relp_TurTje_Var)
axs[2, 0].plot(rel_TurTjeVar_Ene["gns"])
axs[2, 0].set_ylabel('TurTjeVar_Ene')
axs[2, 1].plot(relp_TurTjeVar_Ene)
axs[3, 0].plot(rel_TurTjeVarEne_Bil["gns"])
axs[3, 0].set_ylabel('TurTjeVarEne_Bil')
axs[3, 1].plot(relp_TurTjeVarEne_Bil)

# Hide x labels and tick labels for top plots and y ticks for right plots.
for ax in axs.flat:
    ax.label_outer()
    ax.xaxis.set_major_locator(plt.MaxNLocator(6))

plt.savefig('relbudrelp.eps')

import csv

samlet_data_gns = pd.DataFrame()
samlet_data_gns["Turisme_pris"]=Prisindeks["Turisme"]
samlet_data_gns["Tjenster_pris"]=Prisindeks["Tjenester"]
samlet_data_gns["TurTje_pris"]=Prisindeks_TurTje
samlet_data_gns["Varer_pris"]=Prisindeks["Varer"]
samlet_data_gns["TurTjeVar_pris"]=Prisindeks_TurTjeVar
samlet_data_gns["Energi_pris"]=Prisindeks["Energi"]
samlet_data_gns["TurTjeVarEne_pris"]=Prisindeks_TurTjeVarEne
samlet_data_gns["Biler_pris"]=Prisindeks["Biler"]
samlet_data_gns["Turisme_maengde"]=maengder_gns_MAKRO["Turisme"]
samlet_data_gns["Tjenester_maengde"]=maengder_gns_MAKRO["Tjenester"]
samlet_data_gns["TurTje_maengde"]=TurTje_maengde["gns"]
samlet_data_gns["Varer_maengde"]=maengder_gns_MAKRO["Varer"]
samlet_data_gns["TurTjeVar_maengde"]=TurTjeVar_maengde["gns"]
samlet_data_gns["Energi_maengde"]=maengder_gns_MAKRO["Energi"]
samlet_data_gns["TurTjeVarEne_maengde"]=TurTjeVarEne_maengde["gns"]
samlet_data_gns["Biler_maengde"]=maengder_gns_MAKRO["Biler"]
#samlet_data_gns = samlet_data_gns.drop("MAKRO_gruppe", axis=0)
#samlet_data_gns = samlet_data_gns.drop("Egen_gruppe", axis=0)
#samlet_data_gns = samlet_data_gns.drop("Kategori", axis=0)



samlet_data_u250 = pd.DataFrame()
samlet_data_u250["Turisme_pris"]=Prisindeks["Turisme"]
samlet_data_u250["Tjenster_pris"]=Prisindeks["Tjenester"]
samlet_data_u250["TurTje_pris"]=Prisindeks_TurTje
samlet_data_u250["Varer_pris"]=Prisindeks["Varer"]
samlet_data_u250["TurTjeVar_pris"]=Prisindeks_TurTjeVar
samlet_data_u250["Energi_pris"]=Prisindeks["Energi"]
samlet_data_u250["TurTjeVarEne_pris"]=Prisindeks_TurTjeVarEne
samlet_data_u250["Biler_pris"]=Prisindeks["Biler"]
samlet_data_u250["Turisme_maengde"]=maengder_u250_MAKRO["Turisme"]
samlet_data_u250["Tjenester_maengde"]=maengder_u250_MAKRO["Tjenester"]
samlet_data_u250["TurTje_maengde"]=TurTje_maengde["u250"]
samlet_data_u250["Varer_maengde"]=maengder_u250_MAKRO["Varer"]
samlet_data_u250["TurTjeVar_maengde"]=TurTjeVar_maengde["u250"]
samlet_data_u250["Energi_maengde"]=maengder_u250_MAKRO["Energi"]
samlet_data_u250["TurTjeVarEne_maengde"]=TurTjeVarEne_maengde["u250"]
samlet_data_u250["Biler_maengde"]=maengder_u250_MAKRO["Biler"]
#samlet_data_u250 = samlet_data_u250.drop("MAKRO_gruppe", axis=0)
#samlet_data_u250 = samlet_data_u250.drop("Egen_gruppe", axis=0)
#samlet_data_u250 = samlet_data_u250.drop("Kategori", axis=0)

samlet_data_250_450 = pd.DataFrame()
samlet_data_250_450["Turisme_pris"]=Prisindeks["Turisme"]
samlet_data_250_450["Tjenster_pris"]=Prisindeks["Tjenester"]
samlet_data_250_450["TurTje_pris"]=Prisindeks_TurTje
samlet_data_250_450["Varer_pris"]=Prisindeks["Varer"]
samlet_data_250_450["TurTjeVar_pris"]=Prisindeks_TurTjeVar
samlet_data_250_450["Energi_pris"]=Prisindeks["Energi"]
samlet_data_250_450["TurTjeVarEne_pris"]=Prisindeks_TurTjeVarEne
samlet_data_250_450["Biler_pris"]=Prisindeks["Biler"]
samlet_data_250_450["Turisme_maengde"]=maengder_250_450_MAKRO["Turisme"]
samlet_data_250_450["Tjenester_maengde"]=maengder_250_450_MAKRO["Tjenester"]
samlet_data_250_450["TurTje_maengde"]=TurTje_maengde["250_450"]
samlet_data_250_450["Varer_maengde"]=maengder_250_450_MAKRO["Varer"]
samlet_data_250_450["TurTjeVar_maengde"]=TurTjeVar_maengde["250_450"]
samlet_data_250_450["Energi_maengde"]=maengder_250_450_MAKRO["Energi"]
samlet_data_250_450["TurTjeVarEne_maengde"]=TurTjeVarEne_maengde["250_450"]
samlet_data_250_450["Biler_maengde"]=maengder_250_450_MAKRO["Biler"]
#samlet_data_250_450 = samlet_data_250_450.drop("MAKRO_gruppe", axis=0)
#samlet_data_250_450 = samlet_data_250_450.drop("Egen_gruppe", axis=0)
#samlet_data_250_450 = samlet_data_250_450.drop("Kategori", axis=0)

samlet_data_450_700 = pd.DataFrame()
samlet_data_450_700["Turisme_pris"]=Prisindeks["Turisme"]
samlet_data_450_700["Tjenster_pris"]=Prisindeks["Tjenester"]
samlet_data_450_700["TurTje_pris"]=Prisindeks_TurTje
samlet_data_450_700["Varer_pris"]=Prisindeks["Varer"]
samlet_data_450_700["TurTjeVar_pris"]=Prisindeks_TurTjeVar
samlet_data_450_700["Energi_pris"]=Prisindeks["Energi"]
samlet_data_450_700["TurTjeVarEne_pris"]=Prisindeks_TurTjeVarEne
samlet_data_450_700["Biler_pris"]=Prisindeks["Biler"]
samlet_data_450_700["Turisme_maengde"]=maengder_450_700_MAKRO["Turisme"]
samlet_data_450_700["Tjenester_maengde"]=maengder_450_700_MAKRO["Tjenester"]
samlet_data_450_700["TurTje_maengde"]=TurTje_maengde["450_700"]
samlet_data_450_700["Varer_maengde"]=maengder_450_700_MAKRO["Varer"]
samlet_data_450_700["TurTjeVar_maengde"]=TurTjeVar_maengde["450_700"]
samlet_data_450_700["Energi_maengde"]=maengder_450_700_MAKRO["Energi"]
samlet_data_450_700["TurTjeVarEne_maengde"]=TurTjeVarEne_maengde["450_700"]
samlet_data_450_700["Biler_maengde"]=maengder_450_700_MAKRO["Biler"]
#samlet_data_450_700 = samlet_data_450_700.drop("MAKRO_gruppe", axis=0)
#samlet_data_450_700 = samlet_data_450_700.drop("Egen_gruppe", axis=0)
#samlet_data_450_700 = samlet_data_450_700.drop("Kategori", axis=0)

samlet_data_700_1mio = pd.DataFrame()
samlet_data_700_1mio["Turisme_pris"]=Prisindeks["Turisme"]
samlet_data_700_1mio["Tjenster_pris"]=Prisindeks["Tjenester"]
samlet_data_700_1mio["TurTje_pris"]=Prisindeks_TurTje
samlet_data_700_1mio["Varer_pris"]=Prisindeks["Varer"]
samlet_data_700_1mio["TurTjeVar_pris"]=Prisindeks_TurTjeVar
samlet_data_700_1mio["Energi_pris"]=Prisindeks["Energi"]
samlet_data_700_1mio["TurTjeVarEne_pris"]=Prisindeks_TurTjeVarEne
samlet_data_700_1mio["Biler_pris"]=Prisindeks["Biler"]
samlet_data_700_1mio["Turisme_maengde"]=maengder_700_1mio_MAKRO["Turisme"]
samlet_data_700_1mio["Tjenester_maengde"]=maengder_700_1mio_MAKRO["Tjenester"]
samlet_data_700_1mio["TurTje_maengde"]=TurTje_maengde["700_1mio"]
samlet_data_700_1mio["Varer_maengde"]=maengder_700_1mio_MAKRO["Varer"]
samlet_data_700_1mio["TurTjeVar_maengde"]=TurTjeVar_maengde["700_1mio"]
samlet_data_700_1mio["Energi_maengde"]=maengder_700_1mio_MAKRO["Energi"]
samlet_data_700_1mio["TurTjeVarEne_maengde"]=TurTjeVarEne_maengde["700_1mio"]
samlet_data_700_1mio["Biler_maengde"]=maengder_700_1mio_MAKRO["Biler"]
#samlet_data_700_1mio = samlet_data_700_1mio.drop("MAKRO_gruppe", axis=0)
#samlet_data_700_1mio = samlet_data_u250.drop("Egen_gruppe", axis=0)
#samlet_data_700_1mio = samlet_data_700_1mio.drop("Kategori", axis=0)

samlet_data_o1mio = pd.DataFrame()
samlet_data_o1mio["Turisme_pris"]=Prisindeks["Turisme"]
samlet_data_o1mio["Tjenster_pris"]=Prisindeks["Tjenester"]
samlet_data_o1mio["TurTje_pris"]=Prisindeks_TurTje
samlet_data_o1mio["Varer_pris"]=Prisindeks["Varer"]
samlet_data_o1mio["TurTjeVar_pris"]=Prisindeks_TurTjeVar
samlet_data_o1mio["Energi_pris"]=Prisindeks["Energi"]
samlet_data_o1mio["TurTjeVarEne_pris"]=Prisindeks_TurTjeVarEne
samlet_data_o1mio["Biler_pris"]=Prisindeks["Biler"]
samlet_data_o1mio["Turisme_maengde"]=maengder_o1mio_MAKRO["Turisme"]
samlet_data_o1mio["Tjenester_maengde"]=maengder_o1mio_MAKRO["Tjenester"]
samlet_data_o1mio["TurTje_maengde"]=TurTje_maengde["o1mio"]
samlet_data_o1mio["Varer_maengde"]=maengder_o1mio_MAKRO["Varer"]
samlet_data_o1mio["TurTjeVar_maengde"]=TurTjeVar_maengde["o1mio"]
samlet_data_o1mio["Energi_maengde"]=maengder_o1mio_MAKRO["Energi"]
samlet_data_o1mio["TurTjeVarEne_maengde"]=TurTjeVarEne_maengde["o1mio"]
samlet_data_o1mio["Biler_maengde"]=maengder_o1mio_MAKRO["Biler"]
#samlet_data_o1mio = samlet_data_o1mio.drop("MAKRO_gruppe", axis=0)
#samlet_data_o1mio = samlet_data_o1mio.drop("Egen_gruppe", axis=0)
#samlet_data_o1mio = samlet_data_o1mio.drop("Kategori", axis=0)

#dette loop virker ikke 
dataset = (samlet_data_u250, samlet_data_250_450, samlet_data_450_700, samlet_data_700_1mio, samlet_data_o1mio, samlet_data_gns)
for df in dataset:
    df = df.drop("MAKRO_gruppe", axis=0)
    df = df.drop("Egen_gruppe", axis=0)
    df = df.drop("Kategori", axis=0)


samlet_data_u250.to_csv("data_u250.csv")
samlet_data_250_450.to_csv("data_250_450.csv")
samlet_data_450_700.to_csv("data_450_700.csv")
samlet_data_700_1mio.to_csv("data_700_1mio.csv")
samlet_data_o1mio.to_csv("data_o1mio.csv")
samlet_data_gns.to_csv("data_gns.csv")



# Til pythonfil: samlet_data_gns.to_pickle("data_tur_tje.pkl")
# Samler det hele i en zip

#compression_opts = dict(method='zip',
 #                       archive_name='out.csv')  

#df.to_csv('out.zip', index=False,
#          compression=compression_opts)


# Nu skal vi estimere. slut på databehandling. 









