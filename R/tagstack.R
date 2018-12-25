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

#' definition for the subset operator
#'
#' what i want this to do is return a tagstack as opposed to [[ which should return a tag (and it does by default).
setMethod("[", "tagstack", function(x, i, j, ..., drop) {
	x@.Data <- x@.Data[i]
	x
})

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

#' @describeIn tag_st method for tagstack
setMethod("tag_st", "tagstack", function(x) sapply(x, function(s) tag_st(s)))

#' @describeIn tag_en method for tagstack
setMethod("tag_en", "tagstack", function(x) sapply(x, function(s) tag_en(s)))

#' @describeIn tag_st method for tagstack
setMethod("tag_st<-", "tagstack", function(x, value) {
	if(length(x) != length(value)) stop("i need the same number of start times as there are tags...")
	if(!all(is.numeric(value))) stop("time must be numeric...")
	
	for(i in 1:length(x)) {
		tag_st(x[[i]]) <- value[i]
	}
	
	x
})

setMethod("tag_en<-", "tagstack", function(x, value) {
	if(length(x) != length(value)) stop("i need the same number of start times as there are tags...")
	if(!all(is.numeric(value))) stop("time must be numeric...")
	
	for(i in 1:length(x)) {
		tag_en(x[[i]]) <- value[i]
	}
	
	x
})

#' @describeIn streamtype return a vector of stream types of all sattagstreams contained in a tagstack
setMethod("streamtype", "tagstack", function(x) lapply(x, function(s) streamtype(s)))

#' @describeIn filename return a vector of source filenames of all sattagstreams contained in a tagstack
setMethod("filename", "tagstack", function(x) lapply(x, function(s) filename(s)))

#' @describeIn getstream return a tagstack of all streams of type
setMethod("getstream", "tagstack", function(x, type, collapse = FALSE) {
  streams <- streamtype(x)
  picks <- lapply(streams, function(s) s == type)
  out <- x
  for(i in 1:length(picks))
    if(any(picks[[i]])) {
      out[[i]] <- out[[i]][picks[[i]]]
    }
  
  if(collapse) {
  	out <- do.call('rbind', lapply(out, function(l) do.call('rbind', l)))
  	row.names(out) <- 1:nrow(out)
  
  	
  	type <- strsplit(type, split = "_")[[2]]
  	out <- sattagstream(type, data = out, filename = "called from getstream")	
  }
  out
})

#' show tagstack
setMethod("show", "tagstack", function(object) {
	cat(paste0("tagstack of ", length(object), " tags\n"))
	cat("-----\n")
	cat(paste(Ptt(object), "-", DeployID(object), "-", sapply(object, function(tag) length(tag)), "streams", collapse = "\n"))
})

