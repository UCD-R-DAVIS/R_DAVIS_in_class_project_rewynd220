#Load survey data 
survey<-read.csv('data/portal_data_joined.csv')

# Create a new data frame called surveys_base with only the species_id, the weight, and the plot_type columns. 

surveys_base<-survey[c('species_id','weight','plot_type')]
#could also use tidyverse 
surveys_base<-select(surveys, species_id, weight, plot_id)
#another option: surveys_base <- surveys[1:5000, c(6, 9, 13)] #selecting rows 1:5000 and just columns 6, 9 and 13


#Have this data frame only be the first 5,000 rows.
surveys_base <-head(surveys_base,5000)
surveys_base <-surveys[1:5000,]

#Convert both species_id and plot_type to factors.
#are there other ways to do this? 

surveys_base$species_id<-factor(surveys_base$species_id)
class(surveys_base$species_id)

surveys_base$plot_type<-factor(surveys_base$plot_type)
class(surveys_base$plot_type)

#Remove all rows where there is an NA in the weight column.

#selecting only the ROWS that have complete cases (no NAs) **Notice the comma was needed for this to work**
##is there a way to use the !na.is function in this situation?---- 
surveys_base <- surveys_base[complete.cases(surveys_base), ]

#Explore these variables and try to explain why a factor is different from a character. Why might we want to use factors? Can you think of any examples?
levels(surveys_base$species_id)
levels(surveys_base$weight)

typeof(surveys_base$species_id)
typeof(surveys_base$weight)
class(surveys_base$species_id)
class(surveys_base$weight)

##I am still a bit confused about the difference and why you might want factors instead of characters. ----
#Factors can provide a bit more structure / order to values than characters can, particularly categorical data like "low","medium," and "high" that have a specific order. 

#for example with species ID you might not want to look at everything alphabetically, but with some other order 

#CHALLENGE: Create a second data frame called challenge_base that only consists of individuals from your surveys_base data frame with weights greater than 150g.

#challenge question----
challenge_base<-surveys_base[surveys_base[,2]>150] #why an additional comma after 150?
challenge_base <- surveys_base[surveys_base[, 2]>150,] 
