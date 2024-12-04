#Iteration -----
#Options for iteration: for loops, map functions (base R), apply functions (tidyverse)
#for loops - doing calculations going down a single column (i.e. specify temp values for each day)
##give it a row number, value in the data, down a column
#map functions - if you want to know the mean of an entire column 

#this is helpful when you want to write your own custom function and run values through (I could have done that with my functions previously)

#using baseR iris and mtcars 

head(iris)
head(mtcars)

#Subsetting refresher 
#the last few weeks we've been subsetting in tidyverse 
#square brackets for indexing 
iris[1] #square brackets pulls out info from dataframes - this is 1st column 
iris[[1]] #gives vector of values in column 
#same as using $
iris$Sepal.Length

iris[,1] #use commas to look at x and y values 
iris[1,1]
#same as doing this 
iris$Sepal.Length[1]

#For Loops----
#when you want to do something down rows of data 
#takes an index value and runs it through your function 
#layout: use of i to specify index value (although you could use any value here)

#basic syntax for for loops 
for(i in 1:10){
  print(i)
}
#what we've said: for every index value in range of 1 through 10, print that value 
#output gives value for every single i in that range 
#this automatically gets stored in our environment (stores very last value)
#key difference - when we run function nothing is stored 

#benefit of for loops is we can write in different operations we want to do with the data 

for(i in 1:10){
  print(iris$Sepal.Length[i])
}

#this should match 
head(iris$Sepal.Length, n = 10)

#benefit of for loops is we can do multiple operations insdie of them 

for(i in 1:10){
  print(iris$Sepal.Length[i])
  print(mtcars$mpg[i]) #asking to also print the first 10 rows of values of mpg from cars dataset 
}

#each output alternating b/w the 2 lines of codes we've written 

#store output 
#think about what you want your output to look like 
results <- rep(NA, nrow(mtcars)) #making vector with NAs that is same length as dataframe 
results

for(i in 1:nrow(mtcars)){
  results[i] <- mtcars$wt[i]*100
}

#output is list of 32 values (each value of the row times 100)

#Map Family of Functions ----
#map functions are useful when you want to do something across multiple columns 
library(tidyverse)
#two arguments: the data & the function 

map(iris, mean) #calculating mean for each column 
#default output is a list 

map_df(iris, mean) #gives us more familiar output as a tibble 

#different maps provide different outputs 

#map functions used in conjunction with custom function 

head(mtcars)

#create a function that takes two different arguments 
print_mpg<- function (x,y){
  paste(x, "gets", y, "miles per gallon") #paste function takes two arguments and some value and puts it all together in a character value 
}

#map function called map2_chr(input 1, input2, function) takes 2 different inputs and spits it out as a character 

map2_chr(rownames(mtcars),mtcars$mpg, print_mpg)
#get list of 32 character strings that says what we want them to say 
# we created a specific function to do this 

#can also embed "anonymous" function 
#put function in map function and it's not saved in your enviro #no curly brackets needed 
map2_chr(rownames(mtcars),mtcars$mpg,function (x,y) paste(x, "gets", y, "miles per gallon"))  

#in class we'll think about how to construct work flow to get tasks done, bring them into a function and then an iteration 
