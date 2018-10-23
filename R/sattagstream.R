#' an S4 class to represent a single data stream in a tag
#'
#' a parent class for specific sattag stream types. generally accessed from within a \code{\link[sattagutils]{sattag}}.
#' @slot streamtype character of the stream type for convenience (e.g., argos, behavior, etc.).
#' @slot filename the original filename from which the data stream was derrived. this will almost always be a text or csv file.
#' @export

setClass("sattagstream", 
	slots = c(
		streamtype = "character",
		filename = "character"
	),
	contains = "data.frame"
)

#' constructor for sattagstreams
#'
#' \code{\link[sattagutils]{sattagstream-class}} should be considered an abstract class. use this constructor to assign the correct subclass (e.g., location, argos, beahvior, etc.).
#' @param type character of stream type. currently permitted: \code{c("all", "argos", "behavior", "corrupt", "fastgps", "histos", "labels", "locations", "minmaxdepth", "rawargos", "rtc", "series", "seriesrange", "stt")}.
#' @param data this is a data frame from a wildlife computer portal downloaded csv data file.
#' @param filename the name of the file the data originally came from.
#' @details i don't really expect you to use this function very often, but if you do want to make a stream by hand this is the perferred method. if you are importing streams from an exisiting tag you probably should be by using \code{\link[sattagutils]{load_tag}} or \code{\link[sattagutils]{batch_load_tags}} to load a directory downloaded from the portal.
#' @return an S4 object which extends \code{\link[sattagutils]{sattagstream-class}}
#' @export
#' @examples
#' \dontrun{
#' argos.df <- rcsv("PTT-Argos.csv")
#' sattagstream("argos", argos.df)
#' }

sattagstream <- function(type = character(), data = data.frame(), filename = character()) {
	legaltypes <- c("all", "argos", "behavior", "corrupt", "fastgps", "histos", "labels", "locations", "minmaxdepth", "rawargos", "rtc", "series", "seriesrange", "stt")
	
	if(!hasArg(type)) stop("i need a type of stream to assign... if you don't want to assign a type to this stream than use new(\"sattagstream\", ...)...")
	
	type <- tolower(type)
	if(!(type %in% legaltypes)) stop("that's not a type of stream that i know about...")
	
	if(!hasArg(streamname)) streamname <- type
	new(paste0("stream_", type), streamtype = type, data, filename = filename)
}


#' get filename of a sattagstream
#'
#' use this function to get the filename of a \code{\link[sattagutils]{sattagstream-class}}. changing the source filename after construction is currently not supported.
#' @seealso \code{\link[sattagutils]{sattagstream}}
#' @param x source filename for a csv data stream file.
#' @export

setGeneric("filename", function(x) standardGeneric("filename"))



#' get stream type of a sattagstream
#'
#' use this function to get the stream type of a \code{\link[sattagutils]{sattagstream-class}}. changing the stream type after construction is currently not supported.
#' @seealso \code{\link[sattagutils]{sattagstream}}
#' @param x stream type.
#' @export

setGeneric("streamtype", function(x) standardGeneric("streamtype"))

#' @describeIn streamtype get the streamtype of a sattagstream
setMethod("streamtype", "sattagstream", function(x) x@streamtype)

#' @describeIn filename get the source filename of a sattagstream
setMethod("filename", "sattagstream", function(x) x@filename)
