#' find duplicates in a stream
#' 
#' find duplicates aware that some columns might be different
#' @param stream a \code{sattagstream} to test for duplicates
#' @param use_cols a character vector of column names or a integer vector of indices to use to generate a key for duplicated.
#' @export

setGeneric("duplicated_sattagstream", function(stream, use_cols = colnames(stream)) {
  standardGeneric("duplicated_sattagstream")
})

#' @describeIn duplicated_sattagstream for generic sattagstreams
setMethod("duplicated_sattagstream", "sattagstream", function(stream, use_cols = colnames(stream)) {
  teststream <- stream[, use_cols]
  duplicated(teststream)  
})

#' @describeIn duplicated_sattagstream for *-All.csv
setMethod("duplicated_sattagstream", "all", function(stream, use_cols = colnames(stream)) {
  callNextMethod(stream, use_cols)
})

#' @describeIn duplicated_sattagstream for *-Behavior.csv
setMethod("duplicated_sattagstream", "behavior", function(stream, use_cols = c("Ptt", "Start", "End", "What", "Number", "Shape", "DepthMin", "DepthMax", "DurationMin", "DurationMax", "Shallow", "Deep")) {
    callNextMethod(stream, use_cols)
})

#' @describeIn duplicated_sattagstream for *-FastGPS.csv
setMethod("duplicated_sattagstream", "fastgps", function(stream, use_cols = c("Day", "Time", "LocNumber", "Failures", "Hauled.Out", "Satellites", "Range.Bits", 
  "Id",    "Range",    "Signal",    "Doppler",    "CNR", 
  "Id.1",  "Range.1",  "Signal.1",  "Doppler.1",  "CNR.1", 
  "Id.2",  "Range.2",  "Signal.2",  "Doppler.2",  "CNR.2",
  "Id.3",  "Range.3",  "Signal.3",  "Doppler.3",  "CNR.3",
  "Id.4",  "Range.4",  "Signal.4",  "Doppler.4",  "CNR.4",
  "Id.5",  "Range.5",  "Signal.5",  "Doppler.5",  "CNR.5",
  "Id.6",  "Range.6",  "Signal.6",  "Doppler.6",  "CNR.6",
  "Id.7",  "Range.7",  "Signal.7",  "Doppler.7",  "CNR.7",
  "Id.8",  "Range.8",  "Signal.8",  "Doppler.8",  "CNR.8",
  "Id.9",  "Range.9",  "Signal.9",  "Doppler.9",  "CNR.9",
  "Id.10", "Range.10", "Signal.10", "Doppler.10", "CNR.10",
  "Id.11", "Range.11", "Signal.11", "Doppler.11", "CNR.11",
  "Id.12", "Range.12", "Signal.12", "Doppler.12", "CNR.12",
  "Id.13", "Range.13", "Signal.13", "Doppler.13", "CNR.13",
  "Id.14", "Range.14", "Signal.14", "Doppler.14", "CNR.14"
  )) {
  callNextMethod(stream, use_cols)
})

#' @describeIn duplicated_sattagstream for *-Series.csv
setMethod("duplicated_sattagstream", "series", function(stream, use_cols = c("Ptt", "Day", "Time", "Depth", "DRange", "Temperature", "TRange", "Activity", "ARange")) {
  callNextMethod(stream, use_cols)
})

#' @describeIn duplicated_sattagstream for *-SeriesRange.csv
setMethod("duplicated_sattagstream", "seriesrange", function(stream, use_cols = c("Ptt", "Start", "End", "MinDepth", "MinDepthAccuracy", "MaxDepth", "MaxDepthAccuracy", "MinTemp", "MinTempAccuracy", "MaxTemp", "MaxTempAccuracy", "MobMean", "MobSD", "ActivitySum")) {
  callNextMethod(stream, use_cols) 
})
