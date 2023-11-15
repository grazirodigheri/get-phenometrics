# 
#' @title extract_metrics_phenofit
#' 
#' @param serie: (array) time series
#' @param method: (string) method of extraction ("deriv", "trs")
#' @param T_sos: (number) sos threshold
#' @param T_eos: (number) eos threshold
#' @param plot: (boolean) wether to plot
#' @return (data.frame) Data frame containing all metrics selected
# 

# This function requires the phenofit package developed by Kong et al., (2022)
# You can install the package using the command: install_github("eco-hydro/phenofit")
library("phenofit")

extract_metrics_phenofit <- function(serie, method, T_sos, T_eos, plot=F){

    time <- seq(1, length(serie), 1)

    if (method == "deriv"){
        metrics <- phenofit::PhenoDeriv(
            serie, 
            time, 
            der1=2, 
            smoothed.spline = FALSE, 
            IsPlot=plot)
        metrics <- data.frame(t(metrics))[,c("sos","eos")]
    }
    else if (method == "trs"){
        res1 <- phenofit::PhenoTrs(serie, time, IsPlot=plot, trs=T_sos)
        sos <- res1[[1]]

        res2 <- phenofit::PhenoTrs(serie, time, IsPlot=plot, trs=T_eos)
        eos <- res2[[2]]

        metrics <- data.frame(sos=sos, eos=eos)
    }
    else{
        print("INCORRECT METHOD. Please use deriv or trs.")
    }

    return(metrics)
}