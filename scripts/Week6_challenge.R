#week 6 challenges 

#1----
#Use ggplot() to create a scatter plot of weight and species_id with weight on the Y-axis, and species_id on the X-axis. Have the colors be coded by plot_type. Is this a good way to show this type of data? What might be a better graph?

ggplot(data = surveys_complete, mapping = aes(x = species_id, y = weight))+
  geom_point(aes(color = plot_type))
  

#2----
#Boxplots are useful summaries, but hide the shape of the distribution. For example, if the distribution is bimodal, we would not see it in a boxplot. An alternative to the boxplot is the violin plot, where the shape (of the density of points) is drawn.
#Replace the box plot code from above with a violin plot; see geom_violin().

ggplot(data = surveys_complete, mapping = aes(x = species_id, y = weight)) +
  geom_jitter(alpha = 0.3, color = "tomato") +
  geom_violin(alpha = 0)

#In many types of data, it is important to consider the scale of the observations. For example, it may be worth changing the scale of the axis to better distribute the observations in the space of the plot. Changing the scale of the axes is done similarly to adding/modifying other components (i.e., by incrementally adding commands). Try making these modifications:
  #Use the violin plot you made in Q1 and adjust the weight to be on the log10 scale; see scale_y_log10().

ggplot(data = surveys_complete, mapping = aes(x = species_id, y = weight)) +
  geom_jitter(alpha = 0.3, color = "tomato") +
  geom_violin(alpha = 0) + 
  scale_y_log10()

#Make a new plot to explore the distribution of hindfoot_length just for species NL and PF using geom_boxplot(). Overlay a jitter/scatter plot of the hindfoot lengths of the two species behind the boxplots. Then, add an aes() argument to color the datapoints (but not the boxplots) according to the plot from which the sample was taken.

surveys_complete_filter <- surveys_complete %>% 
  filter(species_id == "NL" | species_id == "PF")

ggplot(data = surveys_complete_filter, mapping = aes(x = species_id, y = hindfoot_length))+
  geom_jitter(aes(colour = plot_id), alpha = 0.3)+
  geom_boxplot()

class(surveys_complete_filter$plot_id)

#change plot_id from numeric to factor - this will change how the color codes and the legend 

ggplot(data = surveys_complete_filter, mapping = aes(x = species_id, y = hindfoot_length))+
  geom_jitter(aes(colour = as.factor(plot_id)), alpha = 0.3)+
  geom_boxplot()

#3----
mystery <- read_csv("https://raw.githubusercontent.com/gge-ucd/R-DAVIS/master/data/mysteryData.csv")

mystery %>%
  head(5)

ggplot(data = mystery, mapping = aes(x=x, y=y))+
  facet_wrap(~Group)+
  geom_point(size = 0.1, alpha = 0.01)

#Try equalizing the coordinate space in the x- and y-axes by adding a coord_equal() to your ggplot() call:
ggplot(data = mystery, mapping = aes(x = x, y = y)) +
  facet_wrap(~ Group) +
  geom_point(size = 0.1, alpha = 0.01) +
  coord_equal()

#4----
#Usually plots with white background look more readable when printed. We can set the background to white using the function theme_bw(). Additionally, you can remove the grid:

#Let’s make one final change to our facet wrapped plot of our yearly count data. What if we wanted to split the counts of species up by sex where the lines for each sex are different colors? Make sure you have a nice theme on your graph too!

#Hint Make a new dataframe using the count function we learned earlier!
 
surveys_complete <- read_csv('data/portal_data_joined.csv') %>%
  filter(complete.cases(.))

yearly_counts <- surveys_complete %>% count(year,species_id,sex)
  
ggplot(data = yearly_counts, mapping = aes(x = year, y = n, group = sex)) +
  geom_line(aes(colour = sex)) +
  facet_wrap(~ species_id) +
  theme_bw() +
  theme(panel.grid = element_blank())

#Use what you just learned to create a plot that depicts how the average weight of each species changes through the years.

avg_weight<- surveys_complete %>% count(year,species_id,weight) %>% 
  group_by(year,species_id) %>% 
  summarise(avg_weight = mean(weight))

ggplot(data=avg_weight, mapping = aes(x=year, y=avg_weight))+
  geom_line()+
  facet_wrap(~species_id, scales = 'free')+
  theme_bw()
  


