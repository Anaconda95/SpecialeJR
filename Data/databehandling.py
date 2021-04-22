# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""

import pandas as pd
years = [1994,1995,1996,1997,1998,1999,2000,2001,2002,2003,2004,2005,2006,2007,2008,2009,2010,2011,2012,2013,2014,2015,2016,2017,2018,2019]


data = {}
for year in years:
    data[year] = pd.read_excel (f'C:\specialeJR\Data\Forbrug loebende priser {year}.xlsx')
    data[year] = data[year].dropna( axis=0, how='all')

#grup = [gns, dec1,dec2,dec3,dec4,dec5,dec6,dec7,dec8,dec9,dec10]
grupper = ["Hele landet","1. decil","2. decil","3. decil","4. decil","5. decil","6. decil","7. decil","8. decil","9. decil","10. decil"]
#%%
#years = [1994,1995,1996,1997,1998,1999,2000,2001,2002,2003,2004,2005,2006,2007,2008,2009,2010,2011,2012,2013,2014,2015,2016,2017,2018,2019]

data_tidsserie = {}

for gruppe in grupper:
    data_tidsserie[gruppe] = {}
    for year in years:
        data_tidsserie[gruppe][year] = pd.DataFrame(columns=["Forbrug", "Forbrug1",year])
        data_tidsserie[gruppe][year][year] = data[year][gruppe]
        data_tidsserie[gruppe][year]["Forbrug"] = data[year]["Forbrug"]
