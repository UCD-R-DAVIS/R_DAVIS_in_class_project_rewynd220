#Week 4 Challenge 

#Using pipes, subset the surveys data to include individuals collected before 1995 and retain only the columns year, sex, and weight. Name this dataframe surveys_challenge

library(tidyverse)
surveys <- read_csv("data/portal_data_joined.csv")

str(surveys)

surveys_1995 <- surveys %>% 
  filter(year < 1995) %>% 
  select(year, sex, weight)
head(surveys_1995)

#Create a new data frame from the surveys data that meets the following criteria: contains only the species_id column and a new column called hindfoot_half containing values that are half the hindfoot_length values. In this hindfoot_half column, there are no NAs and all values are less than 30. Name this data frame surveys_hindfoot_half.

#Hint: think about how the commands should be ordered to produce this data frame!
  
surveys_hindfoot_half <- surveys %>% 
  mutate(hindfoot_half = hindfoot_length/2) %>% 
  filter(!is.na(hindfoot_half), hindfoot_half<30) %>% 
  select(species_id, hindfoot_half) 

head(surveys_hindfoot_half)  

#What was the weight of the heaviest animal measured in each year? Return a table with three columns: year, weight of the heaviest animal in grams, and weight in kilograms, arranged (arrange()) in descending order, from heaviest to lightest. (This table should have 26 rows, one for each year)



#Try out a new function, count(). Group the data by sex and pipe the grouped data into the count() function. How could you get the same result using group_by() and summarize()? Hint: see ?n.


