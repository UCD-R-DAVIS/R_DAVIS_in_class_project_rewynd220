library(tidyverse)
gapminder <- read_csv("https://ucd-r-davis.github.io/R-DAVIS/data/gapminder.csv") 
library(ggplot2)

#To get the population difference between 2002 and 2007 for each country, it would probably be easiest to have a country in each row and a column for 2002 population and a column for 2007 population.
#data needed: continent, countries, population, year 
#filter year = 2002 and year = 2007 

filter_gapminder <- gapminder %>% 
  select('continent', 'country', 'year', 'pop') %>% 
  filter(year %in% c(2002,2007)) %>% 
  pivot_wider(names_from = year, values_from =pop) %>% 
  mutate(pop_difference = filter_gapminder$"2007" - filter_gapminder$"2002") %>% 
  select('continent', 'country', 'pop_difference')

filter_gapminder_2<-filter_gapminder %>% 
  filter(continent != "Oceania")


#faceting to make separate graphs for each continent 

ggplot(data = filter_gapminder_2, mapping = aes(x = fct_reorder(country, pop_difference),
                                                y = pop_difference, fill = continent)) +
  geom_col()+
  facet_wrap(~ continent, scales = 'free')+
  theme_minimal() +
  theme(
    strip.background = element_rect(fill = "gray80", color = "black"), # Gray background and black border
  )+
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  xlab("Countries") + 
  ylab("Change in Population Between 2002 and 2007")+
  scale_fill_brewer(palette = "Set2")+
  scale_fill_discrete(guide = "none") #remove legend for fill 


#ggplot(diamonds, aes(x = clarity, fill = cut)) + 
#geom_bar() +
 # theme(axis.text.x = element_text(angle=70, vjust=0.5)) +
  #scale_fill_viridis_d("cut", option = "B") +
  #theme_classic()