#%%
for gruppe in grupper:
        ### Indsætter nul'er
    data_tidsserie[gruppe][1994].loc[0:941,"Forbrug1"] = "0"+ data_tidsserie[gruppe][1994].loc[0:941,"Forbrug"]
    data_tidsserie[gruppe][1994].loc[941:1134,"Forbrug1"] =  data_tidsserie[gruppe][1994].loc[941:1134,"Forbrug"]
    
    data_tidsserie[gruppe][1995].loc[0:1006,"Forbrug1"] = "0"+ data_tidsserie[gruppe][1995].loc[0:1006,"Forbrug"]
    data_tidsserie[gruppe][1995].loc[1006:1210,"Forbrug1"] =  data_tidsserie[gruppe][1995].loc[1006:1210,"Forbrug"]
    
    data_tidsserie[gruppe][1996].loc[0:1003,"Forbrug1"] = "0"+ data_tidsserie[gruppe][1996].loc[0:1003,"Forbrug"]        
    data_tidsserie[gruppe][1996].loc[1003:1205,"Forbrug1"] =  data_tidsserie[gruppe][1996].loc[1003:1205,"Forbrug"]
    
    data_tidsserie[gruppe][1997].loc[0:1016,"Forbrug1"] = "0"+ data_tidsserie[gruppe][1997].loc[0:1016,"Forbrug"]
    data_tidsserie[gruppe][1997].loc[1016:1217,"Forbrug1"] =  data_tidsserie[gruppe][1997].loc[1016:1217,"Forbrug"]
    
    data_tidsserie[gruppe][1998].loc[0:1013,"Forbrug1"] = "0"+ data_tidsserie[gruppe][1998].loc[0:1013,"Forbrug"]        
    data_tidsserie[gruppe][1998].loc[1013:1209,"Forbrug1"] =  data_tidsserie[gruppe][1998].loc[1013:1209,"Forbrug"]
    
    data_tidsserie[gruppe][1999].loc[0:1018,"Forbrug1"] = "0"+ data_tidsserie[gruppe][1999].loc[0:1018,"Forbrug"]
    data_tidsserie[gruppe][1999].loc[1018:1217,"Forbrug1"] =  data_tidsserie[gruppe][1999].loc[1018:1217,"Forbrug"]
    
    data_tidsserie[gruppe][2000].loc[0:1023,"Forbrug1"] = "0"+ data_tidsserie[gruppe][2000].loc[0:1023,"Forbrug"]
    data_tidsserie[gruppe][2000].loc[1023:1228,"Forbrug1"] =  data_tidsserie[gruppe][2000].loc[1023:1228,"Forbrug"]
      
    data_tidsserie[gruppe][2001].loc[0:1019,"Forbrug1"] = "0"+ data_tidsserie[gruppe][2001].loc[0:1019,"Forbrug"]
    data_tidsserie[gruppe][2001].loc[1019:1226,"Forbrug1"] =  data_tidsserie[gruppe][2001].loc[1019:1226,"Forbrug"]
    
    data_tidsserie[gruppe][2002].loc[0:1035,"Forbrug1"] = "0"+ data_tidsserie[gruppe][2002].loc[0:1035,"Forbrug"]
    data_tidsserie[gruppe][2002].loc[1035:1243,"Forbrug1"] =  data_tidsserie[gruppe][2002].loc[1035:1243,"Forbrug"]
    
    data_tidsserie[gruppe][2003].loc[0:1037,"Forbrug1"] = "0"+ data_tidsserie[gruppe][2003].loc[0:1037,"Forbrug"]
    data_tidsserie[gruppe][2003].loc[1037:len(data_tidsserie[gruppe][2003]),"Forbrug1"] =  data_tidsserie[gruppe][2003].loc[1037:len(data_tidsserie[gruppe][2003]),"Forbrug"]

    data_tidsserie[gruppe][2004].loc[0:1047,"Forbrug1"] = "0"+ data_tidsserie[gruppe][2004].loc[0:1047,"Forbrug"]
    data_tidsserie[gruppe][2004].loc[1047:len(data_tidsserie[gruppe][2004]),"Forbrug1"] =  data_tidsserie[gruppe][2004].loc[1047:len(data_tidsserie[gruppe][2004]),"Forbrug"]
    
    data_tidsserie[gruppe][2005].loc[0:1054,"Forbrug1"] = "0"+ data_tidsserie[gruppe][2005].loc[0:1054,"Forbrug"]
    data_tidsserie[gruppe][2005].loc[1054:len(data_tidsserie[gruppe][2005]),"Forbrug1"] =  data_tidsserie[gruppe][2005].loc[1054:len(data_tidsserie[gruppe][2005]),"Forbrug"]
    
    data_tidsserie[gruppe][2006].loc[0:1049,"Forbrug1"] = "0"+ data_tidsserie[gruppe][2006].loc[0:1049,"Forbrug"]
    data_tidsserie[gruppe][2006].loc[1049:len(data_tidsserie[gruppe][2006]),"Forbrug1"] =  data_tidsserie[gruppe][2006].loc[1049:len(data_tidsserie[gruppe][2006]),"Forbrug"]
    
    data_tidsserie[gruppe][2007].loc[0:1055,"Forbrug1"] = "0"+ data_tidsserie[gruppe][2007].loc[0:1055,"Forbrug"]
    data_tidsserie[gruppe][2007].loc[1055:len(data_tidsserie[gruppe][2007]),"Forbrug1"] =  data_tidsserie[gruppe][2007].loc[1055:len(data_tidsserie[gruppe][2007]),"Forbrug"]
    
    data_tidsserie[gruppe][2008].loc[0:1050,"Forbrug1"] = "0"+ data_tidsserie[gruppe][2008].loc[0:1050,"Forbrug"]
    data_tidsserie[gruppe][2008].loc[1050:len(data_tidsserie[gruppe][2008]),"Forbrug1"] =  data_tidsserie[gruppe][2008].loc[1050:len(data_tidsserie[gruppe][2008]),"Forbrug"]
    
    data_tidsserie[gruppe][2009].loc[0:1052,"Forbrug1"] = "0"+ data_tidsserie[gruppe][2009].loc[0:1052,"Forbrug"]
    data_tidsserie[gruppe][2009].loc[1052:len(data_tidsserie[gruppe][2009]),"Forbrug1"] =  data_tidsserie[gruppe][2009].loc[1052:len(data_tidsserie[gruppe][2009]),"Forbrug"]
    
    data_tidsserie[gruppe][2010].loc[0:1052,"Forbrug1"] = "0"+ data_tidsserie[gruppe][2010].loc[0:1052,"Forbrug"]
    data_tidsserie[gruppe][2010].loc[1052:len(data_tidsserie[gruppe][2010]),"Forbrug1"] =  data_tidsserie[gruppe][2010].loc[1052:len(data_tidsserie[gruppe][2010]),"Forbrug"]
    
    data_tidsserie[gruppe][2011].loc[0:1059,"Forbrug1"] = "0"+ data_tidsserie[gruppe][2011].loc[0:1059,"Forbrug"]
    data_tidsserie[gruppe][2011].loc[1059:len(data_tidsserie[gruppe][2011]),"Forbrug1"] =  data_tidsserie[gruppe][2011].loc[1059:len(data_tidsserie[gruppe][2011]),"Forbrug"]
    
    data_tidsserie[gruppe][2012].loc[0:1061,"Forbrug1"] = "0"+ data_tidsserie[gruppe][2012].loc[0:1061,"Forbrug"]
    data_tidsserie[gruppe][2012].loc[1061:len(data_tidsserie[gruppe][2012]),"Forbrug1"] =  data_tidsserie[gruppe][2012].loc[1061:len(data_tidsserie[gruppe][2012]),"Forbrug"]
    
    data_tidsserie[gruppe][2013].loc[0:1063,"Forbrug1"] = "0"+ data_tidsserie[gruppe][2013].loc[0:1063,"Forbrug"]
    data_tidsserie[gruppe][2013].loc[1063:len(data_tidsserie[gruppe][2013]),"Forbrug1"] =  data_tidsserie[gruppe][2013].loc[1063:len(data_tidsserie[gruppe][2013]),"Forbrug"]
    
    data_tidsserie[gruppe][2014].loc[0:1055,"Forbrug1"] = "0"+ data_tidsserie[gruppe][2014].loc[0:1055,"Forbrug"]
    data_tidsserie[gruppe][2014].loc[1055:len(data_tidsserie[gruppe][2014]),"Forbrug1"] =  data_tidsserie[gruppe][2014].loc[1055:len(data_tidsserie[gruppe][2014]),"Forbrug"]
    
    data_tidsserie[gruppe][2015].loc[0:1063,"Forbrug1"] = "0"+ data_tidsserie[gruppe][2015].loc[0:1063,"Forbrug"]
    data_tidsserie[gruppe][2015].loc[1063:len(data_tidsserie[gruppe][2015]),"Forbrug1"] =  data_tidsserie[gruppe][2015].loc[1063:len(data_tidsserie[gruppe][2015]),"Forbrug"]
    
    data_tidsserie[gruppe][2016].loc[0:1077,"Forbrug1"] = "0"+ data_tidsserie[gruppe][2016].loc[0:1077,"Forbrug"]
    data_tidsserie[gruppe][2016].loc[1077:len(data_tidsserie[gruppe][2016]),"Forbrug1"] =  data_tidsserie[gruppe][2016].loc[1077:len(data_tidsserie[gruppe][2016]),"Forbrug"]
    
    data_tidsserie[gruppe][2017].loc[0:1095,"Forbrug1"] = "0"+ data_tidsserie[gruppe][2017].loc[0:1095,"Forbrug"]
    data_tidsserie[gruppe][2017].loc[1095:len(data_tidsserie[gruppe][2017]),"Forbrug1"] =  data_tidsserie[gruppe][2017].loc[1095:len(data_tidsserie[gruppe][2017]),"Forbrug"]
    
    data_tidsserie[gruppe][2018].loc[0:1101,"Forbrug1"] = "0"+ data_tidsserie[gruppe][2018].loc[0:1101,"Forbrug"]
    data_tidsserie[gruppe][2018].loc[1101:len(data_tidsserie[gruppe][2018]),"Forbrug1"] =  data_tidsserie[gruppe][2018].loc[1101:len(data_tidsserie[gruppe][2018]),"Forbrug"]
    
    data_tidsserie[gruppe][2019].loc[0:1092,"Forbrug1"] = "0"+ data_tidsserie[gruppe][2019].loc[0:1092,"Forbrug"]
    data_tidsserie[gruppe][2019].loc[1092:len(data_tidsserie[gruppe][2019]),"Forbrug1"] =  data_tidsserie[gruppe][2019].loc[1092:len(data_tidsserie[gruppe][2019]),"Forbrug"]
    
    
        
        
        #data_tidsserie[gruppe][year]["Aar"]=year
        


