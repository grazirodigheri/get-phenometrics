import numpy as np
import pandas as pd
import xarray as xr
import warnings

from dea_tools import temporal

def dea_phenology(serie, method_sos, method_eos):
    warnings.filterwarnings('ignore')

    start = "01-01-2020"

    np_serie = np.array(serie, dtype=np.float32)
    dates_datetime64 = pd.date_range(pd.to_datetime(start, format='%d-%m-%Y'), periods=len(np_serie))
    data_xr = xr.DataArray(np_serie, coords = {'time': dates_datetime64})

    pheno_stats = ['SOS','vSOS','POS','vPOS','EOS','vEOS','Trough','LOS','AOS','ROG','ROS']
    
    try:
        stats = temporal.xr_phenology(
            data_xr,
            method_sos = method_sos,
            method_eos = method_eos,
            stats = pheno_stats,
            verbose = False
        )
        
        keys = list(stats.keys())
        values = [np.array(stats.variables[var]).tolist() for var in stats.keys()]

        return values
    
    except:
        print("ERROR when executing DEA Tools!")
        return None

