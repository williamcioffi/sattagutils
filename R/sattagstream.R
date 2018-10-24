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
#' use this constructor to assign the correct subclass (e.g., location, argos, beahvior, etc.) to a new sattagstream object.
#' @param type character of stream type. subclasses exist for: \code{c("all", "argos", "behavior", "corrupt", "fastgps", "histos", "labels", "locations", "minmaxdepth", "rawargos", "rtc", "series", "seriesrange", "stt", "status", "summary")}. anything else will become a generic sattagstream. if you want to add a stream type which requires special methods then you'll have to add it and write them. if you don't need the special methods the generic sattagstream will work fine.
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
	subclassoptions <- c("all", "argos", "behavior", "corrupt", "fastgps", "histos", "labels", "locations", "minmaxdepth", "rawargos", "rtc", "series", "seriesrange", "stt", "status", "summary")
	
	if(!hasArg(type)) stop("i need a type of stream to assign... if you don't want to assign a type to this stream than use new(\"sattagstream\", ...)...")
	
	type <- tolower(type)
	if(!(type %in% subclassoptions)) {
		type <- "sattagstream"
	} else {
		type <- paste0("stream_", type)
	}
	
	new(type, streamtype = type, data, filename = filename)
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
