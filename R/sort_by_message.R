#' sort behavior streams
#' 
#' sort behavior streams by start time keeping messages together
#' @param beh a beavior sattagstream.
#' @return a behavior sattagstream sorted.
#' @export

sort_by_message <- function(beh) {
  if(streamtype(beh) != "behavior") stop("beh must be a behavior sattagstream...")
  
  msgid <- cumsum(beh$What == "Message")
  nmsg <- length(unique(msgid))
  
  msgorder <- order(beh$Start[beh$What == "Message"])
  runlen <- rle(msgid)$lengths
  
  msgsort <- vector("list", length = nmsg)
  
  k <- 1
  for(i in 1:length(runlen)) {
    st <- k
    k <- k + runlen[i]
    en <- k - 1
    msgsort[[i]] <- st:en
  }
  
  oo <- unlist(msgsort[msgorder])
  beh[oo, ]
}

