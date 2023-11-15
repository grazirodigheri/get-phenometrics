# 
#' @title extract_metrics_phenex
#' 
#' @param serie: (array) time series
#' @param trs_green: (number) greenup threshold
#' @param trs_sen: (number) senescence threshold
#' @return (data.frame) Data frame containing all metrics selected
# 

# This function requires the phenex package developed by Lange and Doktor, (2017)
# You can install the package using the command: install.packages("phenex")
library("phenex")

extract_metrics_phenex<- function(serie, trs_green, trs_sen){
   
    # Create phenex model with linear interpolation and none correction
    model <- modelNDVI(
        ndvi.values=serie, 
        year.int=1995, 
        MARGIN=2, 
        doParallel=FALSE, 
        correction="none", 
        method="LinIP"
    )

    # Get greenup day
    greenup <- phenoPhase(model[[1]], phase="greenup", method="local", threshold=trs_green, n=1000)

    # Get senescence day
    senescence <- phenoPhase(model[[1]], phase="senescence", method="local", threshold=trs_sen, n=1000)

    # # Get max VI day
    # maxvi <- phenoPhase(model[[1]], phase="max", n=1000)

    # # GSIVI = Green Season Integrated Vegetation Index
    # gsivi <- integrateTimeserie(model[[1]], start=greenup, end=senescence, n=1000)

    # 'greenup','senescence','maxvi','gsivi'
    metrics_df <- data.frame(
        greenup = greenup$mean,
        senescence = senescence$mean
        # maxvi = maxvi$mean,
        # gsivi = gsivi$mean
    )
  
    return(metrics_df)
}