#' @include sattagstream.R
#' @include sattag.R
NULL

#' an S4 class to represent a stack of sat tags
#'
#' represents a tag stack. wrapper for a \code{\link{list}}.
#' @seealso \code{\link[sattagutils]{tagstack}}
#' @export

setClass("tagstack",
	slots = c(directory = "character"),
	contains = "list"
)

#' constructor for tagstack
#'
#' use this constructor to create a new tagstack object.
#' @param data this should be a list of \code{\link[sattagutils]{sattag-class}}.
#' @return a \code{\link[sattagutils]{tagstack-class}}
#' @export

tagstack <- function(data = list(), directory = character()) {
	new("tagstack", data, directory = directory)
}

#' get tagstack source directory
#'
#' function to extract the source directory for a tagstack
#' @family slot access functions
#' @param a \code{\link[sattagutils]{tagstack}}
#' @return a character representation of the source directory
#' @export
tagstackdir <- function(x) x@directory

#' @describeIn DeployID method for tagstack
setMethod("DeployID", "tagstack", function(x) sapply(x, function(s) DeployID(s)))

#' @describeIn instrument method for tagstack
setMethod("instrument", "tagstack", function(x) sapply(x, function(s) instrument(s)))

#' @describeIn Ptt method for tagstack
setMethod("Ptt", "tagstack", function(x) sapply(x, function(s) Ptt(s)))

#' @describeIn species method for tagstack
setMethod("species", "tagstack", function(x) sapply(x, function(s) species(s)))

#' @describeIn location method for tagstack
setMethod("location", "tagstack", function(x) sapply(x, function(s) location(s)))

#' @describeIn tagdir method for tagstack
setMethod("tagdir", "tagstack", function(x) sapply(x, function(s) tagdir(s)))

#' @describeIn loadtime method for tagstack
setMethod("loadtime", "tagstack", function(x) sapply(x, function(s) loadtime(s)))

#' @describeIn streamtype return a vector of stream types of all sattagstreams contained in a tagstack
setMethod("streamtype", "tagstack", function(x) lapply(x, function(s) streamtype(s)))

#' @describeIn filename return a vector of source filenames of all sattagstreams contained in a tagstack
setMethod("filename", "tagstack", function(x) lapply(x, function(s) filename(s)))

#' show tagstack
setMethod("show", "tagstack", function(object) {
	cat(paste0("tagstack of ", length(object), " tags\n"))
	cat("-----\n")
	cat(paste(Ptt(object), "-", DeployID(object), "-", sapply(object, function(tag) length(tag)), "streams", collapse = "\n"))
})

