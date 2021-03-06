% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/collectedfunctions.R
\name{nca.cal}
\alias{nca.cal}
\title{Derive Common NCA parameters using single and multiple profiles}
\usage{
nca.cal(
  data,
  n_lambda = 3,
  id = "id",
  time = "TAD",
  dv = "dv",
  partialAUC = NULL,
  partialConc = NULL
)
}
\arguments{
\item{data}{datset or data frame (ex:data=PKdatat)}

\item{n_lambda}{number of points for estimating the Lambda}

\item{id}{unique subject identifier}

\item{time}{Sampling time after dose (TAD)}

\item{dv}{Concentration}

\item{partialAUC}{Time interval for partial AUC. Ex: c(0,6,0,12,6,12) for AUC0-6, AUC0-12 and AUC6-12}

\item{partialConc}{Point estimated concentration (Ex:c(1,4) for concentration after 1 and 4 h)}
}
\description{
nca.cal()
}
\examples{
test<-nca.cal(data=data,n_lambda = 3, id = "id", time = "TAD", dv = "dv",dose
}
\keyword{nca.cal}
