library("signal")
library("imputeTS")
library("phenex")

# This function smooths a time-series with Savitzky-Golay (SG)
func_sg <- function(col){
    return (sgolayfilt(col, p=2, n=5))
}
func_sg_gt <- function(col){
    return (sgolayfilt(col, p=2, n=25))
}

# This function interpolates a time-series
func_int <- function(col){
    return (na_interpolation(as.numeric(col), option="linear"))
}

# This function apply phenex BISE with SG filter and interpolates the time-series
func_bise_sg_int <- function(col){
    vi_bise_sg <- modelNDVI(ndvi.values = as.numeric(col), 
                year.int=2019, multipleSeasons=F, correction="bise", 
                method="SavGol", window.sav=5, degree=2, smoothing=10, 
                MARGIN=2, doParallel=F, slidingperiod=20, cycleValues=T)
    serie_bise_sg <- vi_bise_sg[[1]]@modelledValues
    serie_bise_sg <- na_interpolation(serie_bise_sg, option="linear")
    
    return (as.numeric(serie_bise_sg))
}

# This function clamps a VI time-series
clamp <- function(serie){
    serie[serie > 1] = 1
    serie[serie < -1] = -1
    return (serie)
}

# This function apply phenex BISE in a time-series
func_bise <- function(serie){
    # Constants
    slidingPeriod = 20
    growthFactorThreshold = 0.1 # default
    cycleValues = T

    vi <- new("NDVI", values=serie, year=as.integer(2020))
    vi_bise <- bise(
        vi, 
        slidingperiod=slidingPeriod, 
        growthFactorThreshold=growthFactorThreshold, 
        cycleValues=cycleValues
    )
    serie_bise <- vi_bise@correctedValues

    # Interpolate time-series
    if (sum(is.na(serie_bise)) > 0){
        serie_bise <- na_interpolation(serie_bise, option="linear") # last element = NA
    }
    return(serie_bise)
}