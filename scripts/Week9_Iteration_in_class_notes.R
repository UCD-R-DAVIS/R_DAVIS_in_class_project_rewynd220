# Iteration ---------------------------------------------------------------

# Learning Objectives: 
## Understand when and why to iterate code
## Be able to start with a single use and build up to iteration
## Use for loops, apply functions, and purrr to iterate
## Be able to write functions to cleanly iterate code

# Data for class 
head(iris)
head(mtcars)
gapminder <- read_csv("https://ucd-r-davis.github.io/R-DAVIS/data/gapminder.csv")

# Packages
library(tidyverse)


# Subsetting refresher
## column of data
head(iris[1]) # first column
head(iris %>% select(Sepal.Length))

## vector of data
iris[[1]] # first column in a vector
iris[,1]
head(iris$Sepal.Length)

## specific values
iris[1,1]
iris$Sepal.Length[1]


# For Loops ---------------------------------------------------------------
##comparison of function & iteration syntax----
#function
test <- function(i){
  print(i)
}
test(1)

#iteration (stores values)
for (i in 1:10) {
  print(i)
}

#how do we store multiple things?

## Vector example -----
## 1. What do I want my output to be?
# we want an empty vector to fill up with values from our function
results <- rep(NA, nrow(mtcars)) # can run nrow() to see what to expect
results 

## 2. What is the task I want my for loop to do?
mtcars$wt*100

## 3. What values do I want to loop through the task?
for(i in 1:nrow(mtcars)){ # we want to do this for every row in cars data, we could hard code but more robust to soft code
  results[i] <- mtcars$wt[i]*100
}



## Datafame example -----
#wants to loop over every single country in the dataframe to get mean gdp
for(i in unique(gapminder$country)){
  country_df <- gapminder[gapminder$country == i, ] #saves new dataframe with all info for specific country 
  df <- country_df %>%
    summarize(meanGDP = mean(gdpPercap, na.rm = TRUE))
  return(df)
} # And when we use the return function?? one in our environment
df


# how do we know for sure that the for loop is evaluting every country?
for(i in unique(gapminder$country)){
  country_df <- gapminder[gapminder$country == i, ]
  df <- country_df %>%
    summarize(meanGDP = mean(gdpPercap, na.rm = TRUE))
  print(df) #shows you what's happening, but not saving anywhere 
} 

#we could do this same thing using summarize function, but we would want to use for loop if we're doing multiple operations to the data 

## Changing the format so that it will save all the values as a data frame
## 1. What do I want my output to be?


## 2. What is the task I want my for loop to do?


## 3. What values do I want to loop through the task?




# Map Family of Functions -----------------------------------------------------------
# map functions are useful when you want to do something across multiple columns
library(tidyverse)
# two arguments: the data & the function
# think about output, but instead of creating a blank output, you can just use the specific function

# basic function
map(iris, mean) # warning of NA for species
# default is that the output is a list

map_df(iris, mean) # df in, df out, anything that follows the function is the desired output

map_df(iris[1:4], mean) # use subset to be a little more specific & select just columns with continuous data

# class coercion



# often times iteration is paired with custom functions
head(mtcars)
print_mpg <- function(x, y){
  paste(x, "gets", y, "miles per gallon")
}


# more detailed functions which can take two arguments
map2_chr(rownames(mtcars), mtcars$mpg, print_mpg)

# Can also embed an "anonymous" function 
#put function in another command, but not saved in environment 

# pmap for more than two inputs

##find in class tutorial

#figure out processing figure out looping, when you put it together identify error more easily 
for(gz in gz_files) # you can change iterator terms - just be consistent 
  
#helpful to print function in beginning to see if it's doing what you want it to do 
  
#apply functions are like generic loops on steroids 
#family of apply functions (lapply, mapply)
  
  
#phrase: split, apply combine (processing large data)
