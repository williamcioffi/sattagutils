% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/es4dataframe.R
\name{as.data.frame,es4dataframe-method}
\alias{as.data.frame,es4dataframe-method}
\title{convert es4dataframe back to data.frame}
\usage{
\S4method{as.data.frame}{es4dataframe}(
  x,
  row.names = NULL,
  option = FALSE,
  ...,
  stringsAsFactors = FALSE
)
}
\arguments{
\item{x}{an es4dataframe}

\item{row.names}{defaults to NULL}

\item{option}{boolean defaults to FALSE}

\item{...}{all the other good stuff}

\item{stringsAsFactors}{boolean defaults to FALSE because why would you want to do anything else? note that this is not the default behavior of an as.data.frame method.}
}
\value{
a \code{\link{dataframe}}
}
\description{
i use this to quickly grab the underlying data.frame mainly in order to pass it cleanly to S3 methods, but there are other applications.
}
\examples{
df1 	<- data.frame(a = rnorm(10), b = rnorm(10))
dfx	<- es4dataframe(df1)
df2 	<- as.data.frame(dfx)
identical(df1, df2)
}
\seealso{
\code{\link[sattagutils]{es4dataframe}}
}
