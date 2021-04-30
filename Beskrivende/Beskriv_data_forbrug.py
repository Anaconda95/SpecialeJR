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

Forbrug_faste = {}
grupper = Forbrug_loeb["Decil1"].columns
Samlet = {}
for decil in Deciler:
    priser1 = priser.drop(["Aar"],axis=1)
    priser1.columns = grupper
    Forbrug_faste[decil] = Forbrug_loeb[decil]
    for column in Forbrug_loeb[decil]:
            Forbrug_faste[decil][column] = Forbrug_loeb[decil].loc[:,column]/priser1.loc[:,column]
    Samlet[decil]= pd.DataFrame(Forbrug_faste[decil].sum(axis=1), columns=["ialt"])
    #Forbrug_faste[decil] = Forbrug_faste[decil].join(Samlet[decil]["ialt"])


#%%
################# Vil gerne beregne forbrugsandele

Forbrugs_andel = {}

for decil in Deciler:
    Forbrugs_andel[decil] = Forbrug_faste[decil]
    for column in Forbrugs_andel[decil]:
        Forbrugs_andel[decil].loc[:,column] = Forbrugs_andel[decil].loc[:,column]/Samlet[decil].loc[:,"ialt"]

Aar = priser["Aar"]
#%%
################## Plotte forbrugandele over tid:
import matplotlib.pyplot as plt
import matplotlib.pylab as pylab
from matplotlib.font_manager import FontProperties
fontP = FontProperties()
fontP.set_size('xx-large')

### lav plots 
fig, axs = plt.subplots(2,4, figsize=(16,12))

udvalgt_decil = ["Decil1","Decil4","Decil7","Decil10"]
for decil in udvalgt_decil:
    axs[0, 0].plot(Aar, Forbrugs_andel[decil]["kod_fisk_mej"], label=decil)

axs[0, 0].set_title('Kød, fisk og mejeri')
axs[0, 0].set_ylabel('Forbrugsandele, faste priser', color='k')


for decil in udvalgt_decil:
    axs[0, 1].plot(Aar, Forbrugs_andel[decil]["ovr_fode"], label=decil)
axs[0, 1].set_title('Øvrige fødevarer')

for decil in udvalgt_decil:
    axs[0, 2].plot(Aar, Forbrugs_andel[decil]["bol"], label=decil)
axs[0, 2].set_title('Bolig')

for decil in udvalgt_decil:
    axs[0, 3].plot(Aar, Forbrugs_andel[decil]["ene_hje"], label=decil)
axs[0, 3].set_title('Energi til hjemmet')
axs[0, 3].legend(bbox_to_anchor=(1.05, 1), loc='upper left', prop=fontP)

for decil in udvalgt_decil:
    axs[1, 0].plot(Aar, Forbrugs_andel[decil]["ene_tra"], label=decil)

axs[1, 0].set_title('Energi til transport')
axs[1, 0].set_ylabel('Forbrugsandele, faste priser', color='k')


for decil in udvalgt_decil:
    axs[1, 1].plot(Aar, Forbrugs_andel[decil]["tra"], label=decil)
axs[1, 1].set_title('Transport')

for decil in udvalgt_decil:
    axs[1, 2].plot(Aar, Forbrugs_andel[decil]["ovr_var"], label=decil)
axs[1, 2].set_title('Øvrige vare')

for decil in udvalgt_decil:
    axs[1, 3].plot(Aar, Forbrugs_andel[decil]["ovr_tje"], label=decil)
axs[1, 3].set_title('Øvrige tjenester')
#axs[1, 3].legend(bbox_to_anchor=(1.05, 1), loc='upper left', prop=fontP)

plt.tight_layout()

fig.savefig('C:\specialeJR\Beskrivende\Forbrugsandele.png',
            format='jpeg',
            dpi=100,
            bbox_inches='tight')

#%%

################ Indkomst-data #################

indkomst = pd.read_excel("C:\specialeJR\Data\Disponibel indkomst tidsserie.xlsx")
indkomst = indkomst.sort_values(by=["Aar"])

#%%
fontP.set_size("small")
decilind = ["1. decil","2. decil", "3. decil", "4. decil", "5. decil", "6. decil", "7. decil", "8. decil", "9. decil", "10. decil"]
for decil in decilind:
    plt.plot(indkomst["Aar"],indkomst.loc[:,decil], label= decil)
plt.legend(bbox_to_anchor=(1.05, 1), loc='upper left', prop=fontP)
plt.title("Udvikling i disponibel indkomst")
plt.tight_layout()

fig.savefig('C:\specialeJR\Beskrivende\Indkomstudvikling.png',
            format='jpeg',
            dpi=100,
            bbox_inches='tight')