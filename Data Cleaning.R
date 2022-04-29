### Preamble ####
#Purpose: The purpose of this code is to clean up the data obtained from Toronto Police Open data. 
#Author: Chyna Hui 
#Date: 20 April 2022
#Contact: chyna.hui@mail.utoronto.ca


### Workplace Setup ###
#load in required packages 
library("tidyverse")
library("dplyr")
library('ggplot2')
library('knitr')
library('kableExtra')
library('lubridate')
library('stringr')
library('float')
library('data.table')
library('lubridate')


# Set working directory
 #Load in raw data for Police Apprehensions
 Apprehensions_raw.csv <-
   raw_dat <- readr::read_csv("inputs/data/Apprehensions_raw.csv")
 
 ### Isolating data by Year ###
 clean_dat <-
   raw_dat |>
   filter(ReportYear %in% c(2018, 2019, 2020)) |>
   select(ReportYear, NeighbourhoodName, Sex, AgeGroup, PremisesType, ApprehensionType)|>
   rename(
     "Year"= ReportYear,
     "Neighborhood"= NeighbourhoodName,
     "Age"= AgeGroup
   )
 save(clean_dat,file="outputs/rda/clean_dat.rda")
 
 ### Create new dataframe isolating the number of Apprehensions per year ### 
 apprehension_count <-
   table(clean_dat$Year)

save(apprehension_count, file = "outputs/rda/apprehension_count.rda")
  
### Create dataframe for Apprehension Graph 
year<- c("2018", "2019", "2020")

number_of_apprehensions <- c(10588, 11168, 11707)

app_graph_frame <- data.frame(year, number_of_apprehensions)

save(app_graph_frame, file = ('outputs/rda/app_graph_frame.rda'))

 
 ### Load raw data for Crisis Calls ###
 Persons_in_Crisis_Calls.csv <-
   raw_crisis_calls <- readr:: read_csv('inputs/data/Persons_in_Crisis_Calls.csv')
 as.data.frame('raw_crisis_calls')
 fread("inputs/data/Persons_in_Crisis_Calls.csv")
 
 ### Isolating data ###
 clean_crisis_calls <-
   raw_crisis_calls |>
   filter(EventYear %in% c(2018, 2019, 2020)) |>
   select(EventYear, EventType, NeighbourhoodName, ApprehensionMade)|>
   rename(
     "Year"=EventYear,
     "Type"=EventType,
     "Neighborhood"=NeighbourhoodName,
     "Apprehension_Made"=ApprehensionMade
   )

save(clean_crisis_calls, file="outputs/rda/clean_crisis_calls.rda")

### Create new dataframe isolating the number of Crisis Calls per year ###
crisis_call_count <-
  table(clean_crisis_calls$Year)

save(crisis_call_count, file = "outputs/rda/crisis_call_count.rda")

### Create new dataframe isolating 2020 data ### 
clean_crisis_calls_2020 <-
  raw_crisis_calls |>
  filter(EventYear %in% c(2020))|>
  select(EventYear, EventType)|>
  rename(
    "Year"=EventYear,
    "Type"=EventType,
  )
save(clean_crisis_calls_2020, file=('outputs/rda/clean_crisis_calls_2020.rda'))

call_type_table <-
  table(clean_crisis_calls$Type)

save(call_type_table, file=('outputs/rda/call_type_table.rda'))



###Create new dataframe isolating 2020 Crisis calls ###
clean_crisis_calls_2020_months <-
  raw_crisis_calls |>
  filter(EventYear %in% c(2020))|>
  select(EventYear, EventMonth)|>
  rename(
    "Year"=EventYear,
    "Month"=EventMonth,
  )
save(clean_crisis_calls_2020_months, file=('outputs/rda/clean_crisis_calls_2020_months.rda'))


calls_table <-
  table(clean_crisis_calls_2020_months$Month)

save(calls_table, file=('outputs/rda/calls_table.rda'))

### Create new dataframe for graph
type_of_call<- c("Overdose", "Person in Crisis", "Suicide-related")

number_of_calls <- c(9789, 53854, 29588)

graph_frame <- data.frame(type_of_call, number_of_calls)

save(graph_frame, file = ('outputs/rda/graph_frame.rda'))





 