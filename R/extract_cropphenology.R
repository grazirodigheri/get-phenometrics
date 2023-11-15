# 
#' @title extract_metrics_cropphenology
#' 
#' @param serie: (array) time series
#' @param percent: (number) threshold
#' @return (data.frame) Data frame containing all metrics selected
# 

# This function requires the CropPhenology package developed by Araya et al., (2018)
# You can install the package using the command: install_github("SofanitAraya/CropPhenology")
library("CropPhenology")

extract_metrics_cropphenology <- function(serie, percent) {
    metrics <- SinglePhenology(serie, Percentage=percent)
    
    metrics_df <- data.frame(
        OnsetV = metrics[1],
        OnsetT = metrics[2],
        MaxV = metrics[3],
        MaxT = metrics[4],
        OffsetV = metrics[5],
        OffsetT = metrics[6],
        LengthGS = metrics[7]
    )
    
    return (metrics_df)
}