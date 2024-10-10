surveys <- read.csv("data/portal_data_joined.csv")
?read.csv #underneath read.table; default for read.csv is header = TRUE 
str(surveys)
nrow(surveys)
ncol(surveys)
#use blank " and hit tab and you can navigate to file 
file_loc<-"data/portal_data_joined.csv"
read.csv(file_loc)
str(surveys) #tells us about every column in data frame 
class(surveys)
summary(surveys)
?summary

#first value row, second value column 
dim(surveys) #dimensions 
surveys[1,5]
surveys[1:5] 
#Parentheses are for functions, brackets are for pulling something out of dataframe, indicating the position of items in a vector or matrix.
surveys[1:5,] 
surveys [c(1,5,24,3001),]
surveys[,1] #get vector 
surveys[,1:5] #get data frame
colnames(surveys) #gives all names of columns in surveys 

surveys[c('record_id','year','day')]
head(surveys[c('record_id','year','day')]) #only shows top few rows (can specify rows)
#use head to make sure the function or thing you are doing is doing what you want it to do without having to scroll a bunch 

tail(surveys)
head(surveys)

head(surveys["genus"])
head(surveys[["genus"]]) #double bracket looks like vector; double bracket gets into internal object living within (brackets are about level of indexing, double bracket you loose metadata)
head(surveys[c("genus","species")])

surveys$genus #$ name of each column is sub-object of larger surveys object 
#$dollar sign is how you open up an object and say next level of names please 
surveys$hindfoot_length #only can select one at a time; only works for columns that are named 
class(surveys$hindfoot_length)

#Tidyverse Package ----
install.packages("tidyverse")
library(tidyverse)
#a way for it to be simpler to index and view data 

t_surveys<-read_csv('data/portal_data_joined.csv') #visual aesthetics wrapped around dataframe 
class(t_surveys)
t_surveys

#we already know all the objects in R, everything else is just fancy versions of that 
#try things out and practice! 