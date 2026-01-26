#' @include sattagstream.R
NULL

#' segment series data into dives
#' 
#' A simplier, but maybe better dive segmentation function
#' 
#' Basically it makes 3 tests on adjacent points to look for dive breaks:
#' - are we switching from ascending to descending?
#' - are we switching from ascending to flat?
#' - are we switching from flat to descending?
#'   
#'   Further we check to make sure we aren't bridging a data gap. And finally we check to see if the dive is shallow (within a threshold set by the user) since sometimes dive undulate up and down underwater.
#' @param ser a series data stream or a dataframe approximating one. requires columns numeric \code{Date}, numeric \code{Depth}, numeric \code{DRange}.
#' @param sampling_period sampling period of input series data
#' @param series_max_depth_dive_st_or_en used by the peak finding algorithm to determine if a peak is close enough to the surface to represent a real surfacing event. you will need to pick something that makes sense for your species and tag settings.
#' @return a numeric vector of length \code{nrow(ser)} that provides a dive index
#' @note this is a better algorithm than ser2beh, but does not produce a well formatted behavior data stream.
#' @export

serseg <- function(ser, sampling_period, series_max_depth_dive_st_or_en) {
  # constants
  SAMPLING_PERIOD <- sampling_period
  SERIES_MAXIMUM_DEPTH_DIVE_ST_OR_EN <- series_max_depth_dive_st_or_en
  
  # rename for consistentcy
  cur <- ser
  
  cur$tdiff <- c(0, cur$Date[2:nrow(cur)] - cur$Date[1:(nrow(cur) - 1)])
  cur$stretchid <- cumsum(cur$tdiff > SAMPLING_PERIOD) + 1
  
  # sign of the first derivative gives inflection points
  dtcur <- c(NA, diff(-cur$Depth))
  dtcur_sign <- sign(dtcur)
  cur$sign <- dtcur_sign
  cur$dd <- abs(dtcur)
  
  working_range <- 2:(nrow(cur) - 1)
  
  # any of these are acceptable transitions
  # that might be the start or end of a dive
  pascur <- dtcur_sign[working_range] == 1 & dtcur_sign[working_range + 1] == -1
  pass2 <- dtcur_sign[working_range] == 1 & dtcur_sign[working_range + 1] == 0
  pass3 <- dtcur_sign[working_range] == 0 & dtcur_sign[working_range + 1] == -1
  
  # check to see if it crosses a gap
  isgap <- cur$stretchid[working_range] != cur$stretchid[working_range + 1]
  
  # check the conditions for transitions and not over a gap
  pass_all <- pascur | pass2 | pass3
  pass_all <- pass_all & !isgap
  
  # most likely a change in the dive if they are also shallow
  pass_final <- pass_all & cur$Depth[working_range] <= SERIES_MAXIMUM_DEPTH_DIVE_ST_OR_EN
  pass_final <- c(FALSE, pass_final, FALSE)
  
  # define an index based on these dives
  cumsum(pass_final)
}
