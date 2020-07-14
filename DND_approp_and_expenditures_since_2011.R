#Exploring Main Estimates and expenditures and authorities data

library(tidyverse)
library(gtools)
library(ggthemes)
library(rvest)
options(scipen = 999)

#locations of source files on open canada portal, accessed July 2020.  No need to download if accessing from repo.
#url <- "https://open.canada.ca/data/dataset/a35cf382-690c-4221-a971-cf0fd189a46f/resource/3bafde71-8cb8-460e-93e2-691295221063/download/eav_eac_en.csv"
#url2 <- "https://open.canada.ca/data/dataset/a35cf382-690c-4221-a971-cf0fd189a46f/resource/27e54a33-3c39-42a9-8d58-46dd37c527e5/download/eso_eac_en.csv"
#download.file(url, "eav_eac_en.csv")
#download.file(url2, "easo_eac_en.csv")

#exploring Main Estimates and expenditures and authorities by Vote
eav_eac_en <- read_csv("eav_eac_en.csv")
head(eav_eac_en)
dnd_eav_eac <- eav_eac_en %>% filter(org_name == "Department of National Defence")
dnd_eav_eac
dnd_eav_eac <- data.frame(dnd_eav_eac)
class(dnd_eav_eac)

dnd_eav_inmillions <- dnd_eav_eac %>% mutate(authorities_in_mill = (authorities/1000000), expenditures_in_mill = (expenditures/1000000))
head(dnd_eav_inmillions)

dnd_eav_inmillions %>% filter(!is.na(expenditures_in_mill), !is.na(fy_ef), vote_and_statutory == "5") %>%
  ggplot(aes(x=fy_ef)) +
  geom_col(aes(y=expenditures_in_mill)) +
  geom_line(aes(y=authorities_in_mill)) +
  ggtitle("DND Vote 5 Appropriations and Spend ($millions)")+
  theme_economist()
  

dnd_eav_inmillions %>% filter(!is.na(expenditures_in_mill), !is.na(fy_ef), vote_and_statutory == "1") %>%
  ggplot(aes(x=fy_ef)) +
  geom_col(aes(y=expenditures_in_mill)) +
  geom_line(aes(y=authorities_in_mill)) +
  ggtitle("DND Vote 1 Appropriations and Spend ($millions)")+
theme_economist()


#percentage of spend against appropriated dollars
dnd_eav_inmillions <- dnd_eav_inmillions %>% mutate(spend_percent = round(expenditures/authorities, 2))

dnd_eav_inmillions %>% filter(!is.na(expenditures_in_mill), !is.na(fy_ef), vote_and_statutory == "1") %>%
  ggplot(aes(x=fy_ef, y=spend_percent, label=spend_percent)) +
  geom_point() +
  geom_label() +
  ggtitle("DND Vote 1 - Proportion of authorities spent") +
  theme_minimal()

dnd_eav_inmillions %>% filter(!is.na(expenditures_in_mill), !is.na(fy_ef), vote_and_statutory == "5") %>%
  ggplot(aes(x=fy_ef, y=spend_percent, label=spend_percent)) +
  geom_point() +
  geom_label() +
  ggtitle("DND Vote 5 - Proportion of authorities spent")+
  theme_minimal()


#DND expenditure by Standard Object

easo_en <- read_csv("eso_eac_en.csv")
head(easo_en)

dnd_easo <- easo_en %>% filter(org_name == "Department of National Defence")
head(dnd_easo)
class(dnd_easo)

dnd_easo <- data.frame(dnd_easo)
class(dnd_easo)
nrow(dnd_easo)
range(dnd_easo$expenditures)
range(dnd_easo$fy_ef)

dnd_easo %>% group_by(fy_ef) %>% summarize(total_spend = sum(expenditures)) 
#around 20B per year in total spending

dnd_easo %>% group_by(sobj_en) %>% summarise(avg_per_year = sum(expenditures/(2018-2011)))
#shows avg of  standard object spend since 2011.  Personnel clearly number one


#separating out the defence procurement related items - as much as is possible.
dnd_easo %>% filter(sobj_en %in% c("Acquisition of machinery and equipment", "Repair and maintenance", "Rentals")) %>%
  ggplot(aes(x=fy_ef, y=expenditures, col=sobj_en))+
  geom_point()

