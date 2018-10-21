#' calculate the haversine distance between two geographic coordiantes
#'
#' @family distance functions
#' @param lat1,lon1 start coordinates (can be vectors)
#' @param lat2,lon2 end coordinates (can be vectors)
#' @return distance in kilometers
#' @details uses 6371 as the radius of the earth in kilometers.
#' @references \url{https://www.movable-type.co.uk/scripts/latlong.html}
#' @export
#' @examples
#' latlond.hav(-6.72, 147, -4.67, -174.52)

latlond.hav <- function(lat1, lon1, lat2, lon2) {
	R <- 6371

	dlat <- torad(lat2) - torad(lat1)
	dlon <- torad(lon2) - torad(lon1)

	a = sin(dlat/2) * sin(dlat/2) + cos(torad(lat1)) * cos(torad(lat2)) * sin(dlon/2) * sin(dlon/2)
	c = 2 * atan2(sqrt(a), sqrt(1-a))

	d = R * c

	return(d)
}