#' @include sattagstream.R
NULL

#' downsample series data to faux behavior data
#' 
#' a simple downsampling which takes series data stream as an input and creates an estimate of what the behavior stream would have looked like. tries to interpolate surfacing times for more accurate duration estimates.
#' @param s a series data stream or a dataframe approximating one. requires columns numeric \code{Date}, numeric \code{Depth}.
#' @param surface_threshold_metersused by the peak finding algorithm to determine if a peak is close enough to the surface to represent a real surfacing event. default 25 is for me. you will need ot pick something that makes sense for your species.
#' @param vrate_ascent_meters_per_second, vrate_decent_meters_per_second these are the vertical ascent and decent rates used to interpolate surfacing times. defaults are for Ziphius cavirostris (see notes). 
#' @param dive_definition_threshold_meters would be from the behavior settings you want to emulate. this is the threshold to qualify as a behavior dive.
#' @param period sampling period of input series data
#' @note i've set the vertical ascent and decent rates the same for Ziphius cavirostris (1.4 m/s). This is based on some experimentationwith known surfacings from behavior data, vertical rates from series data, and analysis of dtags by Tyack et al. (2006). Though the ascent rates are much slower for Z. cavirostris after deep dives than the decent rates, there is actually no difference in the last several hundred meters and the rate is much faster.
#' @references Tyack, P. L., Johnson, M., Soto, N. A., Sturlese, A., & Madsen, P. T. (2006). Extreme diving of beaked whales. Journal of Experimental Biology, 209(21), 4238–4253. https://doi.org/10.1242/jeb.02505
#' @export

