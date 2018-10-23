#' @include sattagstream.R
NULL

#' display an S4 object which extends \code{sattagstream}
#'
#' generic method for show.
setMethod("show", "sattagstream", 
	function(object) {
		print(head(object))
		cat("------\n")
		cat(paste0("stream type: ", streamtype(object), "\n"))
		cat(paste0("filename: ", filename(object), "\n"))
	}
)