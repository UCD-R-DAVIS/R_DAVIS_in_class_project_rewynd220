#Data Manipulation in Tidyverse ----
##Conditional Statements ----
#this is a way to classify and reclassify data (next level up from filtering)
library(tidyverse)
surveys <- read_csv('data/portal_data_joined.csv')
summary(surveys$hindfoot_length)
#reclassifying data variables from numeric into some kind of categorgy 
#pseudocode 
#ifelse(test or condition, what to do if the test is yes / true, and what to do if the test is false)

#boolean test 
surveys$hindfoot_length <29.9

#create new column this way; test that we do on right side of variable will be saved under this new column 
surveys$hindfoot_cat <- ifelse(surveys$hindfoot_length<29.9, yes = "small", no = "big")
head(surveys$hindfoot_cat)
head(surveys$hindfoot_length)

#another way to write this that is more robust (instead of putting in 29.9 as mean)
surveys$hindfoot_cat <- ifelse(surveys$hindfoot_length<mean(surveys$hindfoot_length, na.rm = TRUE), yes = "small", no = "big")
head(surveys$hindfoot_cat)

#once you start having more than 2 conditions or categories you want to create, it gets messy 

# use case_when()

surveys %>% 
  mutate(hindfoot_cat = case_when(
    hindfoot_length > 29.29 ~ "big",
    is.na(hindfoot_length) ~ NA_character_, #also other types: NA_integer_
    TRUE ~ "small" #weird syntax... but essentially the "else" part 
  )) %>% 
  select(hindfoot_length,hindfoot_cat) %>% 
  head()

#more categories? 

surveys %>% 
  mutate(hindfoot_cat = case_when(
    hindfoot_length > 31.5 ~ "big",
    hindfoot_length >29 ~ "medium",
    is.na(hindfoot_length) ~ NA_character_, #also other types: NA_integer_
    TRUE ~ "small" #weird syntax... but essentially the "else" part 
  )) %>% 
  select(hindfoot_length,hindfoot_cat) %>% 
  group_by(hindfoot_cat) %>% 
  tally()

##Joining----
#bringing dataframes together 

library(tidyverse)
tail<- read_csv('data/tail_length.csv')
head(tail)
dim(tail)

#join_function(data frame a, data frame b, how to join)

#inner_join (data frame a, data frame b, common id) #only joins the same thing in A and B and gets rid of the rest 
#inner_join only keeps records in both dataframes 
surveys <- read_csv('data/portal_data_joined.csv')
dim(inner_join(x=surveys, y=tail, by = 'record_id'))
dim(surveys)
dim(tail)

#left_join
#left_join takes dataframe x and dataframe y - takes everything in left hand side and only matches in right hand side 
#(keeps everything in x and only matches in y)

#left_join(x,y) == right_join(y,x)
#just use left join, have X be the dataframe you want to keep and alter, have Y be the dataframe you want to grab matches from 

#right_join - takes dataframe x and dataframe y and it keeps everything in y and only matches in x 

surveys_left_joined <- left_join(x= surveys, y= tail, by= 'record_id')
surveys_right_joined <- right_join(y=surveys, x= tail, by='record_id')

dim(surveys_left_joined)
dim(surveys_right_joined)

#full_join(x,y)
#full_join keeps EVERYTHING (can get messy if you don't have common record)

surveys_full_joined <- full_join(x=surveys, y=tail)
dim(surveys_full_joined)

##Pivoting--
#moving from lots of columns to rows and vice versa 

#pivot_wider makes data with more columns 
pivot_wider()

#pivot_longer makes data with more rows 
pivot_longer()

surveys_mz <- surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(genus, plot_id) %>% 
  summarize(mean_weight = mean(weight)) 

surveys_mz
unique(surveys_mz$genus) #get unique values #maybe i want to do this with my species? 
#plot ID on column, genus on rows 

wide_survey <- surveys_mz %>% 
  pivot_wider(names_from = 'plot_id', values_from = 'mean_weight')
head(wide_survey) #we prefer to store data in long format because we don't have to store those extra NA values that come up in wide format 

long_survey <- wide_survey %>%  pivot_longer(-genus, names_to = 'plot_id', values_to = 'mean_weight') 
head(long_survey)