ser2beh <- function(
	s,
	surface_threshold_meters = 25, 
	vrate_ascent_meters_per_second = 1.4,
	vrate_decent_meters_per_second = 1.4,
	dive_definition_threshold_meters = 50,
	period
) {
	
	
	# error checking
	if(is.sattagstream(s) & streamtype(s) != "stream_series") {
		stop("if you're gonna use a sattagstream it's gotta be a series...")
	}		
	
	###
	# x-intercept function
	#
	xint <- function(i, direction = "forward") {
		increment <- i+1
		VR <- -VRATE_ASCENT
		if(direction == "reverse") {
			increment <- i-1
			VR <- VRATE_DECENT
		}
		yint <- d[increment] - VR * tt[increment]
		-yint / VR
	}
	
	# constants
	
	PERIOD <- period # seconds
	# SURFACE_THRESHOLD_METERS is used by the peak finding algorithm
	# used to determine if a peak is close enough to the surface
	# to represent a real surfacing event
	SURFACE_THRESHOLD_METERS <- surface_threshold_meters
	VRATE_ASCENT <- vrate_ascent_meters_per_second
	VRATE_DECENT <- vrate_decent_meters_per_second
	
	# This is the behavior dive defintion threshold which determines
	# whether a wet/dry determined dive should be processed and saved
	# i.e., if it qualifies as a dive. this should be derived from the settings
	# you want to emulate.
	DIVE_DEFINITION_THRESHOLD_METERS <- dive_definition_threshold_meters
	
	###
	# find peaks
	
	# take the sign of the derivitive
	depdiffvec <- diff(s$Depth)
	
	depdiff <- sign(depdiffvec)
	depdiff <- c(0, depdiff) # add a dummy for the first point
	
	depdiffvec <- c(0, depdiffvec)
	vrates_1 <- depdiffvec[1:(length(depdiffvec)-1)] / PERIOD
	vrates_2 <- depdiffvec[2:length(depdiffvec)] / PERIOD
	
	# create two vectors: t, and t+1
	depdiff_1 <- depdiff[1:(length(depdiff)-1)]
	depdiff_2 <- depdiff[2:length(depdiff)]
	
	# find the peaks (single points nearest the surface)
	# where f'(t) < 0 and f'(t+1) > 0
	# remove peaks that are greater than SURFACE_THRESHOLD_METERS
	surf_pt <- depdiff_1 == -1 & depdiff_2 == 1 & s$Depth[-nrow(s)] < SURFACE_THRESHOLD_METERS
	
	# look for shallow peaks right before deep dives
	# and combine with the regular peaks
	surf_pt2 <- !surf_pt & depdiff_1 == -1 & depdiff_2 == 1 & abs(vrates_2) > abs(vrates_1)
	
	surf_pt <- surf_pt | surf_pt2	
	# catch the surfacings that are long enough at the surface to get flat
	# where f'(t+1) == 0
	# again make sure we are shallow enough to be a likely surface event
	surf_st <- depdiff_1 == -1 & depdiff_2 == 0 & s$Depth[-nrow(s)] < SURFACE_THRESHOLD_METERS
	surf_en <- depdiff_1 == 0 & depdiff_2 ==  1 & s$Depth[-nrow(s)] < SURFACE_THRESHOLD_METERS
	
	# take a look
	plot(s$Date, -s$Depth, pch = 16, cex = .5, axes = FALSE)
	lines(s$Date, -s$Depth)
	abline(v = s$Date[surf_pt], lty = 2, col = "grey50")
	abline(v = s$Date[surf_st], lty = 2, col = "green")
	abline(v = s$Date[surf_en], lty = 2, col = "purple")

	###
	# helper functions for the menu
	#add a peak
	addapeak <- function(surf_pt) {
		pts <- locator()
					
		xx <- pts$x
		# add these
		for(q in 1:length(xx)) {
			dis <- which.min(abs(s$Date - xx[q]))
			surf_pt[dis] <- TRUE
			abline(v = s$Date[dis], lty = 1, col = "black")
		}
		
		surf_pt
	}
	
	# destory a peak
	destroyapeak <- function(surf_pt, surf_st, surf_en) {
		pts <- locator()
					
		xx <- pts$x
		#remove these
		add_these <- vector()
		for(q in 1:length(xx)) {
			dis <- which.min(abs(s$Date - xx))
			surf_pt[dis] <- FALSE
			surf_st[dis] <- FALSE
			surf_en[dis] <- FALSE
			abline(v = s$Date[dis], lty = 2, col = "red")
		}
		
		list(surf_pt = surf_pt, surf_st = surf_st, surf_en = surf_en)
	}
	# end: helper functions for the menu
	###

	###
	# menu
	choice <- 4
	while(choice != 3) {
		choice <- menu(c("add a peak", "destroy a peak", "done"))
		
		if(choice == 1) {
			surf_pt <- addapeak(surf_pt)
		} else if(choice == 2) {
			surfl <- destroyapeak(surf_pt, surf_st, surf_en)
			surf_pt <- surfl$surf_pt
			surf_st <- surfl$surf_st
			surf_en <- surfl$surf_en
		}
	}
	# end: menu
	###	
	
	###
	# extrapolate to surface time
	d <- -s$Depth
	tt <- s$Date
	
	surfst_extrap <- vector()
	surfen_extrap <- vector()
	
	# flat surfacing starts
	surf_st <- which(surf_st)
	if(length(surf_st) > 0) {
		surfst_times <- xint(surf_st, direction = "reverse")
		surfst_extrap  <- c(surfst_extrap, surfst_times)
		
points(surfst_times, rep(0, length(surf_st)), col = "green", cex = .75)
	}
	
	# flat surfacing ends
	surf_en <- which(surf_en)
	if(length(surf_en) > 0) {
		surfen_times <- xint(surf_en, direction = "forward")
		surfen_extrap <- c(surfen_extrap, surfen_times)
		
points(surfen_times, rep(0, length(surf_en)), col = "purple", cex = .75)
	}
	
	# peaks
	surf_pt <- which(surf_pt)
	if(length(surf_pt) > 0) {
		surfptst_times <- xint(surf_pt, direction = "reverse")
		surfpten_times <- xint(surf_pt, direction = "forward")
		
		surfst_extrap <- c(surfst_extrap, surfptst_times)
		surfen_extrap <- c(surfen_extrap, surfpten_times)
		
points(surfptst_times, rep(0, length(surf_pt)), col = "green", cex = .75, pch = 2)
points(surfpten_times, rep(0, length(surf_pt)), col = "purple", cex = .75, pch = 2)
	}
	
ans <- readline("press return to continue")
	
	###
	# construct a faux behavior stream
	
	# make tmp dataframe of surf starts and ends for processing
	surfs <- data.frame(t = c(surfst_extrap, surfen_extrap), what = c(rep("surfst", length(surfst_extrap)), rep("surfen", length(surfen_extrap))))
	beh_extrap <- NULL
	
	if(nrow(surfs) > 0) {	
		# make a key for the order
		surfskey <- c(surf_st, surf_pt, surf_en, surf_pt)
		oo <- order(surfskey)
		
		# sort surfs
		surfs <- surfs[oo, ]
		
		# make a data frame to hold the resultant faux behavior
		beh_extrap <- data.frame(DeployID = vector(), Ptt = vector(), Start = vector(), End = vector(), What = vector(), Shape = vector(), DepthMin = vector(), DepthMax = vector(), DurationMin = vector(), DurationMax = vector())
		
		blankrow <- data.frame(DeployID = NA, Ptt = NA, Start = NA, End = NA, What = NA, Shape = NA, DepthMin = NA, DepthMax = NA, DurationMin = NA, DurationMax = NA)
		
		# running count of the beh_extrap row
		k <- 1
		
		# first iteration is different
		i <- 1
		
		beh_extrap <- rbind(beh_extrap, blankrow)
			
		if(surfs$what[i] == "surfst") {
			beh_extrap$What[k] <- "Dive"
			beh_extrap$End[k] <- surfs$t[i]
			
			k <- k + 1
			beh_extrap <- rbind(beh_extrap, blankrow)
				
			beh_extrap$What[k] <- "Surface"
			beh_extrap$Start[k] <- surfs$t[i]
		} else {
			beh_extrap$What[k] <- "Surface"
			beh_extrap$End[k] <- surfs$t[i]
			
			k <- k + 1
			beh_extrap <- rbind(beh_extrap, blankrow)
				
			beh_extrap$What[k] <- "Dive"
			beh_extrap$Start[k] <- surfs$t[i]
		}
		# END: first interation
		
		# for loop only if there is anything to loop
		if(nrow(surfs) > 1) {
			for(i in 2:nrow(surfs)) {
				beh_extrap$End[k] <- surfs$t[i]
				
				k <- k + 1
				beh_extrap <- rbind(beh_extrap, blankrow)
						
				if(surfs$what[i] == "surfst") {
					beh_extrap$What[k] <- "Surface"
					beh_extrap$Start[k] <- surfs$t[i]
				} else {
					beh_extrap$What[k] <- "Dive"
					beh_extrap$Start[k] <- surfs$t[i]
				}
			}
		}
		
		# trim incomplete rows
		beh_extrap <- beh_extrap[complete.cases(beh_extrap[, c('Start', 'End')]), ]
		
		# here's an exit point if trimming has removed everything
		if(nrow(beh_extrap) == 0) {
			warning("no extractable dives")
			return(NULL)
		}
		
		# create one big message (why not?)
		msg_st <- beh_extrap$Start[1]
		msg_en <- beh_extrap$End[nrow(beh_extrap)]
		
		beh_extrap <- rbind(blankrow, beh_extrap)
		beh_extrap$What[1] <- "Message"
		beh_extrap$Start[1] <- msg_st
		beh_extrap$End[1] <- msg_en
		
		# fill in Duration
		beh_extrap$DurationMin <- beh_extrap$End - beh_extrap$Start
		beh_extrap$DurationMax <- beh_extrap$End - beh_extrap$Start
		
		
# # add a column for the simple shape calculation
# beh_extrap[, 'Shape2'] <- NA	
		
		# calculate DepthMin and DepthMax and Shape
		for(i in 1:nrow(beh_extrap)) {
			if(beh_extrap$What[i] == "Dive") {
				st <- beh_extrap$Start[i]
				en <- beh_extrap$End[i]
				
				dese <- s$Date >= st & s$Date <= en
				curs <- s[dese, ]
				
				dismax <- which.max(curs$Depth)
				beh_extrap$DepthMax[i] <- curs$Depth[dismax] + curs$DRange[dismax]
				beh_extrap$DepthMin[i] <- curs$Depth[dismax] - curs$DRange[dismax]
				
				
				# consider extending the shape algorithm to include extrapolated surface time and resample to 1 hz?
				tt <- c(st, curs$Date, en)
				dep <- c(0, curs$Depth, 0)
				intdep <- approx(tt, dep, n = tt[length(tt)]-tt[1])$y
				
				shp <- ""	
				depth80perc <- max(intdep) * 0.80
				npts <- length(intdep)
				
				n_ge_80perc <- length(which(intdep >= depth80perc))
				p80 <- n_ge_80perc / npts
				
				if(p80 > 0.50) shp <- "Square"
				if(p80 > 0.20 & p80 <= 0.50) shp <- "U"
				if(p80 <= 0.20) shp <- "V"
				
				beh_extrap$Shape[i] <- shp		
# ###
# # simple shape comparison to see if it matters		
		# shp2 <- ""	
		# depth80perc <- max(curs$Depth) * 0.80
		# npts <- nrow(curs)
		
		# n_ge_80perc <- length(which(curs$Depth >= depth80perc))
		# p80 <- n_ge_80perc / npts
		
		# if(p80 > 0.50) shp2 <- "Square"
		# if(p80 > 0.20 & p80 <= 0.50) shp2 <- "U"
		# if(p80 <= 0.20) shp2 <- "V"
		# beh_extrap$Shape2[i] <- shp2
# # END: simple shape calculation comparison
# ###	
			}
		}
	} else {
		warning("no extractable dives")
	}
	
	fname <- NULL
	if(is.sattagstream(s)) fname <- filename(s)
	beh_extrap$Ptt <- s$Ptt[1]
	beh_extrap$DeployID <- s$DeployID[1]
	
	sattagstream("behavior", beh_extrap, filename = fname)
}

