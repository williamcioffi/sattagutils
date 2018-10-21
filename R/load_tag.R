#' load a single sat tag
#'
#' given a tag directory from a portal download instantiate, populate, and return a \code{\link[sattagutils]{sattag-class}} S4 object.
#' @param tag_dir a path to a tag directory containg csv data streams downloaded from the portal.
#' @param streams a character vector limiting which streams to search for. NA default to all streams. note that \code{*-Summary.csv} is expected to populate some of the slots.
#' @return a \code{\link[sattagutils]{sattag-class}} S4 object.
#' @export
#' @examples
#' \dontrun{
#' tag1 <- load_tag("~/path/to/tags/tag1")
#' }

load_tag <- function(tag_dir, streams = NA) {
	# constants
	STREAM_DELIM <- "-"	# assuming a standard wildlife computer download
	
	# need at least a valid tag diretory to proceed
	if(!hasArg(tag_dir)) stop("I need a tag directory to look for streams...")
	if(!file.exists(tag_dir)) stop(tag_dir, ": I don't think that tag directory exists...")
	
	# grab all the file names and look for csv data streams
	tfnames <- list.files(tag_dir)
	iscsv <- grepl("*.csv$", tfnames)
	
	# throw an error if you didn't find any csvs
	if(!any(iscsv)) stop(tag_dir, ": I didn't find any csv files in this directory...")
	
	# subset out the csvs
	# and look for the stream name
	csvfnames <- tfnames[iscsv]
	csvfpaths <- file.path(tag_dir, csvfnames)
	
	#
	stream_names <- strsplit(csvfnames, STREAM_DELIM)
	stream_names <- sapply(stream_names, function(s) s[length(s)])
	stream_names <- tolower(stream_names)
	stream_names <- sapply(strsplit(stream_names, "\\."), '[[', 1)
	
	# if streams is not NA then select just those streams
	if(!is.na(streams)) {
		streams <- tolower(streams)
		
		desestreams <- stream_names %in% streams
		if(!any(desestreams)) stop(paste(streams, collapse = ", "), ": I could not find any of these streams...")
		
		# subsample both stream names and paths
		csvfpaths <- csvfpaths[desestreams]
		stream_names <- stream_names[desestreams]
	}
	
	# create a tag object to hold output
	outtag <- new("sattag")
	outdata <- list()
	
	# loop through each stream
	for(s in 1:length(csvfpaths)) {
		path <- csvfpaths[s]
		
				tryCatch({	# start try block
		# special considerations for these stream types
		if(stream_names[s] == "rawargos") {
			# RAWARGOS always has 4 lines that don't follow the csv format at the end
			tmpstream <- rcsv(text = paste0(head(readLines(path), -4)), comment.char = "")
		} else if(stream_names[s] == "fastgps") {
			# FASTGPS always has 3 lines that don't follow the csv format at the beginning
			tmpstream <- rcsv(text = paste0(tail(readLines(path), -3)), comment.char = "")
		} else if(stream_names[s] == "labels") {
			# labels isn't actually a well formatted csv. and I think it might be missing an EOF? 
			# also it is a tall table instead of a wide one like every other data stream. go figure.
			# but I want this metadata so we'll have to parse it.
			rawlabels <- readLines(path)
			rawsplit <- strsplit(rawlabels, ",") 
			labels <- as.data.frame(do.call('rbind', rawsplit), stringsAsFactors = FALSE)
			
			outtag@instrument <- labels$V2[labels$V1 == "TagType"]
			outtag@location <- labels$V2[labels$V1 == "Locality"]
			outtag@species <- labels$V2[labels$V1 == "Species"]
			
			tmpstream <- labels
		} else {
			tmpstream <- rcsv(path)
		}
		
		# make a new stream object of the correct class
		tmpdata <- new(paste0("stream_", stream_names[s]), filename = csvfnames[s], data = tmpstream)
		# convert times to numeric appropraitely
		tmpdata <- date2num(tmpdata)
		# save to the list
		outdata[[s]] <- tmpdata
		
				},	# end try block / start catch
				error = function(err) {
					message(paste0(csvfpaths[s], ": ", err))
				}, finally = {})
#				warning = function(war) {
#					message(paste0(csvfpaths[s], ": ", war))
#				}, finally = {}) # end catch
	}
	
	names(outdata) <- stream_names
	outtag@streams <- outdata
	
	outtag@nstreams <- length(outdata)
	outtag@DeployID <- outtag@streams$summary@data$DeployID[1]
	outtag@Ptt <- as.character(outtag@streams$summary@data$Ptt[1])
	outtag@earliestdata <- outtag@streams$summary@data$EarliestDataTime[1]
	outtag@latestdata <- outtag@streams$summary@data$LatestDataTime[1]
	outtag@directory <- tag_dir
	
	outtag
}
