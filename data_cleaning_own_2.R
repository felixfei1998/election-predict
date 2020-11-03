#### Preamble ####
# Purpose: Prepare and clean the survey data downloaded from [https://www.voterstudygroup.org/publication/nationscape-data-set]
# Author: "Yuyu Fei, Biqi Jiang, Jiayi Yang, Yuwen Wu
# Data: 2 November 2020
# Contact: 
# License: MIT

#### Workspace setup ####
library(haven)
library(tidyverse)
# Read in the raw data (You might need to change this if you use a different dataset)
raw_data <- read_dta("ns20200625.dta")
# Add the labels
raw_data <- labelled::to_factor(raw_data)
# Just keep some variables
reduced_data <- 
  raw_data %>% 
  select(interest, registration, vote_2016, vote_intention, vote_2020, ideo5, employment,
         foreign_born, gender, census_region, hispanic, race_ethnicity, household_income, education,
         state, congress_district, age)
reduced_data<-
  reduced_data %>%
  mutate(vote_trump = 
           ifelse(vote_2020=="Donald Trump", 1, 0))
write_csv(reduced_data, "survey_data.csv")
