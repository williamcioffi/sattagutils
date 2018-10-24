# test package

library(devtools)
library(roxygen2)

setwd("~/git/sattagutils")

document()
document()

install(".")

library(sattagutils)

t1 <- load_tag("~/Desktop/0_CURRENT_backedup20181016/12_BRS/4_WC_DOWNLOADS_FALL18/FALL18_FINAL_DOWNLOAD_20181010/171946/")

t1
# # # if you have to go line by line
# tag_dir <- "~/Desktop/0_CURRENT_backedup20181016/12_BRS/4_WC_DOWNLOADS_FALL18/FALL18_FINAL_DOWNLOAD_20181010/171946/"
# stream <- NA
