% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/outOfSample.R
\name{oneWayHoldout}
\alias{oneWayHoldout}
\title{One way holdout, a splitFunction in the sense of vtreat::buildEvalSets.}
\usage{
oneWayHoldout(nRows, nSplits, dframe, y)
}
\arguments{
\item{nRows}{number of rows to split (integer >1).}

\item{nSplits}{number of groups to split into (ignored).}

\item{dframe}{original data frame (ignored).}

\item{y}{numeric outcome variable (ignored).}
}
\value{
split plan
}
\description{
Note one way holdout can leak target expected values, so it should not
be preferred in nested modeling situations.
Also, doesn't respect nSplits.
}
\examples{

oneWayHoldout(3,NULL,NULL,NULL)

}
