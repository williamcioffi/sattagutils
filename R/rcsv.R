#' sensible defaults for \code{read.table}
#'
#' @family sensible csv functions
#' @param ... all the regular good stuff for finding files and whatnot.
#' @param header i always want a header
#' @param sep we're talking about comma seperated values here.
#' @param stringsAsFactors default is FALSE. please don't change that. why would you change that?
#' @details please don't use read_csv or any of that other nonesense, it breaks everyone's code...
#' @export
#' @examples
#' # use it just like read.table but without the worry
#' \dontrun{
#' rcsv("file.csv")
#' }

rcsv <- function(..., header = TRUE, sep = ',', stringsAsFactors = FALSE)  {
	read.table(..., header = header, sep = sep, stringsAsFactors = stringsAsFactors)
}

