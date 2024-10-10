#Vector Math ----
#R allows us to do calculations on sets of numbers 
x<-1:10
x

x+3 #R adds 3 to each number in the vector 
x*10

#2 vectors of same length that R is adding together 
y<- 100:109
y
x+y
#because the vectors are the same length it is creating a pair 
cbind(x,y,x+y)
#console shows x vector, y vector and what they add up to 
#what if vectors are different lengths 
z<-1:2
z
x+z
#output is interesting - because z is different length than x, it repeats through each number in z until a number is available for each number in x 
cbind(x,z,x+z)
#you see r is recycling the numbers 1 and 2 until it populates all index numbers of x 
#this term of recycling is really important and comes up in many different ways 
#basic mechanism behind subsettng and indexing 

#what if z was 3 numbers? not a perfect multiple of 10 
z<-1:3
z
x+z
#we get a warning because 3 is not perfect multiple of 10 
cbind(x,z,x+z)

#when combining vectors of different lengths we'll get same warning 
a<-x+z

##Index a vector ----
#select every other value in x 
x[c(TRUE,FALSE)]
x[c(TRUE,FALSE,FALSE)]
#R does the same recycling thing in this situation but does not provide warning 

##Missing values ----
#NA is special character in R for identifying missing data 
NA #special character (thinking about it the same way it thinks about numerical value)
NaN #R sees it similarly as missing value 
"NA" #if it's in quotes R sees it as text or string - R won't see it as a missing value 

heights <- c(2,4,4,NA,6)

mean(heights)
sum(heights)
#R is saying that it can't calculate with NA in the vector 
mean(heights,na.rm = TRUE)
#tab after height to add conditional that it won't incorporate the NAs 

is.na(heights)
#this gives logical values if there is an NA or not in the vector 
! #this exclamation mark symbol tells R to invert, select opposite 
!is.na(heights)

#this is handy because you might want to remove na values from vector 
#how to remove NA values below 
heights[!is.na(heights)]

#complete cases function will return an object that only has values where full information is available - use function to create subset of data that has no NAs in it 

heights[complete.cases(heights)]

#Other data types ---- 
#so far we have just talked about vectors 

##Lists ----
#data type constructed of multiple vectors in one object 
list(4,6,"dog") #use function list to bring together 3 values, this gives us 3 separate vectors vs. below which puts all values in one vector 
c(4,6,"dog")
a<-list(4,6,"dog")
class(a) #tells us what data type it is 
str(a) #tells us type of data (numerical, character etc)
b<-list(4,letters,"dog") #letters is all letters in the alphabet
str(b)
length(b) #3 separate elements in list 
length(b[[2]]) #look at length of letters, i.e. length of values within the list 

##Data frames ----
#one of the most common data types; picky lists 
letters
data.frame(letters) #puts everything within vector into columns 
df<-data.frame(letters) 
length(df) #says 1 (number of columns)
dim(df) #dimensions, 26 rows, 1 column
nrow(df) #number of rows
ncol(df) #number of columns 
df2<-data.frame(letters, letters)
str(df2) #r will rename second row if it's the same 
dim(df2) #now we have 26 charterers in 2 columns 

data.frame(letters, "dog") #recycling, it repeats dog all the way down in new column 
data.frame(letters, 1)
data.frame(letters, 1:2) #recycles because length has to be the same 
data.frame(letters,1:3) #this gives us an error because it can't easily determine how it wants us to include 1:3 because it doesn't factor in easily 

##Matrices ----
#type of data but has to be same type of data in x and y (all numerical or all character)
matrix (nrow = 10, ncol = 10)
matrix(1:10, nrow=10, ncol = 10) #each row is same value, counting 1:10 in each column 
m<-matrix(1:10, nrow=10, ncol = 10, byrow = TRUE) #now it will do sequence of values across each row 
m[1,3] #extract a value in first row and 3rd column 
m[c(1,2),c(5,6)]

#arrays are matrices in 3 dimensions with x,y and z values 
#multiple networks that are related to each other, and look at them in relation to each other 

##Factors ----
#fancy characters with some sort of value or order to them 
#handy and convenient to use at times when you want to specify a certain order in your characters that are different than what R gives 

response<-factor(c("no","yes","maybe","no","maybe","no"))
class(response) #tells us this is a factor 
levels(response) #R has assigned levels to the words in the response object 
nlevels(response) #understand number of levels in factor 
typeof(response) #r tells us what it's thinking about the data - it tell us it's an integer 
response #order is based on the alphabet 
response<-factor(response, levels = c("yes","maybe","no")) #specify the order we want #use factor to help order them 
response
###convert factor ----
as.character(response)
#issue with numbers 
year_fct<-factor(c(1990,1983,1997,1998,1990))
year_fct
as.numeric(year_fct)
as.numeric(as.character(year_fct))#retains number characters 

#renaming 
levels(response)
levels(response)[1] <-"YES" #change name 
response
levels(response)<-c("YES","MAYBE","NO") #change all names 
levels(response)
response
