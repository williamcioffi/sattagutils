#' extract a stream from a sattag.
#'
#' perferred method for extracting a sat tag stream.
#' @family sattagstream manipulators
#' @param tag an S4 object which extends \code{\link[sattagutils]{sattag}}.
#' @param either a character (stream name) or numeric (stream index).
#' @return either a list of S4 \code{\link[sattagutils]{sattagstream}} objects or a single S4 sattagstream if \code{length(stream) == 1}.
#' @export
#' @examples
#' \dontrun{
#'	tag1 <- load_tag("path/to/tags/tag1")
#'	getStream(tag1, 1)
#' 	getStream(tag1, 'argos')	
#'	}

get.stream <- function(tag, stream) {
	if(!is.sattag(tag)) stop("i need a sattag")
	
	dese <- vector()
	
	if(is.character(stream)) {
		dese <- tag@streamnames %in% stream
	} else if(is.numeric(stream)) {
		if(stream > tag@nstreams | stream < 1) stop(paste0("i don't have that stream, plase select a stream in [1, ", tag@nstreams, "]"))
		dese <- 1:tag@nstreams %in% stream
	} else {
		stop("i need a character or numeric index to select a stream")
	}
	
	if(length(which(dese)) == 1) return(tag@streams[dese][[1]]) else return(tag@stream[dese])
}