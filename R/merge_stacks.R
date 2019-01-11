#' merge tagstacks
#' 
#' sensibily merge two tagstacks together with overlapping sets of tags
#' @param s1 a tagstack, the target stack
#' @param s2 a tagstack, the source stack
#' @param by the name of the \code{sattag} slot to base the merge on. Probably should be \code{"Ptt"} or \code{"DeployID"}. Defaults to \code{"Ptt"}.
#' @param retain_duplicates a boolean defaults to FALSE. If TRUE, duplicated rows of data will be retained in the output tagstack.
#' @param identify_source a boolean defaults to FALSE. If TRUE, a character 'source' column will be added to each sattag stream indicating the origin of each row with a character identifier specified by lab1 or lab2.
#' @param lab1 a string to identify data that came from the target tagstack.
#' @param lab2 a string to identify data that came from the source tagstack.
#' @return an S4 object of class \code{\link[sattagutils]{tagstack}}.
#' @export

merge_stacks <- function(s1, s2, by = "Ptt", retain_duplicaes = FALSE, identify_source = FALSE, lab1 = "target", lab2 = "source") {
  
}