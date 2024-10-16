#Learning dplyr and tidyr: select, filter, and pipes ----
#only do this once ever:
install.packages("tidyverse")
#We've learned bracket subsetting
#It can be hard to read and prone to error
#dplyr is great for data table manipulation!
#tidyr helps you switch between data formats

#Packages in R are collections of additional functions
#tidyverse is an "umbrella package" that
#includes several packages we'll use this quarter:
#tidyr, dplyr, ggplot2, tibble, etc.

#benefits of tidyverse
#1. Predictable results (base R functionality can vary by data type) 
#2. Good for new learners, because syntax is consistent. 
#3. Avoids hidden arguments and default settings of base R functions

#To load the package type:
library(tidyverse)
#now let's work with a survey dataset
surveys <- read_csv("data/portal_data_joined.csv")

##looking at surveys ----
view(surveys) #loads in new window 
str(surveys) # $ is a column 

##select columns ----
month_day_year<-select(surveys, month, day, year) #first enter object name, then enter columns you want to select 

##filtering to meet logical criteria ----
#filtering by equals 
filter(surveys, year == 1981) #only want to keep entries that have the year 1981 
#if we want to manipulate this dataset and do stuff with it, we have to create a new variable 
year_1981<-filter(surveys, year == 1981) #can't name an object starting with number 

#filtering by range 
filter(surveys, year %in% c(1981:1983))
#the function %in% is a bucket search - out of all observations in the dataset, anything that has those years will be selected 

#review: why you should NEVER do this to select 1981-1983
filter(surveys, year == c(1981,1982,1983))
#This recycles the vector 
#(index-matching, not bucket-matching)
#we get warning message - longer object length is not a multiple of shorter object length; when we say equals equals and have vectors of values, that's column level matching does row 1 - 1981, does row 2 = 1982 (row 2 not being checked if it's 1981 or 1983)

#filtering by multiple conditions 
bigfoot_with_weight <- filter(surveys, hindfoot_length >40 & !is.na(weight))

#multi-step process 
small_animals <- filter(surveys, weight<5)
#this is slightly dangerous because you have to remember 
#to select from small_animals, not surveys in the next step
small_animals_ids <- select(small_animals, record_id, plot_id, species_id)

#same process, using nested functions (don't need to do intermediate steps)
small_animals_ids <- select(filter(surveys, weight<5), record_id, plot_id, species_id) #replacing small_animals in line 54 with expression in line 51 that equals small_animals 

#using nested functions is a little clunky
#same process, using a pipe
#Cmd Shift M (%>%)
#or |> (#this is pipe in base R)
#note our select function no longer explicitly calls the tibble as its first element
#read pipe from left to right, first filter, then pipe to select columns from the filter - when you use a pipe it understands that first filtering function gets ported into the select function as the invisible first variable 
small_animals_ids <- filter(surveys, weight<5) %>% select(record_id, plot_id, species_id)
#this is the same as writing it this way - more readable - read entire statement from left to right 
small_animals_ids <- surveys %>% filter(weight<5) %>% select(record_id, plot_id, species_id)

#how to do line breaks with pipes 
surveys %>% filter(month == 1)
#good
surveys %>% 
  filter(month == 1)
#break up lines in a way that R knows statement cannot end 
#not good:
surveys 
%>% filter(month==1)
#what happened here?

##line break rules: after open parenthesis, pipe,commas, or anything that shows the line is not complete yet ----

library(tidyverse)
surveys <- read_csv('data/portal_data_joined.csv')

#Learn about mutate, group_by, and summarize functions ----
## Mutate ----

#create, modify and delete columns 
surveys <- surveys %>% 
  mutate(weight_kg = weight/1000)
str(surveys)

#add multiple columns inside mutate function
surveys <- surveys %>% 
  mutate(weight_kg = weight/1000, 
         weight_kg2 = weight_kg*2)
str(surveys)

#filter out NAs
surveys <- surveys %>% 
  filter(!is.na(weight)) %>% 
  mutate(weight_kg = weight/1000, 
         weight_kg2 = weight_kg*2)
str(surveys)
head(surveys) #by default shows first 10 columns 

#challenge in tutorial to combine skills 

## Group_by and summarize ----
#often used together 

#group_by allows you to perform analysis on certain groups in data - requires some kind of categorical variable 
surveys2 <- surveys %>% 
  group_by(sex) %>% 
  mutate(mean_weight = mean(weight,))
str(surveys2)
#we just want to know the weight by each group in the sex column - this is where summarize function is handy 

surveys3 <- surveys %>% 
  group_by(sex) %>% 
  summarize(mean_weight = mean(weight,))

surveys3

#look at weight for multiple variables (sex and species ID)
surveys3 <- surveys %>% 
  group_by(sex, species_id) %>% 
  summarize(mean_weight = mean(weight,))

surveys3

#use arrange function to look at weight values in a specific order 
surveys %>% 
  group_by(sex, species_id) %>% 
  summarize(mean_weight = mean(weight,)) %>% 
  arrange(mean_weight)
#now the output is from lowest to highest weight 
surveys %>% 
  group_by(sex, species_id) %>% 
  summarize(mean_weight = mean(weight,)) %>% 
  arrange(-mean_weight)
#add dash and now the values descend from highest value 

#summarize multiple values 
surveys %>% 
  group_by(sex, species_id) %>% 
  summarize(mean_weight = mean(weight),
            min_weight = min(weight)) %>% 
  arrange(-mean_weight)
