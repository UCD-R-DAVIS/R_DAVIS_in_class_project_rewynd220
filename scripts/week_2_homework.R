set.seed(15)
hw2 <- runif(50, 4, 50)
hw2 <- replace(hw2, c(4,12,22,27), NA)
hw2

?set.seed
?runif
?replace
hw2
hw2[NA]
?subset
#remove NA
hw2[!hw2 %in% c(NA)]
#rename hw2 without NAs
hw2<-hw2[!hw2 %in% c(NA)]
hw2
#select range of values 

