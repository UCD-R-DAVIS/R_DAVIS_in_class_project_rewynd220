library(tidyverse)
#Create a tibble named surveys from the portal_data_joined.csv file.
surveys <- read_csv('data/portal_data_joined.csv')
#Subset surveys using Tidyverse methods to keep rows with weight between 30 and 60, and print out the first 6 rows.
weight_range <- surveys %>% 
  filter(weight >= 30 & weight <= 60)
head(weight_range, n=6)
#Create a new tibble showing the maximum weight for each species + sex combination and name it biggest_critters. Sort the tibble to take a look at the biggest and smallest species + sex combinations. HINT: it’s easier to calculate max if there are no NAs in the dataframe…
biggest_critters <- surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(species_id, sex) %>% 
  summarise(max(weight), min(weight)) #or try summarise(max_weight = max(weight))

#Try to figure out where the NA weights are concentrated in the data- is there a particular species, taxa, plot, or whatever, where there are lots of NA values? There isn’t necessarily a right or wrong answer here, but manipulate surveys a few different ways to explore this. Maybe use tally and arrange here.
NA_weights <- surveys %>% 
  filter(is.na(weight)) %>% 
  group_by(taxa) %>% tally() %>% arrange (-n)

# Sort the tibble to take a look at the biggest and 
# smallest species + sex combinations.
biggest_critters %>% arrange(max_weight) %>% head()

biggest_critters %>% arrange(desc(max_weight)) %>% head()
# or arrange(-max_weight)

#Take surveys, remove the rows where weight is NA and add a column that contains the average weight of each species+sex combination to the full surveys dataframe. 

surveys %>% 
  filter(is.na(weight)) %>% 
  group_by(species) %>% 
  tally() %>% 
  arrange(desc(n))

surveys %>% 
  filter(is.na(weight)) %>% 
  group_by(taxa) %>% 
  tally() %>% 
  arrange(desc(n))

surveys %>% 
  filter(is.na(weight)) %>% 
  group_by(plot_id) %>% 
  tally() %>% 
  arrange(desc(n))


#Then get rid of all the columns except for species, sex, weight, and your new average weight column. Save this tibble as surveys_avg_weight.

surveys<- surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(species_id,sex) %>% 
  mutate(avg_weight = mean(weight))
  #why is it that this what worked and not group_by(sex)?

surveys_avg_weight <- surveys %>% 
  select(species_id, sex, weight, avg_weight)
  #why use select and not filter?   
  #select is used specifically for columns, #filter is used for rows 

#how would we make a summary table? 
surveys_avg_weight<- surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(species_id,sex) %>% 
  mutate(avg_weight = mean(weight)) %>% 
  select(species_id, sex, weight, avg_weight) %>% 
  summarize(avg_weight=mean(weight), max_weight = max(weight)) #can add other columns in summary data frame as well - understand for midterm next week 

#it dropped weight because it only takes columns that you group by 


#Take surveys_avg_weight and add a new column called above_average that contains logical values stating whether or not a row’s weight is above average for its species+sex combination (recall the new column we made for this tibble).

#logical values 

surveys_above_avg_weight <- surveys_avg_weight %>% 
  group_by(species_id,sex) %>% 
  mutate(above_average = weight>avg_weight)
  #how do we know it will return true / false for this? 
