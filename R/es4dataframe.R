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
#' @seealso \code{\link[sattagutils]{as.data.frame-es4dataframe-method}}
#' @param ... all that good regular data.frame stuff
#' @param stringsAsFactors boolean defaults to FALSE because why would you do anything else?
#' @details a well behaving S4 \code{data.frame} wrapper. i hope what you expect to happen happens. my main concern was that subsetting functions should return an S4 class instead of a \code{data.frame}. 
#'
#' i've implemented methods for \code{as.data.frame, $, [, [<}, and \code{merge}. these methods are just simple wrappers for the S3 methods. 
#'
#' note that \code{merge} will have to be implemented in any class that extends \code{es4dataframe} and has slots so that these functions know how to merge those slots.
#' 
#' with the defaults and those definitions many methods work without fuss and return the S4 object including \code{subset, na.omit, unique, $<-}. 
#' 
#' other methods you don't expect to return the S4 class anyway work fine like: \code{duplicated, as.list, [[}, etc.
#'
#' i think it makes sense to let some methods default to returning the underlying \code{data.frame} only and not the S4 class. for example, \code{edit}. in the applications i have in mind, i don't really want the user to be able to edit the S4 classes data 'by hand'. and if you want that functionality you can always extend the class and add it.
#'
#' i haven't implemented \code{cbind} or \code{rbind} because i can't figure out how to do it. they'd also have to be implemented in any class that extends \code{es4dataframe} with slots.
#' @return an S4 class of \code{es4dataframe}.
#' @export
#' @examples
#' testdf <- es4dataframe(a = rnorm(10), b = rnorm(10))

es4dataframe <- function(..., stringsAsFactors = FALSE) {
	data <- data.frame(..., stringsAsFactors = stringsAsFactors)
	new("es4dataframe", data)
}

#' is function for es4dataframe
#'
#' check to see if an object extends \code{\link[sattagutils]{es4dataframe}}
#' @export

is.es4dataframe <- function(obj) {
	inherits(obj, "es4dataframe")
}


#' convert es4dataframe back to data.frame
#'
#' i use this to quickly grab the underlying data.frame mainly in order to pass it cleanly to S3 methods, but there are other applications.
#' @seealso \code{\link[sattagutils]{es4dataframe}}
#' @param x an es4dataframe
#' @param row.names defaults to NULL
#' @param option boolean defaults to FALSE
#' @param ... all the other good stuff
#' @param stringsAsFactors boolean defaults to FALSE because why would you want to do anything else? note that this is not the default behavior of an as.data.frame method.
#' @return a \code{\link{dataframe}}
#' @export
#' @examples
#' df1 	<- data.frame(a = rnorm(10), b = rnorm(10))
#' dfx	<- es4dataframe(df1)
#' df2 	<- as.data.frame(dfx)
#' identical(df1, df2)
setMethod("as.data.frame", "es4dataframe", function(x, row.names = NULL, option = FALSE, ..., stringsAsFactors = FALSE) {
	as.data.frame(x@.Data, row.names = x@row.names, col.names = names(x), stringsAsFactors = stringsAsFactors)
})

#' wrapper for S3 methods
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
		
		x@row.names <- row.names(dfin)[i]
		
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
setMethod("merge", "es4dataframe", function(x, y, by = intersect(names(x), names(y)), by.x = by, by.y = by, all = FALSE, all.x = all, all.y = all, sort = TRUE, suffixes = c(".x", ".y"), no.dups = TRUE, incomparables = NULL, ...) {

	if(is.es4dataframe(x)) x <- as.data.frame(x)
	if(is.es4dataframe(y)) y <- as.data.frame(y)
	
	outdf <- merge(x, y, by, by.x, by.y, all, all.x, all.y, sort, suffixes, no.dups, incomparables, ...)
	es4dataframe(outdf)
})
