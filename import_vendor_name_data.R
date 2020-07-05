#import of vendor name data from GoC-Spending on Github

#GoC vendor names grouped into "parent companies".  Many unique vendor names were
#data entry errors so having this as ref point should help improve analysis quality.

#vendor_data.csv is subject to the "unlicence".  Github link is as follows:
#https://github.com/GoC-Spending/goc-spending-vendors/blob/master/vendor_data.csv

#I am planning to use this vendor name data to update analysis of contract data.

library(tidyverse)
library(rvest)

url <- "https://raw.githubusercontent.com/GoC-Spending/goc-spending-vendors/master/vendor_data.csv"

download.file(url, "vendor_data.csv")
vendor_data <- read.csv("vendor_data.csv")
view(vendor_data)
save(vendor_data, file ="vendor_data.rda")
