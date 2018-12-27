#' @include sattag.R
#' @include num2date.R
NULL

#' display an S4 object of class \code{\link[sattagutils]{sattag}}

setMethod("show", "sattag", 
	function(object) {
		streamfnames <- filename(object)
		streamindices <- 1:length(streamfnames)	
		streams <- paste0(sprintf("%02d", streamindices), "- ", streamfnames)	
		streams <- paste(streams, collapse = "\n")
		cat(paste0("sattag type: ", object@instrument, "\n"))
		cat(paste0("species: ", object@species, "\n"))
		cat(paste0("deploy id: ", object@DeployID, "\nptt: ", object@Ptt, "\n"))
		cat(paste0("start data date: ", format(num2date(object@t_start), "%Y-%m-%d"), "\nend data date: ", format(num2date(object@t_end), format = "%Y-%m-%d"), "\n"))
		
		cat("------\n") 
		cat(paste0("streams: \n", streams, "\n"))
		cat("------\n") 
		cat(paste0("loaded from: ", object@directory, "\n"))
		cat(paste0("loaded on: ", object@loadtime, "\n"))
	}
)

