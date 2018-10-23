#' @include sattag.R
NULL

#' display an S4 object of class \code{\link[sattagutils]{sattag}}

setMethod("show", "sattag", 
	function(object) {
		streams <- names(object)
		streamtypes <- streamtype(object)
		streamindices <- 1:length(streams)	
		streams <- paste0(sprintf("%02d", streamindices), "- ", streams, " ", streamtypes)	
		streams <- paste(streams, collapse = "\n")
		cat(paste0("sattag type: ", object@instrument, "\n"))
		cat(paste0("species: ", object@species, "\n"))
		cat(paste0("deploy id: ", object@DeployID, "\nptt: ", object@Ptt, "\n"))
		cat(paste0("start data date: ", object@t_start, "\nend data date: ", object@t_end, "\n"))
		
		cat("------\n") 
		cat(paste0("streams: \n", streams, "\n"))
		cat("------\n") 
		cat(paste0("loaded from: ", object@directory, "\n"))
		cat(paste0("loaded on: ", object@loadtime, "\n"))
	}
)