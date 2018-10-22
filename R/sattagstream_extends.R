#' @include sattagstream.R
NULL

#' an S4 class which extends sattagstream
#'
#' corresponds to the *-All.csv data stream.
#' @name stream_all
#' @seealso \code{\link[sattagutils]{sattag}} 
#' @seealso \code{\link[sattagutils]{sattagstream}}
#' @family sattagstream types
setClass("stream_all", 			contains = "sattagstream")

#' an S4 class which extends sattagstream
#'
#' corresponds to the *-Argos.csv data stream.
#' @name stream_argos
#' @seealso \code{\link[sattagutils]{sattag}} 
#' @seealso \code{\link[sattagutils]{sattagstream}}
#' @family sattagstream types
setClass("stream_argos", 		contains = "sattagstream")

#' an S4 class which extends sattagstream
#'
#' corresponds to the *-Behavior.csv data stream.
#' @name stream_behavior
#' @seealso \code{\link[sattagutils]{sattag}} 
#' @seealso \code{\link[sattagutils]{sattagstream}}
#' @family sattagstream types
setClass("stream_behavior", 		contains = "sattagstream")

#' an S4 class which extends sattagstream
#'
#' corresponds to the *-Corrupt.csv data stream.
#' @name stream_corrupt
#' @seealso \code{\link[sattagutils]{sattag}} 
#' @seealso \code{\link[sattagutils]{sattagstream}}
#' @family sattagstream types
setClass("stream_corrupt", 		contains = "sattagstream")

#' an S4 class which extends sattagstream
#'
#' corresponds to the *-FastGPS.csv data stream. this is not a well formated csv when downloaded from the portal so beware when importing. see \code{\link[sattagutils]{load_tag}}.
#' @name stream_fastgps
#' @seealso \code{\link[sattagutils]{sattag}} 
#' @seealso \code{\link[sattagutils]{sattagstream}}
#' @family sattagstream types
setClass("stream_fastgps", 		contains = "sattagstream")

#' an S4 class which extends sattagstream
#'
#' corresponds to the *-Histos.csv data stream.
#' @name stream_hists
#' @seealso \code{\link[sattagutils]{sattag}} 
#' @seealso \code{\link[sattagutils]{sattagstream}}
#' @family sattagstream types
setClass("stream_histos", 		contains = "sattagstream")

#' an S4 class which extends sattagstream
#'
#' corresponds to the *-Labels.csv data stream. this csv file appears to be missing an EOF when downloaded from the portal so beware when importing. see \code{\link[sattagutils]{load_tag}}.
#' @name stream_labels
#' @seealso \code{\link[sattagutils]{sattag}} 
#' @seealso \code{\link[sattagutils]{sattagstream}}
#' @family sattagstream types
setClass("stream_labels", 		contains = "sattagstream")

#' an S4 class which extends sattagstream
#'
#' corresponds to the *-Locations.csv data stream.
#' @name stream_locations
#' @seealso \code{\link[sattagutils]{sattag}} 
#' @seealso \code{\link[sattagutils]{sattagstream}}
#' @family sattagstream types
setClass("stream_locations", 	contains = "sattagstream")

#' an S4 class which extends sattagstream
#'
#' corresponds to the *-MinMaxDepth.csv data stream.
#' @name stream_locations
#' @seealso \code{\link[sattagutils]{sattag}} 
#' @seealso \code{\link[sattagutils]{sattagstream}}
#' @family sattagstream types
setClass("stream_minmaxdepth",	contains = "sattagstream")

#' an S4 class which extends sattagstream
#'
#' corresponds to the *-RawArgos.csv data stream. this is not a well formated csv when downloaded from the portal so beware when importing. see \code{\link[sattagutils]{load_tag}}.
#' @name stream_rawargos
#' @seealso \code{\link[sattagutils]{sattag}} 
#' @seealso \code{\link[sattagutils]{sattagstream}}
#' @family sattagstream types
setClass("stream_rawargos", 		contains = "sattagstream")

#' an S4 class which extends sattagstream
#'
#' corresponds to the *-RTC.csv data stream.
#' @name stream_rtc
#' @seealso \code{\link[sattagutils]{sattag}} 
#' @seealso \code{\link[sattagutils]{sattagstream}}
#' @family sattagstream types
setClass("stream_rtc", 			contains = "sattagstream")

#' an S4 class which extends sattagstream
#'
#' corresponds to the *-Series.csv data stream.
#' @name stream_series
#' @seealso \code{\link[sattagutils]{sattag}} 
#' @seealso \code{\link[sattagutils]{sattagstream}}
#' @family sattagstream types
setClass("stream_series", 		contains = "sattagstream")

#' an S4 class which extends sattagstream
#'
#' corresponds to the *-SeriesRange.csv data stream.
#' @name stream_seriesrange
#' @seealso \code{\link[sattagutils]{sattag}} 
#' @seealso \code{\link[sattagutils]{sattagstream}}
#' @family sattagstream types
setClass("stream_seriesrange", 	contains = "sattagstream")

#' an S4 class which extends sattagstream
#'
#' corresponds to the *-SST.csv data stream.
#' @name stream_sst
#' @seealso \code{\link[sattagutils]{sattag}} 
#' @seealso \code{\link[sattagutils]{sattagstream}}
#' @family sattagstream types
setClass("stream_sst", 			contains = "sattagstream")

#' an S4 class which extends sattagstream
#'
#' corresponds to the *-Status.csv data stream.
#' @name stream_status
#' @seealso \code{\link[sattagutils]{sattag}} 
#' @seealso \code{\link[sattagutils]{sattagstream}}
#' @family sattagstream types
setClass("stream_status", 		contains = "sattagstream")

#' an S4 class which extends sattagstream
#'
#' corresponds to the *-Summary.csv data stream. used to populate slots in \code{\link[sattagutils]{sattag}} within \code{\link[sattagutils]{load_tag}}.
#' @name stream_summary
#' @seealso \code{\link[sattagutils]{sattag}} 
#' @seealso \code{\link[sattagutils]{sattagstream}}
#' @family sattagstream types
setClass("stream_summary", 		contains = "sattagstream")
