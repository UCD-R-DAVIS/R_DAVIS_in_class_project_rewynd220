#Week 4 Challenge 

#Using pipes, subset the surveys data to include individuals collected before 1995 and retain only the columns year, sex, and weight. Name this dataframe surveys_challenge

library(tidyverse)
surveys <- read_csv("data/portal_data_joined.csv")

str(surveys)

surveys_1995 <- surveys %>% 
  filter(year < 1995) %>% 
  select(year, sex, weight)
head(surveys_1995)
