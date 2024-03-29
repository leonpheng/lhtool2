% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/collectedfunctions.R
\name{phoenix_typical}
\alias{phoenix_typical}
\title{Summary of Phoenix typical values}
\usage{
phoenix_typical(
  theta = "df theta",
  omega = "df omega",
  omega_sd = "df omsd or null",
  sd = "Stderr",
  estimate = "Estimate",
  lab = c("tvKa;;Ka (1/h);;x+y;;c(0,0);;nKa;;sqrt(exp(x)-1)*100",
    "dKadSTR100;;If dose=100;;exp(x)+y;;c(0,0);;",
    "tvCl;;CL/F (L/h);;x+y;;c(0,0);;nCl;;sqrt(exp(x)-1)*100",
    "dCldMULT2;;CL, if multiple dose;;exp(x)*y;;tvCl;;",
    "tvV;;Vc/F (L);;x+y;;c(0,0);;nV;;sqrt(exp(x)-1)*100",
    "tvCl2;;Q/F (L/h);;x+y;;c(0,0);;nCl2;;sqrt(exp(x)-1)*100",
    "tvV2;;Vp/F (L/h);;x+y;;c(0,0);;nV2;;sqrt(exp(x)-1)*100",
    "stdev0;;Proportional Error (\%);;x*100+y;;c(0,0);;")
)
}
\arguments{
\item{theta}{theta sheet: data frame}

\item{omega}{omega data matrix format:  data frame}

\item{omega_sd}{sd for omega matrix format:  data frame}

\item{sd}{set to null if no covariance steps or variable name Stderr for sd of theta}

\item{estimate}{specify variable name Estimate for theta}

\item{lab}{table format}
}
\description{
Summary of Phoenix typical values
}
\keyword{phx_typical}
