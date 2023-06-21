#Exploring Main Estimates and expenditures and authorities data

library(tidyverse)
library(gtools)
library(ggthemes)
library(rvest)
library(lubridate)
options(scipen = 999)

#locations of source files on open canada portal.  The script will download the files directly from the portal.

#exploring Main Estimates and expenditures and authorities by Vote
eav_eac_en <- read_csv("https://open.canada.ca/data/dataset/a35cf382-690c-4221-a971-cf0fd189a46f/resource/3bafde71-8cb8-460e-93e2-691295221063/download/eav_eac_en.csv")
head(eav_eac_en)
dnd_eav_eac <- eav_eac_en %>% filter(org_name == "Department of National Defence")
dnd_eav_eac
dnd_eav_eac <- data.frame(dnd_eav_eac)
class(dnd_eav_eac)

dnd_eav_inmillions <- dnd_eav_eac |>
  mutate(authorities_in_mill = as.numeric(authorities)/1000000,
         expenditures_in_mill = as.numeric(expenditures)/1000000)

head(dnd_eav_inmillions)

dnd_eav_inmillions |>
  filter(!is.na(expenditures_in_mill),
         !is.na(authorities_in_mill),
         !is.na(fy_ef),
         vote_and_statutory == "5") |>
  ggplot(aes(x=fy_ef)) +
  geom_point(aes(y=authorities_in_mill), size=3, col="red") +
  geom_col(aes(y=expenditures_in_mill)) +
  xlab("Fiscal Year") +
  ylab("$ in Millions")+
  scale_y_continuous() +
  ggtitle("DND Vote 5 Appropriations and Spend ($millions)")+
  theme_minimal()
  

dnd_eav_inmillions |>
  filter(!is.na(expenditures_in_mill),
         !is.na(fy_ef),
         vote_and_statutory == "1") |>
  ggplot(aes(x=fy_ef)) +
  geom_point(aes(y=authorities_in_mill), size=3, col="red") +
  geom_col(aes(y=expenditures_in_mill)) +
  xlab("Fiscal Year") +
  ylab("$ in Millions")+
  scale_y_continuous() +
  ggtitle("DND Vote 1 Appropriations and Spend ($millions)")+
  theme_minimal()


#percentage of spend against appropriated dollars
dnd_eav_inmillions <- dnd_eav_inmillions |>
  mutate(spend_percent = round(as.numeric(expenditures)/as.numeric(authorities), 2))

dnd_eav_inmillions |>
  filter(!is.na(expenditures_in_mill),
         !is.na(fy_ef), vote_and_statutory == "1") |>
  ggplot(aes(x=fy_ef, y=spend_percent, label=spend_percent*100)) +
  geom_point() +
  geom_label() +
  ylab("Percentage")+
  xlab("Fiscal Year")+
  ggtitle("DND Vote 1 - Proportion of authorities spent") +
  theme_minimal()

dnd_eav_inmillions |>
  filter(!is.na(expenditures_in_mill),
         !is.na(fy_ef), vote_and_statutory == "5") |>
  ggplot(aes(x=fy_ef, y=spend_percent, label=spend_percent*100)) +
  geom_point() +
  geom_label() +
  ylab("Percentage")+
  xlab("Fiscal Year")+
  ggtitle("DND Vote 5 - Proportion of authorities spent")+
  theme_minimal()


#DND expenditure by Standard Object

easo_en <- read_csv("https://open.canada.ca/data/dataset/a35cf382-690c-4221-a971-cf0fd189a46f/resource/27e54a33-3c39-42a9-8d58-46dd37c527e5/download/eso_eac_en.csv")
head(easo_en)

dnd_easo <- easo_en |>
  filter(org_name == "Department of National Defence")

head(dnd_easo)
class(dnd_easo)

dnd_easo <- data.frame(dnd_easo)
class(dnd_easo)
nrow(dnd_easo)
range(dnd_easo$expenditures)
range(dnd_easo$fy_ef)

dnd_easo %>% group_by(fy_ef) |>
  summarize(total_spend = sum(as.numeric(expenditures))) 
#around 20B per year in total spending

dnd_easo %>% group_by(sobj_en) |>
  summarise(avg_per_year = sum(as.numeric(expenditures)/length(unique(fy_ef)))) |>
  arrange(desc(avg_per_year))
#shows avg of  standard object spend since 2011.  Personnel clearly number one


#separating out the defence procurement related items - as much as is possible.
dnd_easo |>
  filter(sobj_en %in% c("Acquisition of machinery and equipment",
                        "Repair and maintenance", "Rentals")) |>
  mutate(expenditures_in_millions = expenditures/1000000) |>
  ggplot(aes(x=as.character(fy_ef), y=expenditures_in_millions, col=sobj_en))+
  geom_point(size=4) +
  xlab("FY") +
  ggtitle("Canada's Public Accounts - Key DND Expenditures ($millions) by Standard Object")+
  theme_minimal()

