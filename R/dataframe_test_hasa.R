# setClass("wdf",
	# slots = c(data = "data.frame")
# )

# test <- new("wdf", data = data.frame(a = rnorm(10), b = rnorm(10)))

# setMethod("dim", "wdf", function(x) {
	# dim(x@data)
# })

# setMethod("$", "wdf", function(x, name) {
	# getElement(x@data, name)
# })

# setMethod("[", "wdf", function(x, i, j, ..., drop) {
	# x@data <- as.data.frame(x@data[i, j, ..., drop = FALSE])
	# x
# })

# # # setMethod("[[", "wdf", function(x, i, j, ..., drop) {
# # })

# setMethod("[<-", "wdf", function(x, i, j, ..., value) {
	# x@data[i, j, ...] <- value
	# x
# })

# setMethod("names", "wdf", function(x) {
	# names(x@data)
# })

# setMethod("dimnames", "wdf", function(x) {
	# dimnames(x@data)
# })

# # setMethod("merge", "wdf", function(x, y, ...) {
	# # merge(as.data.frame(x), as.data.frame(y), ...)
# # })

# setMethod("as.data.frame", "wdf", function(x, ..., stringsAsFactors) {
	# as.data.frame(x@data, ..., stringsAsFactors = FALSE)
# })

# setMethod("$<-", "wdf", function(x, name, value) {
	# x <- x@data
	# cl <- oldClass(x)
	    # class(x) <- NULL
	    # nrows <- .row_names_info(x, 2L)
	    # if (!is.null(value)) {
	        # N <- NROW(value)
	        # if (N > nrows) 
	            # stop(sprintf(ngettext(N, "replacement has %d row, data has %d", 
	                # "replacement has %d rows, data has %d"), N, nrows), 
	                # domain = NA)
	        # if (N < nrows) 
	            # if (N > 0L && (nrows%%N == 0L) && length(dim(value)) <= 
	                # 1L) 
	                # value <- rep(value, length.out = nrows)
	            # else stop(sprintf(ngettext(N, "replacement has %d row, data has %d", 
	                # "replacement has %d rows, data has %d"), N, nrows), 
	                # domain = NA)
	        # if (is.atomic(value) && !is.null(names(value))) 
	            # names(value) <- NULL
	    # }
	    # x[[name]] <- value
	    # class(x) <- cl
	    # return(x)
# })