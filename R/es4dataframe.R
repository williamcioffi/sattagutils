#' an S4 data.frame
#'
#' call me hadley.
#' @seealso \code{\link[sattagutils]{es4dataframe}}
#' @export

setClass("es4dataframe",
	contains = "data.frame"
)

#' es4dataframe constructor
#'
#' this would be the typical way to instantiate an es4dataframe, an S4 wrapper for \code{data.frame.}
#' @seealso \code{\link[sattagutils]{es4dataframe-class}}
#' @param ... all that good regular data.frame stuff
#' @param stringsAsFactors boolean defaults to FALSE because why would you do anything else?
#' @details a well behaving S4 \code{data.frame} wrapper. i hope what you expect to happen happens. my main concern was that subsetting functions should return an S4 class instead of a \code{data.frame}. 
#'
#' i've implemented methods for \code{as.data.frame, $, [, [<-, cbind, rbind}, and \code{merge}. these methods are just simple wrappers for the S3 methods. 
#'
#' with the defaults and those definitions many methods work without fuss and return the S4 object including \code{subset, na.omit, unique, $<-}. 
#' 
#' other methods you don't expect to return the S4 class anyway work fine like: \code{duplicated, as.list, [[}, etc.
#'
#' finally, i think it makes sense to let some methods default to returning the underlying \code{data.frame} only and not the S4 class. for example, \code{edit}. in the applications i have in mind, i don't really want the user to be able to edit the S4 classes data 'by hand'. and if you want that functionality you can always extend the class and add it.
#' @return an S4 class of \code{es4dataframe}.
#' @export
#' @examples
#' testdf <- es4dataframe(a = rnorm(10), b = rnorm(10))

es4dataframe <- function(..., stringsAsFactors = FALSE) {
	data <- data.frame(..., stringsAsFactors = stringsAsFactors)
	new("es4dataframe", data)
}



setMethod("as.data.frame", "es4dataframe", function(x, row.names = NULL, option = FALSE, ..., stringsAsFactors = FALSE) {
	as.data.frame(x@.Data, row.names = x@row.names, col.names = names(x), stringsAsFactors = stringsAsFactors)
})


#' wrapper for S3 method
setMethod("$", "es4dataframe", function(x, name) {
	x <- as.data.frame(x)
	getS3method("$", "data.frame")(x, name)
})

#' wrapper for S3 method
setMethod("[", "es4dataframe", function(x, i, j, ..., drop) {
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

#' wrapper for S3 method
setMethod("[<-", "es4dataframe", function(x, i, j, ..., value) {
	dfin <- as.data.frame(x)
	dfout <- getS3method("[<-", "data.frame")(dfin, i, j, ..., value)
	
	x@.Data <- dfout
	x@names <- names(dfout)
	x@row.names <- rownames(dfout)
	
	return(x)
})


#' wrapper for S3 method
# setMethod("merge", "es4dataframe", function(x, y, by = intersect(names(x), names(y)), by.x = by, by.y = by, all = FALSE, all.x = all, all.y = all, sort = TRUE, suffixes = c(".x", ".y"), no.dups = TRUE, incomparables = NULL, ...) {
	
# })
