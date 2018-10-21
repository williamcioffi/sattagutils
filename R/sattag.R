#' an S4 class to represent a single sat tag
#'
#' represents a single sat tag. holds a small amount of meta data and a list of data streams.
#'
#' @slot instrument instrument type, e.g., "MK10-A"
#' @slot DeployID character vector (pulled from summary by \code{load_tag})
#' @slot Ptt character vector (pulled from summary stream by \code{load_tag})
#' @slot species character vector (pulled from summary stream by \code{load_tag})
#' @slot location character vector (pulled from summary stream by \code{load_tag})
#' @slot earliestdata,latestdata numeric dates (seconds since UNIX epoch). can either by pulled from summary stream by \code{load_tag} or user updated to represent censoring.
#' @slot nstreams number of different data streams set automatically by \code{load_tag}
#' @slot streams a list of \code{\link[sattagutils]{sattagstream-class}} objects.
#' @slot directory the original directory from which the tag was loaded if set by \code{load_tag}
#' @slot loadtime a character vector set by \code{initialize()} when object is instantiated.
#' @export

setClass("sattag",
	slots = c(
	instrument = "character",
	DeployID = "character",
	Ptt = "character",
	species = "character",
	location = "character",
	earliestdata = "numeric",
	latestdata = "numeric",
	directory = "character",
	loadtime = "character",
	nstreams = "numeric",
	streams = "list"
	)
)
