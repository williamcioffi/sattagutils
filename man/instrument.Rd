% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sattag.R, R/tagstack.R
\name{instrument}
\alias{instrument}
\alias{instrument,sattag-method}
\alias{instrument,tagstack-method}
\title{get instrument}
\usage{
instrument(x)

\S4method{instrument}{sattag}(x)

\S4method{instrument}{tagstack}(x)
}
\description{
function to extract instrument type (e.g., SPOT6, MK10-A, etc).
}
\section{Methods (by class)}{
\itemize{
\item \code{sattag}: method for sattag

\item \code{tagstack}: method for tagstack
}}

\seealso{
Other slot access functions: 
\code{\link{DeployID}()},
\code{\link{Ptt}()},
\code{\link{filename}()},
\code{\link{getstream}()},
\code{\link{loadtime}()},
\code{\link{location}()},
\code{\link{species}()},
\code{\link{streamtype}()},
\code{\link{tag_en}()},
\code{\link{tag_st}()},
\code{\link{tagdir}()},
\code{\link{tagstackdir}()}
}
\concept{slot access functions}
