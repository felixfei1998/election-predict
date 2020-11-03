#### Preamble ####
# Purpose: Prepare and clean the survey data downloaded from [https://usa.ipums.org/usa/index.shtml]
# Author: Yuyu Fei, Biqi Jiang, Jiayi Yang, Yuwen Wu
# Data: 2 November 2020
# License: MIT

library(haven); library(tidyverse)
raw_data <- read_dta("usa_00002.dta.gz")
raw_data <- labelled::to_factor(raw_data)

reduced_data <- 
  raw_data %>% 
  select(region,stateicp,sex, age, race,hispan,marst,bpl,citizen,educd,labforce)
reduced_data <- reduced_data %>%    
  mutate(sex = case_when(sex=="male"~"Male",
                         sex=="female"~"Female"))
reduced_data <- reduced_data %>% 
               mutate(state = case_when(stateicp=="alabama"~"AL",
                           stateicp=="alaska"~"AK",
                           stateicp=="arizona"~"AZ",
                           stateicp=="arkansas"~"AR",
                           stateicp=="california"~"CA",
                           stateicp=="colorado"~"CO",
                           stateicp=="connecticut"~"CT",
                           stateicp=="delaware"~"DE",
                           stateicp=="florida"~"FL",
                           stateicp=="district of columbia"~"DC",
                           stateicp=="georgia"~"GA",
                           stateicp=="hawaii"~"HI",
                           stateicp=="idaho"~"ID",
                           stateicp=="illinois"~"IL",
                           stateicp=="indiana"~"IN",
                           stateicp=="iowa"~"IA",
                           stateicp=="kansas"~"KS",
                           stateicp=="kentucky"~"KY",
                           stateicp=="louisiana"~"LA",
                           stateicp=="maine"~"ME",
                           stateicp=="maryland"~"MD",
                           stateicp=="massachusetts"~"MA",
                           stateicp=="michigan"~"MI",
                           stateicp=="minnesota"~"MN",
                           stateicp=="mississippi"~"MS",
                           stateicp=="missouri"~"MO",
                           stateicp=="montana"~"MT",
                           stateicp=="nebraska"~"NE",
                           stateicp=="nevada"~"NV",
                           stateicp=="new hampshire"~"NH",
                           stateicp=="new jersey"~"NJ",
                           stateicp=="new mexico"~"NM",
                           stateicp=="new york"~"NY",
                           stateicp=="north carolina"~"NC",
                           stateicp=="north dakota"~"ND",
                           stateicp=="ohio"~"OH",
                           stateicp=="oklahoma"~"OK",
                           stateicp=="oregon"~"OR",
                           stateicp=="pennsylvania"~"PA",
                           stateicp=="rhode island"~"RI",
                           stateicp=="south carolina"~"SC",
                           stateicp=="south dakota"~"SD",
                           stateicp=="tennessee"~"TN",
                           stateicp=="texas"~"TX",
                           stateicp=="utah"~"UT",
                           stateicp=="vermont"~"VT",
                           stateicp=="virginia"~"VA",
                           stateicp=="washington"~"WA",
                           stateicp=="west virginia"~"WV",
                           stateicp=="wisconsin"~"WI",
                           stateicp=="wyoming"~"WY"))
reduced_data <- reduced_data %>% 
         mutate(race = case_when(race == "white"~"White",
                          race=="black/african american/negro"~"Black",
                          race=="other race, nec"~"Other",
                          race=="other asian or pacific islander"~"Pacific",
                          race=="japanese"~"Asian",
                          race=="chinese"~"Asian",
                          race=="american indian or alaska native"~"Native",
                          race=="two major races"~"Mix",
                          race=="three or more major races"~"Mix"))
# create cells
reduced_data <- 
  reduced_data %>%
  count(age, sex, state, race) %>%
  group_by(age, sex, state, race) 

# more data cleaning
reduced_data <- 
  reduced_data %>% 
  filter(age != "less than 1 year old") %>%
  filter(age != "90 (90+ in 1980 and 1990)")

reduced_data$age <- as.integer(reduced_data$age)

# write CSV file
write_csv(reduced_data, "census_data.csv")



         