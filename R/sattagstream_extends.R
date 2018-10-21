#' @include sattagstream.R
NULL

#' an S4 class which extends \code{sattagstream}
#'
#' corresponds to the *-All.csv data stream.
setClass("stream_all", 			contains = "sattagstream")
#' an S4 class which extends \code{sattagstream}
#'
#' corresponds to the *-Argos.csv data stream.
setClass("stream_argos", 		contains = "sattagstream")
#' an S4 class which extends \code{sattagstream}
#'
#' corresponds to the *-Behavior.csv data stream.
setClass("stream_behavior", 		contains = "sattagstream")
#' an S4 class which extends \code{sattagstream}
#'
#' corresponds to the *-Corrupt.csv data stream.
setClass("stream_corrupt", 		contains = "sattagstream")
#' an S4 class which extends \code{sattagstream}
#'
#' corresponds to the *-FastGPS.csv data stream. this is not a well formated csv when downloaded from the portal so beware when importing. see load_stream.
setClass("stream_fastgps", 		contains = "sattagstream")
#' an S4 class which extends \code{sattagstream}
#'
#' corresponds to the *-Histos.csv data stream.
setClass("stream_histos", 		contains = "sattagstream")
#' an S4 class which extends \code{sattagstream}
#'
#' corresponds to the *-Labels.csv data stream. this csv file appears to be missing an EOF when downloaded from the portal so beware when importing. see load_stream.
setClass("stream_labels", 		contains = "sattagstream")
#' an S4 class which extends \code{sattagstream}
#'
#' corresponds to the *-Locations.csv data stream.
setClass("stream_locations", 	contains = "sattagstream")
#' an S4 class which extends \code{sattagstream}
#'
#' corresponds to the *-MinMaxDepth.csv data stream.
setClass("stream_minmaxdepth",	contains = "sattagstream")
#' an S4 class which extends \code{sattagstream}
#'
#' corresponds to the *-RawArgos.csv data stream. this is not a well formated csv when downloaded from the portal so beware when importing. see load_stream.
setClass("stream_rawargos", 		contains = "sattagstream")
#' an S4 class which extends \code{sattagstream}
#'
#' corresponds to the *-RTC.csv data stream.
setClass("stream_rtc", 			contains = "sattagstream")
#' an S4 class which extends \code{sattagstream}
#'
#' corresponds to the *-Series.csv data stream.
setClass("stream_series", 		contains = "sattagstream")
#' an S4 class which extends \code{sattagstream}
#'
#' corresponds to the *-SeriesRange.csv data stream.
setClass("stream_seriesrange", 	contains = "sattagstream")
#' an S4 class which extends \code{sattagstream}
#'
#' corresponds to the *-SST.csv data stream.
setClass("stream_sst", 			contains = "sattagstream")
#' an S4 class which extends \code{sattagstream}
#'
#' corresponds to the *-Status.csv data stream.
setClass("stream_status", 		contains = "sattagstream")
#' an S4 class which extends \code{sattagstream}
#'
#' corresponds to the *-Summary.csv data stream.
setClass("stream_summary", 		contains = "sattagstream")
