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
#' this would be the typical way to instantiate an ess4_dataframe, an S4 wrapper for data.frame.
#' @seealso \code{\link[sattagutils]{ess4_dataframe-class}}
#' @param ... all that good regular data.frame stuff
#' @param stringsAsFactors boolean defaults to FALSE because why would you do anything else?
#' @details a well behaving S4 \code{data.frame} wrapper. i hope what you expect to happen happens. my main concern was that subsetting functions should return an S4 class instead of a \code{data.frame}. 
#'
#' i've implemented methods for \code{as.data.frame, $, [, [<-, cbind, rbind}, and \code{merge}. these methods are just simple wrappers for the S3 methods. 
#'
#' with the defaults and those definitions many methods work without fuss including \code{subset, na.omit, unique, $<-} and return the S4 object. 
#' 
#' other methods you don't expect to return the same class as was inputted like: \code{duplicated, as.list, [[}, etc.
#'
#' finally, i think it makes sense to let some methods default to returning the underlying data.frame only and not the S4 class. for example, \code{edit}. in the applications i have in mind, i don't really want the user to be able to edit the S4 classes data 'by hand' in that way. and if you want that functionality you can always extend the class and add that functionality.
#' @return an S4 class of \code{ess4_dataframe}.
#' @export
#' @examples
#' testdf <- ess4_dataframe(a = rnorm(10), b = rnorm(10))

ess4_dataframe <- function(..., stringsAsFactors = FALSE) {
	data <- data.frame(..., stringsAsFactors = stringsAsFactors)
	new("ess4_dataframe", data)
}

#' convert ess4_dataframe back to data.frame
#'
#' i use this to quickly grab the underlying data.frame mainly in order to pass it cleanly to S3 methods, but there are other applications.
#' @seealso \code{\link{ess4_dataframe}}
#' @param x an ess4_dataframe
#' @param row.names defaults to NULL
#' @param option boolean defaults to FALSE
#' @param ... all the other good stuff
#' @param stringsAsFactors boolean defaults to FALSE because why would you want to do anything else? note that this is not the default behavior of an as.data.frame method.
#' @return a \code{\link{dataframe}}
#' @export
#' @examples
#' df1 	<- data.frame(a = rnorm(10), b = rnorm(10))
#' dfx	<- ess4_dataframe(df1)
#' df2 	<- as.data.frame(dfx)
#' identical(df1, df2)

setMethod("as.data.frame", "ess4_dataframe", function(x, row.names = NULL, option = FALSE, ..., stringsAsFactors = FALSE) {
	as.data.frame(x@.Data, row.names = x@row.names, col.names = names(x), stringsAsFactors = stringsAsFactors)
})


#' wrapper for S3 method
setMethod("$", "ess4_dataframe", function(x, name) {
	x <- as.data.frame(x)
	getS3method("$", "data.frame")(x, name)
})

#' wrapper for S3 method
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

#' wrapper for S3 method
setMethod("[<-", "ess4_dataframe", function(x, i, j, ..., value) {
	dfin <- as.data.frame(x)
	dfout <- getS3method("[<-", "data.frame")(dfin, i, j, ..., value)
	
	x@.Data <- dfout
	x@names <- names(dfout)
	x@row.names <- rownames(dfout)
	
	return(x)
})
