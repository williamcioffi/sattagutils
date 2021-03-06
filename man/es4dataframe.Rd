% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/es4dataframe.R
\name{es4dataframe}
\alias{es4dataframe}
\title{es4dataframe constructor}
\usage{
es4dataframe(..., stringsAsFactors = FALSE)
}
\arguments{
\item{...}{all that good regular data.frame stuff}

\item{stringsAsFactors}{boolean defaults to FALSE because why would you do anything else?}
}
\value{
an S4 class of \code{es4dataframe}.
}
\description{
this would be the typical way to instantiate an es4dataframe, an S4 wrapper for \code{data.frame.}
}
\details{
a well behaving S4 \code{data.frame} wrapper. i hope what you expect to happen happens. my main concern was that subsetting functions should return an S4 class instead of a \code{data.frame}. 

i've implemented methods for \code{as.data.frame, $, [, [<}, and \code{merge}. these methods are just simple wrappers for the S3 methods. 

note that \code{merge} will have to be implemented in any class that extends \code{es4dataframe} and has slots so that these functions know how to merge those slots.

with the defaults and those definitions many methods work without fuss and return the S4 object including \code{subset, na.omit, unique, $<-}. 

other methods you don't expect to return the S4 class anyway work fine like: \code{duplicated, as.list, [[}, etc.

i think it makes sense to let some methods default to returning the underlying \code{data.frame} only and not the S4 class. for example, \code{edit}. in the applications i have in mind, i don't really want the user to be able to edit the S4 classes data 'by hand'. and if you want that functionality you can always extend the class and add it.

i haven't implemented \code{cbind} or \code{rbind} because i can't figure out how to do it. they'd also have to be implemented in any class that extends \code{es4dataframe} with slots.
}
\examples{
testdf <- es4dataframe(a = rnorm(10), b = rnorm(10))
}
\seealso{
\code{\link[sattagutils]{es4dataframe-class}}

\code{\link[sattagutils]{as.data.frame-es4dataframe-method}}
}
