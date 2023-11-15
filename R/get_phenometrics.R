# 
#' @title get_phenometrics
#' 
#' @param serie: (array) time series
#' @param package: (string) package id ("PF", "CP", "TM", "DT", "PX", "GB")
#' @param parameters: (array) one or more input parameters usde in the extraction functions
#' @return (data.frame) Data frame containing all metrics selected
# 

get_phenometrics <- function(serie, package, parameters) {

    # Extracts the phenological metrics for the selected package
    if (package == "PF") {
        method <- parameters[1]
        trs_sos <- as.numeric(parameters[2])
        trs_eos <- as.numeric(parameters[3])
        metrics <- extract_metrics_phenofit(serie, method, trs_sos, trs_eos, plot=F)
        names(metrics) <- c("PF_sos", "PF_eos")
    }

    else if (package == "CP") {
        trs_sos <- parameters[1]
        trs_eos <- parameters[2]
        metrics_sos <- extract_metrics_cropphenology(serie, trs_sos)
        metrics_eos <- extract_metrics_cropphenology(serie, trs_eos)
        metrics <- data.frame(OnsetT=metrics_sos$OnsetT, OffsetT=metrics_eos$OffsetT)
        names(metrics) = c("CP_sos", "CP_eos")
    }

    else if (package == "TM") {
        metrics <- extract_metrics_timesat(serie, parameters)
    }

    else if (package == "DT") {
        m_sos <- parameters[1]
        m_eos <- parameters[2]
        metrics_dt <- extract_metrics_dea(serie, m_sos, m_eos)
        metrics <- metrics_dt[, c("SOS", "EOS")]
        names(metrics) = c("DT_sos", "DT_eos")
    }

    else if (package == "PX") {
        trs_green <- parameters[1]
        trs_sen <- parameters[2]
        metrics_px <- extract_metrics_phenex(serie, trs_green, trs_sen)
        metrics <- metrics_px[, c("greenup", "senescence")]
        names(metrics) = c("PX_sos", "PX_eos")
    }
            
    else if (package == "GB") {
        method <- parameters[1]
        trs_sos <- as.numeric(parameters[2])
        trs_eos <- as.numeric(parameters[3])
        metrics_gb <- extract_metrics_greenbrown(serie, method, trs_sos, trs_eos, F)
        metrics <- metrics_gb[, c("sos", "eos")]
        names(metrics) = c("GB_sos", "GB_eos")
    }

    return(metrics)
}