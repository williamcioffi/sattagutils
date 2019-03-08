#' quickly create nice data sequences for plotting
#'
#' using numeric times (seconds since UNIX epoch) find where to put the daily and hourly tickmarks
#' @param d a numeric vector of times
#' @param hours boolean defaults to FALSE. when TRUE will return hourly times.
#' @details probably could make this more general, but don't need to right now.
#' @export
#' @examples
#' dateseq(1:(5*24*60*60))

dateseq <- function(d, hours = FALSE) {
	unit <- 60*60*24 # day in seconds
	if(hours) unit <- 60*60 # hour in seconds

	mind <- min(d, na.rm = TRUE)
	maxd <- max(d, na.rm = TRUE)

	std <- ceiling(mind / unit) * unit
	end <- ceiling(maxd / unit) * unit
	
	seq(std, end, by = unit)
}
