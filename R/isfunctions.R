#' is functions for sattag and sattagstream
#'
#' check to see if an object is a \code{\link[sattagutils]{sattag}} or \code{\link[sattagutils]{sattagstream}}
#' @name isfunctions
#' @examples
#' \dontrun{
#'	tag1 <- load_tag("path/to/tags/tag1")
#'	s1 <- getStream(tag1, 1)
#'
#'	c(is.stream(s1), is.tag(s1), is.sattag(tag1), is.stream(tag1))
#'	}
NULL

#' @rdname isfunctions
#' @export
is.sattag <- function(obj) {
	inherits(obj, "sattag")
}

#' @rdname isfunctions
#' @export
is.sattagstream <- function(obj) {
	inherits(obj, "sattagstream")
}