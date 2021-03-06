% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/collectedfunctions.R
\name{indiv.tab}
\alias{indiv.tab}
\title{Individual table with descriptive statse}
\usage{
indiv.tab(data, id, by, variables, rtype = "sigfig", dec = 3)
}
\arguments{
\item{data}{datset or data frame (ex:data=PKdatat)}

\item{id}{unique identifier}

\item{by}{Stratification variable (ex: by="study")}

\item{variables}{Specify sorting variable to be displayed vertically. (ex: colby=by or colby="var")}

\item{rtype}{rounding type. (sigfig by default)}

\item{dec}{round decimal or number of significant figures}
}
\description{
Listing of individual data and descriptove stats
}
\examples{
ind.tab(data=dat,id="NMID",by=c("study"))
}
\keyword{ind.tab}
