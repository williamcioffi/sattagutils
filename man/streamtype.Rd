% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sattagstream.R, R/sattag.R
\docType{methods}
\name{streamtype}
\alias{streamtype}
\alias{streamtype,sattagstream-method}
\alias{streamtype,sattag-method}
\title{get stream type of a sattagstream}
\usage{
streamtype(x)

\S4method{streamtype}{sattagstream}(x)

\S4method{streamtype}{sattag}(x)
}
\arguments{
\item{x}{stream type.}
}
\description{
use this function to get the stream type of a \code{\link[sattagutils]{sattagstream-class}}. changing the stream type after construction is currently not supported.
}
\section{Methods (by class)}{
\itemize{
\item \code{sattagstream}: get the streamtype of a sattagstream

\item \code{sattag}: return a vector of stream types of all sattagstreams contained in a sattag
}}

\seealso{
\code{\link[sattagutils]{sattagstream}}
}