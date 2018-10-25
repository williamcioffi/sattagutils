#' batch load sat tags
#'
#' load sat tags from a directory containing directories downloaded from the wildlife computers portal.
#' @family tag stream loaders
#' @param data_dir character points to a directory of sat tags
#' @param tags_dir character vector of tag directory names to include or NA defaults to every directory in \code{data_dir}
#' @param ignore character vector of directories to ignore or NA defaults not to ignore any directories.
#' @param streams character vector limiting which streams to search for. NA defaults to all streams. note \code{*-Summary.csv} and \code{*-Labels.csv} are expected to populate some of the slots of \code{sattag-class}. 
#' @param stream_delim character defaults to \code{"-"}. this is what the wildlife computers portal puts between the tag identifier (sometimes DeployID, sometimes Ptt) and the stream identifier (e.g., Argos, RTC, etc.) in the csv files.
#' @return an S4 object of class \code{\link[sattagutils]{tagstack}}
#' @export
#' @examples
#' \dontrun{
#' tags <- load_tag("~/path/to/tags/")
#' }

batch_load_tags <- function(
	data_dir,				# point to a directory of sat tags
	tags_dir = NA,		# vector of tag dir names to include or NA defaults to every dir in the data_dir
	ignore = NA,			# vector of tag dir names to ignore or NA defaults to not ignore anything in the data_dir
	streams = NA,			# vector of data streams (CSV file names) to load in or NA defaults to all data streams in the directory)
	stream_delim = "-"
) {
	
	# need at least a valid data_dir to proceed
	if(!hasArg(data_dir)) stop("i need a data directory to look for tags...")
	if(!file.exists(data_dir)) stop(data_dir, ": i don't think that data directory exists...")
	
	streams <- tolower(streams)
	
	# get a list of the (tag directories)
	dnames <- list.files(data_dir)
	
	# remove any non directories
	desedirs <- file_test("-d", file.path(data_dir, dnames))
	dnames <- dnames[desedirs]
	
	# check to make sure there are directories
	if(length(dnames) == 0) stop(data_dir, ": i don't think there are any tag directories in your data directory..")
	
	# if the user decided to select some tag dirs then subset these out
	# check to make sure at least one of them is real
	# ignore any others that aren't real
	if(all(!is.na(tags_dir))) {
		desedirs <- dnames %in% tags_dir
		if(all(!desedirs)) stop("i don't think any of those tag directories exist...")
		
		dnames <- dnames[desedirs]
	}
	
	if(all(!is.na(ignore))) {
		desedirs <- !(dnames %in% tags_dir)
		if(all(!desedirs)) stop("i don't think there are any tag directories in here...")
		
		dnames <- dnames[desedirs]
	}
	
	# make these back into real paths
	dpaths <- file.path(data_dir, dnames)
	
	# set up a list to hold the output
	out <- list()
	
	# loop over each tag
	# and pull the desired streams
	for(d in 1:length(dpaths)) {
		out[[d]] <- load_tag(dpaths[d], streams, stream_delim)
	}
	
	names(out) <- sapply(out, DeployID)
	
	tagstack(out, data_dir)
}