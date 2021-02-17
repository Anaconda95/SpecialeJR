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

#Konstruerer priser for hver forbrugs-gruppe - ikke nested

Prisindeks = {}
maengder_gns_MAKRO = {}
Grupper = ["Turisme","Tjenester","Varer","Energi","Biler"]

for name in Grupper:
    Prisindeks[name] = ((priser[priser['MAKRO_gruppe']==name].iloc[:,1:27]*maengder_gns[maengder_gns['MAKRO_gruppe']==name]
         .iloc[:,1:27]).sum(axis=0))/(maengder_gns[maengder_gns['MAKRO_gruppe']==name].sum(axis=0))
    maengder_gns_MAKRO[name] = maengder_gns[maengder_gns['MAKRO_gruppe']==name].sum(axis=0)
    
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

    

#hej

#noter

#Nu skal vi konstruere priser for de nestede forbrugsgrupper 
# hvordan gøres dette? 

#Prisindeks på 

#priserTur = priser[priser['MAKRO_gruppe']=='Turisme']
#mTur = maengder_gns[maengder_gns['MAKRO_gruppe']=='Turisme']
#pTur = ((priser[priser['MAKRO_gruppe']=='Turisme'].iloc[:,1:27]*maengder_gns[maengder_gns['MAKRO_gruppe']=='Turisme']
#         .iloc[:,1:27]).sum(axis=0))/(maengder_gns[maengder_gns['MAKRO_gruppe']=='Turisme'].sum(axis=0))

#priserVar = priser[priser['MAKRO_gruppe']=='Varer']
#mVar = maengder_gns[maengder_gns['MAKRO_gruppe']=='Varer']
#pv   = priserVar.iloc[:,1:27]*mVar.iloc[:,1:27]
#sumpv = pv.sum(axis=0)
#sumVar = mVar.sum(axis=0)
#pVar=sumpv/sumVar

#pTur = (priser.iloc[33,1:27]*maengder_gns.iloc[33,1:27] + priser.iloc[39,1:27]*maengder_gns.iloc[39,1:27]
#        )/(maengder_gns.iloc[33,1:27] + maengder_gns.iloc[39,1:27])






