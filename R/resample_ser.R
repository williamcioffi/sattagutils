#' resample series
#'
#' downsample series to a particular sampling period.
#' @param s a series data stream or a dataframe approximating one. requires column numeric \code{Date}.
#' @param sampling_period desired sampling period in minutes (sorry).
#' @export

resample_ser <- function(
	s, # series data expectes to have a column date added in numeric format
	sampling_period # desired sampling period in minutes (sorry)
) {
	SAMPLING_PERIOD <- sampling_period
	accepted_times <- seq(0, 59, by = SAMPLING_PERIOD)
	
	decimal_minutes <- as.numeric(format(num2date(s$Date), "%M")) + as.numeric(format(num2date(s$Date), "%S")) / 60
	accepted_samples <- decimal_minutes %in% accepted_times
	s_subsampled <- s[accepted_samples, ]
	s_subsampled
}
