setClass("wdf",
	slots = c(data = "data.frame")
)

test <- new("wdf", data = data.frame(a = rnorm(10), b = rnorm(10)))

setMethod("dim", "wdf", function(x) {
	dim(x@data)
})

setMethod("$", "wdf", function(x, name) {
	getElement(x@data, name)
})

setMethod("[", "wdf", function(x, i, j, ..., drop) {
	x@data <- as.data.frame(x@data[i, j, ..., drop = FALSE])
	x
})

# # setMethod("[[", "wdf", function(x, i, j, ..., drop) {
# })

setMethod("[<-", "wdf", function(x, i, j, ..., value) {
	x@data[i, j, ...] <- value
	x
})

setMethod("names", "wdf", function(x) {
	names(x@data)
})

setMethod("dimnames", "wdf", function(x) {
	dimnames(x@data)
})

# setMethod("merge", "wdf", function(x, y, ...) {
	# merge(as.data.frame(x), as.data.frame(y), ...)
# })

setMethod("as.data.frame", "wdf", function(x, ..., stringsAsFactors) {
	as.data.frame(x@data, ..., stringsAsFactors = FALSE)
})

# # setMethod("$<-", "wdf", function(x, name, value) {
# })