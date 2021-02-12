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
#food_gns = loebpriser_gns()
loebpriser_gns_makro = loebpriser_gns.groupby("MAKRO_gruppe").sum()
print(loebpriser_gns_makro.index)

indkomstkategorier = ["loebpriser_gns_makro", "_u250", "_250450", "450_700", "700_1mio" , "o1mio"]

#loebpriser_gns_makro+hej =loebpriser_gns_makro

#for df_name in indkomstkategorier
 #   df_name= df+'_makro'
  #  reviews[df_name] = df.groupby("MAKRO_gruppe").sum()

import numpy as np

priservar = priser[priser['MAKRO_gruppe']=='Varer']
mvar = maengder_gns[maengder_gns['MAKRO_gruppe']=='Varer']
for i in priservar.iterrows():
    pvar = priservar[i]*mvar[i].sum()

    
print(pvar)
    




