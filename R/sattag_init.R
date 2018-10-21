#' @include sattag.R
NULL

#' initialize an S4 object of class \code{sattag}
setMethod("initialize", "sattag", 
	function(.Object, ...) {
		.Object <- callNextMethod()
		.Object@loadtime <- as.character(Sys.time())
		.Object
	}
)
