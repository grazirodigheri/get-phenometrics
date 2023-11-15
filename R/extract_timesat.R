# 
#' @title extract_metrics_timesat
#' 
#' @param serie: (array) time series
#' @param trs: (number) threshold
#' @return (data.frame) Data frame containing all metrics selected
# 

# This function requires the rTIMESAT package developed by Kong et al., (2021)
# You can install the package using the command: # devtools::install_github("kongdd/rTIMESAT")
library("rTIMESAT")

extract_metrics_timesat <- function(serie, trs) {

    ## Set TIMESAT options
    options_TM <- list(
        ylu                 = c(0, 0.999),    # Valid data range (lower upper)
        qc_1                = c(0, 0, 1),     # Quality range 1 and weight
        qc_2                = c(1, 1, 0.5),   # Quality range 2 and weight
        qc_3                = c(2, 3, 0.2),   # Quality range 3 and weight
        A                   = 0,              # Amplitude cutoff value
        debug               = 3,
        output_type         = c(1, 1, 0),     # Output files (1/0 1/0 1/0), 1: seasonality data; 2: smoothed time-series; 3: original time-series
        seasonpar           = 0,              # Seasonality parameter (0-1)
        iters               = 2,              # No. of envelope iterations (3/2/1)
        # FUN                 = 1,              # Fitting method (1/2/3): (SG/AG/DL)
        # half_win            = 7,              # half Window size for Sav-Gol.
        meth_pheno          = 1,              # (1: seasonal amplitude, 2: absolute value, 3: relatvIe amplitude, 4: STL trend)
        trs                 = trs             # Season start / end values
    )
    
    # Repeat time-series
    rept <- 2
    ts_rep <- rep(serie, rept)
    nptperyear <- length(ts_rep)
    
    # Set clean data for the entire time-series
    SummaryQA <- rep(0, nptperyear)
    
    # Create df with VI and QA data
    df_vi <- data.frame(
        VI <- ts_rep,
        SummaryQA <- SummaryQA
    )
    
    # Extract metrics
    extract_TM <- TSF_main(
        y = df_vi$VI,
        qc = df_vi$SummaryQA,
        nptperyear = nptperyear/rept,
        options = options_TM,
        cache = F,
        t = NULL
    )
    
    metrics_TM <- extract_TM$pheno %>%
        as.data.frame() 
        
    metrics <- metrics_TM[, c("time_start", "time_end")]
    names(metrics) = c("TM_sos", "TM_eos")
    metrics$TM_sos <- round(metrics$TM_sos, 0)
    metrics$TM_eos <- round(metrics$TM_eos, 0)
   
    # Since the time-series was repeat we need to adjust the date for the first year
    metrics <- metrics %>% 
        dplyr::mutate(TM_sos = ifelse(TM_sos > length(serie), TM_sos-length(serie), TM_sos)) %>%
        dplyr::mutate(TM_eos = ifelse(TM_eos > length(serie), TM_eos-length(serie), TM_eos)) %>%
        dplyr::arrange(TM_sos) %>%
        dplyr::filter(TM_sos > 0)
    
    # If TM was not able to extract any data, return NA
    if(nrow(metrics)==0){
        metrics <- data.frame(TM_sos=as.numeric(NA), TM_eos=as.numeric(NA))
    }
    else {
        metrics <- metrics %>% dplyr::slice(1L)
    }
        
    return (metrics)
}