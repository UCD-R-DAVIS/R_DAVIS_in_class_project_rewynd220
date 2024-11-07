library(tidyverse)
gapminder <- read_csv("https://ucd-r-davis.github.io/R-DAVIS/data/gapminder.csv") 
library(ggplot2)
#First calculates mean life expectancy on each continent. Then create a plot that shows how life expectancy has changed over time in each continent. Try to do this all in one step using pipes! (aka, try not to create intermediate dataframes)

gapminder %>% 
  group_by(continent,year) %>% 
  summarise(avg_life_expectancy = mean(lifeExp)) %>% 
  ggplot(data = gapminder, mapping = aes( x = year, y = avg_life_expectancy, color = continent))+
  geom_line()

gapminder %>%
  group_by(continent, year) %>% 
  summarize(mean_lifeExp = mean(lifeExp)) %>% #calculating the mean life expectancy for each continent and year
  ggplot()+
  geom_line(aes(x = year, y = mean_lifeExp, color = continent))+ #scatter plot
  