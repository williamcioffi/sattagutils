#' load dap output
#' 
#' load a directory of output csv's created by Argos\ Message\ Decoder.exe into a sane tagstack.
#' @param data_dir the directory path to your data
#' @param stream_delim a character which defaults to \code{"-"}. This is what Argos\ Message\ Decoder.exe puts between the tag identifier and the stream name in the csv filenames.
#' @param retain_date_format bool defaults to FALSE. set to TRUE to keep whatever date format the source files are in and not add any additional columns for datenum formatted dates. gets passed to \code{\link[sattagutils]{load_tag}}.
#' @return an S4 object of class \code{\link[sattagutils]{tagstack}}
#' @details This functions expects there to be multiple tags concatenated into the same csv files and so returns a tagstack. This isn't a problem if there is only one tag, but it will since return a tagstack of length of 1. You can always un-nest it later. Basically this function just calls \code{\link[sattagutils]{load_tag}} and then deals with the fallout to get things into a nice tagstack. This function also expects Ptts to be unique, which should be the case for a batch of tags running at the same time, but isn't neccessarily true for all time. Nevertheless, the user can't neccessarily be relied upon to always have \code{DeployID} set so perhaps this is the most reasonable first pass?
#' @export
#' @examples 
#' \dontrun{
#' tag <- load_dap_output("path/to/dap/csvs/")
#' }

load_dap_output <- function(data_dir, stream_delim = '-', retain_date_format = FALSE) {
  
  # check args
  if(!hasArg(data_dir)) stop("I need a data directory to look for tags...")
  
  # load in everything together as a badly formatted sattag
  tmptag <- load_tag(data_dir, stream_delim = stream_delim, retain_date_format = retain_date_format)
  nstreams <- length(tmptag)
  
  # get unique ptts
  #
  # there is a problem in the fastgps file where DAP repeats the header lines 
  # (including the blank lines that appear at the top of this file format for some reason.)
  # this is annoying because I assume it is a mistake and will be fixed some day and when it does
  # all of my code will break...
  u_ptts <- as.character(unique(unlist(lapply(tmptag, '[[', 'Ptt'))))

  # catch any ptts that might be unique in fastgps
  if(has_stream(tmptag, "fastgps")) {
    fastgps <- getstream(tmptag, "fastgps", squash = TRUE)
    
    # test the unique Name and see if they are numerics and put those in potptts
    # oh and i want them to be characters...
    # sorry I crammed too much in a line here
    # also i have to supress warnings because NAs get turned into FALSE which is what I want
    # but makes a warning.
    
suppressWarnings({
    potptts <- as.character(unique(fastgps$Name)[!is.na(as.numeric(unique(fastgps$Name)))])
})
    
    u_ptts <- unique(c(u_ptts, potptts))
  }
  
  # count them up
  nptts <- length(u_ptts)
  
  # i'm going to make an empty nested list representing the data
  # of each sattag. really this is stupid because you should be able to
  # do it with a real tagstack and a real sattags. I think I need to add
  # an add / remove method to sattag to achieve that.
  # at the end i'll loop over this list and make them into real sattags
  # i pre allocated the lists to be the max possible instead of doing
  # something clever so at the end don't forget to drop the NULLs.
  
  outtags <- vector("list", length = nptts)
  names(outtags) <- u_ptts
  
  for(i in 1:length(outtags)) {
    outtags[[i]] <- vector("list", length = nstreams)
    names(outtags[[i]]) <- streamtype(tmptag)
  }
  
  
  # loop through each stream and split it by Ptt.
  # and drop it in the right sattag
  
  for(i in 1:nstreams) {
    s1 <- tmptag[[i]]
    
    # don't forget to catch fastgps which has Name and not Ptt
    # this is kind of rediculous, but not much way about it unless they fix the data format.
    
    if(streamtype(s1) == "fastgps") {
      tmpstreamlist <- split(s1, s1$Name)
      pttcolname <- "Name"
    } else {
      tmpstreamlist <- split(s1, s1$Ptt)
      pttcolname <- "Ptt"
    }
    
    # loop over each and deposit in the right place
    for(n in 1:length(tmpstreamlist)) {
      curptt <- as.character(tmpstreamlist[[n]][1, pttcolname])
      curstream <- streamtype(tmpstreamlist[[n]])
      
      outtags[[curptt]][[curstream]] <- tmpstreamlist[[n]]
    }
  }
  
  # ok now actually put these into sattags
  sattaglist <- vector("list", length = nptts)
  
  for(i in 1:nptts) {
    tagdata <- outtags[[i]]
    names(tagdata) <- names(tmptag)
    tagdata[sapply(tagdata, is.null)] <- NULL
    sattaglist[[i]] <- sattag(tagdata, Ptt = as.character(u_ptts[i]))
  }
  
  # return a tagstack
  tagstack(sattaglist)
}
