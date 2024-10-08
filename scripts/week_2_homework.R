set.seed(15)
hw2 <- runif(50, 4, 50)
hw2 <- replace(hw2, c(4,12,22,27), NA)
hw2

#remove all NAs 
hw2[!is.na(hw2)]
hw2<-hw2[!is.na(hw2)]
hw2

#select all numbers between 14 and 38 inclusive
hw2[hw2>=14 & hw2<=38]
prob1 <-hw2[hw2>=14 & hw2<=38]
prob1

#multiply each number in prob1 vector by 3 
times3<-prob1*3
times3

#add 10
plus10<-times3+10
plus10

#select every other number in plus10 vector 
plus10[c(TRUE,FALSE)]
