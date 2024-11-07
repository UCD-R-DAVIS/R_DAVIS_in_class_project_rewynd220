library(tidyverse)
library(ggplot2)

surveys_complete <- read_csv("data/portal_data_joined.csv") %>% 
  filter(complete.cases(.))

# ggplot2 ----
## Grammar of Graphics plotting package (included in tidyverse package - you can see this when you call library(tidyverse)!)
## easy to use functions to produce pretty plots
## ?ggplot2 will take you to the package helpfile where there is a link to the website: https://ggplot2.tidyverse.org - this is where you'll find the cheatsheet with visuals of what the package can do!


#syntax for ggplot ----
## ggplot basics
## every plot can be made from these three components: data, the coordinate system (ie what gets mapped), and the geoms (how to graphical represent the data)

# ggplot(data = <DATA>,mapping = aes(<MAPPING>)) + <GEOM_FUNCTION> ()

#(name data frame in all caps, mapping - tell R where you want to get data from in data frame; put column names in parentheses); we've been using pipe function but in ggplot it uses just a plus sign, put geometric function to add graphical representation to your plot 

#go to ggplot2 help to access website / cheat sheet 

#example ----
ggplot(data = surveys_complete)

#add aes argument 
ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length))
#aesthetics function goes into your dataframe and pulls out any sort of matching column frames that you specify - any info you want plotted has to be specified in aesthetics argument 

#add geom_function (how we want R to graphically represent the data)
#lots of geom functions based on type of data you have 
#continuous variables - geom_point, or geom_line to show relationship
#categorical and numerical you could use geom_boxplot
#just categorical variables you can use geom_bar 
#R graph gallery to get inspiration on how to make different plots & code 
#with + function space down every time you add something new to plot 
ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length)) + 
  geom_point()

#add more plot elements / aesthetic features 
#add transparency to the points 
ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length)) + 
  geom_point(alpha = 0.1)

#add color to the points 
ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length)) + 
  geom_point(color = "blue") #great color cheat sheet

#color by group, for example, color by genus
ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length)) + 
  geom_point(aes(color = genus)) +
  geom_smooth (aes(color=genus)) #represent the relationship b/w hindfoot length and weight for each group - this plost line per genus 

#make it more streamlined #universal plot settings ----
ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length, color = genus)) + #putting it up here makes it so all following actions are by genus 
  geom_point() +
  geom_smooth ()


## Visualize weight categories and the range of hindfoot lengths in each group
## Bonus from hw: 
sum_weight <- summary(surveys$weight)
surveys_wt_cat <- surveys %>% 
  mutate(weight_cat = case_when(
    weight <= sum_weight[[2]] ~ "small", 
    weight > sum_weight[[2]] & weight < sum_weight[[5]] ~ "medium",
    weight >= sum_weight[[5]] ~ "large"
  )) 

table(surveys_wt_cat$weight_cat)

#boxplots: categorical & continuous data ----
ggplot(data = surveys_complete, mapping = aes(x=species_id, y = weight))+
  geom_boxplot(color = "orange") #giving spread of weight for each species id (look up geom_boxplot for details)

ggplot(data = surveys_complete, mapping = aes(x=species_id, y = weight))+
  geom_boxplot(fill = "orange") + #make insides orange, not just outline 
  geom_jitter(color = "black", alpha = 0.1) #slight variation in how points are displayed on graph so you can visually see all the points that are there #alpha adds transparency 

#change order of how plot is constructed so we can see the boxes #simply reverse order of how it's written 
ggplot(data = surveys_complete, mapping = aes(x=species_id, y = weight))+
  geom_jitter(color = "black", alpha = 0.1) +
  geom_boxplot(fill = "orange", alpha = 0.7) 


#for surveys_wt_cat example boxplot 
ggplot(data=surveys_wt_cat, aes(x=weight_cat, y= hindfoot_length))+
  geom_boxplot(aes(color = weight_cat), alpha = 0.5) +
  geom_point(alpha = 0.1) # this would be constant across plot, you could also specify it for a certain element within the data 

#how do we tell ggplot to reorder the boxes in the boxplot? 
surveys_wt_cat$weight_cat <- factor(surveys_wt_cat$weight_cat, c("small", "medium", "large"))
#

ggplot(data=surveys_wt_cat, aes(x=weight_cat, y= hindfoot_length))+
  geom_boxplot(aes(color = weight_cat), alpha = 0.5) +
  geom_point(alpha = 0.1)

#geom_jitter - randomize points to see how many are there 
ggplot(data=surveys_wt_cat, aes(x=weight_cat, y= hindfoot_length))+
  geom_boxplot(aes(color = weight_cat), alpha = 0.5) +
  geom_point(alpha = 0.1)+
  geom_jitter(alpha = 0.1)

#switch the order of geoms to see what's on top 
ggplot(data=surveys_wt_cat, aes(x=weight_cat, y= hindfoot_length))+
  geom_point(alpha = 0.1)+
  geom_jitter(alpha = 0.1)+
  geom_boxplot(aes(color = weight_cat), alpha = 0.5)
 
 
