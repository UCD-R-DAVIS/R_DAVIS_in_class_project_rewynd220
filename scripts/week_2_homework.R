set.seed(15)
hw2 <- runif(50, 4, 50)
hw2 <- replace(hw2, c(4,12,22,27), NA)
hw2

#remove all NAs 
hw2[!is.na(hw2)]
hw2<-hw2[!is.na(hw2)]
hw2
#when would it make sense to use na.omit vs !is.na ? different na functions can behave differently
#also can use hw2[complete.cases(hw2)] #takes data that only has complete observations 
#to remove a certain number like 10, you would hw2[!hw2does not equal 10] (something like that)


#select all numbers between 14 and 38 inclusive
hw2[hw2>=14 & hw2<=38]
prob1 <-hw2[hw2>=14 & hw2<=38]
prob1
#or would be a |
#hw2[c14:38] is referring to index value 14 - 38 not the numbers in the vector 

#multiply each number in prob1 vector by 3 
times3<-prob1*3
times3

#add 10
plus10<-times3+10
plus10

#select every other number in plus10 vector 
plus10[c(TRUE,FALSE)]
#says it wants first number, not second number, and recycles 

#if you have to do math with a vector with NAs in it 
mean(hw.2,na.rm=TRUE)