#' an S4 class to represent a single data stream in a tag
#'
#' a parent class for specific sattag stream types. generally accessed from within a \code{\link[sattagutils]{sattag}}.
#' @family sattagstream types
#' @name sattagstream
#' @slot streamname character identifer for the stream.
#' @slot filename the original filename from which the data stream was derrived. this will almost always be a text or csv file.
#' @slot data data frame representing the actual data stream. almost all wildlife computer data streams (csvs) are in tabular format so this makes sense, but in the future perhaps this should be made more general (e.g., list).
#' @export

setClass("sattagstream", 
	slots = c(
		streamname = "character",
		filename = "character",
		data = "data.frame"
	)
)
