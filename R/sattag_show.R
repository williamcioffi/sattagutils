#' @include sattag.R
NULL

#' display an S4 object of class \code{\link[sattagutils]{sattag}}

setMethod("show", "sattag", 
	function(object) {
		streams <- sapply(object@streams, function(s) slot(s, "streamname"))
		streamindices <- 1:length(streams)	
		streams <- paste(sprintf("%02d", streamindices), streams, sep = "- ")	
		streams <- paste(streams, collapse = "\n")
		cat(paste0("sattag type: ", object@instrument, "\n"))
		cat(paste0("species: ", object@species, "\n"))
		cat(paste0("deploy id: ", object@DeployID, "\nptt: ", object@Ptt, "\n"))
		cat(paste0("earliest data date: ", object@earliestdata, "\nlatest data date: ", object@latestdata, "\n"))
		
		cat("------\n") 
		cat(paste0("streams: \n", streams, "\n"))
		cat("------\n") 
		cat(paste0("loaded from: ", object@directory, "\n"))
		cat(paste0("loaded on: ", object@loadtime, "\n"))
	}
)