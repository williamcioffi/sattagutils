#' merge tagstacks
#' 
#' sensibily merge two tagstacks together with overlapping sets of tags
#' @param target a tagstack, the target stack
#' @param source a tagstack, the source stack
#' @param by the name of the \code{sattag} slot to base the merge on. Should be \code{"Ptt"} or \code{"DeployID"}. Defaults to \code{"Ptt"}.
#' @param remove_duplicates a boolean defaults to FALSE. If TRUE, duplicated rows of data will be retained in the output tagstack.
#' @param identify_original a boolean defaults to FALSE. If TRUE, a character 'original' column will be added to each sattag stream indicating the origin of each row with a character identifier specified by target_lab or source_lab.
#' @param target_lab a string to identify data that came from the target tagstack.
#' @param source_lab a string to identify data that came from the source tagstack.
#' @return an S4 object of class \code{\link[sattagutils]{tagstack}}.
#' @export

merge_stacks <- function(target_stack, source_stack, by = "Ptt", remove_duplicates = FALSE, identify_original = FALSE, target_lab = "target", source_lab = "source") {
  if(!(by %in% c("Ptt", "DeployID"))) stop("by must be either \'Ptt\' or \'DeployID\'...")
 
  # make a key based on 'by'
  if(by == "Ptt") {
    target_key <- Ptt(target_stack)
    source_key <- Ptt(source_stack)
  } else if(by == 'DeployID') {
    target_key <- DeployID(target_stack)
    source_key <- DeployID(source_stack)
  }
  
  # squish things together
  for(i in 1:length(source_key)) {
    # if a tag is in the source but not the target just copy that tag over
    if(!(source_key[i] %in% target_key)) {
      k <- length(target_stack) + 1
      target_stack[[k]] <- source_stack[[i]]
    } else {
      cur_src <- source_stack[[i]]
      cur_tar_index <- which(target_key == source_key[i])
      
      # right now just fail if there is more than one tag that matches because maybe they didn't
      # want to do that. could just loop over them and do the same to each also
      if(length(cur_tar_index) > 1) stop(paste(source_key[i], "matching more than one tag in target..."))
      
      # go stream by stream
      for(n in 1:length(cur_src)) {
        # if a stream is in the source but not the target just copy that stream over
        src_streamtype <- streamtype(cur_src[[n]])
        if(!(src_streamtype %in% streamtype(target_stack[[cur_tar_index]]))) {
          k <- length(target_stack) + 1
          target_stack[[cur_tar_index]][[k]] <- cur_src[[n]]
        } else {
          tar_stream_matches <- which(streamtype(target_stack[[cur_tar_index]]) == src_streamtype)
          
          # do the same to each of the matches
          for(p in 1:length(tar_stream_matches)) {
            tar_stream <- target_stack[[cur_tar_index]][[tar_stream_matches[p]]]
            src_stream <- cur_src[[n]]
            
            # add original column
            if(identify_original) {
              tar_stream[, 'original'] <- target_lab
              src_stream[, 'original'] <- source_lab
            }
            
            # make a new sattagstream object
            # with the combined stream
            combined_stream_tmp <- sattagstream(
              data = rbind(tar_stream, src_stream),
              type = streamtype(tar_stream),
              filename = c(tar_stream@filename, src_stream@filename)
            )
            
            # remove duplicates
            if(remove_duplicates) {
              dups <- duplicated_sattagstream(combined_stream_tmp)
              combined_stream_tmp <- combined_stream_tmp[!dups, ]
            }
            
            # copy the stream back into the right place in the target stack
            target_stack[[cur_tar_index]][[tar_stream_matches[p]]] <- combined_stream_tmp
          }
        }
      }
    }
  }
  
  target_stack
}
