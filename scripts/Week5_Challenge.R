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