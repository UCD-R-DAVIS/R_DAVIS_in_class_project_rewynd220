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
