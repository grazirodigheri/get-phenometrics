# 
#' @title extract_metrics_dea
#' 
#' @param serie: (array) time series
#' @param m_sos: (number) sos method ("first", "median")
#' @param m_eos: (number) eos method ("last", "median")
#' @return (data.frame) Data frame containing all metrics selected
# 

# This function requires the Digital Earth Australia python package developed by DEA, (2022)
# You can install the package using the command: 

# Reticulate package invoke python functions from R
library("reticulate")

# Set python executable. On Windows, usually the python path is "C:/Program Files/Python38/python.exe". On Linux, usually the python path is "/usr/bin/python3".
use_python("C:/Program Files/Python38/python.exe")

# Set python source file
source_python("dea_phenology.py")

extract_metrics_dea <- function(serie, m_sos, m_eos) {
    metrics <- dea_phenology(serie, m_sos, m_eos)

    # If DEA was not able to extract any data, return NA
    if (is.null(metrics)) {
        metrics_df <- data.frame(
            SOS = as.integer(NA), 
            EOS = as.integer(NA)
        )
    }
    else{
        # 'SOS','vSOS','POS','vPOS','EOS','vEOS','Trough','LOS','AOS','ROG','ROS'
        metrics_df <- data.frame(
            SOS = as.integer(metrics[[1]]),
            EOS = as.integer(metrics[[5]])
        )
    }
    return (metrics_df)
}