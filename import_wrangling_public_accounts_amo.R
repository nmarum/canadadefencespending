#Public Accts detailed information on acq of machinary and equipment
#data wrangling
library(tidyverse)

url_2020 <- "http://donnees-data.tpsgc-pwgsc.gc.ca/ba1/amo-ame/amo-ame-2020-eng.csv"
url_2019 <- "http://donnees-data.tpsgc-pwgsc.gc.ca/ba1/amo-ame/amo-ame-2019-eng.csv"
url_2018 <- "http://donnees-data.tpsgc-pwgsc.gc.ca/ba1/amo-ame/amo-ame-2018-eng.csv"
url_2017 <- "http://donnees-data.tpsgc-pwgsc.gc.ca/ba1/amo-ame/amo-ame-2017-eng.csv"
url_2016 <- "http://donnees-data.tpsgc-pwgsc.gc.ca/ba1/amo-ame/amo-ame-2016-eng.csv"
url_2015 <- "http://donnees-data.tpsgc-pwgsc.gc.ca/ba1/amo-ame/amo-ame-2015-eng.csv"
url_2014 <- "http://donnees-data.tpsgc-pwgsc.gc.ca/ba1/amo-ame/amo-ame-2014-eng.csv"
url_2013 <- "http://donnees-data.tpsgc-pwgsc.gc.ca/ba1/amo-ame/amo-ame-2013-eng.csv"
url_2012 <- "http://donnees-data.tpsgc-pwgsc.gc.ca/ba1/amo-ame/amo-ame-2012-eng.csv"
url_2011 <- "http://donnees-data.tpsgc-pwgsc.gc.ca/ba1/amo-ame/amo-ame-2011-eng.csv"
url_2010 <- "http://donnees-data.tpsgc-pwgsc.gc.ca/ba1/amo-ame/amo-ame-2010-eng.csv"


download.file(url_2020, "amo_2020.csv")
download.file(url_2019, "amo_2019.csv")
download.file(url_2018, "amo_2018.csv")
download.file(url_2017, "amo_2017.csv")
download.file(url_2016, "amo_2016.csv")
download.file(url_2015, "amo_2015.csv")
download.file(url_2014, "amo_2014.csv")
download.file(url_2013, "amo_2013.csv")
download.file(url_2012, "amo_2012.csv")
download.file(url_2011, "amo_2011.csv")
download.file(url_2010, "amo_2010.csv")

amo_dnd_2020 <- read_csv("amo_2020.csv") %>% filter(DEPT_EN_DESC == "National Defence (Department of)")
amo_dnd_2019 <- read_csv("amo_2019.csv") %>% filter(DEPT_EN_DESC == "National Defence")
amo_dnd_2018 <- read_csv("amo_2018.csv") %>% filter(DEPT_EN_DESC == "National Defence")
amo_dnd_2017 <- read_csv("amo_2017.csv") %>% filter(DEPT_EN_DESC == "National Defence")
amo_dnd_2016 <- read_csv("amo_2016.csv") %>% filter(DEPT_EN_DESC == "National Defence")
amo_dnd_2015 <- read_csv("amo_2015.csv") %>% filter(DEPT_EN_DESC == "National Defence")
amo_dnd_2014 <- read_csv("amo_2014.csv") %>% filter(DEPT_EN_DESC == "National Defence")
amo_dnd_2013 <- read_csv("amo_2013.csv") %>% filter(DEPT_EN_DESC == "National Defence")
amo_dnd_2012 <- read_csv("amo_2012.csv") %>% filter(DEPT_EN_DESC == "National Defence")
amo_dnd_2011 <- read_csv("amo_2011.csv") %>% filter(DEPT_EN_DESC == "National Defence")
amo_dnd_2010 <- read_csv("amo_2010.csv") %>% filter(DEPT_EN_DESC == "National Defence")
head(amo_dnd_2020)
head(amo_dnd_2010)#checking to see if column names match throughout - all good!

amo_2010to2020 <- bind_rows(amo_dnd_2010, amo_dnd_2011)
amo_2010to2020 <- bind_rows(amo_2010to2020, amo_dnd_2012)
amo_2010to2020 <- bind_rows(amo_2010to2020, amo_dnd_2013)
amo_2010to2020 <- bind_rows(amo_2010to2020, amo_dnd_2014)
amo_2010to2020 <- bind_rows(amo_2010to2020, amo_dnd_2015)
amo_2010to2020 <- bind_rows(amo_2010to2020, amo_dnd_2016)
amo_2010to2020 <- bind_rows(amo_2010to2020, amo_dnd_2017)
amo_2010to2020 <- bind_rows(amo_2010to2020, amo_dnd_2018)
amo_2010to2020 <- bind_rows(amo_2010to2020, amo_dnd_2019)
amo_2010to2020 <- bind_rows(amo_2010to2020, amo_dnd_2020)

save(amo_2010to2020, file = "amo_2010to2020.rda")#create RDA file containing the data
file.exists("amo_2010to2020.rda") #check to make sure it was successful
view(amo_2010to2020)

file.remove(c("amo_2020.csv", "amo_2019.csv", "amo_2018.csv", "amo_2017.csv", "amo_2016.csv", "amo_2015.csv", "amo_2014.csv", "amo_2013.csv", "amo_2012.csv", "amo_2011.csv", "amo_2010.csv"))
#clean up complete!