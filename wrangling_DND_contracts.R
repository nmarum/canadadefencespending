#wrangling open contract data

#slicing out DND contract data since 2015 from large GoC contract dataset
#and joining parent vendor names from Ottawa Civic Tech contract analysis project.

#objective is to make a more useful object for analysis.  Beware, the contracts.csv
#is a large file (about 300MB).  I occasionally had to try a few times before it
#would download for me.  Last run Aug 2020.

library(tidyverse)
library(rvest)
library(textclean)
library(lubridate)

defence_vendor_data <- read_csv("defence_vendor_data.csv") #updated vendor data based on knowledge of defence industry

download.file(url="https://open.canada.ca/data/dataset/d8f85d91-7dec-4fd1-8055-483b77225d8b/resource/fac950c0-00d5-4ec1-a4d3-9cbebf98a305/download/contracts.csv", destfile="contracts.csv")
gov_contracts <- read_csv("contracts.csv", col_types = cols(additional_comments_fr = col_skip(), amendment_value = col_number(), comments_fr = col_skip(), contract_date = col_date(format = "%Y-%m-%d"), contract_period_start = col_date(format = "%Y-%m-%d"), contract_value = col_number(), delivery_date = col_date(format =  "%Y-%m-%d"), description_fr = col_skip(), original_value = col_number()), locale = locale(date_format = "%Y-%m-%d"))

file.remove("contracts.csv")

dnd_contracts <- gov_contracts %>% 
  filter(owner_org == "dnd-mdn") %>% #filter by DND
  mutate(contract_year = format(contract_date, "%Y"), vendor_name = toupper(vendor_name), vendor_name = strip(vendor_name, digit.remove = FALSE, lower.case = FALSE, apostrophe.remove = TRUE), vendor_name = str_replace(vendor_name, "\\s+INC$|\\s+LTD$|\\s+LIMITED$|\\s+LTEE$|\\s+CO$|\\s+CIE$|\\s+ULC$|\\s+CORPORATION$|\\s+LP$|\\s+AG$|\\s+GMBH$|\\s+SA$|\\s+MBH$|\\s+AS$|\\s+LTÉE$|\\s+LLC$", ""))
  #changing vendor_names to upper case to align for joining add a contract 
  #year variable using contract_date

#joining defence vendor parent company column
dnd_contracts <- left_join(dnd_contracts, defence_vendor_data)

#test to show joining worked
dnd_contracts %>% group_by(parent_company) %>%
  summarize(n=n()) %>% arrange(desc(n))

#save file in project folder
save(dnd_contracts, file = "dnd_contracts.rda")
file.exists("dnd_contracts.rda")