#%%
panel = {}
for gruppe in grupper:
    panel[gruppe] = pd.DataFrame(columns=["Forbrug"])
    panel[gruppe]["Forbrug"] = data_tidsserie[gruppe][1994]["Forbrug"]
    for year in years:
        panel[gruppe] = panel[gruppe].merge(data_tidsserie[gruppe][year],on="Forbrug", how="outer", sort=True)
        panel[gruppe] = panel[gruppe].fillna(0)

   # del panel[gruppe]["Forbrug"]
   # panel[gruppe] = panel[gruppe].rename(columns={"Forbrug1": "Forbrug"})


    

#%%
disponibel = pd.read_excel ('C:\specialeJR\Data\Disponibel indkomst tidsserie.xlsx')
disponibel = disponibel.sort_values(by="Aar", ascending=True)

#%%
disp_grup = {}
for gruppe in grupper:
    disp_grup[gruppe] = pd.DataFrame(columns=["Aar", gruppe])
    disp_grup[gruppe]["Aar"]=disponibel["Aar"]
    disp_grup[gruppe][gruppe]=disponibel[gruppe]
    disp_grup[gruppe]["Hejj"] = 1
    disp_grup[gruppe] = disp_grup[gruppe].pivot(index="Hejj",columns="Aar",values=gruppe)
    disp_grup[gruppe]["Forbrug"] = "Disponibel indkomst"
    panel[gruppe] = panel[gruppe].append(disp_grup[gruppe], ignore_index=True)
    
#%%

samlet_forbrug = pd.read_excel ('C:\specialeJR\Data\Samlet forbrug tidsserie.xlsx')
samlet_forbrug = samlet_forbrug.sort_values(by="Aar", ascending=True)
samlet_for = {}
for gruppe in grupper:
    samlet_for[gruppe] = pd.DataFrame(columns=["Aar", gruppe])
    samlet_for[gruppe]["Aar"]=samlet_forbrug["Aar"]
    samlet_for[gruppe][gruppe]=samlet_forbrug[gruppe]
    samlet_for[gruppe]["Hejj"] = 1
    samlet_for[gruppe] = samlet_for[gruppe].pivot(index="Hejj",columns="Aar",values=gruppe)
    samlet_for[gruppe]["Forbrug"] = "Samlet forbrug"
    panel[gruppe] = panel[gruppe].append(samlet_for[gruppe], ignore_index=True).set_index("Forbrug")
    panel[gruppe] = panel[gruppe].transpose()


#%%
for gruppe in grupper:
    panel[gruppe].to_excel (f'C:\specialeJR\Data\Forbrug loebende priser {gruppe}.xlsx')
    
    
    
