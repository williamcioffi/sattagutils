#' @include sattagstream.R
NULL

#' display an S4 object which extends \code{sattagstream}
setMethod("show", "sattagstream", 
	function(object) {
		print(head(object@data))
		cat("------\n")
		cat(paste0("stream: ", class(object)[1], "\n"))
		cat(paste0("filename: ", object@filename, "\n"))
	}
)