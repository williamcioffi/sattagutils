#' @include sattagstream.R
#' @include sattagstream_extends.R
NULL

#' translate character dates to numeric dates
#'
#' convert character dates to numeric dates (seconds since UNIX epoch by default). see also \code{\link[sattagutils]{num2date}} 
#' @param d either a character vector of dates or an object of a class which extends \code{\link[sattagutils]{sattagstream-class}}.
#' @param tz,format as expected by \code{\link[base]{as.POSIXct}}. 
#' @details methods are defined for converting objects of a class which extends \code{sattagstream}.
#' note that the date formats and column names are inconsistent in the data streams download from the portal. for example, note the odd capitalization patterns in \code{*-All.csv} (and ambiguous date format). method is not fully implemented for \code{stream_summary} because i've never seen the date format for \code{ReleaseDate} and \code{DeployDate}.
#'
#' also, beware if you open any data stream csvs in excel and re-save, the dates will likely be put into an absurb ambiguous form. additionally, seconds tend to be obliterated.
#'
#' this methods may become defunct if wildlife updates their conventions and will have to be updated.
#' @export
#' @examples
#' date2num("1988-03-12 07:00:00", tz = "UTC", format = "%Y-%m-%d %H:%M:%S")

setGeneric("date2num",
	function(d, tz = "UTC", format = "%H:%M:%S %d-%b-%Y", ...) {
		as.numeric(as.POSIXct(d, tz = tz, format = format))
	}
)

#' @rdname date2num
setMethod("date2num", "sattagstream", function(d, tz, format, ...) {
	d@data$Date <- date2num(d@data$Date, tz = tz, format = format, ...)
	d
})

#' @rdname date2num
setMethod("date2num", "stream_all", function(d, tz, format = "%m/%d/%Y %H:%M:%S", ...) {
	d@data$Loc..date <- date2num(d@data$Loc..date, tz = tz, format = format, ...)
	d@data$Msg.Date  <- date2num(d@data$Msg.Date,  tz = tz, format = format, ...)
	d
})

#' @rdname date2num
setMethod("date2num", "stream_behavior", function(d, tz, format, ...) {
	d@data$Start <- date2num(d@data$Start, 	tz = tz, format = format, ...)
	d@data$End <- 	date2num(d@data$End, 	tz = tz, format = format, ....)
	d
})

#' @rdname date2num
setMethod("date2num", "stream_corrupt", function(d, tz, format, ...) {
	d@data$Date <- date2num(d@data$Date, tz = tz, format = format, ...)
	d@data$Possible.Timestamp <- date2num(d@data$Possible.Timestamp, tz = tz, format = format)
	d
})

#' @rdname date2num
setMethod("date2num", "stream_fastgps", function(d, tz, format, ...) {
	d@data$Date <- date2num(paste(d@data$Time, d@data$Day), tz = tz, format = format, ...)
	d
})

#' @rdname date2num
setMethod("date2num", "stream_labels", function(d, tz, format, ...) {
	warning("There aren't any dates in the labels streams")
	d
})

#' @rdname date2num
setMethod("date2num", "stream_rawargos", function(d, tz, format, ...) {
	d@data$PassDate <- date2num(paste(d@data$PassTime, d@data$PassDate), tz = tz, format = format, ...)
	d@data$MsgDate 	<- date2num(paste(d@data$MsgTime,  d@data$MsgDate),  tz = tz, format = format, ...)
	d
})

#' @rdname date2num
setMethod("date2num", "stream_rtc", function(d, tz, format, ...) {
	d@data$TagDate  <- date2num(paste(d@data$TagTime,  d@data$TagDate),  tz = tz, format = format, ...)
	d@data$RealDate <- date2num(paste(d@data$RealTime, d@data$RealDate), tz = tz, format = format, ...)
	d
})

#' @rdname date2num
setMethod("date2num", "stream_series", function(d, tz, format, ...) {
	d@data$Date <- date2num(paste(d@data$Time, d@data$Day), tz = tz, format = format, ...)
	d
})

#' @rdname date2num
setMethod("date2num", "stream_seriesrange", function(d, tz, format, ...) {
	d@data$Start <- date2num(d@data$Start, 	tz = tz, format = format, ...)
	d@data$End 	 <-	date2num(d@data$End, 	tz = tz, format = format, ....)
	d
})

#' @rdname date2num
setMethod("date2num", "stream_status", function(d, tz, format, ...) {
	d@data$Received <- date2num(d@data$Received,	 tz = tz, format = format, ...)
	d@data$RTC 		<- 	date2num(d@data$RTC, 	 tz = tz, format = format, ....)
	d
})

#' @rdname date2num
setMethod("date2num", "stream_summary", function(d, tz, format, ...) {
	d@data$EarliestXmitTime	<- date2num(d@data$EarliestXmitTime, tz = tz, format = format, ...)
	d@data$LatestXmitTime	<- date2num(d@data$LatestXmitTime,	 tz = tz, format = format, ...)
	d@data$EarliestDataTime <- date2num(d@data$EarliestDataTime, tz = tz, format = format, ...)
	d@data$LatestDataTime	<- date2num(d@data$LatestDataTime,   tz = tz, format = format, ...)
	# d@data$ReleaseDate # not sure how this is implemented?
	# d@data$DeployDate # not sure how this is implemented?
	d
})
