#Automate processes, get around copying and pasting when you want to apply code to multiple variables in your project 
#we have been using functions all quarter, for example ggplot is a function that someone has written - arguments and functions already there to create a plot 

# Creating Functions ------------------------------------------------------
# Learning Objectives: 
## Define a function that takes arguments
## Set default value for function arguments
## Explain why we should divide programs into small, single-purpose functions



## Defining a function -----------------------------------------------------
# arguments are the input, return values are the output
# for now, we will work with functions that return a single value

# a and b are our arguments, then open curly brackets where we tell R what we want to do. add a and b together, save as object called the sum - then we want r to return the sum 
my_sum <- function(a, b) {
  the_sum <- a + b
  return(the_sum)
}

my_sum #if we just type out my_sum console spits out code that is saved in the function 

my_sum( a=2, b = 2) #code runs this and output is 4; when you run a function it does not automatically save - if you want it to save you have to give it an object name 

sum <- my_sum( a=2, b = 2)


# providing argument defaults so you don't have to specify every argument every time (e.g., na.rm = FALSE in mean)

my_sum2 <- function(a =1, b=2) {
  the_sum <- a + b
  return(the_sum)
}

my_sum2() #now automatically runs with default numbers 
#however you can force change the values if you want 
my_sum2(b=3)



# Process to write your own function --------------------------------------
#start with very specific line of code that works and is doing something that you want it to do (Example below)
## temperature conversion example: Farenheit to Kelvin
((50 - 32) * (5/9)) + 273.15
((62 - 32) * (5/9)) + 273.15
((72 - 32) * (5/9)) + 273.15

## How do write function: 
# 1. Identify what piece(s) will change within your commands -- this is your argument
# 2. Remove it and replace with object(s) name(s)
# 3. Place code and argument into the function() function

f_to_k <- function(tempF){
  ((tempF - 32) * (5/9)) + 273.15 
}

#only first number in temp example was changing - replace it with generic argument name 
#now we save the function (above) by naming it and copying and pasting generic code into squiggly brackets 

f_to_k(tempF = 72)

#best practice is to specify the function as we did initially 

f_to_k <- function(tempF){
 k <- ((tempF - 32) * (5/9)) + 273.15 
 return(k)
}

#return retains all the values that the function is creating 

#this sets us up well for iteration - helpful to create internal object and specify return of the object
#the object K is pass-by-values - it only stays in function, doesn't go into global environment 

## Pass-by-value: changes or objects within the function only exist within the function
## what happens in the function, stays in the function 

#in order to save a value you need to specify that 

farenheit <- f_to_k( tempF = 72)



# source()ing functions ---------------------------------------------------

#when you have a bunch of functions you're working with, put it in it's own script, and call it into function you're working with (save function as it's own script, and call into the other script you're working in) #looking into this more 

source('scripts/practice function.R')



# Using dataframes in functions -------------------------------------------
# Say you find yourself subsetting a portion of your dataframe again and again 
# Example: Calculate average GDP in a given country, in a given span of years, using the gapminder data

#this is what i've been doing with overlapping species / quadrat species! 

library(tidyverse)
gapminder <- read_csv("https://ucd-r-davis.github.io/R-DAVIS/data/gapminder.csv") 

#write a specific line of code to calc average 
gapminder %>% 
  filter(country == "Canada", year %in% c(1950:1970)) %>% 
  summarize(meanGDP = mean(gdpPercap, na.rm = TRUE))

#generalize code (For other countries and other year ranges) 
#change specific country & range of years 

avgGDP<- function(cntry, yr.range){
  gapminder %>% 
    filter(country == cntry, year %in% c(yr.range)) %>% 
    summarize(meanGDP = mean(gdpPercap, na.rm = TRUE))
  }

#QUESTION - what if cntry shows up multiple times in the code? can you specify it once and it will fill in? 

avgGDP("United States", 1980:1985)

#didn't save above to internal object value and ask to return 

avgGDP<- function(cntry, yr.range){
  df <- gapminder %>% 
    filter(country == cntry, year %in% c(yr.range)) %>% 
    summarize(meanGDP = mean(gdpPercap, na.rm = TRUE))
  return(df)
}


# Challenge ---------------------------------------------------------------
# Write a new function that takes two arguments, the gapminder data.frame (d) and the name of a country (e.g. "Afghanistan"), and plots a time series of the country’s population. The return value from the function should be a ggplot object. Note: It is often easier to modify existing code than to start from scratch. To start out with one plot for a particular country, figured out what you need to change for each iteration (these will be your arguments), and then wrap it in a function.

library(ggplot2)
gapminder <- read_csv("https://ucd-r-davis.github.io/R-DAVIS/data/gapminder.csv") 

country_plot <- function(cntry) {
country_pop <- gapminder %>% 
  select(country, year, pop) %>% 
  filter(country == cntry) %>% #change this to interchange later 
  group_by(year, pop) 
  ggplot(data= country_pop, mapping = aes(x=year, y=pop))+
  geom_line()+
  labs(title = cntry)+
    theme(
      plot.title = element_text(hjust = 0.5)
    )
}

country_plot("Australia")




