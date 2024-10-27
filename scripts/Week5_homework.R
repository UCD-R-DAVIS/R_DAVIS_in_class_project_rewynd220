#Week 5 HW
#Create a tibble named surveys from the portal_data_joined.csv file. 

library(tidyverse)
surveys <- read_csv("data/portal_data_joined.csv")

#Then manipulate surveys to create a new dataframe called surveys_wide with a column for genus and a column named after every plot type, with each of these columns containing the mean hindfoot length of animals in that plot type and genus. So every row has a genus and then a mean hindfoot length value for every plot type. The dataframe should be sorted by values in the Control plot type column. This question will involve quite a few of the functions you’ve used so far, and it may be useful to sketch out the steps to get to the final result.

#surveys_wide <- surveys 
#plot type # genus #meanhidfoot lenght 

surveys_wide <- surveys %>% 
  filter(!is.na(hindfoot_length)) %>% 
  group_by(plot_type, genus) %>% 
  summarise(mean_hindfoot_length = mean(hindfoot_length)) #as far as I got on my own 
  
surveys_wide2 <- surveys %>% 
  filter(!is.na(hindfoot_length)) %>% 
  group_by(genus, plot_type) %>% 
  summarise(mean_hindfoot = mean(hindfoot_length)) %>% 
  pivot_wider(names_from = plot_type, values_from = mean_hindfoot) %>% 
  arrange(Control)


#Using the original surveys dataframe, use the two different functions we laid out for conditional statements, ifelse() and case_when(), to calculate a new weight category variable called weight_cat. For this variable, define the rodent weight into three categories, where “small” is less than or equal to the 1st quartile of weight distribution, “medium” is between (but not inclusive) the 1st and 3rd quartile, and “large” is any weight greater than or equal to the 3rd quartile. (Hint: the summary() function on a column summarizes the distribution). For ifelse() and case_when(), compare what happens to the weight values of NA, depending on how you specify your arguments.

#case_when()
summary(surveys$weight)

weight_cat <- surveys %>% 
  mutate(weight_cat = case_when(
    weight <= 20.00 ~ "small",
    weight <42.7 & weight >20.00 ~ "medium",
    weight >=42.7 ~ "large",
    is.na(weight) ~ NA_character_,
    TRUE ~ "other"
  ))


#BONUS: How might you soft code the values (i.e. not type them in manually) of the 1st and 3rd quartile into your conditional statements in question 2?

  
weight_cat <- surveys %>% 
  mutate(weight_cat = case_when(
    weight <= quantile(weight,0.25, na.rm = TRUE) ~ "small",
    weight < quantile(weight,0.75,na.rm = TRUE) & weight > quantile(weight, 0.25, na.rm = TRUE) ~ "medium",
    weight >= (weight,0.75,na.rm = TRUE) ~ "large",
    is.na(weight) ~ NA_character_,
    TRUE ~ "other"
  ))

#not sure why I keep getting error here? 


