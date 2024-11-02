library(tidyverse)

surveys_complete <- read_csv('data/portal_data_joined.csv') %>%
  filter(complete.cases(.))

# these are two different ways of doing the same thing
head(surveys_complete %>% count(year,species_id))
head(surveys_complete %>% group_by(year,species_id) %>% tally())

yearly_counts <- surveys_complete %>% count(year,species_id)

head(yearly_counts)

ggplot(data = yearly_counts) +
  geom_line(aes(x=year, y =n))
#OR CAN WRITE LIKE THIS 
ggplot(data = yearly_counts, mapping = aes(x=year, y=n)) +
  geom_line()
#this plot doesn't look good 

#add one aesthetic which is group = species_id
ggplot(data = yearly_counts,mapping = aes(x = year, y= n,group = species_id)) +
  geom_line()
#no idea what lines are what in this plot


ggplot(data = yearly_counts,mapping = aes(x = year, y= n, colour = species_id)) +
  geom_line()
#this looks worse - too many colors 


ggplot(data = yearly_counts, mapping = aes(x = year, y = n)) +
  geom_line() +
  facet_wrap(~ species_id) #facet call (similar one that is called facet grid) - species id is the third variable - show it by making each value a separate color OR show separate graphs for each species  #map panels across species (I could do this?) #species id value becomes title of each panel 

#if you want to filter only a few species IDS
ggplot(data = yearly_counts [yearly_counts$species_id%in%c('BA','DM','DO','DS')], mapping = aes(x = year, y = n)) +
  geom_line() +
  facet_wrap(~ species_id)

#when you call facet wrap by default it keeps the scale the same for every panel 

ggplot(data = yearly_counts, mapping = aes(x = year, y = n)) +
  geom_line() +
  facet_wrap(~ species_id,scales = 'free_y') #4 options for scales 

#alter options for axes 
ggplot(data = yearly_counts, mapping = aes(x = year, y = n)) +
  geom_line() +
  facet_wrap(~ species_id) +
  scale_y_continuous(name = 'obs', n.breaks = 12)

ggplot(data = yearly_counts, mapping = aes(x = year, y = n)) +
  geom_line() +
  facet_wrap(~ species_id) +
  scale_y_continuous(name = 'obs', breaks = seq(0,600, 100))

#pull up plot_name$data you can see the dataframe the plot is referencing 
# do the data manipulation THEN plot 

#when you see grey default background 

ggplot(data = yearly_counts, mapping = aes(x = year, y = n)) +
  geom_line() +
  facet_wrap(~ species_id) +
  scale_y_continuous(name = 'obs', breaks = seq(0,600, 100)) +
  theme_bw()

#lots of theme options 
theme_economist

library(ggthemes)
