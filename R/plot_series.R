#' plotting function for series datastream.
#'
#' simple function to plot series data quickly.
#' @param s a series data stream or a dataframe approximating one. requires columns numeric \code{Date}, numeric \code{Depth}.right now also requires to have at least 2 rows that is so i can calculate the sampling period. see readme for more information about this. 
#' @param show_gaps boolean defaults to FALSE. if TRUE pink rectangles will show the data gaps
#' @param new boolean defaults to TRUE. draw a new plot if this is TRUE otherwise draw on whatever you have up.
#' @param points boolean defaults to TRUE. draw points.
#' @param lines boolean defaults to TRUE. draw lines.
#' @param pch,cex just reasonable defaults do whatever you want.
#' @param col.lines color of the lines if drawn.
#' @param col.points color of the points if drawn.
#' @param ... all the other good plotting stuff. gets passed to \code{plot}, \code{points}, and \code{lines} so think about it.
#' @export

plot_series <- function(s, show_gaps = FALSE, new = TRUE, points = TRUE, lines = TRUE, pch = 16, cex = .5, col.lines = "black", col.points = "black", ...) {
	if(nrow(s) < 2) stop("i need two points to figure out what the sampling period is...") # i guess the series sattagstream should know what its sampling period is
	if(new) plot(s$Date, -s$Depth, type = 'n', ...)
	
	gaps <- findgaps2(data.frame(Start = s$Date, End = s$Date, What = "Message"), tolerance = s$Date[2] - s$Date[1])
	serstretch <- gaps$stretchid
	userstretch <- unique(serstretch)
	for(n in 1:length(userstretch)) {
		dese_ser <- serstretch == userstretch[n]
		curcurs <- s[dese_ser, ]
		if(points) points(curcurs$Date, -curcurs$Depth, pch = pch, cex = cex, col = col.points, ...)
		if(lines) lines(curcurs$Date, -curcurs$Depth, col = col.lines, ...)
	}
	
	if(show_gaps) {
		rect(gaps$gap_st, rep(-4000, gaps$ngaps), gaps$gap_en, rep(4000, gaps$ngaps), col = rgb(1, 0, 0, .25), border = NA)
	}
}

