#' has_stream
#' 
#' Checks to see if a tagstack or sattag has a stream
#' @param x the tagstack or sattag in question
#' @param streamname the stream you are searching for
#' @return a bool if any of the streams are \code{streamname}
#' @export
has_stream <- function(x, streamname) {
  any(streamname %in% streamtype(x))
}

