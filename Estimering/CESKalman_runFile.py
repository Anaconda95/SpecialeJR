# -*- coding: utf-8 -*-
"""
Created on Wed Aug 26 13:02:56 2020

@author: B051581

Run the CESKalman function from R to get substitutionselasticities
"""

import rpy2
from rpy2.robjects.packages import importr
from rpy2.robjects import pandas2ri
from rpy2.robjects import r

import sys
# sys.platform = 'win64'
import pandas as pd
import dreamtools as dt
import os
import numpy as np
import statsmodels.api as sm

# utils = importr('utils')
# utils.install_packages('normtest')
# utils.install_packages('dlm')
# utils.install_packages('lmtest')
# utils.install_packages('CESKalman')

dlm = importr('dlm')
lmtest = importr('lmtest')
normtest = importr('normtest')
CESKalman = importr('CESKalman')
pandas2ri.activate() # Aktiver automatiske konverteringer af data-typer mellem pandas og R   

#sectors = ['lan', 'byg', 'ene', 'udv', 'fre', 'soe', 'tje']
sectors = ["fre"] ## Lad os lige kigge på MAKROs fremstillingsbranche

from Optimer_Gen_Loading_Data import gen_loading_data


for sector in sectors:
    dataset = gen_loading_data(sector=sector)
      
    datalist = pd.concat([dataset.loc[:,'pK'],dataset.loc[:,'pL'],dataset.loc[:,'qK'],dataset.loc[:,'qL'],
                            dataset.loc[:,'pKL'],dataset.loc[:,'pB'],dataset.loc[:,'qKL'],dataset.loc[:,'qB'],
                            dataset.loc[:,'pKLB'],dataset.loc[:,'pR'],dataset.loc[:,'qKLB'],dataset.loc[:,'qR']], axis=1)
        
    def timeseries(x, t0=1969, T=2016):
        #index = x.index.drop(to_del)
          del1 = x[x.index.astype('int64') > T].index
          del2 = x[x.index.astype('int64') < t0].index
          to_del = list(del1) + list(del2)
          x.drop(to_del , inplace=True)
          return x
        
    data = timeseries(x=datalist)
    
    est_kalman = {}
    for nest in range(1,4):
        # nest = 1   ## Lad os lige starte med at kigge på nest 1 (KL, nederste nest)  
        tmp = pd.concat([data.iloc[:,0+4*(nest-1)],data.iloc[:,1+4*(nest-1)],data.iloc[:,2+4*(nest-1)],data.iloc[:,3+4*(nest-1)]], axis=1)
        Kalman = r.CESKalman(data=tmp, max_nlags = 2, grid_alpha_init = np.array([-0.9,-0.1,0.3]), grid_sigma_init = np.array([0,1.5,0.2]), print_results = True, lambda_est_freely =False, grid_lambda = np.array([100,1000,20]))
        est_kalman[nest] = dict(zip(Kalman.names, list(Kalman)))
