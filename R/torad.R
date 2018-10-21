#' convert degrees to radians
#'
#' @family distance functions
#' @param ang angle in degrees
#' @return angle in radians
#' @export
#' @examples
#' torad(180)

torad <- function(ang) {
	radians <- ang*pi/180
	return(radians)
}