# -*- coding: utf-8 -*-
"""
Created on Thu Apr 29 21:17:01 2021

@author: B063675
"""
import pandas as pd

priser = pd.read_csv("C:/specialeJR/Prisdata DST/PRISINDEKS.csv")

Deciler = ["Decil1","Decil2","Decil3","Decil4","Decil5","Decil6","Decil7","Decil8","Decil9","Decil10","Gns"]

Forbrug_loeb = {}

for decil,i in zip(Deciler,["1","2","3","4","5","6","7","8","9","10","h"]):
        Forbrug_loeb[decil] = pd.read_csv(f"C:/specialeJR/Prisdata DST/v8_decil_{i}.csv")
        Forbrug_loeb[decil].drop(["Unnamed: 0","aar","ialt"],axis=1,inplace=True)

#%%
grupper = Forbrug_loeb["Decil1"].columns
priser1 = priser.drop(["Aar"],axis=1)
priser1.columns = grupper
kvint_1 = (Forbrug_loeb['Decil1']+Forbrug_loeb['Decil2'])/2
kvint_2 = (Forbrug_loeb['Decil3']+Forbrug_loeb['Decil4'])/2
kvint_3 = (Forbrug_loeb['Decil5']+Forbrug_loeb['Decil6'])/2
kvint_4 = (Forbrug_loeb['Decil7']+Forbrug_loeb['Decil8'])/2
kvint_5 = (Forbrug_loeb['Decil9']+Forbrug_loeb['Decil10'])/2

kvint_1_fast = kvint_1.div(priser1)
kvint_2_fast = kvint_2.div(priser1)
kvint_3_fast = kvint_3.div(priser1)
kvint_4_fast = kvint_4.div(priser1)
kvint_5_fast = kvint_5.div(priser1)

Ialt_1 = pd.DataFrame(kvint_1_fast.sum(axis=1), columns=["ialt"])
Ialt_2 = pd.DataFrame(kvint_2_fast.sum(axis=1), columns=["ialt"])
Ialt_3 = pd.DataFrame(kvint_3_fast.sum(axis=1), columns=["ialt"])
Ialt_4 = pd.DataFrame(kvint_4_fast.sum(axis=1), columns=["ialt"])
Ialt_5 = pd.DataFrame(kvint_5_fast.sum(axis=1), columns=["ialt"])

Andel_1 = kvint_1_fast.div(Ialt_1.loc[:,"ialt"],axis=0)
Andel_2 = kvint_2_fast.div(Ialt_2.loc[:,"ialt"],axis=0)
Andel_3 = kvint_3_fast.div(Ialt_3.loc[:,"ialt"],axis=0)
Andel_4 = kvint_4_fast.div(Ialt_4.loc[:,"ialt"],axis=0)
Andel_5 = kvint_5_fast.div(Ialt_5.loc[:,"ialt"],axis=0)

#%%
Aar = priser["Aar"]
################## Plotte forbrugandele over tid:
import matplotlib.pyplot as plt
import matplotlib.pylab as pylab
from matplotlib.font_manager import FontProperties
fontP = FontProperties()
fontP.set_size('xx-large')

### lav plots 
fig, axs = plt.subplots(2,4, figsize=(16,12))

Kvintiler = [Andel_1,Andel_2, Andel_3, Andel_4,Andel_5]
Navne = ["Quint 1","Quint 2","Quint 3", "Quint 4", "Quint 5" ]
for (kvint,navn) in  zip(Kvintiler, Navne):
    axs[0, 0].plot(Aar, kvint["kod_fisk_mej"], label=navn)

axs[0, 0].set_title('Meat and dairy', fontsize=18)
axs[0, 0].set_ylabel('Budget share, 2015-prices', color='k')


for kvint,navn in zip(Kvintiler,Navne):
    axs[0, 1].plot(Aar, kvint["ovr_fode"], label=navn)
axs[0, 1].set_title('Other foods', fontsize=18)


for kvint,navn in zip(Kvintiler,Navne):
    axs[0, 2].plot(Aar, kvint["bol"], label=navn)
axs[0, 2].set_title('Housing', fontsize=18)


for kvint,navn in zip(Kvintiler,Navne):
    axs[0, 3].plot(Aar, kvint["ene_hje"], label=navn)
axs[0, 3].set_title('Energy, housing', fontsize=18)
axs[0, 3].legend(bbox_to_anchor=(1.05, 1), loc='upper left', prop=fontP)


for kvint,navn in zip(Kvintiler,Navne):
    axs[1, 0].plot(Aar, kvint["ene_tra"], label=navn)

axs[1, 0].set_title('Energy, transport', fontsize=18)
axs[1, 0].set_ylabel('Budget shares, 2015-prices', color='k')



for kvint,navn in zip(Kvintiler,Navne):
    axs[1, 1].plot(Aar, kvint["tra"], label=navn)
axs[1, 1].set_title('Transport', fontsize=18)


for kvint,navn in zip(Kvintiler,Navne):
    axs[1, 2].plot(Aar, kvint["ovr_var"], label=navn)
axs[1, 2].set_title('Other goods', fontsize=18)


for kvint,navn in zip(Kvintiler,Navne):
    axs[1, 3].plot(Aar, kvint["ovr_tje"], label=navn)
axs[1, 3].set_title('Other services', fontsize=18)
#axs[1, 3].legend(bbox_to_anchor=(1.05, 1), loc='upper left', prop=fontP)

plt.tight_layout()

fig.savefig('C:\specialeJR\Beskrivende\Forbrugsandele_kvint.png',
            format='jpeg',
            dpi=100,
            bbox_inches='tight')

#%%

################ Indkomst-data #################

indkomst = pd.read_excel("C:\specialeJR\Data\Disponibel indkomst tidsserie.xlsx")
indkomst = indkomst.sort_values(by=["Aar"])

#%%
########## Lav til kvintiler ###########
ind_kvint1= indkomst.loc[:,"1. decil"]+indkomst.loc[:,"2. decil"]/10000
ind_kvint2= indkomst.loc[:,"3. decil"]+indkomst.loc[:,"4. decil"]/10000
ind_kvint3= indkomst.loc[:,"5. decil"]+indkomst.loc[:,"6. decil"]/10000
ind_kvint4= indkomst.loc[:,"7. decil"]+indkomst.loc[:,"8. decil"]/10000
ind_kvint5= indkomst.loc[:,"9. decil"]+indkomst.loc[:,"10. decil"]/10000


#%%
fontP.set_size("small")
ind_kvint = [ind_kvint1,ind_kvint2,ind_kvint3, ind_kvint4, ind_kvint5]
#decilind = ["1. decil","2. decil", "3. decil", "4. decil", "5. decil", "6. decil", "7. decil", "8. decil", "9. decil", "10. decil"]
for kvint,navn in zip(ind_kvint,Navne):
    plt.plot(indkomst["Aar"],kvint, label= navn)
plt.legend(bbox_to_anchor=(1.05, 1), loc='upper left', prop=fontP)
#plt.title("Development in disposable income across quintiles", fontsize=14)
plt.ylabel("10.000 DKK")
plt.tight_layout()

plt.savefig('C:\specialeJR\Beskrivende\Indkomstudvikling1.png',
            format='jpeg',
            dpi=100,
            bbox_inches='tight')