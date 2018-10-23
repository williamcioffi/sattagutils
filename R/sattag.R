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
setGeneric("DeployID", function(x) standardGeneric("DeployID"))

#' get instrument
setGeneric("instrument", function(x) standardGeneric("instrument"))

#' get Ptt
setGeneric("Ptt", function(x) standardGeneric("Ptt"))

#' get species
setGeneric("species", function(x) standardGeneric("species"))

#' get location
setGeneric("location", function(x) standardGeneric("location"))

#' get tagdir
setGeneric("tagdir", function(x) standardGeneric("tagdir"))

#' get loadtime
setGeneric("loadtime", function(x) standardGeneric("loadtime"))



#' get DeployID
setMethod("DeployID", "sattag", function(x) x@DeployID)

#' get instrument
setMethod("instrument", "sattag", function(x) x@instrument)

#' get Ptt
setMethod("Ptt", "sattag", function(x) x@Ptt)

#' get species
setMethod("species", "sattag", function(x) x@species)

#' get location
setMethod("location", "sattag", function(x) x@location)

#' get tagdir
setMethod("tagdir", "sattag", function(x) x@tagdir)

#' get loadtime
setMethod("loadtime", "sattag", function(x) x@loadtime)

#' @describeIn streamtype return a vector of stream types of all sattagstreams contained in a sattag
setMethod("streamtype", "sattag", function(x) sapply(x, function(s) streamtype(s)))

#' @describeIn filename return a vector of source filenames of all sattagstreams contained in a sattag
setMethod("filename", "sattag", function(x) sapply(x, function(s) filename(s)))

