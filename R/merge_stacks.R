#' merge tagstacks
#' 
#' sensibily merge two tagstacks together with overlapping sets of tags
#' @param target a tagstack, the target stack
#' @param source a tagstack, the source stack
#' @param by the name of the \code{sattag} slot to base the merge on. Should be \code{"Ptt"} or \code{"DeployID"}. Defaults to \code{"Ptt"}.
#' @param retain_duplicates a boolean defaults to FALSE. If TRUE, duplicated rows of data will be retained in the output tagstack.
#' @param identify_original a boolean defaults to FALSE. If TRUE, a character 'original' column will be added to each sattag stream indicating the origin of each row with a character identifier specified by target_lab or source_lab.
#' @param target_lab a string to identify data that came from the target tagstack.
#' @param source_lab a string to identify data that came from the source tagstack.
#' @return an S4 object of class \code{\link[sattagutils]{tagstack}}.
#' @export

merge_stacks <- function(target_stack, source_stack, by = "Ptt", retain_duplicates = FALSE, identify_original = FALSE, target_lab = "target", source_lab = "source") {
  if(!(by %in% ("Ptt", "DeployID"))) stop("by must be either \'Ptt\' or \'DeployID\'...")
 
  # make a key based on 'by'
  if(by == "Ptt") {
    target_key <- Ptt(target_stack)
    source_key <- Ptt(source_stack)
  } else if(by == 'DeployID') {
    target_key <- DeployID(s1)
    source_key <- DeployID(s2)
  }
  
  # squish things together
  for(i in 1:length(source_key)) {
    # if a tag is in the source but not the target just copy that tag over
    if(!(source_key[i] %in% target_key)) {
      k <- length(target_stack) + 1
      target_stack[[k]] <- source_stack[[i]]
    }
    
    #############################################################
    ######################### START HERE ########################
    #############################################################
    # 1. merge like to like
    # 2. squish in streams that are in source but not target
    # 3. combine streams that are in both source and target
    #    - if retain_duplicates == FALSE delete dups
    #    - if identify_original == TRUE add a column to id where you came from
    
  }
 
  target_stack
}
