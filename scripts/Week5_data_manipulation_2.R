#Data Manipulation in Tidyverse ----
##Conditional Statements ----
## ifelse: run a test, if true do this, if false do this other thing
## case_when: basically multiple ifelse statements
# can be helpful to write "psuedo-code" first which basically is writing out what steps you want to take & then do the actual coding
# great way to classify and reclassify data
#this is a way to classify and reclassify data (next level up from filtering)
library(tidyverse)
surveys <- read_csv('data/portal_data_joined.csv')

#reclassifying data variables from numeric into some kind of category 
#ifelse (test or condition, what to do if the test is yes / true, and what to do if the test is false)

#surveys$hindfoot_length mean is 29.9

#create new column this way; test that we do on right side of variable will be saved under this new column 
surveys$hindfoot_cat <- ifelse(surveys$hindfoot_length<29.9, yes = "small", no = "big")
head(surveys$hindfoot_cat)
head(surveys$hindfoot_length)

#another way to write this that is more robust (instead of putting in 29.9 as mean)
surveys$hindfoot_cat <- ifelse(surveys$hindfoot_length<mean(surveys$hindfoot_length, na.rm = TRUE), yes = "small", no = "big")
head(surveys$hindfoot_cat)

unique(surveys$hindfoot_cat) #summarizes individual categories in each column (I could use to name species)

#once you start having more than 2 conditions or categories you want to create, it gets messy 

# use case_when()
#case_when functions run from top to bottom it keeps going down until it catches everything - you want a very broad thing at the end so everything has a category - this is why you use TRUE
#case_when you have to be very specific in what you're doing - need to specify what you want it to do with the NAs

surveys %>% 
  mutate(hindfoot_cat = case_when(
    hindfoot_length > 29.29 ~ "big",
    is.na(hindfoot_length) ~ NA_character_, #also other types: NA_integer_
    TRUE ~ "small" #weird syntax... but essentially the "else" part 
  )) %>% 
  select(hindfoot_length,hindfoot_cat) %>% 
  head()

#more categories? 
#using mutate instead of summarize - we want it to go through every record in data frame and add a category - not make any summaries 

surveys %>% 
  mutate(hindfoot_cat = case_when(
    hindfoot_length > 31.5 ~ "big", #make notes about each case and why you're doing it 
    hindfoot_length >29 ~ "medium",
    is.na(hindfoot_length) ~ NA_character_, #also other types: NA_integer_
    TRUE ~ "small" #always label it small if it didn't get caught before 
  )) %>% 
  select(hindfoot_length,hindfoot_cat) %>% 
  head(10)

# lots of other ways to specify cases in case_when and ifelse
surveys %>%
  mutate(favorites = case_when(
    year < 1990 & hindfoot_length > 29.29 ~ "number1", 
    species_id %in% c("NL", "DM", "PF", "PE") ~ "number2",
    month == 4 ~ "number3",
    TRUE ~ "other"
  )) %>%
  group_by(favorites) %>%
  tally()


##Joining----
#bringing dataframes together 
#join functions work row wise - join row to row where the column values match up 

library(tidyverse)
tail<- read_csv('data/tail_length.csv')
head(tail)
dim(tail)
dim(surveys)

#join_function(data frame a, data frame b, how to join)

#inner_join - only exact matches remain (dataframe gets smaller) 
#(data frame a, data frame b, common id) #only joins the same thing in A and B and gets rid of the rest 
#inner_join only keeps records in both dataframes 

surveys_inner <-inner_join(x=surveys, y=tail)
dim(surveys_inner)
#now there is one more row b/c record_id is the same, tail length is additional 

surveys <- read_csv('data/portal_data_joined.csv')
dim(inner_join(x=surveys, y=tail, by = 'record_id'))
dim(surveys)
dim(tail)

#left_join - keeps everything in first dataframe and only takes on matches it finds in the second dataframe (dataframe stays the same size - will fill in NAs for new row that doesn't match)
#always use left_join - always keep records in the left data frame 

#left_join takes dataframe x and dataframe y - takes everything in left hand side and only matches in right hand side 
#(keeps everything in x and only matches in y)

#left_join(x,y) == right_join(y,x)
#just use left join, have X be the dataframe you want to keep and alter, have Y be the dataframe you want to grab matches from 

#right_join - takes dataframe x and dataframe y and it keeps everything in y and only matches in x 

surveys_left_joined <- left_join(x= surveys, y= tail, by= 'record_id')
surveys_right_joined <- right_join(y=surveys, x= tail, by='record_id')

#use dim function to check how dataframe is looking and make sure it's still the right size 
dim(surveys_left_joined)
dim(surveys_right_joined)

#full_join(x,y)
#full_join keeps EVERYTHING (can get messy if you don't have common record); gets more complicated if it's a many to one type of join 

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
  pivot_wider(id_cols = 'genus', 
  names_from = 'plot_id', 
  values_from = 'mean_weight')
head(wide_survey) #we prefer to store data in long format because we don't have to store those extra NA values that come up in wide format 

long_survey <- wide_survey %>%  pivot_longer(-genus, names_to = 'plot_id', values_to = 'mean_weight') 
head(long_survey)
