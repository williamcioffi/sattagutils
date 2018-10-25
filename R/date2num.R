#' @include sattagstream.R
#' @include sattagstream_extends.R
NULL

#' translate character dates to numeric dates
#'
#' convert character dates to numeric dates (seconds since UNIX epoch by default).
#' @family date manipulators
#' @seealso \code{\link[base]{as.POSIXct}}
#' @param d either a character vector of dates or an object of a class which extends \code{\link[sattagutils]{sattagstream}}.
#' @param tz,format as expected by \code{\link[base]{as.POSIXct}}. 
#' @param ... any other good stuff you want to pass to \code{as.POSIXct}.
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
	function(d, ...) {
		as.numeric(as.POSIXct(d, ...))
	}
)

#' @describeIn date2num for generic sattagstreams
setMethod("date2num", "sattagstream", function(d, tz = "UTC", format = "%H:%M:%S %d-%b-%Y", ...) {
	d$Date <- date2num(d$Date, tz = tz, format = format, ...)
	d
})

#' @describeIn date2num for *-All.csv. note the different time format.
setMethod("date2num", "stream_all", function(d, tz = "UTC", format = "%m/%d/%Y %H:%M:%S", ...) {
	d$Loc..date <- date2num(d$Loc..date, tz = tz, format = format, ...)
	d$Msg.Date  <- date2num(d$Msg.Date, tz = tz, format = format, ...)
	d
})

#' @describeIn date2num for *-Behavior.csv
setMethod("date2num", "stream_behavior", function(d, tz = "UTC", format = "%H:%M:%S %d-%b-%Y", ...) {
	d$Start <- date2num(d$Start, tz = tz, format = format, ...)
	d$End 	<- date2num(d$End, tz = tz, format = format, ...)
	d
})

#' @describeIn date2num for *-Corrupt.csv
setMethod("date2num", "stream_corrupt", function(d, tz = "UTC", format = "%H:%M:%S %d-%b-%Y", ...) {
	d$Date <- date2num(d$Date, tz = tz, format = format, ...)
	d$Possible.Timestamp <- date2num(d$Possible.Timestamp, tz = tz, format = format, ...)
	d
})

#' @describeIn date2num for *-FastGPS.csv
setMethod("date2num", "stream_fastgps", function(d, tz = "UTC", format = "%H:%M:%S %d-%b-%Y", ...) {
	d$Date <- date2num(paste(d$Time, d$Day), tz = tz, format = format, ...)
	d
})

#' @describeIn date2num for *-Labels.csv
setMethod("date2num", "stream_labels", function(d, tz = "UTC", format = "%H:%M:%S %d-%b-%Y", ...) {
	warning("There aren't any dates in the labels streams")
	d
})

#' @describeIn date2num for *-RawArgos.csv
setMethod("date2num", "stream_rawargos", function(d, tz = "UTC", format = "%H:%M:%S %d-%b-%Y", ...) {
	d$PassDate <- date2num(paste(d$PassTime, d$PassDate), tz = tz, format = format, ...)
	d$MsgDate 	<- date2num(paste(d$MsgTime,  d$MsgDate), tz = tz, format = format, ...)
	d
})

#' @describeIn date2num for *-RTC.csv
setMethod("date2num", "stream_rtc", function(d, tz = "UTC", format = "%H:%M:%S %d-%b-%Y", ...) {
	d$TagDate  <- date2num(paste(d$TagTime,  d$TagDate), tz = tz, format = format, ...)
	d$RealDate <- date2num(paste(d$RealTime, d$RealDate), tz = tz, format = format, ...)
	d
})

#' @describeIn date2num for *-Series.csv
setMethod("date2num", "stream_series", function(d, tz = "UTC", format = "%H:%M:%S %d-%b-%Y", ...) {
	d$Date <- date2num(paste(d$Time, d$Day), tz = tz, format = format, ...)
	d
})

#' @describeIn date2num for *-SeriesRange.csv
setMethod("date2num", "stream_seriesrange", function(d, tz = "UTC", format = "%H:%M:%S %d-%b-%Y", ...) {
	d$Start <- date2num(d$Start, tz = tz, format = format, ...)
	d$End 	 <-	date2num(d$End, tz = tz, format = format, ...)
	d
})

#' @describeIn date2num for *-Locations.csv
setMethod("date2num", "stream_locations", function(d, tz = "UTC", format = "%H:%M:%S %d-%b-%Y", ...) {
	tmpdate <- d$Date
	datesplit <- strsplit(tmpdate, " ")
	times <- sapply(datesplit, "[[", 1)
	days <- sapply(datesplit, "[[", 2)
	trunctimes <- sapply(strsplit(times, "\\."), "[[", 1)
	
	d$originaldate <- tmpdate
	d$Date <- date2num(paste(trunctimes, days), tz = tz, format = format, ...)
	d
})

#' @describeIn date2num for *-Status.csv
setMethod("date2num", "stream_status", function(d, tz = "UTC", format = "%H:%M:%S %d-%b-%Y", ...) {
	d$Received <- date2num(d$Received, tz = tz, format = format, ...)
	d$RTC 		<- 	date2num(d$RTC, tz = tz, format = format, ...)
	d
})

#' @describeIn date2num for *-Summary.csv note: not sure how to implement ReleaseDate or DeployDate...
setMethod("date2num", "stream_summary", function(d, tz = "UTC", format = "%H:%M:%S %d-%b-%Y", ...) {
	d$EarliestXmitTime	<- date2num(d$EarliestXmitTime, tz = tz, format = format, ...)
	d$LatestXmitTime	<- date2num(d$LatestXmitTime, tz = tz, format = format, ...)
	d$EarliestDataTime <- date2num(d$EarliestDataTime, tz = tz, format = format, ...)
	d$LatestDataTime	<- date2num(d$LatestDataTime, tz = tz, format = format, ...)
	# d$ReleaseDate # not sure how this is implemented?
	# d$DeployDate # not sure how this is implemented?
	d
})
