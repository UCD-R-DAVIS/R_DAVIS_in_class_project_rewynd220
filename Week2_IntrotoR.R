#look at elise's repo for code 
#you can save script and it lives forever - console is ephemeral; only run code in the script 
#use comments to explain what you did and why you did something 
4+(8*3^2 #x's help show you what's wrong 
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
