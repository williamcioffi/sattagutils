#' translate numeric dates back to \code{POSIX*}
#'
#' will convert a numeric vector (seconds since UNIX epoch) using \code{as.POSIXct}. methods for \code{\link[sattagutils]{sattagstream}} classes not implemeneted.
#' @family date manipulators
#' @seealso \code{\link[base]{as.POSIXct}}
#' @param d a numeric vector of dates.
#' @param tz,origin as expected by \code{\link[base]{as.POSIXct}}.
#' @export
#' @examples
#' num2date(574153200)

setGeneric("num2date",
	function(d, tz = "UTC", origin = "1970-01-01", ...) {
		as.POSIXct(d, tz = tz, origin = origin)	
	}
)
