#' @include sattagstream.R
NULL

#' an S4 class to represent a single sat tag
#'
#' represents a single sat tag. holds a small amount of meta data and a list of data streams (extends \code{\link{list}}).
#' @slot instrument instrument type, e.g., "MK10-A"
#' @slot DeployID character vector 
#' @slot Ptt character vector 
#' @slot species character vector 
#' @slot location character vector of the study site name.
#' @slot earliestdata,latestdata numeric dates (seconds since UNIX epoch).
#' @slot directory the original directory from which the tag was loaded.
#' @slot loadtime a character vector set by \code{initialize()} when object is instantiated.
#' @export

setClass("sattag",
	slots = c(
	instrument = "character",
	DeployID = "character",
	Ptt = "character",
	species = "character",
	location = "character",
	t_start = "numeric",
	t_end = "numeric",
	directory = "character",
	loadtime = "character"
	),
	contains = "list"
)

#' constructor for sattag
#'
#' use this constructor to create a new sattag object.
#' @param data this should be a list of \code{\link[sattagutils]{sattagstreams-class}}.
#' @param instrument instrument type, e.g., "MK10-A"
#' @param DeployID character vector 
#' @param Ptt character vector 
#' @param species character vector 
#' @param location character vector of the study site name.
#' @param t_start,t_end numeric dates (seconds since UNIX epoch).
#' @param directory the original directory from which the tag was loaded.
#' @return a \code{\link[sattagutils]{sattag-class}}
#' @export

sattag <- function(data = list(), instrument = character(), DeployID = character(), Ptt = character(), species = character(), location = character(), t_start = numeric(), t_end = numeric(), directory = character()) {
	new("sattag", data, instrument = instrument, DeployID = DeployID, Ptt = Ptt, species = species, location = location, t_start = t_start, t_end = t_end, directory = directory)
}

#' get DeployID
#'
#' function to extract DeployID.
#' @family slot access functions
#' @export
setGeneric("DeployID", function(x) standardGeneric("DeployID"))

#' get instrument
#'
#' function to extract instrument type (e.g., SPOT6, MK10-A, etc).
#' @family slot access functions
#' @export
setGeneric("instrument", function(x) standardGeneric("instrument"))

#' get Ptt
#'
#' function to extract Ptt.
#' @family slot access functions
#' @return a character representation of the Ptt. why this and not numeric?
#' @export
setGeneric("Ptt", function(x) standardGeneric("Ptt"))

#' get species
#'
#' function to extract species as defined in *-Labels.csv.
#' @family slot access functions
#' @export
setGeneric("species", function(x) standardGeneric("species"))

#' get location
#'
#' function to extract study location as defined in *-Labels.csv.
#' @family slot access functions
#' @export
setGeneric("location", function(x) standardGeneric("location"))

#' get tagdir
#'
#' function to extract source directory from which the tag was loaded.
#' @family slot access functions
#' @export
setGeneric("tagdir", function(x) standardGeneric("tagdir"))

#' get loadtime
#'
#' function to extract time a tag was loaded into R originally based on when \code{intialize()} was called.
#' @family slot access functions
#' @export
setGeneric("loadtime", function(x) standardGeneric("loadtime"))

#' get start time of tag
#'
#' function to extract the data start time for a particular tag. if \code{\link[sattagutils]{load_tag}} or \code{\link[sattagutils]{batch_load_tags}} created the tag object then this is set from the \code{EarliestDataTime} in the \code{summary} stream.
#' @family slot access functions
#' @export
setGeneric("tag_st", function(x) standardGeneric("tag_st"))

#' get end time of tag
#'
#' function to extract the data end time for a particular tag. if \code{\link[sattagutils]{load_tag}} or \code{\link[sattagutils]{batch_load_tags}} created the tag object then this is set from the \code{LatestDataTime} in the \code{summary} stream.
#' @family slot access functions
#' @export
setGeneric("tag_en", function(x) standardGeneric("tag_en"))

#' set start time of tag
#'
#' function to set the data end time for a particular tag. if \code{\link[sattagutils]{load_tag}} or \code{\link[sattagutils]{batch_load_tags}} created the tag object then this is initially set from the \code{EarliestDataTime} in the \code{summary} stream.
#' @export
setGeneric("tag_st<-", function(x, value) standardGeneric("tag_st<-"))

#' set start time of tag
#'
#' function to set the data end time for a particular tag. if \code{\link[sattagutils]{load_tag}} or \code{\link[sattagutils]{batch_load_tags}} created the tag object then this is initially set from the \code{LatestDataTime} in the \code{summary} stream.
#' @export
setGeneric("tag_en<-", function(x, value) standardGeneric("tag_en<-"))

#' get a stream
#' 
#' function to get a particular streamtype from a \code{\link[sattagutils]{sattag}} or \code{\link[sattagutils]{tagstack}}.
#' @param type streamtype to extract
#' @return either a \code{tagstack} or \code{sattag} depending on input.
#' @export
setGeneric("getstream", function(x, type) standardGeneric("getstream"))

#' definition for the subset operator [
#'
#' what i want this to do is return a sattag as opposed to [[ which should return a stream (and it does by default).
setMethod("[", "sattag", function(x, i, j, ..., drop) {
	x@.Data <- x@.Data[i]
	x
})

#' @describeIn DeployID method for sattag
setMethod("DeployID", "sattag", function(x) x@DeployID)

#' @describeIn instrument method for sattag
setMethod("instrument", "sattag", function(x) x@instrument)

#' @describeIn Ptt method for sattag
setMethod("Ptt", "sattag", function(x) x@Ptt)

#' @describeIn species method for sattag
setMethod("species", "sattag", function(x) x@species)

#' @describeIn location method for sattag
setMethod("location", "sattag", function(x) x@location)

#' @describeIn tagdir method for sattag
setMethod("tagdir", "sattag", function(x) x@directory)

#' @describeIn loadtime method for sattag
setMethod("loadtime", "sattag", function(x) x@loadtime)

#' @describeIn tag_st method for sattag
setMethod("tag_st", "sattag", function(x) x@t_start)

#' @describeIn tag_en method for sattag
setMethod("tag_en", "sattag", function(x) x@t_end)

#' @describeIn tag_st method for sattag
setMethod("tag_st<-", "sattag", function(x, value) {
	if(length(value) != 1) stop("i can only have one start time...")
	if(!is.numeric(value)) stop("time must be numeric...")
	
	x@t_start <- value
	x
})

#' @describeIn tag_en method for sattag
setMethod("tag_en<-", "sattag", function(x, value) {
	if(length(value) != 1) stop("i can only have one start time...")
	if(!is.numeric(value)) stop("time must be numeric...")
	
	x@t_end <- value
	x
})

#' @describeIn streamtype return a vector of stream types of all sattagstreams contained in a sattag
setMethod("streamtype", "sattag", function(x) sapply(x, function(s) streamtype(s)))

#' @describeIn getstream return all streams of streamtype type
setMethod("getstream", "sattag", function(x, type) x[streamtype(x) == type])

#' @describeIn filename return a vector of source filenames of all sattagstreams contained in a sattag
setMethod("filename", "sattag", function(x) sapply(x, function(s) filename(s)))

