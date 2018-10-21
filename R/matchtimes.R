#' a tiny time matching function
#'
#' see \code{\link[base]{findInterval}}.
#' @param t1,t2 numeric time vectors.
#' @export
#' @examples
#' t1 <- c(10, 20, 30, 40)
#' t2 <- c(9, 21, 36, 37)
#' matchtimes(t1, t2)
#' matchtimes(t2, t1)

matchtimes <- function(t1, t2) {
# t1, t2 are numeric
	findInterval(t1, c(-Inf, head(t2, -1)) + c(0, diff(t2)/2))
}
