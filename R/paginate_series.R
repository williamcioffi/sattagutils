#' a pagination tool for plotting series datastream.
#' 
#' simple function which provides a menu navigation for seires datastream
#' @param s a series data stream or a dataframe approximating one. gets passed to  \code{\link[sattagutils]{plot_series}}.
#' @param increment the number of sampling points to show on the plot at one time. also current increments without overlap when you page forward or backwards.
#' @param time a string which indicates what you want the x-axis to be. right now only "samples" (running sample index) or "numeric" (matlab style datenum since the unix epoch) are supported.
#' @param xaxt default set to 'n' so i can plot an axis like you asked for in time.
#' @param las default to 1 why would you do anything else?
#' @param ... all that other good graphics stuff and gets passed to \code{\link[sattagutils]{plot_series}}.
#' @export

paginate_series <- function(s, increment = 4*48, time = "samples", xaxt = 'n', las = 1, ...) {
  # constants
  INCR <- increment
  LEGAL_KEYPRESS <- c("n", "p", "c", "q")
  TIME <- time
    
  # dynamics
  steps <- ceiling(nrow(s) / INCR)
  len <- 0
  
  done <- FALSE
  i <- 1
  while(!done) {
    st <- (i-1)*INCR + 1
    en <- st + INCR - 1
    
    # plot where we at
    plot_series(s[st:en], xaxt = xaxt, las = 1, ...)
    title(paste0(i, "/", steps, "      ", s$Ptt[1], "/", s$DeployID[1]))
    
    if(TIME == "samples") {
      axis(1, at = s$Date[st:en], lab = st:en)
    } else if(TIME == "numeric") {
      axis(1)
    }
    
    # get instructions from the user
    keypress <- ""
    keypress_num <- NA
    while(!(keypress %in% LEGAL_KEYPRESS) && is.na(keypress_num)) {
      keypress <- readline("|(n)ext|(p)rev|(#)goto|(c)ount|(q)uit| > ")
      keypress <- tolower(keypress)
      keypress_num <- as.numeric(keypress)
    }
    
    if(!is.na(keypress_num)) {
      if(keypress_num >= 1 && keypress_num <= steps) {
        i <- keypress_num
      }
    }
    if(keypress == "p") {
      i <- i - 1
      if(i < 1) i <- 1
    }
    if(keypress == "n") {
      i <- i + 1
      if(i > steps) i <- steps
    }
    if(keypress == "c") {
      
      donedone <- FALSE
      while(!donedone) {
       dese <- locator(1)
       points(dese[1], dese[2], col = "purple")
       if(is.null(dese)) {
         donedone <- TRUE
       } else {
         points(dese[1], dese[2], col = "purple")
         len <- len + 1
       }
      }
    }
    if(keypress == "q") {
      done <- TRUE
    }
  }
  
  if(len > 0) return(len)
}
