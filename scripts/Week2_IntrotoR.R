#look at elise's repo for code 
#you can save script and it lives forever - console is ephemeral; only run code in the script 
#use comments to explain what you did and why you did something 
4+(8*3^2) #x's help show you what's wrong (you will get warnings all down the line) 
#mathematical functions 
exp(1)
sqrt(4)
#r help files 
?log #this will pull up help window about function 
log(2,4)
log(4,2)
#label all arguments in function 
log(x=2, base=4)
#if you specify which argument is which the order doesn't matter anymore #set variables in R 
x<-1
#try avoid naming variables in your environment the same as variables in functions 
#remove variable x we created 
rm(x)
#nested functions 
#six comparison functions 
my_number <-6 #can use single = of assigning variable in R (often multiple pathways)
my_number==5
my_number!=5
my_number > 4
my_number< 3
my_number>= 2
my_number<=2
#objects and assignment (overwrite values)
my_number<-7
other_number<- -3
my_number*other_number
#object name conventions 
ls()#this lists all objects in environment 
?rm
#error object 'log_of_word' not found -> whenever you see this, it means the object hasn't been loaded or doesn't exist 
ls()
#shouldn't really being going back and forth and up and down in a script #you know if it went through or not is whether it says warning or error, warning does go through but error does not; error does not attempt to complete a task but warning does go through - warning only comes up the 

#challenge 
elephant1_kg <- 3492
elephant2_lb <- 7757
#include unit of measurement in name 
elephant1_lb <- elephant1_kg * 2.2
elephant2_lb > elephant1_lb
myelephants <- c(elephant1_lb, elephant2_lb)
which(myelephants==max(myelephants))
#don't save .r data files; do save .R script 

#working directory and file paths 
getwd()
"/Users/rebeccawynd/Documents/R_Projects/R_DAVIS_in_class_project_rewynd220"
setwd()#changes working directory 

#relative file paths 
d<-read.csv("./data/tail_length.csv")

#best practices 
#any data that i'm using, treat as read only file, manipulate in R and save in new location 
#data folder, scripts folder, data output folder, figures folder
#dir.create("./scripts")
#^^ add hashtag in front of line of code if you don't want it to run again

#How R thinks about data 
#vectors most simple (setting a series of values)

weight_g<-c(50,60,65,82) #c is used if you have multiple values 

animals <- c("mouse", "Rat", "dog")

#inspecting vectors 
length(weight_g)
str(weight_g)


## Headers ----
###another header? ----

###Change vectors----
weight_g<-c(weight_g,90)

###Challenge----
num_char <- c(1, 2, 3, "a") #every vector has to have all the same type of stuff; when you create vector r goes to lowest common denominator 
num_char
num_logical <- c(1, 2, 3, TRUE) #true and false function like 0 and 1, coercion is computer term that forces things into one type of format 
num_logical
char_logical <- c("a", "b", "c", TRUE)
tricky <- c(1, 2, 3, "4")
tricky
class(num_char)
class(tricky)
combined_logical <- c(num_logical, char_logical)
class(combined_logical)


##Subsetting ----
animals<-c("mouse","rat","dog","cat")
animals
animals[2]
#indexing: take items from a vector and create a new combination of values 

##Conditional subsetting ----
#selects things based on whether it meets criteria 
weight_g <-c(21,34,39,54,55)
weight_g>50
weight_g[weight_g>50]

##Symbols ----
#to use to set a conditional subset 
#%in% #within; grab values within a set of values 
animals
animals %in% c("rat","cat","dog","duck", "goat")
#return: FALSE  TRUE  TRUE  TRUE (false b/c mouse isn't in list we asked about)
#%in% rummaging around in bucket, vs == needs to match pairwise; some functions work pair to pair, some functions work bucket to bucket 