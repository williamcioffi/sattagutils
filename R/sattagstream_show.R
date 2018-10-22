#' @include sattagstream.R
NULL

#' display an S4 object which extends \code{sattagstream}
#'
#' generic method for show.
setMethod("show", "sattagstream", 
	function(object) {
		print(head(object@data))
		cat("------\n")
		cat(paste0("stream type: ", class(object)[1], "\n"))
		cat(paste0("stream name: ", object@streamname))
		cat(paste0("filename: ", object@filename, "\n"))
	}
)