#' find duplicates in a stream
#' 
#' find duplicates aware that some columns might be different
#' @param stream a \code{sattagstream} to test for duplicates
#' @param use_cols a character vector of column names or a integer vector of indices to use to generate a key for duplicated.
#' @export

setGeneric("find_duplicates_stream", function(stream, use_cols) {
  standardGeneric("find_duplicates_stream")
})

#' @describeIn find_duplicates_stream for generic sattagstreams
setMethod("find_duplicates_stream", "sattagstream", function(stream, use_cols = colnames(stream)) {
  teststream <- stream[, use_cols]
  duplicated(teststream)  
})

#' @describeIn find_duplicates_stream for *-All.csv
setMethod("find_duplicates_stream", "all", function(stream, use_cols = c()) {
  callNextMethod()
})

# all, behavior, corrupt, fastgps, labels, rawargos, rtc, series, seriesrange, locations, status, summary