#Case_when----
#Using the iris data frame (this is built in to R), create a new variable that categorizes petal length into three groups:
#small (less than or equal to the 1st quartile)
#medium (between the 1st and 3rd quartiles)
#large (greater than or equal to the 3rd quartile)
#Hint: Explore the iris data using summary(iris$Petal.Length), to see the petal length distribution. Then use your function of choice: ifelse() or case_when() to make a new variable named petal.length.cat based on the conditions listed above. Note that in the iris data frame there are no NAs, so we don’t have to deal with them here

summary(iris$Petal.Length)
iris %>% 
  mutate(petal.length.cat = case_when(
    Petal.Length <= 1.6 ~ "small",
    Petal.Length > 1.6 & Petal.Length < 5.1 ~ "medium",
    Petal.Length >=5.1 ~ "big"
  ))

#Joining ----
#Filter the data so that only species_id = NL,and call this surveysNL
#Join the tail data to the surveysNL data (i.e. left join with surveysNL on the left). Name it surveysNL_tail_left. How many rows are there?

surveys <- read_csv('data/portal_data_joined.csv')
surveysNL <- filter(surveys, species_id == "NL")
nrow(surveysNL)
#1252 rows 

#Join the surveysNL data to the tail data (i.e. right join with surveysNL on the left). Name it surveysNL_tail_right. How many rows are there?

tail_surveysNL_left <- left_join(x=tail, y=surveysNL, by = 'record_id')
nrow(surveysNL_tail_right)
#34786 rows 

#Pivoting----
#Use pivot_wider on the surveys data frame with year as columns, plot_id as rows, and the number of genera per plot as the values. You will need to summarize before reshaping, and use the function n_distinct() to get the number of unique genera within a particular chunk of data.

#summarize number of genera per plot 
surveys_pivot <- surveys %>% 
  group_by(year, plot_id) %>% 
  summarise(num_genera = n_distinct(genus)) %>% 
  pivot_wider(names_from = "year",values_from = "num_genera")

q1 <- surveys %>%
  group_by(plot_id, year) %>%
  summarize(n_genera = n_distinct(genus)) %>%
  pivot_wider(names_from = "year", values_from = "n_genera")

#The surveys data set has two measurement columns: hindfoot_length and weight. This makes it difficult to do things like look at the relationship between mean values of each measurement per year in different plot types. Let’s walk through a common solution for this type of problem. First, use pivot_longer() to create a dataset where we have a new column called measurement and a value column that takes on the value of either hindfoot_length or weight. Hint: You’ll need to specify which columns are being selected to make longer.

surveys_pivot_longer <- surveys %>% 
  pivot_longer(cols = c("hindfoot_length","weight"), names_to = "measurement_type",values_to = "value")


#Then with this new data set, calculate the average of each measurement for each different plot_type. Then use pivot_wider() to get them into a data set with a column for hindfoot_length and weight. Hint: You only need to specify the names_from = and values_from = columns

surveys_pivot_longer_2 <- surveys_pivot_longer %>% 
  group_by(measurement_type, plot_type) %>% 
  summarize(mean_value = mean(value, na.rm=TRUE)) %>% 
  pivot_wider(names_from = "measurement_type", values_from = "mean_value")
  
