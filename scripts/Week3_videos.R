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
#what if vectors are different lenghts 
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

#when combining vectors of different lenghts we'll get same warning 
a<-x+z

#index a vector ----
#select every other value in x 
x[c(TRUE,FALSE)]
x[c(TRUE,FALSE,FALSE)]
#R does the same recycling thing in this situation but does not provide warning 