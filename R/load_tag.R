#' load a single sat tag
#'
#' given a tag directory from a portal download instantiate, populate, and return a \code{\link[sattagutils]{sattag}} S4 object.
#' @family tag stream loaders
#' @param tag_dir a path to a tag directory containg csv data streams downloaded from the portal.
#' @param streams a character vector limiting which streams to search for. NA default to all streams. note that \code{*-Summary.csv} is expected to populate some of the slots.
#' @return a \code{\link[sattagutils]{sattag}} S4 object.
#' @export
#' @examples
#' \dontrun{
#' tag1 <- load_tag("~/path/to/tags/tag1")
#' }

load_tag <- function(tag_dir, streams = NA) {
	# constants
	STREAM_DELIM <- "-"	# assuming a standard wildlife computer download
	
	# need at least a valid tag diretory to proceed
	if(!hasArg(tag_dir)) stop("i need a tag directory to look for streams...")
	if(!file.exists(tag_dir)) stop(tag_dir, ": i don't think that tag directory exists...")
	
	# reminder the user if they excluded summary they might loose some fields.
	streams <- tolower(streams)
	
	if(!is.na(streams)) {
		if(!("summary" %in% streams)) {
			warning("you don't seem to want the summary stream. note that load_tag expects *-Summary.csv to populate some of the sattag metadata")
		} else if(!("labels" %in% streams)) {
			warning("you don't seem to want the labels stream. note that load_tag expects *-Labels.csv to populate some of the sattag metadata.")
		}
	}
	
	# grab all the file names and look for csv data streams
	tfnames <- list.files(tag_dir)
	iscsv <- grepl("*.csv$", tfnames)
	
	# throw an error if you didn't find any csvs
	if(!any(iscsv)) stop(tag_dir, ": i didn't find any csv files in this directory...")
	
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
		desestreams <- stream_names %in% streams
		if(!any(desestreams)) stop(paste(streams, collapse = ", "), ": i could not find any of these streams...")
		
		# subsample both stream names and paths
		csvfpaths <- csvfpaths[desestreams]
		stream_names <- stream_names[desestreams]
	}
	
	# these are going to be the sattagstream
	outdata <- list()
	
	# metadata for sattag
	instrument 	<- character()
	location 	<- character()
	species 	<- character()
	DeployID 	<- character()
	Ptt 		<- character()
	t_start 	<- numeric()
	t_end 		<- numeric()
	directory 	<- character()
	
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
			
			# populate some metadata from labels if we haven't been here before
			if(length(instrument) > 0 | length(location) > 0 | length(species)) {
				warning("it appears there are multiple *-Labels.csv files in this directory. using the first one to populate meta data...")
			} else {
				instrument 	<- labels$V2[labels$V1 == "TagType"]
				location 	<- labels$V2[labels$V1 == "Locality"]
				species 	<- labels$V2[labels$V1 == "Species"]
			}
			
			tmpstream <- labels
		} else if(stream_names[s] == "summary") {
			summarystream <- rcsv(path)
			
			# populate some metadata from summary if we haven't been here before
			if(length(DeployID) > 0 | length(Ptt) > 0 | length(t_start) > 0 | length(t_end) > 0) {
				warning("it appears there are multiple *-Summary.csv files in this directory. using the first one to populate meta data...")
			} else {
				DeployID 	<- summarystream$DeployID[1]
				Ptt 		<- as.character(summarystream$Ptt[1])
				t_start 	<- date2num(summarystream$EarliestDataTime[1])
				t_end 		<- date2num(summarystream$LatestDataTime[1])
			}
			
			tmpstream <- summarystream
			
		} else {
			tmpstream <- rcsv(path)
		}
		
		# make a new stream object of the correct class
		tmpdata <- sattagstream(stream_names[s], tmpstream, filename = csvfnames[s])
		# convert times to numeric appropraitely
		tmpdata <- date2num(tmpdata)
		
		# save to the list
		outdata[[s]] <- tmpdata
				},	# end try block / start catch
				error = function(err) {
					# remove the stream name from the list if it didn't work
					stream_names <- stream_names[-s]
					message(paste0(csvfpaths[s], ": ", err))
				}, finally = {})
#				warning = function(war) {
#					message(paste0(csvfpaths[s], ": ", war))
#				}, finally = {}) # end catch
	}
	
	names(outdata) <- stream_names

	# build a sattag object	
	sattag(outdata, instrument = instrument, DeployID = DeployID, Ptt = Ptt, species = species, location = location, t_start = t_start, t_end = t_end, directory = directory)
}
