#' @include sattag.R
NULL

#' initialize an S4 object of class \code{\link[sattagutils]{sattag}}
setMethod("initialize", "sattag", 
	function(.Object, ...) {
		.Object <- callNextMethod()
		.Object@loadtime <- as.character(Sys.time())
		.Object
	}
)
