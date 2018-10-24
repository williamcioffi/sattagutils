#' an S4 data.frame
#'
#' call me hadley.
#' @seealso \code{\link[sattagutils]{ess4_dataframe}}
#' @export
setClass("ess4_dataframe",
	contains = "data.frame"
)

#' ess4_dataframe constructor
#'
#' this would be the typical way to instantiate an ess4_dataframe.
#' @seealso \code{\link[sattagutils]{ess4_dataframe-class}}
#' @param ... all that good regular data.frame stuff
#' @param stringsAsFactors boolean defaults to FALSE because why would you do anything else?
#' @return an S4 class of \code{ess4_dataframe}.
#' @export
#' @examples
#' ess4_dataframe(a = rnorm(10), b = rnorm(10))
ess4_dataframe <- function(..., stringsAsFactors = FALSE) {
	data <- data.frame(..., stringsAsFactors = stringsAsFactors)
	new("ess4_dataframe", data)
}



test <- new("ess4_dataframe", data.frame(a = rnorm(10), b = rnorm(10)))




setMethod("as.data.frame", "ess4_dataframe", function(x, row.names = NULL, option = FALSE, ...) {
	as.data.frame(x@.Data, row.names = x@row.names, col.names = names(x), stringsAsFactors = FALSE)
})


setMethod("$", "ess4_dataframe", function(x, name) {
	x <- as.data.frame(x)
	getS3method("$", "data.frame")(x, name)
})

setMethod("[", "ess4_dataframe", function(x, i, j, ..., drop) {
	dfin <- as.data.frame(x)
	dfout <- getS3method("[", "data.frame")(dfin, i, j, ..., drop)

	if(class(dfout) == "data.frame") {		
		x@.Data <- dfout
		x@names <- names(dfout)
		x@row.names <- rownames(dfout)
		
		return(x)
	} else if(class(dfout) == "list") {
		x@.Data <- dfout
		x@names <- names(dfout)
		x@row.names <- as.character(i)
		
		return(x)
	} else {
		return(dfout)
	}
})

