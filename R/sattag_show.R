#' @include sattag.R
NULL

#' display an S4 object of class \code{sattag}

setMethod("show", "sattag", 
	function(object) {
		streams <- sapply(object@streams, function(o) class(o)[1])
		if(length(streams) > 0) {
			streams <- sapply(strsplit(streams, "_"), '[[', 2)
			streams <- paste(streams, collapse = ", ")
		} else {
			streams <- ""
		}
		
		cat(paste0("sattag type: ", object@instrument, "\n"))
		cat(paste0("species: ", object@species, "\n"))
		cat(paste0("deploy id: ", object@DeployID, "\nptt: ", object@Ptt, "\n"))
		cat(paste0("earliest data date: ", object@earliestdata, "\nlatest data date: ", object@latestdata, "\n"))
		cat(paste0("streams: ", streams, "\n"))
		cat("------\n") 
		cat(paste0("loaded from: ", object@directory, "\n"))
		cat(paste0("loaded on: ", object@loadtime, "\n"))
	}
)