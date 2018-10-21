#' sensible defaults for \code{write.table}
#'
#' @family sensible csv functions
#' @param ... all the regular good stuff for finding files and whatnot.
#' @param sep we're talking about comma seperated values here.
#' @param row.names defaults to FALSE, because that's usually what i want. not when i'm printing a matrix or something though. but here for tables, yes this is what i want.
#' @details please don't use write_csv or any of that other nonesense, it breaks everyone's code...
#' @export
#' @examples
#' # use it just like write.table but without the worry
#' x <- data.frame(x1 = rnorm(10), x2 = rnorm(10))
#' wcsv(x, "file.csv")

wcsv <- function(..., sep = ',', row.names = FALSE) {
	write.table(..., sep = sep, row.names = row.names)
}