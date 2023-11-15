# 
#' @title extract_metrics_greenbrown
#' 
#' @param serie: (array) time series
#' @param method: (string) method of extraction ("deriv", "trs", "white")
#' @param trs_sos: (number) sos threshold
#' @param trs_eos: (number) eos threshold
#' @param plotT: (boolean) wether to plot
#' @return (data.frame) Data frame containing all metrics selected
# 

# This function requires the greenbrown package developed by Forkel et al. (2015) 
# You can install the package using the command: install.packages("greenbrown", repos="http://R-Forge.R-project.org")
library("greenbrown")

extract_metrics_greenbrown <- function(serie, method, trs_sos, trs_eos, plotT){

    if (method == "deriv"){
        metrics <- greenbrown::PhenoDeriv(
            serie, 
            min.mean = 0.1, 
            calc.pheno = TRUE, 
            plot=plotT)
        metrics <- data.frame(t(metrics))[,c("sos","eos")]
    }
    else if (method == "white"){
        metrics <- greenbrown::PhenoTrs(
            serie, 
            approach = "White", 
            min.mean = 0.1, 
            calc.pheno = TRUE, 
            plot=plotT
        )
        metrics <- data.frame(t(metrics))[,c("sos","eos")]
    }
    else if (method == "trs"){
        # Run PhenoTrs with sos threshold
        metrics_sos <- greenbrown::PhenoTrs(
            serie, 
            approach = "Trs", 
            trs = trs_sos,
            min.mean = 0.1, 
            calc.pheno = TRUE, 
            plot=plotT
        )
        metrics_sos <- data.frame(t(metrics_sos))[,c("sos","eos")]

        # Run PhenoTrs with eos threshold
        metrics_eos <- greenbrown::PhenoTrs(
            serie, 
            approach = "Trs", 
            trs = trs_eos,
            min.mean = 0.1, 
            calc.pheno = TRUE, 
            plot=plotT
        )
        metrics_eos <- data.frame(t(metrics_eos))[,c("sos","eos")]

        metrics <- data.frame(sos=metrics_sos$sos, eos=metrics_eos$eos)
    }
    else{
        print("INCORRECT METHOD. Please use deriv, trs or white.")
    }
    
    metrics$sos <- round(metrics$sos)
    metrics$eos <- round(metrics$eos)
  
    return(metrics)
}